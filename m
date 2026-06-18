Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1E38CD98F2
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 13:50:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waD7u-0002JR-U9; Thu, 18 Jun 2026 09:49:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waD7s-0002Iw-NX
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 09:49:48 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1waD7r-00026I-AC
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 09:49:48 -0400
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65ICv3a41878835
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 13:49:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 RTl+ouaP+X8X4g40LoSRPTIpMvm1Q+FKvkP44cxEJEo=; b=TSE3L1876y1uFVFx
 i2x/OVZGp6u3TIKffvKpi2cUpILE41E+TWSwnt51Ue6NA+dCbNLWp7ca9PRb3mWp
 JdFRpkYa9Sr5XS+gsq2yNCQw7JsOXAPhyuDGVsQFU5qoxcz6lqYSJR4xM6BcgXL4
 exTZwkVE0dACDABi08WxarlJ02bsqH9wwnArTdKJkUQPXUyOuMlk/rFOTkqGkhsp
 p7RRtUv/d6Sa3Ft9tdRkFrCoP9y42FTFQNmko55GpRu7zhHFsxyBZpYIkX+plRXp
 tEAfDmahYMWM+q0wmRovrYTnifwDA8wGEXHXBeCznxQASjuegpT3cNRPMSTByC6V
 znWf+w==
Received: from mail-ua1-f69.google.com (mail-ua1-f69.google.com
 [209.85.222.69])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ev0g7kugk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 13:49:45 +0000 (GMT)
Received: by mail-ua1-f69.google.com with SMTP id
 a1e0cc1a2514c-963aef8124fso217630241.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 06:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1781790585; x=1782395385; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RTl+ouaP+X8X4g40LoSRPTIpMvm1Q+FKvkP44cxEJEo=;
 b=DzDdx6BhxJXKT9akSVD68WR+zr38CT0zkXiDShAEgt2HERAxJ1NilTgpCRfTmTlvrN
 vwMybjMbce4re5R4vV6zt+VrnDCDb7GMQT6Cn25zFkD0tkMQ3U539O7eg3MPPLKZhg4e
 1Y/HpYschX4EEwQXtlKi1aSbCUyfPa6mrJizNONsawcIVN6+JdHyy1XhWESIs7a+frq2
 4CyXmFB4z2Q7mE+d0XFeF4pxyXljANCLsGKNEpM8q0nxvSflthV4BfLqCzAMzgETfeXy
 K+MtCEpB7lOH+mDZ3g9mGECob2J2+4v7EQJB1MbJmAfahYZVNeKJWWEaT1bH4CJjDBoT
 e6Sw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781790585; x=1782395385;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RTl+ouaP+X8X4g40LoSRPTIpMvm1Q+FKvkP44cxEJEo=;
 b=G68vlQ+YxcdedbxbJEQuYPvh0rSsWYHajexyLwjgnT6yMT845nrVBviQD5MBOcQHj6
 sDJvolUbnqashk6SXYtlAzK5+3X9WiF3x10OZPQ85Hx8GF2zyg8j7cmcQ3NoasOPRuth
 7qAtIHTX2eyJNdp5NqDFFJLo+DA3T9IQgG107RJF4JibHgPjS0YPReo+3xVZW4tbwjqs
 NYzBSvnKx7R5JxIHhtT75Aj8s/YebbVVtAn6JAIsEAckTsi9XFH3W5b5iZBuNsewpkyJ
 VHeQvn1qPRciPlfM+7A9DZ9AtItKSNCj/nrqfc9uG0OMen5xGg8SOkFIBgxiLzgu4C5j
 sabQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/OlO0+UtnFaZY/nk3z+09WD22TDTikaByPZBMcK2nXSZb9Ff5zwgfKrtnGVvFlxjg3uq6pO+QvOQ2J@nongnu.org
X-Gm-Message-State: AOJu0YyOnWH8o3n8jVP9gqbTb8t/xpQP9kM3IbMiX4zPuee3vRO8APBP
 N36aYAuSVjX5WNdZrhcOrvhSklXD3zMHmgqrfzhomqoHGwbdIQ0NEQErn1SFkvHMds1f/g4iHqK
 Q5WC0V5G1kFUTnbjic5NhVOU1N4d0zkxTGn/WXWSHRTfqWIe2sY8TY3JiQw==
X-Gm-Gg: AfdE7ckvFQ0gTPfbaVpLNTdJ1junJm14BVaUS4fQiI51HO5i3z0hhdvSQ6TZk80BNY4
 ta/MC7BaxZU6qH/GrX6MYShz5vOKKmHVazAS/UVHpOypPD/dlEVeK2LIV4hjfRyCKvtF2Cq2dAS
 hUYxaFhus4cCDS719KAuT+BWaaBAAGOFV8Qqgrby4jNv8BgfkqntsNIgRErdgAS73/ywta0iOi+
 n4Qgd5RiEU3mYK56aBl1yOotm1dT661cZq9VrQu5ZNEq02dDLBaMPMqaQ8d5OOKWa//PEJTJEpI
 NtsP0bCVpQa0dKiH2cBQ2NrlqvFK7dcYZ8RxLREAy3MddaCdnqTrH2zsGJ6GbLIZM/45zmc4bkY
 tboB8IsWpdwB2/fDfuTbU+SzAoPmIXYT9NaznxepASXXfwhWa3aRq75cu8QoEWw==
X-Received: by 2002:a67:f6c3:0:b0:6ef:f691:7043 with SMTP id
 ada2fe7eead31-727c643f9dcmr1788281137.15.1781790585122; 
 Thu, 18 Jun 2026 06:49:45 -0700 (PDT)
X-Received: by 2002:a67:f6c3:0:b0:6ef:f691:7043 with SMTP id
 ada2fe7eead31-727c643f9dcmr1788257137.15.1781790584624; 
 Thu, 18 Jun 2026 06:49:44 -0700 (PDT)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f726sm61184360f8f.15.2026.06.18.06.49.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 06:49:43 -0700 (PDT)
Message-ID: <978d32a4-0f6e-4c3c-a9ec-2aad628ad324@oss.qualcomm.com>
Date: Thu, 18 Jun 2026 15:49:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH TRIVIAL] char-win-stdio: fix typo in spelling of 'stdio'
Content-Language: en-US
To: Filip Hejsek <filip.hejsek@gmail.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, qemu-trivial@nongnu.org
References: <20260618-char-win-stdio-typo-v1-1-05086b1b326b@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20260618-char-win-stdio-typo-v1-1-05086b1b326b@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE4MDEyOSBTYWx0ZWRfX8WiGloBOrXDK
 aV2kVi4ejfoQsEOdkIVYX0remcIT4EVF7ILPYRuBXxz1Rtj83I0sj+dzHW6DXq8MmEbzkwPkLQ/
 VXa7iaY0/THgrH/HijkBeLXlB1VXgm5u9LG7QLD7Y/BX2wBWP6EchgX728B9v81HaB+Vqc28Jmk
 NbWRj7obOcM08MH9cyrKEyrtDa16nA+xqbu0+MknZuBcKhObp2s2cl0teWAqG30OpK/YgMHARpJ
 dZWRRO/WNpgyuWs4t1Qbm644MWG2QFCE5HxLt9ApbsbHN5NYCKI8lFQsITkC3b4Uqy9d87fbuvz
 BSbBvhbR+J1lKrvTD5MSA7Mc/nsM3+rtTl4tCvilab9/Ba0kmc9UC/kZunMLFyig+3Trt+BggTO
 Z50yGj7h/IJf8JkbXKGDVcKQtr0JfwUjDhnEaHBqfBn45V0qoqxht7n+KbAWbNISc9MPwAMareH
 TlFKnrikpEue/R5MW2A==
X-Proofpoint-GUID: sT9xUYVwAyt6m9ExxilPpVnnt8-_2z1Y
X-Proofpoint-ORIG-GUID: sT9xUYVwAyt6m9ExxilPpVnnt8-_2z1Y
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE4MDEyOSBTYWx0ZWRfX0yjLJAndABKU
 b7qtUHyCyYLDerR05vA0j4twQHAdfVowfFqBHHaxOqae2yL2aeWcaJpmL3pnRnyXOFS9sFkVMI4
 XL04ONBFcCHHHcNgRx6OOd6yX+71l0w=
X-Authority-Analysis: v=2.4 cv=YrI/gYYX c=1 sm=1 tr=0 ts=6a33f779 cx=c_pps
 a=UbhLPJ621ZpgOD2l3yZY1w==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=jyHsQcsEmyMA:10 a=TOPH6uDL9cOC6tEoww4z:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-18_01,2026-06-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 malwarescore=0 bulkscore=0 suspectscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606180129
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

On 18/6/26 13:20, Filip Hejsek wrote:
> Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>
> ---
>   chardev/char-win-stdio.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

