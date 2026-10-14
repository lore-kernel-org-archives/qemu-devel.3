Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6AD2CC6B2C
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Oct 2026 20:14:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xH5Mm-0004m6-Is; Wed, 14 Oct 2026 16:14:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH5Mj-0004gp-OZ
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 16:14:21 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xH5Mh-0004fd-PV
 for qemu-devel@nongnu.org; Wed, 14 Oct 2026 16:14:21 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69EEb88l1013328
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:14:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gaVnZLNu8pbTheViy0bX2nlNS9Ea/r8baqHvUMnP8zU=; b=mV4mXOs5k+7fej9u
 2HGg6TKbCYZEcGONYbvk9ngfpJdpYALEKOtFxr/u1Lp3Um2+MEBzCsNbqjCbrGMz
 GICR2hBrPkq5YilbuwoWMNkrb1xhnBWyCQQ38oz0axqCBOzjB85waxUev04mvtTL
 Ifzjjk3UvYqbD02fSm9fbQ0AgNArwv71OZV32PB1211isDsENSEiUmFld1/Mg1u3
 DR6fGrF94QChzCK4jfaX2rPVuKfAIhxjJERyXrlCh+YkRmF3IsqJCLISMn7RrWaV
 63Myx9FMebhiY7zZWPiktsg/p/a6xqC3abdBGgY2hO/20D11D9zk1lauz+Cyt1cp
 tqOTGQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ha80ct8s0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 20:14:17 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-35d4538fd74so4176211eec.1
 for <qemu-devel@nongnu.org>; Wed, 14 Oct 2026 13:14:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792008857; x=1792613657; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=gaVnZLNu8pbTheViy0bX2nlNS9Ea/r8baqHvUMnP8zU=;
 b=dYizaghOABbb/4siwx5f7isQ49rmQCmQCbouJUq64dYqii1xE39C178cXCxp/BnDo0
 j4gAwccLVg2WpbmIvemYN4v+lw1UKg/wl94nMPB9iUb94zjK+BHsZxM5Bd9vmrvTr44P
 gtLT7XfIYsesdBmAz4bSNitkuAM6iXD632zpL6/CpWDjKI7mSHrtBhHhuRQWkK/+MuUK
 XedANC2CZ/Mei724NE4eZpoTR8uNhF1lYswI4ogHgYdnnyoKJAhS10rVlkd2hqRWqED1
 54AjtTpdnr4Fc13M1F3g5rfI1Oe1XmWhnuEKNdZJu7Xx0cfHItUsDAlhpCp+0zHErcYj
 76eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792008857; x=1792613657;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=gaVnZLNu8pbTheViy0bX2nlNS9Ea/r8baqHvUMnP8zU=;
 b=wjcrNxHx1xMJN0w8U7H1x3W6VFWdHA8eUZvFdYCPo/YfvfV3UNcSXk5cRjzqbhbb9F
 +oV5Gd4/+4QApsfEiCPdWhHPkspbyPmoMHw8H/KT/Q2jqq2rtq6RyMFcl766Kgstega0
 rphtAzI+8dgxnj1QpJKiLPKScdJFt6NkAX2OLL8SXdcCbsNNoslsbcV+1SwizGstgCNZ
 2IwYoIjhHl7pWkH96WA/3zp6YHMVYQJwTCRN4nUEjoc6oWc99cLfUSUYY2o35BEIn1As
 546T7Bo3RorDmVVo6ON3MHjLZ2kZ9cWtQ/smYTNBBqt3o3EBqOc0r2G6PTxQjlHc6odE
 1qCw==
X-Forwarded-Encrypted: i=1;
 AKwUvByb4u12sTV3+M9p/XmhLRk8OSo2BJEleGDWUIZDbet9KWUl5SWRsXbcBjzupCiu2xR4xG/bwOlKbw3q@nongnu.org
X-Gm-Message-State: AFq9FYJZEzhCsT9Gvn+BrKFytvVvyqjKFX5OkAbNENm/rIboOKrl1lCK
 fuk1QP4iDyssBIa/2Z3pTZefcS77priqCqDIlcmsTYQA3bbFYuZ2o+VjZomtxx/hfy7EUVP5JSU
 6l1pOciny38KBTGCN5b72HLaPo+SqRDfrA7ipg+EiemwDGQy6ndpWJK3mHw==
X-Gm-Gg: AYBFou1kGji1gE32tvrrh5f3EkoVHq8Gsa6J5Nx6bmTUwEbS9rlaY8GRfmctluZplqs
 b69Wc8isSSBsuEUgeeZSBM0fovREe9z5ZR15Lab5ZwnWg+0zKKBAZYh/p/Y/BE2Jw5Sz3Yxjdor
 i0fxqjfP6yTbWG0XfBgEsD1wvMree9YwsqvKza8doY7YAx7jfeoAzdolds4+r6ay+EO4Ir7dyeY
 5LAWPWETxWCzhjR6R5cqVJpslXFKnDps36XCzKbEaytW+GRpHbyEkxv2wNd5k2VpVyEN0Q8rkd/
 qyPWcU4edMhcABXWP06WDsZUmC5RvtUfnETiK+tdg+waOg92Jwh+zLV9nRgdh8kpJDBNNKMraK5
 RC/5FSi10WVFLMTkVzvcvzZd4lTVJcJDbTwM9DwsYuja+ezK0xZOLkyaqNTzmFyNhsbnVYw==
X-Received: by 2002:a05:7301:2ad:b0:351:5b99:5f36 with SMTP id
 5a478bee46e88-3537e01eb1dmr21927582eec.9.1792008856937; 
 Wed, 14 Oct 2026 13:14:16 -0700 (PDT)
X-Received: by 2002:a05:7301:2ad:b0:351:5b99:5f36 with SMTP id
 5a478bee46e88-3537e01eb1dmr21927551eec.9.1792008856133; 
 Wed, 14 Oct 2026 13:14:16 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-35a352d4b05sm37323854eec.19.2026.10.14.13.14.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Oct 2026 13:14:15 -0700 (PDT)
Message-ID: <2cfd5712-bc91-4600-836a-914f7dd7cd85@oss.qualcomm.com>
Date: Wed, 14 Oct 2026 13:14:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/11] semihosting: declare semihosting cpu ops
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Anton Johansson <anjo@rev.ng>
References: <20261014182543.135965-1-pierrick.bouvier@oss.qualcomm.com>
 <20261014182543.135965-6-pierrick.bouvier@oss.qualcomm.com>
 <98eb67b3-af20-4f94-b13e-b179dbac233a@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <98eb67b3-af20-4f94-b13e-b179dbac233a@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE0MDA4MCBTYWx0ZWRfX0UQIKJEZg8V5
 cEyQ4KTJhdLjW/Z517McJ+ZZDskUEgFXH0O5ha3Rip8t2zUmWleSZbTe/NufPZzdhZyKy4w3e0r
 iomZ7iBdi3XxAhTuCIjfMlTunKTzPJ8=
X-Proofpoint-GUID: JMcW1G2BLtJWVwmtEYae2sak5OlgPqFj
X-Proofpoint-ORIG-GUID: JMcW1G2BLtJWVwmtEYae2sak5OlgPqFj
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE0MDA4MCBTYWx0ZWRfXzZ/RXRscDyOv
 9+8AauKZjyafCJbjKVkCgO5cEQLAIhXjmuTjbIQ1VupEL/cNj+slWXXmu1wLRb0fLpiGx2uQnj1
 Gh+WoIXp/TVJLxhKs+aDvkoQot63D2W95h7SNuyEvE0jcrQQJIUo43DzKBv3OLEN5lWLVyj5OPa
 u4XE2ayuUtEIN87leLn+dfw2RAkrRRsIfemEncC/LdlHyOaDKOfoYrv1AhqPTi0ceDE5DP6C2gJ
 RcgNqkjeq5e2muxIWdrp+9qbOCUuGB4BDdcTmz0yEsLBHLBMVLI/g+l+VFHiajO8xDbyVZorip4
 N+7iwhZpihOPZzkUUIxvc5NnUZ+gHJQiFGHUdxKqV23w9+tGj8uLX/0GyiyAJVDT9ZJetqJmcpB
 4b85QAYDL8wB2W4YmCYpsIwqNgYx3+0D+rUS0dvhBeIY3sG6eL5XAZpCEuLdYhoDhHFzicL/7uM
 dgLVYAL9JaOIw9Tt1fw==
X-Authority-Analysis: v=2.4 cv=JegpPkKV c=1 sm=1 tr=0 ts=6acfe299 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=0chu2OoBQL8WuwJmgwcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=6Ab_bkdmUrQuMsNx7PHu:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015 phishscore=0 suspectscore=0 priorityscore=1501
 bulkscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610080000 definitions=main-2610140080
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
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

On 10/14/2026 12:43 PM, Philippe Mathieu-Daudé wrote:
> On 14/10/26 20:25, Pierrick Bouvier wrote:
>> This allows a specific target to declare its implementation of 
>> semihosting.
>> 
>> Reviewed-by: Brian Cain <brian.cain@oss.qualcomm.com> Signed-off-
>> by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> --- 
>> include/hw/core/cpu.h             |  6 ++++++ include/semihosting/
>> common-semi.h | 17 +++++++++++++++++ 2 files changed, 23
>> insertions(+)
>> 
>> diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h index
>> 76801444a16..456154df6f6 100644 --- a/include/hw/core/cpu.h +++ b/
>> include/hw/core/cpu.h @@ -98,6 +98,9 @@ struct AccelCPUClass; /*
>> see sysemu-cpu-ops.h */ struct SysemuCPUOps; +/* see semihosting/
>> common-semi.h */ +struct SemihostingCPUOps; + /** * CPUClass: *
>> @class_by_name: Callback to map -cpu command line model name to an 
>> @@ -186,6 +189,9 @@ struct CPUClass { #ifdef CONFIG_TCG /* when
>> TCG is not available, this pointer is NULL */ const TCGCPUOps
>> *tcg_ops; + +    /* when target does not implement semihosting,
>> this pointer is NULL */ +    const struct SemihostingCPUOps
>> *semi_ops;
> 
> Could these be *const?

This field is not statically initialized, so we can't use *const.
It would trigger: In function ‘arm_cpu_class_init’:
target/arm/cpu.c:2669:18: error: assignment of read-only member ‘semi_ops’
 2669 |     cc->semi_ops = &arm_semihosting_ops;
      |

Current const ensures we can't modify callbacks set (
cpu->cc->semi_ops-> (const)), which is what matters the most.

Note: that's the same pattern than all other ops.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>


