Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D444C982ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 12:30:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8dAH-0005VY-SK; Mon, 21 Sep 2026 08:30:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8dA2-0005QX-Kv
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 08:30:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1x8dA0-0001wr-Lm
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 08:30:18 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68LAdoFN1217553
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 12:30:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 exb7MIh4/C1kWQwYHE6RQk5kEFT2UArXS7rsJ7wYm2g=; b=UxzEB5pU6QCZqDNC
 knOF28hJWGj2ydcFSDOv0T1kLcyw+fQHQWgMrlOBx0hZ4XN467Ya/neSro0ClZu+
 8/506bAgO4D7NI0TFW0JVzKjD5y/FcdvWwqPRIMF8JjzxWL52CVxpAbiMmjs6qGh
 9qxrq/QGkUmx4RO0eNAfNIc1/LEPSWLMJq8je0H9zCRZmI8xLEe0kRfX5OTSYjqA
 JtdP8lwi34I43ILNULI+G2ZGGXv/k1vz2JMFkpvmxT36dyTRSYcW4Jn82e2H3DOa
 V9WHC1YADoykCOBKFpEZ+FdYF0lMlQqZU4KLdZmsZTXHLW0EZsc3ZF0xDs0s1NKQ
 6lGKRQ==
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gu01197wj-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 12:30:14 +0000 (GMT)
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-78fbc5a4cf8so3825745137.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 05:30:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1789993814; x=1790598614; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=exb7MIh4/C1kWQwYHE6RQk5kEFT2UArXS7rsJ7wYm2g=;
 b=gqCLhB7uaKw56fTEfbx0N/UD4aEaa8DKb+aHIX4zcpSXjZ2qiqkjYaFD3RSEEFT9RX
 nMGboG6YMyzd3mciKtdkZVu+QNiK1epfJxw4WMGm8j8GPu3g5O/5D/SI9+aTIlGMt9/v
 f/P51HWk2XYoYc0KI3dSN6B6Z31jkEDxl2cl3/CSNTUaE+EPCJTkm/5AdvFmfGYbPfuN
 WXs4CgLdoKCqdvTswEKgSlm0TYMSGJO8N0BTv6XH2maaztjaU6BtfMLgdiVjSe1gePQz
 m6Aw0i2ZEORwSXcTl6aI8PS2Jn4Vmjev2NlyGfjDP8/PMet5J3Qy5v3SxSUefZCvs4FQ
 ZB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789993814; x=1790598614;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=exb7MIh4/C1kWQwYHE6RQk5kEFT2UArXS7rsJ7wYm2g=;
 b=ql11sdxpVZ/nWqmxa5+lliX2WlzWyXDY1hAJynOMhlbtXJvhMvgdId97FpSZQblmjw
 G3yLr8E5NxNcIzGegocnuwUVte5ZsedNhlEnWtmLN5bi/u/TeqoevorHnOHSn/Qd4okQ
 BM5k1+3/9YyUOEweeMrtihIaEYY6HMAjIOqa9fqK8w4qZvtajTz8GNcaCkbVMo5q4nwL
 RqJdFwW5K8FilgXje4ANbJrTPJhvceQYzwgMVylcHC5+FSjUoRUXJwd928BhRDaG1c6O
 sOCQfSDCsWE8ycXePPyACp7pATfPdh8E7YV0Cj81yXDo0UbVYSEOG5o5uQj4l3QRiKLY
 zbXg==
X-Forwarded-Encrypted: i=1;
 AKwUvByKkoVmp4aNoPAErvtBXQVvCsok+gNS6t8i3l34aAv/BfKhEj8llgXYF1LUHvps5RNye2hkXbv+J8VN@nongnu.org
X-Gm-Message-State: AFuF++mLlmpuzJd8yXDkBOToWvswpzVPG4VCNpJeOMpa+GRCxktDDphq
 m+D7BeClkwsNtzXQyy49H6qJHtcoOBejQUJkuIwN+jq13ACOLfCtgR/rp4dvQ9Kr0P6lH08+yOg
 CXt9KxnMQOAbUikwKxXl+hkCUTIelS1tZlxjcrxWzmfR77oPHnp1PL2m7Ew==
X-Gm-Gg: AYBFou2SH1KjSutiPUusm33VEQAmFYLLB72DgVZvUXsSSUntDDleA6qL7XWrxzp2TL0
 iIzu7xS5KDaVUwgxaYS1LAtaJJz39LmRQnXV86gZKu47oSRlUOBHuOlRnuwxakawPIOFqegBA1S
 nN/RmpXHVC5ABYZFibT6bxqSzatUiFZZWtnxSfyYtrdHjTJYC76+XuJzpemzVSxb+zZm6c0XJzt
 SGM2/AGjLQCVdhTgSPdzTn9dYWdvKNsNH8zoZMb/NROJm/GFpe09oAAy/sAiizfN0GNPrXThbcR
 PdAkq2xaNqxFL34yrIcVOGnS8yMtNgtBYPlD3y7wIg8/jK0QInc1m8h4Mwf2bfV04Z7T/jjPuZC
 hYTxlBbseE9+blpJ6BuZt0A08g3Xw5hTqiQ==
X-Received: by 2002:a05:6102:2582:20b0:7a1:f2b5:645c with SMTP id
 ada2fe7eead31-7a1f2b564femr3461067137.25.1789993814064; 
 Mon, 21 Sep 2026 05:30:14 -0700 (PDT)
X-Received: by 2002:a05:6102:2582:20b0:7a1:f2b5:645c with SMTP id
 ada2fe7eead31-7a1f2b564femr3461046137.25.1789993813676; 
 Mon, 21 Sep 2026 05:30:13 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fcda2140bsm249586455e9.1.2026.09.21.05.30.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 05:30:12 -0700 (PDT)
Message-ID: <39414f23-09fd-401d-839b-c3fe08aa6354@oss.qualcomm.com>
Date: Mon, 21 Sep 2026 14:30:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/char/stm32l4x5_usart.c: Support 16-bit writes
Content-Language: en-US
To: Jacob Whitaker Abrams <jwhitakera@gmail.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, Jacob Whitaker Abrams <satur9nine@gmail.com>,
 Samuel Tardieu <sam@rfc1149.net>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>,
 "open list:STM32L4x5 SoC Family" <qemu-arm@nongnu.org>
References: <20260921050959.1876719-1-satur9nine@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260921050959.1876719-1-satur9nine@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-GUID: XWhabEV-yglkj_OTr2k2azu-kGEcJ79g
X-Authority-Analysis: v=2.4 cv=dPczC+Zb c=1 sm=1 tr=0 ts=6ab12356 cx=c_pps
 a=DUEm7b3gzWu7BqY5nP7+9g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=wwpT0siQYdPtGs8qREwA:9 a=QEXdDO2ut3YA:10
 a=-aSRE8QhW-JAV6biHavz:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTIxMDE4MSBTYWx0ZWRfX0ACZlUh8c9b6
 gIOojcRzN11QSKrh2sD1x4yNiOeYKHDhU44ZEPGX8kR3d5Eg/nPfj7P4UHKWOwPs7nL+Au/ew2J
 EWni2st58oKuvVif/SwGuqhCSEr8PHyuUBojHRehtxtTV6M9q+Itoaeif7ii2sRt8QW7XwvvEM5
 jykJYvGPlZa0cV50cyQHDcDMuIA5DIUjDSXV2BsrQC+IjxPDNDSYGSyaymOxJafOANF378fLpeU
 5kXPpnAMaD9zKtCvnBBbvbOTugHlJDyr0+up93Kx2YYGK/nqq6UyC6kR/AdcXTE0is+BnZdapFo
 5dQrh8OImAAo/QVWepE+ZhehJYSL1MS401IheplX+dhS2f4F5ZTzFEB+8xc+pcSHc1cijT3NTP8
 JlwLa/vUiz/sJgS/nDewTmZKJfYynS3eFR4y6ajxXE0HEutQ3oLn+TeTqlIOkVsDC9S4Y1Ml+GF
 bn1DiyWqEdfXiDt6YlQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTIxMDE4MSBTYWx0ZWRfXyIgdpCYEeDz2
 QNfJ0wxAXIEuPJcCGovIr1dKzHssfGc0ILGetA1Qawxlw8Tbl98f9Xq+EWfmyIpfMhLqk46bu2n
 KoC/ABoy/SDI5lasDn9dH5vNHQg24kY=
X-Proofpoint-ORIG-GUID: XWhabEV-yglkj_OTr2k2azu-kGEcJ79g
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-21_04,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 clxscore=1015 adultscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609210181
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=philmd@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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

Hi Jacob,

On 21/9/26 07:09, Jacob Whitaker Abrams wrote:
> Official STM32CubeL4 drivers use and require support for 16-bit writes to
> UART registers for proper function despite datasheet claims.

[*]

> 
> Signed-off-by: Jacob Whitaker Abrams <satur9nine@gmail.com>
> ---
> v2:
>   - Remove all changes other than supporting 16-bit writes UART regs
> 
>   hw/char/stm32l4x5_usart.c          |  4 ++--
>   tests/qtest/stm32l4x5_usart-test.c | 22 +++++++++++++++++++++-
>   2 files changed, 23 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/char/stm32l4x5_usart.c b/hw/char/stm32l4x5_usart.c
> index dd1b099195..3b9883bb23 100644
> --- a/hw/char/stm32l4x5_usart.c
> +++ b/hw/char/stm32l4x5_usart.c
> @@ -521,12 +521,12 @@ static const MemoryRegionOps stm32l4x5_usart_base_ops = {
>       .endianness = DEVICE_NATIVE_ENDIAN,
>       .valid = {
>           .max_access_size = 4,
> -        .min_access_size = 4,
> +        .min_access_size = 2,

Can we replicate the description comment here?

>           .unaligned = false
>       },
>       .impl = {
>           .max_access_size = 4,
> -        .min_access_size = 4,
> +        .min_access_size = 2,

This files defines addresses using the REG32() macro, and
the read/write handlers switch over these 32-bit addresses.

Why change the implementation minimum access size to 16-bit?

>           .unaligned = false
>       },
>   };

