Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52161C44524
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 06:04:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmmWx-0005EH-6G; Thu, 23 Jul 2026 02:03:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmmWv-0005B9-7e
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 02:03:37 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wmmWt-0005f3-KG
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 02:03:37 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66N4vQAR4120632
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 06:03:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 7keMzPCxl7utQPpc2pLfDXAilcSK1raT403Yfw93ii0=; b=d7Poq4HJKISYMxdm
 5O/32Axjor1ficHyMI+yI8W2w3EULCSGmfRv/ipdHIh0w9HNKisQmVDCinRLMe2/
 8iVgvRt0fsSwkqcB/S2S0iZl8PRTyEram58aUBg+KiQy+XxMhzv6TodFbEAIK0sw
 pD9wmFl4ZjV1P7zRonlr+9xnzhmXJt39Xeloj2u0Vu79NOMYG6h9/40+oAHYHoWy
 JwTwsbMnG4Xo+wchEx0vR5IZQdWIki1xVUdfmnL1chbByBc6FBxZqxuGNla1ETvZ
 8dDNjqoTGFw+5P4lyy6inpc94yypmQ832A6sjGgCeTH9rt1j9W6C10Fkcelqh+mE
 oi3dLg==
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fk28xth46-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 06:03:34 +0000 (GMT)
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-51a8db414c7so5884161cf.0
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 23:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784786613; x=1785391413; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7keMzPCxl7utQPpc2pLfDXAilcSK1raT403Yfw93ii0=;
 b=kDtOLLOhUGAAcf8eQGe98a8pvZS7rc2A05MidMEY2aIF6niWqIq4vt/v1CPShdHA+A
 6+20a3fU97wfaEnKX+Imv0eRj5HSVsHtbFoR13S8grzL/eyqdo/05M/3x9TJVOGgXkkR
 6iPP2lgv6vrOZKbXT01YH4uVdQgUrFgtbvjRfDXI723Vq1BmyIGPUtm1zUHI38fezEz9
 bBI8FjNkNEaK8PSo8QiYK3eJJarKd5lMp4qawe9GM7AbPXMtB3C0RKSopnUYSFM3O/fE
 E090jRdD4mGon6rziGkFofHJWVLziKVrRAXGj5/7hcwxhBp9ZU6koSHd2HUPvw8lh181
 Albg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784786613; x=1785391413;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=7keMzPCxl7utQPpc2pLfDXAilcSK1raT403Yfw93ii0=;
 b=DAxMuEddciI0D4bwP6S7fg1ExiHE8ytEX9Df1RScLavmt4KPZ+v+TJNFG8ZhHf4113
 28wDeufmftMWl/VJixFjiLL/gHHpvBqpFDw3BLyNff8SA+Pparu3yh0Klkdhn2hNgeZB
 d5Xp7Z8E5GhDZz+mbheTVuuKU0Tyk0b0H5GrnZFHD4XUFrK1lALfAZNd/ewcb2jaXNrU
 vUffo/At7xTcl3Xe5BchuOlqYBrXy5h9/itNb8oIJh6vkEWfbe3W40S/qgnl46PN2Ach
 MLirIxvumat/kFiU6zsovAsrxu7HF/s7ndPMC3WDJgRRDF9GgDVQSqx3Hx5XXkyY5Dqu
 8lLw==
X-Gm-Message-State: AOJu0YxOsS5E6Yg09McpK7vFdf4+D/IDjzwj7o6E4RPMjNuTCV1ymZ6I
 HNZqj/qK3lubBCHTMhQHfNDy9bqIOYkCG0n6p/SnU3LEC4THZNZGxRJEarSro1s+EnvgN5n17NM
 +Jlr95Px93MiLNMd5z/Mr58108Bm4S8C8kdI7on3JNTUDEUv6myL1u7tKHvmzz9d0Ng==
X-Gm-Gg: AR+sD10LJKRuGmYb17msS+8XIP8u7IM/bIudw4E2LfS+o4v5gDTks19X+9/zRQ+2lqC
 N6pJLhcYzwuXFwbE8tbAUjREJFk9jXbg//4k2s/SrP2sav6B3pgGZeUsmkUTIwTBCNSkzuo2FgO
 +JOiyy3zyUXcWydzYZh8MkzE4GXbQcZNYlAdIM7x7QwlKGxuL8A8T7jfheMJ2/e7HaY9/zvkWy+
 ArsCgzXMeCNWzsKQYPvR7wPSSiJWfDrxfM06xPLLtR0WgOyoTw/d6m4wpoTBMhwIeBI4Hw5qEwN
 /9AREdjRpnz0pFX6nDHAEc6mTggrdVUePpkjp8qwXYXR5doSmOB+XGBW3auB25V1LYM51Tm2z7O
 AaDW95W+nDakeHC6S9HBPY40HQUbmg9q4Olc1haDvigDSGywFv1w=
X-Received: by 2002:a05:622a:1c0d:b0:51c:7b11:419e with SMTP id
 d75a77b69052e-5283df78e1amr15704071cf.75.1784786613003; 
 Wed, 22 Jul 2026 23:03:33 -0700 (PDT)
X-Received: by 2002:a05:622a:1c0d:b0:51c:7b11:419e with SMTP id
 d75a77b69052e-5283df78e1amr15703811cf.75.1784786612505; 
 Wed, 22 Jul 2026 23:03:32 -0700 (PDT)
Received: from [192.168.69.212] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4956a4f25b6sm114370025e9.2.2026.07.22.23.03.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 23:03:31 -0700 (PDT)
Message-ID: <3e349615-c5fe-4571-bfc0-683b37126888@oss.qualcomm.com>
Date: Thu, 23 Jul 2026 08:03:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] hw/cxl: fix timer leak in cxl_destroy_cci()
Content-Language: en-US
To: Junjie Cao <junjie.cao@intel.com>, Jonathan Cameron <jic23@kernel.org>
Cc: qemu-devel@nongnu.org, linux-cxl@vger.kernel.org, qemu-stable@nongnu.org
References: <20260723011625.1117034-1-junjie.cao@intel.com>
 <20260723011625.1117034-2-junjie.cao@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260723011625.1117034-2-junjie.cao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: MQuLgdPPi-2iLW8bvNVuNGEaulKakEjZ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIzMDA1OSBTYWx0ZWRfX8UqkOuI0paml
 XCySsHQdUmEG7uooKjdwjAIqU65+4Ysjz8NSFmdCUskybJ5AvEGYliZ0mYFauisl7wjdVqDfHRq
 U63tFNVWT8xPUqH7DKKpTq/NpQOWs8k=
X-Proofpoint-GUID: MQuLgdPPi-2iLW8bvNVuNGEaulKakEjZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIzMDA1OSBTYWx0ZWRfX5eaHKqJH0Weg
 kAiE29q5RSpMP24uZuUl83kCgHgpHZz+ypJu/aUxOgnmYusIMJfKsen3uv86fvpSbBSPEUi7Mer
 q1bHuxEK9f61ZQmZ02sp/b9pg3DKuBijA4Q2KakaIBduTHLmCeEdYweG7a2HQvaJvFNiATQ/0OA
 pikVJ2JK9fRLO+tFm6RcBKNBtft5qL1+4IRDR1j6o9/EpEtJzB7rYIkwqU/aOflSoNUzCAYQ140
 H65uXEfWdZuoeBXX89GYaF9oqb5owFUHuliyiQz9Hm//irpOEm0rZUQyiBNE7fpyVOQ8vTjCXT3
 WG7hnSuZHlak6nzr5tE4oabUE8DoExhpa13ny9PrVCERJTHvq+PBvIjqAUpE/pW5VC0SRE2Z4nO
 KGesY9yTAmcU88fJ5JLOyShwO7Xjjjz7i4jh4YrL5hNfmjCsyedq9PCQC1ERRxdIseSE5HlHWu1
 RBkB5RjhVRbgqGtTYOA==
X-Authority-Analysis: v=2.4 cv=WNxPmHsR c=1 sm=1 tr=0 ts=6a61aeb6 cx=c_pps
 a=JbAStetqSzwMeJznSMzCyw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=69wJf7TsAAAA:8 a=QyXUC8HyAAAA:8 a=EUspDBNiAAAA:8 a=nd1R-Y27xLvYdgTe2jcA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=uxP6HrT_eTzRwkO_Te1X:22
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-23_02,2026-07-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 priorityscore=1501 malwarescore=0 phishscore=0
 impostorscore=0 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607230059
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

On 23/7/26 03:16, Junjie Cao wrote:
> cxl_init_cci() allocates a QEMUTimer via timer_new_ms() but
> cxl_destroy_cci() never frees it.  This leaks a timer object on every
> device exit path and, more critically, on every device reset cycle since
> the secondary CCIs (vdm_fm_owned_ld_mctp_cci, ld0_cci) are destroyed
> and re-initialized each time ct3d_reset() runs.
> 
> Tear the CCI down in the reverse of cxl_init_cci()'s setup order:
> destroy the mutex, then free the timer.  timer_free() cancels any
> pending expiry via timer_del() internally and tolerates a NULL pointer;
> clear the field afterwards so that a repeated timer_free() on the same
> CCI is a safe no-op.
> (The function as a whole is still not idempotent: qemu_mutex_destroy()
> asserts on an already-destroyed mutex.  Callers must not invoke
> cxl_destroy_cci() twice; the .initialized guard added in the next patch
> enforces that.)
> 
> Fixes: 98cbac128f1c ("hw/cxl: Support aborting background commands")
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> ---
>   hw/cxl/cxl-mailbox-utils.c | 2 ++
>   1 file changed, 2 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

