Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02C7606A31A
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 01:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=knvkgoU3;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=FN++Mmrc
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMyGf-0002rP-EO; Fri, 30 Oct 2026 21:52:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMyGA-0002p9-Ma
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 21:51:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xMyG7-0004kB-2P
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 21:51:53 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69V1Ceu7749677
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 01:51:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 9EYJOM0H9dJD2hgklOIl9JoR5CMKcX6ZZzpTCEQjgyk=; b=knvkgoU36fxNqvHI
 APfyHeBmKE5zbj3iokodOvop9u//Te8eAgfU8vhwHL2qknoF/LTG+CChpV6kXyys
 W9mgKu52yLpwRiwBgawRXdyksPhxbRrcGSPSS3XsT5j19GWxPiRvDFE4yawnjbKe
 3+cE9yJl6FPhtLhZHqbJ9AEPF0oh+XcfEz21v0QLcRsQag56kThffwM7nO4FF/XS
 4OCAM9pYQfzRbAGHY8AVkD6tNXQZQwtKTWOrDX8fXIE8YYw3t50cv7WFMYo/nwJU
 fjTt/c5fwPZHe1xRhJ41JhfUWHwtBDx/G1uV5pc/qZsoox7uMxXTl3evB7hK7w0H
 SsRVDg==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hn2x00p23-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 01:51:48 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-36a3451ea93so2067572eec.1
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2026 18:51:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793411507; x=1794016307; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=9EYJOM0H9dJD2hgklOIl9JoR5CMKcX6ZZzpTCEQjgyk=;
 b=FN++MmrcUHmikLc9ckgYuURn0r6AqRaCv5Fprb7jRG3Je7GvD9D+M0u3AooiPZvZQR
 FKHXdDbblHlLa1GGVDEh9fxTA/+6o/3kbNqMkBbtBvVHZmuWm8g4uoSIIJIVdCDPpFmc
 i0WlQgoYB3s0jOK3YQktHLqz2u5pu4PShT0ufsUKy8EFmGmv3uj+SeYL2EDJIi8WFD/6
 iZFBq5U/1gj3uNoNCGu683Tl94Jaqbqui29tuNurhC3rL84E1ogI3EcNkzQq4JfY+If5
 Awzxosti8jBTNG75aVNP9zuQU0Q0PzmfFwIeYUMaRIckt8gKzd2vihISBl7ZhyAubJCA
 Ci+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793411507; x=1794016307;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=9EYJOM0H9dJD2hgklOIl9JoR5CMKcX6ZZzpTCEQjgyk=;
 b=uS11R4RFIyl14arvqc9LQy1TIEmNKBNwWR8S94+ZzQ2mwTd8aB1ciY45/sXvpBP0iV
 nkgl9jbVQ3n72qLWd2PJYmnqcDm6NHZj6o7TdBnY3JiYB+CLQjpUIfIW8BH02PbDn8vT
 iNWyOqw21sTxqRwVP32YrTjJEC029cIONEEDgmmxJ/Mz8EQSlhxUBJm1OGQ4SzPZuMSR
 c8yDDy6HahkfsPMFBajJ7tD6Y/2NTkan7ukQ5p4rKXZTpLKQ05np2FrYgZbd0eVNk1rm
 NNhoHJ+Tsyq9XTL4gumc14dxCKHrGrhVPJ9Hw0T9PP3cVxRfbDG7bWXU2h4WRh13Eo6u
 fasA==
X-Gm-Message-State: AFq9FYILb7lRV7VrIvnR0iHJBtvZiYG6bKL/iJBvNaJ6eW6RsoYWEoZo
 p1ceGu/tiF3bToEwKuC9FKnle2oBXYYE9QfPalqrMkTzhZAmc+6xYdzZxqLNxwNY1cLXyENYS5B
 b5NID/qSwkSfMoSOR/Q38gSHp/BigBYLy4c0imS2G0Ighh9ZEfexvHxUqrw==
X-Gm-Gg: AYBFou3ZHJollCwKVCAONzPYUWx52Ml++4wl6HRyEFjPD30QOMQw187h/gUxFgwkXdN
 BgjVCy1z3G1UdOOSpcqrM1ZzsVYPwEdT6SGmPdro6tHYGacSQ6NX0GtmXcZ0BSahvdJYtX8WLK8
 wTSyQeZdZiT/Za0FXUM8GYZjSo1n6zqQ2RGERcEraSH5bLAs8Rwwbs2AtKlKyrbdnxcaZNv5ByM
 LT4w4G9LyjJJuhgtepAXuN1OtIrcGrliTXcsvoMUfwmtXexM949We4mKrVufP9VaMmo7+7QT9eU
 UXx4UrdXGZ0/0eDzfO1WsvdLUWKvKhtyxDLAqIPPq02CztYXOQpJSCdIJ42ruc1qRI4NHQ3L9w5
 6pW63IaGIWGh8+hEDNck8csJezp6tlhXW2vCtuYfA79KVNCQ4fxzFFMNuK1M/0dkTPGtHgyvhJV
 nFOEJtY7Vd8iUjyxNYFivBhA2iA0DPb/ZOai5n0sjSt6I=
X-Received: by 2002:a05:693c:880c:10b0:35c:cd26:3066 with SMTP id
 5a478bee46e88-36a424655bcmr5937758eec.41.1793411507347; 
 Fri, 30 Oct 2026 18:51:47 -0700 (PDT)
X-Received: by 2002:a05:693c:880c:10b0:35c:cd26:3066 with SMTP id
 5a478bee46e88-36a424655bcmr5937730eec.41.1793411506763; 
 Fri, 30 Oct 2026 18:51:46 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-36a42a98f65sm10975065eec.28.2026.10.30.18.51.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2026 18:51:46 -0700 (PDT)
Message-ID: <aa70e94c-d9a8-41c9-850f-7ded87f7f327@oss.qualcomm.com>
Date: Fri, 30 Oct 2026 17:51:44 -0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/15] hw: expand DEFINE_MACHINE to explicit TypeInfo
 registration
To: BALATON Zoltan <balaton@eik.bme.hu>, Yonggang Luo <luoyonggang@gmail.com>
Cc: qemu-devel@nongnu.org, Anthony PERARD <anthony@xenproject.org>,
 Felipe Balbi <balbi@kernel.org>, Aleksandar Rikalo <arikalo@gmail.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Antony Pavlov <antonynpavlov@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Subbaraya Sundeep <sundeep.lkml@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 Max Filippov <jcmvbkbc@gmail.com>, Niek Linnenbank
 <nieklinnenbank@gmail.com>,
 xen-devel@lists.xenproject.org, qemu-riscv@nongnu.org,
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-ppc@nongnu.org,
 Alexandre Iooss <erdnaxe@crans.org>, Weiwei Li <liwei1518@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Strahinja Jankovic <strahinja.p.jankovic@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, =?UTF-8?Q?Cl=C3=A9ment_Chigot?=
 <chigot@adacore.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 Frederic Konrad <konrad.frederic@yahoo.fr>,
 Palmer Dabbelt <palmer@dabbelt.com>, Peter Maydell
 <peter.maydell@linaro.org>, Chao Liu <chao.liu@processmission.com>,
 Sai Pavan Boddu <sai.pavan.boddu@amd.com>,
 Alistair Francis <alistair@alistair23.me>,
 Huacai Chen <chenhuacai@kernel.org>, Aurelien Jarno <aurelien@aurel32.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, qemu-arm@nongnu.org
References: <20261030151539.1872-1-luoyonggang@gmail.com>
 <d1db54c6-b802-676a-7779-0c2c63f5f807@eik.bme.hu>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <d1db54c6-b802-676a-7779-0c2c63f5f807@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDMxMDAwNyBTYWx0ZWRfX80M47RLvZcg/
 aFpmPBPGm6C5N4og7doYycjgVgIjCcAFEyUJRTWh+HmkWadV7UhnF6hTl7dmxNpVY2GwmMEI6cC
 x1dQ5FByp/RkYKqUNMl0BSZfCQc0DIUmhm6IRQaySMv14JYxbO8aEN9XYADva5xuUC+ofDdtC4M
 S7bUFuS550aRzvweWqPttDswpDPCynGG/1Pr7St/aIBsbMielUT2Svvoe3jvMIw/E3oZPl8GvSA
 GaVZUYkJxxAtOIslHcj2duAR+Lkkrkvuf19A7Wqejw5X0NQUazr/jB/cddXSPO9cBTW2hITMEQU
 k5Lm36DNr0eqB9Y1vGszE8JbOu6+Hu2U3c1FOm/VsUMVlZaKySDbk/E9Xar3DR8fbmwm0paxNXk
 JeAOsppUv+lUiNwKwK0VKhUY6vNTYUOiZ0EZN5sR2eWPlqsgg4oyKbsPq3HtGBdTJTruk5rPNyY
 vDMDwJ5sANtmPiJpDww==
X-Proofpoint-GUID: zW2XPH0owuKAhofBgrkEomrLLwqivs9_
X-Authority-Analysis: v=2.4 cv=FcSiV5+6 c=1 sm=1 tr=0 ts=6ae549b4 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=3o5FCx-jELZdd1X3BU0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-ORIG-GUID: zW2XPH0owuKAhofBgrkEomrLLwqivs9_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDMxMDAwNyBTYWx0ZWRfXwGNDjXEpxBHB
 GZk7zXBxna5wePxFzUt26n0LvcLhG4kjQ8GsUkl48ybJJAqAZvCk+Y9wNGUZzBxQnEfyQieGQPm
 Ef3+LeYS3Q1t7HykodtkMolJsuZ1gm0=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-31_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 suspectscore=0 phishscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610300000 definitions=main-2610310007
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
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/30/2026 4:09 PM, BALATON Zoltan wrote:
> On Fri, 30 Oct 2026, Yonggang Luo wrote:
>> DEFINE_MACHINE and DEFINE_MACHINE_EXTENDED hide the TypeInfo and the
>> type_init
>> function that calls type_register_static(). A later change needs to
>> pass a
> 
> That's the point of the macro to hide the boiler plate code.
> 
>> target mask into that registration, and the macros have no parameter
>> for it.
> 
> Couldn't you just change the macros to take that parameter instead of
> expanding it everywhere?
>

Problem of macros is that they don't have default parameters, so you
need variants for everything:

DEFINE_MACHINE
DEFINE_MACHINE_EXTENDED
DEFINE_MACHINE_WITH_INTERFACES
DEFINE_MACHINE_WITH_INTERFACE_ARRAY
and now would need a new variant, with variant for other existing ones.

In the end, it's just simpler to remove this and add the boilerplate.
It's written once and never modified, so using a macro just save typing
those lines once.

> Regards,
> BALATON Zoltan
> 
>> This series expands every caller first, with no behavior change, so the
>> follow-up only replaces the type_register_static() call.
>>
>> Each machine file gains a class_init function, a TypeInfo, and a
>> type_init
>> function that calls type_register_static(). The last patch removes
>> DEFINE_MACHINE* and DEFINE_SECURE_MACHINE* from include/hw/core/boards.h.
>>
>> Yonggang Luo (15):
>>  hw/alpha: expand DEFINE_MACHINE in dp264.c
>>  hw/m68k: expand DEFINE_MACHINE for M68K machines
>>  hw/microblaze: expand DEFINE_MACHINE for MicroBlaze
>>  hw/tricore: expand DEFINE_MACHINE in tricore_testboard.c
>>  hw/arm: expand DEFINE_MACHINE for ARM machines
>>  hw/riscv: expand DEFINE_MACHINE for RISC-V machines
>>  hw/core/null-machine: expand DEFINE_MACHINE
>>  hw/mips: expand DEFINE_MACHINE for MIPS machines
>>  hw/ppc: expand DEFINE_MACHINE for PowerPC machines
>>  hw/sh4: expand DEFINE_MACHINE in r2d.c
>>  hw/sparc: expand DEFINE_MACHINE in leon3.c
>>  hw/xenpv: expand DEFINE_MACHINE in xen_machine_pv.c
>>  hw/xtensa: expand DEFINE_MACHINE in sim.c
>>  hw/xtensa: expand DEFINE_MACHINE in virt.c
>>  hw/core/boards: remove unused DEFINE_MACHINE* macros
>>
>> hw/alpha/dp264.c                    | 18 +++++++++--
>> hw/arm/bananapi_m2u.c               | 18 +++++++++--
>> hw/arm/cubieboard.c                 | 19 +++++++++---
>> hw/arm/digic_boards.c               | 18 +++++++++--
>> hw/arm/imx25_pdk.c                  | 18 +++++++++--
>> hw/arm/imx8mm-evk.c                 | 20 +++++++++---
>> hw/arm/integratorcp.c               | 14 ++++++---
>> hw/arm/kzm.c                        | 18 +++++++++--
>> hw/arm/max78000fthr.c               | 17 ++++++++--
>> hw/arm/mcimx6ul-evk.c               | 18 +++++++++--
>> hw/arm/mcimx7d-sabre.c              | 20 +++++++++---
>> hw/arm/msf2-som.c                   | 17 ++++++++--
>> hw/arm/netduino2.c                  | 17 ++++++++--
>> hw/arm/netduinoplus2.c              | 17 ++++++++--
>> hw/arm/olimex-stm32-h405.c          | 18 +++++++++--
>> hw/arm/orangepi.c                   | 19 +++++++++---
>> hw/arm/stm32vldiscovery.c           | 18 +++++++++--
>> hw/core/null-machine.c              | 18 +++++++++--
>> hw/m68k/an5206.c                    | 18 +++++++++--
>> hw/m68k/mcf5208.c                   | 18 +++++++++--
>> hw/microblaze/petalogix_ml605_mmu.c | 19 ++++++++++--
>> hw/microblaze/xlnx-zynqmp-pmu.c     | 19 ++++++++++--
>> hw/mips/boston.c                    | 18 +++++++++--
>> hw/mips/fuloong2e.c                 | 18 +++++++++--
>> hw/mips/malta.c                     | 12 ++++++--
>> hw/ppc/amigaone.c                   | 18 +++++++++--
>> hw/ppc/pegasos.c                    | 21 ++++++++-----
>> hw/ppc/ppc440_bamboo.c              | 18 +++++++++--
>> hw/ppc/prep.c                       | 18 +++++++++--
>> hw/ppc/sam460ex.c                   | 18 +++++++++--
>> hw/ppc/virtex_ml507.c               | 18 +++++++++--
>> hw/riscv/boston-aia.c               | 18 +++++++++--
>> hw/riscv/microblaze-v-generic.c     | 18 +++++++++--
>> hw/sh4/r2d.c                        | 18 +++++++++--
>> hw/sparc/leon3.c                    | 18 +++++++++--
>> hw/tricore/tricore_testboard.c      | 18 +++++++++--
>> hw/xenpv/xen_machine_pv.c           | 18 +++++++++--
>> hw/xtensa/sim.c                     | 18 +++++++++--
>> hw/xtensa/virt.c                    | 18 +++++++++--
>> include/hw/core/boards.h            | 48 -----------------------------
>> 40 files changed, 605 insertions(+), 142 deletions(-)
>>
>>


