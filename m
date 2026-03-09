Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 615BCFCC9A2
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 23:36:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzk93-00022c-Jr; Mon, 09 Mar 2026 19:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <razvanghiorghe16@gmail.com>)
 id 1vzk91-00022G-PL
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 19:36:15 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <razvanghiorghe16@gmail.com>)
 id 1vzk90-0001IY-1B
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 19:36:15 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4838c15e3cbso111822245e9.3
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 16:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1773099372; x=1773704172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KS+OrrEVus7ZAUGKXWo85JJy5YO5Cwlo+UiFdEN5BXo=;
 b=fuLscYM+/LP61FllFIzHECFNdJJQznTwtSp4HDzZ0rnUFd92TUqvoKq1lcArLEWvFl
 j7jxvLN3of9emk/0K7GPhWo9uGhOf8XuFoYUkoGJ/9eOJ3Wiy7Y5h9/nrBbEVYWyrArk
 FwVqbbwHB/qPhc98U5ZAxiMZWI/Js9rXlSi9H9BH7poWVlb+cHyjtQyjbxeCgTxSDckO
 xR2k1OgTR2kuWhVMByB7929ECYAfhRuR0ZsgfF4ZttmFuKvr8umS9fOakbWzBBy3917e
 PVwus61YzniODw4JkT8P36VsTgcz9sbEG3fnaa2mu37NjK2s72ZGSHkY04nqvuNHEDrx
 23fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773099372; x=1773704172;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=KS+OrrEVus7ZAUGKXWo85JJy5YO5Cwlo+UiFdEN5BXo=;
 b=fw5FbUJ1KLg2Ewn5BzozIGmLDYTT/MpdhW8ITv4rCG5pGEfAomD5yzzkWJqyES+58B
 H5ufC4WQEPB2I23SZ4wSyRWsD2qKeY7c6gEqxXbKIHCHTiVRPkpsySF7+7DJ9bwv1+PI
 NpSJvQhNRQqXR8Jrlg/ifv1SI5sJVTMEudc77zWx4PoedzBvTQf8MII4rtS/2BI2IETZ
 9luFPqA55IE7WSyvJAccX5K98IYoXq9SmFY1tPnJRir0wnu9j74qdQzj4qg3XsmNc1QP
 6k7VMQGKwGWaMIiEC5SWQvaSTrA7ZPPABX7cLdYQRJ+bBwrCE/F+ThSuTkc+W92Vw3Op
 DDvA==
X-Gm-Message-State: AOJu0YzHbncL5xBfzpUNLYrMeZgPfi+abCUKF61xhFKyLk6ProwxhQ7v
 ZgJ1Wn184f5leY0h/AV1sFLaTATL3Nh6D5+GTnve0sN5LDg15f+sjyOeAEvKEHI1
X-Gm-Gg: ATEYQzz7kc0uZbsnQ3/eOqJf0HYKYO7RRwNuUsltJR/hrJV4VltaNjhycNWq1Eh+/Xw
 iUzY14IsD8emmYU9bmkja+8cuKQZMEsaJ0GfViTuZDxQm6NGHO4cmO8uemJ3fNlc+WA8BMaG0fD
 n80Ud4+DM1sHiODfg6slIbVy6MZRbIt5It6YcAiTmIK7RhpdhTwVni6WHrtCl63HU+s7KCA7Gj8
 U46Hq3wmO+joUVNbBzkRuII8J2JtIm87VIRmJpSaRWUSqx/93CB4nxFBOdUUY+uLKYPT2MU53rx
 dTZlBZm+oTy1AQD8PJAHzWMarZy1sb7Av2V5mUFaGWjJwqcyFXF8si+w4qmfP0OhXlqx6OMd4Y6
 L/Twf3GakARo42SQZO3yDOEPTy5Qk9miSpk79VpaTclmr7TONlkCaP2Q6ygsOjpVpx9X58ZVt/v
 9eBZM8yVvWF4cY308GskT9WnEHITUErLKL9JZtH2ZbKaKgUmmr3o0=
X-Received: by 2002:a05:600c:3f0b:b0:485:3bb5:92c5 with SMTP id
 5b1f17b1804b1-4853bb598e8mr72715775e9.14.1773099371470; 
 Mon, 09 Mar 2026 16:36:11 -0700 (PDT)
Received: from localhost.localdomain ([92.180.8.65])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541a8f610sm45478985e9.7.2026.03.09.16.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 16:36:11 -0700 (PDT)
From: Razvan Ghiorghe <razvanghiorghe16@gmail.com>
To: qemu-devel@nongnu.org
Cc: helge.deller@gmx.de, laurent@vivier.eu,
 Razvan Ghiorghe <razvanghiorghe16@gmail.com>
Subject: [PATCH v3] linux-user: fix mremap with old_size=0 for shared mappings
Date: Tue, 10 Mar 2026 01:30:32 +0200
Message-ID: <20260309233352.20760-1-razvanghiorghe16@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <edf2a69e-810f-4555-bb0b-e476296377fd@gmx.de>
References: <edf2a69e-810f-4555-bb0b-e476296377fd@gmx.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=razvanghiorghe16@gmail.com; helo=mail-wm1-x332.google.com
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

When old_size is zero and old_address refers to a shareable mapping,
mremap() should create a new mapping of the same pages according to the
mremap(2) man page. The MREMAP_MAYMOVE flag must be specified in this case.

Previously, QEMU's target_mremap() rejected this valid case with EFAULT
during the initial validation, before checking for the special
old_size == 0 behaviour.

This patch adds proper handling for old_size == 0:
- Validates that MREMAP_MAYMOVE flag is set (required by man spec)
- Passes the call through to the host mremap()
- Creates a new mapping without invalidating the original, with both
  being valid and sharing the same physical memory frames.
- Ensures the new mapping address falls within the valid guest address
  region before returning it to the guest.

Tested with the reproducer from the issue on qemu-riscv64, qemu-hppa,
and qemu-aarch64.
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3105
Signed-off-by: Razvan Ghiorghe <razvanghiorghe16@gmail.com>

Hi  Heldge,
Thank you for testing and detailed feedback!
V3 fixes h2g_valid assertion failure on hppa by using mmap_find_vma()
to ensure the new mapping stays within the valid guest adress region

Tested on qemu-riscv64, qemu-hppa and qemu-aarch64.

---
 linux-user/mmap.c | 52 +++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 52 insertions(+)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 07175e11d5..b41308840a 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1117,6 +1117,58 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
         errno = EINVAL;
         return -1;
     }
+
+    if (!old_size) {
+        if (!(flags & MREMAP_MAYMOVE)) {
+            errno = EINVAL;
+            return -1;
+        }
+        mmap_lock();
+        if (flags & MREMAP_FIXED) {
+            host_addr = mremap(g2h_untagged(old_addr), old_size, new_size,
+                             flags, g2h_untagged(new_addr));
+        } else {
+            /*
+             * We ensure that the new mapping stands in the
+             * region of guest mappable addresses.
+             */
+            abi_ulong mmap_start;
+
+            mmap_start = mmap_find_vma(0, new_size, TARGET_PAGE_SIZE);
+
+            if (mmap_start == -1) {
+                errno = ENOMEM;
+                mmap_unlock();
+                return -1;
+            }
+
+            host_addr = mremap(g2h_untagged(old_addr), old_size, new_size,
+                             flags | MREMAP_FIXED, g2h_untagged(mmap_start));
+
+            new_addr = mmap_start;
+        }
+        
+        if (host_addr == MAP_FAILED) {
+            mmap_unlock();
+            return -1;
+        }
+
+        if (flags & MREMAP_FIXED) {
+            new_addr = h2g(host_addr);
+        }
+
+        prot = page_get_flags(old_addr);
+        /*
+         * For old_size zero, there is nothing to clear at old_addr.
+         * Only set the flags for the new mapping. They both are valid.
+         */
+        page_set_flags(new_addr, new_addr + new_size - 1,
+                       prot | PAGE_VALID, PAGE_VALID);
+        shm_region_rm_complete(new_addr, new_addr + new_size - 1);
+        mmap_unlock();
+        return new_addr;
+    }
+
     if (!guest_range_valid_untagged(old_addr, old_size)) {
         errno = EFAULT;
         return -1;
-- 
2.43.0


