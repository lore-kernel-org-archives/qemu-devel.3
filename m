Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6D2AC47DDB
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jan 2024 03:04:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rV0ss-0007PL-Md; Tue, 30 Jan 2024 22:03:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rV0sq-0007O2-Ct
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 22:03:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rV0sn-0004rC-Me
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 22:03:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706670204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1AUHlXOFdV1GF0CF2xonLCznzzAjNlaQD2w1Uh9b7HI=;
 b=fn9u4IXiJ+YWt20ma+mWajT55DZXYSq3O6gtk/lhLhqUf+nKn7JziwuS3dAAJPATJWTm5V
 BoaIZETns/LugxtMtzZOjc5/9zNu9lVNFsvQIcRZId2EsjykjhC1Hn1MpvLnXQoq/nPmSE
 /T2GuEtHbHgdN4pmGFJ+7jmt5RJMAus=
Received: from mail-io1-f69.google.com (mail-io1-f69.google.com
 [209.85.166.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-dioXNfy-PxO084qkqI9EjQ-1; Tue, 30 Jan 2024 22:03:21 -0500
X-MC-Unique: dioXNfy-PxO084qkqI9EjQ-1
Received: by mail-io1-f69.google.com with SMTP id
 ca18e2360f4ac-7bff15a8209so59458439f.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jan 2024 19:03:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706670200; x=1707275000;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1AUHlXOFdV1GF0CF2xonLCznzzAjNlaQD2w1Uh9b7HI=;
 b=Ly1+tMueKw3ztuYI6GDs5CiuYif6WtB929IlL28J6AndsbQXl033H0fMH3pU5Xmhns
 dRtpSgfmWbJcnu/SwQh1w9bCmfZOnzVGXoAyFpxudPFxaHiP6T1TZCB/1rtAymIPN0Tv
 EhTpVyrz+Wx9WPld/bStgyGpa3Y9/k3rC16LiWgfZ9X6e2sTX9H+SZT0tg9eMIYl2Rkw
 EpStp6+7j3RB3oPr6J9g7MRZIr2QN5Nc3PQuQlnMz12NT6X52/T9yu2bT20DbC8doHU9
 JTwbUEwJDJ9rDNE9PjixwQVa8k7wQBjfPFwrJdaFFhpI3avXNVQW9ACbF1D5/MnPk/pr
 GCWA==
X-Gm-Message-State: AOJu0Yyp3H1OeCil2+RXKp0doJpw60f3LIdtro8zCa/51zCr3ZoBr7ah
 2Wsws1yEOpwcfLoLdqjd1j+hT0vJSlxXpKhSdPM3Xm1TGPqnfcze4fmhnV3J4wrzXiQX2N3Q8zr
 4QzDkq2yIqWIpwXi6sOWdFKaqweecadfTs50LzLifo/C0HhBMCbHyDyujE3EVndQ=
X-Received: by 2002:a05:6e02:1c8e:b0:363:7bef:a4cd with SMTP id
 w14-20020a056e021c8e00b003637befa4cdmr543659ill.0.1706670200482; 
 Tue, 30 Jan 2024 19:03:20 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFCTCjKhzsbIm1UziVtBHyfUhQvbfzl1Ltua4YZQYMB99CUBz6yY5UCPsaVXha08hhEkyNpwQ==
X-Received: by 2002:a05:6e02:1c8e:b0:363:7bef:a4cd with SMTP id
 w14-20020a056e021c8e00b003637befa4cdmr543643ill.0.1706670200070; 
 Tue, 30 Jan 2024 19:03:20 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 b12-20020a63cf4c000000b005ceac534e47sm9254468pgj.51.2024.01.30.19.03.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jan 2024 19:03:19 -0800 (PST)
Date: Wed, 31 Jan 2024 11:03:13 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: [PATCH] migration/docs: Explain two solutions for VMSD
 compatibility
Message-ID: <Zbm4cYeDCTe3RbBz@x1n>
References: <20240122070600.16681-1-peterx@redhat.com> <87plxtgyxx.fsf@suse.de>
 <Za81vJgTjFSGT56r@x1n> <87frygdzjl.fsf@suse.de>
 <Zbh7zAqS4_9KnATk@x1n> <875xzaditb.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <875xzaditb.fsf@suse.de>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.292,
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

On Tue, Jan 30, 2024 at 10:58:24AM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Mon, Jan 29, 2024 at 10:44:46AM -0300, Fabiano Rosas wrote:
> >> > Since we're at it, I would also like to know how you think about whether we
> >> > should still suggest people using VMSD versioning, as we know that it won't
> >> > work for backward migrations.
> >> >
> >> > My current thoughts is it is still fine, as it's easier to use, and it
> >> > should still be applicable to the cases where a strict migration semantics
> >> > are not required.  However it's hard to justify which device needs that
> >> > strictness.
> >> 
> >> I'd prefer if we kept things strict. However I don't think we can do
> >> that without having enough testing and specially, clear recipes on how
> >> to add compatibility back once it gets lost. Think of that recent thread
> >
> > If it was broken, IMHO we should just fix it and backport to stable.
> 
> (tangent)
> Sure, but I'm talking about how do we instruct device developers on
> fixing migration bugs. We cannot simply yell "regression!" and expect
> people to care.
> 
> Once something breaks there's no easy way to determine what's the right
> fix. It will always involve copying the migration maintainers and some
> back and forth with the device people before we reach an agreement on
> what's even broken.
> 
> When I say "clear recipes" what I mean is we'd have a "catalogue" of
> types of failures that could happen. Those would be both documented in
> plain english and also have some instrumentation in the code to produce
> a clear error/message.
> 
>   E.g.: "Device 'foo' failed to migrate because of error type X: the src
>   machine provided more state than the dst was expecting around the
>   value Y".
> 
> And that "error type X" would come with some docs listing examples of
> other similar errors and what strategies we suggest do deal with them.
> 
> Currently most migration failures are just a completely helpless:
> "blergh, error -5". And the only thing we can say about it upfront is
> "well, something must have changed in the stream".

Yes, IMHO it's because of the current design of VMSD isn't self describing,
then if some VMSD added new fields without boosting the version_id, what
can happen is when the destination reads that new VMSD field added it'll
assume it is the next thing to read, and that can be a completely different
VMSD for another device.  We just don't have anything to describe it.

E.g. for sending an uint32_t field, vmstate_info_uint32 only does
qemu_put_be32s(), we keep pushing data onto the wire without proper
description of that field.

We used to have some attempt describing these fields so it might be easier
at least for debugging, see:

commit 8118f0950fc77cce7873002a5021172dd6e040b5
Author: Alexander Graf <agraf@csgraf.de>
Date:   Thu Jan 22 15:01:39 2015 +0100

    migration: Append JSON description of migration stream

But that seems only for debugging.  E.g., that happens _after_ all vmstate
loaded.  So the reported error could be the same confusing, as when an
error happens it is before the JSON chunk ready.

We may be able to do better in this regard in the future, but that'll take
some thoughts and effort.

> 
> Real migration failures I have seen recently (all fixed already):
> 
> 1- Some feature bit was mistakenly removed from an arm cpu. Migration
>    complains about a 'length' field being different.
> 
> 2- A group of devices was moved from the machine init to the cpu init on
>    pseries. Migration spews some nonsense about an "index".
> 
> 3- Recent (invalid) bug on -cpu max on arm, a couple of bits were set in
>    a register. Migration barfs incomprehensibly with: "error while
>    loading state for instance 0x0 of device 'cpu', Operation not
>    permitted".
> 
> So I bet we could improve these error cases to be a bit more predictable
> and that would help device developers to be able to maintain migration
> compatibility without making it seem like an arbitrary, hard to achieve
> requirement.
> (/tangent)

Right, there can be multiple ways to fail, and we may need to look into
them one by one.  They all take quite some effort.

> 
> >
> > I think Juan used to worry on what happens if someone already used an old
> > version of old release, e.g., someone using 8.2.0 may not be able to
> > migrate to 8.2.1 if we fix that breakage in 9.0 and backport that to 8.2.1.
> > My take is that maybe that's overcomplicated, and maybe we should simply
> > only maintain the latest stable version, rather than all.  In this case,
> > IMHO it will be less burden if we only guarantee 8.2.1 will be working,
> > e.g., when migrating from 8.1.z -> 8.2.1.  Then we should just state a
> > known issue in 8.2.0 that it is broken, and both:
> >
> >   (1) 8.1.z -> 8.2.0, and
> 
> Fair enough.
> 
> >   (2) 8.2.0 -> 8.2.1
> 
> Do you think we may not be able to always ensure that the user can get
> out of the broken version? Or do you simply think that's too much work?

Yes.  Allowing such compatibility means we declare support over all
binaries we released, including buggy ones.  But a bug is a bug, and it can
happen.  Just like QEMU, as one normal piece of software, can crash when
hit a bug, and it can happen to any binary because we can't guarantee it's
bug-free.

It's just too much to me.  It's also hard if not impossible, because I
don't think it always has a solution if the src QEMU is simply broken.
When such happens, we request the user to reboot with a correct version of
QEMU.

> 
> I think I agree with you. It's better to have a clear statement of what
> we support and make sure that works, rather than having _some_ scenarios
> where the user _may_ need to shutdown the VM and _some_ where they _may_
> be able to migrate out of the situation. It creates a confusing message
> that I imagine would just cause people to avoid using migration
> altogether.
> 
> > will expect to fail.
> >
> >> were we discussed an old powerpc issue. How come we can see the fix
> >> today in the code but cannot tell which problem it was trying to solve?
> >> That's bonkers. Ideally every type of breakage would have a mapping into
> >> why it breaks and how to fix it.
> >> 
> >> So with testing to catch the issue early and a clear step-by-step on how
> >> to identify and fix compatibility, then we could require strict
> >> compatibility for every device.
> >
> > I don't think we can guarantee no bug there, but indeed we can do better on
> > providing some test framework for device VMSDs.
> >
> >> 
> >> >
> >> > For example, any device to be used in migration-test must be forward +
> >> > backward migration compatible at least, because you just added the n-1
> >> > regression tests to cover both directions.  Said that, only a few devices
> >> > are involved because currently our migration-test qemu cmdline is pretty
> >> > simple.
> >> 
> >> We might want to make a distinction between migration core vs. device
> >> state testing. I see n-1 testing more like migration core testing. It's
> >> bad to break migration, but it's really bad to break migration for
> >> everyone because we refactored something deep within migration/.
> >> 
> >> I also wouldn't mind if we had some simple way for device developers to
> >> add migration tests that cover their code. Currently it's infeasible to
> >> edit migration-test with new command lines for every device of
> >> interest. Maybe we could have a little framework that takes a command
> >> line and spits a migration stream? Something really self-contained,
> >> behind the device's CONFIG in meson.
> >
> > I added one more todo:
> >
> > https://wiki.qemu.org/ToDo/LiveMigration#Device_migration_stream_test_framework
> >
> > How's that look?  Feel free to modify on your will.
> 
> Looks good.
> 
> The point about the guest behavior influence is something that Juan has
> mentioned as a blocker for testing with static data. I don't think it
> would be impossible to have some unit testing at the vmstate with some
> artificial values, but it might be too much work to be worth it.
> 

-- 
Peter Xu


