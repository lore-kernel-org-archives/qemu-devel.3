Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7B4FC9832F
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 09:36:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xB7mH-0008Qj-DV; Mon, 28 Sep 2026 05:36:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB7m7-0008PQ-7z
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:35:55 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xB7m5-0006fY-Js
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 05:35:54 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68S9M8tY2057259
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 Q9mTr8BLc2fogx+WMrCHjS4cxhNXtGHzdEwK/fOBuz8=; b=VBFNRQOdzZUYgIlt
 gi0367RbOcn3S8RAdQYGFaXoTuFV31hY3lNBGAjSZjBXTOuncCsVaHUV/EcF6Ewg
 QbiMdaLZN1RoV3zgT0Bxf6u3JKW6nsYfbPUBinU2Nqpnn+uWP3WXJuorl4ZXk+Md
 ORbRDznOHh8gOExh9pONtWFdh2nbJqJV/UpbtVqx8bCpGe/qVsiyCCCqP1e0t6n2
 VrA960cL4lPHRwzoB2HBwYQuiI0Xh4JiUVYkrbCyzpIcbERC/g3tiLkiNcrDS4mL
 XhOFiy5UteoNgv7uDNP7xI9bOnsmrTxmErVugxocDbRCaGECZBaxaCflIG/1bTYI
 LLoWRQ==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyhubgwrv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:35:51 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93a183a0e93so623945385a.1
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 02:35:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790588151; x=1791192951; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Q9mTr8BLc2fogx+WMrCHjS4cxhNXtGHzdEwK/fOBuz8=;
 b=KkAN3VbmJecwMeoscd29Kpcr4ABBY5ITdigcgwTiMPhjsI8SUv3kbYDKjGCi5VChJA
 ZRydFgneObRjDCP6JWg8mB0g/l1Vk3Byjl2kSm6jT7WFhqqr0TwQUVOqH4IvwjXE3c4z
 a5sJTd691wXQXW7CcdhwYVTFF3kjvzBDbq7v555q9GYUEcn7UmCWNjWlZ4oOzsSOFc4W
 VozNtNIOLtxqmp5EYKo3eELqvtQWRPNN94q4ypE2QTgdbXPTyP4wqqJjYeelgf7qANzd
 EupUsJm6GlZ+UKKbeHoYa96hPqAEBEPz8e9kyWoyn6yfGK6FH27rddec6UK0Nze3GxzD
 G4fA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790588151; x=1791192951;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Q9mTr8BLc2fogx+WMrCHjS4cxhNXtGHzdEwK/fOBuz8=;
 b=TFhwAk9//Tf+GpSAPPnzSmHaq8YbbVeZ+Mqjyl2g20y7Cqbj7c7844+k4HzVET9nqr
 pr3qPXzsKDctCeqoaTSC6wtYguXIyBqtkndTEJwAumTV5qk7KGYwF/MAvywCVCO8t01F
 ZIHjNo7vH1SuliuF3pqZOZcp5l2ceTsK8wQRUi+4VY3Ni9ZWPvE/2kiPb6zVYsKGt7VY
 4bsZSpBPK/cpGJNfFTJc9VIHR1rHiwrdwLXSTNXQNGks58r17ih3qlEUbcdA+Do99kbI
 EVlQv03wmmTvIJQA0k+EN/S8vDzhR5wxbKijZWMbQFUGjhGjp8V+PZRW/LMlXaDzVSqS
 Hjmw==
X-Forwarded-Encrypted: i=1;
 AKwUvBz3R21fX4HgHnuSHrdTi8PwdVpwtyAGfv++/XsGCUmppAYdQ3uON/M8WNmaoxefMqt2ZzK7F6rvcLXD@nongnu.org
X-Gm-Message-State: AFuF++mTyYVpFHaMi4Kps1aLejVVIA2KpeoCsHZAkR9r1g3SmD3vhXNm
 YJLwYgnNYhymEE2l18YkcPyCa2C4KuyPs3i97fO/7wbc7n8TtUCrqVCmmUkOGMj/Iy2pQfwscV2
 coHu0sBEXRbk57jGChXndL2kzUL1myArAzL69fmnqbCnF0kXgrdPapFih7w==
X-Gm-Gg: AYBFou3B5pO423U0BSBKhQbsaamxQMhLPpmkHo8FbnGhtpmXE+QWcWxr9+L3czPi+bI
 VNDoGXeI/ru4Dv4lCWz311Co+4mgaq/b2bUFPoMeY4D+5t15W5l5EqCMh0X0GjabCz8+l7zC66w
 swu0H0oCAo2WK/6kL1qUF94sNtD+ullDH6LFCbp2rQrbtTMviwVesFfuc48tJuNkOlltUzkIYc2
 Ktjj//9J4Qx4KXGrOcqSY17/z9wEiiiIdQLlL4z+9dBLRFx0c2SYHGkDKhzs9cq0GCLqtaZORP4
 IPnUnq2PvxTijsJfLQEXaqVuXHoAAqAObl/QAOEomD09VGDzBcZ0j6ZIPztmDiqrOm3Y4NgQfQa
 MeIYEzhLCYcdDk7MIuh76iV1rsV3WslxQKw==
X-Received: by 2002:a05:620a:6e46:10b0:93c:82bc:146c with SMTP id
 af79cd13be357-93c82bc186fmr108309485a.37.1790588150775; 
 Mon, 28 Sep 2026 02:35:50 -0700 (PDT)
X-Received: by 2002:a05:620a:6e46:10b0:93c:82bc:146c with SMTP id
 af79cd13be357-93c82bc186fmr108306985a.37.1790588150317; 
 Mon, 28 Sep 2026 02:35:50 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0017656cesm121285875e9.3.2026.09.28.02.35.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 02:35:49 -0700 (PDT)
Message-ID: <5582a997-b180-4659-8130-d172598666eb@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 11:35:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 13/14] target/arm: Honor PSTATE.UINJ during translation
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20260925215004.456336-1-richard.henderson@linaro.org>
 <20260925215004.456336-14-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260925215004.456336-14-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: Kh0Klau9oClHexcmnNk6udJN0TT4qrkA
X-Authority-Analysis: v=2.4 cv=C7F8WgP+ c=1 sm=1 tr=0 ts=6aba34f7 cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PEH46H7Ffwr30OY-TuGO:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: Kh0Klau9oClHexcmnNk6udJN0TT4qrkA
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDAzOCBTYWx0ZWRfXycNRSW62eV8p
 RySpVEON3GNbG/QjXE6kAztktYZHf6V4ptbTQFVODgynFCKfeEDT/0KNtb0JkrLbf5pFlC/jVRa
 Ln+vnQian4Ma/Ym7rIzdkIa4AFRZC54boH6/m478okfEUpAZWg/icM8wbdZnmq7KrYjzJ99rIuK
 ZnvIVtrD6IkjJc9xqScfjShLkwzQBAa8GAeQ4UoFM96wPd0YqoiIurDdyKStGqbgHwBjwxp8UJC
 YfGfj3G9JtV007hvpHL4uu+KSmBVZ9K6yeqU3vNAA1/OyrmpMC1qmDfH8FKbG1TUyXdEp0cEGMb
 hMqC/dPxvQa9d/O7wXH7s/pNhWqlQIc1ixIh5bbvqQuTw6C6TvUPfYVQo9IEWSwZOm3GJwFwr1R
 /fnlInvvaY1ATfHHYFI5TuEJ8vmHPbEzVjqYtSSiMwZcvRwOvgr+dJYxqOFNbm3Qcq/HHfDzq2F
 ztn5P9IgMF4hJCSb3Ig==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDAzOCBTYWx0ZWRfXw0M11QuDpz18
 478gDDF1rxXC3U9VgYZXKpOarr09dAc/4CfxGwpDtPamtj3+8+fWziVqSetY7e7Kp6dppGsW1tO
 y80hrsCVvVFtXn+IBX1CP9gpQ7lU9as=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_02,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 malwarescore=0 lowpriorityscore=0 clxscore=1015 phishscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280038
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

On 25/9/26 23:50, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/tcg/translate.h     |  2 +-
>   target/arm/tcg/translate-a64.c |  2 +-
>   target/arm/tcg/translate.c     | 10 +++++++---
>   3 files changed, 9 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

