Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 539FEC3DA70
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 01:07:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sW3yj-00029Y-O5; Mon, 22 Jul 2024 21:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sW3yh-000220-Oz
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 21:06:07 -0400
Received: from mail-qt1-x830.google.com ([2607:f8b0:4864:20::830])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1sW3yd-0008Pr-6a
 for qemu-devel@nongnu.org; Mon, 22 Jul 2024 21:06:07 -0400
Received: by mail-qt1-x830.google.com with SMTP id
 d75a77b69052e-447eb65d366so26304771cf.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jul 2024 18:06:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1721696761; x=1722301561; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9/mdOQDY1ghGA+xvcmnOOxcVL1lDJZ6kJ8Mir8k5wNo=;
 b=OWdYg+a7c1ZnyxwE14LEer8eoftCJ5ywXuDe08/kkEhlTuYSpFWa/X0g4DAXoCB3HF
 B0CdV9NA2UglshxZ1gaTgZhAaX9gA+5tIqQNALfaBou9YAENccvbDiL9G5Q1WzaOYsv2
 5WlCe6zXBTCBu/CXJut/e+EacD6tTPQtn3n1raVFH0AK9cbfoheJTIG7BLsehN3VG3js
 a5UTm1HhgFSOxeCoqPmMfFaU6VMsq9zeynZ+6ZUBKQpfow5CgdOQ89xnjY3TKYyon/xy
 KXgFp5eAj//V92pMxHDhSLINCmPAhfZIU6JinWtrHiThVa34HbckQ5ro9g9lmubM2hX0
 f25Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721696761; x=1722301561;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9/mdOQDY1ghGA+xvcmnOOxcVL1lDJZ6kJ8Mir8k5wNo=;
 b=d3CjUfM0FhrB4HBGpRFsxiErnmfCTfcG2V7P5ihWbnLvGyvuP4PWyfgQLMudAEwMuG
 jzEICRyACcDxLShEyQG40oYMd5pS/g0KY1E1kgD3yfNnAwEaqFVzgPZW5KZ6Tea9NWuS
 clzTSiaP9oI5MjjgU2ImNQMl7Lc0kFSriMeq4Gihi//RF6DjDwlTK9/gzukKv4mbJ3nD
 ykAtC+RchVl78xt3ZEumIklf/1Wzt4liXzZvmYtOjpXQZ1MHTJGlqzxDzzA/s3jylfoO
 1PjgYYDwVclqj5ozjIiaYOmsdzhWt+ccCbx4bWikqA41NtbDSlgJjNy5IHxI9SJYK2Ax
 P/nA==
X-Gm-Message-State: AOJu0Yx6cc17hIc1cwDUoBqoARZK0qnlQ0jVhDnFVYK2Fn+4gkCBiqzB
 HVwWheY7nDeFO181E3eRr4dX16Zw7zE1wOZlCXtWM8+JYLdvZXnReJldjlS64k9KX14rPxJ6/xn
 cHENPntql/me8mNzBUKTEyCiPP+WtGjk6CUSk/JCQJHW2w+zh8LzFCbgJl/typCIhLEjCZEN5SU
 y22IEQnjpLzzdirN8VjCMaIwOgXnPb
X-Google-Smtp-Source: AGHT+IHs7/gQ/vGvFanyj7n8GXRPV68vkSI1w9WnogzkLSz999QKPZcoNI9j1nY9PvcX0oAU/cPmYA==
X-Received: by 2002:a05:622a:47:b0:447:e0e6:7787 with SMTP id
 d75a77b69052e-44fa538db17mr140672491cf.60.1721696760039; 
 Mon, 22 Jul 2024 18:06:00 -0700 (PDT)
Received: from kermit.cs.unc.edu (kermit.cs.unc.edu. [152.2.133.133])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44f9cdc0cbdsm37953601cf.92.2024.07.22.18.05.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jul 2024 18:05:59 -0700 (PDT)
From: Don Porter <porter@cs.unc.edu>
To: qemu-devel@nongnu.org
Cc: dave@treblig.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 richard.henderson@linaro.org, philmd@linaro.org, berrange@redhat.com,
 Don Porter <porter@cs.unc.edu>
Subject: [PATCH v4 3/7] Add an "info pg" command that prints the current page
 tables
Date: Mon, 22 Jul 2024 21:05:41 -0400
Message-Id: <20240723010545.3648706-4-porter@cs.unc.edu>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240723010545.3648706-1-porter@cs.unc.edu>
References: <20240723010545.3648706-1-porter@cs.unc.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::830;
 envelope-from=porter@cs.unc.edu; helo=mail-qt1-x830.google.com
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

The new "info pg" monitor command prints the current page table,
including virtual address ranges, flag bits, and snippets of physical
page numbers.  Completely filled regions of the page table with
compatible flags are "folded", with the result that the complete
output for a freshly booted x86-64 Linux VM can fit in a single
terminal window.  The output looks like this:

Info pg for CPU 0
VPN range             Entry         Flags            Physical page
[7f0000000-7f0000000] PML4[0fe]     ---DA--UWP
  [7f28c0000-7f28fffff]  PDP[0a3]     ---DA--UWP
    [7f28c4600-7f28c47ff]  PDE[023]     ---DA--UWP
      [7f28c4655-7f28c4656]  PTE[055-056] X--D---U-P 0000007f14-0000007f15
      [7f28c465b-7f28c465b]  PTE[05b]     ----A--U-P 0000001cfc
...
[ff8000000-ff8000000] PML4[1ff]     ---DA--UWP
  [ffff80000-ffffbffff]  PDP[1fe]     ---DA---WP
    [ffff81000-ffff81dff]  PDE[008-00e] -GSDA---WP 0000001000-0000001dff
  [ffffc0000-fffffffff]  PDP[1ff]     ---DA--UWP
    [ffffff400-ffffff5ff]  PDE[1fa]     ---DA--UWP
      [ffffff5fb-ffffff5fc]  PTE[1fb-1fc] XG-DACT-WP 00000fec00 00000fee00
    [ffffff600-ffffff7ff]  PDE[1fb]     ---DA--UWP
      [ffffff600-ffffff600]  PTE[000]     -G-DA--U-P 0000001467

This draws heavy inspiration from Austin Clements' original patch.

For nested paging, it does a recursive walk:

Info pg for CPU 0, guest mode
VPN range             Entry         Flags            Physical page(s)
[008000000-00fffffff] PML4[001]     -------UWP
  [008000000-00803ffff]  PDP[000]     -------UWP
    [008000800-0080009ff]  PDE[004]     -------UWP
      [008000800-00800085b]  PTE[000-05b] -------U-P 000000076a-00000007c5
    [008000a00-008000bff]  PDE[005]     -------UWP
      [008000a00-008000a0f]  PTE[000-00f] -------U-P 000000075a-0000000769
    [008003e00-008003fff]  PDE[01f]     -------UWP
      [008003fa8-008003fb7]  PTE[1a8-1b7] --------WP 000000054b-000000055a
      [008003fc0-008003fcf]  PTE[1c0-1cf] --------WP 000000053b-000000054a
      [008003fd8-008003fe7]  PTE[1d8-1e7] --------WP 000000052b-000000053a
      [008003ff0-008003fff]  PTE[1f0-1ff] --------WP 000000051b-000000052a
    [008004000-008004fff]  PDE[020-027] -------UWP
      [008004000-008004fff]  PTE[000-1ff] --------WP 0000000000-0000000fff
Info pg for CPU 0, host mode
VPN range             Entry         Flags            Physical page(s)
[000000000-007ffffff] PML4[000]     ----XWR
  [000000000-00003ffff]  PDP[000]     ----XWR
    [000000000-0000001ff]  PDE[000]     ----XWR
      [000000001-000000005]  PTE[001-005] ----XWR    0000001b24-0000001b28
      [000000006-000000006]  PTE[006]     ----XWR    0000001ab6
      [000000007-000000007]  PTE[007]     ----XWR    00000012ab
      [000000008-00000000e]  PTE[008-00e] ----XWR    0000001b29-0000001b2f
...

This also adds a generic page table walker, which other monitor
and execution commands will be migrated to in subsequent patches.

Finally, this patch adds some fields to the x86 architectural
state that are necessary to implement nested page table walks,
but are not standardized across acclerator back-ends.  Because I
cannot test on all of these accelerators, the goal of this patch
set is to detect if the accelerator and page table format
can be walked, and fail gracefully if not.

Signed-off-by: Don Porter <porter@cs.unc.edu>
---
 hmp-commands-info.hx              |  13 +
 hw/core/cpu-sysemu.c              | 168 ++++-
 hw/core/machine-qmp-cmds.c        | 243 ++++++++
 include/hw/core/cpu.h             |  78 ++-
 include/hw/core/sysemu-cpu-ops.h  | 138 ++++-
 include/monitor/hmp-target.h      |   1 +
 qapi/machine.json                 |  17 +
 system/memory_mapping.c           |   2 +-
 target/i386/arch_memory_mapping.c | 994 +++++++++++++++++++++++++++++-
 target/i386/cpu.c                 |  23 +-
 target/i386/cpu.h                 |  58 +-
 target/i386/kvm/kvm.c             |  68 ++
 target/i386/monitor.c             | 175 ++++++
 13 files changed, 1967 insertions(+), 11 deletions(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index c59cd6637b..8f178193e3 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -242,6 +242,19 @@ SRST
     Show memory tree.
 ERST
 
+    {
+        .name         = "pg",
+        .args_type    = "",
+        .params       = "",
+        .help         = "show the page table",
+        .cmd_info_hrt = qmp_x_query_pg,
+    },
+
+SRST
+  ``info pg``
+    Show the active page table.
+ERST
+
 #if defined(CONFIG_TCG)
     {
         .name       = "jit",
diff --git a/hw/core/cpu-sysemu.c b/hw/core/cpu-sysemu.c
index 2a9a2a4eb5..9d05e3e363 100644
--- a/hw/core/cpu-sysemu.c
+++ b/hw/core/cpu-sysemu.c
@@ -23,12 +23,12 @@
 #include "exec/tswap.h"
 #include "hw/core/sysemu-cpu-ops.h"
 
-bool cpu_paging_enabled(const CPUState *cpu)
+bool cpu_paging_enabled(const CPUState *cpu, int mmu_idx)
 {
     CPUClass *cc = CPU_GET_CLASS(cpu);
 
     if (cc->sysemu_ops->get_paging_enabled) {
-        return cc->sysemu_ops->get_paging_enabled(cpu);
+        return cc->sysemu_ops->get_paging_enabled(cpu, mmu_idx);
     }
 
     return false;
@@ -142,3 +142,167 @@ GuestPanicInformation *cpu_get_crash_info(CPUState *cpu)
     }
     return res;
 }
+
+/**
+ * for_each_pte_recursive - recursive helper function
+ *
+ * @cs - CPU state
+ * @fn(cs, data, pte, vaddr, height) - User-provided function to call on each
+ *                                     pte.
+ *   * @cs - pass through cs
+ *   * @data - user-provided, opaque pointer
+ *   * @pte - current pte
+ *   * @height - height in the tree of pte
+ *   * @layout- The layout of the radix tree
+ * @data - user-provided, opaque pointer, passed to fn()
+ * @visit_interior_nodes - if true, call fn() on page table entries in
+ *                         interior nodes.  If false, only call fn() on page
+ *                         table entries in leaves.
+ * @visit_not_present - if true, call fn() on entries that are not present.
+ *                         if false, visit only present entries.
+ * @visit_malformed - if true, call fn() on entries that are malformed (e.g.,
+ *                         bad reserved bits.  Even if true, will not follow
+ *                         a child pointer to another node.
+ * @node - The physical address of the current page table radix tree node
+ * @vaddr_in - The virtual address bits translated in walking the page
+ *          table to node
+ * @height - The height of the node in the radix tree
+ * @layout- The layout of the radix tree
+ * @mmu_idx - Which level of the mmu we are interested in:
+ *            0 == user mode, 1 == nested page table
+ *            Note that MMU_*_IDX macros are not consistent across
+ *            architectures.
+ *
+ * height starts at the max and counts down.
+ * In a 4 level x86 page table, pml4e is level 4, pdpe is level 3,
+ *  pde is level 2, and pte is level 1
+ *
+ * Returns true on success, false on error.
+ */
+static bool
+for_each_pte_recursive(CPUState *cs, qemu_page_walker_for_each fn, void *data,
+                       bool visit_interior_nodes, bool visit_not_present,
+                       bool visit_malformed, hwaddr node, vaddr vaddr_in,
+                       int height, const PageTableLayout *layout,
+                       int mmu_idx)
+{
+    int i;
+    CPUClass *cc = cs->cc;
+    const struct SysemuCPUOps *ops = cc->sysemu_ops;
+
+    assert(height > 0);
+    int ptes_per_node = layout->entries_per_node[height];
+
+    for (i = 0; i < ptes_per_node; i++) {
+        DecodedPTE pt_entry;
+
+        memset(&pt_entry, 0, sizeof(pt_entry));
+
+        /*
+         * For now, let's assume we don't enumerate a page table except
+         * in debug mode, so the access type should be irrelevant
+         */
+        if (!ops->get_pte(cs, node, i, height, &pt_entry, vaddr_in, true,
+                         mmu_idx, false, MMU_DATA_LOAD, NULL, NULL, NULL)) {
+            /* Fail if we can't read the PTE */
+            return false;
+        }
+
+        if (!pt_entry.reserved_bits_ok && !visit_malformed) {
+            continue;
+        }
+
+        if (pt_entry.present || visit_not_present) {
+
+            if (!pt_entry.present || pt_entry.leaf) {
+                if (fn(cs, data, &pt_entry, height, i, mmu_idx, layout)) {
+                    /* Error */
+                    return false;
+                }
+            } else { /* Non-leaf */
+                if (visit_interior_nodes) {
+                    if (fn(cs, data, &pt_entry, height, i, mmu_idx, layout)) {
+                        /* Error */
+                        return false;
+                    }
+                }
+                assert(height > 1);
+
+                if (pt_entry.reserved_bits_ok) {
+
+                    if (!for_each_pte_recursive(cs, fn, data,
+                                                visit_interior_nodes,
+                                                visit_not_present,
+                                                visit_malformed,
+                                                pt_entry.child,
+                                                pt_entry.bits_translated,
+                                                height - 1, layout,
+                                                mmu_idx)) {
+                        return false;
+                    }
+                }
+            }
+        }
+    }
+
+    return true;
+}
+
+/**
+ * for_each_pte - iterate over a page table, and
+ *                call fn on each entry
+ *
+ * @cs - CPU state
+ * @fn(cs, data, pte, height, offset, layout) - User-provided function to call
+ *                                              on each pte.
+ *   * @cs - pass through cs
+ *   * @data - user-provided, opaque pointer
+ *   * @pte - current pte, decoded
+ *   * @height - height in the tree of pte
+ *   * @offset - offset within the page tabe node
+ *   * @layout- The layout of the radix tree
+ * @data - opaque pointer; passed through to fn
+ * @visit_interior_nodes - if true, call fn() on interior entries in
+ *                         page table; if false, visit only leaf entries.
+ * @visit_not_present - if true, call fn() on entries that are not present.
+ *                         if false, visit only present entries.
+ * @visit_malformed - if true, call fn() on entries that are malformed (e.g.,
+ *                         bad reserved bits.  Even if true, will not follow
+ *                         a child pointer to another node.
+ * @mmu_idx - Which level of the mmu we are interested in:
+ *            0 == user mode, 1 == nested page table
+ *            Note that MMU_*_IDX macros are not consistent across
+ *            architectures.
+ *
+ * Returns true on success, false on error.
+ *
+ */
+bool for_each_pte(CPUState *cs, qemu_page_walker_for_each fn, void *data,
+                  bool visit_interior_nodes, bool visit_not_present,
+                  bool visit_malformed, int mmu_idx)
+{
+    vaddr vaddr = 0;
+    hwaddr root;
+    CPUClass *cc = cs->cc;
+    const PageTableLayout *layout;
+
+    if (!cpu_paging_enabled(cs, mmu_idx)) {
+        /* paging is disabled */
+        return true;
+    }
+
+    if (!cc->sysemu_ops->page_table_root) {
+        return false;
+    }
+    assert(cc->sysemu_ops->get_pte);
+
+    root = cc->sysemu_ops->page_table_root(cs, &layout, mmu_idx);
+
+    assert(layout->height > 1);
+
+    /* Recursively call a helper to walk the page table */
+    return for_each_pte_recursive(cs, fn, data, visit_interior_nodes,
+                                  visit_not_present, visit_malformed, root,
+                                  vaddr, layout->height, layout, mmu_idx);
+
+}
diff --git a/hw/core/machine-qmp-cmds.c b/hw/core/machine-qmp-cmds.c
index 130217da8f..0e17750969 100644
--- a/hw/core/machine-qmp-cmds.c
+++ b/hw/core/machine-qmp-cmds.c
@@ -10,6 +10,7 @@
 #include "qemu/osdep.h"
 #include "hw/acpi/vmgenid.h"
 #include "hw/boards.h"
+#include "hw/core/sysemu-cpu-ops.h"
 #include "hw/intc/intc.h"
 #include "hw/mem/memory-device.h"
 #include "qapi/error.h"
@@ -406,3 +407,245 @@ GuidInfo *qmp_query_vm_generation_id(Error **errp)
     info->guid = qemu_uuid_unparse_strdup(&vms->guid);
     return info;
 }
+
+/* Assume only called on present entries */
+int compressing_iterator(CPUState *cs, void *data, DecodedPTE *pte,
+                         int height, int offset, int mmu_idx,
+                         const PageTableLayout *layout)
+{
+    struct mem_print_state *state = (struct mem_print_state *) data;
+    hwaddr paddr = pte->child;
+    uint64_t size = pte->leaf_page_size;
+    bool start_new_run = false, flush = false;
+    bool is_leaf = pte->leaf;
+
+    int entries_per_node = layout->entries_per_node[height];
+
+
+    /* Prot of current pte */
+    int prot = pte->prot;
+
+    /* If there is a prior run, first try to extend it. */
+    if (state->start_height != 0) {
+
+        /*
+         * If we aren't flushing interior nodes, raise the start height.
+         * We don't need to detect non-compressible interior nodes.
+         */
+        if (!state->flush_interior && state->start_height < height) {
+            state->start_height = height;
+            state->vstart[height] = pte->bits_translated;
+            state->vend[height] = pte->bits_translated;
+            assert(pte->leaf_page_size != -1);
+            state->pg_size[height] = pte->leaf_page_size;
+            state->prot[height] = prot;
+            if (offset == 0) {
+                state->last_offset[height] = entries_per_node - 1;
+            } else {
+                state->last_offset[height] = offset - 1;
+            }
+        }
+
+        /* Detect when we are walking down the "left edge" of a range */
+        if (state->vstart[height] == -1
+            && (height + 1) <= state->start_height
+            && state->vstart[height + 1] == pte->bits_translated) {
+
+            state->vstart[height] = pte->bits_translated;
+            assert(pte->leaf_page_size != -1);
+            state->pg_size[height] = pte->leaf_page_size;
+            state->vend[height] = pte->bits_translated;
+            state->prot[height] = prot;
+            state->offset[height] = offset;
+            state->last_offset[height] = offset;
+
+            if (is_leaf) {
+                state->pstart = paddr;
+                state->pend = paddr;
+                state->leaf_height = height;
+            }
+
+            /* Detect contiguous entries at same level */
+        } else if (state->vstart[height] != -1
+                   && state->start_height >= height
+                   && state->prot[height] == prot
+                   && (state->last_offset[height] + 1) % entries_per_node
+                       == offset
+                   && (!is_leaf
+                       || !state->require_physical_contiguity
+                       || state->pend + size == paddr)) {
+
+
+            /*
+             * If there are entries at the levels below, make sure we
+             * completed them.  We only compress interior nodes
+             * without holes in the mappings.
+             */
+            if (height != 1) {
+                for (int i = height - 1; i >= 1; i--) {
+                    int entries = layout->entries_per_node[i];
+
+                    /* Stop if we hit large pages before level 1 */
+                    if (state->vstart[i] == -1) {
+                        break;
+                    }
+
+                    if (state->last_offset[i] + 1 != entries) {
+                        flush = true;
+                        start_new_run = true;
+                        break;
+                    }
+                }
+            }
+
+
+            if (!flush) {
+
+                /* We can compress these entries */
+                state->prot[height] = prot;
+                state->vend[height] = pte->bits_translated;
+                state->last_offset[height] = offset;
+
+                /* Only update the physical range on leaves */
+                if (is_leaf) {
+                    state->pend = paddr;
+                }
+            }
+            /* Let PTEs accumulate... */
+        } else {
+            flush = true;
+        }
+
+        if (flush) {
+            /*
+             * We hit dicontiguous permissions or pages.
+             * Print the old entries, then start accumulating again
+             *
+             * Some clients only want the flusher called on a leaf.
+             * Check that too.
+             *
+             * We can infer whether the accumulated range includes a
+             * leaf based on whether pstart is -1.
+             */
+            if (state->flush_interior || (state->pstart != -1)) {
+                if (state->flusher(cs, state)) {
+                    start_new_run = true;
+                }
+            } else {
+                start_new_run = true;
+            }
+        }
+    } else {
+        start_new_run = true;
+    }
+
+    if (start_new_run) {
+        /* start a new run with this PTE */
+        for (int i = state->start_height; i > 0; i--) {
+            if (state->vstart[i] != -1) {
+                state->prot[i] = 0;
+                state->last_offset[i] = 0;
+                state->vstart[i] = -1;
+                state->pg_size[height] = -1;
+            }
+        }
+        state->pstart = -1;
+        state->leaf_height = -1;
+        state->vstart[height] = pte->bits_translated;
+        state->vend[height] = pte->bits_translated;
+        state->pg_size[height] = pte->leaf_page_size;
+        state->prot[height] = prot;
+        state->offset[height] = offset;
+        state->last_offset[height] = offset;
+        if (is_leaf) {
+            state->pstart = paddr;
+            state->pend = paddr;
+            state->leaf_height = height;
+        }
+        state->start_height = height;
+    }
+
+    return 0;
+}
+
+static
+void query_page_helper(GString *buf, CPUState *cpu, int mmu_idx, bool nested)
+{
+    CPUClass *cc = cpu->cc;
+    struct mem_print_state state;
+
+    if (!cc->sysemu_ops->mon_init_page_table_iterator(cpu, buf, mmu_idx,
+                                                      &state)) {
+        g_string_append_printf(buf,
+                               "Unable to initialize page table iterator\n");
+        return;
+    }
+
+    if (nested) {
+        if (mmu_idx == 0) {
+            g_string_append_printf(buf, "Info pg for CPU %d, guest mode\n",
+                                   cpu->cpu_index);
+        } else if (mmu_idx == 1) {
+            g_string_append_printf(buf, "Info pg for CPU %d, host mode\n",
+                                   cpu->cpu_index);
+        } else {
+            g_assert_not_reached();
+        }
+    } else {
+        g_string_append_printf(buf, "Info pg for CPU %d\n", cpu->cpu_index);
+    }
+
+    state.flush_interior = true;
+    state.require_physical_contiguity = true;
+    state.flusher = cc->sysemu_ops->mon_flush_page_print_state;
+
+    cc->sysemu_ops->mon_info_pg_print_header(&state);
+
+    /*
+     * We must visit interior entries to get the hierarchy, but
+     * can skip not present mappings
+     */
+    for_each_pte(cpu, &compressing_iterator, &state, true, false, true,
+                 mmu_idx);
+
+    /* Print last entry, if one present */
+    cc->sysemu_ops->mon_flush_page_print_state(cpu, &state);
+}
+
+HumanReadableText *qmp_x_query_pg(Error **errp)
+{
+
+    g_autoptr(GString) buf = g_string_new("");
+
+    CPUState *cpu;
+    CPU_FOREACH(cpu) {
+        bool nested;
+
+        cpu_synchronize_state(cpu);
+
+        if (!cpu_paging_enabled(cpu, 0)) {
+            continue;
+        }
+
+        nested = cpu_paging_enabled(cpu, 1);
+
+        CPUClass *cc = cpu->cc;
+
+        if (!cc->sysemu_ops->page_table_root) {
+            g_string_append_printf(buf, "Info pg unsupported on this ISA\n");
+            break;
+        }
+
+        assert(cc->sysemu_ops->mon_init_page_table_iterator);
+        assert(cc->sysemu_ops->mon_info_pg_print_header);
+        assert(cc->sysemu_ops->mon_flush_page_print_state);
+
+        query_page_helper(buf, cpu, 0, nested);
+
+        if (nested) {
+            query_page_helper(buf, cpu, 1, nested);
+        }
+    }
+
+    return human_readable_text_from_str(buf);
+}
diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index d946161717..c70d31433d 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -605,10 +605,11 @@ extern bool mttcg_enabled;
 /**
  * cpu_paging_enabled:
  * @cpu: The CPU whose state is to be inspected.
+ * @mmu_idx: 0 == traditional paging, 1 == nested paging
  *
  * Returns: %true if paging is enabled, %false otherwise.
  */
-bool cpu_paging_enabled(const CPUState *cpu);
+bool cpu_paging_enabled(const CPUState *cpu, int mmu_idx);
 
 /**
  * cpu_get_memory_mapping:
@@ -671,9 +672,82 @@ int cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
  * Caller is responsible for freeing the data.
  */
 GuestPanicInformation *cpu_get_crash_info(CPUState *cpu);
-
 #endif /* !CONFIG_USER_ONLY */
 
+/* Maximum supported page table height - currently x86 at 5 */
+#define MAX_HEIGHT 5
+
+typedef struct PageTableLayout {
+    int height; /* Height of the page table */
+    int entries_per_node[MAX_HEIGHT + 1];
+} PageTableLayout;
+
+typedef struct DecodedPTE {
+    int prot; /* Always populated, arch-specific, decoded flags */
+    bool present;
+    bool leaf; /* Only valid if present */
+    bool reserved_bits_ok;
+    bool user_read_ok;
+    bool user_write_ok;
+    bool user_exec_ok;
+    bool super_read_ok;
+    bool super_write_ok;
+    bool super_exec_ok;
+    bool dirty;
+    hwaddr child; /* Only valid if present and !leaf */
+    uint64_t leaf_page_size; /* Only valid if present and leaf */
+    uint64_t nested_page_size; /*
+                                * If nested paging, the page size of the host
+                                * page storing the data, versus the size of the
+                                * guest page frame in leaf_page_size
+                                */
+    vaddr bits_translated; /*
+                            * The virtual address bits translated in walking
+                            * the page table to node[i].
+                            */
+    hwaddr pte_addr; /* (guest) physical address of the PTE */
+    hwaddr pte_host_addr; /* (host) physical address of the PTE */
+    uint64_t pte_contents; /* Raw contents of the pte */
+} DecodedPTE;
+
+typedef int (*qemu_page_walker_for_each)(CPUState *cs, void *data,
+                                         DecodedPTE *pte,
+                                         int height, int offset, int mmu_idx,
+                                         const PageTableLayout *layout);
+
+/**
+ * for_each_pte - iterate over a page table, and
+ *                call fn on each entry
+ *
+ * @cs - CPU state
+ * @fn(cs, data, pte, height, offset, layout) - User-provided function to call
+ *                                              on each pte.
+ *   * @cs - pass through cs
+ *   * @data - user-provided, opaque pointer
+ *   * @pte - current pte, decoded
+ *   * @height - height in the tree of pte
+ *   * @offset - offset within the page tabe node
+ *   * @layout - pointer to a PageTableLayout for this tree
+ * @data - opaque pointer; passed through to fn
+ * @visit_interior_nodes - if true, call fn() on interior entries in
+ *                         page table; if false, visit only leaf entries.
+ * @visit_not_present - if true, call fn() on entries that are not present.
+ *                         if false, visit only present entries.
+ * @mmu_idx - Which level of the mmu we are interested in:
+ *            0 == user mode, 1 == nested page table
+ *            Note that MMU_*_IDX macros are not consistent across
+ *            architectures.
+ *
+ * Returns true on success, false on error.
+ *
+ * We assume all callers of this function are in debug mode, and do not
+ * want to synthesize, say, a user-mode load, on each page in the address
+ * space.
+ */
+bool for_each_pte(CPUState *cs, qemu_page_walker_for_each fn, void *data,
+                  bool visit_interior_nodes, bool visit_not_present,
+                  bool visit_malformed, int mmu_idx);
+
 /**
  * CPUDumpFlags:
  * @CPU_DUMP_CODE:
diff --git a/include/hw/core/sysemu-cpu-ops.h b/include/hw/core/sysemu-cpu-ops.h
index 4c94e51267..d0e939def8 100644
--- a/include/hw/core/sysemu-cpu-ops.h
+++ b/include/hw/core/sysemu-cpu-ops.h
@@ -12,6 +12,43 @@
 
 #include "hw/core/cpu.h"
 
+/*
+ * struct mem_print_state: Used by qmp in walking page tables.
+ */
+struct mem_print_state {
+    GString *buf;
+    CPUArchState *env;
+    int vaw, paw; /* VA and PA width in characters */
+    int max_height;
+    int mmu_idx; /* 0 == user mode, 1 == nested page table */
+    bool (*flusher)(CPUState *cs, struct mem_print_state *state);
+    bool flush_interior; /* If false, only call flusher() on leaves */
+    bool require_physical_contiguity;
+    /*
+     * The height at which we started accumulating ranges, i.e., the
+     * next height we need to print once we hit the end of a
+     * contiguous range.
+     */
+    int start_height;
+    int leaf_height; /* The height at which we found a leaf, or -1 */
+    /*
+     * For compressing contiguous ranges, track the
+     * start and end of the range
+     */
+    hwaddr vstart[MAX_HEIGHT + 1]; /* Starting virt. addr. of open pte range */
+    hwaddr vend[MAX_HEIGHT + 1]; /* Ending virtual address of open pte range */
+    hwaddr pstart; /* Starting physical address of open pte range */
+    hwaddr pend; /* Ending physical address of open pte range */
+
+    /* PTE protection flags current root->leaf path */
+    uint64_t prot[MAX_HEIGHT + 1];
+
+    /* Page size (leaf) or address range covered (non-leaf). */
+    uint64_t pg_size[MAX_HEIGHT + 1];
+    int offset[MAX_HEIGHT + 1]; /* PTE range starting offsets */
+    int last_offset[MAX_HEIGHT + 1]; /* PTE range ending offsets */
+};
+
 typedef enum TranslateFaultStage2 {
     S2_NONE,
     S2_GPA,
@@ -30,7 +67,7 @@ typedef struct SysemuCPUOps {
     /**
      * @get_paging_enabled: Callback for inquiring whether paging is enabled.
      */
-    bool (*get_paging_enabled)(const CPUState *cpu);
+    bool (*get_paging_enabled)(const CPUState *cpu, int mmu_idx);
     /**
      * @get_phys_page_debug: Callback for obtaining a physical address.
      */
@@ -93,6 +130,105 @@ typedef struct SysemuCPUOps {
      */
     const VMStateDescription *legacy_vmsd;
 
+    /**
+     * page_table_root - Given a CPUState, return the physical address
+     *                    of the current page table root, as well as
+     *                    setting a pointer to a PageTableLayout.
+     *
+     * @cs - CPU state
+     * @layout - a pointer to a PageTableLayout structure, which stores
+     *           the page table tree geometry.
+     * @mmu_idx - Which level of the mmu we are interested in:
+     *            0 == user mode, 1 == nested page table
+     *            Note that MMU_*_IDX macros are not consistent across
+     *            architectures.
+     *
+     * Returns a hardware address on success.  Should not fail (i.e.,
+     * caller is responsible to ensure that a page table is actually
+     * present, or that, with nested paging, there is a nested table
+     * present).
+     *
+     * Do not free layout.
+     */
+    hwaddr (*page_table_root)(CPUState *cs, const PageTableLayout **layout,
+                              int mmu_idx);
+
+    /**
+     * get_pte - Copy and decode the contents of the page table entry at
+     *           node[i] into pt_entry.
+     *
+     * @cs - CPU state
+     * @node - physical address of the current page table node
+     * @i - index (in page table entries, not bytes) of the page table
+     *      entry, within node
+     * @height - height of node within the tree (leaves are 1, not 0)
+     * @pt_entry - Pointer to a DecodedPTE, stores the contents of the page
+     *             table entry
+     * @vaddr_parent - The virtual address bits already translated in
+     *                 walking the page table to node.  Optional: only
+     *                 used if vaddr_pte is set.
+     * @debug - If true, do not update softmmu state (if applicable) to reflect
+     *              the page table walk.
+     * @mmu_idx - Which level of the mmu we are interested in:
+     *            0 == user mode, 1 == nested page table
+     *            Note that MMU_*_IDX macros are not consistent across
+     *            architectures.
+     * @user_access - For non-debug accesses, true if a user mode access, false
+     *                if supervisor mode access.  Used to determine faults.
+     * @access_type - For non-debug accesses, what type of access is driving the
+     *                lookup.  Used to determine faults.
+     * @error_code - Optional integer pointer, to store error reason on failure
+     * @fault_addr - Optional vaddr pointer, to store the faulting address on a
+     *               recursive page walk for the pe.  Otherwise, caller is
+     *               expected to determine if this pte access would fault.
+     * @nested_fault - Optional pointer, to differentiate causes of nested
+     *                 faults.  Set to true if there is a fault recurring on a
+     *                 nested page table.
+     *
+     * Returns true on success, false on failure.  This should only fail if a
+     * page table entry cannot be read because the address of node is not a
+     * valid (guest) physical address.  Otherwise, we capture errors like bad
+     * reserved flags in the DecodedPTE entry and let the caller decide how to
+     * handle it.
+     */
+
+    bool (*get_pte)(CPUState *cs, hwaddr node, int i, int height,
+                    DecodedPTE *pt_entry, vaddr vaddr_parent, bool debug,
+                    int mmu_idx, bool user_access,
+                    const MMUAccessType access_type, int *error_code,
+                    hwaddr *fault_addr, TranslateFaultStage2 *nested_fault);
+
+    /**
+     * @mon_init_page_table_iterator: Callback to configure a page table
+     * iterator for use by a monitor function.
+     * Returns true on success, false if not supported (e.g., no paging disabled
+     * or not implemented on this CPU).
+     *
+     * @mmu_idx - Which level of the mmu we are interested in:
+     *            0 == user mode, 1 == nested page table
+     *            Note that MMU_*_IDX macros are not consistent across
+     *            architectures.
+     */
+    bool (*mon_init_page_table_iterator)(CPUState *cpu, GString *buf,
+                                         int mmu_idx,
+                                         struct mem_print_state *state);
+
+    /**
+     * @mon_info_pg_print_header: Prints the header line for 'info pg'.
+     */
+    void (*mon_info_pg_print_header)(struct mem_print_state *state);
+
+    /**
+     * @flush_page_table_iterator_state: For 'info pg', it prints the last
+     * entry that was visited by the compressing_iterator, if one is present.
+     */
+    bool (*mon_flush_page_print_state)(CPUState *cs,
+                                       struct mem_print_state *state);
+
 } SysemuCPUOps;
 
+int compressing_iterator(CPUState *cs, void *data, DecodedPTE *pte,
+                         int height, int offset, int mmu_idx,
+                         const PageTableLayout *layout);
+
 #endif /* SYSEMU_CPU_OPS_H */
diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
index b679aaebbf..9af72ea58d 100644
--- a/include/monitor/hmp-target.h
+++ b/include/monitor/hmp-target.h
@@ -50,6 +50,7 @@ CPUState *mon_get_cpu(Monitor *mon);
 void hmp_info_mem(Monitor *mon, const QDict *qdict);
 void hmp_info_tlb(Monitor *mon, const QDict *qdict);
 void hmp_mce(Monitor *mon, const QDict *qdict);
+void hmp_info_pg(Monitor *mon, const QDict *qdict);
 void hmp_info_local_apic(Monitor *mon, const QDict *qdict);
 void hmp_info_sev(Monitor *mon, const QDict *qdict);
 void hmp_info_sgx(Monitor *mon, const QDict *qdict);
diff --git a/qapi/machine.json b/qapi/machine.json
index f9ea6b3e97..2a259588dc 100644
--- a/qapi/machine.json
+++ b/qapi/machine.json
@@ -1771,6 +1771,23 @@
   'if': 'CONFIG_TCG',
   'features': [ 'unstable' ] }
 
+##
+# @x-query-pg:
+#
+# Query current page tables
+#
+# Features:
+#
+# @unstable: This command is meant for debugging.
+#
+# Returns: Compressed summary of page tables.
+#
+# Since: 9.0
+##
+{ 'command': 'x-query-pg',
+  'returns': 'HumanReadableText',
+  'features': [ 'unstable' ] }
+
 ##
 # @x-query-ramblock:
 #
diff --git a/system/memory_mapping.c b/system/memory_mapping.c
index 6f884c5b90..78499ae607 100644
--- a/system/memory_mapping.c
+++ b/system/memory_mapping.c
@@ -296,7 +296,7 @@ static CPUState *find_paging_enabled_cpu(void)
     CPUState *cpu;
 
     CPU_FOREACH(cpu) {
-        if (cpu_paging_enabled(cpu)) {
+        if (cpu_paging_enabled(cpu, 0)) {
             return cpu;
         }
     }
diff --git a/target/i386/arch_memory_mapping.c b/target/i386/arch_memory_mapping.c
index d1ff659128..ef29e4b42f 100644
--- a/target/i386/arch_memory_mapping.c
+++ b/target/i386/arch_memory_mapping.c
@@ -14,6 +14,997 @@
 #include "qemu/osdep.h"
 #include "cpu.h"
 #include "sysemu/memory_mapping.h"
+#include "exec/cpu_ldst.h"
+#include "tcg/helper-tcg.h"
+
+#define PML4_ADDR_MASK 0xffffffffff000ULL /* selects bits 51:12 */
+
+const PageTableLayout x86_lma57_layout = { .height = 5,
+    .entries_per_node = {0, 512, 512, 512, 512, 512}
+};
+
+const PageTableLayout x86_lma48_layout = { .height = 4,
+    .entries_per_node = {0, 512, 512, 512, 512, 0}
+};
+
+const PageTableLayout x86_pae32_layout = { .height = 3,
+    .entries_per_node = {0, 512, 512, 4, 0, 0}
+};
+
+const PageTableLayout x86_ia32_layout = { .height = 2,
+    .entries_per_node = {0, 1024, 1024, 0, 0, 0}
+};
+
+/**
+ * x86_page_table_root - Given a CPUState, return the physical address
+ *                       of the current page table root, as well as
+ *                       setting a pointer to a PageTableLayout.
+ *
+ * @cs - CPU state
+ * @layout - a pointer to a pointer to a PageTableLayout structure,
+ *           into which is written a pointer to the page table tree
+ *           geometry.
+ * @mmu_idx - Which level of the mmu we are interested in:
+ *            0 == user mode, 1 == nested page table
+ *            Note that MMU_*_IDX macros are not consistent across
+ *            architectures.
+ *
+ * Returns a hardware address on success.  Should not fail (i.e.,
+ * caller is responsible to ensure that a page table is actually
+ * present, or that, with nested paging, there is a nested
+ * table present).
+ *
+ * Do not free *layout.
+ */
+hwaddr
+x86_page_table_root(CPUState *cs, const PageTableLayout ** layout,
+                    int mmu_idx)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+    /*
+     * DEP 5/15/24: Some original page table walking code sets the a20
+     * mask as a 32 bit integer and checks it on each level of hte
+     * page table walk; some only checks it against the final result.
+     * For 64 bits, I think we need to sign extend in the common case
+     * it is not set (and returns -1), or we will lose bits.
+     */
+    hwaddr root = 0;
+    int pg_mode;
+    int64_t a20_mask;
+
+    assert(cpu_paging_enabled(cs, mmu_idx));
+    a20_mask = x86_get_a20_mask(env);
+
+    switch (mmu_idx) {
+    case 0:
+        root = env->cr[3];
+        pg_mode = get_pg_mode(env);
+
+        if (pg_mode & PG_MODE_PAE) {
+#ifdef TARGET_X86_64
+            if (pg_mode & PG_MODE_LMA) {
+                if (pg_mode & PG_MODE_LA57) {
+                    *layout = &x86_lma57_layout;
+                } else {
+                    *layout = &x86_lma48_layout;
+                }
+                return (root & PML4_ADDR_MASK) & a20_mask;
+            } else
+#endif
+            {
+                *layout = &x86_pae32_layout;
+                return (root & ~0x1f) & a20_mask;
+            }
+        } else {
+            assert(mmu_idx != 1);
+            *layout = &x86_ia32_layout;
+            return (root & ~0xfff) & a20_mask;
+        }
+        break;
+    case 1:
+        assert(env->vm_state_valid);
+        root = env->nested_pg_root;
+        switch (env->nested_pg_height) {
+        case 4:
+            *layout = &x86_lma48_layout;
+            break;
+        case 5:
+            *layout = &x86_lma57_layout;
+            break;
+        default:
+            g_assert_not_reached();
+        }
+        return (root & PML4_ADDR_MASK) & a20_mask;
+    default:
+        g_assert_not_reached();
+    }
+
+    g_assert_not_reached();
+    return 0;
+}
+
+/*
+ * Given a CPU state and height, return the number of bits
+ * to shift right/left in going from virtual to PTE index
+ * and vice versa, the number of useful bits.
+ */
+static void _mmu_decode_va_parameters(CPUState *cs, int height,
+                                      int *shift, int *width)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+    int _shift = 0;
+    int _width = 0;
+    bool pae_enabled = env->cr[4] & CR4_PAE_MASK;
+
+    switch (height) {
+    case 5:
+        _shift = 48;
+        _width = 9;
+        break;
+    case 4:
+        _shift = 39;
+        _width = 9;
+        break;
+    case 3:
+        _shift = 30;
+        _width = 9;
+        break;
+    case 2:
+        /* 64 bit page tables shift from 30->21 bits here */
+        if (pae_enabled) {
+            _shift = 21;
+            _width = 9;
+        } else {
+            /* 32 bit page tables shift from 32->22 bits */
+            _shift = 22;
+            _width = 10;
+        }
+        break;
+    case 1:
+        _shift = 12;
+        if (pae_enabled) {
+            _width = 9;
+        } else {
+            _width = 10;
+        }
+
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    if (shift) {
+        *shift = _shift;
+    }
+
+    if (width) {
+        *width = _width;
+    }
+}
+
+/**
+ * x86_virtual_to_pte_index - Given a virtual address and height in
+ *       the page table radix tree, return the index that should be
+ *       used to look up the next page table entry (pte) in
+ *       translating an address.
+ *
+ * @cs - CPU state
+ * @vaddr - The virtual address to translate
+ * @height - height of node within the tree (leaves are 1, not 0).
+ *
+ * Example: In 32-bit x86 page tables, the virtual address is split
+ * into 10 bits at height 2, 10 bits at height 1, and 12 offset bits.
+ * So a call with VA and height 2 would return the first 10 bits of va,
+ * right shifted by 22.
+ */
+int x86_virtual_to_pte_index(CPUState *cs, vaddr vaddr_in, int height)
+{
+    int shift = 0;
+    int width = 0;
+    int mask = 0;
+
+    _mmu_decode_va_parameters(cs, height, &shift, &width);
+
+    mask = (1 << width) - 1;
+
+    return (vaddr_in >> shift) & mask;
+}
+
+/**
+ * x86_get_pte - Copy and decode the contents of the page table entry at
+ *               node[i] into pt_entry.
+ *
+ * @cs - CPU state
+ * @node - physical address of the current page table node
+ * @i - index (in page table entries, not bytes) of the page table
+ *      entry, within node
+ * @height - height of node within the tree (leaves are 1, not 0)
+ * @pt_entry - Poiter to a DecodedPTE, stores the contents of the page table
+ *             entry
+ * @vaddr_parent - The virtual address bits already translated in walking the
+ *                 page table to node.  Optional: only used if vaddr_pte is set.
+ * @debug - If true, do not update softmmu state (if applicable) to reflect
+ *          the page table walk.
+ * @mmu_idx - Which level of the mmu we are interested in: 0 == user
+ *            mode, 1 == nested page table Note that MMU_*_IDX macros
+ *            are not consistent across architectures.
+ * @user_access - For non-debug accesses, is this a user or supervisor-mode
+ *                access.  Used to determine faults.
+ * @access_type - For non-debug accesses, what type of access is driving the
+ *                lookup.  Used to determine faults.
+ * @error_code - Optional integer pointer, to store error reason on failure
+ * @fault_addr - Optional vaddr pointer, to store the faulting address on a
+ *               recursive page walk for the pe.  Otherwise, caller is expected
+ *               to determine if this pte access would fault.
+ * @nested_fault - Optional pointer, to differentiate causes of nested faults.
+ *                 Set to true if there is a fault recurring on a nested page
+ *                 table.
+ *
+ * Returns true on success, false on failure.  This should only fail if a page
+ * table entry cannot be read because the address of node is not a valid (guest)
+ * physical address.  Otherwise, we capture errors like bad reserved flags in
+ * the DecodedPTE entry and let the caller decide how to handle it.
+ */
+bool
+x86_get_pte(CPUState *cs, hwaddr node, int i, int height, DecodedPTE *pt_entry,
+            vaddr vaddr_parent, bool debug, int mmu_idx, bool user_access,
+            const MMUAccessType access_type, int *error_code,
+            vaddr *fault_addr, TranslateFaultStage2 *nested_fault)
+{
+    CPUX86State *env = cpu_env(cs);
+    int32_t a20_mask = x86_get_a20_mask(env);
+    hwaddr pte = 0;
+    uint64_t pte_contents = 0;
+    hwaddr pte_host_addr = 0;
+    uint64_t unused = 0; /* We always call probe_access in non-fault mode */
+    bool use_stage2 = env->hflags & HF_GUEST_MASK;
+    int pte_width = 4;
+    uint64_t leaf_mask = 0;
+    int pg_mode = get_pg_mode(env);
+    bool pae_enabled = !!(pg_mode & PG_MODE_PAE);
+    bool long_mode = !!(pg_mode & PG_MODE_LMA);
+#ifdef CONFIG_TCG
+    void *pte_internal_pointer = NULL;
+#endif
+
+    pt_entry->reserved_bits_ok = false;
+
+    if (env->hflags & HF_LMA_MASK) {
+        /* 64 bit */
+        pte_width = 8;
+    }
+
+    pte = (node + (i * pte_width)) & a20_mask;
+
+    if (debug) {
+
+        /* Recur on nested paging */
+        if (mmu_idx == 0 && use_stage2) {
+
+            bool ok = x86_ptw_translate(cs, pte, &pte_host_addr, debug, 1,
+                                        user_access, access_type, NULL,
+                                        error_code, fault_addr, NULL, NULL,
+                                        NULL);
+            if (!ok) {
+                if (nested_fault) {
+                    *nested_fault = S2_GPT;
+                }
+                return false;
+            }
+        } else {
+            pte_host_addr = pte;
+        }
+    } else {
+#ifdef CONFIG_TCG
+        CPUTLBEntryFull *full;
+        int flags = probe_access_full(env, pte, 0, MMU_DATA_STORE,
+                                      MMU_NESTED_IDX, true,
+                                      &pte_internal_pointer, &full,
+                                      unused);
+
+        if (unlikely(flags & TLB_INVALID_MASK)) {
+            if (nested_fault) {
+                *nested_fault = S2_GPT;
+            }
+            if (error_code) {
+                *error_code = env->error_code;
+            }
+            if (fault_addr) {
+                *fault_addr = pte;
+            }
+            return false;
+        }
+
+        pte_host_addr = full->phys_addr;
+        /* probe_access_full() drops the offset bits; we need to re-add them */
+        pte_host_addr += i * pte_width;
+        /*
+         * But don't re-add to pte_internal_pointer, which overlaps with
+         * pte_host_addr...
+         */
+#else
+        /* Any non-TCG use case should be read-only */
+        g_assert_not_reached();
+#endif
+    }
+#ifdef CONFIG_TCG
+    /*
+     * TCG needs to set the accessed bit on the PTE; it does this in a
+     * compare-and-swap loop.
+     */
+ reread_pte:
+#endif
+
+    /* Read the PTE contents */
+    if (likely(pte_host_addr)) {
+        if (long_mode) {
+            pte_contents = address_space_ldq(cs->as, pte_host_addr,
+                                             MEMTXATTRS_UNSPECIFIED, NULL);
+        } else {
+            pte_contents = address_space_ldl(cs->as, pte_host_addr,
+                                             MEMTXATTRS_UNSPECIFIED, NULL);
+        }
+    } else {
+        pte_contents = long_mode ?
+            cpu_ldq_mmuidx_ra(env, pte, MMU_PHYS_IDX, unused) :
+            cpu_ldl_mmuidx_ra(env, pte, MMU_PHYS_IDX, unused);
+    }
+
+    /* Deserialize flag bits, different by mmu index */
+    if (mmu_idx == 0 ||
+        (mmu_idx == 1 && env->vm_state_valid && env->nested_pg_format == 1))
+    {
+        pt_entry->present = pte_contents & PG_PRESENT_MASK;
+
+        if (pt_entry->present) {
+            bool nx_enabled = !!(pg_mode & PG_MODE_NXE);
+            bool smep_enabled = !!(pg_mode & PG_MODE_SMEP);
+
+            pt_entry->super_read_ok = true;
+            if (pg_mode & PG_MODE_WP) {
+                pt_entry->super_write_ok = !!(pte_contents & PG_RW_MASK);
+            } else {
+                pt_entry->super_write_ok = true;
+            }
+
+            if (nx_enabled) {
+                if (smep_enabled) {
+                    pt_entry->super_exec_ok = !(pte_contents & PG_USER_MASK);
+                } else {
+                    pt_entry->super_exec_ok = !(pte_contents & PG_NX_MASK);
+                }
+                pt_entry->user_exec_ok = !(pte_contents & PG_NX_MASK);
+            } else {
+                pt_entry->super_exec_ok = true;
+                pt_entry->user_exec_ok = !!(pte_contents & PG_USER_MASK);
+            }
+
+            if (pte_contents & PG_USER_MASK) {
+                pt_entry->user_read_ok = true;
+                pt_entry->user_write_ok = !!(pte_contents & PG_RW_MASK);
+            }
+
+            pt_entry->dirty = !!(pte_contents & PG_DIRTY_MASK);
+        }
+
+        pt_entry->prot = pte_contents & (PG_USER_MASK | PG_RW_MASK |
+                                         PG_PRESENT_MASK);
+
+
+
+        /* In 32-bit mode without PAE, we need to check the PSE flag in cr4 */
+        if (long_mode || pae_enabled || pg_mode & PG_MODE_PSE) {
+            leaf_mask = PG_PSE_MASK;
+        }
+
+    } else if (mmu_idx == 1) {
+        uint64_t mask = PG_EPT_PRESENT_MASK;
+        /*
+         * One could arguably check whether the CPU is in supervisor mode
+         * here. At least for debugging functions, one probably only wants
+         * an entry treated as not-present if it is not present in all modes,
+         * not just the current guest ring.  OTOH, TCG may want this semantic.
+         */
+        if (env->enable_mode_based_access_control) {
+            mask |= PG_EPT_X_USER_MASK;
+        }
+        pt_entry->present = !!(pte_contents & mask);
+        if (pt_entry->present) {
+            pt_entry->super_read_ok = pt_entry->user_read_ok
+                = !!(pte_contents & PG_EPT_R_MASK);
+
+            pt_entry->super_exec_ok = !!(pte_contents & PG_EPT_X_SUPER_MASK);
+            if (env->enable_mode_based_access_control) {
+                pt_entry->user_exec_ok = !!(pte_contents & PG_EPT_X_USER_MASK);
+            } else {
+                pt_entry->user_exec_ok = pt_entry->super_exec_ok;
+            }
+
+            pt_entry->dirty = !!(pte_contents & PG_DIRTY_MASK);
+        }
+        pt_entry->prot = pte_contents & (PG_EPT_PRESENT_MASK |
+                                         PG_EPT_X_USER_MASK);
+        leaf_mask = PG_EPT_PSE_MASK;
+    } else {
+        g_assert_not_reached();
+    }
+
+    if (pt_entry->present) {
+        pt_entry->leaf = (height == 1 ||
+                          pte_contents & leaf_mask);
+
+        /* Sanity checks */
+        if (pt_entry->leaf) {
+            switch (height) {
+#ifdef TARGET_X86_64
+            case 5:
+                /* No leaves at level 5 in EPT */
+                assert(mmu_idx == 0);
+                assert(pae_enabled);
+                assert(env->cr[4] & CR4_LA57_MASK);
+                assert(env->hflags & HF_LMA_MASK);
+                break;
+            case 4:
+                /* No leaves at level 4 in EPT */
+                assert(mmu_idx == 0);
+                assert(pae_enabled);
+                assert(env->hflags & HF_LMA_MASK);
+                break;
+#endif
+            case 3:
+                if (mmu_idx == 0) {
+                    assert(pae_enabled);
+                }
+                break;
+            }
+        }
+
+        switch (height) {
+#ifdef TARGET_X86_64
+        case 5:
+            /* assert(pae_enabled); */
+            /* Fall through */
+        case 4:
+            /* assert(pae_enabled); */
+            /* Fall through */
+#endif
+        case 3:
+            assert(pae_enabled);
+#ifdef TARGET_X86_64
+            if (env->hflags & HF_LMA_MASK) {
+                if (pt_entry->leaf) {
+                    /* Select bits 30--51 */
+                    pt_entry->child = (pte_contents & 0xfffffc0000000);
+                } else {
+                    pt_entry->child = (pte_contents & PG_ADDRESS_MASK)
+                        & a20_mask;
+                }
+            } else
+#endif
+            {
+                pt_entry->child = (pte_contents & ~0xfff) & a20_mask;
+            }
+            break;
+        case 2:
+            if (pt_entry->leaf) {
+                if (pae_enabled) {
+                    /* Select bits 21--51 */
+                    pt_entry->child = (pte_contents & 0xfffffffe00000);
+                } else {
+                    /*
+                     * 4 MB page:
+                     * bits 39:32 are bits 20:13 of the PDE
+                     * bit3 31:22 are bits 31:22 of the PDE
+                     */
+                    hwaddr high_paddr = (hwaddr)(pte_contents & 0x1fe000) << 19;
+                    pt_entry->child = (pte_contents & ~0x3fffff) | high_paddr;
+                }
+                break;
+            }
+            /* else fall through */
+        case 1:
+            if (pae_enabled || mmu_idx == 1) {
+                pt_entry->child = (pte_contents & PG_ADDRESS_MASK)
+                    & a20_mask;
+            } else {
+                pt_entry->child = (pte_contents & ~0xfff) & a20_mask;
+            }
+            break;
+        default:
+            g_assert_not_reached();
+        }
+
+        /* Check reserved bits */
+        uint64_t rsvd_mask = ~MAKE_64BIT_MASK(0, env_archcpu(env)->phys_bits);
+        rsvd_mask &= PG_ADDRESS_MASK;
+
+        if (mmu_idx == 0
+            || (mmu_idx == 1 && env->vm_state_valid &&
+                env->nested_pg_format == 1)) {
+
+            if (!(env->efer & MSR_EFER_NXE)
+                || !long_mode) {
+                rsvd_mask |= PG_NX_MASK;
+            }
+            if (height > 3) {
+                rsvd_mask |= PG_PSE_MASK;
+            }
+            if (!long_mode) {
+                if (pae_enabled) {
+                    rsvd_mask |= PG_HI_USER_MASK;
+                } else if (!pae_enabled && height == 2 && pt_entry->leaf) {
+                    rsvd_mask = 0x200000;
+                } else {
+                    rsvd_mask = 0;
+                }
+            }
+
+            /* If PAT is not supported, the PAT bit is reserved */
+            if (!(env->features[FEAT_1_EDX] & CPUID_PAT)) {
+                rsvd_mask |= PG_PSE_PAT_MASK;
+            }
+
+        } else if (mmu_idx == 1) {
+            assert(env->nested_pg_format == 0);
+            /* All EPT formats reserve bits 51..max phys address. */
+            rsvd_mask &= 0xffffffffff000;
+
+            if (pt_entry->leaf) {
+                /* Leaves reserve irrelevant low-bits of the phys addr */
+                if (height == 3) {
+                    rsvd_mask |= 0x3ffff000;
+                } else if (height == 2) {
+                    rsvd_mask |= 0x1ff000;
+                }
+            } else {
+                /* non-leaves should have bits 7:3 clear */
+                rsvd_mask |= 0xf8;
+            }
+        } else {
+            g_assert_not_reached();
+        }
+
+        if (pte_contents & rsvd_mask) {
+            pt_entry->reserved_bits_ok = false;
+        } else {
+            pt_entry->reserved_bits_ok = true;
+        }
+
+        /* In non-read-only case, set accessed bits */
+        if (!debug) {
+#ifdef CONFIG_TCG
+            TranslateFault err;
+            PTETranslate pte_trans = {
+                .gaddr = pte_host_addr,
+                .haddr = pte_internal_pointer,
+                .env = env,
+                .err = &err,
+                .ptw_idx = MMU_PHYS_IDX, /* We already recurred */
+            };
+
+            /* If this is a leaf and a store, set the dirty bit too */
+            if (mmu_idx == 0 || (mmu_idx == 1 && env->nested_pg_format == 1)) {
+                uint32_t set = PG_ACCESSED_MASK;
+                if (pt_entry->leaf && access_type == MMU_DATA_STORE) {
+                    set |= PG_DIRTY_MASK;
+                }
+                if (!ptw_setl(&pte_trans, pte_contents, set)) {
+                    goto reread_pte;
+                }
+            } else if (mmu_idx == 1) {
+                assert(env->nested_pg_format == 0);
+                if (env->enable_ept_accessed_dirty) {
+                    uint32_t set = PG_EPT_ACCESSED_MASK;
+                    if (pt_entry->leaf && access_type == MMU_DATA_STORE) {
+                        set |= PG_EPT_DIRTY_MASK;
+                    }
+                    if (!ptw_setl(&pte_trans, pte_contents, set)) {
+                        goto reread_pte;
+                    }
+                }
+            } else {
+                g_assert_not_reached();
+            }
+#else
+            g_assert_not_reached();
+#endif
+        }
+    }
+
+    /*
+     * We always report the relevant leaf page size so that
+     * consumers know the virtual addresses range translated by this entry.
+     */
+
+    /* Decode the child node's hw address */
+    switch (height) {
+#ifdef TARGET_X86_64
+    case 5:
+        assert(env->cr[4] & CR4_LA57_MASK);
+        pt_entry->leaf_page_size = 1ULL << 48;
+        break;
+    case 4:
+        assert(env->hflags & HF_LMA_MASK);
+        pt_entry->leaf_page_size = 1ULL << 39;
+        break;
+#endif
+    case 3:
+        pt_entry->leaf_page_size = 1 << 30;
+        break;
+    case 2:
+        if (pae_enabled || mmu_idx == 1) {
+            pt_entry->leaf_page_size = 1 << 21;
+        } else {
+            pt_entry->leaf_page_size = 1 << 22;
+        }
+        break;
+    case 1:
+        pt_entry->leaf_page_size = 4096;
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    int shift = 0;
+    _mmu_decode_va_parameters(cs, height, &shift, NULL);
+    pt_entry->bits_translated = vaddr_parent | ((i & 0x1ffULL) << shift);
+    pt_entry->pte_addr = pte;
+    pt_entry->pte_host_addr = (hwaddr) pte_host_addr;
+    pt_entry->pte_contents = pte_contents;
+
+    return true;
+}
+
+bool x86_ptw_translate(CPUState *cs, vaddr vaddress, hwaddr *hpa,
+                       bool debug, int mmu_idx, bool user_access,
+                       const MMUAccessType access_type, uint64_t *page_size,
+                       int *error_code, hwaddr *fault_addr,
+                       TranslateFaultStage2 *nested_fault, int *prot,
+                       bool *dirty)
+{
+    CPUX86State *env = cpu_env(cs);
+    const PageTableLayout *layout;
+    hwaddr pt_node = x86_page_table_root(cs, &layout, mmu_idx);
+    DecodedPTE pt_entry;
+    hwaddr offset = 0;
+    hwaddr real_hpa = 0;
+    uint64_t real_page_size;
+
+    vaddr bits_translated = 0;
+    int pg_mode = get_pg_mode(env);
+    bool use_stage2 = env->hflags & HF_GUEST_MASK;
+
+    /*
+     * As we iterate on the page table, accumulate allowed operations, for
+     * a possible TLB refill (e.g., TCG).  Note that we follow the TCG softmmu
+     * code in applying protection keys here; my reading is that one needs to
+     * flush the TLB on any operation that changes a relevant key, which is
+     * beyond this code's purview...
+     */
+    bool user_read_ok = true, user_write_ok = true, user_exec_ok = true;
+    bool super_read_ok = true, super_write_ok = true, super_exec_ok = true;
+
+    /* Initialize the error code to 0 */
+    if (error_code) {
+        *error_code = 0;
+    }
+
+    /* Ensure nested_fault is initialized properly */
+    if (nested_fault) {
+        *nested_fault = S2_NONE;
+    }
+
+    int i = layout->height;
+    do {
+        int index = x86_virtual_to_pte_index(cs, vaddress, i);
+
+        memset(&pt_entry, 0, sizeof(pt_entry));
+
+        if (!x86_get_pte(cs, pt_node, index, i, &pt_entry, bits_translated,
+                         debug, mmu_idx, user_access, access_type, error_code,
+                         fault_addr, nested_fault)) {
+            return false;
+        }
+
+        if (!pt_entry.present) {
+            if (error_code) {
+                /* Set the P bit to zero */
+                if (error_code) {
+                    *error_code &= ~PG_ERROR_P_MASK;
+                    if (user_access) {
+                        *error_code |= PG_ERROR_U_MASK;
+                    }
+                    if (access_type == MMU_DATA_STORE) {
+                        *error_code |= PG_ERROR_W_MASK;
+                    } else if (access_type == MMU_INST_FETCH) {
+                        if (pg_mode & PG_MODE_SMEP
+                            || (pg_mode & PG_MODE_NXE
+                                && pg_mode & PG_MODE_PAE)) {
+                            *error_code |= PG_ERROR_I_D_MASK;
+                        }
+                    }
+                }
+            }
+            goto fault_out;
+        }
+
+        /* Always check reserved bits */
+        if (!pt_entry.reserved_bits_ok) {
+            if (error_code) {
+                *error_code |= PG_ERROR_RSVD_MASK;
+            }
+            goto fault_out;
+        }
+
+        /* Always accumulate the permissions on the page table walk. */
+        user_read_ok &= pt_entry.user_read_ok;
+        user_write_ok &= pt_entry.user_write_ok;
+        user_exec_ok &= pt_entry.user_exec_ok;
+        super_read_ok &= pt_entry.super_read_ok;
+        super_write_ok &= pt_entry.super_write_ok;
+        super_exec_ok &= pt_entry.super_exec_ok;
+
+        /* If we are not in debug mode, check permissions before recurring */
+        if (!debug) {
+            if (user_access) {
+                switch (access_type) {
+                case MMU_DATA_LOAD:
+                    if (!pt_entry.user_read_ok) {
+                        if (error_code) {
+                            *error_code |= PG_ERROR_U_MASK;
+                            /* We can only set the P bit on a leaf */
+                            if (pt_entry.leaf) {
+                                *error_code |=  PG_ERROR_P_MASK;
+                            }
+                        }
+                        goto fault_out;
+                    }
+                    break;
+                case MMU_DATA_STORE:
+                    if (!pt_entry.user_write_ok) {
+                        if (error_code) {
+                            *error_code |=  PG_ERROR_W_MASK | PG_ERROR_U_MASK;
+                            /* We can only set the P bit on a leaf */
+                            if (pt_entry.leaf) {
+                                *error_code |=  PG_ERROR_P_MASK;
+                            }
+                        }
+                        goto fault_out;
+                    }
+                    break;
+                case MMU_INST_FETCH:
+                    if (!pt_entry.user_exec_ok) {
+                        if (error_code) {
+                            *error_code |=  PG_ERROR_U_MASK;
+                            if (pg_mode & PG_MODE_SMEP
+                                || (pg_mode & PG_MODE_NXE
+                                    && pg_mode & PG_MODE_PAE)) {
+                                *error_code |= PG_ERROR_I_D_MASK;
+                                /* We can only set the P bit on a leaf */
+                                if (pt_entry.leaf) {
+                                    *error_code |=  PG_ERROR_P_MASK;
+                                }
+                            }
+                        }
+                        goto fault_out;
+                    }
+                    break;
+                default:
+                    g_assert_not_reached();
+                }
+            } else {
+                switch (access_type) {
+                case MMU_DATA_LOAD:
+                    if (!pt_entry.super_read_ok) {
+                        if (error_code && pt_entry.leaf) {
+                            /* Not a distinct super+r mask */
+                            *error_code |= PG_ERROR_P_MASK;
+                        }
+                        goto fault_out;
+                    }
+                    break;
+                case MMU_DATA_STORE:
+                    if (!pt_entry.super_write_ok) {
+                        if (error_code) {
+                            *error_code |= PG_ERROR_P_MASK | PG_ERROR_W_MASK;
+                            /* We can only set the P bit on a leaf */
+                            if (pt_entry.leaf) {
+                                *error_code |=  PG_ERROR_P_MASK;
+                            }
+
+                        }
+                        goto fault_out;
+                    }
+                    break;
+                case MMU_INST_FETCH:
+                    if (!pt_entry.super_exec_ok) {
+                        if (error_code) {
+                            /* We can only set the P bit on a leaf */
+                            if (pt_entry.leaf) {
+                                *error_code |=  PG_ERROR_P_MASK;
+                            }
+                            if (pg_mode & PG_MODE_SMEP
+                                || (pg_mode & PG_MODE_NXE
+                                    && pg_mode & PG_MODE_PAE)) {
+                                *error_code |= PG_ERROR_I_D_MASK;
+                            }
+
+                        }
+                        goto fault_out;
+                    }
+                    break;
+                default:
+                    g_assert_not_reached();
+                }
+            }
+        }
+
+        /* Check if we have hit a leaf.  Won't happen (yet) at heights > 3. */
+        if (pt_entry.leaf) {
+            assert(i < 4);
+            break;
+        }
+
+        /* Move to the child node */
+        assert(i > 1);
+        pt_node = pt_entry.child;
+        bits_translated |= pt_entry.bits_translated;
+        i--;
+    } while (i > 0);
+
+    assert(pt_entry.leaf);
+
+    /* Some x86 protection checks are leaf-specific */
+
+    /* Apply MPK at end, only on non-nested page tables */
+    if (mmu_idx == 0) {
+        /* MPK */
+        uint32_t pkr;
+
+        /* Is this a user-mode mapping? */
+        if (user_read_ok) {
+            pkr = pg_mode & PG_MODE_PKE ? env->pkru : 0;
+        } else {
+            pkr = pg_mode & PG_MODE_PKS ? env->pkrs : 0;
+        }
+
+        if (pkr) {
+            uint32_t pk = (pt_entry.pte_contents & PG_PKRU_MASK)
+                >> PG_PKRU_BIT;
+            /*
+             * Follow the TCG pattern here of applying these bits
+             * to the protection, which may be fed to the TLB.
+             * My reading is that it is not safe to cache this across
+             * changes to these registers...
+             */
+            uint32_t pkr_ad = (pkr >> pk * 2) & 1;
+            uint32_t pkr_wd = (pkr >> pk * 2) & 2;
+
+            if (pkr_ad) {
+                super_read_ok = false;
+                user_read_ok = false;
+                super_write_ok = false;
+                user_write_ok = false;
+
+                if (!debug) {
+                    if (access_type == MMU_DATA_LOAD
+                        || access_type == MMU_DATA_STORE) {
+                        if (error_code) {
+                            *error_code |= PG_ERROR_PK_MASK | PG_ERROR_P_MASK;
+                            if (user_access) {
+                                *error_code |= PG_ERROR_U_MASK;
+                            }
+                        }
+                        goto fault_out;
+
+                    }
+                }
+            }
+
+            if (pkr_wd) {
+                user_write_ok = false;
+                if (pg_mode & PG_MODE_WP) {
+                    super_write_ok = false;
+                }
+                if (!debug) {
+                    if (access_type == MMU_DATA_STORE
+                        && (user_access || pg_mode & PG_MODE_WP)) {
+                        if (error_code) {
+                            *error_code |= PG_ERROR_PK_MASK | PG_ERROR_P_MASK;
+                            if (user_access) {
+                                *error_code |= PG_ERROR_U_MASK;
+                            }
+                        }
+                        goto fault_out;
+                    }
+                }
+            }
+        }
+    }
+
+    real_page_size = pt_entry.leaf_page_size;
+    /* Add offset bits back to hpa */
+    offset = vaddress & (pt_entry.leaf_page_size - 1);
+    real_hpa = pt_entry.child | offset;
+
+    /*
+     * In the event of nested paging, we need to recur one last time on the
+     * child address to resolve the host address.  Also, if the nested page
+     * size is larger use that for a TLB consumer.  Recursion with the offset
+     * bits added in should do the right thing if the nested page sizes differ.
+     */
+
+    if (mmu_idx == 0 && use_stage2) {
+        vaddr gpa = pt_entry.child | offset;
+        uint64_t nested_page_size = 0;
+
+        if (error_code) {
+            assert(error_code == 0);
+        }
+
+        if (!x86_ptw_translate(cs, gpa, &real_hpa,
+                               debug, 1, user_access, access_type,
+                               &nested_page_size, error_code, fault_addr,
+                               nested_fault, prot, NULL)) {
+            if (nested_fault) {
+                *nested_fault = S2_GPA;
+            }
+            return false;
+        }
+
+        if (real_page_size < nested_page_size) {
+            real_page_size = nested_page_size;
+        }
+    }
+
+    if (hpa) {
+        *hpa = real_hpa;
+    }
+
+    if (page_size) {
+        *page_size = real_page_size;
+    }
+
+    if (prot) {
+        *prot = 0;
+        if (user_access) {
+            if (user_read_ok) {
+                *prot |= PAGE_READ;
+            }
+            if (user_write_ok) {
+                *prot |= PAGE_WRITE;
+            }
+            if (user_exec_ok) {
+                *prot |= PAGE_EXEC;
+            }
+        } else {
+            if (super_read_ok) {
+                *prot |= PAGE_READ;
+            }
+            if (super_write_ok) {
+                *prot |= PAGE_WRITE;
+            }
+            if (super_exec_ok) {
+                *prot |= PAGE_EXEC;
+            }
+        }
+    }
+
+    if (dirty) {
+        *dirty = pt_entry.dirty;
+    }
+
+    return true;
+
+ fault_out:
+    if (fault_addr) {
+        *fault_addr = vaddress;
+    }
+    return false;
+
+}
 
 /* PAE Paging or IA-32e Paging */
 static void walk_pte(MemoryMappingList *list, AddressSpace *as,
@@ -273,7 +1264,7 @@ bool x86_cpu_get_memory_mapping(CPUState *cs, MemoryMappingList *list,
     CPUX86State *env = &cpu->env;
     int32_t a20_mask;
 
-    if (!cpu_paging_enabled(cs)) {
+    if (!cpu_paging_enabled(cs, 0)) {
         /* paging is disabled */
         return true;
     }
@@ -313,4 +1304,3 @@ bool x86_cpu_get_memory_mapping(CPUState *cs, MemoryMappingList *list,
 
     return true;
 }
-
diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index 4688d140c2..ec419e0ef0 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -8050,11 +8050,25 @@ static int64_t x86_cpu_get_arch_id(CPUState *cs)
 }
 
 #if !defined(CONFIG_USER_ONLY)
-static bool x86_cpu_get_paging_enabled(const CPUState *cs)
+static bool x86_cpu_get_paging_enabled(const CPUState *cs, int mmu_idx)
 {
     X86CPU *cpu = X86_CPU(cs);
 
-    return cpu->env.cr[0] & CR0_PG_MASK;
+    if (mmu_idx == 0) {
+        return cpu->env.cr[0] & CR0_PG_MASK;
+    } else if (mmu_idx == 1) {
+        if (cpu->env.hflags & HF_GUEST_MASK) {
+            if (!cpu->env.vm_state_valid) {
+                warn_report_once("Attempt to query virtualization state on an"
+                                 "unsupported accelerator.  This operation will"
+                                 "not work properly on this configuration.");
+                return false;
+            }
+
+            return cpu->env.nested_paging;
+        }
+    }
+    return false;
 }
 #endif /* !CONFIG_USER_ONLY */
 
@@ -8369,6 +8383,11 @@ static const struct SysemuCPUOps i386_sysemu_ops = {
     .write_elf32_qemunote = x86_cpu_write_elf32_qemunote,
     .write_elf64_qemunote = x86_cpu_write_elf64_qemunote,
     .legacy_vmsd = &vmstate_x86_cpu,
+    .page_table_root = &x86_page_table_root,
+    .get_pte = &x86_get_pte,
+    .mon_init_page_table_iterator = &x86_mon_init_page_table_iterator,
+    .mon_info_pg_print_header = &x86_mon_info_pg_print_header,
+    .mon_flush_page_print_state = &x86_mon_flush_print_pg_state,
 };
 #endif
 
diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index d899644cb8..4e5877f41d 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -303,6 +303,7 @@ typedef enum X86Seg {
 
 #define DR_RESERVED_MASK 0xffffffff00000000ULL
 
+/* Regular x86 Page Bits */
 #define PG_PRESENT_BIT  0
 #define PG_RW_BIT       1
 #define PG_USER_BIT     2
@@ -340,6 +341,28 @@ typedef enum X86Seg {
 #define PG_ERROR_I_D_MASK  0x10
 #define PG_ERROR_PK_MASK   0x20
 
+/* EPT Bits */
+#define PG_EPT_R_BIT        0
+#define PG_EPT_W_BIT        1
+#define PG_EPT_X_SUPER_BIT  2
+#define PG_EPT_PSE_BIT      7
+#define PG_EPT_ACCESSED_BIT 8
+#define PG_EPT_DIRTY_BIT    9 /* Only set on leaves */
+#define PG_EPT_X_USER_BIT  10
+
+#define PG_EPT_R_MASK        (1 << PG_EPT_R_BIT)
+#define PG_EPT_W_MASK        (1 << PG_EPT_W_BIT)
+#define PG_EPT_X_SUPER_MASK  (1 << PG_EPT_X_SUPER_BIT)
+#define PG_EPT_PSE_MASK      (1 << PG_EPT_PSE_BIT)
+#define PG_EPT_ACCESSED_MASK (1 << PG_EPT_ACCESSED_BIT)
+#define PG_EPT_DIRTY_MASK    (1 << PG_EPT_DIRTY_BIT)
+#define PG_EPT_X_USER_MASK   (1 << PG_EPT_X_USER_BIT)
+
+/* EPT_X_USER_BIT only checked if vm mode based controls enabled */
+#define PG_EPT_PRESENT_MASK (PG_EPT_R_MASK | PG_EPT_W_MASK \
+                             | PG_EPT_X_SUPER_MASK)
+
+
 #define PG_MODE_PAE      (1 << 0)
 #define PG_MODE_LMA      (1 << 1)
 #define PG_MODE_NXE      (1 << 2)
@@ -1167,6 +1190,7 @@ uint64_t x86_cpu_get_supported_feature_word(X86CPU *cpu, FeatureWord w);
 #define VMX_SECONDARY_EXEC_RDSEED_EXITING           0x00010000
 #define VMX_SECONDARY_EXEC_ENABLE_PML               0x00020000
 #define VMX_SECONDARY_EXEC_XSAVES                   0x00100000
+#define VMX_SECONDARY_EXEC_ENABLE_MODE_BASED_EXC    0x00400000
 #define VMX_SECONDARY_EXEC_TSC_SCALING              0x02000000
 #define VMX_SECONDARY_EXEC_ENABLE_USER_WAIT_PAUSE   0x04000000
 
@@ -1862,6 +1886,19 @@ typedef struct CPUArchState {
     }; /* break/watchpoints for dr[0..3] */
     int old_exception;  /* exception in flight */
 
+    /* Genericized architectural state for virtualization.  Work in progress */
+    bool nested_paging; /* Nested or extended hardware paging enabled */
+    bool vm_state_valid; /* Not all accelerators sync nested_cr3 */
+    bool enable_ept_accessed_dirty;
+    bool enable_mode_based_access_control;
+    uint8_t nested_pg_height;
+    uint8_t nested_pg_format; /* 0 == Intel EPT, 1 == AMD NPT */
+    uint64_t nested_pg_root;
+    /* End generic architctural state for virtualization */
+
+    /**** accelerator specific virtualization state *****/
+
+    /* TCG */
     uint64_t vm_vmcb;
     uint64_t tsc_offset;
     uint64_t intercept;
@@ -2212,8 +2249,28 @@ int x86_cpu_write_elf64_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
 int x86_cpu_write_elf32_qemunote(WriteCoreDumpFunction f, CPUState *cpu,
                                  DumpState *s);
 
+int get_pg_mode(CPUX86State *env);
+hwaddr x86_page_table_root(CPUState *cs, const PageTableLayout **layout,
+                           int mmu_idx);
+bool x86_get_pte(CPUState *cs, hwaddr node, int i, int height,
+                 DecodedPTE *pt_entry, vaddr vaddr_parent, bool debug,
+                 int mmu_idx, bool user_access, const MMUAccessType access_type,
+                 int *error_code, hwaddr *fault_addr,
+                 TranslateFaultStage2 *nested_fault);
+int x86_virtual_to_pte_index(CPUState *cs, vaddr vaddr_in, int height);
 bool x86_cpu_get_memory_mapping(CPUState *cpu, MemoryMappingList *list,
                                 Error **errp);
+bool x86_mon_init_page_table_iterator(CPUState *cpu, GString *buf, int mmu_idx,
+                                      struct mem_print_state *state);
+void x86_mon_info_pg_print_header(struct mem_print_state *state);
+bool x86_mon_flush_print_pg_state(CPUState *cs, struct mem_print_state *state);
+bool x86_ptw_translate(CPUState *cs, vaddr vaddress, hwaddr *hpa,
+                       bool debug, int mmu_idx, bool user_access,
+                       const MMUAccessType access_type, uint64_t *page_size,
+                       int *error_code, hwaddr *fault_addr,
+                       TranslateFaultStage2 *nested_fault, int *prot, bool *
+                       dirty);
+
 
 void x86_cpu_dump_state(CPUState *cs, FILE *f, int flags);
 
@@ -2363,7 +2420,6 @@ void host_cpuid(uint32_t function, uint32_t count,
 bool cpu_has_x2apic_feature(CPUX86State *env);
 
 /* helper.c */
-int get_pg_mode(CPUX86State *env);
 void x86_cpu_set_a20(X86CPU *cpu, int a20_state);
 void cpu_sync_avx_hflag(CPUX86State *env);
 
diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index becca2efa5..a81e1eac87 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -65,6 +65,8 @@
 #include "exec/memattrs.h"
 #include "trace.h"
 
+#include "vmcs12.h"
+
 #include CONFIG_DEVICES
 
 //#define DEBUG_KVM
@@ -4676,6 +4678,72 @@ static int kvm_get_nested_state(X86CPU *cpu)
         env->hflags &= ~HF_GUEST_MASK;
     }
 
+
+    if (env->hflags & HF_GUEST_MASK) {
+
+        /* Extract the EPTP value from vmcs12 structure, store in arch state */
+        if (env->nested_state->format == KVM_STATE_NESTED_FORMAT_VMX) {
+            struct vmcs12 *vmcs =
+                (struct vmcs12 *) env->nested_state->data.vmx->vmcs12;
+
+            assert(vmcs->hdr.revision_id == VMCS12_REVISION);
+
+            /* See if EPT is enabled */
+            if (vmcs->secondary_vm_exec_control &
+                VMX_SECONDARY_EXEC_ENABLE_EPT) {
+                env->nested_paging = true;
+                env->nested_pg_format = 0;
+
+                /* Decode the ept pointer following SDM 24.6.11 */
+                /* The height of the tree is encoded in bits 5:3, height -1 */
+                uint8_t height = (uint8_t) (vmcs->ept_pointer >> 3);
+                height &= 7;
+                height++;
+                env->nested_pg_height = height;
+                /* The accessed/dirty flag is in bit 6 of the EPTP*/
+                env->enable_ept_accessed_dirty =
+                    !!(vmcs->ept_pointer & (1 << 6));
+
+                /* Mask out low 12 bits, bits beyond physical addr width */
+                uint64_t phys_mask = MAKE_64BIT_MASK(0, cpu->phys_bits);
+                phys_mask &= ~0xfff;
+                env->nested_pg_root = vmcs->ept_pointer & phys_mask;
+
+                if (vmcs->secondary_vm_exec_control &
+                    VMX_SECONDARY_EXEC_ENABLE_MODE_BASED_EXC) {
+                    env->enable_mode_based_access_control = true;
+                } else {
+                    env->enable_mode_based_access_control = false;
+                }
+            } else {
+                env->nested_paging = false;
+                env->enable_mode_based_access_control = false;
+            }
+            env->vm_state_valid = true;
+        } else if (env->nested_state->format == KVM_STATE_NESTED_FORMAT_SVM) {
+            struct vmcb *vmcb = (struct vmcb *) env->nested_state->data.svm;
+
+            /* See if nested paging is enabled */
+            if (vmcb->control.nested_ctl & SVM_NPT_ENABLED) {
+                env->nested_paging = true;
+                env->nested_pg_format = 1;
+                env->nested_pg_root = vmcb->control.nested_cr3;
+
+                env->nested_pg_height = env->cr[4] & CR4_LA57_MASK ?
+                    5 : 4;
+
+                env->enable_ept_accessed_dirty = false;
+                env->enable_mode_based_access_control = false;
+
+            } else {
+                env->nested_paging = false;
+                env->enable_mode_based_access_control = false;
+            }
+            env->vm_state_valid = true;
+        }
+    }
+
+
     /* Keep HF2_GIF_MASK set on !SVM as x86_cpu_pending_interrupt() needs it */
     if (cpu_has_svm(env)) {
         if (env->nested_state->flags & KVM_STATE_NESTED_GIF_SET) {
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 2d766b2637..8ef92e7c42 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -32,6 +32,181 @@
 #include "qapi/qapi-commands-misc-target.h"
 #include "qapi/qapi-commands-misc.h"
 
+/********************* x86 specific hooks for printing page table stuff ****/
+
+const char *names[7] = {(char *)NULL, "PTE", "PDE", "PDP", "PML4", "Pml5",
+                        (char *)NULL};
+static char *pg_bits(CPUState *cs, hwaddr ent, int mmu_idx)
+{
+    static char buf[32];
+    CPUX86State *env = cpu_env(cs);
+
+    if (mmu_idx == 0
+        || (mmu_idx == 1
+            && env->vm_state_valid && env->nested_pg_format == 1)) {
+        snprintf(buf, 32, "%c%c%c%c%c%c%c%c%c%c",
+                 ent & PG_NX_MASK ? 'X' : '-',
+                 ent & PG_GLOBAL_MASK ? 'G' : '-',
+                 ent & PG_PSE_MASK ? 'S' : '-',
+                 ent & PG_DIRTY_MASK ? 'D' : '-',
+                 ent & PG_ACCESSED_MASK ? 'A' : '-',
+                 ent & PG_PCD_MASK ? 'C' : '-',
+                 ent & PG_PWT_MASK ? 'T' : '-',
+                 ent & PG_USER_MASK ? 'U' : '-',
+                 ent & PG_RW_MASK ? 'W' : '-',
+                 ent & PG_PRESENT_MASK ? 'P' : '-');
+    } else if (mmu_idx == 1) {
+        bool accessed = false;
+        bool dirty = false;
+        X86CPU *cpu = X86_CPU(cs);
+
+        if (cpu->env.enable_ept_accessed_dirty) {
+            accessed = !!(ent & PG_EPT_ACCESSED_MASK);
+            dirty = !!(ent & (PG_EPT_ACCESSED_MASK | PG_EPT_PSE_MASK));
+        }
+
+        snprintf(buf, 32, "%c%c%c%c%c%c%c   ",
+                 ent & PG_EPT_X_USER_MASK ? 'U' : '-',
+                 dirty ? 'D' : '-',
+                 accessed ? 'A' : '-',
+                 ent & PG_EPT_PSE_MASK ? 'S' : '-',
+                 ent & PG_EPT_X_SUPER_MASK ? 'X' : '-',
+                 ent & PG_EPT_W_MASK ? 'W' : '-',
+                 ent & PG_EPT_R_MASK ? 'R' : '-');
+    } else {
+        g_assert_not_reached();
+    }
+    return buf;
+}
+
+bool x86_mon_init_page_table_iterator(CPUState *cs, GString *buf, int mmu_idx,
+                                      struct mem_print_state *state)
+{
+    X86CPU *cpu = X86_CPU(cs);
+    CPUX86State *env = &cpu->env;
+
+    state->env = env;
+    state->buf = buf;
+    state->mmu_idx = mmu_idx;
+    state->flush_interior = false;
+    state->require_physical_contiguity = false;
+
+    for (int i = 0; i < MAX_HEIGHT; i++) {
+        state->vstart[i] = -1;
+        state->last_offset[i] = 0;
+    }
+    state->start_height = 0;
+
+    if (!(env->cr[0] & CR0_PG_MASK)) {
+        g_string_append_printf(buf, "PG disabled\n");
+        return false;
+    }
+
+    /* set va and pa width */
+    if (env->cr[4] & CR4_PAE_MASK) {
+        state->paw = 13;
+#ifdef TARGET_X86_64
+        if (env->hflags & HF_LMA_MASK) {
+            if (env->cr[4] & CR4_LA57_MASK) {
+                state->vaw = 15;
+                state->max_height = 5;
+            } else {
+                state->vaw = 12;
+                state->max_height = 4;
+            }
+        } else
+#endif
+        {
+            state->vaw = 8;
+            state->max_height = 3;
+        }
+    } else {
+        state->max_height = 2;
+        state->vaw = 8;
+        state->paw = 8;
+    }
+
+    return true;
+}
+
+void x86_mon_info_pg_print_header(struct mem_print_state *state)
+{
+    /* Header line */
+    g_string_append_printf(state->buf, "%-*s %-13s %-10s %*s%s\n",
+                           3 + 2 * (state->vaw - 3), "VPN range",
+                           "Entry", "Flags",
+                           2 * (state->max_height - 1), "",
+                           "Physical page(s)");
+}
+
+
+static void pg_print(CPUState *cs, GString *out_buf, uint64_t pt_ent,
+                     vaddr vaddr_s, vaddr vaddr_l,
+                     hwaddr paddr_s, hwaddr paddr_l,
+                     int offset_s, int offset_l,
+                     int height, int max_height, int vaw, int paw,
+                     uint64_t page_size, bool is_leaf, int mmu_idx)
+
+{
+    g_autoptr(GString) buf = g_string_new("");
+
+    /* VFN range */
+    g_string_append_printf(buf, "%*s[%0*"PRIx64"-%0*"PRIx64"] ",
+                           (max_height - height) * 2, "",
+                           vaw - 3, vaddr_s >> 12,
+                           vaw - 3, (vaddr_l + page_size - 1) >> 12);
+
+    /* Slot */
+    if (vaddr_s == vaddr_l) {
+        g_string_append_printf(buf, "%4s[%03x]    ",
+                               names[height], offset_s);
+    } else {
+        g_string_append_printf(buf, "%4s[%03x-%03x]",
+                               names[height], offset_s, offset_l);
+    }
+
+    /* Flags */
+    g_string_append_printf(buf, " %s", pg_bits(cs, pt_ent, mmu_idx));
+
+
+    /* Range-compressed PFN's */
+    if (is_leaf) {
+        if (vaddr_s == vaddr_l) {
+            g_string_append_printf(buf, " %0*"PRIx64,
+                                   paw - 3, (uint64_t)paddr_s >> 12);
+        } else {
+            g_string_append_printf(buf, " %0*"PRIx64"-%0*"PRIx64,
+                                   paw - 3, (uint64_t)paddr_s >> 12,
+                                   paw - 3, (uint64_t)paddr_l >> 12);
+        }
+    }
+
+    /* Trim line to fit screen */
+    g_string_truncate(buf, 79);
+
+    g_string_append_printf(out_buf, "%s\n", buf->str);
+}
+
+/* Returns true if it emitted anything */
+bool x86_mon_flush_print_pg_state(CPUState *cs, struct mem_print_state *state)
+{
+    bool ret = false;
+    for (int i = state->start_height; i > 0; i--) {
+        if (state->vstart[i] == -1) {
+            break;
+        }
+        ret = true;
+        pg_print(cs, state->buf, state->prot[i],
+                 state->vstart[i], state->vend[i],
+                 state->pstart, state->pend,
+                 state->offset[i], state->last_offset[i],
+                 i, state->max_height, state->vaw, state->paw,
+                 state->pg_size[i], i == state->leaf_height, state->mmu_idx);
+    }
+
+    return ret;
+}
+
 /* Perform linear address sign extension */
 static hwaddr addr_canonical(CPUArchState *env, hwaddr addr)
 {
-- 
2.34.1


