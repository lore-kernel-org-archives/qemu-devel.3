Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58D9CD6E4A
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 09:20:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wULH1-0000kg-4M; Tue, 02 Jun 2026 05:18:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wULGp-0000Z3-P8
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 05:18:49 -0400
Received: from mail-dl1-x1242.google.com ([2607:f8b0:4864:20::1242])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fritchleybohrer@gmail.com>)
 id 1wULGl-0007e7-5n
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 05:18:45 -0400
Received: by mail-dl1-x1242.google.com with SMTP id
 a92af1059eb24-137dd51129bso45216c88.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 02:18:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780391920; x=1780996720; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PCLumQ0UyNQHKa/ypfifej8V3OAD6FODRX9ywAOjyVA=;
 b=M2ntlYJf1Azh56TrvgvL5KtpTsGwa1xJVatQ+Ldh8cufU+7al30A5VnHitJq7mhjWJ
 8dyAK5G3itKmkJvoAAdBTfjwsrvgrey9UmK0TXo/DWwNTm+/THR7Vays94I/S47TreRG
 guQoV/jKSuKi0c4XW/QT3AaLVnU8TbIDblcLM9EvcfiOThviHadnAXbGgdGx9xH89f0w
 Za5SJSzNXnzJ1B6bXBsuCMK4Un5/nL8q3SavesRCAP6jBQ5iiOuhKxKwJRavLVLRA2P+
 vKBAmHV6XlyISmjhZVvF/u3c6abz30nV80TbsaJ2/ynPEyCWgNhG4ZYPDhJSd4MSlzar
 rj4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780391920; x=1780996720;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=PCLumQ0UyNQHKa/ypfifej8V3OAD6FODRX9ywAOjyVA=;
 b=NvdLNdSezYCsf+OkdHH7kONc6YdFbuyChQOZunq/Xkj5SPYegr/N2ARqvtIDNraJcI
 qm6DKfPQXPk7s0F9IA8hiL0S7+6NgHDj4gVwpVDB7Lk7vBcB27iJeHJ4XWmYoV8reKgE
 jx5i7ogM0E8oJEAm6a7hh4wocAcjvukZbPlEKf5TOXAslstYaGoM1Cl46ONkciT8douD
 gyRyF8HvG1UVlyESwd8qQggLmGT9yyziYqAdrGPFMIkhJQgVbuh+8tzZFBuoyjiWpAWe
 T1TL9tIZwupUA4xDYnb9k+3Tv8mRU0Sz+2wnDdtNOfOZ2AdrRlxv99ictYNfAZB4DrIK
 S40w==
X-Gm-Message-State: AOJu0YwUDY1w7ZFNS2MYZfX5SXbaHRIA2dnV0AgbrzdA3FH4sNCaedFU
 rd+XhuGlxS3AJN/eI9uP7tZpXSHtiQwu4OKR6nBfyN7nmhBnc1FbBJ3ISu+iygsl+qtVyw==
X-Gm-Gg: Acq92OE5NoV4wuUCJvL6yngbwB1C8ykjQ/bkmpLaVQpkf6NHVJRnFKumyuwvveCAJmJ
 HtpckcRTqP5QbLKWibYhmFwFaZvCDAyvaWtFmJjiw3Dx1NHnVlCxCtlSX8MaA3RmiXhJZtfJxhL
 wSYinkL2FbVuudr95BBL5P9YDCw2HenFEKndcIsQIfTPahL9JkRTOIp7dFw+pXaBM37I3xmi4Y5
 u34iuUJX9LwF/463M/JiaLrz3jItBW5r3qWify5JUDFVbHxozhuVyIrC68hFFUZc5cJ/5m4apgf
 mOJ7wLQ70FQPNsjkGMbzcv7v6w8NtKRtEw4TpitVQRMI6+X2KtQEnbzdFheKMmWTfxRYP2d2vcr
 7Gkfczn6oV8ZDuHkBOXSljmZLBgpAj0SyPVhMIoCOVzQNRsPIqh/6pcRxo7ObpTOJkW2Nvp6pWE
 I1TuU2/weUThcAlk0u3mmGBYcKZZGJJdG+o8REXjWe306pwtKO0dPqmsRnV/sfnZzvXCUIaDOgq
 ennV4PmPJxIpS4cX2RPLk4Fo4FkNzkPCt4JeA==
X-Received: by 2002:a05:693c:300c:b0:2ca:8099:ffc0 with SMTP id
 5a478bee46e88-304fa4a90c6mr7077827eec.7.1780391920436; 
 Tue, 02 Jun 2026 02:18:40 -0700 (PDT)
Received: from openkylin..
 (ec2-54-176-108-193.us-west-1.compute.amazonaws.com. [54.176.108.193])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed2c3121sm11419146eec.5.2026.06.02.02.18.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Jun 2026 02:18:39 -0700 (PDT)
From: Zephyr Li <fritchleybohrer@gmail.com>
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 alex.bennee@linaro.org, pierrick.bouvier@oss.qualcomm.com,
 philmd@linaro.org, Zephyr Li <fritchleybohrer@gmail.com>
Subject: [PATCH v3 4/6] target/riscv: reject x-misa-w outside TCG
Date: Tue,  2 Jun 2026 17:17:51 +0800
Message-ID: <20260602091753.3209261-5-fritchleybohrer@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260602091753.3209261-1-fritchleybohrer@gmail.com>
References: <20260602091753.3209261-1-fritchleybohrer@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1242;
 envelope-from=fritchleybohrer@gmail.com; helo=mail-dl1-x1242.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

x-misa-w controls dynamic writes to misa in the emulated CPU path and is
only meaningful when TCG is available. Reject it explicitly outside TCG
instead of relying on TCG-only finalize code.

This also covers CONFIG_TCG builds that are running with a non-TCG
accelerator. It also rejects CPU models that require writable misa by
default when the selected accelerator is not TCG.

Signed-off-by: Zephyr Li <fritchleybohrer@gmail.com>
---
 target/riscv/cpu.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 862834b480..8ef72a88b1 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -956,6 +956,18 @@ static void riscv_cpu_realize(DeviceState *dev, Error **errp)
     RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(dev);
     Error *local_err = NULL;
 
+    if (cpu->cfg.misa_w) {
+#ifdef CONFIG_TCG
+        if (!tcg_enabled()) {
+            error_setg(errp, "x-misa-w requires TCG");
+            return;
+        }
+#else
+        error_setg(errp, "x-misa-w requires TCG");
+        return;
+#endif
+    }
+
     cpu_exec_realizefn(cs, &local_err);
     if (local_err != NULL) {
         error_propagate(errp, local_err);
-- 
2.43.0


