Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18219C48286
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Feb 2024 19:59:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rVdDb-00053E-2m; Thu, 01 Feb 2024 14:59:27 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rVdDV-00052U-S4
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 14:59:21 -0500
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <nifan.cxl@gmail.com>)
 id 1rVdDS-0001qk-W6
 for qemu-devel@nongnu.org; Thu, 01 Feb 2024 14:59:21 -0500
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1d746856d85so10218825ad.0
 for <qemu-devel@nongnu.org>; Thu, 01 Feb 2024 11:59:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1706817556; x=1707422356; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BMvVeyGQAKcLy19Wng8scvDqqyK6VsFbdgmF17TbVuU=;
 b=kjXid4ZNnHCoWrS+79TObMOqLJfmJk9DaKoDkTd4qw+pn88uONvkAHOc1cc+iRBSDF
 xpRgyllmge2hl607cM185J5vEVzxue6EwUArvOqiifRadKC9mwaWeNYzvb47Pa/Nd6BU
 VikqB3rFNvN4Jh9q7x7cUqulZdl+UN9nRvKCtn3732v6Re8YE3/unzL4ojcfMd/CUNNf
 xGqtiBgjQiJUywvy0XgiaJz+NF3UXmxNp24s0PaI4HxjlEu0tyENPISEmAhKbLb3pUAK
 qGJdhrprueepponkJY0Nnf3Jjc9HyE/Kx/cVijMcVRNY3L0MoAK80YUbNMZWl1RZcFEs
 CJHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706817556; x=1707422356;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BMvVeyGQAKcLy19Wng8scvDqqyK6VsFbdgmF17TbVuU=;
 b=Ge0r0/LrUpXHrdXDSsr90YGN4XpeXl3yrhLiUTzBhfhXbN/fQes9jZBzQ3b7fkvaLF
 TRIXrRco5fnTno9j6vSPxhThpUzPTNB2iLEvC1m8GD3t1AOjOW9M8RuiSISKYG89s3+b
 ZDy86auORRzJ1LEuaL0E8iqzn7NUhqPRJkcy4jM+otR1Sx3x6PwuUzSjBmJ/yhHMFJib
 tu18kCL5IHAGUBNTuUD+8dKmaMeTuRI5dbooxmIlg+XmatUZBjXwav6W37d77yl26shO
 8LWp7qDP3L6P8nWoWrZdl2QiEzPtQLbeMFGXYStI/pn40loYy402U2iKowaxOQEz/cmH
 RKDw==
X-Gm-Message-State: AOJu0YyQGx1XpbeLGpCienUDTR61su7A6W3MCIkQ73nNH/zfll5p37ct
 Fys3UMMiA4RbPNjinQiyKM1is1Ol5Q6WN3X2/Vsq0F8hhBGBOto2
X-Google-Smtp-Source: AGHT+IGX7zMsQOTtRtzsvdu2rWo4Cqx7IT1uaxp/xRQmtpEy0IyGdc4BAdIPoVmuIZyX2hd295Rp1Q==
X-Received: by 2002:a17:903:110f:b0:1d9:4ede:66b5 with SMTP id
 n15-20020a170903110f00b001d94ede66b5mr108700plh.15.1706817556464; 
 Thu, 01 Feb 2024 11:59:16 -0800 (PST)
X-Forwarded-Encrypted: i=0;
 AJvYcCWpqdOuR9cVXtqyFkEPYnbc3oh0PscqNphdmeRRh+npanra86IEt+y6bIaJuFVRBietlJhuzQC6o52dLd3xEbiIOR74AItQTlCzOpGKaheHE/E8rJaYVY+x0sQJxwxuU2j/wOFtVneI1QSlYmE2FFp5vYeZ+FqFFHTtA5pJOmOJzZqqQ8krPGiRWGemysrv0r4+xfyNKzU7WqM6l/lgGho7T8WLzNurnWgE6NoYcYaR6lVB2owTRLE1LGWjut8xn07cInghTXWRoEK3ACbgW1HS6CJdhhNosOiLukIHaRKtlQOOSMbVMaMXyRHZTBvF0GPCgqItrJ51KzPB7vqkTbxxTPop3o2zr4RZ4tB+snHtxXX9O7yb+w==
Received: from debian ([2601:641:300:14de:e8a1:d128:e5c4:4d0c])
 by smtp.gmail.com with ESMTPSA id
 d5-20020a170902ef0500b001d8ee46170dsm212942plx.84.2024.02.01.11.59.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Feb 2024 11:59:16 -0800 (PST)
From: fan <nifan.cxl@gmail.com>
X-Google-Original-From: fan <fan@debian>
Date: Thu, 1 Feb 2024 11:58:43 -0800
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: nifan.cxl@gmail.com, qemu-devel@nongnu.org, linux-cxl@vger.kernel.org,
 ira.weiny@intel.com, dan.j.williams@intel.com,
 a.manzanares@samsung.com, dave@stgolabs.net,
 nmtadam.samsung@gmail.com, nifan@outlook.com,
 jim.harris@samsung.com, Fan Ni <fan.ni@samsung.com>
Subject: Re: [PATCH v3 2/9] hw/cxl/cxl-mailbox-utils: Add dynamic capacity
 region representative and mailbox command support
Message-ID: <Zbv3806dVKTqjF0u@debian>
References: <20231107180907.553451-1-nifan.cxl@gmail.com>
 <20231107180907.553451-3-nifan.cxl@gmail.com>
 <20240124145118.00002f7d@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240124145118.00002f7d@Huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=nifan.cxl@gmail.com; helo=mail-pl1-x62f.google.com
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

On Wed, Jan 24, 2024 at 02:51:18PM +0000, Jonathan Cameron wrote:
> On Tue,  7 Nov 2023 10:07:06 -0800
> nifan.cxl@gmail.com wrote:
> 
> > From: Fan Ni <fan.ni@samsung.com>
> > 
> > Per cxl spec 3.0, add dynamic capacity region representative based on
> > Table 8-126 and extend the cxl type3 device definition to include dc region
> > information. Also, based on info in 8.2.9.8.9.1, add 'Get Dynamic Capacity
> > Configuration' mailbox support.
> > 
> > Note: decode_len of a dc region is aligned to 256*MiB, need to be divided by
> > 256 * MiB before returned to the host for "Get Dynamic Capacity Configuration"
> > mailbox command.
> > 
> > Signed-off-by: Fan Ni <fan.ni@samsung.com>
> 
> Hi Fan,
> 
> I'm looking at how to move these much earlier in my tree on basis that
> they should be our main focus for merging in this QEMU cycle.
> 
> Whilst I do that rebase, I'm taking a closer look at the code.
> I'm targetting rebasing on upstream qemu + the two patch sets I just
> sent out:
> [PATCH 00/12 qemu] CXL emulation fixes and minor cleanup. 
> [PATCH 0/5 qemu] hw/cxl: Update CXL emulation to reflect and reference r3.1
> 
> It would be good to document why these commands should be optional (which I think
> comes down to the annoying fact that Get Dynamic Capacity Configuration isn't
> allowed to return 0 regions, but instead should not be available as a command
> if DCD isn't supported.
> 
> Note this requires us to carry Gregory's patches to make the CCI command list
> constructed at runtime rather than baked in ahead of this set.
> 
> So another question is should we jump directly to the r3.1 version of DCD?
> I think we probably should as it includes some additions that are necessary
> for a bunch of the potential use cases.
> 

Based on cxl spec r3.1, the get dynamic capacity configuration output
payload (Table 8-164) have 4 extra items after the variable region configuration
structure. That is not allowed by the compiler, should we move the
new-added 4 items before the variable region configuration structures?

Fan

> 
> > ---
> >  hw/cxl/cxl-mailbox-utils.c  | 80 +++++++++++++++++++++++++++++++++++++
> >  hw/mem/cxl_type3.c          |  6 +++
> >  include/hw/cxl/cxl_device.h | 17 ++++++++
> >  3 files changed, 103 insertions(+)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index 8eceedfa87..f80dd6474f 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -80,6 +80,8 @@ enum {
> >          #define GET_POISON_LIST        0x0
> >          #define INJECT_POISON          0x1
> >          #define CLEAR_POISON           0x2
> > +    DCD_CONFIG  = 0x48,
> > +        #define GET_DC_CONFIG          0x0
> >      PHYSICAL_SWITCH = 0x51,
> >          #define IDENTIFY_SWITCH_DEVICE      0x0
> >          #define GET_PHYSICAL_PORT_STATE     0x1
> > @@ -1210,6 +1212,74 @@ static CXLRetCode cmd_media_clear_poison(const struct cxl_cmd *cmd,
> >      return CXL_MBOX_SUCCESS;
> >  }
> >  
> > +/*
> > + * CXL r3.0 section 8.2.9.8.9.1: Get Dynamic Capacity Configuration
> 
> As per the patch set I just sent out, I want to standardize on references
> to r3.1 because it's all that is easy to get.  However if we decide to r3.0
> DCD first the upgrade it later, then clearly these need to stick to r3.0 for
> now.
> 
> > + * (Opcode: 4800h)
> > + */
> > +static CXLRetCode cmd_dcd_get_dyn_cap_config(const struct cxl_cmd *cmd,
> > +                                             uint8_t *payload_in,
> > +                                             size_t len_in,
> > +                                             uint8_t *payload_out,
> > +                                             size_t *len_out,
> > +                                             CXLCCI *cci)
> > +{
> > +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> > +    struct get_dyn_cap_config_in_pl {
> > +        uint8_t region_cnt;
> > +        uint8_t start_region_id;
> > +    } QEMU_PACKED;
> > +
> > +    struct get_dyn_cap_config_out_pl {
> > +        uint8_t num_regions;
> > +        uint8_t rsvd1[7];
> 
> This changed in r3.1 (errata? - I haven't checked)
> Should be 'regions returned' in first byte.
> 
> > +        struct {
> > +            uint64_t base;
> > +            uint64_t decode_len;
> > +            uint64_t region_len;
> > +            uint64_t block_size;
> > +            uint32_t dsmadhandle;
> 
> > +            uint8_t flags;
> > +            uint8_t rsvd2[3];
> > +        } QEMU_PACKED records[];
> 
> There are two fields after this as well.
> Total number of supported extents and number of available extents.
> 
> That annoyingly means we can't use the structure to tell us where
> to find all the fields...
> 
> 
> > +    } QEMU_PACKED;
> > +
> > +    struct get_dyn_cap_config_in_pl *in = (void *)payload_in;
> > +    struct get_dyn_cap_config_out_pl *out = (void *)payload_out;
> > +    uint16_t record_count = 0, i;
> 
> Better to split that on to 2 lines. Never hide setting a value
> in the middle of a set of declarations.
> 
> > +    uint16_t out_pl_len;
> > +    uint8_t start_region_id = in->start_region_id;
> > +
> > +    if (start_region_id >= ct3d->dc.num_regions) {
> > +        return CXL_MBOX_INVALID_INPUT;
> > +    }
> > +
> > +    record_count = MIN(ct3d->dc.num_regions - in->start_region_id,
> > +            in->region_cnt);
> > +
> > +    out_pl_len = sizeof(*out) + record_count * sizeof(out->records[0]);
> 
> For r3.1 + 8 for the two trailing fields.
> 
> > +    assert(out_pl_len <= CXL_MAILBOX_MAX_PAYLOAD_SIZE);
> > +
> > +    memset(out, 0, out_pl_len);
> 
> As part of the cci rework we started zeroing the whole mailbox payload space
> after copying out the input payload.
> https://elixir.bootlin.com/qemu/latest/source/hw/cxl/cxl-device-utils.c#L204
> 
> So shouldn't need this (unless we have a bug)
> 
> Jonathan

