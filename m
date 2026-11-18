Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F7BE606A32C
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Nov 2026 15:33:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=YIj8Mcj7;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=OAjarMXV
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xThea-0004kL-4R; Wed, 18 Nov 2026 10:32:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xTheE-0004gZ-0F
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 10:32:35 -0500
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xTheC-0002O7-3e
 for qemu-devel@nongnu.org; Wed, 18 Nov 2026 10:32:33 -0500
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AIDQM0X3912419
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 15:32:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 UheKrYAI9m42QIBsOVRlJRqrVVotx5ft7J9rdCw6tIY=; b=YIj8Mcj7UCfmWZW3
 pxMl2rgPdLgWpl9zAr6PYnndm/JVMwxnOgNIGA6NXhHzeEc9vaCVqUOZxrCB//wD
 +AZPt99xQX34xuql7gM6AQ4s1l66sCvJxB41nD7Y4fv+vmFoD6XrJW6ru+o4qfn8
 wRRHV3H4tOtW32Am0Ny0rHIMt2Goopu0ymvxw4EAiKt1ponwPP0J+yChH1UVyiy4
 /VlaqW7OTqDr7kyn334ky63NVrqKjKzdxq35coM8dTgsgps12bb6hFStzChkASpq
 wU8Jqgp5QHuc8A0z+FA8aiMmZJBVkR+Be0k6h6nwhT3U6ua3a7enauYGt4Uu8l3t
 mbJKlg==
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j0yv9bryw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 15:32:30 +0000 (GMT)
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-8b2fb1f981fso16207177b3.0
 for <qemu-devel@nongnu.org>; Wed, 18 Nov 2026 07:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795015950; x=1795620750; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=UheKrYAI9m42QIBsOVRlJRqrVVotx5ft7J9rdCw6tIY=;
 b=OAjarMXVK/8/uEBzEj5yhvGBuP1zM9/6p5ND5pgcLRMiJAaFW8hL3AiH1wqPdotcIT
 MO9njXWrv8d9N3A+g1QiSxK4VuPumrMhjxyL+OpUEv//+VMcMF3rhWN+fbil5PuJ/Cas
 /zVbTGKA1Zs8uBT6CSCTn3XewiaoCcSSKsPTOlJR+FwMBaHr6deHDUWf0XiZV+CbJFSg
 Zze7xsLiNdKTAc+S3/OTtshGtU1XJor5oR7mdLG+AUUJqE34gNvPhQ2MD3xq+pXAIVks
 FIw4q+FswyBfYYB2b3puy0xhAvi1xKaRgnCtRa1X7neJy4YHiO9uEnpcpqeiJwhsN16a
 dUlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795015950; x=1795620750;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UheKrYAI9m42QIBsOVRlJRqrVVotx5ft7J9rdCw6tIY=;
 b=yua/hwrZuJIBRclzmm00ZxKJi+J4rkRPcr4IpVCx2jK4QoD9A5IIic3b6BhFbMf0pt
 T9ctT2AAdL0T2rGLYe0bTqQB+fljj2YeZOAzifha4fT1DPn3EDpwSePI+zP5heX6SQ4s
 wDFg9mz3DVUT3rGK7odzxJ9VtI9hnWdcXvonbZ2N0lw1EJHsI/XZklaOP7gKeLVTSwkn
 KlnYca+ZxotVtImOg2DxsFE8u9F7hzHZq4XQ2Mb6pVgTUz8GN2rgO/hBKjwmwjVSyXCl
 8pq1oU+l8VEpc7KVbAJSwbsWHVvnZNNyZIKywOYs67clr1a9YvLr6Tvjn2Li+KEnK1P4
 zCbw==
X-Forwarded-Encrypted: i=1;
 AL+hErFsC94vEAb+2CNzdM7k0O6owkTFe/+8lBXme1+X+OidC23+hKgdLwXWFZ0Jy/chVnrOX2IKsp2AZeTT@nongnu.org
X-Gm-Message-State: APuU4Z+8MVClpsNzqE0ZJJC/ezfvIrLjmevU2tCp0SEZZ/GmQA1yyJqG
 arXiJGtEI6mDeI3gwQTa6uatQ47NZix8PWyQyijULq30aJ7DkX29vwPra0wxueNx/Gw2CIm/tfj
 0OKGCX3prR4SlKOWAc5sEKwSsmYarKJDISw+r0rD3IM4Vv27viqgeLpjPcw==
X-Gm-Gg: AZFdTZcThR8JVDyStfrSHM54YxH2nu36HIRw/WAqoLlwBP3R0oJbmq/kdRcDQKPLkoN
 nIlpTXQh085bL4VH6uLyW+a62lHf/izt6s0kNvL0liUCd4GzHZjWmQ+iGL8KTZaQiuzdrtgfxza
 p11YK9mIwFZsbqZwZU4TLNyvrfvzXJQ0LgmRxW8a9EudgpGI5fKOHxKi/QI9iKXQeBuP41GDQT8
 3UlBeiWltsy036Shyk+IhozE+tu+Vh60iFN355e3ZF+hVp3ajFIb/f6zbmJpLXGXG+vDrklb7eU
 9pm1RZZcZhJUHdDybOLT6fLZEUVZYnU99C4GcU/8yPjXmlRDND8d29MVeh+s+pr/2jN4rSdAJ+q
 zm9qLbGQJvN7Rb4basEVwQ0WMx95XNgA+a2IWKJdcVw1gjX3uO4UUuZABIr6OqhdyqOWlUrVwMl
 odR8kROFI=
X-Received: by 2002:a05:690e:43cb:b0:67c:6a94:f104 with SMTP id
 956f58d0204a3-67dd3f8bf82mr878698d50.61.1795015949888; 
 Wed, 18 Nov 2026 07:32:29 -0800 (PST)
X-Received: by 2002:a05:690e:43cb:b0:67c:6a94:f104 with SMTP id
 956f58d0204a3-67dd3f8bf82mr878676d50.61.1795015949176; 
 Wed, 18 Nov 2026 07:32:29 -0800 (PST)
Received: from [192.168.69.234] (pmd666.hd.free.fr. [82.67.153.177])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4a656c11f1csm5868540f8f.53.2026.11.18.07.32.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Nov 2026 07:32:28 -0800 (PST)
Message-ID: <74083d44-2bf2-4972-ad84-52c9b93f099e@oss.qualcomm.com>
Date: Wed, 18 Nov 2026 16:32:27 +0100
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/6] tcg/riscv64: Fix vector immediate handling
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Peter Maydell <peter.maydell@linaro.org>, Palmer Dabbelt
 <palmer@dabbelt.com>, qemu-arm@nongnu.org,
 QEMU Stable <qemu-stable@nongnu.org>
References: <20261028143330.6518-1-philmd@oss.qualcomm.com>
 <d16001a6-d66c-4af5-8e61-35484b24c37c@tls.msk.ru>
 <5f508944-1398-4163-9c72-ba7970640c6b@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <5f508944-1398-4163-9c72-ba7970640c6b@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTE4MDA2MSBTYWx0ZWRfX8kTCdjnoanst
 ++sjcSJdA29aMov7LNc9pVd+BzaHZcNympnh8/6eNnkqagqAIjDZ1/QwCks0vDUMsLMIcTH7zN0
 eNN3v7D7aBuhlsXUdafJeHpaFjsHud0=
X-Authority-Analysis: v=2.4 cv=acT0Dhot c=1 sm=1 tr=0 ts=6afdc50e cx=c_pps
 a=NMvoxGxYzVyQPkMeJjVPKg==:117 a=nz36NW0qrpeEijYxj/H2Ew==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=gowsoOTTUOVcmtlkKump:22
 a=VwQbUJbxAAAA:8 a=hXZgYZo4AAAA:8 a=X8Xlvf7YKcKku9pxmycA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=O8hF6Hzn-FEA:10 a=kLokIza1BN8a-hAJ3hfR:22
 a=37BJPeUnzxYkbV1yBC-1:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTE4MDA2MSBTYWx0ZWRfX7+lTpcSB7h1+
 kUCyMdjczN4FwxWeI9KryVoLtmEI2eMrazVVjUuAjcm2Uble9KCppYApGeDx+SDrQDFiGA6gjkx
 EVorjvwtV890f0DfTRCQU56x3jG6RKIboNzVkq4HM7GsUzRgt0OjqGWBM36I0El0doQ7Jtz8eWB
 Cb66AbvSiDvNXcAJ/9TaHZdhnNI5PpS+kudlUV/dG+fhAfEqb9WDRQQSDGrcuncPC2B6kg7CP3l
 +uiHP+30BP/VtSUDY/YUGA183nIQqpB5XqP98gs7GXOFWqT0DHwIH1Kfvc+dRurjeVCuD1eC3gY
 1Pxe3ekOWDbSVFg04c54o22pCitrauoNNa9fSlRau5eNKPR4OtvXypFo0rlY6PpR75V/VfR2nEn
 MbY/QFst37i3G3PQ/aPAa0+bdRlm5f68klfwhG7MaG4o/1WmSE7rA8gflzpFBfLNJjwL5BLgKGD
 zxy7uPjFJ0a+RdB9EJA==
X-Proofpoint-ORIG-GUID: EwUw97We33dzOYExRcnjWsz0OGDd5BkN
X-Proofpoint-GUID: EwUw97We33dzOYExRcnjWsz0OGDd5BkN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-18_04,2026-11-16_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 impostorscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 spamscore=0 clxscore=1015 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611180061
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
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 18/11/26 15:34, Michael Tokarev wrote:
> On 11/18/26 17:32, Michael Tokarev wrote:
>> On 10/28/26 17:33, Philippe Mathieu-Daudé wrote:
>>> The riscv64 backend mishandles constant operands of RVV .vi forms:
>>>
>>> - logical ops apply the immediate at a stale SEW (wrong results,
>>>    since v9.2);
>>> - arithmetic, compare and select ops encode the whole replicated
>>>    64-bit constant instead of one element;
>>> - shifts take uimm5, but the encoder checks for simm5.
>>>
>>> 1-2: add a uimm5 encoder for shifts,
>>> 3-4: extract one element (vec_imm()) for arithmetic and compare/select,
>>> 5: follow rth suggestion of adding a new constraint to pick the smallest
>>>     element size at which the constant replicates as a simm5, and the
>>>     emitter switches SEW to it,
>>> 6: AI-generated regression test.
>>>
>>> Tested with qemu-aarch64 built for a riscv64 host (debug-TCG), run
>>> under qemu-riscv64 -cpu max: the new test fails or aborts before the
>>> series, and passes with it at every SVE vector length.
>>>
>>> [1] https://lore.kernel.org/qemu-devel/20261010174742.3552498-1- 
>>> aurelien@aurel32.net/
>>> Supersedes: <20261010174742.3552498-1-aurelien@aurel32.net>
>>>
>>> Philippe Mathieu-Daudé (6):
>>>    tcg/riscv64: Factor encode_vi_raw() out of encode_vi()
>>>    tcg/riscv64: Use a uimm5 encoder for vector shift immediates
>>>    tcg/riscv64: Extract elements for vector arithmetic immediates
>>>    tcg/riscv64: Fix constant handling in vector comparisons and selects
>>>    tcg/riscv64: Fix logical vector immediate matching and emission
>>>    tests/tcg/aarch64: Add vector immediate regression tests
>>
>> Hi!
>>
>>  From this patchset, 5/6 "Fix logical vector immediate matching and 
>> emission" is
>> marked for-stable.  However, it uses a function (vec_imm) which is 
>> introduced in
>> 3/6  "Fix logical vector immediate matching and emission".  Obviously, 
>> just 5/6
>> alone wont work.
>>
>> However, it feels like whole patchset should be picked up for the 
>> stable series,
>> not just a single patch - because the whole thing fixes an assortment 
>> of problems
>> in this area.
> 
> Aha, so the other patches fixes ussues introduced after the last qemu 
> releases.
> So..
> 
>> Alternatively I can pick just this function from 3/6, which does not 
>> feel right.
> 
> This seems to be the right way to go.

If this isn't too much burden, sure. Otherwise I'll defer to Aurelien.


