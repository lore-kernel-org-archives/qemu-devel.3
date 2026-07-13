Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F2DAC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 11:36:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjExN-0000yn-9p; Mon, 13 Jul 2026 07:36:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjExL-0000ye-V1
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:36:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjExK-0001cB-1q
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 07:36:15 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66D9dXfI952940
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 11:36:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 ipibSbzZCxpu7NyJC7H06YTlCgBjCw/BWWw3UYYXlM4=; b=nTHY/4McPVpAOcNz
 2AenFJVLdaZd9aA6GqXROu88ByxauxDMpmPc6oxClaMP0POrnl31gQL6TPXWJ/mg
 9XECOn4A3AxzcX4oKahICK27nLGlpMO84JiWMILaqBJg7hWH+OwFo03O/qerey7I
 2RTJecSH9IgsO3AE+UHY/lNrlAtS0gbHiQPJRbB0yqai2x1vPiVPiWgIsvsbchR4
 T2NGGLcbSfGoTP6E0829QP9zHu/jScAoRyy83i8hrZHCAJXL3tfzPHcCY2GettHE
 Z47MY5MpAyOAeBkxytlmv4NWRDGsYPr7IJeq17hzkplINQXS0AvcL/5awmwqqQ0W
 5u/6mw==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcwk3gcew-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 11:36:11 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51c2af04aeeso43855821cf.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 04:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783942570; x=1784547370; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=ipibSbzZCxpu7NyJC7H06YTlCgBjCw/BWWw3UYYXlM4=;
 b=QrS++rvvRx80ZjSV7itOF8tXu4/Tqmogz9PlZtU6sXYjtfKDa5UuqwmQwcLs6rW9OA
 BEMXYgXNkGTjKTkobcCkCT8xs+R7BhJCbaYoZhaxDCm/tDBkwafS05uuaJEtPzAByAhg
 C2MH7eSGZxL3oSr+6OmKGU9YdkSCLF8zKgOzwAyOYgZG059DEz0gDjH3Bvpuyd2MNjKz
 vAGUKtFxy7zxYW33u9fGKKyJGd6xlf4hHqrxuCURi65zhNUIxu50cknky/zGW86zhk9s
 PfD7AM3jBeblZAs7PHo4R1kYEoKNem4vP0wJ5FOfGIALlTLwwXuPN1EEQRlPHeVzQK//
 49/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783942570; x=1784547370;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ipibSbzZCxpu7NyJC7H06YTlCgBjCw/BWWw3UYYXlM4=;
 b=cRwzy5hpNUqvXWroDdfyvJaCZaFSOG2Fq3Mu0EsAQs2sgpGcEl53l5R3rmUu3uPYPq
 kb1zFm45hIOmeRYTIBu3TkI3yumT67tEWMpWsiQP7HPqFptcGZoQ6nVv0kk2PCHsYjUk
 wGb+b3EUbkbtbm9hT16U+v1x+RccnKJAmM1X3YyR3FhrWmzn3DEAc0NRdOess79f4qQJ
 4XkWs47hJj66G1rZlQPTy6AmAnZSme2/cyTv8rG2E80JWBbnS3ODDQZjM+SJg+3wU7k8
 HFiX1nfaCM4FeXtY5hIfy67hf1EpdZ0cEB9aHP4hc8I2m+Lza+jgE0lUgc3dhO79B37M
 egvA==
X-Forwarded-Encrypted: i=1;
 AHgh+RqTOuHrygmyBImCi6z7ptA9Y1BERS0AfELJzRrm8zRCqejIjoUeUqYTzEKWugNYl/n1fk4FemCHxyl0@nongnu.org
X-Gm-Message-State: AOJu0YwdIjJjBvaJtUXHG+Cdb9ylMu6MZcStQoSyx647xY9WckQhC0lv
 Wvj+rptbqAB4/eWPq9K2dET5yVso2dTlCJLloDCUVJ+y1kTpvL4GOfgWmZPxlrX+hwyRoRBaKHf
 HQSYGgCfrDRW0nz6PphEUTe9gKdqb7/PXYzGca04YLBeR44gDSeVl6wTiB+YbOnrIKA==
X-Gm-Gg: AfdE7cmgBut9HCtpy36/P2X3CurCQ/RhIZHbqN8fhO3wcKxgzbet9aIdZ1ZRALx4JGj
 5LYqlw1B+9XPD9N1YEq90aVPNfU55MK6qZRYEVwfYTGhpxBZJ6n/8hB8S3JuKm2ES8VrCKIggqG
 j4f6fxPwb8b01vOUtMRCHeukrsC0osD1SMHhkL50d/yc11UIsLDhSTr7vWDt7YgAuHzaeHVYwuD
 n8loo8vriGbw1b8ZYwRzOvSYjwAZebp0Eqy+8M86gVhsLI0sq5aAgPJe+Q4RqfjIWNR4VJ4TzTg
 JmeOKXkw2gn/IwRMdyFED/+QLKqzvxLmqkcM1X4WwOHPekbz7CZkhAIqt0MJ+4NANl418fibgr1
 skzLDjga/mNWVnbsvLnKHZ1vPuJMahhVo+j7LtJBWQ7gwAbONDZMCOkogtQmW9A==
X-Received: by 2002:a05:622a:1825:b0:517:64b2:2388 with SMTP id
 d75a77b69052e-51caa08a913mr132025711cf.15.1783942570370; 
 Mon, 13 Jul 2026 04:36:10 -0700 (PDT)
X-Received: by 2002:a05:622a:1825:b0:517:64b2:2388 with SMTP id
 d75a77b69052e-51caa08a913mr132025481cf.15.1783942569874; 
 Mon, 13 Jul 2026 04:36:09 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0f21328sm85774945f8f.32.2026.07.13.04.36.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 04:36:09 -0700 (PDT)
Message-ID: <2716b6da-3ff6-496d-a380-d11f3be33663@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 13:36:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] hw/mips: add Octeon III EBB7304 machine
Content-Language: en-US
To: "Kirill A. Korinsky" <kirill@korins.ky>, qemu-devel@nongnu.org
References: <20260713112004.4956-1-kirill@korins.ky>
 <20260713112004.4956-10-kirill@korins.ky>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260713112004.4956-10-kirill@korins.ky>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: ejUi4kuYq62t65tEZpeANkjrBDI69q__
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyMSBTYWx0ZWRfXy6gYzxiP234k
 RxmRVn3YdHYyPD+jMDeUDnqapnIwd01RXV86ACmdbZCuO667KX4cFKBzBq8XP21vKS1QhrrjO7q
 9gbMZ+0B85ruzW3pWi0JVZMlVZQauhY=
X-Authority-Analysis: v=2.4 cv=e6c2j6p/ c=1 sm=1 tr=0 ts=6a54cdab cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=9oXOXeiqkHEnwya2cy4A:9 a=QEXdDO2ut3YA:10 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyMSBTYWx0ZWRfX1HyFKBgyPSNR
 dt2F+VVpR7r7GE6bnzc8hAkL5uH1H34X4w861LMHINUYJ2ixgoc810grOp4JFimHRpGusUvc1Qo
 BNC7Trke5zR/Bnu5dnAXph0k2QhD0EHHHy+X8XyEY52TbHN6OxaQldfapCgIadizNjT6elPrGcZ
 egt9gxN2lPSXgEzjojupq24kde5fPP/cUa+neBDI268J2leeqC/jXK6+ctObn70cOcUxojW8H0a
 qsHmv8tbowhP8S90WaAj9nYtNLBMbnnEdIw9cAuyEUoOHVRz5p5r98O5wEp7bP0E3CZ7qEy6ljC
 udpXVLm/9XpifHYEdMNeBVmp7uVDz2JnFSOwt0VEYCEw5YhIgXbzlJSc9qM21ninKmqMenyM0aU
 5g7d12LjnqBY7vLmwn82TEDE2d214jJAFO65BtxMyFMPitPwM4rZfPqxzfUIlyPxs8J8TneS6f+
 Inbf0u7KBZemMFBVfRA==
X-Proofpoint-GUID: ejUi4kuYq62t65tEZpeANkjrBDI69q__
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1015 phishscore=0 lowpriorityscore=0 spamscore=0
 adultscore=0 malwarescore=0 impostorscore=0 suspectscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130121
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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

Hi Kirill,

On 13/7/26 13:16, Kirill A. Korinsky wrote:
> Add a minimal Cavium/Marvell Octeon III machine model for the EBB7304
> evaluation board. This work is based on Amir Mehmood's original Octeon
> host.patch; the basic machine approach and several hardware model ideas
> come from that work.
> 
> The model targets modern U-Boot's EBB7304 firmware and OpenBSD/octeon.
> The same machine also boots the U-Boot image shipped in the ER-8-XG
> firmware upgrade package.
> 
> It provides the RAM layout, boot flash aliasing, CIU/CIU3 interrupt
> state, UART, TWSI/SPD, LMC state, RNG, POW, DWC3 USB, and minimal PCIe
> support needed to boot with USB storage and an attached PCI e1000.
> 
> Add a functional test that boots the OpenBSD/octeon ramdisk through
> U-Boot using QEMU's user mode TFTP server.
> 
> Signed-off-by: Kirill A. Korinsky <kirill@korins.ky>
> ---
>   hw/mips/Kconfig                         |   10 +
>   hw/mips/meson.build                     |    1 +
>   hw/mips/octeon.c                        | 3829 +++++++++++++++++++++++

Thanks for this contribution! Unfortunately the patch is too big to be
reviewable... Do you mind splitting it in distinct parts (add empty
machine, then add pheripherals and wire them to the machine, then the
test).

PCI host bridge, I2C and USB controllers deserve their own file in
hw/pci-bridge/, hw/i2c/ and hw/usb/.

Do not use DEVICE_NATIVE_ENDIAN.

octeon_board_reset() seems to contain reset code from distinct
peripherals. Each peripheral should have its own reset handler
(please do not use the legacy reset API).

Thanks,

Phil.

>   tests/functional/mips64/meson.build     |    2 +
>   tests/functional/mips64/test_octeon3.py |   54 +
>   5 files changed, 3896 insertions(+)
>   create mode 100644 hw/mips/octeon.c
>   create mode 100644 tests/functional/mips64/test_octeon3.py


