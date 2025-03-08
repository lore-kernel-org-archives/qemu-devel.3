Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2EB2C282EC
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Mar 2025 12:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqtIv-0006d2-NV; Sat, 08 Mar 2025 07:29:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqtIa-0006T9-K9
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 07:29:13 -0500
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tqtIX-0002B6-NE
 for qemu-devel@nongnu.org; Sat, 08 Mar 2025 07:28:59 -0500
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso941115e9.3
 for <qemu-devel@nongnu.org>; Sat, 08 Mar 2025 04:28:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741436935; x=1742041735; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iYxfjuJgdCGSXC8a1k7IDwhqReMpmbHRqmDmJU5MeDM=;
 b=X0FS5IKpyobnJd/O79kHN9BFt8Pc4KVnEcci74kq/xKzR2Of5m7dNJ+T/7yc+AEDYb
 6AaggwWWED7DU596zpj2mWuICAAZuC+rkxT9Ui38Lxz17FjLCXR3LK1KNMk0U12+NvC/
 OWLWuuX+izOeKywQyCmmBdbG1liTvou+3Y4QAh0i16ENQxiHKOTQB7IPj3/N9ZqINLig
 gY3203hL+3F5F6m25Q4bs2JeuT3VhOtM5Y1yy3VDy8aEQ3FWmP/xoFjfbeoOMGxqkFFL
 5CMWbkYO8LbWhJInqlyu7Vq3/5xDvw1cA33hwWz91u3yz5SbDdYZtXusp/qaAkmy8TEY
 x6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741436935; x=1742041735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iYxfjuJgdCGSXC8a1k7IDwhqReMpmbHRqmDmJU5MeDM=;
 b=WfE4gfq7theYE6zMeCcBP3yhcmLWEN1q8EUAftIpiuUhsomz37o0b/KKJKHo2sCCjH
 +lucskIRIlEvbZPO33YXPAIC1gdaHW188HA5USwiYtKTPdVm/JKDa6QL+jDwB7x9IQZ/
 35vlrJcof9SqS+X+5AHLGJMOjSq/l9tEJMNHCFCEDD4otIVDYdR2wOtbpMdVb95ngDV8
 DqurYbbZKIT9YgUS69Mdn4LTYC6oVEj2f3S2DG0KjFYI1Uqj8E3yaO1ceLGXNgNqTR5c
 FW+oCRDrHgtFDN0H6ZqVKLi94sFJ2NCLoLySzAaW/I4EvhrPU54a2VTB6qLt/t+Cb33w
 Mbug==
X-Gm-Message-State: AOJu0YycmrdnhHS3NLmkZ9VkQFkKGZuUL2rncv/aVG8QIyx0yl0iYsi/
 qB+kZGhfOsxBGcGAhcRa5OK3QQ18QEQqfiBPNlmsA5J/DpkuATwIBgfXK3Vu8tkLnzZI40++cqE
 JAjY=
X-Gm-Gg: ASbGncsXmCNa9R0iy5O0Qn/KyX3Oqh9NGTsD315Igh3O1xOLPCX/yWsJ/UYhk7zKa4O
 HUX0y0bBrLFIjszV9vfMuAH/Td8p3RXd7Dm9qClf5gjwDqkRft5EzKa3xbVyA+X8ru2EF2EZtTS
 h6/ZDkRWzP5G2UGIVhk48l8RfRpjksCOEceDrFNtvTY66XEMcQyIXGhLsOorc1WOkr6ZViuEQa2
 +UA0R1SRNjVgNhcqV3CXvHQv7F/rpOHvG3tlfMIWvW7NzhJkxgF/DmHfJ4JmrBv5SI4EAGZ9tZh
 ye7J4mnwKGPI1ptMJ9axfXZzEe20stma8zN96V24JsxuFPZd5hAODOx7NTj+rfbQgVrqUsB6nCP
 QM3HsuR6+uFl19ePhNFM=
X-Google-Smtp-Source: AGHT+IEmFsZw6Qqr4oEJ4X8s3rKTt8RfNHu/+6/qLH6gJFS/eI/U1mj9s1HeLcY4orNJzLhuwkaXnw==
X-Received: by 2002:a05:6000:156b:b0:38d:e304:7478 with SMTP id
 ffacd0b85a97d-39132dc56f2mr5155066f8f.38.1741436935200; 
 Sat, 08 Mar 2025 04:28:55 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3912c103f41sm8574514f8f.85.2025.03.08.04.28.53
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 08 Mar 2025 04:28:54 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>,
 Kyle Evans <kevans@freebsd.org>, Warner Losh <imp@bsdimp.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v4 2/3] bsd-user: Propagate alignment argument to
 mmap_find_vma()
Date: Sat,  8 Mar 2025 13:28:41 +0100
Message-ID: <20250308122842.76377-3-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250308122842.76377-1-philmd@linaro.org>
References: <20250308122842.76377-1-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Propagate the alignment to mmap_find_vma(), effectively
embedding mmap_find_vma_aligned() within mmap_find_vma().

Add a comment in do_bsd_shmat() to clarify alignment above
page size is not required.

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
---
 bsd-user/bsd-mem.h |  4 +++-
 bsd-user/qemu.h    |  2 +-
 bsd-user/mmap.c    | 10 ++--------
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/bsd-user/bsd-mem.h b/bsd-user/bsd-mem.h
index f5ec0de24ca..90ca0e33775 100644
--- a/bsd-user/bsd-mem.h
+++ b/bsd-user/bsd-mem.h
@@ -370,9 +370,11 @@ static inline abi_long do_bsd_shmat(int shmid, abi_ulong shmaddr, int shmflg)
         if (shmaddr) {
             host_raddr = shmat(shmid, (void *)g2h_untagged(shmaddr), shmflg);
         } else {
+            abi_ulong alignment;
             abi_ulong mmap_start;
 
-            mmap_start = mmap_find_vma(0, shm_info.shm_segsz);
+            alignment = 0; /* alignment above page size not required */
+            mmap_start = mmap_find_vma(0, shm_info.shm_segsz, alignment);
 
             if (mmap_start == -1) {
                 return -TARGET_ENOMEM;
diff --git a/bsd-user/qemu.h b/bsd-user/qemu.h
index 4e97c796318..0b3bd65b180 100644
--- a/bsd-user/qemu.h
+++ b/bsd-user/qemu.h
@@ -242,7 +242,7 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
                        abi_ulong new_addr);
 int target_msync(abi_ulong start, abi_ulong len, int flags);
 extern abi_ulong mmap_next_start;
-abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size);
+abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong alignment);
 void mmap_reserve(abi_ulong start, abi_ulong size);
 void TSA_NO_TSA mmap_fork_start(void);
 void TSA_NO_TSA mmap_fork_end(int child);
diff --git a/bsd-user/mmap.c b/bsd-user/mmap.c
index dfa6e728ab5..3f0df79c375 100644
--- a/bsd-user/mmap.c
+++ b/bsd-user/mmap.c
@@ -275,8 +275,7 @@ static abi_ulong mmap_find_vma_reserved(abi_ulong start, abi_ulong size,
  * It must be called with mmap_lock() held.
  * Return -1 if error.
  */
-static abi_ulong mmap_find_vma_aligned(abi_ulong start, abi_ulong size,
-                                       abi_ulong alignment)
+abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size, abi_ulong alignment)
 {
     void *ptr, *prev;
     abi_ulong addr;
@@ -395,11 +394,6 @@ static abi_ulong mmap_find_vma_aligned(abi_ulong start, abi_ulong size,
     }
 }
 
-abi_ulong mmap_find_vma(abi_ulong start, abi_ulong size)
-{
-    return mmap_find_vma_aligned(start, size, 0);
-}
-
 /* NOTE: all the constants are the HOST ones */
 abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
                      int flags, int fd, off_t offset)
@@ -494,7 +488,7 @@ abi_long target_mmap(abi_ulong start, abi_ulong len, int prot,
         host_len = len + offset - host_offset;
         host_len = HOST_PAGE_ALIGN(host_len);
         alignment = (flags & MAP_ALIGNMENT_MASK) >> MAP_ALIGNMENT_SHIFT;
-        start = mmap_find_vma_aligned(real_start, host_len, alignment);
+        start = mmap_find_vma(real_start, host_len, alignment);
         if (start == (abi_ulong)-1) {
             errno = ENOMEM;
             goto fail;
-- 
2.47.1


