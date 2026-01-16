Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC789C79FBF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 14:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgkVQ-0004Cd-8H; Fri, 16 Jan 2026 09:08:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vgkVO-0004CN-TB
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 09:08:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vgkVM-0005l1-Ro
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 09:08:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768572527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TR/8yuRfP6ITzdjE3EsGgj37qYsa9p3GFXx5kqAvcZQ=;
 b=XlyzbfGfSb2eY1YSOvQ5WIaFm6XC0uRmI2Gja2wI4pjz3CbY2eDsudB9eznwJJqKiQHdg6
 nGeqhJMtU4Yi2l5uKi4Q55i5LeoPCGGhKriBRNZTynJyl6cuql6XGB0Qu40hwvUT3DcYh4
 mkJiM4d8f6i5as9zVsylnEtVdXFFRJ0=
Received: from mail-dl1-f69.google.com (mail-dl1-f69.google.com
 [74.125.82.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-626-H8ApgTJ0MAa_79mT9upjKQ-1; Fri, 16 Jan 2026 09:08:45 -0500
X-MC-Unique: H8ApgTJ0MAa_79mT9upjKQ-1
X-Mimecast-MFC-AGG-ID: H8ApgTJ0MAa_79mT9upjKQ_1768572524
Received: by mail-dl1-f69.google.com with SMTP id
 a92af1059eb24-123840bf029so1553375c88.1
 for <qemu-devel@nongnu.org>; Fri, 16 Jan 2026 06:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768572524; x=1769177324; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TR/8yuRfP6ITzdjE3EsGgj37qYsa9p3GFXx5kqAvcZQ=;
 b=iNtxdmaJOvzrdRavVNH8iqzHEpeZmTxW21g2gF7k6sS2wxGwVYT+m2JipP/MZozbiV
 IIZq8xAB4ZTqTFmVXFUXHWPMt0RW6T/UlvfBWAut0r2jbweOdP4v6tIQ4k/nLISI0olP
 fEfkBAE5wEuDHaFI6SMH/3T9SoBsH+rrCIk4QOwhMCCl4GSS9HqEL4uSo5DuNYp8IqUG
 s9+oDWUh7/x11slKQAdLogZK7sA0CvrL8Jg5tk41Lg4Y+dJ3eDqjHAh7YIfj2vkNyDaz
 Gpswj0BZ70PbY8Zb1RFV6vF6XXj5GfH7mCHUntqh7D+tJm+gYFRvQKMShFUkJ3TwnL/e
 13pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768572524; x=1769177324;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TR/8yuRfP6ITzdjE3EsGgj37qYsa9p3GFXx5kqAvcZQ=;
 b=YG5fLQoGqK8FoLDhvzNea7wYLvSaonfye9Y0kiwCQKCZgeaoYNz/Ehzr9/X1OAdIjF
 iofof89S5HAOIGm7b5pEUeteK8wzFpjcxu827VR4Wztt6KUHVLYDP1DSPwBbsQj3tzQ1
 O0702+kdpASuw3Gu1EaHfYX/i0054gN/WXW3Q54TE6NOFFgdu2IG83eatXJbddtQcYte
 YC0yiVUcrjPtzWCwpDfT4oBFxzUF9RNWvWFIiiDzcEL8VMiK4KHLZTUIQkkShWbkwL4X
 Caj1oi8OxGVUAsiYSvoEG1uEJbnOlhj1G/2zaHoy8ElLy9GAKglGSL6IYSh32qpTW51Z
 nDmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTTvTm1J2tsqlLt4KhPnDDFrmptwq6GRe0Td5sDdM2twz8Zx16RS8cokn9jxGHTuF1CyyvdyBgyjEY@nongnu.org
X-Gm-Message-State: AOJu0YyrqcEV88xT0L5jFT5YypJkCOgZORXK762FTAt+rzwE+CagLpUq
 sWs3r1dAX6Fi9MLINpGEs9iVaH93RQiNzCTlV8FwpU3apj9fSh7alFtHpUx9LDbQzuW0nQHXhg7
 HOYi9JzKm+IuIAeMDbRHk1jYO/djWT2nL8ygWGT6707xi0WSQgpnM83pF
X-Gm-Gg: AY/fxX6iC5avRzFW8aOM3mwkZioTBU7S+LUOVKHdBN4c6KM5Kh93t6IvdLFT14F5TJz
 1XpnoiSk1KAj/wUJYptPo87nYI6re3eIGVyLRMRr1dXnzgrmHs/tmzma3Z5F3bfgQyP+TxDMixk
 L1cRMiVLK+JLYiin1kbOGD7TUQ4fMXFytH4XM07Y8d8jFsP3A08Fwka+FkVqioRxf92mQRlAee8
 8RXkqPWJbjhh9a6c4Hj15T7zydgZCvurWR87NilyfH8JOl0oPRubF7Y44DfAOkT91BZJpq5KeFD
 mHxnR1wQsBIiMrLCAoUUg8mmyVLk+04HCSDKKJ4pM+IUJHBVEPVvqIpegHEWySOELK7lr/O7pZU
 pCRk=
X-Received: by 2002:a05:7022:2490:b0:11d:f89d:85a0 with SMTP id
 a92af1059eb24-1244a75ebebmr2375688c88.27.1768572524300; 
 Fri, 16 Jan 2026 06:08:44 -0800 (PST)
X-Received: by 2002:a05:7022:2490:b0:11d:f89d:85a0 with SMTP id
 a92af1059eb24-1244a75ebebmr2375670c88.27.1768572523781; 
 Fri, 16 Jan 2026 06:08:43 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1244ac57fd0sm2375736c88.3.2026.01.16.06.08.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Jan 2026 06:08:43 -0800 (PST)
Date: Fri, 16 Jan 2026 09:08:35 -0500
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>, Lukas Straub <lukasstraub2@web.de>,
 qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Juan Quintela <quintela@trasno.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 zhanghailiang@xfusion.com, Li Zhijian <lizhijian@fujitsu.com>,
 Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/3] migration/colo: Deprecate COLO migration framework
Message-ID: <aWpGY9Y1dPwlBuw3@x1.local>
References: <20260114195659.2543649-1-peterx@redhat.com>
 <20260114195659.2543649-2-peterx@redhat.com>
 <aWf4i7EOXtpAljGX@x1.local> <20260115224929.616aab85@penguin>
 <87ecnqt6nc.fsf@pond.sub.org>
 <CAK3tnvKUXk9yvvTKC6cJOKnMJrhZz6W_ZuKze=rqj8JHAREg1g@mail.gmail.com>
 <87ecnpyjw7.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87ecnpyjw7.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, Jan 16, 2026 at 10:41:28AM +0100, Markus Armbruster wrote:
> Zhang Chen <zhangckid@gmail.com> writes:
> 
> > On Fri, Jan 16, 2026 at 2:26 PM Markus Armbruster <armbru@redhat.com> wrote:
> >>
> >> Lukas Straub <lukasstraub2@web.de> writes:
> >>
> >> > On Wed, 14 Jan 2026 15:11:55 -0500
> >> > Peter Xu <peterx@redhat.com> wrote:
> >> >
> >> >> On Wed, Jan 14, 2026 at 02:56:57PM -0500, Peter Xu wrote:
> >> >> > COLO was broken for QEMU release 10.0/10.1 without anyone noticed.  One
> >> >> > reason might be that we don't have an unit test for COLO (which we
> >> >> > explicitly require now for any new migration feature).  The other reason
> >> >> > should be that there are just no more active COLO users, at least based on
> >> >> > the latest development of QEMU.
> >> >> >
> >> >> > I don't remember seeing anything really active in the past few years in
> >> >> > COLO development.
> >> >> >
> >> >> > Meanwhile, COLO migration framework maintainer (Hailiang Zhang)'s last
> >> >> > email to qemu-devel is in Dec 2021 where the patch proposed an email
> >> >> > change (<20211214075424.6920-1-zhanghailiang@xfusion.com>).
> >> >> >
> >> >> > We've discussed this for a while, see latest discussions here (our thoughts
> >> >> > of deprecating COLO framework might be earlier than that, but still):
> >> >> >
> >> >> > https://lore.kernel.org/r/aQu6bDAA7hnIPg-y@x1.local/
> >> >> > https://lore.kernel.org/r/20251230-colo_unit_test_multifd-v1-0-f9734bc74c71@web.de
> >> >> >
> >> >> > Let's make it partly official and put COLO into deprecation list.  If
> >> >> > anyone cares about COLO and is deploying it, please send an email to
> >> >> > qemu-devel to discuss.
> >> >> >
> >> >> > Otherwise, let's try to save some energy for either maintainers or
> >> >> > developers who is looking after QEMU. Let's save the work if we don't even
> >> >> > know what the work is for.
> >> >> >
> >> >> > Cc: Lukáš Doktor <ldoktor@redhat.com>
> >> >>
> >> >> My apologize, I copied the wrong email.
> >> >>
> >> >> Cc: Lukas Straub <lukasstraub2@web.de>
> >> >
> >> > Nack.
> >> >
> >> > This code has users, as explained in my other email:
> >> > https://lore.kernel.org/qemu-devel/20260115224516.7f0309ba@penguin/T/#mc99839451d6841366619c4ec0d5af5264e2f6464
> >>
> >> Code being useful is not enough.  We must have people to maintain it
> >> adequately.  This has not been the case for COLO in years.
> >>
> >> Deprecating a feature with intent to remove it is not a death sentence.
> >> It's a *suspended* death sentence: if somebody steps up to maintain it,
> >> we can revert the deprecation, or extend the grace period to give them a
> >> chance.
> >>
> >> I think we should deprecate COLO now to send a clear distress signal.
> >> The deprecation notice should explain it doesn't work, and will be
> >> removed unless people step up to fix it and to maintain it.  This will
> >> ensure progress one way or the other.  Doing nothing now virtually
> >> ensures we'll have the same discussion again later.
> >>
> >> "Broken for two releases without anyone noticing" and "maintainer absent
> >> for more than four years" doesn't exacltly inspire hope, though.  We
> >> should seriously consider removing it right away.
> >>
> >> Lukas, can you give us hope?
> >>
> >
> > Hi Markus,
> > Maybe you missed something?
> > I think Lukas is ready to maintain this code in his previous emails.
> > https://lore.kernel.org/qemu-devel/20260115224516.7f0309ba@penguin/T/#mc99839451d6841366619c4ec0d5af5264e2f6464
> 
> Patch to MAINTAINERS or it didn't happen ;)

I'd even say MAINTAINERS file is, in many cases, cosmetic..

It definitely is helpful for people to do lookups or scripts to fetch
information, but IMHO we need more than one single entry, and in some sense
that entry is less important than the activities.

We need someone to be first familiar with a piece of code, spend time on
it, actively reply to the relevant queries upstream, proper testing /
gating to make sure the feature is usable as stated - either fully
maintained or odd fixes or others, and more.

I used to request Lukas help reviewing the loadvm threadify series [1,2]
which definitely touches COLO, I didn't really get a respond.  That's also
a sign I don't feel like Lucas cares enough about COLO, after I explicitly
pointing out something might be changing and might be risky.

It's like Hailiang is also in the MAINTAINERS file but Hailiang is
unfortunately not active anymore recently over the years.

Frankly, it was Zhijian and Chen that were always helping from that regard.
I would rather think anyone of both would be more suitable at least from
all the discussions I had with COLO, but this is a promise I can't do.  I
also still want to remove it as I proposed, in case it releases everyone.

So an update in the file isn't even enough if we accept it.  We need
activity corresponding to the file change.  That's also why I still think
we should remove COLO regardless if 11.0 doesn't improve in this condition,
as I stated in the other email.

[1] https://lore.kernel.org/qemu-devel/aSSx28slqi1ywg2v@x1.local
[2] https://lore.kernel.org/all/20251022192612.2737648-1-peterx@redhat.com

Thanks,

-- 
Peter Xu


