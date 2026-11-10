Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1849F606A326
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 00:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=B+dyziUf;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=j4t5ID9y
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQZqb-0003vl-MV; Mon, 09 Nov 2026 19:36:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQZqZ-0003vU-NP
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 19:36:24 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xQZqX-000888-MS
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 19:36:23 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9LAP131401219
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 00:36:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 olxU+IGTYOzhZGpsSiNJJcjJUVPZEqfccZq8p8kpjA0=; b=B+dyziUf/mKkAZAg
 p8wO9rpp0dwEC81eSPiABfmc28fjDxFzfQAb+md9seAh00R9FmNS5Ij8KanddeuP
 aVEHnaD07lZ6jA+FK2REbuz4WqaNaVB/nBFhZJ0fE1sHOkQ9voaZlzZ3CgvOy6eG
 XZwdjwmVFwppIlmf2s3VEz2C8hxV2l+4/9myG5ZBFeGljNNCyL5Hux7Jc/fOrJ+C
 xOuxgWoyAPluRBzhVRASYBP6QTNl7HJoPEFCkEWxh6BJ43Gd8tPUebhPZcUQqnAc
 /1LVtlZbgfOUO7mAHNVr59/waDdO3YnzBYe2cHb0cwAgAh0wH0VaBYTd3qJiACDo
 V6Tu6Q==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hu6x2m5ts-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 00:36:19 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93f33438950so304924885a.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 16:36:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794270979; x=1794875779; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=olxU+IGTYOzhZGpsSiNJJcjJUVPZEqfccZq8p8kpjA0=;
 b=j4t5ID9yiEAmSYEiRVweO+LWhYjtNTwBk26VeRfYy63f5fXexMXzk7An+4UN/1WR7I
 QZNkSHAnHImb8CXygt78muqdQQRiyn1W3sZKT3TtbQ8reSR9bNm98kgrz/y3nRZX9HWx
 sDiMlJJYZcDbCnVnRsoRIlgUZ9sjMwrN52Bvr2zmhT8Vej7XF7o/fy5wb540+2npaMkN
 fADzeYblEI0qSgrLePpAX2yiXz3zU22OfvsD13QE/vbXN+W/GtkWjolL/PAXxLQXcP8G
 7N+MHfyJ3YNyFLk8/phn6feg9jN5ZtjDbsTpIrmZTC/60I1/ZwycnSdW6Ho196+/R2D8
 kJWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794270979; x=1794875779;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=olxU+IGTYOzhZGpsSiNJJcjJUVPZEqfccZq8p8kpjA0=;
 b=023m9nfe4aEqcSG5hD5SYM6zLMzHU6I0GzrkADv0lbNjcgQbWYL9NFYov1sqwCHmQH
 bPXIx8vGeQbqeiZdTHF16ExE+LQ9ohi2rOS+DxHVCDfLlFnCmfRDHL7aL88pAIM69X3O
 vseCbOGCuB5cedbZSEsjAcpA/u0UcGhV/VkBmwXju58gJKNsrgzmJkAyNO9W7xuRsmui
 bkZOGrGVBTSrv6ZakuhPGPPr7Yugitzpb8b7TjrlOO6uuAqrhvrrYkw/tJiCHKgU99vi
 Q0tLuof3BSmzYCYVtZL9khZhewrlZTsdqZ3E0cVns+5Q1Qb8KVaQXnKKm1OziG51CwEY
 TddQ==
X-Forwarded-Encrypted: i=1;
 AL+hErGQ7fl6OibGTaFH4hsy1mqRZ2oKD61GpZ9c6qRG0Kp9/Qs5ms8bLswVM9ObzBZjRWjdG0TztchC/xMR@nongnu.org
X-Gm-Message-State: APuU4Z9LeUt9wboQAWZt25Jbl6jtboTiTd0J54QtKVxYY4V0xA/P1p2y
 OUbCvPn4pY57EdsuQB1EI/q46SKV9osxrCVqzCu8i6pgCNlYvA7eurVFzcQYWD7PhGJLZaISlmZ
 JrnfpC1g4r5wMivEGLL5bOl13uMrfSZnM706xLISJdt2S0UIsxf6ckivLoQ==
X-Gm-Gg: AYBFou1uJgZ8n9NhvQfFZSneouEwyr17jM3nV1iISve27yz0G7fRpQZrs0hDttn+6hB
 aEpG7r7W/rrbMIL6/fxSdWt4skNTotbAEcI3ieArf72zZKo6843u9zN9sOkezIs7XyCsnlR59Bc
 xEeufIEQ+qlpiWKXBCbxWrDjpKvGZ6bsM00G6IgVA10OBiiB+dlKjjmk/9uz02A388+Cw4uwC06
 VMg/mxqBdMDMPb9Yxjaxc0TyerNlnwssBraeD9A9whS5errkqpxCVBTEo8K5iT25YwvKu33tzgV
 lOySG8cBE2WuaAlO22eslj+F/CJbR1fET92yqr52g3RNLVz/NDJmt/ZmJ+B4wzw0WL3VtrkfV6S
 /6vOkQ74HNwzH5HjvXDLVrRJekCQbQtpSyRFolILQTcYXZoaOtxiWU/tvcm1ANL6AQ9XtvF0dKE
 YlUarNVIuVHbLZrL7Zp621KGICd/TaSzhhiW8/lQMk3KOredBDbrw=
X-Received: by 2002:a05:620a:27c4:b0:93f:2b65:f47 with SMTP id
 af79cd13be357-9479f290ba3mr203007585a.25.1794270978617; 
 Mon, 09 Nov 2026 16:36:18 -0800 (PST)
X-Received: by 2002:a05:620a:27c4:b0:93f:2b65:f47 with SMTP id
 af79cd13be357-9479f290ba3mr203002685a.25.1794270977879; 
 Mon, 09 Nov 2026 16:36:17 -0800 (PST)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9479e7d6964sm98144085a.34.2026.11.09.16.36.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 16:36:17 -0800 (PST)
Message-ID: <fc02969e-d931-4e70-8795-d00de840429a@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 18:36:16 -0600
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] target/hexagon: preserve guest event fault and CFI
 state
To: Marco Liebel <marco.liebel@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 philmd@oss.qualcomm.com
References: <20261109232142.4081792-1-marco.liebel@oss.qualcomm.com>
 <20261109232142.4081792-2-marco.liebel@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261109232142.4081792-2-marco.liebel@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TMjQ2Fla c=1 sm=1 tr=0 ts=6af26703 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=NLz3GSk0QO-j8AMhZOgA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTEwMDAwMSBTYWx0ZWRfX+Lqk3TZQhllO
 G9cTXN9wLlVJ21DA5Pr6+D6/6IFUPdAIwSR8IHFjtbp3HKiIK2KllerQqFV1ydNuE1TBb2Ty8gC
 FNIh/FYQtZbcfTcye4RkkLIMdB3Rb8PAQn7K3UtFpo4a26VDb/N3eFh1SaW48biXHfbcq1sLjY5
 YBGhC/1ZJWnfsq2rv04Wf9sg0u+nkwyYy2ME6t2KwZBugKwl9M6JPvAS209lvfxz4gSqW2CY4Fs
 3oA7SyTpyAqsXZz546NNeK1vGvBcEEojMHmv8g1crKtnO7lzIWO6VaVohTVpSJWiO6xxci8ejXg
 9Vs7AmZzxRD+PDc/cPIHqAEZDwfrENdI4WsLQtORcgMADBiWO3RRPbeopSxRhtiWqiiLhIE0FeD
 c+oo1wIHKRjyo2ycBplTEOWbX+XdG8Q6gn1lXmfYomR0+CJLVIJlEdjICywvkYM56QwbW04ubxW
 H21pHVNrxUG3N1KOKrQ==
X-Proofpoint-GUID: Nb3IHUwVEzt_VkQPsZb9Zy_nnZBnDHFp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTEwMDAwMSBTYWx0ZWRfX44z4FvGYOmnS
 Grzkl4NyU0YtCZa268BDAWR02C2dV06aFF13m46fk8TEslgxCzSPom/jHyJco9Vy3NMQCzw7azg
 NClutQZ9rVzGN//gxJd9FR8ZtVnCqCA=
X-Proofpoint-ORIG-GUID: Nb3IHUwVEzt_VkQPsZb9Zy_nnZBnDHFp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_07,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611100001
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 11/9/2026 5:21 PM, Marco Liebel wrote:
> Guest event entry must select BADVA0 or BADVA1 through SSR.BVS
> instead of copying the stale BADVA array slot. It must also save
> SSR.CFI into GSR.CFI so guest return can restore the interrupted
> CFI state.
>
> Signed-off-by: Marco Liebel <marco.liebel@oss.qualcomm.com>
> ---
>   target/hexagon/hexswi.c | 6 +++++-
>   1 file changed, 5 insertions(+), 1 deletion(-)

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>


> diff --git a/target/hexagon/hexswi.c b/target/hexagon/hexswi.c
> index 663d9fe49ea..f22d4a77516 100644
> --- a/target/hexagon/hexswi.c
> +++ b/target/hexagon/hexswi.c
> @@ -809,6 +809,9 @@ static void guest_event_entry(CPUHexagonState *env, uint32_t cause,
>       gsr = deposit32(gsr, reg_field_info[GSR_IE].offset,
>                       reg_field_info[GSR_IE].width,
>                       GET_FIELD(CCR_GIE, env->t_sreg[HEX_SREG_CCR]));
> +    gsr = deposit32(gsr, reg_field_info[GSR_CFI].offset,
> +                    reg_field_info[GSR_CFI].width,
> +                    GET_FIELD(SSR_CFI, old_ssr));
>       env->greg[HEX_GREG_GSR] = gsr;
>       SET_SYSTEM_FIELD(env, HEX_SREG_SSR, SSR_SS, 0);
>       SET_SYSTEM_FIELD(env, HEX_SREG_SSR, SSR_GM, 1);
> @@ -816,7 +819,8 @@ static void guest_event_entry(CPUHexagonState *env, uint32_t cause,
>       SET_SYSTEM_FIELD(env, HEX_SREG_CCR, CCR_GIE, 0);
>       env->greg[HEX_GREG_GELR] = event_pc;
>       if (set_gbadva) {
> -        env->greg[HEX_GREG_GBADVA] = env->t_sreg[HEX_SREG_BADVA];
> +        env->greg[HEX_GREG_GBADVA] = env->t_sreg[
> +            GET_FIELD(SSR_BVS, old_ssr) ? HEX_SREG_BADVA1 : HEX_SREG_BADVA0];
>       }
>       env->gpr[HEX_REG_PC] = gevb + vec_offset;
>   }

