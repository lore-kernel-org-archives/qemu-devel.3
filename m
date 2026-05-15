Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62874CD4F48
	for <qemu-devel@archiver.kernel.org>; Fri, 15 May 2026 17:01:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNvuF-0005IN-MV; Fri, 15 May 2026 13:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNvtW-000571-6L
 for qemu-devel@nongnu.org; Fri, 15 May 2026 13:00:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNvtS-00064F-ID
 for qemu-devel@nongnu.org; Fri, 15 May 2026 13:00:13 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64FBcTEN3512994
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:00:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 CUTPbQnnYo0SwhRY0iu+P6lu/Ytp9IhS6qAd3elCJVw=; b=l3UxPQhzstYN0nvG
 xYZJRnFX5hQHpl+AdrT6HM7KqoNPNR1rviVQAsqdAxJVYZhv5Uv7O3Fgh/5bJbrE
 qLS5AtPWXUDN/7xUU920VLxRej9u9Cj+t1VnEIL4u2F50hlneTiASwhBJm6hhJNm
 LrCbJLrQ3BGdjJpBaIwlyfP+xxksLnUfAZ57K1FaumjXWKoMgq2SZZxoM9mkLE9p
 5uh2EAi1TwfvH6mztBobp/bk+/c8vi+yLFZApl0ncmKarR2+3xk7Va75uNlXxVOV
 PYCnBRwG62QnYGYlbe0Ao00HlmjZH3sLPJnspGGqu4n9kjZVQBcATJg8+FmXvKGC
 3QJAFQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e5m1vc4xe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 17:00:08 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2ef62078ee7so55187eec.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2026 10:00:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778864408; x=1779469208; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CUTPbQnnYo0SwhRY0iu+P6lu/Ytp9IhS6qAd3elCJVw=;
 b=cz1xLxQ3V5S+EJ4wRnn4p99XdyMicnPfkM/s66+2ylcch//OYKMUOnh1FpJSwAihFa
 5gPUnooArEaM3VTwtXC8Z1gRHB+oLzhgXeRGpR6WOiEAg012garTFSQh+tXzRx5qqgRp
 HqLuw84K77DTUPPWiY22ZKqnjeHIVzrtXeF9xB7tOc8Ft+dSC3julukwTcdxxut2g3P4
 YfmRsDBbsKZl07nF1a/QrcrkTqpVOOtS9F+5Veqd8MTn4Yo7oZWQ/R8Nh7JOjBQST7cC
 I4vEGbmYlD5/Yhyj4cwedsS/EBruW6IVV98zwuundhJfeYpKRTOmxR+bA6hhgGyXMBbo
 3bKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778864408; x=1779469208;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CUTPbQnnYo0SwhRY0iu+P6lu/Ytp9IhS6qAd3elCJVw=;
 b=VxeaxKhSdTNRehVhN81AoGbJYEVQsqrGtgCqwUCa8qdMC1LzSb+TRIZwc0vk5jRF3L
 7z30RzXjyWPHZ9D9B/yqowHFDmZQGwswSfuwVkigsx81H/mbXehZq2f3U0ivwlE8dc/+
 /GmbcUQyWAXCDiE/qlpKljr9x4i+u5V2GGGECutwBPmWErxlmFU9cIdBu5L4zXPhTacr
 0GZQufMS8vwyoKQs0cA0YKYbkDGmtWhqRBD/h8WTMjwPPCaAwJ6UHs+PxI+XAOa2B1Zb
 1SY+0ELXCMnE5SXfQjUj0DotFxrIPy2nag1k9KPUUkmZtCWYL/rL3CjEgUCf0h1X+lCa
 orEA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8/LaZ5CeH9H2pR6Jonol9j7CIqYdSXrseCF5kaqGFWrdeLGa2utKGqiZiDO0tm4Nyyx6t8S2lanWsX@nongnu.org
X-Gm-Message-State: AOJu0YwiwdSwgSxcNnqDSkPJR9GMCrVLoqk6Ca3Qg3IDmvUTVwoKw35I
 JoIL6U0QCd+yL2KB6kvXhNDAlHtIaI1fmkiu5hjp/+Fn8Kv+N4nU8YCfmi/33KhkhjxSzF/Ax0e
 J6QF5hQAImOIVh72XOL3G3zfYRDrH44OhVQN4Ozemn8IV3kli8QV23872mQ==
X-Gm-Gg: Acq92OFImPB2d0JcWnirr0b5DvE75H0B6ZRlZforVoTMDELnkzg6hQQ0z+hCp9SjkMi
 lhWYRTAxBdvCuO6mK39YfGFhxrQkrN6OY7cJ9pp/+NwixmeZkoja1/J8UhUR3sbCHLpxQGZF16S
 LI+budIEYy/4wyRlPCRw563gotJUVmo0QHUFnn68Qvxz73o5Y7/iEMmzDnHsDD1vwUVZVLttPwr
 +nr3c2ezvbehmQ99um3uXcgzyTDO9L47IVmMV7/Sbe0/FxM/2Se0v/S0WjUmeG1JSnNxSiwskAs
 LluoeCbt/49XS2gevBnc5+Uyg+qHzbidlI2L2e/hU8dzUajk2Cxdg4csZxZJdc7NrqZj5U9HHq4
 tYV1O2fLNhfYgJBMwPjwmPEivOd4vfucVkFEWlnvnzEIjCPR5EJylCSgbX4R2LYQD6cFZgoPEP3
 z2RqFRJ9i3ybCLxBo+XRtCYfqE
X-Received: by 2002:a05:7301:3d1a:b0:2da:1a81:588 with SMTP id
 5a478bee46e88-303983c6515mr2218442eec.14.1778864407975; 
 Fri, 15 May 2026 10:00:07 -0700 (PDT)
X-Received: by 2002:a05:7301:3d1a:b0:2da:1a81:588 with SMTP id
 5a478bee46e88-303983c6515mr2218418eec.14.1778864407290; 
 Fri, 15 May 2026 10:00:07 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30296dcb6e9sm8860161eec.16.2026.05.15.10.00.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2026 10:00:06 -0700 (PDT)
Message-ID: <99983366-9174-40cf-a158-a663daa7965f@oss.qualcomm.com>
Date: Fri, 15 May 2026 10:00:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 04/20] hw/arm/aspeed: Initialize 64-bit CPU types
 during DeviceRealize()
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Joel Stanley <joel@jms.id.au>, Kane Chen <kane_chen@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
References: <20260515141032.3271-1-philmd@linaro.org>
 <20260515141032.3271-5-philmd@linaro.org>
 <e8e1d0f8-b5b9-49a3-9478-f58f72e962e7@kaod.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e8e1d0f8-b5b9-49a3-9478-f58f72e962e7@kaod.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTE1MDE3MyBTYWx0ZWRfX/Z8UyzLxD4rA
 8uVuYjByMykRuQI0/q7jSmtsyVBMa0cZLwvxUij7TCCbF/qutuUWVo3mrpSl6HyeWtrxch4JG7B
 q8PSh8rqUKp5gab5VZUUbB3/wzYhmHdAzD88IJPt3IaWoZ9vVBwZYNoEsevuwicpAZLOYgY2rHA
 sI5nqqU+QpYdRoPeS7rOsxKronRjAincVYFgydxC092AR8RSzA8NEWotr37Rwi79BVDZN8D4lkv
 Rl5udWcOvCK+6FiFVdiioK+iM8WfBQjmVmam7QQ7ssm6ZEU6cf97E/TojelOe5vUb6Hwtw7g7gz
 pVEgeJ+lYKnVPHJxrdIJgtksCtmFCRj0HQrlvXhDVvt6PptpmVFQ1ldEAQHAEm1pm+LOKXFiEr1
 XeFT6v2ZD6hzjt0Wo7HlaglduL+ozaAbWXh1+bMDqk3a+DsvD+Iy9k64x2cJRmAuSXRW0pE87Zo
 mfTYcAA1MaQzVYSaQxg==
X-Proofpoint-GUID: ZRScf1qdDhpwG3aQJ9HXT1YVO_zI8GTN
X-Proofpoint-ORIG-GUID: ZRScf1qdDhpwG3aQJ9HXT1YVO_zI8GTN
X-Authority-Analysis: v=2.4 cv=BvqtB4X5 c=1 sm=1 tr=0 ts=6a075119 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=KKAkSRfTAAAA:8 a=u3Zk6hkPrBBZEYuwQVgA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-15_04,2026-05-15_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 malwarescore=0 bulkscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605150173
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 5/15/2026 9:29 AM, Cédric Le Goater wrote:
> On 5/15/26 16:10, Philippe Mathieu-Daudé wrote:
>> aspeed_ast27x0.c models 2 similar SoC based on a 64-bit only
>> CPU (Cortex-A35), only available in the 64-bit binary.
>>
>> If we build this file as common object, these SoCs become
>> available in both 32 and 64-bit binaries; however when running
>> the introspection test on the 32-bit binary, the init() method
>> tries to init the Cortex-A35 type -- although not realizing it
>> -- which is not available. This can be avoided by deferring the
>> CPU type initialization to the SoC DeviceRealize step (this is
>> safe because nothing uses the CPU type before, only the GIC
>> access them, just after their realization).
> 
> I understand this is a qtest workaround. Could we introduce
> instead a (qtest_enabled() && 32-bit binary) helper ?
>

In general, it exposes a dependency issue in QOM type system.
In this case, we get a class depending on another one through
class_init. Moving this to realize seems like the best fix.

> C.
> 
> 
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/arm/aspeed_ast27x0.c | 7 ++-----
>>   1 file changed, 2 insertions(+), 5 deletions(-)
>>
>> diff --git a/hw/arm/aspeed_ast27x0.c b/hw/arm/aspeed_ast27x0.c
>> index 87dcb82e1b0..e50125bfeec 100644
>> --- a/hw/arm/aspeed_ast27x0.c
>> +++ b/hw/arm/aspeed_ast27x0.c
>> @@ -418,11 +418,6 @@ static void aspeed_soc_ast2700_init(Object *obj)
>>           g_assert_not_reached();
>>       }
>>   -    for (i = 0; i < sc->num_cpus; i++) {
>> -        object_initialize_child(obj, "cpu[*]", &a->cpu[i],
>> -                                aspeed_soc_cpu_type(sc-
>> >valid_cpu_types));
>> -    }
>> -
>>       object_initialize_child(obj, "gic", &a->gic, gicv3_class_name());
>>         object_initialize_child(obj, "scu", &s->scu,
>> TYPE_ASPEED_2700_SCU);
>> @@ -701,6 +696,8 @@ static void aspeed_soc_ast2700_realize(DeviceState
>> *dev, Error **errp)
>>         /* CPU */
>>       for (i = 0; i < sc->num_cpus; i++) {
>> +        object_initialize_child(OBJECT(dev), "cpu[*]", &a->cpu[i],
>> +                                aspeed_soc_cpu_type(sc-
>> >valid_cpu_types));
>>           object_property_set_int(OBJECT(&a->cpu[i]), "mp-affinity",
>>                                   aspeed_calc_affinity(i), &error_abort);
>>   
> 


