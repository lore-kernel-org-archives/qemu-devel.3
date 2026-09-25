Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33669C98321
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Sep 2026 16:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xA938-0001TN-Ve; Fri, 25 Sep 2026 12:45:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xA92r-0001OB-QG
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 12:45:10 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xA92p-0002ik-Qz
 for qemu-devel@nongnu.org; Fri, 25 Sep 2026 12:45:09 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68PG0qtF2124650
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 16:45:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 bgJdNVPNIXz6/6vxBeeY4FT3sU03eEKOOlaTO1KM3FM=; b=Ulo28Oa/2M/OOfw9
 IIqgQg+nobn8GvTGvXdBUZkkRjKheS3R8A6tYZ9WO6YbUWHMkbF8KWknljjFQS3k
 +tRpdZTnmZwQwWDmVDLWyT20khr9XB4vlJg4O2f+Q0LUY6dp2JS6vxEdYRoFaUmQ
 hcJ6B4fq8NtKajQYoN8BHfS+kUibPAe/V6RP6/CWc7zCmlTGW69EmA/GMtjn0Azk
 OzsdbKthX2Cr4SxiqAW3wfE6U8tvsS3G9/LZYnknxHnd+/DPTWbn3rp1D0grrBXK
 UOudByywPnoIJvsmUoHgrv56826qU1/bPOPoslFXFZmoLbtIAwO22NAzM6RZZWt+
 FfFiGQ==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gwjq0a9gc-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 16:45:05 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93a0b66ecd9so166361185a.2
 for <qemu-devel@nongnu.org>; Fri, 25 Sep 2026 09:45:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790354704; x=1790959504; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=bgJdNVPNIXz6/6vxBeeY4FT3sU03eEKOOlaTO1KM3FM=;
 b=aBk/Z8PFvynBQtjfazW3VkaBRTtYE7cNRGbuwo+hDQWn3bd0ZIY6RLI8iSPk5ps8qw
 0pFblEAZXecbJen6HW+Q6NjSanlvZpheoemgbaCrB4PBSJ1YDjYI3iEs6zP+wBrUI3K1
 el2ZAoLH+dtETk8zb8DY8C+Vh/DjVWp+81qsKaGpm8C+s7kf7Frxdcuvrert3teLEgaK
 XACNWPXkzaa80tWdG74qYuNk+r/f9iL+kAUz+dEc1GRkXUUfxWRW0ZQPH6CB3CBc8fL4
 WlI9tn4h8jeQYsQpCZGF1n3+SRWlxHkTVV+T15gW73FDIj9TCRbGTCuX2eqTPs5BJd4R
 HLZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790354704; x=1790959504;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=bgJdNVPNIXz6/6vxBeeY4FT3sU03eEKOOlaTO1KM3FM=;
 b=LMDEaB6xcHOdLo6nhF8ydzrViB/AfVQ6ZOKi8icdjExmWeWOTVgaw1KkEFowTBfLv0
 GIGl/uRjgmGKVv+6GrganMwIZ1CdDs+uVgJA/h8VsCrM9jy3fKK7GL7wkYT5KV6LbJfQ
 MLWfdMPWH7XIr6FJ28EOlYrtolbXckiqvubGOSvyF24zxH4GJlCcmgBJwMhSpU8kTEGx
 Up4viBYW7NEB2d00OuB61hf361UrsNY+YPdKdT4qnGyAbS4fYdPtM1ZDpgkzQGZl5CdP
 EN4rXKThgjM3Ru7P2z50ZnvrtwUJ5GwGdWLbBoFXd8ApK+jXOMyEnKKJ1JtRGpmvfh+l
 zQZA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxFuWgN7oFYlk3BmfXYfPferQC5nVxxiVWcMEf0OBmaq7JuJqm/mdjNFkeCv8JEeq44Pvxt3EC2rWqt@nongnu.org
X-Gm-Message-State: AFuF++lF/RjoW1QaGyLH44pea1/z7OluTgg8QH/e7RAwch/mUj5wJX9Y
 i1ufYrXyDhfQgW4F+6uA9LgqWVCk0YN6+BDrVNwy144Tvg3Kr/p12fzWjwYsPcLkXAf2/qFMh/B
 sRJrvpeWyGmnSozJDZ4r1iRFKFCM8e0onyCzWqH86Yj2OyAGPex7uDtErNw==
X-Gm-Gg: AYBFou0hTug46FnOUNjpsnB9/effpjIwzxvxMAvQ3HdRp11D8SnrAfNRUQMUOwOyIra
 kWtuCVcKK1qWeN+sUEpkl/sF0Bxjb2FSKSEfiFbw27qLtaH55j3FLZY6bPSnkIn9EdgVPEcUDVX
 j27Y3FR20q7vGsK36SDIyUo/jPqwTQisXRppS5noBbXBNr91LC+pqz162PbK18wiUiLpkrZ+csK
 EdvaTIRrRrRKNxlAvqhE7H+QNBox+YID1cQg7+J4mP6xi5T3ywO33eUGXlCPHT9YRXi1q14gpP3
 1+JPSnf4lfu5VFzzq/MK5BW3kSEz8vKcTwgDNO+QjCRTptw1poZAhyxg58HanZ6tg3+1B36y/P/
 nZZ9FC5alBiKSpwQjXgzxWeuzZcYvzKtuOw==
X-Received: by 2002:a05:620a:8389:b0:939:f8e9:5e19 with SMTP id
 af79cd13be357-93c43c2f3ecmr558821885a.1.1790354704441; 
 Fri, 25 Sep 2026 09:45:04 -0700 (PDT)
X-Received: by 2002:a05:620a:8389:b0:939:f8e9:5e19 with SMTP id
 af79cd13be357-93c43c2f3ecmr558815285a.1.1790354703938; 
 Fri, 25 Sep 2026 09:45:03 -0700 (PDT)
Received: from [192.168.68.102] ([177.94.15.187])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93c44421508sm223090785a.0.2026.09.25.09.45.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Sep 2026 09:45:03 -0700 (PDT)
Message-ID: <ba8f5a00-1da4-4f09-a45f-6666ae0d73fe@oss.qualcomm.com>
Date: Fri, 25 Sep 2026 13:45:00 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/14] target/riscv: Clear virtualization mode on reset
To: TANG Tiancheng <lyndra@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: Zephyr Li <fritchleybohrer@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu@processmission.com>, qemu-riscv@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
References: <20260910-riscv-pmu-correctness-v2-0-5da5159a0c64@linux.alibaba.com>
 <20260910-riscv-pmu-correctness-v2-13-5da5159a0c64@linux.alibaba.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260910-riscv-pmu-correctness-v2-13-5da5159a0c64@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI1MDA2NiBTYWx0ZWRfX4BrVd3khSIRt
 UjEIGq0ElzCZ5M/8usEx2R8Jn4/tO+uI3B9kzZpXQvLsDAUxX+zD7rRX21Iz89hrvntePc2h24G
 AdUEdPgTiUxIyCIPm9obfm+yN+kR+/A=
X-Proofpoint-GUID: AV-2MUUfML8dpihy0WrN-cUxt-BV7j2t
X-Proofpoint-ORIG-GUID: AV-2MUUfML8dpihy0WrN-cUxt-BV7j2t
X-Authority-Analysis: v=2.4 cv=LNPz05W9 c=1 sm=1 tr=0 ts=6ab6a511 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=0kFmPUMe/4ewoYCJjrGTNA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=SRrdq9N9AAAA:8 a=EUspDBNiAAAA:8 a=qWS3GbcsPDoVOp1RmmoA:9 a=QEXdDO2ut3YA:10
 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI1MDA2NiBTYWx0ZWRfX7aCmMeSTYy8h
 wlJ055HIRpYsBzDJz4jVvvO44nfVY9UTArkOd51F5jfyym5S+qTJ0WwD2UebiUN2brGLmXoSZ0E
 SkZohwJnrIUdre25Tb8mPIlwewIJdkVdv1o5crEyqstkELdguwZqXCKij5oFy+ZhhS0CopYjO9M
 ipi6gOiEvaCF1U2tbm7Kw5C8ZIvWLgZTaC3l7QECWf49NylomnS83Rm1koA10tTASk40y9F1Udl
 bGsgZlsLGt+IdHRsuJzxiJwW/h4RHhvSc2OrDMqTBr+gGehZUkObwzwpcQPtxeD6IA+3r1ef+5O
 ER9VzCARmrCXnBmXrmBfpIOLU/r+mg/+ElKRyfeIGak/FnLQZnl7cl/uboLEYrvVz/gtatHox5Y
 8VvOSG7iRHBD4GXZvFKe4l7/q87O6KmDUxFjRi8x9Oq+xjRkGyk/xAsugnXBmI4MfpcpZfP6DYn
 5uqvjcg1dQlVgh5iFKw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-25_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 adultscore=0 priorityscore=1501 clxscore=1015 bulkscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609250066
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 9/10/2026 11:39 AM, TANG Tiancheng wrote:
> Reset enters M-mode without clearing virt_enabled, leaving an invalid
> M-mode, V=1 state after a reset from virtual mode. Clear virt_enabled
> alongside the privilege reset.
> 

This one is quite old.

Fixes: dc5bd18fa5 ("RISC-V CPU Core Definition")



> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>



>   target/riscv/cpu.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 5fff9d745e9b36d9cbd30f166ec91b5165e5f497..f60d7cca1e2f0008b09b1055c5cdeed3ec4ad1d3 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -980,6 +980,7 @@ static void riscv_cpu_reset_hold(Object *obj, ResetType type)
>   #ifndef CONFIG_USER_ONLY
>       env->misa_mxl = mcc->def->misa_mxl_max;
>       env->priv = PRV_M;
> +    env->virt_enabled = false;
>       env->mstatus &= ~(MSTATUS_MIE | MSTATUS_MPRV);
>       if (env->misa_mxl > MXL_RV32) {
>           /*
> 


