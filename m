Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2834EC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 23:59:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sa29p-0002Le-HP; Fri, 02 Aug 2024 19:58:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sa29o-0002Fm-56
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:58:00 -0400
Received: from mail-io1-xd2c.google.com ([2607:f8b0:4864:20::d2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <imp@bsdimp.com>) id 1sa29m-0004Kz-7o
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 19:57:59 -0400
Received: by mail-io1-xd2c.google.com with SMTP id
 ca18e2360f4ac-81fd520fee5so57865339f.2
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 16:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bsdimp-com.20230601.gappssmtp.com; s=20230601; t=1722643076; x=1723247876;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g3kDJhuVOCuA9YqIFpqwx9TDE8LgGOs4efk+QHLf3Y4=;
 b=BE+MpRiwRcM4QOanS7lGaJDEZtqKGsYRIQWOdNm/MFsOfS0BRuo0vj7hqDocFoR/CT
 LxtP8azy8sBFQY5fPQ/eb8sGWt4BSgGUIfLb6MyRlol/SLdRm+6YxyN4B1xCtso18Dov
 K8D/Vf0ScqVOJphU76Fag7/iHWY0fRLPTJYYjLXYA9gATbgOIlnh4ye5xZ3vGDywWtq7
 EoU2o/T5DEswQOyQTuvr0Xzh1pnSMNztPHN2JceIPxG6A++XjfFxplVFMRStrvg6Ztsm
 HNHjPhQu0va8oVHsmP5WZYKZqZynRRLc12C4RFXOFCay+PXGSQU9QKNX/lH2vfi9PsK7
 9zDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722643076; x=1723247876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g3kDJhuVOCuA9YqIFpqwx9TDE8LgGOs4efk+QHLf3Y4=;
 b=SiDMu4uJ0uQHYtUc8jb3AGJieEVZEF4V1N20RXE1v5I4sqoxqNct7ktfeBlnzbbZYB
 XktW9WYhCXJMnrZHTWuljFN74+YPdU3crnqpkTHWrQTKz8PPpJgloLWV5WrR3RZH7+bI
 87fyhx1i+TbnWePgmQmreJELnOb+XzfjuWSuro63oVgy2XqwtGoe8DE4ZYEEdOZ48ZVd
 NFqPjYrYqb7w/1/VX5wmuoiMnPBfttW7KIHbG4ygQBku1VuZrAb6BHF08nxiXBJZqS7h
 pCOgWBonnRYOcLqcs7cJGRzvQM+Nv/Gn9W2toE1xIoiYFy+GRzYnUuhQef08cF5+82Bu
 CbGg==
X-Gm-Message-State: AOJu0Yy2Y6WlYbEDLoMab25dmDGjvPpTyNp4NgajjPVAIUtSdG/iqBqv
 T1sPzIRSf1dLJ8GLW5py7egga8QLb8AhOdf10BN0FHD498QtSgDdm60JWQ++vEUWr3+yGTYxcCr
 DE/M=
X-Google-Smtp-Source: AGHT+IELASuw97UAzcir4BinQoP3HvesnqYEnH2VyaF/0j3lz2iudTNLtU7/pPm3syqcaltgUWIGAw==
X-Received: by 2002:a05:6602:3fcb:b0:81e:23e8:8d4 with SMTP id
 ca18e2360f4ac-81fd435b40bmr628481439f.6.1722643076330; 
 Fri, 02 Aug 2024 16:57:56 -0700 (PDT)
Received: from dune.bsdimp.com ([50.253.99.174])
 by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4c8d69a8227sm683131173.47.2024.08.02.16.57.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Aug 2024 16:57:55 -0700 (PDT)
From: Warner Losh <imp@bsdimp.com>
To: qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>,
 Jessica Clarke <jrtc27@jrtc27.com>
Subject: [PATCH 16/17] bsd-user: Define validate_prot_to_pageflags and use in
 mprotect
Date: Fri,  2 Aug 2024 17:56:16 -0600
Message-ID: <20240802235617.7971-17-imp@bsdimp.com>
X-Mailer: git-send-email 2.45.1
In-Reply-To: <20240802235617.7971-1-imp@bsdimp.com>
References: <20240802235617.7971-1-imp@bsdimp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::d2c;
 envelope-from=imp@bsdimp.com; helo=mail-io1-xd2c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

Define validate_prot_to_pageflags. Use it in target_mprotect to validate
the flags. Our taraget_mmap needs more work before it can be used there,
do don't copy linux-user's use of it there. This should hvae no net
functional change, but does make target_mprotect more similar to
linux-user's.

Signed-off-by: Warner Losh <imp@bsdimp.com>
---
 bsd-user/mmap.c | 28 +++++++++++++++++++++++-----
 1 file changed, 23 insertions(+), 5 deletions(-)

diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index ffecf52a72a..3c48a188e88 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -60,12 +60,26 @@ void mmap_fork_end(int child)
         pthread_mutex_unlock(&mmap_mutex);
 }
 
+/*
+ * Validate target prot bitmask.
+ * Return the prot bitmask for the host in *HOST_PROT.
+ * Return 0 if the target prot bitmask is invalid, otherwise
+ * the internal qemu page_flags (which will include PAGE_VALID).
+ */
+static int validate_prot_to_pageflags(int prot)
+{
+    int valid = PROT_READ | PROT_WRITE | PROT_EXEC;
+    int page_flags = (prot & PAGE_RWX) | PAGE_VALID;
+
+    return prot & ~valid ? 0 : page_flags;
+}
+
 /* NOTE: all the constants are the HOST ones, but addresses are target. */
 int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
 {
     int host_page_size = qemu_real_host_page_size();
     abi_ulong end, host_start, host_end, addr;
-    int prot1, ret;
+    int prot1, ret, page_flags;
 
     qemu_log_mask(CPU_LOG_PAGE, "mprotect: start=0x" TARGET_ABI_FMT_lx
                   " len=0x" TARGET_ABI_FMT_lx " prot=%c%c%c\n", start, len,
@@ -74,14 +88,18 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
                   target_prot & PROT_EXEC ? 'x' : '-');
     if ((start & ~TARGET_PAGE_MASK) != 0)
         return -EINVAL;
+    page_flags = validate_prot_to_pageflags(target_prot);
+    if (!page_flags) {
+        return -TARGET_EINVAL;
+    }
     len = TARGET_PAGE_ALIGN(len);
+    if (len == 0)
+        return 0;
     if (!guest_range_valid_untagged(start, len)) {
         return -ENOMEM;
     }
-    end = start + len;
     target_prot &= PROT_READ | PROT_WRITE | PROT_EXEC;
-    if (len == 0)
-        return 0;
+    end = start + len;
 
     mmap_lock();
     host_start = start & -host_page_size;
@@ -122,7 +140,7 @@ int target_mprotect(abi_ulong start, abi_ulong len, int target_prot)
         if (ret != 0)
             goto error;
     }
-    page_set_flags(start, start + len - 1, target_prot | PAGE_VALID);
+    page_set_flags(start, start + len - 1, page_flags);
     mmap_unlock();
     return 0;
 error:
-- 
2.45.1


