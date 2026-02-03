Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A185DE8305B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 07:32:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnAto-000719-Fy; Tue, 03 Feb 2026 02:32:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1vnAtm-00070e-Qq
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 02:32:34 -0500
Received: from mout.kundenserver.de ([212.227.17.24])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <laurent@vivier.eu>) id 1vnAtl-0005kb-0O
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 02:32:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=vivier.eu;
 s=s1-ionos; t=1770103948; x=1770708748; i=laurent@vivier.eu;
 bh=0LNy8FiWmkc5kH+YOIA/xigbLSOcpn+uXwrJRoX8Wmg=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=ugWSEcuVDG7F/Oe3bPInkKce5iervZ2c1R9Kjq1tPovCmCVEW+XpTahoX0cT2gh/
 tVB//bTFXZjdB/rQ4M7avQThps3Oe/lS/Zv8nnEzllYtG7ey0Hoze1/FJA4UBJ3wO
 68TNwS+StGG7gN4qG1qYqOYZAAvmOrlJkizhQO3tQLNErdhFjuCjz2rg4B3K+vyyC
 XeBShTTqrBxXjmw2/qhTCDbl36vxwIX7jWjA4vJBxbtGpUodW6I1a17HU0UHM4M7k
 DMtDaMWSGPK9Nc3DTnt6ZusUSd4RkbnF2Y4sSFkAyC8UZ6mqInFzPfayyckYjScdQ
 jKO74lTkLgQQG1bCSg==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from [192.168.100.1] ([82.64.211.94]) by mrelayeu.kundenserver.de
 (mreue106 [213.165.67.119]) with ESMTPSA (Nemesis) id
 1MZk5x-1wJOmJ1kJj-00NW7M; Tue, 03 Feb 2026 08:32:28 +0100
Message-ID: <31572435-2b65-4e82-bc00-76a08c2fcf87@vivier.eu>
Date: Tue, 3 Feb 2026 08:32:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/m68k: Inline translator_ld[uw,l,q]() calls
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20260202214050.98935-1-philmd@linaro.org>
Content-Language: fr
From: Laurent Vivier <laurent@vivier.eu>
Autocrypt: addr=laurent@vivier.eu; keydata=
 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
In-Reply-To: <20260202214050.98935-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:2dd5jObt3dykjAf2WfzLfs/jK6tlbxff54oBT37J29bKsIeqM5n
 L2KALPQoNU97GWLm0inDRsdMUb23Z3CxGb0ZomOQRfe1idVDeR7FyDkje1ycxK9SaVMCtbU
 2hBhdCQLTjvE0VjtJfKrtTy7tTu0e0a9GNxYaLtpwmUm1UdpJIpatOuTpRgX5bVFXaNOcfX
 xrOSAaPqNtN6bcoQCM5GQ==
UI-OutboundReport: notjunk:1;M01:P0:/U2GYy34Hek=;27nWJewbHgJn2FnFij31x0fXyY9
 nMSuuCu3fGu45ZrufBZbJkaTLhdys4aDIA5Gje3OVG5BRc5opAVRBeLhhbVFzOGzG5NQWT3Hw
 0ls1OUZ+lFQSwp7SppUcbgVagS6OxazLAZ49lIyGw9yxYBfNS0TZ6xMmTup9kps016t4XZtBv
 oGnVTuksyiUjwfdTd62qKDTNpu7/5PExGT5hFkPhV6z1sm686K0OpOKMV/YXwW0lAe8+ouEyV
 z9SRAPiFr4IPys2zJu5cR+jBkvjGphwu8kXsueabRBsXtdLH0qNbMbG/Pn6S93/PxXvgZyBp1
 kBDAJ3rrB+mYB7biq12tUs8GzRA0PY+R+7MYzMrkFRf+3Qhq+x6UjOKo7BCg+CK/HrAP5Ad6N
 aWfAz0GOs00kn3KbYJr+wXgaQA0IWXGpaGE81IaL0lzdATaJuUXKVGVhy1YG3wJoW9ZACFUPp
 gO/09FGZOjtvgnyPhLBEttL6+SO1RMyggavB5e24QDeuWCU3Zm4XcPWgKTTes4e2/TChzjpZn
 wgUCE/3ofHYH6enDuJxJAnCj3+oymt2q80UZJ+cz6yF/f3nEq5CUJ59WQl2eAWVqEwqg/xsy3
 Tz+auuwC8rXlBlvFNvjxsuz62K3OrWv3tSwdDTZEs0OtAcIduim7LXoMXnG9CcaUcp8ESCO2L
 3Fi6isB+/xQeuEfY5WRqdNAmMkaek7LQttckpCmK5aPqX5ZT+69Xh8+5znP5mWY4WKoXf99MT
 iRuhJqwjP1Txk2D/Qzee2jnC53HQ9a6YE8WYGg2doIhYg9j4/jZgbsyIFgpAGUFgH3cCAsJFF
 vczznCwCVtO6PdqH1jiwX5FCc9FsGhrxalXVG+YPkFpeGlBGEICpUjF3N2hCWY/rsZlJh1OLK
 pal6K3PAnLd3mKxlgQzeCbuoIZp7hXBRV1MgqwiKXE85y2/EnAMpYqT2ZL+4ev3aBr65dGEuW
 AIUnuyZGqwaPavoXO32H2bGWfjMzEHXkH5mOf7s8HZ6f8qqFJcES0Q7wT69aQR1/7Ugljje4s
 eN2TanjJhf0pmbNB0WHWAON+KPSFvJHyJrK05i+O+EkTERlYZlXRk2soJWocL/V9BuGCgRAMd
 gwEtag6KQH7Dqhwcy4yvhjcdCJuCSl4U3OeWKA0RdcwNX0RlVNkI0I6oQXGR+V6g3Q9smR4+M
 ibx1kDivhZ3u4bLb/yV215A76nOZq95+fH0fnlZHfTQxH2zCDlcUAw6G+p1eK311bGlJlrcNY
 zGmFynOKkzbMN8Js2EzMJmdmZih4BQQItGG8PErghfMseoinFRstW4KxbK5/17cNM7M1b478K
 8jaI3cpB8cJDRvniH38jYCDUujYWGMYn8+ZvKbN/0pQTHhYzLn2yBVV7jHNP/anIRJ+ojsWGw
 U3tKBRZhW4Vg+KsdsyVu0UjBVd50TwX3keT1YFVElkuGuYcs4WBBKSuJ95CVcGxBKLsphoaSJ
 DXwzBowmk4nD5h1rGt3yqqQh1GeRtMkJ5VyIVEmSF6afG9m9GsvN0rfU+We9o5ud4an+VqOLb
 8nv8j/+cm18egYftKKQBMKjUUzjU9lMRsnDcfs8qYzz5gpwTINfutmmfLIfYrfaaL5PqIEOAv
 sTgCeOA4U6FniowY0ItMSLiP5XlMaZR7UaafF0/YfjFO0IpCShuneM6e2hV1/pWr31Aj5pxmT
 FN1hCeabVLfXlHM1zGlVZD7VlFAmHjwiYz/XzvgOjK3XSHBquru3VcsLrMjmu3ApJ6wntQipI
 cCdak9zLMYijjtMcZC5o8cLgSEAF0UFkBdVZqUtAEkzOZIFAMXqB+s+A=
Received-SPF: pass client-ip=212.227.17.24; envelope-from=laurent@vivier.eu;
 helo=mout.kundenserver.de
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Le 02/02/2026 =C3=A0 22:40, Philippe Mathieu-Daud=C3=A9 a =C3=A9crit=C2=A0=
:
> In preparation of removing the translator_ld[uw,l,q]() methods,
> inline them for the m68k target, expanding MO_TE -> MO_BE since
> this architecture is only available in big endianness.
>=20
> Mechanical change using the following Coccinelle 'spatch' script:
>=20
>      @@
>      expression env, db, pc, do_swap;
>      @@
>      (
>      - translator_lduw(env, db, pc)
>      + translator_lduw_end(env, db, pc, MO_BE)
>      |
>      - translator_ldl(env, db, pc)
>      + translator_ldl_end(env, db, pc, MO_BE)
>      |
>      - translator_ldq(env, db, pc)
>      + translator_ldq_end(env, db, pc, MO_BE)
>      )
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>   target/m68k/translate.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/m68k/translate.c b/target/m68k/translate.c
> index 721668634d9..a0309939012 100644
> --- a/target/m68k/translate.c
> +++ b/target/m68k/translate.c
> @@ -347,7 +347,7 @@ static TCGv gen_ldst(DisasContext *s, int opsize, TC=
Gv addr, TCGv val,
>   static inline uint16_t read_im16(CPUM68KState *env, DisasContext *s)
>   {
>       uint16_t im;
> -    im =3D translator_lduw(env, &s->base, s->pc);
> +    im =3D translator_lduw_end(env, &s->base, s->pc, MO_BE);
>       s->pc +=3D 2;
>       return im;
>   }
> @@ -1412,12 +1412,12 @@ static bool semihosting_test(DisasContext *s)
>       if (s->pc % 4 !=3D 0) {
>           return false;
>       }
> -    test =3D translator_lduw(s->env, &s->base, s->pc - 4);
> +    test =3D translator_lduw_end(s->env, &s->base, s->pc - 4, MO_BE);
>       if (test !=3D 0x4e71) {
>           return false;
>       }
>       /* "... and followed by an invalid sentinel instruction movec %sp,=
0." */
> -    test =3D translator_ldl(s->env, &s->base, s->pc);
> +    test =3D translator_ldl_end(s->env, &s->base, s->pc, MO_BE);
>       if (test !=3D 0x4e7bf000) {
>           return false;
>       }

Reviewed-by: Laurent Vivier <laurent@vivier.eu>

