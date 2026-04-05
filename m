Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F46E9D80D
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 18:26:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9SAq-0000N3-50; Sun, 05 Apr 2026 14:26:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1w9SAo-0000M4-4x
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 14:26:14 -0400
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1w9SAl-0005ml-CF
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 14:26:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1775413561; x=1776018361; i=deller@gmx.de;
 bh=b4rRSR9f51J/meMDnu01cRtOt/hh8waTSme9d/yTpfg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=J492zDmyOrxXNmwGPbMFQDe5FxLVbWlLT3CH9MbkbZbXROWZ9l7dr/uK/xLoQUci
 H9O9SYP25B1hlnRPPmDG41n1P22qOoze861yl7/+4hDnkauyII/LPr8u57nV2PipA
 +Pim6ztXGRwEPpkEIErjXHRrIeAb1jV26i8O0UMpdc33li/u62PjNN5Sw+AIZQdde
 5SFbOxtQ8whCoFQdm3k7mNuKvxM0JrLEAI25P2Lut8caswTtTXupF3FadKWqZ2TpR
 Whnj3WsmdxOTBptTzSdSeOgN8XZ0SLj2FrRWzvJNvyIxddSs/IVuUBbggKO/X+tGr
 PBPHRB0nCWTWdTW2aQ==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from client.hidden.invalid by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MtOKc-1vLKvH2vra-00vnuM; Sun, 05
 Apr 2026 20:26:01 +0200
Message-ID: <42604ad8-edfc-4013-a49a-92a876591238@gmx.de>
Date: Sun, 5 Apr 2026 20:57:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.0 0/6] allow building tools and qemu-guest-agent on
 32bit hosts
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@kernel.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260403104327.1163942-1-mjt@tls.msk.ru>
 <878qb27dkm.fsf@draig.linaro.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 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
In-Reply-To: <878qb27dkm.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:fOmZs+WX1l1ueXRdH54zJt2Ve/oIgBlA+nGEskJtQfkMdzx1Zcy
 6UVMyKyreFxM2+DJQDiSg/F+jPCZaivFxfsb3P8G6MIz3BKkgbHJW5ioia8zQL+POzOtoMB
 myHQ/iLnbzxZOjdBRnppGRpDSooUOa+oRNnjlYhsUFHOiq3eywaZXwTWsGsRDzHKsBmGGNH
 1DUCmHLxSIwe1llDqO8XQ==
UI-OutboundReport: notjunk:1;M01:P0:SjaYzsJE/jY=;iYK40lPJ5+C0luP5N9XXLE49B8R
 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
 SD
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi Alex,

On 4/4/26 21:03, Alex Benn=C3=A9e wrote:
> Michael Tokarev <mjt@tls.msk.ru> writes:
>=20
>> This is a patchset which makes qemu-guest-agent, qemu-img & qemu-nbd
>> buildable on 32bit hosts again.  The patches are simple enough to be
>> picked up for 11.0.  The one from Helge is marked as RFC still, but
>> I'd love for it to be accepted the way it is.
>>
>> All patches has been on qemu-devel previously, I just collected them
>> into a single batch.
>=20
> How are you configuring the 32bit build. I'm trying:
>=20
>    '../../configure' '--disable-docs' '--disable-system' '--disable-user=
' '--cross-prefix=3Di686-linux-gnu-'

Basically that's the command line, but I'm in a native chroot/physical
box, so I didn't need the --cross-prefix option.

> but failing with:
>=20
>    Command line: `i686-linux-gnu-gcc -m64 -I/usr/include/glib-2.0 -I/usr=
/lib/i386-linux-gnu/glib-2.0/include -I/usr/include/sysprof-6 /home/alex/l=
src/qemu.git/builds/testing/meson-private/tmpp4ra9pn_/testfile.c -o /home/=
alex/lsrc/qemu.git/builds/testing/meson-private/tmpp4ra9pn_/output.obj -c =
-pthread -D_FILE_OFFSET_BITS=3D64 -O0 -std=3Dgnu11` -> 1
>    stderr:
>    /home/alex/lsrc/qemu.git/builds/testing/meson-private/tmpp4ra9pn_/tes=
tfile.c: In function 'main':
>    /home/alex/lsrc/qemu.git/builds/testing/meson-private/tmpp4ra9pn_/tes=
tfile.c:6:16: error: size of array 'qemu_build_bug_on' is negative
>        6 |   typedef char qemu_build_bug_on[(x)?-1:1] __attribute__((unu=
sed));
>          |                ^~~~~~~~~~~~~~~~~
>    /home/alex/lsrc/qemu.git/builds/testing/meson-private/tmpp4ra9pn_/tes=
tfile.c:9:6: note: in expansion of macro 'QEMU_BUILD_BUG_ON'
>        9 |      QEMU_BUILD_BUG_ON(sizeof(size_t) !=3D GLIB_SIZEOF_SIZE_T=
);
>          |      ^~~~~~~~~~~~~~~~~
>    -----------
>=20
>    ../../meson.build:1072:2: ERROR: Problem encountered: sizeof(size_t) =
doesn't match GLIB_SIZEOF_SIZE_T.
>            You probably need to set PKG_CONFIG_LIBDIR" to point
>            to the right pkg-config files for your build target.
>=20
> I've pointed PKG_CONFIG_LIBDIR at the right place I think:
>=20
>    =E2=9E=9C  echo $PKG_CONFIG_LIBDIR
>    /usr/lib/i386-linux-gnu/pkgconfig
>    =F0=9F=95=9920:02:58 alex@draig:qemu.git/builds/testing  on =EE=82=A0=
 20260403_mjt_tls_msk_ru [$?]
>    =E2=9E=9C  pkg-config --path glib-2.0
>    /usr/lib/i386-linux-gnu/pkgconfig//glib-2.0.pc
>=20
> But obviously I must be holding it wrong.

Of course all libraries, including glib, would need to have been built for=
 64-bit.
On Debian esp. i386 has been excluded from the 64-bit time_t transition be=
cause its primary use case is running legacy 32-bit binaries, and that wou=
ld no longer be possible following an ABI change. See [1].
[1] https://wiki.debian.org/ReleaseGoals/64bit-time
I assume your i386-libs still use 32-bit time_t.

As debian developer it's possible to use the debian porterboxes.
Or, as qemu developer, you could simply set up a debian chroot with
linux-user for armhf, m68k, hppa, powerpc or sh4, e.g.

a=3Dpowerpc && debootstrap --arch=3D$a --include=3Dbusybox --keyring=3D/us=
r/share/keyrings/debian-ports-archive-keyring.gpg sid $a-chroot http://ftp=
.ports.debian.org/debian-ports/
cd /etc && cp passwd group shells $a-chroot/etc
echo $a-chroot > $a-chroot/etc/debian_chroot

Helge

