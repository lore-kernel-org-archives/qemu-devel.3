Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A2F7C83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 18:18:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubNkV-0002Fk-5K; Mon, 14 Jul 2025 14:17:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1ubMrh-0008Jm-1i
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 13:21:26 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1ubMre-0004hr-GV
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 13:21:20 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-31a93a4b399so4009412a91.0
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 10:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752513673; x=1753118473; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=1xCcyA4imSktTZNuYs6d0ixwsnZXyJ0ZGdf4DChw5wg=;
 b=XwcfhtK2UD45yjSKCTV65+CV6Dd735ogYDqQxy3BonDdu10movIBzmIGHVLbCmdsa3
 ZXorK441EMdpz2yY9HXGj+DTt2agXsxKK9z+Q1Qkcz48wcwKNuB1MY5Mm1gPfKpmwmVf
 JSVu3Cc02vO0l8kqC7gugHoHygfuCsYwIWL5VvRaBcWe6+opxHlspCR+HSb3n+hayJNJ
 ktN0MFyPwnROTRMp8o04yh/srdGrikV8z7D06LtdpuczXAQsj/ALKm+Qfyx1PN0kC5O9
 gOIpBnx+dWPUnJAkhaqPdZJpQCpsCpmeHd/t7s0/iojwnit3P0cFOcI+JhAaX0zMyo4x
 9z4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752513673; x=1753118473;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1xCcyA4imSktTZNuYs6d0ixwsnZXyJ0ZGdf4DChw5wg=;
 b=UmFn12iCeJbLwv9hB+Bem5n8XWUYsXrSqVoYPR/yEXcFGdhMDzYb7rw82wmeFUrihC
 Sa2ieuDwgl0eKvsoLi+Rezr9RsTKjDIkgrvM7p+rfBaWetSKkDPXiYEvkaTzTTHv8Fev
 iwVSzMO5jJYDJoOiLV6413zHXIVsOvlCix81cOsRMPdM7Lu0POEDvY3uxJLdpIa/nB2G
 rJxVL5Itf7Et6SZNCYC3/8qt7y5X27ufCmD+ORIFNVWInXDwf7TMR6ZoucnLTqvdxTsR
 wuJZpcomvWlkkNeINty57OAF5/CaIcBnBrPE/7A874CitFO9O2nW06lTRsozsIB1taYa
 8kgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmuJEO63AQiP7jkKYsDehcxQF3jYNfl3U44/fNyFIaN/TiT63XlqLqt5eh5DM5PS6kMB66tmQcrP68@nongnu.org
X-Gm-Message-State: AOJu0Ywj7RJ4ZkscuwnyEAN9oUpvQvg1XJ7JcwhDNTniWqS4fAhxaKBQ
 3ATNU3/tPTijA46D+OuuhjZYKLzMST/Mr7tYUI9KFQXOwckQmiFMgcRO
X-Gm-Gg: ASbGncsXs/rjgrVotrbeDqinzRyPcXav+QlToUQRli7gsQzWGkW9TBevOGeMTH/50AR
 FdY+h6VLM5iNZRWCMssQPbnHytIC5hO9+ThHw9PXxF0D84oCOIIvFp0B2IunYx11pEKFGs9dvLU
 y/Ene5xz87ohUf0P9uOALlue/DXU+4TCKRioYE0q1LYXpU547fy3kri078/IdLjjdfUDbN95+sL
 SuJ+hOAWD12rs5+hwBgigUV842+iLHwUr+Iy/m8LkNpVGFkooM5JMBOsGhprTyKMj0ey4dYaRd8
 WAw2lAjzwKzW3L3RWjYXaOlMzxdAGaIK4P0naI+1Fih+9vamOllEErobLL4wSzJJ89wubabznZ+
 3hEkp1NGVBZI1fipJi7Yvqgdzj/LjWTZbJN7z/lm/SuIBWlN6muTc+LW1vFU=
X-Google-Smtp-Source: AGHT+IGuhyRqHc5viAmr7xsq1hveDst/ENhxsyPig6SbkAqDcGHad0xcjDvWpUnfE0UUA5RN4jLJpg==
X-Received: by 2002:a17:90b:4ecb:b0:2fa:2133:bc87 with SMTP id
 98e67ed59e1d1-31c8f7d9573mr554006a91.6.1752513672930; 
 Mon, 14 Jul 2025 10:21:12 -0700 (PDT)
Received: from deb-101020-bm01.eng.stellus.in ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-31c3eb4654esm11192278a91.29.2025.07.14.10.21.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 14 Jul 2025 10:21:12 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Mon, 14 Jul 2025 17:21:10 +0000
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: Fan Ni <nifan.cxl@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, linuxarm@huawei.com
Subject: Re: [PATCH qemu 07/11] hw/cxl: mailbox-utils: 0x5602 - FMAPI Set DC
 Region Config
Message-ID: <aHU8huAwCLTh2sLx@deb-101020-bm01.eng.stellus.in>
References: <20250702160219.989731-1-Jonathan.Cameron@huawei.com>
 <20250702160219.989731-8-Jonathan.Cameron@huawei.com>
 <20250714052757-mutt-send-email-mst@kernel.org>
 <20250714150218.00006c95@huawei.com>
 <20250714151512.00000a2a@huawei.com>
 <20250714151638.000038ac@huawei.com> <aHU0K4bXbPLsed5t@lg>
 <20250714180226.0000562d@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250714180226.0000562d@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=anisa.su887@gmail.com; helo=mail-pj1-x1029.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, Jul 14, 2025 at 06:02:26PM +0100, Jonathan Cameron wrote:
> On Mon, 14 Jul 2025 09:45:31 -0700
> Fan Ni <nifan.cxl@gmail.com> wrote:
> 
> > On Mon, Jul 14, 2025 at 03:16:38PM +0100, Jonathan Cameron wrote:
> > > On Mon, 14 Jul 2025 15:15:12 +0100
> > > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > >   
> > > > On Mon, 14 Jul 2025 15:02:18 +0100
> > > > Jonathan Cameron <Jonathan.Cameron@huawei.com> wrote:
> > > >   
> > > > > On Mon, 14 Jul 2025 05:32:19 -0400
> > > > > "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > >     
> > > > > > On Wed, Jul 02, 2025 at 05:02:13PM +0100, Jonathan Cameron wrote:      
> > > > > > > From: Anisa Su <anisa.su@samsung.com>
> > > > > > > 
> > > > > > > FM DCD Management command 0x5602 implemented per CXL r3.2 Spec Section 7.6.7.6.3
> > > > > > > 
> > > > > > > Reviewed-by: Fan Ni <fan.ni@samsung.com>
> > > > > > > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > > > > > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>      
> > > > > 
> > > > >     
> > > > > > > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > > > > > > index bf1710b251..1fc453f70d 100644
> > > > > > > --- a/hw/cxl/cxl-mailbox-utils.c
> > > > > > > +++ b/hw/cxl/cxl-mailbox-utils.c      
> > > > >     
> > > > > > > +/* CXL r3.2 section 7.6.7.6.3: Set Host DC Region Configuration (Opcode 5602) */
> > > > > > > +static CXLRetCode cmd_fm_set_dc_region_config(const struct cxl_cmd *cmd,
> > > > > > > +                                              uint8_t *payload_in,
> > > > > > > +                                              size_t len_in,
> > > > > > > +                                              uint8_t *payload_out,
> > > > > > > +                                              size_t *len_out,
> > > > > > > +                                              CXLCCI *cci)
> > > > > > > +{
> > > > > > > +    struct {
> > > > > > > +        uint8_t reg_id;
> > > > > > > +        uint8_t rsvd[3];
> > > > > > > +        uint64_t block_sz;
> > > > > > > +        uint8_t flags;
> > > > > > > +        uint8_t rsvd2[3];
> > > > > > > +    } QEMU_PACKED *in = (void *)payload_in;
> > > > > > > +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> > > > > > > +    CXLEventDynamicCapacity dcEvent = {};
> > > > > > > +    CXLDCRegion *region = &ct3d->dc.regions[in->reg_id];
> > > > > > > +
> > > > > > > +    /*
> > > > > > > +     * CXL r3.2 7.6.7.6.3: Set DC Region Configuration
> > > > > > > +     * This command shall fail with Unsupported when the Sanitize on Release
> > > > > > > +     * field does not match the region’s configuration... and the device
> > > > > > > +     * does not support reconfiguration of the Sanitize on Release setting.
> > > > > > > +     *
> > > > > > > +     * Currently not reconfigurable, so always fail if sanitize bit (bit 0)
> > > > > > > +     * doesn't match.
> > > > > > > +     */
> > > > > > > +    if ((in->flags & 0x1) != (region->flags & 0x1)) {
> > > > > > > +        return CXL_MBOX_UNSUPPORTED;
> > > > > > > +    }
> > > > > > > +
> > > > > > > +    if (in->reg_id >= DCD_MAX_NUM_REGION) {
> > > > > > > +        return CXL_MBOX_UNSUPPORTED;
> > > > > > > +    }
> > > > > > > +
> > > > > > > +    /* Check that no extents are in the region being reconfigured */
> > > > > > > +    if (!bitmap_empty(region->blk_bitmap, region->len / region->block_size)) {
> > > > > > > +        return CXL_MBOX_UNSUPPORTED;
> > > > > > > +    }
> > > > > > > +
> > > > > > > +    /* Check that new block size is supported */
> > > > > > > +    if (!test_bit(BIT((int) log2(in->block_sz)),
> > > > > > > +                  &region->supported_blk_size_bitmask)) {
> > > > > > > +        return CXL_MBOX_INVALID_INPUT;
> > > > > > > +    }        
> > > > > > 
> > > > > > This does not work: test_bit works on unsigned long, while
> > > > > > supported_blk_size_bitmask is uint64_t.
> > > > > > 
> > > > > > Why so funky? what is wrong with:
> > > > > > 
> > > > > > if (!(BIT_ULL(log2(in->block_sz)) & region->supported_blk_size_bitmask))
> > > > > > 
> > > > > > And BTW why cast to int here?      
> > > > This became obvious when your suggestion didn't build :(
> > > > 
> > > > ./../hw/cxl/cxl-mailbox-utils.c: In function ‘cmd_fm_set_dc_region_config’:
> > > > /home/jic23/src/qemu/include/qemu/bitops.h:25:39: error: invalid operands to binary << (have ‘long long unsigned int’ and ‘double’)
> > > >    25 | #define BIT_ULL(nr)             (1ULL << (nr))
> > > >       |                                       ^~ ~~~~
> > > > ../../hw/cxl/cxl-mailbox-utils.c:3436:11: note: in expansion of macro ‘BIT_ULL’
> > > >  3436 |     if (!(BIT_ULL(log2(in->block_sz)) & region->supported_blk_size_bitmask)) {
> > > >       |           ^~~~~~~
> > > > 
> > > > Now I look again, this is effectively 2**(log_2(x)) or x. So
> > > > if (in->block_sz & region->supporte_blk_size_bitmask)  
> > > 
> > > it (!(in->block_sz & region->supports_blk_size_bitmask))
> > > 
> > > I mean.  
> > 
> > Make sense to me. 
> > 
> > The only thing is how to detect the violation if the passed in block_sz
> > is not power of 2.
> > Or who will do the check if not in qemu?
> Hi Fan,
> 
> I checked the spec on this.  There isn't an explicit statement that the device
> should return an error on this. Looks to be impdef. I'd happily see such
> a check as a usability improvement though!
> 
> I'm just not set up to test this right now so decided to be
> risk averse and not trying adding one. 
> 
> If you want to send a patch on top I'd be happy to add it.
> 
> Jonathan
> 
> 
Would something like this work?

/* Check that new block size is supported */
if (!is_power_of_2(in->block_sz) ||
    !(in->block_sz & region->supported_blk_size_bitmask)) {
    return CXL_MBOX_INVALID_INPUT;
}

I did not have to add any extra headers to use this helper function in
include/qemu/host-utils.h and it compiles for me.

Anisa
> 
> > 
> > Fan
> > 
> > > 
> > >   
> > > > Should work as long as we know block_size is a power of 2 (which the specification
> > > > says it must be).
> > > > 
> > > > Anisa?
> > > >   
> > > > > 
> > > > > Change looks fine to me, so I'll prepare an updated set with this
> > > > > and the missing semi colon.  Anisa if you can have a look at this
> > > > > that would be great. 
> > > > > 
> > > > > Sorry I seem to have missed Anisa off the cc for this!
> > > > > 
> > > > > Jonathan
> > > > >     
> > > >   
> > >   
> > 
> 

