Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 470F3C83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 18:05:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueHJK-0007ZW-2V; Tue, 22 Jul 2025 14:01:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ueGwQ-0000sK-4r
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 13:38:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vacha.bhavsar@oss.qualcomm.com>)
 id 1ueGwN-0000DB-M1
 for qemu-devel@nongnu.org; Tue, 22 Jul 2025 13:38:13 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56MEivMx018339
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 17:38:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=fWiNpI4sQ9CEWLe68Mec0P4x
 7LZOJJJIxJQ/jJX/Eb8=; b=inRcUpKeU10RjLfn2CIhdINmBrm/ORDdazZlU1yc
 6Rw1B04BxYhglc39Q3D0ND6a+3DXf/TdbGwrHGasrTWBk+xO5vH+ewkPjtYVMJt4
 rc34e8FNoHYwGxzXLYP/sa9tn/a6gFkODoVtNjI2qv3ZR8vCYdaU4R2VPYN8nOCy
 oLMGN15GgLF1H5fe8vlLklGGyfz5qCuW70TffTq+8JWsstnuoxcBQmW1fiIrnyu5
 JLcJx7M8+G5l5ka3ENh875C7cExiaPwgsHhLOVaro68Tv9+T7tmUtfRHNsGNV5Hv
 WSQgJySoCsw3ilrT2HfZwGTYb9G/45lSwnk6H5CV10xBIw==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4804na0rkw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 17:38:09 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-71839bc5591so77391077b3.2
 for <qemu-devel@nongnu.org>; Tue, 22 Jul 2025 10:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753205888; x=1753810688;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fWiNpI4sQ9CEWLe68Mec0P4x7LZOJJJIxJQ/jJX/Eb8=;
 b=VNmw1Kw0SjFAIo9UpUwgA7In9daAjLHZ2Vvxd5sEQvA8PrZR9DvJI4q4cqQOHjuv81
 MiT3Zy0YIuHngxUKpsjcEy5lcRQUYHxe/Xrg7fU4I8TpkgeDohJZXhHr2VjzNNqKeqta
 xnuIS68tUODyENFNel4KL27b1jM+KiNdBMhgm+La1Tgs6mpuwdAhGj7wL9VUbmrcywUg
 2F9VMwQG2jG/HQzD3EDY0X+Au1bIY3WndNvn5LAC2D8gaAE9w0mmWZZkeoULlfJONZeI
 XqN2DYvYCFOqUWo38hjE12NoFNm6cagAkScqpRby1DzJfAs1PilwAwKQdF099A8VoJWH
 C9EA==
X-Gm-Message-State: AOJu0YyuKEfufkqjHQRAJ9Ru6ibRWclwdTV9f9knL9u4iD9yTjY2Yr+5
 zhfZQvV7kT/8W8E9puCuKhQiBnRumkbhID6JeT7COGzkgN+oWSm54SYCxn2BuGW7MVo8vvFM50V
 YBIN6EMu7bCRoCmIgP0t8fh913XVek7hOF+oX/SaD5iCQOkZI/DsZuf64FJDuNahKowUnHZN9kU
 6eI0Jtw/oMboBuudx7a+tI7HSwMP0u0nJk
X-Gm-Gg: ASbGncsE3hmh5SDuCSsxX1+8QuSGRFQQheXI56tKDe1V7LqHnjrNoxEB93UFbBgtcud
 XZhATPycRXDus9G7SxBdbKmONcpc/aae86PdKKmsPDxO2A0RoV5VILsTNdFQAg1VScRi4pnzagm
 nuHajkVGgkIzkS7osiT6hk4Q==
X-Received: by 2002:a05:6902:200d:b0:e8b:bece:b4c5 with SMTP id
 3f1490d57ef6-e8dc594c716mr178286276.20.1753205888104; 
 Tue, 22 Jul 2025 10:38:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEr1T3FG7yfXPc2hnG4rIvPII63tndvYhJZAVvN8Bq83na/KVspVrNaKPVcbVQpesWQNK0/uZ6eST5dqrlqRH0=
X-Received: by 2002:a05:6902:200d:b0:e8b:bece:b4c5 with SMTP id
 3f1490d57ef6-e8dc594c716mr178254276.20.1753205887546; Tue, 22 Jul 2025
 10:38:07 -0700 (PDT)
MIME-Version: 1.0
References: <20250721211952.2239714-1-vacha.bhavsar@oss.qualcomm.com>
 <20250721211952.2239714-2-vacha.bhavsar@oss.qualcomm.com>
 <9eeee985-0df8-4e88-8ebc-00e20399fe95@linaro.org>
In-Reply-To: <9eeee985-0df8-4e88-8ebc-00e20399fe95@linaro.org>
From: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
Date: Tue, 22 Jul 2025 13:37:56 -0400
X-Gm-Features: Ac12FXxH0ESnt3iQzTvPpDTAcad2G5Si_vyDaIPxXz6PvLF01GTcYg6M63-9I0c
Message-ID: <CAEWVDmsJPq47pZgwXRZzhwQYgkuUQn4ZHWk8X36S0Fzk-tz=yQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] target/arm: Fix big-endian handling of NEON gdb
 remote debugging
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org
Content-Type: multipart/alternative; boundary="00000000000025505c063a880e1f"
X-Proofpoint-GUID: E7v1YpiSskPSsKRzustwrY-S_c9KL7JX
X-Proofpoint-ORIG-GUID: E7v1YpiSskPSsKRzustwrY-S_c9KL7JX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzIyMDE0OSBTYWx0ZWRfX6/l7FsakCPs6
 ktRcmFc93DfPvcd0vr3UWLSI2qBpFGDPKCgrCEGaptkPuA+rA2hTELF/MW4SGsFqAarFgUyrR3f
 PGmfs/ahPMe6tpRzU573lznxgTkA+iQRXefdkhHG2Uqx5bgIdW5G3mpTTHfbAbsC5J5D+JEhGeC
 rgPcDbvnVQzMw8sgH7xREJ1wxkw3LRVEYmjKNDlD9IW4VSkILdz6ZCg59PeKsWiJlk5MFwZ+6Gf
 fb/fuGDJZ1X/b+nNupvBoaoqf6Du8bTze71jlbw04+UC0I2gxXpUOLPn4ADYN+B5+eCgcoZbdA7
 KA8YvOrJRhKHZ9hnwMFBOqKSDLR0RXNMYzlbJXSRg8V9cISfHh4gw+xnuH+0uLzFoAQvSi0VFjX
 JLYkBzeeeDrGkZ8YKDgE8HXhgjkxNABSxhMCZ5r3pN9bVqsi9fMi0ZBA4l8p1KjJkYqN3wrt
X-Authority-Analysis: v=2.4 cv=DoFW+H/+ c=1 sm=1 tr=0 ts=687fcc81 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=Wb1JkmetP80A:10 a=KKAkSRfTAAAA:8
 a=EUspDBNiAAAA:8 a=W__LxpSxGxo44iX2rtMA:9 a=QEXdDO2ut3YA:10
 a=FL2y2Ow5dUcLyCVka2oA:9 a=x0wGDgfKR-FBRejI:21 a=lqcHg5cX4UMA:10
 a=kA6IBgd4cpdPkAWqgNAz:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-22_02,2025-07-21_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 clxscore=1015 mlxscore=0 mlxlogscore=912
 bulkscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0 adultscore=0
 spamscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507220149
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=vacha.bhavsar@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

--00000000000025505c063a880e1f
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Philippe,

Noted! Edits have been made and another version sent over.

Thanks,
Vacha

On Tue, Jul 22, 2025 at 2:05=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> Hi,
>
> On 21/7/25 23:19, Vacha Bhavsar wrote:
> > This patch adds big endian support for NEON GDB remote
> > debugging. It replaces the use of ldq_le_p() with the use of ldq_p() as
> > explained in the first part of this patch series. Additionally, the
> order in
> > which the buffer content is loaded into the CPU struct is switched
> depending
> > on target endianness to ensure the most significant bits are always in
> second
> > element.
>
> This patch description is what will be committed in the git history.
>
> What do you mean by "as explained in the first part of this patch
> series"? This is already the first patch of the series. The "series"
> notion will be lost in the git history, so we don't understand what
> you meant / referred to.
>
> Anyway, maybe the description can be simplified as:
>
> "Check target endianness and always store the most significant bits
>   in the second element."
>
> > Signed-off-by: Vacha Bhavsar <vacha.bhavsar@oss.qualcomm.com>
> > ---
> >   target/arm/gdbstub64.c | 12 ++++++++++--
> >   1 file changed, 10 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c
> > index 64ee9b3b56..8b7f15b920 100644
> > --- a/target/arm/gdbstub64.c
> > +++ b/target/arm/gdbstub64.c
> > @@ -115,8 +115,16 @@ int aarch64_gdb_set_fpu_reg(CPUState *cs, uint8_t
> *buf, int reg)
> >           /* 128 bit FP register */
> >           {
> >               uint64_t *q =3D aa64_vfp_qreg(env, reg);
> > -            q[0] =3D ldq_le_p(buf);
> > -            q[1] =3D ldq_le_p(buf + 8);
> > +
> > +            if (target_big_endian()){
> > +                q[1] =3D ldq_p(buf);
> > +                q[0] =3D ldq_p(buf + 8);
> > +            }
> > +            else{
>
> Per our docs/devel/style.rst:
>
>                 } else {
>
> > +                q[0] =3D ldq_p(buf);
> > +                q[1] =3D ldq_p(buf + 8);
> > +            }
> > +
> >               return 16;
> >           }
> >       case 32:
>
>

--00000000000025505c063a880e1f
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">Hi=C2=A0Philippe,<div><br></div><div>Noted! Edits have bee=
n made and another version sent over.</div><div><br></div><div>Thanks,</div=
><div>Vacha<br><table cellpadding=3D"0" style=3D"font-family:&quot;Google S=
ans&quot;,Roboto,RobotoDraft,Helvetica,Arial,sans-serif;font-size:14px;bord=
er-collapse:collapse;table-layout:fixed;width:805.365px"><tbody></tbody></t=
able><table cellpadding=3D"0" style=3D"border-collapse:collapse;margin-top:=
0px;width:auto;font-family:&quot;Google Sans&quot;,Roboto,RobotoDraft,Helve=
tica,Arial,sans-serif;font-size:14px;display:block"></table></div></div><br=
><div class=3D"gmail_quote"><div dir=3D"ltr" class=3D"gmail_attr">On Tue, J=
ul 22, 2025 at 2:05=E2=80=AFAM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"m=
ailto:philmd@linaro.org" target=3D"_blank">philmd@linaro.org</a>&gt; wrote:=
<br></div><blockquote class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8=
ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">Hi,<br>
<br>
On 21/7/25 23:19, Vacha Bhavsar wrote:<br>
&gt; This patch adds big endian support for NEON GDB remote<br>
&gt; debugging. It replaces the use of ldq_le_p() with the use of ldq_p() a=
s<br>
&gt; explained in the first part of this patch series. Additionally, the or=
der in<br>
&gt; which the buffer content is loaded into the CPU struct is switched dep=
ending<br>
&gt; on target endianness to ensure the most significant bits are always in=
 second<br>
&gt; element.<br>
<br>
This patch description is what will be committed in the git history.<br>
<br>
What do you mean by &quot;as explained in the first part of this patch<br>
series&quot;? This is already the first patch of the series. The &quot;seri=
es&quot;<br>
notion will be lost in the git history, so we don&#39;t understand what<br>
you meant / referred to.<br>
<br>
Anyway, maybe the description can be simplified as:<br>
<br>
&quot;Check target endianness and always store the most significant bits<br=
>
=C2=A0 in the second element.&quot;<br>
<br>
&gt; Signed-off-by: Vacha Bhavsar &lt;<a href=3D"mailto:vacha.bhavsar@oss.q=
ualcomm.com" target=3D"_blank">vacha.bhavsar@oss.qualcomm.com</a>&gt;<br>
&gt; ---<br>
&gt;=C2=A0 =C2=A0target/arm/gdbstub64.c | 12 ++++++++++--<br>
&gt;=C2=A0 =C2=A01 file changed, 10 insertions(+), 2 deletions(-)<br>
&gt; <br>
&gt; diff --git a/target/arm/gdbstub64.c b/target/arm/gdbstub64.c<br>
&gt; index 64ee9b3b56..8b7f15b920 100644<br>
&gt; --- a/target/arm/gdbstub64.c<br>
&gt; +++ b/target/arm/gdbstub64.c<br>
&gt; @@ -115,8 +115,16 @@ int aarch64_gdb_set_fpu_reg(CPUState *cs, uint8_t=
 *buf, int reg)<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* 128 bit FP register */<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64_t *q =3D =
aa64_vfp_qreg(env, reg);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q[0] =3D ldq_le_p(buf);<br>
&gt; -=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q[1] =3D ldq_le_p(buf + 8);=
<br>
&gt; +<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 if (target_big_endian()){<b=
r>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q[1] =3D ldq_=
p(buf);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q[0] =3D ldq_=
p(buf + 8);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 else{<br>
<br>
Per our docs/devel/style.rst:<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 } else {<br>
<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q[0] =3D ldq_=
p(buf);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 q[1] =3D ldq_=
p(buf + 8);<br>
&gt; +=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 }<br>
&gt; +<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return 16;<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
&gt;=C2=A0 =C2=A0 =C2=A0 =C2=A0case 32:<br>
<br>
</blockquote></div>

--00000000000025505c063a880e1f--

