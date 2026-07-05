Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A89BC43458
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Jul 2026 21:49:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgUhb-0001vQ-Sk; Sun, 05 Jul 2026 17:48:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUha-0001v8-WE
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:48:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wgUhZ-0005tQ-JO
 for qemu-devel@nongnu.org; Sun, 05 Jul 2026 17:48:38 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 665LgR9C2824761
 for <qemu-devel@nongnu.org>; Sun, 5 Jul 2026 21:48:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 TN6KFEhF4ZP2/6FxuX38uLSJsAbmGPCP3ZKQ+7z9Ktc=; b=QHjIEpmP/Go7o1D/
 K4PB1DKC6X7ibpcUFhk5dLYIilc9wFDbqq+aamtxna1cKW7wB1Ph77rJAEpinUCH
 NW4qRiztDndkWLFotLaKrFILp0b2KH3iWhi+onYmLCCIYFFTw/Y2SxHazsr6sEC9
 Mll6ppyojcmC47Uoz1RZqmalxfyLXuUXhyKwuO+lDso7ZiDePURYcqxc0l5Lh/31
 6Sycf5TuItN/51KJvySVaHO9asP/Oh4f8eaWxc3UOibvSt4c7DyxKUr5FhrNZwPo
 YmWUQ1TuhJyH+RKmcIRQEowWa6Ohds4c/Hv+PVJxh8ujrj5GEu5w3zS/Jk0fRA2x
 TfL37w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f6srvkj0e-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 21:48:33 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51c1e6f602cso42084691cf.3
 for <qemu-devel@nongnu.org>; Sun, 05 Jul 2026 14:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783288113; x=1783892913; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=TN6KFEhF4ZP2/6FxuX38uLSJsAbmGPCP3ZKQ+7z9Ktc=;
 b=bygIwtbX9SI4poKJQhyZYFHtMdNlZAwK+FvKBT1gcWn6yBDoboPGATJhbQs8zgMZ8E
 slHZQzkAe3DKxD6NHI7ZnOB/sXV2a9NtDjcCP1gkUyVJZWiNfiRm5FF/PEswZvqbjC7y
 hHzA6dxyyYg+IGzm1Imd0h+f500o3dHg6UIqGRQ9dT98pZOBA0uoPe+YSRjtgzgiJFf0
 Y9d1OFRQTObCUWQBfDtiTgCzf3zQibcHUCDLPtMVHPQq+aA2LVWIa3Z9CLELYGCQ1Kht
 YNCVtRbyo83UkIh4x1I7c34gFvefUwmBZk9xmUYW0DokIyg+o690wobgC0IxQ7KFaMJq
 gyfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783288113; x=1783892913;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=TN6KFEhF4ZP2/6FxuX38uLSJsAbmGPCP3ZKQ+7z9Ktc=;
 b=RXeFBBiMWr0m8yphrArfndSMCfQIxKenVFjqBGhVykvGIWQUgRzsnqSV3HPayOkKYD
 QRGCSwhoxtyLHPKeR1qn+VnOip1K/eeNyIMLhlnhwkjd0OWKjUN8fO+jQmn7qY1xShW0
 2ItoMx4baCoRQbSW6lq/hR8Wc2BM4l6nP7hX0uaKW3hSiRu6knMnKdGpNWAfndWhYvaL
 5wHvJJBwcXnhZtWACYR7gGoUu1rBZCxUHlOic7NkMB44GU6xtux+rfVHHwIGEFGFXcQP
 u18UIvyU73kxsseY1bta+eXiHRDrAC4iaRByIwq5IdDWx1tlUGfA/rP/n5KfqqY3oZR7
 UJKg==
X-Forwarded-Encrypted: i=1;
 AHgh+Ro8Lj3KriUrp0TbYqubyChL7B+cnEjhVg8dLXkH7yAeWfPyT9o1EsW57wAeYJZF6lYTerVqsbWjIAAk@nongnu.org
X-Gm-Message-State: AOJu0Yy02hXyILt3maHBrSZdEJrv8lkVs+CJBQAWpKflOEf1HUq5At65
 K+Bcbn6X1hA2Yd5Vmj5ujMGO8mnwjmSZbcPxvNEio7Yp+F1t+bpx1/SG76s00nKD4K6wk6oDT1/
 QFSlBOGV/DrAbFbbMzLYIxA3mcVJIhA1UPpa1+Kgo4Uq1y5KOG3TLAA++2g==
X-Gm-Gg: AfdE7clZL3kKBhwk3Rt8ZXDziwclobmmir4pNWXfnF2R6EoyJm4eLTQeZ2ujDWNpCAh
 zYT+zN4Rt74HNxszWeAXwcWIphE8HT7TlvubTa+drDaxDvyBBZKMqNdstvEY28+by7Hz+TT/u1+
 tLOzK2oyawUMi2dHq6bquvEHm/rb2pSVvCfsZ6g8ARfmA5Sojl47NTFQWuAEsxFraOEIht66zTL
 PP/gWZf5eYsNoWuShA3DPfXwQTvBRJ2v+DgGAGUv9gBMsbNzAQFytE3rfNx1WBFoOhx4NvZigal
 zHgCVYWZVb5uOAXtMws3TNkEHSN7Rbax1TGV7T6ikEitYfKQnEOKoa7mIaOKJhzJ6Kd2t7DO/Gj
 wPHRa8c6eXk+UDvaq6ADF14CeDZXoQHynzcxeZFpxpLunR7a4VCAupgJn55autA==
X-Received: by 2002:ac8:5813:0:b0:51a:8c97:fb9b with SMTP id
 d75a77b69052e-51c4c32cc17mr137204601cf.68.1783288112825; 
 Sun, 05 Jul 2026 14:48:32 -0700 (PDT)
X-Received: by 2002:ac8:5813:0:b0:51a:8c97:fb9b with SMTP id
 d75a77b69052e-51c4c32cc17mr137204301cf.68.1783288112419; 
 Sun, 05 Jul 2026 14:48:32 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa039ad21sm19020216f8f.20.2026.07.05.14.48.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 05 Jul 2026 14:48:31 -0700 (PDT)
Message-ID: <6fcd2351-5fae-41fa-bda9-04a95b88c47c@oss.qualcomm.com>
Date: Sun, 5 Jul 2026 23:48:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 16/33] accel: Hold @can_reverse information in
 AccelGdbConfig
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Chao Liu <chao.liu.zevorn@gmail.com>, qemu-s390x@nongnu.org,
 Xiaoyao Li <xiaoyao.li@intel.com>, Zhao Liu <zhao1.liu@intel.com>,
 alex.bennee@linaro.org, Magnus Kulke <magnuskulke@linux.microsoft.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-ppc@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260703163757.55500-1-philmd@oss.qualcomm.com>
 <20260703163757.55500-17-philmd@oss.qualcomm.com>
 <ce9c60c5-123a-4b02-bb9b-5415b8de1698@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <ce9c60c5-123a-4b02-bb9b-5415b8de1698@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=TcamcxQh c=1 sm=1 tr=0 ts=6a4ad131 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=WpYMOuGuVo2vna8LTCcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: 03uK0FAm2ucHxRBp-5JBjbBLbZIUKUvW
X-Proofpoint-GUID: 03uK0FAm2ucHxRBp-5JBjbBLbZIUKUvW
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA1MDIzNiBTYWx0ZWRfXwV77YL8Vi4Du
 HAY7nEbqdeGv1mmjK5/JkZ4ieNaB+RvMJKPOv6Ag5pKb1TswRgwsxGSWCLY6Hg/i5M2vpPVPTZg
 YZXZ0abWI2hVixFINXy9Q8ar2ExTkloX59G3I+Lm7IRQvc8BWGHjw4Ry7yk+j/eBRf/PC0sPUqh
 i2Vuc0Zg7oeKVSuJI9W3j73Mc0J3KiPBYd+YXBYmG5NGUxT7/p+pHdBpQMbJtyG8H6X1Ph/LxoZ
 va7fXAT44ZJuzny+UPdAiIbaqKM2FC6uocyFtZsv5JID9AY/+uG+6sXsso37nnN0TOuocUVC7Wh
 ZF3wAQQv8Tzg85vJUJoBSVun1IRyQNHU0V0mmja3ClkJcAX0nhaDf2YV+C6D/BTMVm7r0e8TMAL
 9o7ZEQHNRijcTf6h6pCs6Ml9H/6zkhffS7NTK33it+DoaDQ+P3tPKv3sHSVydf/UY/oaySngInK
 Dhh7wkmUd7gKjShbLZA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA1MDIzNiBTYWx0ZWRfX9nuHfZ0lYUbt
 fcAvY81LaY8AmDk/XdsPqGpqjWb3wzsLrSu5N8V55JMq7mjBcOn0L/padPstxFpQplK15p7Ix5h
 DI61GaG7Fc+GGEtfYktnO14XEgI4RJ0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-05_01,2026-07-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 bulkscore=0 phishscore=0
 impostorscore=0 adultscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607050236
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

On 4/7/26 21:50, Richard Henderson wrote:
> On 7/3/26 09:37, Philippe Mathieu-Daudé wrote:
>> @@ -158,6 +158,7 @@ static int tcg_init_machine(AccelState *as, 
>> MachineState *ms)
>>            * them occurring every time we single step.
>>            */
>>           as->gdbstub.sstep_flags |= SSTEP_NOIRQ | SSTEP_NOTIMER;
>> +        as->gdbstub.can_reverse = true;
>>       }
> 
> This is under replay_mode == NONE.
> 
>> -bool gdb_can_reverse(void)
>> -{
>> -    return replay_mode == REPLAY_MODE_PLAY;
>> -}
> 
> This isn't.

Oops good catch.

