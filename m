Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 107CE606A31B
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Oct 2026 03:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gCt8NnDn;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hhGAh0we
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xLXhv-0008AR-TE; Mon, 26 Oct 2026 23:18:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLXhs-00089i-D1
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:18:36 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xLXhq-0007VS-SR
 for qemu-devel@nongnu.org; Mon, 26 Oct 2026 23:18:36 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69R2F5gC512361
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:18:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Yx5bXM/cYo5UbS6BHzv1XuuXF1QAiMID1ROVIcNS/KU=; b=gCt8NnDnTMMaYXvT
 B24Lj7rECvSrveTp7MJNjXlTTMwi/HqW7iRHQtC5nJYY6YT09ubB9p3gQvOrW9eW
 Cyb2yS07RKs12hhNRE0DI6zJOYNuAZnS5/dG5+WwCHxgVaaZy1GfWhKrBbrnWWlg
 tT6wcbJ0oW0jz2t8Uh0+t0icQMRQtgxJDrFx1ZAG829Igd7C1B17+IG7vtN9gas6
 cvKHUG9VbPo8YRMUuL2OtW6i01zIgf9ZG68CBReaVShyvzp68OneXVc2hFiWKSBl
 nioIXwL4ttZrzAaRBSfdbbcNv71/HeVyWSWpojL+pudtvHUkkGwmOEOTVyxuCQxm
 Tqdnbg==
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hj4cpbk4j-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 27 Oct 2026 03:18:32 +0000 (GMT)
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-93f2c0e6653so416398885a.1
 for <qemu-devel@nongnu.org>; Mon, 26 Oct 2026 20:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1793071112; x=1793675912; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Yx5bXM/cYo5UbS6BHzv1XuuXF1QAiMID1ROVIcNS/KU=;
 b=hhGAh0weYtylWDyAd4V4M7/RPzdjBUIk3dwtfI1Rtg2aKf3Snw0d1F9knRqm1HM+vy
 zVxQN3mCo1qFANb1I51vq2ZYOdBQLzkOvHxVAlVpkYCgVx/Nyadc2udbUdMBKMP7WYfV
 EI3x9Dy1glu+Lch5ssLucWZBaaytrUTLe3bN62Eah20AaUh0RmH9dGQMNes6akmC1HPG
 ab67C0x0YRPuDYSSbi3S9BdbuBkWKxkKIUTzSSDsTdfOfY7DZOeE3CYZUplcNtzqCEsN
 L0lRwfv6OkiBTiRuNgWBzt9dk0Cl1AgDKjGBH17gdOvS2sYCpqtHWEc60Ts5oCfR4GTY
 SaeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793071112; x=1793675912;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Yx5bXM/cYo5UbS6BHzv1XuuXF1QAiMID1ROVIcNS/KU=;
 b=wARNtEzCitj6RVWvysVXgjkLEamnQz7R9YKw2JxUzBJsuRWl4/38uOSu5HiSkylZeX
 ml1zCdSmvxvCWigd44AQh0IZFcKV1G6FSjsTtR9I4ODcsI5kS+sybJkIrbCssVOnQneB
 UXVaKMb3v1qVjiNVuJRtBnrM0OSE9DAaNomSrL3b8S1NcjbwlfO7jYd8MgxTw5YJgneH
 uJozRbTWe5QsfpRr5F5ah7pNNLj7lBfEW4d+FK2amKb+5Y8GlqrO93bsMLTKxiN7YpUe
 FJY+mrRkxAf6MRPFC784xPIzdsjwoYJ0e6hUBfUJr9qt7hXN30fNUsiJ5b0rD47x0EBk
 3qpg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxePUDgFXDaUdZmPWdHjHQ1lM0Ihw3EYe0PuB+KDuuA+cETIVATdfTWIkhb1B97CJR2waszoh5ybZm8@nongnu.org
X-Gm-Message-State: AFq9FYKyZ7R8Gv5h+YXJuZBbk/MmGwzrBm7IEP2UpNX2bUM3dXE1zIh/
 lbB22AzuYL/1k0DILBGhiqmGrBYKqEcjGpe2TJXzq9ciKhZQ81gbo6EbICqq6gBnT3KSlqBJR2X
 R4KquKZl2vcyejDHZnDdiccEpuTlieea6HwSPBTe5qNAMR9zJfCPrlyBbOg==
X-Gm-Gg: AYBFou1iGAKXrKl+eY1sF7w9Tw5vI1vLbpRGiwDnf1CN0fne3PoUdqCpyvXZk1FtE1g
 v96lKTnpvJp06/tC1RuCnDxHwXeoK1NcvLCY37soRFnHs07PHG638QnYhFMXoni+kLHLGzn16W5
 pBwoO+JkuzB9D7wlUq8Zoup06FX5N1MnXux5ltZ7iE2WdzSJchrBvUfGWVkxjSFW1VdZLQtGyS5
 eDiCiPQt7cbeXdO092Q2KMh7iwiOF3+YnT0/o1fPgtHGx5vCanBArinr8ljjSjyN/0/C6pgG4AT
 lQA4K1TuVNc3//TfEq9Qo2voCKspb5q1rLOhT4SUw1NsYadOr7oKZ9zoPnB4oiOFwjNQgXx5i1q
 BSPE/hM0riIuF9HF/velBRJP53xtWD5LAWQ==
X-Received: by 2002:a05:620a:2629:b0:93f:dea:3b7e with SMTP id
 af79cd13be357-940ef8aed26mr1280285685a.24.1793071111817; 
 Mon, 26 Oct 2026 20:18:31 -0700 (PDT)
X-Received: by 2002:a05:620a:2629:b0:93f:dea:3b7e with SMTP id
 af79cd13be357-940ef8aed26mr1280284185a.24.1793071111379; 
 Mon, 26 Oct 2026 20:18:31 -0700 (PDT)
Received: from [192.168.69.230] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a35a30e11bsm279550675e9.1.2026.10.26.20.18.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Oct 2026 20:18:29 -0700 (PDT)
Message-ID: <931bee05-0c8e-4aca-b7cd-fe53fe5d1749@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 04:18:28 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/6] hw/i2c/aspeed: fix BUSY status reading in new
 register mode
Content-Language: en-US
To: Timur Maksimov <gessingate@gmail.com>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>, Peter Maydell <peter.maydell@linaro.org>,
 Jamin Lin <jamin_lin@aspeedtech.com>,
 Kane Chen <kane_chen@aspeedtech.com>, qemu-arm@nongnu.org,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>
References: <20261027-aspeed-i2c-nonpkt-fix-v1-0-076cdde514f8@gmail.com>
 <20261027-aspeed-i2c-nonpkt-fix-v1-5-076cdde514f8@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261027-aspeed-i2c-nonpkt-fix-v1-5-076cdde514f8@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI3MDAxMiBTYWx0ZWRfX2bLCEW1W+j4a
 r8XKpYntWk3cg1RxRI/aKILDHsm+HZzCEhbFNtNINyqswEVPWsIJuZTqByG+jeMZgHJmgumqFP3
 iRsAeKco/Vd/nz2Tavkx/c4Lc8gaY/6v68R1L+ZVDGFHE4MKuI26vR2kMkHyfZXURsngUwsONQQ
 0ju0vZym3P13uwrkkdBG0vIVmxdvkDIPohxfAEZfVqlWKM/AEjFB5a5vTw4jgVlsHMwZBMiTG7g
 jGrR5QXB7V6DYE5OzXOLIm5N9F/wmssEyJ5y45s7/DIsXVhseimXEiKD/o8VBih/0FelNN6vFx2
 b5nqm/Agu8wEPoQY1lenPt+2uSruavjpWEIedQ+Sw9aVs5zIO0ZM+5AbKoS5ScwxSAANe1yGWoT
 ZN196gU9A7y9NxTc8zhZuSJPPtPdK30y9M/4+Z9Ptb0Sin72p746ERjqSjcWd7ac9/KXAp2kz3t
 w18iNOC1HTbbRGU/xTg==
X-Proofpoint-GUID: Y38fi-DjW_10WVP3G_XfUNQyEnBNvcgp
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI3MDAxMiBTYWx0ZWRfX7cd+MEFd65Vo
 MDK207N3yWuN5b5Iabp+1TUPtI3/wa7G76cmPc4kwCbd7wJ8z1VyG/4p1C0hbhDKnNjUMNR+bnV
 7q0vfO8FG/8SNq4hDribEWyI768WxJ4=
X-Proofpoint-ORIG-GUID: Y38fi-DjW_10WVP3G_XfUNQyEnBNvcgp
X-Authority-Analysis: v=2.4 cv=TboDJhQh c=1 sm=1 tr=0 ts=6ae01808 cx=c_pps
 a=50t2pK5VMbmlHzFWWp8p/g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=9v4L6AuQKO0o8pUoPmMA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=IoWCM6iH3mJn3m4BftBB:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-27_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610270012
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Timur,

On 26/10/26 22:28, Timur Maksimov wrote:
> The BUSY status is moved to I2CC_MS_TXRX_BYTE_BUF register instead of I2CM_CMD in new register mode.

Slighly clearer:

   '''
   In new register mode, BUS_BUSY_STS is bit 16 of I2CC_MS_TXRX_BYTE_BUF;
   bit 16 of I2CM_CMD is PKT_OP_EN. Report the bus busy state in the
   correct register.
   '''

Fixes: ba2cccd64e90 ("aspeed: i2c: Add new mode support")

> Signed-off-by: Timur Maksimov gessingate@gmail.com

Email goes withing angle brackets (same applies to other patches):

Signed-off-by: Timur Maksimov <gessingate@gmail.com>

> ---
>   hw/i2c/aspeed_i2c.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/i2c/aspeed_i2c.c b/hw/i2c/aspeed_i2c.c
> index 376e113e58..a2b4c8b576 100644
> --- a/hw/i2c/aspeed_i2c.c
> +++ b/hw/i2c/aspeed_i2c.c
> @@ -147,7 +147,7 @@ static uint64_t aspeed_i2c_bus_new_read(AspeedI2CBus *bus, hwaddr offset,
>       case A_I2CC_POOL_CTRL:
>       case A_I2CM_INTR_CTRL:
>       case A_I2CM_INTR_STS:
> -    case A_I2CC_MS_TXRX_BYTE_BUF:
> +    case A_I2CM_CMD:
>       case A_I2CM_DMA_LEN:
>       case A_I2CM_DMA_TX_ADDR:
>       case A_I2CM_DMA_RX_ADDR:
> @@ -167,7 +167,7 @@ static uint64_t aspeed_i2c_bus_new_read(AspeedI2CBus *bus, hwaddr offset,
>       case A_I2CC_DMA_ADDR:
>           value = extract64(bus->dma_dram_offset, 0, 32);
>           break;
> -    case A_I2CM_CMD:
> +    case A_I2CC_MS_TXRX_BYTE_BUF:
>           value = bus->regs[offset / sizeof(*bus->regs)];

This patch should be re-ordered before the #2 one IIUC,
otherwise the fix is correct:
Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

>           value = SHARED_FIELD_DP32(value, BUS_BUSY_STS, i2c_bus_busy(bus->bus));
>           break;
> 

Thanks,

Phil.

