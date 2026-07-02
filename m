Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 288C3C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 12:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfGyS-0003U0-28; Thu, 02 Jul 2026 08:57:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfGyQ-0003Tq-QN
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 08:56:58 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wfGyP-0000w1-6h
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 08:56:58 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 662CkDl4488887
 for <qemu-devel@nongnu.org>; Thu, 2 Jul 2026 12:56:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 AdHqx1113yGH3DgtfedW7K1bCbn1zrzmit9owUVmKb8=; b=YMFLbUxZ28gVtLKP
 glwnpGy3ae12Rr/EvSDhLCWUBPxze5mZChfo98MqXiH9xl8TG5kV1v9riiiwOXa5
 6EYqAXZSyb+YqqvjHTktCOMIl652cGsB0XV6CrktP5K3INS2t5zR71mK4sSsMzfK
 WMAED3ijTLJ3AglNUbB/DrVZJ3o5OEgqzqHhlxe+2gmWLoiQdIDDmZT8IiksdWkm
 BwPIADAKV4NhmxjKovIaMRpeXW60qlqW+zW5unPOsB6prMn9dqdDPakU74KzK3c/
 +Yh8EEfLn5axJPsGNwkbZ5Mpuuihqq7h1wnCg1CB+3cGn4Ej3iUCdDNTxNCQ45dl
 YARf+A==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f5knc19ac-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 12:56:55 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e663c29f2so73782885a.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 05:56:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1782997015; x=1783601815; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AdHqx1113yGH3DgtfedW7K1bCbn1zrzmit9owUVmKb8=;
 b=hCoxZXQ7xLrbe4iijdlGs9Ny1RyfQJXx7AVUg13OTjiTAC9MI79qH5iuGw5dpDs9ib
 SRTUX5LeBBmpRXq34jlU7ZDhFcSdU3fcMQDMzpZoULref/2okXA/abk2CeU7sKMuxbEh
 NHRtxmJGY1A4TDB2rWwu8fNnUHb1lHu27XOWAl67/9PEbY50ghpvGNM5TyjZg1oT+pmR
 Qv/+T0LgLhwJ0rHb5WQNbnjde9lAglTpKBPHkUJGmWC+iIhwTjOUJX89f9DJ8Ee8UkXR
 dtoLt7R9cl2Fbne1AyYjHFGusrJg9XgaLDCImo4ywLXcai6fDG9l44fRy8pr50vwaEWS
 Ez2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782997015; x=1783601815;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AdHqx1113yGH3DgtfedW7K1bCbn1zrzmit9owUVmKb8=;
 b=aR/zVCq+403cor7R7bFvbZWt3Y5dgFn9Zvafd6+XoT17UDPITkNDTili0gbMhoJJ7e
 6U2lCg0ZK4o+f4khDnsPyjfwmRI/JReQCeK8+J+JA1DMjg08YZpThqewW6oFvcLMf32E
 r0LozUEM+G2nOSKo2tXtVHVvyYrfYMWi4pcyJ9qM9ToP2ANuGH4yz8bfh6bp2fTqTqtq
 c/qeP/cq5ZMJwUxP1221pFOcaPVRzih8g37rnH+FV4V5ro8bTHluYjIw5C2V+6l6AwVT
 zyHeGqXLMxPe8UT3eFYUE2jnHsBAac9wXx3o6/AK6beTy8ZhdR4xokAgSjWTUHs1ya9o
 L+eg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/LIQNI3F5RQfBeEbtTg8KBo1Dr+A+Wh5VSkuMrjuh4wmVhFWXMurY0NUvJFQoe6+/iLLt1CRVmMte2@nongnu.org
X-Gm-Message-State: AOJu0Yz1zjR0GsB0cVXknexqTuhfSlxWKg3X3c4gLTnsg4A3pFDkwaR1
 NfUV4Be6oXFGeDbeS3HOFeKitiCLcjkiYlItfDJCFTdJnhRdSBem5Lnf53l+4iTTsVOrZImM5Ga
 9IukCksvsOj3Ix0AxKWkkI9SXvy5FhhQg9MfAlu1BBWL9Zn3xS1ZEjhKZww==
X-Gm-Gg: AfdE7clFT5rxuk4gNCD3bNT0BGOU+Ui8eVwGd8DblQ3siu1U71OUAOHf8NJuOaXR0Iy
 YdJDXqTMc1m9iD+wCRKs3zR+PNvJ6lHFtBSZAD9yyMiq++kZhBmdu/+WmEo04M/KOvUHZd77soh
 OK4PmcPBXyECSOxWtLz9eTGbR3eFi0yNMQXGJk8n3KPqITqBFDOaDw608j2zBgeW2ibgbkVamKU
 GM61sEB/AurOu9UMaWihapt4d+yCMYl6NXmsZLSlH7JGuVVbXs2Na7tITRE1kzYJLPhWzKrMjqd
 LVoAil/XT9/IOFGvtxk48IteolvcwFMpfvh6Ehm32cgYW3rZ7qypHVKtCP++7oBI4/h7LRngJrr
 SJeNnMv5TS5oOlQWYqTWxBjIIcc7GLg4uE2uMgAgqbSXcHZJ5KdFMfo6FAQ29Vg==
X-Received: by 2002:a05:620a:890c:b0:92e:65d0:1cc7 with SMTP id
 af79cd13be357-92e697cc3fcmr1328466585a.28.1782997014628; 
 Thu, 02 Jul 2026 05:56:54 -0700 (PDT)
X-Received: by 2002:a05:620a:890c:b0:92e:65d0:1cc7 with SMTP id
 af79cd13be357-92e697cc3fcmr1328463085a.28.1782997014166; 
 Thu, 02 Jul 2026 05:56:54 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493bef23feasm107333975e9.2.2026.07.02.05.56.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jul 2026 05:56:52 -0700 (PDT)
Message-ID: <2a13fcae-779a-4596-bd2d-c5cd7cf8ad1f@oss.qualcomm.com>
Date: Thu, 2 Jul 2026 14:56:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/2] hw/uefi: disable debug function
Content-Language: en-US
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org
References: <20260702092349.4183512-1-kraxel@redhat.com>
 <20260702092349.4183512-3-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260702092349.4183512-3-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: K-WxbHjPBSep4WnMJ2ys7IHzfDYs3wYP
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a466017 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=wkumObNaO7LzE2vtsRMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAyMDEzNSBTYWx0ZWRfXzOCKqurOFpd9
 75f0hq+HLOwDpKfE1Ev2uFj17coDxRvhd4u0r8PfbHVBfjImjJDUpcZlZ3wnarzWhhzM7S1p8tz
 2ZVWFR/pqOk91hE09NeQCPEoLEqxHw/v1FpYntysgJdmhs3L7i9j3GErXuA6giWOLkq/AnV10e9
 QRjEdUzYV1lSbtrD62IxY5b1lCh7sTE8T4KGcH2YhPy1aORfBd3ak6X7M7g+CyLDXyyqgEehsBI
 8TPgdftWCqbPCsmKDhuc2uxV4c5qppuqmtfBB6Qt5LtAsfPt5t884ghi8XcNhFUZqBvYX2Z5pHS
 2wjIKF5o5CpfRU80st8rBKLCyl8eEjf2kXs5l2nsBjFAxpmzSCHWmM49zrwaIiIp0g463zR2sGe
 Wmx8kIIgauyRWXIwgovqQMsGpplJTtNkYugrzUpt6PZR54MJ7/7XbU3FPpklmLXJ+O2YKeRWC+j
 gcsM77VJBCjoTDRNvTA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAyMDEzNSBTYWx0ZWRfXyG83tykrxv4l
 LjiGCEvGalHvbbb0m9GUvcBmos7QVM32JymCsxb07sdJyvYoh7KGSWiS6Iyhnl4QxLCU/wWYYc5
 pNEECOsfDW6VJ05mo5aNExO8H2UNrfE=
X-Proofpoint-GUID: K-WxbHjPBSep4WnMJ2ys7IHzfDYs3wYP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-02_01,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 suspectscore=0 priorityscore=1501 bulkscore=0 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607020135
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Hi Gerd,

On 2/7/26 11:23, Gerd Hoffmann wrote:
> This was never meant to be active in production builds.  It's a code
> path not hit on a normal boot (OVMF wouldn't try variable updates which
> are not allowed), so this went unnoticed.
> 
> Wrap the call into "if (VARIABLE_POLICY_DEBUG)" so it is never used
> unless the #define is changed to true.
> 
> Also fix the name printing to not overrun the entry size.
> 
> Fixes: CVE-2026-58582
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3615
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   hw/uefi/var-service-policy.c | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/uefi/var-service-policy.c b/hw/uefi/var-service-policy.c
> index 989bf87ddb86..b56fc62f7092 100644
> --- a/hw/uefi/var-service-policy.c
> +++ b/hw/uefi/var-service-policy.c
> @@ -16,6 +16,8 @@
>   
>   #include "trace.h"
>   
> +#define VARIABLE_POLICY_DEBUG 0

To avoid this anti-pattern, ...

>   static void calc_policy(uefi_var_policy *pol);
>   
>   static int uefi_var_policy_post_load(void *opaque, int version_id)
> @@ -40,11 +42,12 @@ const VMStateDescription vmstate_uefi_var_policy = {
>   static void print_policy_entry(variable_policy_entry *pe)
>   {
>       uint16_t *name = (void *)pe + pe->offset_to_name;
> +    uint16_t *end = (void *)pe + pe->size;
>   
>       fprintf(stderr, "%s:\n", __func__);
>   
>       fprintf(stderr, "    name ´");
> -    while (*name) {
> +    while (*name && name < end) {
>           fprintf(stderr, "%c", *name);
>           name++;
>       }
> @@ -173,7 +176,9 @@ efi_status uefi_vars_policy_check(uefi_vars_state *uv,
>       pe = pol->entry;
>   
>       uefi_trace_variable(__func__, var->guid, var->name, var->name_size);

... better keep it compiled with a trace event:

        if (trace_event_get_state_backends(TRACE_UEFI_POLICY)) {

> -    print_policy_entry(pe);
> +    if (VARIABLE_POLICY_DEBUG) {
> +        print_policy_entry(pe);
> +    }
>   
>       if ((var->attributes & pe->attributes_must_have) != pe->attributes_must_have) {
>           trace_uefi_vars_policy_deny("must-have-attr");


