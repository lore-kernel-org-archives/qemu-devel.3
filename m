Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639DE606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Oct 2026 13:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BQ8leHpk
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLKNt-00079o-Ju; Mon, 26 Oct 2026 09:05:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xLKNq-00079H-U8; Mon, 26 Oct 2026 09:05:02 -0400
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1xLKNo-0003Pf-UJ; Mon, 26 Oct 2026 09:05:02 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9A65743DB6;
 Mon, 26 Oct 2026 13:04:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D22ED1F01825;
 Mon, 26 Oct 2026 13:04:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793019898;
 bh=pzz8OvT1i49oPyK6pMVHCq6SdOgT/6pfNQ1mXReD5R8=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=BQ8leHpk6dM1TTNjXedaROeyPxFro5CBu/zFHpKE7KlCRTLVQvLhd7MLYD7O2x7Qf
 a+3yIA4AHk1NzeLAffoY59A6S+5MbPlNFmF8nIj/jzqFQDgDszSGRvo4FeklsHJVNa
 UHeR2WseOw4LBxHUdPTcYMeuN0dOBaYUqZCqc+DlTIkzw7zzI7cPi8GB/v4krcfQcb
 JuVClrw5xyARn9SCDIIufJpWkEXBqSJW2tvz8fKW2lMElD77yy5aOptrVZeWOSRPxq
 eKnmxFP4vwcPW4OvTW2vmy+qSGxf6eF/oK8kF+3OI/ubTJ7aolXk9z7PsN+3OIoQpz
 Oco4XN9OxLG4w==
Date: Mon, 26 Oct 2026 14:04:52 +0100
From: Niklas Cassel <cassel@kernel.org>
To: Daejun Park <daejun7.park@samsung.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 Jeuk Kim <jeuk20.kim@samsung.com>, "farosas@suse.de" <farosas@suse.de>,
 "lvivier@redhat.com" <lvivier@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "kwolf@redhat.com" <kwolf@redhat.com>,
 "hreitz@redhat.com" <hreitz@redhat.com>,
 "qemu-block@nongnu.org" <qemu-block@nongnu.org>,
 "pierrick.bouvier@oss.qualcomm.com" <pierrick.bouvier@oss.qualcomm.com>,
 "stanleyjhu@google.com" <stanleyjhu@google.com>,
 Keoseong Park <keosung.park@samsung.com>,
 "qemu-stable@nongnu.org" <qemu-stable@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Sam Li <faithilikerun@gmail.com>, Damien Le Moal <dlemoal@kernel.org>
Subject: Re: [PATCH v3 0/6] Support for Zoned UFS
Message-ID: <at9P9OWMQUQR501_@ryzen>
References: <CGME20261020001647epcms2p52cd58173164a43e252c33a3eb5935dc8@epcms2p5>
 <20261020001647epcms2p52cd58173164a43e252c33a3eb5935dc8@epcms2p5>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261020001647epcms2p52cd58173164a43e252c33a3eb5935dc8@epcms2p5>
Received-SPF: pass client-ip=2600:3c0a:e001:78e:0:1991:8:25;
 envelope-from=cassel@kernel.org; helo=sea.source.kernel.org
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.339,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello Daejun,

On Tue, Oct 20, 2026 at 09:16:47AM +0900, Daejun Park wrote:
> This series lets a ufs-lu be a host-managed zoned block device (ZBC)
> with zoned=on, so that the zoned storage stack, for example f2fs on
> host-managed zones, can be tested on UFS without zoned UFS hardware.
> Patches 1-3 fix the command path that the zoned code relies on and can
> be merged first; patch 4 documents zoned logical units, patch 5 adds
> them and patch 6 the tests.
> 
> Not modelled: persistent zone state, conventional and gap zones, and the
> zoned UFS descriptor bits.
> 
> Tested with the UFS qtests (also under ASan and UBSan) and with Linux
> 7.3-rc7 and android17-6.18 guests, legacy doorbell and MCQ: fio
> --zonemode=zbd with verification, blkzone, and f2fs on android17-6.18.

This series does not appear to be making use of the zoned block layer APIs
that currently exist in QEMU (see e.g. include/block/block-common.h and
block/io.c).

I know that NVMe currently does not use it, but I don't think we should
allow adding zoned storage support in additional storage protocols, if
they do not make use of the QEMU zoned block layer APIs.

Sam Li has a series that converts NVMe to use the QEMU zoned block layer
APIs, even though that series seems to have stalled:
https://lore.kernel.org/qemu-devel/20240122190013.41302-1-faithilikerun@gmail.com/


Currently, it is only virtio-blk which is making use of the QEMU zoned
block layer APIs, and the only supported backend is file-posix.c.

However, there is work in progress to add qcow2 backend support for
the QEMU zoned block layer APIs:
https://lore.kernel.org/qemu-devel/20261026121259.3354561-1-cassel@kernel.org/
Which requires the (still not merged...) prep series:
https://lore.kernel.org/qemu-devel/20260921142819.2916043-1-cassel@kernel.org/


If you make use of the QEMU zoned block layer APIs, you will get support
for conventional zones, and will not need to add a UFS property for
max_open_zones. Once the qcow2 series lands, you will also get persistence.


If you want inspiration, you can see how virtio_blk_zone_report_complete()
(hw/block/virtio-blk.c) converts between the QEMU zoned block layer zone
states BLK_ZS_* and the virtio-blk VIRTIO_BLK_ZS_* defined zone states.

If you want futher inspiration, you could look at my (work in progress)
branch (note: this branch is going to be rebased multiple times), which
converts between the QEMU zoned block layer zone states BLK_ZS_* and the
zone states defined by the Zone ATA Commands (ZAC) specification:
https://github.com/floatious/qemu/tree/zac/


Kind regards,
Niklas

