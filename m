Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61BC0CCD184
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 23:29:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v704G-0000X8-LV; Thu, 09 Oct 2025 19:29:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v704F-0000Wp-EA
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 19:29:03 -0400
Received: from mail-il1-x131.google.com ([2607:f8b0:4864:20::131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1v704D-0000bG-K0
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 19:29:03 -0400
Received: by mail-il1-x131.google.com with SMTP id
 e9e14a558f8ab-4259247208aso10973845ab.3
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 16:29:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760052540; x=1760657340; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1qcgMGBsBUVslFfDAB5CgTqqMmqVbE1LOeNVsrV6THc=;
 b=ZrUsUQDuIHtDWZUB6xA8on4XsOEFPUu6uUhHcFRzN5ngxYio/RVxZtIfrLbipevdOa
 nzv+Irx0DYkw9Skb830usidh7GRYFCt1O8wclzUrNBujd7qA8gV4W9wyuK3JHjalx2Y7
 67EFW6aZEwQM5ts7F2ytKCgi+2zrk75FA0KupXMeFOfMy5Afre3uzTSla6DtZiL/MWcp
 BYk3Jj7n3l2TTiDQxj8CwiqAaPfJsj9IW9BJ/rXY4tJbrcsUGdjptdSkArsEZbAdJyKQ
 Up2+wfqwJ+rWNQ3QQrNo1ju/03fKQbk/RksUR1Ksl1N4nMiWoA7zD2ujf11qgA88lscn
 N/jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760052540; x=1760657340;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1qcgMGBsBUVslFfDAB5CgTqqMmqVbE1LOeNVsrV6THc=;
 b=wchaovN40lqBt+oSZsEldS534m3caVf7q2Y5BLgkVNSnF0WyA19lvSyB1qdj4iJAc0
 2rAHqIq7iIMrjSi2Cxeueh5xanc6kGsj1Ei1EKvvghMvxlyNjpdvTC7U4zF1N1gaqfZl
 JaCKXnBV3+KoJPc/R3qyhwFhj126PUOfbZjD6l3uMJiCsOwv7dVWFyYd0dhcS/oV7vmM
 /Aww8UJMk4KI+erzp7vSCAM9lfRMR8n02p7KX6GRL37YrPs6aY8c/tNp3KKt9AtiIqkK
 sTs7y4c8HewscU8sYzspwcqBnN9FQdOGqdNEPHC5+mDh48Kw0WmgpobJaiptJ1zme3eP
 DvZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVlJL6teKi/NqcP1a3TBYSjh4XKzZ2IMJxNweEfGHqw2KOxx4rUyr4gT5Fu07TJb138s0btIrtrimO4@nongnu.org
X-Gm-Message-State: AOJu0YxGMJCRaGULYst9dhRvO2A/hZnPNHPfvWGo2jinRAPoKjzyQ6Rj
 J/MUrwM50Y+W2ykcoS+wlc3ddUkPrTX4iymgTYWohtnFwfw8RLa88azAxoMbDiOuotsEkbpCHB/
 KWZwfRwHXYyz88xudqN3DtqtGOcHEcOA=
X-Gm-Gg: ASbGnctkm4ozSt3X+y1oIHz3pwF+57BM9vjXNlpf1ot5oiu69D5Ine4uuWjKi2lvBIS
 ZM88JxyGizUSSmDbBo+WblRCobTvziKaAU/9nt7ve/arU882VcR9QkMnQwaoR5ET6Ok6XZ1E8NN
 ATRtupSADDSzfKrl7P3rBG5lP29EjiLZJjS8mJpGBt8YbW2/XsfWng8b9/fuT0aDm/+NYJyhCvh
 9PFGz/1ac+AkYBFeHSxkmROJPyros7SEx1Jbi8RZg==
X-Google-Smtp-Source: AGHT+IEx2a+sHK6SYD9xqghhnh8uuL9qYIk+s4orIIC/kK6o5kIgcCnMxepB08ez3Ag01f2ZTTm3xZ6fu0KCD9rl0tM=
X-Received: by 2002:a05:6e02:2783:b0:424:866:ec6d with SMTP id
 e9e14a558f8ab-42f8736d251mr97333985ab.12.1760052539683; Thu, 09 Oct 2025
 16:28:59 -0700 (PDT)
MIME-Version: 1.0
References: <20250813164856.950363-1-vsementsov@yandex-team.ru>
 <CAFubqFv8F8swA3EwZfgnVYpHNgs0yZSFgf6wm2DwXgPxSTjs5A@mail.gmail.com>
 <aabfa3db-e434-4dde-b01e-b0195eb4adee@yandex-team.ru>
In-Reply-To: <aabfa3db-e434-4dde-b01e-b0195eb4adee@yandex-team.ru>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Thu, 9 Oct 2025 19:28:48 -0400
X-Gm-Features: AS18NWB6hjOf5642jdWHU54Fx6pKk0x5wKuAKDzY5mIt13ykK6EBGF_cZKJmVck
Message-ID: <CAFubqFsANpc_v8Dvd4P=Swmei2P_Nt33+0eXn4UdC8-dcJCPfA@mail.gmail.com>
Subject: Re: [PATCH 00/33] vhost-user-blk: live-backend local migration
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: mst@redhat.com, peterx@redhat.com, farosas@suse.de, raphael@enfabrica.net, 
 sgarzare@redhat.com, marcandre.lureau@redhat.com, pbonzini@redhat.com, 
 kwolf@redhat.com, hreitz@redhat.com, berrange@redhat.com, eblake@redhat.com, 
 armbru@redhat.com, qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 steven.sistare@oracle.com, den-plotnikov@yandex-team.ru
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::131;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-il1-x131.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Thanks for the detailed response here, it does clear up the intent.

I agree it's much better to keep the management layer from having to
make API calls back and forth to the backend so that the migration
looks like a reconnect from the backend's perspective. I'm not totally
clear on the fundamental reason why the management layer would have to
call out to the backend, as opposed to having the vhost-user code in
the backend figure out that it's a local migration when the new
destination QEMU tries to connect and respond accordingly.

That said, I haven't followed the work here all that closely. If MST
or other maintainers have blessed this as the right way I'm ok with
it.

On Thu, Oct 9, 2025 at 6:43=E2=80=AFPM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> On 09.10.25 22:16, Raphael Norwitz wrote:
> > My apologies for the late review here. I appreciate the need to work
> > around these issues but I do feel the approach complicates Qemu
> > significantly and it may be possible to achieve similar results
> > managing state inside the backend. More comments inline.
> >
> > I like a lot of the cleanups here - maybe consider breaking out a
> > series with some of the cleanups?
>
> Of course, I thought about that too.
>
> >
> > On Wed, Aug 13, 2025 at 12:56=E2=80=AFPM Vladimir Sementsov-Ogievskiy
> > <vsementsov@yandex-team.ru> wrote:
> >>
> >> Hi all!
> >>
> >> Local migration of vhost-user-blk requires non-trivial actions
> >> from management layer, it should provide a new connection for new
> >> QEMU process and handle disk operation movement from one connection
> >> to another.
> >>
> >> Such switching, including reinitialization of vhost-user connection,
> >> draining disk requests, etc, adds significant value to local migration
> >> downtime.
> >
> > I see how draining IO requests adds downtime and is impactful. That
> > said, we need to start-stop the device anyways
>
> No, with this series and new feature enabled we don't have this drain,
> see
>
>      if (dev->backend_transfer) {
>          return 0;
>      }
>
> at start of do_vhost_virtqueue_stop().
>
> > so I'm not convinced
> > that setting up mappings and sending messages back and forth are
> > impactful enough to warrant adding a whole new migration mode. Am I
> > missing anything here?
>
> In management layer we have to manage two end-points for remote
> disk, and accompany a safe switch from one to another. That's
> complicated and often long procedure, which contributes an
> average delay of 0.6 seconds, and (which is worse) ~2.4 seconds
> in p99.
>
> Of course, you may say "just rewrite your management layer to
> work better":) But that's not simple, and we came to idea, that
> we can do the whole local migration at QEMU side, not touching
> backend at all.
>
> The main benefit: fewer participants. We don't rely on management layer
> and vhost-user server to do proper things for migration. Backend even
> don't know, that QEMU is updated. This makes the whole process
> simpler and therefore safer.
>
> The disk service may also be temporarily down at some time, which of cour=
se has
> a bad effect on live migration and its freeze-time. We avoid this
> issue with my series (as we don't communicate to the backend in
> any way during migration, and disk service should not manage any
> endpoints switching)
>
> Note also, that my series is not a precedent in QEMU, and not a totally n=
ew
> mode.
>
> Steve Sistare works on the idea to pass backends through UNIX socket, and=
 it
> is now merged as cpr-transfer and cpr-exec migration modes, and supports
> VFIO devices.
>
> So, my work shares this existing concept on vhost-user-blk and virtio-net=
,
> and may be used as part of cpr-transfer / cpr-exec, or in separate.
>
> >
> >>
> >> This all leads to an idea: why not to just pass all we need from
> >> old QEMU process to the new one (including open file descriptors),
> >> and don't touch the backend at all? This way, the vhost user backend
> >> server will not even know, that QEMU process is changed, as live
> >> vhost-user connection is migrated.
> >
> > Alternatively, if it really is about avoiding IO draining, what if
> > Qemu advertised a new vhost-user protocol feature which would query
> > whether the backend already has state for the device? Then, if the
> > backend indicates that it does, Qemu and the backend can take a
> > different path in vhost-user, exchanging relevant information,
> > including the descriptor indexes for the VQs such that draining can be
> > avoided. I expect that could be implemented to cut down a lot of the
> > other vhost-user overhead anyways (i.e. you could skip setting the
> > memory table). If nothing else it would probably help other device
> > types take advantage of this without adding more options to Qemu.
> >
>
> Hmm, if say only about draining, as I understand, the only thing we need
> is support migrating of "inflight region". This done in the series,
> and we are also preparing a separate feature to support migrating
> inflight region for remote migration.
>
> But, for local migration we want more: remove disk service from
> the process at all, to have a guaranteed small downtime for live updates.
> independent of any problems which may occur on disk service side.
>
> Why freeze-time is more sensitive for live-updates than for remote
> migration? Because we have to run a lot of live-update operations:
> simply update all the vms in the cloud to a new version. Remote
> migration happens much less frequently: when we need to move all
> vms from physical server to reboot it (or repair it, serve it, etc).
>
> So, I still believe, that migrating backend states through QEMU migration
> stream makes sense in general, and for vhost-user-blk it works well too.
>
>
> --
> Best regards,
> Vladimir

