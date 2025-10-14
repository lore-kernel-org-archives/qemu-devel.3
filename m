Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D117ACCD192
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 14:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8g2O-0001Oy-Uz; Tue, 14 Oct 2025 10:30:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1v8g2M-0001On-U9
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 10:30:03 -0400
Received: from fout-a6-smtp.messagingengine.com ([103.168.172.149])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1v8g2I-0007Uq-9i
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 10:30:02 -0400
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
 by mailfout.phl.internal (Postfix) with ESMTP id 8AEE9EC0175;
 Tue, 14 Oct 2025 10:29:54 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
 by phl-compute-12.internal (MEProxy); Tue, 14 Oct 2025 10:29:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm1; t=1760452194;
 x=1760538594; bh=bE4kXEuQPE4wg5fy7lZtx2WSvgpTF7tlwKl2B0B41T8=; b=
 kf0uMuCc1+R7xI9UMUAUMu+xJxoHYkTwjUSXcFjABSpQjW7IwMcSymelCgIFbfaM
 HchFoJ/YW0iKbG+umuifHG8h6sg8zrSJ4C/32IuEfXaHnXJlGGV9P18NBWdh1/jr
 vG2aAIC0XNIcNaqH61U8x2Hs+qCv24Hmdxl0Zqs8YQpVLkxTincich/DoORxI6SQ
 XsjweZKJFcpxUjDKYWN54LpmsA9u1aWsHrkVComgDwlsN8U51vCLOxQo1mzSNbgA
 EwdZSv6shlNH3uOa/GzTlnPe96YZvPDWqiW0kAZHZ2TxFevlDDSXKI5Jv++U6lgN
 RCcf+lgbjIT6c4V5ZMTNzA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1760452194; x=
 1760538594; bh=bE4kXEuQPE4wg5fy7lZtx2WSvgpTF7tlwKl2B0B41T8=; b=h
 RB9kjS8gpd9DvIiFhrVZwZqg84y0QGyoeoBTQbnBre571VeEbGV3h9dSJJ1ojg/r
 dAtJCFBrqp2b8l0ThFMdB8mbT+pSplne+ZhkzASm0dZzKtZdqQLpUmk55l6LijLw
 6ig1aa75sL2QTNTXjNMZBIjGz/m3elCNSuehbwL+V89cgfEAMyjww2gLqsoycUvY
 g1JFpbUsHNrEKIeqUn8+oJtkyXWvqhrZHYYwKQ0UIOpPL+6utnACoIdFnPJrnmwx
 hG8FwRVE9feKPX+XQRLoEJjm4JgCBRpfn6oH+rYML5Vq7PptE/J4YGfZYbrIrl0A
 YCWPI925K4wquTVye0EjA==
X-ME-Sender: <xms:Yl7uaLqGcxM_qbJRoBBk4oA6ONi-WObPDG9OCPn_xYQj6UZWCMAqjw>
 <xme:Yl7uaAmY4yF7hZFguWiqhPizxbNcQs6Iqa_5YIQnVp8QQOruk-ES8LngCw6lv9Z8w
 6iM7YVybzoRN6UJb4R5t7dPjKKRF5AVpCdEb0NNbHrwi5kgtBlhCg>
X-ME-Received: <xmr:Yl7uaHNI1OwOxZ-mYuN6QB9_MRYREtJT3OqCszqGMxEsTRSExiGowQMuGMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduvddtjeejucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
 hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
 htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
 veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepjedpmhhouggvpehs
 mhhtphhouhhtpdhrtghpthhtohepjhhohhhnrdhlvghvohhnsehnuhhtrghnihigrdgtoh
 hmpdhrtghpthhtoheptghlghesrhgvughhrghtrdgtohhmpdhrtghpthhtohepqhgvmhhu
 qdguvghvvghlsehnohhnghhnuhdrohhrghdprhgtphhtthhopegrlhgvgidrfihilhhlih
 grmhhsohhnsehrvgguhhgrthdrtghomhdprhgtphhtthhopehjohhhnhdrghdrjhhohhhn
 shhonhesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepvghlvghnrgdruhhfihhmthhsvg
 hvrgesohhrrggtlhgvrdgtohhmpdhrtghpthhtohepjhgrghdrrhgrmhgrnhesohhrrggt
 lhgvrdgtohhm
X-ME-Proxy: <xmx:Yl7uaEMvTBJKcgmTrZJ6-qL_eUIKbEx5fa-8uTezmRDrjoGazmsj8w>
 <xmx:Yl7uaIgt7tNQkVDrexef0nwi4ckh4JHljdrcZH8E-8zTSeOtB5HeEA>
 <xmx:Yl7uaBsBYbHrSCjcKl-9h8WC6jTrTLxenUeO5s72Tha2DVD6f60raQ>
 <xmx:Yl7uaOSO5GNvER7junjYmMHYq0b4_9MDDiAb_NF6xCk98fdjXk-Y1w>
 <xmx:Yl7uaJNUBZ8MKGIRFZicR3H5kxuz2c5vjnF0hhD3bbnGB959JowD6enU>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Oct 2025 10:29:53 -0400 (EDT)
Date: Tue, 14 Oct 2025 08:29:49 -0600
From: Alex Williamson <alex@shazbot.org>
To: John Levon <john.levon@nutanix.com>
Cc: =?UTF-8?B?Q8OpZHJpYw==?= Le Goater <clg@redhat.com>,
 qemu-devel@nongnu.org, Alex Williamson <alex.williamson@redhat.com>, John
 Johnson <john.g.johnson@oracle.com>, Elena Ufimtseva
 <elena.ufimtseva@oracle.com>, Jagannathan Raman <jag.raman@oracle.com>
Subject: Re: [PULL 25/28] vfio: add region info cache
Message-ID: <20251014082937.7de6f960@shazbot.org>
In-Reply-To: <aO5XeknOrUtvLJO9@lent>
References: <20250509131317.164235-1-clg@redhat.com>
 <20250509131317.164235-26-clg@redhat.com>
 <6519c5b0-46d2-4097-bb37-7a78f9087f68@redhat.com>
 <aO5RAIX6WI0MerI-@lent>
 <cb4b8412-f1a5-4c7c-b2f4-d65b72194412@app.fastmail.com>
 <aO5XeknOrUtvLJO9@lent>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=103.168.172.149; envelope-from=alex@shazbot.org;
 helo=fout-a6-smtp.messagingengine.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, 14 Oct 2025 16:00:26 +0200
John Levon <john.levon@nutanix.com> wrote:

> On Tue, Oct 14, 2025 at 07:49:24AM -0600, Alex Williamson wrote:
> 
> > > My apologies - we hit the exact same issue internally, but with a much older
> > > codebase, so I did not realise this could be an upstream problem as well!
> > >
> > > We put this down to a bug in the nvidia driver - surely it shouldn't be
> > > reporting fewer regions than are actually in use. So we applied what we
> > > thought to be a gross hack of boundary checking, and not using the region
> > > cache in case it's beyond num_regions.
> > >
> > > To put it another way, the header file says:
> > >
> > >    217         __u32   num_regions;    /* Max region index + 1 */
> > >
> > > If it's not actually the max region index + 1, what are the expected
> > > semantics of this field, or of region indices more generally? We could not
> > > find any clear documentation on the topic other than this comment.  
> > 
> > '9' only defines the end of the fixed, pre-defined region indexes for
> > vfio-pci, ie. VFIO_PCI_NUM_REGIONS.  Beyond that, we support device specific
> > regions.  The GFX region is one such device specific region.  
> 
> To be clear, nowhere in the code are we hard-coding 9, we ask the underlying
> vfio instance for the num_regions value.
> 
> In this case, it appears that the underlying instance is returning 9, and then
> trying to use index 9.

That sounds like a bug, in vfio_pci_ioctl_get_info() we return
num_regions as (VFIO_PCI_NUM_REGIONS + vdev->num_regions) where
vdev->num_regions is incremented via
vfio_pci_core_register_dev_region().  Any read, write, or mmap access
done through vfio-pci-core would need to increment vdev->num_regions to
support that access.  I think we're dealing with NVIDIA vGPU here,
which afaik is the only driver that uses a region for the display, so
I'd suspect they have a bug and don't use the vfio-pci-core callbacks
here.

Does QEMU's caching model need to fall through to GET_REGION_INFO and
expand the cache for an out-of-bounds index to handle such a bug?

> > There is no fixed limit to the number of regions a device may expose  
> 
> Sure.
> 
> >, nor is vfio_device_info.num_regions necessarily a static value.  
> 
> Ah - is this documented somewhere? And do you have an example of where this
> varies over the lifetime of a device currently?

It's more the case that it's not specifically defined as static over
the lifetime of the device.  I don't think we want device spontaneously
creating new regions, we have no device-check notification mechanism to
userspace to reevaluate regions, but a user initiated action defined to
create a new region seems like a fair vector where num_regions could be
updated.  Also the current working idea would be that regions are only
added, not modified or deleted.

> IOW, are these devices actually changing the num_regions value they report
> sometime after initialization (namely, can it change after
> vfio_device_prepare()) ?

In theory, yes.

> Or would querying num_regions still return the original value, and in fact the
> semantics of the field are "it's not the max region index, but the max region
> index during initialization" or similar ?

Ultimately it's just a marker that *should* indicate there are no
regions to query above (num_regions - 1).  It should be valid at the
time it's queried.  I don't think it would be valid that it could be
dynamic in any other way than a monotonically increasing value.  Thanks,

Alex

