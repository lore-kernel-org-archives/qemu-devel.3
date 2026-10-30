Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12CA2606A31C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 08:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=samsung.com header.i=@samsung.com header.a=rsa-sha256 header.s=mail20170921 header.b=PmSXaGpA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMhjz-0005YB-SX; Fri, 30 Oct 2026 04:13:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1xMhjt-0005X4-2U
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 04:13:29 -0400
Received: from mailout2.samsung.com ([203.254.224.25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daejun7.park@samsung.com>)
 id 1xMhjp-0001Eq-BK
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 04:13:28 -0400
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
 by mailout2.samsung.com (KnoxPortal) with ESMTP id
 20261030081316epoutp02fd2ca6b7e9ae982355823f79f49e0bc2~jQIBXdwMw1440814408epoutp02k
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 08:13:16 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com
 20261030081316epoutp02fd2ca6b7e9ae982355823f79f49e0bc2~jQIBXdwMw1440814408epoutp02k
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
 s=mail20170921; t=1793347996;
 bh=hVBfDzgrmMd0q9qOwpRI3rd7CaGiq30k3Qa3wENQ3Zw=;
 h=Subject:Reply-To:From:To:CC:In-Reply-To:Date:References:From;
 b=PmSXaGpAIgAEqJMZGAgR0msk17HcPjcw30XdFXnAQNRWP6+HDtmBPTUbbJSkQLG8W
 D+R5n/Igmd3DHhb81Vt9lomCXqoCluUThEZiWKqLcMHin1folX3VRlrI82zC11+NEB
 8RB5HlhcXtkz4LilI7wVZVLWEMPQjGw8O+qR4e7E=
Received: from epsnrtp01.localdomain (unknown [182.195.42.153]) by
 epcas2p2.samsung.com (KnoxPortal) with ESMTPS id
 20261030081315epcas2p2abf64eca8734c1a75aadb033f2981f6c~jQIApfeZB2213922139epcas2p2m;
 Fri, 30 Oct 2026 08:13:15 +0000 (GMT)
Received: from epcas2p1.samsung.com (unknown [182.195.38.199]) by
 epsnrtp01.localdomain (Postfix) with ESMTP id 4jGDPR3TNWz6B9m5; Fri, 30 Oct
 2026 08:13:15 +0000 (GMT)
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0
Subject: RE:(2) [PATCH v3 0/6] Support for Zoned UFS
From: Daejun Park <daejun7.park@samsung.com>
To: Niklas Cassel <cassel@kernel.org>
CC: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Jeuk Kim
 <jeuk20.kim@samsung.com>, "farosas@suse.de" <farosas@suse.de>,
 "lvivier@redhat.com" <lvivier@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>,
 "hreitz@redhat.com" <hreitz@redhat.com>, "qemu-block@nongnu.org"
 <qemu-block@nongnu.org>, "pierrick.bouvier@oss.qualcomm.com"
 <pierrick.bouvier@oss.qualcomm.com>, "stanleyjhu@google.com"
 <stanleyjhu@google.com>, Keoseong Park <keosung.park@samsung.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng
 <fam@euphon.net>, John Snow <jsnow@redhat.com>, "Denis V. Lunev"
 <den@openvz.org>, Sam Li <faithilikerun@gmail.com>, Damien Le Moal
 <dlemoal@kernel.org>, Daejun Park <daejun7.park@samsung.com>
X-Priority: 3
X-Content-Kind-Code: NORMAL
In-Reply-To: <at9P9OWMQUQR501_@ryzen>
X-CPGS-Detection: blocking_info_exchange
X-Drm-Type: N,general
X-Msg-Generator: Mail
X-Msg-Type: PERSONAL
X-Reply-Demand: N
Message-ID: <20261030081315epcms2p6557cc3ed2cae312c8ae82b1ef2758bd5@epcms2p6>
Date: Fri, 30 Oct 2026 17:13:15 +0900
X-CMS-MailID: 20261030081315epcms2p6557cc3ed2cae312c8ae82b1ef2758bd5
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
X-CPGSPASS: Y
X-CPGSPASS: Y
cpgsPolicy: CPGSC10-223,Y
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20261020001647epcms2p52cd58173164a43e252c33a3eb5935dc8
References: <at9P9OWMQUQR501_@ryzen>
 <20261020001647epcms2p52cd58173164a43e252c33a3eb5935dc8@epcms2p5>
 <CGME20261020001647epcms2p52cd58173164a43e252c33a3eb5935dc8@epcms2p6>
Received-SPF: pass client-ip=203.254.224.25;
 envelope-from=daejun7.park@samsung.com; helo=mailout2.samsung.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, Oct 26, 2026 at 02:04:52PM +0100, Niklas Cassel wrote:
> This series does not appear to be making use of the zoned block layer APIs
> that currently exist in QEMU (see e.g. include/block/block-common.h and
> block/io.c).

Thank you, Niklas. I have reworked the series on the zoned block layer
API, on top of your qcow2 v15. The zones live in the image, and the UFS
logical unit calls blk_co_zone_report() and blk_co_zone_mgmt().
Conventional zones and the open zone limit come from the image, and the
UFS zone properties are gone.

> If you want futher inspiration, you could look at my (work in progress)
> branch (note: this branch is going to be rebased multiple times), which
> converts between the QEMU zoned block layer zone states BLK_ZS_* and the
> zone states defined by the Zone ATA Commands (ZAC) specification:
> https://github.com/floatious/qemu/tree/zac/

v4 uses two commits of that branch:

  67ced597c3 scsi: add the sense codes of zoned block devices
  4373841591 block: add accessors for the zone model, capacity and open
             zone limit

May I post them in v4 under your authorship, as they are? If you would
rather post them yourself, I will base v4 on your posting instead.

One question: qcow2 fails a write to a full zone with
BLK_ZE_UNALIGNED_WRITE, so the guest gets UNALIGNED WRITE COMMAND. A ZBC
device, and scsi_debug, report INVALID FIELD IN CDB there. Would you
take a separate errno for a full zone in v16? Linux with write
pipelining retries UNALIGNED WRITE COMMAND as a reordering.

Two more things you may want to know:
- v4 adds scsi_sense_from_zone_errno() to scsi/utils.c, which maps the
  BLK_ZE_* errnos to these sense codes. IDE ZAC could use it instead of
  its own copy in ide_sense_for_errno().
- qcow2 v15 calls error_report() on every rejected zone write
  (qcow2.c:3582, 3591, 3618, 3633). A guest can fill stderr this way
  through any device model.

Daejun

