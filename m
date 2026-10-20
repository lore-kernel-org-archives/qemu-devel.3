Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16AB3606A321
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Oct 2026 00:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=qAQzoMPf
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIxXN-000587-3n; Mon, 19 Oct 2026 20:17:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1xIxXJ-00057D-5Y
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 20:17:01 -0400
Received: from mailout4.samsung.com ([203.254.224.34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1xIxXG-0003NP-Ct
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 20:17:00 -0400
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
 by mailout4.samsung.com (KnoxPortal) with ESMTP id
 20261020001648epoutp04be42afda8b543500159c2c8ae46b0c90~gFLKJ38hk3231232312epoutp04A
 for <qemu-devel@nongnu.org>; Tue, 20 Oct 2026 00:16:48 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com
 20261020001648epoutp04be42afda8b543500159c2c8ae46b0c90~gFLKJ38hk3231232312epoutp04A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1792455408;
 bh=O/LWpu9ji47KoO5L7wdT76E66qdnoGz4d33oAhpQhDI=;
 h=Subject:Reply-To:From:To:CC:Date:References:From;
 b=qAQzoMPfDfeZW6s6zTXk/KT2r28SxM6LdGzp8QBXXR+yAOGSsQBkMvMQqxBGGq4EO
 URgWkxHoDGpWZzpYiG0AxCYbwR3xl+AfIBqzP9OiC3Llla4WjLXOEv6QmuBrLBuX6S
 PsDU+JyPeHVC/9qZGoJ0r/2ffOwDzA1VjvisCAFg=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
 epcas2p4.samsung.com (KnoxPortal) with ESMTPS id
 20261020001648epcas2p4bd4affd25b3e9ac7c3319c24d8e8eefc~gFLJmEUbO0045500455epcas2p4A;
 Tue, 20 Oct 2026 00:16:48 +0000 (GMT)
Received: from epcas2p2.samsung.com (unknown [182.195.38.201]) by
 epsnrtp01.localdomain (Postfix) with ESMTP id 4j7tJH5fZyz6B9mF; Tue, 20 Oct
 2026 00:16:47 +0000 (GMT)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Subject: [PATCH v3 0/6] Support for Zoned UFS
From: Daejun Park <daejun7.park@samsung.com>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
CC: Jeuk Kim <jeuk20.kim@samsung.com>, "farosas@suse.de" <farosas@suse.de>,
 "lvivier@redhat.com" <lvivier@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "hreitz@redhat.com" <hreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, "pierrick.bouvier@oss.qualcomm.com"
 <pierrick.bouvier@oss.qualcomm.com>, "stanleyjhu@google.com"
 <stanleyjhu@google.com>, Keoseong Park <keosung.park@samsung.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, Daejun Park
 <daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20261020001647epcms2p52cd58173164a43e252c33a3eb5935dc8@epcms2p5>
Date: Tue, 20 Oct 2026 09:16:47 +0900
X-CMS-MailID: 20261020001647epcms2p52cd58173164a43e252c33a3eb5935dc8
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261020001647epcms2p52cd58173164a43e252c33a3eb5935dc8
References: <CGME20261020001647epcms2p52cd58173164a43e252c33a3eb5935dc8@epcms2p5>
Received-SPF: pass client-ip=203.254.224.34;
 envelope-from=daejun7.park@samsung.com; helo=mailout4.samsung.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.329,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series lets a ufs-lu be a host-managed zoned block device (ZBC)
with zoned=on, so that the zoned storage stack, for example f2fs on
host-managed zones, can be tested on UFS without zoned UFS hardware.
Patches 1-3 fix the command path that the zoned code relies on and can
be merged first; patch 4 documents zoned logical units, patch 5 adds
them and patch 6 the tests.

Not modelled: persistent zone state, conventional and gap zones, and the
zoned UFS descriptor bits.

Tested with the UFS qtests (also under ASan and UBSan) and with Linux
7.3-rc7 and android17-6.18 guests, legacy doorbell and MCQ: fio
--zonemode=zbd with verification, blkzone, and f2fs on android17-6.18.

Changes in v3:
- 1/6: fail a missing PRDT with OCS MISMATCH DATA BUFFER SIZE instead of
  INVALID COMMAND TABLE ATTRIBUTES.
- 3/6, retitled from "Limit data transfers to the transfer length of
  the CDB": also fail a request whose PRDT is shorter than the transfer
  length, with the same OCS before it reaches scsi-hd, as proposed in
  reply to Stanley [1]. ufs_fit_data_buffer() in ufs.c fits the PRDT;
  ufs-lu passes it the parsed transfer length. The HID qtest wrote eight
  blocks from a one-block buffer and now has eight blocks.
- 5/6: reject WRITE SAME(10/16) on zoned logical units with INVALID
  COMMAND OPERATION CODE and clear its bits in the Logical Block
  Provisioning VPD page (Stanley). Change the zone of a write only once
  scsi-hd has accepted the write: in v2, a write that scsi-hd refused,
  for example for its WRPROTECT field, could still open its zone or close
  another one. A write with a short PRDT changes no zone either; REPORT
  ZONES and the ZBC VPD page follow the same PRDT rule.
- 4/6, 6/6: documentation and tests follow.
- Rebased on current master.
- Link to v2: https://lore.kernel.org/qemu-devel/20261016092423epcms2p83f80a8dd8f7c1ddc3a94541e0771c306@epcms2p8

[1] https://lore.kernel.org/qemu-devel/20261019013307epcms2p14049cf5797cbe5332877ddeb950f18bc@epcms2p1

Changes in v2:
- Drop the hw/scsi patch: scsi-hd stays TYPE_DISK and ufs-lu reports
  TYPE_ZBC itself. With v1's TYPE_ZBC scsi-hd, MODE SENSE failed and the
  guest never sent a flush.
- New patches 1-3: a crash on commands without a PRDT, SYNCHRONIZE
  CACHE(16), and PRDTs longer than the CDB transfer length.
- Fix v1's REPORT ZONES buffer overflow, NULL zone dereference past the
  last zone, division by zero with zoned.zone_size=0, and its zone state
  handling.
- Move the write pointer back when a write fails or is aborted, reject
  UNMAP, drop zoned.zone_capacity.
- Add trace events, tests and documentation.
- Jeuk's Reviewed-by on v1 is not carried over, since both patches
  changed substantially.
- Link to v1: https://lore.kernel.org/qemu-devel/20231208060902epcms2p3810b29fefbddaf16a7f3f2758cf218ba@epcms2p3

---
Daejun Park (6):
      hw/ufs: Fail SCSI commands that move data without a PRDT
      hw/ufs: Pass SYNCHRONIZE CACHE(16) to scsi-hd as SYNCHRONIZE CACHE(10)
      hw/ufs: Check the PRDT size against the transfer length of the CDB
      docs/system: Document zoned UFS logical units
      hw/ufs: Support for Zoned UFS
      tests/qtest: Add tests for Zoned UFS

 docs/system/devices/ufs.rst |   55 ++
 hw/ufs/lu.c                 |  930 ++++++++++++++++++++++++++++-
 hw/ufs/trace-events         |    7 +
 hw/ufs/ufs.c                |   45 +-
 hw/ufs/ufs.h                |   46 ++
 include/block/ufs.h         |   27 +
 tests/qtest/ufs-test.c      | 1368 ++++++++++++++++++++++++++++++++++++++++++-
 7 files changed, 2470 insertions(+), 8 deletions(-)
---
base-commit: a19f59a72d96056d9a8f48cf6c77f5787491e414
change-id: 20261016-zoned-ufs-0a6c741446a9

Best regards,
-- 
Daejun Park <daejun7.park@samsung.com>

