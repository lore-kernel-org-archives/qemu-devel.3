Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3CA7CD6E4C
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 08:21:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wTxtT-0004L6-BY; Mon, 01 Jun 2026 04:21:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wTxtS-0004Kq-3V
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 04:21:06 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wTxtQ-0000Bp-6w
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 04:21:05 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6514L4DS2753261
 for <qemu-devel@nongnu.org>; Mon, 1 Jun 2026 08:21:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gProE1uRRThJYlSwKDyi1/bUaAmIDeNRikdfxsQosQw=; b=CqUODJIeQ/gPYFDe
 kaRfuG9TfJ1YINmL2q50GcZo5Ue5zz98ncOxVW3w60e2SV6FZpMmNOKjHhHB5W7z
 dJK+UfYcVvRAJbxeKQARNtsYP2hnsEIKMlI+FSTep79hjgAssvoZ3+nT7imzDjNu
 Mzy7WVgCUZ9WzDtopPn0IJUlff22xgMd02HlI5m1LapFGxpUbyIAtN9unwzfq2Zr
 9iby6FUjTBABTJBGiCynwzp12G2rfVjSXjzmGyLgSS81Xe7aGcLRPfhQUYb0jShT
 NLOd9QNWvbit2LQxUWITCKQFhC5X/GR5CsV3juV06/3DE06VcpGKCvh6f/EIvCEX
 4H4Iyw==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4efux563aq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 08:21:00 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-304e7fc90b1so3018445eec.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 01:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780302060; x=1780906860; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gProE1uRRThJYlSwKDyi1/bUaAmIDeNRikdfxsQosQw=;
 b=FtAJJjiH2KjDrfwkhiQb4M2qosGp9KF5PMtHdI+Zpc+paBQ74Ah/N+GukLJ2iYIL1U
 0JGzIP17sv58vZI6Bn/f2H5AMqjyin99e0tHbK3izAewu+3trY1XeaKNNXhL4wyS3PzY
 GcUAIKRseUVuohBh6XI777bYJ3/8ihKHZS1pKS5X5EFwpllElzJCzNASCyIyY/fx2UVq
 UlGjmFsBDxNYijsgiekma1upzkNJhZjMNNWEJq6YyeMBPrMGFJi3154hIoJ5XeHGj1wU
 L40jrE55yw9XCBsZfzBBM6Jm9SxmHEk2v/DhSQKQVWufl0ZiLxagQWfo7yy6jgEh7/F5
 23+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780302060; x=1780906860;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gProE1uRRThJYlSwKDyi1/bUaAmIDeNRikdfxsQosQw=;
 b=O2wlbEMWyRvESxl9IK289cUQ32MMoJ+nt6Qy412swWVzt27vLKc6N2mwyVmOrdSHGi
 jXk43kn0HZ1UP9szcGymsa4P0JprhI32zW0sJ/0tcbzrd1dPiI2qvuYoNUfQyRwyc9lA
 4qYY/VDex71JMhIZpNo7qpDMiaj2hCepjxT5OsM6R45B5tNXM3BuoX5R7sq43zJOQQKs
 ZDcEgF0WEyXODGfved0BgEMtKBc0zXebWuZ3hbBU/D9KY2Dm3PXEDjqUBQOs9++xonms
 6GRgqOBjMJCewqzTS3Wamidx5cOdnDKg6flFyAaYo+nWKP3ZgGxS+v4vloxfJpTc80t0
 alKA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9b3F2+g6zeyVe1d0IuSt50UvmIs8+Dcj7cf7ym6sEWDAz+OMuNxFupaxgpSqTfeRtVQHJJ2bCIeMlc@nongnu.org
X-Gm-Message-State: AOJu0YxPNP0RKVpbHGnsiyKJ9kQLSsm5Z9tn0vFp7MTU6eRwNyq46bT3
 s4QS0g8LnZ9Z6cESq1FDrLxOtEYMxAMHZ93C/U7iOLfejpppMp/ZIukVPm3bcEvPQIyDBQ6KANX
 yH3rLBxAIAzXBa80u+jz74Rxt5fiT13qQbrEhczIlAYlLpKHYNfFvHl/6bQ==
X-Gm-Gg: Acq92OGiOgYkIpkDuMxZVH19IRcyPWY/RuWM07qMgZ1pwtJ/9CxuqF0eyL0Ji83t0dt
 0piiA+YwolH3WDdTihmmAQWy7M3CiJQoCM/U2GsDgNqEwT8acv06x1silNI9ergwY5Ag0XulsFj
 n4eXowp13oOxPnqq4Ps8Z5CSaVYMPF8gtLM45rhIypvQIYPPY7g07254BE6vCiMOZ2HGz68Xy1H
 GOsS/vYIZbevQwI0TCyu3RiDvLVXEu79bJguXLwvbSI4UWV0WcCmV8WKpafbI45eipRZi5hFMPY
 TfGkbkUuZ7QT8olDaDyxVxhL1ZSguRee5YZ3HiuKBWknBQgeaDRncHTBV8uYmXvKpW3mUb/0Ike
 FhQCJ+NB2F6q/o2VqEROlH4gNzES5TePhmSRBfhGnl1uv53SR6jaWA9EkDpN0n7BlahpV2X0xT+
 hO2HXxo/Sx+riKnCIwRzTW99Fo
X-Received: by 2002:a05:7300:a44c:b0:2da:a813:a5fd with SMTP id
 5a478bee46e88-304fa5a7ac4mr4556495eec.22.1780302059830; 
 Mon, 01 Jun 2026 01:20:59 -0700 (PDT)
X-Received: by 2002:a05:7300:a44c:b0:2da:a813:a5fd with SMTP id
 5a478bee46e88-304fa5a7ac4mr4556481eec.22.1780302059304; 
 Mon, 01 Jun 2026 01:20:59 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed578c48sm7875190eec.20.2026.06.01.01.20.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2026 01:20:58 -0700 (PDT)
Message-ID: <519e6188-699b-4ed3-bbe0-f8f5ae7c62d5@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 01:20:56 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] semihosting/uaccess: Compile once
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250502220524.81548-1-philmd@linaro.org>
 <20250502220524.81548-3-philmd@linaro.org>
 <5ebb1a1c-efdd-4dcd-8027-aa3dc031b755@linaro.org>
 <e287f18b-757d-4fbf-a680-7d66f962eb11@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <e287f18b-757d-4fbf-a680-7d66f962eb11@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: eK5S437dl00NQC6lWZtHZ3rPeMLY-Iiw
X-Proofpoint-ORIG-GUID: eK5S437dl00NQC6lWZtHZ3rPeMLY-Iiw
X-Authority-Analysis: v=2.4 cv=BdnoFLt2 c=1 sm=1 tr=0 ts=6a1d40ec cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=0Eh1pWOq_tBhjFxJSD0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDA4MiBTYWx0ZWRfX2LQ7SzLknybc
 7dpNr3I1s/HaSouiFvC8h99y9/bTH6wj9qTh2kWccylRru+/7Pf2bR4iOOy1fyswq7adOS4uV+s
 pwKguLRvqpn5AThwaZdfEulr8X26hASq5WNFVWEnmJWjPnh/6jFWCt30/8f5vexR0B4LOf1Z6f8
 XQWa/xY8FEvl6zKSwaRZQnnweJrnkqYAiPLYFSd2phQmoUGwXemQw8FWgqcgRKcG1502syv/YtY
 ETqaGTMI1ZwhrhwtGQy2xUZTBbCWgq9/mRK7Wd9cnLvejc7Y8V88I+6UwlmAkO7/5M+hYqawIbu
 ZH/hji8mrdJlxw+n6TT+shhJ5lrG6FvwLyUhVnpBcKc9TQhE+am+qHBpDUusTI8F8yK/EUGCZ2a
 zwif4bqPIzEd8kZLHxoMCM3iu4vsyH6DPIiATCdgeJT8Q7OpqDnN9Ek7ykHXsed3eRp4GN9aY04
 X+VsBDnlCQbFqwyx6fQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 priorityscore=1501 spamscore=0 phishscore=0 bulkscore=0
 clxscore=1015 malwarescore=0 adultscore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010082
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 5/25/2025 9:15 AM, Philippe Mathieu-Daudé wrote:
> On 3/5/25 22:04, Pierrick Bouvier wrote:
>> On 5/2/25 3:05 PM, Philippe Mathieu-Daudé wrote:
>>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>>> ---
>>>   semihosting/meson.build | 4 +---
>>>   1 file changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git a/semihosting/meson.build b/semihosting/meson.build
>>> index f3d38dda91d..a0a1c081f43 100644
>>> --- a/semihosting/meson.build
>>> +++ b/semihosting/meson.build
>>> @@ -3,9 +3,7 @@ specific_ss.add(when: 'CONFIG_SEMIHOSTING', if_true:
>>> files(
>>>     'syscalls.c',
>>>   ))
>>> -specific_ss.add(when: ['CONFIG_SEMIHOSTING', 'CONFIG_SYSTEM_ONLY'],
>>> if_true: files(
>>> -  'uaccess.c',
>>> -))
>>> +libsystem_ss.add(files('uaccess.c'))
>>>   common_ss.add(when: 'CONFIG_SEMIHOSTING', if_false: files('stubs-
>>> all.c'))
>>>   user_ss.add(when: 'CONFIG_SEMIHOSTING', if_true: files('user.c'))
>>
>> Fails to build with:
>> ./configure --disable-tcg && ninja -C build
>> FAILED: libsystem.a.p/semihosting_uaccess.c.o
>> ../semihosting/uaccess.c
>> ../semihosting/uaccess.c: In function ‘uaccess_strlen_user’:
>> ../semihosting/uaccess.c:43:17: error: implicit declaration of
>> function ‘probe_access_flags’ [-Wimplicit-function-declaration]
>>      43 |         flags = probe_access_flags(env, addr, 0, MMU_DATA_LOAD,
>>         |                 ^~~~~~~~~~~~~~~~~~
>> ../semihosting/uaccess.c:43:17: error: nested extern declaration of
>> ‘probe_access_flags’ [-Werror=nested-externs]
>>
>> CONFIG_SEMIHOSTING conditional must be kept.
>> -libsystem_ss.add(files('uaccess.c'))
>> +libsystem_ss.add(when: 'CONFIG_SEMIHOSTING', if_true:
>> files('uaccess.c'))
> 
> This produces:
> 
> ../../meson.build:4119:28: ERROR: Entry CONFIG_SEMIHOSTING not in
> configuration dictionary.
> 
> 

I'm not sure what is the context of this patch, semihosting is already
common upstream.

Regards,
Pierrick

