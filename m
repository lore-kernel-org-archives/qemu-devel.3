Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B09C4606A331
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=dlAwOeqQ;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=huO5AJfe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQVbG-00082u-VF; Mon, 09 Nov 2026 15:04:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQVbF-000817-6j
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:04:17 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQVbD-0004cx-I9
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:04:16 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9HHGJn899570
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 20:04:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1zo3Gvzvz9Rey7froWrdXvDVwGBJloHLQ3iYmQTeerk=; b=dlAwOeqQPdc015nG
 +FcQXk4Xu80t4Pe4ZTfOzq68dI9pnV8i58/TmFDdVDUVMG+kSYu0/DIDzC8xb+df
 gRBhhmI5aYrdBnJwnrf5ONWcH+TqWS0DleawQZD/nbp+Nbqj+3X5hfUHTALPn8sf
 0uIpTwGQbvmDC5ke9seHJ6KKvf9jbBULEa90MZOi6X5lAeRYPmgbOsKkDUAE5B9j
 JWYZe7sMQU9abU8ixr3Avispdon2iegeF19gWGbvwBXaWeS7kr1XcKc4sYTfk34t
 yDIOXPKoy3M1mLScSONjU9IMjATXxhqKUICzILtQ7IJ6WBZPJEGke0h5K7crJ7FN
 vAFnoQ==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hu6x2kbyx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 20:04:14 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-53395d51187so21684191cf.1
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 12:04:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794254654; x=1794859454; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1zo3Gvzvz9Rey7froWrdXvDVwGBJloHLQ3iYmQTeerk=;
 b=huO5AJfe3+XTdKlEqARagTmwuZQvc2JZkjwXkpHflFRY10kNjy/HEPL53r4/Eqzs4b
 zsCkcqwdQ8fc5qLA4JANjsqh+QaM75D2Ac6N6Md3KazSLiBBfLpJUHhFxWYfd8+4kZD0
 C4EIa7yZR7rB1GImqwRqf41vv2IzRZrrhNt2PwN2M0jkMzUjdNu1eQbbASL2UL1vZZTd
 gxFkoeITKs5Fzmc2kxgEzClw+W3ptDmc5oA+Luyt54mLEd+F/rjY/r57Yhk4KKOjfg6k
 8nLag8XJF/bJ6Rj+P0xiPNQE/4C6BdiJE14Om4+aJZ3k/7yHJLysRFreA4y9z3mU+//f
 Wx+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794254654; x=1794859454;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1zo3Gvzvz9Rey7froWrdXvDVwGBJloHLQ3iYmQTeerk=;
 b=y1eiy6vF+AXeH3E7FH3BfK0mcsDu25W9yFzr6AAGuEKM1+9mYb403iEFTDzfBJqFFm
 e3B5rzJNEUghaP1mRx7KIN/ysIzqzVmOmbaeUJYppsvniRiIIFeT2mGuV+MSpVUH/XSa
 wxCTLipMPS/WYD+0X2prjUwJMKKD2p7RfhvBFecCXlUn9SUL1XB6W1bcQ58vMEn7Bwdv
 FN8lhcbNR3wDiVZk5Vl9MeEhl0fxabQBzhdrwjGM8iA8eJqya8Ue89saga+JjTVYQQ99
 K6M1myC2ffVwi8mucLUdkOHeYMX42eL6C6CBd4usks/eCjQjgn2eF3l/s3rjJuoODFtm
 OsDQ==
X-Forwarded-Encrypted: i=1;
 AL+hErF3Sw+kZQA0KrZnZKDoGpjKgZYKj/V9emIXNBURzB+NdN8NAtSc66ZU+0KCgETi05fL2YsRgGO0xTpb@nongnu.org
X-Gm-Message-State: APuU4Z9ONWSAP8Eerqc2Eo8a82VtTVO/zwosBrAz7H7g3I1s+ZRMd7PX
 fzWUlAIaM9riJ67LrnHkV28zOLHxTWKkc4u4N3f04Mf9Hm3bknd5M7FKJglH0ATial3gf2WFsJc
 QuHvorAfWWwq6Iy75qP+7aJeaz9eBDYbknfhFsLGWV6QLD89Fy36LnHmRtQ==
X-Gm-Gg: AYBFou2ErWRzU42TwaDyxtq3am/5EOpb1LhqB3WWadL9ZpmHxDvewgM1suU4ktQvus3
 5hZk99ENNB87Qi7Vt4QFAuLSkOMFWY8lcFuYfy+FyMu04qFJ3G0sgZViayUScU+ABUgbi8dK8Mj
 rSzb3N/iph58kfcSZtfViVsguWfv5CZOZWQQIpqPxd3ZPsRbhY1ysp0dT2kLfINjJYypT/lZXzm
 RTOHuStzd7bZDF4d0QdKCIrLJRZozQL2npygHwxt0HfIp7/uOyC7OkeqoSoy0IiprAVUy+zFTU1
 NF+XAxkxJJDNwBF3y5bIx5AZYdpPYFg7OxXIP2grrMDC7wjwi94gna1cbmWzc/ZvRLBTaW14xZS
 5OJmNDFjQVV/Un2LpWAXW8TpiAe5BSDrMV/8ohjVDXFHZrId82KoF+j1sLPitcPimrcVy+bNVnV
 vGsopvqEW2
X-Received: by 2002:a05:622a:5e0d:b0:536:719d:7974 with SMTP id
 d75a77b69052e-555283f3c18mr6632791cf.55.1794254653820; 
 Mon, 09 Nov 2026 12:04:13 -0800 (PST)
X-Received: by 2002:a05:622a:5e0d:b0:536:719d:7974 with SMTP id
 d75a77b69052e-555283f3c18mr6632381cf.55.1794254653405; 
 Mon, 09 Nov 2026 12:04:13 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5550be2e22esm5315721cf.23.2026.11.09.12.04.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 12:04:12 -0800 (PST)
Message-ID: <1bdbf80b-670d-4c65-a5b3-1105f50bcdca@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 17:04:09 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 12/38] target/riscv: Add implied rules for
 Zvfwdota16bf extension
To: Max Chou <max.chou@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>
References: <20261104194155.679241-1-max.chou@sifive.com>
 <20261104194155.679241-13-max.chou@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261104194155.679241-13-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=TMjQ2Fla c=1 sm=1 tr=0 ts=6af2273e cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=CoVnzymCHC7Sdcki2SQA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA3OSBTYWx0ZWRfX4mfnKMm5G5eY
 XxwSZqSrNUmEUIyPkErKN4ajWfDFCLCKv8NeFSch42mJpPa3d1nNAsDgwB+U2ujgYcbb8wAUBKI
 blH7vy72MJ8qPF1ZJSRs1hRspycQSt4DzzJl2I9gu7oUbsTQPiLWhH+3I6cPeNhlZbA3G4PydX+
 8bKuhxRX126DySLPJuqCRmWD/AZImmLjwvxKDqpTf2yE6TL9DUarJUlOO/aFrDvhsHdIJzmqDlT
 dKjZODgfb7+FeXrU/E4vw/y/f55eiS1u8hybDsPmKlSPixVScuLNbiSmDTfq11Wzgd+a4m+VQGF
 /JpMTUm2xo37DcC6V3FJtm2MUgVwHRr5zazB9UicO8OZnlzElHsHhI+4fheccbyvT1wFSTSWKwx
 h33Y+9ZQAUbEd7DJCg+NSk0uj4JTDOgMMEMA+0f9dkTe+FFpw2TEvJzWryyPk6jL7+DIFObrj2+
 M/yIolrXR4neEqUJ81w==
X-Proofpoint-GUID: _4wrHQaEyB2BDuNaNlBVveSPryV5PR4I
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA3OSBTYWx0ZWRfX2nKayqy6zHJD
 8WzFnFxjaGqqBv/C6lbs4JRSk/XXznIwHaUB0tST38TDVJfcwdomoxJL3oVEJHK8KteLX2wO7CP
 TfjdSdgq48PFF7XjxVtuXYFNWQsDVb8=
X-Proofpoint-ORIG-GUID: _4wrHQaEyB2BDuNaNlBVveSPryV5PR4I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 malwarescore=0
 phishscore=0 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611090079
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/4/2026 4:41 PM, Max Chou wrote:
> Add implied rules to enable the implied extensions of Zvfwdota16bf
> extension recursively.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/cpu.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index d6e2b07c401..2d905a99d68 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2873,6 +2873,15 @@ static RISCVCPUImpliedExtsRule ZVQWDOTA8I_IMPLIED = {
>       },
>   };
>   
> +static RISCVCPUImpliedExtsRule ZVFWDOTA16BF_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zvfwdota16bf),
> +    .implied_multi_exts = {
> +        CPU_CFG_OFFSET(ext_zve32f),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>   static RISCVCPUImpliedExtsRule ZVKN_IMPLIED = {
>       .ext = CPU_CFG_OFFSET(ext_zvkn),
>       .implied_multi_exts = {
> @@ -3070,6 +3079,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>       &ZVFBFWMA_IMPLIED,
>       &ZVFH_IMPLIED,
>       &ZVFHMIN_IMPLIED,
> +    &ZVFWDOTA16BF_IMPLIED,
>       &ZVKN_IMPLIED,
>       &ZVKNC_IMPLIED,
>       &ZVKNG_IMPLIED,


