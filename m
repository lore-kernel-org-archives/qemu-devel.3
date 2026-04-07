Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31ADFF5138
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABWy-0008JF-8o; Tue, 07 Apr 2026 14:52:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wABTp-0003JL-Fb
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:48:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wA2wY-0003kz-1u
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 05:41:59 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6376iJDE3815226
 for <qemu-devel@nongnu.org>; Tue, 7 Apr 2026 09:41:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Au2d2yNiFOxQ3cQzB1FZ5/URQp5lMwFbU+wKH9HYk6s=; b=Akd3NRI0fI225ykj
 ZWsHvJrqvBmKhBS5sISlCUQz7uvl3Rz7S21aBgVYIIjMzjYnMtcjNvAwYEnvAc3W
 /4VvHcAmVrlQ16b8EQKENoJGnJRnkymBFEcn/Gv+tc1vBhHrSVbUAbxwm0pUInra
 fq/iDEk+vkWxcWHbTrFJ2HbUItxRQJbuzqMBcLmKUjO/FtpyHBc19chyotKFa8Yf
 yahpKPIhaF4TwoDrAFIuvDGZ0FeYy9xMw1VqzTmT7oqPfl7wABXiIriB0ZUHESJa
 We/KqT7cCPxFN6PpCKZJE+8Uf5H75bY+Mb51xG97zuu52SpBHJck6lIAuiS1lxOW
 8EuqXA==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4dcmr4t41s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 09:41:56 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-2bdd327d970so3575937eec.1
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 02:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1775554916; x=1776159716; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Au2d2yNiFOxQ3cQzB1FZ5/URQp5lMwFbU+wKH9HYk6s=;
 b=acmjfl1iRckWusSCGaHOSM0DGrZuMgIdUr+eQKf9zzhgQOVVmMfCF2cuUizMr2qZ8m
 CCqG4lOq5ByTiKKWX5rH/Zu+b1qpV1jW/xn6S5aU2D+B450baLgsgdSRzoUUBgu0Ofo/
 nPhQj6uLLuXy7S+4cvT6AxrDX5bTPQ4LbbLDwHVUD+7uHIYm5MEDMqbnWYrgLPn+69pk
 vOVHSYlbtZ/JZTDWgaryDNtyZX+304qNIpk9QdfkP9dhzy8fuXC5gpD1+zSRR3e5M5Qn
 c0syggn+urERpczkEWBipG63RM2Or8nrTOFAzp/nBjgpTwE4EGoUJjq5JbfjVIM4LiVs
 c/YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775554916; x=1776159716;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Au2d2yNiFOxQ3cQzB1FZ5/URQp5lMwFbU+wKH9HYk6s=;
 b=QZZC1nvZum3PXW0GB2YPcrIRhK1apMTUmTVPIdVBOfCxavScITyFe6UJNHrBmdVm1A
 p+iRinFBxkMLmnTttYD780Ff/hT9wDK+UW5D5udQ4wYTkwJGRH8+pgdG4oNPOZGvIh2Z
 YqVtx5uyA0XqhubdQlhxwDjUNgbxLYWkc12q8FlM4SgedIpLHzAEXF/usYU6sjPXxhwx
 gL0hcQSqYkjLFA8bGSr7Mpm9mehbc4QXu1psmw+JJUKhqK16+ODfX/oN/PQYiviz3Iy4
 OcH9KCzTe6Zi2p3+C3l7E42VANUOkBBEn+C+M82w0wPFzauUzNKeWAqo7g8MuQddsCFW
 C4lw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVufo3xs8wT4k1zubTetmV9GhLYGVbNeadbaG4ihwyoOQTyFydkHEFP/Tcp6DLHFFpEr5SbzyG0Yblh@nongnu.org
X-Gm-Message-State: AOJu0YwA1kxh/KdULsE8JrvSdkNzb4N7J7UOw5kjhF7VdoykrC5jtnU4
 3yPDVlOPFeJe7clFEu1T1cIIGTw92jX+nSCg3hzYHiJmzqUDA/A3hfaZZwQZtNR76slMG3yRHmq
 e0+0Czcn6aJby0eowKtiNiwrn8GS2DlTnuiEM2ySMe20o6E2yZ2cle4SgNg==
X-Gm-Gg: AeBDieuCPJqTehQgXnRXSBkusq00qARX/pGhZj6j9JljXJwIOjlkQ8QfXfE988umpsF
 kS/a/78wTwAPeOIX5maKyxa76p8EuIveylJQKcTVlYMtwTVx4asJTgAUd5XZs3+rJjs+8z0nraO
 NDscOXCBSStUZEYanZD0mH50ccWit3Kr1TH5ZifqUQ2wIHWFMPVmEG+IMey1zakQtYEXq3Z7l9p
 ASkt4JXuvxS/jAGsuzxqWHhkx3HXoDvkvWWC8zE9hGRojSRaIYTuictCNFget/UMjp1Cu31yND7
 xMQKm4aBjhwn+lI8TWWwYAZCcSwn1Qeucir8VJXFplX/j6Pg/6CerMVasMxH9r474DowzXgXT38
 tiuWtNr93D47B0rcdkE7w8gIxLbnRO6TfMjAOfyQ5uXZHOOAFk9I6TqCq
X-Received: by 2002:a05:7301:4306:b0:2cf:8de3:d48d with SMTP id
 5a478bee46e88-2cf8df3209fmr2290478eec.2.1775554915697; 
 Tue, 07 Apr 2026 02:41:55 -0700 (PDT)
X-Received: by 2002:a05:7301:4306:b0:2cf:8de3:d48d with SMTP id
 5a478bee46e88-2cf8df3209fmr2290454eec.2.1775554915068; 
 Tue, 07 Apr 2026 02:41:55 -0700 (PDT)
Received: from [192.168.68.100] ([177.18.66.130])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2d1bf4447dasm1566379eec.21.2026.04.07.02.41.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 02:41:54 -0700 (PDT)
Message-ID: <e7d16fee-1f2a-4fa0-b587-21f14f01dda6@oss.qualcomm.com>
Date: Tue, 7 Apr 2026 06:41:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/5] target/riscv: Don't OR mip.SEIP when mvien is one
To: alistair23@gmail.com, palmer@dabbelt.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
References: <20260407043614.372871-1-alistair.francis@wdc.com>
 <20260407043614.372871-4-alistair.francis@wdc.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260407043614.372871-4-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=dO6WXuZb c=1 sm=1 tr=0 ts=69d4d164 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=Wg2i10Q8swPuJs8jTFC2sw==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=p0WdMEafAAAA:8 a=pGLkceISAAAA:8 a=JF9118EUAAAA:8 a=EUspDBNiAAAA:8
 a=JXnM8C8QJobWS20sFw4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bBxd6f-gb0O0v-kibOvt:22 a=xVlTc564ipvMDusKsbsT:22
X-Proofpoint-GUID: HIdU2ouInXDPcML-zvBwatuBYFwWjhML
X-Proofpoint-ORIG-GUID: HIdU2ouInXDPcML-zvBwatuBYFwWjhML
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDA3MDA4OSBTYWx0ZWRfX3bvW/P4wTPMT
 jx6BJG97RbPw6+lopiLl9sTqiq6AZ/Wb1+lsKHGmNPLMp/beLz04DlzMaEAHNJjLJRkmXfI2Eg8
 pdRrSxkhrHU08O36HWo3s21rylsaOeg1zKA1+HO9sPDs/i2jzmLmAv0bWnI/urQ6/79Oz05vBMo
 m875zN5CBHaMkV/BOxIRGlT5szuG5bu5FHnlZ2UvG+jmPXRCirLI7SGCHgrBBqTTZ0AqbmEW5OJ
 zJ3febeihkZRW8MsuJituNfISaKwQiq+mAtKl84/C6fI0SbXc9pesN4nyc2O4e42sGLRYOGcq1M
 XNuzlpYThQliwQz2DEX18aJtYdJ93F4vwbJwrtSrutHu+sno6T/T8SUBjteVeCHOy/Clsp5shAN
 e3prD5u4yfiaDaBUfcQEOJf2llHFxvWKa0KMGQwvgZE2qA3W4a3nQ0dNhar/J3sEL0bT1Z8s16m
 gJCGwD03fehkM2Wbjvg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-07_02,2026-04-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 malwarescore=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604010000 definitions=main-2604070089
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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



On 4/7/2026 1:36 AM, alistair23@gmail.com wrote:
> From: Alistair Francis <alistair.francis@wdc.com>
> 
> The RISC-V spec states that
> 
> """
> But when bit 9 of mvien is one, bit SEIP in mip is read-only and does
> not include the value of bit 9 of mvip. Rather, the value of mip.SEIP
> is simply the supervisor external interrupt signal from the hart’s
> external interrupt controller (APLIC or IMSIC).
> """
> 
>  From my understanding this means we should remove MIP_SEIP from the
> alias mask.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2828
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---


Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/csr.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index a75281539b..2a2f9497db 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -3796,6 +3796,14 @@ static RISCVException rmw_mvip64(CPURISCVState *env, int csrno,
>           /* Remove bits that are zero in both mideleg and mvien. */
>           alias_mask &= (env->mideleg | env->mvien);
>           nalias_mask &= (env->mideleg | env->mvien);
> +    } else {
> +        if (env->mvien & MIP_SEIP) {
> +            /*
> +             * Bit SEIP in mip is read-only and does not
> +             * include the value of bit 9 of mvip
> +             */
> +            alias_mask &= ~MIP_SEIP;
> +        }
>       }
>   
>       /*


