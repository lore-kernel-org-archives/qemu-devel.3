Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C924606A319
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Oct 2026 18:08:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gJM5MB38;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=gXfSn9fT
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJxCj-0002LS-SN; Thu, 22 Oct 2026 14:07:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJxCa-0002Kl-DD
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 14:07:47 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xJxCX-0006Fm-B3
 for qemu-devel@nongnu.org; Thu, 22 Oct 2026 14:07:43 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69MHtVbi935780
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 18:07:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3hPK0Vhpa/9wbs/T3zc3ct7se/ZYakZCAXduG+pEtQs=; b=gJM5MB38m4yj/BKr
 0XRtqKAAztH2Z8phJQ62ssmq6BwrEZv8y4BpO0NUGlZjFgAPxpu+PaXZVgiMcDFF
 iJ6434M4CMmXIzUeYuv25K/yF6bKBns/x4C35Ux5tpGA1xQQqyYAGichJRS82Ccp
 iGwy0x3iGW5EJVMODk25Ya1NQ+64q1V2r/MvZ3cLl87e1z1kf0GDuRQxdN9wSORa
 MWXCQTUUJdkVZeQsqiakzmjZXQmuGPEU6yskpoHeZteDdKnapxTk+HgYygdbIH9U
 KYDOrDFXv0yA5Zvj/zbSH+B5kzYQcfhsPuXyTJRrA2vu+RoQcqh6yuwHHxDYraHG
 20jamA==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hf93cd2tp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 18:07:38 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-33c35f5ca6cso99700eec.1
 for <qemu-devel@nongnu.org>; Thu, 22 Oct 2026 11:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792692458; x=1793297258; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=3hPK0Vhpa/9wbs/T3zc3ct7se/ZYakZCAXduG+pEtQs=;
 b=gXfSn9fTnSILh3a6YzhMJnJUdzzd/3DPAtcNC1ji7n0sLXjcxw7oZlqPHPNXN3N4RH
 XWzwJGzBG5euAa0MQhJnRNtdE0HCLrlNTjiXJdQuXv7AxUSVWA9WMrdUMjqA7AYeTKcE
 9y8n9GJXbphBIjaw4KfTjDIHNuAN4YM1S7qQtH5qFJ/KivZFfZVK12NCrWUXK4+A2NAA
 gAU+meiMR25uzEx0Sn9XRcz90/QOwFHAburdnLRd+fTH8sLxrgrFZteY3vl1ZL8tvXd7
 hrdilAe/QhhvViOv4Ddqz5BSgC0cTdt1DKYc64qpU7iW5K61vDN8jNmIbghPGfka4rkB
 iP1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792692458; x=1793297258;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=3hPK0Vhpa/9wbs/T3zc3ct7se/ZYakZCAXduG+pEtQs=;
 b=eDXwl8iOt55IqkQms5VXXt9KAWvfPul+CadRj3s/ZjudAbf88quOv2imIbB95kEuay
 zWM1OR9lcRC5fqaUkUlH9Nw3Pdv9px4GbKEfFsvk0msSKLvd4hwA14S65DqLqAf7tHTy
 FYdCP3Qss4E2pZAcygtilAYf4H+103kWmNS1PtYyCUmrqUQ23VXkAAlesp7Ynv7WGjux
 pL2tUL1Ci6vwQQRqEND6FyMGb68EjZfLB4FmlU+EQwkOrUubwl1Cjl7ZlY4L1yzrkqWv
 MQ0QU+hAFliAPf4T/cWUYMLkkSp8wqhemgqdjPKcoUWyRNRiI3+sYiiwteVZGsZPdzc9
 LBrg==
X-Gm-Message-State: AFq9FYJlxfVPKf+KhODahFdO0wtSVAj9UKrq5lAIZTB+w4F0yN3EgApJ
 K8sJSj8o8ZbyBE+DAW+simcFwMJIOT/zk+F9f4KTWaggHDVZfYWMKzZ3yrujDod+PfqO7/g/xvH
 Kz5Bg3Rh98JrCWR0iSASBbAYoNQe3YqvpClSLSc9BYG8+mLOVkNQNghvM+g==
X-Gm-Gg: AYBFou1InPZlkmXWEk3PrOfIlU/P8JbsrqedSv8H7PbIew3t/mVYQ/0STeVNp7aS/bH
 FibA6HFC10T0xb98tyJ5/2RrbVG9jFsRWwVBRWQu5VRFyN347C51qvtM2flKAKBii9ZcTn64Rv+
 JtlmuSQ1D1DP4TKRZ7iYiWLWBUjuEA1VEhKaQDGylnG70sMXILpJu4ERExeCQ+fHzravcZg7XAm
 8X7nsDjegm5KrfAuV2L/SVb9PieOMrjIg88oK63H8Qw6fa5wribEJrwXWtHvAamzA2QmXMM/r+O
 a/aQMfSex8UdcHdoCrMZYqoq4KXw2IiqmEQzwqTi3ghfpJaLvZFju5/sg5VzV5/jIFqChnBjtjo
 GcA/x55oe3/UAU5tFO792qi9pqD00/eRLazKFUJMeQOi9wN0mFM+hYR9FazNxNdyC1Gj9bw==
X-Received: by 2002:a05:701b:465b:b0:15a:4155:3d9a with SMTP id
 a92af1059eb24-190a7c21ad5mr6691230c88.47.1792692457435; 
 Thu, 22 Oct 2026 11:07:37 -0700 (PDT)
X-Received: by 2002:a05:701b:465b:b0:15a:4155:3d9a with SMTP id
 a92af1059eb24-190a7c21ad5mr6691199c88.47.1792692456726; 
 Thu, 22 Oct 2026 11:07:36 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-195a982f3cfsm203479c88.13.2026.10.22.11.07.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Oct 2026 11:07:36 -0700 (PDT)
Message-ID: <ac640e32-871d-4365-8751-93d96cd84352@oss.qualcomm.com>
Date: Thu, 22 Oct 2026 11:07:34 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/26] multi-target: prefix helpers with target prefix
To: Anton Johansson <anjo@rev.ng>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>
References: <20261019212046.149572-1-pierrick.bouvier@oss.qualcomm.com>
 <atoF3WQrtsFPfxkP@hive.localdomain>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <atoF3WQrtsFPfxkP@hive.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIyMDA3MiBTYWx0ZWRfXzWNBiwBQDtnL
 p8Dh0olx3SGFD4321yW7GhezmgBjM06Hpsmtfw92xSczopaFOKtFDd4+bphghj4zQk12/+mt1ba
 4utSMn48lBaHIEsY7Q1/uEUR5X0OoeA=
X-Authority-Analysis: v=2.4 cv=ReAFmFtv c=1 sm=1 tr=0 ts=6ada50ea cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=P_53ZkWc76a6brgvWcUA:9 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-GUID: FoxB1ywRKu-5OdwNDO-jXhS31zbhFw3E
X-Proofpoint-ORIG-GUID: FoxB1ywRKu-5OdwNDO-jXhS31zbhFw3E
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIyMDA3MiBTYWx0ZWRfXxPFPx1HDapcE
 D95JKvV5ffiT1VzQTl+0zJQowkCOPAh/x6+EOIFIVls6hDW3YKAVVrmglexnBulHwkt0rYO4Vjx
 AysQcWxLuuXh6WlRFOmNIQX+wSGMemVpnC9t2HkSzrWKcb253VkilgwQFN1+o7TSO8JJxyNeYnS
 Td5RMmqPj7ebkXSkGV3TrmIc8VACMJyIF8Fly2cfODnzn7XoINRBqlBuav2beeWwanRTx4qiFNn
 /pud/sYmeyFLpKCgtHXwS8O/FOgLJ9m4jx5a+dieg0Byk/tgsMaizr7EfN+ogeAYRw55Cno6Soq
 NsFUZgRabQYCfciaMZ1v0uuzMR0rBlsymBHIqv2GayUKyWdZwF87bri+PKi+9RUmINY0cvAhFKT
 OjSF8Jdcq3j8l+IddBFWlcituvhtDkkIqPnuPZmk+wa5TxArVLIjYULng2TQT6dcOG2V/LmFhcz
 k+qVpX+qzOm306D16Ow==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-22_06,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610220072
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/22/2026 5:57 AM, Anton Johansson wrote:
> On 19/10/26, Pierrick Bouvier wrote:
>> When linking multiple targets together, we usually have conflicts with helper
>> names. So far, it was solved using ad-hoc renaming, but multiple people pointed it
>> would be better to have a general mechanism for it, so here it is.
>>
>> A previous series attempted that:
>> https://lore.kernel.org/qemu-devel/20260930073935.712-1-luoyonggang@gmail.com/,
>> but it was relying on (binary) symbol renaming, which is not a portable solution.
>> Instead, this series approaches the problem from source code directly.
>> It requires more change, but it's cleaner IMHO.
>>
>> Series follows these steps:
>>
>> First, we make sure all helpers and definition are using HELPER() macro. A lot
>> of helpers were already defined this way, we just make sure it's exhaustive.
>> After that we don't have any 'helper_' left on any target code. This is a big
>> change touching the whole codebase, but it's a simple mechanical change. As long
>> as it compiles and links, we know it's correct.
>>
>> Then, we introduce the prefix for target helpers. For this , we add a new define
>> (from meson) that applies to all target related code. It could later be used to
>> prefix other symbols also, that's why it's not named "TCG".
>>
>> Finally, we cleanup the previous manual helpers prefix that were added in
>> codebase.
>>
>> Pierrick Bouvier (26):
>>   target/alpha: define and call helpers using HELPER macro
>>   target/arm: define and call helpers using HELPER macro
>>   target/avr: define and call helpers using HELPER macro
>>   target/hppa: define and call helpers using HELPER macro
>>   target/i386: define and call helpers using HELPER macro
>>   target/loongarch: define and call helpers using HELPER macro
>>   target/m68k: define and call helpers using HELPER macro
>>   target/microblaze: define and call helpers using HELPER macro
>>   target/mips: define and call helpers using HELPER macro
>>   target/or1k: define and call helpers using HELPER macro
>>   target/ppc: define and call helpers using HELPER macro
>>   target/riscv: define and call helpers using HELPER macro
>>   target/rx: define and call helpers using HELPER macro
>>   target/s390x: define and call helpers using HELPER macro
>>   target/sh4: define and call helpers using HELPER macro
>>   target/sparc: define and call helpers using HELPER macro
>>   target/tricore: define and call helpers using HELPER macro
>>   tcg: introduce HELPER_INFO macro
>>   tcg: prefix helpers with target base architecture
>>   target/alpha: remove explicit target specific prefix
>>   target/hexagon: remove explicit target specific prefix
>>   target/hppa: remove explicit target specific prefix
>>   target/microblaze: remove explicit target specific prefix
>>   target/or1k: remove explicit target specific prefix
>>   target/rx: remove explicit target specific prefix
>>   target/tricore: remove explicit target specific prefix
> 
> Hi, since this allows us to link different targets together with clashing
> helper names, what about going one step further to allow symbol
> collisions between say riscv32/64 etc.? It would make converting targets
> to heterogeoneous emulation much easier since you could just compile
> op_helper.c and translate.c twice and select different function pointers
> based on target_*().
>

We had this idea also while working on arm/aarch64, and resisted the
temptation. That said, it was only because the code was correctly
splitted in different files between 32/64 variant.
For riscv32/64, I can understand it's a different challenge, and it
would be worth exploring the idea if it's not easy to split
implementation between 32 and 64 parts.
I remember that Richard was more inclined to do the proper refactoring
required for other targets though.

Regarding current series, when the time come, we can simply replace
TARGET_ARCH_PREFIX to use the full target_arch, instead of just
target_base_arch.

In all cases, if you want to demonstrate this (on one file only to save
your time and energy), feel free to send a series exploring this
approach so we can talk about it.

> When I played around with this I ended up splitting helper.h in to
> helper-common.h and helper-target.h, where the latter would get an extra
> helper_*_tl32_*() prefix and could be compiled twice. But I recall you
> mentioning this might be too much helper magic.
>

I'm not a big fan of preprocessor usage to create duplicated definition
of macros, but it's a personal preference, not a general truth.

In case it helps with duplicated compilation of files you mentioned
above, feel free to show an example using it. I suspect it won't be
needed with current series though.

> Just throwing ideas out there, either way the current series is good.
> 
> Series:
> Reviewed-by: Anton Johansson <anjo@rev.ng>


