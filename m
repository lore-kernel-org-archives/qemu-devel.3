Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06F45C55ABA
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:17:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wreIM-0001r4-3i; Wed, 05 Aug 2026 12:16:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wreIB-0001qY-5k
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 12:16:34 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wreI6-0006PE-Tj
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 12:16:28 -0400
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675FVSLW3332365
 for <qemu-devel@nongnu.org>; Wed, 5 Aug 2026 16:16:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 cC7IuUX0kO1TajwGo/T2B8rLfA2JEYu5bvBwy+qlssM=; b=LzW5xqY2YWWKVp6K
 xa77RLKLawWAfOprN+68eAOmC6mQZsqoHrMK1rvi5yilUZTfUUnnluzbpFSH2+XJ
 R2O+Lza7VrFD+doNcgjy4iIcVh65+6hLAWm1ok8QRF83CoRslOFb7kBqkb3qsqe+
 EfD+GGEMCdmH8MhdPCisfA2D/ZfFYnfRBIdbPT8FtJFlfRGihjL6MBW87A52+Ryd
 GThVvbNvI1pNPFnzTcluoGYAKvdtqNFPReBisXg3aJdwpdEb/e528s+dn/PbX2wd
 T5UclKVcDWriodu2tyEiZjcZtQdOgtyAZeF3wu3netYAj9QzpaeXe9NvsArKmvnw
 QuSk8w==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fv2c09wpt-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 16:16:24 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2d001671a54so21971435ad.2
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 09:16:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785946584; x=1786551384; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=cC7IuUX0kO1TajwGo/T2B8rLfA2JEYu5bvBwy+qlssM=;
 b=XVTCNPKu/EmmHTtQS+nJtiGSQZluA6NchrL9W5Vy41pYeHQsAGAl6mG50JTqWwg+tp
 89OEsEQV5L/ziyAQOKShVInm9HoklOVu4xxpcBzZswewD8VY9fy54mExQgrOi0gEaKoZ
 IHLQLK9DwJDeVn5ErJ8Zh/tI4/w42jjG7IwkfmMXhcYiS7uwj1gXbD5xYKF+URaDQu4o
 J3LHX1bFTmeaidRbc8Kw4um/jwGG1ZaCPcXvxzfok9s4R3r3lAB9MLpR3NY46QtDRrzz
 CopmVqUK4u/Y4sfCHh6gGjaAOEKXGm3Evq/vmq0PQGgfKDCIU/n9/QBwitfgV6OQTECF
 9ynQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785946584; x=1786551384;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=cC7IuUX0kO1TajwGo/T2B8rLfA2JEYu5bvBwy+qlssM=;
 b=TrII6hHJiaO52GHM/XTb8N5El6mQef6cCtBVMAQInlhSarUtjNY5dfUBF1PY07Khzd
 9buCdEcp3M4FNuj7WXF2IE7DbXTRi1hpFmWonJ6zqbmWGnt00PTMhzJgoBbVFEQF6EWP
 fn7G3FSG61leyaoGTLBymOl9JfHUf/0fq2hiKzMtGmfDxCUXjf4RyODhImZyU8h5RbwO
 SJ0GTArAecQLC5+UM3cyg7jBcQmI4XNST8q1af+KxjLzHmkQ2zW8LbS/LNTWEoYab5Ef
 QHmeQ2J5BVgJh0pATk6IoGx2kZeNoIGkFZpOPbkNHyDo7Bvp5HvoctnntgG2gLuiGhaK
 hYTQ==
X-Gm-Message-State: AOJu0YwTkHpV70ZV+iwmmOh8FD9VFBzul/tFBFjvd3LFESd7sKW/a4Rv
 pponnwMQVSOziPMU4De3FSk7a4F3bDsom1KbRxPoA5kME+a0e2lkU5VCYTeySuBWA1XAsYe7GW/
 dpnfCOF8CVO7bfPlR44DO3k7t36eXCkhTQ8U2LmNnJGQ4kNR5Y7MXHROtFQ==
X-Gm-Gg: AR+sD12DqVmQfSg2FmmbMgWzqv50X/0JcVPfiDJJP0jZC33EpE1XQam1ZKEfeb7skOw
 suLu3bi0K3ZbGHccZjULX2L4uzXrv9+lpyPZ20JBzUrlgJ/f5n5mkjuAtoBvUL+va8caUIgOE0e
 4xRcfX4iO1ywLBGKb1QOdxU/oPBIpFGAHgtQXkyWn0+0qqR7SuYSY//wXBcKm2hB35YSqKsgP83
 DeojDDCGpti4Xt8jgNmWCnFwojmcZLu4JkDENGLzVptE/2b5WpJxQ/bplNJJ4uea+1PE8t1Got+
 WPEVw3oNeduCHhnZjaWlSM9n35Iy+3pMXSfSfLoe7D4a7+3tH3MjRiMO7U+1w31SmuddvkUmLaF
 us7AkuMo6H6CUOeTCCJqWfFB/AH4wnxfr/x3TLlNurWNVvSLzMD1bmr1VUS55libd6g/M
X-Received: by 2002:a17:90b:2745:b0:381:3b5d:30f4 with SMTP id
 98e67ed59e1d1-3903c535d84mr9296971a91.1.1785946583743; 
 Wed, 05 Aug 2026 09:16:23 -0700 (PDT)
X-Received: by 2002:a17:90b:2745:b0:381:3b5d:30f4 with SMTP id
 98e67ed59e1d1-3903c535d84mr9296897a91.1.1785946583282; 
 Wed, 05 Aug 2026 09:16:23 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315867c6a29sm17762462eec.29.2026.08.05.09.16.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2026 09:16:22 -0700 (PDT)
Message-ID: <adfd5a5f-c237-4634-9c0b-14389c0f3585@oss.qualcomm.com>
Date: Wed, 5 Aug 2026 09:16:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/27] include/qemu/target-info-qom.h: declare
 TYPE_TARGET_SPECIFIC interface
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
 <20260724000948.234657-2-pierrick.bouvier@oss.qualcomm.com>
 <anNDM7WAvxY5tO2K@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <anNDM7WAvxY5tO2K@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: IfyPheKC4O253Pdmv_X0s1LPN2rYstKD
X-Authority-Analysis: v=2.4 cv=aOfAb79m c=1 sm=1 tr=0 ts=6a7361d8 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=rJkE3RaqiGZ5pbrm-msn:22
 a=EUspDBNiAAAA:8 a=x0Ui9Yw8a6ZUUr44vfEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1OuFwYUASf3TG4hYMiVC:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEzMyBTYWx0ZWRfX/zbufHRec8od
 AV2UL/T94vR9hrM3y+7lr+VXLzb+RaFQ6lxYB4hkbFzK7UHsoMTz3/qHyV5c6wqr9iYq/s/awJq
 APFDY7WHR9EnSdmlkshkBfAZO2NWH+M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEzMyBTYWx0ZWRfX+FOz09nWt/8f
 HvZX5GI+aAVj7CXDNgh1uy71dKMjcGcoxqehdD/JdDMITXIlNHwj3ExJw8DIlSSg5p5f/jG+o0p
 LcEp++VkCmssRNctrTDZz6HG5vUmFFp0T+AFyoncPFKw1ABqbZXvpkmtfnvRIU1x2jHiNPc+4m8
 KLl8o+YIcuPhl2au6pv+meDoISz9sTLHRwSSoxoeJIb8k3xKL3/v1Os0oZ6ad/j3fkTctAMSsEP
 ejE7uguxOKBotl4jJko25/4R3Vv6xLoeswsn2SekiMZH+kHQYtL9Oggv3GxkGmoC05WOLvH+Fs7
 rsqRGsd4NDjeWv7/b6rn7eJJ7iCTSW6zyY4GPsOrGt5yx1nRmNvfKSfQGOS68Xh6Pc2qX0XGrdu
 vtvcltRKNORkIwZej9A/Ju1RytQaKOZufWqO3YqK89g8yYxMYMHoyEycfQC9Ppi7UBmC/MCniAX
 2pRoluWIQO7osWgmQcQ==
X-Proofpoint-GUID: IfyPheKC4O253Pdmv_X0s1LPN2rYstKD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 lowpriorityscore=0 spamscore=0 clxscore=1015 phishscore=0
 malwarescore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050133
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

On 8/5/2026 7:05 AM, Daniel P. Berrangé wrote:
> On Fri, Jul 24, 2026 at 12:09:21AM +0000, Pierrick Bouvier wrote:
>> In the next commits, We'll replace the logic to filter QOM types per
>> target from a static one (based on INTERFACES) to a runtime one, based
>> on is_available() function, that can be overriden per class.
>>
>> Introduce the new interface we'll use for that.
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>  include/qemu/target-info-qom.h | 15 +++++++++++++++
>>  target-info-qom.c              |  5 +++++
>>  2 files changed, 20 insertions(+)
>>
>> diff --git a/include/qemu/target-info-qom.h b/include/qemu/target-info-qom.h
>> index 91be415ed33..83eb537333b 100644
>> --- a/include/qemu/target-info-qom.h
>> +++ b/include/qemu/target-info-qom.h
>> @@ -14,6 +14,21 @@
>>  
>>  #define TYPE_TARGET_INFO "target-info"
>>  
>> +#define TYPE_TARGET_SPECIFIC "target-specific"
>> +
>> +typedef struct TargetSpecific TargetSpecific;
>> +
>> +typedef struct TargetSpecificClass {
>> +    InterfaceClass parent_class;
>> +
>> +    bool (*is_available)(void);
>> +} TargetSpecificClass;
>> +
>> +#define TARGET_SPECIFIC(obj) \
>> +    INTERFACE_CHECK(TargetSpecific, (obj), TYPE_TARGET_SPECIFIC)
>> +DECLARE_CLASS_CHECKERS(TargetSpecificClass, TARGET_SPECIFIC,
>> +                       TYPE_TARGET_SPECIFIC)
> 
> Looking through the series,I don't really see the point
> in this interface.   Why is this not possible to do by
> adding 'is_available' to MachineClass.  It would make
> the rest of the series simpler and especially avoid the
> need to introduced yet more series of macros for defining
> machine classes.
>

We'll need the exact same interface for cpus, and devices also. IMHO, it
makes sense to have this in an external interface, instead of forcing it
to be present in all cpus/devices/machines. I also considered adding it
directly in Object class directly (would be the simplest), but I felt it
would be hard to motivate it.

What do you think?

> With regards,
> Daniel

