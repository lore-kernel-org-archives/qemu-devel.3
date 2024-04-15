Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90916C00A94
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 16:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwOsl-0005aX-Dq; Mon, 15 Apr 2024 12:08:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1rwOsk-0005aO-2z
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 12:08:34 -0400
Received: from mail-qk1-x734.google.com ([2607:f8b0:4864:20::734])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1rwOsh-00073B-6z
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 12:08:33 -0400
Received: by mail-qk1-x734.google.com with SMTP id
 af79cd13be357-78edc3ad5fdso143379985a.0
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 09:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1713197309; x=1713802109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bKxn4zRRP0GuBodYPfxVKDxf/AVc0hWzzsTLBwSwSK0=;
 b=CB/Vg7Ps6l4ec2DpKGF3kQMFI+FVAmO1c07ZqP4RqNk2W52vI2QlJlEQUBT+zAV08I
 slNbTLeUpjuD+piDN/kxfswWePSOFj5Zlkq66rmvdxHjz7tAbZSXUOcZODJerf9Xi2/4
 aSB60Mm7mwSNSp3epCJSUwZvYYXW8k5D2p/vIsrHhdnyN1CGJl67xSNXhV6zOv6GTKeQ
 9Qo1VKvRE1Y3A5Xoc+xLIGCxtXLl6Aua/9pspUEazj9gESipynkJcm0zv6Id+aXDoxid
 ktV5QwgyptmtK3cARqqfeaojOsHPRhTyqms3jZ13AdXN+R2Dtde4UEexU4VgBAPdp/Gk
 BzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713197309; x=1713802109;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bKxn4zRRP0GuBodYPfxVKDxf/AVc0hWzzsTLBwSwSK0=;
 b=J7ipD6TWZlzYaeTRV6GNtlWv+bnda8HFc3ZhmFnaM/P2bcuMq3Yigvt6EIR11an7G7
 J6hqU4IJEBlU5ycz8uI77UREm/7B1GvqY/XXrmK+vUfJ8Kb1mDc1lhnypJ0o9QfESSQH
 iF0qCGysZNVYXuEhQP1k7Wt93/K7T5UE01vTYgsp94oGrvrl9tBzmPCbjNZ08KpzBBYU
 H/xwdaN5ACRirwUn8KYBXFwLx1OS9zpWhUQYptxCU/itlSatWFG+zDEwkZjDqRa16Z9r
 7WvP6O46KHZ+vjOTYCQZdZdAYoAqxspFi7/ggrUzWqjUiLgPG8Ps3i9QiuybsMoy9pgr
 Heig==
X-Gm-Message-State: AOJu0YwnYk6LLmFcXBmaMnOn3rKrmMIOL4/ar4dBhSm2mm3seto5t+t4
 sIKeUs7axB6ox8iNzxLZeGvHDVeVrmK0W/ef+5xwIXBtwOnovDQdi0ZWPUBGnlIDea9BvloJ8hr
 m/DjxeNkg35XTOuBOHrXPt9k8jyji+cgkq53sfpqzTDWJWDYZB0ZOVEO2tGf+OdygGiIyy3aTtQ
 uiimJ9N9KBdGvxbfGuV5hJjKZSm0xK
X-Google-Smtp-Source: AGHT+IGM3HwK96EL+ewxdJMiBI4LSJwliK4Vi2ZuBvpIHVYBB0hkxipzECsMfX2LPK0pUsUUNNiSkw==
X-Received: by 2002:a05:620a:4010:b0:78d:4596:b77f with SMTP id
 h16-20020a05620a401000b0078d4596b77fmr174474qko.18.1713197309238; 
 Mon, 15 Apr 2024 09:08:29 -0700 (PDT)
Received: from kermit.cs.unc.edu (kermit.cs.unc.edu. [152.2.133.133])
 by smtp.gmail.com with ESMTPSA id
 h7-20020a05620a21c700b0078d72553055sm6491341qka.11.2024.04.15.09.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 09:08:28 -0700 (PDT)
From: Don Porter <porter@cs.unc.edu>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, dave@treblig.org,
 Austin Clements <aclements@csail.mit.edu>,
 Geoffrey Thomas <geofft@ldpreload.com>, Don Porter <porter@cs.unc.edu>
Subject: [PATCH 1/2] monitor: Implement a generic x86 page table iterator
Date: Mon, 15 Apr 2024 12:08:17 -0400
Message-Id: <20240415160818.2316599-2-porter@cs.unc.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240415160818.2316599-1-porter@cs.unc.edu>
References: <20240415160818.2316599-1-porter@cs.unc.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::734;
 envelope-from=porter@cs.unc.edu; helo=mail-qk1-x734.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Austin Clements <aclements@csail.mit.edu>

This iterator provides a way to traverse 32-bit, PAE, and 64-bit page
tables by abstracting them as n-ary trees.  A struct describes the
full range of x86 page table layouts and the iterator builds on this
to provide a "successor" function for efficiently traversing the page
table tree.

This code is currently unused, but provides the groundwork for the
following "info pg" patch.  It could also be used to unify and
simplify the implementations of "info mem" and "info tlb".

Signed-off-by: Austin Clements <aclements@csail.mit.edu>
[geofft@ldpreload.com: Rebased on top of 2.9.0]
Signed-off-by: Geoffrey Thomas <geofft@ldpreload.com>
Signed-off-by: Don Porter <porter@cs.unc.edu>
---
 target/i386/monitor.c | 149 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 149 insertions(+)

diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 3a281dab02..7924de6520 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -34,6 +34,155 @@
 #include "qapi/qapi-commands-misc-target.h"
 #include "qapi/qapi-commands-misc.h"
 
+/**
+ * PTLayout describes the layout of an x86 page table in enough detail
+ * to fully decode up to a 4-level 64-bit page table tree.
+ */
+typedef struct PTLayout {
+    int levels, entsize;
+    int entries[4];             /* Entries in each table level */
+    int shift[4];               /* VA bit shift each each level */
+    bool pse[4];                /* Whether PSE bit is valid */
+    const char *names[4];
+    int vaw, paw;               /* VA and PA width in characters */
+} PTLayout;
+
+/**
+ * PTIter provides a generic way to traverse and decode an x86 page
+ * table tree.
+ */
+typedef struct PTIter {
+    const PTLayout *layout;
+    bool pse;                   /* PSE enabled */
+    int level;                  /* Current level */
+    int i[4];                   /* Index at each level */
+    hwaddr base[4];             /* Physical base pointer */
+
+    uint64_t ent;               /* Current entry */
+    bool present, leaf;
+    target_ulong va;
+    hwaddr pa;
+    target_ulong  size;
+} PTIter;
+
+static bool ptiter_succ(PTIter *it);
+
+/**
+ * Initialize a PTIter to point to the first entry of the page table's
+ * top level.  On failure, prints a message to mon and returns false.
+ */
+static bool
+__attribute__ ((unused))
+ptiter_init(Monitor *mon, PTIter *it)
+{
+    static const PTLayout l32 = {
+        2, 4, {1024, 1024}, {22, 12}, {1, 0}, {"PDE", "PTE"}, 8, 8
+    };
+    static const PTLayout lpae = {
+        3, 8, {4, 512, 512}, {30, 21, 12}, {0, 1, 0},
+        {"PDP", "PDE", "PTE"}, 8, 13
+    };
+#ifdef TARGET_X86_64
+    static const PTLayout l64 = {
+        4, 8, {512, 512, 512, 512}, {39, 30, 21, 12}, {0, 1, 1, 0},
+        {"PML4", "PDP", "PDE", "PTE"}, 12, 13
+    };
+#endif
+    CPUArchState *env;
+
+    env = mon_get_cpu_env(mon);
+
+    if (!(env->cr[0] & CR0_PG_MASK)) {
+        monitor_printf(mon, "PG disabled\n");
+        return false;
+    }
+
+    memset(it, 0, sizeof(*it));
+    if (env->cr[4] & CR4_PAE_MASK) {
+#ifdef TARGET_X86_64
+        if (env->hflags & HF_LMA_MASK) {
+            it->layout = &l64;
+            it->base[0] = env->cr[3] & 0x3fffffffff000ULL;
+        } else
+#endif
+        {
+            it->layout = &lpae;
+            it->base[0] = env->cr[3] & ~0x1f;
+        }
+        it->pse = true;
+    } else {
+        it->layout = &l32;
+        it->base[0] = env->cr[3] & ~0xfff;
+        it->pse = (env->cr[4] & CR4_PSE_MASK);
+    }
+
+    /* Trick ptiter_succ into doing the hard initialization. */
+    it->i[0] = -1;
+    it->leaf = true;
+    ptiter_succ(it);
+    return true;
+}
+
+/**
+ * Move a PTIter to the successor of the current entry.  Specifically:
+ * if the iterator points to a leaf, move to its next sibling, or to
+ * the next sibling of a parent if it has no more siblings.  If the
+ * iterator points to a non-leaf, move to its first child.  If there
+ * is no successor, return false.
+ *
+ * Note that the resulting entry may not be marked present, though
+ * non-present entries are always leafs (within a page
+ * table/directory/etc, this will always visit all entries).
+ */
+static bool ptiter_succ(PTIter *it)
+{
+    int i, l, entsize;
+    uint64_t ent64;
+    uint32_t ent32;
+    bool large;
+
+    if (it->level < 0) {
+        return false;
+    } else if (!it->leaf) {
+        /* Move to this entry's first child */
+        it->level++;
+        it->base[it->level] = it->pa;
+        it->i[it->level] = 0;
+    } else {
+        /* Move forward and, if we hit the end of this level, up */
+        while (++it->i[it->level] == it->layout->entries[it->level]) {
+            if (it->level-- == 0) {
+                /* We're out of page table */
+                return false;
+            }
+        }
+    }
+
+    /* Read this entry */
+    l = it->level;
+    entsize = it->layout->entsize;
+    cpu_physical_memory_read(it->base[l] + it->i[l] * entsize,
+                             entsize == 4 ? (void *)&ent32 : (void *)&ent64,
+                             entsize);
+    if (entsize == 4) {
+        it->ent = le32_to_cpu(ent32);
+    } else {
+        it->ent = le64_to_cpu(ent64);
+    }
+
+    /* Decode the entry */
+    large = (it->pse && it->layout->pse[l] && (it->ent & PG_PSE_MASK));
+    it->present = it->ent & PG_PRESENT_MASK;
+    it->leaf = (large || !it->present || ((l + 1) == it->layout->levels));
+    it->va = 0;
+    for (i = 0; i <= l; i++) {
+        it->va |= (uint64_t)it->i[i] << it->layout->shift[i];
+    }
+    it->pa = it->ent & (large ? 0x3ffffffffc000ULL : 0x3fffffffff000ULL);
+    it->size = 1 << it->layout->shift[l];
+    return true;
+}
+
 /* Perform linear address sign extension */
 static hwaddr addr_canonical(CPUArchState *env, hwaddr addr)
 {
-- 
2.25.1


