Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2637CA9ED2
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Oct 2026 09:45:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xGCaM-0005NX-UP; Mon, 12 Oct 2026 05:44:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGCaI-0005Ml-OS
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 05:44:43 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xGCaH-0007iP-6W
 for qemu-devel@nongnu.org; Mon, 12 Oct 2026 05:44:42 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69C8KC9H2796187
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 09:44:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tIetr4LTlyVK2S6o2njUpNkv76LQtGil+3sDiSU8Bqo=; b=olsU7I7Wag/2EvSv
 S7p5LGRvojkgP69GeE9kRLCWetmokG7mByMJOwg2oJ/PEGl4khIpK3GQXpr/poHI
 uhlTDdNV04KreKzBGyWMQH7qCfGF+mz51szY4zPIOE3tf51OWf+sCkMw4/nryAHQ
 EgXhCZbi0j/tQGLFceAknO/ihprZ7LmFjFOiwNfWWgmJMZ/Kdhd7LBLySTmtCj0Y
 h/BQuR0Ry/qYs5zHxuEN99PrV7D0nKiqKLQMAdIyOFVcIsNF7JzDi2TrZ8tRl1Mv
 pNWs0AshJHAHmG+Ckt7Q3TitdkcCETjJmQDSC0ilgThp7+hBMqxwxz3PY34cNUYm
 xvd7UA==
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h8uh3gg1q-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 09:44:36 +0000 (GMT)
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-93caf6c528aso306240385a.0
 for <qemu-devel@nongnu.org>; Mon, 12 Oct 2026 02:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791798275; x=1792403075; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=tIetr4LTlyVK2S6o2njUpNkv76LQtGil+3sDiSU8Bqo=;
 b=FVq0cFA+R30R4Pb4jsc/HBqEGYV2ZarVvYK7g66kbFdcKCnwUUP6aeqHvor0y037CN
 CVjFM86EgD5wm/ZWNk7s1OcRnVEoX+ryTAIm/MgyOBf31g0Lug8QeMH4pfN8hAtUwYH0
 7U7wlo8pINWqgy2mQ93SQ4lZhhpRzjVob6HDmZPVKN3MuNK/anFZFlqerWjlnoyIlKqN
 hSEgu0/4tbiNbHtdO00TRxU4rLRSO8kQA0dHVDM/i4vMgrffSht7rBplJXpEaiuO8Eka
 vEWLSK7J/jro1RmVNzBsS1SDC2hGqwFhnEUYoNGhhfG6V+WDMIS4IYEd2ZoouFlyx/gS
 XyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791798275; x=1792403075;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=tIetr4LTlyVK2S6o2njUpNkv76LQtGil+3sDiSU8Bqo=;
 b=ndmVy1pH146NUjaeT1fuQi4t6aRMm8HVW11b+IB8iLaIlwD4TaqM++1aJbTZ/iXUQV
 +voLaomMcLukTKWdlGTrEQsdpRiKWsQEH+AmwpsbHI9ZBIjwnE35mBqidL0xlTihLDe9
 uRVRMGDaQVZ0WPtly7Pa5E3TjkakRRYAtQdLg5xRfDzYiTy+JyVphPe8x3I/xn8xkywr
 VjWsC9I//N5lrcBqAB2iJ1BVqsAUL+xzM0M69ABOQEU0IgzagaopTc4jPKDg2XeK3Uv7
 RiTtRR+xiCFT5j+GF/O3lzsXsUvyqB/3MCtUzNi3bMb1xD/7qMBK1eifMKXinAWOt/tu
 xlYg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzC0LhoL7QI75doUdqSP7MJeCiLpv3UuLuywXwmL8eaOCTJBwuXRiLX4nqr8m6jgIjl8yJi28C6hnJ1@nongnu.org
X-Gm-Message-State: AFq9FYLzEA/XGEnOz6HcavBP1gwBrq+kj+YDZb6jDBP1h6qhqKStf1Vb
 WYMqAIXh0EU1GWhVc9c0xxyOhRQT5qZNEq+GZPGjjymqZtjfkmw/UGSqhvNwhECAI1Md2t1ovAL
 YJynkgmoBmsmGWs9x72Kq42MAOMrHvxeMMg+oO+8Bt1/XvTI+omYMy+r6kw==
X-Gm-Gg: AYBFou3uuvUcnS8YWhNuzfCt0vV0T6D1ngYjWJJr/30vYJpyO5SX1HoUrAwXgI++0QJ
 fGOmbE/KkvS7URDyB0hExhDkFVef8zT9HTY50smNmQHwPHHnyTrYYtWUZgfk/tXJZ7zoeHR997h
 8FLxyjop5KeBYtjP6Vjvp3X2a8m37dUPaACuOHArP3l/n4ju7UxNq2JuYEJg4OmclTSkv4inUNu
 hy3klJV/U+ede6//Yu/pcomrIdpNJBXvXxzv+kiVAdCotPPbHlzxPpN35N9dAkRM54g4EBG2cQe
 sE9wNXbg8behlfjy/6zqWDJ8ImpALxJNng6RJdYGqhYRvGT0mbQ7lABLGbrEIFcAiEsfvuQNRvt
 DAfCBHTwz72hmSnOdnIOFZNgIZhsUscVHbw==
X-Received: by 2002:a05:620a:198d:b0:936:df48:d507 with SMTP id
 af79cd13be357-93ebd1e0110mr1433540185a.18.1791798275125; 
 Mon, 12 Oct 2026 02:44:35 -0700 (PDT)
X-Received: by 2002:a05:620a:198d:b0:936:df48:d507 with SMTP id
 af79cd13be357-93ebd1e0110mr1433537485a.18.1791798274649; 
 Mon, 12 Oct 2026 02:44:34 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48db9abda3csm19702764f8f.36.2026.10.12.02.44.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Oct 2026 02:44:25 -0700 (PDT)
Message-ID: <21d3e269-4f47-46b3-b779-03a34c6323c0@oss.qualcomm.com>
Date: Mon, 12 Oct 2026 11:44:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/11] target-info: add target_hexagon
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
References: <20261009225226.10657-1-pierrick.bouvier@oss.qualcomm.com>
 <20261009225226.10657-3-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261009225226.10657-3-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEyMDAzOCBTYWx0ZWRfX3okFcDzEtaiN
 abRlYJM+nR4cfI5sbigpqKhRxzCBSoNIx2x9FTmW+4nOlX3D5f9yh6xdNNZz6ORtkZ4g/DRAnZb
 mk6FnCRLIzo7oKcNDKifCIKpRnN1ZRm5NLIjgHqlAcEEXz4f9qQ+/m5STBMK+9cbcLdyymx88TJ
 tKnmqZHQQHcG7fjfQ3eSfRzyjYjw/JryLrfdkLqg3i2ggy9iHJK/uyRCIgkq2zLq5Ja0Nws3TK0
 2h4qSBmzeNrJWtldAs6CC1+UQiUaa7FucCdaHR/PhDTGJUqHQ74yBI1KBjHWmvrewP1DzqKWW5V
 UdA3LT3smunLGjnqSDLUli6NPvZ4GnlRb6GltgdC+CFS8WDvJdCAi6DitAiy4uKQYUPWE/nhRIi
 JN0WZGe/njdMjjtts1B+VRl4qd1o5B/hF2fEf0osIJb/MPo2WZ1YdmcfzdUlL9z6lNecECEfYjm
 J2qALmbo6qzVbb0bctw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEyMDAzOCBTYWx0ZWRfX0ZqgICxF1ILj
 LYQwhA9CZRVXfYM9XiL1AUGg23uq2bzVROtXkEZj/8VVa33g8p+5snhVQntx1l89EaCQ4hb3wEj
 jEpzQhSdIXwY6/VpQbL0oV9Db8I3Ykk=
X-Authority-Analysis: v=2.4 cv=QO391QLL c=1 sm=1 tr=0 ts=6accac04 cx=c_pps
 a=qKBjSQ1v91RyAK45QCPf5w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=NFOGd7dJGGMPyQGDc5-O:22
X-Proofpoint-ORIG-GUID: qzmKJF5ysFfeyBn7AQ4y7MReTyFn7y7O
X-Proofpoint-GUID: qzmKJF5ysFfeyBn7AQ4y7MReTyFn7y7O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-12_03,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 bulkscore=0 spamscore=0 malwarescore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610120038
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

On 10/10/26 00:52, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   include/qemu/target-info.h | 7 +++++++
>   target-info.c              | 5 +++++
>   2 files changed, 12 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

