Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE34DD29FFE
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 12:35:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg05m-0000YS-I1; Wed, 14 Jan 2026 07:35:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vg05i-0000IH-Hl
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 07:35:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vg05f-0004h3-Jj
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 07:35:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768394109;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=teVed9wkpF4YrY622OZwfCVxWWIea5vtN1+xtUYhAhU=;
 b=CGFenmS4eUTqJD3jP80UikTP8hTSSerfl5eH8Gy63vi9fye7bg0LPldRHJPMLQyzpHGkjs
 Qaz19xm7tScH7tbeWRwaLrdx285N9JMdnXBIMAYmN5e7NiD8LUo7bZIt6epYnGjv91M3yR
 ppRMcZmsszopaw/AaOAKiPw3lbHaHs0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-639-uwFeLuVqPKuD4aVHCcgxTQ-1; Wed, 14 Jan 2026 07:35:08 -0500
X-MC-Unique: uwFeLuVqPKuD4aVHCcgxTQ-1
X-Mimecast-MFC-AGG-ID: uwFeLuVqPKuD4aVHCcgxTQ_1768394106
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4779ecc3cc8so59234615e9.3
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 04:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768394106; x=1768998906; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=teVed9wkpF4YrY622OZwfCVxWWIea5vtN1+xtUYhAhU=;
 b=lS74fKyVj/NE/1GnQUQiCxXzRKD0rOsPlrtFaOhYM4XPXcXYVMZmPPn0S1YZ8BHUhF
 mV1hTQJtb3l5oh8VNJeRv/KhHajFHTRYuf+b9PjWkFKbSElV2JG4c+ehiXSqvYWgHXLm
 BlwFIC6nwkJxwOCufVn8z5FPx4OwWOtQv/YkhfHyFJa89dDgt2jrAQls20Z7eLjozHDO
 f6q5gzPtLTcQD9j/TMm2krqhQKEDEdYZbr/kd9TwmOSmoZBHLYN1CdR83JtTICtZnslN
 lrn0F5LHe0GZaTQVNB8pbmxKvcfCAFveyZdzCBNU5dOEgbsKXeuRy7QFfa1Vf3fbABiV
 3dtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768394106; x=1768998906;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=teVed9wkpF4YrY622OZwfCVxWWIea5vtN1+xtUYhAhU=;
 b=NJoBOmtbP8Jvl+djgopFKXy1vqVGXAsa7ekh/LB5klnuZRnAwrATugdJnfG1II3TUT
 mg/XMNdQnwdWp6xo1rIDrXPRc6qLz+MXMU7oUnevWVTuaWymxUC2IiPvawwBO8X5c7oI
 ISBPHVWVUXOkQ4f2WTLADGWVQgAn+fcs0M8tAU+txgzAYfla79inYeqnnejVqmml74MC
 KMy86vbaj9fc1gJYHZbK4Bk0Is8HgSG+Van8/oRlND//jCFI1jCChkkSUEzmU/rLswWr
 5tz7I44ykbm+2RstGdCcX53MyI2FnmvhNIdWJwZGWcN7DmpmHJsPSxPT8npqN3b9NPta
 NrHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzY6nrXj36VW2vbzi2/GzqrRSMrYz0iuEnKfrhWriOqwI5wv67iR5BPKmwOjkL9cz3cUhkw4ge3/xc@nongnu.org
X-Gm-Message-State: AOJu0YytPoksdGv3tWLJrabVGxVjsDm4PdZzQSGlkYaaElv0LAmOP9mJ
 D3+bAYmC2HdE7oRquXRaLVTllLdAFyOBOorduFpmH5rFPpdCrBFfxQbW6318r9l3y5pqQIuukAg
 FOecWT3pzf3VlumieoKWeUxf5vYJsOR09c9EDRDn/tg/OVqBra2hnYrMy57Un2tsm
X-Gm-Gg: AY/fxX7j4gwLuOTQMzB9u9gpj8POWrGmqfnhZeecbO2/zE7SfbvddLFvSlYuqckXHvj
 yagD74eje4UwyW1kFu0GoZshg0/WpMhEwsCqLXKoAndc0vCn4WLHJNpfQAHCLZ16VWPak27MKp9
 Gtyt9gWrAmZu/IuLbvWB2fGjszdO4W2b2m6LNaMZ/tE6VeDV6hBtyLUVOl5Vv9A3PjZtdU/WBa/
 C1RD6aSmV6ViO6oP2iTSpzG9NQRtgBp0P/gVJM3n+5IP5PTEFRO8ASYapuF49ngQi7lPvB9gsbi
 xSWKnf7E6WO6RjwKUAv0nGQi4puSMOo6nIj98bSjphTQEamxSSrTzyDu/Nut283o7eI9VfEDdEG
 GwQ073PAp2eQPgTn3UJLneUrbr8JVpNE=
X-Received: by 2002:a05:600c:a4c:b0:477:7975:30ea with SMTP id
 5b1f17b1804b1-47ee338a820mr30066615e9.29.1768394106179; 
 Wed, 14 Jan 2026 04:35:06 -0800 (PST)
X-Received: by 2002:a05:600c:a4c:b0:477:7975:30ea with SMTP id
 5b1f17b1804b1-47ee338a820mr30066105e9.29.1768394105575; 
 Wed, 14 Jan 2026 04:35:05 -0800 (PST)
Received: from redhat.com (IGLD-80-230-35-22.inter.net.il. [80.230.35.22])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47ee1189f5fsm22615875e9.2.2026.01.14.04.35.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 04:35:05 -0800 (PST)
Date: Wed, 14 Jan 2026 07:35:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Shameer Kolothum <skolothumtho@nvidia.com>
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>,
 "qemu-arm@nongnu.org" <qemu-arm@nongnu.org>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "eric.auger@redhat.com" <eric.auger@redhat.com>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 Jason Gunthorpe <jgg@nvidia.com>, Nicolin Chen <nicolinc@nvidia.com>,
 "ddutile@redhat.com" <ddutile@redhat.com>,
 "berrange@redhat.com" <berrange@redhat.com>,
 "clg@redhat.com" <clg@redhat.com>, "alex@shazbot.org" <alex@shazbot.org>,
 Nathan Chen <nathanc@nvidia.com>, Matt Ochs <mochs@nvidia.com>,
 "smostafa@google.com" <smostafa@google.com>,
 "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
 "jiangkunkun@huawei.com" <jiangkunkun@huawei.com>,
 "zhangfei.gao@linaro.org" <zhangfei.gao@linaro.org>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 Krishnakant Jaju <kjaju@nvidia.com>
Subject: Re: [PATCH v7 33/36] hw/pci: Add helper to insert PCIe extended
 capability at a fixed offset
Message-ID: <20260114073338-mutt-send-email-mst@kernel.org>
References: <20260111195508.106943-1-skolothumtho@nvidia.com>
 <20260111195508.106943-34-skolothumtho@nvidia.com>
 <20260114114556.0000153c@huawei.com>
 <CH3PR12MB7548C1DABCCCB8CB332B59A0AB8FA@CH3PR12MB7548.namprd12.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CH3PR12MB7548C1DABCCCB8CB332B59A0AB8FA@CH3PR12MB7548.namprd12.prod.outlook.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jan 14, 2026 at 12:26:29PM +0000, Shameer Kolothum wrote:
> 
> 
> > -----Original Message-----
> > From: Jonathan Cameron <jonathan.cameron@huawei.com>
> > Sent: 14 January 2026 11:46
> > To: Shameer Kolothum <skolothumtho@nvidia.com>
> > Cc: qemu-arm@nongnu.org; qemu-devel@nongnu.org;
> > eric.auger@redhat.com; peter.maydell@linaro.org; Jason Gunthorpe
> > <jgg@nvidia.com>; Nicolin Chen <nicolinc@nvidia.com>; ddutile@redhat.com;
> > berrange@redhat.com; clg@redhat.com; alex@shazbot.org; Nathan Chen
> > <nathanc@nvidia.com>; Matt Ochs <mochs@nvidia.com>;
> > smostafa@google.com; wangzhou1@hisilicon.com;
> > jiangkunkun@huawei.com; zhangfei.gao@linaro.org;
> > zhenzhong.duan@intel.com; yi.l.liu@intel.com; Krishnakant Jaju
> > <kjaju@nvidia.com>; Michael S . Tsirkin <mst@redhat.com>
> > Subject: Re: [PATCH v7 33/36] hw/pci: Add helper to insert PCIe extended
> > capability at a fixed offset
> > 
> > External email: Use caution opening links or attachments
> > 
> > 
> > On Sun, 11 Jan 2026 19:53:19 +0000
> > Shameer Kolothum <skolothumtho@nvidia.com> wrote:
> > 
> > > Add pcie_insert_capability(), a helper to insert a PCIe extended
> > > capability into an existing extended capability list at a
> > > caller-specified offset.
> > >
> > > Unlike pcie_add_capability(), which always appends a capability to the
> > > end of the list, this helper preserves the existing list ordering while
> > > allowing insertion at an arbitrary offset.
> > >
> > > The helper only validates that the insertion does not overwrite an
> > > existing PCIe extended capability header, since corrupting a header
> > > would break the extended capability linked list. Validation of overlaps
> > > with other configuration space registers or capability-specific
> > > register blocks is left to the caller.
> > >
> > > Cc: Michael S. Tsirkin <mst@redhat.com>
> > > Signed-off-by: Shameer Kolothum <skolothumtho@nvidia.com>
> > Hi Shameer.
> 
> Happy new year!
> 
> > 
> > Random musings inline... Maybe I'm just failing in my spec grep skills.
> > 
> > > ---
> > >  hw/pci/pcie.c         | 58
> > +++++++++++++++++++++++++++++++++++++++++++
> > >  include/hw/pci/pcie.h |  2 ++
> > >  2 files changed, 60 insertions(+)
> > >
> > > diff --git a/hw/pci/pcie.c b/hw/pci/pcie.c
> > > index b302de6419..8568a062a5 100644
> > > --- a/hw/pci/pcie.c
> > > +++ b/hw/pci/pcie.c
> > > @@ -1050,6 +1050,64 @@ static void pcie_ext_cap_set_next(PCIDevice
> > *dev, uint16_t pos, uint16_t next)
> > >      pci_set_long(dev->config + pos, header);
> > >  }
> > >
> > > +/*
> > > + * Insert a PCIe extended capability at a given offset.
> > > + *
> > > + * This helper only validates that the insertion does not overwrite an
> > > + * existing PCIe extended capability header, as corrupting a header would
> > > + * break the extended capability linked list.
> > > + *
> > > + * The caller must ensure that (offset, size) does not overlap with other
> > > + * registers or capability-specific register blocks. Overlaps with
> > > + * capability-specific registers are not checked and are considered a
> > > + * user-controlled override.
> > > + */
> > > +bool pcie_insert_capability(PCIDevice *dev, uint16_t cap_id, uint8_t
> > cap_ver,
> > > +                            uint16_t offset, uint16_t size)
> > > +{
> > > +    uint16_t prev = 0, next = 0;
> > > +    uint16_t cur = pci_get_word(dev->config + PCI_CONFIG_SPACE_SIZE);
> > > +
> > > +    /* Walk the ext cap list to find insertion point */
> > > +    while (cur) {
> > > +        uint32_t hdr = pci_get_long(dev->config + cur);
> > > +        next = PCI_EXT_CAP_NEXT(hdr);
> > > +
> > > +        /* Check we are not overwriting any existing CAP header area */
> > > +        if (offset >= cur && offset < cur + PCI_EXT_CAP_ALIGN) {
> > > +            return false;
> > > +        }
> > > +
> > > +        prev = cur;
> > > +        cur = next;
> > > +        if (next == 0 || next > offset) {
> > 
> > So this (sort of) relies on a thing I've never been able to find a clear
> > statement of in the PCIe spec.  Does Next Capability Offset have to be
> > larger than the offset of the current record?  I.e. Can we have
> > backwards pointers?
> 
> That’s right. I also couldn’t find a place in the spec that explicitly
> says the list must be forward only. A device doing a backward walk
> would be pretty odd, hopefully nothing like that exists in the wild.

Yes, there's no reason not to have such pointers, with either
PCIe or classical PCI capability.


> > Meh, I think this is fine, it just came up before and I couldn't find
> > a reference to prove it!
> > 
> > More importantly, if it isn't a requirement and a rare device turns up
> > that has a backwards pointer, that just means there isn't a 'right'
> > point in the list to put this at, so any random choice is fine and
> > the next == 0 condition means we always fine an option.
> 
> Yes. 
> 
> > 
> > > +            break;
> > > +        }
> > > +    }
> > > +
> > > +   /* Make sure, next CAP header area is not over written either */
> > 
> > Looks like one space too few.
> > 
> > > +    if (next && (offset + size) >= next) {
> > > +        return false;
> > > +    }
> > > +
> > > +    /* Insert new cap */
> > > +    pci_set_long(dev->config + offset,
> > > +                 PCI_EXT_CAP(cap_id, cap_ver, cur));
> > > +    if (prev) {
> > > +        pcie_ext_cap_set_next(dev, prev, offset);
> > > +    } else {
> > > +        /* Insert at head (0x100) */
> > 
> > Comment is a little confusing as you aren't inserting the new capability
> > there.  What I think this is actually doing is
> > 
> > /*
> >  * Insert a Null Extended Capability (7.9.28 in the PCI 6.2 spec)
> >  * at head when there are no extended capabilities and use that to
> >  * point to the inserted capability at offset.
> >  */
> 
> Sure. However, Zhangfei has reported a crash with this and I have
> reworked the logic a bit to cover few corner cases. Based on his
> tests I will update this.
> 
> Thanks,
> Shameer
> 
> > > +        pci_set_word(dev->config + PCI_CONFIG_SPACE_SIZE, offset);
> > > +    }
> > > +
> > > +    /* Make capability read-only by default */
> > > +    memset(dev->wmask + offset, 0, size);
> > > +    memset(dev->w1cmask + offset, 0, size);
> > > +    /* Check capability by default */
> > > +    memset(dev->cmask + offset, 0xFF, size);
> > > +    return true;
> > > +}
> > 
> 


