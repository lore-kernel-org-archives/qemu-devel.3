Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C9BEC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 22:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whbBZ-0000Cc-Rt; Wed, 08 Jul 2026 18:56:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whbBX-0000CR-J8
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 18:56:07 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1whbBT-0000o2-3Y
 for qemu-devel@nongnu.org; Wed, 08 Jul 2026 18:56:06 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668Kti9x3731540
 for <qemu-devel@nongnu.org>; Wed, 8 Jul 2026 22:56:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0Uv2pZuL/Fh8jKalInzeeuhohX/Ms8fnM/HEgSoHQr8=; b=j+bae57juXvWfJRB
 oqCesX1tfF2usBvBDxEPkLib8uNe3jJbMQEWAHD9zcWMavC2MVRZsyQKLZc7nF+y
 Nd2/wNbgEmfxKvrMK7RycJbTwEbnMwXZhwBdRBy+oIocXF7p5F9ueKmEY9No3s9o
 I379XWcRv1c8sZYxbl37GIZ1r/QAo9aV5cXos+8i4ZZddHSweDCZNFVsANKgITp/
 rQk00cDwd7/ZBIIrgngpmFF82fjvICvZk6vztqXwhPK+OwoZQ/ASymSe0IJ3w3f6
 h4jWwOpMrYquMMdU7pOvOfI0/zytcWj31khh8HpjJ17v8iwdBZBKxa9X+zXkshGn
 Q6fc2A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f9q5sab9p-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 22:55:59 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-51c0d6a2f4cso13667651cf.3
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2026 15:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783551359; x=1784156159; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0Uv2pZuL/Fh8jKalInzeeuhohX/Ms8fnM/HEgSoHQr8=;
 b=T5X8PXiW+1STWo0k+N1p4jXNFnu/dwdVIbmvSZXESr2lUsiv+HFxNekg891XdHF3j8
 8iY55zKiIwsb9FOxzvtMukFdBjMEcyt0rB6VkHUm1q5rjIAhaSaTEK7vLrY7QR6TKQeQ
 jQpknA1tqT6S+3CYJDnHi0xBxZeZnK8NAmeajQhCpW6+rIP8XCkjZqlslH55UIk6yaID
 Aj8T8OrwVzjGY3zEtwnAk8uoYiqgggI8bUPRBL0W3uWpSWFtWFAwrjteTyldf8SPLGFG
 DGMUa4ujJXMh1l5+zM1TbIkzTnSndZj0bHA22v1wp/CxHjIIq2wUevutI/b+WsJs3nps
 GplQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783551359; x=1784156159;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0Uv2pZuL/Fh8jKalInzeeuhohX/Ms8fnM/HEgSoHQr8=;
 b=XmLcYyAdxKH6mhqsquYYFVgz4Sx4pbJ6zMngat+BtODmuUsvSX+hneriQQrehZcskS
 CtYmawcye0eRCvsohf5U4YhG0yQOmJO7QK2EQmdmOF95FMLpvb9A6Rl/gGWmoj6/054R
 QzAww5PcbpLDCO6JgOHT3lStPnrsImkoRpJaDMqHFiA6b6oOCona4Z+ul4dkW06KfXhQ
 Kd8AqzBcEaOathI+Jpurq4fDNjtb+FS4kAAul/diGhESy5BueTirnIk1UWwC48uXuBqB
 ZRw1BzYLa4YF8sfj2pn3NgBr8h8P+vlTVxXFEcqBPn78HTHa/nQvNtc96LshJjIUF+AA
 yJYw==
X-Forwarded-Encrypted: i=1;
 AHgh+RrjOwSdbQo8rWWeCeExEnPKDWUowaLNBfXqHHrwr1TuEXuJeoYYbxUcS2oVfnQAyxuxlQYosY1dpKRU@nongnu.org
X-Gm-Message-State: AOJu0YzmHJoqls3eN9JA0IXlX4j6Km/PXJewxFX/GJvT7kdUKJuNLWeM
 z0XuHT8OCGXcrPL40N+HtM0dd7TQaW+0gAPbWUZUczw0jiz/2NVpeqm2gLbOlc7gW+LTbpS2ahI
 VRpl/K+3snOgstHgfOC2eCLNlBHEsrNKR0ygK+/X+CprB1BIj0RxCZ2t1ug==
X-Gm-Gg: AfdE7cnHyJVLtmyh9Or81AYOTH8ra8vfdD3cWxGYoW3+W4zjwszfFeSlCqmrizCr75u
 bbv3msNcCAwUBRvuuaO+sQmyWWzQmy8Y+jdtp4UUfaFlhQMcoLrSjadA0SkcE3gW/NzFfxqv+Af
 nUzkHRtDoL2Zcd+/U8WVHUaQGeE4eDMDXJpZ1jmxstxEZ9fbxNUK1ZY57b4rwkK2iOBgKLZdoZJ
 Ia3Tbm9nnsn+eoazo3DndoTLNmMCgZKo/QwdOeZjIs54Rtgs+MO4eGMqaN++EbgFLOscqdG/iRb
 80eVr97qQJ8EKHaLvV88WYZXzt4ruIO418zCIf00avPlo0M2Xb+g6oAML5tV3sKd8ZP6JIJbGYm
 r8hLCQ3liEX71JEv1eFgt4rWG8TGVNjdixdMe+oHxothwJg06/bKJu604i6IVEA==
X-Received: by 2002:ac8:7f87:0:b0:51a:8c97:9391 with SMTP id
 d75a77b69052e-51c8b572217mr52220891cf.72.1783551358794; 
 Wed, 08 Jul 2026 15:55:58 -0700 (PDT)
X-Received: by 2002:ac8:7f87:0:b0:51a:8c97:9391 with SMTP id
 d75a77b69052e-51c8b572217mr52220511cf.72.1783551358214; 
 Wed, 08 Jul 2026 15:55:58 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb6fb526sm13058095e9.15.2026.07.08.15.55.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 Jul 2026 15:55:57 -0700 (PDT)
Message-ID: <2d7d578e-9187-4751-97ea-5a9b13ee84ad@oss.qualcomm.com>
Date: Thu, 9 Jul 2026 00:55:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 10/10] docs: Add support vbootrom and update Manual
 boot for ast2700fc
Content-Language: en-US
To: Jamin Lin <jamin_lin@aspeedtech.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Mark Burton <mburton@qti.qualcomm.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alexander Graf <agraf@csgraf.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: Troy Lee <troy_lee@aspeedtech.com>, Steven Lee <steven_lee@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Kane Chen <kane_chen@aspeedtech.com>, Joel Stanley <joel@jms.id.au>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>, Troy Lee <leetroy@gmail.com>
References: <20260708092023.3826159-1-jamin_lin@aspeedtech.com>
 <20260708092023.3826159-11-jamin_lin@aspeedtech.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260708092023.3826159-11-jamin_lin@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDIyNSBTYWx0ZWRfX7TbFv3Ff397X
 ruxhUGDGbhIYV6yfcaN7gTaCTcL5xYj6YpU3I5PpZCV3vFECQwQSVZ4tujeVRqGw9f1A6n4ZMv0
 IRlAGZznnGJRx4zurlv981e50Tbb434NjcOAsbUWiVi18C2MKGssiHkXNA8vQeDCnGhF2dfwy0k
 lRLzGUEzEoJiD2WgvhbkXRScm7qNGZ0TXh0CyDD6/p1rj+TH7TzE2RncmhIM1PaAx1D7sOrBWEx
 fiISQSZLOgzs7yGUBNQfe2OXTWOrBKXS6S+rF0zZ8PhEewuStZy8H+fDIJWibSLLSDpcAnjvefL
 jwyAhUSz9tYQs4nvOFo8r0qCfREIT2NPQi0s0w9ep3dndQoB4giy+lcQttnSWZniwbTPvwiglhc
 zxt1LH9dpABhZ/J0b4ANe4lfzXW9ae74uz+26FQ6zAstbJCbdklg4H2mawMYLcFoDXmdZaeRUxx
 KvlQSzrrcwbqjHP63NQ==
X-Proofpoint-ORIG-GUID: uD7RvnKh80XFBd4PODRL8AqYj9Z5nuPJ
X-Authority-Analysis: v=2.4 cv=NfTWEWD4 c=1 sm=1 tr=0 ts=6a4ed57f cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=V2NxCb60AAAA:8 a=GyafrK3KZhnXGc5g8acA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22 a=3L6qF29SlnrayQqPM2jZ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDIyNSBTYWx0ZWRfX1EYmfwVWBW9+
 os4c0ysYTczWDdnjeQ7/HRK0lD888QwN7f4KtMJUk3gZwr4qglqDQue/zsNtcqx2aTJinU8/Wvs
 uMwlw7T9fSxF765niRInC3Mg/9fO5DI=
X-Proofpoint-GUID: uD7RvnKh80XFBd4PODRL8AqYj9Z5nuPJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_04,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 suspectscore=0 phishscore=0 bulkscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 malwarescore=0 adultscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607080225
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Hello,

On 8/7/26 11:20, Jamin Lin wrote:
> Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> ---
>   docs/system/arm/aspeed.rst | 42 +++++++++++++++++++++++++++++++-------
>   1 file changed, 35 insertions(+), 7 deletions(-)
> 
> diff --git a/docs/system/arm/aspeed.rst b/docs/system/arm/aspeed.rst
> index 2d51ceeb84..b6dd757f6e 100644
> --- a/docs/system/arm/aspeed.rst
> +++ b/docs/system/arm/aspeed.rst
> @@ -386,18 +386,25 @@ Booting the ast2700fc machine
>   AST2700 features four Cortex-A35 primary processors and two Cortex-M4 coprocessors.
>   **ast2700-evb** machine focuses on emulating the four Cortex-A35 primary processors,
>   **ast2700fc** machine extends **ast2700-evb** by adding support for the two Cortex-M4 coprocessors.
> +There are two methods to boot the ast2700fc machine.
> +
> +Manual boot using ``-device loader``:
> +
> +In this approach, users manually load firmware and assign entry points via QEMU loader devices.
> +By default, the PSP begins execution at address ``0x430000000``, the load address of the bl31
> +firmware. The SSP and TSP start in the powered-off state and must be explicitly enabled by the
> +PSP through writes to SCU registers.
>   
>   Steps to boot the AST2700fc machine:
>   
> -1. Ensure you have the following AST2700A1 binaries available in a directory
> +1. Ensure you have the following AST2700 binaries available in a directory
>   
> - * u-boot-nodtb.bin
> - * u-boot.dtb
> + * u-boot.bin
>    * bl31.bin
>    * optee/tee-raw.bin
>    * image-bmc
> - * zephyr-aspeed-ssp.elf (for SSP firmware, CPU 5)
> - * zephyr-aspeed-tsp.elf (for TSP firmware, CPU 6)
> + * zephyr-aspeed-ssp.bin (for SSP firmware, CPU 5)
> + * zephyr-aspeed-tsp.bin (for TSP firmware, CPU 6)
>   
>   2. Execute the following command to start ``ast2700fc`` machine:
>   
> @@ -407,6 +414,8 @@ Steps to boot the AST2700fc machine:
>   
>     $ qemu-system-aarch64 -M ast2700fc \
>          -device loader,force-raw=on,addr=0x400000000,file=${IMGDIR}/u-boot.bin \
> +       -device loader,force-raw=on,addr=0x42C000000,file=${IMGDIR}/zephyr-aspeed-ssp.bin \
> +       -device loader,force-raw=on,addr=0x42E000000,file=${IMGDIR}/zephyr-aspeed-tsp.bin \
>          -device loader,force-raw=on,addr=0x430000000,file=${IMGDIR}/bl31.bin \
>          -device loader,force-raw=on,addr=0x430080000,file=${IMGDIR}/optee/tee-raw.bin \
>          -device loader,cpu-num=0,addr=0x430000000 \
Orthogonal to your work, I found this setup interesting to stress
my work-in-progress 'split-accel' branch, running QEMU with HVF
when possible, otherwise TCG.

I manually started the SSP & TSP first:

=> mw 12c02204 40000000
mw 12c02204 40000000
=> mw 12c02120 1
mw 12c02120 1
=> mw 12c02224 00000200
mw 12c02224 00000200
=> mw 12c02160 1
mw 12c02160 1

Surprisingly I could boot up to the guest login prompt spending
most of the time using HVF

(qemu) info accel
36 transitions, 10943 SW and 86815 HW executions
Accelerator settings:
one-insn-per-tb: off

Translation buffer state:
gen code size       9098100/1072906240
TB count            16086
TB avg target size  14 max=468 bytes
TB avg host size    230 bytes (expansion ratio: 15.8)
cross page TB count 12 (0%)
direct jump count   8371 (52%) (2 jumps=5949 36%)
TB hash buckets     4813/8192 (58.75% head buckets used)
TB hash occupancy   21.05% avg chain occ. Histogram: [0,10)%|█▁▇▁ 
▃▁▁▁▁|[90,100]%
TB hash avg chain   1.059 buckets. Histogram: 1|█▁|2

Statistics:
TB flush count      0
TB invalidate count 8796
TLB full flushes    0
TLB partial flushes 268
TLB elided flushes  53158
CPU#0: cortex-a35
HVF cumulative execution time: 7.020s
CPU#1: cortex-a35
HVF cumulative execution time: 6.000s
CPU#2: cortex-a35
HVF cumulative execution time: 6.805s
CPU#3: cortex-a35
HVF cumulative execution time: 7.656s
CPU#4: cortex-m4
HVF cumulative execution time: 0.000s
CPU#5: cortex-m4
HVF cumulative execution time: 0.000s
(qemu)

Over 10700 "SW executions" are the M-profiles running,
only 162 correspond to A-profiles :)

Thanks for this motivating setup!

Phil.

