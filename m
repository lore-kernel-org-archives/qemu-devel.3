Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C239ECD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 09:50:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNGh-0007e4-TS; Mon, 11 May 2026 05:49:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMNC6-0006NT-V7
 for qemu-devel@nongnu.org; Mon, 11 May 2026 05:46:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMNBs-0002Sh-C3
 for qemu-devel@nongnu.org; Mon, 11 May 2026 05:44:50 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64B8I2Ol1850420
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 09:44:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tyzJfu/Hntt4r3NpSYc4HY9Ih1MNQSw+IHSiGG858wo=; b=FJ8BIt0g24OK0E5m
 MO36l6poo3cfV9KpXIuPV8isweQQCNEyBu+TQTi8zlyO+dqdVVtiAYXWmpYcEtBg
 V1aHWXR0b5pwWloY6FQdKbZQ4RB99EfcveoADjobetaDODVAvkH+qdM9OEeG8syW
 qPdj++ALdA4DyzzXleXSNYehqLLiPqnmGs4o99oORqC//F6oPfgAQPo/UTdV1tzn
 U5MS1u+ZaOaJFm9J0S2XKumnpeiswZd/R/mrXsUC+jXw/R5URt3ilI1Yff4mrMmU
 Uj4UZTFlwgduoSFI2UykTlrliHK/l4iLUZbrlnvg0CBAfu+/Pp2gqOz2BDLtpYh2
 5xebhQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e3bfvgb38-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 09:44:42 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8ebe2c596c6so649067385a.1
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 02:44:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778492682; x=1779097482; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tyzJfu/Hntt4r3NpSYc4HY9Ih1MNQSw+IHSiGG858wo=;
 b=cxwnT5XZ49/BJh8dlw+8BMktHgpTqzzTjJP0IEI99HSlHgtPldIadcNg4otNjepwFT
 tGldAgdm+sGnhcqwADEYvumT5W6ThOPTjnxlOn76yn+vv79JmeS0N/EkARtrbgpACfvj
 i+7F9WPa020hoystjQYiryWzZGdO/PW1xv+7Q9w2de3x6w+9Z7g69IoeNo/dOjexdKcV
 rVO45lo5k4rcBZUvCCEh4T7O7w/ISQVG4maVU0HQ5R3U67OkVZXNKruKHjukTVtKFFWE
 O3aRrwDQoznOdOcZiYsZ6wJE1/qLwLcqXCqHmLwdZdVix8EUOsgm2cD+Yhz4xy4GhA+8
 +Ghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778492682; x=1779097482;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tyzJfu/Hntt4r3NpSYc4HY9Ih1MNQSw+IHSiGG858wo=;
 b=kuccdtSG5Wph8CpnFtY8rSpyAcAUI+Jjg25VbK5ifmn9nQ6LnuxD5wNpw5fBNKePUq
 pWlfy62WCcoUgD3IJsQhdO5MlRv88GE72CvAJRdwdjD10P8DXVXXczPbstsZB0MnRfhH
 gyLfBztRxnlwmUKjTMNu18ePy5kAFrrFxtc5AN5K2c+gmd5V1m/ED66+GqvQU8xcDj9Z
 lTktmRrWCEU/fmF57kZu347Puj9MPvKOM46a39reiFqJKUlbaAPGo/JszDV8sCfMjEOa
 vAvkBTGR6mv/XojDfnV4Myjl2AoVeZdEjI6VXe8Hwm/gS4P/bri63PdmHoM0RMtklfSQ
 QPEQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/0NkKpHe20TwrHLaqzlLJl4+3yTMFMw39H7bGgoJ6euxpFjetAZtuUywiqJJLuaVVKyfr0m2R2FgEA@nongnu.org
X-Gm-Message-State: AOJu0YxQoA7kNCbsdlnjTcn8W13MraEeGhSCx0kaxOTU1Zao7SFsXrom
 mNZHcu2Vn4lx0A/0NC38710er5NOPtDH1TdlgueUEfA+OwZk32KM6x+7orqc4qA3F5dFcVQo+7Z
 iPqX2CZOayKCS9iwjZ++aGgLMTEFN0I65haREEzKIS9s0cmirVIiqwnfWIg==
X-Gm-Gg: Acq92OHyDbqStWxEgSGMKJr/u2hUGn2Bx+XPulvd+6tNKySJA+2rJaXDa0GNsJLymTz
 aDYKbXzRdJ2BnGnfC0K1bCMGQLVKfmnLEY3BHYlnK6na+QGqdhO0B61/59O3phNCk8eBo7u9QjQ
 RsVfgYW9tZD0FBhUXJ6ATCVXNDkJ3Af+BehHQlD4cKadjxjaCZ7PXDqyu/GzHxjcJfg7rSGoVx0
 +1oeM5uyk9mdhN3qLXBYMnw/MNNbG4BeHP/KmZGFlJ/tYQ12TwTCK0N0XZRCcSAKkC0YSoAQE5U
 5inKqNHPo6Gsuw9OfpDIjrtbI2BBME848KrQbwtZIM3qWYCfjfCS5X/DK7YI4wN+xUfv8AE8GfG
 r7b4ePMxphDuY1z5GXgymyplRPxCQ/CKkFEB8TAIe+P9w67dMrIZU7zyzZ3U=
X-Received: by 2002:a05:620a:319f:b0:8eb:41de:fb3b with SMTP id
 af79cd13be357-904d3eaf9fbmr3556655985a.5.1778492681686; 
 Mon, 11 May 2026 02:44:41 -0700 (PDT)
X-Received: by 2002:a05:620a:319f:b0:8eb:41de:fb3b with SMTP id
 af79cd13be357-904d3eaf9fbmr3556652385a.5.1778492681244; 
 Mon, 11 May 2026 02:44:41 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-907b966ee91sm1018674485a.10.2026.05.11.02.44.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 02:44:40 -0700 (PDT)
Message-ID: <69ef07a9-57f7-4d2d-a72d-e5ece31bdb62@oss.qualcomm.com>
Date: Mon, 11 May 2026 06:44:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: add Zvknha as an implied extension for
 Zvknhb
To: Zishun Yi <vulab@iscas.ac.cn>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20260511051736.2916225-1-vulab@iscas.ac.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260511051736.2916225-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authority-Analysis: v=2.4 cv=Fa4HAp+6 c=1 sm=1 tr=0 ts=6a01a50a cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=7WufM6Q2AAAA:20 a=EUspDBNiAAAA:8 a=5tghbzQ9oMU--FvhtGgA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-GUID: TCnRUNwCXN_MjEsxXtu_17QiFMFa48xp
X-Proofpoint-ORIG-GUID: TCnRUNwCXN_MjEsxXtu_17QiFMFa48xp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDEwNCBTYWx0ZWRfXzS2O6P/OEys1
 mJtmbdFazO1fz7uE7EkVeXXsJAAVrbSig+WaW5AVWJ/6NQqCFEmH4m8lKV0fDoVNpz/V63Nv+yl
 HDGDKNFij4ultW3mKF306wB24HmtYlw8pbi7vjT9xVUvoUQDSlthlw2WeNSED2QZao7cfSK1Vv/
 XgmiwHZwiDvc2+jqSJQyWYgGxiwpyzV1Ehn8vqHieioK2zmI2aSV54Yu7rOSjsIS8lSJLqE7GLp
 uTFYy66XCtW4aEeZo4R3KRIlfKccbE/9MgA8G4IFlVHlfqCo9VlCdEr/Lsb3zXT+8hD57z2Iv5r
 lgIaz/ErV8q1WzkC+XQ4pNOUbBaYlF7LR8vPm15ii51mT1PBDVxB/qfsxyIqlQ7Nh5tIdoAcJcl
 onU2ZKvD5f6DSmbBr6gKOeVGUZLTifobfiYt7lWkAxX4KZOEHxeH9vh8O18t7d97No4GrfH/UmJ
 pp3FOiqKKLoyOdx2zVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_03,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1015
 malwarescore=0 spamscore=0 priorityscore=1501 bulkscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110104
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 5/11/2026 2:17 AM, Zishun Yi wrote:
> The RISC-V unpriv specification (zvk.adoc) states that "Zvknhb
> implies Zvknha". This means that enabling Zvknhb should automatically
> enable Zvknha.
> 
> Add Zvknha to ZVKNHB_IMPLIED to ensure the dependency is correctly
> enforced.
> 
> This issue was discovered and reported by SpecHunter, an AI-driven
> architecture specification analysis tool.
> 
> Link:https://github.com/yizishun/rv-isa-sec/blob/master/output/riscv-isa-manual/pr-2635/qemu.txt
> Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index ce15a17c37de..61430e44020e 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2542,7 +2542,7 @@ static RISCVCPUImpliedExtsRule ZVKNG_IMPLIED = {
>   static RISCVCPUImpliedExtsRule ZVKNHB_IMPLIED = {
>       .ext = CPU_CFG_OFFSET(ext_zvknhb),
>       .implied_multi_exts = {
> -        CPU_CFG_OFFSET(ext_zve64x),
> +        CPU_CFG_OFFSET(ext_zve64x), CPU_CFG_OFFSET(ext_zvknha),
>   
>           RISCV_IMPLIED_EXTS_RULE_END
>       },


