Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1C74CDE001
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 12:59:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcjfP-0007Qn-5Y; Thu, 25 Jun 2026 08:58:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcjfJ-0007QO-OH
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 08:58:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wcjfH-0002eJ-5h
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 08:58:44 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65P9jt5a3077514
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 12:58:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ikbKE+vlbbxpnCSIcd2Fa2ckqoLTv6S/5Hio0SFcqeo=; b=T//u/comf6dw3Gn1
 dzOwP+nSKrSq5onDFAiRFxZAdT+aY+Q7rR4ief8bCPlu2jpijUak3+eAeVn6m4t4
 lEb0TXS8YpAVYeID6ltosNhGuAHNLshmEbsPy8zyt0BhV/8AD5sgvfipnLpveyjR
 4Ov/7gwPq8KSnJKDH2GSK7oYnPGbbYTY+Q/dfkK/An2KuPUJcMkUQPWDEUwNq/1c
 yZDjOl7xnQ5vpo0UTxJXpWLP+Xkhd9j/fxKCxOYYsMznX4sqdeK4Om4yThJ+9bZv
 KQjdd/haeFEh/KfViVwsnAcM0IesDmuTY1shCqKgrumkJiaSpxjHwvHpMYEQion+
 mG8Czw==
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f0yyns761-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 12:58:39 +0000 (GMT)
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-44801afec53so1296386fac.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 05:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782392319; x=1782997119; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ikbKE+vlbbxpnCSIcd2Fa2ckqoLTv6S/5Hio0SFcqeo=;
 b=EOYwDJyDgU0FytBnLEadAi0QT6jk+ZoQt25eSK0ZRUlT3arE6ekw1CsyfEVT4m5+eB
 zdGfJbcTsI2oEHv3B9/brujVaQtAvTaLKoJ+YP0vDTnq1kvj4EteNCHZHOxMICUzaAm7
 xPO5FVaBOx9/Uvjc0LNyMO/g7TxJnzS9Exk0vzcwikKXnZfIaG1GKRUbd0/xB/+fIWX0
 65ZM6vL3q81UCWF77v622WGXBWqt+uvQroIL/Ab1DWNeN5r76Zf2t+uHmR1Y6QxAhBRP
 Bgo6f0AoZFluYit8anYhiJibQkd8mVOQkEoAFhbNbwAZ35qErZZE9mf7oQsuAuBkTrQ9
 zAow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782392319; x=1782997119;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ikbKE+vlbbxpnCSIcd2Fa2ckqoLTv6S/5Hio0SFcqeo=;
 b=Qg++1+F+JDbyXDn2Uo/DiHFPCxmXsYy0Cvi0SoDdeZ4Gjh+SIgLS3ckhEV0W/HGm2t
 CNGN3RAw6XFaw3WsOnNX1khXvQlZeNSArRPi8pndsLptDAJLYXgC5zR/fyAa+11ej354
 XEth5cx8+JrR1Vx8XFt8LsD3wIQ3Ua7/Zi8/pwOZDJhoZJRi6gCtmBb+/LUR1wep5vi3
 k4KNUNATz2aZjf1fiWePWla/JDI4FevaJf3Z+QTePCdVz79gkkZqNEMizBKIuF1rigMR
 OY9X0/lejy6tMyCFc1gERmIn6HQt6/76Y+edqmaAfE7g2nfcZTD55iTqALYgc1JkjXgT
 zTqQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ+ygEJWzYoezvlKBKU2T9H8JNxyr1mVBW2040MrAzdXtFJ7Z9hjIrCw/CpiR2NpvkilyWEG4I24z3D7@nongnu.org
X-Gm-Message-State: AOJu0Yy8idh47Z0xcU5xNlfMvZgF3LRDQ2JlPlLLbQC6ulXWOiuUzqNj
 Lz5e71nzxYpqcnO0gPMREvZTbTisOrcHV9ek8nU/r33tSX3/G78qNO2yw/u8JrXCTy9aqH3z8QG
 5pVgauWEUmD0PTZg3ZPv/768Kq58rc/7z81P3gHDzOmfKGNkV7bbUclrgiw==
X-Gm-Gg: AfdE7cndaj+1lts5sFwvNuqfxR3DPOF2zsE6s9Bfh2EgQjV3/Im0Z/Z5j334eVDH7kL
 vn3BpmBLoknlr7ZiunZLdBYUTE04F6/NPmSOASD77H0pblnudRce1U5GOBlo9+qY0Ea+hgALeNX
 otfPXF2aFHSE1zRbuqXUBe3tbFebhI5FwvydKJuPiL2I6C55Vpzdmeh97c/aPqRWu/OY6c/zTtm
 8oRiukcDl/ga+W8vkEPgfH61BKnv6mFKcppR7SVybzJB9R++AxTkBEpMESt8MlzXLHscVTQxlaU
 SYbNrUtG7NxIVxblbYDZaeljKu8CkWYFlWDAbGQVlUlMAKIgZ2nq8cBIPP+7EwlI13Mx/LanYad
 3bBOIKtyqha07bsuWtewDZHO2MJGTro3FCkCkyfLo+1Et7Mh/0H/SLW+hjRsIVTsjopjggS0KH8
 zDY/w=
X-Received: by 2002:a05:6870:d415:b0:423:9219:4c6 with SMTP id
 586e51a60fabf-448119ab40bmr2042209fac.13.1782392318941; 
 Thu, 25 Jun 2026 05:58:38 -0700 (PDT)
X-Received: by 2002:a05:6870:d415:b0:423:9219:4c6 with SMTP id
 586e51a60fabf-448119ab40bmr2042189fac.13.1782392318543; 
 Thu, 25 Jun 2026 05:58:38 -0700 (PDT)
Received: from ?IPV6:2804:7f0:bcc2:6962:5520:30ca:9e66:df39?
 ([2804:7f0:bcc2:6962:5520:30ca:9e66:df39])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-4472eccfa68sm11665147fac.5.2026.06.25.05.58.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2026 05:58:38 -0700 (PDT)
Message-ID: <644195e9-ad3e-4f68-af43-0fb98668ac59@oss.qualcomm.com>
Date: Thu, 25 Jun 2026 09:58:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/riscv: Apply UXL WARL handling to vsstatus
To: SeungJu Cheon <suunj1331@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com
References: <20260625081521.595683-1-suunj1331@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260625081521.595683-1-suunj1331@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI1MDExMSBTYWx0ZWRfXwEJByeQxE+hS
 men9QA65PJBx+u8A/pwJS5I2zBEmDQgjVurRZhooyH5LjotJk995hstY6JSBBdplQ53JMTdZr0D
 CTOCUJoG+x6IHVqvKyg7723Cqter424vmm1dgEg7T7ep6h1pBI5A2MoruftuXRtRlePxUju320Z
 ZxPr/Rzt3uUpwzzdxWqqlyWGoN0oRLU4fiaXVuaA6OrKNM95VYYYZxVoHMK/D7pixF39/MkHQ0k
 Vxs8iQ+CHP8DobGsEXFR4C85VZURkv4bLkXKQIgf/CNnxD+voPEKrfASnx9lauzV04Rf6hhiBll
 fzWwHaddG0EWrHEeXBR/S7f9khNeKYBSj13gcThtDv339ETGjR7w+24RxpCQNuM3dLZuBlj4Jt2
 MZBF+d16BuACdnqpjDykZuta6dihEZtoTvnWWAZbMVlU2swjZ1s+EDI6FhgxOq/LBq7qBMtv4WI
 OxIA9Z9kWBObUNAaNoA==
X-Authority-Analysis: v=2.4 cv=aoyCzyZV c=1 sm=1 tr=0 ts=6a3d25ff cx=c_pps
 a=nSjmGuzVYOmhOUYzIAhsAg==:117 a=xqWC_Br6kY4A:10 a=IkcTkHD0fZMA:10
 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22 a=EUspDBNiAAAA:8
 a=pGLkceISAAAA:8 a=Eyf7DqpKdIDjvx2et8kA:9 a=QEXdDO2ut3YA:10
 a=1zu1i0D7hVQfj8NKfPKu:22
X-Proofpoint-ORIG-GUID: IgRFemq30eYICubO-HMg2okiWKAQ9l9h
X-Proofpoint-GUID: IgRFemq30eYICubO-HMg2okiWKAQ9l9h
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI1MDExMSBTYWx0ZWRfXzsiasDM9Y45G
 Mu4jIWR+03gyClOd6r/EcmCzN9yFaSZnFYjXuvvRRLoERyw+FzgKNtUNYzxdWfd+esvrPiWjliX
 1rhXQYvvu/LTgQ2FaRY32ASJxn5fYWM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-25_01,2026-06-24_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 priorityscore=1501
 clxscore=1015 adultscore=0 malwarescore=0 phishscore=0 bulkscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606250111
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 6/25/2026 5:15 AM, SeungJu Cheon wrote:
> write_mstatus() already handles the reserved UXL value by writing a
> legal value instead.
> 
> Apply the same handling when writing vsstatus so that reserved UXL
> values follow the same WARL behavior.
> 
> Factor the common logic into a local helper riscv_write_uxl() and use
> it for both mstatus and vsstatus.
> 
> Suggested-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
> Fixes: f310df58bd2 ("target/riscv: Enable uxl field write")
> Signed-off-by: SeungJu Cheon <suunj1331@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/csr.c | 27 +++++++++++++++++----------
>   1 file changed, 17 insertions(+), 10 deletions(-)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index dd9726fcf4..12f1ce5180 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -2012,6 +2012,20 @@ static target_ulong legalize_mpp(CPURISCVState *env, target_ulong old_mpp,
>       return val;
>   }
>   
> +static uint64_t riscv_write_uxl(CPURISCVState *env, uint64_t val,
> +                                uint64_t field)
> +{
> +    RISCVMXL xl = riscv_cpu_mxl(env);
> +    uint64_t uxl = get_field(val, field);
> +
> +    if (uxl == MXL_RV128) {
> +        uxl = xl == MXL_RV128 ? MXL_RV64 : xl;
> +        val = set_field(val, field, uxl);
> +    }
> +
> +    return val;
> +}
> +
>   static RISCVException write_mstatus(CPURISCVState *env, int csrno,
>                                       target_ulong val, uintptr_t ra)
>   {
> @@ -2058,17 +2072,8 @@ static RISCVException write_mstatus(CPURISCVState *env, int csrno,
>   
>       if (xl != MXL_RV32 || env->debugger) {
>           if ((val & MSTATUS64_UXL) != 0) {
> -            uint64_t uxl = val & MSTATUS64_UXL >> 32;
>               mask |= MSTATUS64_UXL;
> -
> -            /*
> -             * uxl = 3 is reserved so write the current xl instead.
> -             * In case xl = MXL_RV128 (3) write MXL_RV64.
> -             */
> -            if (uxl == 3) {
> -                uxl = xl == MXL_RV128 ? MXL_RV64 : xl;
> -                val = deposit64(val, 32, 2, uxl);
> -            }
> +            val = riscv_write_uxl(env, val, MSTATUS64_UXL);
>           }
>       }
>   
> @@ -5226,6 +5231,8 @@ static RISCVException write_vsstatus(CPURISCVState *env, int csrno,
>       uint64_t mask = (target_ulong)-1;
>       if ((val & VSSTATUS64_UXL) == 0) {
>           mask &= ~VSSTATUS64_UXL;
> +    } else {
> +        val = riscv_write_uxl(env, val, VSSTATUS64_UXL);
>       }
>       if ((env->henvcfg & HENVCFG_DTE)) {
>           if ((val & SSTATUS_SDT) != 0) {


