Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A8DACD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 12:32:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZpQy-0005Y9-Dt; Wed, 17 Jun 2026 08:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZpQw-0005Xc-Mt
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 08:31:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1wZpQv-0005en-2b
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 08:31:54 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65H8UfaO1654310
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 12:31:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 niRn+dNJeIemlNqpivtJNkz0wB1fY5y3GFMTNzWzE9M=; b=KHdfh9XILedj/mEx
 qROp/oHMlmiq9dtWmZo2+uvcezE+GaYo1E8J2XNdVCNlTDz5XMZCL73KuDEiNueb
 MSpkqnoQWrP8/0l6mZDvWFtvK6TZcApaoraciOSg3uih5b3pDtdPmRC8MVGnQQ/z
 //T/a6p1b3WVp85mIQc1+3lSN8VQasNWm23hJ3k7tVzxYpc+b1h+us8132+pfqCp
 7TahKII6ZNDbmBJQD2HYRYCQrLMtGjixnluxn0p3zeD4Yekhh2FqHxSp8yaTEldi
 zkbFtknnAvITRGyb5EwcV1aK4zbcEhIjbTKf6zmRZyhXB9ROPxq+JO8N/mHoSVO1
 p5jvdQ==
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eueer31tv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 12:31:50 +0000 (GMT)
Received: by mail-oi1-f199.google.com with SMTP id
 5614622812f47-4862fcd9a3cso8257583b6e.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 05:31:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781699509; x=1782304309; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=niRn+dNJeIemlNqpivtJNkz0wB1fY5y3GFMTNzWzE9M=;
 b=DcFsPxkioLlBK/4tuyIfIDZPB89YtWfdvmvQif4x8huJHpwWFyMffvB6uANDuKsURe
 N+g1hqaZajab1Qoe3N4biyRJgS858q+RdA0q8+zZ0z80Q/zL5BH8Wb5l2SrQYW2SOPMH
 6wgB7h12ZslmfdLkanB5zi1Vjz0R/Lf1Zf4xzQvOpi3NscmL3hBLLVax0jmUunKWowMz
 Q2AtvirkXWJTXwgEsBTURSRwENwk7jkOPNlplf5HRJT+3bmqsRkeUikPrc4Lc+e3bNzX
 7c5C/SyF08V5KU0aHpDhLfxDGX+jJ6wZ/0c27z9+SbBbN1M6NQW+G9AbzlVstfzc6i8L
 1iAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781699509; x=1782304309;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=niRn+dNJeIemlNqpivtJNkz0wB1fY5y3GFMTNzWzE9M=;
 b=NG4kNhPF4Dy98j1EAALR7wl2eAmN/47MyMDvczy6R3mva1SWkwwU9khpde0nH+8yAc
 gd/2Swlz6DyLBRG4VNqmTwhKZskXAsjesvZ2rVH6q4IRgKgjzAT+6Aewr9EIi4OJPulr
 ig7oHpkkjKjXizYg784k87k3PDTDZKC9D9tFUtLhT8mXkiEq0BvLSsTildBWWWRjWFGg
 tDRE2bRyNVgPPJRarLh8zdurQJOws+TK3NcbsYuLeUz5ITog1A5RCOUsQNL656/bH0ef
 UjXN+ofyafOiBtUrwLuKKZI16DJU+BljV4IPvVzZdVRCtbFp0betLnPWwwOXd4OoMDmB
 eIfQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/xPhuiJauZiQ1kMqdkApn/JRfOaNvOhsoUDTbLNlhz9wDDQvOi9Kt487qeMEHKruAoofhLx9SaiyMq@nongnu.org
X-Gm-Message-State: AOJu0YzL7WslCdVLwd2b2S6KMNUFcZ8I+xnHbeV16W7bw+0FBV05u+7A
 PGj7p33K+9u4tILhuGgIVcv/E80KH5ZJ0D8gdc9GxRdBfneGM96UFSG/d33U8JECjiwPjblPwFA
 oyLt1R+eCByc8a0gU2Lb4UvbzM/dqPiMry/Y6u0eRH2/s3x3DJXxjfsfIPg==
X-Gm-Gg: Acq92OEtyrJN5AlyxQOSLpkQVlAsMtT3Oghoaz4klWfA+hQr0ZSColsAMUbmpx0cvQ+
 SuXSm3ZhBYS2qEhYEZuVllGMXvUC1HwZeEpq2DWVn4RVsUlSoQVZanoRgmO5BdmoHwi7S4xQ5rL
 FKeRUdkEt/dKgW3QwSD3WEQz4GZUTdBf+F1PjHHDutEbERWm10DJo0akoHnGkoh5WX0A+818w6W
 8ne5dyZByeu1QpG0PeuXSl4eOI9uioWIPih35XgHJUquHXVMV3a7xIzOmaMUx8u5NWTnrHYmHmj
 xDiQlaccnwKjmdZ54rjcLZkNu8DqmRYt1RVKyiF14STyeYjSiQaPkJpx5jptFH4V9xBtGpY3O+3
 4NY3UdrIVeHH+v1CvXvQJVTHW4lW1xu/K50eBifnXfItg6ts=
X-Received: by 2002:a05:6808:50a0:b0:485:29d7:70a9 with SMTP id
 5614622812f47-48942be9245mr3417098b6e.41.1781699508796; 
 Wed, 17 Jun 2026 05:31:48 -0700 (PDT)
X-Received: by 2002:a05:6808:50a0:b0:485:29d7:70a9 with SMTP id
 5614622812f47-48942be9245mr3417011b6e.41.1781699507923; 
 Wed, 17 Jun 2026 05:31:47 -0700 (PDT)
Received: from [192.168.68.103] ([177.170.117.62])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8d9f14168f0sm68807586d6.6.2026.06.17.05.31.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 05:31:47 -0700 (PDT)
Message-ID: <baf3069e-7950-4384-a9f3-2a9abc0b05d2@oss.qualcomm.com>
Date: Wed, 17 Jun 2026 09:31:44 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] tests/functional/riscv64: Add virt machine AIA boot
 test
To: Joel Stanley <joel@jms.id.au>, alistair.francis@wdc.com,
 Anton Johansson <anjo@rev.ng>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260617054034.1020724-1-joel@jms.id.au>
 <20260617054034.1020724-4-joel@jms.id.au>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <20260617054034.1020724-4-joel@jms.id.au>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-ORIG-GUID: tConhEYnICuQ8VubcRUPM2sJ85kGkPSa
X-Authority-Analysis: v=2.4 cv=Mr1iLWae c=1 sm=1 tr=0 ts=6a3293b6 cx=c_pps
 a=yymyAM/LQ7lj/HqAiIiKTw==:117 a=gdiugJE53z4H+vvYeRBHqw==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=oNMWG6_fg_YX9jL0BucA:9 a=QEXdDO2ut3YA:10
 a=efpaJB4zofY2dbm2aIRb:22
X-Proofpoint-GUID: tConhEYnICuQ8VubcRUPM2sJ85kGkPSa
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE3MDExOSBTYWx0ZWRfX6zTxH5pmGgDq
 7ki7/ZcPBLlT1mPAdLSTAlDQ6ayUDZ8eyxh/moLNpqvauEidNhpjWY6pkFS7jU+3QsJXEfnN5LV
 zYXAuqtkDBK8VkrLCOGcqu4S1N8kS2M=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE3MDExOSBTYWx0ZWRfX+GAW0CJLRlKL
 MbnbISpHewbWjrOZskcGjj2R2vvp+jfTMsEpZQOcd2bTGYN4LWTa0eaIplh2t3Dmmee408Ajz6y
 i48W+qjVjZVpsGi9aqYT3a+tmfl2jp0FsXxT+vd6TztXggk4jcS/qSvcWSPB4BZtfZ4VBgidE+3
 aVR0PzxyyS82l2bg5xcwvdtdaPpq5u+b1hNZ0jlg59owxAsfoDoCv5IG1VACKTeDKv+XQrUFc1k
 gbqa5OuQ07z+VMW8EGmRaIejcGcOu1oS2lrp7FknxQukCcyDRXZUDotgIpL6OAjCiObHSWUGUUY
 bhUhiTMvnD0hVQJQP9Mm++ocD4eqa5jF54jRLQCCX3Ql5rM+BJLf4Hi2ioKdu9/vvhw0Cef4A32
 2+4kRt7oslhtT9qrBj6UypN7be0Zz4Al88dFgQvWcO3J6rPfuLORt5s94mwBiEIHCYu3myXjvfP
 T5gZBxUsAkXDb/H0V2Q==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-17_01,2026-06-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 phishscore=0 bulkscore=0 priorityscore=1501
 malwarescore=0 lowpriorityscore=0 adultscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606170119
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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



On 6/17/2026 2:39 AM, Joel Stanley wrote:
> Add coverage of the riscv64 virt machine's Advanced Interrupt
> Architecture models. With this the APLIC and IMSIC models are used by
> Linux, catching regressions.
> 
> This test requires a kernel >= 6.10, as AIA drivers were added to Linux
> in 6.10.
> 
> Boot time is ~5s on a laptop.
> 
> Signed-off-by: Joel Stanley <joel@jms.id.au>
> ---

I think we need to add more 'virt' tests with all sorts of supported setups
and configs catch these errors as early as possible.

This in particular is a nice test to be added since 'aplic-imsic' happens to
be one of the most used aia setups out there.  We should start adding variations
of this one  (change number of aia-guests and etc).  A work for another day
though.



Reviewed-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>




>   tests/functional/riscv64/test_tuxrun.py | 7 +++++++
>   1 file changed, 7 insertions(+)
> 
> diff --git a/tests/functional/riscv64/test_tuxrun.py b/tests/functional/riscv64/test_tuxrun.py
> index 43d1242be52b..6203a45060ce 100755
> --- a/tests/functional/riscv64/test_tuxrun.py
> +++ b/tests/functional/riscv64/test_tuxrun.py
> @@ -41,6 +41,13 @@ def test_riscv64_maxcpu(self):
>           self.common_tuxrun(kernel_asset=self.ASSET_RISCV64_KERNEL,
>                              rootfs_asset=self.ASSET_RISCV64_ROOTFS)
>   
> +    def test_riscv64_aia(self):
> +        self.set_machine('virt')
> +        self.vm.set_machine('virt,aia=aplic-imsic')
> +        self.cpu='max'
> +        self.common_tuxrun(kernel_asset=self.ASSET_RISCV64_KERNEL,
> +                           rootfs_asset=self.ASSET_RISCV64_ROOTFS)
> +
>       def test_riscv64_rv32(self):
>           self.set_machine('virt')
>           self.cpu='rv32'


