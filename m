Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55808CD98C7
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2026 21:16:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXmkv-0001jX-Dl; Thu, 11 Jun 2026 17:16:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXmkr-0001j6-JN
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 17:16:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wXmkp-0006ap-V8
 for qemu-devel@nongnu.org; Thu, 11 Jun 2026 17:16:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781212558;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZslFwwJQpjv4U1ic2gm0DX8XMzpxcXTIrq34lVO3GaE=;
 b=gpVgE3i5PZvnhj/rIoa7bXCPOQEU5GXDA3cxywLQAsS/g6DYGeXD+1igR+26BgYYPNi2ND
 1tquN7PTLlL4OLnW6/XwdptveJovF0Ij67AG1mqSnkHgIhHABHfp/B9QC9WQXlm0Z85enZ
 huAO8VrKO3A1P+aYm9JZnQDioPyPuBg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-Hwoy5PUMPiytYapFZ6TeXg-1; Thu, 11 Jun 2026 17:15:56 -0400
X-MC-Unique: Hwoy5PUMPiytYapFZ6TeXg-1
X-Mimecast-MFC-AGG-ID: Hwoy5PUMPiytYapFZ6TeXg_1781212555
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490b93debc8so2065865e9.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2026 14:15:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781212555; x=1781817355; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=ZslFwwJQpjv4U1ic2gm0DX8XMzpxcXTIrq34lVO3GaE=;
 b=tUNNObmpaqsgx9ijsEPLdvHXTbXLKmk0pSMKnkD654X/v+Il4z7JKyNzOQ2BEZJpi6
 bsGi+rvGeuSYgFEis8++kNFrDIr6mfMgZ1CbJOytokyZ6cdbKvMlERTxb2N/5r85J6C4
 KSG/cOvzawUEwqPa2nyOqoLffJQEJtJ26QWo9j86e/XR3vCk2Kk2ZOXP4pup0uZ3OUGf
 ZLxaDbxHrOw1kA9XwKh0/Xfu/A18CTC0uItwn4ndUrnEJchjcoarZYfr38dzprFbr3yx
 LPBwBe8B991awoLlj7fLd1XOdUMUxSIPAolR4g5VgNGuDZGBj5qyWmzhNhzh6W5aSnqf
 k14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781212555; x=1781817355;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ZslFwwJQpjv4U1ic2gm0DX8XMzpxcXTIrq34lVO3GaE=;
 b=EPB30B5RyZKVF8DRzbUd4KMOAMO37CWWGkQ9DTdtEAnGgCaEpM3gA7sS46Ng4aJjYg
 NSd8Q3kC4vvVQKvEc5bCKsTJ9c/VledoOT3ZT3zyIkNr0iOkNF4CvDdZq93kQ2Ag4p8y
 //s8G/GItXwbFBEZypF5fiXcwdbCqDx14bazcA4uwwaIpXO/fRUA+qcCl/RL0QisiDQK
 jauzRwB4oBZtKwrmr7DrCm2vHUcEcbbzPEWoRyS0meyLIPNgd9sbB2U9Aondd+CFSxsd
 hFHBwiPLkA9qNIdm2rji5WwOVS3wZ55TNymGNjrRjik76HNRc4/7XHEpF0HkbKhi9ulw
 S1hw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+qn7vuR0fTzNOcdZ78B9ogXQCnQpgv1N2+BdLGsDkCRK1Ozu291LwWD4fLN4C5ucKisaoFphLHtjOp@nongnu.org
X-Gm-Message-State: AOJu0Yzg5y6NvjQ+4Z4gdmO2gaOpNJcnCPrDZ2NVZEiihCYH02n+0PwC
 w02nc8Kl5eCQ9KviCJmK97jDipSsPQvisrqs6G9Y52b841329tnIDwOkdwvdCwl0lWZbPw+ZwEu
 zo0jI0/Ld1GgnsJLXmFLgDE6YaQoo1z+4NquNlg5Ge0MhO/uQ2KQR1q/s
X-Gm-Gg: Acq92OEPdQtiZK7S+H2kbtlJKN7+s4FW/JmVUixLCKJLvcQUc9yBpZCXhT69rYTefDB
 YXbbao812jtT0I5Gko1MISjxdNnXhLrvhrikHNHD6XhSkWMQF8ZbLltYmqGVpmNvb1N3mWjZVCL
 NSSnJKozZybeW2+psm8DI4zsdtfA4AVZrh9SjURydwvmoaNhUVC1G7aEVAN7k4kBaEnvkwvolTN
 KLc1sphZA4f5Wszxu196INIFHQD2A/E1HQMpMp2k+BTEqF+/Vhu6ZZfVot7UhV2kZYEx1woweUu
 Udjm36CXEU0ZIJD8ViIf6Z4jtrN5QAiCOL7WGX8p5+Qqyr5pvraHeY6pF2v2s7CCyBoO8pBlA3x
 FPPM1mHtcYH1cxxj2ssIA2dDLiISatz9i0LKUpL01Rbs=
X-Received: by 2002:a05:600c:4691:b0:48f:e249:4094 with SMTP id
 5b1f17b1804b1-490e560b2d5mr61095085e9.18.1781212554874; 
 Thu, 11 Jun 2026 14:15:54 -0700 (PDT)
X-Received: by 2002:a05:600c:4691:b0:48f:e249:4094 with SMTP id
 5b1f17b1804b1-490e560b2d5mr61094765e9.18.1781212554332; 
 Thu, 11 Jun 2026 14:15:54 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490e2c7ead0sm105147645e9.3.2026.06.11.14.15.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jun 2026 14:15:52 -0700 (PDT)
Date: Thu, 11 Jun 2026 17:15:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gavin Shan <gshan@redhat.com>, Peter Xu <peterx@redhat.com>,
 Pavel Hrdina <phrdina@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org, jugraham@redhat.com,
 shan.gavin@gmail.com, Alex Williamson <alex@shazbot.org>,
 David Hildenbrand <david@kernel.org>
Subject: Re: [PATCH RFCv1] virtio: Inherit max bounce buffer size from bus
 parent if possible
Message-ID: <20260611171353-mutt-send-email-mst@kernel.org>
References: <CAFEAcA8Q9qEaZS8wCpZQ-4jpAnQ9JXvnb7iSeRTdhJ9Y3BcCRg@mail.gmail.com>
 <20260611093049-mutt-send-email-mst@kernel.org>
 <CAFEAcA-8Hv0o3PibjH=8jixsHyunH2HkOAMQVqHkGr34b1Ascg@mail.gmail.com>
 <20260611110156-mutt-send-email-mst@kernel.org>
 <CAFEAcA_2oZepwCoPS+cMgdnrSTj=mCGzdFZf5gGRHJK13yqaKQ@mail.gmail.com>
 <20260611114811-mutt-send-email-mst@kernel.org>
 <CAFEAcA9HUGfDgHjvCemPPNkp6FfvQp+4y7qCnw+ROFpG3+ybMw@mail.gmail.com>
 <20260611123952-mutt-send-email-mst@kernel.org>
 <CAFEAcA8vOMd64cCkfCyc1wNbjEY+bnhFPce-V_WbAuXrUnP8cw@mail.gmail.com>
 <20260611130037-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260611130037-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Thu, Jun 11, 2026 at 01:02:39PM -0400, Michael S. Tsirkin wrote:
> On Thu, Jun 11, 2026 at 05:53:54PM +0100, Peter Maydell wrote:
> > On Thu, 11 Jun 2026 at 17:42, Michael S. Tsirkin <mst@redhat.com> wrote:
> > >
> > > On Thu, Jun 11, 2026 at 05:16:09PM +0100, Peter Maydell wrote:
> > > > On Thu, 11 Jun 2026 at 16:57, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > > Then I'd like to see an example where we have an actual good reason
> > > > > to do execute arbitrary width accesses on device RAM when the
> > > > > driver does not execute them, please.
> > > >
> > > > That's the case we started with, with this GPU where the
> > > > virtio data structures are in this PCI BAR. We want the
> > > > virtio backend to have the freedom to say "I'm just going
> > > > to assume the ring buffer etc is in RAM, and I don't need to
> > > > care about carefully ensuring that I only do word accesses".
> > >
> > > virtio backend does not need to assume anything. any spec
> > > compliant guest guarantees it. any address given to
> > > a virtio device is ram.
> > 
> > OK, but how do we tell if the mmap() PCI BAR we have is RAM
> > or not ? Some of them are, some of them aren't...
> > 
> > -- PMM
> 
> We don't care? If guest asked a virtio device to access
> memory then that memory better support accesses guest
> requested, and on virtio that means any width.

And by the way, current "direct access" code that translates a fixed
width guest access to a variable length memcpy, resulting by byte
accesses - is broken for everything, including RAM, because guests
expect atomicity.


-- 
MST


