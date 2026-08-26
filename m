Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A88C61DBE
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 20:42:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzKRa-0004hG-SY; Wed, 26 Aug 2026 16:41:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzKRS-0004dL-9Z
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 16:41:51 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wzKRO-0002vT-KS
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 16:41:50 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QKdXEm2584033
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 20:41:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 2vSNcTLBLJ2fIie+ToClEkp/ds+Bi6cQu31VElmqUYo=; b=ld4WqZ1TDt6V9boS
 20p3tKVf/+suGaj5w+VhWlG0W8du31qJWPpPgj22z0E/B7ltrCr0RUm79T+ckYok
 cbWyse76AWCISw53yHpk/ImTRyj7aW+uE8RyhTrvH/DRLU51isIKxpwwfVb0yRjH
 UeTEJngTkl9fKtQL2ZSP2xu/mxCy2sRAHXvI1ZolQr9dkKSE9W7yuqEPySCL14zO
 +DNOA1tedlepnz3MF6Bsc0XGLeuCfiScyb3NApsWF5Pmj0uqmIBNMCJuBuwvtbo9
 kzVdSaTH69YZUBPVXv+oBPo7v80JNk/LbeEkKwi81GJpxMNucr1xCh20+F5xQ73e
 Pke+qA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ga0wbsnsj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 20:41:44 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93771aa0379so196293385a.1
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 13:41:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787776904; x=1788381704; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2vSNcTLBLJ2fIie+ToClEkp/ds+Bi6cQu31VElmqUYo=;
 b=aqpcLZrOCYU+pOk5X7DT45nXXGxZODHwV6+sTXIIpl2GqHdBS4N0tcRtmwEyeXP7gx
 4smmU19wJE5Ba+4iTUebdAtH+MjaykbDq6kELswi6g2iDeHfIcO7acWh0+ub8h23GodM
 lPCl/hWCK6CFsO+0MVgsPvr7pg2LHPWLO0rSR79dOgzOPPV3i4wlU+j+29KZOobGlIio
 N0Vf/j/P5wndHK2tVTWsM/S0j3I8TVKZn12x+XZg01P6O+Z1xpbNxFbeqzjHzcLibeq0
 7kKbgGkrQrjX4UolA97l1mWqOZ0W2+ivjTURFX/vZTpUeYBOz/qkHm5A6ksJtuEGrSJ1
 sM3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787776904; x=1788381704;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2vSNcTLBLJ2fIie+ToClEkp/ds+Bi6cQu31VElmqUYo=;
 b=esICIooVQMshkv0hsnQ17/VgR+4+j8kLOZyZC1y7Pb28WQpf4g1wNrLIAQLR42sDke
 P8v0GME7Eq4IM6+kQnvRPKSEddYULs7C/jDGpa8ry5aFC+miXtcNHMUhNn9CWuEnSXnf
 TpHpsAx66cFPgU7BvCP/cAmcdk0WZbhikp8RhXOMksuToHRyyehgZ5q22Tvvpd8NSbaN
 Tqp+P/MEsShhcaVqBVrBlekdVV/ve4luKzNJVsA7H9MitByk05tUkJ+m18J2/Z2tNyWc
 HvYuCAFw7lUEcxZexOWmBrq1wjN9LloZLlL6w448i64k+6M2quAS767eK20SH/DGbDGp
 TR2Q==
X-Gm-Message-State: AFuF++mVjj9sEk8/holLOFOMlr/dWzw73SuBe+fjXzaIb4tnY2PU7Wjf
 r4Lgb8ix3k4zosfx3jVERLT3JkweyIZAUXCZ7C61+z6lWAyoKbrFuxSjJkTLGeXoThE/XTcAMKa
 kZXFZPnmHlv7t8p2bEqjlIiwt26DVc5lpE0cWdLyeE9iioVkC8/62KxJNbw==
X-Gm-Gg: AR+sD10v/cX42/qP5mLEDnU1t/d7/yKD2DKRQ/zybkjsI0mvFBMY5cJ/qMjn6qBvmhi
 RHqnQti2/fnMBPLv54tY7YdK1GV6ekPc8xAEQrT2HZ2ANtCDI4k0vLJDWuBXdGCoCDNobtXSi2Y
 QiraZTWyWk2Kt8aY8zMsopFUqCW1b3YS67OAKUyBFnx6+r+Bd6vdN5/juRYPPIVkzLnju64676K
 DQG/cx237r8bwz/QwdMJ/y5cEPL9Y44yAcr/3r0TaszkANnEEaBbKUNMO4NXojIQ6OTK9qDBqAT
 3phB1Tk9w4CsOvf8MnclNZc4MBcuc3fmC9mEbM3Jw4WBceWitvMngUKVaXq7DSaW3tsSW0DG8XC
 7ZCpJQ4alcDXfXk0BqGeJUPgSprS00035bZtk
X-Received: by 2002:ad4:5962:0:b0:8f2:fbb1:cec4 with SMTP id
 6a1803df08f44-90cc7a180e0mr98061446d6.19.1787776903303; 
 Wed, 26 Aug 2026 13:41:43 -0700 (PDT)
X-Received: by 2002:ad4:5962:0:b0:8f2:fbb1:cec4 with SMTP id
 6a1803df08f44-90cc7a180e0mr98060816d6.19.1787776902826; 
 Wed, 26 Aug 2026 13:41:42 -0700 (PDT)
Received: from [192.168.68.100] ([189.38.141.232])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-90cc6507eddsm35004516d6.30.2026.08.26.13.41.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Aug 2026 13:41:39 -0700 (PDT)
Message-ID: <7f865144-dc5e-4eaa-9704-8cb3cc6a1158@oss.qualcomm.com>
Date: Wed, 26 Aug 2026 17:41:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/12] single-binary: link ARM and RISC-V into qemu-system
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org, Xianglai Li <lixianglai@loongson.cn>,
 Alistair Francis <alistair.francis@wdc.com>,
 Chinmay Rath <rathc@linux.ibm.com>,
 Sunil V L <sunilvl@ventanamicro.com>, qemu-riscv@nongnu.org,
 Alexander Bulekov <alxndr@bu.edu>, Zhao Liu <zhao1.liu@intel.com>,
 Eric Farman <farman@linux.ibm.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Chao Liu <chao.liu@processmission.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Song Gao <17746591750@163.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Glenn Miles <milesg@linux.ibm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Stefan Hajnoczi
 <stefanha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 David Hildenbrand <david@kernel.org>, qemu-ppc@nongnu.org,
 qemu-arm@nongnu.org, Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Bibo Mao <maobibo@loongson.cn>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Weiwei Li <liwei1518@gmail.com>,
 Darren Kenny <darren.kenny@oracle.com>
References: <20260823150731.896-1-luoyonggang@gmail.com>
 <ao7c-FiawF9sMCGj@redhat.com>
 <392d0652-2d06-4889-8b67-c199e59bd314@nutanix.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <392d0652-2d06-4889-8b67-c199e59bd314@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: tGXHXEZQ6plcjtHGrIghsKI0RHi6gMsV
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDE3NCBTYWx0ZWRfX0Laq/dlYuqtF
 383ZBkIFOM9/t/dB6dqwoeCFcGiVEKgxTCQkJHLzkoaV6i1lcm8xryXJrRPeQUUVHwFQHDkFTe9
 0P5LmpSaPG20p369eH3GjK3xBjoyWSA=
X-Proofpoint-GUID: tGXHXEZQ6plcjtHGrIghsKI0RHi6gMsV
X-Authority-Analysis: v=2.4 cv=SoCgLvO0 c=1 sm=1 tr=0 ts=6a8f4f88 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=MCIxunHWmQOg/5OnbzXZaw==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=_OsohoArVhiiuAOQVD4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDE3NCBTYWx0ZWRfXwbzhum5gGqUS
 Cpy+ywvoPWIB2u2wTnzqvBPQm8ccOQNjWEU5WTUu7nFhCCmAeOMpRhpafg4LDe2cP4HKIR2qs7r
 BuPVxfElGTHAYrNKeQa6OBj6uIQ7wZHPsnI8E8beCqeHDCJKUmpUvgrVpExa8bgiHnjLQUMCkIz
 kv0rnPu/Omauegkr02dzNgfGqIFNt5ARs7CAv0MjniXp2H1WwNR0WShZ6IZcH+xiGptqCHAPhcA
 DVe/nlnRKFkjJgPXQq7u+Bk2NhRdG3cuH/UuJ90hnv2Dgz3j9AWJzoUv5T2+hqD4W6oPnsoOCMb
 0K4GFNc1gkvCwEKppOwWia5fqrw9BWno2meeK2RCloc4FSDpoq951dELwA/aLOuP9N/b2NyD9mL
 pPNF2ityckTs+p0s0AZ/SNi2FurfszYBMS/Y5xwkUqP1E16hntXbwVFjYHF6r1uIZzZNUn/4RCe
 hQ33klP9RuhnXhIy1iQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_06,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608260174
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 8/26/2026 10:40 AM, Mark Cave-Ayland wrote:
> On 26/08/2026 13:32, Daniel P. Berrangé wrote:
> 
>> On Sun, Aug 23, 2026 at 11:07:18PM +0800, Yonggang Luo wrote:
>>
>> snip,
>>
>> ..to comment just on the end result for now..
>>
>>> The last patch builds qemu-system (and qemu-systemw on Windows) from
>>> aarch64 common/system objects plus RISC-V arch objects, and installs
>>> qemu-system-{arm,aarch64,riscv32,riscv64} as symlinks so argv[0] still
>>> selects TargetInfo.
>>>
>>> Examples:
>>>
>>>    qemu-system -target aarch64 -M virt ...
>>>    qemu-system-riscv64 -M virt ...
>>>
>>> A basename that matches no registered token falls through to the unique
>>> default. A combined binary with no suffix requires -target when more
>>> than one default TargetInfo is registered.
>>
>> In testing and comparing  the new qemu-system-riscv64 symlink
>> to qemu-system vs the current standalone qemu-system-riscv64
>> binary there are some significant user visible changes.
>>
>> The simplest is 'qom-list-types' went from reporting approx
>> 770 classes, to reporting approx 1530 classes. IOW, the
>> qemu-system-riscv64 binary is now reporting supporting for
>> all the classes that were unique to arm.
>>
>> The '-device help' output similarly shows a great many more
>> devices
>>
>> TL;DR introspecting qemu-system-riscv64 is no longer accurate
>> wrt riscv64 capabilities.
>>
>> This is not suprising, since we register all TypeInfo meaning
>> we get all QOM classes present. Some of Pierricks patches try
>> to filter places which iterate over classes, but this does not
>> have full coverage.
>>
>>
>> I think this is probably also what leads to the increased RAM
>> usage in qemu-system-riscv64. Starting
>>
>>    qemu-system-riscv64 -nodefaults -display none -M none
>>
>> shows an increase in RAM usage from  17.3 to 20.7 MB which
>> is about 15% increase. NB this is dirty, private RAM per
>> process. The shared RAM pages also increase but that's not
>> a concern since they're common to all QEMU processes.
>>
>> qemu-system-aarch64 shows a much smaller RAM increase, since
>> it only grew from 1430 classes to 1530 classes.
>>
>> We have many more target though, so if we assume the end
>> point where every single target is unified, the the union
>> of all classes for all targets comes to approx 3600.
>>
>> My guesstimate is that would mean a memory increase for
>> qemu-system-riscv64 from 17.3 to 39.9 MB, which is a
>> 72% increase.
>>
>> In absolute terms this is still modest, but for deployments
>> with large VM counts  and small RAM sizes, that gets to be
>> significant.
>>
>>
>> None of this means single binary is a bad idea.
>>
>>
>> My main takeaway is that we're creating uneccessary work
>> for ourselves by trying to make 'qemu-sytem' identical
>> in behaviour to qemu-system-$TARGET.
>>
>> The complex filtering patches / QOM interfaces that I
>> found uncomfortable in Pierrick's base series are largely
>> around the filtering needed to simulate qemu-system-$TARGET,
>> and they're still incomplete. I don't have high confidence
>> in our ability to avoid regressions if we go route this
>> route.
>>
>>
>> IMHO we should make a clean break with the past. Leave
>> the existing qemu-system-$TARGET binaries being built
>> from the same pieces they are today, such that there
>> is better confidence that we are not making behavioural
>> changes to them.
>>
>>
>> qemu-system should be built alongside qemu-system-$TARGET
>> and offer new semantics where it is documented as exposing
>> everything from all targets whenever introspected and does
>> not apply target type or target Kconfig filtering to inputs/
>> outputs.
>>
>> We still get the benefit of only building most  .o files
>> once, so keeping qemu-system-$TARGET is only a small
>> overhead in the final step of linking everything together.
>>
>>
>> qemu-system will still have the increased memory overhead
>> but that's fine as qemu-system-$TARGET will be unaffected.
>> We can tackle the memory overhead of qemu-system at our
>> leisure through use of loadable modules, and thus not have
>> that as a task to think about today.
>>
>>
>> With the clean break with the past, we also have the
>> ability to tackle various long standing design mistakes
>> present in qemu-system-$TARGET instead of carrying them
>> over into the new binary.
>>
>> Specifically
>>
>>   * -nodefaults should become the default
>>   * All CLI args should be processed in order from
>>     the command line, so we eliminate the nonsense
>>     where we process some -object, then -chardev,
>>     then more -object through hand crafted deps
>>
>>   * No default machine type
> 
> I would even go as far as to suggest that we should make modules mandatory for qemu-system, so that devices can be loaded upon demand during machine construction to help keep the size down.
> 
> I'll leave whether that is through dependency tracking or via an explicit load directive for someone else to decide :)
>>   * Drop all legacy syntax so we only have a single
>>     QAPI based way of configuring.
>>     eg drop -hda, -hdb, -cdrom, -drive, etc
>>        only keeping -blockdev
>>     eg drop -mon, -monitor, -qmp, etc only
>>        keeping -object
> 
> The only problem with this is that I often get a lot of complaints that QEMU command lines are complicated from retro folks who just want to run their favourite old games. Why would they want to come up with a long-winded -drive command line when they can just use -hda instead?
> 
>> We don't have to do all that straightaway. If we declare
>> qemu-system "experimental" initially we can iterate on
>> that intentionally breaking compat in releases, without
>> any impact on qemu-system-$TARGET.
>>
>> Avoiding the back compat task will give us more flexibility
>> with the follow on work when people come to create new
>> machine types with heterogenous CPU targets.
> I agree that this is a good opportunity to explore new things without being tied to past decisions.

To be fair I don't think Phil and Pierrick are basing their design solely
on "we must comply to what qemu-system-$target does and has".  From what I
understood they're trying to get the prototype out of the door to prove that
it works, i.e. "this is clearest and most viable path we're seeing to make it
happen". This would naturally adhere to what is already available because,
well, it's already a proven base to build on top of.

I believe we'll end up doing a break with the past and experimenting a lot with
it (we definitely should mark it as experimental for multiple releases ...).
I also believe that there will be things we'll figure out only after the POC
lands, so might as well strive to get to that point ASAP.


Cheers,
dhb

> 
> 
> ATB,
> 
> Mark.
> 


