Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FF96CD11DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 16:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp9Yt-0006AN-2T; Tue, 26 Mar 2024 12:22:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rp9Yr-00069y-IY
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 12:22:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rp9Yp-0002Bf-TM
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 12:22:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711470123;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zSBko5VBkdv5xMNTquercBqwqtT3YFKAb945ePdU8fM=;
 b=gWBGQynlU8AYM3IXS5FdfwCCoj/JkAzKSGvA0AxW7C884L4Hkpu9LOmy9nzUO7e6DxBRpy
 Kjm4Gv2dsCA3A9fvbIFd+vbMOzzQRZQiJ+V75FMOXZzSiBrC76CjWi+lqUpc6YmD9UwdWg
 mWgcuGz9QPf60Icud4tCHF4DFEg7Kto=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-358-oHLE-aXYPkqhvrzsKXAtBQ-1; Tue, 26 Mar 2024 12:22:00 -0400
X-MC-Unique: oHLE-aXYPkqhvrzsKXAtBQ-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2d48d75abc0so49510631fa.2
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 09:22:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711470116; x=1712074916;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=zSBko5VBkdv5xMNTquercBqwqtT3YFKAb945ePdU8fM=;
 b=JLLDutOr8dRUP9fpqO5N5UnqmlU8d/a2ujFBoi6uLMWRAPyRwElGXlRKdFoprhyaHy
 xO2Yd/jw6kB9dCcmpYhsoy9shIm+Gf/0kfh6j2SIzrQ8l21Tk0z6fi/6TZpL+eL23HKo
 BSzMZzH7i+Tf5bLLNuT1ZdYeu2sALzKWqP8vPBHdrfiZHnWHVD7MmSjQm2q+Em6KiKfe
 tHEX7ZosPXX32Mk2HHzCBaFk00WgCa7GEXi840Zh49ekLpcFDxC+ZaGf6o4UPmT35tFw
 lJvSiBaLlIc+nHuRxK2LAB3YNOzJ24aSTPrsWH03g1SAMaWVTwyX6PLzcFgqLoMtND5l
 V92g==
X-Gm-Message-State: AOJu0YxkNimBfQqa6BwXC07C0CbslbM9h0oGSqX0LKfM5NELROk0hw6y
 Bq0XhMl1+/F9R37d63dhBZLC3Fi0xcMJzN/dBZmOI4X/3h0G5IEB7HDLsXCKe2ydVxY5BIvI1Sa
 wwZ7Kyn39wSFigqPLepEhDwZf7J4XQORl7Mg77waXSEVYb1PP9vGc
X-Received: by 2002:a2e:9f08:0:b0:2d6:dbc3:3d3c with SMTP id
 u8-20020a2e9f08000000b002d6dbc33d3cmr112754ljk.8.1711470116479; 
 Tue, 26 Mar 2024 09:21:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE7uyqYco9tTL7Da49zmvFAYrEg97iwHH5EII44DwMXwgIfu4+lVSTa9KISCvqFzkLP4xfGtw==
X-Received: by 2002:a2e:9f08:0:b0:2d6:dbc3:3d3c with SMTP id
 u8-20020a2e9f08000000b002d6dbc33d3cmr112735ljk.8.1711470115934; 
 Tue, 26 Mar 2024 09:21:55 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 q20-20020a05600c46d400b004147db8a91asm12072085wmo.40.2024.03.26.09.20.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 Mar 2024 09:20:33 -0700 (PDT)
Date: Tue, 26 Mar 2024 17:20:13 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, devel@lists.libvirt.org,
 richard.henderson@linaro.org, mst@redhat.com, thuth@redhat.com,
 qemu-trivial@nongnu.org
Subject: Re: [PATCH for-9.0] docs/about: Mark the iaspc machine type as
 deprecated
Message-ID: <20240326172013.5d6b9206@imammedo.users.ipa.redhat.com>
In-Reply-To: <d8ddb193-fe76-4554-b887-5106eed2dd01@ilande.co.uk>
References: <20240326125104.90103-1-imammedo@redhat.com>
 <d8ddb193-fe76-4554-b887-5106eed2dd01@ilande.co.uk>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Message-ID: <20240326162013.CdljJWmSIX2WFbd9fwKiKFl5aFNQvJFupkph-zZdRhM@z>

On Tue, 26 Mar 2024 13:30:48 +0000
Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk> wrote:

> On 26/03/2024 12:51, Igor Mammedov wrote:
> 
> > ISAPC machine was introduced 25 years ago and it's a lot of time since
> > such machine was around with real ISA only PC hardware practically defunct.
> > Also it's slowly bit-rots (for example: I was able to boot RHEL6 on RHEL9 host
> > in only TCG mode, while in KVM mode it hung in the middle of boot)
> > 
> > Rather than spending time on fixing 'the oldest' no longer tested machine type,
> > deprecate it so we can clean up QEMU code from legacy fixups and hopefully
> > make it easier to follow.
> > 
> > Folks who have to use ancient guest that requires ISAPC can still
> > use older QEMU to play with it.  
> 
> Heh I've actually been using isapc over the past couple of weeks to fire up some old 
> programs in a Windows 3 VM :)
> 
> I'd really hate to see isapc disappear as there are a number of people from the retro 
> crowd (such as myself) who fire up QEMU/KVM on various historical images, and whilst 
> there are alternatives, there isn't really anything that touches QEMU performance-wise.
> 
> This leads into the question as to how QEMU should handle less recent machines: I 
> appreciate that from an enterprise perspective there is little interest, but there 
> are plenty of hobbyists and historians who are.

I'm not looking at it from enterprise point of view, but rather from
developers/maintainers side.

>  From my personal experience with SPARC/macppc machines I accept that they are not 
> first-class citizens, and so my approach here is that I don't mind if patches break 
> migration or command-line compatibility as long as I can still fire up the VM. 
> Regressions do occur, but fortunately they don't tend to occur that often.
> 
> I can see how there is a lot of legacy cruft around handling legacy command line 
> options that could be improved by removing isapc, and I think that a lot of this is 
> around preserving historical behaviour.
> 
> How about splitting the isapc machine out of the generic PC init so that it can be 
> used going forward with less command-line/migration compatibility guarantees, but 
> also won't prevent subsequent tidy-ups/changes to the main PC machines going forward?

it's not only command line, it polluting code all over pc machine
(the recent example, I've touched smbios, where we have legacy mode
only for ISAPC (since 2.0 machine has been deprecated/removed)).

Yep, it should be possible to extract ISA machine at cost of some
duplication and let it slowly continue decay. But it's thanks-less
task and shared code would still remian the issue.

Old QEMU can be used for testing at the cost of few minutes to
create container without much hassle, see my other reply to Philippe.
 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> >   docs/about/deprecated.rst | 7 +++++++
> >   hw/i386/pc_piix.c         | 1 +
> >   2 files changed, 8 insertions(+)
> > 
> > diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> > index 7b548519b5..5708296991 100644
> > --- a/docs/about/deprecated.rst
> > +++ b/docs/about/deprecated.rst
> > @@ -226,6 +226,13 @@ These old machine types are quite neglected nowadays and thus might have
> >   various pitfalls with regards to live migration. Use a newer machine type
> >   instead.
> >   
> > +``isapc`` (since 9.0)
> > +'''''''''''''''''''''''''''''''''''''''''''''''''''''
> > +
> > +These old machine type are quite neglected nowadays and thus might have
> > +various pitfalls with regards to live migration. Use a newer machine type
> > +instead.
> > +
> >   Nios II ``10m50-ghrd`` and ``nios2-generic-nommu`` machines (since 8.2)
> >   '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> >   
> > diff --git a/hw/i386/pc_piix.c b/hw/i386/pc_piix.c
> > index 18ba076609..96f72384dd 100644
> > --- a/hw/i386/pc_piix.c
> > +++ b/hw/i386/pc_piix.c
> > @@ -921,6 +921,7 @@ static void isapc_machine_options(MachineClass *m)
> >       m->default_nic = "ne2k_isa";
> >       m->default_cpu_type = X86_CPU_TYPE_NAME("486");
> >       m->no_parallel = !module_object_class_by_name(TYPE_ISA_PARALLEL);
> > +    m->deprecation_reason = "old and unattended - use a newer version instead";
> >   }
> >   
> >   DEFINE_PC_MACHINE(isapc, "isapc", pc_init_isa,  
> 
> 
> ATB,
> 
> Mark.
> 


