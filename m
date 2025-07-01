Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 040FEC83038
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 14:55:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWcH9-0000x4-C3; Tue, 01 Jul 2025 10:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcGP-0007yi-Pl
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:47:17 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uWcGM-0007Yi-W6
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 10:47:13 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-3a6d77b43c9so3113833f8f.3
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 07:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751381226; x=1751986026; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lM8I1wdyqp+n5IfE0fwP4jnCngs3585EkWKxfQquTDA=;
 b=mcw/x2D+9jhb8M3C+iQWRX1xPcJThSLXF8HbtHBQgNmOzjCPW9YPygai9tM9QhW2sM
 Lqw3OZOjyq8JbzNWpz/BmwNKHQAcEVtA4swBLpnZQcZPKhcPk9Mk05ZvPqpx/1k+5f8u
 cU/Sp09nQxxSfRpfSv4ErL5wUzw7m82kaTDbiGsnFekwqlXUJ2v7+LImCokxmJxyrWBk
 Q15BtRWf3vZzxFiPWxLp0LTJ6fzVQMuBgXAOxK0SgVSiOkU5W8Vx88j8IVaXVauVIB2E
 IndfJcQwxQ0mKuFz/T7VWXfs0U5M9mMOsQpEYr6665snm8kcQNM3U2yM2/BPa13iqHOA
 QTZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751381226; x=1751986026;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lM8I1wdyqp+n5IfE0fwP4jnCngs3585EkWKxfQquTDA=;
 b=JmqJrjmDkyGJRy7mQOczKj0YeXQte6A+59cNvF3jkTirG0RoEgla3Rf7CHjFrc6gWr
 oi6Psiw0JDTO3omV3w8IGJSVrnAcfTMM5RFU2Cu6EwpTOhPy46/FkggFlSPu0v//MNzN
 tduUTrKT5NoDNTxZTQSbvuvMVbDBEymKw2uTDAFYbYDnNebRRmzlOsYxSgJCSRWzFHLz
 +L6O7NM+P1f+/biaqpcPNhUV7i1oY71y+fW6LgyGLUsAsAEVdfhMHv81vfT7F5FAkLYA
 T6RUTvX8lvZPeQDbtCGS+5PSZf+WXoQpJdpohB/FzJN3UtV3hm23w8XWT0r+1Y+ATPJs
 lCTQ==
X-Gm-Message-State: AOJu0YwbE4BBxyx7FUh7sw5qeM5ZUVcaVPImayLEEyn7QhO4MDvKY1pC
 23u/mv25MEKnYugy8XgFkY2ffaSUC2aR9IZqmEWyB1EKJTF18/br1QHr4v1KDIPIlLq7BOWA0eW
 aFr7C
X-Gm-Gg: ASbGncuCbEqEjRDolwTBNyv1XuHn1yl5Olu7l0pedc6u2MjiyQ7kNDxTUg0PKyGoAfz
 p5s7dsA7LjRzmoDCG8N273w9a87KzLViz470MHJOe3QcW3ql8IrHMigwj0kigzEZFDnagd6NeW/
 zRHJXTtXglI6kg7NOyZmgv2pannwayD0UC7eXd/vNHZMNuSzyKSgD+SkKKdcHsVCxwS2Zk87V1K
 pB9GCzeGsUVKKfQaHx4ubGAHcrWp37QlvuhEyba5c+vS389r5jffJ8+rjQzSd3WXA5Hxpf3S8kw
 a+QO7k8YCMphWpB4Y79eA2s6GW6/WnYnV4DkIXdfibNTJiR2kdkZ5LsyvDRIo5NRsxwxz1+xmsm
 cNk5rgOOLV4oW2EdapIlaFC5SWkOtogZ6apnaV3mGGLvK6ow=
X-Google-Smtp-Source: AGHT+IGMv4m9tuWsD9jYd3qQKidDcXOHpGRYI+o19Bcb1V8RoyGl43+cnZ3lNCry7NKAf6l40YN+QA==
X-Received: by 2002:a5d:584b:0:b0:3a5:3e64:1ac4 with SMTP id
 ffacd0b85a97d-3a8fee64d08mr17644997f8f.33.1751381226412; 
 Tue, 01 Jul 2025 07:47:06 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a892e5f8absm13700424f8f.95.2025.07.01.07.47.04
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Tue, 01 Jul 2025 07:47:05 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 62/68] accel/tcg: Add rr_vcpu_destroy() stub
Date: Tue,  1 Jul 2025 16:40:10 +0200
Message-ID: <20250701144017.43487-63-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250701144017.43487-1-philmd@linaro.org>
References: <20250701144017.43487-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 accel/tcg/tcg-accel-ops-rr.h | 2 ++
 accel/tcg/tcg-accel-ops-rr.c | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/accel/tcg/tcg-accel-ops-rr.h b/accel/tcg/tcg-accel-ops-rr.h
index a73fe5b94a6..4234ef2f706 100644
--- a/accel/tcg/tcg-accel-ops-rr.h
+++ b/accel/tcg/tcg-accel-ops-rr.h
@@ -20,4 +20,6 @@ void rr_start_vcpu_thread(CPUState *cpu);
 
 int rr_cpu_exec(CPUState *cpu);
 
+void rr_vcpu_destroy(CPUState *cpu);
+
 #endif /* TCG_ACCEL_OPS_RR_H */
diff --git a/accel/tcg/tcg-accel-ops-rr.c b/accel/tcg/tcg-accel-ops-rr.c
index a9150802369..95c7d3a3172 100644
--- a/accel/tcg/tcg-accel-ops-rr.c
+++ b/accel/tcg/tcg-accel-ops-rr.c
@@ -137,6 +137,11 @@ static void rr_deal_with_unplugged_cpus(void)
     }
 }
 
+void rr_vcpu_destroy(CPUState *cpu)
+{
+    /* Already dealt with in rr_deal_with_unplugged_cpus() */
+}
+
 static void rr_force_rcu(Notifier *notify, void *data)
 {
     rr_kick_next_cpu();
-- 
2.49.0


