Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41B3F606A31C
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2026 20:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=iJfQGFLT;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=MAlyyhZ5
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQVrS-0007vl-PZ; Mon, 09 Nov 2026 15:21:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQVrN-0007nD-GA
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:20:57 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xQVrL-0006BZ-DE
 for qemu-devel@nongnu.org; Mon, 09 Nov 2026 15:20:56 -0500
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6A9JfsIa1830104
 for <qemu-devel@nongnu.org>; Mon, 9 Nov 2026 20:20:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wuUdR9jZU5RlA3wAB4TD8px/KMtKuD5m7Sg8IXmU6xE=; b=iJfQGFLT9wAiQiET
 G2fJdpVNY2rC72F+ZfQn5PAPSvQI7DzIOWlmYWaYiGMgE0mLGJnqXfc+4UKaWb2h
 R3RXjMZy4NtUp47JKxaky1w3PTNsQ5yb4epIDE1xKQP5JZj9o8mMgQ9G3V5GHQgW
 0fvdH4O9zOr3eEhH0qCLl+EXZeaNXz6jFrsthWvZXv1G0IJipqzgveDUR157aUdf
 xhe9sUPuww1RMEjwsXnqthO8ufTUmbXKB05pEtUWcaCPPAjsjMB2yyVAVvBNwGGQ
 WB3hysMFlRnAHVb2ca34aIENTTqCKRl4xPVQUJA6QiG2xCd6xKDp7bsu6Q1xxG2V
 oUVyQg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4humjg0466-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 20:20:54 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-5363b06bcb2so28301721cf.2
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2026 12:20:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1794255654; x=1794860454; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wuUdR9jZU5RlA3wAB4TD8px/KMtKuD5m7Sg8IXmU6xE=;
 b=MAlyyhZ5QfaQyQR89Wq1X5eMLugu1/z4VMVNf+sCXfIJkKVb+I5lYNijEpe0eql/ca
 DMHn1Lf+G4IcqtdByrmmgaOxMaWclMqgJvIP+nop96GDMMCHA2lWreGgHHskPPB7mdpg
 YEh6dkMr6eCQfL27KC0AiWW07myBBUxeOenWOUvC0X93bQrgHGBV3H24hd4dAZ47EHn6
 ZD06wOWLIGsFgY/moAfzHE3kQZ5bqhUABGxsD06WqFaE+GL9WFTCPBd1wROnvX+/yyLY
 i3pDSWzC/e24iqlQFoMse7mgGQTHI3EbUE6ZFfAOqGBQc4Z0OlFlxF/78ITBD1jDaEVc
 a+Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794255654; x=1794860454;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wuUdR9jZU5RlA3wAB4TD8px/KMtKuD5m7Sg8IXmU6xE=;
 b=WPbbq9qIaDqhzaGgbeXTwJT8lIIk1Bijs4vptm7VBep4+7Tz5B1NYHeUKt0b5uPmlE
 CJrFVUEv2ARnb55bP8TOvgx0cNQFWzqqCnA7QxuKmACbpvKsOX7pzQqs+MhdG0bRpQUn
 nGWIBJ0S2iHhBOHYj4nNdmfV/FhQ8kgd7bAXAoQ+9GhpSFVBIVVrJSAjIcGup7RdAS/H
 MOx45wB1dNmmFmtmI4QHUqqzoGRNYQtPI+iMSrUmfJ7rOBrR/teBmzUWxmXRq/E+qAT0
 KDE0m3RRdpmUHD1/8W8PWtDDaipqnu54MkXv06aaKG5N8qJPZmjTdYqShiSwuERXnMy3
 x+OQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFYTqyHM52YVsnsUaBP9QjhKlP1OEESBuKTDPHcpbym3aipmw/EDOhC4+XrXFOOL5ApYe9CsoqTFQW5@nongnu.org
X-Gm-Message-State: APuU4Z+z2p721+XWEV9oKCUpojqANB9+wJ8aNj6siln1oP8F0Wt3Ry4R
 2SFoQDRJZ6n0xjFdglYhy3o+nHfxz2tD53ha4iXNmxaKlfxJnkxhacJsmh1mJHg0fz+YXdvb8UV
 g1IOQldBzml0P2dTGcRX5bXcYxkiyt1dXe6XbBWAOCCjeuzXLze/LLglYBA==
X-Gm-Gg: AYBFou1vBVVZisTtpwhieIxZOlvd7D0SY4AEmK5box1MO/MttKLJ9epE5p+3S2I8NAS
 ywWqtsQqPdn3o2M8eLJnMX/4OL+hS8/gicEra2K8j4gUtbTet3x/1hlmKnCEUyJQie2zul1SSuB
 myGK0ywXe3FQIURsjUNBUXBHPgg1O+y+8Toykr9px2/BakcteDxEbuDhFl7e5b1QjBZiKxHPDUX
 rdn3lffAmMZIB9M58nOQ4/T9C4PdxOytwB6c9JBrkstRuRL+VDB/oEHSfVRH9CEezoSTYV32cqw
 94whrhV+1ziB1Ii2dxjduAItAFinbd8YPE9MBM5l1pKuBiPLOSyLu/FqB8hr5En0p3EtKUvCICO
 kOGf9JA84nQID9C/jcCgb71G3WO8+r9JoUM4c0T9OtKY9JIVwgXCVXy8Sv+NEhWbCupdwuYyg5X
 VC8IM7icCL
X-Received: by 2002:a05:622a:5b8b:b0:536:6c87:ebd7 with SMTP id
 d75a77b69052e-5552b64e9f2mr7022031cf.69.1794255653659; 
 Mon, 09 Nov 2026 12:20:53 -0800 (PST)
X-Received: by 2002:a05:622a:5b8b:b0:536:6c87:ebd7 with SMTP id
 d75a77b69052e-5552b64e9f2mr7021391cf.69.1794255653007; 
 Mon, 09 Nov 2026 12:20:53 -0800 (PST)
Received: from [192.168.68.100] ([152.234.124.231])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5550af5f09fsm5808101cf.6.2026.11.09.12.20.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2026 12:20:52 -0800 (PST)
Message-ID: <60fe8d66-4106-40f8-bd1b-9c0a35193b06@oss.qualcomm.com>
Date: Mon, 9 Nov 2026 17:20:49 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 20/38] target/riscv: Add implied rules for Zvqwbdota8i
 extension
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
 <20261104194155.679241-21-max.chou@sifive.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20261104194155.679241-21-max.chou@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTA5MDA4MSBTYWx0ZWRfX1d647oKrvGxq
 JCRqzJs3iPuI46Aqhwk/CpoeST8M4ROuBCETyMIUQes0KH+95KtT1AsjEyT0QDKywcVplMQMcGY
 Fdw9wiqHSqdyDW7jkoPP33FQ9cSp6KMIQUN3IrzdWYbdJed46MXrTb8X4JrWkEjk3TJotmK7cLB
 qhWgb1Vn0G5bqAeO2i3gPnP3YL9AGaAGtMGwyxb6YTCRSJgkLKkgFDzYFqg1VALNIw1Wt/ergpC
 iYuwdL1AT3wryXM0tmfD+dChLgVZacYAu3wxqkQkIlMh0K9aYXUQTppYw5c1CxAD2gmqRhwlblw
 5+vnVzl+ZqjNejiGDYUPSmmg5KNgdwrQCj3X0Yiyqk6lXp9cpdp0ZyeEmUDEHWRohb6UWfA5h/F
 8XvB127tjF+Tgx0GgGmGPziW6+lahAcpwYPV0zfP5tzzJ3AqN2pHk1q+lAPVx7fnahBC1PUUEjG
 Q3AJyoQobame5/PPcAg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTA5MDA4MSBTYWx0ZWRfX9PhUb1dGwtwQ
 oHc+RPA5lrDvavZB1NYVDl6W5h/9KbMjIrL4pM1dOVvX7sSTH2gR8ywJRFuSJq6FZQmfgxWJ43w
 plv8LrmjiKfDWPqJxt80zx6BAUSMApc=
X-Proofpoint-GUID: WAUXG9l8IofH-RsBYnh2khyvge13tEUX
X-Authority-Analysis: v=2.4 cv=B6gsQ+tM c=1 sm=1 tr=0 ts=6af22b26 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=8elE1k/PHQNyZ14TNTodlQ==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pFyQfRViAAAA:8 a=EUspDBNiAAAA:8 a=rmaBA_Xxq6BIzo8Oe4sA:9 a=QEXdDO2ut3YA:10
 a=uxP6HrT_eTzRwkO_Te1X:22 a=oJz5jJLG1JtSoe7EL652:22
X-Proofpoint-ORIG-GUID: WAUXG9l8IofH-RsBYnh2khyvge13tEUX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-09_06,2026-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611090081
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 11/4/2026 4:41 PM, Max Chou wrote:
> Add implied rules to enable the implied extensions of Zvqwbdota8i
> extension recursively.
> 
> Signed-off-by: Max Chou <max.chou@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/cpu.c | 10 ++++++++++
>   1 file changed, 10 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 9271f79d1b6..26d5ac69c75 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2895,6 +2895,15 @@ static RISCVCPUImpliedExtsRule ZVFWDOTA16BF_IMPLIED = {
>       },
>   };
>   
> +static RISCVCPUImpliedExtsRule ZVQWBDOTA8I_IMPLIED = {
> +    .ext = CPU_CFG_OFFSET(ext_zvqwbdota8i),
> +    .implied_multi_exts = {
> +        CPU_CFG_OFFSET(ext_zve32x),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>   static RISCVCPUImpliedExtsRule ZVKN_IMPLIED = {
>       .ext = CPU_CFG_OFFSET(ext_zvkn),
>       .implied_multi_exts = {
> @@ -3101,6 +3110,7 @@ RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] = {
>       &ZVKS_IMPLIED,
>       &ZVKSC_IMPLIED,
>       &ZVKSG_IMPLIED,
> +    &ZVQWBDOTA8I_IMPLIED,
>       &ZVQWDOTA16I_IMPLIED,
>       &ZVQWDOTA8I_IMPLIED,
>       &SHA_IMPLIED,


