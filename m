Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45CC5C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 15:55:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3yAG-00030j-94; Tue, 08 Sep 2026 11:55:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sid.manning@oss.qualcomm.com>)
 id 1x3yAE-0002wh-Ma
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:55:14 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sid.manning@oss.qualcomm.com>)
 id 1x3yAC-0000Em-Mv
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 11:55:14 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 688FdZDc2194385
 for <qemu-devel@nongnu.org>; Tue, 8 Sep 2026 15:55:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=BoiOdGkNTRiQ20DUGx/CzUhC
 mOuJHI3zN1BG1SmDyC8=; b=gwBibAIQqIGgaN2pKzOcjMemqo1jU0o1Ekh5IARm
 vzvmebXJbf/uOeAn2zKgnw/LPTK4i4df0fHiHRdB0qvz9CNWOZiAsmxotRXgrJBp
 C6GKH9BDjGiHR3oA43bMO0IhxtzgSO+BLIZahxoIpCkFPmSMkVgx0snQdTdjRUAI
 NocRRrkIWfxWafMgm04EpR5NxI9CY28W/cOyal4BtZt8aK++8XtieFGdbWjNYTjT
 w1Q5v5vjZ89+MXugFjKPofSH+4jcUb69ydVYKkeBEZB97CgdxM6wNP+4ITrN3zsy
 qkVljjicpRKviLMY2IRbvcSuDOb6/q0lBEi3TuxbBr/b6Q==
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gjkshrhu1-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 15:55:09 +0000 (GMT)
Received: by mail-yw1-f198.google.com with SMTP id
 00721157ae682-836c8fc09cfso96168917b3.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 08:55:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788882908; cv=none;
 d=google.com; s=arc-20260327;
 b=GSqx9/Q3HQkyWygoUUJrs+oNnChFhiPIO2eeVH5LB84oNMxq9fA7jqSSqsQaoolFUv
 VytfbWC49Pn0kNEi7OAIdJk7ZvwlmIk9GlTQ16gCxD41MkbpCwemMYBVZ3J+dOFe5ChP
 Se2m6u69gmjDd36ifE/VDtXRYHAoQFCOj1h5HKL60766JYcmVdfgDPsGwxwkI3+W9BgY
 tLScLOMddz4zSLBZLlq+E50lRQCHG7/fv23PZ0shyXjsdBcr2gXe9oCKWj0ZJGZCXu50
 SY3MG/pae74BLdRhzIW4cEN45zATNttKVOu8y0RLrN/oMX+NFntCGk8Ni4JjJwQRCFE8
 9zBA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BoiOdGkNTRiQ20DUGx/CzUhCmOuJHI3zN1BG1SmDyC8=;
 fh=+NGiuCaJkBcMFhTaOsG/B5aXYeWujaYLuYLP/6yolpU=;
 b=Fk/PdVWHsb7KM10nVVUI2gm+98EnWOL+taX7l9QAoZHaqzWdMDUUUwYO159CQQpH3J
 +xMjqLIEVgIdICMZqI1bCfplgbF9Q5bENO/n27gKbT0BrSn4CKjpH8wlIquqGTP9sHrX
 kaMwh++YvgRjkOsViFJvv0mNWUf1jtvzcgQOqE5oPguzdGLyfEGd0sG+mJd2u4dpimxr
 pSnWg4+cHPbC+h8o13VcboPPhTrCm1EXEu2mxpUTrTNrS5D7iI4VMzYeMrH/o7lorVng
 mojAlZ+K5lGOtmE32H5oqR8Uyv/FQbFGYigmiD50aY7ravPhoHQpKCrkKIaQcWBIf0Fn
 OJtQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788882908; x=1789487708; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=BoiOdGkNTRiQ20DUGx/CzUhCmOuJHI3zN1BG1SmDyC8=;
 b=Fgqg6TIJ93ONW6SHRtK7s+LsSNAdvICcHdNsT2hr2MfgYdeUoDxpOtB/pM/yVXXJu0
 dXgV4JlD0bkvWRpL7QUmPpPSHAwO7N/Sh2R18HG8fWXC7oLWbbWYFOw/9Y6fOPQHt1gl
 7wPuRj4d7fLTeMR+BpVrPfFYv3LbzfnnOWvR0hdPWQoVEi/8chwQ1FGChfKl8JDql7oS
 2SArR5sOWLIdXyMdAID83YoCZl6GP2e8Eynvckt2I1cZRIiabPKAOjiBlRs+sfKjQ3F/
 1UZQxCMhXmIy6VAcsq7GBTBJ4O3j9kIYWLJmCiYa3dslypK7Q+jEMS7x4D5zDOjJ1F+u
 pC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788882908; x=1789487708;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=BoiOdGkNTRiQ20DUGx/CzUhCmOuJHI3zN1BG1SmDyC8=;
 b=TSGgakcd5y/M3933OVPuEpPU/po2OwtS9kS1BnHSnHA5w+pz/E9HQrSnq7zqDI11u/
 tb2U6fJhvQK30hwnObwCxwjVtvxHT1Ma4yBAQp4k65QWG2HSFulsXxYcXsaU9VYlBGpE
 lsbzTq3G4IsTzP+dgSYi+p6tTnq0GQDz+f9Z7cN668B+6VNgBuTcoYeUUUfAqm//KdwU
 KQ6id0PB6G4L1mBHJ/OH28OiWxyAMOrgxmuNKL61jrgvwm/vdgOJcISURujMYJMWccpp
 oXGmrUIVDh3xcj4TuOaPQWlmzcdE1O6AaXH85ugeiNRZm8kCXLaY6og+xtEmtrYJPXl9
 uu4g==
X-Gm-Message-State: AFuF++knJY81V6LtMYGeO6EThDf0nDEyX+kTVVe31pi45vhf7z3oRQ9s
 DHd91TBzT3+J4Sk0MZoKR5Qy5/gGQcprLClrXByuDc9vOF0TloRS7aWnO78gav3oQ+Kxtl3Kz6W
 TaCfiPuG0OP+jjSovUPXo08XVxXce8vSR8nTN171SDL2KdSGyKeUGejpakZUcs6e2WP6tAPEEk/
 SBZydRlPP0rvGdCurrL6WFUhDPQZmVzSva
X-Gm-Gg: AYBFou28MOH0T1A2r73St/IephXIXQx/Ip+hKRX5WzqV97Gu102mnaLdns3fJBqqDcy
 bsR2Nj6aBEHjX/fuBsSOJulqcDNYoTrdlAMPBawOelQypsWkv2RyOOEQBb1T28O/GeCe1KgJ/3a
 SM4ACbXsC8J6n9DPXJdzdpi3G7wm2CIuBEO23b2yH3hYXNPPZx0AJu9THRIQ==
X-Received: by 2002:a05:690c:e0d5:10b0:857:f33:6f1d with SMTP id
 00721157ae682-87122396144mr80484667b3.6.1788882908181; 
 Tue, 08 Sep 2026 08:55:08 -0700 (PDT)
X-Received: by 2002:a05:690c:e0d5:10b0:857:f33:6f1d with SMTP id
 00721157ae682-87122396144mr80484447b3.6.1788882907658; Tue, 08 Sep 2026
 08:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
 <20260905180949.1852673-2-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260905180949.1852673-2-brian.cain@oss.qualcomm.com>
From: Sid Manning <sid.manning@oss.qualcomm.com>
Date: Tue, 8 Sep 2026 10:54:56 -0500
X-Gm-Features: AcwNN1UKQXQIbB6b2F2CRoN4lHLgdGW8PY0Q6jApesVSf_W3vNfkIAIfDMF7uSE
Message-ID: <CAJpW4SXu9Otn_O37d-dGqiOcF+9-zL8mYVn0B33sC=b=8FFoKA@mail.gmail.com>
Subject: Re: [PATCH 01/17] tests/tcg/hexagon: fix undefined signed left shift
 in circ.c
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="0000000000004194c3065afac2e5"
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDE3MSBTYWx0ZWRfX8nr1YSqHcUwg
 egZ4/rFS73KQ2TZgz0Wr7155tfiMm0hSSjBOpJB/kPcuWE9IILXE9aOfAwSor6279iluZ3JbnkU
 s/xoy8pFgwxVuxV04NSK6VPYorQFyxY=
X-Proofpoint-ORIG-GUID: 8vPaGbXyUTkiXtFwD6NG6BfoMuitTXLC
X-Authority-Analysis: v=2.4 cv=TammcxQh c=1 sm=1 tr=0 ts=6aa02fdd cx=c_pps
 a=g1v0Z557R90hA0UpD/5Yag==:117 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=sC25wYaVvpZHD3WcN6UA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=G6KhYomvbhgvyHxHSrEA:9 a=oxr4_ypfeJXb6gGU:21 a=lqcHg5cX4UMA:10
 a=MFSWADHSvvjO3QEy5MdX:22
X-Proofpoint-GUID: 8vPaGbXyUTkiXtFwD6NG6BfoMuitTXLC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDE3MSBTYWx0ZWRfXxfyy2JX29Y9K
 gN09cRMJGfvRckV2bVtcPf4Kux9Ghrxk1OSUvukjGU5K3pv/BUyGaO7535kyLXJ73u6ubi+bOgw
 WR1kCX/K9IFYpGiBIBR6J2hv6sOqSf+Qa1sfHMgAkVAL1tzMeL6ZWIqqi58XfCSt9HdysRN7+wS
 MDFnp5ATxDDdzwjFwRVuj6mCZAsOp2lUK3wjuv9B2i5e61oGAmlc5KwcONiQi7L5Xq+j+wFMnuD
 6J2dpbhBbzDQFuDVl2qZn4w42ln39A7FUXC3pOlGjkXnPZIAUfwj+CUmmPPTct+qYFgIl0qgLMZ
 qdoqIWs7jNHM7f38VLbUGmCt2fR9bYA7Nd7DiZWevQanXV2IU3Rk0sx30DPy+67qr8HYHL+VGgF
 6z/5KSEW8+2xQmDdkFCZ9AiV5ZPFo11SWoqWCTGeHtyQsgKeA/AATcj/30gRrrG243+Zgq7LzTK
 yqpNjr5b/H49kdLZR2Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 lowpriorityscore=0 phishscore=0 adultscore=0
 spamscore=0 suspectscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609080171
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=sid.manning@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
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

--0000000000004194c3065afac2e5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

LGTM

On Sat, Sep 5, 2026 at 1:09=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm.=
com>
wrote:

> Cast operands to uint32_t before left-shifting in build_mreg() to
> avoid undefined behavior when the shift result overflows int32_t.
> Found with UBSan.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/circ.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/tests/tcg/hexagon/circ.c b/tests/tcg/hexagon/circ.c
> index ab949ebef1c..2a15c324242 100644
> --- a/tests/tcg/hexagon/circ.c
> +++ b/tests/tcg/hexagon/circ.c
> @@ -97,9 +97,9 @@ INIT(dbuf, NDOBLS)
>   */
>  static int32_t build_mreg(int32_t inc, int32_t K, int32_t len)
>  {
> -    return ((inc & 0x780) << 21) |
> -           ((K & 0xf) << 24) |
> -           ((inc & 0x7f) << 17) |
> +    return ((uint32_t)(inc & 0x780) << 21) |
> +           ((uint32_t)(K & 0xf) << 24) |
> +           ((uint32_t)(inc & 0x7f) << 17) |
>             (len & 0x1ffff);
>  }
>
> --
> 2.34.1
>
>

--0000000000004194c3065afac2e5
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">LGTM</div><br><div class=3D"gmail_quote gmail_quote_contai=
ner"><div dir=3D"ltr" class=3D"gmail_attr">On Sat, Sep 5, 2026 at 1:09=E2=
=80=AFPM Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com">bria=
n.cain@oss.qualcomm.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_=
quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,=
204);padding-left:1ex">Cast operands to uint32_t before left-shifting in bu=
ild_mreg() to<br>
avoid undefined behavior when the shift result overflows int32_t.<br>
Found with UBSan.<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0tests/tcg/hexagon/circ.c | 6 +++---<br>
=C2=A01 file changed, 3 insertions(+), 3 deletions(-)<br>
<br>
diff --git a/tests/tcg/hexagon/circ.c b/tests/tcg/hexagon/circ.c<br>
index ab949ebef1c..2a15c324242 100644<br>
--- a/tests/tcg/hexagon/circ.c<br>
+++ b/tests/tcg/hexagon/circ.c<br>
@@ -97,9 +97,9 @@ INIT(dbuf, NDOBLS)<br>
=C2=A0 */<br>
=C2=A0static int32_t build_mreg(int32_t inc, int32_t K, int32_t len)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 return ((inc &amp; 0x780) &lt;&lt; 21) |<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((K &amp; 0xf) &lt;&lt; 24) |<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((inc &amp; 0x7f) &lt;&lt; 17) |<=
br>
+=C2=A0 =C2=A0 return ((uint32_t)(inc &amp; 0x780) &lt;&lt; 21) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((uint32_t)(K &amp; 0xf) &lt;&lt;=
 24) |<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0((uint32_t)(inc &amp; 0x7f) &lt;&=
lt; 17) |<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 (len &amp; 0x1ffff);<br>
=C2=A0}<br>
<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div>

--0000000000004194c3065afac2e5--

