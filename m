Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE921CD37B5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 10:09:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNZd-0006lA-6D; Mon, 11 May 2026 06:09:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMNZT-0006ju-QU
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:09:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wMNZR-00015A-JR
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:09:07 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64B79DcL2575028
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 09:37:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Uii7AB/nSagMFqYVZsnFP3Hblz6zJSy3Uv8KbT4qW2Q=; b=EDBrKMjBOufNJjKk
 kZlGM8okztrleZTJ5kYsWp3tS+PUiG7WWQrpnGQyhaK9LLe5cItTtjkszYuBweVi
 44cGNSgbJ/wRmgP8Xip2L4CKvTSJKKGIMYCXL8cDrL6Y8jtsEejVkN363SH9Meo2
 e/Qtt1krqfYJPA3+dJjihY4hnd6t/egL5nTR6Ys7edPdy7w2nUeU7B1arTbmOmX6
 9nQaJ4KKu1dHvvS3jla/emQGF1rwcIN0huJ0SWUGUWnG5mMWNci+0DgesM1hzLRL
 oNDIFaDcpckGv7MzK4s7AIbzlLlmx24CaozCTPgdciVz4C/ifDSMQmjdWnMxiPL5
 edDgVw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e1x79na64-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 09:37:45 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8eb52a22e85so907901085a.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 02:37:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778492264; x=1779097064; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Uii7AB/nSagMFqYVZsnFP3Hblz6zJSy3Uv8KbT4qW2Q=;
 b=E/J32OfsuP/bGAX0e5NS5IvTyWOLlYdssi+aB1wmUlM7Oxq8i/hKu9dNcGGunEUP/M
 We8MLgBxRZWGLjhC2m4Kn7e1GA81awPNWuAGwcNquO6RFzGl2ct9bqv9oDSF6l1dbflc
 DnXvwHJZ4WVNzzvlIb7hMJBzjzeg5D7BV/925smZKqvLif5M2RmmFTzE78InWfSR2fYc
 Qzie311w8HvkjLA0QXRMilaMiYhWm+dAU3ConsAhENsQmCd162mvEpVQ5vq8kNkrJBnu
 XS8evOA8xqvDoDmnErESnY9ag6WIBghZv47s7gvoSlWet8BAj80ru5fm8WHQ7UGljuqP
 P/4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778492264; x=1779097064;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Uii7AB/nSagMFqYVZsnFP3Hblz6zJSy3Uv8KbT4qW2Q=;
 b=KKimbDsi4tbp6uUudLKQ5Z3F/tALvQ+3KfgsoMgqABOXRn/8nITdTuXvJZ5GL5jAJI
 S3dMr1cpXbadPiNmNKTgUU4fefHfaRRgYSSZd1gymsBovihYMi0Ky7prIw+GO8F5MXa0
 7NNIKzE9Vbc/YZaS6XZCLGLcW63u8/LKGHQ/Oc9d6JgaK15jvtnj1iAiqlIPn2cHm3YL
 zGH/vvy+ctaW3kOPxWj6Z+XGB8784raw9oWqnz+7+VVPcgpDF54HSXel5K8IM5tCiZr4
 5qH3DQaJri6/rBx28mQ5a7VJDXbtfI9BOI0bhBSUSfaYqAuWjcOrCfa6PBdnpep7ho2q
 5Tyg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/F1Z/KZhucaVEN7JWGLUw4FAPCAo5oVPZF1GfGxmFkFYcud1pyU58xHjlCuEUu6MnArek8sFPdWXaG@nongnu.org
X-Gm-Message-State: AOJu0YywoZMvbqvfcfgVM5G0/9jtD9UOrWDf+pD6TfuPOlJ8GiW/wJYL
 4OORJy1RNCVx//BV7wYC5d1W9+FxGgkkJaheAoAhYUr8J8BIPxAtoa5mlMHOFVBCwwTtvsr2UoD
 21xiEueCHgSV+EgJfU7NRvMlhPi9Z16oup5ADlYPLfjtjV8vnH23BeRpzCQ==
X-Gm-Gg: Acq92OFZ0n2WEk9eVHZr9aKrAY3U4MuRU9VHD4J/ZosFsmjWTwsBo8n7g7wOGkuoRgK
 xr9W9UimgLfRpHGioak4s0jcnYof+D4XGAcYKaQvv/WmDDTU5PeVPWTdQcDroRncgTvs6CNqi8l
 l1oAdJaKw9bP8+9pdmhDUePwTt7eIac6qreyMCObGPFnmItw/t3Py6U4RETHNsmS+oPQbnTlQ5I
 9XDJW3Id7lqx8XBMHxtUEtfdMmR3sIkXvzS1gjWdWvrCgqD5qVFyHtpcTbQl+MF5pLopuZfeARA
 zNd9M+26KKsXqz1ZlUyhGmjk7ji909kmbWkIgxKQPRvae1MAA7Oey88hcjO7d+EN81qkef0JGJu
 1qXikhMSDLr30pAA0SQLVj93Rv04u5mewA04YOC1q6S4CsqKHtM37+kjP7uk=
X-Received: by 2002:a05:620a:7106:b0:8cf:c451:cc1c with SMTP id
 af79cd13be357-904d6fcd744mr3338817585a.58.1778492264497; 
 Mon, 11 May 2026 02:37:44 -0700 (PDT)
X-Received: by 2002:a05:620a:7106:b0:8cf:c451:cc1c with SMTP id
 af79cd13be357-904d6fcd744mr3338814285a.58.1778492263885; 
 Mon, 11 May 2026 02:37:43 -0700 (PDT)
Received: from [192.168.68.106] ([191.202.238.222])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8fc2c91dd48sm3036417385a.38.2026.05.11.02.37.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 02:37:43 -0700 (PDT)
Message-ID: <f7ef722f-9f6a-4453-b28d-b0e75ba815d2@oss.qualcomm.com>
Date: Mon, 11 May 2026 06:37:39 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] target/riscv: Fix missing CDE check for scountinhibit
To: Zishun Yi <vulab@iscas.ac.cn>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20260508174917.371667-1-vulab@iscas.ac.cn>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260508174917.371667-1-vulab@iscas.ac.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: o7AYRpr6ErdYVT1_DOoPk9zArMcHWvVJ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTExMDEwMyBTYWx0ZWRfX7Jkd9NncTKqW
 +o+0oLeWtC5M2lfyFVjAMpnQ9yyH7SiCbizSdHUyy3Ld3JRoJqD+x6j0ILdVeYaQPQhe++amLXE
 KwLoKdvzns/C2qeaesE6sWQ9Njw45xQ2e3kEMOxj9M1y0pH7+2xEWSYn37Khz4B47v2XoZbSVHa
 96LXmZpvGi88b1CgqAoCnevgeO8U7/feZF1d2kG/bincaYPmfvvVojKaWvbx/eDnr4zsUDfZz8W
 NqZlQGC/YghygygvVbqItpRwd2Cx258fPkANSk4kOJXcWbrXKUz7KClUEbXircLOqX1XDjgbh0g
 fOHpmT8A6DBNOt50GrLu4q0Kp4MFU9r4DPsnL1UQIn8z6T/GkYTI+qoruGJ8F2fYG/6TexWXHP9
 vTDlxf84OxCZBXYNCCAO2tW80mnVtgutzABXdOliPK9Vrsv9NqSCZdK0LT22GxejhTuDK4MyxLp
 v5HVtOz+rcOPf85ko5w==
X-Proofpoint-GUID: o7AYRpr6ErdYVT1_DOoPk9zArMcHWvVJ
X-Authority-Analysis: v=2.4 cv=Yvo/gYYX c=1 sm=1 tr=0 ts=6a01a369 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=etEqFfc6qwXwpI8uT8rzbw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=7WufM6Q2AAAA:20 a=EUspDBNiAAAA:8 a=vCT3OJhkVFK2oHaeq4YA:9 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22 a=bA3UWDv6hWIuX7UZL3qL:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_02,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 suspectscore=0 bulkscore=0 impostorscore=0
 spamscore=0 clxscore=1015 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605110103
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



On 5/8/2026 2:49 PM, Zishun Yi wrote:
> According to the RISC-V smcdeleg specification: "When menvcfg.CDE=0,
> attempts to access scountinhibit raise an illegal-instruction
> exception."
> 
> The current implementation of scountinhibit_pred() only checks the
> hardware extensions (ext_ssccfg, ext_smcdeleg) and virtualization
> status, but completely misses the runtime environment configuration
> check (menvcfg.CDE).  This allows S-mode to access scountinhibit even
> when the M-mode has explicitly disabled counter delegation.
> 
> This issue was discovered by the SpecHunter tool
> (https://github.com/yizishun/rv-isa-sec/blob/master/output/riscv-isa-manual/pr-2571/qemu.txt).
> 
> Fixes: 6247dc2ef70b ("target/riscv: Add counter delegation/configuration support")
> Signed-off-by: Zishun Yi <vulab@iscas.ac.cn>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

> v2: Removed mistakenly added #include "cpu_bits.h".
> 
>   target/riscv/csr.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index da366cf56271..9ae8d553dcf1 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -398,6 +398,10 @@ static RISCVException scountinhibit_pred(CPURISCVState *env, int csrno)
>           return RISCV_EXCP_ILLEGAL_INST;
>       }
>   
> +    if (!get_field(env->menvcfg, MENVCFG_CDE)) {
> +        return RISCV_EXCP_ILLEGAL_INST;
> +    }
> +
>       if (env->virt_enabled) {
>           return RISCV_EXCP_VIRT_INSTRUCTION_FAULT;
>       }


