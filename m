Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B704EC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 12:13:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjFWl-0001jZ-9x; Mon, 13 Jul 2026 08:12:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjFWj-0001jB-SP
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 08:12:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wjFWg-0006oA-45
 for qemu-devel@nongnu.org; Mon, 13 Jul 2026 08:12:47 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DAZSIR668623
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 12:12:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 0XLo5c5bXPi1kcGUU3o6fmF+i8P5fiilgFAhUvqzwdM=; b=feZSAqAQWIZ9Wdm7
 rro3V7gbjFW8KWr3iP39vO/V4938QIqtbAxBQPqdb2jGBjH2onkQyFyrH86tFVpX
 1z8LI3N3gzVlobIqShdvQZWIPq3Vc85bIK+NSemgCb7vYpJuBc8XflJUoQsA4fSf
 N2a/uXvT0r++z4szGeIGbr9qvPqlrRYBy1ffc4QqpRFG2vFWYZ811B0QUJ/yO7FI
 vrUvLEE83NTeoFzccmMbh0F4U/JvEBCAsPEWawVKtbCiPZqPNKybQHuAq34NiJDl
 J/gJfNeugV32s+Ufn5sOrVDs7fx6TQYueOV6JhFlXs8b8AONfOHnLYfwxA1DSlJg
 hoT7/g==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fcjnm2esw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 12:12:44 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-51a8c689b5fso45350421cf.0
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2026 05:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783944763; x=1784549563; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0XLo5c5bXPi1kcGUU3o6fmF+i8P5fiilgFAhUvqzwdM=;
 b=e4a/hsDN75qx8WiQQ2yYIZhxTtV5nBVRLi4qlruJL1dAfEVTLpTBsmjBzhWv4yBali
 U8ysHqr9qNegdtJU1i41WEr1k9a+pvuCrPsjRNBhfRulHizZraksgYr2h4JSBMZhxlf/
 IUOshmQbFP4Hp2TDuBOapWG5EgouCmttyyDN+qJDWJiB6rfLGQYL0aKvnvcsgh5iRxQR
 fsNLx2M2J0LJFj3PF1eO2hAcBH1QyhX6G8/g1SQq5hYoq2r0XsdtqxQdea63V5Vytv9d
 NCpMQIWNELZyob6+ORdhLIeEPk7NrS/P1ZwuYqLTfxAF4VA8ZuteayNabzjV68aXh6XZ
 JGLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783944763; x=1784549563;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0XLo5c5bXPi1kcGUU3o6fmF+i8P5fiilgFAhUvqzwdM=;
 b=PBgbNjJnqXL7oY+tq+co8sqPzw2cYWop/nhqxpI76OLLOYisnaXNO8cYdEM1idi5Jf
 H12QRa1zK4fhStLogeaS4vzIhKWOxigTVwwMOXnt0Ba60e81T2ehrnqZEwHXZy5H3UT8
 Hx6rj2KK7wXndjAyn4+/nyhx8/cXu6SbpIl6PsvglW0Kx6j5dTw45R7iLV19wpxNqWNB
 CU0oCbgWOEvuphkfx2hGTy4dz7U+IfhIPG6m1FQYN4q8IOCq6NLjlFOWkAfEAlxWy5Z9
 HAOtuguOX33b8rYOux/pdz+0KcGl9hh6xkVcGGnpdaZHIIDmYzncANcixnaG0VJVlQhV
 jvbA==
X-Forwarded-Encrypted: i=1;
 AHgh+Rono+oVWNa7UQFTZGsyjLs+BaBVCTGb2mOwqTnJR1y3tGc/bPqa4WQ26qNzTmrlLuFnHP9Iq60cENyv@nongnu.org
X-Gm-Message-State: AOJu0Yxa7soGYIh0QxmyZ5RRncWfhPhWYNzqqX84RY/AQQ/Iomhm/6J9
 4c8hnKfg/MJ+xL8pXS++fwVW3GAblUiuWBgZspxdGrUEoHaUHVaboH+np7FVnr8D8pkh8BMWK81
 zCngRkAIyoTcDBwYRw043jEd5dYRuiBquDvSzrcTM24nljd+kxLnlGukK7Q==
X-Gm-Gg: AfdE7cmV0rEzv9Kx/L2+rr6YRVel69vhi//qCs5TEa2KryBopuF0I4lY4NKVdCTLyLL
 Z6ah3YzCmd1PNSYDldNcj3Ys/s08IQ8rGgKTYk/xKAf9wqF39gVsWj96jDznRTN6x1OvQEEFu0R
 3/AmU412l/kKHu1XZwDM0oh8h7DuzUJvbln7gWH5ib2Th3bpTE5Uef5ZOyq3vc/pP1cTnU8RqYs
 WXKVqaH6CUBmbyAUkBXRci1aU2TMwzZfERgrB8gbp/vw6QPaNmUxgv0McR0zZKJ7mYxuk4gWFu1
 UfTbY+uXTbGNRKyCIBt5BIuMTZ0CFL+u/Qbsw47H/DiXWILVUm+cnY3BbjuCetdaqM/LKnS5ffu
 5HwiPAiW/RFARn/ohSLf2S+TspaN1E/5ocFpujMcXT+rulQTZqktbeJ8pUhwQ8Q==
X-Received: by 2002:a05:622a:1f8b:b0:51c:7b11:41b4 with SMTP id
 d75a77b69052e-51cbf2eeb27mr84549651cf.80.1783944763180; 
 Mon, 13 Jul 2026 05:12:43 -0700 (PDT)
X-Received: by 2002:a05:622a:1f8b:b0:51c:7b11:41b4 with SMTP id
 d75a77b69052e-51cbf2eeb27mr84549281cf.80.1783944762792; 
 Mon, 13 Jul 2026 05:12:42 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f2a2e499sm289167485e9.0.2026.07.13.05.12.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2026 05:12:42 -0700 (PDT)
Message-ID: <af1ef226-7cd4-474e-80fd-6500c2f365b2@oss.qualcomm.com>
Date: Mon, 13 Jul 2026 14:12:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 9/9] MAINTAINERS: Add soc_dma to OMAP section
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Jim MacArthur <jim.macarthur@linaro.org>
References: <20260710105907.2570621-1-peter.maydell@linaro.org>
 <20260710105907.2570621-10-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260710105907.2570621-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: _O-lq86QzF5r05FhXGxg5c5Yk1hEcT6Y
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyNyBTYWx0ZWRfX2u+WdBRs3Dau
 vnOrEKFjJkxMZcF+zu6xYmj4kTD2ylJ+DNVDxfv0IrVY6wRKrMYfLOxpD3IL3tKbmHHA+4jdFlU
 P00eRsJtrgla24jhdWKygf3ha5y/yN9T3Ej8J+I2KoIZqhLWscn6b59zV7XhgQAGIZo3SkajSR6
 uitd3KHe7rG9Dm1aqkurbs7PFbGr8cKr5yKGfpH7Ru/KLJ/nyhraZXf4+2HD/9pYipX4opdx0Sf
 g4CXgQ6cQDutwmDVoOWXCJODEuf1JyF0LZRHdO5M0u2hDXjHAyo8Sy8iAeJOtNy++mv1303Uqo5
 bQo6LyFPkCjDT9DiWZWDfGUjQP2dfjvzDgwwmoxflMREASMLTvmhE4LbyhwgDC2PtUzxF3J93m6
 O7oFCrwEjFl7sgpa2fIyFGWsgA1teAaUjZSSlX474kqb8Mrij6n3Pnnu9V9hMzwU5h3686S36db
 Jqkw4Cq0xYz2NgOdtww==
X-Proofpoint-GUID: _O-lq86QzF5r05FhXGxg5c5Yk1hEcT6Y
X-Authority-Analysis: v=2.4 cv=AfmB2XXG c=1 sm=1 tr=0 ts=6a54d63c cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=ZXulRonScM0A:10 a=dawVfQjAaf238kedN5IG:22
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyNyBTYWx0ZWRfX8/5iNbVP1RRV
 WlOv6mjRTVnOJhShtKjfrFQDinxB8LcsEFBbxB3Jx34Q3/IMpoGo+pda6zlJoKZwMg4StBfYXvV
 Sla/5XkWZCCodU4h58p6J+/Z7lE+j6g=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 lowpriorityscore=0 phishscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607130127
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

On 10/7/26 12:59, Peter Maydell wrote:
> The hw/dma/soc_dma.c code appears to have been written with the idea
> that it abstracts out DMA transfer operations from the details of a
> particular DMA controller device.  In practice, it's used only by the
> omap_dma code and I would not today recommend trying to use it in any
> new DMA device.  Add the files to the OMAP section of MAINTAINERS so
> that patches can be cc'd to the appropriate places.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

