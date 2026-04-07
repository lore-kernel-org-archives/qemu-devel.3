Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE01FFF5136
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:24:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABXf-0000Kb-9P; Tue, 07 Apr 2026 14:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1wABUK-000521-Eo
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:49:24 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1w9yDJ-0007HW-Al
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 00:38:58 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-82735a41920so1564481b3a.2
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 21:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1775536736; x=1776141536; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wsSyzB+nHn6U7XjN+sfZadyH0yW29u1E/XNnjLJPkzk=;
 b=j1r1947wqgKNT2m3e+LEOVpbWU1J7kCAPPQHmTPEMX7pks9AZuZayudot7y0c+GE0j
 W1wohoiq/ahdAZqRCo7TrdfEtb7PLCa6pkxXtmykDoKZCCGJeCLpbtsv5X4rwkt0gd7U
 G1iv4eY+GnJw6u5QpWmUrWEsYfA2sPOCTIol+pGQzW197aZL6CpByM2B5nInd1XomOUl
 xPW/fo4czr3NZ3IAqus58lmlWRecRgwo9/U0BDq3kSbed4maMiN9aOybD6e0cCuvoYZG
 BBsm9xFeNblIBgFqXCxIagmUfPt44ZVEIlCs3Eh690KmxYtFfFhJPvcbKWU0Hy8jlfLj
 ekww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775536736; x=1776141536;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wsSyzB+nHn6U7XjN+sfZadyH0yW29u1E/XNnjLJPkzk=;
 b=eB/YwoC/GYv9kVIcYX2JotyWewJVjrwCVFoAgYL9c1H8iDST8dlKvoxSOiyU0cKui/
 4gcll9cayQ/mVnk9Sr6mPWAXxxI/1rSO9v58XrahOwpN6bxb50vQt/PDTWlkxbrllEpt
 JEtgNoAGgbFQp25h09/0Lhqi9qI7Kx65mZc5tE/rk7uws96W61ows9knkHMOoN5onnpH
 EitqcGabQctuFdy2vdMgEihV1v6zTPhdJ0Zy8VV6RvK/fADRGQbW0DS6NGHQpTINEfjZ
 LOhJnQ3fKcnzmX2Sj7KGqKQiTlwYavERPoFRT5eoujw4Leou1hKOsnaj7fCy8nWJiNqS
 ay3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXpwSzutzGbXPoFkO3cdYSfzB0Ov3dfmWQOSAWdy6Gh4n5avODyV5MEqwmWhWxCdbExnVZBQ9yQ8Vfr@nongnu.org
X-Gm-Message-State: AOJu0YxK6ujAhrxA32dpTBMsvTEantS+GglAf9m42cD8EWGc14YNrdDJ
 ywq1ftjnUJ0ZygL1gY3wkdGcXrNOO5nVlLN2rg2TlcSg/O9p339QIl9k
X-Gm-Gg: AeBDievXqgv4ghyM2tvAvkko2LRC0/vNu+HMnQCfjJDm8jFAIucfRTT0LgzkAdan2Rl
 MBcW6CII4UKh81ujqia06H6K5vgIvxKaCTR4dJsllkRRB4yHYCWzSDussH+eAVtoXelTEmS4aXC
 Kc0oMxQ9HTGRUtee0HvsB4Jvy5UH5avhzXAcSWIPkmEuktrNXCw/x2y3M13wm/Dm10pvLsf6gvf
 4Iaxc1Pl/Bw4+vzv4FIkM1TnnJ3jIOeEq8r3mEDaJ/WZP4HZit/F9tBS4C/0jlehoL2LD+RDSre
 mRzPGkfoHq3AkHd94zt+RrOfZqafU++5eUtDPSHENQJ0reaELVeKlPMG6hbayOFeNTH+MlltF5n
 O0DnIb7+lZ1sZxoHTCJ4YKPoULAuu6MVemDf9LY+ythJpUioNET1PoQ9f0jVOdYgBPciio0UEt/
 8YDQWckDDDlQ0Z+ry5xkWOfwsGRFpF5SRyTggczVke
X-Received: by 2002:a05:6a20:3d90:b0:39e:f994:f685 with SMTP id
 adf61e73a8af0-39f2ee00861mr15120747637.6.1775536735852; 
 Mon, 06 Apr 2026 21:38:55 -0700 (PDT)
Received: from toolbx.alistair23.me ([2403:581e:fdf9:0:6209:4521:6813:45b7])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c76c6491fedsm15809963a12.8.2026.04.06.21.38.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 21:38:54 -0700 (PDT)
From: alistair23@gmail.com
X-Google-Original-From: alistair.francis@wdc.com
To: palmer@dabbelt.com, liwei1518@gmail.com, daniel.barboza@oss.qualcomm.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: alistair23@gmail.com,
	Alistair Francis <alistair.francis@wdc.com>
Subject: [PATCH 2/5] linux-user/strace: Add a wrapper for read and write
Date: Tue,  7 Apr 2026 14:36:11 +1000
Message-ID: <20260407043614.372871-3-alistair.francis@wdc.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260407043614.372871-1-alistair.francis@wdc.com>
References: <20260407043614.372871-1-alistair.francis@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=alistair23@gmail.com; helo=mail-pf1-x42b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Alistair Francis <alistair.francis@wdc.com>

The stack pointer is being truncated as 32-bits for qemu-riscv64, so
let's add a print_read_write helper that ensures all of the bits are
printed.

Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3238
Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
---
 linux-user/strace.c    | 14 ++++++++++++++
 linux-user/strace.list |  4 ++--
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/linux-user/strace.c b/linux-user/strace.c
index 2cbaf94c89..023173857b 100644
--- a/linux-user/strace.c
+++ b/linux-user/strace.c
@@ -4309,6 +4309,20 @@ print_tgkill(CPUArchState *cpu_env, const struct syscallname *name,
 }
 #endif
 
+#if defined(TARGET_NR_read) || defined(TARGET_NR_write)
+static void
+print_read_write(CPUArchState *cpu_env, const struct syscallname *name,
+        abi_long arg0, abi_long arg1, abi_long arg2,
+        abi_long arg3, abi_long arg4, abi_long arg5)
+{
+    print_syscall_prologue(name);
+    print_raw_param("%d", arg0, 0);
+    print_pointer(arg1, 0);
+    print_raw_param("%d", arg2, 1);
+    print_syscall_epilogue(name);
+}
+#endif
+
 #if defined(TARGET_NR_pread64) || defined(TARGET_NR_pwrite64)
 static void
 print_pread64(CPUArchState *cpu_env, const struct syscallname *name,
diff --git a/linux-user/strace.list b/linux-user/strace.list
index 35f001fecd..239b9e18b4 100644
--- a/linux-user/strace.list
+++ b/linux-user/strace.list
@@ -1114,7 +1114,7 @@
 { TARGET_NR_quotactl, "quotactl" , NULL, NULL, NULL },
 #endif
 #ifdef TARGET_NR_read
-{ TARGET_NR_read, "read" , "%s(%d,%#x,%d)", NULL, NULL },
+{ TARGET_NR_read, "read" , NULL, print_read_write, NULL },
 #endif
 #ifdef TARGET_NR_readahead
 { TARGET_NR_readahead, "readahead" , NULL, NULL, NULL },
@@ -1674,7 +1674,7 @@
                      print_syscall_ret_waitpid },
 #endif
 #ifdef TARGET_NR_write
-{ TARGET_NR_write, "write" , "%s(%d,%#x,%d)", NULL, NULL },
+{ TARGET_NR_write, "write" , NULL, print_read_write, NULL },
 #endif
 #ifdef TARGET_NR_writev
 { TARGET_NR_writev, "writev" , "%s(%d,%p,%#x)", NULL, NULL },
-- 
2.53.0


