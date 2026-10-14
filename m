Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1E6FCC6B2E
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:40:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH4pO-0005OP-96; Wed, 14 Oct 2026 15:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xH4pN-0005OG-Gw
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:39:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xH4pL-0001Do-Tx
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:39:53 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEb7gS1013305
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:39:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1I6ETAayPYc5O5Yhce4Zog/WU9cunarlvR0L9Piv9rA=; b=AjmGtCg+eeOQI9o4
 hMbG+O/MEiW9cBqt8/wJxq2XNEAk4DUlVVOZCfJHWhsmKR9u7kChXH4UJeNioEqD
 J0xQ2q7JdfJmVH2JgG1CeVLDNq4uo5A6pHObF5jPA95xQf5WhoiyQBAwdB2aznFB
 SnhtJFemQYvj45d6uinHbMmDh93krPZBP4Cyp1FvyITvzReecAr1UV4Rgnssu6AC
 j4eVcZTWnv/vNWylBnGBDnEX3KoY8EKTC2+xBttqG6gthLM3m1OpwRlTRQGK44ju
 xvxoCoHNc2Q6ihhzCzGewPPF4JgNnSiAEr9Jf681q8nqGtKUZ8y3rWAVMSn3hYEq
 +iKHlA==
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha80ct4qh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:39:50 +0000 (GMT)
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-9179d9cde17so8104676d6.0
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 12:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792006790; x=1792611590; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=1I6ETAayPYc5O5Yhce4Zog/WU9cunarlvR0L9Piv9rA=;
 b=QGD4YlYmnDTxLapZ6AngZxMlcl3wb+2uZHIhLVht8PizKHOtwAm7QN3JcCccHpkX7p
 N01QnTJVpfjL6y66PsbTeg6phqhALvcWIgq+SAnoVRvaMaEiSnYNISa01vh1xNDa3E62
 cyiES072oWWdp/rD3sfvFKHkw/Gv9i221+tLYfv5K6ePUFvcS4LQASD/qXEKCEFU6LIp
 FJihvJbQKyxRHqgaFzqPi70N6MzrvKW6WDv5GSBeHvFKvEiEcC6DTGXOqFgNiJrfY6Wc
 IFUFnkR4rfO/Qo6JSNVQYnaHeT2NHkZqtcxCV+6twOgVPAONNT4lJVtTnj2nPjyuRQ9p
 0t2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792006790; x=1792611590;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1I6ETAayPYc5O5Yhce4Zog/WU9cunarlvR0L9Piv9rA=;
 b=nm2KSmw6+BVvrBAcaI51DiKdjCllwCvhTXmaKSnUe934Nod8hoycO+cMvwTRHL6g+E
 jSi9f+PS8SinD2tuUTw/HDjnQ92b7w5zLUr3vZ7xhKq7tljYR8wXA1leqVVH7PU5TsPV
 xxFMt/CXKsTYmQh7oUg52cBrSShfyPq2BfgWtRsiLDXbufARRhP6qYP+lWopaq/FQEgO
 dKuR4QTvUGMp8UTRB5E9nrkSaGN+z949OklYui3zcqRSHkCnBBdDrtu97E7zN8IZlKn+
 A6+mNgs26SIjl5ZqJdBs8eGOsV4T0H5raueGJ6t7IcgTBWlQPplTD/WJk8eKq0f5+dtR
 KsZw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwz6CbV5ceDIc+GcAu8E/rtN7Nz+1yL9jKu8aCSTCTdoTQIEnimBBpGFHd2u1OwCchfBqhk3p4xZSYH@nongnu.org
X-Gm-Message-State: AFq9FYJi5eREvwyPpDELgc2oEAraTBJPZY7oRI+voX4c82owbnXYjqNc
 QJA5BNlylWuIB31rrs7PE7RE9EzhPwo7MosfC2mmxI65JucQZ2YW3sxgOUaufk15NiDp7PWj9LZ
 Lv9R4eyO8ZP8KgHGZsNhixmShqGzY7WhIPJXw7CG2C0OS+v8UehiWuCrqTg==
X-Gm-Gg: AYBFou2sObSof1FXtfSdqyMMqBxXATw+RQJKX6NREm5skDyspScS9IMZWqn+l779uuP
 aj2aoUKNVSVnWFloxZcRtN/lOLUYAjDdIpWEsx3wgV/ynahU4Ii/FnlY6Xqojw1PsE2VEU1D6Sk
 4xubPlDDiQsKXG5ihR7yrk2TkGnzXKWJbpPsb6KsDc7oYeo/jQBQhwPrFuzlE6bekqXOJfzqlGF
 mrY5IavPaQPtOJQwBx8EbRSQxeBZ7d9mzIJO5S4B8zLwoWvw4h0RtE3P1dgqqHRf+avRpuXDRT3
 9fHTT79uqNhAokpU7d5Hp8TJ6/Wco9ONE/ZnM4ZNRuGNko9Gxw8MBGHwFwMw4jT6GDS+M5n5x5P
 Z8hORR+MDiXhE1QSHq+kAYHXTNPXHzo9Y0A==
X-Received: by 2002:a05:620a:25d2:b0:93e:d5c1:da58 with SMTP id
 af79cd13be357-93ed5c1ddd7mr2071074085a.79.1792006789961; 
 Wed, 14 Oct 2026 12:39:49 -0700 (PDT)
X-Received: by 2002:a05:620a:25d2:b0:93e:d5c1:da58 with SMTP id
 af79cd13be357-93ed5c1ddd7mr2071070885a.79.1792006789425; 
 Wed, 14 Oct 2026 12:39:49 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48defca4013sm3867331f8f.9.2026.10.14.12.39.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 12:39:48 -0700 (PDT)
Message-ID: <2cef1a78-a1f5-4ec5-8a56-0419dcfda864@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 21:39:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] semihosting: use new semihosting ops
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
References: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
 <20261014182543.135965-10-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261014182543.135965-10-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX4rDXe67jOaEd
 R07fDyzmMFDijrNav3uTKKypUxN9wbR9CHAgbcOz3auy4zJvSRpFOoMLOQfVkAmhI7cXEBTzNbQ
 /2fcl5G47cZ1xu5wVfJujVUhMvsygwE=
X-Proofpoint-GUID: T0lZe1DV5NOj4tkvktepHDG7Tn60gak_
X-Proofpoint-ORIG-GUID: T0lZe1DV5NOj4tkvktepHDG7Tn60gak_
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX2UZau9H9CNQm
 7ByyFj/9tFe5aV7imqCBVOTYkPT5eQkvtqDT1vELXgMnKbzN/MMw4laJ687/fKiI5CWk7TaT8XY
 wZjonuBDWqMdmgTmjy2+du4NF8BRnETqCXMAhJuJiKW7XM7zjUEOllg+iqV2T8FxLhuJHQwGvb1
 ixbryw8h3I4SqSsAi+CuPNoOneKmpMwCeP4dgK+uj2NanLg/kzpUOBY75WGr6cmVsJGI1cip/Hi
 BPL83eYwle+X9C/roo2Yq0x2gAnzr6lENr/umShZq879ytN2WrBPcu85EZ/nmDmZ+zJdmIF9i3Z
 WVx/zyDvUSeVymZebz8AvPmQ+tuj8D97LJ9OJyloXhsREMRuHUpl9fyBXSmD4Xx2Efl2/iKF1Bw
 2B0ziHMPsKpZxhOEv5+iLIQ7obuqRk9wjgDjEHekUBjVZiW1xOVVuPGT9gUnCXe1IYXcxmgIveO
 lXonqE2k7aZBjTD4vWw==
X-Authority-Analysis: v=2.4 cv=JegpPkKV c=1 sm=1 tr=0 ts=6acfda86 cx=c_pps
 a=UgVkIMxJMSkC9lv97toC5g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=1HOtulTD9v-eNWfpl4qZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140078
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

On 14/10/26 20:25, Pierrick Bouvier wrote:
> Now that all targets implement this interface, we can replace function
> calls with the new interface.
> 
> Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   semihosting/arm-compat-semi.c | 56 +++++++++++++++++------------------
>   1 file changed, 28 insertions(+), 28 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

