Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1A6FCDE001
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 14:52:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wclRh-0007Fa-5x; Thu, 25 Jun 2026 10:52:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wclRV-0007D9-AT
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:52:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wclRT-0002Gj-HX
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 10:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782399154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=b03ny8I3CECy/Mhh5LizKVfN8XCPRPuhJjOU+XekIzk=;
 b=JlqRgmuFTnR72GITsETRPny2VgHujE+y89rJbAfTlLh2o9RXrh8L4ZDVaF5F3BxlbNy9aY
 SQjY+cVk6wD/HjFc5mNgc0FBMbrheEPy4EWPz7glIgVq5oqLBUzOQu9b6X8qCTWiGnGeci
 ZBjjM5qvI4LeUIO408VFI3Njz/U2rrs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-FSLxn_bQOg2sgRd69Mj3bw-1; Thu, 25 Jun 2026 10:52:33 -0400
X-MC-Unique: FSLxn_bQOg2sgRd69Mj3bw-1
X-Mimecast-MFC-AGG-ID: FSLxn_bQOg2sgRd69Mj3bw_1782399152
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4924e099a17so14849895e9.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 07:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782399152; x=1783003952; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=b03ny8I3CECy/Mhh5LizKVfN8XCPRPuhJjOU+XekIzk=;
 b=NqpTlM36WX7i6OQFk1kWMttbKzDAoUjQTPwE3UEbyR/9/PSTzdfsn/SjnfEuaFxi5E
 drvB77rGn9LxoNl/hJGkG+g0arpVDdziRw+hufRmnVpCOU2ZZX7/eMRd0fUa8hiK2fGp
 13Wv0QpCgbue/upEaF0mCwRJgq5tW3hG/NHpvneHFkPFQ8wt443O20I62bdSL4UFm9/1
 S2MEWjp7pId7V9xYg0DW87CzED8xgQMBf+g8CHj+ZWMF4RKHKNWjl5r85X/37T76K/UJ
 S6Mncr4De3QtOh9EIE68n1B/cLb4ovjaYQ+A9hrjwSU+cU+oVMgDBH/+LocIjM0QNYJ9
 KkoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782399152; x=1783003952;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=b03ny8I3CECy/Mhh5LizKVfN8XCPRPuhJjOU+XekIzk=;
 b=JmNBN50SPdwWAaPYbk3G2EKbX9cskkxTisP3EkWVQMgk3yd6F2haA4RwN74XT7eE6C
 iBzX7DebYt8PysrRrfm5gU4MPfnIb0cloPOSshnO8TDwosPvCwTFOCETIzRkFJQNg9y3
 0L7e2Bzu+EI5sIaOTIFHUIbWBYj1FOOcLoXRShVOm5uQ+iBAMfKbjg2fgTzKhnejo138
 N7bIGDhJIFy3LQ8M5Pb8r5H2GpxP3qJIsSx86JDRMoW8JGDCUCh3MZ/sJ1CUVQXrS7f+
 P0Mkn5l/0w9KF0XzoBBSKL8u+0K7gUIKqWsra/zy59Gi7qGrr2/YmYhJnqWL+55Mkm82
 091w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+nL5CbjlyhiD2AfD6Z/nljckqLn70NPyqs2JRfPY2gyIszF8yTWXLjVRsT4BMRomTF8SigkaSOtEz5@nongnu.org
X-Gm-Message-State: AOJu0YyLY2QqbBfbctVC1iSPDEjTGZhIuyeKTMhUEoKohYS98lC818b2
 /Re/aDw4fcImvDbdfluf8UZIsNB/Lsnyl0IPMw8uQyoioFeXNA9OsBht/0VPCT+Q0nREM6en6Hc
 4bV1wXFKWDFGGjdvIUYzEfiiInHgWk2KHEQeoKoLEJMikMk4jn2f5fdti
X-Gm-Gg: AfdE7ck6rbr5yAAOBfqc6w8etBO9I1zlyAbW+va+pSKCy//pcUD5SPNzdgglIn7PKuX
 CvmW9ZASqCPuwFik+6bzlnBj8BL4f/viG8nebRzYutXue6qqyt7JQKH2fMqNUvYDp9SaPw82LdZ
 MOx1HXesL959Sng8nfYxOhi/2zP+e3/a1+T1MxJDZSFhoFuVeNdp3UHZpZHAoQwb6IkW5YrOf3O
 uDe5hCnsZ8FO5wqHhTX6iO1X7HF914A1r5R8vinmEhfu+4QkeWDMJBX/CeZja+lolBtPCHNr2b3
 DIE0Xvhl8AHMZGMGOZp6fZbXhL3o5JdGIJNJpBPs3IlDafindS1rEYQMOOb9wRCF3WzBuE9uDVo
 ZbPeGQuQxVLMUy65F4I5m+zeDmVdulA+0
X-Received: by 2002:a05:600c:820d:b0:490:bcc1:4edb with SMTP id
 5b1f17b1804b1-49266884b7emr39945365e9.27.1782399151677; 
 Thu, 25 Jun 2026 07:52:31 -0700 (PDT)
X-Received: by 2002:a05:600c:820d:b0:490:bcc1:4edb with SMTP id
 5b1f17b1804b1-49266884b7emr39944835e9.27.1782399151131; 
 Thu, 25 Jun 2026 07:52:31 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492690100c7sm2889135e9.12.2026.06.25.07.52.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 07:52:30 -0700 (PDT)
Date: Thu, 25 Jun 2026 10:52:27 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Gavin Shan <gshan@redhat.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, peterx@redhat.com, alex@shazbot.org,
 richard.henderson@linaro.org, berrange@redhat.com,
 philmd@oss.qualcomm.com, philmd@mailo.com, david@kernel.org,
 clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com,
 jugraham@redhat.com, liugang24219@sangfor.com.cn,
 dinghui@sangfor.com.cn, shan.gavin@gmail.com
Subject: Re: [PATCH v3 1/2] system/memory: Use qemu_ram_{copy, move}() in ram
 device region accessors
Message-ID: <20260625101817-mutt-send-email-mst@kernel.org>
References: <20260616052552.389021-1-gshan@redhat.com>
 <20260616052552.389021-2-gshan@redhat.com>
 <CAFEAcA-mf14=jpRFHarAbN6AbQwvW=Yu6WB1JiNMsECEdaxD3A@mail.gmail.com>
 <20260625070551-mutt-send-email-mst@kernel.org>
 <CAFEAcA8YJZq9TqrUd0zTnewAdVDm5y6UV7BJQZ0C60TZ=RT98Q@mail.gmail.com>
 <20260625091334-mutt-send-email-mst@kernel.org>
 <CAFEAcA8xK+t3-prEphtkq-o9UY2mgS6cowhs880GOaxL9dKSGw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAFEAcA8xK+t3-prEphtkq-o9UY2mgS6cowhs880GOaxL9dKSGw@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Jun 25, 2026 at 03:02:42PM +0100, Peter Maydell wrote:
> On Thu, 25 Jun 2026 at 14:23, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Jun 25, 2026 at 01:48:11PM +0100, Peter Maydell wrote:
> > > On Thu, 25 Jun 2026 at 12:07, Michael S. Tsirkin <mst@redhat.com> wrote:
> > > >
> > > > On Thu, Jun 25, 2026 at 11:09:26AM +0100, Peter Maydell wrote:
> > > > > This is still wrong. We should not have "x86 magically works
> > > > > and all other hosts do something different" ifdefs. Define what
> > > > > semantics you need and then we can figure out how to
> > > > > implement them.
> > > > >
> > > > > My current thought is that we need to handle accesses of
> > > > > 1, 2, 4 and 8 bytes that are naturally aligned by ensuring that we
> > > > > do exactly one host load/store of that type, and that anything else
> > > > > is "the guest isn't relying on specific semantics here, we can just
> > > > > assume it's plain old RAM and do whatever". That would not
> > > > > require any architecture specific ifdefs.
> > >
> > > > Well. X86 is special, as usual. It allows unaligned mmio so
> > > > we really have no way to know an x86 guest does not intend
> > > > just that. That can only be emulated perfectly on x86
> > > > which is sad but I see no reason to actively break it.
> > >
> > > What actual hardware will rely on unaligned accesses
> > > appearing to it as single unaligned accesses?
> >
> > /me shrugs
> > any hardware that was only tested under windows?
> 
> I seriously doubt any hardware designer implements
> registers that are not aligned, especially on PCI devices.
> "Only tested under Windows" doesn't imply "hardware
> designer did something nuts".

Well I worry.

> > > And if we do need this, we need to specify:
> > > - what are the semantics we need to provide?
> >
> > match what happens on bare metal
> 
> This is too vague. We need to write down what we mean,
> in enough specifics that we can then say "OK, we can
> do this this way", or "we can do this this way on
> some hosts, and these corner cases are not covered
> on other hosts".

I think there is exactly 1 kinda reasonable case. A 2 byte read/write at
offset 0x1 within a dword. This maps nicely to even classical PCI byte
enable mechanism and so yes it works if your CPU can initiate these
things, and it's atomic.

I tried reading LEDCTL on e1000e:

       byte  @ 0xe00: 0x64
       byte  @ 0xe01: 0x2a
       byte  @ 0xe02: 0x00
       byte  @ 0xe03: 0x00
       word  @ 0xe00: 0x2a64
       word  @ 0xe01: 0x002a

Works fine.

How important is it to have a script like this to work
correctly? I don't know.


> > > - what is the use case that relies on these?
> > > Then we can see how closely we can match that.
> >
> > passhtrough of weird devices, first of all.
> 
> This isn't a use case, it's a vague hypothetical.

True.

> > > There's a lot of extra complexity added in here for
> > > something it I don't think is ever going to matter,
> > > and having the most common host architecture take a
> > > totally different codepath from everything else is
> > > a recipe for that other codepath breaking.
> 
> > Not sure we have to be pedantic. We have arch specific code and the
> > world did not end.  It's not a lot of code, it's just for unaligned
> > accesses on MMIO, which might or might not be broken anyway.
> > And it worked already, so it's more about going back to what we
> > did earlier.
> 
> But we should not have arch specific code unless we
> have a reason to do it. And if we have a reason to do
> it then we should say what that reason is and what the
> cases the host has to cover are, so that when we can
> implement it correctly we do that.
> 
> -- PMM

I just like it when we implement whatever host does, qemu being a
hardware emulator, after all.

If you feel it's nonsense, I'm not gonnu fight.

-- 
MST


