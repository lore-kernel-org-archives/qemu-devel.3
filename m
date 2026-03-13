Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F9EE105F7AE
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 14:17:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w13KA-0001LC-A1; Fri, 13 Mar 2026 10:17:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w13Jm-0001J0-Od
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 10:16:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1w13Jk-0007FR-QF
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 10:16:46 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62DDm5mf237571
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 14:16:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=0iWwW/kbtOyJ5+h4j3rWNQ4C
 YDBWVhusLyoAs3i4hq8=; b=NDhq5FmiPgxe/Tjxv4KU77hd50r16ElaXtjW+ow0
 Hs+4IL+hd8TyRQU9PuLeqr1s1tQd/fyRgw7Fl+KPOicQVVrwtXlq21Gm5h2bXRyk
 psoI7tEL3yMSuZAfED2VWTJPXNYt/WJit4tf74yw6nVH6TP2jxacbt8DXfgDEiYz
 yKCnDaB+t/7PKVyPiB0brhwmJKhgdpy2TvyZtEOPrDjPCgyIzatKl8GjuQ3wClZT
 x0dTU1nWd6Wv0rupKOY1AlKD4u4JDFaXPb21e0HzsVGBQ9g2UZjmwp5hb97Y1fT/
 Ibz7ugBjcbpCyr7XppcHcIvP1T1k7dDJTtE0GJ92cbJrsA==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4cve3d9f11-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 14:16:41 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-79904eb0d1bso51351567b3.2
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 07:16:41 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773411400; cv=none;
 d=google.com; s=arc-20240605;
 b=EGA+cb8opuSSdF5/oW6wCy99NL0L/R067yMrX10EZFwx1KdrkwHXxOJR3qhdjRjTyb
 ne881HUppZ3d3mK3MV7qgG91x80kpqroCCGfYz12iJ/g9j6Dh1fuV708++XVCCBPQ5jA
 2YOjI2VZfHpovaUiOB/ezAdS2rOS6AdWJgI76xhjDlGWhRYmqQHuE4ZWm0rjLOSvwnXX
 OtjI6h7SaX/abL/0xet7cCbk6xh+iu8ogG5KG67P8IDsQTO9p8CB5fDx0aHCKZkZXLj3
 Fjj1ikYB395Snyy5yJqoub2pJc1DQLlDkUzHHdzgXLOOqM3mmY7M2doL70Q5R31V5BcU
 G7UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=0iWwW/kbtOyJ5+h4j3rWNQ4CYDBWVhusLyoAs3i4hq8=;
 fh=3xCeSc75lr+zOARCmxqRIz7h9E70eq9zIVMYqvh1S6U=;
 b=kKGJ0jbcKOnMu2HAQtYjCA9ZrSySB6sYlCgP579//OPeRVo5mexJO3O8IoGrNKgdyg
 /DzonZM6h4KtfC/COL/vdpu6ksJ/NHF6QF7N64OO1pWpyis5Lou/CgXfyi0hRftYVoE+
 teZP02jLVDbx2nMGlaxGC+BYGN5APDzGuc5eYUw506yWAfdtq88cJB8f2VDS5RXCHg54
 4OwTOG/vF7cm5yyX7LKkXOnIGoJUN2MhOcQehWmY0hAjSe67oy/kGGACtE8eYWFkt47u
 jaFrx3C+8aKucjH2Eo6toaRSZVoum5iUygJPF0sGTvw5t3oMG01HyK0vUfU7gonZR32r
 EvJA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1773411400; x=1774016200; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0iWwW/kbtOyJ5+h4j3rWNQ4CYDBWVhusLyoAs3i4hq8=;
 b=gp2HkdTld2/bsPKrbVJMyrV4WcFeRnJQ/J3MvKJ5XduoafKD0H+IZ52rF5NMqoxtaB
 4PVYi2tAktGgoW+rrqAvv/Ar+Kro4uoB/m4A/sxBAf6c0Oy2/ebhtXGR8Pzf4Eoh+JVd
 ssiPrm/f1is4NZ9LJih6EJEhXF/lN5piCG1o2W6DPvx0PeesJLqt6rsAdfLVrFWihXdv
 1Hz7TWjKTbu51xCrA/5WARKseBOy5mz+WrdDtEmvMdAf+AW3vk82qBt0/hn/j34m1zvp
 FDuPWzbv2gPW5NIBrbuqiuavQeCDw71lukK1lK+F5/Tm3HyXTO0a/twJWT8eJWJvvbcP
 m1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773411400; x=1774016200;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0iWwW/kbtOyJ5+h4j3rWNQ4CYDBWVhusLyoAs3i4hq8=;
 b=T+A3Nj6vYw/C1WCgBkB2u/+9hxj2nLNeipf74aq9W61Y/8tygGWJqNmE6m67wfAm8u
 ZEFG/xqhPQa6HJYz8hLubugWdvO7i1zyVNxe1ZxfK4CYds9yZb+MeOchg6nhFL+CEfyF
 cIvlyrhyPNsVfGvPbtFs42250wbQM5OJBk926ubfm0ZjmzYqZCLx2PZC4RjkT0E4Rxks
 rzqTkVRBvA3WNwpiU1zK/W8HKi3owxuElwYypj44xPZ6bHp5KcdsJo2dpPBPHJrLDmLW
 akCtdsSiZ9c6n2NTaFaYTehcZDFlNbz6tH3j7jRN80id9+1lmo6SDkK9bYDlxV+0+Cgi
 IVyw==
X-Gm-Message-State: AOJu0YxacHmKvvze9hv5vr9sJHddK8jAFHOZbV4UAiYnGwttAf4MRcAm
 jt1Ar1fJGC4KLhRlV4leGJ70pWxKKc/U72/ctUak8DrkW0z/eEy1epp+skldryFY+Onbg6pXGt4
 vcvuKzKNBxDbU20PHXplv97r/mDyeBRJPD+u+1Eo2xrFxGHxFQRR5rmKLyg0yR8V30GJR9XFG2j
 6l26C935Mhpn8aJwelRbAOWHv6MTNaoNL3
X-Gm-Gg: ATEYQzy8oeZbdU5WgfIVlSJNQMxSqEo/gVlaWhVN9dDWdUNwdUBsa7Z1wyJRXAbHvaS
 Ij3Rezk1Uvv4kNCetBeYTq93y56vZlEcJMTxJZcwQsjzi8uJKmzXWFl1UNkgG/tI7ZyrChzMruI
 bYHYKpZ03b/zZQLwPp6C4bQmCCNNLLiq2S9tpvUFywBUkMVzibXBd9bw3gL9IDEPLGnB48iegRF
 CghVfc=
X-Received: by 2002:a05:690c:1c:b0:798:6944:a033 with SMTP id
 00721157ae682-79a1c1e56d6mr38391137b3.55.1773411400351; 
 Fri, 13 Mar 2026 07:16:40 -0700 (PDT)
X-Received: by 2002:a05:690c:1c:b0:798:6944:a033 with SMTP id
 00721157ae682-79a1c1e56d6mr38390297b3.55.1773411399527; Fri, 13 Mar 2026
 07:16:39 -0700 (PDT)
MIME-Version: 1.0
References: <20260313062055.2188-1-philmd@linaro.org>
 <20260313062055.2188-8-philmd@linaro.org>
In-Reply-To: <20260313062055.2188-8-philmd@linaro.org>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Fri, 13 Mar 2026 09:16:23 -0500
X-Gm-Features: AaiRm53drc0w3fTyMnuoHPZPByqEW23lv4YbHW11QCExLvCaSCnKYdfIVsLaoxk
Message-ID: <CAEqNhNaFuVqtSvMmoMGwrvQULYVq229XR8kjipkZwigCPQO0YQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/38] target/hexagon: Include missing
 'exec/target_long.h' header
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
Content-Type: multipart/alternative; boundary="000000000000827ff7064ce8843d"
X-Proofpoint-ORIG-GUID: KITVnAm5WNy0OD_2yO1ptpwm9mGgWCxZ
X-Authority-Analysis: v=2.4 cv=FLwWBuos c=1 sm=1 tr=0 ts=69b41c49 cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=Yq5XynenixoA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=gszjLy3Z7wW3dk9eg-0A:9 a=QEXdDO2ut3YA:10
 a=yURiqBW9c67TzRsx04wA:9 a=8vN8Q5QbspksDkFG:21 a=lqcHg5cX4UMA:10
 a=MFSWADHSvvjO3QEy5MdX:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzEzMDExMyBTYWx0ZWRfXymjRuqARgMVU
 +U+Gs823oESlfyevkFdCd74jhYpzZmUKH58HimcAR/vxrb8FOxaHas9WrL9WtMJyI1GSV7jbMJy
 TBjCCy26yw8i+XqdVCSdggHq0vZU8p6TnXb2bu0qkQl7WyXkCEuaSTMHjQ0RmF79gOQoFPAD+FZ
 74XDb6Qe9JbLg640RtRwZYw1S/0bpzO2gB2mFOCwPZBe3aJdgpvkq/HxHYsjqwRs1lBVgZdV2Fx
 g1zFl1t7TwenhaF5rZM6g8ybBoX5gc0egF0j1pvj+VX0NB88zdtpLIfVFdiAyIED9OipgbscGGa
 O3ii4Y9K5aM8n2rAF8TUVO/tXN0BWObuvUgjLBHgNR/wbNTdCV+1XxZSHxulJo/+IqIu+qtDGti
 GEz4E94hSOm2mxlp+4BdBYvPokSt6PY7D5b8DiXxVEs+CDp+N4Ngb1FD3EAtgPbwn7glCLyeY2e
 0jhF+O4KyrtIvBO2QhA==
X-Proofpoint-GUID: KITVnAm5WNy0OD_2yO1ptpwm9mGgWCxZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-13_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 bulkscore=0 malwarescore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 phishscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603130113
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903, SPF_HELO_NONE=0.001,
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

--000000000000827ff7064ce8843d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 13, 2026 at 1:21=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> The "exec/target_long.h" header is indirectly included, pulled
> via "exec/cpu-defs.h". Include it explicitly otherwise we'd get
> when removing the latter:
>
>   ../target/hexagon/cpu.h:76:5: error: unknown type name =E2=80=98target_=
ulong=E2=80=99
>      76 |     target_ulong gpr[TOTAL_PER_THREAD_REGS];
>         |     ^~~~~~~~~~~~
>   ../target/hexagon/mmvec/mmvec.h:69:5: error: unknown type name
> =E2=80=98target_ulong=E2=80=99
>      69 |     target_ulong va[MAX_VEC_SIZE_BYTES];
>         |     ^~~~~~~~~~~~
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

 target/hexagon/cpu.h         | 2 ++
>  target/hexagon/mmvec/mmvec.h | 3 +++
>  2 files changed, 5 insertions(+)
>
> diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h
> index 85afd592778..7a91399fe02 100644
> --- a/target/hexagon/cpu.h
> +++ b/target/hexagon/cpu.h
> @@ -23,9 +23,11 @@
>  #include "cpu-qom.h"
>  #include "exec/cpu-common.h"
>  #include "exec/cpu-defs.h"
> +#include "exec/target_long.h"
>  #include "hex_regs.h"
>  #include "mmvec/mmvec.h"
>  #include "hw/core/registerfields.h"
> +#include "qemu/bitmap.h"
>
>  #ifndef CONFIG_USER_ONLY
>  #error "Hexagon does not support system emulation"
> diff --git a/target/hexagon/mmvec/mmvec.h b/target/hexagon/mmvec/mmvec.h
> index 52d470709c0..4a4f6cc9805 100644
> --- a/target/hexagon/mmvec/mmvec.h
> +++ b/target/hexagon/mmvec/mmvec.h
> @@ -18,6 +18,9 @@
>  #ifndef HEXAGON_MMVEC_H
>  #define HEXAGON_MMVEC_H
>
> +#include "exec/target_long.h"
> +#include "qemu/bitmap.h"
> +
>  #define MAX_VEC_SIZE_LOGBYTES 7
>  #define MAX_VEC_SIZE_BYTES  (1 << MAX_VEC_SIZE_LOGBYTES)
>
> --
> 2.53.0
>
>
>

--000000000000827ff7064ce8843d
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><div class=3D"gmail_default" style=3D"fon=
t-family:monospace"><br></div></div><br><div class=3D"gmail_quote gmail_quo=
te_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Mar 13, 2026 at=
 1:21=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@l=
inaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"g=
mail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204=
,204,204);padding-left:1ex">The &quot;exec/target_long.h&quot; header is in=
directly included, pulled<br>
via &quot;exec/cpu-defs.h&quot;. Include it explicitly otherwise we&#39;d g=
et<br>
when removing the latter:<br>
<br>
=C2=A0 ../target/hexagon/cpu.h:76:5: error: unknown type name =E2=80=98targ=
et_ulong=E2=80=99<br>
=C2=A0 =C2=A0 =C2=A076 |=C2=A0 =C2=A0 =C2=A0target_ulong gpr[TOTAL_PER_THRE=
AD_REGS];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~<br>
=C2=A0 ../target/hexagon/mmvec/mmvec.h:69:5: error: unknown type name =E2=
=80=98target_ulong=E2=80=99<br>
=C2=A0 =C2=A0 =C2=A069 |=C2=A0 =C2=A0 =C2=A0target_ulong va[MAX_VEC_SIZE_BY=
TES];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 =C2=A0^~~~~~~~~~~~<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
---<br></blockquote><div><br></div><div class=3D"gmail_default" style=3D"fo=
nt-family:monospace">Reviewed-by: Brian Cain &lt;<a href=3D"mailto:brian.ca=
in@oss.qualcomm.com">brian.cain@oss.qualcomm.com</a>&gt;</div><div class=3D=
"gmail_default" style=3D"font-family:monospace"><br></div><blockquote class=
=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rg=
b(204,204,204);padding-left:1ex">
=C2=A0target/hexagon/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2 ++<br>
=C2=A0target/hexagon/mmvec/mmvec.h | 3 +++<br>
=C2=A02 files changed, 5 insertions(+)<br>
<br>
diff --git a/target/hexagon/cpu.h b/target/hexagon/cpu.h<br>
index 85afd592778..7a91399fe02 100644<br>
--- a/target/hexagon/cpu.h<br>
+++ b/target/hexagon/cpu.h<br>
@@ -23,9 +23,11 @@<br>
=C2=A0#include &quot;cpu-qom.h&quot;<br>
=C2=A0#include &quot;exec/cpu-common.h&quot;<br>
=C2=A0#include &quot;exec/cpu-defs.h&quot;<br>
+#include &quot;exec/target_long.h&quot;<br>
=C2=A0#include &quot;hex_regs.h&quot;<br>
=C2=A0#include &quot;mmvec/mmvec.h&quot;<br>
=C2=A0#include &quot;hw/core/registerfields.h&quot;<br>
+#include &quot;qemu/bitmap.h&quot;<br>
<br>
=C2=A0#ifndef CONFIG_USER_ONLY<br>
=C2=A0#error &quot;Hexagon does not support system emulation&quot;<br>
diff --git a/target/hexagon/mmvec/mmvec.h b/target/hexagon/mmvec/mmvec.h<br=
>
index 52d470709c0..4a4f6cc9805 100644<br>
--- a/target/hexagon/mmvec/mmvec.h<br>
+++ b/target/hexagon/mmvec/mmvec.h<br>
@@ -18,6 +18,9 @@<br>
=C2=A0#ifndef HEXAGON_MMVEC_H<br>
=C2=A0#define HEXAGON_MMVEC_H<br>
<br>
+#include &quot;exec/target_long.h&quot;<br>
+#include &quot;qemu/bitmap.h&quot;<br>
+<br>
=C2=A0#define MAX_VEC_SIZE_LOGBYTES 7<br>
=C2=A0#define MAX_VEC_SIZE_BYTES=C2=A0 (1 &lt;&lt; MAX_VEC_SIZE_LOGBYTES)<b=
r>
<br>
-- <br>
2.53.0<br>
<br>
<br>
</blockquote></div></div>

--000000000000827ff7064ce8843d--

