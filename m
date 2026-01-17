Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4237AC98327
	for <qemu-devel@archiver.kernel.org>; Sat, 17 Jan 2026 15:08:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vh7tu-0007nF-83; Sat, 17 Jan 2026 10:07:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <razvanghiorghe16@gmail.com>)
 id 1vgyRg-0003bx-DY
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 00:01:56 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <razvanghiorghe16@gmail.com>)
 id 1vgyRe-0007Pq-5k
 for qemu-devel@nongnu.org; Sat, 17 Jan 2026 00:01:56 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-47ee4539adfso22778755e9.3
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 21:01:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768626111; x=1769230911; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=D4B6UL9XHt4lGntL3nn7vKSx7UvKttOAJiq3eJbr1dk=;
 b=aAV+t9i5I0UpQNCTdVlsBv3JnsbjaU/DkRDGQe35yrTQNfDWaQwHEsFOK5EBGEQP5i
 ijArvTXOcshKjCUUp1NTAHNa5WQMMlLtigxEfl7XCMUBufa/tUhFD/mPVOdh0A+Hypou
 w6AERvXyoJrs0+eWyOTF90RccDfD+v5/qz2Xh/qUV6OXgTTvG4ZAV6FzqBk0KCU2D/wL
 rnTyeao7xWgwYDIyKFz51GOP6cqq8WaTYZlEXtALLdEiw9idkK2KGQwpT3leNwGLVnih
 8FenvS1tTOFhhZ/fLCJYFd0BUtAOF9cSFKTf8n01RHMmtG7HhKIrHZzFK5dTl+wtcXXO
 mmRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768626111; x=1769230911;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=D4B6UL9XHt4lGntL3nn7vKSx7UvKttOAJiq3eJbr1dk=;
 b=vx1DDXuKKG0YoxTD72k3W/5dH3wwciTcaR336xOk1NvAKIADpG/Gr1Bce99El7pi1a
 TIWhDIxEhZHLgx2r8K4fJPgZNmZEqNEGSwsqjyQ00QxH0NK3iq7Q4fz8DcjD5bRjb4H9
 bzplGB8Usw0Lu9P8/kxC1uS293I3JpwDXI6JYexb4BP6X49+6w4zgnwV+Qdiun++cQWc
 AZFuZWi1zwwPLSmTivCNSQGZp45DG1vuedglPeYYE9XlQRu/QSMGbc+K7X6DAjph1qp6
 jnlVuaV16buF44d4Q6FQ/4Ano1qeDowg0jy0/YqcBNiF7J90yNFJlGOJw1Qt1W19eieM
 zNEw==
X-Gm-Message-State: AOJu0YwLH1lMm1AqjHjK9JVCSijhpIuYSQh3uFG/+L3eIcsk5YE2wnQ0
 zcJi8GJEuuvjUY5cfH17wCU6RkBzO8frr5qAemAmXz8HFIx/E4LoK8uIF6luzw==
X-Gm-Gg: AY/fxX4lfnEhkA/eWK/WrnpCymAuYka6HYZUC8pOdNRI/EZ/n2oG1rvsKveSvqWTJjw
 OU3bgEesTwscMo8qJ5dXDq8wj6r11Cb6A/2buLu9i+MyNDwY/H6rFpYR6BYDeXBffvPOsW9MgXc
 KYXU5Q3Xj/RzT0BcB4N1TmOjR6hsCs+1xhPQ6k1+17/9ei0pqVV03LOcqDk+JRCJfVPyZwtNExG
 6AWnV4/SYK3yAOvb67byTh2FERAFt9E9nc/0fEF5uvd94vJnF1Dw4TYLoOuv1r/TXr5NlNGqSGM
 XhS9sc5k37i3SSfzCeq3/CXJ18jdUO4T5CbqFmj2LVZgkJnMYzGTGinf26sZqCU67jbG5H4xd/j
 zyu1x8VXNiOZUFtTiqVAS2CkD8KOX2fyS9lLa6nbL7IsSCn7eveHJcfgMMKkkvS7rZXXhcybmJo
 iVrg0RhsG2oHpAmFIHVQQoNwqJFiotvK5QFA==
X-Received: by 2002:a05:600c:628c:b0:47d:403e:9cd5 with SMTP id
 5b1f17b1804b1-4801e30b6ffmr51141055e9.11.1768626110426; 
 Fri, 16 Jan 2026 21:01:50 -0800 (PST)
Received: from localhost.localdomain ([128.127.123.191])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4801e8c9cbcsm74669665e9.12.2026.01.16.21.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 21:01:50 -0800 (PST)
From: Razvan Ghiorghe <razvanghiorghe16@gmail.com>
To: qemu-devel@nongnu.org
Cc: laurent@vivier.eu,
	Razvan Ghiorghe <razvanghiorghe16@gmail.com>
Subject: [PATCH] linux-user: Fix mremap() with old_size == 0
Date: Sat, 17 Jan 2026 07:00:49 +0200
Message-ID: <20260117050049.24057-1-razvanghiorghe16@gmail.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=razvanghiorghe16@gmail.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Sat, 17 Jan 2026 10:07:39 -0500
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
Previously, QEMU's target_mremap() rejected this valid case with EFAULT during
the initial validation, before checking for the special old_size == 0 behaviour.

This patch adds proper handling for old_size == 0:
- Validates that MREMAP_MAYMOVE flag is set (required by man spec)
- Passes the call through to the host mremap()
- Creates a new mapping without invalidating the original, with both
beeing valid and sharing the same physical memory frames.

Tested with the reproducer from the issue on qemu-riscv64.
Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3105
Signed-off-by: Razvan Ghiorghe <razvanghiorghe16@gmail.com>
---
 linux-user/mmap.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/linux-user/mmap.c b/linux-user/mmap.c
index 4bcfaf7894..08de949f06 100644
--- a/linux-user/mmap.c
+++ b/linux-user/mmap.c
@@ -1117,6 +1117,38 @@ abi_long target_mremap(abi_ulong old_addr, abi_ulong old_size,
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
+            host_addr = mremap(g2h_untagged(old_addr), old_size, new_size,
+                             flags);
+        }
+        
+        if (host_addr == MAP_FAILED) {
+            mmap_unlock();
+            return -1;
+        }
+        new_addr = h2g(host_addr);
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


