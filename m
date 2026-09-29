Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98A32CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 12:24:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBWsJ-0004jX-6N; Tue, 29 Sep 2026 08:23:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBWsG-0004bX-OB
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:23:57 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBWsF-0003pq-00
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 08:23:56 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68TCEFBV3851848
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:23:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 pbLyNyRKfAJ2mCFtGp6eeRnUKBZnlSrxJUR/CZHXjzc=; b=Upt5zZt1MbXuUOif
 cxwDos18fbptVwhTTp4FENUSl00s3bl1b+CRIWY2pSykgaH42xyhbDHBiTIhSq0r
 u2ucCDM0xDiAAB41WntArdWVDFbnipk3oayw9OVR1GL4TnH9EjgZtg/5dUkEJdF6
 CI2hTgegGsGdYGL58+xtubgGItKwVknlkZSJfnpGprhslewM85d+CJNIpW5clmss
 8UWWZDuMzKriey9cARjTdSyqeMZzbSRwbDW88yDITkBap527L6/xWcRSFVezZ0mi
 xzAgHcUnY2futgz1XLwhJqtsbCJA/RaAusuMoDg0Ca+u9wDUvu/LqCbCZTx8vKrM
 MG0EDA==
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h0bn1ge1u-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 12:23:53 +0000 (GMT)
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-790e3ca4c85so650254137.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 05:23:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790684632; x=1791289432; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=pbLyNyRKfAJ2mCFtGp6eeRnUKBZnlSrxJUR/CZHXjzc=;
 b=kHIaXDa3D9kJGUTtDtDotSEffVNYS6DDLrzHxtlxGNMro2FMvc5N45M0peoqxRNu79
 dkhHAz6GJKeH/72c7W9OjovRyNhq15sOwQij5ZnKIGmkgbR2TXVmMAi+OgNKSl9BRCGm
 2qgGP9oYSlOdkUA2r3fvnYqGGTPqHJAn6mPSkLW0qj4653Fx4T2xB28N7NaEBK4eEHT8
 htvQMVsJvAGGH3n1MHXvLK90Keg9hkGyqtzL8hH0fOSWBW8AoHaZIo0x2oEKbjGyRi/l
 Q/hUGw6LM5NcCTx0mZJ2ytviNZkWDJq2nQ3A6ZTQHNJLegAD6Gyq8nuwl+DRJx7kevzI
 qbeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790684632; x=1791289432;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=pbLyNyRKfAJ2mCFtGp6eeRnUKBZnlSrxJUR/CZHXjzc=;
 b=FCwAM7K80MTrOzwVcQSkXVFTenYAi9V9DmERU5eON19WOm3Rlcz/28NE7eq7HYJMdK
 qf/m87G1ddXYhOT2JGRvr73UzsRRnn4VdHhGJUlUuliabCW5370fLKe1ReXkI8rVIrKM
 +XbJDz4PAXiRl/0chK1Hw1wMCwE1+Mc+m9qEYItcUXtMH31IqbiXAMNuvRndhxrWrQ67
 e1KSJXtfqIfCwhTrJ7opqpAu6ARjHex7YKOXTRN97zcC8krlK/DDlyx0FdufyzDMBUKr
 zl4FLD9GClYLydT4KHoh26Yaw7Jn+JACZWfO19QA/j+2yAtaaoNKMT7oyIVT+izJbtuY
 7gLg==
X-Forwarded-Encrypted: i=1;
 AKwUvBwH1R0uNLDKMNyWueY8+A7mYE714wUChQ4GldocsyHW7nBv85xx4DAwGwUAx/CRhBXdksMutCnXr4Ej@nongnu.org
X-Gm-Message-State: AFq9FYI5Il+9ynZ4roDCEKzJ55+up3J6J7e98Rdwd8t+kaMpzPlJPFia
 c/wW4Ja/SUjSMcN1L/ubk2LvDLMePIiJ9GX7Hn++wMo5y/L6jG7qi0jleMzsb5LMt8icnUL0e1o
 lop38PzSw7Epvzx0r8E+xdF8kycwxkONDihSv5kiZXtXR9ZN5fkfk/w6ViQ==
X-Gm-Gg: AYBFou1LixIEOY7lZEdYu+BN1a7m9K4kA6FNoHr1sZyhaoIzyRNIVPr+the7FaUwZHq
 B366pCpvdyrxsg5qs5IuioqYpyEmPQZbLMV6i3un7H0KKLTMMrdEkpX321ZPh/iAzjwW81K3/sS
 yOsY9ac90Fs9/POwJx7D+9G0KmFt7nq/JNO5sUAOCeOkPWu2iTYdzt5Tpa9WdX651rX3qER9dvo
 8HgVqNgdVGGqERHW+vUNQmrQw/IdDJ7qoW68evdI+Ed+muGIb3mnBWrDii6JBOhORht+cSRHwVr
 RtrfmyOPTHSWyuPJ3Z2H78bffP3moPlq8ZsNYKIgroKwiHGdAjFZEsrVyfLAt1XNiOyQa7FdVIC
 tEf6fqvxTrbavLiCk5cHBTbOEEtXybBgl3A==
X-Received: by 2002:a05:6102:3f0d:b0:7b3:4199:2dd9 with SMTP id
 ada2fe7eead31-7b341994426mr2752648137.9.1790684632504; 
 Tue, 29 Sep 2026 05:23:52 -0700 (PDT)
X-Received: by 2002:a05:6102:3f0d:b0:7b3:4199:2dd9 with SMTP id
 ada2fe7eead31-7b341994426mr2752631137.9.1790684632024; 
 Tue, 29 Sep 2026 05:23:52 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48af50513c7sm3702386f8f.16.2026.09.29.05.23.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 29 Sep 2026 05:23:51 -0700 (PDT)
Message-ID: <625426a3-f2f3-4c72-a465-46c6ec57a63e@oss.qualcomm.com>
Date: Tue, 29 Sep 2026 14:23:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 23/42] Kconfig: Extract config FSL_IMX7_GPR from config IMX
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>,
 Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, Jason Wang <jasowangio@gmail.com>,
 qemu-arm@nongnu.org, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Gaurav Sharma <gaurav.sharma_7@nxp.com>
References: <20260921214710.29422-1-shentey@gmail.com>
 <20260921214710.29422-24-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260921214710.29422-24-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI5MDA0OSBTYWx0ZWRfXy+LaA0WcmRBv
 z07FTztRK+Ata3o/p/3JwuPJ0nmdMw/Jc3KdLXCwrZcSminRLLPFhQDSWt0qdaUIGI+ntfFIkTU
 03WP4oH8MMrjsxGjzdDdqSVDJ95bVhE=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI5MDA0OSBTYWx0ZWRfX5tudBS7iEy6V
 nUJhn8YHxdDgwxp58kvfJRyK4mW7DQaLJAv8TAqvWiAXPuRrVDuDWb2qdnf8c88iR1j/7iQBcC8
 HI+IKS659KNngUlk7QNKXZF6kXhKi9d9Wp4LnFwPUZZEo+izU5PdtfwgBGnjZY04/3H9J4fBI3E
 AeocEVLM7+4yvqiCtfOimPGAYMkHxM1NycvGcOrWeHUXRMR/N6thP5TqUfPubhoYS8NrDDoMl1v
 rFsIMphfuR8qzcwvEcvMBPuhB1LCgfPveM68ZEkxNoY3rjHy/4ZFgjN/DqmwaK9gydd+Ic8ZAyi
 HuXhxM0MPIOSM+MTi41d4fCz1TbmOHDiaDn+qRnRfh3EsRY36qUj2Yt0Jh0cPH4QIIfD5nhYvWA
 xlvAjzQ2FCw2CSq+UJTsIeeGdV+YL9suWOg/Mi9rGpyt3rwpT89lBUL9e0JNk10afzppI+XcAXt
 eGp2PNKIRGZnYz2i1yw==
X-Authority-Analysis: v=2.4 cv=JMiuIMKb c=1 sm=1 tr=0 ts=6abbadd9 cx=c_pps
 a=5HAIKLe1ejAbszaTRHs9Ug==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=pGLkceISAAAA:8 a=Ot67DT_QmXfz63iHxRIA:9 a=QEXdDO2ut3YA:10
 a=gYDTvv6II1OnSo0itH1n:22
X-Proofpoint-ORIG-GUID: o0Q9L5pGFW_3B0SO7yf6-tVagJOFoGKR
X-Proofpoint-GUID: o0Q9L5pGFW_3B0SO7yf6-tVagJOFoGKR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-29_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 malwarescore=0 adultscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609290049
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

On 21/9/26 23:46, Bernhard Beschow wrote:
> Over time, QEMU has grown a number of i.MX boards and the monolithic
> config IMX drags in unneeded dependencies into each SoC model. Extract
> config FSL_IMX7_GPR to eventually eliminate config IMX.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/arm/Kconfig      | 1 +
>   hw/misc/Kconfig     | 3 +++
>   hw/misc/meson.build | 2 +-
>   3 files changed, 5 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
> index 1436c05c98..d3dda015c4 100644
> --- a/hw/arm/Kconfig
> +++ b/hw/arm/Kconfig
> @@ -578,6 +578,7 @@ config FSL_IMX7
>       imply TEST_DEVICES
>       imply I2C_DEVICES
>       select A15MPCORE
> +    select FSL_IMX7_GPR

         select IMX7_SOC

>       select PCI

     config IMX7_SOC

>       select IMX
>       select IMX_FEC

         select FSL_IMX7_GPR


Machine -> SoC -> CPU & peripherals

