Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44887C7115B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 22:21:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSk4f-000116-2P; Fri, 20 Jun 2025 18:19:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfYk-0007GK-Ih
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:29:50 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSfYi-0005yv-Vn
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 13:29:50 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-451e2f0d9c2so15177065e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 10:29:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750440587; x=1751045387; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XWyZ+D51v+wrpcHQSJ9z/sxpKjgalwdAVH6zJ/8xGnU=;
 b=sH3IcivIA8ret8vGovCGFtAYcJNc4aKtBjUApi65jwcW65ijqgkJRAWmebC5ZHUYk0
 8p9P7f+Hmdr15jFq9XSNfXHlFSlXzNYhdBiP0bSRcBTE8cyNzmBpIix2ipmXK9MX7vDO
 IAENFODEnUTmh7dk0+t4qnwYRuqFacF3+ryFZA7PVUU3bPli3Mkiu3mo//2ycbXRvfuA
 sZBQPOCJ0/WoHtKPxD/tqP8QxsmaweW5QYzaqbWPB7Qu1aojN1CNnHmtNfCsa30sUIGw
 hWW9NiPbnRZA7oe3H3NdB7HHSucWch4SFV6VswRQ2prbjkqNdsM7RLf9G//lFuOVDfl8
 VFSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750440587; x=1751045387;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XWyZ+D51v+wrpcHQSJ9z/sxpKjgalwdAVH6zJ/8xGnU=;
 b=POWvkadInfjXMMT+NPi7P0yzzsTjK+9f2tKrZ5EMal6PobBJXRwRbC23enpaio8AxB
 EgScv1h9s1BWRt7r3hFdebebsE8buu0+RX7EI6UdLIOHMBN9UtzMWmP/NBlIiuMi0eSf
 zLKOVFE3fwJsgkXNNrnNmJ0O6Id2DQHPB9jsw40pMfy0egwzflMPTek9jzFEJYx9b7vb
 CWuFaVHWfnIV3EfF+vpJiJEr/F+iRQKKzZlmtGH0PZq5otK6CK/9vD0pSjDHMX555Pgb
 bG6661P2pe313GTaNmmnDuBISmBkMIH5p+jRZr/CNKVqwXjopkjlHsYtbEQX+DmB8kLC
 124Q==
X-Gm-Message-State: AOJu0YxVpe/E/Mz/LFeDVDKzVV72vYHKC8pbGY39Ll3I1TxLGS/omMyE
 cpwF6zeeWCZnxK/x6HMqZ6kv2o1JK2p7lGBf0/jtjLP7qzr2fX1jPPQbCE+kvUKMYolzr2QJdWa
 ku3h9bapWHg==
X-Gm-Gg: ASbGncs09We4pVm0tHDcXPnrL/T3XJimINY6RKjG3CqJ9l7oyrE7pr5USn1CRI+5klR
 8iSCdasWl/HoQxYHk9veosUyVvzpZPgEvaI59Qp30cv/Jdwuh5eQi8k/m9gUDlUWdDkrLppRIfp
 M/xVTsGCpqTTnD66T1WE4dR1QiRkraxqN6dANg0gE0as1iDSBjNyvS2sF2/LTLuU5Jqtbfvr4hQ
 hUsd4BkpbsJlsIVv77w/teXywBkAQ3q/z9WiriWiN9PEumj4+PGHKteL3fEquDW6huLXXhgGqKM
 HUaP5hTwV19cQvyD9VKkDYgNSKCm+5NF2N1dzzgSbB1TKW3lR+t3iosPjNBt762fQnzU2otFehQ
 ymSAwofthDM0AiV8jo7PihVXgJBxf0yCa1NTxvY/TNqJgH45TxDiMKA67
X-Google-Smtp-Source: AGHT+IHEubxwyWynYsD4Z90LpX/HVeIuzfVJPgIxD+VOqs8pRI1ltrZW/aBEL/T9eP6NZYwdAhzFHA==
X-Received: by 2002:a05:600c:458d:b0:43b:4829:8067 with SMTP id
 5b1f17b1804b1-45365e4f9e2mr33502375e9.6.1750440587007; 
 Fri, 20 Jun 2025 10:29:47 -0700 (PDT)
Received: from localhost.localdomain
 (101.red-95-127-63.dynamicip.rima-tde.net. [95.127.63.101])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453632312a3sm41535905e9.1.2025.06.20.10.29.44
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 10:29:46 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Julian Armistead <julian.armistead@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, Mark Burton <mburton@qti.qualcomm.com>,
 Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [RFC PATCH RESEND 14/42] accel/split: Implement
 synchronize_post_init()
Date: Fri, 20 Jun 2025 19:27:22 +0200
Message-ID: <20250620172751.94231-15-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620172751.94231-1-philmd@linaro.org>
References: <20250620172751.94231-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
 accel/split/split-accel-ops.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/accel/split/split-accel-ops.c b/accel/split/split-accel-ops.c
index d4fa07c2dec..6b3ddf21a17 100644
--- a/accel/split/split-accel-ops.c
+++ b/accel/split/split-accel-ops.c
@@ -151,7 +151,16 @@ static void split_synchronize_post_reset(CPUState *cpu)
 
 static void split_synchronize_post_init(CPUState *cpu)
 {
-    g_assert_not_reached();
+    SplitAccelState *sas = SPLIT_ACCEL(cpu->accel->accel);
+    AccelClass *hwc = ACCEL_GET_CLASS(sas->hw);
+    AccelClass *swc = ACCEL_GET_CLASS(sas->sw);
+
+    if (hwc->ops->synchronize_post_init) {
+        hwc->ops->synchronize_post_init(cpu);
+    }
+    if (swc->ops->synchronize_post_init) {
+        swc->ops->synchronize_post_init(cpu);
+    }
 }
 
 static void split_synchronize_state(CPUState *cpu)
-- 
2.49.0


