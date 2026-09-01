Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE20CC624D0
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2026 19:29:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1UAM-0003fD-5u; Tue, 01 Sep 2026 15:29:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1x1UAJ-0003eA-Ud
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 15:29:03 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1x1UAI-0008Qr-0t
 for qemu-devel@nongnu.org; Tue, 01 Sep 2026 15:29:03 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-c1c26d7e951so22992666b.0
 for <qemu-devel@nongnu.org>; Tue, 01 Sep 2026 12:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788290940; x=1788895740; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=K5OIDGcdu8O702SibJFP3wHFVEQwsbROFxJdZM8SmHA=;
 b=NNpck7k1wwij7cOp9rirHtvuDxtFZhDri901QjCnL1qdG64YraWo8Cc7HAGA1/eePL
 DZJatI1xpVnL1Bm8WOizCdCuSGzLpW5IPHdhy2Em0hsrtI2Qw9q6XsOdp8B/5VG+r6CF
 YBgn7yp/1BxklJMA2HxjZxbnXl4mwOVv9ALmVbt7GltwG51aRQP/rhVRRxevVrvEWpeu
 Faa/w1o8gMwF2FP3Urg2A3UfomEPIxvKsWFFlgVd+3ex2Fu7QjkKwyBCGnlosdehMJrr
 ebJ0bVNJ9zbDHqOkU2nNXyHn9m8W//lP6Wigs+mgdonZeqv1X59W4By7yMJRPCTuUJfD
 OEJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788290940; x=1788895740;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=K5OIDGcdu8O702SibJFP3wHFVEQwsbROFxJdZM8SmHA=;
 b=cao5iQZ1Vqj964VJ2oO3py5G+3aqAmIxx13h3z/49KDKl+bpxpSdAv2Jua2eEynKrQ
 jMxwKzV0qys1gLotEeXosvsrlRqRm3kgzlPAInNtPn9RuDje7CfxprD3Fb2oxDSPapOq
 d+alyNYzrJ8ptfPoXXaPa89EQYbOZCJrGaWdftASVZcB/LsYhXpdAmrJE6qavOXtjz94
 ys85Npcel9f/DaIJqKtydDbK8opwMTQH4Qao/JRGyvoPJmefXr7GMp0D5VnkRvjJSva+
 5FUL8S0ai3htOO5HppA34BhkLv+eqH1nAV75/w5Md3yvn+mUPAQtB4opEI8wZieFBnjS
 spSA==
X-Gm-Message-State: AFuF++mWvneuKmZUu16E2ummFxA3aXZGdICy7A1//GQrzkdEWK64DUMR
 ypz/RW8KQ2Y4pyNmf5osG4qnpdoVr0SoLgpg09vYusIGtPEVz2SxcBeDKMyiQehSIVc=
X-Gm-Gg: AR+sD11CyqjmICx5g+y6+enNWhnxLt1tOHhByWhVRIlvzAcBbgmEgARkag6wBVtDt9m
 Ts0sx2JUK5AQCbJx20TuuYalvTOVQ/VdTsgVmIIF2E1Y7CCsXEv1iN5jOLKgyGNNillKsDFW4XW
 2Ujm3VpIYq2S/cNAMH/Mo8iWMYcUOw6UqqRDX7baDK2x2yFh5oNQhqJiJwqsml+u1chwjo7OyiL
 hU4DqSoMsaBuwOaIypgCAiYrvwi+elpXNcENaTzQf6fCUeOsmOEdnQYM0lqQJxlCKLxtLEyLTIK
 i42/U/aDSRwogw8FUZIrbLYoC+Rr4oF5f64PTxMu5eAHZmY4sFh//IAG5JZHJ87QPmQ9pIoNFAz
 xPYIYQzP4FBC8bRoJAkCDSwQFJS/O553jp/FmTobMjKXPoj7os6shEZpyXccQeNbMoa1MZOa6/t
 EzOPw5rHICtb6ia5/VeAkGe01D35emEj1ch8M3pXoRkgIRXY1REnWB/cMEBK6/W6Rr+Y5TJQjD/
 yHuQTBkG8CWSUk1u3DS/NlZceY9+ZnvVv8rkpkpJTzaDRMWjgBfqhDv7g6woEo5XuuBp4EDJjH8
X-Received: by 2002:a17:906:158c:b0:c25:378c:6262 with SMTP id
 a640c23a62f3a-c25b3d56249mr633469966b.22.1788290939455; 
 Tue, 01 Sep 2026 12:28:59 -0700 (PDT)
Received: from tulp.my.domain
 (2001-1c02-1a15-3000-ee82-4536-a8f2-9e22.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:ee82:4536:a8f2:9e22])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c25d002fa72sm14440466b.22.2026.09.01.12.28.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Sep 2026 12:28:59 -0700 (PDT)
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: qemu-devel@nongnu.org
Cc: Roman Bogorodskiy <bogorodskiy@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>, Eric Blake <eblake@redhat.com>
Subject: [PATCH v2] qga: implement 'guest-get-diskstats' for FreeBSD
Date: Tue,  1 Sep 2026 21:27:31 +0200
Message-ID: <20260901192732.46190-1-bogorodskiy@gmail.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x636.google.com
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

Implement the 'guest-get-diskstats' for FreeBSD.
This implementation uses the devstat(3) library which is a part
of the FreeBSD base system.

The build system is updated to link qga with `-ldevstat`.

Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
Acked-by: Markus Armbruster <armbru@redhat.com> (QAPI schema)
---
Changes since v1:
 - Replace the guest_diskstats_append() helper with a simpler guest_diskstats_info_new().
 - Drop the unnecessary condition for ios_pgr.
 - Drop the unnecessary guest_get_diskstats() wrapper.
 - Jump to error on devstat_getdevs() as it does allocations.

 qga/commands-bsd.c   | 120 +++++++++++++++++++++++++++++++++++++++++++
 qga/meson.build      |   3 ++
 qga/qapi-schema.json |   6 +--
 3 files changed, 126 insertions(+), 3 deletions(-)

diff --git a/qga/commands-bsd.c b/qga/commands-bsd.c
index 94ff6fee6a..6a1aadee8d 100644
--- a/qga/commands-bsd.c
+++ b/qga/commands-bsd.c
@@ -14,6 +14,7 @@
 #include "qga-qapi-commands.h"
 #include "qapi/error.h"
 #include "qemu/queue.h"
+#include "block/block-common.h"
 #include "commands-common.h"
 #include <sys/ioctl.h>
 #include <sys/param.h>
@@ -27,6 +28,9 @@
 #include <net/ethernet.h>
 #endif
 #include <paths.h>
+#ifdef CONFIG_FREEBSD
+#include <devstat.h>
+#endif
 
 #if defined(CONFIG_FSFREEZE) || defined(CONFIG_FSTRIM)
 bool build_fs_mount_list(FsMountList *mounts, Error **errp)
@@ -178,3 +182,119 @@ bool guest_get_hw_addr(struct ifaddrs *ifa, unsigned char *buf,
     return true;
 }
 #endif /* HAVE_GETIFADDRS */
+
+#ifdef CONFIG_FREEBSD
+static uint64_t bintime_to_msec(const struct bintime *bt)
+{
+    return (uint64_t)bt->sec * 1000ULL + (((bt->frac >> 32) * 1000ULL) >> 32);
+}
+
+static GuestDiskStatsInfo *
+guest_diskstats_info_new(const struct devstat *dev)
+{
+    GuestDiskStatsInfo *diskstatinfo;
+    GuestDiskStats *diskstat;
+
+    diskstatinfo = g_new0(GuestDiskStatsInfo, 1);
+    diskstatinfo->name = g_strdup_printf("%s%d", dev->device_name,
+                                         dev->unit_number);
+    /*
+     * devstat does not expose Linux-style major/minor numbers.  Report the
+     * devstat device number and unit number in these mandatory QAPI fields.
+     */
+    diskstatinfo->major = dev->device_number;
+    diskstatinfo->minor = dev->unit_number;
+
+    diskstat = g_new0(GuestDiskStats, 1);
+    diskstat->has_read_ios = true;
+    diskstat->read_ios = dev->operations[DEVSTAT_READ];
+    diskstat->has_read_sectors = true;
+    diskstat->read_sectors = dev->bytes[DEVSTAT_READ] / BDRV_SECTOR_SIZE;
+    diskstat->has_read_ticks = true;
+    diskstat->read_ticks = bintime_to_msec(&dev->duration[DEVSTAT_READ]);
+
+    diskstat->has_write_ios = true;
+    diskstat->write_ios = dev->operations[DEVSTAT_WRITE];
+    diskstat->has_write_sectors = true;
+    diskstat->write_sectors = dev->bytes[DEVSTAT_WRITE] / BDRV_SECTOR_SIZE;
+    diskstat->has_write_ticks = true;
+    diskstat->write_ticks = bintime_to_msec(&dev->duration[DEVSTAT_WRITE]);
+
+    diskstat->has_discard_ios = true;
+    diskstat->discard_ios = dev->operations[DEVSTAT_FREE];
+    diskstat->has_discard_sectors = true;
+    diskstat->discard_sectors = dev->bytes[DEVSTAT_FREE] / BDRV_SECTOR_SIZE;
+    diskstat->has_discard_ticks = true;
+    diskstat->discard_ticks = bintime_to_msec(&dev->duration[DEVSTAT_FREE]);
+
+    diskstat->has_ios_pgr = true;
+    diskstat->ios_pgr = dev->start_count - dev->end_count;
+
+    diskstat->has_total_ticks = true;
+    diskstat->total_ticks = bintime_to_msec(&dev->busy_time);
+
+    diskstatinfo->stats = diskstat;
+    return diskstatinfo;
+}
+
+GuestDiskStatsInfoList *qmp_guest_get_diskstats(Error **errp)
+{
+    GuestDiskStatsInfoList *head = NULL, **tail = &head;
+    struct devinfo dinfo = { 0 };
+    struct statinfo stats = { .dinfo = &dinfo };
+    struct device_selection *dev_select = NULL;
+    struct devstat_match matches[] = {
+        {
+            .match_fields = DEVSTAT_MATCH_TYPE,
+            .device_type = DEVSTAT_TYPE_DIRECT,
+            .num_match_categories = 1,
+        },
+    };
+    int num_selected = 0;
+    int num_selections = 0;
+    long select_generation = 0;
+    int i;
+
+    if (devstat_checkversion(NULL) == -1) {
+        error_setg(errp, "%s", devstat_errbuf);
+        return NULL;
+    }
+
+    if (devstat_getdevs(NULL, &stats) == -1) {
+        error_setg(errp, "%s", devstat_errbuf);
+        goto error;
+    }
+
+    if (devstat_selectdevs(&dev_select, &num_selected, &num_selections,
+                           &select_generation, stats.dinfo->generation,
+                           stats.dinfo->devices, stats.dinfo->numdevs,
+                           matches, ARRAY_SIZE(matches), NULL, 0,
+                           DS_SELECT_ONLY,
+                           stats.dinfo->numdevs, 0) == -1) {
+        error_setg(errp, "%s", devstat_errbuf);
+        goto error;
+    }
+
+    for (i = 0; i < num_selections; i++) {
+        const struct devstat *dev;
+
+        if (dev_select[i].selected == 0) {
+            continue;
+        }
+
+        dev = &stats.dinfo->devices[dev_select[i].position];
+        QAPI_LIST_APPEND(tail, guest_diskstats_info_new(dev));
+    }
+
+    free(stats.dinfo->mem_ptr);
+    free(dev_select);
+    return head;
+
+error:
+    qapi_free_GuestDiskStatsInfoList(head);
+    free(stats.dinfo->mem_ptr);
+    free(dev_select);
+    return NULL;
+}
+
+#endif /* CONFIG_FREEBSD */
diff --git a/qga/meson.build b/qga/meson.build
index cfa2157efb..a046ebe305 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -93,6 +93,9 @@ qga_ss = qga_ss.apply({})
 
 gen_tlb = []
 qga_libs = []
+if host_os == 'freebsd'
+  qga_libs += ['-ldevstat']
+endif
 if host_os == 'windows'
   qga_libs += ['-lws2_32', '-lwinmm', '-lpowrprof', '-lwtsapi32', '-lwininet', '-liphlpapi', '-lnetapi32',
                '-lsetupapi', '-lcfgmgr32', '-luserenv', '-lpdh' ]
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index c57bc9a02f..0d1476dcc4 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -1714,7 +1714,7 @@
            '*total-ticks': 'uint64',
            '*weight-ticks': 'uint64'
            },
-  'if': 'CONFIG_LINUX' }
+  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_FREEBSD'] } }
 
 ##
 # @GuestDiskStatsInfo:
@@ -1732,7 +1732,7 @@
            'major': 'uint64',
            'minor': 'uint64',
            'stats': 'GuestDiskStats' },
-  'if': 'CONFIG_LINUX' }
+  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_FREEBSD'] } }
 
 ##
 # @guest-get-diskstats:
@@ -1745,7 +1745,7 @@
 ##
 { 'command': 'guest-get-diskstats',
   'returns': ['GuestDiskStatsInfo'],
-  'if': 'CONFIG_LINUX'
+  'if': { 'any': ['CONFIG_LINUX', 'CONFIG_FREEBSD'] }
 }
 
 ##
-- 
2.55.0


