Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6944ECCF2C9
	for <qemu-devel@archiver.kernel.org>; Sun, 18 Oct 2026 19:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIWb8-00056L-Ke; Sun, 18 Oct 2026 15:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <SRS0=U7TD=II=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
 id 1xIWb1-00055u-7V
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 15:31:06 -0400
Received: from sonata.ens-lyon.org ([140.77.166.138])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <SRS0=U7TD=II=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org>)
 id 1xIWas-0006xP-AB
 for qemu-devel@nongnu.org; Sun, 18 Oct 2026 15:30:55 -0400
Received: from localhost (localhost [127.0.0.1])
 by sonata.ens-lyon.org (Postfix) with ESMTP id 14769A479A;
 Sun, 18 Oct 2026 21:30:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ens-lyon.org; s=dkim;
 t=1792351852; bh=HZnP79Mu35O28GM0wudflsHfLwcdDdcgjWz3qcyCPIA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=iOLI1wG7/Ly6jJF2iYJwXD1SwNRZnYcizZ+CTCMGHUJvh24MQj+O5FmF4FenW2bTd
 rcaW/WN28feBm3+AHyZJuIbQozXSF2ayOYWo7rbIHXKhPtIucO532MpNcEnKWZn05d
 0ehYgdSHgJIjEm/QriTUrXSw17opk/LB78cbJ8YUptcwLBRbOyilHxS5uyO9nDMTmY
 xudOckLc3q4EOa35Kp5DNXcxUM67kVYvNP74CoVu1cyWh9ZzFF2K4ZOaayuTEQfvUr
 oFgxBoS3+HOEFisFllUagtZ1AhElyCGdfFtaqQpBU7xFgdjuJr8S3TeF2D95t7Neif
 d3Ksb5101npdQ==
Received: from sonata.ens-lyon.org ([127.0.0.1])
 by localhost (sonata.ens-lyon.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A1FKCnsaE-mD; Sun, 18 Oct 2026 21:30:52 +0200 (CEST)
Received: from end (lfbn-bor-1-980-210.w90-120.abo.wanadoo.fr [90.120.173.210])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 by sonata.ens-lyon.org (Postfix) with ESMTPSA id DC089A1C00;
 Sun, 18 Oct 2026 21:30:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ens-lyon.org; s=dkim;
 t=1792351851; bh=HZnP79Mu35O28GM0wudflsHfLwcdDdcgjWz3qcyCPIA=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=x7KnN+v6IYdQ3E91bbpuY0MjSbLNYuYxeDelE8d7fMjImQ2Ydpc1/KYT9A46oWlsc
 nani4nmf7dvtGKmbrnpH4Z5B4FtGXBWHR1jEBxY+7sCpP/iLjDfqIbxc8r82m1EVEL
 jplm97qldIfbEMA6ivwRFijMgq7OvKK2jpCKLQYTjk6vjrfUO3tcbl97ofuezNG6BG
 Gj+e3dSqibigGYza1X26VcpqKF/tmSmAIww2vw7cKxvwAxjIYtzi7Sc/U17JpxIxLM
 5/wO+Z9MM9slqoS6eMErRlSRYzuscL9HnP95Yz5d4rS1KRdBAOc3dRVEAZznV5NqZD
 glaC6Q0kv9aNg==
Received: from samy by end with local (Exim 4.100.1)
 (envelope-from <samuel.thibault@ens-lyon.org>)
 id 1xIWap-00000002BrZ-28HE; Sun, 18 Oct 2026 21:30:51 +0200
Date: Sun, 18 Oct 2026 21:30:51 +0200
From: Samuel Thibault <samuel.thibault@ens-lyon.org>
To: Alexander Epaneshnikov <aarnaarn2@gmail.com>
Cc: qemu-devel@nongnu.org, brltty@brltty.app
Subject: Re: baum: NVDA does not detect usb-braille, and following the
 input-linux grab
Message-ID: <atUea-Pg8KexOMeE@end>
References: <atNoDNz0dQucxzFN@alex-pc> <atNo9sk_7jCAi98u@end>
 <atPIRr46KvMoiCti@alex-pc> <atTzTVaSxUy5r95x@end>
 <atUU4HpVVI59QcLJ@alex-pc> <atUbL22N4UounO8L@end>
 <atUcdQhy2bqOI5cw@alex-pc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <atUcdQhy2bqOI5cw@alex-pc>
Organization: I am not organized
Received-SPF: pass client-ip=140.77.166.138;
 envelope-from=SRS0=U7TD=II=ens-lyon.org=samuel.thibault@bounce.ens-lyon.org;
 helo=sonata.ens-lyon.org
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Alexander Epaneshnikov, le dim. 18 oct. 2026 22:26:32 +0300, a ecrit:
> On Sun, Oct 18, 2026 at 09:17:03PM +0200, Samuel Thibault wrote:
> > Alexander Epaneshnikov, le dim. 18 oct. 2026 21:52:44 +0300, a ecrit:
> > > On Sun, Oct 18, 2026 at 06:26:53PM +0200, Samuel Thibault wrote:
> > > > But then how do you access the VM to get keyboard/mouse access?
> > >
> > > Through input-linux (libvirt <input type='evdev'> with grab='all').
> > > QEMU reads the host keyboard and mouse evdev devices directly. Pressing
> > > both Ctrl keys toggles the exclusive grab between the host and the
> > > guest.
> >
> > So you mean that you make qemu steal keyboard presses from under your
> > Wayland session? That is very peculiar... I'm really unclear this way of
> > stealing the keyboard will work on the long run.
> 
> I am using evdev for it, qemu uses it, and I think evdev isn't going anywhere.

evdev, sure, but stealing keyboard input from wayland while wayland is
running, will surely be frowned upon long-term.

> > > There is no front-end. The grab toggle happens inside QEMU's
> > > input-linux, so QEMU is the only process that knows which side has the
> > > keyboard. libvirt doesn't see it, and neither does anything else on
> > > the host. That is why I thought baum should react to it directly.
> >
> > I now understand your situation, but I don't think it is long-term
> > sustainable :/
> 
> I am using this setup for I think 4 years already.

We have been using the linux console for decades. And still it is
getting removed in Fedora.

> > > > SDL/GTK do not need a grab: provided that the window id is properly
> > > > set, brlapi already switches according to the window focus.
> > >
> > > Thanks, that answers my third question. Then only input-linux, which
> > > has no window, needs to report the grab.
> >
> > Yes, this is really a situation only for such tinkering.
> 
> Should I understand this as that you are not interested in making this feature upstream and I should carry my own downstream patches?

I mean that it's really not clear that qemu will be interested in
integrating code for supporting this situation.

Samuel

