Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C808C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 15:31:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk45T-0001qK-TN; Tue, 12 Mar 2024 11:30:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk459-0001hX-TD
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 11:30:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rk452-0000EP-AR
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 11:30:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710257414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W8VyTvR5PrFnJnJ7a46rsJN039Y09OF2/36ICSHpR0c=;
 b=JhhA43Yzlg8nh2SqkJcdVWvgQ0G9J3mvtvCIzo6VbvSW25C7XqsGxqI63fgOJGGmgRy1fN
 6NZng5o2A0/iycBQn4vDE+7Dd8AGWJfFvQZbCXIuHiuP4myyWHeSmjANIArl7sZVfV/xJN
 +TJ8kA+PqfdoXpdA/oeIJx+tv/KzYWo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-ZRYev3GCNW6I5KtunAPqow-1; Tue, 12 Mar 2024 11:30:12 -0400
X-MC-Unique: ZRYev3GCNW6I5KtunAPqow-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-33e8adeffe6so1569081f8f.2
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 08:30:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710257411; x=1710862211;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=W8VyTvR5PrFnJnJ7a46rsJN039Y09OF2/36ICSHpR0c=;
 b=XcDJMDB0Kot4Iiksp9uIoQYq1N04hziOJv4X1w6lqHRfRtmtDeR9DNTU3jB06pOHy7
 yXWEaDfhz/clJ9v/LlXq3UmXxg8we5roty+WW6nilzldo/wXZAkiadCorhwSZJue/MQG
 JMPr6iAB/W9+qEG2vCFfCeNBW2LPBumt2Hl/nAkopmXw8kVCsIh753DEQNcFZ+VCtjCt
 +lPz1NEzzyjI6ocM/a5gCCEm/Q2G+oWWQ3vRQuN433/yTfwaU+xwUDK7J84YaynExX8F
 bSzf19ZhdO8iqXc5OyuM6/KQv9jc0p/puhbEqu3Ziq0dn92yAmUxDSFyqIpwZ5dA0r5N
 yvew==
X-Gm-Message-State: AOJu0Yw6eCR4OaHhzXcCWTkFDHTHMBpHanKdnMe+gnOBgcNyJPOsFZkK
 RkSFbkGK6GZDKvm3heqCuvhnMMtCevlzGSzb5fLwnfKV1gkd4LSh1sBSMPC9me+oyfd2ol5FDzk
 JSkT9aTyk09BuZJ8U6u+G0yNyRSBlBNUqJwEwOJNrDTcPP+pGz7Kq
X-Received: by 2002:a05:6000:4c5:b0:33e:4238:8615 with SMTP id
 h5-20020a05600004c500b0033e42388615mr1551837wri.40.1710257411241; 
 Tue, 12 Mar 2024 08:30:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHK5WS+eGqgp3kYusTzwQf+XUw1rUYo2gh6xiOZyJOnU1q4ssFtxrQ6mKai2iGpgF2zpb7ogQ==
X-Received: by 2002:a05:6000:4c5:b0:33e:4238:8615 with SMTP id
 h5-20020a05600004c500b0033e42388615mr1551828wri.40.1710257410716; 
 Tue, 12 Mar 2024 08:30:10 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f0:532c:5ae4:fce6:76e1:fa1a])
 by smtp.gmail.com with ESMTPSA id
 i17-20020adfefd1000000b0033e7503ce7esm9265547wrp.46.2024.03.12.08.30.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Mar 2024 08:30:10 -0700 (PDT)
Date: Tue, 12 Mar 2024 11:30:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qemu-devel@nongnu.org, Fan Ni <nifan.cxl@gmail.com>,
 linuxarm@huawei.com, linux-cxl@vger.kernel.org
Subject: Re: [PATCH qemu] hw/pci-bridge/pxb-cxl: Drop RAS capability from
 host bridge.
Message-ID: <20240312112942-mutt-send-email-mst@kernel.org>
References: <20240215155206.2736-1-Jonathan.Cameron@huawei.com>
 <20240215111117-mutt-send-email-mst@kernel.org>
 <20240215174212.000057c9@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240215174212.000057c9@Huawei.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 15, 2024 at 05:42:12PM +0000, Jonathan Cameron wrote:
> On Thu, 15 Feb 2024 11:11:47 -0500
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Thu, Feb 15, 2024 at 03:52:06PM +0000, Jonathan Cameron wrote:
> > > This CXL component isn't allowed to have a RAS capability.
> > > Whilst this should be harmless as software is not expected to look
> > > here, good to clean it up.
> > > 
> > > Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>  
> > 
> > Isn't this device migrateable? If yes you need compat
> > handling.
> 
> Not yet. Migrating these is broken in lots of ways :(
> 
> Given they are functional emulation only I've never cared that much.
> We'll need to fix this as part of adding support for virtualization
> use cases which start to make sense when dynamic capacity
> support lands in kernel + QEMU (probably later this year)
> 
> Jonathan


should probably block migration then?

> > 
> > 
> > > ---
> > >  I've been carrying this on my tree for quite a while.
> > >  This wasn't in previous fixes set because it's low priority and
> > >  rebasing it across cleanup series that followed those fixes was
> > >  too fiddly to bother.
> > >  
> > >  include/hw/cxl/cxl_component.h      |  1 +
> > >  hw/cxl/cxl-component-utils.c        | 21 +++++++++++++++++----
> > >  hw/pci-bridge/pci_expander_bridge.c |  2 +-
> > >  3 files changed, 19 insertions(+), 5 deletions(-)
> > > 
> > > diff --git a/include/hw/cxl/cxl_component.h b/include/hw/cxl/cxl_component.h
> > > index 0e5d35c263..5012fab6f7 100644
> > > --- a/include/hw/cxl/cxl_component.h
> > > +++ b/include/hw/cxl/cxl_component.h
> > > @@ -25,6 +25,7 @@ enum reg_type {
> > >      CXL2_TYPE3_DEVICE,
> > >      CXL2_LOGICAL_DEVICE,
> > >      CXL2_ROOT_PORT,
> > > +    CXL2_RC,
> > >      CXL2_UPSTREAM_PORT,
> > >      CXL2_DOWNSTREAM_PORT,
> > >      CXL3_SWITCH_MAILBOX_CCI,
> > > diff --git a/hw/cxl/cxl-component-utils.c b/hw/cxl/cxl-component-utils.c
> > > index 84ab503325..cd116c0401 100644
> > > --- a/hw/cxl/cxl-component-utils.c
> > > +++ b/hw/cxl/cxl-component-utils.c
> > > @@ -297,6 +297,7 @@ void cxl_component_register_init_common(uint32_t *reg_state,
> > >          caps = 3;
> > >          break;
> > >      case CXL2_ROOT_PORT:
> > > +    case CXL2_RC:
> > >          /* + Extended Security, + Snoop */
> > >          caps = 5;
> > >          break;
> > > @@ -326,8 +327,19 @@ void cxl_component_register_init_common(uint32_t *reg_state,
> > >                         CXL_##reg##_REGISTERS_OFFSET);                         \
> > >      } while (0)
> > >  
> > > +    switch (type) {
> > > +    case CXL2_DEVICE:
> > > +    case CXL2_TYPE3_DEVICE:
> > > +    case CXL2_LOGICAL_DEVICE:
> > > +    case CXL2_ROOT_PORT:
> > > +    case CXL2_UPSTREAM_PORT:
> > > +    case CXL2_DOWNSTREAM_PORT:
> > >      init_cap_reg(RAS, 2, CXL_RAS_CAPABILITY_VERSION);
> > > -    ras_init_common(reg_state, write_msk);
> > > +        ras_init_common(reg_state, write_msk);
> > > +        break;
> > > +    default:
> > > +        break;
> > > +    }
> > >  
> > >      init_cap_reg(LINK, 4, CXL_LINK_CAPABILITY_VERSION);
> > >  
> > > @@ -335,9 +347,10 @@ void cxl_component_register_init_common(uint32_t *reg_state,
> > >          return;
> > >      }
> > >  
> > > -    init_cap_reg(HDM, 5, CXL_HDM_CAPABILITY_VERSION);
> > > -    hdm_init_common(reg_state, write_msk, type);
> > > -
> > > +    if (type != CXL2_ROOT_PORT) {
> > > +        init_cap_reg(HDM, 5, CXL_HDM_CAPABILITY_VERSION);
> > > +        hdm_init_common(reg_state, write_msk, type);
> > > +    }
> > >      if (caps < 5) {
> > >          return;
> > >      }
> > > diff --git a/hw/pci-bridge/pci_expander_bridge.c b/hw/pci-bridge/pci_expander_bridge.c
> > > index 535889f7c2..0411ad31ea 100644
> > > --- a/hw/pci-bridge/pci_expander_bridge.c
> > > +++ b/hw/pci-bridge/pci_expander_bridge.c
> > > @@ -290,7 +290,7 @@ static void pxb_cxl_dev_reset(DeviceState *dev)
> > >      uint32_t *write_msk = cxl_cstate->crb.cache_mem_regs_write_mask;
> > >      int dsp_count = 0;
> > >  
> > > -    cxl_component_register_init_common(reg_state, write_msk, CXL2_ROOT_PORT);
> > > +    cxl_component_register_init_common(reg_state, write_msk, CXL2_RC);
> > >      /*
> > >       * The CXL specification allows for host bridges with no HDM decoders
> > >       * if they only have a single root port.
> > > -- 
> > > 2.39.2  
> > 


