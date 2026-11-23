Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B858606A31F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 19:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=gz3FKKJU;
	dkim=pass (2048-bit key) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=RNl5blBe
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVZuY-00087U-Vj; Mon, 23 Nov 2026 14:41:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVZuW-00086r-23
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 14:41:09 -0500
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xVZuR-0001xU-Ng
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 14:41:07 -0500
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6ANGGv5h2340294
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 19:40:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 EBWOMbY1PzDZv4r62a4+9ALSGe4bdfv7rahik9IOWnc=; b=gz3FKKJUacgZS3+A
 pQ4yvTW+0uLiklZNiVjRHsghMMWS/RuRqI/bWrbERMX5/9wqg5E5VRVlmKYA/yq7
 8c1fa25umXfyUjsdGb758Ln+bpV+8zVIvb357pFIQQ5jWZhNyWV8krqTfamSCUHe
 4xE76gKaOGWV9AUNOuZkrUGc/cJvHUIWYvfWBbaGUX7pRJfJ9de4T0tBJs4N5BKi
 oa00Ekcz/Kt4D6UOXWNczlGpUa65gfhP6OxbmcWOeHT1u4FueNGA/2tz95VP3yxW
 cst8vIrVlsF9fQ/B0SmvOFOsDwV4wnSrJ/mX4StCpXB6kyuT/kcrxG3l8/XQj7VQ
 FVkS6w==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4j4exx3bbn-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 19:40:57 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-55b9c13273dso65916481cf.1
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 11:40:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1795462857; x=1796067657; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=EBWOMbY1PzDZv4r62a4+9ALSGe4bdfv7rahik9IOWnc=;
 b=RNl5blBenKJXYzawAjSneVJQqunk/tafSoCFUTZp9njWav5iPol8dk7poGxlCqF4yt
 Pi4rRbnt8wu3rkdVooCfGJW3g1JmBR1hgaQiZM0WNxzT6iRE+d0wrFuhqpMcnDxfSNvt
 GZkAYJTohY90IpC0QQvYfWV65unTSITe9h4UDwbd0hARg7hNpTgQVer9y54FoE+AXEFH
 LP3h0KxSul53GuISHb1j8iSt0Txpyv3sgnCWik+7odPZWqNBnRM4A/pNts5NJm59fshn
 3herrAp7LzGJJPefR33HVep3YQuYCN6b5SCNkKSJDm5JqJzu9Oug+PeyX9wciJnpv4Jg
 2VZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795462857; x=1796067657;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=EBWOMbY1PzDZv4r62a4+9ALSGe4bdfv7rahik9IOWnc=;
 b=Et3g6FhMPaNagDAf2YWNggYdwJjjq2/3pZHVJZPi/4OIjLc8hvvXBBqyFsx2ccLCyO
 EHGQ0vby7x702Dmb9xCYREyUQisoqvjZq6snhmb0/ToVvTEfqsZD+DXSzZ/ujjK4ajux
 VTg+9ZKPG42rxyfJb0RvfSr/dWJGEu1J/r4b2e4rH3oo6iuqkCY02a5VDvvObhB6lfX8
 VUKTCsitGKktrv9kWOnjPRw1QhG26IXszGO9zNEplCDudLamdLFpsiaOVUaSNMjRaAZX
 9UxD/r1ZTdlmyjE1wyaMU3lzkZAmOdbxUWAeEtL5bXS+IWwnKZz4K0cVaKAg4XZq+MXc
 df9g==
X-Forwarded-Encrypted: i=1;
 AL+hErEbeij6IDfgKDmyBPRS+CVUcsUFKuJsndW3lZFkIe+L47Mk42ZXmHu34ph4NZC7mQSO4/774KVZucyQ@nongnu.org
X-Gm-Message-State: APuU4Z8O7sFwBW+18hvE9GT/M5SB2kljtKqHnabbxpWUxf2FVxsxe3lq
 vDKvZOD+FU5rMmE19woPFyh0GRd9cP+je6F++83465nrRNaQOfTtI+2TzAdDBUXaIrqCk+pLrzo
 gOaA/saIvv4Sg4GOThVYYATVQ6I9i4o7KymqL68WnhylzAVyojHGyi/eyiA==
X-Gm-Gg: AZFdTZcY93aU1EHsrpvvjQuGd/zNWXW/EGALcFH16/Pt7/stfLc3FjJrVAr38HX8HQ7
 f4NjPT2VLSDGNebXvdXkcd/yzLFffhpqK0nZC94c0CCEXfBlZidjkiFTfoEB1x/g6p4o08jCMGA
 IfSviyeMFWR8/riH0rAMefSd2Lx4YqLPNFsKw9jjSE8sn3+7Fq5W+Up1tndr07alGEgb6xjc4uh
 nNRdejAZXueq/VIdbWu4UD2F2edaknkjupZhgHcNFQDJ+9R5SZePxwfKk7kwbdhLc3Een/5CS9k
 lLwztdYO6qHw97zotAhE29R5iJg+XInAVonUZ5MZZ2aXC64TkBOlWLphvhAJaYxGq+zCNnv09rJ
 9RRpe7eL+VZV+8WJHx2QjsQOKMZka3vQNICdSE1vgzZdhdH9ImYt0GzkQcZaljuOcgN8fVKBLdP
 IaY79C9co7
X-Received: by 2002:a05:622a:a05:b0:555:50da:f038 with SMTP id
 d75a77b69052e-55d768a3faemr229806891cf.1.1795462856743; 
 Mon, 23 Nov 2026 11:40:56 -0800 (PST)
X-Received: by 2002:a05:622a:a05:b0:555:50da:f038 with SMTP id
 d75a77b69052e-55d768a3faemr229805251cf.1.1795462854862; 
 Mon, 23 Nov 2026 11:40:54 -0800 (PST)
Received: from [192.168.68.101] ([189.110.107.17])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-921349f098bsm112080516d6.30.2026.11.23.11.40.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Nov 2026 11:40:54 -0800 (PST)
Message-ID: <a5a6cbd5-4220-425b-be7e-5726ff0221ea@oss.qualcomm.com>
Date: Mon, 23 Nov 2026 16:40:51 -0300
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/1] target/riscv: do not write SXL < UXL [GL4821]
To: Alistair Francis <Alistair.Francis@wdc.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "chao.liu@processmission.com" <chao.liu@processmission.com>,
 "liwei1518@gmail.com" <liwei1518@gmail.com>,
 "zhiwei_liu@linux.alibaba.com" <zhiwei_liu@linux.alibaba.com>
References: <20261119124141.1279663-1-daniel.barboza@oss.qualcomm.com>
 <fc4c472c8652b624f8964eae5f0f95ec7c3a880a.camel@wdc.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <fc4c472c8652b624f8964eae5f0f95ec7c3a880a.camel@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=FKKOVOos c=1 sm=1 tr=0 ts=6b0496c9 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=2Chh/y2wedAoPG2p3qwUfw==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=VwQbUJbxAAAA:8 a=EUspDBNiAAAA:8 a=CYUUmzwy_dYJKcM43WsA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-ORIG-GUID: Bh44A5CvYF-nYXINz7OZNnUlwkp_gKMX
X-Proofpoint-GUID: Bh44A5CvYF-nYXINz7OZNnUlwkp_gKMX
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfX2+a3zf9kNqzl
 kLNKDr4zUcGf5qInb1qAaqOosebUoMUyj5pM3b5jMnImQFK9jpKLOYR0gIXmDOT/aLCVkPJLMyK
 devbsb91fkfAgZvcj0NaLwImdi+cuOs=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIzMDA3OCBTYWx0ZWRfX51welLZagGnJ
 h+XjMy+rRmWpI2oQwlRNiG8JMP6pg+YxuZpIn2j8IMwhS3YWKu5WA6rG4B4PDr1XtXsAcVAH+a5
 n4cNP2SlIek0Tw2pAGeHvHgbR2cSluFF0bp0OeyV/sEG7mfu/6oMm1SnSPcC4Qv/3gFPCXIlkSO
 NcXqg5vIZPgOd35fM8eebH3gsnBs/tKtrybLEbcAwV7pnWgJylfD6NetnSbDBVQeQP48LS1TKkd
 VUMSrI9TG0K1C7qJZNNojN/FZeq9q2h2uhdJIoERKWL3U109isLB/eXFRxUIC8THRwe83uZoHUx
 0yhVyh32ow1s0W7tTtAncOvsvAqQW6NxNnoqFUHBbpCkNgQFaec1YdZvIUjRoQjWdSjJAg+y4lg
 nhiaVdpPLO5CFlDdskWg9jM+nPQbswnyJZOKWeyfe67s20QuTVngM0XtXdJjYit2XB9SyGXAUVE
 4ifkK20E9iELZA0ZYJg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-11-23_04,2026-11-23_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 bulkscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 impostorscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2611040001 definitions=main-2611230078
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-12.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



On 11/19/2026 9:56 PM, Alistair Francis wrote:
> On Thu, 2026-11-19 at 09:41 -0300, Daniel Henrique Barboza wrote:
>> Based-on: 20261110232614.83050-1-christianslima@proton.me
>> ("target/riscv: change mstatus bits for read-only if S ou U
>> unsupported")
>>
>> Hi,
>>
>> In this v2 there are 2 Sashiko-suggested changes:
>>
>> - added a "Fixes" tag;
>>
>> - simplified the 'min_val' calculation when writing SXL.  Sashiko
>> said:
>>
>>    "- [MEDIUM] In target/riscv/tcg/csr.c (write_mstatus), SXL can be
>> set less
>>    than UXL if RVU is absent. The min_val for SXL is only derived from
>> UXL
>>    if RVU is present; otherwise, it defaults to 0. This allows a guest
>> to
>>    write SXL < UXL, violating the intended fix and the hardware
>> contract.
>>    The check should ensure min_val is derived from UXL regardless of
>> RVU."
>>
>> This won't happen in practice since we're basing this patch on a
>> commit
>> that will forbid UXL writes unless we have RVU, i.e. if there's no
>> RVU
>> we can assume UXL will be zero.  But, by this same logic, this
>> ternary
>> is unneeded:
>>
>>     uint32_t min_val = mask & MSTATUS64_UXL
>>                        ? get_field(val, MSTATUS64_UXL) : 0;
>>
>> And we should just use 'get_field(...)' directly instead.  So we're
>> ended up doing what Sashiko suggested but for other reason.
>>
>> No other changes made.
>>
>> Changes in v2:
>> - added "Fixes" tag;
>> - removed the ternary when assigning 'min_val' during SXL logic;
>> - v1 link:
>> https://lore.kernel.org/qemu-devel/20261112163242.509864-1-daniel.barboza@oss.qualcomm.com/
>>
>>
>> Daniel Henrique Barboza (1):
>>    target/riscv: do not write SXL < UXL [GL4821]
> 
> Why is there a GL in the commit message?

Shorthand for "Gitlab".  Makes it a bit easier to find patches that are addressing
bugs in "git log --oneline" and friends instead of reading the "Resolves" tag.

Let me know if this is annoying and I'll stop :D


Daniel

> 
> Alistair
> 
>>
>>   target/riscv/tcg/csr.c               | 39 ++++++++++++------
>>   tests/tcg/riscv64/system/meson.build |  7 ++++
>>   tests/tcg/riscv64/test-uxl-sxl.S     | 59
>> ++++++++++++++++++++++++++++
>>   3 files changed, 92 insertions(+), 13 deletions(-)
>>   create mode 100644 tests/tcg/riscv64/test-uxl-sxl.S


