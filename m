Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22E0CC5DF7D
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 00:06:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwTp9-0000CQ-9d; Tue, 18 Aug 2026 20:06:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwTp7-0000C1-Sn
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 20:06:29 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wwTp6-0006GF-8G
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 20:06:29 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67INlaAu3119177
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 00:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 I87KWitpbM0qff4HsDIQwGLB0Ohy3nvtNNU0aaLa2Ek=; b=kncXrhymjrbT8358
 iT9tRYR1YsPV2Ib/44k7B0MwLL5r1AAgRFzrBNjEXnHnqGyiR4bIyWvTPTzjyLC7
 i9mifeTrxUsJq0n4sWe38coqHWFyjim/qTyTvpAJZnT5ARg4bglB8ZT1o1lxtN3H
 cVamAKUDKSJo0qkijcNjCy4bmNghNsuvE26zkKZFmbMbxHwLmbzjT0CVnio1juQk
 toaQWeTDh3UBIvkuVywGj1bE3DVn6j3r64Ccl+PM3idls2LU7WZAeLGwlyK229sr
 DGBXWaAFVdd+2gcVlzOkvCixqGoP+CMt9cg3v5eJMI1plq5Wzv9VWb2YIAs+MXJI
 DAojpw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g4yfm8f8w-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 00:06:24 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-92e4f946461so54385885a.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 17:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787097984; x=1787702784; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=I87KWitpbM0qff4HsDIQwGLB0Ohy3nvtNNU0aaLa2Ek=;
 b=TJsr8kI+2OxEeq0QTGdsTW5XTddWJBhmSJpIvvmn672HNs47qZiC7hzQIkMj8cib5B
 s0p285CwMtgDlI+zNEYHJwOf8SI7obqulP1Gak8aO40Qvtv20zh6CfmdM3iuum9OB0qV
 VNlbJ+fWEp/UkwvW6hMVvBeVbsbEuwXW1584n7dy0YvCQKUurKl3kNjwJPYBPUnbY/yT
 aYOyVpBECmMJRmrOEwqoDkfEAPrdwp0GOiHZlS0PAdzFAlbotdYyu+D8Y0w/9bh88XOd
 3zp/Sl98G1iTf5je41xLSZlO/Yqh6fCIuvpIsko79VLe1tDlop3vbCTXEYiX/wG3T4Vg
 9EoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787097984; x=1787702784;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=I87KWitpbM0qff4HsDIQwGLB0Ohy3nvtNNU0aaLa2Ek=;
 b=euVAy7Sb4GVSQr1ZPT6FuyKwBrcOsFNdeiEuciGKiPjGhhAT7ZHa9BZ1XhTigkomXZ
 p8o82YRqnvKxwGL0aWn4SXLz12YnZVmfl26Uhj1PyRlegn7WUk9cbtc6xavUOUtXW5bs
 9d6zSx4KtiqSZCsIPwi4GTXMjqmc/zN1sb1u/U3HMyNVXj947HCJ9kyO2OaqbAinU5M6
 r8Wk7eKvZd1KOIbByFUY448d+lHlaNjPusguyTheZJ4X3Im8c0DQeBMICzLZKq2AIk8O
 uACNTPRSuDOhrPnxZ65+PhAa6kupdHlDQB/RtDwV7kH3q1E26xoQgOWQ5GqjwkKYO1FR
 l8ww==
X-Forwarded-Encrypted: i=1;
 AHgh+Rpf43KpqFX0IiulnncnkfULzC5UBchAzEBN0MVgICXKwiyJ40Pjv8Sd0vG7hBChwT3TOynN468MHD0u@nongnu.org
X-Gm-Message-State: AOJu0Yw4M+24cYXgyR7fQIrYN4eC+Yj2v30Yg6w6UMpOpXuxw15Lpz5O
 U0+6MGxitXDaG+l7uR4GJgUDTiuewASQyCqZjF2sj/65VmIsvnBwSUncCT/o6P6E7tV3nchRmn1
 5ajiRugvBBlHY7/UIEpbimvvOgl3ngNF1cVwZY8+ws+5J0HReep28JnxygVSufnG8DGfU
X-Gm-Gg: AR+sD1100FkEEV+V75YPP1SCgYZ0utUj6L98bAqvNP0lPsGtI0lRFon8FP5NiJqZVg8
 TPltTzSeLyRjIoTTOxIlMZvtQ4OfP5ekJCs7ig+GAmuWBiYH+iNhOqYFM+LJY5wFh5qS8Aqncot
 duOcjXWLblv+Ao0KSa2yIGmriOrSjcV/B+OUQv3q/ijViXlWSq9kFbOZ10B10VmDfoqhIVF7Fla
 c4DEJKS2+l7Y0/vXshWUO5VWcOoVE/RfLASjhzmHZ+T/0xV6JsRaWdkOf9CNMupTwk6ay9XaKc1
 4IY105ipXPkXFHyywq8bSqtG4v032xMqPzT1g+LP7owEgvucgczvhHnezaknK5Z1O5JkLNomUAy
 X4q/OcR+ea6hSoBnQuxuc8zxVLOACwtsZ7FU=
X-Received: by 2002:a05:620a:1994:b0:930:9585:e08e with SMTP id
 af79cd13be357-9371e205015mr106384785a.10.1787097983741; 
 Tue, 18 Aug 2026 17:06:23 -0700 (PDT)
X-Received: by 2002:a05:620a:1994:b0:930:9585:e08e with SMTP id
 af79cd13be357-9371e205015mr106380085a.10.1787097983240; 
 Tue, 18 Aug 2026 17:06:23 -0700 (PDT)
Received: from [192.168.69.231] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499a9e78496sm14285555e9.2.2026.08.18.17.06.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Aug 2026 17:06:21 -0700 (PDT)
Message-ID: <53ae0209-0fd9-4f62-ac4b-f70b4f92c235@oss.qualcomm.com>
Date: Wed, 19 Aug 2026 02:06:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc/aspeed_scu: Set both AST2600 protection key
 registers on reset
Content-Language: en-US
To: Andrew Jeffery <andrew@codeconstruct.com.au>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Kane Chen <kane_chen@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 qemu-arm@nongnu.org
References: <20260818-dev-ast2600-hw-prot-key-reset-v1-1-5dc3de64c247@codeconstruct.com.au>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260818-dev-ast2600-hw-prot-key-reset-v1-1-5dc3de64c247@codeconstruct.com.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: T52_a3ozowIbbhFSGdL3J9bfVpQ0FzD4
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDE3NyBTYWx0ZWRfX+fErNWpBGHlK
 bBOtm+uxLUJ6Es0JNaMFwmIjuTJLlO1X9eFdgfLOkRG5El//Apju7nEs9gWHsnK6/gVy5VsQDDp
 19zH+5Ge6DffAnCN6JF3cGbZ56rAsRw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDE3NyBTYWx0ZWRfX+rXC4t0Xf17L
 7dG+ec6R7jVoEHTwx2P9yDhvLu14qUl1LoSYKJLQ1BVky2u94hcuzR1wpPwtJmRHNA2oNecnXnJ
 /hrqfX0NKKzoxj9stCCB572oLer8P9yaf+3ELIVPZXX5QJ+1n3JLhhq5Jz6dsDIxis7KY8l4qlH
 j0R0FdN7eY6vqWsOrXVIgjp9189jCLiZ1TYcX+NnUhAIKaVxFX/82bfZVRiJgE72HE8xz/lHk8g
 jmxPfD9yNjXgc3325qB06IFQ9sGmzCHSJ7Ed4lM634lBGiq2EHA+N7I0Hq6DX1SQCnNluxnHkJa
 C2fgu+5V7gUi0jiFvZ8XFRh9cMUIdmPD2CDGOvYFmOp0/+VvnBSvwyKvGwD3BGU4MxnGhquOSJY
 JNorE1DYV8CukdScNeTf9tFTgGRChmmv73o+ICBv/dz8umHRHWvzh2+Ry1YYBpuA849jLWK2t8M
 eGedqerGLzctG1+BRaQ==
X-Authority-Analysis: v=2.4 cv=aNrAb79m c=1 sm=1 tr=0 ts=6a84f380 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=7KBfExy5AAAA:8 a=69wJf7TsAAAA:8 a=EUspDBNiAAAA:8 a=n9CPKyDd1ScNi2Ms_7YA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=eL7OMsOqQ-6kYQPn45L1:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: T52_a3ozowIbbhFSGdL3J9bfVpQ0FzD4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_05,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015 bulkscore=0
 malwarescore=0 suspectscore=0 priorityscore=1501 phishscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180177
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_NONE=0.001,
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

On 18/8/26 03:43, Andrew Jeffery wrote:
> Currently, booting Linux on the ast2600-evb machine via -kernel results
> in a lot of warnings about failing to apply pinmux configuration when
> binding drivers:
> 
>      [    7.339307][    T1] Creating 5 MTD partitions on "bmc":
>      [    7.340402][    T1] 0x000000000000-0x0000000e0000 : "u-boot"
>      [    7.513755][    T1] 0x0000000e0000-0x000000100000 : "u-boot-env"
>      [    7.664219][    T1] 0x000000100000-0x000000a00000 : "kernel"
>      [    7.826974][    T1] 0x000000a00000-0x000002a00000 : "rofs"
>      [    8.026666][    T1] 0x000002a00000-0x000004000000 : "rwfs"
>      [    8.201612][    T1] spi-aspeed-smc 1e630000.spi: error -EPERM: Error applying setting, reverse things back
>      [    8.370835][    T1] spi-aspeed-smc 1e630000.spi: Calibration area too uniform, using low speed
>      [    8.371131][    T1] spi-aspeed-smc 1e630000.spi: Force to dts configuration 100000kHz.
>      [    8.371500][    T1] spi-aspeed-smc 1e630000.spi: CE0 read buswidth:4 [0x406c0741]
>      [    8.766797][    T1] mdio-aspeed 1e650000.mdio: error -EPERM: Error applying setting, reverse things back
>      [    8.906008][    T1] mdio-aspeed 1e650008.mdio: error -EPERM: Error applying setting, reverse things back
>      [    9.039240][    T1] mdio-aspeed 1e650010.mdio: error -EPERM: Error applying setting, reverse things back
>      [    9.147942][    T1] mdio-aspeed 1e650018.mdio: error -EPERM: Error applying setting, reverse things back
> 
> The pinmux configuration fails because the SCU is not unlocked.
> 
> Set both SCU protection keys for the AST2600. Further, set them
> such that they behave accordance with the read value documented
> by the datasheet. The new arrangement now upholds the comment in
> hw/arm/aspeed.c regarding passing -kernel on the qemu command-line.
> 
>      [    7.568170][    T1] Creating 5 MTD partitions on "bmc":
>      [    7.569330][    T1] 0x000000000000-0x0000000e0000 : "u-boot"
>      [    7.740372][    T1] 0x0000000e0000-0x000000100000 : "u-boot-env"
>      [    7.883570][    T1] 0x000000100000-0x000000a00000 : "kernel"
>      [    8.041004][    T1] 0x000000a00000-0x000002a00000 : "rofs"
>      [    8.196824][    T1] 0x000002a00000-0x000004000000 : "rwfs"
>      [    8.547037][    T1] spi-aspeed-smc 1e630000.spi: Calibration area too uniform, using low speed
>      [    8.547320][    T1] spi-aspeed-smc 1e630000.spi: Force to dts configuration 100000kHz.
>      [    8.547642][    T1] spi-aspeed-smc 1e630000.spi: CE0 read buswidth:4 [0x406c0741]
>      [    9.494235][    T1] ftgmac100 1e660000.ethernet: Read MAC address 52:54:00:12:34:56 from chip
>      [    9.531186][    T1] RTL8211E Gigabit Ethernet 1e650000.mdio-1:00: attached PHY driver (mii_bus:phy_addr=1e650000.mdio-1:00,
> 
> Fixes: e09cf36321f6 ("hw: aspeed_scu: Add AST2600 support")
> Signed-off-by: Andrew Jeffery <andrew@codeconstruct.com.au>
> ---
> I ran into this issue while improving test coverage in my patch review
> process.
> ---
>   hw/misc/aspeed_scu.c | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Cc: qemu-stable@nongnu.org
Fixes: e09cf36321f ("hw: aspeed_scu: Add AST2600 support")
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

