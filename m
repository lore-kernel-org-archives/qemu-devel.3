Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75562CA0EEB
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Aug 2025 11:01:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uq8SB-00080U-J2; Sun, 24 Aug 2025 07:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1uq8SA-0007zq-6A
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 07:00:02 -0400
Received: from mout.gmx.net ([212.227.17.20])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1uq8S6-0004co-R5
 for qemu-devel@nongnu.org; Sun, 24 Aug 2025 07:00:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1756033193; x=1756637993; i=deller@gmx.de;
 bh=hHHjin2x/aoBwlQ3CNave1v5DJO4+WTOEFWp01m2VjY=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=OAnNv0axlvfub65n8r2ijrBWIgRHUJOo5avUscRowpo3z5a5UPmjLKBgOm7S2XTt
 m3PO+2yCrYnRmZrAbQBd4GFL/cnHd7WWdaF4+aCm1ePLXgciLrGB7a/XGxG34jVjS
 byTKKQTkezP5Pyo6wVzUW3n2cU5DSdXfzGHc/psqOIgL2m6KaQZu8028jM8+Fi2ak
 8cCF28Ug1eqtaZDjkIJM2iNi4OPWUHmVbE3yPVHIqtHj15HkUfBE8UMZW8Ymva8jY
 17CD0scUarAMR6VOuuliMdQuCJFssmQmGipk2Z7PSUOQDzUleTdX6B4yKUaaLkVap
 kDhocIdScrnepOaUVg==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([83.135.217.92]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MTzfG-1uyHfP2sAk-00NBpx; Sun, 24
 Aug 2025 12:59:53 +0200
Message-ID: <50e6ca70-5144-45ed-9afc-f15d45274a7b@gmx.de>
Date: Sun, 24 Aug 2025 12:59:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: qemu-user + binfmt Credential flag, again
To: Michael Tokarev <mjt@tls.msk.ru>, QEMU Development <qemu-devel@nongnu.org>
References: <f1a22d84-142e-4bc6-8ef0-c05156dcc20a@tls.msk.ru>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <f1a22d84-142e-4bc6-8ef0-c05156dcc20a@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:tNhJ7wgV4DKz40Q1pUPLjaYyxHCRfW4Rkue3xlN5Sbs67P73rix
 s1++oNhe3odWeDfUsKJS2QkaOvCHGfm2rvyJ0dsN4ttoPtxXMiRJngjbNsWz7RgHz46tl2p
 6OYd8pnQzlZ1CfuHKhdERryR7NO7BXKPxGvzw6u4jh1aU2q7zc2FGjYyGp6eByZq0Wo+Lyv
 39hvoDSciJkNDcuyInhvQ==
UI-OutboundReport: notjunk:1;M01:P0:LxQXXq9CL84=;3QaI+/HopeYsPjHVELwJzBvjt6B
 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
 mG3rB1c=
Received-SPF: pass client-ip=212.227.17.20; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 8/24/25 12:16, Michael Tokarev wrote:
> Just a couple days ago Debian has released qemu security update (DSA
> 5983-1), addressing qemu-user + binfmt vulnerability which were present
> in debian (and ubuntu) for over 15 years.=C2=A0 The prob is that qemu-us=
er
> binfmts has been registered with C flag, which means qemu is run with
> elevated privileges (as root) when asked to provide interpreter to a
> suid foreign binary.=C2=A0 Apparently no one realized how bad it is, unt=
il
> now.=C2=A0 qemu was never supposed to be used like this, yet a few linux
> distributions wrongly enabled this C flag.
>=20
> To demonstrate how bad it is.
>=20
>  =C2=A0# debootstrap --arch=3Darmel --variant=3Dminbase bookworm /chroot=
/bookworm
>=20
> this will populate /chroot/bookworm with an armel debian bookworm
> installation.=C2=A0 Almost any linux install includes a few suid-root
> binaries, for example the traditional *nix /bin/su.=C2=A0 Now, for any
> user on the system, starting with an easy one:
>=20
>  =C2=A0$ QEMU_LOG_FILENAME=3D/etc/shadoww QEMU_LD_PREFIX=3D/chroot/bookw=
orm \
>  =C2=A0=C2=A0=C2=A0 /chroot/bookworm/bin/su
>  =C2=A0=C2=A0 (just hit Ctrl+C to the su prompt).
>  =C2=A0$ ls -l /etc/shadoww
>  =C2=A0-rw-r--r-- 1 root mjt 0 Aug 14 21:56 /etc/shadoww
>=20
> this makes qemu write any file as root.=C2=A0 Not with a given contents,
> but the fact it writes to whatever file it is told to write is already
> interesting.
>=20
> Now, something more interesting would be to provide a modified
> lib/ld.so or lib/libc.so which just runs /bin/sh, and use it in the
> same way with that same /chroot/bookworm/bin/su binary to gain full
> root privileges.=C2=A0 I'm not providing actually working PoC here, --
> the above command line already tells you that you can control
> QEMU_LD_PREFIX which works exactly like LD_LIBRARY_PATH for ld.so,
> so qemu will happily run any user-supplied code as root.
>=20
> This is just a tip of the iceberg - just the very basics.=C2=A0 Qemu
> can be modified to not react to QEMU_* environment variables when
> it detects it is running with elevated privileges, in a way similar
> to a shell which ignore certain env vars when run in suid mode -
> and this is something which definitely should be done (I'll post
> a simpla patch later).=C2=A0 Maybe it should produce a big fat warning
> when it detects suid mode, too.
>=20
> The more deep prob is that qemu was never written with any sense
> of security in mind, and it is a complex and tricky piece of software,
> so making it "secure" is not really an option, at least not in any
> reasonable future.
>=20
> At the very least, I propose to remove --credential option from
> scripts/qemu-binfmt-setup.sh entirely (patch will follow) - not to
> help someone to shoot themselves in the foot. =20

I really disagree on this.
There are very good reasons to have qemu with credentials enabled.
One such valid example is to used debian as buildd server to cross-compile
debian packages for other architectures. For this you need to have
credentials enabled for quite some packages, so with security in mind
you should normally not allow other users to access the machine.

In general, just if someone can shoot himself into the foot you should
not remove features.
Instead, disabling it by default, and adding a big fat warning if people
enable it is a good way forward.

> It should not be noted in any docs or examples either (how to
> configure it to work with suid foreign binaries, that is).=20

Disagree. Hiding issues don't solve them.

> Instead, we can add a big fat warning in the docs which tells the
> user *not* to try doing that.
Yes. Agreed.

Helge

> Seeing how much fun can be done with debian systems now before
> the yesterday update of qemu-user, I think this issue deserves
> much wider attention and care.=C2=A0 Thankfully, not every user system
> has foreign chroots installed with qemu-user binfmt handler enabled.
>=20
> Thanks,
>=20
> /mjt
>=20


