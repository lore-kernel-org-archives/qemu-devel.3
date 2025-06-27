Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95A99C77B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 16:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVC5o-0006Zu-WD; Fri, 27 Jun 2025 12:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uVC5n-0006Zd-6E
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 12:38:23 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anisa.su887@gmail.com>)
 id 1uVC5l-0006L6-1E
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 12:38:22 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-739b3fe7ce8so2926598b3a.0
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 09:38:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751042299; x=1751647099; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=+KrP4NrgRfqKvj7KEsF377Ymituu2ngJplzC+zDSckM=;
 b=Xm95IyVuLtn2msqu1Df5fWrIgmiRfbw4SaZtkR8LE2hCuD0NQNZgXzCzq1BoPwp8Lh
 I4g7jlpKd8fpUN3LL9EqEqkpnGeSDDEYy0F366pOtsGp6GRe+aDCJYh3mZ7Te9i/XFfn
 dBzGw3xIgN6kHLAeQLkUEg+V14A/hdSM+wICMtWh9KilNPCeavWyUcstbnr2rHvd0T/P
 n4q3B3L/qVbG8p6AQtZC9OIkXrTl/ohFA0B8FNR9dSQWz1fxmmBfI4BvSjpXp+RowYkl
 eeqfp+THua49Jv6qluftRIUiXs12J4CAjdNekm2l7QtqwNBJ6McS/qLkprRfVWS1r6Zn
 QIAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751042299; x=1751647099;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:date:from:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+KrP4NrgRfqKvj7KEsF377Ymituu2ngJplzC+zDSckM=;
 b=kfgrXZ+OMbr60njyK5gI0gFCTlIKhKZOOPz31Tk6oiPe63SvMpVRsaagGP92aP6S1H
 HeaXgKld/kwdvQOHivyJTxylTr4WoDFsRR3sjHzJJDdZF2pPRtgQDb6Lxey7gJYd73GK
 LtGhizEvot+fRNbDmDGJPQ4bBUF3TtXlBH/UReraeA7ktqipPIKUwrud0rX2o+kU+qb2
 tuHCxQXO23AxfqtbHldfm2g4KFqswsynPcl1Np0ocyO0M4LKwlC0jyvn0kFtzbu28lZV
 YAFiro4RoKl14kO2xc3T3LfrBEMU0OkPxbqv6VVEP76rWE5zGHeZOf/tMU5TiFasPSXG
 x6YA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXGNiX65X23c1KUdTdUCitW8V9wUOF52t3g2cA7micVYbk7Rwqwe/izitHlwXdxHWYxDjn2ZPJYJePF@nongnu.org
X-Gm-Message-State: AOJu0Yy22U4l6SU4BmQAmE3EvkieO+YyYMnW7ddkq/AGCj8/iQ2dHxqE
 BA470Fz9xS1yROm9iydDG+KMtx78+YeiFNUusagW3cgC5s296I77hIZK
X-Gm-Gg: ASbGncveABpJTXHDP/ubmpjY/vhiDk/sa39JctdPAOO6/qOPTSz0HBAoI4rTIjECyqT
 lKp0Ni6kRDpX8x+QOEy3GL++HpWSObb/4sqNEd1xcN9AY4+bJsaXJW+vQb/GulrDqBcUQu+3Nsc
 OAIc3tkrQt9OcInWFxEBt9jEjvvsB9yeTXxJ4rJedfBc9BdRMRTY1QRg0eQwigSFBy/mmuYAEQN
 FQZzToI48tgRx1BYpkUQPLeIZAClHIjx1Q7BFenjKSVgdcbBfleo9UGQu1ag51WI9CWaoznrRoU
 djbH51IAdEA6wOUuX/kY11dwBZ7nR9dbg8fRXEcfRN/1pi7QMadnoUzlktYN3esuJqX+jOpRvzq
 XDMW2NQk3Yg4VatYYAfl2/ao=
X-Google-Smtp-Source: AGHT+IFEGzayuaUZPPDUntzB46BhlvyBWNVdIiBGBzdvEUIpwGJfB0HiDIzF6jM+3w0dl/cI9PShew==
X-Received: by 2002:a17:902:d58f:b0:235:2e0:ab8 with SMTP id
 d9443c01a7336-23ac3cf54a7mr51063175ad.6.1751042298751; 
 Fri, 27 Jun 2025 09:38:18 -0700 (PDT)
Received: from deb-101020-bm01.eng.stellus.in ([149.97.161.244])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b34e300468esm2027696a12.7.2025.06.27.09.38.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 Jun 2025 09:38:18 -0700 (PDT)
From: Anisa Su <anisa.su887@gmail.com>
X-Google-Original-From: Anisa Su <anisa.su@samsung.com>
Date: Fri, 27 Jun 2025 16:38:16 +0000
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: anisa.su887@gmail.com, qemu-devel@nongnu.org, nifan.cxl@gmail.com,
 dave@stgolabs.net, linux-cxl@vger.kernel.org
Subject: Re: [HACK QEMU PATCH v1 1/1] hw/cxl: Fix MCTP Binding Check
Message-ID: <aF7I-ByGLZOxqNXi@deb-101020-bm01.eng.stellus.in>
References: <20250626235102.1902427-1-anisa.su887@gmail.com>
 <20250626235102.1902427-2-anisa.su887@gmail.com>
 <20250627104859.00003cbe@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250627104859.00003cbe@huawei.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=anisa.su887@gmail.com; helo=mail-pf1-x42b.google.com
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

On Fri, Jun 27, 2025 at 10:48:59AM +0100, Jonathan Cameron wrote:
> On Thu, 26 Jun 2025 23:41:15 +0000
> anisa.su887@gmail.com wrote:
> 
> > From: Anisa Su <anisa.su@samsung.com>
> > 
> > Per the spec, FMAPI commands (0x51-0x59) must be bound with
> > MCTP_MT_CXL_FMAPI. Fix the conditions ensuring this in i2c_mctp_cxl.c
> > and dev-mctp.c
> > 
> > Move the opcode enum from cxl-mailbox-utils.c to cxl_mailbox.h to
> > allow i2c_mctp_cxl.c and dev-mctp.c to use the enum instead of
> > hardcoding the values.
> > 
> > Signed-off-by: Anisa Su <anisa.su@samsung.com>
> Why HACK in the patch title?
> 
I guess this isn't really a hack but my intention was to make
it clear that this patch isn't intended for upstream. Seems like that
made things more confusing though, but now I know!

> In general this seems reasonable - the complexity is how I merge it
> into my tree given the code being modified slips in at various different
> points. I'll sort that out though.

I could also send you an alternate version of the FMAPI DCD Management patchset
based on this one?

> Jonathan
> 
> > ---
> >  hw/cxl/cxl-mailbox-utils.c   | 74 +-----------------------------------
> >  hw/cxl/i2c_mctp_cxl.c        |  6 ++-
> >  hw/usb/dev-mctp.c            |  6 ++-
> >  include/hw/cxl/cxl_mailbox.h | 73 +++++++++++++++++++++++++++++++++++
> >  4 files changed, 82 insertions(+), 77 deletions(-)
> > 
> > diff --git a/hw/cxl/cxl-mailbox-utils.c b/hw/cxl/cxl-mailbox-utils.c
> > index 4c01b25110..7f84e147f7 100644
> > --- a/hw/cxl/cxl-mailbox-utils.c
> > +++ b/hw/cxl/cxl-mailbox-utils.c
> > @@ -37,7 +37,7 @@
> >  
> >  /*
> >   * How to add a new command, example. The command set FOO, with cmd BAR.
> > - *  1. Add the command set and cmd to the enum.
> > + *  1. Add the command set and cmd to the enum in cxl_mailbox.h.
> >   *     FOO    = 0x7f,
> >   *          #define BAR 0
> >   *  2. Implement the handler
> > @@ -60,78 +60,6 @@
> >   *  a register interface that already deals with it.
> >   */
> >  
> > -enum {
> > -    INFOSTAT    = 0x00,
> > -        #define IS_IDENTIFY   0x1
> > -        #define BACKGROUND_OPERATION_STATUS    0x2
> > -        #define GET_RESPONSE_MSG_LIMIT         0x3
> > -        #define SET_RESPONSE_MSG_LIMIT         0x4
> > -        #define BACKGROUND_OPERATION_ABORT     0x5
> > -    EVENTS      = 0x01,
> > -        #define GET_RECORDS   0x0
> > -        #define CLEAR_RECORDS   0x1
> > -        #define GET_INTERRUPT_POLICY   0x2
> > -        #define SET_INTERRUPT_POLICY   0x3
> > -    FIRMWARE_UPDATE = 0x02,
> > -        #define GET_INFO      0x0
> > -        #define TRANSFER      0x1
> > -        #define ACTIVATE      0x2
> > -    TIMESTAMP   = 0x03,
> > -        #define GET           0x0
> > -        #define SET           0x1
> > -    LOGS        = 0x04,
> > -        #define GET_SUPPORTED 0x0
> > -        #define GET_LOG       0x1
> > -        #define GET_LOG_CAPABILITIES   0x2
> > -        #define CLEAR_LOG     0x3
> > -        #define POPULATE_LOG  0x4
> > -    FEATURES    = 0x05,
> > -        #define GET_SUPPORTED 0x0
> > -        #define GET_FEATURE   0x1
> > -        #define SET_FEATURE   0x2
> > -    IDENTIFY    = 0x40,
> > -        #define MEMORY_DEVICE 0x0
> > -    CCLS        = 0x41,
> > -        #define GET_PARTITION_INFO     0x0
> > -        #define GET_LSA       0x2
> > -        #define SET_LSA       0x3
> > -    HEALTH_INFO_ALERTS = 0x42,
> > -        #define GET_ALERT_CONFIG 0x1
> > -        #define SET_ALERT_CONFIG 0x2
> > -    SANITIZE    = 0x44,
> > -        #define OVERWRITE     0x0
> > -        #define SECURE_ERASE  0x1
> > -        #define MEDIA_OPERATIONS 0x2
> > -    PERSISTENT_MEM = 0x45,
> > -        #define GET_SECURITY_STATE     0x0
> > -    MEDIA_AND_POISON = 0x43,
> > -        #define GET_POISON_LIST        0x0
> > -        #define INJECT_POISON          0x1
> > -        #define CLEAR_POISON           0x2
> > -        #define GET_SCAN_MEDIA_CAPABILITIES 0x3
> > -        #define SCAN_MEDIA             0x4
> > -        #define GET_SCAN_MEDIA_RESULTS 0x5
> > -    DCD_CONFIG  = 0x48,
> > -        #define GET_DC_CONFIG          0x0
> > -        #define GET_DYN_CAP_EXT_LIST   0x1
> > -        #define ADD_DYN_CAP_RSP        0x2
> > -        #define RELEASE_DYN_CAP        0x3
> > -    PHYSICAL_SWITCH = 0x51,
> > -        #define IDENTIFY_SWITCH_DEVICE      0x0
> > -        #define GET_PHYSICAL_PORT_STATE     0x1
> > -    TUNNEL = 0x53,
> > -        #define MANAGEMENT_COMMAND     0x0
> > -    MHD = 0x55,
> > -        #define GET_MHD_INFO 0x0
> > -    FMAPI_DCD_MGMT = 0x56,
> > -        #define GET_DCD_INFO    0x0
> > -        #define GET_HOST_DC_REGION_CONFIG   0x1
> > -        #define SET_DC_REGION_CONFIG        0x2
> > -        #define GET_DC_REGION_EXTENT_LIST   0x3
> > -        #define INITIATE_DC_ADD             0x4
> > -        #define INITIATE_DC_RELEASE         0x5
> > -};
> > -
> >  /* CCI Message Format CXL r3.1 Figure 7-19 */
> >  typedef struct CXLCCIMessage {
> >      uint8_t category;
> > diff --git a/hw/cxl/i2c_mctp_cxl.c b/hw/cxl/i2c_mctp_cxl.c
> > index 1714f36e8e..3f17779562 100644
> > --- a/hw/cxl/i2c_mctp_cxl.c
> > +++ b/hw/cxl/i2c_mctp_cxl.c
> > @@ -29,6 +29,7 @@
> >  #include "hw/pci/pcie_port.h"
> >  #include "hw/qdev-properties.h"
> >  #include "hw/registerfields.h"
> > +#include "hw/cxl/cxl_mailbox.h"
> >  
> >  #define TYPE_I2C_MCTP_CXL "i2c_mctp_cxl"
> >  
> > @@ -198,9 +199,10 @@ static void i2c_mctp_cxl_handle_message(MCTPI2CEndpoint *mctp)
> >           */
> >  
> >          if (!(msg->message_type == MCTP_MT_CXL_TYPE3 &&
> > -              msg->command_set < 0x51) &&
> > +              msg->command_set < PHYSICAL_SWITCH) &&
> >              !(msg->message_type == MCTP_MT_CXL_FMAPI &&
> > -              msg->command_set >= 0x51 && msg->command_set < 0x56)) {
> > +              msg->command_set >= PHYSICAL_SWITCH &&
> > +              msg->command_set < GLOBAL_MEM_ACCESS_EP_MGMT)) {
> >              buf->rc = CXL_MBOX_UNSUPPORTED;
> >              st24_le_p(buf->pl_length, len_out);
> >              s->len = s->pos;
> > diff --git a/hw/usb/dev-mctp.c b/hw/usb/dev-mctp.c
> > index aafb9e7e96..b82a269561 100644
> > --- a/hw/usb/dev-mctp.c
> > +++ b/hw/usb/dev-mctp.c
> > @@ -25,6 +25,7 @@
> >  #include "hw/usb.h"
> >  #include "hw/usb/desc.h"
> >  #include "net/mctp.h"
> > +#include "hw/cxl/cxl_mailbox.h"
> >  
> >  /* TODO: Move to header */
> >  
> > @@ -504,9 +505,10 @@ static void usb_cxl_mctp_handle_data(USBDevice *dev, USBPacket *p)
> >           * onwards.
> >           */
> >          if (!(req->message_type == MCTP_MT_CXL_TYPE3 &&
> > -              req->command_set < 0x51) &&
> > +              req->command_set < PHYSICAL_SWITCH) &&
> >              !(req->message_type == MCTP_MT_CXL_FMAPI &&
> > -              req->command_set >= 0x51 && req->command_set < 0x56)) {
> > +              req->command_set >= PHYSICAL_SWITCH &&
> > +              req->command_set < GLOBAL_MEM_ACCESS_EP_MGMT)) {
> >              len_out = 0;
> >              usb_pkt_len = sizeof(MCTPUSBPacket) + sizeof(CXLMCTPMessage) +
> >                  len_out;
> > diff --git a/include/hw/cxl/cxl_mailbox.h b/include/hw/cxl/cxl_mailbox.h
> > index 820c411cbb..209a11ecbc 100644
> > --- a/include/hw/cxl/cxl_mailbox.h
> > +++ b/include/hw/cxl/cxl_mailbox.h
> > @@ -27,4 +27,77 @@
> >  #define CXL_LOG_CAP_AUTO_POPULATE_SUPPORTED (1 << 2)
> >  #define CXL_LOG_CAP_PERSISTENT_COLD_RESET_SUPPORTED (1 << 3)
> >  
> > +enum {
> > +    INFOSTAT    = 0x00,
> > +        #define IS_IDENTIFY   0x1
> > +        #define BACKGROUND_OPERATION_STATUS    0x2
> > +        #define GET_RESPONSE_MSG_LIMIT         0x3
> > +        #define SET_RESPONSE_MSG_LIMIT         0x4
> > +        #define BACKGROUND_OPERATION_ABORT     0x5
> > +    EVENTS      = 0x01,
> > +        #define GET_RECORDS   0x0
> > +        #define CLEAR_RECORDS   0x1
> > +        #define GET_INTERRUPT_POLICY   0x2
> > +        #define SET_INTERRUPT_POLICY   0x3
> > +    FIRMWARE_UPDATE = 0x02,
> > +        #define GET_INFO      0x0
> > +        #define TRANSFER      0x1
> > +        #define ACTIVATE      0x2
> > +    TIMESTAMP   = 0x03,
> > +        #define GET           0x0
> > +        #define SET           0x1
> > +    LOGS        = 0x04,
> > +        #define GET_SUPPORTED 0x0
> > +        #define GET_LOG       0x1
> > +        #define GET_LOG_CAPABILITIES   0x2
> > +        #define CLEAR_LOG     0x3
> > +        #define POPULATE_LOG  0x4
> > +    FEATURES    = 0x05,
> > +        #define GET_SUPPORTED 0x0
> > +        #define GET_FEATURE   0x1
> > +        #define SET_FEATURE   0x2
> > +    IDENTIFY    = 0x40,
> > +        #define MEMORY_DEVICE 0x0
> > +    CCLS        = 0x41,
> > +        #define GET_PARTITION_INFO     0x0
> > +        #define GET_LSA       0x2
> > +        #define SET_LSA       0x3
> > +    HEALTH_INFO_ALERTS = 0x42,
> > +        #define GET_ALERT_CONFIG 0x1
> > +        #define SET_ALERT_CONFIG 0x2
> > +    SANITIZE    = 0x44,
> > +        #define OVERWRITE     0x0
> > +        #define SECURE_ERASE  0x1
> > +        #define MEDIA_OPERATIONS 0x2
> > +    PERSISTENT_MEM = 0x45,
> > +        #define GET_SECURITY_STATE     0x0
> > +    MEDIA_AND_POISON = 0x43,
> > +        #define GET_POISON_LIST        0x0
> > +        #define INJECT_POISON          0x1
> > +        #define CLEAR_POISON           0x2
> > +        #define GET_SCAN_MEDIA_CAPABILITIES 0x3
> > +        #define SCAN_MEDIA             0x4
> > +        #define GET_SCAN_MEDIA_RESULTS 0x5
> > +    DCD_CONFIG  = 0x48,
> > +        #define GET_DC_CONFIG          0x0
> > +        #define GET_DYN_CAP_EXT_LIST   0x1
> > +        #define ADD_DYN_CAP_RSP        0x2
> > +        #define RELEASE_DYN_CAP        0x3
> > +    PHYSICAL_SWITCH = 0x51,
> > +        #define IDENTIFY_SWITCH_DEVICE      0x0
> > +        #define GET_PHYSICAL_PORT_STATE     0x1
> > +    TUNNEL = 0x53,
> > +        #define MANAGEMENT_COMMAND     0x0
> > +    MHD = 0x55,
> > +        #define GET_MHD_INFO 0x0
> > +    FMAPI_DCD_MGMT = 0x56,
> > +        #define GET_DCD_INFO    0x0
> > +        #define GET_HOST_DC_REGION_CONFIG   0x1
> > +        #define SET_DC_REGION_CONFIG        0x2
> > +        #define GET_DC_REGION_EXTENT_LIST   0x3
> > +        #define INITIATE_DC_ADD             0x4
> > +        #define INITIATE_DC_RELEASE         0x5
> > +    GLOBAL_MEM_ACCESS_EP_MGMT = 0X59,
> > +};
> > +
> >  #endif
> 

