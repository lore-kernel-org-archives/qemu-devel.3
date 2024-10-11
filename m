Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4062D24475
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 05:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz8Vb-0001Y6-LX; Fri, 11 Oct 2024 01:48:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raj.khem@gmail.com>)
 id 1sz8VZ-0001XR-QK
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 01:48:13 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raj.khem@gmail.com>)
 id 1sz8VX-0002M6-Ug
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 01:48:13 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7ea0ae67df5so1316890a12.2
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 22:48:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728625689; x=1729230489; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7NGAC5Xq1NnVqHNmxrgJT2LGs+jC8o8ABswK8q8+aS0=;
 b=j7X0JTE+4OLqvSAmk2G9se83VyAfG/JgYE9SXPN17xc2URipDCd8Fjk1Yl0yBkHA7t
 xRVs34LnDJxlKOQACBDRIHQ/IbCmSPTUIWVhPMVQDL8ot3FQrVM2kjHcEaXVvNuVplH6
 QwYso1EkwmtlMpsu8SjaxBngCmGUtc/KTu6w+N5SmyxoXtnxeHdVIz+u5CGw002oUKFC
 ebYaZL1asHQQnjuRg9gP+cON93vXwEeALcWEARQHgkXxoQIsu99x2+XUpTWi8E6tYoP/
 ZisETzZomWe4L1Xi1m7lpWRhyE99dYmKlswfr2m9qgoqopaQ7F20BG/xBYwzKHK82A8S
 rU5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728625689; x=1729230489;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7NGAC5Xq1NnVqHNmxrgJT2LGs+jC8o8ABswK8q8+aS0=;
 b=k3FHe1enKOUnfayIqVvarE9uJ7OFLXKXgv7N7enSsYq/pDTkvJEFnawRQw78VF8Hv7
 7EdrJ2Oo+WbpnYIoWMQof5hqRySaEoRaq3lE+BFPfvR22SZEA/dtYM5Kopi59hFvi2eb
 4SPQePB+mR5q501reEM6RTGD0kTvJR5J/dgg7bXan5lcOOmCBOGKiNpklnxTdhM/LSp6
 QbEtOdrTCvTLHUKkFCnRLoztyjMrDrU6UAKfVkGqL7O0aRbn8oWZBrL3stY/gtQHmsQg
 92ITDt8C6YuGKGFFtNEuufk2bRK2qg/GFYYL7kZXpgE7bf2mEsBA0OVdl+zOwy+PHkqC
 tH3Q==
X-Gm-Message-State: AOJu0YxTgE4cGKb8+pEwP0im7Ye4WRHZ/0P+MWHA764EBlsoyH7ypD6G
 o8EkFv4WfwUQUMPT5C8doKSP3o4CutvcwN8e69AvXgdMV8pM8BohvOFAXk93
X-Google-Smtp-Source: AGHT+IHdNFlD32TZnzxjoiKUdZ5GP+0FiIdHib5fpW7166QhY8Zws0pcXCWH1FV1qByTZcnG+xdN4Q==
X-Received: by 2002:a05:6a21:2d84:b0:1d5:10c1:470b with SMTP id
 adf61e73a8af0-1d8bcfa9e43mr2141054637.31.1728625689350; 
 Thu, 10 Oct 2024 22:48:09 -0700 (PDT)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9d80:4380::8d77])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e2d5fcc759sm2393117a91.57.2024.10.10.22.48.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 22:48:08 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: qemu-devel@nongnu.org
Cc: Khem Raj <raj.khem@gmail.com>,
	Laurent Vivier <laurent@vivier.eu>
Subject: [PATCH] sched_attr: Do not define for glibc >= 2.41
Date: Thu, 10 Oct 2024 22:48:06 -0700
Message-ID: <20241011054806.1014276-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=raj.khem@gmail.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

glibc 2.41+ has added [1] definitions for sched_setattr and sched_getattr functions
and struct sched_attr. Therefore, it needs to be checked for here as well before
defining sched_attr

Fixes builds with glibc/trunk

[1] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=21571ca0d70302909cf72707b2a7736cf12190a0;hp=298bc488fdc047da37482f4003023cb9adef78f8

Signed-off-by: Khem Raj <raj.khem@gmail.com>
Cc: Laurent Vivier <laurent@vivier.eu> (m
---
 linux-user/syscall.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1354e75694..9e6eebbf1a 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -359,7 +359,13 @@ _syscall3(int, sys_sched_getaffinity, pid_t, pid, unsigned int, len,
 #define __NR_sys_sched_setaffinity __NR_sched_setaffinity
 _syscall3(int, sys_sched_setaffinity, pid_t, pid, unsigned int, len,
           unsigned long *, user_mask_ptr);
-/* sched_attr is not defined in glibc */
+/* sched_attr is not defined in glibc < 2.41 */
+#include <stdio.h>
+
+#if defined(__GLIBC__) && defined(__GLIBC_MINOR__)
+# if (__GLIBC__ > 2) || (__GLIBC__ == 2 && __GLIBC_MINOR__ >= 41)
+    /* do nothing */
+# else
 struct sched_attr {
     uint32_t size;
     uint32_t sched_policy;
@@ -372,6 +378,8 @@ struct sched_attr {
     uint32_t sched_util_min;
     uint32_t sched_util_max;
 };
+# endif
+#endif
 #define __NR_sys_sched_getattr __NR_sched_getattr
 _syscall4(int, sys_sched_getattr, pid_t, pid, struct sched_attr *, attr,
           unsigned int, size, unsigned int, flags);

