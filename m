Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 179F4606A323
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 16:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XRXmdUIk;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=G2Kcr4S5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWFOz-00078f-8p; Wed, 25 Nov 2026 10:59:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWFOx-00078Q-Dy
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 10:59:19 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1xWFOv-0006st-HS
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 10:59:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1795622355;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wVu+gnBKoLHdf9Shc3LPYPJfPZkS/enNHfQP8Cdhdg8=;
 b=XRXmdUIkBIFZZudqWrYFQ/aXu52E8DnWn96c7/dhaONZnvBGVAe/dUXd4yivCVkP4I5ALk
 +RWBEZJIVuY5ZAXYHqSvgfjMTRd8Ig4E/OdUM8hM+HcRrk6obJoTsVtm35umfEi0W1b8YI
 v4AoOiYre0jr+wnABqM6Fxia3DsNl80=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-nJ_gQTnaOPOPkxgCkxMYvg-1; Wed, 25 Nov 2026 15:59:11 +0000
X-MC-Unique: nJ_gQTnaOPOPkxgCkxMYvg-1
X-Mimecast-MFC-AGG-ID: nJ_gQTnaOPOPkxgCkxMYvg_1795622350
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-94961511b61so974784985a.3
 for <qemu-devel@nongnu.org>; Wed, 25 Nov 2026 07:59:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1795622349; x=1796227149; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=wVu+gnBKoLHdf9Shc3LPYPJfPZkS/enNHfQP8Cdhdg8=;
 b=G2Kcr4S5nPDkurTrx0exBG32qH5kPSBCdXu8tC6ovSGmWzcE00qyxEyRE5erpMlFzX
 Q7n+0rB5/sTbPgAW8spLVcjCFiQk+UXCsWHZK87HHz4B/3cbMFRn5E/fZGPsBUNxdVLl
 IHzYWfVVxOdCP2awQnL5QJzQMjDx3Nh7tHl88IKau2zAQ/RorrfYWKO8Y6rdSbnWpLK2
 TiOCr3t8AmQ/RERBQioS/t4ZhGEqwLbMCe09pk8/J4GpisrnSM+KOBMCai+9/hN+Ny8F
 HdCkSexUjeFyu6xrBRSgmfnQPYNLJPhB7DL5ROWxHxKF2pU0eYQquJpcNNy0/x00ZmXE
 b9Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795622349; x=1796227149;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=wVu+gnBKoLHdf9Shc3LPYPJfPZkS/enNHfQP8Cdhdg8=;
 b=f1bbJ36XFGUaSgEZPsx3toITgxiSclL+BmHISnPCTYDE779Kd2qmXAYhfN1Q0yVdpB
 ygovb96HXVBQO5g55thoV6DdI4jOOrGG39tIS5ZMcyCVoLFR9KyZwK0RmCfeN5Q/aPrL
 4S/2/f1QjkFVlgTNAcw0Gxxchx3mJFJMla8jNschKzXC5m+oynpxr5zDBjfgmUIiZgH5
 8UTLIMAgdcvmMrIYTLAfSwSpSUdrrPI1E5P8uIJNZq5yMx3xDRu5aiYMK0/i7flZ5XxE
 v89RWsZe9ENq09m5tczSz3v8xvWTSEobUNQ/MHShLmqee7B2gkK26Z0KhPbk4hYaPqZ2
 JOIg==
X-Forwarded-Encrypted: i=1;
 AL+hErGXWYGXhWZ6slwjETw1+j+rFyNRkh3tjyWZDX+A5YZxphkiiCEXW8qrx1U/S+W7NLsK15uRc4iU2yX2@nongnu.org
X-Gm-Message-State: APuU4Z+WFl+Mau7gtHypH7QKvMSqbdE7pEaZCH2WdJeRkii+azBD9Mpo
 S+z/330rR4sz8H3QIlJclWmRcetTf1qsOZRmVcI91fgFvIR9Y2tfjPEMhtKPQP/Seq89eFWVTcG
 5kWXdH9mHB83jVm5mst5GE+NYRWJ+BW4CdmPNXvRlTR34G60hEkRw7/MS
X-Gm-Gg: AZFdTZdBWKQzbhWCkkmFuPKiTlnXs64GODnx4dnW7SvEkoM8Q01Vkn6ij7cipsn2yNz
 olbXjK7L88OLUdZbaJY9jNrYN/51UUAG5o6zZzjtcnoCMF8rSy8/oGML7fZv+dUyqnLCcuK77Tk
 Ku5tLvITCByrUV4lNJQ++tlbQXF+MTIG3ZcNY9GPDdIOh0VxGwzDMtBig1fXQZvNvVEN36r1HyA
 sTfyeGXh0sHcdWlpD3qStMylgpqW/KROnGRkefiovUehHC6PM7UCr/yHRb7TzgLvyhSytUX4SNe
 ZU8wu2yxh/7o5HgYJ6giXTr5zfhdKTpAIQpNPEmykg7I75Vs45VoJkPzpm+/XX1ZAJ56hMsXk3W
 qwLzYcP5218/P+ux1vgo7EdcnrZVGECrA+CD5krgja69F
X-Received: by 2002:a05:620a:a7dd:10b0:949:cb81:38b8 with SMTP id
 af79cd13be357-949cb813bb2mr1997031385a.13.1795622349494; 
 Wed, 25 Nov 2026 07:59:09 -0800 (PST)
X-Received: by 2002:a05:620a:a7dd:10b0:949:cb81:38b8 with SMTP id
 af79cd13be357-949cb813bb2mr1997025585a.13.1795622348927; 
 Wed, 25 Nov 2026 07:59:08 -0800 (PST)
Received: from localhost ([142.188.212.246]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-949bb418241sm1323508285a.38.2026.11.25.07.59.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Nov 2026 07:59:08 -0800 (PST)
Date: Wed, 25 Nov 2026 10:59:07 -0500
From: Peter Xu <peterx@redhat.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>
Subject: Re: memory_region_init_ram_ptr() handling of sizes that are less
 than a page
Message-ID: <awcFy1y-_KEvnMgn@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <CAFEAcA_77DxGK-26Z6=qx0a88Zd0KQgFjKgJc2CgTmm-iOzbsg@mail.gmail.com>
 <CAFEAcA-o9DoPL1D0-S3hpB1bT6iSNgy4zm1VZRSjcjxHkmUfiQ@mail.gmail.com>
 <awW88uEaJ2IKp-nY@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAFEAcA-PB-tPvdXc6ZMMhanN0fPi9uvGQ=XtM0h2+uxt-JnrSg@mail.gmail.com>
 <awXafWB2p8VuG_Qh@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <CAFEAcA8-UQPdJ4na2EXfFff+Nw547nYVDfQcK-pjLr6ykW=ThQ@mail.gmail.com>
 <0e0f553c-6741-4808-a138-bda1d327cba1@linaro.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <0e0f553c-6741-4808-a138-bda1d327cba1@linaro.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Nov 24, 2026 at 01:38:00PM -0800, Richard Henderson wrote:
> On 11/24/26 12:38, Peter Maydell wrote:
> > On Tue, 24 Nov 2026 at 18:42, Peter Xu <peterx@redhat.com> wrote:
> > > 
> > > On Tue, Nov 24, 2026 at 05:37:23PM +0000, Peter Maydell wrote:
> > > > The atmega.c code explicitly calls
> > > >          vmstate_register_ram(&s->sram_io, dev);
> > > > which is why #4877 reports that we crash during migration.
> > > 
> > > Ah...
> > > 
> > > This seems a hack.  I don't see what we benefit from g_malloc0() rather
> > > than using memory_region_init_ram(), it's hand-coding how allocation is
> > > done.  IMO we should switch.
> > 
> > That's what it used to do before commit 9f99072fc08 last year,
> > though. I should check with RTH why it's doing that so we know
> > what we need to test to make sure we avoid breaking something.
> With respect to AVR, there were complications due to a change in
> TARGET_PAGE_SIZE.
> 
> Leading up to 9f99, we allocated ram at a target-page-aligned location. We
> still do that for certain cpu+board configurations (
> 
> After 9f99, we still allocate ram at target-page alignment for certain
> cpu+board configurations (mc->io_size >= TARGET_PAGE_SIZE).  But failing
> that we must allocate ram at a non-target-page aligned address on the same
> page as other I/O.  It's that sharing of the target page which requires
> allocation "device ram" and not regular ram, so that it's all considered
> I/O.  Thus memory_region_init_ram_device_ptr and not any other api flavor.

Hi, Richard, please see the other email I sent almost the same time of
yours:

https://lore.kernel.org/all/awYEDAgvEbeVtrAW@zhexu-thinkpadt14gen5.rmtcaon.csb/

IIUC at least in current master, ram_device is not IO anymore.

Functional-wise, I don't yet see how the current code will change function
if we switch to using memory_region_init_ram() for the region "sram-as-io"
in for atmega_realize(), when mc->io_size < TARGET_PAGE_SIZE.

It should, afaiu, only set ram_device=true, but at least now it doesn't
really mean it's IO.  I also didn't see TCG has special handling of
ram_device=true.

> 
> As for the question that Peter's actually asking: I have no idea why the
> memory subsystem is requiring aligned addresses.  My first suspicion was
> something related to qemu_ram_block_from_host, but that properly handles
> arbitrary addresses.
> 
> My preference is that the APIs don't enforce host pointer alignment, because
> I can't see a good reason for it.

If we're talking about when a pointer passed into QEMU to create a ramblock
attached to the pointer, I also agree I don't see much point on alignment
needs.  But for the generic case, we definitely need VA alignment.

E.g. qemu_anon_ram_alloc() uses 2M alignment for anon, I believe that makes
anon THP start working or it may not really work.  Same requirement for
shmem, but that's currently broken and that (memory-backend-memfd) will
likely be fixed, so we need 2M alignment for memory-backend-memfd ramblocks
too if the user cares about shmem THP.

Thanks,

-- 
Peter Xu


