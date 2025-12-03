Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85304D1CDAC
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 23:37:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQwPm-0007OM-C7; Wed, 03 Dec 2025 18:37:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vQwPl-0007OB-09
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 18:37:41 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vQwPj-0001IU-9B
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 18:37:40 -0500
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5B3GSTD11969567
 for <qemu-devel@nongnu.org>; Wed, 3 Dec 2025 23:37:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=fmsIcIFs8qjdNWnTNrfJQ1dX
 6Ql5y9a9HHDfRc2Pf0g=; b=B0DxewhLzJ2u7BpnnogGJWaJb82ozMkCwm3Y8Qkj
 vrILsFfYCSdoAV3/+p/lkIc3WX9Dq9hm9noCkebCJg03uQ+c+e0nd88JaXIn4byU
 b9m906T2bLnlnsRV+IehuuohZMnVuePjkt3tcVzFqwwfMP8mjXXzESuPXOV9jwje
 hNbNwwD5yRxiVovDvFwkmXgt2FGChITIDadt1Mv9C8rozJcrBdovBwlay2OCu8Ve
 AnbgmBRiq85JyIcpkAOH2TRO+mQqK8tPXAJZ7u0LJK/lsjLoINuL1Nah0jzZ4YxG
 hwMIkPiILcRRHWKdPIjmSuPHXnelwpG6FFyhAZxNPz1khg==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4atjjs2cbr-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 23:37:37 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-78ad5fa6c2dso5709197b3.0
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 15:37:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1764805057; x=1765409857; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fmsIcIFs8qjdNWnTNrfJQ1dX6Ql5y9a9HHDfRc2Pf0g=;
 b=JCQlICy1OsN59wg934ebn44sLSsYSRV7lEAnWS8Rgqa3A5aAG3oS6okxYRYhZY9/35
 2jIIk7dC/9CUc/RrXJ3yjNGH3v/pLeB5amsVAIYsrBDqYS/9FDLkOjbtTWJD1LZ3L4Ng
 vZlLxQ0lgH0XUPB1YTbr9GPrfho9qmkFUCvC45/Gi42aj+RRhyroiKkcx5/ucZrrxQUA
 1x4EF2r4tZNuOINSaxWC9hZUd+uyi3l4mFgkjykVK12leMApZVmm2cGbfYZPhUr+IFpe
 8mm9Yv9e2uLt8+4ar98ac4Iiy8aYUPC+/z/ElIUxRA2Ny2BiT3RAHBY7tWOMP/SJIOSG
 ZKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764805057; x=1765409857;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fmsIcIFs8qjdNWnTNrfJQ1dX6Ql5y9a9HHDfRc2Pf0g=;
 b=damXpk2TzIIpspoiTaVDvjXQVLZSlpKybosdxOKeyHeHNG9kzqt9tsq/63rY+eEE69
 EnC6HAU2rCmv4rA4yuP50yrnStulAEwGnVIUG2r76dFnDQm18ABdM5/+wnUQVa5L/2h7
 +qUOvOa9XkHunxGm7MBgZ83ilYZDL93Be5SXrJPt7+q+rdqm/oipeRZ+YbqlrKShBEzI
 sIRARCP2SjVwuTmgr9kUgOHIYq06fRoKgtI2ypT6W48VBTiyi0CrksO9gfx52sWu+fiV
 sbVj22Urcu0BGa1umRU7/8B23y6LL2wryj1lNEkam45Dbr3wozKp9To8ObNPq+ApAF61
 1dWg==
X-Gm-Message-State: AOJu0YwsK0BQVFG7LDtDfkyHqgbQ+XM/QJYR8Bmxu2rRUxHnoCgSAxPl
 YJqkgoXjqDwETRqOYXBG/7qXpvx6NGfau9bg/J+LU2sAAlfdbPdgUipRBK6HN5w/tKuJNTMdh18
 N9zoc0bO0pYVTONV0i6LCsB5UVVyBOnEORwyidtmhJhkMeJ4monnD7HHLh6UIWwtq1OCU8VrCVP
 q2Fn/IES0TlHaHc9ksPCZoNiYk/lZX5VrK
X-Gm-Gg: ASbGncuM0wS0KcreIUXPa5Ny0vnJaDRK6XeZGxRzOtX9PsyPz9ooQIV5u4pSHd9Swl+
 Wcn3EdifylW3pxCrY24ahbM9SDxeu4Jg/ILyIyv291oZkuPBId6YJLl21CVPw+drn85oq14pjlq
 2j61BOFm83gce3DqiYq/7iB1xTc4covRzO04r5z/jrqZZIrAhtc33WQc3/GA6f8Wt/el7sj5WTe
 VcUuyDQup4JxEMCNiaH+ktDOPc=
X-Received: by 2002:a05:690c:6c05:b0:78a:77ca:b2b5 with SMTP id
 00721157ae682-78c0bed5b1fmr33455837b3.4.1764805057041; 
 Wed, 03 Dec 2025 15:37:37 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGozul1uuGUsP5IZjOCuP7mClQ37Z7QolxjXnf+QZfA75sGOs+d+55hzpxDS3YjZ485Yb+tbYTZKwDbHXQGcbA=
X-Received: by 2002:a05:690c:6c05:b0:78a:77ca:b2b5 with SMTP id
 00721157ae682-78c0bed5b1fmr33455537b3.4.1764805056667; Wed, 03 Dec 2025
 15:37:36 -0800 (PST)
MIME-Version: 1.0
References: <20251114230013.158098-1-ltaylorsimpson@gmail.com>
 <20251114230013.158098-4-ltaylorsimpson@gmail.com>
In-Reply-To: <20251114230013.158098-4-ltaylorsimpson@gmail.com>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Wed, 3 Dec 2025 17:37:24 -0600
X-Gm-Features: AWmQ_bnOUfUu_xbkNwZ58uQCsc4CGqUHWEobX0xq8tUFJRmKUG2NjTwAQ5BY294
Message-ID: <CAEqNhNYRjqmNsYwtjVSrWxJADx2wro=k45_uy6_ExDW9ybgf8w@mail.gmail.com>
Subject: Re: [PATCH 3/4] Hexagon (target/hexagon)
 s/gen_log_vreg_write/gen_vreg_write
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, matheus.bernardino@oss.qualcomm.com,
 sid.manning@oss.qualcomm.com, marco.liebel@oss.qualcomm.com,
 richard.henderson@linaro.org, philmd@linaro.org, ale@rev.ng, anjo@rev.ng
Content-Type: multipart/alternative; boundary="000000000000803051064514b257"
X-Proofpoint-ORIG-GUID: vi_LYIu3rW2S3hDeXAPd6dO5vCI4Jmwk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjAzMDE4OCBTYWx0ZWRfX7Qrds3dk5DTQ
 gjPiGu4sSgi71jtUYCNm/OseVz9fPnMHMXj9JAyRioXR5nIcl7PxXRibpUZElEmM8TNKIdnsATo
 2pN2PUC3n/wMqeQ0lqhB8IwRZBe8MmdmERguHee9VSDbNRO0lAWDc5WYWY65JCnsgQ77PeOcuB6
 eltJ4XJct6c6i1BzFdpo1uUdwjiXClMhw0soCIAk9Uf5Jqhj02dxwZQTPWrDen4+DILPZyWZ9UW
 9g9UPSagrb8gzU2XCYTvDELDvV/DPRcgMIJnqntjFErG6kyM9ZtZQUDPSBVdY0pLF5AD1c5eCG5
 VvhKevFbzTmvTrTzhokQKzm2v8vjiA1pwyPPU5WdkUfg6aF+XxCCKMK3erVQpsKlRux7JwVhIIG
 t9ob4OxyFMyj+oNyAqknT4oDA32gKg==
X-Proofpoint-GUID: vi_LYIu3rW2S3hDeXAPd6dO5vCI4Jmwk
X-Authority-Analysis: v=2.4 cv=ZqDg6t7G c=1 sm=1 tr=0 ts=6930c9c1 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=wP3pNCr1ah4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=SSCX-ap5o9fHfXRpzfUA:9 a=QEXdDO2ut3YA:10 a=hR1g0v18N0XenAuMeEAA:9
 a=3zgU3rgV0TZonzeV:21 a=lqcHg5cX4UMA:10 a=WgItmB6HBUc_1uVUp3mg:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-03_03,2025-12-03_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 spamscore=0 bulkscore=0 adultscore=0 phishscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2510240001
 definitions=main-2512030188
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

--000000000000803051064514b257
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 14, 2025 at 5:00=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmai=
l.com>
wrote:

> Note there are two functions impacted
>     gen_log_vreg_write          -> gen_vreg_write
>     gen_log_vreg_write_pair     -> gen_vreg_write_pair
> These functions don't "log" anything, they just generate the write
>
> Signed-off-by: Taylor Simpson <ltaylorsimpson@gmail.com>
> ---
>  target/hexagon/genptr.c      | 8 ++++----
>  target/hexagon/hex_common.py | 8 ++++----
>  2 files changed, 8 insertions(+), 8 deletions(-)
>
>
Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>



> diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c
> index bfbbd61c33..616db17907 100644
> --- a/target/hexagon/genptr.c
> +++ b/target/hexagon/genptr.c
> @@ -1174,7 +1174,7 @@ static intptr_t vreg_src_off(DisasContext *ctx, int
> num)
>      return offset;
>  }
>
> -static void gen_log_vreg_write(DisasContext *ctx, intptr_t srcoff, int
> num,
> +static void gen_vreg_write(DisasContext *ctx, intptr_t srcoff, int num,
>                                 VRegWriteType type)
>  {
>      intptr_t dstoff;
> @@ -1190,12 +1190,12 @@ static void gen_log_vreg_write(DisasContext *ctx,
> intptr_t srcoff, int num,
>      }
>  }
>
> -static void gen_log_vreg_write_pair(DisasContext *ctx, intptr_t srcoff,
> int num,
> +static void gen_vreg_write_pair(DisasContext *ctx, intptr_t srcoff, int
> num,
>                                      VRegWriteType type)
>  {
> -    gen_log_vreg_write(ctx, srcoff, num ^ 0, type);
> +    gen_vreg_write(ctx, srcoff, num ^ 0, type);
>      srcoff +=3D sizeof(MMVector);
> -    gen_log_vreg_write(ctx, srcoff, num ^ 1, type);
> +    gen_vreg_write(ctx, srcoff, num ^ 1, type);
>  }
>
>  static intptr_t get_result_qreg(DisasContext *ctx, int qnum)
> diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py
> index 1277fec9a2..6b683487bc 100755
> --- a/target/hexagon/hex_common.py
> +++ b/target/hexagon/hex_common.py
> @@ -823,8 +823,8 @@ def decl_tcg(self, f, tag, regno):
>              """))
>      def log_write(self, f, tag):
>          f.write(code_fmt(f"""\
> -            gen_log_vreg_write(ctx, {self.hvx_off()}, {self.reg_num},
> -                               {hvx_newv(tag)});
> +            gen_vreg_write(ctx, {self.hvx_off()}, {self.reg_num},
> +                           {hvx_newv(tag)});
>          """))
>      def helper_hvx_desc(self, f):
>          f.write(code_fmt(f"""\
> @@ -915,8 +915,8 @@ def decl_tcg(self, f, tag, regno):
>              """))
>      def log_write(self, f, tag):
>          f.write(code_fmt(f"""\
> -            gen_log_vreg_write_pair(ctx, {self.hvx_off()}, {self.reg_num=
},
> -                                    {hvx_newv(tag)});
> +            gen_vreg_write_pair(ctx, {self.hvx_off()}, {self.reg_num},
> +                                {hvx_newv(tag)});
>          """))
>      def helper_hvx_desc(self, f):
>          f.write(code_fmt(f"""\
> --
> 2.43.0
>
>

--000000000000803051064514b257
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Nov 14,=
 2025 at 5:00=E2=80=AFPM Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpso=
n@gmail.com">ltaylorsimpson@gmail.com</a>&gt; wrote:<br></div><blockquote c=
lass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px soli=
d rgb(204,204,204);padding-left:1ex">Note there are two functions impacted<=
br>
=C2=A0 =C2=A0 gen_log_vreg_write=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 -&gt; ge=
n_vreg_write<br>
=C2=A0 =C2=A0 gen_log_vreg_write_pair=C2=A0 =C2=A0 =C2=A0-&gt; gen_vreg_wri=
te_pair<br>
These functions don&#39;t &quot;log&quot; anything, they just generate the =
write<br>
<br>
Signed-off-by: Taylor Simpson &lt;<a href=3D"mailto:ltaylorsimpson@gmail.co=
m" target=3D"_blank">ltaylorsimpson@gmail.com</a>&gt;<br>
---<br>
=C2=A0target/hexagon/genptr.c=C2=A0 =C2=A0 =C2=A0 | 8 ++++----<br>
=C2=A0target/hexagon/hex_common.py | 8 ++++----<br>
=C2=A02 files changed, 8 insertions(+), 8 deletions(-)<br>
<br></blockquote><div><br></div><div>Reviewed-by: Brian Cain &lt;<a href=3D=
"mailto:brian.cain@oss.qualcomm.com">brian.cain@oss.qualcomm.com</a>&gt;</d=
iv><br class=3D"gmail-Apple-interchange-newline"><div>=C2=A0</div><blockquo=
te class=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px =
solid rgb(204,204,204);padding-left:1ex">
diff --git a/target/hexagon/genptr.c b/target/hexagon/genptr.c<br>
index bfbbd61c33..616db17907 100644<br>
--- a/target/hexagon/genptr.c<br>
+++ b/target/hexagon/genptr.c<br>
@@ -1174,7 +1174,7 @@ static intptr_t vreg_src_off(DisasContext *ctx, int n=
um)<br>
=C2=A0 =C2=A0 =C2=A0return offset;<br>
=C2=A0}<br>
<br>
-static void gen_log_vreg_write(DisasContext *ctx, intptr_t srcoff, int num=
,<br>
+static void gen_vreg_write(DisasContext *ctx, intptr_t srcoff, int num,<br=
>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 VRegWriteType type)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0intptr_t dstoff;<br>
@@ -1190,12 +1190,12 @@ static void gen_log_vreg_write(DisasContext *ctx, i=
ntptr_t srcoff, int num,<br>
=C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0}<br>
<br>
-static void gen_log_vreg_write_pair(DisasContext *ctx, intptr_t srcoff, in=
t num,<br>
+static void gen_vreg_write_pair(DisasContext *ctx, intptr_t srcoff, int nu=
m,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0VRegWriteType ty=
pe)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 gen_log_vreg_write(ctx, srcoff, num ^ 0, type);<br>
+=C2=A0 =C2=A0 gen_vreg_write(ctx, srcoff, num ^ 0, type);<br>
=C2=A0 =C2=A0 =C2=A0srcoff +=3D sizeof(MMVector);<br>
-=C2=A0 =C2=A0 gen_log_vreg_write(ctx, srcoff, num ^ 1, type);<br>
+=C2=A0 =C2=A0 gen_vreg_write(ctx, srcoff, num ^ 1, type);<br>
=C2=A0}<br>
<br>
=C2=A0static intptr_t get_result_qreg(DisasContext *ctx, int qnum)<br>
diff --git a/target/hexagon/hex_common.py b/target/hexagon/hex_common.py<br=
>
index 1277fec9a2..6b683487bc 100755<br>
--- a/target/hexagon/hex_common.py<br>
+++ b/target/hexagon/hex_common.py<br>
@@ -823,8 +823,8 @@ def decl_tcg(self, f, tag, regno):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
=C2=A0 =C2=A0 =C2=A0def log_write(self, f, tag):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(code_fmt(f&quot;&quot;&quot;\<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_log_vreg_write(ctx, {self.hv=
x_off()}, {self.reg_num},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0{hvx_newv(tag)});<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_vreg_write(ctx, {self.hvx_of=
f()}, {self.reg_num},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0{hvx_newv(tag)});<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
=C2=A0 =C2=A0 =C2=A0def helper_hvx_desc(self, f):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(code_fmt(f&quot;&quot;&quot;\<br>
@@ -915,8 +915,8 @@ def decl_tcg(self, f, tag, regno):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
=C2=A0 =C2=A0 =C2=A0def log_write(self, f, tag):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(code_fmt(f&quot;&quot;&quot;\<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_log_vreg_write_pair(ctx, {se=
lf.hvx_off()}, {self.reg_num},<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {hvx_newv(tag)});<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 gen_vreg_write_pair(ctx, {self.h=
vx_off()}, {self.reg_num},<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 {hvx_newv(tag)});<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0&quot;&quot;&quot;))<br>
=C2=A0 =C2=A0 =C2=A0def helper_hvx_desc(self, f):<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0f.write(code_fmt(f&quot;&quot;&quot;\<br>
-- <br>
2.43.0<br>
<br>
</blockquote></div></div>

--000000000000803051064514b257--

