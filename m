Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6501C606A31B
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Nov 2026 18:21:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=bOOGQihq
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xP24o-0003Xl-Pw; Thu, 05 Nov 2026 13:20:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP24Y-0003O2-KX
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 13:20:27 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xP24U-00060K-6j
 for qemu-devel@nongnu.org; Thu, 05 Nov 2026 13:20:25 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-6b1aa2848d2so3587409a12.3
 for <qemu-devel@nongnu.org>; Thu, 05 Nov 2026 10:20:16 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793902815; cv=none;
 d=google.com; s=arc-20260327;
 b=eyKXqNsMTF5GJyoh8tsuCkA5QNtwdVa+QH6bmZBeAWiheo4LmsFJB01utjmq5Mic6r
 OnKxwuslzl3farA/O8+boCXR/luXtnHk6l/NWmN97isHalfTG/jzdc20p1G06uH4mKvV
 PcsroFNvPDj1di9mTKA7E6EYTus3OKgebf9tqEvptV8olsDa6zEXkxMzGc+l2e9BNHht
 NuRzz49r2kxVkWTqW5VbufgjsyPp1xYiL5xtNyP3uS9Zk5vU4pntf5QqRJKhgtzguRgw
 6SXwbrVvFQWogIIyHJpEed3ZN0LddjdVpqp0XYDMc5v2KRbfyRMt64ACrBjvwQaSp5p6
 fHbA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=CcRKCep0Em8qb4RS+XI3XlrvWGSt/BojL916oGwTcLA=;
 fh=DIWY/Gq4nXjLBcBmg1XxI+KW8yE1iwC+kJ0Hios1Ng8=;
 b=nHyfJRBQbD3quWuUXGt++wZncGav3GJVqbi3GkCQo2Qd5A5sUmCgl6jUc3WKXwidi6
 zoY/FPgOzad1C0cxWIfZMJDWEjXleeqcuyx3UbwUbJxej6zr3OzzWCNcNwEXapywzkVY
 o6D4XE++e6TKJ9F/LOnT/9SDEYJ+XRS//KqzPOBScui921xpYrHTY4/eYP6B/yyWH60X
 jqkV342henjqlwDw0C8ys5SKzAEWIfwOB/xGqC4TAUS3GgMeAZp19/ouBaTk/zcvKyre
 qwaspRAVzVSWphpQC9xyJWjpkIFfT054Ucj0JLbqE/T9xrHcb6r2FBP4NzmUexQB9Kue
 Hupg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793902815; x=1794507615; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=CcRKCep0Em8qb4RS+XI3XlrvWGSt/BojL916oGwTcLA=;
 b=bOOGQihqVoeFfOAju18z9GvNwys+XolXgwAKOoNtjpWB5AelfIaZCnXzLLRuz4j2hL
 u+ZcputKMaZZiF4mo0q3yZd9rC/PDSeLLIugf/qKkJzymezFU3lTiW7izCnsJbL+z4+Q
 o8Bd56MQm4n2fAcjHMOU0/R9jYp93bV9YBgrgwd6luSXu0qJV96bGKyvUQbQKY9apyRJ
 uBaT5C0ful6wmFTPE1pgx3s2V0Y2axxURTAm4QvkgzW1p0wLV4Igwo3S4iT90LDpDLwE
 YhrmeEO1PJl3dsaOyQkrASRCdEB/b3Oj7XpQYRHkYZMog/XnMrBXXF3HuN1Kw6OpCsb3
 VpiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793902815; x=1794507615;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=CcRKCep0Em8qb4RS+XI3XlrvWGSt/BojL916oGwTcLA=;
 b=dgpPXgKK5LLBn86jGsjpedula0aR1B/vGIZdpN9kAlsilPAKtD8AQbRwxj/cbx+P7D
 SnAl32lP9PgWRmkjNtApl2k4XVTRaeNcjQFNwYBDWZ6lO9TNWBNVwqkmnreuCWwr5SzI
 6joJ0UAvndg45ENSa1g/zp3DdLGV73GBh+APpp+GRNW56hK+hyD8HEVIzdXm97A2GvSU
 rX/0EZBB3IT/ij9m1fs7lavyQlIcayYBYIcU3zU7ir7Nli4ugXdZ/tMJ1sedM/hC4gSQ
 KYJCXP0yAim41bh/E/1AptHiwRg1lt95/FC9F4Au7oxZlOST47l03ocChIvOxWHv6wlh
 wa1Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwp2+fNrM1o8Un/RY/dzl1XFhRomTuFrybIZaj0aAqnzt3eMZ/+rHX3goGUcheXlDaAXOVXIr9fq5L5@nongnu.org
X-Gm-Message-State: APuU4Z/ph+Kni/qsFxV5ZrRy2pkXCYv5PRywN56y/Dn7rRNZm5FlvvEx
 THl7RrLYytD0BLdPPSM/bTTkBv8jnOJUhQB/3eko0/01fqOj+9QgObM86Wak1nRpAHdf05oJCMT
 1loemGL++cO9mr38lrkXmT1NPBRo68+c=
X-Gm-Gg: AYBFou01Hzg1wwkHf22RjBiHSKcPv9EG7WYWsJSGVS7SGoQKBwNa4gcVcFstYDDTTIf
 5S15rLHo47w0tqxqFfEPxmtrDf18U8eDoEJ15uke6v8wvJVhGvX4PTsuoUTGIQE+LZRdBa2bo3Z
 5S/K/BIlR924VEng6P+1kJT9GT4tu+6ITKv1ILYdR8Mnw+B6wlx+SOD/mgZ/LiHZTh3QmQxwnV3
 1Z8Emp3gCQ2DqxV8K5tbDtRd4DwYIyTm0qaLX955KsmV+XQGwKbh/LEn1Q1n2ZO+wTPr3ZUVgeJ
 GmBv5Aqofmj9DNTUqttUFEtqDxhCHFb3BpVRWWbrxlv5p3uX5eqiVzFTohgn3k+CsxaSgYRAd5o
 s0IFxBlT4wYJVSayjpOgnWIBYkRgFUHDz74wX
X-Received: by 2002:a05:6402:43ca:b0:6b5:78c1:e22c with SMTP id
 4fb4d7f45d1cf-6b59753cc2fmr68608a12.5.1793902814699; Thu, 05 Nov 2026
 10:20:14 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261103133500.2295582-1-pbonzini@redhat.com>
 <CAFEAcA_=L36WixkY-KMXOhwRZ26_pEFXmicVOYMueKH=WYv7uw@mail.gmail.com>
 <CAFEAcA8bGODxRfRzrimhGN1v2HtcWvApRsyucemZbMUUBVkYwA@mail.gmail.com>
In-Reply-To: <CAFEAcA8bGODxRfRzrimhGN1v2HtcWvApRsyucemZbMUUBVkYwA@mail.gmail.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Fri, 6 Nov 2026 02:20:01 +0800
X-Gm-Features: AclHuK-gO8aQyn1SzgV-gZWhs0bN3FJX1HLgI9wgsgT_JQR_Vo5s2w9JKyqJT0Q
Message-ID: <CAE2XoE8A4++C1LQYYZV2Km8G1ik+ijmQ2XsRHiUCh+27VtkDkA@mail.gmail.com>
Subject: Re: [PULL v2 00/10] i386, AGENTS.md,
 meson changes for QEMU 11.2 soft freeze
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x52b.google.com
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
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 6, 2026 at 12:32=E2=80=AFAM Peter Maydell <peter.maydell@linaro=
.org> wrote:
>
> On Thu, 5 Nov 2026 at 10:27, Peter Maydell <peter.maydell@linaro.org> wro=
te:
> >
> > On Tue, 3 Nov 2026 at 13:35, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > > ----------------------------------------------------------------
> > > * target/i386/tcg: bugfixes and cleanups
> > > * AGENTS.md: add final instructions
> > > * meson: rewrite scripts/qemu-version.sh directly in meson.build
> > >
> > > ----------------------------------------------------------------
> >
> > The qemu-version.h changes here seem to have broken incremental builds:
> >
> > In file included from ../../monitor/qmp-cmds-control.c:28:
> > /home/pm215/qemu/include/qemu/version.h:11:10: fatal error:
> > qemu-version.h: No such file or directory
> >    11 | #include "qemu-version.h"
> >       |          ^~~~~~~~~~~~~~~~
> > compilation terminated.
> >
> > This happens even though the incremental rebuild decided it had
> > to re-run configure.
> >
> > Blowing away the build tree and doing a complete rebuild avoids the
> > error, but it would be nice for incremental builds to work.
>
> Also, if you delete qemu-version.h from the build tree, then
> re-run make, nothing notices that it needs to recreate the file
> and the build fails. Perhaps there is a dependency missing ?

Because I faced this issue, I have to fixes it at:

https://lore.kernel.org/qemu-devel/20261105181449.1691-1-luoyonggang@gmail.=
com/

>
> thanks
> -- PMM
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

