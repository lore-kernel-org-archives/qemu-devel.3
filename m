Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 509C6C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 17:20:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdZCw-0002sW-0I; Fri, 23 Feb 2024 12:19:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rdYqr-00089T-AF
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:56:46 -0500
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rdYqd-0004D5-0V
 for qemu-devel@nongnu.org; Fri, 23 Feb 2024 11:56:44 -0500
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-5ce07cf1e5dso505841a12.2
 for <qemu-devel@nongnu.org>; Fri, 23 Feb 2024 08:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708707384; x=1709312184; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vqxkXBb6PhFa+1UMisoz0rLwEEh0zgLzrj88ji9tSBE=;
 b=eao4We7WUsFsxhHMy1lOKop8LDbjRpAhb7QHmWc32ONYvOFB4xDc0BLtsRYjCBsysz
 TLCmNnYFmoF3Kn78Xn+B4dckVMLVXw852Pt8RAcjw/czXBd1T9ps7yY5YMLbtmL6S9a+
 gtSt9zvkS01k9dUzpIYYingknKQSapoQDEj3xPuJ7TJhi6Dzg8Xm3r3ZrPiJMy+9Jh2X
 pmmL4amh9Crh/VrLNAThFF39B1G6mvZDiciucyd+orF7/WSrEnrgYK83bakHc91FWfJd
 OClVJg2XoN7WuRYm03S6x/y67XNk6WQ1uq1NoPxm7g3AC+0O22A/eAlQlr7jYaFF9vRW
 yQjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708707384; x=1709312184;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:date:from
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vqxkXBb6PhFa+1UMisoz0rLwEEh0zgLzrj88ji9tSBE=;
 b=Z9zpcCDDwgnQqg9lU8PfKyHARGHdmEaQs8/g5wRBLZ1aheblXzLIEQBLCiFO6U7SI1
 FVStgVtSRSUzX0jJWxXaZQ352A0spv12xlhOHH0PE7vwhPw8BRtZvqIAr0cm6QTqi7ti
 ucZZshQqHSkynARCw4TU5MJvwejWy0ad7qN0+FoN5vlqmZWdq6B9qRcRP1D7FrlzbTjf
 Ycr4n5n7VEJJg7zzRStIU8FnkM6293RQty1jahLug3NeLTNrubFF7Jrt3fox277sf28k
 Nio4/GzkR58f2XGhAAW1+ZALHAE0dMDLg029hnIWB71DfK7cF8gF3eMSOS8/xtfDKOAf
 2bmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6UrwZUENPzPwCgyM3wttmxDtNubYXqI8ah7eJHjSK/gXKyaNe5YfQsOj6Wt9gfL47o10tKsbXgD4mE63LIAGIm7rq3aY=
X-Gm-Message-State: AOJu0Yzfr53lQaxDHXER3GJ0Be5+Qo5BqtNrkqqRDFIGzZKlCHf/sysp
 gsrOZeVT8jL6CBiF25ATXTLS/njhmqwzImkxGUDKRxYFOqQuMlc/
X-Google-Smtp-Source: AGHT+IHglsYhoWeG3jZSwWCRSwZ9e5fr4Q2O6UQV67X9L0DgRTBvHxYp69k21a8PrRmiUC0+SMfWww==
X-Received: by 2002:a05:6a21:3987:b0:1a0:dfc8:9ddd with SMTP id
 ad7-20020a056a21398700b001a0dfc89dddmr465920pzc.6.1708707384208; 
 Fri, 23 Feb 2024 08:56:24 -0800 (PST)
Received: from debian ([2601:641:300:14de:2595:938c:d7c1:5827])
 by smtp.gmail.com with ESMTPSA id
 e26-20020aa78c5a000000b006e3809da4fdsm12126930pfd.83.2024.02.23.08.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Feb 2024 08:56:23 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Fri, 23 Feb 2024 08:56:09 -0800
To: Wonjae Lee <wj28.lee@gmail.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, jonathan.cameron@huawei.com,
 linux-cxl@vger.kernel.org, gregory.price@memverge.com,
 ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net,
 nmtadam.samsung@gmail.com, jim.harris@samsung.com,
 Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v4 07/10] hw/mem/cxl_type3: Add DC extent list
 representative and get DC extent list mailbox support
Message-ID: <ZdjOKWTm5aCJc8o9@debian>
References: <20240221182020.1086096-1-nifan.cxl@gmail.com>
 <20240221182020.1086096-8-nifan.cxl@gmail.com>
 <6fad2a96-aba6-46a1-a1ef-85be4faba59b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6fad2a96-aba6-46a1-a1ef-85be4faba59b@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Fri, Feb 23, 2024 at 04:16:53PM +0900, Wonjae Lee wrote:
> On 2024-02-22 오전 3:16, nifan.cxl@gmail.com wrote:
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > Add dynamic capacity extent list representative to the definition of
> > CXLType3Dev and add get DC extent list mailbox command per
> > CXL.spec.3.1:.8.2.9.9.9.2.
> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> > ---
> >   hw/cxl/cxl-mailbox-utils.c  | 71 +++++++++++++++++++++++++++++++++++++
> >   hw/mem/cxl_type3.c          |  1 +
> >   include/hw/cxl/cxl_device.h | 23 ++++++++++++
> >   3 files changed, 95 insertions(+)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index f95e417683..dae7fe00ed 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -83,6 +83,7 @@ enum {
> >           #define CLEAR_POISON           0x2
> >       DCD_CONFIG  = 0x48,
> >           #define GET_DC_CONFIG          0x0
> > +        #define GET_DYN_CAP_EXT_LIST   0x1
> >       PHYSICAL_SWITCH = 0x51,
> >           #define IDENTIFY_SWITCH_DEVICE      0x0
> >           #define GET_PHYSICAL_PORT_STATE     0x1
> > @@ -1344,6 +1345,73 @@ static CXLRetCode cmd_dcd_get_dyn_cap_config(const struct cxl_cmd *cmd,
> >       return CXL_MBOX_SUCCESS;
> >   }
> > +/*
> > + * CXL r3.1 section 8.2.9.9.9.2:
> > + * Get Dynamic Capacity Extent List (Opcode 4801h)
> > + */
> > +static CXLRetCode cmd_dcd_get_dyn_cap_ext_list(const struct cxl_cmd *cmd,
> > +                                               uint8_t *payload_in,
> > +                                               size_t len_in,
> > +                                               uint8_t *payload_out,
> > +                                               size_t *len_out,
> > +                                               CXLCCI *cci)
> > +{
> > +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> > +    struct get_dyn_cap_ext_list_in_pl {
> > +        uint32_t extent_cnt;
> > +        uint32_t start_extent_id;
> > +    } QEMU_PACKED;
> > +
> > +    struct get_dyn_cap_ext_list_out_pl {
> > +        uint32_t count;
> > +        uint32_t total_extents;
> > +        uint32_t generation_num;
> > +        uint8_t rsvd[4];
> > +        CXLDCExtentRaw records[];
> > +    } QEMU_PACKED;
> > +
> > +    struct get_dyn_cap_ext_list_in_pl *in = (void *)payload_in;
> > +    struct get_dyn_cap_ext_list_out_pl *out = (void *)payload_out;
> > +    uint16_t record_count = 0, i = 0, record_done = 0;
> > +    CXLDCExtentList *extent_list = &ct3d->dc.extents;
> > +    CXLDCExtent *ent;
> > +    uint16_t out_pl_len;
> > +    uint32_t start_extent_id = in->start_extent_id;
> > +
> > +    if (start_extent_id > ct3d->dc.total_extent_count) {
> 
> Hello,
> 
> Shouldn't it be >= rather than >?
> 
> (I accidentally replied to v3 with the same comment above, so please ignore
> that.)

The spec says "Greater than", so I will keep it as it is until there is
more clarification about this. When start_extent_id ==
total_extent_count, return 0 extents.

Fan
> 
> Thanks,
> Wonjae
> 

