Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69456606A31A
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 17:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aule4Jlp
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJwI1-00022f-Rx; Thu, 22 Oct 2026 13:09:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xJwHv-00021I-Hx
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 13:09:13 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xJwHs-0000m4-5Y
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 13:09:11 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa377c61so2793938a12.3
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 10:09:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792688946; cv=none;
 d=google.com; s=arc-20260327;
 b=bWpilcMY7z4dASLxbElIeAiz2ESvjTYhhXBFDGKcbvaeXQgYeSBG/uO2ocgJsGlVrj
 eOULJxWOR/Km80Q+4DkuIkWV6YWG8LcwEXv5HNO7hIRIh3hEPHrn1h7w+xh+2xmhDeO8
 pWP7i3fxdYH6saZ4CNjHAFqH1AwxAX4QIqn9eJqf+OGEtzytn/qTdMJ6NrL3TkCN/RZP
 Qkpi9YqcEzum97Rv+VZi1Anbvh55aI0LuVXB3ysMZ8u+XM70Xm4fT9puYEYBAn0bCC7B
 NGOKdxol9PH7/sqnrZU9BWf04ELZkYYCpDovCTLXNDQy4EdAwZzt4OKZmWcgqqtTsXjm
 aZyg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=fbB1fMgZgjJs8QmzN6GpsNzp15IN/fxVVaMbYPFR/BY=;
 fh=Z10wg4GlF8AsPcVEhZ6x6f9z5OdCMIaeKnidQlIT0uY=;
 b=AfqTXg20SCcWBGtHXQj1WiNFxNBRMUJQyZ4FyN/bVMAe9TrP2pQOowCFWiuYdbJN6S
 PHY4xBCzk0KyTJP4UJy54WoBE7Ni1EiBvVUy72zu1f+QzbLhirDPIZQrmMhhvDXmwNuC
 WtuFGAbIL91rlKmSrXX5fAa+K0Dpm2f2h3NfHvhPWMzIulsANLbNWdtMq7xuNZ1GwNH+
 ZkFO8mbu8MCOOG8S7t4KJ9iEcu23PW3sUytcpVGA7K5ycHd03f+5eoELVXHW9Jpv/Ttr
 jHdYd604pjogkAW1OQBujmOqrGhxz9ZKh+wXOxrugv0tyI6P9jUV+ycxW9qSoAZ/JWCa
 nHkA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792688946; x=1793293746; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=fbB1fMgZgjJs8QmzN6GpsNzp15IN/fxVVaMbYPFR/BY=;
 b=aule4JlpOJmS6SAzYlWTeo3wXU0rW3q+Qy+3VOe6qRcf8TAn1l5pd4xDai/RnPKxQt
 zRwxpTJdsjir3GkA8eOlR1R5/LXDWZzA6Y6W4ITkHNnpOlNqZOsz0uelFCTt54z5FqQb
 K0B2MVEpqT29r3vReG2zsi1zsK1jLU+I62ifEmg2goLUVJ+dqA5t6pR59AryfX76HETV
 Fg+cjYpaO1bXln8CCRXTliTdH9ZemgnFOuNtKjv4dHY+8bjm8EW80LZnSbE2EyrG4/jZ
 UYE+/51CNbiEb3lp+L7UI9tDbfDTAWBrD4oMsl3xccKYLhnc9PfHAAvqj+VyvrG48/JU
 G+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792688946; x=1793293746;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=fbB1fMgZgjJs8QmzN6GpsNzp15IN/fxVVaMbYPFR/BY=;
 b=Yd68HcIBiQ3LPmkGGvVnK56cU5LVPAdL3AdV1HlIRH9oTf1UWzmMhWMclI9PnQviXd
 egtjjzTpU9nUrj5jNGUcRm2MlJQiZKcj3+mAaie9vFBBoEDjk5ifxOgA0pD8GH2r4eEz
 pNL1XohS0VmIDuVe1XFIB5qceQwuVlI9DFiut/1YByQTPuJ71aa73E6lCMU1Xw1+aXFW
 ZY1kZQ8UlXkPkII0Jv2DEHD89YATbuKTr36ZjJ6/QpAJQqCmaHwvq/Q1nxHKUtS/Nnhq
 Syjdhlw7Qwn6C9oC5Amkrkc1IKcZnvkZ1YRqcl+wQZJ8tzRhgFHLfkiGDtt8xyXToqVT
 wxQQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxZ3hraFEOW8aOpwRswPgLKlqnGjV2UzOiIsn1MSeAzIYfH9D/dFOmcdwJx5RJtXjPszlLPs0CT/Av6@nongnu.org
X-Gm-Message-State: AFq9FYKJGLi/wimqF5UeG/guwLA8YHXu+0aJbdTzPZ1p1MsR9xqdJqj9
 TcRZJ2N9h7uzVJAtpoTTJrjtjwChMoCciWu6dG0lvLgkq3r0WL7Mg+YT13O5O3h6ubFc/poGNqL
 P8yqNjeVdDaY4Z605irLvr+JBqNVXFX8=
X-Gm-Gg: AYBFou1C8QF6sKCjbpOF6ntNAm3pa77NE6zEkqqSPs2lPyTDTw9jxaueyGeL8yt2oj6
 0l6/Y0J3WKefqmuxts6JeKdXfFsZ/3g8fAuHrXW39EV1Fh2OCzPahuoJmwP3UwXQBkj9heiuzOi
 1M8gp6Tt795bQSJEO3E/A2Nqq7mVkiztWC0PlCV93QFE75xaFllvuGieXmtZXsajFIF5f4bgYdy
 Dh/VO6D45JO+PVQExFaEPlIm7tgwGbF6IZSYEmiBq62w4VrSHe0s5xgDUe2OwKM2UYyUPM5B3oo
 9/h15wu0ACROXj9bHbx1hjRJvZni8WaGsGNRfWiZE7pu6BBSufflPFxSyzhb9/Fjtu5JIDKpItW
 QSj3qxPWRC6tSubYimcdME8BZPfBm4ci4G06AEtQHl4fsMCWcbF3iSJBirQ==
X-Received: by 2002:a05:6402:c50:b0:6b3:d0a0:228c with SMTP id
 4fb4d7f45d1cf-6b432bf0c0emr57658a12.16.1792688946098; Thu, 22 Oct 2026
 10:09:06 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
 <atoF3WQrtsFPfxkP@hive.localdomain>
In-Reply-To: <atoF3WQrtsFPfxkP@hive.localdomain>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Fri, 23 Oct 2026 01:08:53 +0800
X-Gm-Features: AclHuK8j2zAJAz1K-BcGK1Sc5k4jBAJwWH9vkw-iUBAOA2I8TB6iksuG0hVM5sc
Message-ID: <CAE2XoE8UA0ZWivMOZa1qcK=S5nVU_urzgVQ2fbxEG1jahD2Xag@mail.gmail.com>
Subject: Re: [PATCH 00/26] multi-target: prefix helpers with target prefix
To: Anton Johansson <anjo@rev.ng>
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x533.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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
Reply-To: luoyonggang@gmail.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, Oct 22, 2026 at 8:52=E2=80=AFPM Anton Johansson via qemu developmen=
t
<qemu-devel@nongnu.org> wrote:
>
> On 19/10/26, Pierrick Bouvier wrote:
> > When linking multiple targets together, we usually have conflicts with =
helper
> > names. So far, it was solved using ad-hoc renaming, but multiple people=
 pointed it
> > would be better to have a general mechanism for it, so here it is.
> >
> > A previous series attempted that:
> > https://lore.kernel.org/qemu-devel/20260930073935.712-1-luoyonggang@gma=
il.com/,
> > but it was relying on (binary) symbol renaming, which is not a portable=
 solution.
> > Instead, this series approaches the problem from source code directly.
> > It requires more change, but it's cleaner IMHO.
> >
> > Series follows these steps:
> >
> > First, we make sure all helpers and definition are using HELPER() macro=
. A lot
> > of helpers were already defined this way, we just make sure it's exhaus=
tive.
> > After that we don't have any 'helper_' left on any target code. This is=
 a big
> > change touching the whole codebase, but it's a simple mechanical change=
. As long
> > as it compiles and links, we know it's correct.
> >
> > Then, we introduce the prefix for target helpers. For this , we add a n=
ew define
> > (from meson) that applies to all target related code. It could later be=
 used to
> > prefix other symbols also, that's why it's not named "TCG".
> >
> > Finally, we cleanup the previous manual helpers prefix that were added =
in
> > codebase.
> >
> > Pierrick Bouvier (26):
> >   target/alpha: define and call helpers using HELPER macro
> >   target/arm: define and call helpers using HELPER macro
> >   target/avr: define and call helpers using HELPER macro
> >   target/hppa: define and call helpers using HELPER macro
> >   target/i386: define and call helpers using HELPER macro
> >   target/loongarch: define and call helpers using HELPER macro
> >   target/m68k: define and call helpers using HELPER macro
> >   target/microblaze: define and call helpers using HELPER macro
> >   target/mips: define and call helpers using HELPER macro
> >   target/or1k: define and call helpers using HELPER macro
> >   target/ppc: define and call helpers using HELPER macro
> >   target/riscv: define and call helpers using HELPER macro
> >   target/rx: define and call helpers using HELPER macro
> >   target/s390x: define and call helpers using HELPER macro
> >   target/sh4: define and call helpers using HELPER macro
> >   target/sparc: define and call helpers using HELPER macro
> >   target/tricore: define and call helpers using HELPER macro
> >   tcg: introduce HELPER_INFO macro
> >   tcg: prefix helpers with target base architecture
> >   target/alpha: remove explicit target specific prefix
> >   target/hexagon: remove explicit target specific prefix
> >   target/hppa: remove explicit target specific prefix
> >   target/microblaze: remove explicit target specific prefix
> >   target/or1k: remove explicit target specific prefix
> >   target/rx: remove explicit target specific prefix
> >   target/tricore: remove explicit target specific prefix
>
> Hi, since this allows us to link different targets together with clashing
> helper names, what about going one step further to allow symbol
> collisions between say riscv32/64 etc.? It would make converting targets
> to heterogeoneous emulation much easier since you could just compile
> op_helper.c and translate.c twice and select different function pointers
> based on target_*().

Hi I've done that, do I need to post those patches? and indeed working!
Except, I need to define target_ulong to be always uint64_t. And I tried it=
 for
both riscv/i386.

>
> When I played around with this I ended up splitting helper.h in to
> helper-common.h and helper-target.h, where the latter would get an extra
> helper_*_tl32_*() prefix and could be compiled twice. But I recall you
> mentioning this might be too much helper magic.
>
> Just throwing ideas out there, either way the current series is good.
>
> Series:
> Reviewed-by: Anton Johansson <anjo@rev.ng>
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

