Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE557C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 12:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmCIu-0004D4-21; Mon, 18 Mar 2024 08:41:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmCIt-0004Cl-7o
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 08:41:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rmCIj-0003OO-ST
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 08:41:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710765672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+EqjrbWXQu/j8Y37QpofsM16Thz++0wS7P0g2Jf81Mw=;
 b=bTxIYmcegt3wB7m2yHIDAVYZakyoQoXYM+PA9/WllV9kH3LDUX8qLO+ElwE16gmkc8yutO
 vwOArWNT0TSZCA3vUEwCS0779X5tX5Xepab8Sc+pc1A/bwTFIYxpp8jhZjiPSMQYccZgjP
 93T4AnnfiQ7wM6Qh6u69pHJsSZ4rN4I=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-OYjeU6htOIG_5HPpc8WCgw-1; Mon, 18 Mar 2024 08:41:10 -0400
X-MC-Unique: OYjeU6htOIG_5HPpc8WCgw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-33ec4fb1a83so1173245f8f.2
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 05:41:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710765669; x=1711370469;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=+EqjrbWXQu/j8Y37QpofsM16Thz++0wS7P0g2Jf81Mw=;
 b=rh03Kdwlw7BGLK2ar8VQqmjrjGaQvn5uGLbTc+71St9pYvbOH1k8rgeGqday004qri
 iydThoZRnh5DKNXVV0apvKYe2sXudRpiZUbtXhSAQcYPJsyqRx6DMc5r0zdAxXGitEnc
 3NAxRbbtKsX8pm0syzye7aUWg2DfiYD1JwOn3evDG6HKX/csSEJ4kkt00HXy1IjWKdAI
 MKF6FJEFttEpJQj1eX7F6bBXUaaN89gR39jVWxL3v15/mIm0hi1Ln0kD6ppEHK8gstaX
 1IYwZEz47eMVQBQx/hdnHc+pnMXeLwdQJGURaP8Gl+wnrZpVPLQr3Oy1JWIMOEExl/PZ
 gPqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVr6xdx+xUAjvTIwrGeQi7yzSd7Dd+iRCLQNTE5mkKv2rB5Vc8E5Pu+29eyx1iQQ7Usx7XTBNKmMZXgYzX6le8nSoeJ9FI=
X-Gm-Message-State: AOJu0YxF7TiHN5/p9Pu1ZRamzbM6xMYMxSZwXAJbubAAYhhSgJeGY0MH
 YCMMPPE2MA/nLd04eUu5jpUh5EOtvEtltvsNOzcYOtfZfhcQU9C/hfYzz+FZwb7lbanmgHPa5ns
 xqOTzQAlx4l+T9mRVFvGldNDTwlO0wWB+aziDafKCWvePAhZwCwZ0
X-Received: by 2002:adf:fd0d:0:b0:33e:a29d:9672 with SMTP id
 e13-20020adffd0d000000b0033ea29d9672mr8305637wrr.51.1710765669412; 
 Mon, 18 Mar 2024 05:41:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiynh73wWw52KQ7yKC2SrebNiwRk/QyUTeqq1mMqhrvXe671fegzBem+lYtXn9uJ9jwD5OPg==
X-Received: by 2002:adf:fd0d:0:b0:33e:a29d:9672 with SMTP id
 e13-20020adffd0d000000b0033ea29d9672mr8305605wrr.51.1710765668580; 
 Mon, 18 Mar 2024 05:41:08 -0700 (PDT)
Received: from redhat.com ([2.52.5.113]) by smtp.gmail.com with ESMTPSA id
 g14-20020a5d540e000000b0033e95bf4796sm9724077wrv.27.2024.03.18.05.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 05:41:07 -0700 (PDT)
Date: Mon, 18 Mar 2024 08:41:04 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas@t-8ch.de>,
 Hao Chen <chenh@yusur.tech>, qemu-devel@nongnu.org,
 cohuck@redhat.com, pbonzini@redhat.com
Subject: Re: [PATCH] hw/virtio: Add support for VDPA network simulation devices
Message-ID: <20240318083932-mutt-send-email-mst@kernel.org>
References: <20240221073802.2888022-1-chenh@yusur.tech>
 <d9e4f3b4-9c2e-466c-b5f4-3387ce88c6b9@t-8ch.de>
 <20240313155136-mutt-send-email-mst@kernel.org>
 <CACGkMEtSSb-9PsmQKPA4i-UWVJJ4ZVog8rt+1PKoqE+ABhpRTA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEtSSb-9PsmQKPA4i-UWVJJ4ZVog8rt+1PKoqE+ABhpRTA@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.374,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, Mar 14, 2024 at 11:24:33AM +0800, Jason Wang wrote:
> On Thu, Mar 14, 2024 at 3:52 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Mar 13, 2024 at 07:51:08PM +0100, Thomas Weißschuh wrote:
> > > On 2024-02-21 15:38:02+0800, Hao Chen wrote:
> > > > This patch adds support for VDPA network simulation devices.
> > > > The device is developed based on virtio-net and tap backend,
> > > > and supports hardware live migration function.
> > > >
> > > > For more details, please refer to "docs/system/devices/vdpa-net.rst"
> > > >
> > > > Signed-off-by: Hao Chen <chenh@yusur.tech>
> > > > ---
> > > >  MAINTAINERS                                 |   5 +
> > > >  docs/system/device-emulation.rst            |   1 +
> > > >  docs/system/devices/vdpa-net.rst            | 121 +++++++++++++
> > > >  hw/net/virtio-net.c                         |  16 ++
> > > >  hw/virtio/virtio-pci.c                      | 189 +++++++++++++++++++-
> 
> I think those modifications should belong to a separate file as it
> might conflict with virito features in the future.
> 
> > > >  hw/virtio/virtio.c                          |  39 ++++
> > > >  include/hw/virtio/virtio-pci.h              |   5 +
> > > >  include/hw/virtio/virtio.h                  |  19 ++
> > > >  include/standard-headers/linux/virtio_pci.h |   7 +
> > > >  9 files changed, 399 insertions(+), 3 deletions(-)
> > > >  create mode 100644 docs/system/devices/vdpa-net.rst
> > >
> > > [..]
> > >
> > > > diff --git a/include/standard-headers/linux/virtio_pci.h b/include/standard-headers/linux/virtio_pci.h
> > > > index b7fdfd0668..fb5391cef6 100644
> > > > --- a/include/standard-headers/linux/virtio_pci.h
> > > > +++ b/include/standard-headers/linux/virtio_pci.h
> > > > @@ -216,6 +216,13 @@ struct virtio_pci_cfg_cap {
> > > >  #define VIRTIO_PCI_COMMON_Q_NDATA  56
> > > >  #define VIRTIO_PCI_COMMON_Q_RESET  58
> > > >
> > > > +#define LM_LOGGING_CTRL                 0
> > > > +#define LM_BASE_ADDR_LOW                4
> > > > +#define LM_BASE_ADDR_HIGH               8
> > > > +#define LM_END_ADDR_LOW                 12
> > > > +#define LM_END_ADDR_HIGH                16
> > > > +#define LM_VRING_STATE_OFFSET           0x20
> > >
> > > These changes are not in upstream Linux and will be undone by
> > > ./scripts/update-linux-headers.sh.
> > >
> > > Are they intentionally in this header?
> >
> >
> > Good point. Pls move.
> 
> Right and this part, it's not a part of standard virtio.
> 
> Thanks

I'm thinking of reverting this patch unless there's a resolution
soon, and reapplying later after the release.


> >
> > > > +
> > > >  #endif /* VIRTIO_PCI_NO_MODERN */
> > > >
> > > >  #endif
> >


