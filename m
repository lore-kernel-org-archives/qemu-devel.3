Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4513CD343F
	for <qemu-devel@archiver.kernel.org>; Thu,  7 May 2026 20:56:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wL5kT-0006eu-0e; Thu, 07 May 2026 16:55:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wL5kQ-0006b2-Lr
 for qemu-devel@nongnu.org; Thu, 07 May 2026 16:55:06 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wL5kO-0003XO-1q
 for qemu-devel@nongnu.org; Thu, 07 May 2026 16:55:06 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 647G31uB2384216
 for <qemu-devel@nongnu.org>; Thu, 7 May 2026 20:55:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 qTJ7jAQV9Bq3MZFnxRQrIHL1++tQ1fQnlXQcS7CiTx4=; b=TNFtuYN4YneSLx3u
 wUMmWlykQbmCEYOY16iQziypgPMTvN+SK41ZNDpsNy1jqjjmeRusQZjvSkBHdJTs
 d+lLDDv7I1ShbIkhU0DTn/9KjEDhfd3oxc/DCUwOl+VVsNl/lVZEiubTM6BBHfqA
 LD50BPHrem3LV0QlWSLpyh9oeklILKNdO7xJim73xyN+btMGDk8jFWtXnk8vq+8J
 u67p0ds1GQsQ6TexDhjDfGgPT5s9PVw8G9AyQuMT7c6xro3Ol1y34yOELxx6QP2k
 Ku13nc+JCnezdCAy4IbQ49OjrQ/S/UQUTHUW1IBsA3PhDUEU9zEmzAwWdmfkFEaY
 QhYS/w==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e0wwuh1yb-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 20:55:02 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-12c8ccc7593so3011509c88.1
 for <qemu-devel@nongnu.org>; Thu, 07 May 2026 13:55:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778187301; x=1778792101; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qTJ7jAQV9Bq3MZFnxRQrIHL1++tQ1fQnlXQcS7CiTx4=;
 b=Ve0XpDDdhUD68OcqjjJL7GKbmtC++Vhs/F0oPY9teDBzuZvORGKJrRA0kLmxG+dRji
 y+VbXO2y1MXW3pvby2yAQRjgx1LwBWCs7V2AIfX06pMDmJSZAP1yutfWtsI9d7TSQbVD
 BDEmvatX0WiRg4mG6t+KWIFhJ9pTLKocPwiyBVXWyvIxi+yX5Ffo3lYYVnklqX6vGl6S
 BNmiCHd3npEsO2VtN2Zr6zNC0J5N78CJxNQWO+RQ7l5NTrg0sKaYbUjPPCQo2tCu1bt+
 DHfwycGwu/7zE99NxML4xA0Pr/VCjUVmZ2BoKbrEx6CDuC1y75h/N3hWyzMEmci8+n7B
 ZcQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778187301; x=1778792101;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qTJ7jAQV9Bq3MZFnxRQrIHL1++tQ1fQnlXQcS7CiTx4=;
 b=AoTSpWfgI/RV9DIC7GTc+dAOMxMtBpY/nvIxDX592kZAICs/Eo6XJyBqAx8XGCoRfo
 UxTV5mlBMFn3eOojy0A28T3rPiCxl+v5XsrcTpdXYxNqGrbZTG+t3f57Dl7ZVBPMlDNX
 We8FhxyxdCjlFTjkK2KXwViXsX2Sj+/2FcdwGG/hkSfPz7sHs/pOvd7Bz2Jn6jNycaXK
 rr37emvqPDu06F7bjwT1NgL0Dx5cAy9kpJeVo/SmlLXYA3kgSiK0fdKYFIPu60Tqhy40
 BusTcBqvL+yOmO/1fncf8WHBlU3Kcme3lE37yuYhAeOhRp1k2aw7aMNqIMN8e/WIlKca
 RPZw==
X-Forwarded-Encrypted: i=1;
 AFNElJ9FzTDktdDADXcB6Npol1bdIY0bE9J02r02bn60i5ezSEiRWDj8g2z5Z8Zyjxtoe7WgG95xdoQtbFmp@nongnu.org
X-Gm-Message-State: AOJu0YwAYTT46i3ghg24RoymuRvYYb20xc36JHPzGFwl5Nz8EwcfP4GF
 mr6Vnd2d6tfqQYR70caKIkTfHYj4mETLS00nre3QtQ5aLNM8gjdPosVxdUyrycMLa6Y7lwatn6R
 adP2PaXrHFG7YjzyhdJOvTDG2Xhy0xb0QEA/IxprNq3NN0VqUeFLUgb0qEQ==
X-Gm-Gg: AeBDievwAdevJDRnsT7x8GP4aRerMcCKTgygZvRjGDknwWVNpJevSY38x1cRAicqhNg
 w3xa2H1R2+u24OTMMNBbAnI70qTrAKICSiHaHHHR2YoFucSUQ5G5SDVB1suiWQ+NCgt75/nV5HW
 L0l3Pn61qoOYCekiUkLBMq7abG0tq4prGMN7AYQlSiBfL0H6CqpzPo03z5z/WfWgEkxwNilpAiu
 Twx7YBAIJFnsujSz42Qm/46r4TKJVJ/y6sUzkAGrdjfxhNYsBLLMUDqJEmQMbw07ug5eZ872rri
 sYKA+CX+bqv/kIN98B0gFF5Hjl+aOUgwlc2CxJu0vZh5eahHcvu4ETaSdRAuseUJC6GjOlID4Uz
 e6bsVJIrcZZarthR6iycmG72ujTIGCcFKhS6kJNGZKQSCfu2XI6A4RyNPWKUujqhrq/ZuLwbmy+
 JrOXcUF5UipCpwEg==
X-Received: by 2002:a05:7022:fa07:b0:12d:f0af:110d with SMTP id
 a92af1059eb24-1318ea2dc7bmr4612602c88.28.1778187300914; 
 Thu, 07 May 2026 13:55:00 -0700 (PDT)
X-Received: by 2002:a05:7022:fa07:b0:12d:f0af:110d with SMTP id
 a92af1059eb24-1318ea2dc7bmr4612580c88.28.1778187300303; 
 Thu, 07 May 2026 13:55:00 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13270901ba2sm195177c88.11.2026.05.07.13.54.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2026 13:54:59 -0700 (PDT)
Message-ID: <f6b9b16a-0273-4dc7-a8e0-df074d246a01@oss.qualcomm.com>
Date: Thu, 7 May 2026 13:54:58 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/6] target/arm: Fix functional test failures in KVM-only
 builds
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20260507194728.2034696-1-peter.maydell@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260507194728.2034696-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: IoLFeeLMDz9jeT1ufKRCTFK2aIEYVc9u
X-Authority-Analysis: v=2.4 cv=Nd/WEWD4 c=1 sm=1 tr=0 ts=69fcfc26 cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=EUspDBNiAAAA:8 a=Z8H6kxiZWI1TnuwXCkYA:9 a=QEXdDO2ut3YA:10
 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTA3MDIwOSBTYWx0ZWRfX07rHdNVXFZLk
 yOuqkWwfQoInVQom6PEqahX7YeRj115uM24rCjxnsduU0JTfU3X9ZfGfWCZ1D+YIb8Can0G9wim
 7SWEeuzinbc/YrC8ueOFIfZhkNGsKjjPT5XoCJ2mexsG+PEdTZh3+OtvBlfuBYn6T//VDg5xjfe
 pFs4sSMq7RdgplHrs6gSZpK6IW7w+O3hK5eDJ0qTbvSKyy8VEGLkSRcXUVTLF8dcVhgzLUgNyuV
 2YSg8AMTnO//YmBge/uQ6IqvRBwqsYwajvWkpxV3doFd57fajmd8jBXP2r/u7M4Mc7FEM3rZW0s
 SmHPkA08LJBeMAFJQsuwDC+bnbDFN+I0OWLNdI+/3Ko2mHhQZYwuvpQLlNdZCz3Qmo1XNkRnHKN
 5JoPZGpIfmcBLfj6nygSmf1uWcxoP92xGPUWVOjlHlTjO+19mHgKgNZw3uN3lsZ+G/T+YXloBaD
 4oj/koxybHop2exdfdA==
X-Proofpoint-GUID: IoLFeeLMDz9jeT1ufKRCTFK2aIEYVc9u
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-07_02,2026-05-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 clxscore=1015 spamscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2605070209
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

On 5/7/2026 12:47 PM, Peter Maydell wrote:
> If you build QEMU with --disable-tcg on an AArch64 system, some of the
> "make check-functional" tests fail. This patchset fixes them.
> 
> The first patch fixes a bug in QEMU proper, where we broke the
> "x-remote" machine because we forgot to mark it up as being
> OK to expose in the qemu-system-arm and qemu-system-aarch64
> binaries, the way we do for "none" and for all the actual Arm
> machine types.
> 
> The rest are tweaks to the tests:
>  * tests that run '-machine virt,virtualization=on' need to
>    check for failure because the machine reports that the hypervisor
>    can't support nested virt
>  * tests that use a specific CPU type need to either be
>    restricted to TCG-only, or else changed to use 'max' instead
>    (since that's the only CPU that will work on both TCG and KVM)
> 
> thanks
> -- PMM
> 
> Peter Maydell (6):
>   hw/remote/machine.c: Mark x-remote machine as OK for AArch64 and
>     AArch32
>   tests/functional/test_virt_vbsa: Skip UEFI test if virtualization not
>     supported
>   tests/functional/test_kvm.py: Use -cpu max, not cortex-a72
>   tests/functional/test_kvm.py: Skip if virtualization not supported
>   tests/functional/test_hotplug_pci.py: Require TCG
>   tests/functional/test_tuxrun: Restrict to TCG
> 
>  hw/remote/machine.c                          |  3 +++
>  tests/functional/aarch64/test_hotplug_pci.py |  1 +
>  tests/functional/aarch64/test_kvm.py         | 12 ++++++++++--
>  tests/functional/aarch64/test_tuxrun.py      |  2 ++
>  tests/functional/aarch64/test_virt_vbsa.py   | 10 +++++++++-
>  5 files changed, 25 insertions(+), 3 deletions(-)
> 

For series:
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


