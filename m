Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C948EC3DA7A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 19:49:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH4yc-0003It-I7; Wed, 14 Oct 2026 15:49:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xH4yK-0003Fm-Se
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:49:09 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xH4yI-00029E-6l
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 15:49:07 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEabKj500271
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:49:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 LuZYQZ1u61efskiGgxWde1JSKxPM42Xg3gubBrZ/NMs=; b=cvv5SXE7g8MOOpA3
 NbZiC5T7B0Sq+OjnKTU/oukrZZPye21xpuoxz0lKeRkGen4kCYEDHtFy7iD/P+Bc
 cKp1vw1Sf9i+xHYxQtsNnpjcdcevX9BQkKPy+5igrnc9og8B+tJgpzVmWolpTTS0
 iBx6IDUAR00ZsIGREmlYGLm9lIVejoWiNQkOQnJ8fNbPUXPHQFB6HRFY0+uMUH6E
 590I/XL3AOcX7GFmNjyOpZaDrA36abqw5rgM3M7dpZZgB4qEfOy/mBqp0rojAoqo
 VRyf6wvCcLXaIxf0yhQHwAijzdvsjqsxaHB1QOiFpBVWOIsH1en5lF7gtDLmxPrS
 dAGc5w==
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4haagf1h52-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 19:49:03 +0000 (GMT)
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-93caa0ce0cdso103751085a.2
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 12:49:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792007342; x=1792612142; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=LuZYQZ1u61efskiGgxWde1JSKxPM42Xg3gubBrZ/NMs=;
 b=Qz/brccrDdqlRpuFcl4JbOflePkNSxHwVBgTaixoWvvpeDppnTVIv5jBaEhYsgqrM9
 dcz1/rKRUFlnpzEJENq3OvWR6oa4ssLuIiZcSG0YAuxRfmKFMP0KS4Ijdj4jAaOKx4dd
 q3EtPGwDPIZEsqyIGEl8iZHawLAE6BTKVmMrBNqUWjwPNS3uTVZw0N6jBxtcYHE69thm
 ab8q//PiDV6gXvOB4UF3mtT1FX3tLOJ31R6BvSeI5/lL/uBACjXA2FYhLVFKWIwWeZaG
 5Iv7QgXjdDvXrvHNcRhJEV80qDfmvY10o4ZfG75GYqwDRQgg5dj+Inx6Hva8PBc8H1Yn
 syXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792007342; x=1792612142;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=LuZYQZ1u61efskiGgxWde1JSKxPM42Xg3gubBrZ/NMs=;
 b=yhyagLqFm/K0Q5s8ZTC+rW6zRRVwMFzS4JMURJd5kLTD4wEDYKhJyRRgSOK+3DujOV
 1uyVd2lPWfS51ma4KGDQw5FlhZccb9sgRj3pimFOot9SOvPbsVGUIOrUyNEITLZq8QQJ
 d4XBz035q/aXicC/OHWe9+Qe7g4sh/KnKYoo1DdAV7MObMHpjI/1yCUqLC9eIEwIDrcq
 8NN2u3TzLLroZjeuHhoDbDNjVU0eo/lF1CFUWRFvle38t5NcvmUZdeSIMGNeYa7VBIfH
 gqktGMpqGtMT0Oz3OqbXKGnGFW2IHSVAMQCuh07owob8HRKRDNIW1ST5gHuw7gEh7P3r
 SADg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzkfrSnh67S7RwcLKIL0/Ju+fa6RCqT9JCEppixWJUgzk8kOvQfRUp/Kw4t2QYqpWYNpMskz1vzM3bG@nongnu.org
X-Gm-Message-State: AFq9FYKgI/QtGazccYchVkFAWMHjW/qBY4TZHffRyM+F9rxP+49jotBO
 GMrVcbxxFNfcPIexqZ+EV+qoW5i5JRS4SAJXokonOjlPPoa10BQ42Z5iV1d3bfsxhAgNPWZgytK
 CMk2pvP9g3Ds65sbulhqhnBVQfoOHOtD/iRo7rKIqBsqX1BRLwdi9KuJgZQ==
X-Gm-Gg: AYBFou1chsGE4rV1U5O76rWmsoyT2mWNxP3m9lwkMbVMIGtkO1nRaHVyKDUIhANMKnq
 B3hf8fMzro5p3izsqu/oQ76C3N2oe3tHNnNTzhRaghvJCgtyDidGGJe5DBdQnu6eRBdV92VSnsO
 Q7a8TfIxNL02ljinBl3q8R2kIGML4GGi+P65CpdMiCt8Y6hZkF/HTs0aO4GzPIGMRZDaY+ZSm6b
 KQS7Tuy+rsR11JvLtMh5UXkceM0+tEsqr3hDfj2Ta75B8q1sWWNB2XnHCsPL0WF3bV2ecv8OyOe
 9+szqZpc1RBoLcM4cEDC3Fr5J1UyKO9EA/qk+c5tuRrSTroFJ/T2IfcMuwTN+DImWYXDqf846x8
 lzDFP3atOwqOgvHrnLccYsjkqCMvKa66+cw==
X-Received: by 2002:a05:620a:4449:b0:93b:e9db:1bab with SMTP id
 af79cd13be357-93ebd27cc75mr2598166585a.56.1792007342314; 
 Wed, 14 Oct 2026 12:49:02 -0700 (PDT)
X-Received: by 2002:a05:620a:4449:b0:93b:e9db:1bab with SMTP id
 af79cd13be357-93ebd27cc75mr2598163285a.56.1792007341848; 
 Wed, 14 Oct 2026 12:49:01 -0700 (PDT)
Received: from [192.168.69.210] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a1bd680c83sm6933365e9.2.2026.10.14.12.49.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 12:49:01 -0700 (PDT)
Message-ID: <46c3fc51-9363-49f8-b225-734a76abc2d5@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 21:49:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/11] target/hexagon: declare semihosting ops
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
References: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
 <20261014182543.135965-8-pierrick.bouvier@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <20261014182543.135965-8-pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX0kpxdmtr5AMQ
 pLi6irb2fSjdvT/y/N5KDe9q/rRy1y22j1FPUuDToZLQKjNAKu+zZRG4YxvtkVedEHaqZlqMBe2
 JF2UoztTzgQwcruUY8JEearLLyqSQx0=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA3OCBTYWx0ZWRfX2t1LZXEobHx0
 /6t99pGfMxFGEtsIeHkby/0flBBNf1Ieq8c+LDhES9PTmRGgGPpziraFGR76ST30kGgWRPPWeBm
 kU2cs5t4P/ahIfbYMY9U3253KMyb6RAzf1ICje874gThfUyIp+izzxnU18gHoe6niQU9lzObCkD
 5P8ncBXLRbPU3zswQA6UdYGyLK/ct8Sk3/0BgxAESoOC6OIDPoESKeMpS0XBhO/upCrDP14Fw4S
 A/5ZwfVP9fUE3CTCmqEfrDY9Jlo5L3wlbDhHvkqmj9NKO0RXFE90YkO3trdL+W3Q3QyLVbK7+4m
 vKlcgM2LpbOjV4bq7sue+W7BVY1FbntSeWpoPikTyaTJ7lsrMlTcgQgPeQeR2pmvhiBVaGT6IOJ
 v9Hu5zEfcFCiG2Z7YQ4YXS49AJwv8Q==
X-Proofpoint-ORIG-GUID: HUtlxxyRBR-uZHJz8Lw_0DdHOFc5oTYW
X-Authority-Analysis: v=2.4 cv=V/noQuni c=1 sm=1 tr=0 ts=6acfdcaf cx=c_pps
 a=hnmNkyzTK/kJ09Xio7VxxA==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=1tSEMpTH9XP_W59IOagA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PEH46H7Ffwr30OY-TuGO:22
X-Proofpoint-GUID: HUtlxxyRBR-uZHJz8Lw_0DdHOFc5oTYW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0
 spamscore=0 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610140078
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

On 14/10/26 20:25, Pierrick Bouvier wrote:
> For now, we keep the global common_* symbols defined.
> 
> Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>   target/hexagon/common-semi-target.c | 63 ++++++++++++++++++++++++-----
>   target/hexagon/cpu.c                |  2 +
>   target/hexagon/internal.h           |  2 +
>   3 files changed, 58 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>

