Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAA3DC7115C
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Jun 2025 13:14:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uSbUD-00045J-Dz; Fri, 20 Jun 2025 09:08:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbU0-0003UU-12
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:08:43 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uSbTy-0004jz-5Z
 for qemu-devel@nongnu.org; Fri, 20 Jun 2025 09:08:39 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-451ebd3d149so11660895e9.2
 for <qemu-devel@nongnu.org>; Fri, 20 Jun 2025 06:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750424916; x=1751029716; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fteu42QoSrS1hfDvjcW70gOANYEhePCaBpCVcvmvL2M=;
 b=xGM6RSzxkE4aAyTloGQUSOucPNeP9CB5qTNqzcAnoobRa7XqERGLvOyv37fbFdiifm
 GxzqlemSBI5tVIepRdFz9xUzYKi94nXWis7ZueMYe+OPkBaSsPhMNre2uxaoAcAwsE5F
 8sbfIv3967Z0JdnHxSrab2jTBo92xQYvbvzd2nmp/CCwDwCttg8FSWdn9R2t0Kr18Rmx
 OiP9gFT1qgKiCcXWpP4lh+nVCt3W1VjroJIR0T2coY/52+TDUn2lJM1C9CVrpdLu4CKv
 6eGZ/4YkA1B7wNt/aGHM5omIq3P/3nENv5/RmPSfwX4NPBtif1cpiH3rJh6l9A7xq8nC
 wETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750424916; x=1751029716;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fteu42QoSrS1hfDvjcW70gOANYEhePCaBpCVcvmvL2M=;
 b=J8GD4T6KFyTDxxvKJ+vZStxaw6mfZBkutBr80Acx0jl29noz9PIy78+zfKqAk06Enf
 qYqNxQ198rUNaeHy6jOmCFKdSrLK+4Zrk4K+1qMjp1hknnpIdvbuZjXmHbCZjVJRwEBL
 9ABWrv84kxsVzoze96+V0zTmV0mDlvGXE7xKmpt6wlWpKel4Ho1+EZPyLhG/Qj8RF/sz
 8lSRqeWo7nnLi46dU7iJv60p9mNYcoEcqsqOf19+WHBPgqhauhb0oielDwV85siXjFxM
 JZc64hGfPf58+xdKd+biglpOMvpwUuvO7E+2XYupczRckCrMU3QLerwy6LW7LycJn716
 s1QA==
X-Gm-Message-State: AOJu0YxdGGLB1ZU19/HBxaNsULzFRZh6n87ie0MYivIomiYYvciKRDl0
 s/KhE6ZuQ70jk7ENMUd5AaxuizRjIkKnEaoxMEl1XxH8wjzDgmC3YNKNCDh+GLV3QAtloThmv6N
 kNLuR7bw=
X-Gm-Gg: ASbGncsvdrn8Y4aHxZ0oWwz4dN5TiD3tmb6+V3KX4/8f2/kMHvJFIP+e1+G8HyZ+Dpj
 pC/UTmCBHcNjA1txaAxSVzzoOdeSKbTRM37jFY5EJsUpgXfRQEo2dLOqpOrP/psigiomnLwwZRA
 /to0iv8E5WEeHDZ16Z21o/FJXQdnFrwQCFhVk/Wn3kCtvOg/0K3cS3lpP4me1mVlVn6RFJCVH3N
 9HPiU1yOlaR+721lCOFZavT/415Na5dvKO2QYuRoxTu1A+QCf0ZhRzwEM/3sp/6sqZvEn9d0sxh
 xYI03cuBaXr4u14oHhE8qVc7U9g4WUn7GT4ZM1Lq97jhJGklSlYNT3Kxntnb6lQfKbzI3mkiqB1
 dZWbJoQRkDsSphfCiSAAK+X+8xX4OD73eDDKW
X-Google-Smtp-Source: AGHT+IF+npPw/Fpnff5lnMY4tzVA5zu1lieKqW+klOIEesBk3BkWi62GERyChD7PyAo9RXNQgBmPoQ==
X-Received: by 2002:a05:600c:8b70:b0:445:1984:247d with SMTP id
 5b1f17b1804b1-453653aa3afmr23498795e9.7.1750424916439; 
 Fri, 20 Jun 2025 06:08:36 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d11909f4sm2016944f8f.88.2025.06.20.06.08.35
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 20 Jun 2025 06:08:36 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Graf <agraf@csgraf.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>, Cleber Rosa <crosa@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2 15/26] accel: Introduce AccelOpsClass::cpu_target_realize()
 hook
Date: Fri, 20 Jun 2025 15:06:58 +0200
Message-ID: <20250620130709.31073-16-philmd@linaro.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250620130709.31073-1-philmd@linaro.org>
References: <20250620130709.31073-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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

Allow accelerators to set vCPU properties before its realization.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 include/system/accel-ops.h | 1 +
 accel/accel-common.c       | 3 +++
 2 files changed, 4 insertions(+)

diff --git a/include/system/accel-ops.h b/include/system/accel-ops.h
index 44b37592d02..a863fe59388 100644
--- a/include/system/accel-ops.h
+++ b/include/system/accel-ops.h
@@ -35,6 +35,7 @@ struct AccelOpsClass {
     void (*ops_init)(AccelClass *ac);
 
     bool (*cpus_are_resettable)(void);
+    bool (*cpu_target_realize)(CPUState *cpu, Error **errp);
     void (*cpu_reset_hold)(CPUState *cpu);
 
     void (*create_vcpu_thread)(CPUState *cpu); /* MANDATORY NON-NULL */
diff --git a/accel/accel-common.c b/accel/accel-common.c
index 56d88940f92..55d21b63a48 100644
--- a/accel/accel-common.c
+++ b/accel/accel-common.c
@@ -105,6 +105,9 @@ bool accel_cpu_common_realize(CPUState *cpu, Error **errp)
     if (acc->cpu_common_realize && !acc->cpu_common_realize(cpu, errp)) {
         return false;
     }
+    if (acc->ops->cpu_target_realize && !acc->ops->cpu_target_realize(cpu, errp)) {
+        return false;
+    }
 
     return true;
 }
-- 
2.49.0


