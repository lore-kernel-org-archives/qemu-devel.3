Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0C80C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 17:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhCAE-0003hO-A6; Mon, 04 Mar 2024 12:31:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rhCAC-0003h7-G7
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:31:44 -0500
Received: from mail-yb1-xb2d.google.com ([2607:f8b0:4864:20::b2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rhCAA-0000gl-QM
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:31:44 -0500
Received: by mail-yb1-xb2d.google.com with SMTP id
 3f1490d57ef6-dcc6fc978ddso3827907276.0
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 09:31:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709573501; x=1710178301; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=z3Qx+aXmPP8v8jU0J6qHwTML1uLCWv1nNAU++flyM4A=;
 b=kQv9OBWftLRLE4x9eB8jF8shLTEq4itaKP2yd+8w3QowwiEi7Y1dTOSAE0wlz7CFdV
 c4doeEqCEOBzTSZqrDBL+xTcAyXwYGvj6ue9Fqk+kGq75K11OOQZAs0pv4S5D4W4Cs+q
 KyDHxsUh4hHbRDVvrISULMoJQ5TonCtI/ULBBMknfWAObudvQAFRUnspm0PwWd4huqq5
 Lz4yTn6vBB7xoDd3jD6QAx2hIr2WlG0tF1VsloPZyg/s+3/I3M85DMaWp1+04bDefGXD
 jqZWRwv6q0/moCe6H39q+yDpCyK7KAITGf48Sol+qsGsrexNSQKhk9R0SODzOzrKdlmF
 DbzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709573501; x=1710178301;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z3Qx+aXmPP8v8jU0J6qHwTML1uLCWv1nNAU++flyM4A=;
 b=oujCf3Rp73TkTZCZNpEXOCwoTYrcpLuzEV8btFFtF/vfmkrIpCw96oRjbf4Hbz5Y+l
 lSq5WQzwvyCOnCcUYUwFDvKdKCTAgyMrefcCVghmD1pzX81FU9c4rUUuKqXaB0aXvmEh
 BjIQviqBvx/zKfLa26EHTWBzJ0aq+f/UDw9MyJ4ifWuy5ydoVe7BFaxAkkjTqfk7XTfn
 01aDCgg1IFElSJ3QQsJgfDHg7vTHEvjwD2uWKBpcYU8Yr1eeEUNFpFlhhzL0lozBn7A7
 d/2jM91Tq/v8AIUdtpZVogkA+jJL4CyUfo99aFVvyfJqyzYPXIGBZ+nOMu4xwRlD5Ssj
 bQSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBYFqBCm+YDLQ0FhPEM7oS0ln4OM8RXo34oOOTOKMpy3r2vnb48gpA8s+URZbmNoot8T7NYofI0Afr9mBfzDaID5hDBO4=
X-Gm-Message-State: AOJu0YwPq/CH9UzKgTlj5lonYYabvjNgFx1ILRWdVWeW2U2yiaPorKre
 kC4zFL0P37B4c5fTLf2lv+Cc6J3vdcD6dDHwR40fZ1jeUrjYbEY0
X-Google-Smtp-Source: AGHT+IFxHkWJmBV7rK8mGrDaT2BHHaRIeh/zkdGUMy66EQvXNr9iBaUJpu1ucf+VcMJPbfZ2Q0/8mQ==
X-Received: by 2002:a05:6902:1815:b0:dc2:2ae4:d639 with SMTP id
 cf21-20020a056902181500b00dc22ae4d639mr124971ybb.20.1709573501320; 
 Mon, 04 Mar 2024 09:31:41 -0800 (PST)
Received: from debian ([50.205.20.42]) by smtp.gmail.com with ESMTPSA id
 y3-20020a25dc03000000b00dcda3959006sm2345648ybe.33.2024.03.04.09.31.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 09:31:41 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Mon, 4 Mar 2024 09:31:25 -0800
To: =?iso-8859-1?Q?J=F8rgen?= Hansen <Jorgen.Hansen@wdc.com>
Cc: "nifan.cxl@gmail.com" <nifan.cxl@gmail.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jonathan.cameron@huawei.com" <jonathan.cameron@huawei.com>,
 "linux-cxl@vger.kernel.org" <linux-cxl@vger.kernel.org>,
 "gregory.price@memverge.com" <gregory.price@memverge.com>,
 "ira.weiny@intel.com" <ira.weiny@intel.com>,
 "dan.j.williams@intel.com" <dan.j.williams@intel.com>,
 "a.manzanares@samsung.com" <a.manzanares@samsung.com>,
 "dave@stgolabs.net" <dave@stgolabs.net>,
 "nmtadam.samsung@gmail.com" <nmtadam.samsung@gmail.com>,
 "jim.harris@samsung.com" <jim.harris@samsung.com>,
 Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v4 04/10] hw/mem/cxl_type3: Add support to create DC
 regions to type3 memory devices
Message-ID: <ZeYFbeYrJfQR7sNn@debian>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
 <20240221182020.1086096-5-nifan.cxl@gmail.com>
 <ebab98e4-aa07-4aa6-84ec-768f6432e2f4@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ebab98e4-aa07-4aa6-84ec-768f6432e2f4@wdc.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2d;
 envelope-from=nifan.cxl@gmail.com; helo=mail-yb1-xb2d.google.com
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

On Mon, Mar 04, 2024 at 01:10:37PM +0000, Jørgen Hansen wrote:
> On 2/21/24 19:15, nifan.cxl@gmail.com wrote:
> > CAUTION: This email originated from outside of Western Digital. Do not click on links or open attachments unless you recognize the sender and know that the content is safe.
> > 
> > 
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > With the change, when setting up memory for type3 memory device, we can
> > create DC regions.
> > A property 'num-dc-regions' is added to ct3_props to allow users to pass the
> > number of DC regions to create. To make it easier, other region parameters
> > like region base, length, and block size are hard coded. If needed,
> > these parameters can be added easily.
> > 
> > With the change, we can create DC regions with proper kernel side
> > support like below:
> > 
> > region=$(cat /sys/bus/cxl/devices/decoder0.0/create_dc_region)
> > echo $region > /sys/bus/cxl/devices/decoder0.0/create_dc_region
> > echo 256 > /sys/bus/cxl/devices/$region/interleave_granularity
> > echo 1 > /sys/bus/cxl/devices/$region/interleave_ways
> > 
> > echo "dc0" >/sys/bus/cxl/devices/decoder2.0/mode
> > echo 0x40000000 >/sys/bus/cxl/devices/decoder2.0/dpa_size
> > 
> > echo 0x40000000 > /sys/bus/cxl/devices/$region/size
> > echo  "decoder2.0" > /sys/bus/cxl/devices/$region/target0
> > echo 1 > /sys/bus/cxl/devices/$region/commit
> > echo $region > /sys/bus/cxl/drivers/cxl_region/bind
> > 
> > However, we cannot really read/write to the DC regions due to lack of
> > 1. host backend and address space setup for DC regions;
> > 2. mailbox command support for adding/releasing DC extents.
> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > ---
> >   hw/mem/cxl_type3.c | 40 ++++++++++++++++++++++++++++++++++++++++
> >   1 file changed, 40 insertions(+)
> > 
> > diff --git a/hw/mem/cxl_type3.c b/hw/mem/cxl_type3.c
> > index 244d2b5fd5..c61cd2b5ac 100644
> > --- a/hw/mem/cxl_type3.c
> > +++ b/hw/mem/cxl_type3.c
> > @@ -567,6 +567,40 @@ static void ct3d_reg_write(void *opaque, hwaddr offset, uint64_t value,
> >       }
> >   }
> > 
> > +/*
> > + * TODO: dc region configuration will be updated once host backend and address
> > + * space support is added for DCD.
> > + */
> > +static bool cxl_create_dc_regions(CXLType3Dev *ct3d, Error **errp)
> > +{
> > +    int i;
> > +    uint64_t region_base = 0;
> > +    uint64_t region_len =  2 * GiB;
> > +    uint64_t decode_len = 2 * GiB;
> > +    uint64_t blk_size = 2 * MiB;
> > +    CXLDCDRegion *region;
> > +
> > +    if (ct3d->hostvmem) {
> > +        region_base += ct3d->hostvmem->size;
> > +    }
> > +    if (ct3d->hostpmem) {
> > +        region_base += ct3d->hostpmem->size;
> > +    }
> 
> You could use memory_region_size() here instead of accessing field directly.
> 
> Also, it doesn't look like there is any enforcement of hostvmem and 
> hostpmem being a multiple of 256MB, so region_base isn't necessarily 
> aligned to 256MB either. This probably should be fixed separately for 
> vmem and pmem, such that they check the size similar to what you do, as 
> the existing code also assumes that they are multiples of 256MB.

Yeah. I will update the code and add check here to make sure the region
base is aligned with 256MB.

Fan

> 
> > +    for (i = 0; i < ct3d->dc.num_regions; i++) {
> > +        region = &ct3d->dc.regions[i];
> > +        region->base = region_base;
> > +        region->decode_len = decode_len;
> > +        region->len = region_len;
> > +        region->block_size = blk_size;
> > +        /* dsmad_handle is set when creating cdat table entries */
> > +        region->flags = 0;
> > +
> > +        region_base += region->len;
> > +    }
> > +
> > +    return true;
> > +}
> > +
> >   static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
> >   {
> >       DeviceState *ds = DEVICE(ct3d);
> > @@ -635,6 +669,11 @@ static bool cxl_setup_memory(CXLType3Dev *ct3d, Error **errp)
> >           g_free(p_name);
> >       }
> > 
> > +    if (!cxl_create_dc_regions(ct3d, errp)) {
> > +        error_setg(errp, "setup DC regions failed");
> > +        return false;
> > +    }
> > +
> >       return true;
> >   }
> > 
> > @@ -930,6 +969,7 @@ static Property ct3_props[] = {
> >                        HostMemoryBackend *),
> >       DEFINE_PROP_UINT64("sn", CXLType3Dev, sn, UI64_NULL),
> >       DEFINE_PROP_STRING("cdat", CXLType3Dev, cxl_cstate.cdat.filename),
> > +    DEFINE_PROP_UINT8("num-dc-regions", CXLType3Dev, dc.num_regions, 0),
> >       DEFINE_PROP_END_OF_LIST(),
> >   };
> > 
> > --
> > 2.43.0
> > 
> > 
> 
> Thanks,
> Jorgen

