Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC380C369C9
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Apr 2025 21:26:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u5AGP-0001ZH-QO; Wed, 16 Apr 2025 17:25:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1u5AGM-0001Z2-OV
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 17:25:42 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1u5AGK-0000A1-4x
 for qemu-devel@nongnu.org; Wed, 16 Apr 2025 17:25:41 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-22c33677183so1499795ad.2
 for <qemu-devel@nongnu.org>; Wed, 16 Apr 2025 14:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744838738; x=1745443538; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=oAEUDZKbLPgza5DZtsu0FJyh6PwlcfTu2jJWNYque1Y=;
 b=Lbb8cENDhMp8PKPOWqdSRwtl/XujdEqKxnICcfzjoE9f/3sTeGgItkFayM8RTJ4si5
 KjSa5GlrEhLmixxt9kqTjA2oz9g54i2J1tPphwSUYRQrmkD2jg6ZO8mvz17Hnb+gYdW4
 3SWNnXE/DcjUnswAohYwm+bxmlnTICo2hqF8PGa3s2jWhwFGtIfrNbw+uYOjTJPG+ipn
 qbAbbvh6RhA7tl7dA61baJv9A6mKPsm7yNHQZLy8QutaR3LkAMPoZn+sWq+dPGhWVgff
 x9slRt2g3w+YFhzySsOdl8Q8diMgUTcwk/NgmJ8/qawprntvlU2C+zn1V4BLfENTfrMB
 /wDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744838738; x=1745443538;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oAEUDZKbLPgza5DZtsu0FJyh6PwlcfTu2jJWNYque1Y=;
 b=wz+p+biUZ14bE6AVREXRWQQpv1wz2okW3b/4ww8A8aBRPMO3Tw8L6T4CZjX0v58nP6
 4IsAeGaDshBYOIeOBiXldJeYzKG+uSe3Gm+k5c61C4Q+X+ohnz5PRBZlXuuDj+fQO21O
 aDeS5KTZ7xlCyC9LKurUCHuJ1yBkjPOPz3gt6YvV1ala5JmqfeNU7a1d8p9f5YYx63DD
 Qgj0OVSRtwF7UUubPvIUV38AFLEBMiyz7nXflrQJykmiTYWXA8vvIvQre3RhIT4bfN8W
 2i0CjxOXCMrzPy5lv12yVPIwZkA5LZ5y2emxdTkUiI4tznx4Ht0yHu9pNy2J2bMqXUX7
 V7xw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW4m6RQcnTe5ge8i+yOHokYIVSrkZy2+SM8FB7cKM7x2dbXWKGh91UD/w7ztdrHDk5u8QZaBHv8J9Ly@nongnu.org
X-Gm-Message-State: AOJu0YyGqsghM5As3TOwghmgkzx8MREiCocU+qUcZVNyJ1CnkTq2dR4F
 K6eTt6lqfCaZAY5SnoEz26MHV7KAzbHWfBFDDaS9LPXq33zJJCf2
X-Gm-Gg: ASbGncuKcNsXoUesJpcQZWSki0Myu276ZIHNyjUIWUvMZBITyfaqG3vs34TWNpb1QZ7
 fQvyiagLe2Nfie6gLwvwiHgNBF+meuNOStT1e7rsH8HhQtaE9B3PQHrGw6gi9mlJET55tf4QLOd
 fSZVlp74sG93hl2OwM/cB+ar0dq4LACmnWwzVG5Qm12ZkpAjkz7V/+WWXPIA5T323Dr+Nl3YACg
 od7fWuRMboE8Vh41+p3kXBW6+DZYKs1litYSj3+OyrTdcppFD6f0gNDz5woVlCP21rJV/ebCFvK
 MkQRqU7wxNI2ssZtw1ZP2HsK5fjmRUnbXafbfZuCGZF2oGW+aWegsh1UKSomrqFcEt1jIyy/fHj
 GjQ==
X-Google-Smtp-Source: AGHT+IGP3CPy6p8wued0F90EC+c8Pvvq25w8rVHX8qBnidg5TnYXPH4w3uHp5M00MdN4ml26InZEhg==
X-Received: by 2002:a17:902:eb8a:b0:224:2200:5940 with SMTP id
 d9443c01a7336-22c3596b995mr66522655ad.38.1744838737875; 
 Wed, 16 Apr 2025 14:25:37 -0700 (PDT)
Received: from deb-101020-bm01.eng.stellus.in ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-308537cdb13sm2663562a91.0.2025.04.16.14.25.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Apr 2025 14:25:37 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Wed, 16 Apr 2025 21:25:34 +0000
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: anisa.su887@gmail.com, qemu-devel@nongnu.org, nifan.cxl@gmail.com,
 dave@stgolabs.net, linux-cxl@vger.kernel.org
Subject: Re: [PATCH 2/9] cxl-mailbox-utils: 0x5600 - FMAPI Get DCD Info
Message-ID: <aAAgTjeapPWpXhjt@deb-101020-bm01.eng.stellus.in>
References: <20250317164204.2299371-1-anisa.su887@gmail.com>
 <20250317164204.2299371-3-anisa.su887@gmail.com>
 <20250318155624.00006410@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250318155624.00006410@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=anisa.su887@gmail.com; helo=mail-pl1-x630.google.com
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

On Tue, Mar 18, 2025 at 03:56:24PM +0000, Jonathan Cameron wrote:
> On Mon, 17 Mar 2025 16:31:29 +0000
> anisa.su887@gmail.com wrote:
> 
> > From: Anisa Su <anisa.su@samsung.com>
> > 
> > FM DCD Management command 0x5600 implemented per CXL 3.2 Spec Section 7.6.7.6.1
> > 
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> > ---
> >  hw/cxl/cxl-mailbox-utils.c | 67 ++++++++++++++++++++++++++++++++++++++
> >  hw/cxl/i2c_mctp_cxl.c      |  6 +++-
> >  2 files changed, 72 insertions(+), 1 deletion(-)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index 1b62d36101..e9991fd1a7 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -122,6 +122,8 @@ enum {
> >          #define MANAGEMENT_COMMAND     0x0
> >      MHD = 0x55,
> >          #define GET_MHD_INFO 0x0
> > +    FMAPI_DCD_MGMT = 0x56,
> > +        #define GET_DCD_INFO 0x0
> >  };
> >  
> >  /* CCI Message Format CXL r3.1 Figure 7-19 */
> > @@ -3341,6 +3343,62 @@ static CXLRetCode cmd_dcd_release_dyn_cap(const struct cxl_cmd *cmd,
> >      return CXL_MBOX_SUCCESS;
> >  }
> >  
> > +/*
> > + * CXL r3.2 section 7.6.7.6.1: Get DCD Info (Opcode 5600h)
> > + */
> 
> Single line comment should be fine here.
> 
> > +static CXLRetCode cmd_fm_get_dcd_info(const struct cxl_cmd *cmd,
> > +                                      uint8_t *payload_in,
> > +                                      size_t len_in,
> > +                                      uint8_t *payload_out,
> > +                                      size_t *len_out,
> > +                                      CXLCCI *cci)
> > +{
> > +    struct {
> > +        uint8_t num_hosts;
> > +        uint8_t num_regions_supported;
> > +        uint8_t rsvd1[2];
> > +        uint16_t add_select_policy_bitmask;
> > +        uint8_t rsvd2[2];
> > +        uint16_t release_select_policy_bitmask;
> > +        uint8_t sanitize_on_release_bitmask;
> > +        uint8_t rsvd3;
> > +        uint64_t total_dynamic_capacity;
> > +        uint64_t region_blk_size_bitmasks[8];
> > +    } QEMU_PACKED *out;
>     } QEMU_PACKED *out = (void *)payload_out;
> > +    CXLType3Dev *ct3d = CXL_TYPE3(cci->d);
> > +    CXLDCRegion region;
> > +    int i;
> > +
> > +    if (ct3d->dc.num_regions == 0) {
> > +        return CXL_MBOX_UNSUPPORTED;
> > +    }
> > +
> > +    out = (void *)payload_out;
> Why not just do this at declaration above?
> It is harmless to set it then even if we exit earlier
> I think.
> 
> > +
> > +    /* TODO: num hosts set to 1 for now */
> 
> Unless this changes later in the set, no need for a todo here.
> This simply denotes what we are emulating. Maybe we will make
> it more flexible in future, maybe not.
> 
> > +    out->num_hosts = 1;
> > +    out->num_regions_supported = ct3d->dc.num_regions;
> > +    /* TODO: only prescriptive supported for now */
> 
> Likewise, not a todo that needs comment. Just a current setting.
> As long as we never make it nor support this we are fine for
> compatibility etc.  The CXL stuff doesn't support migration anyway
> so not problems there.
> 
> > +    stw_le_p(&out->add_select_policy_bitmask,
> > +             CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE);
should be
BIT(CXL_EXTENT_SELECTION_POLICY_PRESCRIPTIVE)
> > +    stw_le_p(&out->release_select_policy_bitmask,
> > +             CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE);
should be
BIT(CXL_EXTENT_REMOVAL_POLICY_PRESCRIPTIVE)

-Anisa
> > +    /* TODO: sanitize on release bitmask cleared for now */
> 
> As with above, not really a todo, more of a choice made for now.
> 
> > +    out->sanitize_on_release_bitmask = 0;
> > +
> > +    stq_le_p(&out->total_dynamic_capacity,
> > +             ct3d->dc.total_capacity / CXL_CAPACITY_MULTIPLIER);
> > +
> > +    for (i = 0; i < ct3d->dc.num_regions; i++) {
> > +        region = ct3d->dc.regions[i];
> > +        memcpy(&out->region_blk_size_bitmasks[i],
> > +                &region.supported_blk_size_bitmask, 8);
> 
> sizeof(out->region_blk_size_bitmasks[i]) 
> 
> > +    }
> > +
> > +    *len_out = sizeof(*out);
> > +    return CXL_MBOX_SUCCESS;
> > +}
> > +
> >  static const struct cxl_cmd cxl_cmd_set[256][256] = {
> >      [INFOSTAT][BACKGROUND_OPERATION_ABORT] = { "BACKGROUND_OPERATION_ABORT",
> >          cmd_infostat_bg_op_abort, 0, 0 },
> > @@ -3462,6 +3520,11 @@ static const struct cxl_cmd cxl_cmd_set_sw[256][256] = {
> >                                       cmd_tunnel_management_cmd, ~0, 0 },
> >  };
> >  
> > +static const struct cxl_cmd cxl_cmd_set_fm_dcd[256][256] = {
> > +    [FMAPI_DCD_MGMT][GET_DCD_INFO] = { "GET_DCD_INFO",
> > +        cmd_fm_get_dcd_info, 0, 0},
> > +};
> > +
> >  /*
> >   * While the command is executing in the background, the device should
> >   * update the percentage complete in the Background Command Status Register
> > @@ -3764,7 +3827,11 @@ void cxl_initialize_t3_fm_owned_ld_mctpcci(CXLCCI *cci, DeviceState *d,
> >                                             DeviceState *intf,
> >                                             size_t payload_max)
> >  {
> > +    CXLType3Dev *ct3d = CXL_TYPE3(d);
> >      cxl_copy_cci_commands(cci, cxl_cmd_set_t3_fm_owned_ld_mctp);
> > +    if (ct3d->dc.num_regions) {
> > +        cxl_copy_cci_commands(cci, cxl_cmd_set_fm_dcd);
> > +    }
> >      cci->d = d;
> >      cci->intf = intf;
> >      cxl_init_cci(cci, payload_max);
> > diff --git a/hw/cxl/i2c_mctp_cxl.c b/hw/cxl/i2c_mctp_cxl.c
> > index 7d2cbc3b75..df95182925 100644
> > --- a/hw/cxl/i2c_mctp_cxl.c
> > +++ b/hw/cxl/i2c_mctp_cxl.c
> > @@ -46,6 +46,9 @@
> >  /* Implementation choice - may make this configurable */
> >  #define MCTP_CXL_MAILBOX_BYTES 512
> >  
> > +/* Supported FMAPI Cmds */
> > +#define FMAPI_CMD_MAX_OPCODE 0x57
> > +
> >  typedef struct CXLMCTPMessage {
> >      /*
> >       * DSP0236 (MCTP Base) Integrity Check + Message Type
> > @@ -200,7 +203,8 @@ static void i2c_mctp_cxl_handle_message(MCTPI2CEndpoint *mctp)
> >          if (!(msg->message_type == MCTP_MT_CXL_TYPE3 &&
> >                msg->command_set < 0x51) &&
> >              !(msg->message_type == MCTP_MT_CXL_FMAPI &&
> > -              msg->command_set >= 0x51 && msg->command_set < 0x56)) {
> > +              msg->command_set >= 0x51 &&
> > +              msg->command_set < FMAPI_CMD_MAX_OPCODE)) {
> 
> Hmm. There is a visibility problem here we should address but probably not
> by introducing a new define.  Maybe we should move the enum from
> cxl-mailbox-utils.c in a precursor patch.
> 
> Jonathan
> 
> 
> >              buf->rc = CXL_MBOX_UNSUPPORTED;
> >              st24_le_p(buf->pl_length, len_out);
> >              s->len = s->pos;
> 

