Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 724B6C79FB6
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 14:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4JWQ-0000Jd-Q6; Wed, 09 Sep 2026 10:43:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sid.manning@oss.qualcomm.com>)
 id 1x4JWE-0000Ii-MO
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 10:43:22 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sid.manning@oss.qualcomm.com>)
 id 1x4JWC-0005iI-Gc
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 10:43:22 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 689BU2RQ2019093
 for <qemu-devel@nongnu.org>; Wed, 9 Sep 2026 14:43:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=sCd7XnMT08YIUhK4dxF9NyGh
 gBRMF1Qjo21OJX/YEBM=; b=Gtvhyrk7bbDTOed6vr46fjfVv+IlzTy4l57f7iZ3
 oMQX4VzxHYcrf+9jsm0fG+ez5YT7jK0GJHdhK5Ct2HRDcZ8mRG/8hnw9yJcZB+Nn
 zoqLE8dU8sp24RJxP+TnUoHe7rxzka0cLHGyr4+IS74Lyp5+5m4MnZMByfwk0OE+
 aD8ZZVLDttbqJPBAXac2QEm0XH4DoTwZqppYNK2s2o3FmA6CbWhYcPIMEMI31SkB
 TayqBcMyGnPu/emW8aCmgapSjtHMo+FIttgvb448X4kVcIh9P+y1H6yJCIVQYrE5
 wGQ39Y6KSDbYiUqHTmYdS9bYe1g/gNcrJM1/7fXEEisbZw==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk62x8wq7-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 14:43:15 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-7f5b54da461so115842167b3.3
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 07:43:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788964995; cv=none;
 d=google.com; s=arc-20260327;
 b=fTbPcOi+Gco33G9Zfm23bK9pXgoXBGwK+9iq0g6TlBqNXOm5miElrz8HlXY4G1vGtG
 5mffbbJ7YzWgYSIcug+k12gbVMktf7Skp9Khxtw1aM+ogYI091XV2PWeLi3gg+a94ep6
 TRgISId0mSWzL4mP6x1U7z+snpy4fUcwodYBTMME6VcvMDjuAzdsUo2RY52VrhPnc0+u
 WNeeuqmKckNuj8lQSDPsENeLsISXUPPC1ulRjMMdDZpc4vJzoFxq+i71VmzNal6QF1jB
 dyE+Nlus0+KZYUK+NMvpc9krTuxM+vQeUqep6BCK+SGW0PcWYyPOFfQk0MvsEc/Ft5hj
 yrOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sCd7XnMT08YIUhK4dxF9NyGhgBRMF1Qjo21OJX/YEBM=;
 fh=+NGiuCaJkBcMFhTaOsG/B5aXYeWujaYLuYLP/6yolpU=;
 b=N1r7asGmiUOupcw0jx1OSC2R8+LTBIDrbXQ2qoCX40TUk1qxKSzZ8wBuQEWBuyC6ZE
 7JjtXsiSf1Qyiqp8TFub3hTHWA0OCUPyvnPo2DdAa0FC6WEIG60adJyUK3HvuKYgYqxW
 NYBkgE5B8VhQq/oduwlY0BLcz3nvy7Kd4bxYVIjGeH37FegI199H5r9JbTrGcDBtEGZs
 fIJOGNqsMMu6sixSMBCpgC1OBk2qj2VB1SQj+VAquFiHH0BA9hNN9SQjWThRAUgOFZAb
 sEuo4sIQdOrhAZMNzopKYT6W48ycY722n9VLM8SZiP8ZnYAbXdK/b+hdaSl2mXeEB4Wd
 GyYQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788964995; x=1789569795; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=sCd7XnMT08YIUhK4dxF9NyGhgBRMF1Qjo21OJX/YEBM=;
 b=RIxXshkYTbpTwIra3iYUaGnK3q9cJBrmtCboaQZsNl9A6DILSL0IsVoyeLtoXwNgmB
 +KInBcDPFHVGwGOxBJJxl125wmZmdiGYs+LgMOuQNSt/BGqvTUS1xqkl/TSCcEvddIJI
 iGnG0mDkB9zh6tb2EwG9tz2ECZtyeVlHDzs/1lMa+tXOoUVvuPTlBis1ZbRK2Ryy0F8L
 Tw5zvOOR1uVVAwxoc7GeluFkz2C3XmS2pmTEVoy0IxO0V0DfkBDP4puYnYE08DRj2w3V
 1GIFKb+fkb/gdguCJi1HTESi7CD3Kf/h9hgFpWeFwm3YSNjGR+LJJc+bEX0+ldge6xLy
 XeWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788964995; x=1789569795;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sCd7XnMT08YIUhK4dxF9NyGhgBRMF1Qjo21OJX/YEBM=;
 b=ENvKmVHHzed7+2V5speaaScCPC046q7jvU+6EJc03LJBMRwZRg8/BFcIFT3yZmQzYz
 qHzRqP3EzWTploiD0xSmJoWYoHYYDCt2plKEzopPmfwzEMxe71NZAKuAcdZR03PQLSkm
 qZgynkhLvgZrOITO5IYO1tEDuTV/UjalN878Rec2JGm3s/5OfrStpHRAAtnI35sfEjGc
 FZF8B8t9XD2kmHr69ihQ8YwqAv2meWGCvnvlYr2D/vHHSrK3xbaT8afl7pgrM0fXoebk
 oo81YbG4JIpJgFge/Z/xGPeC8BLD2N/4g+LWYV80Gj+ULdo2kbgZcK/E7m7io91UlHRP
 4uhw==
X-Gm-Message-State: AFuF++mRhWnEqlPSBa6VCculLiiFp7Z+2zo6mpEF/EyZc618T0uRWgkr
 CYqbj6R5AbhXqJGyVHaWp8IcQABu/lKLoEDJdx1qdEjFPOgO5MioQ8+EfooZS608vGimjqhisle
 0akSp+7AjqIqeRgwuTaK7dXosAW/Mauvq800pN6jelOkwTZNfDjX5lVq8YQEoK9feP177jUsXk8
 ifnAbA6NJwTHNy/ZYUsLoNnan1LnZkLsbW
X-Gm-Gg: AYBFou14ZkbVizY3Rr/7V3f57+LLTXnQ8VcdGmE5WTcykGemybih6tvE0ph1B4xKHbi
 +Zgx0M8qO//qrds4uT70DhEZOTHXJApZyrvOmtcmcC6z7vOx+Lkb1QFP1wAcIZYjo/HFz3Im7VH
 WZo7k4zBt1qC1I9SQmzv/9NLRwDSajtuG07BL8Y6wRb2SzuRILRJTlrJq7Tqw=
X-Received: by 2002:a05:690c:dc4:b0:820:15ad:522c with SMTP id
 00721157ae682-8771acca965mr80478397b3.11.1788964994990; 
 Wed, 09 Sep 2026 07:43:14 -0700 (PDT)
X-Received: by 2002:a05:690c:dc4:b0:820:15ad:522c with SMTP id
 00721157ae682-8771acca965mr80478007b3.11.1788964994394; Wed, 09 Sep 2026
 07:43:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
 <20260905180949.1852673-3-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260905180949.1852673-3-brian.cain@oss.qualcomm.com>
From: Sid Manning <sid.manning@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 09:43:03 -0500
X-Gm-Features: AcwNN1WhRqR-UsB3ZCd4GFheG-VQixw4Lsl0ZmkI4C_prNvYPZwI7KIwrEHzp5k
Message-ID: <CAJpW4SVzmDUqHXK6rh11aDRRGe4oABFgA9=znJotVOo8OhXfWg@mail.gmail.com>
Subject: Re: [PATCH 02/17] tests/tcg/hexagon: fix undefined signed left shift
 in brev.c
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="00000000000001bf96065b0ddf3e"
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE2NCBTYWx0ZWRfX8cwobOcDU7xt
 M0xaJZJPPMLo27tJDYBP+vSHJpvhvb/X42nZhFuxJAzqHi2ws8RAVS5MjVGshhDIwBUQblTaXbJ
 d1rMnkaXYGLgAFAjQ2WDo9uw4c/aPQw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE2NCBTYWx0ZWRfX9T9UZSK0uy+V
 y1r6kJJOE/e7pCzdAqzSz8ZN27hGAZvSOXSb6tDXfaE9z3ytdaGnc4lPi54gu6WokTvSu9JjWNy
 oiWs+EhNqBI9+rLX3w6GYBCk+AEHlx5f/dmIUYIQTw5L+XMMRYfUhqbRHZ/mreNjKhHucZd1Ngo
 /L78omcBuukTy7kF+vP/gYrkVV4jzqGHVM1tEcq9f8kOwnQar8tXjfouF/Un2WdNP123QaW5Ixn
 vYv/UuCkIBWnoEN1WQDIUT7EK3c3qeoxGFd4krvsQICoBVBthL1oV60JQMoNouVQ4hxX7YHkYox
 1Cvk5hE0WnsC+Fl6ldpuR3wx9f1r9eTG/dNje7D4LXgCp1D3iFUP8c1HTvCBv+ryx0W+0O0BzTd
 ihx+zMUZduusl1e3yezZxaIYzWn4v/kldzRVjRH1N31mF4PmbProx32ba+4tPPTTUNYOaHfMct2
 5m8s6X1WNNbFhmV9Cbw==
X-Authority-Analysis: v=2.4 cv=UeFhjqSN c=1 sm=1 tr=0 ts=6aa17083 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=k3Zke_hgPCLTMCfRxzAA:9 a=QEXdDO2ut3YA:10 a=zZCYzV9kfG8A:10
 a=opBqxjFusBnFnvBfOIMA:9 a=E6gFIum0B_P9BOX3:21 a=lqcHg5cX4UMA:10
 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-ORIG-GUID: 5X7oN3k-XiPbP5Oo1IZr1Ya_334as_V1
X-Proofpoint-GUID: 5X7oN3k-XiPbP5Oo1IZr1Ya_334as_V1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 bulkscore=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609090164
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

--00000000000001bf96065b0ddf3e
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

LGTM
Reviewed-by:Sid Manning sid.manning@oss.qualcomm.com


On Sat, Sep 5, 2026 at 1:09=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm.=
com>
wrote:

> Cast to uint32_t before left-shifting in sext8() to avoid undefined
> behavior when shifting a negative value. The subsequent arithmetic
> right shift on the int32_t cast correctly sign-extends the result.
> Found with UBSan.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/brev.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/tcg/hexagon/brev.c b/tests/tcg/hexagon/brev.c
> index 6c7b1340849..1473e309ee0 100644
> --- a/tests/tcg/hexagon/brev.c
> +++ b/tests/tcg/hexagon/brev.c
> @@ -106,7 +106,7 @@ uint32_t bitreverse(uint32_t x)
>
>  int32_t sext8(int32_t x)
>  {
> -    return (x << 24) >> 24;
> +    return (int32_t)((uint32_t)x << 24) >> 24;
>  }
>
>  #define TEST_BREV_LOAD(SZ, TYPE, BUF, SHIFT, EXP) \
> --
> 2.34.1
>
>

--00000000000001bf96065b0ddf3e
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>LGTM</div>Reviewed-by:Sid Manning <a href=3D"mailto:s=
id.manning@oss.qualcomm.com">sid.manning@oss.qualcomm.com</a><br>=C2=A0 =C2=
=A0</div><br><div class=3D"gmail_quote gmail_quote_container"><div dir=3D"l=
tr" class=3D"gmail_attr">On Sat, Sep 5, 2026 at 1:09=E2=80=AFPM Brian Cain =
&lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com">brian.cain@oss.qualcomm.=
com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=3D"marg=
in:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1e=
x">Cast to uint32_t before left-shifting in sext8() to avoid undefined<br>
behavior when shifting a negative value. The subsequent arithmetic<br>
right shift on the int32_t cast correctly sign-extends the result.<br>
Found with UBSan.<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0tests/tcg/hexagon/brev.c | 2 +-<br>
=C2=A01 file changed, 1 insertion(+), 1 deletion(-)<br>
<br>
diff --git a/tests/tcg/hexagon/brev.c b/tests/tcg/hexagon/brev.c<br>
index 6c7b1340849..1473e309ee0 100644<br>
--- a/tests/tcg/hexagon/brev.c<br>
+++ b/tests/tcg/hexagon/brev.c<br>
@@ -106,7 +106,7 @@ uint32_t bitreverse(uint32_t x)<br>
<br>
=C2=A0int32_t sext8(int32_t x)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 return (x &lt;&lt; 24) &gt;&gt; 24;<br>
+=C2=A0 =C2=A0 return (int32_t)((uint32_t)x &lt;&lt; 24) &gt;&gt; 24;<br>
=C2=A0}<br>
<br>
=C2=A0#define TEST_BREV_LOAD(SZ, TYPE, BUF, SHIFT, EXP) \<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div>

--00000000000001bf96065b0ddf3e--

