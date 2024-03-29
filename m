Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25467CD1283
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 06:32:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rq5mv-0002pV-RY; Fri, 29 Mar 2024 02:32:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1rq5mt-0002mo-Tg; Fri, 29 Mar 2024 02:32:27 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1rq5ms-0001x5-1N; Fri, 29 Mar 2024 02:32:27 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1def3340682so15595245ad.1; 
 Thu, 28 Mar 2024 23:32:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711693942; x=1712298742; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=sAs3vTGnClbvNwXtqETLXylv1FnXYl3lh4mYErtNGAk=;
 b=iaAl4Wj3IT6FOEClpBudIemge8lN7FmLizl1r/rBCkmsZ4H/tvs4gwCDf99+itJM3S
 XxXQUyw4KvhO2MSHw5h09pGUnsBASig9lO62A+JT7sVfWu28oz8MdLe9UMGDRCu05HAF
 ZNTyVvSQcbOXmp48t7H1kV0IwcLM8PaFeBUiPcddAYHCqMKtmPkllhy+sMQJLZwKSG4p
 v4/gp824riW/ZkV1Ym+aqOdvzP5MGkCmiJBgTwiWR1ISqW6XG4wbsJeKzXJrGbym5e3N
 qD3dLSfg+yg+NcO0gxIayuEIYguLKPtEQg8zTliU9o7jjBXsMqF2iuT1Df113qg3BeDI
 dGZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711693942; x=1712298742;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sAs3vTGnClbvNwXtqETLXylv1FnXYl3lh4mYErtNGAk=;
 b=LAFZDFU7TRd6PS7MhHh1rHXYoJ5dfl2fMLHBbvubtniEFFgaEpq7oybeXAMqLIzbbB
 j+tLOV1SFQ0rQB381PNpAH/5jp8n1nX1T5uzBnoL7lFNKo4+BEG0b6GMYnyGmHgG8lIx
 ZlVZ58sdceuagmTJdo9UeLc66w3PdjXEWrv2OSxdExcsZKOL0+AfTzWxPluSE+V+IleV
 SnRnSSDcfdod8/r7zc5wW3UJ2tjUjCCsgfb5awx4einqKSeXejCdxvD8kwbVzix5bMPT
 NBbEX2HOQVRNBVaAKuIo0vajMh15AmvqRwMexiYH5n8b1CBYmSbU7uQ/9zLb1fnQ/xDI
 qvJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwgJ46jejFxRfQ45P5QWyV7nrVwBSSElW01o1ghNdi3S9+eD2sag/3dksLZQ0taiY5ZFIpWkgIpvj0DF8Mj0btkIJ67bb4
X-Gm-Message-State: AOJu0Yyf6hleWDaobrGa12XXcukLw1or39MO6p32eYfJpgzpQcXCC4MB
 KnCssCwgRWeHqCuhBYe5KZLFOUiD2iWpYeIM91iTvv0WL/fXZy3Gnx6eAxHy
X-Google-Smtp-Source: AGHT+IGYUcKGhxDOxzJgJLj0ZiEwdJ+L4AWU7Z7yu27iNP3Hn9v9lCTHEJfCPVGAnJoDue+5ZFyuxA==
X-Received: by 2002:a17:903:40c7:b0:1e2:23b8:9880 with SMTP id
 t7-20020a17090340c700b001e223b89880mr2014447pld.35.1711693942459; 
 Thu, 28 Mar 2024 23:32:22 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net
 ([2601:646:a200:bbd0:3e59:66bc:8049:275e])
 by smtp.gmail.com with ESMTPSA id
 kt15-20020a170903088f00b001db616fa11dsm2717423plb.238.2024.03.28.23.32.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Mar 2024 23:32:22 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Cc: Max Filippov <jcmvbkbc@gmail.com>,
	qemu-stable@nongnu.org
Subject: [PATCH] linux-user/syscall: xtensa: fix target_msqid_ds and ipc_perm
 conversion
Date: Thu, 28 Mar 2024 23:31:48 -0700
Message-Id: <20240329063148.129343-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FROM_LOCAL_NOVOWEL=0.5, HK_RANDOM_ENVFROM=0.001, HK_RANDOM_FROM=0.999,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

- target_ipc_perm::mode and target_ipc_perm::__seq fields are 32-bit wide
  on xtensa and thus need to use tswap32
- target_msqid_ds::msg_*time field pairs are reversed on big-endian
  xtensa
Both issues result in incorrect conversion results on big-endian xtensa
targets, spotted by the libc-test http://nsz.repo.hu/git/?p=libc-test

Cc: qemu-stable@nongnu.org
Fixes: a3da8be5126b ("target/xtensa: linux-user: fix sysv IPC structures")
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
 linux-user/syscall.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index e384e1424890..cb334e90d6f0 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -3758,12 +3758,13 @@ static inline abi_long target_to_host_ipc_perm(struct ipc_perm *host_ip,
     host_ip->gid = tswap32(target_ip->gid);
     host_ip->cuid = tswap32(target_ip->cuid);
     host_ip->cgid = tswap32(target_ip->cgid);
-#if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_PPC)
+#if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_PPC) || \
+    defined(TARGET_XTENSA)
     host_ip->mode = tswap32(target_ip->mode);
 #else
     host_ip->mode = tswap16(target_ip->mode);
 #endif
-#if defined(TARGET_PPC)
+#if defined(TARGET_PPC) || defined(TARGET_XTENSA)
     host_ip->__seq = tswap32(target_ip->__seq);
 #else
     host_ip->__seq = tswap16(target_ip->__seq);
@@ -3786,12 +3787,13 @@ static inline abi_long host_to_target_ipc_perm(abi_ulong target_addr,
     target_ip->gid = tswap32(host_ip->gid);
     target_ip->cuid = tswap32(host_ip->cuid);
     target_ip->cgid = tswap32(host_ip->cgid);
-#if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_PPC)
+#if defined(TARGET_ALPHA) || defined(TARGET_MIPS) || defined(TARGET_PPC) || \
+    defined(TARGET_XTENSA)
     target_ip->mode = tswap32(host_ip->mode);
 #else
     target_ip->mode = tswap16(host_ip->mode);
 #endif
-#if defined(TARGET_PPC)
+#if defined(TARGET_PPC) || defined(TARGET_XTENSA)
     target_ip->__seq = tswap32(host_ip->__seq);
 #else
     target_ip->__seq = tswap16(host_ip->__seq);
@@ -4111,6 +4113,14 @@ static inline abi_long do_semtimedop(int semid,
 struct target_msqid_ds
 {
     struct target_ipc_perm msg_perm;
+#if defined(TARGET_XTENSA) && TARGET_BIG_ENDIAN
+    abi_ulong __unused1;
+    abi_ulong msg_stime;
+    abi_ulong __unused2;
+    abi_ulong msg_rtime;
+    abi_ulong __unused3;
+    abi_ulong msg_ctime;
+#else
     abi_ulong msg_stime;
 #if TARGET_ABI_BITS == 32
     abi_ulong __unused1;
@@ -4122,6 +4132,7 @@ struct target_msqid_ds
     abi_ulong msg_ctime;
 #if TARGET_ABI_BITS == 32
     abi_ulong __unused3;
+#endif
 #endif
     abi_ulong __msg_cbytes;
     abi_ulong msg_qnum;
-- 
2.39.2


