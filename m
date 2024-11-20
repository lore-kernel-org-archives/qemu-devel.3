Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DFC2D711C0
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Nov 2024 16:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDnVF-0006oI-Cl; Wed, 20 Nov 2024 11:24:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDnVE-0006oA-ER
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 11:24:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tDnVC-0002M5-P7
 for qemu-devel@nongnu.org; Wed, 20 Nov 2024 11:24:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732119864;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vFUyPlC6+S58/HKyFxh7eumsaWPLVUkGyl/BpVkjCQI=;
 b=W3MRmz6OiV5FqjSR3xFgXvnx3uXLslrCPGt8d42ixYyL8sylxEgvIg6qhX3WVltKNNRegX
 jexjW60ANjSFYGf/9pQEQHfU4ETQLGPqF5Y+a/MwuxI7Yi6CP+FUC7KSJgdKya3lHjYjqB
 K/duT+pQI1+emVRb3vKCHsVnNFRDNZk=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-Zou-ri6rN7Srcc0nZBus9g-1; Wed, 20 Nov 2024 11:24:23 -0500
X-MC-Unique: Zou-ri6rN7Srcc0nZBus9g-1
X-Mimecast-MFC-AGG-ID: Zou-ri6rN7Srcc0nZBus9g
Received: by mail-io1-f72.google.com with SMTP id
 ca18e2360f4ac-83ac3fe1cf4so439109839f.3
 for <qemu-devel@nongnu.org>; Wed, 20 Nov 2024 08:24:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732119862; x=1732724662;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vFUyPlC6+S58/HKyFxh7eumsaWPLVUkGyl/BpVkjCQI=;
 b=DK44wx013Sv7B1e0psn7yHj5IGDgd/0ngQbQtwQH1VEuyH2WTKFIOzeB5QAny+T1wi
 tbnZj7XNEegRqAIi4j/6XMO8eyQs/UNwl5vDTA0UufYwclJ9o8IgcZpV2IhyRv03bFG1
 XH1y+SmCgjpLFu6zdPyvKq1zges8AE+8zXUKJ+1UNjDzi21+D0sd3X+8FNUQDasejkKN
 ibRKg+BAxJjGcOc7ilzAlnfzcq78y1RqAwYCbuA7Rc5mh+TU2uBiz7uqbgktKViKP/RO
 4oyCUVqJ/YVktPWhpjGARVO/OmCyMJ+ktD0mop2DHF9IPJq+/mNov86oSobZhpKJaWj7
 D0SA==
X-Gm-Message-State: AOJu0YwHVhhvaJhERsgyRuZOJXq/1p9Li80RUfr9Ksb1NtVr1dRnxjhJ
 CZA7VPvaoBhG8Eo7NhQHb8DktM56EUA2c0gubteiFWfWt1Bx57AD5VgeKI6ZmwGrLP8oL+OoV/3
 qacIJtSzpvYBYThSGNlDSziaFZo7Q8jQ08HN1NwBO7/7HYziOCUCw2IstNfEP
X-Received: by 2002:a05:6602:6016:b0:835:4b2a:e52b with SMTP id
 ca18e2360f4ac-83eb604a057mr392278739f.10.1732119862415; 
 Wed, 20 Nov 2024 08:24:22 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGygoN3ILiJJuWpbyZfAtqfis0sI1r2EgKjG6P4+x1X/UFbek4c+PA7QsxkzKtq9aVf1zWWrA==
X-Received: by 2002:a05:6602:6016:b0:835:4b2a:e52b with SMTP id
 ca18e2360f4ac-83eb604a057mr392276739f.10.1732119862119; 
 Wed, 20 Nov 2024 08:24:22 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 8926c6da1cb9f-4e06d707aeasm3307237173.52.2024.11.20.08.24.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Nov 2024 08:24:21 -0800 (PST)
Date: Wed, 20 Nov 2024 11:24:19 -0500
From: Peter Xu <peterx@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Juraj Marcin <jmarcin@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 5/5] qom: Make container_get() strict to always walk or
 return container
Message-ID: <Zz4NM0MKErNHZcs_@x1n>
References: <20241118221330.3480246-1-peterx@redhat.com>
 <20241118221330.3480246-6-peterx@redhat.com> <ZzvIZ4EL92hEk4wC@x1n>
 <CABgObfamYxtgX7SubOd8OvA5w70xQ5uesJ1TuPoTK9onVO+58w@mail.gmail.com>
 <Zzzv32xlLAH4O5Ig@x1n>
 <CABgObfaKrOvfhK5KfoxOOXOyZXeEz33VkvDeE=5wwtq3Ep=QdQ@mail.gmail.com>
 <Zz0GlJAYOzWrrOcC@x1n>
 <CABgObfbXuiqw01mzVLZEgw-o_tdbf83QzYugq7oL4g7TFVV_yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABgObfbXuiqw01mzVLZEgw-o_tdbf83QzYugq7oL4g7TFVV_yg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Wed, Nov 20, 2024 at 12:45:19PM +0100, Paolo Bonzini wrote:
> Il mar 19 nov 2024, 22:43 Peter Xu <peterx@redhat.com> ha scritto:
> 
> > > The easiest way to check is probably to print the type of every
> > successful
> > > object_dynamic_cast and object_class_dynamic_cast. I suspect the result
> > > will be virtio-blk-device and/or scsi-hd, but maybe those already do an
> > > unsafe cast (pointer type cast) instead of object_dynamic_cast.
> >
> > Yes, it sounds more reasonable to me to optimize specific call sites so far
> > rather than provides something generic.
> 
> Though it could still be a
> > generic API so that devices can opt-in.
> 
> 
> One of the things that I am excited about for Rust is checking at compile
> time whether a cast is to a superclass, which makes it safe automatically.

I see.  However looks like it doesn't easily apply to the ahci example
below, where it could conditionally fail the cast (and where I got it
wrong..)?

> 
> > I can give it some measurement if there is, otherwise I'm
> > > > guessing whatever changes could fall into the noise.
> > >
> > >
> > > Yes, probably. At most you can identify if there any heavy places out of
> > > the 34000 calls, and see if they can use an unsafe cast.
> >
> > I can still trivially do this.
> >
> > I traced qemu using bpf
> 
> 
> Nice! I want to know more. :))

I also only learned it yesterday, where I only used to use k*probes
previously. :-) That's:

$ cat qemu.bpf
uprobe:/home/peterx/git/qemu/bin/qemu-system-x86_64:object_class_dynamic_cast
{
        @out[ustack()]++;
}
$ sudo bpftrace --usdt-file-activation ./qemu.bpf

> 
> > and interestingly in my case close to half (over
> > 10000+) of the calls are about ahci_irq_lower() from different higher level
> > stack (yeah I used IDE in my setup.. with a split irqchi..), where it has:
> >
> >     PCIDevice *pci_dev = (PCIDevice *)
> > object_dynamic_cast(OBJECT(dev_state),
> >
> >  TYPE_PCI_DEVICE);
> >
> > So IIUC that can be open to a unsafe cast too
> 
> 
> Hmm no it can't because there's also sysbus AHCI. The fix would be to add
> an AHCIClass and make irq toggling into a method there

Yep, I overlooked the lines of code later.. :(

> 
> but considering IDE is ODD FIXES stage, I'm not sure if I should send a
> > patch at all.  However I copied John regardless.
> >
> 
> Well, MAINTAINERS only says the kind of work that the maintainer is doing,
> you can always do more. However it seems like not a small amount, so maybe
> adding a comment is enough if somebody else wants to do it?

Can do.

-- 
Peter Xu


