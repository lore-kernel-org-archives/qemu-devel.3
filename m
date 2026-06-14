Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93658CD98D2
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Jun 2026 15:13:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYmWQ-0003hL-TN; Sun, 14 Jun 2026 11:13:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYmWP-0003gp-Ia
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 11:13:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wYmWN-0005Do-Qg
 for qemu-devel@nongnu.org; Sun, 14 Jun 2026 11:13:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781449990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kWl8m7l9xoImRfNFb/MfBzBL9YfQPVIKZShDreG9XTU=;
 b=iQgjRlLkg7TYzgm9EeqLuznUK2CXEZ5ehl6U8jfQ0dhIOrLuzBUGGvRc+P9RMU+XAvAcMU
 Erqbw3JQR1H84iwYOSPGgcqpecCyaQJLU05atev6i4lKADSlZ6PjKSG6E/3otYCnIbir2y
 toocbPdVm9/bmQoqJnicahN1+KUmvyE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-617-Llx7XJMTMFO0MmE_L2xMbg-1; Sun, 14 Jun 2026 11:13:07 -0400
X-MC-Unique: Llx7XJMTMFO0MmE_L2xMbg-1
X-Mimecast-MFC-AGG-ID: Llx7XJMTMFO0MmE_L2xMbg_1781449986
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45eef10d5ebso1307633f8f.0
 for <qemu-devel@nongnu.org>; Sun, 14 Jun 2026 08:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781449986; x=1782054786; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=kWl8m7l9xoImRfNFb/MfBzBL9YfQPVIKZShDreG9XTU=;
 b=t/gSS2vZ91DJ2T3RDK7Kj8PS/LpThN06xsBfEINaTLgtKgGHBWv7loGam+OS6VZUne
 r9oXPYcJx0aWRhwBKGrAfqHErp8Th8p4p8qhNjH7X0qw+SFUO9gnod1AjFyWbIGeLzdT
 dry+zBwcVtip5fdpfIlujl+1KMAbw1tKC0lZ6zMC1GBYjSB6gUWxMisNnhmx4DQQu0IK
 4i3maHkYwSfDI/U/7p3CBANbWiatbiKRaeQQVdPOGwk8p3mr/BI3HKRepR8S8OK6Sdu+
 3ncHoOkmwvEvJenefa/I7Ke8pzjjoA8l+H9ETsPEB3GtYGj6MUB5NJAJth4cKTsIwBf+
 7EqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781449986; x=1782054786;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kWl8m7l9xoImRfNFb/MfBzBL9YfQPVIKZShDreG9XTU=;
 b=shJZqY7j9t3M84OpJymZx1dzcDE01pm4mSBGfI8zuHVky+IA7AP5iusjz0LSPxJ1Fu
 BUHegpgp1na4SUdHSHMCXoVBrKaeADeptT8vgRJRJS0tS/ludznlrRSv/lmW6jws/M88
 r90OE/qx4BXV8+wcisRTmuQmB3Exp1NOB+KtjtLnPUpNwGWsNQX8KW9mtpKbsMExeelq
 b/e5k2IWYGOTI8dRYDbN7RjqZuE91gaaJbXn/I4b6W7mSjLpLve48zp3Kc8vX42vQm7n
 DZ8Qvbd3URWQYeeBdvMB13+R38UXckweLLGPiNhW8V21DiNsSkqQSnezQ6T+4JXDGGPB
 OL2Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Cv0E7WDC93WfpJiMI1ACoL1zQWjM5yrKvaCeyuTN3HmeQIYWBVJsv9xLIq4rip/BAlPfLrxn+LT1W@nongnu.org
X-Gm-Message-State: AOJu0Yz2cEPBL5ZJM+Vfgu00FshPMPH6QUPdk21HlRRHM2x1qaJZM24N
 yyWVXIzZfkcKM6oUh/a6n2837zVeW1HePjaeCrvzyGVja2mpxe0nJ6RlSjEqji1CqLBPp9BTCdn
 /OgNpJd8y6K/ie143QCIbC0lA8GdmU1hP0dmSPlxATh+0fIHNWV4OsYe8
X-Gm-Gg: Acq92OHJhB1Mzs1YtVeHNyJkta9XDTk6i4LqGSVj6VqzY3Qx1rym9iKsEQ1lXvWj5t+
 XB/l9/sMm7PRwP7j6GxplAn2PIF22kCPF8jX8T1ok3qmPvWyNycUx3b1REDWnp1VYSbM2S5R0WR
 bKHRyI7ZeXwpl0sGFGl4x0dq8lzjUXR/Hq1ki3qcFrEju+BaBCIZqbcEJHmWrFnkjV+4KDBStMT
 qxH9Pw6oLhnWC0R/K0RePqE/mOcbQE6B9bIcVIICnElBuUuVvKtOti3mp1CAEdJcTf0OmKWxdib
 fQpT3cK5cVc07Rm2LPx5yTCFIP0/kx58pURF5ioLOW00EFd451B0FZbLkeqyrzYMjqgtaz6McCd
 pR8aIg3b92h/pHkQpG6t67YY10t7/ycQ5yr1mB7vnGeY=
X-Received: by 2002:a05:600c:3650:b0:490:d354:bd0a with SMTP id
 5b1f17b1804b1-49220143bd1mr58959195e9.31.1781449985772; 
 Sun, 14 Jun 2026 08:13:05 -0700 (PDT)
X-Received: by 2002:a05:600c:3650:b0:490:d354:bd0a with SMTP id
 5b1f17b1804b1-49220143bd1mr58958715e9.31.1781449985143; 
 Sun, 14 Jun 2026 08:13:05 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922033dd59sm162910305e9.9.2026.06.14.08.13.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 08:13:04 -0700 (PDT)
Date: Sun, 14 Jun 2026 11:13:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Gavin Shan <gshan@redhat.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, peterx@redhat.com,
 berrange@redhat.com, david@kernel.org, alex@shazbot.org,
 clg@redhat.com, pbonzini@redhat.com, philmd@mailo.com,
 phrdina@redhat.com, jugraham@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH 1/2] system/memory: Use __builtin_mem{cpy, move} in
 accessors of ram device region
Message-ID: <20260614084004-mutt-send-email-mst@kernel.org>
References: <20260612110307.1264798-1-gshan@redhat.com>
 <20260612110307.1264798-2-gshan@redhat.com>
 <223f5f94-b9b7-46b0-8466-5be655203a0e@linaro.org>
 <CAFEAcA-TgP_BM0WQo3rysZmvhNN17Gc_nrSYB6pXn-mvs5w13g@mail.gmail.com>
 <123d9e80-d731-42c7-81cc-71de47bb13d3@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <123d9e80-d731-42c7-81cc-71de47bb13d3@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Jun 12, 2026 at 10:25:35AM -0700, Richard Henderson wrote:
> On 6/12/26 09:36, Peter Maydell wrote:
> > On Fri, 12 Jun 2026 at 16:29, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> > > 
> > > On 6/12/26 04:03, Gavin Shan wrote:
> > > > This replaces mem{cpy, move} with __builtin_mem{cpy, move} in the memory
> > > > accessors to ram device memory region, preparatory work to make ram device
> > > > region directly accessible and bypass the bounce buffer in the DMA path
> > > > in next patch.
> > > 
> > > memcpy/memmove *always* compile to __builtin_memcpy/memmove, and the compiler later
> > > decides whether or not to expand inline.
> > 
> > Yes, but if you pass it a fixed small integer, then it is likely
> > to expand it inline, whereas if you pass it a variable then it
> > is likely not to... The patch is attempting to persuade the
> > compiler to definitely do an inline access for 1, 2, 4, 8
> > byte access.
> 
> Sure, for hosts with unaligned accesses.  We still have sparc64 and (some?)
> riscv64 that don't automatically have such and will compile to more than one
> host instruction.
> 
> > > My real question is: what are you attempting to achieve?
> > > 
> > > (1) is the problem unaligned access to a mapped physical device?
> > > (2) is the problem vector access to a mapped physical device?
> > > (3) something else?
> > 
> > I think there are two problems we're trying to fix here:
> > 
> > (1) If a device does e.g. a pci_dma_write() with size 1, we want
> > this to turn into exactly 1 byte write into guest memory, for the
> > normal case where the guest memory is real host RAM.
> > This deals with the e1000 bug where the pci_dma_write() turns into
> > a call to glibc memmove() with size 1 and glibc's implementation
> > turns that into 3 writes of the byte to the same address...
> 
> Gotcha.  Easily handled by not using memcpy/memmove at all.
> 
> 	*(char *)ptr = val;
> 
> is sufficient for all hosts.

Yes, I think it does work because we use -fno-strict-aliasing.
For bigger sizes we'll need packed because the addresses
could be unaligned.



But again, qemu simply already relies on this in bswap.h

I kind of dislike muddying the waters by making several
unrelated changes here. If we do we should change bwap too.


> > (2) If a vCPU (emulated or KVM) does a 4 byte access to an
> > address which is in the PCI BAR of a vfio-passthrough device,
> > we want this to turn into exactly a 4-byte access to the
> > mmap()ed memory which is the BAR of the host device. This
> > is because that address might be a real hardware device
> > register, so it's important to access it exactly the way
> > the guest vCPU asked for, and not do multiple accesses or
> > misaligned accesses or whatever.
> > 
> > (The reason we make pass-through BARs not "direct access"
> > but instead go via the bounce buffer is that we were working
> > around (2).)
> 
> That's going to require qatomic and alignment checks.
> 
> That's also going to beg the question of the intended behaviour anything
> that isn't a naturally aligned access of size in {1,2,4,8}: fall back to N
> operations of the minimum of alignment and size?

For most host/guest pairs things simply work even for unaligned.

And yes, guest drivers do do this.

On classical pci, there are no transactions as such and
an unaligned access will be split anyway.



> 
> 
> r~


