Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E278CFB453
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 19:05:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxt2j-0008SG-Gx; Mon, 07 Oct 2024 15:05:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sxt2i-0008Rl-7d
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 15:05:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sxt2g-0002Xk-Ec
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 15:05:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728327911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=U67EA8NaJuuHzXugmhL5eeCsPAbntIMrbUsfZ282OfQ=;
 b=H/GqCqRuew+3kVPyAn7H6tAGye3209vPm5FyNA2h+hPNTk7wGDDRMoe2s6Ecqnx+yp9UgL
 optZjyE+crIMqMFF83NPcwv1hfr2J7hswqRsS2n2tjp0+sIktPCebOtTA0OvH6MNMjXyCt
 TaKYfzuLZYbV98PJrmNX+MUDSj/EdGo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-IxDPyPcBNIu6om6Y75JQ5g-1; Mon, 07 Oct 2024 15:05:09 -0400
X-MC-Unique: IxDPyPcBNIu6om6Y75JQ5g-1
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6cb4180fab6so104779326d6.0
 for <qemu-devel@nongnu.org>; Mon, 07 Oct 2024 12:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728327909; x=1728932709;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U67EA8NaJuuHzXugmhL5eeCsPAbntIMrbUsfZ282OfQ=;
 b=RvFuKgyD34H6uUOqOnoiqna9ooWfUfwyJDF76AYiky9/Mim+6VhNgx38hQdxbNs73z
 1fNRygEw46F1+X1wcp2a6dcFkaENeLeXoHxcUHMoAabKt0R0+X+0U9CWxXbVDQAEQxC7
 O/lK13CtpmggHD+iu4fIlGtGc8kGY3tUg0+9cNczr4CzyOHzY3CmvwpGfblddoeSyTps
 7jOPjZ1wXRKBmPVqqbJZgvyWM91xhFxpNnRISkIapMToPI/GkYOxMquufjdCtAbfTcjn
 cQjF2KG8lc+MU07axvBhqhH9sCy38yQj3KRwiu9f8Y7wpHCqL9FARhZDCDONr7MbNYwi
 LA7w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWNpRlZfzqLAS+SrqjNrHEohEdBrxniKygni2utczODqWBtYoI7hM9I14S/CH0NBbXnQpop0RRrTyfO@nongnu.org
X-Gm-Message-State: AOJu0YwS5Xc7tYZGto3FMXaVfB+hFIOhwTtXEsgmmitl7LIGrwHIFiUX
 CRWWbErJTCCwUl5kXnhX588rKaFYNeOWV01PY0lKpZUHJ6u7TdBS49joDMHHHWSaF2XJv9k0Ig4
 tbFQUeiZHMmZJS6SwjT10fXxC0VvPIzey+iXXM88tLX3ULvIlhBG4
X-Received: by 2002:a05:6214:4b04:b0:6c5:1fe5:f84c with SMTP id
 6a1803df08f44-6cb9a308cbemr208515386d6.20.1728327909272; 
 Mon, 07 Oct 2024 12:05:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJHyEbNOoCHdGTPR7TFFUaE837R7Q/qtihVmMC2FT6w12vYT13E5pyCPEFVWKJOBE4UJkVGQ==
X-Received: by 2002:a05:6214:4b04:b0:6c5:1fe5:f84c with SMTP id
 6a1803df08f44-6cb9a308cbemr208515046d6.20.1728327908897; 
 Mon, 07 Oct 2024 12:05:08 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6cba475efcdsm28254736d6.116.2024.10.07.12.05.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Oct 2024 12:05:07 -0700 (PDT)
Date: Mon, 7 Oct 2024 15:05:04 -0400
From: Peter Xu <peterx@redhat.com>
To: David Hildenbrand <david@redhat.com>
Cc: Steve Sistare <steven.sistare@oracle.com>, qemu-devel@nongnu.org,
 Fabiano Rosas <farosas@suse.de>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Igor Mammedov <imammedo@redhat.com>
Subject: Re: [PATCH V2 01/13] machine: alloc-anon option
Message-ID: <ZwQw4P43IhoEIe66@x1n>
References: <1727725244-105198-1-git-send-email-steven.sistare@oracle.com>
 <1727725244-105198-2-git-send-email-steven.sistare@oracle.com>
 <Zv7C7MeVP2X8bEJU@x1n>
 <2143f803-439e-4b8b-ae92-07caa913d646@redhat.com>
 <Zv_ghrH6i4QOzne8@x1n>
 <bffa3dc0-36b7-4fa1-a0b6-cce34743a46c@redhat.com>
 <Zv_spkFwqwgxGkNY@x1n>
 <47ba3f75-147d-4ea6-a576-eba6ef168643@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <47ba3f75-147d-4ea6-a576-eba6ef168643@redhat.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.153,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Mon, Oct 07, 2024 at 06:23:26PM +0200, David Hildenbrand wrote:
> > Yes I thought it could be unconditionally.  We can discuss downside below,
> > I think we can still use a new flag otherwise, but the idea would be the
> > same, where I want the flag to be explicit in the callers not implicitly
> > with the object type check, which I think can be hackish.
> 
> I agree that the caller should specify it.
> 
> But I don't think using shared memory where shared memory is not warranted
> is a reasonable approach.
> 
> I'm quite surprise you're considering such changes with unclear impacts on
> other OSes besides Linux (Freedbsd? Windows that doeasn';t even support
> shared memory?) just to make one corner-case QEMU use case happy.
> 
> But I'm sure there are valid reasons why you had that idea, so I'm happy to
> learn why using shared memory unconditionally here is better than providing
> a clean alternative path with the feature enabled and memfd actually being
> supported on the setup (e.g., newer Linux kernel).

I was thinking whether cpr-transfer can be enabled by default, so whenever
people want to use it, no code reset needed.  It's also easier for Libvirt
to not need to add yet another machine flags if possible.

Currently this parameter is the only one left that needs to be manually
enabled on src.  It means if we can get rid of it then any QEMU based VM on
Linux can do a cpr-transfer any time as long as QEMU supports it.

Without it, this new parameter will need to be manually enabled otherwise
another system code reboot / live migration needs to happen first without
CPR, just to enable this flag.

But yeah I don't think I think it all through, so I left my pure question.
I think it looks still like an option, the other option if we still want to
enable it by default is, keep the option, then only enable it on new
machines that is based on Linux.

OS dependency is definitely an issue.  AFAICT CPR is only available for
Linux anyway, but I'm happy to be corrected..  IOW, those chunk of new code
(if only unconditionally done..) would need proper #ifdef, so that
non-Linux OSes work like before.

> 
> > 
> > > 
> > > > 
> > > > > 
> > > > > > 
> > > > > > I think RAM_SHARED can actually be that flag already - I mean, in all paths
> > > > > > that we may create anon mem (but not memory-backend-* objects), is it
> > > > > > always safe we always switch to RAM_SHARED from anon?
> > > > > 
> > > > > Do you mean only setting the flag (-> anonymous shmem) or switching also to
> > > > > memfd, which is a bigger change?
> > > > 
> > > > Switching to memfd.  I thought anon shmem (mmap(MAP_SHARED)) is mostly the
> > > > same internally, if we create memfd then mmap(MAP_SHARED) on top of it, no?
> > > 
> > > Memfd is Linux specific, keep that in mind. Apart from that there shouldn't
> > > be much difference between anon shmem and memfd (there are memory commit
> > > differences, though).
> > 
> > Could you elaborate the memory commit difference and what does that imply
> > to QEMU's usage?
> 
> Note how memfd code passed VM_NORESERVE to shmem_file_setup() and
> shmem_zero_setup() effectively doesn't (unless MAP_NORESERVE was specified
> IIRC).
> 
> Not sure if the change makes a big impact in QEMU's usage, it's just one of
> these differences between memfd and shared anonymous memory. (responding to
> your "mostly the same").

So yeah, I hoped the memory commit won't be a problem, because I think they
should be corner case MRs, and should be small.

Vram can take up to 16MB, that's the max I'm aware of, but indeed I don't
know all the use cases to be sure.  I think it means some tens of MBs can
be accounted later during fault rather than upfront to fail QEMU from boot.
Ideally mgmt apps should leave enough space for these ones, but if we worry
on that we can stick with the current option (but create a new flag besides
RAM_SHARED).

> 
> > 
> > > 
> > > Of course, there is a difference between anon memory and shmem, for example
> > > regarding what viritofsd faced (e.g., KSM) recently.
> > 
> > The four paths shouldn't be KSM target, AFAICT.
> 
> Do you have a good overview of what is deduplicated in practice and why
> these don't apply? For example, I thought these functions are also used for
> hosting the BIOS, and that might just be deduplciated between VMs?

I was thinking KSM was for merging OS/App pages (rather than BIOSs, which
are normally very, very small)?  Though I could be wrong.

> 
> Anyhow, there are obviously other differences with shmem vs. anonymous (THP
> handling, page fault performance, userfaultfd compatibility on older
> kernels) at least on Linux, but I have absolutely no clue how that would
> differ on other host OSes.
> 
> None of them are major
> 
> This is probably going to result in a bigger discussion, for which I don't
> have any time. So my opinion on it is above.
> 
> Anyhow, this sounds like one of the suggestions I wouldn't suggest Steve to
> actually implement.

We don't need to make it a bigger discussion.  If there's concern with it,
we can stick with a new flag.

The next question is whether if with a new flag we should enable it by
default sometimes (e.g. on new machine types on Linux).  But when with a
new option, that can be discussed later.

Thanks,

-- 
Peter Xu


