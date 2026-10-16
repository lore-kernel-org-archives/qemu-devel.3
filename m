Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC8D4CCA462
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 11:24:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHg1u-0000Qh-8j; Fri, 16 Oct 2026 07:23:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xHg1s-0000QK-Bw
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 07:23:16 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <daniel.barboza@oss.qualcomm.com>)
 id 1xHg1q-0001xz-Gu
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 07:23:16 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69GAAMHD2998612
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:23:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 VNKsOl8pp1JpbZ9NCvNb/rRD4IhUJ/WIPAqWKwqHBHc=; b=fO6soc8FRCdk44jI
 an0X57LfdIzoZqjSgVBYrT6SEmG8mYkQini2HmfqZ5tWc6axLzklsE1xVpZ7ZOZJ
 ueMdqMq7HLJBd5GzZbYjjgEUG4VI8+jTt/a/t1/590uamxpem42PODojnaLtda21
 8tvHtSNDsALPs9mnQbu+PQHBt2Yg7Aq9I8r9mdE3kehs3gbY8CtatyLfwy71jBjt
 iKrY+++umj/hcgLD1F462ehJjRjlf5Yv1sK0TmPpQpCneq8EHpSg/iRqRfDWF7Dw
 eojLbDsxKb9LnwEEb34robrjOUKXO6BydR0m3asRqSa/TX6FSPAvFK74d7hFJtRB
 jXeZ7A==
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hb8r12ad6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 11:23:12 +0000 (GMT)
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-5339253dc3fso136632871cf.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 04:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792149791; x=1792754591; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=VNKsOl8pp1JpbZ9NCvNb/rRD4IhUJ/WIPAqWKwqHBHc=;
 b=PEah807OoNhbplPhC2bf7B6tCHKVgwKjVjNxG3OOfuUgt2iMVxtcIokgHqDYkvWeVI
 /3A17EvqmyP5auZ6Z0IOyRmyhMxxR3flzELtQKt4KOnmg/VapWoFj3dLbqyT8sgNYASO
 SXB0rAGmZVC+N0xIITyA3dCvG5sHDRFgiuucK+U8OgK+71N3oPf+APiC0yEvNOFHPer7
 +RK1+ipoICPBp76mU4vBdG7081SH4/N/qwUloDfYQ0DL2hM99XHvg7ob1aqu5UOi/yoE
 8wjBE+XnrBA/McP9knsgH+ci98LjMMBpM+ii5JPjT1suFl+Y8QDcJsNUQ0KZporBXkHx
 SBNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792149791; x=1792754591;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=VNKsOl8pp1JpbZ9NCvNb/rRD4IhUJ/WIPAqWKwqHBHc=;
 b=L0W6a+D7QkGKrsbM2kR/UyeqZyuOig47rPd5i2o0/n7I+JUP3WDariy577FcLgxE+2
 5vJ4esQcXP0IZE4HC9QSbdIto6APfqqVIZCfvmSLXoib20JvnYaKktuaUtuv124mABvF
 sGFuzJKx0dyu0HP1xFs9jcU/92ymH33oDhCbwvoYMoO5pQj6beyj4pwqGfLMJUxTDzcr
 LLvtHPiio9ogRZOiY2ysKon8gG6ibMD+Uxtk8GHJB7isgB3D8rIYOPF3zGtmNuS6T2HW
 FEdA8lw0K6YuU5ZVTEj/OyCT4Nuh32gHDSjbbVSNDIC9dysCZlSJPFfayMQI6HEugfg+
 shJg==
X-Forwarded-Encrypted: i=1;
 AKwUvBxScSg4CRZYFCJsrl54pnxX1B1h2Ge402VUQ+LM9FBHNzXBI4At5xnR6cGy1cXXJuNbqfZXs1/NW1oY@nongnu.org
X-Gm-Message-State: AFq9FYLfWxBfwHfvuMw7c5QUY3hfYY8tiWxqgdJoa+J2zJpflb2P2YoL
 zcvtWldaIDAsZdcm87aDoFosZa5LrzKHICMNFL/rFZXFjhcPDmf/D4XAbg6F+oNnjZBqXh/bhmS
 IKg86KjvDEAS6H14B9vStzeE3uX60z01MVjIKD09Ipg2e8hAsQFVtBKiV9Q==
X-Gm-Gg: AYBFou3KnLbdf1Gb06hhKfeycgzhp7ROPzGiqnccKi8CTcOO3fJWzWARkoZMGNzStR7
 P2gghN++PccXUJtWvcwIC+HhweUHPIh3RD8KbWqwzrljTC/saiwoK2j3g1gAHcsKthH6a3uVls0
 O1wMw6OxZNyM+JD+wC1rIDte25N9fMbHXvkuLaxEPVONG87KiSWRhDyvwxQLnUBEsfZarDptVSf
 66dLwm8XIG3JeoByZRx2qU00kkciUbDagKZadE7PVQW38tX1F4OGV+2PJxigKLKfmPL8Gpk+veM
 0goq+MBxj5w4TAOcmm2dTkxWzLX861oJbChMX7NWpov+OutGlL+FMS68UOBECxjtjV1fmyKllzl
 VTjLPaHk5B9ElfSjdcqI537kyko4dSOAu50r/
X-Received: by 2002:a05:622a:647:b0:535:a5fb:6448 with SMTP id
 d75a77b69052e-535a5fb6a27mr376905411cf.66.1792149791331; 
 Fri, 16 Oct 2026 04:23:11 -0700 (PDT)
X-Received: by 2002:a05:622a:647:b0:535:a5fb:6448 with SMTP id
 d75a77b69052e-535a5fb6a27mr376904931cf.66.1792149790851; 
 Fri, 16 Oct 2026 04:23:10 -0700 (PDT)
Received: from [192.168.68.53] ([187.106.240.201])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5362a8e5831sm20203011cf.10.2026.10.16.04.23.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 16 Oct 2026 04:23:09 -0700 (PDT)
Message-ID: <763f740c-559c-4f99-a237-daf1e88d4e07@oss.qualcomm.com>
Date: Fri, 16 Oct 2026 08:23:04 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/12] machine: Support extra board CPUs outside -smp
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Portia Stephens <portias@oss.tenstorrent.com>, qemu-devel@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Chao Liu <chao.liu@processmission.com>,
 Alistair Francis <alistair.francis@wdc.com>, qemu-riscv@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Joel Stanley <joel@jms.id.au>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Michael Ellerman <mpe@kernel.org>
References: <20261015031804.2406055-1-portias@oss.tenstorrent.com>
 <20261015031804.2406055-8-portias@oss.tenstorrent.com>
 <b87a7231-ca35-4c1d-bc05-ffeee15eebf0@oss.qualcomm.com>
 <atH7u-UCZ3dbA-ui@redhat.com>
From: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <atH7u-UCZ3dbA-ui@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: JDYMpidDwZ04Zib_9z3DLI2GmgAaCn9k
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE2MDA0NSBTYWx0ZWRfX/WuWDTbIjjJj
 lhx7b/K2CbBWC1qZBppzUwC4AZlc2AFP4tBaj6vAhhsgmzQgHi/3EvIJP1Cplc2+Vh7jh6YKCzB
 lBN06+9G/ErISUJQLqi6lH3Fbtj3AZI=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE2MDA0NSBTYWx0ZWRfX1SOdSD89LUey
 podTFjm/YePKTxeMwYKywqjb8rXSttA4BPatdBmNwJvFxQprxReQfG0/O1wS2FeC9MANco7EoLS
 egf4lrRnSSxWKph+CLMYcBeUwO4O9cI006SdjENUitjmS24wMU7rx28XQpMzOuqW/cm+G8Nu0ot
 on9j+4aFpTN4DHlhkGNw/zg9blxNZg+Fr5dqa/9wnfxl0KMHwe2JEMnjAGkTLsif7FoozNIW5o9
 Is8qDOBbjemOE4psR0j31k5XRmhdtdwZ69uAjIBQVHTKz2ZIVIRUSlKGBYQNcnferWd2W4dLbvh
 p61J3gFGjrZuDs6QzoFkaCv6K7czf6cMQedEBO3U6e4DqzG7pZfYrnMfaHyGd+PX0mQApWnNEWi
 1hHHuu5n4XODw/qkYWantbNkkorLZQvKWo7moYJbZYEFE563k26sd2+65LBapWd05XueabOGV/J
 LN/j7SafVcn7P9Sbylg==
X-Proofpoint-GUID: JDYMpidDwZ04Zib_9z3DLI2GmgAaCn9k
X-Authority-Analysis: v=2.4 cv=L/CI0OT8 c=1 sm=1 tr=0 ts=6ad20920 cx=c_pps
 a=WeENfcodrlLV9YRTxbY/uA==:117 a=7SJRNfuEitxYTu7vBacxyQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=mDV3o1hIAAAA:8 a=85MS5epfI4Z2dy0OqHQA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=kacYvNCVWA4VmyqE58fU:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-16_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 malwarescore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 phishscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610160045
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=daniel.barboza@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 10/16/2026 7:26 AM, Daniel P. Berrangé wrote:
> On Thu, Oct 15, 2026 at 05:31:33PM -0300, Daniel Henrique Barboza wrote:
>> Phil, Pierrick,
>>
>> This patch seems to dwell around your turf.  Did you think about how to
>> instantiate different CPUs that might have different SMP topologies in
>> the context of single binary/split accel work?
> 
> IMHO the -smp argument as it exists today is essentially unfixable
> for the general case and will ultimately need to be declared legacy
> / for simplistic usage only. Trying to paper over the limitations of
> -smp with special cases like "extra cpus" is unlikely to deliver
> attractive solutions long term.
> 
> The eventual emulation of heterogeneous CPUS in the single binary
> work will bring this to a head, but it already causes problems
> today with our per-target binaries because even individual the real
> world CPUs we want to be able to model are not symmetric.
> 
> As a historical reference, a while back, Zhao had an RFC that proposed
> we use '-device' to define each topology level discretely, which would
> allow for arbitrary asymmetric topologies:
> 
>    https://lists.gnu.org/archive/html/qemu-devel/2024-09/msg03727.html

This RFC looks solid.  Any reason why we didn't go through with it back then?
The conversation just fizzled out quietly from what I'm reading in the archives ...

I am not sure about the schedule/planning around the heterogeneous CPU work
but if this RFC is aligned with that effort it would be great if we could push
that forward.   Enabling multiple CPUs of the same architecture/target into
a single board seems like a step into that direction.

We have the tt-atlantis RISC-V board that has a use case for additional CPUs outside
of the main smp topology, i.e. we can use the board as a testcase/validation for
the RFC.


Cheers,
Daniel


> 
> 
> With regards,
> Daniel


