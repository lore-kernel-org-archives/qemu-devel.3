Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1067AFC5926
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 10:44:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvYqY-0000Te-9t; Thu, 26 Feb 2026 05:43:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vvYqW-0000TS-Az
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 05:43:52 -0500
Received: from mout.web.de ([217.72.192.78])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lukasstraub2@web.de>)
 id 1vvYqU-0007ye-I7
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 05:43:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=web.de;
 s=s29768273; t=1772102612; x=1772707412; i=lukasstraub2@web.de;
 bh=7b7j9IDjSQZkt1htldDqjdpf9eDRpTMTDcDoRvelniw=;
 h=X-UI-Sender-Class:Date:From:To:Cc:Subject:Message-ID:In-Reply-To:
 References:MIME-Version:Content-Type:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=XS32f0asRR6FF+e7RjJQChTteNVZ+6u36LS3jLLX2BuW04lFALmFLzjHR9d3hXAB
 xGdHy3IYlsI/EQC7za7ZgS4Y6Qtamxc6GAvxVInKBkQkw/4Ve112wG5c2Ur2U4yoS
 qUldtA5qk/UYkzMQBad0cDTSz9BAyZQW7YR3o1I6oJbU8vXNMpyBCGZTNGPTrwBXR
 hjm6uywmiKnT0+w8HfFA/AH1w3P7+MXmacOBuqZAv6BXY4bBRrg/BSwCZ21T4P+j2
 8Ga93LBytx8WCOgoKOgBPHPEoxt9xBFX22/udZKUawCN7/VJ7gh6JyGut5qtO2nFF
 WRsq3d0/ciF1pIYTuA==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from client.hidden.invalid by smtp.web.de (mrweb106
 [213.165.67.124]) with ESMTPSA (Nemesis) id 1N2BM4-1vZC7012as-018ESB; Thu, 26
 Feb 2026 11:43:32 +0100
Date: Thu, 26 Feb 2026 11:43:19 +0100
From: Lukas Straub <lukasstraub2@web.de>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Zhang Chen
 <zhangckid@gmail.com>, Hailiang Zhang <zhanghailiang@xfusion.com>, Markus
 Armbruster <armbru@redhat.com>, Li Zhijian <lizhijian@fujitsu.com>, "Dr.
 David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH v9 19/19] colo: Fix a rare crash during shutdown
Message-ID: <20260226114319.17f11f9b@penguin>
In-Reply-To: <aZeBn2MBKvQQYEAx@x1.local>
References: <20260218-colo_unit_test_multifd-v9-0-d8dbdb0ca6f6@web.de>
 <20260218-colo_unit_test_multifd-v9-19-d8dbdb0ca6f6@web.de>
 <aZeBn2MBKvQQYEAx@x1.local>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.4JA8oKT9JPAaqU1SpKDr1e";
 protocol="application/pgp-signature"; micalg=pgp-sha512
X-Provags-ID: V03:K1:GAQNkq3v4vsgbqz6kmWIpRkOSZcoIvYrQKQrSvCSv5FUQUQXOhS
 N6Lv7/JCKzWqjLo/fyTpKOaMT9QVonGvCg3cmd16hXcykM4N/q9yOayg70lTHpHl3jvP7Js
 nN2xUReK8gk89IJLxghFuIT3NUF6yD9GLpgBotzv4HSL3+WdYNXgqEOFDWpEIL8NITkEG67
 nENYhuw+gfFNZuGDQaV/A==
UI-OutboundReport: notjunk:1;M01:P0:bYGRXc9X+y8=;g0TXOtfiBHCLyME4aNwk4GmpsKe
 3e3mze/X7uuei3+tNrijkzMVdiaUtql2IPvVg+nN+VYuuLJhSA2zfLkct/Br0Edv/M83ATCl9
 4xxtK5GbGi86TRnraAL5q+7eZsfCvo0XzSoCPQs9hz9ZD1lJRreX699gK3qVEpESqOnlKKx/B
 OtdscOfMhUu4J4ylYS7ta97n3RWOn8eqawCupCj5dEKEKc3h8Frp+Qo6zl7VMBnbqJ2yNQbZr
 VbMOIqvsAEQZlYHJgJXbcYkIfwtVqUXXOA6oSUIPf4AQVNU0qLCRLqmUpycBmuNMBAU3YMfFf
 eUcn5L1t1V3TJffm8Qzj1tNBN6N7ppswkeZa+ypnmlkUlSyNJm7nMPe932to1Hm2AyaZGukjH
 PwIVJ/g9ep6/guersaneAU6WX1TPfwZ3oFet3Tbixh8GQae0xokr0u5bLVSSpWg5tAXNa+DkZ
 SryVRvZf/4hhAcrAA81LwNv/P+fzXU749Nt1/aPfmFLZOgosSVK0q9mMNvQOWK8mkgycyO6CD
 thmfKh+GLLoVCGAOj64AUhJu13M1hjrJwr5BXUQmYviTp++9ZWYPR9wPftVZ3eJHNot5dsnyj
 lnDNKhcKOhtGhoDEWcrarwkXxdFH/rrW7+hf0/cWIwkpYOyGlUZhhRU/g4+kebowgCg8bdUWG
 /y6iAlZBGhIRvEz4kr1Bu6ppxa6c1U/DSesleMR4JnkAWBckbWY+gMkRKOL1T+cOIoYJhkY1+
 LRo2HsHqpoN6RXsCaIBODyjHw5D/8MSE0es8kMZEJFrXF3raXztjUziOBmVE6wXW7Mg+1c3jJ
 9VIUWf3ejXVncUPfTzr8zBckijFB7ROne4KgB6e+COHiA7cTbit+6HCnIb+7lTk8uc6fuGk8u
 Y77wNVFGNE8c5nyrSVR1FpDfYKKX8x9JICkf5jb2dApOefnYJxC1sykjKZC95pe7BhO/rECBy
 J+1D7yabujja2j/59wRJ28kUEV4qZg8FR013ZhzPmiweIBmGOapuc30JA+ZvwLi0JbvXFVg12
 LneZnpU+rG1z110QO1p7C6rZrXApe34t7JT8Mp3XQ81lwbylW23LuvhFFmcF+PsSXltcxMuq+
 r0byehDHS4eoDtt7TdVZ0sX4mevzUdBMob8A/a0WAn/sNNA+xylILq2YM4Vbl5hs0C7DNtRUU
 F3n3D2en5JvB/vgi7YWd9k/uaafpAhkz0g9sa5+2XoNP4DvTRcINwPGO3WvPjdm15KWM9BfGJ
 H6GkZbbfSXOMOO3NLnhvWdG3wp675ILIt2nGTb5mzfxXoTx33TWNfLndm99epxquruwHXku5F
 Nr1AVUUpjslDOLpi39XhsXeXTJW9qM8lHX/ZXHHjDulH796pCEN+hNXTLyJGP+fB8PEeRlE7L
 XMKIkPaTcL84QQ08ZYBnOpbZ2P/ZJ05k0XioY9Un3VHEB9JVEMpQmhYfTWHJa7mU16xRvwx3A
 JDtrfFQxy5FSFWxfx5WPBxgpgJdv4biwqPhgtO9fV8kaQi2s36fAj96ED467co0GYQ7oh/SIj
 MPa8gEQNeKcc/pqxQCRF/iBo7x15PuFR/Qud4tJ0LbkHCaYoNH+qUdJvlLhz0OSYCeTFxqxVL
 mPDkgd6naI9vRYQMuj6fDOkmxxIGFO1/gtFjyLEFtzUHa3Mp2nmOIagOS8t+9/p+t4EUQtMg7
 LPr6hh1h0J7PE+UvqWgmCr2QJ0D79mqHfX0NncGuaJW1A89+4eLJQw/HNI+8zXxRY9DFoaVQz
 Y+lG5BwPrdxtMvTf8b7y08xzgl0In0mPqjW51BccC9f6G5Svf8Vf8GQaUGDLsDSfyiF8hDI+C
 iXz06H1BrrJQllqZCLZ3MAuAdTupyzmlEoSBlG+Vf7X1HR3j/xLu216iRp3qa2SPiW0nWbQ57
 Xi49/pJTDSGWjL7ZttNAAwUSTWoctGqeNIJ6id5YYocDZ8EE8MxCXXVXgvHrRwdtFDKW1OrMv
 T0yNhwoy1zL7ASv2CpeDrrWaFo46EzfGZbpCH8ppkaDocZ5W9LSoqhsHC3WZhpivZek+3rpMc
 Mt/kUxW5ImVGbh1SDDXjk8427LOjgV4LkizXD9pmvsdq5D+7l13OJpYdy8RKiVLv/TAiHSAZS
 VF1JqyWli1Gxqx6pzNeeko45ICbVyjt/9FCIazjQCub5fy7INHhzrkiecjf8j9uuncsUcT+Dy
 ZaWHHgT6DDwpT4n3cG7bwMEogF2st8mWD7VYyFM5uwxtbUOLNYtTaWBP2PwbMojT1XpAYUCj0
 yU48fK6TJd1JLJ4knI4s7ect+OJZwSddu6e3FSn01CEz1BY0sWSrE50uuPQTDj5BqRmEELedN
 rjARDT0Mk96satzv+QUiV4TF7mZMGgzIZw4NFnoe8RCc060DixaGMKOXaJRItC5l8k6dth/I1
 QVg9x6dZgwJqBEmPb935zhNs40JeXry0Q3BzO8xPbCdBa0rC7yMrYgHpYF0Lxy9U1XjOsi7E+
 0Rd6NLwzkj+qg/9j5+DTB2HYFHkeTJBYmg7652V+tBem4RztQyw5bzpdVPSurT8gJ1wST+jna
 K9MLhZMXumTW+Vqh09cDtK9hiVjema4tHV+be00ujxaDFT/iSQzHL7XB2pWysIvzkpvjdhbLp
 3FMZDF3AB9UTYQ5sBWa1SZW6yU+ynvsUKr/OBBOALDnbWKyURGXPNpHvNRAjQ3hG6Dkib4u0y
 MOz+Rt/O0zf0JiWxjK1P7OR2Tb/q2ImudPll1yrL/4PdcLJNPeQCVarrJV4Gs3/WCN19H00vx
 mzNxrbTGwsK5yStBJQkEHFKFOnKr8puHtqInjJMzsOJkMXnCjzycM6Xm7dvXse7pvuev2+RRn
 OKUmwBd12QgMO7U/NeSwddkbiNSVU170CK6BS6hlVqv6/tKyzZ3GPmoUR7uOrPK/xXQ4BTSWR
 GhaF5Y69VqSNse4w6po0N0mzl8VnbpNYNHsAD300RhYohlhviiXx611ubR2npSSW+4nWvD2At
 zxVphmAeaWv8553krJ/38VdAnWSv/JIzjUfysEQXziUH/hfMc1VxkKNrKvFAZFQgraJPlhOr/
 I2feNtDMFz61KovCoAT3S2Vi4/gsPo+0aGa79ScIhxvawHlx1zWs7WeYBBGNOHO5WVMPzRz6P
 IZZNhqyIVuHb1pdujkDx3Iq6Sinighq6U4s1EhgcJe4RzE+JWpAEQP9Y53lxNYD6meWuVOtVr
 YNs023NMJ7VFgT3+HCaCh7mb9w3nZkJwOtP5HQu/bGKdggdPW+BK4Efg25pg68pp3zu3kEzpG
 IRuMvQ1dmvP1WTXeDYQn/rJfehfQsDV2SLcdXXqBi38UWRzMUKSWxVkRtTmrRcGTfB5SZMdWM
 JDl/ueTNYXUgOzJ5IRm9FI+/ssFQnJZWCjSs5e8ds1umujfDOrzvU+85D5TdQVJ7xipfny43l
 /uKeehiQ6IyK5uBJlJNnklQef8ty8Ji1NKqji45uSgmTDclF6WpYYjGLFq8/6N+WaZtAqAA6F
 sjwhP69Qeviq3b7yJN2z1Gxv4kRxlElpJix1tJGQ+Nc3dh+1SjM4EwvO6JC4wCkIVj7dmdB9v
 fO5q63T/1FXqpStU2JUaO3+q1Cyd/9ZnI8dFShDeWrLt0ZqN6Bq4oU6SOhOJVmc9Mcvxp9xTW
 djqBhnNACTyRObVzysVk/9btDPSnYzr+eE0s8CipDevsfEvxX1UmZMOxyct+j9RPmIvIRfkVP
 oQaMgcof7lNRvntVlo8PhzTlOFVTNUlV93Fz6EimmlxgX0fxy1pvmoYbaJLm7AczRhcbDkYdD
 I30qhmKfG1J9YICZFrXTl9shKbDeR8mK7KYRmw+P3i2ODXewXH/gn24Ygv1CevKRDhYOyRSDT
 fMAk622rOtif3Eobgjtu7Ab5ouSgzgp8T1gWr33hZ5MlqKWIDb7xk6yCyrFma1rsr++CAFeE3
 Kqcr+9XZxHCPrnh1p1bQ1PimVJl82wulyh0xrzyAry57BPkDCxQT1AH36wEAty99lHozkSPjC
 xt0f6qM8hj6IE5NXx/bR04ZbeDMWGtysO6pJHWr3p/8i9nbZDwBLLAK7wONSqsKTRqJE91/sV
 7SHisbf1GNmaOfd3sR30FDainHyLviCpj5F1bKsE+bOFGT/abl7XZdqqo2Lj0DvYNXB5oweyT
 WsB4NMibZLzO/3rFO+8VkFGmV5T9e6HA6Z/bYQHs/O+ziZi33xCStUYtIKukJrpaQ00oSywDt
 BnMyvrn8TEcZqFjoQBoacRRnabZznALpZF4hloQi0YC4U3kWPOUvw7ASeYloW+Fh60l5X/TCK
 QQ2ZYRBCDR3k4qX55VGpyWOnVi9Mlz3CE0lb7/9f9RC1d+nZuLqz+qBaCujtGlbqoj1pDK3Mr
 OJkiVyPCa0m41qrnEFQ0owO3AkyIN5cdY2DKwRe3urhh6RDoThMo3wFUj8mymcFVx4cV7zknD
 ur03MdxSdcg0yq1D9wF2lKCnbqhd5HmyCQxJSFjYw8Yrztimn9lSP94gzLfdMQ7HHfZ7IJ3On
 1mgZM8aYH1qcfIewojiaDE+Iea1w1NzUxuxdLVoA7vDWwmOPpnMskn3S0+MEABKzkN/a9utyx
 1qSLXugJvYPTodIRjrOEJ+vB31SFjzf1RGU0Y+TJfuhFYOsPjMa6g0hiAuoosQZz5HcXy1W2L
 N2nKH+vs1feWwosc0FFZWYf8szZ2QO5ZB74jAorRlcyf8NIuOHvWQxVd/GIB0LTKCJKtI2pkW
 +yniPUq22klYDUMr81H5PHCGSVWrLg/F/EeBbmdiNJNY8xebFZaKUtW2av93tsjxmbtubGD5N
 woxua8C38QDWpzrkjRJQP8+8BfGh6yqSE9ZSR0ztretsOSjnj6Vx0AIACayfIEMsqyQvaJJcy
 ZAWq+DMReco/2p7w3VoHhhHr2Cb3BuiisQYIgUZlTRclmSSZHDXYuhyfg4Venxi41qBOCG/09
 0o4m2ZFF2B0PSuhKUVsq9MZStZuT1Uy+LdkV/P3cvSx5lxjv3ynQq6keEIxLixkassPBK6BFy
 RIm3sjKSke/PJkoLS9QMj2v6Hx81BopfSp9IMfyu3xtRHT4GcqXIxuKYxQ5szIKaWbEU82dDy
 PSTf8Y6BWt8Q7hvEX9acdG5LH8gcaMUoWV/d7U3yRNwPOwVoWrrwMQqu7Iqp2bkgkG1HKbynJ
 YqFjInSlSA8B7iXB0kHdua3Ms9wJEoc4l7162fj2zo2adWGmTXSCPFR+yo8bLWaXiZ95gw2Fi
 klRngN+E8u76uwYCbxiMaumu7md6T6DHvGLRGxiTmX85Mw06EYCK+KzWgQ6O71qaFHt+pUIfP
 B4eKs85w/2Zzj0zaVk/IwFjWUAJ5mqyqDn+UvviVig==
Received-SPF: pass client-ip=217.72.192.78; envelope-from=lukasstraub2@web.de;
 helo=mout.web.de
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

--Sig_/.4JA8oKT9JPAaqU1SpKDr1e
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Thu, 19 Feb 2026 16:33:19 -0500
Peter Xu <peterx@redhat.com> wrote:

> On Wed, Feb 18, 2026 at 10:29:39PM +0100, Lukas Straub wrote:
> > In the colo migration unit test, we shutdown all sockets with yank and
> > then stop qemu with SIGTERM. During shutdown migration_shutdown() calls
> > migration_cancel(). Now the colo thread frees s->rp_state.from_dst_file
> > which races with migration_cancel() checking for NULL and potentially c=
alling
> > qemu_file_shutdown() on it.
> >=20
> > Fix this by taking the s->qemu_file_lock.
> >=20
> > Signed-off-by: Lukas Straub <lukasstraub2@web.de> =20
>=20
> The whole patch taking the mutex is reasonable, but it didn't explain one
> thing, on why COLO is special here on managing the return path channel..
>=20
> colo_process_checkpoint() does re-opening of rp channel even if it was
> partially shutdown before:
>=20
> colo_process_checkpoint():
>     s->rp_state.from_dst_file =3D qemu_file_get_return_path(s->to_dst_fil=
e);
>=20
> Should we instead leave all these to migration core?
> E.g. migration_completion() will do close_return_path_on_source(), but I
> wonder if that should only shutdown & close the return path channel when
> without COLO running.  Then IIUC we can also leave the cleanup of the
> qemufiles to migration_cleanup(), as it's also not special to COLO IIUC.
>=20
> What do you think?

It is a bit more involved since the return path needs to be always
opened for this. I implemented this in my current patchset.

Regards,
Lukas Straub

>=20
> Thanks,
>=20
> > ---
> >  migration/colo.c | 23 +++++++++++++++--------
> >  1 file changed, 15 insertions(+), 8 deletions(-)
> >=20
> > diff --git a/migration/colo.c b/migration/colo.c
> > index ce02c71d8857d470be434bdf3a9cacad3baab0d5..180793fe3f25140fa10887a=
cc3d87515ebf43ac9 100644
> > --- a/migration/colo.c
> > +++ b/migration/colo.c
> > @@ -173,11 +173,13 @@ static void primary_vm_do_failover(void)
> >       * The s->rp_state.from_dst_file and s->to_dst_file may use the
> >       * same fd, but we still shutdown the fd for twice, it is harmless.
> >       */
> > -    if (s->to_dst_file) {
> > -        qemu_file_shutdown(s->to_dst_file);
> > -    }
> > -    if (s->rp_state.from_dst_file) {
> > -        qemu_file_shutdown(s->rp_state.from_dst_file);
> > +    WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
> > +        if (s->to_dst_file) {
> > +            qemu_file_shutdown(s->to_dst_file);
> > +        }
> > +        if (s->rp_state.from_dst_file) {
> > +            qemu_file_shutdown(s->rp_state.from_dst_file);
> > +        }
> >      }
> > =20
> >      old_state =3D failover_set_state(FAILOVER_STATUS_ACTIVE,
> > @@ -544,11 +546,14 @@ static void colo_process_checkpoint(MigrationStat=
e *s)
> > =20
> >      failover_init_state();
> > =20
> > +    qemu_mutex_lock(&s->qemu_file_lock);
> >      s->rp_state.from_dst_file =3D qemu_file_get_return_path(s->to_dst_=
file);
> >      if (!s->rp_state.from_dst_file) {
> > +        qemu_mutex_unlock(&s->qemu_file_lock);
> >          error_report("Open QEMUFile from_dst_file failed");
> >          goto out;
> >      }
> > +    qemu_mutex_unlock(&s->qemu_file_lock);
> > =20
> >      packets_compare_notifier.notify =3D colo_compare_notify_checkpoint;
> >      colo_compare_register_notifier(&packets_compare_notifier);
> > @@ -640,9 +645,11 @@ out:
> >       * Or the failover BH may shutdown the wrong fd that
> >       * re-used by other threads after we release here.
> >       */
> > -    if (s->rp_state.from_dst_file) {
> > -        qemu_fclose(s->rp_state.from_dst_file);
> > -        s->rp_state.from_dst_file =3D NULL;
> > +    WITH_QEMU_LOCK_GUARD(&s->qemu_file_lock) {
> > +        if (s->rp_state.from_dst_file) {
> > +            qemu_fclose(s->rp_state.from_dst_file);
> > +            s->rp_state.from_dst_file =3D NULL;
> > +        }
> >      }
> >  }
> > =20
> >=20
> > --=20
> > 2.39.5
> >  =20
>=20


--Sig_/.4JA8oKT9JPAaqU1SpKDr1e
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmmgI8cACgkQNasLKJxd
slilXRAAiohWDgRiAzv2TO4bGIbltnZgLCfSDq3ZJk0+x27ervxIHLvstP1DyV3q
d+rh9KobMqx6Phh793Nh03r7UCQWBQKR9Sq/sRp5/Efc7IXt2J0IiPjfeT7AHNYx
bZpGrwkzUEv1Ynu3QCUn1a/YJrjO3wu7wLyz1q6uS8e8tBFIRG3zbxyLUWa1lIXS
gUekrWQtZp9XJFNOMhPTmVXfPh7g3BBZKmZCEyEz4icNwWMh0Wuhu6fAQxrqHUnu
siQVU3lB8VsIzxpBlAjt1JkCis0nOeDdFZHqVEP5oaKSv+XyM5kwmZIoLPRqJnFo
HDpvjoplNA54kqm0/rbOfsDXco8SlupUsdcoelsibBlkfLw+t2RKaF9I9kckae0v
1sMVcThy2OEWcccL7r72WIk5vihi/FQCp3uj/h97+hIK24ii1FK5Q9Poxnrsjzeh
cI1Z3/ucvT9UNMbi90QKasMPNhdjgOBJRyowiuW+Yo5Sjh6jFIF3HU6uJ6CCGDDA
3cmUhiLSxswrDbAi1P0rPAgvHXWP1wGsTSVlvTwysBbQZ+5XZzDCDfrc/EC6FeLp
LGBQei99P/hQ/fc2/cN6QgRZAIPtZL1cClmXqkLxdJrS4Yval8ZYRhWSrchruvFu
uKrjXbTk47zVqIU2m6O1ZbUZaAd2bq45nxI4309sqihEn2vs7ac=
=ZQSR
-----END PGP SIGNATURE-----

--Sig_/.4JA8oKT9JPAaqU1SpKDr1e--

