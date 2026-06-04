Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93352CD6E4A
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jun 2026 12:53:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wV7Z8-00070p-AF; Thu, 04 Jun 2026 08:52:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wV7Z6-00070G-Ht
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 08:52:52 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wV7Z4-0007Q2-T4
 for qemu-devel@nongnu.org; Thu, 04 Jun 2026 08:52:52 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 654AtrNj1993447
 for <qemu-devel@nongnu.org>; Thu, 4 Jun 2026 12:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RHSax5UFAUyZI+zLD8jSqNO8OzUSv2Jmi21RwZt2Bmw=; b=HCRQXLOO9L0rc74p
 GL/tR75jJ5OQkeU7LKQrW2rxf4Sndh8xspZxHdU4AHHBsRaKYsvlskxZGs4dEGdp
 s4SOSCeIMf9cRv/jYWIx2/1yeI3NTeRsZwaTuf0E2VGrhU2riCkMYPwLHTasvzDW
 SkBoqB0qrqvaMp938HD8c9ZvvESRholzvJqwtsc4EuISI0mWzGUj1OcqgkMOeuDm
 P75Z0CVYQfDsDiuLcWy/kAkjS/Ber2ROMV1xfFVEFANXdjBMvJ1empWyj2XlKio0
 l0d9xhPFoglvmLD0o1K3vEJltEMzlEKKDHg7dF639PpL+WQobfBMbcnHJHqb6rjN
 Rh7a6Q==
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ejs8pur1w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 12:52:48 +0000 (GMT)
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-7e9bb6a1d11so10997097b3.2
 for <qemu-devel@nongnu.org>; Thu, 04 Jun 2026 05:52:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780577568; x=1781182368; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RHSax5UFAUyZI+zLD8jSqNO8OzUSv2Jmi21RwZt2Bmw=;
 b=JPcP++iCqUdori+aci/pMyCftoetb+bcRnuYx2o9nU/yxr8h+omA5vlZxZuqqIR4Ri
 PmPtRVzeE7O/DdSZqOEosuQCXkfkYxAzEdphBLNhWAKWOY8IllZ+ZVi6JDk2leStsROA
 mPr1U1ts/VQGMWQyQzSAHP8RltOqSGWEbEQpkh1Pob9dDoj1oqIEcZEvRMFfK6LCkZof
 L1o9ya3Co1fi9m8tUiMgiF5F4Sd+7RolziZFBvcaWTCGofvSzXOiMwbQ0sOKAfOY0E8T
 PAIYzgQwMlczsOWns32lfRgpyXwfHg5H4gUbEChaEUCa1uGYTUiCUusocoNIU2pmOYVK
 3MAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780577568; x=1781182368;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RHSax5UFAUyZI+zLD8jSqNO8OzUSv2Jmi21RwZt2Bmw=;
 b=dQK4wgOOyz35FyP67ADvDGJ2zSvpCEMJAvR2gwY7gEmGi3jX6cVdshfGIzXe3VuQUU
 cnUdIQ9jrvv6A4UuaUL9OJGgNl3IEbjxPHHy1+BMnt+B4kL1NVbfgEtP4/bmdHQTbNc1
 Ia9zmycdUddCeRWl1WL9eXRolti+t7ak4D+AHLhjZpOiEhkFAMjhoQMZ6gYjD3n+A8TV
 wPJ2cU+YKZ4bYTZr9QKZIGydusmHVUYQRsyMmj6caNtg3S8EZ0N/KB866i2M7CyH9IoS
 nxV2igs7gerO4X6UczArPvbLuaFU8v7ZgiApRHwq5c0hxBSqPDLvhaUadGMspib0OEzm
 fT4w==
X-Forwarded-Encrypted: i=1;
 AFNElJ/MaFFT9CcdYw2VCOhJKY3RGeOywFkdTNg4gsD407CPfcNsLdhAo3goA39dVzIwZ5f7iGneUS6FSkna@nongnu.org
X-Gm-Message-State: AOJu0Yw/e+GBP3sC6hex+ySth7lbtRPvvj01fWXoxZcJnEFKdjRYmoBP
 h15LlBkXXY7PtJjlg8CmuNfqhAF+iKuja/WZV2Q/ID6gvgGiN+8HEIbqCbnxaT8UMKlIUCQenbz
 OiWQyuQxutcL6cDKD5EH947X5pBiXnLOz0O7T9r6LGUcPuXz7udShXAmncA==
X-Gm-Gg: Acq92OEooQo09Bj8AT8BzyzyLYKJBvXwrxkaaa3HmY0iPOW+nyzWlXniiD6vuiStrNr
 ovJYZpZEOd8FjiShrq2mf1xZipjzBzuhlFUtn8/RamPCOIOvc2hVxyYF6HdRnT9Idw8C60mF8mV
 91NuEarXIZoEiQRmw68wMl5vdKbu3GshaBmr0MQpOMYPeI839i20m+lR6TI1p9NFbXWbX503MF+
 m56Ui/EJGEJ8B/HKJpzzSQ1TRm2yKbz3vpcRu5gpxMPyZtvEIlK63xv3yagu7hkN8r+426Cjkup
 ybsdxN3iyh4QxrQ6feMOJZipkpx44FP6YUwcwxVjKXWQYCczTGqZ0gtWbuJEMQiJ+OXrGHjXS9A
 hhzotJrnGMNAf/XuojgRdWEykDjmVpkMPrcQk5dk/z8uQ2T/iFfw4VshiEnaWJ6KJlU+H
X-Received: by 2002:a05:690c:64c1:b0:7d1:dd7b:b71f with SMTP id
 00721157ae682-7ea4987b86cmr76104077b3.29.1780577568410; 
 Thu, 04 Jun 2026 05:52:48 -0700 (PDT)
X-Received: by 2002:a05:690c:64c1:b0:7d1:dd7b:b71f with SMTP id
 00721157ae682-7ea4987b86cmr76103837b3.29.1780577567971; 
 Thu, 04 Jun 2026 05:52:47 -0700 (PDT)
Received: from [192.168.68.106] ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-7ea215825dfsm32973487b3.15.2026.06.04.05.52.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jun 2026 05:52:47 -0700 (PDT)
Message-ID: <64de69a4-aedc-42b7-a0ac-e9f8cdc8d63a@oss.qualcomm.com>
Date: Thu, 4 Jun 2026 09:52:41 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 14/25] target/riscv/debug: Move debug CPU post_load
 details into debug.c
To: Nicholas Piggin <npiggin@gmail.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li
 <liwei1518@gmail.com>, Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, bin.meng@windriver.com,
 vivahavey@gmail.com, Alvin Chang <alvinga@andestech.com>,
 Yu-Ming Chang <yumin686@andestech.com>, Joel Stanley <joel@jms.id.au>
References: <20260114044701.1173347-1-npiggin@gmail.com>
 <20260114044701.1173347-15-npiggin@gmail.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260114044701.1173347-15-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: MayLhHCUMve4S4jId3JiYeV2FIWRpjlu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA0MDEyNCBTYWx0ZWRfXwe4E1qzu3f1J
 umegmnr+uNqXfXnFwx65sTVTvevIyqtr92onnD12m7ZRZCF4CmO/M8jznCjd8NmkUwOh4MHtqDI
 Fvvhm/dqjLtoBGM0TPQOr6arqrA6610VOP6JiabrPx9LdX8UuBs6NYfns7dB88CFdToZSxs920P
 up1k2LzV+htdejYXzTIS2aGcAWk2NmEEdmjqJTuUMq4TCqd8/x5+l9W57/eyW6PlIRp6Ki4lkCp
 oKkEjdvzZJ3LsHZm2Wb94awpjJZXzYk1Mg1pQ9m3sSJOK5YACnApaCOVUCPL/QJCfU8gfQ+aVb8
 lOb8iezu79PTGXlGt69yuMQNej2l+81L9Uq+DSkWJS8stts9p4ssq8Lf9Xk4PfDyyGgINui0vS5
 ugTjrjFySuIcs+jyqrdv0iRVZ0wsGCheCJ8pmfM5nUkyIs+REldNvJsK542sWk7r50pozpnYA3p
 Wm5VL14HXwbAK0LwrYg==
X-Authority-Analysis: v=2.4 cv=E779Y6dl c=1 sm=1 tr=0 ts=6a217520 cx=c_pps
 a=72HoHk1woDtn7btP4rdmlg==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=MrAWP6gwjXxYpVIVeN4A:9 a=QEXdDO2ut3YA:10
 a=kA6IBgd4cpdPkAWqgNAz:22
X-Proofpoint-GUID: MayLhHCUMve4S4jId3JiYeV2FIWRpjlu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-04_04,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 lowpriorityscore=0 adultscore=0 impostorscore=0 malwarescore=0
 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606040124
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org



On 1/14/2026 1:46 AM, Nicholas Piggin wrote:
> No need for machine.c to know internals of how debug.c maintains debug
> state.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---

Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>

>   target/riscv/debug.c   | 9 ++++++++-
>   target/riscv/debug.h   | 2 +-
>   target/riscv/machine.c | 4 +---
>   3 files changed, 10 insertions(+), 5 deletions(-)
> 
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index 973de3b2e2..24161fd46b 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -673,7 +673,7 @@ static bool check_itrigger_priv(CPURISCVState *env, int index)
>       return icount_priv_match(env, index);
>   }
>   
> -bool riscv_itrigger_enabled(CPURISCVState *env)
> +static bool riscv_itrigger_enabled(CPURISCVState *env)
>   {
>       int count;
>   
> @@ -1124,6 +1124,13 @@ void riscv_cpu_debug_change_priv(CPURISCVState *env)
>       }
>   }
>   
> +void riscv_cpu_debug_post_load(CPURISCVState *env)
> +{
> +    if (!icount_enabled()) {
> +        env->itrigger_enabled = riscv_itrigger_enabled(env);
> +    }
> +}
> +
>   void riscv_trigger_reset_hold(CPURISCVState *env)
>   {
>       target_ulong tdata1 = build_tdata1(env, TRIGGER_TYPE_AD_MATCH, 0, 0);
> diff --git a/target/riscv/debug.h b/target/riscv/debug.h
> index 5a14b7894e..400c023943 100644
> --- a/target/riscv/debug.h
> +++ b/target/riscv/debug.h
> @@ -151,9 +151,9 @@ bool riscv_cpu_debug_check_watchpoint(CPUState *cs, CPUWatchpoint *wp);
>   void riscv_trigger_realize(CPURISCVState *env);
>   void riscv_trigger_reset_hold(CPURISCVState *env);
>   
> -bool riscv_itrigger_enabled(CPURISCVState *env);
>   void riscv_itrigger_update_priv(CPURISCVState *env);
>   
>   void riscv_cpu_debug_change_priv(CPURISCVState *env);
> +void riscv_cpu_debug_post_load(CPURISCVState *env);
>   
>   #endif /* RISCV_DEBUG_H */
> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 34fd73c920..bee1445a31 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -230,9 +230,7 @@ static int debug_post_load(void *opaque, int version_id)
>       RISCVCPU *cpu = opaque;
>       CPURISCVState *env = &cpu->env;
>   
> -    if (!icount_enabled()) {
> -        env->itrigger_enabled = riscv_itrigger_enabled(env);
> -    }
> +    riscv_cpu_debug_post_load(env);
>   
>       return 0;
>   }


