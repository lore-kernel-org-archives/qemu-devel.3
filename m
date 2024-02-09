Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C44A6C48297
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Feb 2024 19:04:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYWAw-0004oR-Pr; Fri, 09 Feb 2024 14:04:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rYWAv-0004oC-Kt
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 14:04:37 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rYWAt-0003aO-Mo
 for qemu-devel@nongnu.org; Fri, 09 Feb 2024 14:04:37 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1d7431e702dso12222965ad.1
 for <qemu-devel@nongnu.org>; Fri, 09 Feb 2024 11:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707505473; x=1708110273; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hLI+DnLAUF0CmVB8aA9JgOPaPHjiy2v35lOZdbLXb/U=;
 b=mC3LQrLcJa4J2EyK4ZHJTGnsizv5cuyrNtQoo1SbNNfe1V6XN4ICRqhnHwy+8BeZ8f
 ehw/+Zmy+KLkIRveqMiZCGa3LlW9IMn1+55VjiVdUnNOlm89k5Xvl+hA0ziItZtZ7r1p
 IezumyL9WndcfxZAmyU1cjqDz+s7ubYPUSzGDGcVAHdk4KgqbSr7Jai1yXUzvlxC833m
 dBI2Y9Po4u1XrWIs97m0yzRcnCrF7zwAul06GKVMTZcP7IsEJLQnMIs9aI7aJ/TO9NeI
 gZaZSkDad0zsYqVat4pEI37MLUOg4JdZaY66takvEquy9kQFfXETG1aK2DKiB1uqpo5I
 YPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707505473; x=1708110273;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=hLI+DnLAUF0CmVB8aA9JgOPaPHjiy2v35lOZdbLXb/U=;
 b=pkEn6QwZqjJJWg/sXKopJTZCP0O2j0wHihW+/Wuz2+YOqpTbYY7Q8avma4ZJoLNwto
 pE/LAxYoeIej9Dn66JYWR1mLRIc1RzLZXvBdwnSqKzEQyiVOQRK46aTNNW9pu37vuyT+
 NNbHfVzFo5lVNwcwOjop2Y+pA2m8x5+Yj0TeHleJf7yS6HI8dTVV7vEFNxHpVQ8/2Bdt
 NcS2lQeQ9X+cTXDwBpAuSan5ug304Ob/C2pAECYv5sIpru53eX3pPsZF+8rLr5TWIo/X
 U3659pjUeAqemUjcV6Wmx2jeZRBaNIIhehTSEP5QfvHZv92DfkqW2eqpUiiTwTJc4M6P
 mYZQ==
X-Gm-Message-State: AOJu0YybppiNn5S7n5fJPlpy9t/g2HJ1znM3IFwiuHvaEyhQXP8U5JX/
 f8XsgwvOtdKchiuWmrPhrLYnb/J29SeBAyDHqBOV/k2HhLLL4D4b
X-Google-Smtp-Source: AGHT+IFAKeIpM5HBs8uhyYJXitvSknzU8xFlSnpeBRlIL3wrrZ19jFh6XtYQYKVPHkqkTbE0Bqr5TQ==
X-Received: by 2002:a17:903:988:b0:1d9:a5ec:30c6 with SMTP id
 mb8-20020a170903098800b001d9a5ec30c6mr90736plb.44.1707505472634; 
 Fri, 09 Feb 2024 11:04:32 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCU4sa+AiQu2q/mj4EPZYDBqmnNLtFk7pAy9uXWraQQf39DuubXS4BpmbOlEzRLy3rzNuunlxVw7veyXZhUld7hoP55gvKfODbvhUVm4YtvyJxnpFia8SdLtZDUe1FcF4Dv2e8vKuXES9wvdxroowrFisCTkQXdUigaZTKrpsuObfCZIjCHnnlveaMoHUH/7Leo0v7NPabjyPncmQXq8t5sIKZGVSOm8W8/KucSh4BFELIN8mX/D265xeooKcTyxyRS5femorvrlP0ILxStEkO7hwZpcv840jXvv20uPWWriYtL9G2ylOAE37hE6Cz/ElqNL3b0w9uV5jnKO2d3wj/fLLElR72ZMzzo8TAX1mvDMmZ9djZkSeQ==
Received: from debian ([2601:641:300:14de:9652:d83b:aa3c:1e1f])
 by smtp.gmail.com with ESMTPSA id
 kk7-20020a170903070700b001d8f99dbe4asm1829773plb.4.2024.02.09.11.04.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Feb 2024 11:04:32 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Fri, 9 Feb 2024 11:04:13 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net,
 nmtadam.samsung@gmail.com, nifan@outlook.com,
 jim.harris@samsung.com, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v3 9/9] hw/mem/cxl_type3: Add dpa range validation for
 accesses to dc regions
Message-ID: <ZcZ3LU9bM20Lomce@debian>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
 <20231107180907.553451-10-nifan.cxl@gmail.com>
 <20240124165815.00007e46@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240124165815.00007e46@Huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Jan 24, 2024 at 04:58:15PM +0000, Jonathan Cameron wrote:
> On Tue,  7 Nov 2023 10:07:13 -0800
> nifan.cxl@gmail.com wrote:
> 
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > Not all dpa range in the dc regions is valid to access until an extent
> DPA ... DC etc
> 
> > covering the range has been added. Add a bitmap for each region to
> > record whether a dc block in the region has been backed by dc extent.
> > For the bitmap, a bit in the bitmap represents a dc block. When a dc
> > extent is added, all the bits of the blocks in the extent will be set,
> > which will be cleared when the extent is released.
> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> 
> Hi Fan, one query inline and a few comments.
> 
> Jonathan
> 
> > 
> > --
> > JC changes:
> > - Rebase on what will be next gitlab.com/jic23/qemu CXL staging tree.
> > - Drop unnecessary handling of failed bitmap allocations. In common with
> >   most QEMU allocations they fail hard anyway.
> > - Use previously factored out cxl_find_region() helper
> > - Minor editorial stuff in comments such as spec version references
> >   according to the standard form I'm trying to push through the code.
> > Picked up Jørgen's fix:
> > https://lore.kernel.org/qemu-devel/d0d7ca1d-81bc-19b3-4904-d60046ded844@wdc.com/T/#u
> > ---
> >  hw/cxl/cxl-mailbox-utils.c  | 31 +++++++++------
> >  hw/mem/cxl_type3.c          | 78 +++++++++++++++++++++++++++++++++++++
> >  include/hw/cxl/cxl_device.h | 15 +++++--
> >  3 files changed, 109 insertions(+), 15 deletions(-)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index 8e6a98753a..6be92fb5ba 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -1401,10 +1401,9 @@ CXLDCDRegion *cxl_find_dc_region(CXLType3Dev *ct3d, uint64_t dpa, uint64_t len)
> >  }
> >  
> >  void cxl_insert_extent_to_extent_list(CXLDCDExtentList *list,
> > -                                             uint64_t dpa,
> > -                                             uint64_t len,
> > -                                             uint8_t *tag,
> > -                                             uint16_t shared_seq)
> > +                                      uint64_t dpa, uint64_t len,
> > +                                      uint8_t *tag,
> > +                                      uint16_t shared_seq)
> 
> avoid noisy whitespace changes like this.
> 
> 
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index 43cea3d818..4ec65a751a 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> 
> > +/*
> > + * Check whether a DPA range [dpa, dpa + len) has been backed with DC extents.
> > + * Used when validating read/write to dc regions
> > + */
> > +bool ct3_test_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
> > +                                  uint64_t len)
> > +{
> > +    CXLDCDRegion *region;
> > +    uint64_t nbits;
> > +    long nr;
> > +
> > +    region = cxl_find_dc_region(ct3d, dpa, len);
> > +    if (!region) {
> > +        return false;
> > +    }
> > +
> > +    nr = (dpa - region->base) / region->block_size;
> > +    nbits = DIV_ROUND_UP(len, region->block_size);
> > +    return find_next_zero_bit(region->blk_bitmap, nr + nbits, nr) == nr + nbits;
> I'm not sure how this works... Is it taking a size or an end point?
> 
> Linux equivalent takes size, so I'd expect
> 
>     return find_next_zero_bit(region->blk_bitmap, nbits, nr);
> Perhaps a comment would avoid any future confusion on this.
> 

My understanding is that the size is the size of the bitmap, which is
also end of the range to check, not the length of the range to check.

The function find_next_zero_bit(bitmap, size, offset) checks the bitmap range
[offset, size) to find the next unset bit, for the above test, we want to
check range [nr, nr + nbits), so the arguments passed to the function
should be right.

In the definition of the function, whenever offset >= size, it returns size
because size is the end of the range, So if we pass nbits and nr
to the function and nr >= nbits, which can be common, meaning (dpa-region_base)
\> len, the function will always return true; that is not what we want.

To sum up, the second parameter of the function should always be the end
of the range to check, for our case, it is nr + nbits.

Fan



> > +}
> > +
> > +/*
> > + * Mark the DPA range [dpa, dap + len) to be unbacked and inaccessible. This
> > + * happens when a dc extent is return by the host.
> > + */
> > +void ct3_clear_region_block_backed(CXLType3Dev *ct3d, uint64_t dpa,
> > +                                   uint64_t len)
> > +{
> > +    CXLDCDRegion *region;
> > +    uint64_t nbits;
> > +    long nr;
> > +
> > +    region = cxl_find_dc_region(ct3d, dpa, len);
> > +    if (!region) {
> > +        return;
> > +    }
> > +
> > +    nr = (dpa - region->base) / region->block_size;
> > +    nbits = len / region->block_size;
> > +    bitmap_clear(region->blk_bitmap, nr, nbits);
> > +}
> > +
> 

