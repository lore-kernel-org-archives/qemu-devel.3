Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63D0AC2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 05:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sS98Z-0005SA-H1; Fri, 12 Jul 2024 01:48:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sS98X-0005QK-Dw
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 01:48:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sS98V-00008q-2I
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 01:48:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720763278;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EE/qpmFlX3864AUq8KMxBZyyAbo0y4gLdd2ye1Gp2g8=;
 b=VgnOp5OVwT43zIP6uB2TU+cx+bS5hbLQrxFRvoWbtRK4OV540FfBcCfsHX+1KEZ8JSdrjr
 Q2P1RH3G99VFTzfNBj77LtpLar54+jrk+N0c1Y2GK84vJMPniABxEDm4mgbnWf2X/H1Yz2
 BxZy66Ds6sgfEIN0aCsCb7bGuxzOUPY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-jzXFz63BNiuKqvgD_9Tn4w-1; Fri, 12 Jul 2024 01:47:57 -0400
X-MC-Unique: jzXFz63BNiuKqvgD_9Tn4w-1
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-58b0dce2704so1588133a12.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 22:47:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720763276; x=1721368076;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EE/qpmFlX3864AUq8KMxBZyyAbo0y4gLdd2ye1Gp2g8=;
 b=nzXUNqmu5CKcgJvzduO7TUgD/sA3QbM/VdRN4ejDnDoH4nBsucFzUY/b8WXGNs99ta
 eQBjcYO4+oXtjp5SCBwJIFf6Zs+OegFUn3y+QjziKWoN9soeWrDy2uvh8i+Ek8OEggPk
 DEXGys070fIhPHrFZM0yhLajtEH0wuc5BrjZZwstSjeNHnP+9gE1Pgxn/nXaLJqDf3gm
 ptVUHUdo73I81GsLK+ocNH7kzgQ/4x9UeAByA9LCpgCAmraq5P1WmA3GYIhaWqMkb/TI
 ObOT7bFXLemlHURiG1yXLi4FnydyzHhhABNSLhHG/N2VtSEz3uhH2K8dWmqlsnVcJ9mV
 YWog==
X-Forwarded-Encrypted: i=1;
 AJvYcCUPudMN8uzcCQMAlcHSe4dgYUGZ25eWvPv7JCMVAc/XN36J9Ke6uQm/KkAgwV38kQIwXauNWEVLaQWzLlGBjxAGW6XuMss=
X-Gm-Message-State: AOJu0YzkW5f6qwcO+7vXUYCjh5PLKMKG+OgwAktddU8or9xI38X8IdDV
 wwe0AhNpj6qp3NUbPr4iGnQ6EYNWCY0Kf6nFpjYHHKlVyzSoUKxloT4qafI3fAAVbIO9hWQdxSJ
 P4oAL4RbfnHATzbWuhppb6LLWmYiVxDz3o0NCcVdy/bVN2TcL5461
X-Received: by 2002:a05:6402:518d:b0:58c:6edf:d5cb with SMTP id
 4fb4d7f45d1cf-594b9b04a3emr7539924a12.4.1720763275827; 
 Thu, 11 Jul 2024 22:47:55 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG2EwYqr7OlNp8splDgpOnOwNs7NeaUNGDerShYw98vyNfoCCw8m+Z8FMhByS0Z28ahnJGIOQ==
X-Received: by 2002:a05:6402:518d:b0:58c:6edf:d5cb with SMTP id
 4fb4d7f45d1cf-594b9b04a3emr7539905a12.4.1720763275195; 
 Thu, 11 Jul 2024 22:47:55 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc7:341:761e:f82:fc9a:623b:3fd1])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5998f23bac8sm436050a12.37.2024.07.11.22.47.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Jul 2024 22:47:54 -0700 (PDT)
Date: Fri, 12 Jul 2024 01:47:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Stevens <stevensd@chromium.org>
Cc: Alyssa Ross <hi@alyssa.is>, Albert Esteve <aesteve@redhat.com>,
 qemu-devel@nongnu.org, jasowang@redhat.com, david@redhat.com,
 slp@redhat.com, Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 stefanha@redhat.com
Subject: Re: [RFC PATCH v2 0/5] vhost-user: Add SHMEM_MAP/UNMAP requests
Message-ID: <20240712014407-mutt-send-email-mst@kernel.org>
References: <20240628145710.1516121-1-aesteve@redhat.com>
 <87bk34i4dy.fsf@alyssa.is>
 <CAD=HUj7av_8Epkd0Fe0eWR7Z4bZMTuvTNgqzYoQcOzFQ82wvOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAD=HUj7av_8Epkd0Fe0eWR7Z4bZMTuvTNgqzYoQcOzFQ82wvOg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Jul 12, 2024 at 11:06:49AM +0900, David Stevens wrote:
> On Thu, Jul 11, 2024 at 7:56 PM Alyssa Ross <hi@alyssa.is> wrote:
> >
> > Adding David Stevens, who implemented SHMEM_MAP and SHMEM_UNMAP in
> > crosvm a couple of years ago.
> >
> > David, I'd be particularly interested for your thoughts on the MEM_READ
> > and MEM_WRITE commands, since as far as I know crosvm doesn't implement
> > anything like that.  The discussion leading to those being added starts
> > here:
> >
> > https://lore.kernel.org/qemu-devel/20240604185416.GB90471@fedora.redhat.com/
> >
> > It would be great if this could be standardised between QEMU and crosvm
> > (and therefore have a clearer path toward being implemented in other VMMs)!
> 
> Setting aside vhost-user for a moment, the DAX example given by Stefan
> won't work in crosvm today.
> 
> Is universal access to virtio shared memory regions actually mandated
> by the virtio spec? Copying from virtiofs DAX to virtiofs sharing
> seems reasonable enough, but what about virtio-pmem to virtio-blk?
> What about screenshotting a framebuffer in virtio-gpu shared memory to
> virtio-scsi? I guess with some plumbing in the VMM, it's solvable in a
> virtualized environment. But what about when you have real hardware
> that speaks virtio involved? That's outside my wheelhouse, but it
> doesn't seem like that would be easy to solve.

Yes, it can work for physical devices if allowed by host configuration.
E.g. VFIO supports that I think. Don't think VDPA does.

> For what it's worth, my interpretation of the target scenario:
> 
> > Other backends don't see these mappings. If the guest submits a vring
> > descriptor referencing a mapping to another backend, then that backend
> > won't be able to access this memory
> 
> is that it's omitting how the implementation is reconciled with
> section 2.10.1 of v1.3 of the virtio spec, which states that:
> 
> > References into shared memory regions are represented as offsets from
> > the beginning of the region instead of absolute memory addresses. Offsets
> > are used both for references between structures stored within shared
> > memory and for requests placed in virtqueues that refer to shared memory.
> 
> My interpretation of that statement is that putting raw guest physical
> addresses corresponding to virtio shared memory regions into a vring
> is a driver spec violation.
> 
> -David

This really applies within device I think. Should be clarified ...

-- 
MST


