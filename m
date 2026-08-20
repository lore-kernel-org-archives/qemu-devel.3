Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD9C0C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 09:57:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwzVy-000544-Ao; Thu, 20 Aug 2026 05:56:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwzVw-00052V-Ar
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 05:56:48 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwzVu-0005pM-P3
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 05:56:48 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K6eeGq2161287
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:56:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 NxEHUknx9izU0lZk6Q3EoFQGVKDrNrCFHchkQfoxV1A=; b=Z6n6yonYoYPT32lg
 2e2mNqyLTx26qhDMbLb/I51DVUJr2CD1uJ9j/duy9JFFCyBxsp6Nl4r3QR/02pso
 tsiE4Kr0kymoik02Pf2sxE7K8o84V75jGUN4Rjp6ietOxeW1YZOseGqxrJFO9qLB
 xYCNjScRs6qzrD9fxC0QH8mGB7EJNA/FERMdKIfIQevp5iF2d4MPBR1taa3J6B9P
 UuWP98Fa+c6Cngc/2aBNyhEmZJerDb9yhxWAW8gRYPdq3xBbq5y0kABH9MH1pJO4
 C8qpUof8L6SBgBvi76c2n93DXidy6lPFHWoqFYfy3joEWb7YaKUbXAOEunAJ2jWt
 AzEIYA==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5vh7rpv9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:56:43 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-930edb4362dso208698585a.3
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 02:56:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787219803; x=1787824603; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=NxEHUknx9izU0lZk6Q3EoFQGVKDrNrCFHchkQfoxV1A=;
 b=ibvqrJrn3zaWFIbFNgZWvVA2bnyptZkfYlQlTp9Cf4lP9JsQDg8vJuSY3mmPwkqtMG
 u1nIdsECvNVO+u7oqq2WZKfHM/X/hMc660OmDnOFvZHTNfU3tcMXOwbW/ylQ0jaWqduT
 gbYr9uk+10GSZmYDRS5a6XJm5cnIMEHFhCOuH6F/AAM708nfGOHUSC4P3D6yEDf1PaeT
 pf+G82+aKwfhcJlQb3855btVnqzvG9PnliMFSdkFGUrhEDd7gqr6O4BiGcFZ/DyMzhGV
 2X+lQb5+UXldjMWny6q2XBKym++pERFrvwxHy3YC0xU7OOBkj6qaubOmc9P6t8Q5Kg4u
 8LNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787219803; x=1787824603;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NxEHUknx9izU0lZk6Q3EoFQGVKDrNrCFHchkQfoxV1A=;
 b=VaqZFI94DwBiLtQcpGdXIhSroMtd9G9WdVXWqvM0232YPo3+2IYgMNFFCSK/EuxANC
 3iv1WyD24LRj2imr53Qv8hQDS8yOr8PpRx5P8Nm2RqFb8xOMric5LCnclIZ12O4naLGW
 QzY7Ua/ROez7+cQjIVSVZkXu+FHmFSUN4LD26ofQNx2p35mAeoZ5B/yGV3DBzb0J9HzJ
 gLjB585oLZ9g10u/kDmVCwPJN3fBNYqGM6ijYZSzqHDo2cmtRysVIYMxyUVwYOMVVolC
 Qp5/oSGr38TJXOuXYtLW4ELp1Hsz1DJOLSqEUolUS8CMU6nPVhyKNltG2KL8fAPxEiur
 PWXg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqJyOoMWRhWR3tFUkCHYH8UCum5JyL54P9Bra5j3tjwMxIsNenneV9Aq2dWQho7JkJ422qn+v0zJ0HV@nongnu.org
X-Gm-Message-State: AOJu0Yzs7PCzabUjhiSaHinYkQIEApWvNCFA9V2FXA78QXnPO9MXV+er
 Ay9u/GRpttNsM2ClKyJTg3r4642QT3N7SfG+Fto3Leh/e6sh+bFyBroUfYTY5y+AiMO1YR0F14P
 D+qDMG1xynVLi6HgdOBc6zTVF5+GsPDwzyK6U/sWZbpFvTLXwELE6/tsUKQ==
X-Gm-Gg: AR+sD1124w81HnswrmHVYDjNdohGf0nmhgACFiJf5DpYZKpQDEVYEQzPKW3ZPOzk0Ef
 tVmcJryXsnLwn0hIucstvnKL2ZhDTf5cVyBHfXZi6snjKy87StML7vraheu7yIzrtOWXP7p3C33
 Q1t+FB4XqjrrrhkIZsMoDke5U/BuaqyOVNIX/XO1fRfnHmBYg0w5rovi7gCtx/Bk+9pWmRzJjhM
 rLO4A+ohbdR935UkI1WLunZqitmZele1nHChbdn7DHxywkoC0VJfShnFYmM+o5TaFYhiu/4OD+Y
 wZ2lQLPNIzdAv+rbmn8dbDONwFo3vh58jl+LVOteKJ+7mQAxKWhtQ78SmEb23dC1vQFrO7rALut
 tyeDRGUizbEcmVIEqsCSci9k=
X-Received: by 2002:a05:620a:800b:b0:936:dc4c:3bf4 with SMTP id
 af79cd13be357-9371e2d1713mr1149966385a.28.1787219802730; 
 Thu, 20 Aug 2026 02:56:42 -0700 (PDT)
X-Received: by 2002:a05:620a:800b:b0:936:dc4c:3bf4 with SMTP id
 af79cd13be357-9371e2d1713mr1149964985a.28.1787219802299; 
 Thu, 20 Aug 2026 02:56:42 -0700 (PDT)
Received: from [10.111.143.150] ([212.136.9.21])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa1947c6sm126936435e9.15.2026.08.20.02.56.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 02:56:40 -0700 (PDT)
Message-ID: <bbd002b8-c4b3-40aa-b25a-87a101293dc2@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 11:56:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/11] accel/tcg: Make halt-to-exec transition explicit
 and remove cpu_exec_halt
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260819145649.23439-1-philmd@oss.qualcomm.com>
 <b5b003cf-0997-48c2-adce-3632bba01f12@nutanix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <b5b003cf-0997-48c2-adce-3632bba01f12@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA3MyBTYWx0ZWRfX+JCCqmOx/osq
 Dr/VHkh5/KtsDxABBRTSEFvxQFehL9IiMkUG3Op0HSCGLn51oG0fuFWdrf33QME+aklI2GojdpP
 QMaa3gaKjSQIm8Xj7mJ+B9hOsEBkIL1Ffg6dg2eiC0Fq3OxQpx1U0RckJ/6x6KU3Q3a1PdOM2zB
 XIumJtX1emgwxvfrUL3QJ2BkGg7wK3DBUvp6quFAywGhQiGXCYk6IkFLzHhQVDhbErj15GL/8JV
 TlmdiNfKVQrVvDhktW/xqsGkgIQy6FAyoNmLydDnhopnn7rG0K8XAfPNuGlNipJ+c+iOAM3vJ3Q
 TfOMfHsCH3xruxnkXvU49pegCK/wGY2LX/DZtyCGkdW+BUqiSmeudSaAD+BLKTmZ7itoczcoAnN
 NVhAVuSMXnBoVq31GXBjq7U/DBYZTWipEhWTCW6kDmu6Tr8fECi82L6bTEABWrrokTbvoF7yG2Q
 DgA0Ksl47WD4j9my51A==
X-Proofpoint-ORIG-GUID: bt79gzYoiqkhk6Wt7eopKrJ3gDYD1XZQ
X-Authority-Analysis: v=2.4 cv=Y7fIdBeN c=1 sm=1 tr=0 ts=6a86cf5b cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=/bviTfK1dmy+WGcHzWQ0gg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=vORvrX0xDVHjPSdPodEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=O8hF6Hzn-FEA:10 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA3MyBTYWx0ZWRfX7WzTcYZb/c/5
 ENtTgewCrMKqrkMigsfuMqU9HnNmXQxfnygV3pxJAL16rpjCzGe3hcRQgpDt+AaNiiRrcPztGXO
 0lvz1BBuLnVpqPJgzLYEtfL0lYrVGrw=
X-Proofpoint-GUID: bt79gzYoiqkhk6Wt7eopKrJ3gDYD1XZQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 clxscore=1015 malwarescore=0 impostorscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 phishscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200073
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Hi Mark,

On 2026-08-20 11:26, Mark Cave-Ayland wrote:
> On 19/08/2026 15:56, Philippe Mathieu-Daudé wrote:
> 
> Hi Phil,
> 
> No objections to the idea of the patch, however I do have a couple of 
> questions:
> 
>> This series was inspired by a previous thread on the list [*].
>>
>> Refactor the CPU halt-to-execution transition logic in TCG as
>> something more explicit and composable.
>>
>> Core problem: TCGCPUOps::cpu_exec_halt callback mixed concerns,
>> it checked for work, processed async events, and handled state
>> transitions all in one place.
>>
>> Solution: introduces two dedicated callbacks:
>>
>>    * process_async_events(): Process target-specific async events
>>      before checking for work. Called early in cpu_exec().
> 
> Can you explain exactly what you mean by async events here in the 
> context of TCG? Looking at the thread indicated below suggests this is 
> terminology borrowed from KVM with which I am less familiar.

"asynchronous interrupts/events that arrive (from timers, other threads) 
while a vCPU is halted"?

> 
>>    * transition_halt_to_exec(): Perform target-specific state updates
>>      when transitioning from halt to execution.
> 
> That's quite a name :) Would something like cpu_exec_resume() be more 
> descriptive here (as well as keeping the cpu_exec_ prefix used by other 
> callbacks)?

Naming is hard, I rather something self-explaining when reading the
code; we transition the state but do not resume yet. Anyway what about
.resume_halted/resume_from_halt/resume_from_sleep/resume_execution
instead of .transition_halt_to_exec?

> 
>> This separation allows the generic cpu_exec() code to orchestrate
>> the flow cleanly (process events, check for work, transition state).

