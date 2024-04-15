Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D3D4C4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 16:09:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwOsp-0005bp-8w; Mon, 15 Apr 2024 12:08:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1rwOsn-0005bQ-1U
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 12:08:37 -0400
Received: from mail-qk1-x72e.google.com ([2607:f8b0:4864:20::72e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <porter@cs.unc.edu>) id 1rwOsj-00073Z-1o
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 12:08:36 -0400
Received: by mail-qk1-x72e.google.com with SMTP id
 af79cd13be357-78d543db3a4so256537785a.0
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 09:08:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cs.unc.edu; s=google; t=1713197311; x=1713802111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hDXmSwLbcjNaQnScOxP9Ze3GLYB5cMD+w+myyikWS/A=;
 b=lQhcXQ4wSmYtK/ZYkLqLU7O2m189QiKIyBNvwwyHlr7u57DPS2gODUePX/XrZLaWew
 5cWdVd7eT+uFp7TWJ7JAnhtOqwdrChXMR8if8xeDLMMR/P5RQPoHkcoeAIxnRylLYga/
 sYR9ltChA9c7/Btsj6V/CdiIRTO/S23ekYfCqg08n7nWL1IBFejrcJaLi+4itA4uP9gT
 ZeZlE9pkcpGE/M1/VR9/MLLovQxmQSYSINxrxmUrBF2RXXX89ewJIqrr+/TQcN69r3Oe
 D42n6jpUj/wx5a1jui+aLYMf+8zNiQh67QnCb/vGwvUo6Lg+6aG46E2EO6COXeOa3j2o
 p8pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713197311; x=1713802111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hDXmSwLbcjNaQnScOxP9Ze3GLYB5cMD+w+myyikWS/A=;
 b=uJxk+miUaMxutSDDgRQoKQBKe7BJPHdBI4MACJs0iKiJRS7Gs1wm9vR3CF7JgsgYH4
 6sQ9b8BErepcyz41GK0T8ae/GQ2jav3hXuO/IqZc0HT+3xCflzSD0haE+Y9vvepx1DVz
 4pGCU7E1GCtL++yegt5WLUnvWdPghZJ4V5/bYMReoN+hrrRj+ufYN1lhL76qfxAyTSen
 cfoh3kGHAt5B6uas5Wj+kpgMaj9HrbjWuH2gMK9NJdGCDS1yUHPczY8GNWo2C1QWogZG
 BMpalIEgu2ATzO/pF+Pvt7GV5P8jZpnnO62ycyfmyjYdt81gdMeeT47wUoInyajCN96S
 VU7Q==
X-Gm-Message-State: AOJu0Yz3ggI3i083v0QddIadxnoFnutcQYRZce2lk6bFQvRkHsRsXVWP
 NW3cEoFzuk1ec5i+9gIsr+8TcaBxUEgO4yLYOgBnhnY8by9cFgxdl7IySiTpFh8yw1fwecKXyRh
 u/rg4nQnTHkxE2JKzNQnCIgoDzF1XD2uLfH5gEDmAE9enF/OLyLgg1NcCEQrQ5GI+4uQBWQB3Ey
 0mongID155IhvCW6hPtutAzkKAytpm
X-Google-Smtp-Source: AGHT+IGE1xUvqvKZk3wzdx7i+hnDLzVAYjVxplWoE9VhVoMmra5JiGfwtZjoSH9i7xBfllui0S611w==
X-Received: by 2002:a05:620a:4093:b0:78e:e007:441e with SMTP id
 f19-20020a05620a409300b0078ee007441emr5195118qko.16.1713197311155; 
 Mon, 15 Apr 2024 09:08:31 -0700 (PDT)
Received: from kermit.cs.unc.edu (kermit.cs.unc.edu. [152.2.133.133])
 by smtp.gmail.com with ESMTPSA id
 h7-20020a05620a21c700b0078d72553055sm6491341qka.11.2024.04.15.09.08.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Apr 2024 09:08:30 -0700 (PDT)
From: Don Porter <porter@cs.unc.edu>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, dave@treblig.org,
 Austin Clements <aclements@csail.mit.edu>,
 Geoffrey Thomas <geofft@ldpreload.com>, Don Porter <porter@cs.unc.edu>
Subject: [PATCH 2/2] monitor: Add an "info pg" command that prints the current
 page tables
Date: Mon, 15 Apr 2024 12:08:18 -0400
Message-Id: <20240415160818.2316599-3-porter@cs.unc.edu>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240415160818.2316599-1-porter@cs.unc.edu>
References: <20240415160818.2316599-1-porter@cs.unc.edu>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::72e;
 envelope-from=porter@cs.unc.edu; helo=mail-qk1-x72e.google.com
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

The new "info pg" monitor command prints the current page table,
including virtual address ranges, flag bits, and snippets of physical
page numbers.  Completely filled regions of the page table with
compatible flags are "folded", with the result that the complete
output for a freshly booted x86-64 Linux VM can fit in a single
terminal window.  The output looks like this:

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

Signed-off-by: Austin Clements <aclements@csail.mit.edu>
[geofft@ldpreload.com: Rebased on top of 2.9.0]
Signed-off-by: Geoffrey Thomas <geofft@ldpreload.com>
Signed-off-by: Don Porter <porter@cs.unc.edu>
---
 hmp-commands-info.hx         |  15 +++
 include/monitor/hmp-target.h |   2 +
 target/i386/monitor.c        | 179 ++++++++++++++++++++++++++++++++++-
 3 files changed, 195 insertions(+), 1 deletion(-)

diff --git a/hmp-commands-info.hx b/hmp-commands-info.hx
index ad1b1306e3..ae7de74041 100644
--- a/hmp-commands-info.hx
+++ b/hmp-commands-info.hx
@@ -239,6 +239,21 @@ SRST
     Show the active virtual memory mappings.
 ERST
 
+#if defined(TARGET_I386)
+    {
+        .name       = "pg",
+        .args_type  = "",
+        .params     = "",
+        .help       = "show the page table",
+        .cmd        = hmp_info_pg,
+    },
+#endif
+
+SRST                                                                               |
+  ``info pg``                                                                      |
+    Show the active page table.                                                    |
+ERST
+
     {
         .name       = "mtree",
         .args_type  = "flatview:-f,dispatch_tree:-d,owner:-o,disabled:-D",
diff --git a/include/monitor/hmp-target.h b/include/monitor/hmp-target.h
index d78e979f05..68f58d2a31 100644
--- a/include/monitor/hmp-target.h
+++ b/include/monitor/hmp-target.h
@@ -48,6 +48,8 @@ void hmp_info_mem(Monitor *mon, const QDict *qdict);
 void hmp_info_tlb(Monitor *mon, const QDict *qdict);
 void hmp_mce(Monitor *mon, const QDict *qdict);
 void hmp_info_local_apic(Monitor *mon, const QDict *qdict);
+void hmp_info_io_apic(Monitor *mon, const QDict *qdict);
+void hmp_info_pg(Monitor *mon, const QDict *qdict);
 void hmp_info_sev(Monitor *mon, const QDict *qdict);
 void hmp_info_sgx(Monitor *mon, const QDict *qdict);
 void hmp_info_via(Monitor *mon, const QDict *qdict);
diff --git a/target/i386/monitor.c b/target/i386/monitor.c
index 7924de6520..4cf39a4140 100644
--- a/target/i386/monitor.c
+++ b/target/i386/monitor.c
@@ -72,7 +72,6 @@ static bool ptiter_succ(PTIter *it);
  * top level.  On failure, prints a message to mon and returns false.
  */
 static bool
-__attribute__ ((unused))
 ptiter_init(Monitor *mon, PTIter *it)
 {
     static const PTLayout l32 = {
@@ -88,10 +87,16 @@ ptiter_init(Monitor *mon, PTIter *it)
         {"PML4", "PDP", "PDE", "PTE"}, 12, 13
     };
 #endif
+
     CPUArchState *env;
 
     env = mon_get_cpu_env(mon);
 
+    if (!env) {
+        monitor_printf(mon, "No CPU available\n");
+        return false;
+    }
+
     if (!(env->cr[0] & CR0_PG_MASK)) {
         monitor_printf(mon, "PG disabled\n");
         return false;
@@ -200,6 +205,178 @@ static hwaddr addr_canonical(CPUArchState *env, hwaddr addr)
     return addr;
 }
 
+/**
+ * Return true if the page tree rooted at iter is complete and
+ * compatible with compat.  last will be filled with the last entry at
+ * each level.  If false, does not change iter and last can be filled
+ * with anything; if true, returns with iter at the next entry on the
+ * same level, or the next parent entry if iter is on the last entry
+ * of this level.
+ */
+static bool pg_complete(PTIter *root, const PTIter compat[], PTIter last[])
+{
+    PTIter iter = *root;
+
+    if ((root->ent & 0xfff) != (compat[root->level].ent & 0xfff)) {
+        return false;
+    }
+
+    last[root->level] = *root;
+    ptiter_succ(&iter);
+    if (!root->leaf) {
+        /* Are all of the direct children of root complete? */
+        while (iter.level == root->level + 1) {
+            if (!pg_complete(&iter, compat, last)) {
+                return false;
+            }
+        }
+    }
+    assert(iter.level <= root->level);
+    assert(iter.level == root->level ?
+           iter.i[iter.level] == root->i[iter.level] + 1 : 1);
+    *root = iter;
+    return true;
+}
+
+static char *pg_bits(uint64_t ent)
+{
+    static char buf[32];
+    sprintf(buf, "%c%c%c%c%c%c%c%c%c%c",
+            /* TODO: Some of these change depending on level */
+            ent & PG_NX_MASK ? 'X' : '-',
+            ent & PG_GLOBAL_MASK ? 'G' : '-',
+            ent & PG_PSE_MASK ? 'S' : '-',
+            ent & PG_DIRTY_MASK ? 'D' : '-',
+            ent & PG_ACCESSED_MASK ? 'A' : '-',
+            ent & PG_PCD_MASK ? 'C' : '-',
+            ent & PG_PWT_MASK ? 'T' : '-',
+            ent & PG_USER_MASK ? 'U' : '-',
+            ent & PG_RW_MASK ? 'W' : '-',
+            ent & PG_PRESENT_MASK ? 'P' : '-');
+    return buf;
+}
+
+static void pg_print(Monitor *mon, PTIter *s, PTIter *l)
+{
+    int lev = s->level;
+    char buf[128];
+    char *pos = buf, *end = buf + sizeof(buf);
+
+    /* VFN range */
+    pos += sprintf(pos, "%*s[%0*"PRIx64"-%0*"PRIx64"] ",
+                   lev * 2, "",
+                   s->layout->vaw - 3, (uint64_t)s->va >> 12,
+                   s->layout->vaw - 3, ((uint64_t)l->va + l->size - 1) >> 12);
+
+    /* Slot */
+    if (s->i[lev] == l->i[lev]) {
+        pos += sprintf(pos, "%4s[%03x]    ",
+                       s->layout->names[lev], s->i[lev]);
+    } else {
+        pos += sprintf(pos, "%4s[%03x-%03x]",
+                       s->layout->names[lev], s->i[lev], l->i[lev]);
+    }
+
+    /* Flags */
+    pos += sprintf(pos, " %s", pg_bits(s->ent));
+
+    /* Range-compressed PFN's */
+    if (s->leaf) {
+        PTIter iter = *s;
+        int i = 0;
+        bool exhausted = false;
+        while (!exhausted && i++ < 10) {
+            hwaddr pas = iter.pa, pae = iter.pa + iter.size;
+            while (ptiter_succ(&iter) && iter.va <= l->va) {
+                if (iter.level == s->level) {
+                    if (iter.pa == pae) {
+                        pae = iter.pa + iter.size;
+                    } else {
+                        goto print;
+                    }
+                }
+            }
+            exhausted = true;
+
+print:
+            if (pas >> 12 == (pae - 1) >> 12) {
+                pos += snprintf(pos, end - pos, " %0*"PRIx64,
+                                s->layout->paw - 3, (uint64_t)pas >> 12);
+            } else {
+                pos += snprintf(pos, end - pos, " %0*"PRIx64"-%0*"PRIx64,
+                                s->layout->paw - 3, (uint64_t)pas >> 12,
+                                s->layout->paw - 3, (uint64_t)(pae - 1) >> 12);
+            }
+            pos = MIN(pos, end);
+        }
+    }
+
+    /* Trim line to fit screen */
+    if (pos - buf > 79) {
+        strcpy(buf + 77, "..");
+    }
+
+    monitor_printf(mon, "%s\n", buf);
+}
+
+void hmp_info_pg(Monitor *mon, const QDict *qdict)
+{
+    PTIter iter;
+
+    if (!ptiter_init(mon, &iter)) {
+        return;
+    }
+
+    /* Header line */
+    monitor_printf(mon, "%-*s %-13s %-10s %*s%s\n",
+                   3 + 2 * (iter.layout->vaw - 3), "VPN range",
+                   "Entry", "Flags",
+                   2 * (iter.layout->levels - 1), "", "Physical page");
+
+    while (iter.level >= 0) {
+        int i, startLevel, maxLevel;
+        PTIter start[4], last[4], nlast[4];
+        bool compressed = false;
+
+        /* Skip to the next present entry */
+        do { } while (!iter.present && ptiter_succ(&iter));
+        if (iter.level < 0) {
+            break;
+        }
+
+        /*
+         * Find a run of complete entries starting at iter and staying
+         * on the same level.
+         */
+        startLevel = iter.level;
+        memset(start, 0, sizeof(start));
+        do {
+            start[iter.level] = iter;
+        } while (!iter.leaf && ptiter_succ(&iter));
+        maxLevel = iter.level;
+        iter = start[startLevel];
+        while (iter.level == startLevel && pg_complete(&iter, start, nlast)) {
+            compressed = true;
+            memcpy(last, nlast, sizeof(last));
+        }
+
+        if (compressed) {
+            /*
+             * We found a run we can show as a range spanning
+             * [startLevel, maxLevel].  start stores the first entry
+             * at each level and last stores the last entry.
+             */
+            for (i = startLevel; i <= maxLevel; i++) {
+                pg_print(mon, &start[i], &last[i]);
+            }
+        } else {
+            /* No luck finding a range.  Iter hasn't moved. */
+            pg_print(mon, &iter, &iter);
+            ptiter_succ(&iter);
+        }
+    }
+}
+
 static void print_pte(Monitor *mon, CPUArchState *env, hwaddr addr,
                       hwaddr pte, hwaddr mask)
 {
-- 
2.25.1


