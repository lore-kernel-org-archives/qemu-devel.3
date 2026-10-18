Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87817CCA490
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 19:40:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIWjF-0006FM-Ai; Sun, 18 Oct 2026 15:39:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <aarnaarn2@gmail.com>)
 id 1xIWjA-0006F9-N9
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 15:39:30 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <aarnaarn2@gmail.com>)
 id 1xIWj9-0007S6-4k
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 15:39:28 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-4a1df146015so6077885e9.0
 for <qemu-devel@nongnu.org>; Sun, 18 Oct 2026 12:39:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792352365; x=1792957165; darn=nongnu.org;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to:content-type;
 bh=Sc6flM7MlsVEtA2boYdpUD4ZwrWKT0l0eKk+d2YKVng=;
 b=YVynI+ztgBlnJ27DVDmr3JuXcBfUvSTgjtzt7G+2bvBHA049zfg7I6Yn9NUrHSwNDT
 o1UFfAOD27BAY+PiDamO61HR9wKIUlm5CB3VQr1Pf7XR0Z2KxYXpH9xEyv2THXvSt2FI
 t/3x7XQYCFjYARzGEmXaOKeGBVE4PPueMF6l83oThv6/DEpzDN7qjldOCiPKujxBrYWy
 S69lMbSbCJs1fK5xWG9OPtAmseb9+PW0OPsjwMgLB2BMH5462OL4kt3Tzu80vGgOdN5n
 rby6LR2M9ftOYbH+lXMI9YYiK+js1yisA37ZHjLg9RfOciY6zF2Y5mzY33J8fZKAlf0e
 evsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792352365; x=1792957165;
 h=user-agent:in-reply-to:content-disposition:content-type
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Sc6flM7MlsVEtA2boYdpUD4ZwrWKT0l0eKk+d2YKVng=;
 b=t8ud3XKhO2P3gZvAW6KmH+1RFw722x84T49SsT9Iu1iiktSiOt3b8ufrdn4hqmQv9Z
 ak8XrQK1UwiWdk5oDW/4KQhoaz3iZ8QyvNgKe1xdwRuIQHdjjiQT6Y+Sgch2fUzavXOw
 MooOsKVM9HQBToxWVzg6O7tfvLEPY8D8IevAhyr344U0twgYNVGBz+hVJs3AxBIvgOz8
 dhz9lpK5HkD9PQT6m4NChW4hZIo0cDq3n2DJjvpB+7jzcCkcAbwq7bP4W/EIYS01B5qV
 2j1s8dKA6eny2/vQqpNLl3Fphn0kafpu6fgZT9jrlYD+injtuFypPA73K6Jehzqny8n5
 QWMA==
X-Gm-Message-State: AFq9FYLYTLA6SkZf+0Sh8Q8JK7ax+9MT26MucOSlJ+mkB5Q3pDT0PwpF
 NrA82em3pojJcQ4DrKkDvRcMAEmu3qV42QOHDQ9hwkeknD7cfY+RIYXS
X-Gm-Gg: AYBFou25gw5PVvpYQWEOJz4b2qiesdRkyvkXiUaKcacILI5FJTYZLVHV0B3lfXdXhPY
 7CovC94FCZzf/UHr66w3Ww4XPowjwPyM724dMbeB9PIhW6K+iUoW0UIskkPoj5gRq65u9xxyy9f
 9zIzEht2StiMA7eNcdsDDvnlTILm5cc0a7qRCfk05bbRVHAFr7tRJ0N07Mcjk1OV/7Q2xNKJ3Xe
 +dKkh/UnVmOFJMrDW2tWrE3OWH6dhgpkQKCHM5uHTx8RcZoPgQ8x3hNxlgEH/dNBUIThe7jM2L0
 HHfM3L++UUAQPUgF53m/zg86OjorEto3W0Pq3t4WEuLuC9nQVkWJhbbWOfzIK1iQtutkvSpTlIr
 WmUoGH2xbQQJBA6jJ/2/I4sfivAS79HTVphCtD8gU2eoNmqpvFykgc6xvOW9PVbgVf/IkmOafCg
 lbXH9pdUqxVTOvvTtZnjdGB8GrvaDup4oinlHA5xFgMWvIQfbj7T0FaLO3b0RyxAY=
X-Received: by 2002:a05:600c:4fce:b0:4a0:5b:7bc0 with SMTP id
 5b1f17b1804b1-4a1d7611f69mr133556485e9.21.1792352365259; 
 Sun, 18 Oct 2026 12:39:25 -0700 (PDT)
Received: from localhost ([31.7.57.58]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1d3e2e602sm225948025e9.5.2026.10.18.12.39.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 18 Oct 2026 12:39:24 -0700 (PDT)
Date: Sun, 18 Oct 2026 22:39:23 +0300
From: Alexander Epaneshnikov <aarnaarn2@gmail.com>
To: Samuel Thibault <samuel.thibault@ens-lyon.org>
Cc: qemu-devel@nongnu.org, brltty@brltty.app
Subject: Re: baum: NVDA does not detect usb-braille, and following the
 input-linux grab
Message-ID: <atUgGbk_eswwHR8P@alex-pc>
References: <atNoDNz0dQucxzFN@alex-pc> <atNo9sk_7jCAi98u@end>
 <atPIRr46KvMoiCti@alex-pc> <atTzTVaSxUy5r95x@end>
 <atUU4HpVVI59QcLJ@alex-pc> <atUbL22N4UounO8L@end>
 <atUcdQhy2bqOI5cw@alex-pc> <atUea-Pg8KexOMeE@end>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <atUea-Pg8KexOMeE@end>
User-Agent: NeoMutt/20260616-dirty
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=aarnaarn2@gmail.com; helo=mail-wm1-x329.google.com
X-Spam_score_int: 28
X-Spam_score: 2.8
X-Spam_bar: ++
X-Spam_report: (2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FROM=0.001, RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Sun, Oct 18, 2026 at 09:30:51PM +0200, Samuel Thibault wrote:
> Alexander Epaneshnikov, le dim. 18 oct. 2026 22:26:32 +0300, a ecrit:
> > On Sun, Oct 18, 2026 at 09:17:03PM +0200, Samuel Thibault wrote:
> > > Alexander Epaneshnikov, le dim. 18 oct. 2026 21:52:44 +0300, a ecrit:
> > > > On Sun, Oct 18, 2026 at 06:26:53PM +0200, Samuel Thibault wrote:
> > > > > But then how do you access the VM to get keyboard/mouse access?
> > > >
> > > > Through input-linux (libvirt <input type='evdev'> with grab='all').
> > > > QEMU reads the host keyboard and mouse evdev devices directly. Pressing
> > > > both Ctrl keys toggles the exclusive grab between the host and the
> > > > guest.
> > >
> > > So you mean that you make qemu steal keyboard presses from under your
> > > Wayland session? That is very peculiar... I'm really unclear this way of
> > > stealing the keyboard will work on the long run.
> >
> > I am using evdev for it, qemu uses it, and I think evdev isn't going anywhere.
>
> evdev, sure, but stealing keyboard input from wayland while wayland is
> running, will surely be frowned upon long-term.
>
> > > > There is no front-end. The grab toggle happens inside QEMU's
> > > > input-linux, so QEMU is the only process that knows which side has the
> > > > keyboard. libvirt doesn't see it, and neither does anything else on
> > > > the host. That is why I thought baum should react to it directly.
> > >
> > > I now understand your situation, but I don't think it is long-term
> > > sustainable :/
> >
> > I am using this setup for I think 4 years already.
>
> We have been using the linux console for decades. And still it is
> getting removed in Fedora.
>
> > > > > SDL/GTK do not need a grab: provided that the window id is properly
> > > > > set, brlapi already switches according to the window focus.
> > > >
> > > > Thanks, that answers my third question. Then only input-linux, which
> > > > has no window, needs to report the grab.
> > >
> > > Yes, this is really a situation only for such tinkering.
> >
> > Should I understand this as that you are not interested in making this feature upstream and I should carry my own downstream patches?
>
> I mean that it's really not clear that qemu will be interested in
> integrating code for supporting this situation.

Understood, thanks. The exclusive grab itself is already part of
input-linux upstream, so the change would only let baum follow a grab
that QEMU already does. But I agree it is up to the QEMU UI/input
maintainers whether they want that; if anyone on qemu-devel has an
opinion, I'd be glad to hear it. Until then I'll keep it as a local
patch.

> Samuel

--
Sincerely, Alexander

