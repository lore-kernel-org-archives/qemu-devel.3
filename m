Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7DE57C48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 14:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcQsH-00027z-6x; Tue, 20 Feb 2024 09:13:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.vogt@gmail.com>)
 id 1rcNp8-0004k1-C7
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 05:58:06 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <michael.vogt@gmail.com>)
 id 1rcNp6-0004zw-Uh
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 05:58:06 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-412698cdd77so8973055e9.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 02:58:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708426683; x=1709031483; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=uNCdCIQzg/12W/RrXAVFQ1Isw/BMjvNQW4Y14ZuF5vg=;
 b=RpoJCcYQ8E1W13J5p9kAqIghAIyM0xgwJBCGmtbbeaeItd4bcerqY2EQg56fkUZCv5
 HXfRtKPXDq2UAodTGJCrt0JkOdRlU4eqfkkbxL9fpU5rPH+fLOC8Kp8d6H81ri5MbynZ
 7WrLSEr+QUR3mD3uw0iFrh54gVCIyEiAMjOEldoznK/Auieomp7jmV5Z4ZAaCPeDtjpP
 czw3rvXg5DXdMTFmTy4xW/mJA0quMAk2ky37mwTqyNMUDRdGDQbr6V/ZjFjMwPDquauq
 7G8PRus3KErqlAqLhNoqL0VICILp9oa5YGqSiA8Cu98vNvbdNkcf89mtE4rr80vwImh9
 rMrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708426683; x=1709031483;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=uNCdCIQzg/12W/RrXAVFQ1Isw/BMjvNQW4Y14ZuF5vg=;
 b=anLCtG+2+69Viw2YFg93vXg3ZBx/82tUVKrUPKG0+3CgiM2BmSukRsME1L+upQkYAV
 Llc9ODBvHts9RRZU1MeybdSSRMnAHrXrIJ6HZP30K1cHOxyXB7DOp27hCfOelFBBffpM
 IVwjaKn+XnJ95IUMwMrhZ2T5Mcicw8tbRkCyDQwqrIpfpGWpOEq2HkEbe9T6z143sCBZ
 XYDpDvFRQauxu+SUoVeQjDxt1gm0XHFzwdGH/QjQ/2YDwkkB/yUtlaDHgXafwnzwow/8
 uHvdTZ9neIWDCUHEiHqRg9tHudOy1VhxH6T4jxzakzyTEit+mh2qB05/Yg2brj+hBo1u
 SaDg==
X-Gm-Message-State: AOJu0YxyvxpfZhEbdDWqHqfThgFNUwkmqMXvDaxwAQH7HqdpGm5oVEbJ
 rzstVAif1eTUKOE4NOnCiMyJ9q/vEtd63Er7imeDi7lVutB0bby6fZFsj8mI
X-Google-Smtp-Source: AGHT+IE2hKFMh+QD9lqo4/l/cbseDYiavURJ+upMLFKaU0m0xEke2RTe4jcFKHw/Btg16XyIu0kMxQ==
X-Received: by 2002:a05:600c:4f43:b0:411:e86d:85a3 with SMTP id
 m3-20020a05600c4f4300b00411e86d85a3mr16304898wmq.16.1708426682414; 
 Tue, 20 Feb 2024 02:58:02 -0800 (PST)
Received: from top.fritz.box (p5dd94bc2.dip0.t-ipconnect.de. [93.217.75.194])
 by smtp.gmail.com with ESMTPSA id
 co18-20020a0560000a1200b0033d4c3b0beesm7032427wrb.19.2024.02.20.02.58.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Feb 2024 02:58:02 -0800 (PST)
From: Michael Vogt <michael.vogt@gmail.com>
To: qemu-devel@nongnu.org
Cc: Michael Vogt <michael.vogt@gmail.com>
Subject: [PATCH] linux-user: Add FIFREEZE and FITHAW ioctls
Date: Tue, 20 Feb 2024 11:57:21 +0100
Message-ID: <20240220105726.8852-1-michael.vogt@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=michael.vogt@gmail.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 20 Feb 2024 09:13:26 -0500
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

Add missing FIFREEZE and FITHAW ioctls.

Signed-off-by: Michael Vogt <michael.vogt@gmail.com>
---
 linux-user/ioctls.h       | 6 ++++++
 linux-user/syscall_defs.h | 3 +++
 2 files changed, 9 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 071f7ca253..1aec9d5836 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -134,6 +134,12 @@
      IOCTL(FICLONE, IOC_W, TYPE_INT)
      IOCTL(FICLONERANGE, IOC_W, MK_PTR(MK_STRUCT(STRUCT_file_clone_range)))
 #endif
+#ifdef FIFREEZE
+     IOCTL(FIFREEZE, IOC_W | IOC_R, TYPE_INT)
+#endif
+#ifdef FITHAW
+     IOCTL(FITHAW, IOC_W | IOC_R, TYPE_INT)
+#endif
 
      IOCTL(FIGETBSZ, IOC_R, MK_PTR(TYPE_LONG))
 #ifdef CONFIG_FIEMAP
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 77ba343c85..744fda599e 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -943,6 +943,9 @@ struct target_rtc_pll_info {
 #define TARGET_FICLONE    TARGET_IOW(0x94, 9, abi_int)
 #define TARGET_FICLONERANGE TARGET_IOW(0x94, 13, struct file_clone_range)
 
+#define TARGET_FIFREEZE    TARGET_IOWR('X', 119, abi_int)
+#define TARGET_FITHAW    TARGET_IOWR('X', 120, abi_int)
+
 /*
  * Note that the ioctl numbers for FS_IOC_<GET|SET><FLAGS|VERSION>
  * claim type "long" but the actual type used by the kernel is "int".
-- 
2.43.0


