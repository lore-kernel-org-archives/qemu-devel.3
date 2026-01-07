Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 174E4CF6BF0
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 07:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdNjk-0003Ln-12; Wed, 07 Jan 2026 02:13:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uwu@icenowy.me>) id 1vdNjh-0003KE-Qb
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 02:13:41 -0500
Received: from sender4-op-o15.zoho.com ([136.143.188.15])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <uwu@icenowy.me>) id 1vdNjg-00032B-5b
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 02:13:41 -0500
ARC-Seal: i=1; a=rsa-sha256; t=1767769998; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=ZDgFRDr9WBdsPhm5q3MWkWMwPPsUbLwF2h4MWfoXmuBIRyMydidZzs1NoHDYZEbceDG/uaZr9RDxBzy+BTe/JNSSxxOWAsU0qib2Xt0pThc/sULKw1DdpLSLo4758L7z2rzmh+ma2qUsePeCrz/9/e33J+RhwzeLX7F7O5uKEJ0=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1767769998;
 h=Content-Type:Content-Transfer-Encoding:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To:Cc;
 bh=oHdVobdZgkXhdTqsfBMtuCEVMRK8kkyTO7YzeAQAhTg=; 
 b=XYxroisZ7L/oULRcDaq8kkBcc3KQPUd8DD0vaI0B8KZz6DY/3UWA1pCqPOE4xbLUjpd41w7EWF2t7qQBczadl5DHXySt34mwjpUkAG9x6Sm1gBkIJFnwjbnUOOZXdRHraJlFimjH3VL/yaC1ShtB6uzpPGMSyoeO/8RdShvcVbc=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=icenowy.me;
 spf=pass  smtp.mailfrom=uwu@icenowy.me;
 dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1767769998; 
 s=zmail2; d=icenowy.me; i=uwu@icenowy.me;
 h=Message-ID:Subject:Subject:From:From:To:To:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To:Cc;
 bh=oHdVobdZgkXhdTqsfBMtuCEVMRK8kkyTO7YzeAQAhTg=;
 b=IpBQ34cVdqu+liZi7Xzwh/0mBruV9oMokeUrPe14e8aHdKkyKsvovxj8baVJ9EY1
 ePvQsoZ2mWJT1B+iTzzUzyJ4ZFeLNH+2/IHgjnVSwBg/6oKGBOs+sKIPnkr0dwRQgBP
 cgdbFS2amDwBi8lmgnPhulKJslOs9FR8t/U1/LdwwcAFXnQLJYXbJYTmYP3DJ1p0LQ6
 Kr9ZlRDYBEZVweXzDedsY7LQNb7IdTGpLvukisuRndtydHepWiQiIoqoNX9SSkLlhOY
 7umIAhZ9loxsZSwR26gD+sUaMKUnu09EsIfiiU5Tg/KYCdra96IznSyLoJtl36Z/+Ck
 0zZZk5hg4w==
Received: by mx.zohomail.com with SMTPS id 1767769997045364.62319280571126;
 Tue, 6 Jan 2026 23:13:17 -0800 (PST)
Message-ID: <e0b2b0a72da9eb53ba635fbbc0c04079dbc32468.camel@icenowy.me>
Subject: Re: [PATCH 8/8] linux-user: fixup termios2 related things on PowerPC
From: Icenowy Zheng <uwu@icenowy.me>
To: "Andreas K." =?ISO-8859-1?Q?H=FCttel?= <dilfridge@gentoo.org>, 
 qemu-devel@nongnu.org
Date: Wed, 07 Jan 2026 15:13:10 +0800
In-Reply-To: <20260103153239.15787-9-dilfridge@gentoo.org>
References: <20260103153239.15787-1-dilfridge@gentoo.org>
 <20260103153239.15787-9-dilfridge@gentoo.org>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.15; envelope-from=uwu@icenowy.me;
 helo=sender4-op-o15.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

=E5=9C=A8 2026-01-03=E6=98=9F=E6=9C=9F=E5=85=AD=E7=9A=84 16:25 +0100=EF=BC=
=8CAndreas K. H=C3=BCttel=E5=86=99=E9=81=93=EF=BC=9A
> From: Icenowy Zheng <uwu@icenowy.me>
>=20
> The termios things on PowerPC equal to termios2 things otherwhere.
>=20
> Use some simple #define's to allow both termios and termios2 to map
> to
> termios on PowerPC.
>=20
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> Link:
> https://github.com/AOSC-Dev/aosc-os-abbs/blob/8d77eeaa76e9b159c3f35adaf73=
c875751aa7d17/app-virtualization/qemu/01-shared/patches/0005-AOSCOS-linux-u=
ser-fixup-termios2-related-things-on-P.patch
> Link:
> https://lore.kernel.org/qemu-devel/4403eb94ddbb2934f1f75d94ce921f0f1078ad=
9f.camel@icenowy.me

To be honest, for better bisectibility, it might be more proper to put
this patch as the first (before implementing termios2 in syscall.c),
otherwise when bisecting on PowerPC host the commits between them are
unbuildable.

> ---
> =C2=A0linux-user/syscall.c | 15 +++++++++++++++
> =C2=A01 file changed, 15 insertions(+)
>=20
> diff --git a/linux-user/syscall.c b/linux-user/syscall.c
> index 01b67a6794..dd04c0ec63 100644
> --- a/linux-user/syscall.c
> +++ b/linux-user/syscall.c
> @@ -148,6 +148,21 @@
> =C2=A0#include "fd-trans.h"
> =C2=A0#include "user/cpu_loop.h"
> =C2=A0
> +#if defined(__powerpc__)
> +/*
> + * On PowerPC termios2 is lacking and termios along with ioctls w/o
> 2
> + * behaves like termios2 and things with 2 on other architectures.
> + *
> + * Just define termios2-related things to be the same with termios-
> related
> + * ones to support PowerPC.
> + */
> +#define host_termios2 host_termios
> +#define TCGETS2 TCGETS
> +#define TCSETS2 TCSETS
> +#define TCSETSW2 TCSETSW
> +#define TCSETSF2 TCSETSF
> +#endif
> +
> =C2=A0#ifndef CLONE_IO
> =C2=A0#define CLONE_IO=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 0x80000000=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0 /* Clone io context
> */
> =C2=A0#endif


