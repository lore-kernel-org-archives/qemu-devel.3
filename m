Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D532C5AC7A
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Aug 2026 11:32:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wsInq-0005y2-QL; Fri, 07 Aug 2026 07:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wsInk-0005xQ-Mc; Fri, 07 Aug 2026 07:31:49 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wsInj-0002Gi-1H; Fri, 07 Aug 2026 07:31:48 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 5188560A79;
 Fri,  7 Aug 2026 11:31:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A87B31F000E9;
 Fri,  7 Aug 2026 11:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786102305;
 bh=R1IHR4kNUbWl69tBHJufUNUGgQ57FhADgzNfrvGthYU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=V+k/QEYN1YllKhbyWwzsHkwIB+gJbw5v+xs0PDLwduQeSgncCJeE60sV4JPUNL1V5
 11SGk6IZxEZbULjfIKNc2UzfkDJ8CMHQCH5B/2/iuMM5tq9gcQRhw78IOFqPBe5pIn
 9gChj902vkf9p4TQTKV2DovZeVku/j6Y/Yk0T9A9NzM0VGhwaSd5L6zUkJDbUVNHeM
 Ciw8J+HGExYorguSDRFO75sUY8AioobWuCEgHNlrUf3kVDG9Df3LBGLMZDNIaatUkr
 BkBEKA5JRQNBEZxA7XZDZlRBm73JM5sJiAsBdU0jsMNXe8vzsd6nyyxZmSNv5Jl177
 TDpO7L38BbDPA==
Date: Fri, 7 Aug 2026 13:31:39 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, dlemoal@kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Eric Blake <eblake@redhat.com>,
 qemu-block@nongnu.org
Subject: Re: [PATCH v14 0/6] Add full zoned storage emulation to the qcow2
 driver
Message-ID: <anXCGzwqXVhkA3Yf@ryzen>
References: <20260708221615.346155-1-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708221615.346155-1-faithilikerun@gmail.com>
Received-SPF: pass client-ip=172.105.4.254; envelope-from=cassel@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -32
X-Spam_score: -3.3
X-Spam_bar: ---
X-Spam_report: (-3.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.238,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Jul 09, 2026 at 12:16:09AM +0200, Sam Li wrote:
> This patch series add a new extension - zoned format - to the
> qcow2 driver, allowing full zoned storage emulation on a qcow2
> image file. A user can attach such an image to a guest and have
> it appear as a host-managed zoned block device.
> 
> The zoned format is opt-in through a new qcow2 header extension
> that pins the zone geometry. Behind the extension is a dedicated
> zoned metadata region that stores one 8-byte write pointer (WP)
> per zone. The extension is gated by an incompatible bit, so an
> older qcow2 implementation cannot accidentally open the image.
> 
> Each write pointer is routed through the write pointer cache,
> a Qcow2Cache object. The write pointer cache is written to disk
> after the qcow2 metadata is written, thus guaranteeing that
> the write pointer is updated after the corresponding data is
> written.
> 
> Zone states are in memory. Read-only and offline states are
> device-internal events, which are not modelled in qcow2
> emulation for simplicity. The other zone states
> (closed, empty, full) can be inferred from write poiner
> values, presistent across QEMU reboots. The open states are
> kept in memory using open zone lists.
> 

Hello Sam,


I ran: fio test suite, zonefs test suite, blktests, and zbd-state-test
(WD internal test suite), on the following backends:

1) QEMU qcow2 (this series):
$ lsblk -z
NAME ZONED        ZONE-SZ ZONE-NR ZONE-AMAX ZONE-OMAX ZONE-APP ZONE-WGRAN
vda  host-managed    256M     140         0        16       4K       512B

2) zloop:
https://docs.kernel.org/admin-guide/blockdev/zoned_loop.html
$ lsblk -z
NAME ZONED        ZONE-SZ ZONE-NR ZONE-AMAX ZONE-OMAX ZONE-APP ZONE-WGRAN
vda  host-managed    256M     140         0        16       1M         4K

3) A real HM-SMR device:
$ lsblk -z
NAME ZONED        ZONE-SZ ZONE-NR ZONE-AMAX ZONE-OMAX ZONE-APP ZONE-WGRAN
sda  host-managed    256M  111760         0       128      32M         4K




fio test suite: looks good.

zonefs test suite: looks good.

blktests: same amount of test cases pass.
Only major difference I can see is for the following test cases:

QEMU qcow2:
zbd/004 => vda (write split across sequential zones)         [passed]
    runtime    ...  148.769s


zloop:
zbd/004 => vda (write split across sequential zones)         [passed]
    runtime    ...  47.446s


real dev:
zbd/004 => sda (write split across sequential zones)         [passed]
    runtime    ...  27.616s


QEMU qcow2 seems significantly slower than zloop for this test case.

Perhaps not something to worry about, but the difference compared to
zloop is big enough to raise my eyebrows :)


zbd-state-test:
Show a test case for QEMU qcow2 that fails, but passes on zloop and a
real device.

You can use e.g. blkzone
or libzbd:
https://github.com/westerndigitalcorporation/libzbd
to perform zone operations.

I guess you could also use iotests for this test case.

021: OPEN_ZONE full to full... [Failed]
	    => Expected zone condition fu
	       Got oe

Test case seem to do:
1) Finds a zone in zone state empty.
2) Fills the zone (using dd), zone is now in zone state full.
3) Tries to explicitly open the zone (this zone transition is not legal),
   and the open command should fail.
4) Checks the zone state of the zone, should still be zone state full.

I guess the problem with the QEMU qcow2 code is that it actually changes
the zone state to explicit open in step 3), while it should fail the open
command and keep the zone in zone state full.

If you look at e.g. null_blk: null_open_zone(), it also fails to open a
full zone.


Kind regards,
Niklas

