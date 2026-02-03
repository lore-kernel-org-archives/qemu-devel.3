Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D9FAE8B365
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 20:57:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnNSH-0006db-9y; Tue, 03 Feb 2026 15:57:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vnNSD-0006be-1L
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 15:56:57 -0500
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vnNSA-0003UJ-VH
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 15:56:56 -0500
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-2a871c8b171so36172775ad.3
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 12:56:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770152214; x=1770757014; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r1N6ECMEDgMFdthr2Z2jMnkq5f/37eqmOzrEyVZJugI=;
 b=Nf/pIBUUmELOVHbdv9d3VEHEWy8YKDlpo446WYNEP2E1oOaYHa2OqhAE/Lug4jc3cA
 fdgCsk3et79xSNbX8V8eEc3DPbw+tuWyWdTUiAN3Z2VqR70vKgRSd4Ujx9Sit90GdBXl
 AvdYu1nWSd8BIdFyEzxCbTkeAki0kVTWi4OQocni6ewcSCK/K48KVth2VQGz1I6CvaTO
 KY70e4QMmOWmKU7E7EoY75IeZCORs5pZ9E+eJf9a27r1WwwhpxC/i3eL2xJjf7NgBvqf
 eEXWmUXLdoub2Ftm7e26QJ24hWE98Dge8x5WEgZ+MOLrKjbvfIrJEmogslMme0s4pqzX
 732Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770152214; x=1770757014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r1N6ECMEDgMFdthr2Z2jMnkq5f/37eqmOzrEyVZJugI=;
 b=TmqQ9dTRyTIMI0R0cnRQ9TQ24oiWneJ0MPwcONhua7oWnXynXWTPGtb25ATA23sJ83
 VVs45j0q+9Eh6Jd1nh0+pyu2g9Bk22fD8z+RrnZnae27YfUSJpZe1hP7Z+KRzNeC/hyP
 lhhPHFKYCj4U5wC3wGFsttauOf1JBb+4iFf1IhrKP0Owx+Xi4g8wLNp4XzS2qu/QU1TG
 oH4bVgIdGd8rAlZGWAcK6mIU+ATYiHJkH/gbqpPkD/DhiAjlyynuSIGQ2w9Yd8sXVfSO
 Bp9DjfZev4KfOXVemTBSuTDFRJEM3kbdk9SXDqJ4hX0SjEwv4WvvXPmVSDWoASXZ/Zdu
 tciA==
X-Gm-Message-State: AOJu0YyKxDQAP6hrKg3B1iA6DTEctLIKTqtTUFZv1AWJ/3CgoWqvL3AG
 EFxy77m9uKcEKUU5KeMCdooNLSbBdig929Gg9xlupbVQN34D5rnmZdHOCtzBBm/EuxgU5Q7/PqC
 SLaulxRg=
X-Gm-Gg: AZuq6aKJ7tAAmfM2OOm1CvCkjJ0O+mD+Ao9Sdg+s//Y0JFFlSt4A9ZOxJJcTN4XXWWK
 vjA9rUF4mXUeTFBwuYS1moLtJeXcnGEpTxM+GJsFphMTY1PVjxIZak0iDnAC5AFrceZ4tcd9AAe
 Um7y5HXwKj9xBPVxyYfgZx68/65VgJFgr67dAU+5xGfufnrC0ymurBqexkKxkI9AoncMw/a0mzy
 rbocBZ4/WwIPBWjM4PHyWYP5c1n2jNxsd90VPyEwj7kieS3KJWh+amUlgOosulvAHK3nOUqaL6F
 2JI+ucKsnUFQ7V/0ojWL4WQYylpBshYv6g+N5DvA45Tvto4C6mnXG7sJ23FVxoEvTJUmx7tnEa5
 6w3e4cfICADPb1LbMu0LOtjRy3dVn3J6oPZ5nHsNp+w2vCzw439zKZ9pkX2QoxeHAHba0qlAMmR
 YFq6dKFfyYEMCtql8w62rTvQRwBuFvd4uieE+zZwmqgVQEZF4KlT8FftCeA0VEcT3Q
X-Received: by 2002:a17:903:b8d:b0:2a0:8966:7c94 with SMTP id
 d9443c01a7336-2a933e3fc55mr5162785ad.20.1770152213573; 
 Tue, 03 Feb 2026 12:56:53 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a9338512f4sm3612875ad.9.2026.02.03.12.56.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 12:56:53 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v4 4/9] target-info: add target_base_ppc,
 target_ppc and target_ppc64
Date: Tue,  3 Feb 2026 12:56:32 -0800
Message-ID: <20260203205637.3109749-5-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260203205637.3109749-1-pierrick.bouvier@linaro.org>
References: <20260203205637.3109749-1-pierrick.bouvier@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x636.google.com
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


