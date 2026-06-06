Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C003FCD8C89
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Jun 2026 02:34:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVgrD-00078g-Qn; Fri, 05 Jun 2026 22:33:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wVgrC-00078U-U8
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 22:33:54 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wVgrB-0005np-7l
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 22:33:54 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6562PMxB199453
 for <qemu-devel@nongnu.org>; Sat, 6 Jun 2026 02:33:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 v1TIM0TZiva7fNh2VBKZ3XJJtWrkbwQ8XgKvXUXyoqM=; b=makyiGJwu3P+dWTn
 Y+//qSxq4WLwjc9OEiVv34lcqQuMnWaJWa+TsYPMLUuNrvOVRzDRtBoIVRdGkEBW
 Io+b/7kKwIet2ff/KBxHn1m9Tz1fZRZi5zf0It0+nleOg5yJk6lfzMcbYzW/iRoA
 RYwiylz/MAPRyDOT6F69qoPGv/ni3fyvv7FZQg7eslgZsbNjLMgDvwn1CIPO40Bk
 1nfLp7QOylF7DSiW25RQQGN6QouOY0uo2IWzudn5wquh5QNFWG0ztkFyOTjo/cJr
 ULEKtL91Rhvpf5WeJWuGqaij81jrqsIDW82IDqsxWa8O/HqvpLbDQZ6hExcTlz15
 1yVMZQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4em9nm871s-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 06 Jun 2026 02:33:50 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9157f1be083so547351485a.3
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2026 19:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780713230; x=1781318030; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v1TIM0TZiva7fNh2VBKZ3XJJtWrkbwQ8XgKvXUXyoqM=;
 b=XTMB2z1v4YkBLZnWktL6aRHmtdsG7i7oaVnxmvKM6nBjCnQ/yK2e5DLcDbWZr9ZN1r
 hdrRwy8QTXXP9pkKVI1NmJei9MCkqt45lwu13vJIXLdZZ+g3VwqjRtr6LVhlU37BgdIS
 FlsaLoClMaW9uUcce0QTG7U0qzHbUlBq+JS9UBkahWjZEDuJoHrhO/dNDmZkx10mFhjE
 S42qXVO/T4B/xsH+JvQ8kt7NBGvXmyXSrzL4JupCaAG28i2UDGE4/zlwodoRWPetM8MA
 88BV32zBHGp754dUOZu1AmGcRnjF82YDVoEgWWWtza/3gEt/YJXEaI/ND+vSJs9iRy0X
 tVQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780713230; x=1781318030;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v1TIM0TZiva7fNh2VBKZ3XJJtWrkbwQ8XgKvXUXyoqM=;
 b=kE9mddRZuc1sN2KAlDiBkLO84l4SXtJ4hP2J4hsl+kcnKG3KY90VIjb0b/DfhkxS5o
 IWPJugj8+nQcxj9UDrpucti6Xro8Mch2TauXWz3G2QYE4AmeqsYxpZV+d94E+Qq2oeju
 Ff2KMMabvgb6qZlKymEhGWrfyJpWrlT0HEMATGA7gHn6UMa5xIod0rY+gu8Evq9atmjM
 db/3aPHVb3F0eYRfyjV/OYuyeNtGHw0NoCSTctfDxCt9FARHE1uwCP3uxbv65tFZA9Q0
 ySZs8tnV9ZA+5ktXr1TqxZLDXhlKLMDQVcZxeZ/DWnMzOu2537u+6VEVpn66AZwbQ7Yx
 M1aQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8M5tuLZys/PBaMRAzxbXl+7FCyBBBsO2hqhrlguIY4pKyuBdxx1ow1gQlfGBmMPg3MDavAqvAyAHW1@nongnu.org
X-Gm-Message-State: AOJu0Yxn78uN2wuWSjmnfXSmktl72EUuyu5XUQkjx25Wd/jQCo8d+Oag
 swyTjF9h0KQFRyZbtp26uTLqC5NHGLl79YhCZeRKfkrQc4PNHQflS8WyXq6gOIc/mZOEWF4ivqu
 et8opjjQtV5RpP0L4ZN1KkpYDKdGTNW/6x6OcivOaLe5RmIBI6fStl2lnlg==
X-Gm-Gg: Acq92OF4snZIQLt08gnek65vy7e9N0ktwPb5w6+2mD4WzySyQ3cx6tf/Vek4mT3KbS6
 k04ZxLQ7vXMVZKgjH+UOnUgenRZummomV3OozZEacFiuKCVrzwBg9jX+u9zpSVnxQlAb/tk8Qog
 +ZCoFcjpTMUqP10M+d5NbJ9zp5isuMGJIUhwGNOMfzqPe5FCx7O8CQKp1cVVdnqa3xe85p42aip
 1m6jnm2NHklmvvR62FH/2ygOB2xjUTje78oDSjZpS7ijweUwMifu1Xb8MHktxMfXxgnt46CLyBi
 ZND3vopZQX4+M578h7lQfT/h1d/IedjafdEWY1qEx/LKeOkGWF+dCQVnzhzMwX3w5RddwgwMw8N
 IBbMfzJSCIOT/a3/bvt2jXX2I6sQ/ZZFXPJUcB0+rjuU8t7zNZkdKEIKvBH2FfWPeBriP
X-Received: by 2002:a05:620a:2945:b0:915:40ff:4e10 with SMTP id
 af79cd13be357-915a9c4a2d5mr1126917785a.4.1780713229743; 
 Fri, 05 Jun 2026 19:33:49 -0700 (PDT)
X-Received: by 2002:a05:620a:2945:b0:915:40ff:4e10 with SMTP id
 af79cd13be357-915a9c4a2d5mr1126914985a.4.1780713229238; 
 Fri, 05 Jun 2026 19:33:49 -0700 (PDT)
Received: from [192.168.68.106] ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-9158a00a4f4sm1130666285a.3.2026.06.05.19.33.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2026 19:33:48 -0700 (PDT)
Message-ID: <3f9d50fb-304c-4ef3-bd63-9fd215b45965@oss.qualcomm.com>
Date: Fri, 5 Jun 2026 23:33:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 2/5] target/riscv: Add server platform reference cpu
To: Andrew Jones <andrew.jones@oss.qualcomm.com>
Cc: Icenowy Zheng <uwu@icenowy.me>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org, alistair.francis@wdc.com, liwei1518@gmail.com,
 zhiwei_liu@linux.alibaba.com, chao.liu.zevorn@gmail.com,
 leif.lindholm@oss.qualcomm.com, Fei Wu <wu.fei9@sanechips.com.cn>,
 Palmer Dabbelt <palmer@dabbelt.com>
References: <20260604095244.3313259-1-daniel.barboza@oss.qualcomm.com>
 <20260604095244.3313259-3-daniel.barboza@oss.qualcomm.com>
 <4acb210eea217195fa733a4f42369c01591d5499.camel@icenowy.me>
 <a77a1891-214e-4788-8cc3-a5729f5cd182@oss.qualcomm.com>
 <9b05368c-972a-491e-bddb-7e015100eee2@oss.qualcomm.com>
 <5y2sdlx3pu5oyhrm3yxxkvkwv6pl3bpvuzdpnlqg4xt3l2zrxd@yi4h5x2f2xze>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <5y2sdlx3pu5oyhrm3yxxkvkwv6pl3bpvuzdpnlqg4xt3l2zrxd@yi4h5x2f2xze>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjA2MDAyMiBTYWx0ZWRfX66zFSDUPO3zj
 rUli2ZIhFeDzXKv1oVNEnedd/Ah6d9KraFTixGjPk/zG5/ECSL/+jYaPYUxWzxCdaRwRZI930bn
 D+QB8OQbAQAtTch8eTZwo2t7NVwVxrw+XDJbEcwds9JhYe/jBngzOOECvwT69t5qpNmghbQO+n4
 Eyf+6kLlnwwSN4H9B4yivbG8XwKhShW2KqjxFX4uxFW9zmbnrncLoKmYMlpjylpxzH4pIEvOdz/
 vgA0dgiFrH1jPRlKPX0Tkh4syOZKM/Xe7lfcrcDv4CI5mWe1r82cCAkjW7tvv2pH0AumaRKclBn
 XJdpO37b19PBlLfeEFw48udXWoesKVA1r6p2Sn53CzNidf4fg2C28Jkn0ck5jh/WQ5JzhqFYSM6
 KJy5zu2PeAt8kMQ9QwDFsUiiyhgVUcnpKuB2zJ+JebFbQQUgttd0Gscn/TCjMHJBm6Kks1r4d4e
 RvT7Sek9t6WTbfndyYA==
X-Authority-Analysis: v=2.4 cv=Z9/c2nRA c=1 sm=1 tr=0 ts=6a23870e cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=5l_fwqxPi-CwV5iqmxsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-ORIG-GUID: is0xogUOny7agrw7wGCteEFjd87zrTfm
X-Proofpoint-GUID: is0xogUOny7agrw7wGCteEFjd87zrTfm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-06_01,2026-06-05_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0
 priorityscore=1501 lowpriorityscore=0 malwarescore=0 adultscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606060022
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



On 6/5/2026 7:24 PM, Andrew Jones wrote:
> On Fri, Jun 05, 2026 at 05:48:18PM -0300, Daniel Henrique Barboza wrote:
> ...
>>> You're correct.  We're not initializing satp_mode to max_satp_mode, so the
>>> default value is being set to sv39.  This seems to be the case for all
>>> CPUs, not just this one.  For some reason I thought we were defaulting
>>> to the max_satp_mode.  I need to understand why sv39 is being set as
>>> default (i.e. why not BARE?).
>>
>> Got an update.  It turns out that what we're seeing is something that is
>> only happening to this CPU we're trying to add.
>>
>> The way satp mode is set on QEMU assuming no command line input:
>>
>> - "Bare" CPUs, aka CPUs that has just I or E enabled: default to BARE;
>>
>> - Profile CPUs: default to the minimum required by the spec.  E.g. for
>>    RVA23 the default is set to sv39;
>>
>> - all other CPUs: default to satp_mode_max from the CPU definition.
>>
>> The riscv-server-ref CPU is a BARE CPU that is using the profile framework
>> to enable extensions.  So for all intents and purposes the code is treating
>> it as a profile CPU with extra stuff.  Which is good, but then the
>> satp setting from RVA23 (sv39) is overwriting satp_mode_max from the
>> CPU definition.
>>
>> I believe the way we're creating riscv-server-ref here is correct, so what
>> I'm going to do is send a couple of fixes to allow riscv-server-ref to use
>> RVA23 as a base and honor its satp_mode_max value too.
> 
> But setting satp_mode_max to sv48 is not correct if that really means
> _max_ since we want the reference platform to default to the minimum
> (sv48) but also support the supported optional extensions and sv57 is
> a supported optional extension.

QEMU only works this way for profile CPUs.

For non-profile CPUs: cpu.max_satp_mode is set internally as part of
the CPU definition.  This is the maximum satp value that the CPU allows
users to set via cmd line.  If the user does not provide a satp mode
then we'll do curr_satp_mode = max_satp_mode.

E.g. the thead vendor CPU defines .cfg.max_satp_mode = VM_1_10_SV39.
In the command line we can't set anything higher than that:

$ ./build/qemu-system-riscv64 -M virt -cpu thead-c906,sv57=on
qemu-system-riscv64: satp_mode sv57 is higher than hw max capability sv39


For profile CPUs things are different: they are bare_cpu types, which are
initialized with max_satp_mode sv57, and then during profile init we
set the current satp_mode (current, not max_satp_mode) to the minimum
the profile requires.  Thus the rva23s64 CPU, by default, starts with
sv39 but it can go up to sv57.

 From what I'm understanding we want the riscv-server-ref CPU to work
like profile CPUs.  In fact I believe we can make it official by
adding a 'default_satp_mode' setting in the CPU definition and allowing
all CPUs to define a default satp and a max satp.  CPUs defs that don't
set a default mode will keep working as today (default_satp_mode == max_satp_mode
if no user input).


I'll make changes and see how it goes.  Cheers,

Daniel

> 
> Thanks,
> drew


