Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 842E3CD1288
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Apr 2024 09:22:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrwoa-0006c4-DW; Wed, 03 Apr 2024 05:21:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael.vogt@gmail.com>)
 id 1rrwoU-0006b7-0S
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 05:21:47 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <michael.vogt@gmail.com>)
 id 1rrwoS-0007Iv-IX
 for qemu-devel@nongnu.org; Wed, 03 Apr 2024 05:21:45 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-60a104601dcso62920767b3.2
 for <qemu-devel@nongnu.org>; Wed, 03 Apr 2024 02:21:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1712136100; x=1712740900; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Tf73zga/dXfvQEEuZTXclXjva9tINeQWZCQ9rxo66ZM=;
 b=hz2OqKgDnqIJQCT2KVOomVmf+tyAKX72bx10J9QVciau+RwrVmIZRbnRBG85jDCrtZ
 yKGvox2KsnmZTV9ngff2IbkbEvF1aHORboJoV6zAc5cPRTkozWUnhMlL2R1vxUSo3wnJ
 2I3Lnt0+XDIjkjeXxKA60zIn+n2+nWYEgEBiU+Ag9pcERWs0PFweZ+K85vQDr/bswb2m
 er9Ukn7rlEI0fZEbZ3YwqvJi/rCyG/HrMOPDQBe61y+jfQ4wAnepXsNINWQr0w6AH+8J
 d6IMt3f3ODQ3giQ4U7fstNhH9w2YkviyX0/JjyQM07hxdbVcuAyhpXv31jC41coBpgcC
 0L2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712136100; x=1712740900;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tf73zga/dXfvQEEuZTXclXjva9tINeQWZCQ9rxo66ZM=;
 b=fNL/zUH0Z+owiPLylQKrINGzKCDc4CzeAiVFhgy+ZszWlT3CZw2tFqBkJYTc4NZgVP
 zTnsoNQppzQ34GNJtah7fuhk9eeL7cq7Zh56novd9o4qT0uvoeGzhCO0tRPz6iaSIzON
 XH1VH+U0cfBoSNEp9Zxy9xCp4Bn+uPgvCBu+fNsd6AAwvjW5cLmGZTnCYum54hopW8N5
 9GqrCHGXRtpXBtLP+kNPkrHBR8gJ3QHRtKmKh0GtGJNfxsOiX+NG6A7c00xevjzVL4Lk
 x7/dRszz5bSSQuBuc6eZ09z+0dMjRmUzWnROgVeGTlmnfsQBOZ8/jFrCTYg4/0/5HVex
 LDOw==
X-Gm-Message-State: AOJu0YxJuXxbbRuYPmkLd5IIRZelyHCxW7MWUEEL4H6TgWKo0sPsJJ0u
 cNV5c4i02PfVpVk3h3QVzEH7rlI2gyb9J/7NW9ouGEeNmV7mA5ntfQ3meNzh1KQ=
X-Google-Smtp-Source: AGHT+IFlVzSCrErJRFgpvRvcNQ4iWL+oOUBEH4/9k9xWjA52BmdhuudobubQog3NLPdTzqRRBYR1OQ==
X-Received: by 2002:a0d:db8c:0:b0:615:6873:c524 with SMTP id
 d134-20020a0ddb8c000000b006156873c524mr754260ywe.48.1712136100183; 
 Wed, 03 Apr 2024 02:21:40 -0700 (PDT)
Received: from top.fritz.box (p5dd9421d.dip0.t-ipconnect.de. [93.217.66.29])
 by smtp.gmail.com with ESMTPSA id
 p13-20020a81e20d000000b0060cbd86ba1bsm3244468ywl.12.2024.04.03.02.21.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Apr 2024 02:21:39 -0700 (PDT)
From: Michael Vogt <michael.vogt@gmail.com>
To: qemu-devel@nongnu.org,
	richard.henderson@linaro.org
Cc: Michael Vogt <mvogt@redhat.com>
Subject: [PATCH] linux-user: Add FITRIM ioctl
Date: Wed,  3 Apr 2024 11:20:49 +0200
Message-ID: <20240403092048.16023-2-michael.vogt@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=michael.vogt@gmail.com; helo=mail-yw1-x1130.google.com
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

From: Michael Vogt <mvogt@redhat.com>

Tiny patch to add the missing FITRIM ioctl.

Signed-off-by: Michael Vogt <mvogt@redhat.com>
---
 linux-user/ioctls.h        | 3 +++
 linux-user/syscall_defs.h  | 1 +
 linux-user/syscall_types.h | 5 +++++
 3 files changed, 9 insertions(+)

diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
index 1aec9d5836..d508d0c04a 100644
--- a/linux-user/ioctls.h
+++ b/linux-user/ioctls.h
@@ -140,6 +140,9 @@
 #ifdef FITHAW
      IOCTL(FITHAW, IOC_W | IOC_R, TYPE_INT)
 #endif
+#ifdef FITRIM
+     IOCTL(FITRIM, IOC_W | IOC_R, MK_PTR(MK_STRUCT(STRUCT_fstrim_range)))
+#endif
 
      IOCTL(FIGETBSZ, IOC_R, MK_PTR(TYPE_LONG))
 #ifdef CONFIG_FIEMAP
diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
index 744fda599e..ce0adb706e 100644
--- a/linux-user/syscall_defs.h
+++ b/linux-user/syscall_defs.h
@@ -945,6 +945,7 @@ struct target_rtc_pll_info {
 
 #define TARGET_FIFREEZE    TARGET_IOWR('X', 119, abi_int)
 #define TARGET_FITHAW    TARGET_IOWR('X', 120, abi_int)
+#define TARGET_FITRIM    TARGET_IOWR('X', 121, struct fstrim_range)
 
 /*
  * Note that the ioctl numbers for FS_IOC_<GET|SET><FLAGS|VERSION>
diff --git a/linux-user/syscall_types.h b/linux-user/syscall_types.h
index c3b43f8022..6dd7a80ce5 100644
--- a/linux-user/syscall_types.h
+++ b/linux-user/syscall_types.h
@@ -341,6 +341,11 @@ STRUCT(file_clone_range,
        TYPE_ULONGLONG, /* src_length */
        TYPE_ULONGLONG) /* dest_offset */
 
+STRUCT(fstrim_range,
+       TYPE_ULONGLONG, /* start */
+       TYPE_ULONGLONG, /* len */
+       TYPE_ULONGLONG) /* minlen */
+
 STRUCT(fiemap_extent,
        TYPE_ULONGLONG, /* fe_logical */
        TYPE_ULONGLONG, /* fe_physical */
-- 
2.43.0


