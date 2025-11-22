Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1074ACF64B1
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 03:37:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMdLw-0006XC-9n; Fri, 21 Nov 2025 21:27:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vMdLp-0006SB-Or
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 21:27:50 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1vMdKs-0006Sn-AN
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 21:27:47 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 5ALLeuiF2756812
 for <qemu-devel@nongnu.org>; Sat, 22 Nov 2025 02:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=qcppdkim1; bh=iqxsqaEplUwxnHGWt9IUZNF5
 X4rbUclECOfZirFwrfM=; b=dsKDElTaO+eHlrP+N7fXLqKaX+FomXJyEiPVKLZ7
 /hszhHw7AWLWY1DSvEkDDfghH/ZURJZIr1TY2jm5oynWgwsNEjA/If7RL7+X7rjE
 oweToglxDZrY5mbk+1zMTW/Ivgl01AdKYShD7O4XhAO2kqQhVZEBe+TBy0YlU8Ko
 PzO9A3YQxdBB+cjKC5q2VpfXPFgYJh2Ao0+5IBagxxxqeNr5BfDKGDM8ezHXJEo+
 ljBZucYbO57ApEU3rfwnAJia7JDr4TF+iFuLiLSk4UrnY2/oulDwNiDIKj6K2BzF
 h7g1Zp5BzouYTy2EQPLzANytaj/YOIff2vfbtyi5XETxUA==
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ajhy63g5k-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 22 Nov 2025 02:26:31 +0000 (GMT)
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-787fdf1b574so38807797b3.1
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 18:26:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1763778391; x=1764383191; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=iqxsqaEplUwxnHGWt9IUZNF5X4rbUclECOfZirFwrfM=;
 b=Xi8Z1h03JxUlk9uwUnCKJBKkdSxmv8Mt0LqRUnGbKBLqKnK07EuDZ1bvM1JQBKa5F0
 RnxDnk2a9XSZZ9cbYyG1GwrxmdMttyYPJjqoZbWM35waDSmhKWOr/9jABGdRG8RkxQL4
 8wUWFhkeEzpe5Bq6e/gYGiIMtjHjflXoKY09nM7efG9G6E3is2SHzj4l210AhX/npocq
 8EquMmCQg3Jw05PNiUlaENCuMUKqSETulHEtKs+qJNXdrK3PR18fb9533z8OmHtQi0QD
 mehRGTsVu98VGhyme8CxmxiGIuTTd/Wwub/j7EA3owwGq6L1YAg4tIY1cry9nlFzVB4/
 /fQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763778391; x=1764383191;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iqxsqaEplUwxnHGWt9IUZNF5X4rbUclECOfZirFwrfM=;
 b=q22P/zbPql9wSz4FB1qJ9vqw9V4YDX+WAAwMWWV4lC8H/IpZLPQBcNZb/+QVzrA66P
 zqG2QGK4jB8ISV7/7zRNhIj7OM6Zfg2451hTGc5ZSyM1s4Ul9piF/3MH57D9yVz4yFqd
 SURXtH5JKcIwubmw7wBqULoIBdJfaq+oG+XWObzJah17nMXhE6qkhgAUIkvfCnw2SxXb
 tTA7CZsFIMbEalPU6Ju6z+61QxtywGZQ8IRD+B/0U0MsFXOQdWlZ2BqrU1OX3mYRd2CB
 MHiimdRe4HeJYHpSqxK4L+dYQKEEvGQ7P13wYDClxtmCqBOSixrTb+3Sv6GBDhdGw9Ad
 vvRw==
X-Gm-Message-State: AOJu0Yx9cMuzU1x/Dt9PyKvl9MErHE+Zh04p6YAejMWDrTi8C0fQVq1O
 Ef4jK9jkeKX7q6DonAH5gVumfVTx1CZF60cgP1hcyFyS7mi1bcl33G34pMrSOnRQCkKIelcE+//
 OBW8CBO/fcWHSmKkRGZhHF6BBHe3CT0ngnL+4wvUz1ndyTTioBqt6HY+A7mfHHnWD5/NTAHFDQN
 vloBsrwsTUsQ+fl35MQOJp4z8ajRX6pbK+
X-Gm-Gg: ASbGncvFhj9Ifd2Cj/jX/haMaPfyo3cvBKf0fV/0Tu1TjPu817YvSLAO3LFPNsccKLg
 9gDOZWdWLzEZTwI1Mh6b+yOBPJMP4j4Hk67I4tVY+FjFrSKZL/rpvZi9hj10LefnNO8Hx53tFjF
 /4BqZbEIxUCuIt5GAuP/6EBEO3xCxRn9Dkw+6iYOsL0i6mth6BPS2SyY+BhajWO8Tp2w==
X-Received: by 2002:a05:690c:368a:b0:785:caab:e660 with SMTP id
 00721157ae682-78a8b4979dcmr37440127b3.26.1763778390998; 
 Fri, 21 Nov 2025 18:26:30 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfRJB9655CI6oJrf1bzX49NUOzA5CP8eyOt2ySKHP/neAUDMwaG2wz4XQpwqMPqqRIkC9dvDR54ZKirY0nNEI=
X-Received: by 2002:a05:690c:368a:b0:785:caab:e660 with SMTP id
 00721157ae682-78a8b4979dcmr37439977b3.26.1763778390599; Fri, 21 Nov 2025
 18:26:30 -0800 (PST)
MIME-Version: 1.0
References: <20251121134503.30914-1-philmd@linaro.org>
 <20251121134503.30914-11-philmd@linaro.org>
In-Reply-To: <20251121134503.30914-11-philmd@linaro.org>
From: Brian Cain <brian.cain@oss.qualcomm.com>
Date: Fri, 21 Nov 2025 20:26:19 -0600
X-Gm-Features: AWmQ_bkMihejYAProvsTzIGnjZ9vWhOn6nlMXNb3wmfnhvaBpXf9afG5w4avVc8
Message-ID: <CAEqNhNbBgzgWh90nPsd6Re98BOTQ5m-FW=Lo6ZxfQdw4Ux0dZQ@mail.gmail.com>
Subject: Re: [RFC-PATCH-for-11.0 v3 10/21] target/hexagon: Use little-endian
 variant of cpu_ld/st_data*()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>
Content-Type: multipart/alternative; boundary="0000000000006f391d064425a80b"
X-Authority-Analysis: v=2.4 cv=Lb0xKzfi c=1 sm=1 tr=0 ts=69211f58 cx=c_pps
 a=0mLRTIufkjop4KoA/9S1MA==:117 a=6UeiqGixMTsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8
 a=dtZyN9du9yrRNHqqgEEA:9 a=QEXdDO2ut3YA:10 a=WtIJMpqA1hRDbSTC5FwA:9
 a=o4K8tfJV8zr8ub1S:21 a=lqcHg5cX4UMA:10 a=WgItmB6HBUc_1uVUp3mg:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: 2uFmLGqHl6T8s4sVA6mx4GLpCJtsGdbS
X-Proofpoint-GUID: 2uFmLGqHl6T8s4sVA6mx4GLpCJtsGdbS
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTIyMDAxOCBTYWx0ZWRfX+urWcApc1E1f
 iRvJ+nSdnqYE/xMNK0c9TveRY1bSPDex75UWurRun3N2GYbDHHQ6dDJ8ZQWQ7lL53qotXrd11Mq
 Y6nlOfft/mdevPrLOXIv3WxcceFLO4MdA7kOt4ir8kjwyK0wRgaXIYfEQlIdTevmDRqxaQzV6IY
 1t+Pa6XgIgdSeXYOWuLra/oCK3/xzowlo3SJ2JxqLfvhyavHn/chj8H2j7wgCWBahf2ZhxgVBHg
 5GL1SCdzEEGbadmAiiZZyFf7+tKIchZPFaznjRahyIEGH7DMRcoyHLxDWSZiWBrxoT/BtNa1xXB
 kJtwZhdi/oF+hkTwlJgdd6T7kD3EU79E+hc3eY1oQ+gaNH1bQ3HQ0oSKT6U2EMFwNaBFGH2rckr
 ho/+UmIAGzTkTufTomnQLaHXEb3YCA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-22_01,2025-11-21_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 impostorscore=0 clxscore=1015 malwarescore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511220018
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, HTML_MESSAGE=0.001, T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=no autolearn_force=no
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

--0000000000006f391d064425a80b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 21, 2025 at 8:13=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> We only build the Hexagon target using little endianness order,
> therefore the cpu_ld/st_data*() definitions expand to the little
> endian declarations. Use the explicit little-endian variants.
>
> Mechanical change running:
>
>   $ tgt=3Dhexagon; \
>     end=3Dle; \
>     for op in data mmuidx_ra; do \
>       for ac in uw sw l q; do \
>         sed -i -e "s/cpu_ld${ac}_${op}/cpu_ld${ac}_${end}_${op}/" \
>                   $(git grep -l cpu_ target/${tgt}/); \
>       done;
>       for ac in w l q; do \
>         sed -i -e "s/cpu_st${ac}_${op}/cpu_st${ac}_${end}_${op}/" \
>                   $(git grep -l cpu_ target/${tgt}/); \
>       done;
>     done
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


>  target/hexagon/macros.h    | 6 +++---
>  target/hexagon/op_helper.c | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
>
> diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h
> index 088e5961ab7..6c2862a2320 100644
> --- a/target/hexagon/macros.h
> +++ b/target/hexagon/macros.h
> @@ -519,9 +519,9 @@ static inline TCGv gen_read_ireg(TCGv result, TCGv
> val, int shift)
>  #define fLOAD(NUM, SIZE, SIGN, EA, DST) MEM_LOAD##SIZE##SIGN(DST, EA)
>  #else
>  #define MEM_LOAD1 cpu_ldub_data_ra
> -#define MEM_LOAD2 cpu_lduw_data_ra
> -#define MEM_LOAD4 cpu_ldl_data_ra
> -#define MEM_LOAD8 cpu_ldq_data_ra
> +#define MEM_LOAD2 cpu_lduw_le_data_ra
> +#define MEM_LOAD4 cpu_ldl_le_data_ra
> +#define MEM_LOAD8 cpu_ldq_le_data_ra
>
>  #define fLOAD(NUM, SIZE, SIGN, EA, DST) \
>      do { \
> diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c
> index e2e80ca7efa..08db1e9c56b 100644
> --- a/target/hexagon/op_helper.c
> +++ b/target/hexagon/op_helper.c
> @@ -77,13 +77,13 @@ static void commit_store(CPUHexagonState *env, int
> slot_num, uintptr_t ra)
>          cpu_stb_data_ra(env, va, env->mem_log_stores[slot_num].data32,
> ra);
>          break;
>      case 2:
> -        cpu_stw_data_ra(env, va, env->mem_log_stores[slot_num].data32,
> ra);
> +        cpu_stw_le_data_ra(env, va, env->mem_log_stores[slot_num].data32=
,
> ra);
>          break;
>      case 4:
> -        cpu_stl_data_ra(env, va, env->mem_log_stores[slot_num].data32,
> ra);
> +        cpu_stl_le_data_ra(env, va, env->mem_log_stores[slot_num].data32=
,
> ra);
>          break;
>      case 8:
> -        cpu_stq_data_ra(env, va, env->mem_log_stores[slot_num].data64,
> ra);
> +        cpu_stq_le_data_ra(env, va, env->mem_log_stores[slot_num].data64=
,
> ra);
>          break;
>      default:
>          g_assert_not_reached();
> --
> 2.51.0
>
>
>

--0000000000006f391d064425a80b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote g=
mail_quote_container"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Nov 21,=
 2025 at 8:13=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:=
philmd@linaro.org">philmd@linaro.org</a>&gt; wrote:<br></div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid=
 rgb(204,204,204);padding-left:1ex">We only build the Hexagon target using =
little endianness order,<br>
therefore the cpu_ld/st_data*() definitions expand to the little<br>
endian declarations. Use the explicit little-endian variants.<br>
<br>
Mechanical change running:<br>
<br>
=C2=A0 $ tgt=3Dhexagon; \<br>
=C2=A0 =C2=A0 end=3Dle; \<br>
=C2=A0 =C2=A0 for op in data mmuidx_ra; do \<br>
=C2=A0 =C2=A0 =C2=A0 for ac in uw sw l q; do \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sed -i -e &quot;s/cpu_ld${ac}_${op}/cpu_ld${ac}=
_${end}_${op}/&quot; \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $(git grep -=
l cpu_ target/${tgt}/); \<br>
=C2=A0 =C2=A0 =C2=A0 done;<br>
=C2=A0 =C2=A0 =C2=A0 for ac in w l q; do \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 sed -i -e &quot;s/cpu_st${ac}_${op}/cpu_st${ac}=
_${end}_${op}/&quot; \<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 $(git grep -=
l cpu_ target/${tgt}/); \<br>
=C2=A0 =C2=A0 =C2=A0 done;<br>
=C2=A0 =C2=A0 done<br>
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
---<br></blockquote><div><br></div><div>Reviewed-by: Brian Cain &lt;<a href=
=3D"mailto:brian.cain@oss.qualcomm.com">brian.cain@oss.qualcomm.com</a>&gt;=
</div><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0p=
x 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padding-left:1ex">
=C2=A0target/hexagon/macros.h=C2=A0 =C2=A0 | 6 +++---<br>
=C2=A0target/hexagon/op_helper.c | 6 +++---<br>
=C2=A02 files changed, 6 insertions(+), 6 deletions(-)<br>
<br>
diff --git a/target/hexagon/macros.h b/target/hexagon/macros.h<br>
index 088e5961ab7..6c2862a2320 100644<br>
--- a/target/hexagon/macros.h<br>
+++ b/target/hexagon/macros.h<br>
@@ -519,9 +519,9 @@ static inline TCGv gen_read_ireg(TCGv result, TCGv val,=
 int shift)<br>
=C2=A0#define fLOAD(NUM, SIZE, SIGN, EA, DST) MEM_LOAD##SIZE##SIGN(DST, EA)=
<br>
=C2=A0#else<br>
=C2=A0#define MEM_LOAD1 cpu_ldub_data_ra<br>
-#define MEM_LOAD2 cpu_lduw_data_ra<br>
-#define MEM_LOAD4 cpu_ldl_data_ra<br>
-#define MEM_LOAD8 cpu_ldq_data_ra<br>
+#define MEM_LOAD2 cpu_lduw_le_data_ra<br>
+#define MEM_LOAD4 cpu_ldl_le_data_ra<br>
+#define MEM_LOAD8 cpu_ldq_le_data_ra<br>
<br>
=C2=A0#define fLOAD(NUM, SIZE, SIGN, EA, DST) \<br>
=C2=A0 =C2=A0 =C2=A0do { \<br>
diff --git a/target/hexagon/op_helper.c b/target/hexagon/op_helper.c<br>
index e2e80ca7efa..08db1e9c56b 100644<br>
--- a/target/hexagon/op_helper.c<br>
+++ b/target/hexagon/op_helper.c<br>
@@ -77,13 +77,13 @@ static void commit_store(CPUHexagonState *env, int slot=
_num, uintptr_t ra)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0cpu_stb_data_ra(env, va, env-&gt;mem_log_=
stores[slot_num].data32, ra);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case 2:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stw_data_ra(env, va, env-&gt;mem_log_store=
s[slot_num].data32, ra);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stw_le_data_ra(env, va, env-&gt;mem_log_st=
ores[slot_num].data32, ra);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case 4:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stl_data_ra(env, va, env-&gt;mem_log_store=
s[slot_num].data32, ra);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stl_le_data_ra(env, va, env-&gt;mem_log_st=
ores[slot_num].data32, ra);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0case 8:<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stq_data_ra(env, va, env-&gt;mem_log_store=
s[slot_num].data64, ra);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 cpu_stq_le_data_ra(env, va, env-&gt;mem_log_st=
ores[slot_num].data64, ra);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0break;<br>
=C2=A0 =C2=A0 =C2=A0default:<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0g_assert_not_reached();<br>
-- <br>
2.51.0<br>
<br>
<br>
</blockquote></div></div>

--0000000000006f391d064425a80b--

