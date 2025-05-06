Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2581CC3ABBC
	for <qemu-devel@archiver.kernel.org>; Tue,  6 May 2025 17:35:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCMBd-0004tb-Kx; Tue, 06 May 2025 13:34:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jonwilson030981@googlemail.com>)
 id 1uCMBZ-0004qQ-6g
 for qemu-devel@nongnu.org; Tue, 06 May 2025 13:34:29 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jonwilson030981@googlemail.com>)
 id 1uCMBW-0001LV-Sz
 for qemu-devel@nongnu.org; Tue, 06 May 2025 13:34:28 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43d0359b1fcso835235e9.0
 for <qemu-devel@nongnu.org>; Tue, 06 May 2025 10:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=googlemail.com; s=20230601; t=1746552864; x=1747157664; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GGNEaRzmX7TwlAKBc+YmJmtRj/7EV7fnvkYFDLnHgmM=;
 b=U3uA/8fWqGxtuL8BB0gs5EWCKTWZhupoRHzIrm32tfXIyxOuEtIJk/XrXRnmVLK7Dp
 PhMNSEPU1V/rAnvECPYLN/ecMbD1pUHr2j6sa3bszy3OwnXmiQS9+S/3lW52kclItWMJ
 lEGuGvSbIc+Qsm4KnkR6rR/8NaXh78dcCde1JD30TGF7y7VHP+t0o/ujlAu4JMmdEMrO
 yQhSwomTJRa2I8JDyNBCfd4XFKFMz5R0sDCrg40tL3V4V42sCX9CwWqF6x1o5vEGIgrg
 6w+5IOgOo1p4l8OCz+8LM/2FPxKiZdR6EQILlE2PsoA5GolJpR3kcciiDb53ncwU+IiN
 erNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746552864; x=1747157664;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GGNEaRzmX7TwlAKBc+YmJmtRj/7EV7fnvkYFDLnHgmM=;
 b=uZgwZz/vMXFfbXmpOj+flPaKu0+6UE76BevcYuEhmfLhnMQ3gzAq9p2CKdzEqFxvrV
 9d33tNTc+VlqvrHCIRzUXVN1DWCnHnl9GIrpFT1jfRitrsKC862/LyDZaCydL4umDHjE
 CKiqiUgnWCDcdUTjcX8y9lEowWzTRADPiD/XH1WnSx5Y/USu00DRSexcIrIn8tE4L2jk
 1KFTqaw3zOn6qiDKKR8FI82oaVB23e/YbkLLdfMUNDPrqMLlFeKABrTJ+7aFoReLJQsJ
 UqRi0j/3sGeItz+yU1D5tZGA6djoOqaH9JPRNoV6gMlC24l4HcoCrixwg0+cvFsdTg5v
 UpUA==
X-Gm-Message-State: AOJu0YzXvAoq9c4yRhFdTnURdciivYxMXWrSbwmymPaNnfBSljnFW5EG
 uSK7liMh1iwOyljZ9g49uc5oCMDlSdKvfqn6PcywrKigu/3+wG6zU60dCbCmavs=
X-Gm-Gg: ASbGncuN1EMWclldE/PMFkvH/YRyBu0Ska3wvfqXoorZtIJUEq6AAvQv5s5Iw93BybL
 +zzEbVRLz9mDnJ8Bd92La0rO8hXSNAVKGgw2fRQupfzTyYvh3MdBY7F+rE6oJseaNFikZQrb6xO
 9ygtoLVd0/nTv+dpHhz0SiwFD4t5rFmhbEm+PpGNH0qlakwXgO2vhbdhreR4JYoeJ55vj/Pt5QV
 fjRiFs7WzPhH0RnWzkVByGamlzStG4ePQC7wUqhsmxf276cFaBLpI/f3aRESxi8x2C/cq2zshzC
 7WoBl1aX2YzbGmoXft3AEvPbmwpfpUENgSLAHfo9Ogl3S1rrWNHLZIgoPjorBwIAVXxaq0p0qRf
 6ZN3kYqDrx+A=
X-Google-Smtp-Source: AGHT+IEKPdJ0xIuFdLe/TU9aF0LFrKP5Uj/ohpSH430qi8XlFdcyTknoxnpaueopNf7Qd1eghC6WEA==
X-Received: by 2002:a7b:cbd3:0:b0:43d:174:2668 with SMTP id
 5b1f17b1804b1-441d39e27b4mr5745475e9.0.1746552863723; 
 Tue, 06 May 2025 10:34:23 -0700 (PDT)
Received: from outlast.lan (97e5422b.skybroadband.com. [151.229.66.43])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-441d434650bsm804115e9.13.2025.05.06.10.34.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 May 2025 10:34:23 -0700 (PDT)
From: Jon Wilson <jonwilson030981@googlemail.com>
X-Google-Original-From: Jon Wilson <jonwilson030981@gmail.com>
To: qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Jon Wilson <jonwilson030981@gmail.com>
Subject: [PATCH v4] Support madvise(MADV_DONTDUMP) when creating core dumps
 for qemu-user
Date: Tue,  6 May 2025 18:34:22 +0100
Message-ID: <20250506173423.1312788-1-jonwilson030981@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=jonwilson030981@googlemail.com; helo=mail-wm1-x32d.google.com
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

When running applications which make large (sparsely populated) address ranges
(e.g. when using address sanitizer with LibAFL) the inability to exclude these
regions from any core dump can result in very large files which fill the disk.
A coredump is obvously very useful for performing a post-mortem when fuzzing.

Whilst the man pages state that madvise provides only a hint (and hence can be
ignored), this patch adds support to handle MADV_DONTDUMP and set a
corresponding flag in the page flags, thus allowing QEMU to exclude these
regions from the core file.

Signed-off-by: Jon Wilson <jonwilson030981@gmail.com>
---
 include/exec/page-protection.h |  6 ++++++
 linux-user/elfload.c           |  4 ++++
 linux-user/mmap.c              | 18 ++++++++++++++++++
 3 files changed, 28 insertions(+)

diff --git a/include/exec/page-protection.h b/include/exec/page-protection.h
index c43231af8b..f8826d917e 100644
--- a/include/exec/page-protection.h
+++ b/include/exec/page-protection.h
@@ -38,4 +38,10 @@
  */
 #define PAGE_PASSTHROUGH 0x0800
 
+/*
+ * For linux-user, indicates that the page should not be included in a core 
+ * dump.
+ */
+#define PAGE_DONTDUMP   0x1000
+
 #endif
diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index fbfdec2f17..41c46da055 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -4067,6 +4067,10 @@ static size_t vma_dump_size(target_ulong start, target_ulong end,
         return 0;
     }
 
+    if (flags & PAGE_DONTDUMP) {
+        return 0;
+    }
+
     /*
      * Usually we don't dump executable pages as they contain
      * non-writable code that debugger can read directly from
diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index f88a80c31e..016063a8cf 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1247,6 +1247,24 @@ abi_long target_madvise(abi_ulong start, abi_ulong len_in, int advice)
      */
     mmap_lock();
     switch (advice) {
+    case MADV_DONTDUMP:
+        if (len > 0) {
+            /*
+             * To set the page permissons, we must OR our new flags with the
+             * existing flags. Only mark the pages as PAGE_DONTDUMP if the
+             * entire range has the same flags. If any part of the range
+             * differs, we would need to process it one page at a time which
+             * might not be very performant. Since we are not obliged to respect
+             * this flag, we will support it for the most likely usage scenario.
+             * Note that we don't set PAGE_ANON, since this can only be set with
+             * new mappings.
+             */
+            int flg = page_get_flags(start);
+            if (page_check_range(start, len, flg)) {
+                page_set_flags(start, start + len - 1, PAGE_DONTDUMP | (flg & ~PAGE_ANON) );
+            }
+        }
+        break;
     case MADV_WIPEONFORK:
     case MADV_KEEPONFORK:
         ret = -EINVAL;
-- 
2.43.0


