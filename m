Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95E44ECD983
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 16:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo2B0-0004md-H9; Thu, 05 Feb 2026 11:25:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vo2Ay-0004m7-Ph
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 11:25:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vo2Av-0005eF-4r
 for qemu-devel@nongnu.org; Thu, 05 Feb 2026 11:25:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770308747;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6uh6Elq1Zgru6/gD5EAK11Ph2oRsMY0wOd9bLg2LPCA=;
 b=QFBS1HhJJRTAB2Uqn7HsrakzEWnnXps/wQG6dgQgOMsj1TsoFb84wwq321/M449Hpro3Ie
 CTSlaYJ/Ot912i3PWwPNmQ/jymHUZm/NGmiqGG7+q8FXUf2i3WKKnfo5hNOKfqjC8owlOi
 WFTSzEMtMFoYciph6mRakKNmhMRcEVU=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-5YdJN0e-Pcqeij7Jhd45aw-1; Thu, 05 Feb 2026 11:25:44 -0500
X-MC-Unique: 5YdJN0e-Pcqeij7Jhd45aw-1
X-Mimecast-MFC-AGG-ID: 5YdJN0e-Pcqeij7Jhd45aw_1770308744
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50142190becso41472341cf.3
 for <qemu-devel@nongnu.org>; Thu, 05 Feb 2026 08:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770308744; x=1770913544; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6uh6Elq1Zgru6/gD5EAK11Ph2oRsMY0wOd9bLg2LPCA=;
 b=fs/zneJzdWCA3tG6dt6/zfqdr1j1lSCqWADT83XfwNoZTfrHy0iXh8YCDuto0uhgS2
 YLAA0X+84YBBkcBnIGjvWdLFG7tvr+R+6g7HnLkYs1tP67oIlDGgnlyIpoM5Efidi2sh
 XW5atIaYElwLW7N0smVs88B0IKB4XjVmc0af4nHw/H0TtdpqoBxbNvJlTScz53ywvuKP
 3jPaWwyWEaaTViaCB4Dpfh0whsehN/I4kcXT0BQxExsyJtewVgjE1oey4LK1UNaV/S74
 Rlz6z6KQsNFgGL0vvgikv8oscKnlc7eKZ4E1r7F6uaGZBKMCyoaPwokVxnsZ31hZUcnC
 2toQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770308744; x=1770913544;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6uh6Elq1Zgru6/gD5EAK11Ph2oRsMY0wOd9bLg2LPCA=;
 b=ds4NRHIoOjsSJKlWzen76a5gFrggfyk4HZh+aJZn7EeZt24I3UOpFPnPVz9ZvCkCvo
 w/NHplnP2dETcQj91W/3N8rdQwUdODVVU7MeJQ5+aXXCJq5Wri92Lh6Zprh3v/mfkysl
 J4XvM7+rWR2ImcFERXfu4Yj3OdU8GQdWsKQ+yMaYA3sweU8zNKHDyqTb6uDcWFlYBgsv
 YJA6PR26DvqFlBnmoRBJTlS+fMoiUtAB3/LGfxXb7EPJDUKX90xe7mQdazrpLJeLnhB8
 gaI1yL6zrkUAOx0rNgZnNzlkj1/SZG8SH5/kZOmDSl5hpUMPKDKTRdTofkkgtnxmVZ9z
 XQ2w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVWbcgzUtD3yAYl3azN/U4jCOz+DKpYNOn+oBcR62f0lkwPbhobWaLqrNbXThIDb6GTK7DDgfvqvQor@nongnu.org
X-Gm-Message-State: AOJu0YyP/Th80ji5+zxbs6sKj0sIV72jpy/MB+56XeOgP/P4pPgjPi/+
 iv/X+pijhTm3Ooe+fSImekl4KOeHcqrIQhSeNBfQfX6kI/z8XdgpsJBWj7yt+xcldOMkP7PA7F5
 y5fwaWUggh4EmruiK3Qo9c5TKEQtvHmiikUk7VJERWwsZJxm2wuGYuPAa
X-Gm-Gg: AZuq6aIHyBP/z0ntOeVV969v+2C3tphftfKkJxFJKoLGyew3VWj01+sm88iSY4niOkU
 lQClqCqEapf5Gzq+5Rm/IC2eAbZXOY7T6ULNRAcRM+1N+BMQ/7FYM636eO0XLbyhszCWpbNEcji
 PDC4n/JPg2JxSU2zSyhGpQBV+DjzWVuxgVAPS1GGbjV9HoeAYlVWqYgO2RqB0WGG3NgbQv1tb4a
 1a8KNWkHlvaB+k2ZDWNp/sUoMf0MFwIuRLbBVJ+JKcWWFjZduQRuclEwNTOCNejZufBl7WMx/ay
 I0LvSIXnmZ0rk5tMOdGM9CnNXhVBHZDSBef6909aGQLtAWeugkzPGhnPiQHuBRB6BbUmITmqMOu
 SCtg=
X-Received: by 2002:ac8:5f0b:0:b0:4ff:8da6:2289 with SMTP id
 d75a77b69052e-5061c0d70f5mr88277591cf.27.1770308744141; 
 Thu, 05 Feb 2026 08:25:44 -0800 (PST)
X-Received: by 2002:ac8:5f0b:0:b0:4ff:8da6:2289 with SMTP id
 d75a77b69052e-5061c0d70f5mr88276771cf.27.1770308743393; 
 Thu, 05 Feb 2026 08:25:43 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-89521c19923sm43080326d6.23.2026.02.05.08.25.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Feb 2026 08:25:43 -0800 (PST)
Date: Thu, 5 Feb 2026 11:25:41 -0500
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Markus Armbruster <armbru@redhat.com>, jasowang@redhat.com,
 mst@redhat.com, pbonzini@redhat.com, berrange@redhat.com,
 thuth@redhat.com, eblake@redhat.com, farosas@suse.de,
 zhao1.liu@intel.com, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 davydov-max@yandex-team.ru, qemu-devel@nongnu.org,
 yc-core@yandex-team.ru, leiyang@redhat.com,
 raphael.s.norwitz@gmail.com, bchaney@akamai.com
Subject: Re: [PATCH v10 3/8] qapi: add backend-transfer migration parameter
Message-ID: <aYTEhSjA6Dnvw1yf@x1.local>
References: <20260201162001.296328-1-vsementsov@yandex-team.ru>
 <20260201162001.296328-4-vsementsov@yandex-team.ru>
 <aYOAAfzZQ3PeKf4q@x1.local> <87ecmzu0qx.fsf@pond.sub.org>
 <f83e7888-8159-4522-a40d-352ed0a81be3@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f83e7888-8159-4522-a40d-352ed0a81be3@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Feb 05, 2026 at 11:06:03AM +0300, Vladimir Sementsov-Ogievskiy wrote:
> On 05.02.26 10:07, Markus Armbruster wrote:
> > Peter Xu <peterx@redhat.com> writes:
> > 
> > > On Sun, Feb 01, 2026 at 07:19:55PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> > > >   # @migrate-set-parameters:
> > > > @@ -1004,6 +1005,13 @@
> > > >   #     is @cpr-exec.  The first list element is the program's filename,
> > > >   #     the remainder its arguments.  (Since 10.2)
> > > >   #
> > > > +# @backend-transfer: Enable backend-transfer feature for devices that
> > > > +#     supports it.  In general that means that backend state and its
> > > > +#     file descriptors are passed to the destination in the migraton
> > > > +#     channel (which must be a UNIX socket).  Individual devices
> > > > +#     declare the support for backend-transfer by per-device
> > > > +#     backend-transfer option.  (Since 11.0)
> > > 
> > > I still think it'll be nice to either have "local" in the name of parameter
> > > or at least document it with crystal clear terms.
> > > 
> > > I used to suggest fd-passing, but maybe you wanted to emphasize there's
> > > more than fds to be migrated at least for tap?
> 
> For vhost-user-blk it's the same: not only FDs.
> 
> > > Then it can still be
> > > "local-backend-transfer", because nobody stops a device to transfer backend
> > > states in a remote migration either.. so "backend-transfer" seems to also
> > > work for remote migrations, but it is not.
> 
> Hmm. I imagine a mechanism, where OS supports passing FDs to another host.
> This needs support for actually migrating the corresponding kernel object
> by OS automatically. But theoretically I think it can be done transparently
> for userspace QEMU process, which will simply pass FDs to the some special
> socket, similar to UNIX domain socket.
> 
> So, the key aspect is that we should be able to pass FDs to the migration
> channel, which currently meant that it must be UNIX domain socket, and it
> must be local migration. But in future it may change.

That's a nice vision, but IMHO we shouldn't take it into account when
defining any QEMU interface, when it's only about pure imaginations..
unless there is solid work in progress, or ideas proposed / known feasible
at least.

> 
> And yes, "backend-transfer" work for remote migration of backend.
> If we ever implement remote backend migration, why not to
> reuse "backend-transfer" for it? Even if there will not be transparent
> support from OS, and we'll implement another mechanics, we may add
> new parameter
> 
> 
>    backend-transfer-mechanism = "scm-rights" | "something-other"

Yes, this will look much better.  We likely shouldn't make it "scm-rights",
it should be generic terms that applies to all platforms like "local", even
if the implication / implementation might be different on various
platforms.

That's also the major confusion I got when I was reading the other
vhost-user-blk series, thought it was a local migration but not.

I feel like the interface is simply wrong to make it one covering both, or
at least it shouldn't be a boolean as you said because it represents more
than one use case.

If it's a boolean, it also shouldn't rely on UNIX sockets if it was trying
to describe a remote migration, right?  The vhost-usr-blk way of
backend-migration doesn't require UNIX socket, or does it?

Especially, if we still want to have your new proposal try to work for CPR
too or even replace it some day (or a continuous set of proposals in the
future, from different developers based on this feature), we need to have a
solid and clear way represents what CPR does, which is to do local fd
sharing.  "backend-transfer: local" or something similar can be that.

> 
> (or we can put this into "backend-transfer", supporting passing string to
> it and deprecating boolean)

It can be a enum, something like NONE, LOCAL, REMOTE.  But before that..

> 
> More over, this future "remote-backend-transfer" could be used for local
> migration, so again, it should be called simply "backend-transfer"..

Yes, REMOTE might be slightly misleading.  And considering you seem to want
to allow any of below to work:

  (1) enable fd migrations only,
  (2) enable remote migrations on backends only,
  (3) enable both of (1)+(2)

Maybe we should have two different feature bits?  The per-device one can be
kept as backend-transfer, however we need to change the global migration
knob to something describing a local migration.

In summary, still 1 new parameter for migration, 1 new parameter for
device, but adjust to:

  - Migration parameter: "local", boolean, when set, the migration must be
    a local migration within host (which requires UNIX sockets on Linux)

  - Per-device parameter "backend-transfer", boolean, when set, device will
    migrate backends when migration happens.  Otherwise, backends are not
    migrated; dest QEMU needs to re-initialize it.  The backends may or may
    not contain FDs.

    When the backend device states contain FDs and FD migrations are
    required, it requires "local" set first above, or it should fail the
    migration when user requested backend-transfer=on.

    When it doesn't contain FD at all (or FD migration is not a must?), it
    should either migrate the backend or not depending on the user's
    selection.

For tap (your series here), you need to set both ON and required.

For vhost-usr-blk, that only needs to set per-device knob to ON, the other
one shouldn't matter.

Then when we want to replace cpr, we request people switch (cpr-transfer
only, keeping cpr-exec / cpr-reboot aside for now) from setting
mode=cpr-transfer to local=on, which hopefully will start work as before.
The per-device parameter doesn't matter in this case.

Would this be more reasonable?

Thanks,

-- 
Peter Xu


