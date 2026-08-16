Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B65DBC5DF6D
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Aug 2026 14:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvcI0-0006JV-Ru; Sun, 16 Aug 2026 10:56:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcHz-0006Io-Ay
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:56:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wvcHw-0002vY-QG
 for qemu-devel@nongnu.org; Sun, 16 Aug 2026 10:56:43 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67GDkpuu4143023
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:56:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 X5fUg7aVZd0xLpp8t3QKIhEJmceASxl2vAKj9rm2Rx8=; b=P9QJE+hXeXxz0sSn
 Uyj74vs47vl5OJzvhdG5sC+d8OLQ0K9Z/81QJwgJ7r6F2JFlo6bxSC2BBE6x2NT2
 SMi8jDDeTcEbw3RFSC+6gn3wGYqdwCvtrlAyt3pRSDvpe1JpqcljBwuUebtTXLBy
 CRAW1Q/MkZJD4zGUyU95qwokbBJ7OJHaPg/wro8tgaRGUy9F/Glfi3Kk9L3f8K8P
 5cxC6RSmzQ5h8O3BIDCr6g+3EZimiSc3pScW0NP5dxLOm/xG4U72aILLdBDYrh7T
 gD/v1JJrQF5GC5Pj7L8+mEq7lvi9wfsKJDnbU5Kfp7gWh61rH+EmylX5rRApxAVk
 RReFzA==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4g2ghwkkta-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 14:56:38 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51c1d7886cdso51170741cf.1
 for <qemu-devel@nongnu.org>; Sun, 16 Aug 2026 07:56:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1786892197; x=1787496997; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=X5fUg7aVZd0xLpp8t3QKIhEJmceASxl2vAKj9rm2Rx8=;
 b=B6ITAWFl9ssJL738TzOy5DP29JUAVt7UB9JFvzUjX/bZQUVEjUyoP+ycpzQLptya/B
 HJR4xb9dg3H0ULrINiRgaL0+lu8HzGK7rLmx/yY+pvtTIvV45PwyTTC9/ni3eqe7Xm6w
 PEP95izWWdfiO8eWrms/FqW5ke0XTQo2HGKY9rJO//d2sF3esPPtd1pj84lEyA7Mzcy7
 d+sXfKPyIV1ZHj/OfxJIiSPb+rpfdmJ0/O4BGPIvFhrZMXyG5FfderacVnVhH2CUILH5
 U3DmnhQ5gVds8C3WspXP0CTEIRJrB944Shbu12/jx0vwI+QRbTVWJz5dgNqcDgJKuMmF
 bhHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786892197; x=1787496997;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X5fUg7aVZd0xLpp8t3QKIhEJmceASxl2vAKj9rm2Rx8=;
 b=nk9/utu53Lhunm8WjODytcslLmRAL2w6LDLwIHxKFTUsMY/vxYGyn1bCnpiJu7pEGf
 WcNgfRUf/bMVoKwbX/vCG73JDFhZkMKAEfTQZna2U/6IMZfZiyHB8nl4pB8KXXpU8kLy
 Q4yWeRavVi0OfRabNrCbfTrQSgpCKCj85hGAtPJq2Y32Rr0IMgtrury5xz5Jh4fyCAko
 8P+e4GUMCii5tpORQSQAWqYizZj+BS5Nto2jt8hVKcxcepF0hENbq+0WMA7wB/ARL+nq
 74bq9STqWcaEhcXMFp+en+jKP5jdtLIJWnFjjbYsM45RqYfZsuOaK6LVThYwExuYeQBy
 b0/g==
X-Forwarded-Encrypted: i=1;
 AHgh+RoFMr4wRW6SRcSRkg6xGPQVatGTAe29IvehMusjYyiUuCG+zuRJS3JhLQtvutlonSOFqiDJG4L5ni7D@nongnu.org
X-Gm-Message-State: AOJu0YyrRQaSnjP+z+JukRrTtm3idz9947o5Vol7UmX6XiOeTl1l+fbe
 38Gb/vpT+dAsVIXs8PflawubdG8/HRvgLAcrCwD3vUv7OFoXGBo/V+89gnXmaDC9I7Ld3baXq2R
 gVd3aPGy0ZuMOFBrP8unBR8yglhwQXLz5y+kOU/fFVco4HxlpY0L5We733Q==
X-Gm-Gg: AR+sD13UBsgxY5IGGmsqpHZufbvh0cMO/ZVp5lR6uovc9dJIy/Vst0YJBUfyYomrugi
 GJhQS7TAcQPbG+1C4jHKKklIQqR0Cnsjw0/KDVYuBYW9+OiaNIYjwPLDtk9WGt4v6nNMCZ1lHqo
 AQz8TJTvIH2wq5r92ujSzynaYsvgXnHSLNg8XuuPlgNqZRHAwQK7dQ8x/yYQTkvU7Z0xbSLWVQb
 61T0xF7ROvOSETCOtsxdtYDs5dVGSc+d6L8Zt/m7nn7K+uDHWreeWQPVu2yQfpKW8t1Q5lwy5eT
 TyqrcXdJvpD4jykmagR43IN0OlAF/LyKQmbTb7yy9dnAAdXhkyk86yQ0nZDvzzGamqDVAx7fi7K
 FAU05GOhe7xP0nuLTILqvm7o2u313Mf8xY1c=
X-Received: by 2002:a05:622a:40f:b0:521:8ef0:b4e0 with SMTP id
 d75a77b69052e-52d8534dafbmr208752371cf.17.1786892197544; 
 Sun, 16 Aug 2026 07:56:37 -0700 (PDT)
X-Received: by 2002:a05:622a:40f:b0:521:8ef0:b4e0 with SMTP id
 d75a77b69052e-52d8534dafbmr208752151cf.17.1786892197191; 
 Sun, 16 Aug 2026 07:56:37 -0700 (PDT)
Received: from [192.168.69.229] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499906aaf1dsm104452945e9.4.2026.08.16.07.56.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Aug 2026 07:56:36 -0700 (PDT)
Message-ID: <2617cdda-c353-4f00-9a6c-9bc2c37440e3@oss.qualcomm.com>
Date: Sun, 16 Aug 2026 16:56:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/20] hw/arm: exynos4_boards: Store boot info in the
 board state
Content-Language: en-US
To: Bin Meng <bin.meng@processmission.com>, QEMU <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20260816131300.51799-1-bin.meng@processmission.com>
 <20260816131300.51799-7-bin.meng@processmission.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260816131300.51799-7-bin.meng@processmission.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: n3ceyBvv9zRyY0yct6eeoCsqda1kog5v
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfX9Lx9cmSsgk5Z
 UhOFA90mzRw1R1RaeGF9uPuxiAF+J0mw1ZafSwT6HoKnmiW9MJ0hmv/RtB2WrQMsWuMmU+krlh2
 XyZRbFxIzgkqPW4XQp1ow39jHUEPGqoQ2ulx0FLJ91onY1kTSHlUncKvA5La/3d510AEBeHxEnY
 tXPk3GXUa1no8IFiqvylCURZxPpO3qhI90djGjP3adZuNv/rRPSMm3/E1JnaL1s8suXILuP7qhA
 xJLRlD6mg3ebZwNNTMIOC6v0a36vJAnL+veE7kqY7YFd6ViprIpDExg5Fq2EkfNVMq+45sFiiqW
 7QS7210w1YBgbB1EHSmQ/isuGySLWTJbMCUSpqoG6EVAtkM8PrZhC2Hzi77lQXrlZml9ZQKQlkZ
 MUiK8hBAFglzlJ/kOaBCXDMl45c+AzD96M1YKhHHxQ2KANvTtDUEggQX+DFsI9V1egQxHAmaX+v
 B1VroQwf2vF/yBOJezA==
X-Proofpoint-GUID: n3ceyBvv9zRyY0yct6eeoCsqda1kog5v
X-Authority-Analysis: v=2.4 cv=DdknbPtW c=1 sm=1 tr=0 ts=6a81cfa6 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=FRSEYCzRAAAA:8 a=EUspDBNiAAAA:8 a=P5mgNStSnDlmL_58Bq4A:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22 a=H4N_Y-AU75W7NKDNhZlT:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE2MDExOSBTYWx0ZWRfX2itWBnb4yk5I
 WyGh90+IJnWsTY81BbiqbCrf8gzZWnqQnmX//PplsLyXWjKMjpn8pCHzcn0NoQwc8ucKNpEK0au
 rsFrx/NQeqt9gcw6L7vKYUvoXorcz7E=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-16_04,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 clxscore=1015 priorityscore=1501 adultscore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608160119
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

On 16/8/26 15:12, Bin Meng wrote:
> arm_load_kernel() keeps a pointer to the boot info struct for the
> lifetime of the VM, so the struct logically belongs to the machine
> rather than to a file scoped static object.
> 
> The Exynos4BoardState struct is already allocated per machine
> instance, so move the boot info there.
> 
> As in the xlnx-zcu102 and raspi machines, the boot info belongs to
> the machine rather than to a static object:
> 
> 4d1ac883a7 ("hw/arm: xlnx-zcu102: Move arm_boot_info into XlnxZCU102")
> 0f15c6e338 ("hw/arm/raspi: Move arm_boot_info structure to RaspiMachineState")
> 
> Signed-off-by: Bin Meng <bin.meng@processmission.com>
> ---
> 
>   hw/arm/exynos4_boards.c | 26 +++++++++++---------------
>   1 file changed, 11 insertions(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

