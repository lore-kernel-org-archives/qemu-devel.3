Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10623CD8C9D
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 02:47:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWmUb-00067E-5F; Mon, 08 Jun 2026 22:47:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keosung.park@samsung.com>)
 id 1wWmUS-00066Q-La
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 22:46:58 -0400
Received: from mailout3.samsung.com ([203.254.224.33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <keosung.park@samsung.com>)
 id 1wWmUK-0004go-HF
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 22:46:55 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout3.samsung.com (KnoxPortal) with ESMTP id
 20260609023911epoutp035ec4a042e9dffe66a5c45877308e9a11~3SUf8gyeb0470104701epoutp03j
 for <qemu-devel@nongnu.org>; Tue,  9 Jun 2026 02:39:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com
 20260609023911epoutp035ec4a042e9dffe66a5c45877308e9a11~3SUf8gyeb0470104701epoutp03j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1780972751;
 bh=K/xM4WfrFl0uMI+y35XwUt0Uv0bChTBQpi5UqmRgNwA=;
 h=Subject:Reply-To:From:To:CC:Date:References:From;
 b=uJ8POaR4xk42E4frioXbByk32DC/Ia1dSs8uPLupqlQbiQNjmmX8ehUFFTIvkhS5u
 rfy7UEJYRzqGhKp/s1egrx5e/YGmbrXEDBro8GBNuR2EOmfZAq5B1GVFlkSIpN74jJ
 ooqjsktZPt0A+2gQrzDWc+Bpwa/uRxYcwijZ65fA=
Received: from epsnrtp04.localdomain (unknown [182.195.42.156]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
 20260609023910epcas2p25ceb3fb2f70d824f644a3ef2e0243d0d~3SUfKL84F3023430234epcas2p2c;
 Tue,  9 Jun 2026 02:39:10 +0000 (GMT)
Received: from epcas2p3.samsung.com (unknown [182.195.38.208]) by
 epsnrtp04.localdomain (Postfix) with ESMTP id 4gZCly097Nz6B9mF; Tue,  9 Jun
 2026 02:39:10 +0000 (GMT)
Mime-Version: 1.0
Subject: [PATCH 0/2] hw/ufs: Add Host Initiated Defragmentation (HID) support
From: Keoseong Park <keosung.park@samsung.com>
To: Jeuk Kim <jeuk20.kim@samsung.com>, "kwolf@redhat.com"
 <kwolf@redhat.com>, "hreitz@redhat.com" <hreitz@redhat.com>,
 "farosas@suse.de" <farosas@suse.de>, "lvivier@redhat.com"
 <lvivier@redhat.com>, "pbonzini@redhat.com" <pbonzini@redhat.com>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>
X-Priority: 3
X-Content-Kind-Code: NORMAL
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20260609023909epcms2p3f8856f12fed093168aff636f8dc8f994@epcms2p3>
Date: Tue, 09 Jun 2026 11:39:09 +0900
X-CMS-MailID: 20260609023909epcms2p3f8856f12fed093168aff636f8dc8f994
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20260609023909epcms2p3f8856f12fed093168aff636f8dc8f994
References: <CGME20260609023909epcms2p3f8856f12fed093168aff636f8dc8f994@epcms2p3>
Received-SPF: pass client-ip=203.254.224.33;
 envelope-from=keosung.park@samsung.com; helo=mailout3.samsung.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Reply-To: keosung.park@samsung.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi,

This series adds emulation of the UFS Host Initiated Defragmentation
(HID) extended feature, plus a qtest covering its host-visible
interface.

HID lets the host trigger and control device-side defragmentation
through five attributes (IDN 0x35-0x39):

  bDefragOperation   trigger: Disable / Analysis / Defrag
  dHIDAvailableSize  fragmented 4KB units (published by analysis)
  dHIDSize           host-requested defrag target (4KB units)
  bHIDProgressRatio  0-100%; reading 100 resets HID
  bHIDState          current state; terminal-state read resets HID

Each successful user-data SCSI WRITE increments an internal fragment
counter, which analysis publishes via `dHIDAvailableSize`. The state
machine is driven from `ufs_process_idle()` and only advances while
the device is idle. Support is advertised via
`dExtendedUFSFeaturesSupport` bit 13.

Thanks,
Keoseong

Keoseong Park (2):
  hw/ufs: Add Host Initiated Defragmentation (HID) support
  tests/qtest: Add UFS HID qtest

 hw/ufs/lu.c            |  16 ++-
 hw/ufs/trace-events    |   4 +
 hw/ufs/ufs.c           | 155 +++++++++++++++++++++-
 hw/ufs/ufs.h           |   4 +
 include/block/ufs.h    |  18 +++
 tests/qtest/ufs-test.c | 290 +++++++++++++++++++++++++++++++++++++++++
 6 files changed, 480 insertions(+), 7 deletions(-)

-- 
2.25.1


