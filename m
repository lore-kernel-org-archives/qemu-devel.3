Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA474C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 14:51:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Jds-0006FF-Nb; Wed, 09 Sep 2026 10:51:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sid.manning@oss.qualcomm.com>)
 id 1x4Jdr-0006F0-Go
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 10:51:15 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sid.manning@oss.qualcomm.com>)
 id 1x4Jdp-0007oE-TZ
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 10:51:15 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 689BU2mD1810036
 for <qemu-devel@nongnu.org>; Wed, 9 Sep 2026 14:51:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=Lr+z//p5UOygINpjcW03t5En
 jnhz8XXws60AE1p4HGo=; b=LawyGNufzcq8ROhgFgahK0+X5sPRcbMn0+2mZL4P
 Z14VV4Z4zP6eC78AuX+EGVJ5/s39DuAVYLS9VLAXNXpH1CR4LV+Q8eyYWTST/ZPB
 yygGmIHwgLLyT4vlzT6ewCFTYDn+c+mwgosE2SzdUsA24+CHTLxC08tGGecmniYF
 M//bAdemNFoj4yq6sWdiGwwDYq7QwVHY636i+7w0QdlOoTKZxqvIBfokUvzJ48L3
 d+kT6qY+8zwjNwwlrPdVb4B1BWWw3M4GgXCnWp8IvkmH+Vis1/RZp9eOpOQI7CPQ
 O8w3oIDN9sq7sYGI0NgQlY/geueLUZ3zwFr+qN1DOEapkg==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk4xj18gf-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 14:51:12 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-8563c2a53dbso116137867b3.2
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 07:51:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788965472; cv=none;
 d=google.com; s=arc-20260327;
 b=Cpsl0MlfGDwwRk6FSGm21vGDOiKJ510AD4UwJCzeZPhG6a78wAECnigKqk4nSpo/jN
 ZIs+wUzUHprBc8uKwZ+sGvOeHYfbpHEeywzG1+8DDNrpQWIGEGQKtxpHAj1Hk+kz2xn1
 r/Ioho6gLVijqkfWeC9ExmLJ0MiyUV5Z9NU9kVCaWyh9RC/sf1iax0s2qRG3UkAFQc2E
 a4wu8KiSM6qePTSf4IIETJBTxvsDd7DnsaGzCXlcmXduj6POfS367cHnYc/F20hZLLJf
 Jta9ILyBnlgC7O1li+J7/XIQHViXW4vSzFrmmoWL9PucTtC+eOU03fQPBpAPDxoBn1gP
 2ZLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Lr+z//p5UOygINpjcW03t5Enjnhz8XXws60AE1p4HGo=;
 fh=+NGiuCaJkBcMFhTaOsG/B5aXYeWujaYLuYLP/6yolpU=;
 b=GpSxx2NTnPfcrsf/FrEjz8cj0slE1mikUGSF09g4i72iWUyuowbnOnpUdJQ6PedtQj
 JzslJuMBQbNau9B9dMQ51jbc8q6zZigZgBm7YgXULykbFGEsV/2NA772+EVxDcg+/EEI
 83vINpJkS9TT606wvcMFCc9zYdwSDsYcqY/71D3COHubzqUMqjM6qBOKrNnGkumuUEHE
 NYq/Y4VTwUn9guLRdIbuYbBgr2X0W8LqEW7/qFSrI/1eTnLyBIdQZ+iLcpeyqE6p4Cmw
 8ChDwKWkmEcLxMfWh5Qr2FZt3Mp+EzcAfzN8pv6iUeEsLLfYcUGfzZgsozMLP0ocw938
 k0UQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788965472; x=1789570272; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Lr+z//p5UOygINpjcW03t5Enjnhz8XXws60AE1p4HGo=;
 b=LOgz0rOKnFd83oFo4wJWVnmMEb2fq7fpzmHcDWfaxyqwgkbQ5PvNDrtFrNwhthjO+I
 JjOnOEMCZrC8GDcUTuIkDbQChiiykvPlTvM8771XJUE9ZVYGaY7GJ1u+pHift1IvsJO5
 dhXWj54GFTy/gOpBwG5dFvp9TaB4gZE60eNCM0JPhix+YoSoZe5SSrHv31eiBUyga3bo
 wK/qcnbBaPxrheGGRWlzBTotpeayyrr4jbpHDQ1uMpgPt78AQjO8ieRYGI/U9W2yulJy
 4KXkzFSDca1azOyqBfY3YZ4mEIDxj1JEUJtDya9rO+W8KIdwR8ZOfX5/KlaXXjaxEuWs
 0Y2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788965472; x=1789570272;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Lr+z//p5UOygINpjcW03t5Enjnhz8XXws60AE1p4HGo=;
 b=kRIfay29pngTZcbZJjuKrx+pTUPgemawE0cC9Y5xOj4Jqmnabl6rWqaGNG+Is1E+9h
 cxnM01UpjHMPhZeVTpD9Rie4b/A1/0dco/f/L8H8vwoICwbQTtN33CL0GoxG/HsdRQuX
 URH6VeGUE6PdtVArzzh83iRTtbYvPKp4/+T8rI6aT6WjsgtJjt0t1eB8rgu0moo7Mmz1
 uNODBWgpcEDoC5d7WDM7U/1Hx6J2JPFiqJq+NOiQDvqB9Ft0wqrqx5CJlSrmBEegXm++
 ++c6RIe2E/nc1mo9cvc29H0Q8lJOAEudIbORPVoycHYKYvatOaumBJMwWDl/xMoHAi5D
 OiNA==
X-Gm-Message-State: AFuF++lzMgqIXFwZt1q/IN60OvRhaLJZmBs124gd5SZIYIkVjI60ageU
 jYtOj7HtEzeUl4BhqDxOX/mzpDr221L+FC28vROVs9A05+aYbjKO+clrf4YPkLkZA5TH1IHO9HG
 v6gktIdac9jCRm6ca2NERxRbptG/HXf7W8qXCzR3iuMpYFmdFGyu8qBhfZr+KrlUp5tWqzB8QVy
 2Dfw75/Dp8EKP6OC7TYrMx7+Swe1nXSEBz
X-Gm-Gg: AYBFou1wpKaGgW+C/YLUZzFSTthFZ2UXzzENrkAj4ix3MiZFlOqTiaSDmdSJOSYvV03
 wSJSrQfqLrta8nfedpWlwfkekL7XynhcI/Xa6SEw8P+bOX72D7xJRJA5BLWWbcWOemCjmnXZGcy
 RkagLuZdTFqTjnU/PbZ7eJSUxa9DH0HHKjAGnI8UpWST/A4zENJ//ZM2xUcFw=
X-Received: by 2002:a05:690c:620f:b0:841:773e:8d86 with SMTP id
 00721157ae682-871232363dfmr142170407b3.15.1788965472083; 
 Wed, 09 Sep 2026 07:51:12 -0700 (PDT)
X-Received: by 2002:a05:690c:620f:b0:841:773e:8d86 with SMTP id
 00721157ae682-871232363dfmr142169937b3.15.1788965471680; Wed, 09 Sep 2026
 07:51:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
 <20260905180949.1852673-5-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260905180949.1852673-5-brian.cain@oss.qualcomm.com>
From: Sid Manning <sid.manning@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 09:51:00 -0500
X-Gm-Features: AcwNN1U6zu3dI6yCDk5T3KGfTUzVbueTpG6U4Z_AfTT4huCaJ8c1EjtHIIj7_AY
Message-ID: <CAJpW4SW3mi3K92t60nXTz5xrig6AM4ZgNF0R72Wc5yc55jn=Vw@mail.gmail.com>
Subject: Re: [PATCH 04/17] tests/tcg/hexagon: fix undefined integer overflow
 in v69_hvx.c
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000074a189065b0dfbeb"
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE2NSBTYWx0ZWRfX0dBNg7o8Cbng
 Wd4MWFSTYqLtuf9aseN4aIba4mnnrLh3InxGdFoaxFJAO/fQ2blhm/8A9y8HHF07BYgFXgnWwZp
 9AOdepGwHvI9RxMFmWiWbWbj5lr3BtQ=
X-Authority-Analysis: v=2.4 cv=J52aKgnS c=1 sm=1 tr=0 ts=6aa17260 cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=ZGBiPB4t8C5t0fS2DQkA:9 a=QEXdDO2ut3YA:10
 a=MqPuF_3yjRpNE565w7IA:9 a=BSoMhGkt5RHfF3Dn:21 a=lqcHg5cX4UMA:10
 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-ORIG-GUID: KKTWA9pzf7hqWUWqBMSLJG_P42saAbcP
X-Proofpoint-GUID: KKTWA9pzf7hqWUWqBMSLJG_P42saAbcP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE2NSBTYWx0ZWRfX0qBaPsk5P4tp
 Y7UrspV7OQg8g9P0gnxmYpYrUKgrzyLPjJKdvedHuLOeUE5iZgUfd3Cb/00Qw/0l9ycBkHJ9jNP
 8RhUKR/lA6oFe644GApSaucdUHvw9/kpmabKGPK6XJxQp9vsZ8iba22tRXHf+fwqlclCNOqucbe
 X7cioRIviiaNE7ZDuDf8Xntjttr2CLQzJGQKQewqgeltQrVkmysUTgqBwB5RoxFFFyxqJdexZiy
 N07qglu73E+5HKJ1Hr0VFxqf7mNiFRinpaxVFeF7vHDriDRBiiLlkAr+I7cTZCdJKjh3FY/Md2W
 z1lnHIX5u9MVhxINz4dc1n/SjOm5WckXutYgDZIN1kqouggErMMXCyCpbZlAqZX2cSMzS9YnQ+/
 f3b2MOs8VzYQBBECIyf7jRNe+ey2hc0ruMsu3GmZnj84pU7qbaUHozI3hP1zbgf9ZfHvQo5nnzj
 DNW21zkg8dT3zVQYZ8w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0
 suspectscore=0 impostorscore=0 bulkscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090165
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=sid.manning@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

--00000000000074a189065b0dfbeb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

LGTM
Reviewed-by:Sid Manning sid.manning@oss.qualcomm.com

On Sat, Sep 5, 2026 at 1:10=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm.=
com>
wrote:

> Cast to uint32_t before multiplying uint16_t values to prevent
> signed integer overflow. Without the cast, the uint16_t operands
> are promoted to int, and the product can overflow the int range.
> Found with UBSan.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/v69_hvx.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/tests/tcg/hexagon/v69_hvx.c b/tests/tcg/hexagon/v69_hvx.c
> index a0d567d142f..eff936064a0 100644
> --- a/tests/tcg/hexagon/v69_hvx.c
> +++ b/tests/tcg/hexagon/v69_hvx.c
> @@ -292,7 +292,8 @@ static void test_vmpyuhvs(void)
>          pout +=3D sizeof(MMVector);
>
>          for (int j =3D 0; j < MAX_VEC_SIZE_BYTES / 2; j++) {
> -            expect[i].uh[j] =3D (buffer0[i].uh[j] * buffer1[i].uh[j]) >>=
 16;
> +            expect[i].uh[j] =3D
> +                ((uint32_t)buffer0[i].uh[j] * buffer1[i].uh[j]) >> 16;
>          }
>      }
>
> --
> 2.34.1
>
>

--00000000000074a189065b0dfbeb
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>LGTM</div>Reviewed-by:Sid Manning=C2=A0<a href=3D"mai=
lto:sid.manning@oss.qualcomm.com" target=3D"_blank">sid.manning@oss.qualcom=
m.com</a></div><br><div class=3D"gmail_quote gmail_quote_container"><div di=
r=3D"ltr" class=3D"gmail_attr">On Sat, Sep 5, 2026 at 1:10=E2=80=AFPM Brian=
 Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com">brian.cain@oss.qua=
lcomm.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Cast to uint32_t before multiplying uint16_t values to prevent<b=
r>
signed integer overflow. Without the cast, the uint16_t operands<br>
are promoted to int, and the product can overflow the int range.<br>
Found with UBSan.<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0tests/tcg/hexagon/v69_hvx.c | 3 ++-<br>
=C2=A01 file changed, 2 insertions(+), 1 deletion(-)<br>
<br>
diff --git a/tests/tcg/hexagon/v69_hvx.c b/tests/tcg/hexagon/v69_hvx.c<br>
index a0d567d142f..eff936064a0 100644<br>
--- a/tests/tcg/hexagon/v69_hvx.c<br>
+++ b/tests/tcg/hexagon/v69_hvx.c<br>
@@ -292,7 +292,8 @@ static void test_vmpyuhvs(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pout +=3D sizeof(MMVector);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (int j =3D 0; j &lt; MAX_VEC_SIZE_BYT=
ES / 2; j++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 expect[i].uh[j] =3D (buffer0[i].=
uh[j] * buffer1[i].uh[j]) &gt;&gt; 16;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 expect[i].uh[j] =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 ((uint32_t)buffer0=
[i].uh[j] * buffer1[i].uh[j]) &gt;&gt; 16;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div>

--00000000000074a189065b0dfbeb--

