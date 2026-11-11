Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50E0F606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Nov 2026 23:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=alistair23.me header.i=@alistair23.me header.a=rsa-sha256 header.s=fm3 header.b=eRBT9tw2;
	dkim=pass (2048-bit key, unprotected) header.d=messagingengine.com header.i=@messagingengine.com header.a=rsa-sha256 header.s=fm3 header.b=20FAvLPI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRHpY-0004o2-7s; Wed, 11 Nov 2026 18:34:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xRHpW-0004nd-Cr
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 18:34:14 -0500
Received: from fhigh-b6-smtp.messagingengine.com ([202.12.124.157])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair@alistair23.me>)
 id 1xRHpT-0004Yb-QH
 for qemu-devel@nongnu.org; Wed, 11 Nov 2026 18:34:13 -0500
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
 by mailfhigh.stl.internal (Postfix) with ESMTP id 8A6487A01CF
 for <qemu-devel@nongnu.org>; Wed, 11 Nov 2026 18:34:10 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
 by phl-compute-01.internal (MEProxy); Wed, 11 Nov 2026 18:34:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alistair23.me;
 h=cc:cc:content-transfer-encoding:content-type:content-type
 :date:date:from:from:in-reply-to:in-reply-to:message-id
 :mime-version:references:reply-to:subject:subject:to:to; s=fm3;
 t=1794440050; x=1794526450; bh=xfF+6PvT84FVhWNiIazRAb41GU220XTS
 eSNUViwlxhI=; b=eRBT9tw27ZI32ElTa4MDTrYM7dGgW+syM1LgeTerhzSaM8/q
 5EBT76mCuFx/ADYBrYlSdZeLHukzWBjpLDNY2kiIPfHLItDPgpRmSix+AXSre9p/
 cvB5u1vrz8R/96J7bnnBJu3jnskj6vVs9HCdnvm06Ai1mIYXYkYXLmjhRH/cJ/UP
 bniCpdUXbPbsfUJhL9TvrlECDDNyVKSseFL9/CfdwKCvUTwFftrxMIu3s9X4crit
 zabIsqN5Z5hUMjhTAt7QKY0YjvN0eVk6ISVQ+KvpCxbsfFoBKb+zuuT/kELqueci
 CDVsWAXzUtGhTlkFFaXNMW8nOtz19aBlCFAlTQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
 messagingengine.com; h=cc:cc:content-transfer-encoding
 :content-type:content-type:date:date:feedback-id:feedback-id
 :from:from:in-reply-to:in-reply-to:message-id:mime-version
 :references:reply-to:subject:subject:to:to:x-me-proxy
 :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1794440050; x=
 1794526450; bh=xfF+6PvT84FVhWNiIazRAb41GU220XTSeSNUViwlxhI=; b=2
 0FAvLPITwpHwpRjQSZy65zQ5DUN7Kr5cjZvScSFuUMiqu/YxqKNus4X6UusWnhk0
 SVf6R7LSsjM1q95JkCGIajzGncDmUEIMI2oMhV2CXooz0Pmnjxbw5azm0xG3TOf3
 ro62BuxFnHBL3dZ+QZoZWrRZFUCjqGjBpukwOc9JCY5WXxABvTdN3bND/9ndJ13q
 FZ8gpioWUNMTH61IXoaIl841WLAA/LPx0YJls8FjfIHEUt9UtgNqAKYNcCfC7+ld
 bgFxJjx9dI0/uT45qOGGj69eO8jxz2LMS7EfWDq79nTq77hk0JAsh6CKIyamk7/j
 hmrdokeGlBDadtMUoHjzQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=sign d=alistair23.me a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1794440050; d=alistair23.me;
 mf=PGFsaXN0YWlyQGFsaXN0YWlyMjMubWU+;
 rt=PHFlbXUtZGV2ZWxAbm9uZ251Lm9yZz4=;
 s=fm3:rsa-sha256:TTW0AtOn1PGOxupcZVbOCQExAiTGDI6G3fsW82qN/o4vISJ
 OvU10fnY1Z/2VhzvV1xbfwj5pJ/xcI2G4Uk+ngREYJLTxZDsusxez3LOuBCqE88d
 7TCcyHPUe7zXUg5BAaKHUwnyUVIYO9GW0yALwRF0z4pNNYadzA6VwjVZvWcvlbuI
 Ry6EIzN0XpS4bsDG4y+0ONMCMSWh62bzZVecSB41NfAtz6YftiBuIqYBaKQ035n6
 GF/JL8YA8llE9CN8sgmpo4JjJ6QApBKdS5u6fkThIKznLb9n0UWZwXCxsJBalwM7
 4aOtoXtEc/FzHo60B/mBOlGrT13UwOwugfGWPZA==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-09;
 repo=github.com/dkim2wg/interop; date=2026-11-03; sw=lmtpprox;
 action=mi-m=1; hc=13;
 hn=cc,content-transfer-encoding,content-type,date,feedback-id,
 from,in-reply-to,message-id,mime-version,references,subject,to,
 user-agent;
Message-Instance: m=1;
 h=sha256:2NR93KcIsTI00QyI68EnWpstLQBXjfa4htWNqN0sewc=:xfF+6PvT84FVhWNiIazRAb41GU220XTSeSNUViwlxhI=;
X-ME-Sender: <xms:cPv0aiO36VE2HudTLe_-KPBaqS9Fft_tHhOhtgbVlZJ8P6O2JZujkA>
 <xme:cPv0aoZjIrtGFWe6CeJC9tIfC890OUNqFFcVhSlmzwSb4k0OU2je8Z8tj6eFvC6AN
 3jb8oMrcPvq-yhWlsH5uug8U4LZh7fJL5ABeqFzxwoCDodJSvQOuSjH>
X-ME-Received: <xmr:cPv0amrMFLvd70NRqw7bDua5AGnAVZJm239vd19eMHBwWhw8yriNeFRlnGfYDXzRxKoo5anUdfR4tM5A4wPwquTqdwI>
X-ME-Proxy-Cause: dmFkZTGclP/yB7YXXyQvqElfFzrp6W0qkd0XmX08XMQv1T/NEmlk+0ny2ATlUffIkKUX7Z
 DaoeVnokgpMfQ3myi9q3SWSkyVaOGXcLkF3W6nJ/M/gbPsfScDDaOZcLhal6/hHV7mjQY1
 r7IKyMp0m+JYI9E/MJDTGqk7KHLd0qyOpjvSPsSjqiZyt6/lV/zY94Be2OFOhaS0QNBqJC
 bw2OIndcVMpk1yO9bdEthYxyW9KaEMwkPU5QGxexIkJ/rQFMfM9iS97NDXocG5SsbF7Omi
 i7TCKG2GKGBRUn/5tDrevSJGY2W3SCdSaglDhc8nLjh3TYkwddA/nUFOP5gH1fyzSiLJAq
 iNkmt3Wvwq80AszebknhYUUE3NDJw7F8s6UTidy6jxd6kxNb6N5W/c+/p54J+r7EXx30xX
 OTaDF+ND7QTCG3mMAJ7f/8Hb/hfdXi0FMSdOrtyDT/j7t+nyQYjNqU3d6hNqcU4y3fyhXq
 0uUG/BKG+e+1Z+rQtK0s/QR2viekmCLpIzDcvP5mCdUZ+LkwwAEWfQBXQH9vIi36htv9h5
 MnalnbFzhIavjdidP+TQaIhfn75vWOpG2Sj7HWHXRBCEm3xuPROKgtksWWv5Fqp67MtFn1
 lvIXfoIPzWmzDSZOcEqt1GGgNoSRpk6jZlmvyTrk21XJ2PVkckRUK4GvbuHQ
X-ME-Proxy: <xmx:cPv0asbIBJ4FHU7DK-HkRmPtLtVeO27A_6xjFFBmhcW8d8IEW1mJdg>
 <xmx:cPv0auTbVMlk5QSLcsMSwhMDZf9lAeBrZ1_3LFtNarGjkw8OwaZA9A>
 <xmx:cPv0aj75cW-JZJ5211e2tssBwWkNoOESptFD3qVzrMePWlKpFBiOYg>
 <xmx:cPv0ajzdb9A3DY1DmeCpBB7PArABebLHJJKRTKIGls5morBZ_gkPAw>
 <xmx:cvv0ahBhvtGkBMWbzE_CLLE_pievJXtWqNP8_Yb1ulCzFGzZZKTZIHns>
Feedback-ID: ifd214418:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 11 Nov 2026 18:34:07 -0500 (EST)
Message-ID: <20f168fb2615777ff875a9d4891533c0113331de.camel@alistair23.me>
Subject: Re: [PATCH] linux-user/vdso: make the binaries reproducible
From: Alistair <alistair@alistair23.me>
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
Date: Thu, 12 Nov 2026 09:34:04 +1000
In-Reply-To: <20261111121259.14941-1-mjt@tls.msk.ru>
References: <20261111121259.14941-1-mjt@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.62.1 (by Flathub.org) 
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Received-SPF: pass client-ip=202.12.124.157;
 envelope-from=alistair@alistair23.me; helo=fhigh-b6-smtp.messagingengine.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 2026-11-11 at 15:12 +0300, Michael Tokarev wrote:
> Currently the linux-user vdso*.so files are not reproducible,
> because for one, the binaries embed a random temporary file
> name used by the compiler during compilation, such as ccuckKYd.o.
>=20
> At the very least, use -pipe to avoid the need to have a temp
> file in the first place - this makes the build repeatable.
>=20
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
> =C2=A0linux-user/aarch64/Makefile.vdso=C2=A0=C2=A0=C2=A0=C2=A0 | 6 ++++--
> =C2=A0linux-user/arm/Makefile.vdso=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 8 +++++---
> =C2=A0linux-user/hppa/Makefile.vdso=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 4 +++-
> =C2=A0linux-user/i386/Makefile.vdso=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 | 4 +++-
> =C2=A0linux-user/loongarch64/Makefile.vdso | 4 +++-
> =C2=A0linux-user/ppc/Makefile.vdso=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 8 +++++---
> =C2=A0linux-user/riscv/Makefile.vdso=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 6 ++++--
> =C2=A0linux-user/s390x/Makefile.vdso=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 =
| 4 +++-
> =C2=A0linux-user/sh4/Makefile.vdso=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 | 6 ++++--
> =C2=A0linux-user/x86_64/Makefile.vdso=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 | 4 +=
++-
> =C2=A010 files changed, 37 insertions(+), 17 deletions(-)
>=20
> diff --git a/linux-user/aarch64/Makefile.vdso b/linux-
> user/aarch64/Makefile.vdso
> index 82ed201108..1789b67268 100644
> --- a/linux-user/aarch64/Makefile.vdso
> +++ b/linux-user/aarch64/Makefile.vdso
> @@ -3,6 +3,8 @@ include $(BUILD_DIR)/linux-user/aarch64/config-
> target.mak
> =C2=A0SUBDIR =3D $(SRC_PATH)/linux-user/aarch64
> =C2=A0VPATH +=3D $(SUBDIR)
> =C2=A0
> +REPRODUCIBLE =3D -pipe
> +
> =C2=A0all: $(SUBDIR)/vdso-be.so $(SUBDIR)/vdso-le.so
> =C2=A0
> =C2=A0LDFLAGS =3D -nostdlib -shared -Wl,-h,linux-vdso.so.1 \
> @@ -10,7 +12,7 @@ LDFLAGS =3D -nostdlib -shared -Wl,-h,linux-vdso.so.1
> \
> =C2=A0=09=C2=A0 -Wl,-z,max-page-size=3D4096 -Wl,-T,$(SUBDIR)/vdso.ld
> =C2=A0
> =C2=A0$(SUBDIR)/vdso-be.so: vdso.S vdso.ld
> -=09$(CC) -o $@ $(LDFLAGS) -mbig-endian $<
> +=09$(CC) $(REPRODUCIBLE) -o $@ $(LDFLAGS) -mbig-endian $<
> =C2=A0
> =C2=A0$(SUBDIR)/vdso-le.so: vdso.S vdso.ld
> -=09$(CC) -o $@ $(LDFLAGS) -mlittle-endian $<
> +=09$(CC) $(REPRODUCIBLE) -o $@ $(LDFLAGS) -mlittle-endian $<
> diff --git a/linux-user/arm/Makefile.vdso b/linux-
> user/arm/Makefile.vdso
> index 16ae8d7aaa..360b77185f 100644
> --- a/linux-user/arm/Makefile.vdso
> +++ b/linux-user/arm/Makefile.vdso
> @@ -3,6 +3,8 @@ include $(BUILD_DIR)/linux-user/arm/config-target.mak
> =C2=A0SUBDIR =3D $(SRC_PATH)/linux-user/arm
> =C2=A0VPATH +=3D $(SUBDIR)
> =C2=A0
> +REPRODUCIBLE =3D -pipe
> +
> =C2=A0all: $(SUBDIR)/vdso-be8.so $(SUBDIR)/vdso-be32.so $(SUBDIR)/vdso-
> le.so
> =C2=A0
> =C2=A0# Adding -use-blx disables unneeded interworking without actually
> using blx.
> @@ -11,10 +13,10 @@ LDFLAGS =3D -nostdlib -shared -Wl,-use-blx -Wl,-
> z,max-page-size=3D4096 \
> =C2=A0=09=C2=A0 -Wl,--hash-style=3Dboth -Wl,-T,$(SUBDIR)/vdso.ld
> =C2=A0
> =C2=A0$(SUBDIR)/vdso-be8.so: vdso.S vdso.ld vdso-asmoffset.h
> -=09$(CC) -o $@ $(LDFLAGS) -mbig-endian -mbe8 $<
> +=09$(CC) $(REPRODUCIBLE) -o $@ $(LDFLAGS) -mbig-endian -mbe8 $<
> =C2=A0
> =C2=A0$(SUBDIR)/vdso-be32.so: vdso.S vdso.ld vdso-asmoffset.h
> -=09$(CC) -o $@ $(LDFLAGS) -mbig-endian -mbe32 $<
> +=09$(CC) $(REPRODUCIBLE) -o $@ $(LDFLAGS) -mbig-endian -mbe32
> $<
> =C2=A0
> =C2=A0$(SUBDIR)/vdso-le.so: vdso.S vdso.ld vdso-asmoffset.h
> -=09$(CC) -o $@ $(LDFLAGS) -mlittle-endian $<
> +=09$(CC) $(REPRODUCIBLE) -o $@ $(LDFLAGS) -mlittle-endian $<
> diff --git a/linux-user/hppa/Makefile.vdso b/linux-
> user/hppa/Makefile.vdso
> index 78642c4266..5f3f2ddde9 100644
> --- a/linux-user/hppa/Makefile.vdso
> +++ b/linux-user/hppa/Makefile.vdso
> @@ -3,9 +3,11 @@ include $(BUILD_DIR)/linux-user/hppa/config-
> target.mak
> =C2=A0SUBDIR =3D $(SRC_PATH)/linux-user/hppa
> =C2=A0VPATH +=3D $(SUBDIR)
> =C2=A0
> +REPRODUCIBLE =3D -pipe
> +
> =C2=A0all: $(SUBDIR)/vdso.so
> =C2=A0
> =C2=A0$(SUBDIR)/vdso.so: vdso.S vdso.ld vdso-asmoffset.h
> -=09$(CC) -o $@ -nostdlib -shared -Wl,-h,linux-vdso32.so.1 \
> +=09$(CC) $(REPRODUCIBLE) -o $@ -nostdlib -shared -Wl,-h,linux-
> vdso32.so.1 \
> =C2=A0=09=C2=A0 -Wl,--build-id=3Dsha1 -Wl,--hash-style=3Dboth \
> =C2=A0=09=C2=A0 -Wl,-T,$(SUBDIR)/vdso.ld $<
> diff --git a/linux-user/i386/Makefile.vdso b/linux-
> user/i386/Makefile.vdso
> index ca2e37fa6b..e797c5c7fe 100644
> --- a/linux-user/i386/Makefile.vdso
> +++ b/linux-user/i386/Makefile.vdso
> @@ -3,9 +3,11 @@ include $(BUILD_DIR)/linux-user/i386/config-
> target.mak
> =C2=A0SUBDIR =3D $(SRC_PATH)/linux-user/i386
> =C2=A0VPATH +=3D $(SUBDIR)
> =C2=A0
> +REPRODUCIBLE =3D -pipe
> +
> =C2=A0all: $(SUBDIR)/vdso.so
> =C2=A0
> =C2=A0$(SUBDIR)/vdso.so: vdso.S vdso.ld vdso-asmoffset.h
> -=09$(CC) -o $@ -m32 -nostdlib -shared -Wl,-h,linux-gate.so.1 \
> +=09$(CC) $(REPRODUCIBLE) -o $@ -m32 -nostdlib -shared -Wl,-
> h,linux-gate.so.1 \
> =C2=A0=09=C2=A0 -Wl,--build-id=3Dsha1 -Wl,--hash-style=3Dboth \
> =C2=A0=09=C2=A0 -Wl,-T,$(SUBDIR)/vdso.ld $<
> diff --git a/linux-user/loongarch64/Makefile.vdso b/linux-
> user/loongarch64/Makefile.vdso
> index ceb6110120..64a422e66d 100644
> --- a/linux-user/loongarch64/Makefile.vdso
> +++ b/linux-user/loongarch64/Makefile.vdso
> @@ -3,10 +3,12 @@ include $(BUILD_DIR)/linux-user/loongarch64/config-
> target.mak
> =C2=A0SUBDIR =3D $(SRC_PATH)/linux-user/loongarch64
> =C2=A0VPATH +=3D $(SUBDIR)
> =C2=A0
> +REPRODUCIBLE =3D -pipe
> +
> =C2=A0all: $(SUBDIR)/vdso.so
> =C2=A0
> =C2=A0$(SUBDIR)/vdso.so: vdso.S vdso.ld vdso-asmoffset.h
> -=09$(CC) -o $@ -nostdlib -shared -fpic -Wl,-h,linux-vdso.so.1 \
> +=09$(CC) $(REPRODUCIBLE) -o $@ -nostdlib -shared -fpic -Wl,-
> h,linux-vdso.so.1 \
> =C2=A0=09=C2=A0 -Wl,--build-id=3Dsha1 -Wl,--hash-style=3Dboth \
> =C2=A0=09=C2=A0 -Wl,--no-warn-rwx-segments -Wl,-z,max-page-size=3D4096 \
> =C2=A0=09=C2=A0 -Wl,-T,$(SUBDIR)/vdso.ld $<
> diff --git a/linux-user/ppc/Makefile.vdso b/linux-
> user/ppc/Makefile.vdso
> index 6b9be84381..87a2bc1c57 100644
> --- a/linux-user/ppc/Makefile.vdso
> +++ b/linux-user/ppc/Makefile.vdso
> @@ -3,6 +3,8 @@ include $(BUILD_DIR)/linux-user/ppc64/config-
> target.mak
> =C2=A0SUBDIR =3D $(SRC_PATH)/linux-user/ppc
> =C2=A0VPATH +=3D $(SUBDIR)
> =C2=A0
> +REPRODUCIBLE =3D -pipe
> +
> =C2=A0all: $(SUBDIR)/vdso-32.so $(SUBDIR)/vdso-64.so $(SUBDIR)/vdso-
> 64le.so
> =C2=A0
> =C2=A0LDFLAGS32 =3D -nostdlib -shared -Wl,-T,$(SUBDIR)/vdso-32.ld \
> @@ -13,10 +15,10 @@ LDFLAGS64 =3D -nostdlib -shared -Wl,-
> T,$(SUBDIR)/vdso-64.ld \
> =C2=A0=09=C2=A0=C2=A0=C2=A0 -Wl,--build-id=3Dsha1 -Wl,-z,max-page-size=3D=
4096
> =C2=A0
> =C2=A0$(SUBDIR)/vdso-32.so: vdso.S vdso-32.ld vdso-asmoffset.h
> -=09$(CC) -o $@ $(LDFLAGS32) -m32 $<
> +=09$(CC) $(REPRODUCIBLE) -o $@ $(LDFLAGS32) -m32 $<
> =C2=A0
> =C2=A0$(SUBDIR)/vdso-64.so: vdso.S vdso-64.ld vdso-asmoffset.h
> -=09$(CC) -o $@ $(LDFLAGS64) -mbig-endian $<
> +=09$(CC) $(REPRODUCIBLE) -o $@ $(LDFLAGS64) -mbig-endian $<
> =C2=A0
> =C2=A0$(SUBDIR)/vdso-64le.so: vdso.S vdso-64.ld vdso-asmoffset.h
> -=09$(CC) -o $@ $(LDFLAGS64) -mlittle-endian $<
> +=09$(CC) $(REPRODUCIBLE) -o $@ $(LDFLAGS64) -mlittle-endian $<
> diff --git a/linux-user/riscv/Makefile.vdso b/linux-
> user/riscv/Makefile.vdso
> index 2eefdb70cf..2a47a3113d 100644
> --- a/linux-user/riscv/Makefile.vdso
> +++ b/linux-user/riscv/Makefile.vdso
> @@ -3,13 +3,15 @@ include $(BUILD_DIR)/linux-user/riscv64/config-
> target.mak
> =C2=A0SUBDIR =3D $(SRC_PATH)/linux-user/riscv
> =C2=A0VPATH +=3D $(SUBDIR)
> =C2=A0
> +REPRODUCIBLE =3D -pipe
> +
> =C2=A0all: $(SUBDIR)/vdso-32.so $(SUBDIR)/vdso-64.so
> =C2=A0
> =C2=A0LDFLAGS =3D -nostdlib -shared -fpic -Wl,-h,linux-vdso.so.1 -Wl,--
> build-id=3Dsha1 \
> =C2=A0=09=C2=A0 -Wl,--hash-style=3Dboth -Wl,-T,$(SUBDIR)/vdso.ld
> =C2=A0
> =C2=A0$(SUBDIR)/vdso-32.so: vdso.S vdso.ld vdso-asmoffset.h
> -=09$(CC) -o $@ $(LDFLAGS) -mabi=3Dilp32d -march=3Drv32g $<
> +=09$(CC) $(REPRODUCIBLE) -o $@ $(LDFLAGS) -mabi=3Dilp32d -
> march=3Drv32g $<
> =C2=A0
> =C2=A0$(SUBDIR)/vdso-64.so: vdso.S vdso.ld vdso-asmoffset.h
> -=09$(CC) -o $@ $(LDFLAGS) -mabi=3Dlp64d -march=3Drv64g $<
> +=09$(CC) $(REPRODUCIBLE) -o $@ $(LDFLAGS) -mabi=3Dlp64d -
> march=3Drv64g $<
> diff --git a/linux-user/s390x/Makefile.vdso b/linux-
> user/s390x/Makefile.vdso
> index 51f7c50a2d..65ac267239 100644
> --- a/linux-user/s390x/Makefile.vdso
> +++ b/linux-user/s390x/Makefile.vdso
> @@ -3,9 +3,11 @@ include $(BUILD_DIR)/linux-user/s390x/config-
> target.mak
> =C2=A0SUBDIR =3D $(SRC_PATH)/linux-user/s390x
> =C2=A0VPATH +=3D $(SUBDIR)
> =C2=A0
> +REPRODUCIBLE =3D -pipe
> +
> =C2=A0all: $(SUBDIR)/vdso.so
> =C2=A0
> =C2=A0$(SUBDIR)/vdso.so: vdso.S vdso.ld vdso-asmoffset.h
> -=09$(CC) -o $@ -nostdlib -shared -Wl,-h,linux-vdso64.so.1 \
> +=09$(CC) $(REPRODUCIBLE) -o $@ -nostdlib -shared -Wl,-h,linux-
> vdso64.so.1 \
> =C2=A0=09=C2=A0 -Wl,--build-id=3Dsha1 -Wl,--hash-style=3Dboth \
> =C2=A0=09=C2=A0 -Wl,-T,$(SUBDIR)/vdso.ld $<
> diff --git a/linux-user/sh4/Makefile.vdso b/linux-
> user/sh4/Makefile.vdso
> index ed2cc11b82..97375a4783 100644
> --- a/linux-user/sh4/Makefile.vdso
> +++ b/linux-user/sh4/Makefile.vdso
> @@ -3,6 +3,8 @@ include $(BUILD_DIR)/linux-user/sh4/config-target.mak
> =C2=A0SUBDIR =3D $(SRC_PATH)/linux-user/sh4
> =C2=A0VPATH +=3D $(SUBDIR)
> =C2=A0
> +REPRODUCIBLE =3D -pipe
> +
> =C2=A0all: $(SUBDIR)/vdso-le.so $(SUBDIR)/vdso-be.so
> =C2=A0
> =C2=A0LDFLAGS =3D -nostdlib -shared -Wl,-h,linux-gate.so.1 \
> @@ -10,9 +12,9 @@ LDFLAGS =3D -nostdlib -shared -Wl,-h,linux-gate.so.1
> \
> =C2=A0=09=C2=A0 -Wl,-T,$(SUBDIR)/vdso.ld
> =C2=A0
> =C2=A0$(SUBDIR)/vdso-le.so: vdso.S vdso.ld vdso-asmoffset.h
> -=09$(CC) -o $@ $(LDFLAGS) -ml $<
> +=09$(CC) $(REPRODUCIBLE) -o $@ $(LDFLAGS) -ml $<
> =C2=A0
> =C2=A0CC_BE =3D sh4eb-unknown-linux-gnu-gcc
> =C2=A0
> =C2=A0$(SUBDIR)/vdso-be.so: vdso.S vdso.ld vdso-asmoffset.h
> -=09$(CC_BE) -o $@ $(LDFLAGS) $<
> +=09$(CC_BE) $(REPRODUCIBLE) -o $@ $(LDFLAGS) $<
> diff --git a/linux-user/x86_64/Makefile.vdso b/linux-
> user/x86_64/Makefile.vdso
> index 56fe87af72..41281ffe0a 100644
> --- a/linux-user/x86_64/Makefile.vdso
> +++ b/linux-user/x86_64/Makefile.vdso
> @@ -3,9 +3,11 @@ include $(BUILD_DIR)/linux-user/x86_64/config-
> target.mak
> =C2=A0SUBDIR =3D $(SRC_PATH)/linux-user/x86_64
> =C2=A0VPATH +=3D $(SUBDIR)
> =C2=A0
> +REPRODUCIBLE =3D -pipe
> +
> =C2=A0all: $(SUBDIR)/vdso.so
> =C2=A0
> =C2=A0$(SUBDIR)/vdso.so: vdso.S vdso.ld
> -=09$(CC) -o $@ -nostdlib -shared -Wl,-h,linux-vdso.so.1 \
> +=09$(CC) $(REPRODUCIBLE) -o $@ -nostdlib -shared -Wl,-h,linux-
> vdso.so.1 \
> =C2=A0=09=C2=A0 -Wl,--build-id=3Dsha1 -Wl,--hash-style=3Dboth \
> =C2=A0=09=C2=A0 -Wl,-T,$(SUBDIR)/vdso.ld $<

