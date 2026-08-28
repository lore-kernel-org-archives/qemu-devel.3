Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CCA2C61DBD
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2026 06:04:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzph0-0003u3-Dh; Fri, 28 Aug 2026 02:03:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1wzpgx-0003tG-La; Fri, 28 Aug 2026 02:03:55 -0400
Received: from tor.source.kernel.org ([172.105.4.254])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1wzpgv-0008HS-Hp; Fri, 28 Aug 2026 02:03:54 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C1179602D4;
 Fri, 28 Aug 2026 06:03:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D1531F000E9;
 Fri, 28 Aug 2026 06:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787897031;
 bh=/9DcE0oBOTpnnyvav5O79wroy6qgCRGo0tw2dpjsMEs=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=UPurG5PV4nHO6ITGEIsPJPUGeHHvZaFzTHfOBsvyV/XpJPcrB5OlOWXQ+6LOcNvP5
 izffe/zhmpFNh5tc/fzDfsJVj0Q4QNUpOmfbZvR/0jIJxfhnxq+Vf8En7qIHDC1sN3
 U7EdH9PaJzXDXi5YFVaCU4SGWNh5KfceG339sBzy0BRX4I9JvaqS8FY+TpYYB8fuA6
 MTZ1kuHnmqLhBp6VqqFQUVd+x3eWyfnu7gZuB6CSySLnJsWXdvovW0nIjMrMAnaW4F
 0DCyG4/NRSR1Gs9zu/60/zDmNb5+d3Th15ko7fXZRg8ewCZ17ykzl1vOrexMszfBoH
 qee/NsFgD44RA==
Message-ID: <71d8cb90-8114-4c53-b786-2e3f0fdf81b6@kernel.org>
Date: Fri, 28 Aug 2026 15:03:48 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/12] virtio-blk: report the effective zone write
 granularity
To: Niklas Cassel <cassel@kernel.org>, Stefan Hajnoczi <stefanha@redhat.com>, 
 John Snow <jsnow@redhat.com>, "Denis V. Lunev" <den@openvz.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
Cc: Sam Li <faithilikerun@gmail.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org
References: <20260825205748.679968-1-cassel@kernel.org>
 <20260825205748.679968-5-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20260825205748.679968-5-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=172.105.4.254; envelope-from=dlemoal@kernel.org;
 helo=tor.source.kernel.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On 8/26/26 05:57, Niklas Cassel wrote:
> For ZBC/ZAC devices the write granularity is the physical block size, so
> a 512e SMR disk exposed through a host_device backend has a logical block
> size of 512 and a zone write granularity of 4096. We told the guest driver 512
> while raw_co_zone_append() rejects anything that is not 4096 byte
> aligned, so the driver saw a plain I/O error for a request it had been
> told was valid.
> 
> Report the larger of the backend granularity and the logical block size
> instead. The guest driver cannot issue writes finer than the logical
> size, so the larger of the two is the constraint that applies. This
> matches what a Linux guest derives for itself: blk_validate_zoned_limits()
> raises zone_write_granularity to the logical block size, and
> blk_stack_limits() stacks it with max().
> 
> Add it as a helper next to blkconf_blocksizes(), since it is derived from
> a BlockConf and the limits of the backend below it, and use it for the
> zone append offset check in check_zoned_request(), which validated
> against bs->bl.write_granularity. The value reported to the driver and
> the value that requests are validated against then cannot drift apart.
> The helper cannot return zero because blkconf_blocksizes() always leaves
> a logical block size behind, so the check no longer needs to guard
> against an unset granularity.
> 
> Fixes: 4f7366506a96 ("virtio-blk: add zoned storage emulation for zoned devices")
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

