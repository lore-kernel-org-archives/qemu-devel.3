Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21DDEC5DF82
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 11:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx0kP-0003ni-0M; Thu, 20 Aug 2026 07:15:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx0kN-0003nP-3V
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:15:47 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wx0kK-0004p7-Pz
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 07:15:46 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67K8PFOj2465483
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 11:15:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4SLVibBMk/Aiqw8eHpm17f0cJIXTBqJ/HCG7Q9Pig24=; b=Nh1Z5mAhjtI9gWuf
 CfsDiyWZDBRvGS3a0/vO1zIWQtVV+LCF+a7Zs5mhtjLrysfe/5A41Fs9Ah3iVzLJ
 6THvC2nYyz1ZBflkSE1emSnvWdV2MLoVLIhhAuubC/5H417ate3OUipfb7wQuET3
 giEzFPntqpjkOguFLDHOLUskIFcq68BScNhgXlF/Ze0usIJIZxYJiHUBb3vCyAgw
 hWZHrTXEL2Wo8LI+tlRfF915tKmBvaq1pqQY62fmBzweFGWSclFEvsRriiOWyjxw
 8hPpk/oYIh3mMex51O9JMMIOPAFRIIRTuF/xbeKeVGMr56m/Qc14RkzHcWsmadYe
 vnOBDQ==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g5x29gnyx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 11:15:40 +0000 (GMT)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-9372b9db132so91941885a.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 04:15:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1787224540; x=1787829340; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4SLVibBMk/Aiqw8eHpm17f0cJIXTBqJ/HCG7Q9Pig24=;
 b=OTRec/g8aVxsYTdXvqpR08VtMstwVFOS/LQi2UXiOugpbICD8l/O0m+fipmPKTPUXz
 9Sfbd1TSdTwHLxgZNF3J1t/riNhyLOFo76bMf4GuC8q+3eVYYbX7gzFnfd9MMBvIaspA
 oGCN2zMeQMZgtox8XV7J1+rgeurwR0YkSZWNCqryO2o3r3dqmu6TcqUfxWtHBg05Gw6w
 I9yEI46NqQgNxLqF2d/bkO0x+VKg3NzCPd1BDXERjw16AdArZW3OHMu3HXAvqqOFyFoq
 kv4dfCejcpKik5eEbGwr9AtzyfJqqbbeO6kJ9fXodCZ3O5buTrH/WkQLaDa4slkZsbTv
 Ys0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787224540; x=1787829340;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4SLVibBMk/Aiqw8eHpm17f0cJIXTBqJ/HCG7Q9Pig24=;
 b=NE73h/Rk4x2XkTdKQeg2m6V7M6RmAychaoMJVv6aprYsW/keiS/qLmf1r2ZX27E8Ls
 i8G7eS7aeNOAyv0yWOnEG0GDKOPwVNzOvm8FDM+ceLvjf6d9qDONihmpEo/d6Lt7GORe
 zCFkr5qhOa5kuhn9ymCzwpcNqFSrBsYtr1fnIIyDx8Vh4BsrnvkbF/RKUV7t9NN97plm
 xw3q+U9POt/pvABL1TdGVlh9Fa+9Z6SRriUPHOLSe4k2LbzRfahbMznINO9eQSebTsNt
 J7fz7A1A2l8bafWsKOK/T15H/qs9IvS0N3f3ZFk1DCQWvNhFRFsbk6tffbYFLqFxOOYl
 bO1w==
X-Forwarded-Encrypted: i=1;
 AHgh+RqnDIGN01/dlvS78Nw9jZcB6nn2dptiSmAkUGegeY2Gdsx0Wj3PuXdylF1xzlLt7ajCO5R3+tVMkiwJ@nongnu.org
X-Gm-Message-State: AOJu0YzHk+CoGjmbO3k8SLHqrWPtT37GeFvEQgHrXTr06fhvSZxJPlRA
 7PNkzKVT0bQyIUgLGsUCk10pGjsPvZfi3oIw3iTyl41VvlK8UZP0CU0ovTh7ll+t+5KescN3N5t
 VmbIw/oGJoaESxec8uEKm6TNG6Kdjrm/jLrwJQiCiyV5Wz/4t9o6rAU7PSA==
X-Gm-Gg: AR+sD13bj+KF8G/lMA4yafs3hq7wzV6PVePbCDu8yqnt4U3ylUpxZqD0XRdBN7deHXg
 S4cAbweTPtlvIZ/+lVQnXVj90AXd+b4GYR6BTfre/EU2oLruYp/QGjmXL65zpKfBY720OsarFmC
 Z1/zYXrlCoAZQ7BHkSO7mlAbzS4eLbHMo3+i8FQZUoMm9p26TZGQN8qAeAroOcy4Wt2W5L1/voF
 v9t3akWjIRpZAILaQcYSqUEeOo2lMX7yDSwDit3dfsvXMMnr1TU8W5894e8z+BjOXBk5V0vVf3C
 DYVD0/fbMFfpySyywYzddsK+N9ZkXfe7O+j7/KaJBYcjwU4db/8RHyP0OcN/eC+w4WclioetgtZ
 PBDg4kj2PBVaO7K6Ojp5aGKXXVChpqxm+vaI=
X-Received: by 2002:a05:620a:2945:b0:936:cda2:bd4a with SMTP id
 af79cd13be357-9371e635d40mr834395985a.27.1787224539950; 
 Thu, 20 Aug 2026 04:15:39 -0700 (PDT)
X-Received: by 2002:a05:620a:2945:b0:936:cda2:bd4a with SMTP id
 af79cd13be357-9371e635d40mr834391685a.27.1787224539493; 
 Thu, 20 Aug 2026 04:15:39 -0700 (PDT)
Received: from [192.168.69.231] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14d9783sm12032730f8f.37.2026.08.20.04.15.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 20 Aug 2026 04:15:35 -0700 (PDT)
Message-ID: <10b4107d-2522-4d0b-a8b7-f5c7ccc7ecd1@oss.qualcomm.com>
Date: Thu, 20 Aug 2026 13:15:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] hw/audio: Remove wm8750 I2C audio device
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Jan Kiszka <jan.kiszka@web.de>
References: <20260819185430.3467629-1-peter.maydell@linaro.org>
 <20260819185430.3467629-6-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260819185430.3467629-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: PlB3_kFsZ19Wa4xmVpcGJxhcpT_dKFdu
X-Authority-Analysis: v=2.4 cv=V8BNF+ni c=1 sm=1 tr=0 ts=6a86e1dd cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=p0WdMEafAAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=scklK8NlkdanN0GCpHoA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODIwMDA4MyBTYWx0ZWRfX2jEu3gV3y1on
 zF1SYwiySnOxHnjfE+CP7QnMfyqBsI6Pacp7LiHTgJEwfGgl2m7tp+sntm/ZgU9RZK7CtN8Z0/l
 JDwXOmdzPqh/+ZI9biKVF2wnBtJ2SiGtJE+XjjH6opQvsIWEX7ThlukM53Wi9EO4mRwnr48WvMv
 nkowL0kYBi1C/hJBn36/mK9nFz82J0FY3+7q8PbVnC4R6/A87C4KC+AAIFyYum31/FokmNLkj0y
 j7owYSN1/eoCMnE3gETOym7tZt5r8sexVt/Qpf1nDDERa5s5eA7lDSena81ZxL3vylP6svRsATt
 Ym2UBh7TvY+2Q4fJ4qjv6y5JrNCwu1A0Y970tm7G29LVvTabIgiIs0W6gzrZWwkHr5TEr/aJbiI
 r2MMeChiU/1OVnT/Pd7bVL/4N1obq7gRvGgig9FRewbdQ90pkhUBB1UGDDaCF2jEoltIvU6Y4lw
 uOpeYt8P4T+zk4G9Pkw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODIwMDA4MyBTYWx0ZWRfXyAHWxHr3z3KR
 iGIWErHfT7JA4DZmZsEW20BVzSBp7GgHiTjDf9+e8Bf+OFrS5utvE/AIHVGBksogxpe8ABnovb4
 auuRn7WXylWxGwPJKSyxkZSZ419MsCU=
X-Proofpoint-GUID: PlB3_kFsZ19Wa4xmVpcGJxhcpT_dKFdu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-19_06,2026-08-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0 adultscore=0
 lowpriorityscore=0 phishscore=0 spamscore=0 suspectscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608200083
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

On 19/8/26 20:54, Peter Maydell wrote:
> The wm8750 audio I2C device was used only by the audio device on the
> SoC used in the now-removed musicpal machine.  Since it has no users,
> we can delete it entirely.
> 
> Although the wm8750 is an I2C device that could technically have been
> created on the command line, it isn't possible to do this usefully
> because the device only works when C code calls functions like
> wm8750_data_req_set() and wm8750_dac_buffer().
> 
> This resolves the problem noted in issue #4135 that there's a buffer
> overflow in the interaction between the marvell_88w8618 audio device
> and the wm8750, by removing the offending code entirely.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4135
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/audio/Kconfig          |   4 -
>   hw/audio/meson.build      |   1 -
>   hw/audio/wm8750.c         | 738 --------------------------------------
>   include/hw/audio/wm8750.h |  30 --
>   4 files changed, 773 deletions(-)
>   delete mode 100644 hw/audio/wm8750.c
>   delete mode 100644 include/hw/audio/wm8750.h

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

