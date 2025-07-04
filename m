Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EB2C83F03
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 10:29:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXdfp-0003ih-P4; Fri, 04 Jul 2025 06:29:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvogt@redhat.com>) id 1uXdfj-0003iL-PF
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:29:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mvogt@redhat.com>) id 1uXdfg-0007GN-UQ
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 06:29:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751624970;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=uGysQ4zd9SWmPMYTJ5afHF857JJ1IW4lu8cBVoj4QD8=;
 b=fBEV+KtcaXxlIfOhZ5Nb4CBsZVs03L0V2R3W50Q9oCooUAyKs+gpp2Sn71VSAZaoAUPFdn
 QlYGX5t9s3mvRSFO8u1csqTTiHRKPK7Jp9/R6v6hpdeq4BNbmHFa+1DSU+oHBwEkYEWZ/w
 7Em8mbSfN9Lyo9zWu2BR5OGUb77t7Us=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-qiVUAhi0P56hyijVAkn8UQ-1; Fri, 04 Jul 2025 06:28:23 -0400
X-MC-Unique: qiVUAhi0P56hyijVAkn8UQ-1
X-Mimecast-MFC-AGG-ID: qiVUAhi0P56hyijVAkn8UQ_1751624902
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-60c4d1b0aa4so723456a12.3
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 03:28:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751624902; x=1752229702;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uGysQ4zd9SWmPMYTJ5afHF857JJ1IW4lu8cBVoj4QD8=;
 b=S91PlUGJCZe0x+Z7xZ5tGzKqi8pT05TxiaFxGttuAS3S2dhCMLUwCU3JT4yOKKWwLm
 DGShbp+0s79s1ejkpg+25mbo9YHWZLIkUypzSrKce+xwNazlMeyJBIR5IyHWZarCi4Lv
 Tf0ff4lJD0CVgZ+wi9tyQ9AqVWOGtwxFSZQfY0Gxjou7Lj66kWibF7l7jZZzPO2GyMls
 wqFmWuNcKyBGWJlo+gIIQsQEScT+KtHFriPC8xywC1IR90emi/0B/6rqPQc8TVlFhMGJ
 hf8MrckiQCyK4DbB6otA1CTxtvSaob6uG1O8tEo2IFAjTp7EuqlUfaW0xhq+v/QWNPnS
 2O7g==
X-Gm-Message-State: AOJu0Yxk3mdROHcg0EfEC7jZEGFkinMTEckScQ9RE0BrwOFsQBEdhC6O
 FOkgtRDgEkx62w0zWumVUqxEQ+LVFpXkX9lTV/9YXKIvRYP57wws775urbGUKzcWvp4VtqHVQkS
 bKI0yzAxqyTFKlTFFqRyLT7rfHwPnYFVb9YYEUhnIEicCp9c8tIwagfJ8skdg1/q30oYL7K44/m
 /KObod3M9WSnROZ95Qe65vPEY8j+6O7IRRp9aPqg0=
X-Gm-Gg: ASbGncvEB4G8aKYpG8mfRoNf9JcOT4Ppy52y9APJHW9CU6e/r0XCmLhum+mbLByTlh6
 UK7vrm5GhWK0RiQfmwplMP9p0AObM3npn4mmz8wYPBNN4+A06Q1sLnajLmEghpIbqXWdMfGAFdC
 NjTqs45C35JDTUNJkw6b5uO6+i5sEmdQJ+N15VXYMW8VDmaBW96EN5+RbMAJXlB7LgnXNfpKWkZ
 NZ0T0PEeyQwsO9l6Z+m1XjPYhQbEn66f5Z0VQy6+jfguoBxp8pTXJwNG2mG4H4lyzHAeUiPRhQm
 x4rrvgNrOAZFPRhf4XvmNvpqST1xuEKbFA==
X-Received: by 2002:a05:6402:5112:b0:60e:23d:43b1 with SMTP id
 4fb4d7f45d1cf-60fd3371b33mr1480282a12.16.1751624901914; 
 Fri, 04 Jul 2025 03:28:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvCS19AqrOhj32yAym6Qbb2TYEZytFf3xaKlyo24vv6cQF8nsYUNPNdNyQmwMSqGqkCKvE+A==
X-Received: by 2002:a05:6402:5112:b0:60e:23d:43b1 with SMTP id
 4fb4d7f45d1cf-60fd3371b33mr1480259a12.16.1751624901306; 
 Fri, 04 Jul 2025 03:28:21 -0700 (PDT)
Received: from top.fritz.box ([2a00:6020:4c20:5100:b554:58b6:5239:7d31])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-60fcb1fa9b8sm1118480a12.54.2025.07.04.03.28.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Jul 2025 03:28:20 -0700 (PDT)
From: Michael Vogt <mvogt@redhat.com>
X-Google-Original-From: Michael Vogt <michael.vogt@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Michael Vogt <michael.vogt@gmail.com>
Subject: [RFC] linux-user: return success in TARGET_NR_set_robust_list
Date: Fri,  4 Jul 2025 12:26:38 +0200
Message-ID: <20250704102637.32341-2-michael.vogt@gmail.com>
X-Mailer: git-send-email 2.47.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mvogt@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.237, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The linux set_robust_list() syscall cannot be supported by
qemu-user as explained in e9a970a8316 and hence we return
ENOSYS.

With that understanding this commit still changes the
return to "0". This is of course wrong because we do not
actually support  set_robust_list() *but* for qemu-user
based processes the call result makes less practical
difference:
1. glibc does not actually check the return value and assumes
   robust lists anyway (see below for details) on the common
   architectures. As their is only one per-thread list of
   robust locks this will cover everything that uses glibc
   threading.
2. set_robust_list is about dealing with crashes while
   holding the lock [1]. Without robust futexes only a system
   reboot can release a deadlocked futex. However for
   qemu-user its "only" a restart of the qemu-user process.

Why is this relevant? Because it means we get inconsistent
behavior from qemu-user when trying to run programs like
podman via qemu-user that can request:
```
pthread_mutexattr_setpshared(&attr, PTHREAD_PROCESS_SHARED);
pthread_mutexattr_setrobust(&attr, PTHREAD_MUTEX_ROBUST);
```
This will run fine in qemu-user for x86_64, aarch64 targets
but it fails on riscv64 targets because of
https://github.com/bminor/glibc/blob/glibc-2.41/nptl/pthread_mutex_init.c#L96

With this commit we get the same behavior on riscv64 as
on x86_64 and aarch64.

This commit does not change TARGET_NR_get_robust_list
which is not used by glibc but according to [2] it
is used by steam which will still get TARGET_ENOSYS
which seems fine (but equaly fine to change it).

Note also that with the new set_robust_list2 described
in https://lwn.net/Articles/1027135/ we could actually
implement the real behavior.

Glibc details:

Nowdays glibc does not actually check the
return code of the syscall anymore for the common
architectures because of __ASSUME_SET_ROBUST_LIST, c.f.
https://github.com/bminor/glibc/blob/glibc-2.41/sysdeps/nptl/dl-tls_init_tp.c#L93

And __ASSUME_SET_ROBUST_LIST is set by default but can be
unset in the per architecture kernel-features.h. But for
e.g. X86_64,aarch64 it is left alone. It his however set
on riscv64 conditionally:
https://github.com/bminor/glibc/blob/glibc-2.41/sysdeps/unix/sysv/linux/riscv/kernel-features.h#L25
which means it will end up in the riscv libc there
(output from a debian/testing system with libc6:{riscv64,..}/2.41-9)
```
$ for libc in /usr/lib/*/libc.so.6; do echo "$libc:"; strings "$libc"| grep -n __nptl_set_robust_list_avail; done
/usr/lib/aarch64-linux-gnu/libc.so.6:
/usr/lib/arm-linux-gnueabihf/libc.so.6:
/usr/lib/arm-linux-gnueabi/libc.so.6:
/usr/lib/riscv64-linux-gnu/libc.so.6:
1963:__nptl_set_robust_list_avail
/usr/lib/x86_64-linux-gnu/libc.so.6:
```

Because on riscv64 __ASSUME_SET_ROBUST_LIST is not set this
https://github.com/bminor/glibc/blob/glibc-2.41/nptl/pthread_mutex_init.c#L96
triggers the error.

[1] https://lwn.net/Articles/172134/
[2] https://github.com/FEX-Emu/FEX/commit/310252b97d0fce5c63d07c7911d6d4ec6c2a4efe#diff-8a33d992b7143e73a0235215985c690b61d3b0ef8e5a31e9afb8531914fa3ea2R141

Signed-off-by: Michael Vogt <michael.vogt@gmail.com>
---
 linux-user/syscall.c | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index fc37028597..415be7124b 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -12931,18 +12931,30 @@ static abi_long do_syscall1(CPUArchState *cpu_env, int num, abi_long arg1,
 
 #ifdef TARGET_NR_set_robust_list
     case TARGET_NR_set_robust_list:
-    case TARGET_NR_get_robust_list:
         /* The ABI for supporting robust futexes has userspace pass
          * the kernel a pointer to a linked list which is updated by
          * userspace after the syscall; the list is walked by the kernel
          * when the thread exits. Since the linked list in QEMU guest
          * memory isn't a valid linked list for the host and we have
          * no way to reliably intercept the thread-death event, we can't
-         * support these. Silently return ENOSYS so that guest userspace
-         * falls back to a non-robust futex implementation (which should
-         * be OK except in the corner case of the guest crashing while
-         * holding a mutex that is shared with another process via
-         * shared memory).
+         * support these.
+         *
+         * We still return "0" here as for qemu-user based processes
+         * the call makes less practical difference:
+         * 1. glibc does not actually check the return value and assumes
+         *    robust lists anyway on the common architectures. As
+         *    their is only one per-thread list of robust locks this
+         *    will cover everything that uses glibc threading.
+         * 2. set_robust_list is about dealing with crashes while
+         *    holding the lock. Without robust futexes only a system
+         *    reboot can release a deadlocked futex. However for
+         *    qemu-user its "only" a restart of the qemu-user process.
+         */
+        return 0;
+    case TARGET_NR_get_robust_list:
+        /* For systems that double check via get_robust_list() we
+         * silently return ENOSYS so that guest userspace can fall
+         * back to a non-robust futex implementation.
          */
         return -TARGET_ENOSYS;
 #endif
-- 
2.47.2


