Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA313D0EE24
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 19:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1szLMh-00020r-2G; Fri, 11 Oct 2024 15:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raj.khem@gmail.com>)
 id 1szLMb-00020P-1q
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 15:31:51 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raj.khem@gmail.com>)
 id 1szLMW-0003EY-RE
 for qemu-devel@nongnu.org; Fri, 11 Oct 2024 15:31:46 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-20bb610be6aso25161715ad.1
 for <qemu-devel@nongnu.org>; Fri, 11 Oct 2024 12:31:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728675103; x=1729279903; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PO9IbOEY2YqKRkyInUx1mFCEKdNyF6F1Ade1P8ET5cM=;
 b=X3X/PkBqkfh2oTnVO9pAth7AIJd5Ne80orDrXTNk/cJJf6mdmzL9bu8gmeG6jH1GnR
 bkEMWGAaEkAkTbvc9EORFlS4FmCvH9Fe3u8o5A+BMzwqGb/o/Bbo71Y7xbYoQCXNrtgQ
 5HRrzAZE5Qou40Y+O7oJxQ706e9UwStTKFs6b1UVHBCNHY/vn0FlMjuHFG8wLSJV/30n
 8uTsVC0ETy4vsPokldGw0BCtN8wOt3L6Ri3yS/N8t707vjXEb0Ejt3WC+GQG9Rq+Ws3x
 OFNQQJioB6351EGYdvojEATnlYQjDBihjp+xeumTDTWuOjo3LR6yXJqYr/yckz8u9vmi
 aWgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728675103; x=1729279903;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PO9IbOEY2YqKRkyInUx1mFCEKdNyF6F1Ade1P8ET5cM=;
 b=K3X31NNuvHdknW5P8UcnhDjhiG8YvVt80acZ9o0cp4OYATGyivVrgqlV16YtlE7nbP
 c2GxVasHb4XHOFgQ/OS9twOzcL7BvXjTYuSlqOjY9QQ9Ng38MAMFgLpleBdUdi0JHrfh
 vH2pyWqiWlGfPiDmnJWawogp9bgGCHsqyjPUtcw1LCUqNNx0sfyV98mwYq27/2m4POny
 BQ0yFM/O7SF2EkZuaQwCJWPmH3fQatSgwEAq5u1SGy/Tn9a9GB4Iyolqgm4mMJBiful/
 xoI0a2JEsYatNItIvqoWJ5uBgwrOZHldhxPZGCUP9cL5ecB1flcnPXHxLR4p0/kiQzuI
 LzCw==
X-Gm-Message-State: AOJu0YxWyAwGwQqYK1sZdfMljusz9BkH4fhylN1UvHETC7GDQDWtfFQS
 zz40Z5A7yrfIoS4SkMLM2xTSe57qyfKfFPHRVJe68kPHnsvbdEUpZAecLqJ/
X-Google-Smtp-Source: AGHT+IFHIEUEnOF2eowKWLbmMJR2/rx9rLlqHF2Mjo+/1rBeB4NWOHO0cl406VU5J335aX8QI6m/5A==
X-Received: by 2002:a17:902:d2c5:b0:20c:a644:817f with SMTP id
 d9443c01a7336-20ca6448261mr49539675ad.7.1728675103070; 
 Fri, 11 Oct 2024 12:31:43 -0700 (PDT)
Received: from apollo.hsd1.ca.comcast.net ([2601:646:9d80:4380::f083])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c8bc13551sm26871055ad.88.2024.10.11.12.31.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Oct 2024 12:31:42 -0700 (PDT)
From: Khem Raj <raj.khem@gmail.com>
To: qemu-devel@nongnu.org
Cc: Khem Raj <raj.khem@gmail.com>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v2] sched_attr: Do not define for glibc >= 2.41
Date: Fri, 11 Oct 2024 12:31:40 -0700
Message-ID: <20241011193140.1047648-1-raj.khem@gmail.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=raj.khem@gmail.com; helo=mail-pl1-x635.google.com
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

Define sched_attr conditionally on SCHED_ATTR_SIZE_VER0

Fixes builds with glibc/trunk

[1] https://sourceware.org/git/?p=glibc.git;a=commitdiff;h=21571ca0d70302909cf72707b2a7736cf12190a0;hp=298bc488fdc047da37482f4003023cb9adef78f8

Signed-off-by: Khem Raj <raj.khem@gmail.com>
Cc: Laurent Vivier <laurent@vivier.eu>
Cc: Paolo Bonzini <pbonzini@redhat.com>
---
v2: Use SCHED_ATTR_SIZE_VER0 instead of glibc version check

 linux-user/syscall.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index 1354e75694..caecbb765d 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -359,7 +359,8 @@ _syscall3(int, sys_sched_getaffinity, pid_t, pid, unsigned int, len,
 #define __NR_sys_sched_setaffinity __NR_sched_setaffinity
 _syscall3(int, sys_sched_setaffinity, pid_t, pid, unsigned int, len,
           unsigned long *, user_mask_ptr);
-/* sched_attr is not defined in glibc */
+/* sched_attr is not defined in glibc < 2.41 */
+#ifndef SCHED_ATTR_SIZE_VER0
 struct sched_attr {
     uint32_t size;
     uint32_t sched_policy;
@@ -372,6 +373,7 @@ struct sched_attr {
     uint32_t sched_util_min;
     uint32_t sched_util_max;
 };
+#endif
 #define __NR_sys_sched_getattr __NR_sched_getattr
 _syscall4(int, sys_sched_getattr, pid_t, pid, struct sched_attr *, attr,
           unsigned int, size, unsigned int, flags);

