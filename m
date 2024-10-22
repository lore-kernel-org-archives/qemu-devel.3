Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 096B4D2C55D
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Oct 2024 14:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t3FcM-0003eZ-S6; Tue, 22 Oct 2024 10:12:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1t3Fc9-0003dB-HG
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 10:12:01 -0400
Received: from mail-qv1-xf30.google.com ([2607:f8b0:4864:20::f30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <gourry@gourry.net>) id 1t3Fc7-0004WZ-Ea
 for qemu-devel@nongnu.org; Tue, 22 Oct 2024 10:12:00 -0400
Received: by mail-qv1-xf30.google.com with SMTP id
 6a1803df08f44-6cbd1ae26a6so34343386d6.1
 for <qemu-devel@nongnu.org>; Tue, 22 Oct 2024 07:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gourry.net; s=google; t=1729606317; x=1730211117; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=5Qhll7IfNOfUrslv0JS+DDYY0+c54jassaWQ2ezcVZM=;
 b=PjwpFFP8BC42euQDJMTaLdAQsspSdBj2j4kHqUGErCqIFyL4Qk8B7+D8EJ4VdHA9G4
 d6ZOltxbnnR9XCCL8DZ5Dgck1M+81HugR2FKudKrduKGRuGqDQlm7oYztYGNuf4ZWntE
 nQgGkw5xKNUi4gR2qlOwSbFVREINOgRVI5wwNQOKQVuH52YlpsW+0BPmZtzeYdtSmxNg
 8Cne/nQRKhqIk9GaHq6gTQCugYPkYcrsbmQR2dFZuOCUaPojHXaEDjpkHGj0JGKYGWpu
 oopOJT4unmRBrg/sNjgN4WTOFdyxb/efi4XwFPEVQSeU0DV4iwXqCTV79dLtOrhHRNFF
 qb3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729606317; x=1730211117;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5Qhll7IfNOfUrslv0JS+DDYY0+c54jassaWQ2ezcVZM=;
 b=eRL1ptbX5vJqq/npRwwMqFrn62bN7aWhUaVlSTFQS6scj9m64qaGdbdU6FQZfwefLr
 xSXwQcaTrrP9HIpFwoKZ2zUXPlRZ2hZhyHnHCp51aBCt0tj4Eb0NqnD+fsLE0ZqHW71w
 oWKasZRHZXnrbdAL6oSIFXcDLsQP6f1I1/D7oWEsqG4ToHJXqYbffqJpLZXr3tsG9q4Y
 KvckFdFQq4Xox/M1OsCMTDLj9Dc9N3elLzOi9CHfGrlJ+ZigdhtahWKmJywBwKEBCm2G
 70qwBcrgS2mkkPGHT1oMNns+ZPUFlRi7G8+juV3XeZ6QgZdDDpN+BMxIxhhocO1yoBgX
 QYmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9QJqDiDwsdMk0O6IDnBfl3JS/Xsb7hLRZcXFccNpdesH1zol2vQnDiVfRG//P3fxNtwtg9kT6NtWv@nongnu.org
X-Gm-Message-State: AOJu0YwddooFNucpYrCa0S2P9e2BzxcrcfL+MaiNK9rbYg2HjlX+SjSt
 bllFX4vXndDcsTk7ByeXEKuYWUl/1Tw0AeSzEdLh+lJbDdY6GAqdZdFR4y/9C1s=
X-Google-Smtp-Source: AGHT+IHbw1D8MQDNK0PT64hixmIdaE3j5oH9Y2hxuMJ4+N0WrOEaNeUQS0eLymZXwzrOWOPN26VX2Q==
X-Received: by 2002:a05:6214:440b:b0:6cc:2cc0:ccda with SMTP id
 6a1803df08f44-6cde11459a2mr205071776d6.0.1729606317290; 
 Tue, 22 Oct 2024 07:11:57 -0700 (PDT)
Received: from PC2K9PVX.TheFacebook.com
 (pool-173-79-56-208.washdc.fios.verizon.net. [173.79.56.208])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6ce009e4470sm29298036d6.125.2024.10.22.07.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Oct 2024 07:11:56 -0700 (PDT)
Date: Tue, 22 Oct 2024 10:11:58 -0400
From: Gregory Price <gourry@gourry.net>
To: Jonathan Cameron <jonathan.cameron@huawei.com>
Cc: John Groves <John@groves.net>, David Hildenbrand <david@redhat.com>,
 linux-mm <linux-mm@kvack.org>, linux-cxl <linux-cxl@vger.kernel.org>,
 Davidlohr Bueso <dave@stgolabs.net>, Ira Weiny <ira.weiny@intel.com>,
 virtualization <virtualization@lists.linux.dev>,
 Oscar Salvador <osalvador@suse.de>, qemu-devel <qemu-devel@nongnu.org>,
 Dave Jiang <dave.jiang@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 Linuxarm <linuxarm@huawei.com>,
 "Wangkefeng (OS Kernel Lab)" <wangkefeng.wang@huawei.com>,
 John Groves <jgroves@micron.com>, Fan Ni <fan.ni@samsung.com>,
 Navneet Singh <navneet.singh@intel.com>,
 =?utf-8?B?4oCcTWljaGFlbCBTLiBUc2lya2lu4oCd?= <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Subject: Re: [RFC] Virtualizing tagged disaggregated memory capacity (app
 specific, multi host shared)
Message-ID: <ZxeyrvjaN3peNXhr@PC2K9PVX.TheFacebook.com>
References: <20240815172223.00001ca7@Huawei.com>
 <sjz2xzwkgkq6bun5lssqbsimbggczarotpjdhcsq3itoq5h7jc@x5ormqciwofo>
 <20240819164024.00005a0a@Huawei.com>
 <A4E80580-437F-46D8-A58B-D2F3851D67BD>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <A4E80580-437F-46D8-A58B-D2F3851D67BD>
Received-SPF: pass client-ip=2607:f8b0:4864:20::f30;
 envelope-from=gourry@gourry.net; helo=mail-qv1-xf30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Tue, Sep 17, 2024 at 07:37:21PM +0000, Jonathan Cameron wrote:
> > * Said mechanism should not be explicitly CXL-specific.
> 
> Somewhat agreed, but I don't want to invent a new spec just to avoid explicit
> ties to CXL. I'm not against using CXL to present HBM / ACPI Specific Purpose
> memory for example to a VM. It will trivially work if that is what a user
> wants to do and also illustrates that this stuff doesn't necessarily just
> apply to capacity on a memory pool - it might just be 'weird' memory on the host.
> 

I suspect if you took all the DCD components of the current CXL device
and repackaged it into a device called "DefinitelyNotACXLDCDDevice", that
the CXL device inherited, this whole discussion goes away.

Patches welcome? :]

> > * Finding a tagged capacity devdax device in a VM should work the same as it
> >   does running on bare metal.
> 
> Absolutely - that's a requirement.
> 
> > * The file-backed (and devdax-backed) devdax abstraction is needed in qemu.
> 
> Maybe. I'm not convinced the abstraction is needed at that particular level.
> 
> > * Beyond that, I'm not yet sure what the lookup mechanism should be. Extra
> >   points for being easy to implement in both physical and virtual systems.
> 
> For physical systems we aren't going to get agreement :(  For the systems
> I have visibility of there will be some diversity in hardware, but the
> presentation to userspace and up consistency should be doable.
> 
> Jonathan
> 
> >
> > Thanks for teeing this up!
> > John
> >
> >
> > [1] https://github.com/cxl-micron-reskit/famfs/blob/master/README.md
> >
> 
> 

