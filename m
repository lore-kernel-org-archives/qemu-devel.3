Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E72BEC55174
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Aug 2026 16:20:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wreLv-0003Rh-VB; Wed, 05 Aug 2026 12:20:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wreLu-0003RV-NI
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 12:20:22 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wreLs-0007KJ-Dt
 for qemu-devel@nongnu.org; Wed, 05 Aug 2026 12:20:22 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 675FVL0q2655643
 for <qemu-devel@nongnu.org>; Wed, 5 Aug 2026 16:20:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rg5t26iOfaIg5pKXwIXtLiQv+JY5DjfD4nsU12H84aU=; b=bskyPsDkFUL3Ed56
 dxr9g3Ne2hmsuKfXWtiDuiW/GqV8A3M6lXh7ABtRAamwLdYHXvx139yJizeE8AY7
 y5oYT4V9zkS2TsGMRnFRBB9Zrw2XJzkI09Z9u0gA/TDu+aI5X1W/3Wc4ladeLu+E
 Md2+dGAysDU4331SCEP/BSvSlUJYm3mRWSLxYBt/Z49yR1euHF8jhYdhHjTfTFWr
 VfHEBVFGfPZwsg+PutkydOPJQGhVLZ0OSdvAxuvKkasIPodOXwthWbNeGRuWGmNm
 qcQOtIwBoR0CiMJnHBRLa7mI1RVAGfzDuR9QJlJ6dOlZ5CUM+vqS2gycaCW8ja5C
 5gdayQ==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fuwbqu9rh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 16:20:18 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-cbb92868263so1296693a12.2
 for <qemu-devel@nongnu.org>; Wed, 05 Aug 2026 09:20:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785946817; x=1786551617; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rg5t26iOfaIg5pKXwIXtLiQv+JY5DjfD4nsU12H84aU=;
 b=G51gBKQOvAhrVCqRF+QJsIax6ND6dcdxo09sLRl2kyxR4bikj2DQ8hqEwC2b/V4EAB
 KB9/nQdb1Jm5WfezcGWkctxYi6eXHVasG6veBpFi/JOQsSw6UfMjeAJcUTDwuPGtGsqY
 fBKfr6xs4rvldvtpv2zlQzIZBejdJuYg2T1KwGAOQytvHmeHGTCYxGANYYIonJxtp4oy
 oBPnG9W66FazeTPeVY0fvF0ZojUVp4JGSDkeMNNdESoKa1YP/mkzdrfQOf+dTnWNuEFF
 tiFLVFqp/SzuAsF5M8DZVk90rwIjpfFJqMA5aaxAb4/QHg6l4FMOt46o9YEDmw/Ugrae
 UjmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785946817; x=1786551617;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rg5t26iOfaIg5pKXwIXtLiQv+JY5DjfD4nsU12H84aU=;
 b=FWLma7awqZx4HIWdftYu1gNrTCwrwlYxlMb1qOxUKSAzSPcfioxUXYnR1p9vygskok
 MIl6QCKQGyfymfz9sdZo3AXZs7yLuLvjhadl3Fm0s+Gj/UjxSkpOaSbFKskHRuSyil0Y
 IunkL7rZ/P4b/jfkwkvuyFKppbFPr7LZZsTFD5KkCAxsJdNC9/jaKB/37hBz5XGD2OQ5
 +ldEstFl1gxGIwUIFuPzSUCuZP+JaNv3Fh+yRRc9wTjURZLPD6iFdsjoJBcVMu7K3kkj
 nq8UpbqOMr6FlrODnrId0fQ9e2Q7fcFxhULtVKan2Yvf0J0/7Bo8kl9T0cQiSDH+ozNW
 hCGw==
X-Gm-Message-State: AOJu0Ywmlb7EcV0GgrKw088y9iILxqI5YFRddtVTqblGnnYN+Z4yz3Oi
 t4c13VhyHPT5orDpeDlM+kMia09OtJP25W9Hp/4edLMc/9JI/benVCQfBZ+O1/3Md49ZFNFyh/4
 E7ZlFdY/klzzEHR63xIOUsXyOeTJeKXCfi5/YTrgexfyv6JdobgL3ujsHkQ==
X-Gm-Gg: AR+sD11DwmqSZcwLlibr1XC9uuMDFc/XGSKLMjo/oCsW+0pbrIiXVvGnngWjFH8k2RU
 sVGyBGrG2y6LaT3YWlOnMEP7qyMgJkM28L2Iaht44afhMEV20M1D8CJ3iTVTJqLmTufRUWI3WY6
 3pOxVwsnkVNB7pycyjXNW+S0VwDjmHNXjjpprHoKYJsIVAvQgOtkL2GGO26HPIt4XjhIWbjowXG
 C5PHrK8XirQxtUwxoZs/wRsUqjV4NRMtFlS76DRQet5MVHpjCk/I6kyIgulftQViZ8QGPrMJs71
 W1aPNU6UZh/AfR7RQlQhTfTwu0BNkXh8zQjuCjqF8vu4ps8Zwrp2jY7LLzLdT9xeU3e7KQ/65m7
 VByOiWjFOMsHARX8HB5PAVSZHKVN6KeObzRYLqetAKot/xUIbimnhaZV66IIUuRO0cAaq
X-Received: by 2002:a05:6a20:258e:b0:3c3:875d:7053 with SMTP id
 adf61e73a8af0-3cb85df192fmr8320127637.8.1785946817253; 
 Wed, 05 Aug 2026 09:20:17 -0700 (PDT)
X-Received: by 2002:a05:6a20:258e:b0:3c3:875d:7053 with SMTP id
 adf61e73a8af0-3cb85df192fmr8320047637.8.1785946816783; 
 Wed, 05 Aug 2026 09:20:16 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-31586777bcfsm26255151eec.21.2026.08.05.09.20.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Aug 2026 09:20:16 -0700 (PDT)
Message-ID: <8726ffd9-542c-42b7-b95d-b872ba6b21ea@oss.qualcomm.com>
Date: Wed, 5 Aug 2026 09:20:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/27] single-binary: implement dynamic filtering for
 machine types
To: luoyonggang@gmail.com
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Bernhard Beschow <shentey@gmail.com>, Anton Johansson <anjo@rev.ng>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20260724000948.234657-1-pierrick.bouvier@oss.qualcomm.com>
 <56625144-c2fe-4017-90ed-473e570fa35d@oss.qualcomm.com>
 <CAE2XoE_-amik0TXZFTKiL2o1hOd-Qo0zkBHrdrSGnasLxA6q3g@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE_-amik0TXZFTKiL2o1hOd-Qo0zkBHrdrSGnasLxA6q3g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: iCaD2_uPlFuWWmyGPMlbrWLrD2YfHfRY
X-Authority-Analysis: v=2.4 cv=B+uJFutM c=1 sm=1 tr=0 ts=6a7362c2 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=xOm3KdCdzxGWDFL3HHIA:9 a=lqcHg5cX4UMA:10 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-GUID: iCaD2_uPlFuWWmyGPMlbrWLrD2YfHfRY
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA1MDEzMyBTYWx0ZWRfX8LOhLH0AJsED
 rUITtKQfBGp9sV+5kIjUJaA5Efg2RlUUspF+RfHSiJ3NZulWVcRUmIkjishDN/uHKNBgcXLgC/X
 nvC73hSxwcltEAuRVaM/zr2T4AdHRrw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA1MDEzMyBTYWx0ZWRfX8MJ2mkxQCOgr
 F6vK/fjY/xv7VKbMA5eQHB6n0aDzR4zNSra0lGHBi68jIs7AWCObge6gR3wkVzHZbE4VDZsag7L
 TErh1FYVZbYy0f5N985c3smHav9qhj56CcdzcuSgQdcSmvI59iaXhzOf3u4S0afJZLY2mNHTlFu
 9L3e0RIbqRFjSQPQJRa0uIqVVObbc2mPf4XIl3hmi9pF4bU93ixgbW+mmwTenQOW49jcYl8Sgb+
 dWXGjHgA2mEkdTSA43mSGi4maxcPy5sCVo1Zp9l8H53zo7VKvP4NtmieXUHgIG5H85tXOj53CH5
 Jbj91HsGGTx5cLwuc338FTepMBFmZZgwNaVq4SHjQ3u8wEI7uhT/c077Hh05yP3btEzRymqoNt8
 yCtTNam1P55V9gv4mctdrp39pU+Ie2tUy8OJFdtDRm5UDQ4fZx5KrVAfYhLLmGUdnqCRP2uZepY
 66gO+LrpRcIVRsdMdxw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608050133
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

On 8/5/2026 6:30 AM, Yonggang Luo wrote:
> 
> 
> On Fri, Jul 31, 2026 at 1:34 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com
> <mailto:pierrick.bouvier@oss.qualcomm.com>> wrote:
>>
>> On 7/23/2026 5:09 PM, Pierrick Bouvier wrote:
>> > Now that we can link a single-binary with at least two targets (arm,
> aarch64),
>> > we want to make sure that we expose the same set of machines (later
> devices and
>> > cpus) than target binaries. For that, we implemented a static
> filtering based on
>> > target interfaces that each machine will implement to declare which
> targets have
>> > this machine.
>> >
>> > However, we discovered that this static filtering is not enough.
> Indeed, some
>> > machines and devices do not depend only on target, and their
> presence can depend
>> > on Kconfig or host/target combination. Thus, our static approach
> can't work, and
>> > we need something more flexible.
>> >
>> > This series adds a new TYPE_TARGET_SPECIFIC, that declare a single
> function
>> > bool is_available(void). From there, any machine type (and later
> devices and
>> > cpus) can implement it to override their presence for each target.
>> > We first replace the existing static mechanism with this, and once
> done, we
>> > cleanup all the old interface. One nice benefit is that we can get
> rid of
>> > config/targets/*.c files, which saves duplication.
>> >
>> > This series was tested by comparing list of machines for all qemu system
>> > binaries, before and after this change, to make sure we don't
> introduce a
>> > regression.
>> >
> 
> I am also tracing for this. So what's the shape of the final command line? 
>

I have those commits ready, but I would like to get filtering done
before so we can focus on command line independently.

Currently, what we have implemented is:
./build/qemu-system -target {arm,aarch64,microblaze}
Or
cp ./build/qemu-system ./build/qemu-system-{arm,aarch64,microblaze} and
there is no need to use -target in this case.

> Maybe we can at least get arm/arm64/riscv32/risv64/riscv32-be/risv64-be
> to be in a single binary.
>

v0 will be arm/arm64/microblaze.
risvc64 is a wip, it's not yet ready for integration.

> The -be is needed because gdbstub would need this to get gdb working
> fine. so the endian mode is important. arm/arm64 have nothing about be
> support yet, even though in spec also have
>  
> 
> 
>> > Pierrick Bouvier (27):
>> >   include/qemu/target-info-qom.h: declare TYPE_TARGET_SPECIFIC interface
>> >   hw/arm: implement TYPE_TARGET_SPECIFIC
>> >   target-info: add target_riscv32 and target_base_riscv
>> >   hw/riscv: implement TYPE_TARGET_SPECIFIC
>> >   target-info: add target_config_multiprocess
>> >   hw/remote/machine: remove unsupported arm target
>> >   hw/remote/machine: implement TYPE_TARGET_SPECIFIC
>> >   target-info: add target_config_xen
>> >   hw/arm/xen-pvh: implement TYPE_TARGET_SPECIFIC
>> >   hw/xenpv/xen_machine_pv: implement TYPE_TARGET_SPECIFIC
>> >   target-info: add target_config_nitro
>> >   hw/nitro/machine: implement TYPE_TARGET_SPECIFIC
>> >   target-info-qom: implement new machine filtering per target
>> >   target-info-qom: use TYPE_MACHINE instead of target_machine_typename
>> >   target-info: remove target_machine_typename
>> >   target-info-qom: add type_target_specific
>> >   hw/arm: remove TYPE_TARGET_{AARCH64,ARM}_MACHINE
>> >   hw/arm: remove {arm,arm_aarch64,aarch64}_machine_interfaces
>> >   include/hw/core/boards.h: add DEFINE_MACHINE_TARGET_SPECIFIC
>> >   hw/arm: remove DEFINE_MACHINE_{AARCH64,ARM}
>> >   hw/arm: remove machines-qom.h
>> >   hw/riscv: remove TYPE_TARGET_{RISCV32,RISCV64}_MACHINE
>> >   hw/riscv: remove {riscv32,riscv32_64,riscv64}_machine_interfaces
>> >   hw/riscv: remove DEFINE_MACHINE_{RISCV32,RISCV64}
>> >   hw/riscv: remove machines-qom.h
>> >   configs/targets: remove target info definitions
> 
>> >   target-info: rename target-info-stub.c in target-info-def.c
> 
> Does that mean  target-info-def.c would be compiled N-times. N is the
> target list count and finally linkage into a single binary?
> How to choose this target-info?
>

Yes, correct.
We choose either from -target arch, or from binary name.
In case a single target-info is present, we don't check binary name and
simply use it.

> 
>> >
>>
>> Gentle ping after a week.
>> You're welcome to review only your architecture if time is limited, and
>> validate the global approach.
>>
>> Regards,
>> Pierrick
>>
> 
> 
> --
>          此致
> 礼
> 罗勇刚
> Yours
>     sincerely,
> Yonggang Luo

Regards,
Pierrick

