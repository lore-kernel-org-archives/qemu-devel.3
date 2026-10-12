Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28776CA9ED5
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 04:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xG7ws-00078v-Rz; Mon, 12 Oct 2026 00:47:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xG7wr-00078m-Iu
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 00:47:41 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xG7wp-0004RH-NM
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 00:47:40 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C1lGuO892995
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:47:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4a0eRgRWsn/RomkcNbrkGdhq81XveZxOqrrM7pggk5c=; b=Rd86tEZdYVb1qPHl
 +9hoskJyy+Q6mLyW59Tu/R3oL9gkxrQKQ4ZnO8QNiynQgFATz9h7jhThe26CkowQ
 SRGOYVC9sAnUiUJkWfElN4YW/9nMDSjrWBn19V1wxNjYhQ6knNlcHTpjg5Xy+i0R
 aceAaBTRFdjOpsAvNk8hChmBMtIQ+mK10ky4V0IJvVN41Tb+67NcVhRdORaUryG+
 soWDS0u717hRDRppIqEfnEjMatVaZ5vca8Thgozv5HiiIFYLpQuDuj5AIO8oynAL
 5+UM27cAYEfGzkmJ9nqU0bMIZa1AwAqezMMmYHkCTd2Ur+577BL7l43weSZNPNPu
 mhhMGw==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8j710wmq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 04:47:38 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93a1de6d5c3so382146585a.3
 for <qemu-devel@nongnu.org>; Sun, 11 Oct 2026 21:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791780458; x=1792385258; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4a0eRgRWsn/RomkcNbrkGdhq81XveZxOqrrM7pggk5c=;
 b=HvnlCwc5OuOeKzEkTuKYvifXTcLqk7gJexZI8ULjTkb5LhCzfaiFfVf8uvJQKoxdu1
 CeJaSE1TxWfsKkEAeY0GcCR9AwGAGWv2lKSx3EW1243HvXMzy6fvJ7vp9ZsLWB01pzWC
 Wpz0Q659t7zBIgt5gAHZcxknvRR7ZNw+E/nChLxHTSzWQJK7cr5//MyFxXl//bm4qCGp
 MOio55CAy01Uc/4R3fSIpxnGUNl3BErzfX9Ms/6FTrMCN2FYUDkHaH1A51z06Cu/R+QN
 mluzjO+yo1ZxIT8+7/9IWgX2Nj4nK94ObS3YVTG/1ZkrslaXmG4GXAoktYmla/IEnQDR
 zVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791780458; x=1792385258;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4a0eRgRWsn/RomkcNbrkGdhq81XveZxOqrrM7pggk5c=;
 b=FOrPxRewNgJcVKB0fTUR8rIN5raEJ4UUH9/kNjrAGl+OiifMb5mSgnB4Le1Q0koGEG
 VQ/kWXWI94FEZN1fsbhJPsWeUY5E3on5VNgQNvi0q2gB+zzc+tkqGEp26/tM5DP+tK6h
 tBdzOFMc29OfLIX3PglWe9N9K9tnbmJilZ2O0m+c7U+KGRLAxutwz2NXDORIrge3V9tj
 V6oQH/zeh5OGNZHavpzb2t2KnBbKmQkBZM6ed9HGAw9UvBDTAUH0r9jfsWp2YsvdtLnC
 dZ2/x2Km64qPjKQ2UcJNeFwtuqO46oSbjwTfRSaeINYSswuLNzU+Hnn6+m6bJ+lNbLSg
 EWCA==
X-Forwarded-Encrypted: i=1;
 AKwUvBxbG0Q719zF4oXPSM9jgJT4BUnKgL2tKYE9ykzv+lNpqRhXGegsaSzbew8qZJ+Z234Tl5mMnqhD8SXc@nongnu.org
X-Gm-Message-State: AFq9FYJsblV5JedfWvjns2k4I9yvTn8Nc/6VVl0uzYa2aTXHlelHs2DM
 KuA8iIYk/t+lgxY8iV3sc1+u6E2r2uWSc6WPBnYS38aCNOY8iH7Gy1Hp5twpchq9U4lW7jOKMGs
 byazE3TFAqs+xpjT6qLzLNo//9uhCCEfux9h7DopKeXxPW/lunCb4dIR2rQ==
X-Gm-Gg: AYBFou3ZkITuYJzZjdH96IgdF6Gr/0IKdbIdTkm9n1+983iVUCZOWhVo7erSJm7IMbv
 xU8wbJLsVl8OmwsqIpY/vgeV/T7WA1Jj+AtDx7cRXfwP8qjlQb6pZVdglvXVYXOc0kJqtERJgKF
 Cq5ZtMfa0LeleZCxc4S5bNQqgxqCn5hj24iUsbEZjBLcAfsfubo4KwV5fGJr75EJ29fsjvs13Kf
 dAx5e6kJbImpdYHf1/YfxTtkOs3vxP30JgI4ePxfb582FWSYMFEyu3BAdpbivK6JTox4PiGlepG
 hXDYBjqshx1vvDP4T8IJX1kvFbRdglLytEF3c6EfdVtEnQS+W2NrRfSW7yzlRjiRcrXNUDRSJU7
 OGFY6Mw4R2RRJUbZbri9er+CjO9prZw48B9PRj5dMdqw0fs9KCGXNFyIBB20X71Les9IfjRLkWs
 OvqxU=
X-Received: by 2002:a05:620a:7118:b0:93e:54d2:2285 with SMTP id
 af79cd13be357-93ebd249076mr1372486685a.33.1791780458004; 
 Sun, 11 Oct 2026 21:47:38 -0700 (PDT)
X-Received: by 2002:a05:620a:7118:b0:93e:54d2:2285 with SMTP id
 af79cd13be357-93ebd249076mr1372484285a.33.1791780457582; 
 Sun, 11 Oct 2026 21:47:37 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-93eb98cd599sm774683485a.39.2026.10.11.21.47.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 11 Oct 2026 21:47:35 -0700 (PDT)
Message-ID: <35ff35a1-42ba-4358-b6bf-7635503dfbcf@oss.qualcomm.com>
Date: Sun, 11 Oct 2026 23:47:32 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/11] hw/hexagon/virt: make machine available for hexagon
 target only
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
References: <20261009225226.10657-1-pierrick.bouvier@oss.qualcomm.com>
 <20261009225226.10657-4-pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <20261009225226.10657-4-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAxOCBTYWx0ZWRfX1Hm92d1S2HU7
 ZO0GihQGzsO3cLD9FDNnZbXe/l0zEaJXnRJttoYM3IyOpeF+hc2qgrsPVYQuuXYTFbsSbJp5EQA
 H8wEfQG4z3FeSeFiJBCCW2D69Rnby8A=
X-Proofpoint-GUID: kjNiRxD94dCNcsOR9PRxiiSUM2f3JQ_G
X-Proofpoint-ORIG-GUID: kjNiRxD94dCNcsOR9PRxiiSUM2f3JQ_G
X-Authority-Analysis: v=2.4 cv=ePGGH3p1 c=1 sm=1 tr=0 ts=6acc666a cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=EUspDBNiAAAA:8 a=zq3j2UT3UYmOdI0FYFAA:9 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAxOCBTYWx0ZWRfX+nmm0UyWk0Qd
 Nps6jFSUsayBt+M9qz1DNa1QShW0HpJF1qVJOvAFq1ZWhQ6wjG0fNS9PdUGreJ0TcE3fDtsCZE6
 9DySUOa6HBnyAX5knbpSkWnyaYpVhYGMRBxAY1hKxNruZdypHEv8ZY/iN3k6/s6x9tSbI9L02C0
 FdCq6FZY3Np6yKiu84OI2Y/tRwLJsLkz3zwRp1xoungv2TwCRaKwp1xJwo4WLriOc1Ua7Cv+1kg
 /4XRRaz/CMe1OCqKbgcc0a8hZQpJ4fdhcOVirJhvtGZZ0Pwk5+oxsprYqavEgC94mmvodcF3DAG
 Vb0XatTzw5ibfpv9CjpcW4hpLpohfzJHKFBzlORHw74v4195pMJJcIkrS6PLLa4cjPZyz8Wre4Y
 Whk4fd7YneMvD1hfnGTrIgjGGrWwNKK6a7+AQmaWA8RU9NkSZyG5inV1EEwETazG2YUJAx24tQn
 ZYFCODQOmHfhmKnAkVw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 impostorscore=0 malwarescore=0 adultscore=0
 bulkscore=0 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120018
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0b-0031df01.pphosted.com
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


On 10/9/2026 5:52 PM, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---

Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>

>   hw/hexagon/virt.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/hw/hexagon/virt.c b/hw/hexagon/virt.c
> index 64d8366d27d..b601cd77a92 100644
> --- a/hw/hexagon/virt.c
> +++ b/hw/hexagon/virt.c
> @@ -20,6 +20,7 @@
>   #include "hw/core/register.h"
>   #include "qemu/error-report.h"
>   #include "qemu/guest-random.h"
> +#include "qemu/target-info.h"
>   #include "qemu/units.h"
>   #include "machine_cfg_v68n_1024.h.inc"
>   #include "system/address-spaces.h"
> @@ -379,6 +380,7 @@ static const TypeInfo virt_machine_types[] = { {
>       .parent = TYPE_HEXAGON_COMMON_MACHINE,
>       .instance_size = sizeof(HexagonVirtMachineState),
>       .class_init = virt_class_init,
> +    .is_available = target_hexagon,
>   } };
>   
>   DEFINE_TYPES(virt_machine_types)

