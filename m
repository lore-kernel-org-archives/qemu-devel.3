Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51E83CCD18E
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Oct 2025 09:06:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v8aye-0000Vw-Tq; Tue, 14 Oct 2025 05:05:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v8ayd-0000Vo-Co
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 05:05:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1v8aya-0000Kq-DC
 for qemu-devel@nongnu.org; Tue, 14 Oct 2025 05:05:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760432746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BCNZcQOf0Bag4g0cQ2XrIFeDod0G86j2tb+J6htdoks=;
 b=CGu0+/oEtKuBljVq31p6fAZq5TUCJjcz3ws6itnkLxvYR8ENuDPV0cVybKw5kqmx6hVMTw
 qU0jKiflCXabE8WBZ2H4rx1+7B6EGW8GAsuPplRVHAdIS+UZGBh0/pwrtZ8uMxSRKtAPiF
 5MTnLXqQ8zujg/KJe1V2Knk/3G+r/70=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-467-1Hn8hukKMa-0Dzwi8SkqTw-1; Tue, 14 Oct 2025 05:05:45 -0400
X-MC-Unique: 1Hn8hukKMa-0Dzwi8SkqTw-1
X-Mimecast-MFC-AGG-ID: 1Hn8hukKMa-0Dzwi8SkqTw_1760432744
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3ecdfe971abso4140327f8f.2
 for <qemu-devel@nongnu.org>; Tue, 14 Oct 2025 02:05:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760432744; x=1761037544;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BCNZcQOf0Bag4g0cQ2XrIFeDod0G86j2tb+J6htdoks=;
 b=kZ00Luutj4J2f3/q6rLdxVz6oy2rt3O6H6YuC3m43nRIi9hAkJBZBxC/v/n39tttc/
 9Xq26skOwKLpYcEg2QxAchrUJ21HeIqCuVab7y13p6Hf2SNeSnsXkHAcGc1QgBXvZesf
 PSNKkZF6mgLr8PdFekT8vqd/E1Cmc4nKBe6KBsn421E0sXL+PDKdIlRtgKPkKCcdMHbZ
 FGNztAOsE4uysYyEcoiqYA+7YDb8tSMMsS0/fcgRFzJyHQEM1HW2HQZOnCaCPDhf2Zru
 MNxQ/02YNwXnMBGnwWQIRAe81Qoh/UXvkK2RXi38ZgamwFCGFH3T3sOr4NUB6oemWpb8
 Vhrg==
X-Gm-Message-State: AOJu0Yyk5KjHYuuGEZ3Fd/84GMzQEIcKOCO6hskGlkVFeHfIQBPzeKYq
 VGbHQuDa6j/pxEzaZMqGU8dRmbrOxJyvnlQZpJVKYIMv4xPT4Ync05fbFlJ6gg11tTPKWgUmJiq
 VBIoqdOpKgYppEVdye62cucxc5Ss6BfcuX0iNW3nCmsYCLHJY35h8qw6p
X-Gm-Gg: ASbGncsS7rwSjPfs8UeVH4ffFKp/7BdAnI6u4H+i+cCa8qRVmRG2xmU4GH1gNijCvCp
 Ub8c6KXUEYE/ODF7OQEYayFHZxy9rce9XMK6DNy5pCFKwSn2j0BJq63Ac5jg1JFzPkFVeCthHX4
 qXvzFAaNSrn9YPZsWSALrLxKFUhOZu174xvf/aidk7k0/R95Hf9G2WXtIRpyQY4WNV9LKT3Y0Ts
 TXkkyov2dapCNncr2JCUmdgTGonM3lvUDBABBpXM3AocdaoPKiSqeQ990pf/uOyuNkOB75K7R8h
 OBXFGdBtVgmwajSn11zR6DeA6s2/p6JChw==
X-Received: by 2002:a05:6000:2c11:b0:3ee:15bb:72c8 with SMTP id
 ffacd0b85a97d-4266e7dfd9dmr16937387f8f.36.1760432744140; 
 Tue, 14 Oct 2025 02:05:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOY769jf8tNJwoS6yKdiDIYexYYwtu0oLN5BIhVGRiFs7DCEiuBk06XYrrdupAM9TbIwOtdg==
X-Received: by 2002:a05:6000:2c11:b0:3ee:15bb:72c8 with SMTP id
 ffacd0b85a97d-4266e7dfd9dmr16937356f8f.36.1760432743610; 
 Tue, 14 Oct 2025 02:05:43 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-426e50ef821sm7889951f8f.38.2025.10.14.02.05.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Oct 2025 02:05:43 -0700 (PDT)
Date: Tue, 14 Oct 2025 05:05:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Sairaj Kodilkar <sarunkod@amd.com>
Cc: qemu-devel@nongnu.org, alejandro.j.jimenez@oracle.com,
 pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, suravee.suthikulpanit@amd.com,
 vasant.hegde@amd.com, marcel.apfelbaum@gmail.com,
 eduardo@habkost.net, aik@amd.com
Subject: Re: [PATCH v2 2/2] amd_iommu: Support 64 bit address for IOTLB lookup
Message-ID: <20251014050512-mutt-send-email-mst@kernel.org>
References: <20251013050046.393-1-sarunkod@amd.com>
 <20251013050046.393-3-sarunkod@amd.com>
 <20251013041617-mutt-send-email-mst@kernel.org>
 <e4c5d25c-572c-45fe-8e64-b6f141c0f82e@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e4c5d25c-572c-45fe-8e64-b6f141c0f82e@amd.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Oct 14, 2025 at 02:34:28PM +0530, Sairaj Kodilkar wrote:
> 
> 
> On 10/13/2025 1:49 PM, Michael S. Tsirkin wrote:
> > On Mon, Oct 13, 2025 at 10:30:46AM +0530, Sairaj Kodilkar wrote:
> > > Physical AMD IOMMU supports up to 64 bits of DMA address. When device tries
> > > to read or write from a given DMA address, IOMMU translates the address
> > > using page table assigned to that device. Since IOMMU uses per device page
> > > tables, the emulated IOMMU should use the cache tag of 68 bits
> > > (64 bit address - 12 bit page alignment + 16 bit device ID).
> > > 
> > > Current emulated AMD IOMMU uses GLib hash table to create software iotlb
> > > and uses 64 bit key to store the IOVA and deviceID, which limits the IOVA
> > > to 60 bits. This causes failure while setting up the device when guest is
> > > booted with "iommu.forcedac=1".
> > > 
> > > To solve this problem, Use 64 bit IOVA and 16 bit devid as key to store
> > > entries in IOTLB; Use upper 52 bits of IOVA (GFN) and lower 12 bits of
> > > the device ID to construct the 64 bit hash key in order avoid the
> > > truncation as much as possible (reducing hash collisions).
> > > 
> > > Fixes: d29a09ca6842 ("hw/i386: Introduce AMD IOMMU")
> > > Signed-off-by: Sairaj Kodilkar<sarunkod@amd.com>
> > I am wondering whether we need to limit how much host memory
> > can the shadow take. Because with so many bits, the sky is the limit ...
> > OTOH it's not directly caused by this patch, but it's something
> > we should think about maybe.
> 
> I don't think I fully understand this. Do you mean the host memory
> taken by the pages used to build shadow page table ?

the memory used by the hash table.

> 
> > Something more to improve:
> > 
> > 
> > > ---
> > >   hw/i386/amd_iommu.c | 57 ++++++++++++++++++++++++++++++---------------
> > >   hw/i386/amd_iommu.h |  4 ++--
> > >   2 files changed, 40 insertions(+), 21 deletions(-)
> > > 
> > > diff --git a/hw/i386/amd_iommu.c b/hw/i386/amd_iommu.c
> > > index b194e3294dd7..a218d147e53d 100644
> > > --- a/hw/i386/amd_iommu.c
> > > +++ b/hw/i386/amd_iommu.c
> > > @@ -106,6 +106,11 @@ typedef struct amdvi_as_key {
> > >       uint8_t devfn;
> > >   } amdvi_as_key;
> > > +typedef struct amdvi_iotlb_key {
> > > +    uint64_t gfn;
> > > +    uint16_t devid;
> > > +} amdvi_iotlb_key;
> > > +
> > Pls change struct and typedef names to match qemu coding style.
> Thanks
> Sairaj


