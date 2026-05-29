Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD0E8CD4F54
	for <qemu-devel@archiver.kernel.org>; Fri, 29 May 2026 13:04:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wSwt0-0006y4-Sd; Fri, 29 May 2026 09:04:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wSwsx-0006wO-PB
 for qemu-devel@nongnu.org; Fri, 29 May 2026 09:04:23 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wSwsw-0001SE-A7
 for qemu-devel@nongnu.org; Fri, 29 May 2026 09:04:23 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64T7G7l71829461
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 13:04:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 sOJN/2ghV06s4eA2fKXwh+hFAUNvo7YOjP82Ff9YpYo=; b=bB/kTwd3fjlZaiG9
 Jsts5l8BRMP3i9EQ9O8K4XyiUgiYl4LvrljwuZtFfBX1Oz+wREh1a3CNiDH0Fy5l
 QPxqfhxZKmE5Z7ZiBnqqq5K9j3tfiCUgmgKhw0fnzdFaRvhb0UK7o7oL/s1aI0l3
 Up0ZPKnXclSAY9yNQv49pEXPM7z1oaTjRMLXoVbbJ2PdMjO2kyvSO4gqIIeZeng4
 olysJuh5kmmjh1uRrVZTFMru3cdH35d7aPg8K9S1YSOrukWo+wD18mgiXBeUhDWh
 ZYyuG/josCaEtf3hdiendFo8lACd2ISH4koh+R5MArWBGp45BfFGBZ33fdUFLt15
 nowBNA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eex6m3c9b-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 13:04:20 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304ea1eea05so2071058eec.0
 for <qemu-devel@nongnu.org>; Fri, 29 May 2026 06:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780059859; x=1780664659; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sOJN/2ghV06s4eA2fKXwh+hFAUNvo7YOjP82Ff9YpYo=;
 b=NvF14KcGLl4uEpTNSFN68CW+o1/vTrBQSxc+BOlbNC3DaPDcAfzS3NzYge9Tqqe2Li
 uJhMhZv5/v/4lJFE1IyFxcQnsu3uvd8tuUlyzmxGO0iZa30k5epd2aCw+vaVr8txUzqW
 tiMFtndA53a7cN3KsXsas1VATh/zO/rgo3jFJ3CCqNK9sJsHqgrwFHoNm6xHbpnrYoow
 Kil5qd5riO8JaTByeYGAy0X5BrUlXG0xxEGA16K4VFoJiQifi3ttL1qW4UhP1Wgzv4ld
 d7IQ4X7Zhqoiz3c6Ew0nT4IxJ04cy3TzcUbfuSIk+9u6APupmWK4mk6k6x3AHMFBhVRR
 RZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780059859; x=1780664659;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sOJN/2ghV06s4eA2fKXwh+hFAUNvo7YOjP82Ff9YpYo=;
 b=msGAZmPfxzvsCPQ0yJRlUrMWMmjwzxq4vYLnNCCtRpbuF0ykUp6KqjjdojxCV8wQwy
 Y+4DIFNpNsP4T1DmwM/orM2MZd6hP4LGM9V22pXSA90GyaD06FCCsShnBa9OTp9w0C4e
 Ki5PAVTytZS1aFcbJcPVtmxrTMXesDkNHSpUCW6WZ7HX/YSFRwva6wy6F8hIabN4A9kp
 LQ6H+Gm37fPhC+zGUbeXfFBXJNzcQ34Fxc29IUgFjpSmuwMOfDH6oLGWomN5UD6C6r04
 q+OodQSRGM8jj5T+FXQQmE+BTG/EMPXuKFJ/HT2ZBi4JLgSthxbpl9ex6NIHrsiBZHtM
 dhlQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9etL3WF7Lw1O0ryzwllcntdoIgqbmxn0WdNUbkMXOBBRR3TYd19kXdaHuFKTwtoROVs5GRaROWPpfL@nongnu.org
X-Gm-Message-State: AOJu0YxMmMbOdlQWYWcoGUvzn8ids6a3QNCQVC8eybQ3rPYJU4KPklAa
 Hb5COrLH3A6Yk/AWQfQ9Y2+FHslIAM2AWmGDaG3C3A+BGePoTf9UZvPOjvgsQmqnmFhcyMUvq9l
 4qOFtxBE1Y8Tz41hdtD6NP6m+g/YkigmPcIjfGT6kpiXdTSWTzgj4r5YrMQ==
X-Gm-Gg: Acq92OF5GweVQPQIx2qLeUlvWFrpdKUehODYC3Lx5VGWrhzGXzTKNH7glRfWbe5lzHv
 J6LSD8GdOAK484oJ+k32BvHOgk/mawhcMJrsACl+baPn4UVYUWieG2tYHBprAZ6yrrKw6SETj3T
 amQ0F7I2eoZCQxd8RhxHBNLGru5d6qovyXK+TX5MNOdjzEov6VNZFr4rnWItsRTck3elV7ZuAcV
 eImYSFQowLSGQYKsQu1DwOBtkebVDAzktMBug74zfpg7jS4EuuFr28K4OVutvsBtGF3QPvflUU9
 MY7IhcrCthrffUzhy+zPzOzZXFQNmPt2fXU4BtK21iyqVL5Ue3snArTCc0G7pQ8uY/bUhvP0Nst
 UD7KpBb6fwaxiyLDBv246VhYsafEqiLeQ+RI1UXYn23rRY8XVR9ehVMPWZvAj/kp6wnAY
X-Received: by 2002:a05:7300:cb11:b0:2de:c5ca:c1f3 with SMTP id
 5a478bee46e88-304eb105720mr1285060eec.4.1780059858790; 
 Fri, 29 May 2026 06:04:18 -0700 (PDT)
X-Received: by 2002:a05:7300:cb11:b0:2de:c5ca:c1f3 with SMTP id
 5a478bee46e88-304eb105720mr1284999eec.4.1780059858087; 
 Fri, 29 May 2026 06:04:18 -0700 (PDT)
Received: from [192.168.68.106] ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5f6426sm1306978eec.31.2026.05.29.06.04.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 May 2026 06:04:17 -0700 (PDT)
Message-ID: <346d051e-5cb4-4238-b32c-1d2b85e02e08@oss.qualcomm.com>
Date: Fri, 29 May 2026 10:04:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] target/riscv: Print privilege level and ELP in
 riscv_cpu_dump_state
To: Anton Blanchard <antonb@tenstorrent.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com
References: <20260529053519.1224019-1-antonb@tenstorrent.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260529053519.1224019-1-antonb@tenstorrent.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTI5MDEzMCBTYWx0ZWRfX9DYqSCIbYaA0
 kIAl6uPdM5GzZGGpLg+//Q4vDNR6csHTAW46bZ6m1Ee8ppPojlEY8xrS7w/ozeLo090tAaXStd1
 LjzDL3nrsxl6WIziJoucnskB2aUBni/CEm+hMpN9ucFQw7/1r3j95Gz/m19kqXFo8kBERM7yPfe
 dlr9l4pARAa+7WxtVHI2R+CRtexr3ngxN+98Z7V/dSlMecTkGcOq2K79A7bgqjJoSZXKGXL6bfq
 0rk3uCABoZGdqG8VdSwpHV0ps4A5C2CPtTL6EwLtEPUMCaw3ThY7kNcjo58zSZHET7yoiO/eJ9I
 oLzZkPEYIMNRa7HTiY41n8sMjUjMJMDw2wfEGHvt65oGJ4ti/rMxAzfN42yW6TJLx6KuYB8JM3e
 IuaKWiqAdEsnl37eN1nV71j3JH/WIvMd5rZNVj9lmz8qa1sK3F4FaLiWWDWG+kyYf06fNll0DgL
 PWCvOMOWNcdYQ+kFnvQ==
X-Authority-Analysis: v=2.4 cv=frnsol4f c=1 sm=1 tr=0 ts=6a198ed4 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=t9496tuAAAAA:8 a=EUspDBNiAAAA:8 a=NBj_7myW6Vghhd7hPxYA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=4wQ91nGE5lQcD7eh5OX0:22
X-Proofpoint-GUID: ed8u6Zr1oqyeHlLKqfP2TVUhI_0ocsp5
X-Proofpoint-ORIG-GUID: ed8u6Zr1oqyeHlLKqfP2TVUhI_0ocsp5
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-05-29_03,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 suspectscore=0 adultscore=0 clxscore=1015
 malwarescore=0 impostorscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2605290130
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



On 5/29/2026 2:35 AM, Anton Blanchard wrote:
> The privilege level and ELP are implicit state (like virt), so print them
> out.
> 
> Signed-off-by: Anton Blanchard <antonb@tenstorrent.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/cpu.c | 22 ++++++++++++++++++++++
>   1 file changed, 22 insertions(+)
> 
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 952e34fdf5..b38ddc39ea 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -580,6 +580,22 @@ static void riscv_dump_csr(CPURISCVState *env, int csrno, FILE *f)
>       }
>   }
>   
> +#if !defined(CONFIG_USER_ONLY)
> +static const char *riscv_priv_str(uint32_t priv)
> +{
> +    switch (priv) {
> +    case PRV_M:
> +        return "M";
> +    case PRV_S:
> +        return "S";
> +    case PRV_U:
> +        return "U";
> +    }
> +
> +    return "?";
> +}
> +#endif
> +
>   static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>   {
>       RISCVCPU *cpu = RISCV_CPU(cs);
> @@ -588,9 +604,15 @@ static void riscv_cpu_dump_state(CPUState *cs, FILE *f, int flags)
>       uint8_t *p;
>   
>   #if !defined(CONFIG_USER_ONLY)
> +    qemu_fprintf(f, " %s %s\n", "priv   =  ", riscv_priv_str(env->priv));
> +
>       if (riscv_has_ext(env, RVH)) {
>           qemu_fprintf(f, " %s %d\n", "V      =  ", env->virt_enabled);
>       }
> +
> +    if (cpu->cfg.ext_zicfilp) {
> +        qemu_fprintf(f, " %s %d\n", "elp    =  ", env->elp);
> +    }
>   #endif
>       qemu_fprintf(f, " %s %" PRIx64 "\n", "pc      ", env->pc);
>   #ifndef CONFIG_USER_ONLY


