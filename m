Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09FB4FEC107
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Mar 2026 20:16:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w589w-0007am-Mu; Tue, 24 Mar 2026 16:15:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w589r-0007aJ-9j
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 16:15:23 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <matheus.bernardino@oss.qualcomm.com>)
 id 1w589o-000643-5n
 for qemu-devel@nongnu.org; Tue, 24 Mar 2026 16:15:22 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62OJCrUq3110452
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 20:15:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 w7QYS1Wn8X3MXdGaAGwQO0DiWxDG+QxM5Hd/eMEWOiI=; b=H4+N+gv4GKOV1nWT
 /g6hPGJdA+J+cR8+v4yFox0F2Uz34eFyKtRXRUAjMk7gAoIqSPOO+hjde5y24ejq
 lq7AcOmD4P8eMiLlNpsVg4aO3+qcgyrJpHAnNtXqCObNPY2c/Mc4WwsOQmfwJo5B
 jlUIoZgAHE7cxTfx7L9z24FTLf1hJcPCULTNQ3GypKnDfZw0RgYX7CxJs4dYJHLy
 iwsl45BlwymbsDb6GYg4HDFLJ5iCSgWKl4e9wdCt+TzVIqxw8FKMnnSWsLAU/jKs
 r4gkiMaRqU/osV641xqYXdyh1GOOZxpf+IXYBFoKspR/RAs2Y3rTuLOIpANe1Nna
 lWK41Q==
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4d3vhvsbca-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 20:15:15 +0000 (GMT)
Received: by mail-ot1-f70.google.com with SMTP id
 46e09a7af769-7d73fe3f986so50814787a34.2
 for <qemu-devel@nongnu.org>; Tue, 24 Mar 2026 13:15:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774383315; cv=none;
 d=google.com; s=arc-20240605;
 b=IR29SIFkmGm9+lE1ScVjNuPAANsYRaCvMlZEdI7bjCo6IJwJfmrEnspqXOP5yi4mPf
 6u84ipQASFS2wa7e5OGRC+XRW9bDUOywl2VFtciLYilqw8XDAxDvUWKKwQvM1jD76Ask
 rYz0k7+jqIUtttmFQiEKjpKCZEjPfiJo/0EO9ddJtOuBvHKRGAXYjNYOOeriSrXgexev
 +iPpWxk8WllPniTXQlh/V7r7NcKDOxKEHoGd5ZNGderBPXAv/dFlUbtorFaJIqilMUuL
 Nzde2OhRJrC5J6ToP1X9gJYdwKMwNkutrz4TgH21pjpJGK0OjEZY9AD0/bS9EiDWa7YO
 jyVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=w7QYS1Wn8X3MXdGaAGwQO0DiWxDG+QxM5Hd/eMEWOiI=;
 fh=GIsXnfQ1rlTLuqMVRnuWQs1/XCKcI3goSMKmOb1sBfk=;
 b=EXtH6dSaboE/v8EmV/rxu6HyxSodRYnmG67eqOL2Fa/XgB/YaXNLQhulWTolhwJa9r
 GDBcKObzMGqX8F1lVoUOgYn6Wxm3Yc7iabD9jzIm10iIyhcYr6rULzvSu2yGxJU2+OTN
 FKc0nUySdpimgailtxCSizeW68yzgs02jA+M9y5QnAE6hvlDSiMr4GcTznb1mxp+Zg0b
 EFlxNWVFoStaxWGHNaED56bZLhIipYbjEpkOchIzM6MhUhf9CX1iZdekF44EuxWpBcCQ
 HUmniF7kWAxkfLm1tZq7HHXGPjHMUwp+7foF+zCMYXy1B1SPoypGm0atH8P8VyR/nk4e
 bZug==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1774383315; x=1774988115; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=w7QYS1Wn8X3MXdGaAGwQO0DiWxDG+QxM5Hd/eMEWOiI=;
 b=NoYsmPLtpRDKbMgi4b22u7EnvzqtL7qv30mZTdMdY/9T/TJgIdxH5R7mTl1gjxt6LE
 GRSjxJl9AVPh56F9uTegFG+kaX36N6YjLUGCWLQn/Q0djVE2PaSnXxUyzh6TCsVYhfLR
 tATQV/Fj6rV5+YTiPSSC/oEK9bR32e5Vm3lM5Ny9+iWMaqwnW7cLyahqVIK1JsXmtgf6
 GhjgLamfrxEcbWPiYbN+OzgBVi4/8uv5AsagodJ0R2jcNjWqGJLAaUqbSGtJeROyFMYa
 VFerKb9YR0gmgJheILXXU5nlTHKQA4cZm83yfcBqKDpp2vJaRperzb5UQPzMsYJlwKsu
 Jc/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774383315; x=1774988115;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=w7QYS1Wn8X3MXdGaAGwQO0DiWxDG+QxM5Hd/eMEWOiI=;
 b=EsJS/MhthsJV5OFlqpzy1U94HZqb5rqNrKTUJPnwuGzjkZv6Xx4XUCYVigH57baSNC
 japcb018v+I20mzZRDxihaBcDNUz2R5mEhH9SdDEmqfO19INvFWO2fqVAEbNh4fXYQjS
 nH3aBVvajxr25gof6Qq8YDVuqPJVnwD0SHpifpF8yxKA+Ia1rg6wX00YM+oXjrTmNxl2
 KAo1Tm/UKcOTzzCnQAI01Xq27VTpIA3l1Aqyqr+RfrkU9eWEm88a7hk8Ut7eI55RBjZg
 RRliBZHQ8Vy5WcUM9+UdfQN+yn2jLX83TaPcRAbQDyCpuq+kIcvOihTBo6wdoEjY3ixO
 gFmA==
X-Gm-Message-State: AOJu0YyQlysjpt/NGySDA7KdhXz2HfNiYoO7kcMQI0KcQEMmIMbcGM4F
 QJX0bzb6S4j7HeCwrWlNZmUI3rE12oWvx587DP/NiNubHOh1Vs6Yj8MGDhr0iePKDpysoAxEdI7
 TzaLu4r9QtPo4TttHBnMmclcKEBs8s5W1NhLVnvqo8q24KeKXup9b2Aj7e3lchX8NkPQnWpniun
 tveIrF+KxxP57lPvSr7EudaeCKZNFBBiY3
X-Gm-Gg: ATEYQzwQXo5XRCwV3OMY/v6z1jJiEgNBnYurLcA2323uBTYCPQP88/0E6Chd8p8+GkT
 95telu6wgrI0MZSSrDXQQ3WjyphaWL884xDmjlnj2A4k1N3ckW14hNRlMHgjYivQdbQtvfVPz4t
 +JJZxy6xQ8PT04/wqEWjizZOAC9jdfIkay33Z/E3PxMHN4CMX1q3D1sz/+f8oHfNj2V51IpP2VC
 2D9UWI=
X-Received: by 2002:a05:6830:3509:b0:7d7:ecda:cc3f with SMTP id
 46e09a7af769-7d9d62bad58mr564085a34.0.1774383314907; 
 Tue, 24 Mar 2026 13:15:14 -0700 (PDT)
X-Received: by 2002:a05:6830:3509:b0:7d7:ecda:cc3f with SMTP id
 46e09a7af769-7d9d62bad58mr564071a34.0.1774383314491; Tue, 24 Mar 2026
 13:15:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <4895991dcd597b052869e2275d5f0056dfc2368b.1774271525.git.matheus.bernardino@oss.qualcomm.com>
 <CAATN3No1pf9Xty8NOCmO2_YJg0TKjJ3NoUcPBvG9fHTf8Dr7kw@mail.gmail.com>
In-Reply-To: <CAATN3No1pf9Xty8NOCmO2_YJg0TKjJ3NoUcPBvG9fHTf8Dr7kw@mail.gmail.com>
From: Matheus Bernardino <matheus.bernardino@oss.qualcomm.com>
Date: Tue, 24 Mar 2026 17:15:03 -0300
X-Gm-Features: AQROBzDKT7Lax2OIsXQ-Cg60yO9myTlmbQjjAT5thY0wkOpGJ1DazchdsTDEa6Q
Message-ID: <CABrGZ+Fw4BJmcH0nJfyxguueab86-+ARht4hSUgy+ar2MbXR5w@mail.gmail.com>
Subject: Re: [PATCH 05/13] target/hexagon: add v68 HVX IEEE float min/max insns
To: Taylor Simpson <ltaylorsimpson@gmail.com>
Cc: qemu-devel@nongnu.org, brian.cain@oss.qualcomm.com, ale@rev.ng,
 anjo@rev.ng, marco.liebel@oss.qualcomm.com, philmd@linaro.org,
 quic_mburton@quicinc.com, sid.manning@oss.qualcomm.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzI0MDE1NiBTYWx0ZWRfX0QvWHxFFzL/h
 T5+bZJopTdh4dbXwskCnKJTzX6uwyWRJe1F8XSB4eijbqZvTkOnFxQHuJRRuU2st/rR8IAmvbqL
 HfwA6xd42r/ov4yXfvo4TKQh4iI5kjdoeL2olPYaA+/OTgWLbh4f5PHoYib5Kf2KmcNe+Peoev7
 PJ6ZROfKmDJAMi9J8IRXMeN5SMvTzFbyjJw7uUc6a53AIl4vBEh9eV/JPhRd4atrjcciiL+VyE9
 87c9/5TG9YvzwnP/es+FhOMeWd7N9OuUDLNT4O3+itkQI4NcCCEppE0h9SFkUIJnIHvdEPYWzlx
 h/jmTNoV13UaD7eLk6x7rrx5tGGEfLM1V/Q7C1pvo+77vddQa5qsawAwnnBVr/0uLvxPVgswIfv
 I2drlsx+esqoSkrsqak1UFq8QCUaSPKrlVOtuRK0mvStICOOfABj7Hrtr02BFV9Q3OvkyJCJCsX
 AhP26UY48wgQYf7/wJw==
X-Authority-Analysis: v=2.4 cv=P5M3RyAu c=1 sm=1 tr=0 ts=69c2f0d3 cx=c_pps
 a=7uPEO8VhqeOX8vTJ3z8K6Q==:117 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22
 a=DJpcGTmdVt4CTyJn9g5Z:22 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=rE2gOtIGC4MEnwy5G3MA:9 a=QEXdDO2ut3YA:10 a=EXS-LbY8YePsIyqnH6vw:22
X-Proofpoint-ORIG-GUID: lAh3gm5RjtM4xyAgaiEIg4iuvcJ4B_wW
X-Proofpoint-GUID: lAh3gm5RjtM4xyAgaiEIg4iuvcJ4B_wW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-24_03,2026-03-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 phishscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 bulkscore=0 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603240156
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=matheus.bernardino@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Mon, Mar 23, 2026 at 5:48=E2=80=AFPM Taylor Simpson <ltaylorsimpson@gmai=
l.com> wrote:
>
>
>
> On Mon, Mar 23, 2026 at 7:15=E2=80=AFAM Matheus Tavares Bernardino <mathe=
us.bernardino@oss.qualcomm.com> wrote:
>>
>> Add HVX IEEE floating-point min/max instructions:
>> - vfmin_hf, vfmin_sf: IEEE floating-point minimum
>> - vfmax_hf, vfmax_sf: IEEE floating-point maximum
>> - vmax_hf, vmax_sf: qfloat IEEE maximum
>> - vmin_hf, vmin_sf: qfloat IEEE minimum
>>
>> The Hexagon qfloat variants are similar to the IEEE-754 ones, but they
>> handle NaN slightly differently. See comment on kvx_ieee.h
>>
>> Signed-off-by: Matheus Tavares Bernardino <matheus.bernardino@oss.qualco=
mm.com>
>> ---
>>  target/hexagon/mmvec/kvx_ieee.h              | 12 +++++
>>  target/hexagon/mmvec/kvx_ieee.c              | 46 ++++++++++++++++++++
>>  target/hexagon/imported/mmvec/encode_ext.def | 11 +++++
>>  target/hexagon/imported/mmvec/ext.idef       | 28 +++++++++++-
>>  4 files changed, 96 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/hexagon/mmvec/kvx_ieee.h b/target/hexagon/mmvec/kvx_=
ieee.h
>> index e92ddebeb9..78f546eb8e 100644
>> --- a/target/hexagon/mmvec/kvx_ieee.h
>> +++ b/target/hexagon/mmvec/kvx_ieee.h
>> @@ -44,4 +44,16 @@ uint32_t fp_vdmpy(uint16_t a1, uint16_t a2, uint16_t =
a3, uint16_t a4,
>>  uint32_t fp_vdmpy_acc(uint32_t acc, uint16_t a1, uint16_t a2, uint16_t =
a3,
>>                        uint16_t a4, float_status *fp_status);
>>
>> +/* IEEE - FP min/max instructions */
>> +uint32_t fp_min_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
>> +uint32_t fp_max_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
>> +uint16_t fp_min_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
>> +uint16_t fp_max_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
>> +
>> +/* Qfloat min/max treat +NaN as greater than +INF and -NaN as smaller t=
han -INF */
>> +uint32_t qf_max_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
>> +uint32_t qf_min_sf(uint32_t a1, uint32_t a2, float_status *fp_status);
>> +uint16_t qf_max_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
>> +uint16_t qf_min_hf(uint16_t a1, uint16_t a2, float_status *fp_status);
>
>
> Why are we including Qfloat stuff in a patch series for IEEE float?

Well, good point. We can separate those. I've only included them here
because their semantics are very similar to the respective IEEE
variants, and they are more common in Hexagon code as the IEEE
variants need the extension, which is not available in all cores.

>>
>> +
>>  #endif
>> diff --git a/target/hexagon/imported/mmvec/encode_ext.def b/target/hexag=
on/imported/mmvec/encode_ext.def
>> index 4ce87d09fd..23fbb75743 100644
>> --- a/target/hexagon/imported/mmvec/encode_ext.def
>> +++ b/target/hexagon/imported/mmvec/encode_ext.def
>> @@ -823,4 +823,15 @@ DEF_ENC(V6_vsub_sf_hf,"00011111100vvvvvPP1uuuuu101d=
dddd")
>>  DEF_ENC(V6_vadd_hf_hf,"00011111101vvvvvPP1uuuuu111ddddd")
>>  DEF_ENC(V6_vsub_hf_hf,"00011111011vvvvvPP1uuuuu000ddddd")
>>
>> +/* IEEE FP min/max instructions */
>> +DEF_ENC(V6_vfmin_hf,"00011100011vvvvvPP1uuuuu000ddddd")
>> +DEF_ENC(V6_vfmin_sf,"00011100011vvvvvPP1uuuuu001ddddd")
>> +DEF_ENC(V6_vfmax_hf,"00011100011vvvvvPP1uuuuu010ddddd")
>> +DEF_ENC(V6_vfmax_sf,"00011100011vvvvvPP1uuuuu011ddddd")
>> +DEF_ENC(V6_vmax_sf,"00011111110vvvvvPP1uuuuu001ddddd")
>> +DEF_ENC(V6_vmin_sf,"00011111110vvvvvPP1uuuuu010ddddd")
>> +DEF_ENC(V6_vmax_hf,"00011111110vvvvvPP1uuuuu011ddddd")
>> +DEF_ENC(V6_vmin_hf,"00011111110vvvvvPP1uuuuu100ddddd")
>> +DEF_ENC(V6_vcvt_ub_hf,"00011111110vvvvvPP1uuuuu101ddddd")
>
>
> Minor nit - this is a conversion instruction and is repeated in patch 7. =
 Remove it from this patch.

Will do, thanks.

