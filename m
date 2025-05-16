Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBF8DC3ABD8
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 14:54:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFwRu-0005AJ-OW; Fri, 16 May 2025 10:54:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uFwRt-00059n-2C
 for qemu-devel@nongnu.org; Fri, 16 May 2025 10:54:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uFwRq-0003F0-UX
 for qemu-devel@nongnu.org; Fri, 16 May 2025 10:54:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747407244;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mhL4M1DL+slHMHwv4/atMMjOMG+rjaqrrjB7lLD0hhM=;
 b=HQz5LxkOHjVR2vHOziKbT+nIFIRMGOm9eK5sDaIojT5w+99ox/Jn1y1BKsc6pi6eJCBO9D
 2XZyFQodo2A+5kpUtuvqCmQEfskwr/kIBSLz/Doi5cBB/SBFN1wliH9Pr0yVqyvA3f9mzo
 tGj9pNIumBMFmJODQPkPOCFFhAmgE74=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-RAN2kkTZNaewVEEqsoRW7A-1; Fri, 16 May 2025 10:54:02 -0400
X-MC-Unique: RAN2kkTZNaewVEEqsoRW7A-1
X-Mimecast-MFC-AGG-ID: RAN2kkTZNaewVEEqsoRW7A_1747407242
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6f6ee43c4a6so59912976d6.0
 for <qemu-devel@nongnu.org>; Fri, 16 May 2025 07:54:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747407242; x=1748012042;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mhL4M1DL+slHMHwv4/atMMjOMG+rjaqrrjB7lLD0hhM=;
 b=nzhg9dyIpur91O1FHvr76B6CkYymKL8PCGmVTA9m6yP2P7aiEJUTh8+skPi7i8peoJ
 rxUvbAHZgvOTpkTvnY8caAvC465F9u8+SCXRCjKFYXyO9rVrWncCeXbSIBfHJo5kh7Hr
 NsircA3Dx0iV73k71ZZe6/R+IfyqKEyvE74z3mMM6IO5vv85fVEDcs18mW/rIJVuCYRg
 8f87Ut+60Yg44ekAJ/ddwF9KYfeq+eRydeATXzY0F+EChm582uhg7/ueGj00joTLM2sG
 I8HuiYBJ5pb0fy8fdToc9HWTXt1oquzkFdvN3uQ1tDJrgPeoGgtb2GMHZXB2X0LHHN4C
 Oasg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVm8Jt4SI1/3S+fCYvzfSRZhFMCwZhJJF23QNqhyWo0pcICYtw39nb5NdGrXnzpX18GP4EvIhlrkllO@nongnu.org
X-Gm-Message-State: AOJu0YxA6WyFbfmWU1GA6zAl36iUy9+MogfvVT34L2sGO8uKXtTpykxx
 JPuQyQckC59vdO73XZA4Zhm/HSp2K68Bkf5KG0/YBdU8QkNu4gJ7u33ODxci7Migw9Kopzoh1K8
 zLEt/Bh6TByTtVkB1kIsPPMWfEPjLyCsnwCpfTyt4qW8GI81er3pP3Qev
X-Gm-Gg: ASbGncuBJ8UPj9SR/2AvzWfeMEwEV9o47yxeVEZ7yAaDPvxmCDrtSssEv00MXoVAhc1
 +67FJLruA4uB0qORNQfIuAml4Lhk7IPTvxoza9RTGDh09qi/UNYpQwC+0DBJNv5gfoGsitPRGrM
 S89wd75yWCw95zXrXA0svDiJoDPVMvJA116DLDUpaEo5kRIqu9D+L/RBDpBh2/H/9T2Xj82aMGE
 R/huCmidJ9Cjby9oANiCpeTOTPXA7LwQVE2K/FO5Lsq4ADAnN9XVPw+Q2AP3MO4V4vzeNmcPRcc
 Zno=
X-Received: by 2002:a05:622a:5c0a:b0:494:a0bf:e0a6 with SMTP id
 d75a77b69052e-494b07b7d88mr49565911cf.23.1747407241644; 
 Fri, 16 May 2025 07:54:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs9UiPR5NCFsulUmJ7KycI/kkhdOor93GpTA1Q8pcXcPWzLmW0VXWLSLM6ufFAePx1efLZiA==
X-Received: by 2002:a05:622a:5c0a:b0:494:a0bf:e0a6 with SMTP id
 d75a77b69052e-494b07b7d88mr49565541cf.23.1747407241260; 
 Fri, 16 May 2025 07:54:01 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-494ae4fd816sm11922081cf.50.2025.05.16.07.54.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 May 2025 07:54:00 -0700 (PDT)
Date: Fri, 16 May 2025 10:53:58 -0400
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, qemu-devel@nongnu.org,
 devel@daynix.com,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH v3 01/10] futex: Check value after qemu_futex_wait()
Message-ID: <aCdRho2SCZHOlsn_@x1.local>
References: <20250511-event-v3-0-f7f69247d303@daynix.com>
 <20250511-event-v3-1-f7f69247d303@daynix.com>
 <aCNZk73GuEaU-gcK@x1.local>
 <b1b6574c-1ddb-4129-8a68-fe88f93caecd@daynix.com>
 <aCTNkxN9HMJ5FvR-@x1.local>
 <271a1379-0347-4858-9602-c561bbc8aeaf@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <271a1379-0347-4858-9602-c561bbc8aeaf@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.686,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, May 16, 2025 at 02:34:33PM +0900, Akihiko Odaki wrote:
> On 2025/05/15 2:06, Peter Xu wrote:
> > On Wed, May 14, 2025 at 04:34:33PM +0900, Akihiko Odaki wrote:
> > > On 2025/05/13 23:39, 'Peter Xu' via devel wrote:
> > > > On Sun, May 11, 2025 at 03:08:18PM +0900, Akihiko Odaki wrote:
> > > > > futex(2) - Linux manual page
> > > > > https://man7.org/linux/man-pages/man2/futex.2.html
> > > > > > Note that a wake-up can also be caused by common futex usage patterns
> > > > > > in unrelated code that happened to have previously used the futex
> > > > > > word's memory location (e.g., typical futex-based implementations of
> > > > > > Pthreads mutexes can cause this under some conditions).  Therefore,
> > > > > > callers should always conservatively assume that a return value of 0
> > > > > > can mean a spurious wake-up, and use the futex word's value (i.e.,
> > > > > > the user-space synchronization scheme) to decide whether to continue
> > > > > > to block or not.
> > > > 
> > > > I'm just curious - do you know when this will happen?
> > > > 
> > > > AFAIU, QEMU uses futex always on private mappings, internally futex does
> > > > use (mm, HVA) tuple to index a futex, afaict.  Hence, I don't see how it
> > > > can get spurious wakeups..  And _if_ it happens, since mm pointer can't
> > > > change it must mean the HVA of the futex word is reused, it sounds like an
> > > > UAF user bug to me instead.
> > 
> > [1]
> > 
> > > > 
> > > > I checked the man-pages git repo, this line was introduced in:
> > > > 
> > > > https://github.com/mkerrisk/man-pages/commit/4b35dc5dabcf356ce6dcb1f949f7b00e76c7587d
> > > > 
> > > > I also didn't see details yet in commit message on why that paragraph was
> > > > added.
> > > > 
> > > > And..
> > > > 
> > > > > 
> > > > > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > > > > ---
> > > > >    include/qemu/futex.h              |  9 +++++++++
> > > > >    tests/unit/test-aio-multithread.c |  4 +++-
> > > > >    util/qemu-thread-posix.c          | 28 ++++++++++++++++------------
> > > > >    3 files changed, 28 insertions(+), 13 deletions(-)
> > > > > 
> > > > > diff --git a/include/qemu/futex.h b/include/qemu/futex.h
> > > > > index 91ae88966e12..f57774005330 100644
> > > > > --- a/include/qemu/futex.h
> > > > > +++ b/include/qemu/futex.h
> > > > > @@ -24,6 +24,15 @@ static inline void qemu_futex_wake(void *f, int n)
> > > > >        qemu_futex(f, FUTEX_WAKE, n, NULL, NULL, 0);
> > > > >    }
> > > > > +/*
> > > > > + * Note that a wake-up can also be caused by common futex usage patterns in
> > > > > + * unrelated code that happened to have previously used the futex word's
> > > > > + * memory location (e.g., typical futex-based implementations of Pthreads
> > > > > + * mutexes can cause this under some conditions).  Therefore, callers should
> > > > 
> > > > .. another thing that was unclear to me is, here it's mentioning "typical
> > > > futex-based implementations of pthreads mutexes..", but here
> > > > qemu_futex_wait() is using raw futex without any pthread impl.  Does it
> > > > also mean that this may not be applicable to whatever might cause a
> > > > spurious wakeup?
> > > 
> > > No. The man-page mentions "unrelated code that happened to have previously
> > > used the futex word's memory location", so it doesn't matter whether we use
> > > pthread here.
> > > 
> > > libpthread and even this QemuEvent follows the "common futex usage" so we
> > > should do what is written in the man page.
> > > 
> > > Unfortunately the man page does not describe the "common futex usage
> > > pattern". It looks like as follows:
> > > 
> > > Assume there are two threads, one atomic variable, and one futex.
> > > 
> > > Thread A does the following:
> > > A1. Read the atomic variable.
> > > A2. Go A5 if the atomic variable is zero.
> > > A3. Wait using the futex.
> > > A4. Go A1.
> > > A5. Free the atomic variable and the futex.
> > > 
> > > Thread B does the following:
> > > B1. Set the atomic variable to zero.
> > > B2. Wake up using the futex.
> > > 
> > > In this example, the execution may happen in the following order:
> > > B1 -> A1 -> A2 -> A5 -> B2
> > > 
> > > Here, B2 will cause a spurious wake up of QemuEvent if the freed memory gets
> > > reused for QemuEvent.
> > 
> > This is true.
> > 
> > Said that, if to follow my previous statement at [1] above, here I think A5
> > is the UAF bug I mentioned, trying to free the lock object with existing
> > user (Thread B) accessing the object.
> > 
> > IMHO, the userapp should make sure the object will never be freed if
> > there's any possible user of it, and that includes a waker like Thread B.
> > 
> > For futex, the futex word (which is the important bit here relevant to
> > possible spurious wakeups) is part of the lock object, hence if the lock
> > object isn't freed too early it won't ever get reused, and then there
> > should have no chance of spurious wakeups in the futex context.
> 
> It is a UAF, but it is by design and not a bug.
> 
> The principle of the futex design is to use atomic memory operations to
> manage the state instead of using a system call, which is more expensive.
> 
> This principle motivates tolerating spurious wakeups. If wakeup system calls
> after free are forbidden, a thread will need to use a (expensive) system
> call to ensure the wake up actually happened before freeing. Instead, we can
> tolerate spurious wakeups without causing a buggy behavior by making the
> waiting thread perform (cheaper) atomic memory reads to verify the expected
> state.

Right, that's also my understanding that it's by design for futex from
kernel POV.

Which I am not yet sure is whether it's by design to be used in userapp so
that a spurious wakeup could happen.  From which regard, I still think
maybe we shouldn't have that paragraph in the man page at all, at least it
can be clearer when put into man pages.

So now the question is, do we have such use case so that QEMU needs to free
a qemu_futex_*() API based lock _before_ any wakeups?

QEMU only has two locks impled on top of direct futex, which is QemuEvent
and QemuLockCnt.  From what I can tell on how they're used (not a lot),
none of them will use such as a feature, so IIUC it means QEMU still should
be free from such UAF issue, and it's definitely not a feature either.
Hence if any spurious wakeup happened in QEMU, it's a real bug.

From that POV, IMHO it would make more sense if we allow spurious wakeup
iff it's proved to be necessary (e.g. when QEMU wants to make it a feature
not a bug), and also I worry we're copying the man page content all over
into QEMU tree but just in case it's inaccurate to be applied to QEMU's
context at all.

Thanks,

-- 
Peter Xu


