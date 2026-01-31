Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6328BD46C1D
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Jan 2026 02:02:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vm0Id-0007SL-Is; Fri, 30 Jan 2026 21:01:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vm0IW-0007IL-4w
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 21:01:17 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vm0IO-0000Tz-Qo
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 21:01:13 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-29f30233d8aso17590605ad.0
 for <qemu-devel@nongnu.org>; Fri, 30 Jan 2026 18:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769824867; x=1770429667; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r1N6ECMEDgMFdthr2Z2jMnkq5f/37eqmOzrEyVZJugI=;
 b=y/3TklbVvBd+AApX/9Qvl9Mqxb9w+e9y8PcIUhHuxTSjzzoJW9AfUrt7TKom5XjcNz
 rU88ihNXjcrOOMUnAfsZxXhoedF6FISj4jdPT0NzZIS0fqAIZnqSXp3w0xSDfC4Kiy8O
 Vb3YGLomVIDnTZdLQPHjUZ8SGqfy74w0iDaipj17360stE1QMwW0OtgBOFIYeMgOVhTP
 Yu56BcE5hXIiADwrMRpALutGnMrHGxnQkTSMMy5XkZrv4AYlk4c3kW178ONWX55p1+jD
 bjzWjNGvGxzhUhj4+wTLSQCRJKiDnIu1WPJpcglFMmmcGQbDLtl5bXf4cP8PT1q6gLoa
 +Nww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769824867; x=1770429667;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r1N6ECMEDgMFdthr2Z2jMnkq5f/37eqmOzrEyVZJugI=;
 b=MSksbeHhhkiaykCV8Bsj7urgp+uzfC3ueLGUXBWLYEMpcjgjuB9IcFjkE04ZiOvlDN
 t2FkpaFr2UBBLjv5rgjJkCgd5yZD1Cx5ncLKvqR3W4TcYTRjI3hhi5cs4bZVgVe6r1nx
 wwsZTMXXywoU0c+ooi0sr3LDcpUoCb3wYs3NfX5Zb3MgSZsGmRG/eIynYeOyJ9iM/DPj
 JqC8JmKypaHfl76xcUQUM84H3R8MZ5sgFkBwfccQw88ndVq1oiga3HvoajMQXvwNDDmN
 /G129ivIU2A6iqX1L3/PEXx9C8XnkVduqKbBKyeJhxDUIiAGOrYGsw4Gy68CsfcQBBP2
 03Xg==
X-Gm-Message-State: AOJu0YxezX/d/C94CozEBSxXgG24vtMisP4S6wdCiK8auGlG1k7GmmUC
 hEWSbIYXYVN3Nn1hO3AoEt/asxEdTEoSmoP6GZ42WBDCijd0MQzcrFVYYzJYF2ihhqrgJgD/w9+
 Xsrhj
X-Gm-Gg: AZuq6aJxG8I+XH16X9PMfGPcH8IyPBPDyzyeEMiJtUtSvi3TgwDg1IxEYB5yAS5e7JY
 m+3bEh0JVMWadvSkbY5imm1pNW8wIf/4UVQYBQuT20rB1T4JXKwo/FslJlBnsoRc3T7VRwM82YL
 edAYvRRNNw7uk5UlRhTeV5/WCbSZry/AipY3qmLoS7cc07UnLI2lf+0GpTaioPluC22fXsIvGtL
 hUiLT7v3bAFxeDmFMexbBO4g7AxLWH0REIhj0d8riwwllfPdfQ70qpY7/SaAhmKxYiuY0CC5yPU
 TAvFMyrdwQ9C6E8OR4TlD9F42ScoA/xCvUznsx+1KDLnht5UjFgBAmt/Gz2qoFpz+dp8mIPjxUW
 my4C1xAcP6GSBowylQhmIFtJrRZ/k7K5V50EMFPGVRHyAK8QnATwVS6iBo5ygGvWuKegx9tjwS3
 0ZpH0v8oRMQsgwyqeXo7lfzQrxam9ag/RbulepJt3TUoUKZXdvi1kocML8tpq4L2bh
X-Received: by 2002:a17:902:d50e:b0:2a4:8cd:c3cf with SMTP id
 d9443c01a7336-2a8d8181601mr51103125ad.49.1769824867242; 
 Fri, 30 Jan 2026 18:01:07 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a88b41390bsm84697975ad.23.2026.01.30.18.01.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Jan 2026 18:01:06 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 1/6] target-info: add target_base_ppc,
 target_ppc and target_ppc64
Date: Fri, 30 Jan 2026 18:00:55 -0800
Message-ID: <20260131020100.1115203-2-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260131020100.1115203-1-pierrick.bouvier@linaro.org>
References: <20260131020100.1115203-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
---
 include/qemu/target-info.h | 21 +++++++++++++++++++++
 target-info.c              | 21 +++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/qemu/target-info.h b/include/qemu/target-info.h
index 62359622232..e3287334304 100644
--- a/include/qemu/target-info.h
+++ b/include/qemu/target-info.h
@@ -71,4 +71,25 @@ bool target_arm(void);
  */
 bool target_aarch64(void);
 
+/**
+ * target_base_ppc:
+ *
+ * Returns whether the target architecture is PowerPC 32-bit or 64-bit.
+ */
+bool target_base_ppc(void);
+
+/**
+ * target_ppc:
+ *
+ * Returns whether the target architecture is PowerPC 32-bit.
+ */
+bool target_ppc(void);
+
+/**
+ * target_ppc64:
+ *
+ * Returns whether the target architecture is PowerPC 64-bit.
+ */
+bool target_ppc64(void);
+
 #endif
diff --git a/target-info.c b/target-info.c
index 24696ff4111..5a6d7282524 100644
--- a/target-info.c
+++ b/target-info.c
@@ -73,3 +73,24 @@ bool target_aarch64(void)
 {
     return target_arch() == SYS_EMU_TARGET_AARCH64;
 }
+
+bool target_base_ppc(void)
+{
+    switch (target_arch()) {
+    case SYS_EMU_TARGET_PPC:
+    case SYS_EMU_TARGET_PPC64:
+        return true;
+    default:
+        return false;
+    }
+}
+
+bool target_ppc(void)
+{
+    return target_arch() == SYS_EMU_TARGET_PPC;
+}
+
+bool target_ppc64(void)
+{
+    return target_arch() == SYS_EMU_TARGET_PPC64;
+}
-- 
2.47.3


