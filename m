Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CB7CCD1283
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 22:37:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqKqR-0006LS-Oo; Fri, 29 Mar 2024 18:37:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1rqKqP-0006Kz-Ra; Fri, 29 Mar 2024 18:37:06 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jcmvbkbc@gmail.com>)
 id 1rqKqN-0004Oh-E5; Fri, 29 Mar 2024 18:37:05 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2a02c4dffd2so1969780a91.0; 
 Fri, 29 Mar 2024 15:37:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711751821; x=1712356621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=mj9v31gRDGM+nfN2TBCBiuzOlHFMKfoWTFJDJrU9N+w=;
 b=dGvJZogD2+H4rmBhUkTrye75zjFuTiNuqxzS0pvkEkTGAWoQU3bKXp728ojfrP/Ty5
 XtsISUGs1ahuuRdfvjf1OJjuDS850LJsOYwy7+UGS1cnLWJRCz2CEO8n+Jdd9dQxPVLD
 kWPUNfbVLV8OZTeeNNcGL28gZg41CW03iezvUcqkQIqm+cP44aPtQ6QxymCgHabTtOwF
 enV+UbqwpSWW7pT4rPEvbGpKiL3y53bXBtujukTNiOC9MeZJnv3CiQ0GKxx+lbJ8G0/I
 xl7C1fULZ4RwUoKaDjsU+lhEuJYYp5o52QeY/NZyooUhxKH4YLgEFhAU5Yc2S36Htpat
 9TRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711751821; x=1712356621;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mj9v31gRDGM+nfN2TBCBiuzOlHFMKfoWTFJDJrU9N+w=;
 b=sggKJsNKz2UptRGvZw4RT7uS6/v+rdJ6jVp3/lM50SqhO6upd3Fr/1YGE+4jTOXg/m
 FqdIfmLB1p+MzdlLF9rnC5EtNC7hLp1cLcQcyAcALBr9aiXi1GOCib5LQFeDzQJq+xSs
 zFAg6Aoo9VKPhHcXehTIpXgtONSZUTRqShWvMTnPoMNguQLpO8qpspgtVyKP/PAxEcBZ
 EwVKJbqvY7Qbs+JczE89s7YkEvN/rBl60ReDYkXFBJEWcfdNymDs2eXmPEhBoxJIFnKE
 YdtZ0jzfl7KFyQIBk4IUk1Po/0BnxaG6EqgWIZv7+TJVgGNcTsawNRzJTRgQVj2e6VjX
 a7KQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrhybCn0/ZzDcL6q5yiWmxC3oTnjsMBCnFYfVCCtX3deSBziaEblvo+AvrtsMaOT9mEDy0bJabvA+w1Y4Q5KFX+9hpPxn+
X-Gm-Message-State: AOJu0YwC7Z4gu2EiyDY2YLZy1ZY7znrSSaRsx0ArUcMFbbQg6IEzc6Eu
 JoW/4F1pdE4FwO+imhhuZEkubTnrnbTSG2dR3h8XwrAlQhYZ/RV/jVKa9f8o
X-Google-Smtp-Source: AGHT+IFqPbf8j/I3DaldjiYDBFIhSv1bQ/SPb+Uo65E7vfEyh3NkCpO6GroNr/r7zEFCnk1i5l9uag==
X-Received: by 2002:a17:90b:3842:b0:2a2:c16:d673 with SMTP id
 nl2-20020a17090b384200b002a20c16d673mr3483934pjb.36.1711751821095; 
 Fri, 29 Mar 2024 15:37:01 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net
 ([2601:646:a200:bbd0:2399:5e4a:95e8:172f])
 by smtp.gmail.com with ESMTPSA id
 c1-20020a17090a490100b002a04eef22c5sm3719439pjh.44.2024.03.29.15.37.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Mar 2024 15:37:00 -0700 (PDT)
From: Max Filippov <jcmvbkbc@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-stable@nongnu.org
Subject: [PATCH v2] linux-user/syscall: fix target_msqid_ds time fields order
Date: Fri, 29 Mar 2024 15:36:53 -0700
Message-Id: <20240329223653.155786-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=jcmvbkbc@gmail.com; helo=mail-pj1-x102c.google.com
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

target_msqid_ds::msg_*time field pairs are reversed on 32-bit TARGET_PPC
and TARGET_SPARC and on big-endian TARGET_MIPS and TARGET_XTENSA.
Fix the order to match the kernel definitions.
The issue is spotted by the libc-test http://nsz.repo.hu/git/?p=libc-test
on big-endian xtensa core.

Cc: qemu-stable@nongnu.org
Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
---
Changes v1->v2:
- split into a separate patch
- add PPC, SPARC and big-endian MIPS

 linux-user/syscall.c | 20 +++++++++++++++-----
 1 file changed, 15 insertions(+), 5 deletions(-)

diff --git a/linux-user/syscall.c b/linux-user/syscall.c
index d9bfd31c1cad..781ed14bc613 100644
--- a/linux-user/syscall.c
+++ b/linux-user/syscall.c
@@ -4113,17 +4113,27 @@ static inline abi_long do_semtimedop(int semid,
 struct target_msqid_ds
 {
     struct target_ipc_perm msg_perm;
-    abi_ulong msg_stime;
 #if TARGET_ABI_BITS == 32
+#if defined(TARGET_PPC) || defined(TARGET_SPARC) || \
+    (TARGET_BIG_ENDIAN && (defined(TARGET_MIPS) || defined(TARGET_XTENSA)))
+    abi_ulong __unused1;
+    abi_ulong msg_stime;
+    abi_ulong __unused2;
+    abi_ulong msg_rtime;
+    abi_ulong __unused3;
+    abi_ulong msg_ctime;
+#else
+    abi_ulong msg_stime;
     abi_ulong __unused1;
-#endif
     abi_ulong msg_rtime;
-#if TARGET_ABI_BITS == 32
     abi_ulong __unused2;
-#endif
     abi_ulong msg_ctime;
-#if TARGET_ABI_BITS == 32
     abi_ulong __unused3;
+#endif
+#else
+    abi_ulong msg_stime;
+    abi_ulong msg_rtime;
+    abi_ulong msg_ctime;
 #endif
     abi_ulong __msg_cbytes;
     abi_ulong msg_qnum;
-- 
2.39.2


