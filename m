Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F524606A323
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Nov 2026 23:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bGrXTjSb
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xSjvG-0005YV-GB; Sun, 15 Nov 2026 18:46:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1xSjvF-0005YD-BX; Sun, 15 Nov 2026 18:46:09 -0500
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dlemoal@kernel.org>)
 id 1xSjvD-00077i-Ik; Sun, 15 Nov 2026 18:46:09 -0500
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6875861DCD;
 Sun, 15 Nov 2026 23:45:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DA71F000C4;
 Sun, 15 Nov 2026 23:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794786359;
 bh=mQFlhjSjHMX7wDGPpyLf+OxYz1B9SKpE0D7aZS11VAw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To;
 b=bGrXTjSbAufqM4q3H5k/hCfMmuj2zrarRc+RrqfoIbslyFJ2c4eqtFDeAumN+2ZIR
 6SwzDVbfS5+QnMGH80w0Tl2ZyrQVuOXclf2INWas37wgaX4nl+Xoy9YqqdJc+6j8Hw
 TkURx1YEo7ZIUjfIauMW0weUkR8JwWK67vRsyV6dXQWfm4EeBBJabYiPLNC/0mxUAh
 8wGJnZDH9KHIMUzrfXNPU5m3ZG97v7KQzVaILycherZZhObgjYq/+oreh7Il/780mt
 tbuJQ/n4N1+PuIMDOypAxIGSE0WUz4tt8kPCQXxpO6YxYXChUijSdJfTH10CsuERyD
 YsyqwGD9lBrlQ==
Message-ID: <8e0733ae-28c3-427b-bfe0-20e82347ce0c@kernel.org>
Date: Sun, 15 Nov 2026 15:45:55 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v17 3/9] block: define errnos for zone protocol errors
To: Niklas Cassel <cassel@kernel.org>, qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Eric Blake <eblake@redhat.com>, qemu-block@nongnu.org,
 Sam Li <faithilikerun@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Jeuk Kim <jeuk20.kim@samsung.com>,
 Daejun Park <daejun7.park@samsung.com>
References: <20261112114918.1269168-1-cassel@kernel.org>
 <20261112114918.1269168-4-cassel@kernel.org>
Content-Language: en-US
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20261112114918.1269168-4-cassel@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=dlemoal@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/12/26 03:49, Niklas Cassel wrote:
> A block driver that emulates zones (e.g. qcow2 with the zoned format
> feature) rejects requests that violate the zone protocol, and the device
> model has to report each of these to the guest with the matching zone
> error (ZAC/ZBC sense data, virtio-blk zone status codes, ...). It can
> only do so if each condition comes with an errno of its own, rather than
> a generic one such as EIO.
> 
> Define one for each condition:
> 
>   BLK_ZE_UNALIGNED_WRITE  ESPIPE        write not at the write pointer
>   BLK_ZE_BOUNDARY         ERANGE        write past the zone capacity
>   BLK_ZE_OPEN_RESOURCE    ETOOMANYREFS  open zone limit reached
>   BLK_ZE_ACTIVE_RESOURCE  EOVERFLOW     active zone limit reached
>   BLK_ZE_FULL             EXFULL        write to a full zone
> 
> ETOOMANYREFS and EOVERFLOW are what Linux returns for
> BLK_STS_ZONE_OPEN_RESOURCE and BLK_STS_ZONE_ACTIVE_RESOURCE, so a host
> zoned device used through file-posix already reports the same values.
> For the boundary case, ERANGE is used rather than EFBIG, which the host
> file system can legitimately return for an image file.
> 
> A write that is not at the write pointer gets ESPIPE, which file and
> block device I/O never return, rather than EINVAL, which a zoned driver
> also uses for invalid requests such as an invalid zone state
> transition. So a device model can map each of these errnos to its zone
> error without having to know which request failed.
> 
> A full zone has no write pointer, and ZAC, ZBC, NVMe ZNS and virtio-blk
> all report a write to a full zone differently from a write that is not
> at the write pointer, so it gets its own errno, EXFULL.
> 
> ETOOMANYREFS is not POSIX and EXFULL is Linux-specific, so provide
> fallbacks for hosts that lack them.
> 
> Signed-off-by: Niklas Cassel <cassel@kernel.org>

Looks OK to me.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>

-- 
Damien Le Moal
Western Digital Research

