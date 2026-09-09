Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E313CC79FBB
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2026 14:51:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x4Jda-00068R-Ay; Wed, 09 Sep 2026 10:50:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sid.manning@oss.qualcomm.com>)
 id 1x4JdW-00067w-Ts
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 10:50:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sid.manning@oss.qualcomm.com>)
 id 1x4JdU-0007mP-1W
 for qemu-devel@nongnu.org; Wed, 09 Sep 2026 10:50:54 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 689BU7Mn2375945
 for <qemu-devel@nongnu.org>; Wed, 9 Sep 2026 14:50:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=pZ5iPdEq5vLCL7bQ8R/2Kni2
 eWiLmO2ZxaMRuKs3XL4=; b=XM3S86tUX4++UD+MpnKN34atCpJewQ74wnE9Q1jl
 eTuaoHH3Jd/uZpel7Bnocu5/MGcCj/EqRS4dve5jmhOMBxASDvrBuRT5qN3Wx7jw
 XOQeCJnD5u0a/SChMdv85muHN27YyAvGNQRmr860Nk+/WDI1qf9IkgYyQbYzgPR/
 /Z/FryIVYE4BOzHkDCFSaZYIt/cxU1+c2VPBw6StLYUG9TUOWtO2UaHjTp5Uf8/k
 FgzMGa2cmxrrPo3C5r3shnEy7yrLsdBzBE+ZkgxXmXgkRg+3aGcXUJKSBv30Afz/
 RkydO4liGU5BB1PaC/BfpXmlVPXab6aI9RnNl8nIxoREoQ==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gk5ru1242-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 14:50:50 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-86e8abd7136so83523197b3.0
 for <qemu-devel@nongnu.org>; Wed, 09 Sep 2026 07:50:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788965450; cv=none;
 d=google.com; s=arc-20260327;
 b=V/muZN/ULaEz2jhcpUk1I+Bhmwlr2C4FqdHhQ2AZwUbfccOwdS2jeHHq3HtBqHBL0X
 8YihJayVZyk2ZqwjGP1eaa6Q/mKt03R57paunJ7rde+dRSA6px0FV1v3xtfmQ4WRNsyB
 voJ0N7uhxQHUKMs382VCmzg4x0ekOi4isnbgCkkp3w9JkroyomziPzjNp/szMWb8n81H
 U4upaNuULPK09vFBUA7rGoOK/SF5LJsdQwYbORmUiQ+mTPTJSlbK3D5pzNM/z9MplwC4
 ZypYsg+k7MncG+6O0q1PaHNDCwtQaHF/yqe4botupwEao6kqLGb5WQ7+fI0fIUSuLMkI
 YP7Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=pZ5iPdEq5vLCL7bQ8R/2Kni2eWiLmO2ZxaMRuKs3XL4=;
 fh=+NGiuCaJkBcMFhTaOsG/B5aXYeWujaYLuYLP/6yolpU=;
 b=PoWzWJdbh7Oes7cYeb1yIDsf4KKlK8rH0pydUxht2/D+XvFFKakY/l+V2AYahNlFKC
 F5BpVcXtS/x4laCuk3Hsv51eU69qm9ON/M9o179M2gh0/8GtWognymXKw1GVOoyzddEm
 d9kUhmv8/OCCl3IC75qKFOtsFfD/FxU/k7SrzEfaeMI5e/8aYH3ctpv6UxbITFHjey7z
 t3AF+rOfSJkD7zjlKH74sjuwIcnJGwssEzNRzwhdk4dVe94gpjh0IejZj4JD8Qmx7a3r
 JAMlYhszURxDcK7Sk/8XWvNWZp3VIQpiz8gC/OnZpfq4F5CZLC5f0tS2AtpjDPnTthq/
 H36g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788965450; x=1789570250; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pZ5iPdEq5vLCL7bQ8R/2Kni2eWiLmO2ZxaMRuKs3XL4=;
 b=j9YaYLF4eqiUv4/PDE/7F/Cbg3awK7uE7CnL76A9X28ZrzKVAiIaG21SL94M0jZQ6d
 dCg1hn2HOp8cLeG2jahDRYj/tpmYeiu+HKhvKtHBptt+IMsYH8bDi+M1RGHqStFPjPoJ
 enfnFnmDCp+D9CkZSeovEh7BCzOUDShrIs6ZD4WlsWCLMzGjMHs3Hh+NHoaNev2Bv054
 BWf4ZzynCWOzNjWGSLR5yXEiCPCBk1q31JVT3+GmJDSsZO7IpgD9MI6TWf/4EPqv8O4g
 4pyLmZ6vwhQ5zEUiV57vdTnEgoPRKSs+tPcH9r456Y8gvNYACKy0nktWnESVX51pcxxw
 QPSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788965450; x=1789570250;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=pZ5iPdEq5vLCL7bQ8R/2Kni2eWiLmO2ZxaMRuKs3XL4=;
 b=oq9hwsKOPDrDtuiAY5WtkUekX7ZpN2t/qNQ9PgYoVn8fihOr7flju3q79THKDbEJAH
 EHN/QLNvFvr2rQ8J3tzrTR9lImL3SB7hQ4IP+1PmMnG6Y9mAbv65Jz22NpoLIzlL0nA8
 /ViMmzj2fi/MqQNje4oRKxhoqweNzWSjEX34RDpjRA4SPUbA1OaHCC4wcHSOhKF6o9we
 UzESFEtj97Ple229wkF3YRLCWCSQAyeAl6Bmg7TLQ44XJHhypemNLItXDjw71jlIZ3EP
 frp7k1JQaATw1kTonF9XUrI4ToTELbMsrk6xeCIk24W67fL73zs9jiGz/TITUQSqJN5n
 b6jg==
X-Gm-Message-State: AFuF++lQqSZigkArU+CR7uGJfE0WK/SFOoGrJ890+rtReasvXwba72Yl
 IPhkp+uzsQBXAZDjIKJ6/cmT0RWr+P2uKvmF5iU0hWak/H4UBzp5BjgUwm/jK8b+L6zUF65e1DE
 vgoYyPAxF2T9GuqklGXg3SClhfCxrsW35OgwkgiPiuOJ5XlGcYDslS/olNceQGDnQ1Rl1neQmFU
 LHGudlJiSZ+NNg2/O/cl2gH7ZjDOnv2z0T
X-Gm-Gg: AYBFou29jJjskRKbuhmout2Rbfkla3qWkrUStn9b7qophwb7B49MK0kCJV7fF5QHcSd
 zLwzeB2MoxwRaLPuUUOK9njRCWYJJc1xdQ9PtSO7RHJGVOz4sAOUb00TDXtn/0ALhbZHJ83uH2H
 00CbHIS0uuBByTn3iKpkPXvCgcEQeFwFp3KLSWnMl3pq+McKcEMkJ8xcB3MKg=
X-Received: by 2002:a05:690c:7685:b0:873:5bb2:6c09 with SMTP id
 00721157ae682-8735bb26f9cmr78715447b3.51.1788965450267; 
 Wed, 09 Sep 2026 07:50:50 -0700 (PDT)
X-Received: by 2002:a05:690c:7685:b0:873:5bb2:6c09 with SMTP id
 00721157ae682-8735bb26f9cmr78712017b3.51.1788965445028; Wed, 09 Sep 2026
 07:50:45 -0700 (PDT)
MIME-Version: 1.0
References: <20260905180949.1852673-1-brian.cain@oss.qualcomm.com>
 <20260905180949.1852673-4-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260905180949.1852673-4-brian.cain@oss.qualcomm.com>
From: Sid Manning <sid.manning@oss.qualcomm.com>
Date: Wed, 9 Sep 2026 09:50:33 -0500
X-Gm-Features: AcwNN1U8P2G-Tb9Ji4Pc6H9GfbnEHx1TWZ5BlIZcQDHRUvF162Dq1ISyZHpo-WE
Message-ID: <CAJpW4SWPRnrTbAC2miwHfnv6jUBu3vgkDN=2f+xVGZ1cmv+xMg@mail.gmail.com>
Subject: Re: [PATCH 03/17] tests/tcg/hexagon: fix undefined signed integer
 overflow in hvx_misc
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: multipart/alternative; boundary="000000000000dde116065b0df9de"
X-Authority-Analysis: v=2.4 cv=M+997Sws c=1 sm=1 tr=0 ts=6aa1724a cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=Sjdfk4fB4pV5bCyifT8A:9 a=QEXdDO2ut3YA:10
 a=IqUmWrIzHOg6Eo0noHsA:9 a=irOnvDzGuFcAat7-:21 a=lqcHg5cX4UMA:10
 a=kLokIza1BN8a-hAJ3hfR:22
X-Proofpoint-GUID: _p3kTGouRvAlBebTAXkDemvIiwDKNTD3
X-Proofpoint-ORIG-GUID: _p3kTGouRvAlBebTAXkDemvIiwDKNTD3
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA5MDE2NSBTYWx0ZWRfX/BVTLEKOe8Xl
 WKhekyMZh00iyF6s7rVk5w/w+1FgUosphHFN5VpjsF9oEK3wxPWg3ArNZy3yAMt4F/uvdaMfquv
 AsxtposmW6fDuVHdDKvpThfmEkkuZmM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA5MDE2NSBTYWx0ZWRfXyb9Ohz7XbOoQ
 RGYeoAe9tp0q9oyRVx1GTHGYSh+g925tHzCMeGKOdXZ+dduZwbXrrJNryYDaA7thv1Lpd4zXXbF
 R1Zk4+UYEVxJ2mwK4ksco9k+zdVNQo/mS1RRdv2k++8puO8MgMBoNCY2ffy9/gEgE7JZzAYZ2NF
 XKGWMUcBmywiBPTvs/mn+Ltc62Uv5F77iViO4evYm7wQ4LBtNjNyLjXEE9vI2+v5l0+5TfxY1wg
 u5KZYfhjoLRZvskrbRXBiBJwOTVzBXZ4mmqYjZ0/Al8/ZSq8xk6XUXSuCS/1Y2whwOORi5+vjKB
 yBzRFGbodSZ1IW7paqLiGRL3YTy6tAXZyjBe3PNka/bfDo3CAM0JdCpQdM/5kBf4MaBLJJXDbuX
 yUHoi1ZDgvvA9M9jB3KJdsv16/xZcy7fkyODue3caL9xf0H8DQ1Rd7XkroCo2mxnlfScGm5jvhc
 YK1E6u3tltrku7y5SwQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-08_03,2026-09-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 phishscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609090165
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

--000000000000dde116065b0df9de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

LGTM
Reviewed-by:Sid Manning sid.manning@oss.qualcomm.com

On Sat, Sep 5, 2026 at 1:09=E2=80=AFPM Brian Cain <brian.cain@oss.qualcomm.=
com>
wrote:

> Use unsigned (.uw) instead of signed (.w) array members for
> vector addition and subtraction reference calculations to avoid
> signed integer overflow. Wrapping arithmetic is well-defined for
> unsigned types. Add CHECK_OUTPUT_FUNC(uw, 4) to support unsigned
> word comparisons in the TEST_VEC_OP2 macro.
> Found with UBSan.
>
> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
> ---
>  tests/tcg/hexagon/hvx_misc.h |  1 +
>  tests/tcg/hexagon/hvx_misc.c | 18 +++++++++---------
>  2 files changed, 10 insertions(+), 9 deletions(-)
>
> diff --git a/tests/tcg/hexagon/hvx_misc.h b/tests/tcg/hexagon/hvx_misc.h
> index c21ea975c16..e32715ed11d 100644
> --- a/tests/tcg/hexagon/hvx_misc.h
> +++ b/tests/tcg/hexagon/hvx_misc.h
> @@ -69,6 +69,7 @@ static inline void check_output_##FIELD(int line, size_=
t
> num_vectors) \
>  CHECK_OUTPUT_FUNC(d,  8)
>  CHECK_OUTPUT_FUNC(w,  4)
>  CHECK_OUTPUT_FUNC(sf, 4)
> +CHECK_OUTPUT_FUNC(uw, 4)
>  CHECK_OUTPUT_FUNC(h,  2)
>  CHECK_OUTPUT_FUNC(uh, 2)
>  CHECK_OUTPUT_FUNC(hf, 2)
> diff --git a/tests/tcg/hexagon/hvx_misc.c b/tests/tcg/hexagon/hvx_misc.c
> index 32a3661a86f..f20afc8e670 100644
> --- a/tests/tcg/hexagon/hvx_misc.c
> +++ b/tests/tcg/hexagon/hvx_misc.c
> @@ -55,7 +55,7 @@ static void test_load_tmp(void)
>          pout +=3D sizeof(MMVector);
>
>          for (int j =3D 0; j < MAX_VEC_SIZE_BYTES / 4; j++) {
> -            expect[i].w[j] =3D buffer0[i].w[j] + buffer1[i].w[j] + 1;
> +            expect[i].uw[j] =3D buffer0[i].uw[j] + buffer1[i].uw[j] + 1;
>          }
>      }
>
> @@ -285,8 +285,8 @@ static void test_max_temps()
>
>          /* The first two vectors come from the vadd-pair instruction */
>          for (int i =3D 0; i < MAX_VEC_SIZE_BYTES / 4; i++) {
> -            expect[0].w[i] =3D buffer0[0].w[i] + buffer0[2].w[i];
> -            expect[1].w[i] =3D buffer0[1].w[i] + buffer0[3].w[i];
> +            expect[0].uw[i] =3D buffer0[0].uw[i] + buffer0[2].uw[i];
> +            expect[1].uw[i] =3D buffer0[1].uw[i] + buffer0[3].uw[i];
>          }
>          /* The third vector comes from the vshuffe instruction */
>          for (int i =3D 0; i < MAX_VEC_SIZE_BYTES / 2; i++) {
> @@ -295,7 +295,7 @@ static void test_max_temps()
>          }
>          /* The fourth vector comes from the vadd-single instruction */
>          for (int i =3D 0; i < MAX_VEC_SIZE_BYTES / 4; i++) {
> -            expect[3].w[i] =3D buffer0[1].w[i] + buffer0[5].w[i];
> +            expect[3].uw[i] =3D buffer0[1].uw[i] + buffer0[5].uw[i];
>          }
>          /*
>           * The fifth vector comes from the load to v4
> @@ -306,10 +306,10 @@ static void test_max_temps()
>          check_output_b(__LINE__, 5);
>  }
>
> -TEST_VEC_OP2(vadd_w, vadd, .w, w, 4, +)
> +TEST_VEC_OP2(vadd_w, vadd, .w, uw, 4, +)
>  TEST_VEC_OP2(vadd_h, vadd, .h, h, 2, +)
>  TEST_VEC_OP2(vadd_b, vadd, .b, b, 1, +)
> -TEST_VEC_OP2(vsub_w, vsub, .w, w, 4, -)
> +TEST_VEC_OP2(vsub_w, vsub, .w, uw, 4, -)
>  TEST_VEC_OP2(vsub_h, vsub, .h, h, 2, -)
>  TEST_VEC_OP2(vsub_b, vsub, .b, b, 1, -)
>  TEST_VEC_OP2(vxor, vxor, , d, 8, ^)
> @@ -489,9 +489,9 @@ static void test_load_tmp_predicated(void)
>          pout +=3D sizeof(MMVector);
>
>          for (int j =3D 0; j < MAX_VEC_SIZE_BYTES / 4; j++) {
> -            expect[i].w[j] =3D
> -                pred ? buffer0[i].w[j] + buffer1[i].w[j] + 1
> -                     : buffer0[i].w[j] + 2;
> +            expect[i].uw[j] =3D
> +                pred ? buffer0[i].uw[j] + buffer1[i].uw[j] + 1
> +                     : buffer0[i].uw[j] + 2;
>          }
>          pred =3D !pred;
>      }
> --
> 2.34.1
>
>

--000000000000dde116065b0df9de
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">LGTM<div>Reviewed-by:Sid Manning=C2=A0<a href=3D"mailto:si=
d.manning@oss.qualcomm.com" target=3D"_blank">sid.manning@oss.qualcomm.com<=
/a></div></div><br><div class=3D"gmail_quote gmail_quote_container"><div di=
r=3D"ltr" class=3D"gmail_attr">On Sat, Sep 5, 2026 at 1:09=E2=80=AFPM Brian=
 Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com">brian.cain@oss.qua=
lcomm.com</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" style=
=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding=
-left:1ex">Use unsigned (.uw) instead of signed (.w) array members for<br>
vector addition and subtraction reference calculations to avoid<br>
signed integer overflow. Wrapping arithmetic is well-defined for<br>
unsigned types. Add CHECK_OUTPUT_FUNC(uw, 4) to support unsigned<br>
word comparisons in the TEST_VEC_OP2 macro.<br>
Found with UBSan.<br>
<br>
Signed-off-by: Brian Cain &lt;<a href=3D"mailto:brian.cain@oss.qualcomm.com=
" target=3D"_blank">brian.cain@oss.qualcomm.com</a>&gt;<br>
---<br>
=C2=A0tests/tcg/hexagon/hvx_misc.h |=C2=A0 1 +<br>
=C2=A0tests/tcg/hexagon/hvx_misc.c | 18 +++++++++---------<br>
=C2=A02 files changed, 10 insertions(+), 9 deletions(-)<br>
<br>
diff --git a/tests/tcg/hexagon/hvx_misc.h b/tests/tcg/hexagon/hvx_misc.h<br=
>
index c21ea975c16..e32715ed11d 100644<br>
--- a/tests/tcg/hexagon/hvx_misc.h<br>
+++ b/tests/tcg/hexagon/hvx_misc.h<br>
@@ -69,6 +69,7 @@ static inline void check_output_##FIELD(int line, size_t =
num_vectors) \<br>
=C2=A0CHECK_OUTPUT_FUNC(d,=C2=A0 8)<br>
=C2=A0CHECK_OUTPUT_FUNC(w,=C2=A0 4)<br>
=C2=A0CHECK_OUTPUT_FUNC(sf, 4)<br>
+CHECK_OUTPUT_FUNC(uw, 4)<br>
=C2=A0CHECK_OUTPUT_FUNC(h,=C2=A0 2)<br>
=C2=A0CHECK_OUTPUT_FUNC(uh, 2)<br>
=C2=A0CHECK_OUTPUT_FUNC(hf, 2)<br>
diff --git a/tests/tcg/hexagon/hvx_misc.c b/tests/tcg/hexagon/hvx_misc.c<br=
>
index 32a3661a86f..f20afc8e670 100644<br>
--- a/tests/tcg/hexagon/hvx_misc.c<br>
+++ b/tests/tcg/hexagon/hvx_misc.c<br>
@@ -55,7 +55,7 @@ static void test_load_tmp(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pout +=3D sizeof(MMVector);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (int j =3D 0; j &lt; MAX_VEC_SIZE_BYT=
ES / 4; j++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 expect[i].w[j] =3D buffer0[i].w[=
j] + buffer1[i].w[j] + 1;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 expect[i].uw[j] =3D buffer0[i].u=
w[j] + buffer1[i].uw[j] + 1;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
@@ -285,8 +285,8 @@ static void test_max_temps()<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* The first two vectors come from the va=
dd-pair instruction */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (int i =3D 0; i &lt; MAX_VEC_SIZE_BYT=
ES / 4; i++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 expect[0].w[i] =3D buffer0[0].w[=
i] + buffer0[2].w[i];<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 expect[1].w[i] =3D buffer0[1].w[=
i] + buffer0[3].w[i];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 expect[0].uw[i] =3D buffer0[0].u=
w[i] + buffer0[2].uw[i];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 expect[1].uw[i] =3D buffer0[1].u=
w[i] + buffer0[3].uw[i];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* The third vector comes from the vshuff=
e instruction */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (int i =3D 0; i &lt; MAX_VEC_SIZE_BYT=
ES / 2; i++) {<br>
@@ -295,7 +295,7 @@ static void test_max_temps()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/* The fourth vector comes from the vadd-=
single instruction */<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (int i =3D 0; i &lt; MAX_VEC_SIZE_BYT=
ES / 4; i++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 expect[3].w[i] =3D buffer0[1].w[=
i] + buffer0[5].w[i];<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 expect[3].uw[i] =3D buffer0[1].u=
w[i] + buffer0[5].uw[i];<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0/*<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 * The fifth vector comes from the load t=
o v4<br>
@@ -306,10 +306,10 @@ static void test_max_temps()<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0check_output_b(__LINE__, 5);<br>
=C2=A0}<br>
<br>
-TEST_VEC_OP2(vadd_w, vadd, .w, w, 4, +)<br>
+TEST_VEC_OP2(vadd_w, vadd, .w, uw, 4, +)<br>
=C2=A0TEST_VEC_OP2(vadd_h, vadd, .h, h, 2, +)<br>
=C2=A0TEST_VEC_OP2(vadd_b, vadd, .b, b, 1, +)<br>
-TEST_VEC_OP2(vsub_w, vsub, .w, w, 4, -)<br>
+TEST_VEC_OP2(vsub_w, vsub, .w, uw, 4, -)<br>
=C2=A0TEST_VEC_OP2(vsub_h, vsub, .h, h, 2, -)<br>
=C2=A0TEST_VEC_OP2(vsub_b, vsub, .b, b, 1, -)<br>
=C2=A0TEST_VEC_OP2(vxor, vxor, , d, 8, ^)<br>
@@ -489,9 +489,9 @@ static void test_load_tmp_predicated(void)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pout +=3D sizeof(MMVector);<br>
<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0for (int j =3D 0; j &lt; MAX_VEC_SIZE_BYT=
ES / 4; j++) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 expect[i].w[j] =3D<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pred ? buffer0[i].=
w[j] + buffer1[i].w[j] + 1<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0: buffer0[i].w[j] + 2;<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 expect[i].uw[j] =3D<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 pred ? buffer0[i].=
uw[j] + buffer1[i].uw[j] + 1<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0: buffer0[i].uw[j] + 2;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0pred =3D !pred;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
-- <br>
2.34.1<br>
<br>
</blockquote></div>

--000000000000dde116065b0df9de--

