Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6388C52D7B
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2024 18:47:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdwWx-0007rl-D7; Tue, 13 Aug 2024 14:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sdwWv-0007qh-L7
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 14:46:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sdwWs-0000g2-TC
 for qemu-devel@nongnu.org; Tue, 13 Aug 2024 14:46:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723574756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GJ1kjMh9a0mCsdYKK7uwfERhXhTkTDznfyI/kphb304=;
 b=g4N8DkUKh3yP37tsXAmET5M+OvJw8+CFeoKlkSYR3VVzYln0o3rjkGXvp8g6UPYm48KZEq
 hNG9G+nK3hWBC4cxOBMlau49AktydGAhBwNHQXDyfU13GmLlim1JLAN8GEZxhoArdZx0hC
 5K1+mJ6IDiyFnaE455wHcAqbH4J7MIo=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-69rJU8KhMfiP7ovBo4Jjow-1; Tue, 13 Aug 2024 14:45:54 -0400
X-MC-Unique: 69rJU8KhMfiP7ovBo4Jjow-1
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3db3874fe0fso958144b6e.3
 for <qemu-devel@nongnu.org>; Tue, 13 Aug 2024 11:45:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723574754; x=1724179554;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GJ1kjMh9a0mCsdYKK7uwfERhXhTkTDznfyI/kphb304=;
 b=Iw2d8aEbtfDASBeEKtvuyo5AiTEn1O25H2UHOVt5BWjKDfGXpTDkb90K5ndXQfynOw
 nLsA4wgFCnKN63pEhoU1HJbhg/JL+qJWVD8/q6dtBfPxVgj++IClpiKyIWPS2/P/rhzD
 +VqNbNeQFZzCillKRDMwQGxsRgYbt3DT0oLA9s4eTktMDuiHF7ZJYojtcRElQVqt1Q/P
 9DWoCo55Vix/PCPwBZHNuK1BetNWPw+aMP4TB77XytvfORsbRhGgLRiqqRybJcsSb19m
 A/+ekgZSk2FYl6olUdNen930Yf1/SuV9FdHmSHqM/YunvPZEXpKCTZMhY6a45g8fwkxS
 0t9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWfjAtEdPDEwAyuzrqvwpeGBgylVatueu6Cl7YybwFRz+5UIKZ1xebrTMA9NjwTC70S02jkqOc2xmq7@nongnu.org
X-Gm-Message-State: AOJu0Yz3wa97oUs8bxHW91AfLpSjgkdp+3syESe34aw0H6OwfrGy4fck
 prD6BzwMUmfTjxM5b2532aNw2puR2ZcslsrXsP5esBKdUZG6ryTKprXonnNthLnRc55aLlf1+Pd
 WSKIBjb2WlR1O0VHe9OvMVScTqXuFXO2/kXZui+mgiz30hh7Ka486
X-Received: by 2002:a05:6808:4c3:b0:3d9:402e:4d17 with SMTP id
 5614622812f47-3dd297cdf02mr177379b6e.2.1723574754112; 
 Tue, 13 Aug 2024 11:45:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhGFMxn5EOLjDnsDBNTR2sEn65hyNG/bs4W7LSkR0jGoxi6e5KbLeGd0ysVRGELTboFfiFHg==
X-Received: by 2002:a05:6808:4c3:b0:3d9:402e:4d17 with SMTP id
 5614622812f47-3dd297cdf02mr177360b6e.2.1723574753711; 
 Tue, 13 Aug 2024 11:45:53 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4531c1a7f12sm34379081cf.20.2024.08.13.11.45.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Aug 2024 11:45:53 -0700 (PDT)
Date: Tue, 13 Aug 2024 14:45:50 -0400
From: Peter Xu <peterx@redhat.com>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Steven Sistare <steven.sistare@oracle.com>,
 Igor Mammedov <imammedo@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 01/11] machine: alloc-anon option
Message-ID: <Zrup3sYW7XgsnThy@x1n>
References: <1719776434-435013-1-git-send-email-steven.sistare@oracle.com>
 <1719776434-435013-2-git-send-email-steven.sistare@oracle.com>
 <20240716111955.01d1d2b9@imammedo.users.ipa.redhat.com>
 <88945053-6918-4096-ac55-0ef4b946b241@oracle.com>
 <20240729142932.6667c5b5@imammedo.users.ipa.redhat.com>
 <369f6786-1146-4d5e-a9a5-c0b0b5f45bf7@oracle.com>
 <64b8934e-2655-4224-aaf1-e125e6469f87@oracle.com>
 <Zrt9M00rDk3EUdNM@x1n>
 <20240813110037.6f04ffe9.alex.williamson@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240813110037.6f04ffe9.alex.williamson@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Aug 13, 2024 at 11:00:37AM -0600, Alex Williamson wrote:
> > > Note that the old-QEMU contents of all ramblocks must be preserved, just like
> > > in live migration.  Live migration copies the contents in the stream.  Live update
> > > preserves the contents in place by preserving the memfd.  Thus memfd serves
> > > two purposes: preserving old contents, and preserving DMA mapped pinned pages.  
> > 
> > IMHO the 1st purpose is a fake one.  IOW:
> > 
> >   - Preserving content will be important on large RAM/ROM regions.  When
> >     it's small, it shouldn't matter a huge deal, IMHO, because this is
> >     about "how fast we can migrate / live upgrade'.  IOW, this is not a
> >     functional requirement.
> 
> Regardless of the size of a ROM region, how would it ever be faster to
> migrate ROMs rather that reload them from stable media on the target?
> Furthermore, what mechanism other than migrating the ROM do we have to
> guarantee the contents of the ROM are identical?

IIRC we need to migrate ROMs in some form because they can be different on
src/dst, e.g., ROM files can upgrade after QEMU upgrades.  Here either
putting them onto migration stream, or making that fd-based should work.

Frankly I don't solidly know the details on why they can't be different.
My current understanding was that if one device boots with one version of
ROM/firmware, then it's possible the device keep interacting with the ROM
region in some way (in the form of referring addresses in this specific
version of ROM?), so that it may stop working if the ROM content changed.

IOW, if my understanding is correct, new ROM files won't get used after
migration automatically, but it requires one system reset.  When a system
reset triggered after VM migrated to destination host, it'll reload device
ROMs with the files specified (which will start to point to the upgraded
version of ROM files), and IIUC that's where the devices will boostrap with
the new ROM / BIOS files.

> 
> I have a hard time accepting that ROMs are only migrated for
> performance

AFAICT, it's never about performance or making it faster when putting ROM
data on wire.  Even in this context where Steve wanted to use fd backing
the ROMs, then putting that on wire is still slower than sharing fds.

Here my previous comment / point was that this should be a small region, so
it shouldn't matter a huge deal for ROMs to migrate either through the wire
or via the fd page cache.  I wanted to remove one more dependency that we
may even need the new -alloc-anon parameter as it doesn't sound required
for ROM migrations.

> and there isn't some aspect of migrating them to ensure the
> contents remain identical, and by that token CPR would also need to
> preserve the contents to provide the same guarantee.  Thanks,

Thanks,

-- 
Peter Xu


