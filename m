Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C8DC48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 17:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhCEH-0005MS-HE; Mon, 04 Mar 2024 12:35:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rhCEF-0005MI-Gr
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:35:55 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rhCEE-0001XH-51
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:35:55 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-609a773ec44so16296477b3.3
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 09:35:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709573753; x=1710178553; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=49d9IAE1DJB4fKfr/UgeNRcP4hLs0HGBVdcf75tkwvk=;
 b=VircP3OHt0THozTI9Wb9lzWOd1KyASV+SfCwEsXZl0ZdnOu+ydJ6YuO0NPdenVgE1r
 lbP9tyAirAWpmVuw7q0nis/huVHqbqRBs9qlw1kiKcjtr0Ri2DaBBHpWvYL0mA88XeVU
 MZJNRWgkL1HTv3QWmU6HGhV0hDwRkv6j5uE0YE9qBnJqiFMTPaPx5WMy4g7ezkOkHk1+
 B4oIgeHt1mNdWjYS8o/HhuK3VfWfU+huLMWb+IEERoloBF2bMqzJFvLHoE7yLzBkAbLi
 z4X2Vh7wW2qXN4GD8xg+E7fJmWVxwyZ0K2hichD2dDEWmHZQMsVhYkR/zxMb2AuDG/zP
 Aq6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709573753; x=1710178553;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=49d9IAE1DJB4fKfr/UgeNRcP4hLs0HGBVdcf75tkwvk=;
 b=CoMPFovfoIAwFWNzOfrrt7goLiUKOXsSlFQDdKLKXLv5/QH4RII0qA2Ap1y142UcLC
 MD39fwET7Wdq6JR050yYUz5MuMewVqVonfDwcUYPrs7Ps480xTKwkhXJ1ZLagP+mdWfC
 FJPyFl3EMxuOw1mLuo0SCgzKi0+ua0TXYSI4tiDAebDAWLQtzgFeFIYin5fsEB6cAjqS
 QRUk90qzYWJUjgj6X06uyypaTVoLt1X4AWdGwXSrXpIhsq/kYSsGc+1dIJZ2iG3/+nd2
 ATOs7LKz4zfBi8XmQPEuMe6lf96dy9P/izkVJHhrXC7YBjNdsgVynVjFfLyxLb2T+bNU
 tEXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXo+FjIi0b5o/YN3DYiZlB1JvHLB/6bIfj1vDh3aOqJ+6C4OjZAkxrhyKakzvEovhABvMQHYJAhkTg16/VChny1bPU7gYs=
X-Gm-Message-State: AOJu0YysYQPBRdnE1F1gXdozvNeJYXaumMUvJcv/DuX5SGv8aWtjM1KS
 jZxSsdLDG0wj/CsK74h9ccW0s+GGeCB6G7V6fvivnWhgCvrWDDot
X-Google-Smtp-Source: AGHT+IE3DUAH5SuCKalB5QdXYLGfxv8xiTKi9q/Z3pLebmewcUhJt8pJp4dEXgo5SHNnWmRnWYY6NQ==
X-Received: by 2002:a81:a54a:0:b0:608:fa36:1c27 with SMTP id
 v10-20020a81a54a000000b00608fa361c27mr9465551ywg.23.1709573753025; 
 Mon, 04 Mar 2024 09:35:53 -0800 (PST)
Received: from debian ([50.205.20.42]) by smtp.gmail.com with ESMTPSA id
 w84-20020a814957000000b006096dafea6fsm2667802ywa.62.2024.03.04.09.35.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 09:35:52 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Mon, 4 Mar 2024 09:35:50 -0800
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
Subject: Re: [PATCH v4 02/10] hw/cxl/cxl-mailbox-utils: Add dynamic capacity
 region representative and mailbox command support
Message-ID: <ZeYGduNSn4WGzOz5@debian>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
 <20240221182020.1086096-3-nifan.cxl@gmail.com>
 <8a141940-86fd-43c8-8834-a25b0d1e79fe@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <8a141940-86fd-43c8-8834-a25b0d1e79fe@wdc.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=nifan.cxl@gmail.com; helo=mail-yw1-x112e.google.com
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

On Mon, Mar 04, 2024 at 12:40:18PM +0000, Jørgen Hansen wrote:
> On 2/21/24 19:15, nifan.cxl@gmail.com wrote:
> > CAUTION: This email originated from outside of Western Digital. Do not click on links or open attachments unless you recognize the sender and know that the content is safe.
> > 
> > 
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > Per cxl spec r3.1, add dynamic capacity region representative based on
> > Table 8-165 and extend the cxl type3 device definition to include dc region
> > information. Also, based on info in 8.2.9.9.9.1, add 'Get Dynamic Capacity
> > Configuration' mailbox support.
> > 
> > Note: decode_len of a dc region is aligned to 256*MiB, divided by
> > 256 * MiB before returned to the host for "Get Dynamic Capacity Configuration"
> > mailbox command.
> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > ---
> >   hw/cxl/cxl-mailbox-utils.c  | 110 ++++++++++++++++++++++++++++++++++++
> >   include/hw/cxl/cxl_device.h |  16 ++++++
> >   2 files changed, 126 insertions(+)
> > 
> 
> [snip]
> 
> > 
> >       /* No separation for PCI MB as protocol handled in PCI device */
> > diff --git a/include/hw/cxl/cxl_device.h b/include/hw/cxl/cxl_device.h
> > index 3cf3077afa..6df7fecdf1 100644
> > --- a/include/hw/cxl/cxl_device.h
> > +++ b/include/hw/cxl/cxl_device.h
> > @@ -422,6 +422,17 @@ typedef struct CXLPoison {
> >   typedef QLIST_HEAD(, CXLPoison) CXLPoisonList;
> >   #define CXL_POISON_LIST_LIMIT 256
> > 
> > +#define DCD_MAX_REGION_NUM 8
> > +
> > +typedef struct CXLDCDRegion {
> > +    uint64_t base;
> > +    uint64_t decode_len; /* aligned to 256*MiB */
> > +    uint64_t len;
> > +    uint64_t block_size;
> > +    uint32_t dsmadhandle;
> > +    uint8_t flags;
> > +} CXLDCDRegion;
> > +
> 
> To be consistent with the naming of extents, and functions defined later 
> on, shouldn't this be CXLDCRegion (DC instead of DCD)?
> 

I was also thinking about it and a bit lazy to make the change until
someone points out. Now I have a good reason to make the change :-).
Thanks.

Fan

> >   struct CXLType3Dev {
> >       /* Private */
> >       PCIDevice parent_obj;
> > @@ -454,6 +465,11 @@ struct CXLType3Dev {
> >       unsigned int poison_list_cnt;
> >       bool poison_list_overflowed;
> >       uint64_t poison_list_overflow_ts;
> > +
> > +    struct dynamic_capacity {
> > +        uint8_t num_regions; /* 0-8 regions */
> > +        CXLDCDRegion regions[DCD_MAX_REGION_NUM];
> > +    } dc;
> >   };
> > 
> >   #define TYPE_CXL_TYPE3 "cxl-type3"
> > --
> > 2.43.0
> > 
> > 
> 
> Thanks,
> Jorgen

