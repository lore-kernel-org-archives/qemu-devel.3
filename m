Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94171C52D7C
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 23:38:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1se150-0006Sf-Ir; Tue, 13 Aug 2024 19:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jgg@ziepe.ca>) id 1se14z-0006S3-2y
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 19:37:29 -0400
Received: from mail-qt1-x82b.google.com ([2607:f8b0:4864:20::82b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jgg@ziepe.ca>) id 1se14x-0008Om-9J
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 19:37:28 -0400
Received: by mail-qt1-x82b.google.com with SMTP id
 d75a77b69052e-447d6edc6b1so32233521cf.0
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 16:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ziepe.ca; s=google; t=1723592246; x=1724197046; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5VO2vOXTYUzHNGoqXkty4CZXSIWZNXE+mZa+Oe/5P5M=;
 b=CYjylfHycl064uyMn3Ho0APuZZwxEwvai/lFVtCDuGaS0l9DuVVCK+Ka3x7tOz9+vD
 9F8p6tQ2BkQQ7z4/BHKbsj4n7vMmxt8mPxW/3Iu5/jcm720MoRyD7fOV/VitQ09HIZrC
 ylUu/dW3J1Ls6xxV3/HySuK07/FTP56lxoVyZLXoqOvVx6IPeC6B/HR13HuQMPxHoQHO
 vt4Faxl4zS9kt16Gq0lZbSBHq21axC1Xdd+XEcgcxdctv2nmu4absbQp3izn8NUq6nzu
 UNXPRbIk5+inwRSh2T6AWVIEN6i2LQuPFX/LQ4gFaTjJGOdwzhAf6RiaQfxu3xIMdTor
 Ctyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723592246; x=1724197046;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5VO2vOXTYUzHNGoqXkty4CZXSIWZNXE+mZa+Oe/5P5M=;
 b=JU/Z7RvrbQugXsCTpUhx9+8qe7Ppqkbvyd3IEEEamqDMlKw7dkpnxgqqsuBXJQc8J4
 akvQ6q1SKd1T59kDYUCixFhBqsOeIy05z1KpvycEjlqMlX43B5TcYz/AR8lJ4h9ocGcu
 EKcN/Z68c/l3Ef8MTuxGs1UyjFYAzhCzEjnWJt92DPKE02BIMXiKwqBtis8q8zDw1OxS
 5IBEB5zQU5/CRRH/1xV18jGnGThGA/9kiyK+MPkwla6FfG5HJRvDFOtOjJHXkNFN8ufd
 bqOa83YvtUemPc7hkJkZQBABVn2GAqEWLgETGYfJnMBDbA8ia2TIlmSdAmg3dQ8r+kze
 XGRA==
X-Gm-Message-State: AOJu0YyiqsN25+3QS3uApC2fALG3BNSdyxyU2YvPOb1od5S7TwFEu8L2
 wwIT2SwRCclcbUyuQz1hZbcVJSCKv0qHxVEpYDeG+ItH2sYItopxMuTAGyOeQZA=
X-Google-Smtp-Source: AGHT+IFbm4qDYxgXzWa97F1Ax4tIokMkCTO/HLZVYUI3NA9l3rLq2ilxoJLGeZFzAszYUnI+b4y72g==
X-Received: by 2002:a05:622a:5c17:b0:446:5c31:f268 with SMTP id
 d75a77b69052e-4535bb0821dmr11613701cf.30.1723592245902; 
 Tue, 13 Aug 2024 16:37:25 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-68-80-239.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.68.80.239]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4531c26d30esm36041161cf.64.2024.08.13.16.37.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 16:37:25 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.95)
 (envelope-from <jgg@ziepe.ca>) id 1se14u-00AOBJ-NG;
 Tue, 13 Aug 2024 20:37:24 -0300
Date: Tue, 13 Aug 2024 20:37:24 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, quic_bqiang@quicinc.com,
 kvalo@kernel.org, prestwoj@gmail.com,
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
 dwmw2@infradead.org, iommu@lists.linux.dev, kernel@quicinc.com,
 johannes@sipsolutions.net, jtornosm@redhat.com
Subject: Re: [PATCH RFC/RFT] vfio/pci-quirks: Quirk for ath wireless
Message-ID: <20240813233724.GS1985367@ziepe.ca>
References: <adcb785e-4dc7-4c4a-b341-d53b72e13467@gmail.com>
 <20240812170045.1584000-1-alex.williamson@redhat.com>
 <20240813164341.GL1985367@ziepe.ca>
 <20240813150320.73df43d7.alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240813150320.73df43d7.alex.williamson@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::82b; envelope-from=jgg@ziepe.ca;
 helo=mail-qt1-x82b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, Aug 13, 2024 at 03:03:20PM -0600, Alex Williamson wrote:

> How does the guest know to write a remappable vector format?  How does
> the guest know the host interrupt architecture?  For example why would
> an aarch64 guest program an MSI vector of 0xfee... if the host is x86?

All excellent questions.

Emulating real interrupt controllers in the VM is probably impossible
in every scenario. But certainly x86 emulating x86 and ARM emulating
ARM would be usefully achievable.

hyperv did a neat thing where their remapping driver seems to make VMM
traps and looks kind of like the VMM gives it the platform specific
addr/data pair.

It is a big ugly problem for sure, and we definately have painted
ourselves into a corner where the OS has no idea if IMS techniques
work properly or it is broken. :( :(

But I think there may not be a terribly impossible path where at least
the guest could be offered a, say, virtio-irq in addition to the
existing platform controllers that would process IMS for it.

> The idea of guest owning the physical MSI address space sounds great,
> but is it practical?  

In many cases yes, it is, but more importantly it is the only sane way
to support these IMS like techniques broadly since IMS is by
definition not generally trappable.

> Is it something that would be accomplished while
> this device is still relevant?

I don't know, I fear not. But it keeps coming up. Too many things
don't work right with the trapping approach, including this.

> The Windows driver is just programming the MSI capability to use 16
> vectors.  We configure those vectors on the host at the time the
> capability is written.  Whereas the Linux driver is only using a single
> vector and therefore writing the same MSI address and data at the
> locations noted in the trace, the Windows driver is writing different
> data values at different locations to make use of those vectors.  This
> note is simply describing that we can't directly write the physical
> data value into the device, we need to determine which vector offset
> the guest is using and provide the same offset from the host data
> register value.

I see, it seems to be assuming also that these extra interrupt sources
are generating the same MSI message as the main MSI, not something
else. That is more a SW quirk of Windows, I expect. I don't think
Linux would do that..

This is probably the only way to approach this, trap and emulate the
places in the device that program additional interrupt sources and do
a full MSI-like flow to set them up in the kernel.

Jason

