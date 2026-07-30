Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F2E2C55162
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 16:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpTg4-0006DA-Ib; Thu, 30 Jul 2026 12:32:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wpTg2-0006D2-Hv
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 12:32:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wpTg0-00078o-Lv
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 12:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785429127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hPM+CfseOZB/+BjRz1bLhE2rd8bzU5OQOflecfASSMk=;
 b=Zt24/pdd22jDe45QveyuIZI3oED2EoH42rU3RJEHL6O68qwf+P6qbEmYCDKi4q7COS0dpa
 R7+BR4bbXZiq6c/jcdEyf6yrnC4EDljyfFQoxxP4YslYfo726KyDbPB58XqTZYzOBPCx5B
 g3odJ1wjFEyQmsvfq+kmGNUCESv29hk=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-66-PK6QIMYaMdiJfMncaDrVVw-1; Thu, 30 Jul 2026 12:32:05 -0400
X-MC-Unique: PK6QIMYaMdiJfMncaDrVVw-1
X-Mimecast-MFC-AGG-ID: PK6QIMYaMdiJfMncaDrVVw_1785429125
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c083f1818so26313971cf.0
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 09:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785429125; x=1786033925; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=hPM+CfseOZB/+BjRz1bLhE2rd8bzU5OQOflecfASSMk=;
 b=TPxsKm5M845r/5PdbdHIUvi0EQgmal7JubNjplyc3cFZA20UjE3ppo0N1to6mR0dR9
 rT60vPOI4sBgBbapjNgLoNaWfZzImCNMLlMjO8oDJbhgE92rpsGJAopcgM2Tyo0f3umc
 8EKwuRByzo+DiYhUfWfejk1rOlkKm+vL3t0Q8nUsIKl/1JxpbmgdqmArfqe4q8aupioc
 tTOszP9zXMvHixvxOsDKhjiEnCdaTS+0sLQqi4C8oUQZMxIlP7/lCiZon7mV3B9ZMdUT
 h++uzC7J4pWxf758mi7Q390gd0GUnDAymAR11ydXxzpPfWlTC5rbprF93SYB2TJ4wk2Y
 woCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785429125; x=1786033925;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=hPM+CfseOZB/+BjRz1bLhE2rd8bzU5OQOflecfASSMk=;
 b=RgYVsrd3dvnqVg63y+uBWM70vNwJgEMXHCLeNe8J0Nh0OmAEaO1s2ublL/IxyxYMLQ
 j3YPxwGFThiaWMKs+0/LuxaoP1KrB7gWZ5sj1OODWQFiY0/d1frv1GB7p4o7vUqLvHdD
 M7sIIvBm5Zn6a6moxvZWreU+iSNGIJQjdkMr1VbO1o2ZXaaI47xz8aX/DxWRU12+WdSg
 mN/ClqbzPnyCskqCJy9mY+YXsImX0h56/C2/R3lXgpj8THJnMUNs/WOdZ4xePERGHio9
 bhcfxMh6/87DwCUG6Dv8qu+LgOi/oT5kp1c7q7Su1aTbphQh47YmeMHWoA9wzo8wzFvt
 uqew==
X-Gm-Message-State: AOJu0YyTwB/7iq5UYFuN/sr2OmmuG586K5icweJ+rzkIBc3DgaNRa9EY
 ecjGnegyTNNdTqd6VPcCxwS1en2tSKp9LftqFxmOz3iubnND6yzDdDolxqciwoatGAFAS85UKFU
 NXwxqcB8Howiz5EntR62SVlL3bNLX+3cX46sE20+Jgg4FjFrRDY2OzcyB
X-Gm-Gg: AR+sD12GLN9ECD0fsMfNjwUI4pY3Gzxgmc+ucXMSdhRP3NkAvQU66HR3lB+ZLPeAejB
 xqHJAAvIIhs1k7ChUOIGpOR382OjCpwqXpxKhtT6d40/EhmpAkAM6Y0T/GuFO2BjuCguU4ISvsX
 WC0lTFl4L2tHlJPvDjK6rbJkfKHWspltr1/30xi2IdiyrRCF28OOEizWiMnjCS8jJUgbQzdX8dx
 pHwJ9WAR9A+XRh6Dl6X3odTJ87yz8r7LXddnKZ53iPzuZqoGTRIwjKhVBRZw7z+AUZWVLkpm1i6
 okdKNPB4aJVM+uS+4PMW65fdtFzzcH8B8Ad2MoPMwdnXqSTMgusLnYQ4dKzs7yaJi/qx
X-Received: by 2002:ac8:6105:0:b0:527:f0a:ccb9 with SMTP id
 d75a77b69052e-52b3878182bmr34533831cf.70.1785429124603; 
 Thu, 30 Jul 2026 09:32:04 -0700 (PDT)
X-Received: by 2002:ac8:6105:0:b0:527:f0a:ccb9 with SMTP id
 d75a77b69052e-52b3878182bmr34533231cf.70.1785429123849; 
 Thu, 30 Jul 2026 09:32:03 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-529e2d832a2sm44285381cf.18.2026.07.30.09.32.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jul 2026 09:32:03 -0700 (PDT)
Date: Thu, 30 Jul 2026 12:31:59 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Subject: Re: [PATCH 0/4] migration: Remove extra type-checking from vmstate
 macros
Message-ID: <amt8f4kNQVpjKi16@x1.local>
References: <20260729225227.1170574-1-farosas@suse.de>
 <amtbGkfKvPCJgDec@x1.local> <amteJEbrPguzFpH5@x1.local>
 <87se50mq7l.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87se50mq7l.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
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

On Thu, Jul 30, 2026 at 12:50:38PM -0300, Fabiano Rosas wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Thu, Jul 30, 2026 at 10:09:30AM -0400, Peter Xu wrote:
> >> On Wed, Jul 29, 2026 at 07:52:23PM -0300, Fabiano Rosas wrote:
> >> > Hi, this is basically what I ranted about in:
> >> > https://lore.kernel.org/r/87jyqeomqz.fsf@suse.de
> >> > 
> >> > I'm replacing the per-integer-size type checks with a single "int that
> >> > fits in 32bit" check. This allows several lines of duplicated code to
> >> > be removed.
> >> > 
> >> > I haven't changed the macro names in the device code yet. If this
> >> > series gets positive feedback then I'll send per-subsystem patches
> >> > doing that.
> >> > 
> >> > CI run: https://gitlab.com/farosas/qemu/-/pipelines/2716814081
> >> > Also tested:
> >> > - migration-test --full --thorough
> >> > - x86_64 compat run forwards and backwards for previous 3 QEMU releases
> >> > - s390x compat run forwards and backwards for previous 2 QEMU releases
> >> > - ppc64 compat run forwards and backwards for previous QEMU release
> >> > - migration-test smoke ASAN/UBSAN run
> >> > 
> >> > Fabiano Rosas (4):
> >> >   migration: Remove VMSTATE_ARRAY_INT32_UNSAFE
> >> >   migration: Introduce VMStateOffset
> >> >   migration: Remove redundant flags
> >> >   migration: Remove duplicate vmstate macros
> >> 
> >> Nice work!
> >> 
> >> I think I was only looking at VBUFFER side and I thought it was fine
> >> sticking with 32bit even signed or not, not a huge deal.  But cleaning up
> >> VARRAY whole thing together looks definitely an improvement.  I definitely
> >> like your version here.
> >> 
> >> I assume with your series I can drop both of my patches here, right?
> >> 
> >>   [PATCH v2 1/5] migration: Fix possible overflow in vmstate_handle_alloc()
> >>   https://lore.kernel.org/r/20260728210417.1925078-2-peterx@redhat.com
> >>   (I'll still respin with the rest)
> >> 
> >>   [PATCH] vhost/migration: Fix incorrect size used in inflight->addr in VMSD
> >>   https://lore.kernel.org/r/20260728153942.1891677-1-peterx@redhat.com
> >> 
> >> The only missing piece would be an multiply overflow check in
> >> vmstate_handle_alloc(), if you could add that check too while rewritting
> >> that in patch 1 then I think it'll cover all.
> >> 
> >> Vladimir's ask in the separate email makes sense: I wonder if we can also
> >> do one step further and merge VBUFFER into VARRAY.
> >> 
> >> The other trivial thing is, while looking, I found one trivial macro
> >> VMSTATE_PARTIAL_VBUFFER not used; can drop it altogether.
> >
> > Now officially declare support for u64 on all these offsets, we also need
> > to double check on our alignment with security issues.
> >
> > Similar reports will not be a bug anymore but results will be the same I
> > assume: it's anything the attacker can feed a u64 directly (instead of an
> > int32_t negative overflow), result is still failing a malloc() with
> > enormously large numbers, legally this time.
> >
> 
> Sprinkle some try_alloc maybe? Shouldn't be just a few from the
> migration code itself.

It's a matter of how helpful is it to fail slightly more gracefully,
v.s. malloc()'s error message.

> 
> > Do you still plan to work on finding per-user upper limit or whatever of
> > that kind?  I'd say time spent working on series like this worths more than
> > that, but I still want to check with you while looking at this solution.
> >
> 
> I thought of some things for the future, but I don't have anything
> concrete, only experiments:
> 
> 1) For all vmstate macros that take an unbounded size, length, etc, add
> a new variant:
> 
>  VMSTATE_FOO_BAR_V()
> +VMSTATE_FOO_BAR_V_BOUNDED()
> 
> And allow the vmstate writer to provide a "Bounds" object (format to be
> defined) and the vmstate core would just use that if it's there and
> that's it. I still think that's a functionality the migration code
> should have in its API.

Something relevant I just sent:

https://lore.kernel.org/r/amt4Yv8miJ_rFYSS@x1.local

Based on that, IMHO what we need in a more useful way is, again taking
gtree example, a wrapper to g_tree_new_full() but allow specifying a size..
then gracefully allow failure to happen.

Maybe it's not easy to wrap it to make it graceful and generic, the whole
point is for the existing unlimited resources problem with migration we
should limit it from the user before migration even starts.

> 
> 2) Allowing a transfer limit in bytes to be set in QEMUFile, which can
> be adjusted at will, maybe using some context-manager-like construct:
> 
> WITH_RX_CAP(f, 1024) {
>     qemu_get_byte();
>     qemu_get_byte();
>     vmstate_load_vmsd()
>     qemu_get_buf();
>     ...
> }
> 
> I'm still not sure how useful these would be.
> 
> > I suppose with this, one option is we can close all tickets reporting
> > security issues while allocating with all u64 fields.
> >
> > Thanks,
> 

-- 
Peter Xu


