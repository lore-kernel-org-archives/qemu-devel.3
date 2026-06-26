Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0E81C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jun 2026 13:39:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wd6mO-00067v-Bs; Fri, 26 Jun 2026 09:39:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wd6mN-00067h-CB; Fri, 26 Jun 2026 09:39:35 -0400
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cassel@kernel.org>)
 id 1wd6mL-0008NM-Q4; Fri, 26 Jun 2026 09:39:35 -0400
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 61AF7600DA;
 Fri, 26 Jun 2026 13:39:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA7FA1F00A3D;
 Fri, 26 Jun 2026 13:39:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782481172;
 bh=uhdyL9Tip027eFNuIqflcCa8BdxFsYlnI/uU/SP/a20=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=OGba62pND9SOVvt0BCODdIcNH64QctTOa3NA7X1twIZiasgDVFTp0bfwD4fJszN2S
 L+gBHjCz4FJTh2VGIj8U/ix01T5S0FezEDxOWn75IfUcZju0muNZwnunKAUPsjsWZY
 7uJ1LePH8gBLxL7I8I8i5uvb4Go3WpE0eDQX8lY0+32Lmayf0Cgwx9O26dGlDLTfxr
 lQf8vi8FP4HctXv7L0BDKusQs42FPRjxCG3yC7aTihpf2xx///uLrGzl2hz8RbC95a
 wzzbONIX5L6DPW2glvYOl44954nDNG2RGlw3LAHoCrgLgsY7EmLKttq73OLFOT1MPn
 DuB8BHkUthsmA==
Date: Fri, 26 Jun 2026 15:39:27 +0200
From: Niklas Cassel <cassel@kernel.org>
To: Sam Li <faithilikerun@gmail.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, dlemoal@kernel.org,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Blake <eblake@redhat.com>, Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v13 1/6] docs/qcow2: add the zoned format feature
Message-ID: <aj6BD2Rljo4QtNdj@ryzen>
References: <20260626131555.459792-1-faithilikerun@gmail.com>
 <20260626131555.459792-2-faithilikerun@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260626131555.459792-2-faithilikerun@gmail.com>
Received-SPF: pass client-ip=2600:3c04:e001:324:0:1991:8:25;
 envelope-from=cassel@kernel.org; helo=tor.source.kernel.org
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

On Fri, Jun 26, 2026 at 03:15:50PM +0200, Sam Li wrote:
> Add the specs for the zoned format feature of the qcow2 driver.
> The qcow2 file then can emulate real zoned devices, either passed
> through by virtio-blk device or NVMe ZNS drive to the guest
> given zoned information.
> 
> Signed-off-by: Sam Li <faithilikerun@gmail.com>
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  docs/system/qemu-block-drivers.rst.inc | 50 ++++++++++++++++++++++++++
>  1 file changed, 50 insertions(+)
> 
> diff --git a/docs/system/qemu-block-drivers.rst.inc b/docs/system/qemu-block-drivers.rst.inc
> index 675daa72f9..19587c515f 100644
> --- a/docs/system/qemu-block-drivers.rst.inc
> +++ b/docs/system/qemu-block-drivers.rst.inc
> @@ -172,6 +172,56 @@ This section describes each format and the options that are supported for it.
>      filename`` to check if the NOCOW flag is set or not (Capital 'C' is
>      NOCOW flag).
>  
> +  .. option:: zone.mode
> +    If this is set to ``host-managed``, the image is an emulated zoned
> +    block device. This option is only valid to emulated zoned device files.

All other options in this file seem to have a newline between "option::"
and the actual description.

With a newline added:
Reviewed-by: Niklas Cassel <cassel@kernel.org>


> +
> +  .. option:: zone.size
> +
> +    The size of a zone in bytes. The device is divided into zones of this
> +    size with the exception of the last zone, which may be smaller.
> +    Defaults to ``256 MiB``.
> +
> +  .. option:: zone.capacity
> +
> +    The initial capacity value, in bytes, for all zones. The capacity must
> +    be less than or equal to zone size. If the last zone is smaller, then
> +    its capacity is capped. Defaults to ``zone.size``.
> +
> +    The zone capacity is per zone and may be different between zones in real
> +    devices. QCow2 sets all zones to the same capacity.
> +
> +  .. option:: zone.conventional_zones
> +
> +    The number of conventional zones of the zoned device. Defaults to ``0``
> +    (all zones are sequential-write-required).
> +
> +  .. option:: zone.max_active_zones
> +
> +    The maximum allowed active zones (zones in the implicit open, explicit
> +    open, or closed state).
> +
> +    The max active zones must be less or equal to the number of SWR
> +    (sequential write required) zones of the device. Defaults to ``0``,
> +    meaning no limit.
> +
> +  .. option:: zone.max_open_zones
> +
> +    The maximum allowed open zones (zones in the implicit open or explicit
> +    open state). The max open zones must not be larger than the max active
> +    zones. Defaults to ``zone.max_active_zones`` if that is set, otherwise
> +    ``0`` (no limit).
> +
> +    If the limits of open zones or active zones are equal to the number of
> +    SWR zones, then it is the same as having no limits.
> +
> +  .. option:: zone.max_append_bytes
> +
> +    The maximum number of bytes of a zone append request that can be issued
> +    to the device. It must be 512-byte aligned and less than the zone
> +    capacity. A value of ``0`` means that zone append requests are not
> +    supported. Defaults to ``64 KiB``.
> +
>  .. program:: image-formats
>  .. option:: qed
>  
> -- 
> 2.53.0
> 

