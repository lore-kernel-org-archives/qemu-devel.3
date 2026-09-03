Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14152C624A4
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Sep 2026 16:29:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2AJD-0007FT-AJ; Thu, 03 Sep 2026 12:29:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2AJB-0007FG-7e
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 12:29:01 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x2AJ8-00083K-3u
 for qemu-devel@nongnu.org; Thu, 03 Sep 2026 12:29:00 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 683G33T6970010
 for <qemu-devel@nongnu.org>; Thu, 3 Sep 2026 16:28:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 wW11LO9JTao3dX3FmUKJE+NDFwq/OCDrSrVOzflvoF8=; b=PpBfO06nPZQQR0V+
 xeiUeseJx3jvWjBVt6fdXwu6OzQcmqvHAsqXdQDSaZO3i7Ta9adAVTfAhnfeEIAF
 6j5ygv+MUYhVGj7EDU9iTu0+igYqkK61um/vJdx9ftLeY+MIHh+qtQtStFKX8igm
 tcK0UBDEnKpDrgfFlJj5PcoDkko+DgfuhwZpU8ZRnFhX/z/iKsezuF4C2xN1oHeC
 uT0bHdOC3z8xzFVh5yTXtYV1VBku7hbyfyHH6rgqP1rlmC9/hzVAyqXwl7HRr54Q
 ft5L4vTiaDB1Uc5+GHLwfgdDfkKxD3RCMqeJybk2TNZD/q55cEfuMOLs2Ui7nc2d
 iKJHCQ==
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gf1pyk0ea-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 16:28:43 +0000 (GMT)
Received: by mail-pj1-f69.google.com with SMTP id
 98e67ed59e1d1-39aee9b4cf2so3976592a91.0
 for <qemu-devel@nongnu.org>; Thu, 03 Sep 2026 09:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788452922; x=1789057722; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=wW11LO9JTao3dX3FmUKJE+NDFwq/OCDrSrVOzflvoF8=;
 b=hQPKpMb3xCMoGtRqV83LK/Zwul6iySvVbQMfx70akIeG1+l50UwgGH+iog1Rt8wg5+
 RucbGI3TU8rHd3W1eho0Dj7aZwlEAG1Hh8D1d0Ml+Hn9r8sJe8oHjrcdyzgAwEGELaUI
 QMAJxAd+F2U3Udi0LRoVt0P4ckAjVB/QJ9E0okJAyaIhy+IwwFTCRVJYwFdCmJJJeaCK
 8bhnoxO5lnJaXivJ6MMYkn1vFP6SEXPVY1ZspAesAC+0DjpNRf3RaGW37tfpEmet7oPh
 xXVvOPc6WAVTih5ed8twYhb6iTNH6fTslD1AuSVCUsSuXYKzTBLAVrQ8S6IBS/TnphBe
 38Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788452922; x=1789057722;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=wW11LO9JTao3dX3FmUKJE+NDFwq/OCDrSrVOzflvoF8=;
 b=sSzIt77czoBEU49/fJ+Aas3CigCH4tG7Lm0c3Awsz22deFbLaWDh1c6seHnZJ5vGNa
 BaXsQ/R+rSSr5SE8bKfTj6kvY7ytnvFGZzsnbZqr4yXNs+svq9Sbw3nCHJh/ia4aNQEE
 Fg8TUryL6eSP3xDOnzNVqa5Qgf91GmhXxD37Wlz7R/XhnUvpxVomUsMY3PoT+Z25a9gd
 hL6uSrKUabHpxc04IJg9/cWWVDXTQrK3a3xW88FXijqYeXn87rcEVmbvQkKPBsYMJXy5
 AxpY4ASFdapOwak+eLgEdIhLmHz34qa2rpgmgwzt9FBx/PBV+qDlcHTr/AcTiKMD7i/P
 KddA==
X-Gm-Message-State: AFuF++m3rYGLPgD4lkE9yFVpa/VRjd4xsC8Z+SigTNpQPLcRv+KUeA8y
 pszjYY2zZg82okL+UXeDFmErbXEJX65hJyV5JEVGb1PRf1WuRlZcpIUp6oND/HxJy9I1Mf2IpYJ
 pYvZKVDMYmFhmZDYpKGPvmprsIXqq6IEnEMPpTKT3/hAuJ3UZnS5w94hwMA==
X-Gm-Gg: AYBFou29zBp8dE8r3xm3k+FjxQswyt7fbZWM79kPIlSX3exdcRPIHUcbKeqJ3yk4o3K
 fBP+pY7XoFDZU/5C/jFI/dUEushz/nP1zBBDLzsnnfN60MpUSjyLDtJtjIxUUfwew/EA3hcV5jb
 1gLvIsIoVutGXIuQ/NSdeoOkm399eslj2/n1vyhPNr88CW7WkamfVZ39RNCRduug1++78umfqBY
 mqvIpuldcUBgnyZF4PTQyne+DoM6/gCzxsLaku5snlMsix2L0m+uq60oChryX56KWhsNCsIGJUw
 xj9A8zJOa1r8aUUvbJ8AX7jj4sXbJdJOINfC4CI+QQMNpfNbuEiqyTdQxkfq84ey7Iq5QyeS7px
 kUMWSjB5kQuH/d329GrIG3N1PENowno1GvVrNLU9bjcRzxxsLLMgL0UGuTn7iw3qk3AxL
X-Received: by 2002:a17:90a:d403:b0:398:ba96:1afd with SMTP id
 98e67ed59e1d1-39aedfe2ef3mr22417009a91.8.1788452922322; 
 Thu, 03 Sep 2026 09:28:42 -0700 (PDT)
X-Received: by 2002:a17:90a:d403:b0:398:ba96:1afd with SMTP id
 98e67ed59e1d1-39aedfe2ef3mr22416901a91.8.1788452921714; 
 Thu, 03 Sep 2026 09:28:41 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3339ac24d7esm127603eec.15.2026.09.03.09.28.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Sep 2026 09:28:41 -0700 (PDT)
Message-ID: <44d0f561-e713-420a-a648-c7199b20425a@oss.qualcomm.com>
Date: Thu, 3 Sep 2026 09:28:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/14] target-info: remove machine_typename
To: luoyonggang@gmail.com, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
 <8a68284e-7947-4766-a42a-6dca3e1a4e01@oss.qualcomm.com>
 <CAE2XoE_zkdFEFLp_eaKbX0ftROPJXxGQvv81z6CQrdjx2k5Y8g@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE_zkdFEFLp_eaKbX0ftROPJXxGQvv81z6CQrdjx2k5Y8g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAzMDE0MyBTYWx0ZWRfX0TaJeQGJsIyM
 uG2kTYWO7jdzAmq499U0wrbV1rvowKxVI5CpgR3iYLjy0+epIildKR4CfCuFYTr9rMzXVKhL5tj
 QLqgF3gUUk+EaiejxLn56DoDH9CmDixGA/wthKdOk868bGbrDPT7hh8Cz9Cdsaz+xV4cP688yMl
 oPMYfa0pJvnaeiAZD6NVDyQWgmdnuqrRJHWuxrf5Xfhj4SjgFZ2hJdD7O4L5JA3sx6qdB7UlI3E
 yXFs0aAJYjHl/S2gJ3CNO92lHvNsk9agKqS5AaClLXFqDXOFOdU1hFG0GOjrH1k6EH+pK1x7J7a
 tMIx+vsFN+ADuAcfMwTHm9tVrLeYuUOB8m0yWbm60JkYyLClDQTyOY9OVQOPxCGe3kDZq+iOTx4
 Kbdlu7QTz0S/psGZxo+pFt/aeSZlB8S/V/u484THXNyiXZO5w1mHskClx191gjuBApjLWMVz1A6
 qlR1tsweXzaK8f+N9+g==
X-Proofpoint-ORIG-GUID: 1-0oCyctDNLb-dSbW0DLoDZqcXN7z3GQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAzMDE0MyBTYWx0ZWRfX/vmhc1eczXot
 VPGDsujD4oQkI+CFMBw+G0mJYD59HOLyyMHGqL7rYr/lKP3HuL1ECfB1VTRJm80uETam5ptXcLD
 vG3N/LfI4Duh61SOT7YPkkBB5yNjdH8=
X-Proofpoint-GUID: 1-0oCyctDNLb-dSbW0DLoDZqcXN7z3GQ
X-Authority-Analysis: v=2.4 cv=DMO/JSNb c=1 sm=1 tr=0 ts=6a99a03b cx=c_pps
 a=vVfyC5vLCtgYJKYeQD43oA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=9g6gTwUg0mpaNrSkuWQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=rl5im9kqc5Lf4LNbBjHf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-03_05,2026-09-03_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 lowpriorityscore=0 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2609030143
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

On 9/3/2026 3:33 AM, Yonggang Luo wrote:
> 
> 
>>
>> > Pierrick Bouvier (14):
>> >    qom/object: add is_available callback to TypeInfo
>>
> 
> Patches for is_available callback to TypeInfo, it's can be merged latter
>

It's needed because files in patch 2 already depend on existing
filtering mechanism to distinguish between arm and aarch64.
We found other places where such filter could be used to specify target
related types within a single C file, thus allowing to remove #ifdef
TARGET_X easily.

> The reason is for the following command to execute:
> 
> we need add target_info_select and pass TargetInfo to is_available
> 
> - Move target_info() into qom/object.c. Default to SYS_EMU_TARGET_NONE
>   until a real target is selected.
> - Add target_info_select(); it may be called only once with a non-NULL
>   TargetInfo that is not SYS_EMU_TARGET_NONE.
> - Invoke TypeInfo.is_available after select, passing target_info().
> - Change target_* helpers to take const TargetInfo *.

We can wait to have a need for this. As long as there is no
heterogeneous support, it's safe to assume there is a single target
active globally.

> - Select the sole TargetInfo in user-mode MODULE_INIT_TARGET_INFO.
> 
> With these changes, when `qemu-system` does not select TargetInfo, we
> can still list all machines and devices for each target properly.
> ```
> $ ./qemu-system.exe -machine ?
> Supported machines are:
> none:
> amd-microblaze-v-generic AMD Microblaze-V generic platform
> xlnx-versal-virt     AMD Versal Virtual development board (alias of amd-
> versal-virt)
> amd-versal-virt      AMD Versal Virtual development board
> amd-versal2-virt     AMD Versal Gen 2 Virtual development board
> anacapa-bmc          Facebook Anacapa BMC (Cortex-A7)
> ast1030-evb          Aspeed AST1030 MiniBMC (Cortex-M4)
> ast1040-evb          Aspeed AST1040 BIC EVB (Cortex-M4F)
> ast1060-evb          Aspeed AST1060 Platform Root of Trust (Cortex-M4)
> ast2500-evb          Aspeed AST2500 EVB (ARM1176)
> ast2600-evb          Aspeed AST2600 EVB (Cortex-A7)
> axiado-scm3003       Axiado SCM3003 EVK Board
> b-l475e-iot01a       B-L475E-IOT01A Discovery Kit (Cortex-M4)
> bletchley-bmc        Facebook Bletchley BMC (Cortex-A7)
> boston-aia           MIPS Boston-aia
> bpim2u               Bananapi M2U (Cortex-A7)
> canon-a1100          Canon PowerShot A1100 IS (ARM946)
> catalina-bmc         Facebook Catalina BMC (Cortex-A7)
> collie               Sharp SL-5500 (Collie) PDA (SA-1110)
> cubieboard           cubietech cubieboard (Cortex-A8)
> emcraft-sf2          SmartFusion2 SOM kit from Emcraft (M2S010)
> fby35-bmc            Facebook fby35 BMC (Cortex-A7)
> fuji-bmc             Facebook Fuji BMC (Cortex-A7)
> g220a-bmc            Bytedance G220A BMC (ARM1176)
> gb200nvl-bmc         Nvidia GB200NVL BMC (Cortex-A7)
> imx25-pdk            ARM i.MX25 PDK board (ARM926)
> imx8mm-evk           NXP i.MX 8MM EVK Board
> imx8mp-evk           NXP i.MX 8M Plus EVK Board
> integratorcp         ARM Integrator/CP (ARM926EJ-S)
> kudo-bmc             Kudo BMC (Cortex-A9)
> kzm                  ARM KZM Emulation Baseboard (ARM1136)
> lm3s6965evb          Stellaris LM3S6965EVB (Cortex-M3)
> lm3s811evb           Stellaris LM3S811EVB (Cortex-M3)
> max78000fthr         MAX78000FTHR Board (Cortex-M4 / (Unimplemented) RISC-V)
> mcimx6ul-evk         Freescale i.MX6UL Evaluation Kit (Cortex-A7)
> mcimx7d-sabre        Freescale i.MX7 DUAL SABRE (Cortex-A7)
> microbit             BBC micro:bit (Cortex-M0)
> mori-bmc             Mori BMC (Cortex-A9)
> mps2-an385           ARM MPS2 with AN385 FPGA image for Cortex-M3
> mps2-an386           ARM MPS2 with AN386 FPGA image for Cortex-M4
> mps2-an500           ARM MPS2 with AN500 FPGA image for Cortex-M7
> mps2-an505           ARM MPS2 with AN505 FPGA image for Cortex-M33
> mps2-an511           ARM MPS2 with AN511 DesignStart FPGA image for
> Cortex-M3
> mps2-an521           ARM MPS2 with AN521 FPGA image for dual Cortex-M33
> mps3-an524           ARM MPS3 with AN524 FPGA image for dual Cortex-M33
> mps3-an536           ARM MPS3 with AN536 FPGA image for Cortex-R52
> mps3-an547           ARM MPS3 with AN547 FPGA image for Cortex-M55
> mps3-an555           ARM MPS3 with AN555 FPGA image for Cortex-M85
> musca-a              ARM Musca-A board (dual Cortex-M33)
> musca-b1             ARM Musca-B1 board (dual Cortex-M33)
> netduino2            Netduino 2 Machine (Cortex-M3)
> netduinoplus2        Netduino Plus 2 Machine (Cortex-M4)
> none                 empty machine
> npcm750-evb          Nuvoton NPCM750 Evaluation Board (Cortex-A9)
> npcm845-evb          Nuvoton NPCM845 Evaluation Board (Cortex-A35)
> nuri                 Samsung NURI board (Exynos4210)
> olimex-stm32-h405    Olimex STM32-H405 (Cortex-M4)
> orangepi-pc          Orange Pi PC (Cortex-A7)
> palmetto-bmc         OpenPOWER Palmetto BMC (ARM926EJ-S)
> quanta-gbs-bmc       Quanta GBS (Cortex-A9)
> quanta-gsj           Quanta GSJ (Cortex-A9)
> quanta-q71l-bmc      Quanta-Q71l BMC (ARM926EJ-S)
> rainier-bmc          IBM Rainier BMC (Cortex-A7)
> raspi0               Raspberry Pi Zero (revision 1.2)
> raspi1ap             Raspberry Pi A+ (revision 1.1)
> raspi2b              Raspberry Pi 2B (revision 1.1)
> realview-eb          ARM RealView Emulation Baseboard (ARM926EJ-S)
> realview-eb-mpcore   ARM RealView Emulation Baseboard (ARM11MPCore)
> realview-pb-a8       ARM RealView Platform Baseboard for Cortex-A8
> realview-pbx-a9      ARM RealView Platform Baseboard Explore for Cortex-A9
> romulus-bmc          OpenPOWER Romulus BMC (ARM1176)
> sabrelite            Freescale i.MX6 Quad SABRE Lite Board (Cortex-A9)
> sbsa-ref             QEMU 'SBSA Reference' ARM Virtual Machine
> smdkc210             Samsung SMDKC210 board (Exynos4210)
> stm32vldiscovery     ST STM32VLDISCOVERY (Cortex-M3)
> supermicro-x11spi-bmc Supermicro X11 SPI BMC (ARM1176)
> supermicrox11-bmc    Supermicro X11 BMC (ARM926EJ-S)
> sx1                  Siemens SX1 (OMAP310) V2
> sx1-v1               Siemens SX1 (OMAP310) V1
> tiogapass-bmc        Facebook Tiogapass BMC (ARM1176)
> versatileab          ARM Versatile/AB (ARM926EJ-S)
> versatilepb          ARM Versatile/PB (ARM926EJ-S)
> vexpress-a15         ARM Versatile Express for Cortex-A15
> vexpress-a9          ARM Versatile Express for Cortex-A9
> virt-10.0            QEMU 10.0 ARM Virtual Machine
> virt-10.1            QEMU 10.1 ARM Virtual Machine
> virt-10.2            QEMU 10.2 ARM Virtual Machine
> virt-11.0            QEMU 11.0 ARM Virtual Machine
> virt-11.1            QEMU 11.1 ARM Virtual Machine
> virt                 QEMU 11.2 ARM Virtual Machine (alias of virt-11.2)
> virt-11.2            QEMU 11.2 ARM Virtual Machine
> virt-6.0             QEMU 6.0 ARM Virtual Machine (deprecated)
> virt-6.1             QEMU 6.1 ARM Virtual Machine (deprecated)
> virt-6.2             QEMU 6.2 ARM Virtual Machine (deprecated)
> virt-7.0             QEMU 7.0 ARM Virtual Machine (deprecated)
> virt-7.1             QEMU 7.1 ARM Virtual Machine (deprecated)
> virt-7.2             QEMU 7.2 ARM Virtual Machine (deprecated)
> virt-8.0             QEMU 8.0 ARM Virtual Machine (deprecated)
> virt-8.1             QEMU 8.1 ARM Virtual Machine (deprecated)
> virt-8.2             QEMU 8.2 ARM Virtual Machine (deprecated)
> virt-9.0             QEMU 9.0 ARM Virtual Machine
> virt-9.1             QEMU 9.1 ARM Virtual Machine
> virt-9.2             QEMU 9.2 ARM Virtual Machine
> witherspoon-bmc      OpenPOWER Witherspoon BMC (ARM1176)
> xilinx-zynq-a9       Xilinx Zynq 7000 Platform Baseboard for Cortex-A9
> xlnx-zcu102          Xilinx ZynqMP ZCU102 board with 4xA53s and 2xR5Fs
> based on the value of smp
> yosemitev2-bmc       Facebook YosemiteV2 BMC (ARM1176)
> 
> aarch64:
> ast2700a1-evb        Aspeed AST2700 A1 EVB (Cortex-A35)
> ast2700-evb          Aspeed AST2700 A2 EVB (Cortex-A35) (alias of
> ast2700a2-evb)
> ast2700a2-evb        Aspeed AST2700 A2 EVB (Cortex-A35)
> ast2700fc            ast2700 full core support
> raspi3ap             Raspberry Pi 3A+ (revision 1.0)
> raspi3b              Raspberry Pi 3B (revision 1.2)
> raspi4b              Raspberry Pi 4B (revision 1.5)
> 
> 
> riscv32:
> k230                 RISC-V Board compatible with Kendryte K230 SDK
> microchip-icicle-kit Microchip PolarFire SoC Icicle Kit
> opentitan            RISC-V Board compatible with OpenTitan
> shakti_c             RISC-V Board compatible with Shakti SDK (deprecated)
> sifive_e             RISC-V Board compatible with SiFive E SDK
> sifive_u             RISC-V Board compatible with SiFive U SDK
> spike                RISC-V Spike board
> tt-atlantis          Tenstorrent Atlantis RISC-V SoC (Experimental)
> virt                 RISC-V VirtIO board
> xiangshan-kunminghu  RISC-V Board compatible with the Xiangshan
> Kunminghu FPGA prototype platform
> 
> riscv64:
> k230                 RISC-V Board compatible with Kendryte K230 SDK
> microchip-icicle-kit Microchip PolarFire SoC Icicle Kit
> opentitan            RISC-V Board compatible with OpenTitan
> shakti_c             RISC-V Board compatible with Shakti SDK (deprecated)
> sifive_e             RISC-V Board compatible with SiFive E SDK
> sifive_u             RISC-V Board compatible with SiFive U SDK
> spike                RISC-V Spike board
> tt-atlantis          Tenstorrent Atlantis RISC-V SoC (Experimental)
> virt                 RISC-V VirtIO board
> xiangshan-kunminghu  RISC-V Board compatible with the Xiangshan
> Kunminghu FPGA prototype platform
> ```
> 
> --
>          此致
> 礼
> 罗勇刚
> Yours
>     sincerely,
> Yonggang Luo


