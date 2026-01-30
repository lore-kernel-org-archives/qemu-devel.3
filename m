Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC0CCE6BF1B
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 15:41:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlqbx-00033I-7c; Fri, 30 Jan 2026 10:40:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1vlqbp-00032z-3x
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 10:40:33 -0500
Received: from fout-b4-smtp.messagingengine.com ([202.12.124.147])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex@shazbot.org>) id 1vlqbn-0005nE-2N
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 10:40:32 -0500
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
 by mailfout.stl.internal (Postfix) with ESMTP id D08FA1D000C4;
 Fri, 30 Jan 2026 10:40:27 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
 by phl-compute-05.internal (MEProxy); Fri, 30 Jan 2026 10:40:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=shazbot.org; h=
 cc:cc:content-transfer-encoding:content-type:content-type:date
 :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to; s=fm2; t=1769787627;
 x=1769874027; bh=fDUtyewaz756uH9RVoMWF/n7sIINqFRKK4K+YV3NZpU=; b=
 eQohq5JesHWqxMU9DKv/5Tqijdutm9/9hfDU9epDXiDgvM5vnq+Igwfj9Yf5HvNP
 iT9a55wfAH97wKg2rjQnPA1VtInXQvd0U5l62xP0NV5fTpmRCK2OXx/gsYiGHwNW
 NMWYOmG7LgfyTYYuSxlmOIF42jp+8UePQ+EJpOygzQa5Z+7xJdSKOgSzZRmtL92o
 feXAWoF/vXFLgfVoOmvkn765JCWIUWirRB0dbs3UjOBtSvccJ01V3jppKlF6yVtO
 jv+hvNcWs6K/ydo/iMfAE90mUy3QJTFrs8wPreY3Y/xE1FAvH+hJkB22N55/Et5Q
 0OntCVa1lZz5OHCGtwkkEQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1769787627; x=
 1769874027; bh=fDUtyewaz756uH9RVoMWF/n7sIINqFRKK4K+YV3NZpU=; b=G
 aionXWPDGw2ngMnht0v5cMuj5wyQDviCGVQWWx0Bfn1jaSl3Pt/axTK02Zkb6Bnl
 6tvDjUUd93gkWrkIH3FRPQWmJhg8vVlG+vlYl/hvOXimJ+2sfw6jP/H+qj78Rklf
 oNqWnW6ZovBhjrbGAas5YqSFNz3LOIvMQm+/hkYdgFAUnYYKk0faX/bWTR1BN3t5
 ZibnisciJhAIEcbd+XLU56iQ+4JSw9MK9Av6JMCz3T3bFeVobuZupoboHRtWEw6j
 noaCHJQV1TQaaUKWTwdcg8l/sX1b4hIGTnlEqPEXcOFailR/3P9ViApr4O5JWeNa
 HvzchZZ+oz6FlMDNOWaqA==
X-ME-Sender: <xms:69B8aWFHTdC00Lt19iS47oZuhR6HDUwVTUwXNHTaToiiiaPta_Owjw>
 <xme:69B8afdbczXNo_rdgSp1hO2VFfzOCBn0dlctpVx4MoDHh_vZC8Wl5C9MsVTT0oC1P
 f_Q7629fBZvh3qm_PzdhXGz-7O6rnrEveN5jmIkQbVLx4O5-bBs6A>
X-ME-Received: <xmr:69B8afofCyr3O1kGQ5uyNYIdADtWSAsnGVeHC6OFWzeGos-fe-6uglnE7EY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduieelgedvucetufdoteggodetrf
 dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
 rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
 gurhepfffhvfevuffkjghfofggtgfgsehtjeertdertddvnecuhfhrohhmpeetlhgvgicu
 hghilhhlihgrmhhsohhnuceorghlvgigsehshhgriigsohhtrdhorhhgqeenucggtffrrg
 htthgvrhhnpedvkeefjeekvdduhfduhfetkedugfduieettedvueekvdehtedvkefgudeg
 veeuueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
 grlhgvgiesshhhrgiisghothdrohhrghdpnhgspghrtghpthhtohepudefpdhmohguvgep
 shhmthhpohhuthdprhgtphhtthhopehskhholhhothhhuhhmthhhohesnhhvihguihgrrd
 gtohhmpdhrtghpthhtoheprghnkhhithgrsehnvhhiughirgdrtghomhdprhgtphhtthho
 pehvshgvthhhihesnhhvihguihgrrdgtohhmpdhrtghpthhtohepjhhgghesnhhvihguih
 grrdgtohhmpdhrtghpthhtoheptghlghesrhgvughhrghtrdgtohhmpdhrtghpthhtohep
 rghnihhkvghtrgesnhhvihguihgrrdgtohhmpdhrtghpthhtoheptghjihgrsehnvhhiug
 hirgdrtghomhdprhgtphhtthhopehkfigrnhhkhhgvuggvsehnvhhiughirgdrtghomhdp
 rhgtphhtthhopehtrghrghhuphhtrgesnhhvihguihgrrdgtohhm
X-ME-Proxy: <xmx:69B8aQC4WX5XbPwLOAc0EC2TC2AyOGTFWfcz4SIp3tDOMPkTEiM1Fg>
 <xmx:69B8aYd5c4QkJinrRiBZQbqGKLDwUxq9TPLk7vR3BcnMZpBjo7ZG_g>
 <xmx:69B8aQuoO6SkvU44rONWHx-XJqD3mFS-lTxH9yhB4CRBXkuXJyT4GQ>
 <xmx:69B8aXh5bpPx-H1yitQRa4Yu3FP-UeDyoLDoVkzfBVKSFunT7fiycg>
 <xmx:69B8abxoOHFKN81dBwOqAmv1lwxKzE36tgUmXKzljaHxinWqUQGeg8Ae>
Feedback-ID: i03f14258:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 10:40:26 -0500 (EST)
Date: Fri, 30 Jan 2026 08:40:24 -0700
From: Alex Williamson <alex@shazbot.org>
To: Shameer Kolothum Thodi <skolothumtho@nvidia.com>
Cc: Ankit Agrawal <ankita@nvidia.com>, Vikram Sethi <vsethi@nvidia.com>,
 Jason Gunthorpe <jgg@nvidia.com>, "clg@redhat.com" <clg@redhat.com>, Aniket
 Agashe <aniketa@nvidia.com>, Neo Jia <cjia@nvidia.com>, Kirti Wankhede
 <kwankhede@nvidia.com>, "Tarun Gupta (SW-GPU)" <targupta@nvidia.com>, Zhi
 Wang <zhiw@nvidia.com>, Matt Ochs <mochs@nvidia.com>, Krishnakant Jaju
 <kjaju@nvidia.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Subject: Re: [PATCH v1 1/2] hw/vfio: sort and validate sparse mmap regions
 by offset
Message-ID: <20260130084024.5b32d910@shazbot.org>
In-Reply-To: <CH3PR12MB7548F8415F5FF9EED90FA376AB9FA@CH3PR12MB7548.namprd12.prod.outlook.com>
References: <20260130040649.42485-1-ankita@nvidia.com>
 <20260130040649.42485-2-ankita@nvidia.com>
 <CH3PR12MB7548F8415F5FF9EED90FA376AB9FA@CH3PR12MB7548.namprd12.prod.outlook.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.51; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=202.12.124.147; envelope-from=alex@shazbot.org;
 helo=fout-b4-smtp.messagingengine.com
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

On Fri, 30 Jan 2026 09:33:44 +0000
Shameer Kolothum Thodi <skolothumtho@nvidia.com> wrote:

> > -----Original Message-----
> > From: Ankit Agrawal <ankita@nvidia.com>
> > Sent: 30 January 2026 04:07
> > To: Ankit Agrawal <ankita@nvidia.com>; Vikram Sethi <vsethi@nvidia.com>;
> > Jason Gunthorpe <jgg@nvidia.com>; Shameer Kolothum Thodi
> > <skolothumtho@nvidia.com>; alex@shazbot.org; clg@redhat.com
> > Cc: Aniket Agashe <aniketa@nvidia.com>; Neo Jia <cjia@nvidia.com>; Kirti
> > Wankhede <kwankhede@nvidia.com>; Tarun Gupta (SW-GPU)
> > <targupta@nvidia.com>; Zhi Wang <zhiw@nvidia.com>; Matt Ochs
> > <mochs@nvidia.com>; Krishnakant Jaju <kjaju@nvidia.com>; qemu-
> > devel@nongnu.org
> > Subject: [PATCH v1 1/2] hw/vfio: sort and validate sparse mmap regions by
> > offset
> > 
> > From: Ankit Agrawal <ankita@nvidia.com>
> > 
> > Sort sparse mmap regions by offset during region setup to ensure
> > predictable mapping order, avoid overlaps and a proper handling
> > of the gaps between sub-regions.
> > 
> > Add validation to detect overlapping sparse regions early during
> > setup before any mapping operations begin.
> > 
> > The sorting is performed on the subregions ranges during
> > vfio_setup_region_sparse_mmaps(). This also ensures that subsequent
> > mapping code can rely on subregions being in ascending offset order.
> > 
> > This is preparatory work for alignment adjustments needed to support
> > hugepfnmap on systems where device memory (e.g., Grace-based systems)
> > may have non-power-of-2 sizes.
> > 
> > cc: Alex Williamson <alex@shazbot.org>
> > Signed-off-by: Ankit Agrawal <ankita@nvidia.com>
> > ---
> >  hw/vfio/region.c | 45 ++++++++++++++++++++++++++++++++++++++++++++-
> >  1 file changed, 44 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/vfio/region.c b/hw/vfio/region.c
> > index ab39d77574..7622ae5683 100644
> > --- a/hw/vfio/region.c
> > +++ b/hw/vfio/region.c
> > @@ -149,6 +149,19 @@ static const MemoryRegionOps vfio_region_ops = {
> >      },
> >  };
> > 
> > +static int vfio_mmap_compare_offset(const void *a, const void *b)
> > +{
> > +    const VFIOMmap *mmap_a = a;
> > +    const VFIOMmap *mmap_b = b;
> > +
> > +    if (mmap_a->offset < mmap_b->offset) {
> > +        return -1;
> > +    } else if (mmap_a->offset > mmap_b->offset) {
> > +        return 1;
> > +    }
> > +    return 0;
> > +}
> > +
> >  static int vfio_setup_region_sparse_mmaps(VFIORegion *region,
> >                                            struct vfio_region_info *info)
> >  {
> > @@ -182,6 +195,34 @@ static int
> > vfio_setup_region_sparse_mmaps(VFIORegion *region,
> >      region->nr_mmaps = j;
> >      region->mmaps = g_realloc(region->mmaps, j * sizeof(VFIOMmap));
> > 
> > +    /*
> > +     * Sort sparse mmaps by offset to ensure proper handling of gaps
> > +     * and predictable mapping order in vfio_region_mmap().
> > +     */
> > +    if (region->nr_mmaps > 1) {
> > +        qsort(region->mmaps, region->nr_mmaps, sizeof(VFIOMmap),
> > +              vfio_mmap_compare_offset);
> > +
> > +        /*
> > +         * Validate that sparse regions dont overlap after sorting.
> > +         */
> > +        for (i = 1; i < region->nr_mmaps; i++) {
> > +            off_t prev_end = region->mmaps[i - 1].offset +
> > +                             region->mmaps[i - 1].size;
> > +            if (prev_end > region->mmaps[i].offset) {
> > +                error_report("%s: overlapping sparse mmap regions detected "
> > +                             "in region %d: [0x%lx-0x%lx] overlaps with [0x%lx-0x%lx]",
> > +                             __func__, region->nr, region->mmaps[i - 1].offset,
> > +                             prev_end - 1, region->mmaps[i].offset,
> > +                             region->mmaps[i].offset + region->mmaps[i].size - 1);
> > +                g_free(region->mmaps);
> > +                region->mmaps = NULL;
> > +                region->nr_mmaps = 0;
> > +                return -EINVAL;
> > +            }
> > +        }
> > +    }
> > +
> >      return 0;
> >  }
> > 
> > @@ -213,11 +254,13 @@ int vfio_region_setup(Object *obj, VFIODevice
> > *vbasedev, VFIORegion *region,
> > 
> >              ret = vfio_setup_region_sparse_mmaps(region, info);
> > 
> > -            if (ret) {
> > +            if (ret == -ENODEV) {
> >                  region->nr_mmaps = 1;
> >                  region->mmaps = g_new0(VFIOMmap, region->nr_mmaps);
> >                  region->mmaps[0].offset = 0;
> >                  region->mmaps[0].size = region->size;
> > +            } else {
> > +                return ret;
> >              }  
> 
> Is this now returns without the trace_xxx , right?
> 
> With that fixed:
> Reviewed-by: Shameer Kolothum <skolothumtho@nvidia.com>

Right, I think this was probably meant to be 'else if (ret)' so the
newly added -EINVAL generates an error w/o trace while the non-error
path should fall through.  Thanks,

Alex

