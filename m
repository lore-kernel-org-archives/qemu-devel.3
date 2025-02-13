Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D57AC021A0
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Feb 2025 09:29:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiVWo-0006Ec-NC; Thu, 13 Feb 2025 04:29:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1tiVWm-0006EM-OZ; Thu, 13 Feb 2025 04:29:00 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1tiVWg-0000tr-4T; Thu, 13 Feb 2025 04:28:57 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id C1E195C5218;
 Thu, 13 Feb 2025 09:27:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0670CC4CEE7;
 Thu, 13 Feb 2025 09:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1739438904;
 bh=O6XN/eepoD0qQ1NcJ6x8aY6dWe8Sax3t2bAPi2yqgM0=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=XwPXRLQa6alrMU1rgoOBqv9/Vgu5A84PJpZBHGBR+72pCWjzVVmvc+u9Y9XMmZzRV
 xfFukp7v98QSxBlYPZv7bi/yQXYpE93+TFk04sz+z4NRcrmlrGi8wtUA+izAKWOiwv
 rBGCnMPHKdvDJ00QVVs7HgiX7W5FaZK8YccgCT6LcI7L/wIA6PO508uoULeXYQO/1+
 EuVkWeZfu7LEgXyb4JdMUE9bdlY7Mb5CEw5PXY6Zcw5OgUtf/6fD8032Xr11Y4Wnr0
 1vhSyxCGQI6C2pUyE0h4OU73E70IqERCILWM/CCJEsAWNeN0mTx4P7W1KUPsMbs5ux
 6N6qhZGHI0LZg==
Received: by mail-lf1-f44.google.com with SMTP id
 2adb3069b0e04-5450b91dbc8so590821e87.3; 
 Thu, 13 Feb 2025 01:28:23 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCVgBjyhzAyTbeq+3X64Odigtb6JVjb2SJyct5h24kGRUeaq74wY0r8GKD+S4GwrhOycq9spo6FyXCpcbw==@nongnu.org,
 AJvYcCWrOWd8E3eIrptjLiPWEOYvnk++EpUdMm/B3DdOF3+aD4BmDL+NpH7hVFuFa9JM0VgCah+8GevVmQ==@nongnu.org
X-Gm-Message-State: AOJu0Yw0bsfUEDYEtc9w+MRw7RjMcpBjihsrZMcST2qnEeJ5lsD7aRpy
 T2nBzEyvxVNOySelgaHwXieKGBRI0UMU1FnRMBU6JCdDUMrgNkIfzWgAXqfoh1jceIDLnNuHukB
 EHHETiA1zItMoFbqS17R0K/ME18U=
X-Google-Smtp-Source: AGHT+IH0y14C6AXks5AvBJDlu6KVcSbeXcYX3PqIPq+0N4Y4W/FiJFV6bQMqmcgNeyh/rTw12vh6Q++zMBwnNm1UJ4M=
X-Received: by 2002:a05:6512:138e:b0:545:5d:a5e2 with SMTP id
 2adb3069b0e04-545180ea975mr1770581e87.10.1739438902287; Thu, 13 Feb 2025
 01:28:22 -0800 (PST)
MIME-Version: 1.0
References: <20250211092324.965440-1-kraxel@redhat.com>
 <20250211092324.965440-10-kraxel@redhat.com>
 <da0ac9ed-fdca-433e-b793-5423f430a852@amazon.com>
 <iuwaykfdm7bwtvblyz7lkew3em2ksi5xeztdphqjdv7tsp2ejw@s6j64y3lfmrw>
 <ea1d355b-7e56-47ef-b1e7-158003b6d85f@amazon.com>
 <kk4f5e3olb26qfjveqefkuzrjc45djikkk7uspz4yj7iesdmbj@zointitbvhdp>
 <73fe41f7-dff0-4506-8769-1997323c0a76@amazon.com>
 <4bwjwcs2k4hbrj6mokc57a5dy57jjssfxnvd4qm5257dgnid3x@yqdx7e47o2mf>
 <2c06a98c-f286-4632-a352-8b47dc4cc43c@amazon.com>
In-Reply-To: <2c06a98c-f286-4632-a352-8b47dc4cc43c@amazon.com>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Thu, 13 Feb 2025 10:28:11 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHDMCNGG94V8VcnS8busEGs-MwOy+Ne_oRCkvtw9DiX1w@mail.gmail.com>
X-Gm-Features: AWEUYZmg-J_SVM0li08t7b1-JZye4BO_Qc3OZLPW_VJHfMu3yu423mulzeP44vU
Message-ID: <CAMj1kXHDMCNGG94V8VcnS8busEGs-MwOy+Ne_oRCkvtw9DiX1w@mail.gmail.com>
Subject: Re: [PATCH v3 09/23] hw/uefi: add var-service-core.c
To: Alexander Graf <graf@amazon.com>
Cc: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org, 
 Eric Blake <eblake@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 qemu-arm@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=ardb@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Wed, 12 Feb 2025 at 22:26, Alexander Graf <graf@amazon.com> wrote:
>
>
> On 12.02.25 16:18, Gerd Hoffmann wrote:
> >    Hi,
> >
> >>> Yes.  Knowing both physical and virtual address works only for memory
> >>> you allocated yourself before ExitBootServices.  So you can't pass on
> >>> pointers from the OS, you have to copy the data to a buffer where you
> >>> know the physical address instead.  Yes, some overhead.  Should still
> >>> be much faster than going to pio transfer mode ...
> >> MacOS takes over the full physical address map past ExitBootServices: Your
> >> code no longer has VA access to random code
> > That is totally fine.  EFI drivers must register everything they need as
> > runtime memory.  Anything else can be unmapped by the OS when calling
> > EFI services.
> >
> >> and it literally memcpy()'s all preserved (virtual available) code and
> >> data to different physical addresses.
> > Uhm.  I have my doubts this copying behavior is blessed by the UEFI spec.
>
>
> I don't remember anything in the spec prohibiting it.
>

The UEFI spec clearly states that runtime services must either be
called using a 1:1 mapping, or via a virtual remapping but in that
case, SetVirtualAddresMap() must be called to inform the firmware of
the new virtual mapping.

Even if this is not clearly stated, this violates the intent of the
UEFI spec: the code reasons about mappings of physical memory,
implying that the mapping is the only thing that changes. Moving
memory contents around can only be done safely after
SetVirtualAddressMap(), making it mandatory on these systems, whereas
the spec clearly states that it is entirely optional.

But whatever OSX does on x86 is irrelevant anyway: it is vertically
integrated with the firmware, which is vaguely EFI based but does not
aim for spec compliance. The OSX EULA does not permit running it on
anything other than Apple hardware. And x86 Apple hardware will be
reaching obsolescence pretty soon, at least where future development
is concerned.

My colleague filed a USWG proposal for a EFI_MEMORY_SHARED attribute
that must be honored by the OS when creating runtime mappings, and map
the region in a way that allows access by another observer (typically
the VMM but semantically it could mean other things too)

>
> >> You simply have nothing that is all of 1) RAM (mapped as cacheable on
> >> ARM), 2) known VA 3) known PA.
> > Bummer.
> >
> >> So we really really need a fallback mechanism that works without DMA
> >> :).
> > On arm it should be relatively simple to move the buffer to device
> > memory.  Just place one more region on the platform bus, advertise
> > address + size via device tree, done.
>
>
> That will bring back all issues with cached vs non-cached memory
> accesses, no? So edk2 will always access that memory as device memory
> which means it bypasses the cache, while QEMU will access it through the
> cache. So that buffer would need to actually be MMIO memory I suppose?
>

Indeed. Presenting memory as MMIO just to trick the guest into mapping
it shared is not the right approach here, which is why we need
EFI_MEMORY_SHARED on ARM. On x86, using the EfiMemoryMappedIo type
happens to work, but it is a hack (e.g., you cannot allocate memory of
this type)

