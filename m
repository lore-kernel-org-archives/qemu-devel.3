Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57507C3DA61
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jul 2024 17:01:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYTkC-0007fe-JW; Mon, 29 Jul 2024 13:01:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sYTjw-0007b6-HW
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:00:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sYTju-00035x-BL
 for qemu-devel@nongnu.org; Mon, 29 Jul 2024 13:00:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722272448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vK/FLUt8TzOofA2NIZSDYFwyhB+rQh4W7YEkbrr6xTE=;
 b=PvG93uBkpsQuTC0T/UvsiLw7QDMM8+CHn3wRWb8hnJo3o70gFTcFexvtmGKLaGhmM+zHww
 Kvb+yWkV4TtsidIwqLPaSxc4BMWaybBfPy6/iedKzAfLQ70+Dv2ErYOiV5htGNo9Ktopmt
 JZ76x4vSyx/0UiwHm59keitj2oQ5zmM=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-543-hKgpSgxeP7edtITsXs_8QQ-1; Mon, 29 Jul 2024 13:00:45 -0400
X-MC-Unique: hKgpSgxeP7edtITsXs_8QQ-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-44ff585970bso7388291cf.2
 for <qemu-devel@nongnu.org>; Mon, 29 Jul 2024 10:00:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722272445; x=1722877245;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vK/FLUt8TzOofA2NIZSDYFwyhB+rQh4W7YEkbrr6xTE=;
 b=jSlWoi69IUSpTT70OC8VJeYTo8aEJ9DDLFKtS9k2ayQnHptTZ8XB2I4MBOCjLQVH8z
 bcllDAc7SO7O+IIV6hKKfMdoxSyzr9vF1rFqC11x21/Ko/+e/XMRddH8qRAct/SyLRB2
 Det4zXQxtZKCCvf2tvQDy8XtdOzoLLJ8pDJ5KzoCji81YujBMM2tXScPXvawlsAtUV+u
 Tw2XPXkIPturdIauHvxmV64hspdfXYKQsXZ3W29eMDVbG0i9EDbtdoSUmf+TMer0DaIh
 oJlV2XKmmWfD79OoAcwCR+jwTv0CN1yKrn7TuoK0tDj6uIGksbLsJuu+y7mHu7czT2kw
 xavg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0EZUkjG0hXBDPslteYiPaAfIjR1gZgMbzPVyTakQSoTG+Q26N8szQO5wYthMH/1BmaBxxvK/+IxfooCOyUEROiOpECMw=
X-Gm-Message-State: AOJu0Ywox8e0Z1UJoqhsmmNF/ZfzLLTfHivJ2vMdHreJ8gIauVUaYYeo
 vTwzzl7VVN7+4DuxMwWJ7I6t+y31dY/OyyP5KDEsU2UVv2TG/nIrh2n+gsjP40XrL9xS+78ZDfx
 G9Y54tj9h56jAOI7ia3bcgR4OkDwb8senMw/BQVsnFIGzIyRHcOFp
X-Received: by 2002:ac8:7c50:0:b0:450:27cb:13f9 with SMTP id
 d75a77b69052e-45027cb17a1mr21709291cf.5.1722272444285; 
 Mon, 29 Jul 2024 10:00:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYkbEpdkZ9xBOIQYulrstXBBLrgVrwqYHCoreaBPj4mX+DCMM5Jq9Z5Ra3ISR7/A89mkGhOw==
X-Received: by 2002:ac8:7c50:0:b0:450:27cb:13f9 with SMTP id
 d75a77b69052e-45027cb17a1mr21709031cf.5.1722272443736; 
 Mon, 29 Jul 2024 10:00:43 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-44fe81265e9sm43359511cf.15.2024.07.29.10.00.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jul 2024 10:00:43 -0700 (PDT)
Date: Mon, 29 Jul 2024 13:00:30 -0400
From: Peter Xu <peterx@redhat.com>
To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 akihiko.odaki@daynix.com, jasowang@redhat.com,
 sriram.yagnaraman@est.tech, sw@weilnetz.de, qemu-devel@nongnu.org,
 yan@daynix.com, Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <ZqfKrtQSSRVnEOGt@x1n>
References: <20230731223148.1002258-1-yuri.benditovich@daynix.com>
 <20230731223148.1002258-5-yuri.benditovich@daynix.com>
 <ZqLPLBnbfD5r6z7D@x1n>
 <20240726020656-mutt-send-email-mst@kernel.org>
 <775ff713-f7d3-4fdc-8ba0-4ebde577040d@redhat.com>
 <ZqNiwmy29dxdyMA0@redhat.com> <ZqO2HvFJ8v7hZFOd@x1n>
 <ZqO7cR-UiGpX2rk0@redhat.com> <ZqQLbGxEW3XT7qL-@x1n>
 <Zqe8C9AfaojKHM8A@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Zqe8C9AfaojKHM8A@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Jul 29, 2024 at 04:58:03PM +0100, Daniel P. Berrangé wrote:
> On Fri, Jul 26, 2024 at 04:47:40PM -0400, Peter Xu wrote:
> > On Fri, Jul 26, 2024 at 04:17:12PM +0100, Daniel P. Berrangé wrote:
> > > 
> > > In terms of launching QEMU I'd imagine:
> > > 
> > >   $QEMU -machine pc-q35-9.1 -platform linux-6.9 ...args...
> > > 
> > > Any virtual machine HW features which are tied to host kernel features
> > > would have their defaults set based on the requested -platform. The
> > > -machine will be fully invariant wrt the host kernel.
> > > 
> > > You would have -platform hlep to list available platforms, and
> > > corresonding QMP "query-platforms" command to list what platforms
> > > are supported on a given host OS.
> > > 
> > > Downstream distros can provide their own platforms definitions
> > > (eg "linux-rhel-9.5") if they have kernels whose feature set
> > > diverges from upstream due to backports.
> > > 
> > > Mgmt apps won't need to be taught about every single little QEMU
> > > setting whose default is derived from the kernel. Individual
> > > defaults are opaque and controlled by the requested platform.
> > > 
> > > Live migration has clearly defined semantics, and mgmt app can
> > > use query-platforms to validate two hosts are compatible.
> > > 
> > > Omitting -platform should pick the very latest platform that is
> > > cmpatible with the current host (not neccessarily the latest
> > > platform built-in to QEMU).
> > 
> > This seems to add one more layer to maintain, and so far I don't know
> > whether it's a must.
> > 
> > To put it simple, can we simply rely on qemu cmdline as "the guest ABI"?  I
> > thought it was mostly the case already, except some extremely rare
> > outliers.
> > 
> > When we have one host that boots up a VM using:
> > 
> >   $QEMU1 $cmdline
> > 
> > Then another host boots up:
> > 
> >   $QEMU2 $cmdline -incoming XXX
> > 
> > Then migration should succeed if $cmdline is exactly the same, and the VM
> > can boot up all fine without errors on both sides.
> > 
> > AFAICT this has nothing to do with what kernel is underneath, even not
> > Linux?  I think either QEMU1 / QEMU2 has the option to fail.  But if it
> > didn't, I thought the ABI should be guaranteed.
> 
> We've got two mutually conflicting goals with the machine type
> definitions.
> 
> Primarily we use them to ensure stable ABI, but an important
> secondary goal is to enable new tunables to have new defaults
> set, without having to update every mgmt app.  The latter
> works very well when the defaults have no dependancy on the
> platform kernel/OS, but breaks migration when they do have a
> platform dependancy.
> 
> >   - Firstly, never quietly flipping any bit that affects the ABI...
> > 
> >   - Have a default value of off, then QEMU will always allow the VM to boot
> >     by default, while advanced users can opt-in on new features.  We can't
> >     make this ON by default otherwise some VMs can already fail to boot,
> > 
> >   - If the host doesn't support the feature while the cmdline enabled it,
> >     it needs to fail QEMU boot rather than flipping, so that it says "hey,
> >     this host does not support running such VM specified, due to XXX
> >     feature missing".
> > 
> > That's the only way an user could understand what happened, and IMHO that's
> > a clean way that we stick with QEMU cmdline on defining the guest ABI,
> > while in which the machine type is the fundation of such definition, as the
> > machine type can decides many of the rest compat properties.  And that's
> > the whole point of the compat properties too (to make sure the guest ABI is
> > stable).
> > 
> > If kernel breaks it easily, all compat property things that we maintain can
> > already stop making sense in general, because it didn't define the whole
> > guest ABI..
> > 
> > So AFAIU that's really what we used for years, I hope I didn't overlook
> > somehting.  And maybe we don't yet need the "-platform" layer if we can
> > keep up with this rule?
> 
> We've failed at this for years wrt enabling use of new defaults that have
> a platform depedancy, so historical practice isn't a good reference.
> 
> There are 100's (possibly 1000's) of tunables set implicitly as part of
> the machine type, and of those, libvirt likely only exposes a few 10's
> of tunables. The vast majority are low level details that no mgmt app
> wants to know about, they just want to accept QEMU's new defaults,
> while preserving machine ABI. This is a good thing. No one wants the
> burden of wiring up every single tunable into libvirt and mgmt apps.
> 
> This is what the "-platform" concept would be intended to preserve. It
> would allow a way to enable groups of settings that have a platform level
> dependancy, without ever having to teach either libvirt or the mgmt apps
> about the individual tunables.

Do you think we can achieve similar goal by simply turning the feature to
ON only after a few QEMU releases?  I also mentioned that idea below.

https://lore.kernel.org/r/ZqQNKZ9_OPhDq2AK@x1n

So far it really sounds like the right thing to do to me to fix all similar
issues, even without introducing anything new we need to maintain.

To put that again, what we need to do is this:

  - To start: we should NEVER turn any guest ABI relevant bits
    automatically by QEMU, for sure..

  - When introducing any new device feature that may both (1) affects guest
    ABI, and (2) depends on host kernel features, we set those default
    values to OFF always at start. So this already covers old machine
    types, no compat property needed so far.

  - We always fail hard on QEMU boot whenever we detected such property is
    not supported by the current host when with ON (and since it's OFF by
    default it must be that the user specified that ON).

  - When after a stablized period of time for that new feature to land most
    kernels (we may consider to look at how major Linux distros updates the
    kernel versions) when we're pretty sure the new feature should be
    available on most of the QEMU modern users, we add a patch to make the
    property default ON on the new machine type, add a compat property for
    old machines.

The last bullet also means we'll start to fail new machine type from
booting when running that very new QEMU on a very old kernel, but that's
the trade-off, and when doing it right on "stablizing the feature in the
kernel world", it should really be corner case.  The user should simply
invoke an old machine type on that old kernel, even if the qemu is new.

Thanks,

-- 
Peter Xu


