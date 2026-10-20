Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 254D9606A31A
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 00:20:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=Zq0Z4bdH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIxaJ-0006vx-RF; Mon, 19 Oct 2026 20:20:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1xIxaH-0006vV-QX
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 20:20:05 -0400
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1xIxaE-0003ZO-Pu
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 20:20:05 -0400
Received: from epcas2p4.samsung.com (unknown [182.195.41.56])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20261020001959epoutp02ead7fc9c7a14a8c4c5e7073d09c621d4~gFN77Q8wo3049430494epoutp02g
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 00:19:59 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20261020001959epoutp02ead7fc9c7a14a8c4c5e7073d09c621d4~gFN77Q8wo3049430494epoutp02g
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1792455599;
 bh=nMiVJqA0HitjeW0T9xrvU/y8ho7zI+rBDiFH1CtMKko=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=Zq0Z4bdHA2KSN+73sMRU0jpy6ZE8sk6yYFJ9//v0J3vjQ1a9/Dt+muXvcHL2r6q9n
 hSotWO99dAvsSVP0be1wm8qGXab2WwmEeqnNKFH1zFmuiQVCA7Xa4/m3vLqWJ+m6BP
 wrZD8TuUjUvURYReHV08BaDPs2gP0sOVvkoe0wxg=
Received: from epsnrtp03.localdomain (unknown [182.195.42.155]) by
 epcas2p3.samsung.com (KnoxPortal) with ESMTPS id
 20261020001959epcas2p3761b54091037a8e28f9cfa4752454ff0~gFN7o_hBP3172931729epcas2p3l;
 Tue, 20 Oct 2026 00:19:59 +0000 (GMT)
Received: from epcas2p4.samsung.com (unknown [182.195.38.203]) by
 epsnrtp03.localdomain (Postfix) with ESMTP id 4j7tMy715zz3hhT4; Tue, 20 Oct
 2026 00:19:58 +0000 (GMT)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Subject: [PATCH v3 4/6] docs/system: Document zoned UFS logical units
From: Daejun Park <daejun7.park@samsung.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Jeuk Kim <jeuk20.kim@samsung.com>, "farosas@suse.de" <farosas@suse.de>,
 "lvivier@redhat.com" <lvivier@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "hreitz@redhat.com" <hreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, "pierrick.bouvier@oss.qualcomm.com"
 <pierrick.bouvier@oss.qualcomm.com>, "stanleyjhu@google.com"
 <stanleyjhu@google.com>, Keoseong Park <keosung.park@samsung.com>, Daejun
 Park <daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <20261020001647epcms2p52cd58173164a43e252c33a3eb5935dc8@epcms2p5>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20261020001958epcms2p71f9e9ddf12328d5789a672c1fe4879b0@epcms2p7>
Date: Tue, 20 Oct 2026 09:19:58 +0900
X-CMS-MailID: 20261020001958epcms2p71f9e9ddf12328d5789a672c1fe4879b0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261020001647epcms2p52cd58173164a43e252c33a3eb5935dc8
References: <20261020001647epcms2p52cd58173164a43e252c33a3eb5935dc8@epcms2p5>
 <CGME20261020001647epcms2p52cd58173164a43e252c33a3eb5935dc8@epcms2p7>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=daejun7.park@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: daejun7.park@samsung.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Describe the zoned, zoned.zone_size and zoned.max_open properties of
ufs-lu with an example, what a zoned logical unit emulates and what it
rejects, that reads above the write pointer return what the drive
holds, that zone state is not persistent and that the drive cannot be
resized.

Signed-off-by: Daejun Park <daejun7.park@samsung.com>
---
 docs/system/devices/ufs.rst | 55 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 55 insertions(+)

diff --git a/docs/system/devices/ufs.rst b/docs/system/devices/ufs.rst
index d3482e9299..a76fdbe76e 100644
--- a/docs/system/devices/ufs.rst
+++ b/docs/system/devices/ufs.rst
@@ -74,6 +74,61 @@ Logical Unit Properties
   Logical unit number, 0 to 31. A host controller accepts up to 32
   logical units.
 
+``zoned`` (default off)
+  Present the logical unit as a host-managed zoned block device (ZBC).
+  All zones are sequential write required zones whose capacity is their
+  size. The drive must be writable.
+
+``zoned.zone_size`` (default 128M)
+  Zone size in bytes: a multiple of the 4 KiB logical block size, below
+  16 TiB and not larger than the drive. A logical unit has at most
+  67108862 zones. Linux also requires a power of two. The last zone is
+  smaller when the capacity is not a multiple of the zone size.
+
+``zoned.max_open`` (default 6)
+  Maximum number of open zones; 0 means no limit. When the limit is
+  reached, a write to another zone closes an implicitly open zone, and
+  fails with INSUFFICIENT ZONE RESOURCES if every open zone was opened
+  explicitly. f2fs needs at least as many as its active logs, 6 by
+  default.
+
+Zoned Logical Units
+===================
+
+The following adds a regular logical unit and a zoned one with 64 MiB
+zones:
+
+.. code-block:: console
+
+    -drive file=lu0.img,if=none,id=lu0,format=raw \
+    -drive file=lu1.img,if=none,id=lu1,format=raw \
+    -device ufs,id=ufs0,serial=0001 \
+    -device ufs-lu,drive=lu0,bus=ufs0,lun=0 \
+    -device ufs-lu,drive=lu1,bus=ufs0,lun=1,zoned=on,zoned.zone_size=64M
+
+A Linux guest needs ``CONFIG_BLK_DEV_ZONED``. f2fs keeps its metadata on
+a regular logical unit, for example ``mkfs.f2fs -m -c /dev/sdb /dev/sda``
+with the zoned logical unit as ``/dev/sdb``.
+
+The zoned logical unit reports the ZBC device type in its INQUIRY data,
+handles REPORT ZONES and the OPEN, CLOSE, FINISH and RESET WRITE POINTER
+zone operations, and checks every WRITE and WRITE AND VERIFY command
+against the write pointer of its zone. Zone operations act on one zone
+or, with the ALL bit, on every zone; a ZONE COUNT above 1 is rejected.
+The logical unit does not support WRITE SAME or UNMAP and reports no
+logical block provisioning. All other commands, including reads, MODE
+SENSE and SYNCHRONIZE CACHE, behave as on a regular logical unit. FORMAT
+UNIT changes neither data nor zones.
+
+Reads are not restricted by the write pointer: reads above it, including
+reads of a zone after RESET WRITE POINTER, return whatever the drive
+holds. Zone conditions and write pointers are kept in memory only: after
+QEMU restarts every zone is empty again while the drive keeps its data,
+so the write pointers no longer match what a file system wrote. The zone
+layout is set when the logical unit is created; resizing its drive is
+not supported. Zone conditions and write pointers, open zones included,
+are kept across a host controller reset and a system reset.
+
 Limitations
 ===========
 

-- 
2.43.0

