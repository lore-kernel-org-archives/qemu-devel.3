Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECB0C624D6
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2026 17:42:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x1oyD-0005DV-VA; Wed, 02 Sep 2026 13:41:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1oyB-00059T-Qi
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 13:41:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1x1oyA-0002Wh-1p
 for qemu-devel@nongnu.org; Wed, 02 Sep 2026 13:41:55 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 682HP0tK2421968
 for <qemu-devel@nongnu.org>; Wed, 2 Sep 2026 17:41:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 rptfB3I8Iuddw9rgoKg/e0l3i2DBlIFMoC81kzsop50=; b=esvbbtsGxt0dwKVu
 0Sd1Lf7z+7VfyI1xpebI2DyUB0wxeYKY4KkxlpO7gGhYOlkSk86X4d2QoJ1Q1Fd4
 HJ7JOvUH9RECPg03QfG/8T5kUk5o2IpVvZ0n+JpYHVZ0uNaZ1EBZ22H+cidgRXkn
 lXhT2Opg8rt0oETHTUtn50baPvZ1wvkKhiKG1Q45WrpqJttgn1LxWePICaVJm6dY
 XA8axbQwpR4ImqvjNsKMKYEJgS3XhgrZ+gIAuOOPhIbGGCAt7I5ZgKHta+GRA688
 SWpLf6NtrKV08kR68fd9r/3GBn4rsi1uiHpt7Nl3EgYzSooORCVK4sTfYijl/nnF
 MD071Q==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gemjh93b0-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 17:41:52 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38ea32e57e2so2729285a91.1
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2026 10:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1788370872; x=1788975672; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=rptfB3I8Iuddw9rgoKg/e0l3i2DBlIFMoC81kzsop50=;
 b=Iw8YMPjQFagPv1EYtbNuCf2jWqF54uhisqdEf5LZDaWGYw9Cq/L2f7Lx4NugkyM+Ef
 ZJpl4X92JVuY7lpmTeCBKGHvyKX78jaZ6i9oJL8gW6MYjDgQYys/wLQyS1FM7Q4732NG
 ncCO6awys82ozWJrJBRyC2PlcSwx/odWQUc+OAYUkh2E17I338kjmSOr7/EAGbrhwsDK
 mh8e6C1+TAz7L3Q0gTyW/RDBepmZH031ErWATCMK2etQwPxMuDGj1UaSot55MRIAO4G6
 CEy0g13+EQI9VLjtd4PEzm7MLyfxhn1lnn2WY+kD345DCpWDQVgjAnJDHSu1IEh0A3wy
 9FxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788370872; x=1788975672;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=rptfB3I8Iuddw9rgoKg/e0l3i2DBlIFMoC81kzsop50=;
 b=iG3L4aqTMJ1dVnl1+yIPbiNyN6vPQeE63Q2k2MRg20AEXnfTsrxfrG4ucheur5UpbF
 Tj2Mxl81eulNmzXJERaYsi6KCtZ9pufVfYc6P9y/CK8EAF+pLN7ceKb8ew5XnmiEHhGK
 cuXCKi/y1NkAIoXnvqr29ftm7Y6pdreS1CrFQnte/P5/3HbMSaHj228/pwPdJh4m/ccc
 3xSqvvrshsWW2WKtmOLxiTutm6fXBc271kuEVLDhiamkpTLapaYqQ36ZtFQ+mi1m42fo
 YNBHomJYmjg7zEkLOmT8VuUOIAkJ3vcTaCINhbNni5U5O/BCZGYlZsMdagk7emMu2ZUe
 8PfA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzoqNApNsfVCWKUM2jlS7szbERjnd6XygZPX+1KE6pNDT9BJAukrNQZWoFgO3CTp+yuk08kd2BQohuQ@nongnu.org
X-Gm-Message-State: AFuF++ketFlBisRw6+ymceukXbZNz6840ZUvXenZ/psFCyInUOwxJJLU
 4+HDyJBarwzUx7jKBIDR9G30zjLMZo1hsKe/YKRKo/lpQ8NNiz8Qsp9/KKAtia1hQhoQFkJum31
 S1Kg6vmwp8jeXes3HjbfUFcEd2+AYRQqRT2gErVxSalCpzRZso9I0ZCapxQ==
X-Gm-Gg: AYBFou38h0n0qWLbHlRJEzLBY9lDKNEUmvE1N2hxjwX1reoAizKVXVIMDMBgoMZyRqW
 Pt1Hd6e1SXl4cdustPb61/7Z91idJOxgo3oSJTA5YUmTVxrBqf/dHQvs/fS9sDokDIWubvxRrcu
 IHfSxro8bJWBTvkndOa92tp5dwfKvMCjGzLnllucGxWj80VLhn8DWuFcsApDkcawF5pWFbTrgXy
 dqwUrzmpa5DepFMYxJp13PHKTR9Y5xFmWvWOtRJfcIXVIoJwOr/y7QeD7yqBnmiZpiWSO7QPJ7H
 UnYtreo6hq8kgj4Wcr/dgH7c0il5khXrrSj8FlThFQR+WfIBWeJSpMyIgtQXFU5X+8MtTznp10S
 YC5z1FEkWkkRXSEOyvFVVFgOEBp6fvH/N9ctLZ7+A7J+l7ISvlbUANxAlpd1NS20xMcMT
X-Received: by 2002:a17:90b:2787:b0:381:1c96:829b with SMTP id
 98e67ed59e1d1-39aede91c1bmr10558103a91.3.1788370872234; 
 Wed, 02 Sep 2026 10:41:12 -0700 (PDT)
X-Received: by 2002:a17:90b:2787:b0:381:1c96:829b with SMTP id
 98e67ed59e1d1-39aede91c1bmr10558040a91.3.1788370871717; 
 Wed, 02 Sep 2026 10:41:11 -0700 (PDT)
Received: from [192.168.1.199] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-32f079c33e9sm8958993eec.4.2026.09.02.10.41.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2026 10:41:11 -0700 (PDT)
Message-ID: <1d8f35a9-4d6a-4603-8974-777064f3f786@oss.qualcomm.com>
Date: Wed, 2 Sep 2026 10:41:10 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] configs/targets: remove target info definitions
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260901202043.26532-1-pierrick.bouvier@oss.qualcomm.com>
 <20260901202043.26532-6-pierrick.bouvier@oss.qualcomm.com>
 <12afcfc8-e2ca-4d1d-89c0-54f8252abcc2@oss.qualcomm.com>
 <b816dd20-cb50-4e41-8e99-2559ffbf801d@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <b816dd20-cb50-4e41-8e99-2559ffbf801d@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: ZNihjdyeuGpnQBzkrHsMbXm89rnsYhKC
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTAyMDE1NiBTYWx0ZWRfX5lRxtEngjsS5
 og/TNFDryRiC6MHZY9RpfEMbgIts8mQzPO7QkMw7mPbglM4GMIlJQlVZTNUmLG4tryfMadgmSCV
 Q15lKVzca7Hfrm3rjEoJnwIFofuKBMTuZNrYpGc1hJNN6dahOPF2PpuHtJ8AzastE/wdPgpfrkK
 R1yRW2rqXci71YXSICtfoLrvbBtImN/orrHlqfaceij6s1hXgB+3Qdpke7BQ4a21H8c14Irpv9R
 JkuLeaX7ZeHrSJS6PYWpPYM7Uo8JLGPBbA02nOFQZ8jiWIS1M9e2l4Fk/fLA7b/IHYlebxqDakT
 IuK8NAje8DZMzaQ1GlWKufxAmxaCK6WVHELvPjF3v6gSgLg6bNpvjJGA58en1aaxJCzfy8rAlwY
 de/kkRINwY/lxE0KXoFRG+4arUl8Jwe/X6Be6k5eTRffCalQup+moI4pBj73ev8shUKCtzrGL6W
 ISFwiHXaK+LfXlB1TcA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTAyMDE1NiBTYWx0ZWRfXzMsNqiARx5jz
 HAsZscoHOdl29v1CVqyy9OqJItSyFsEh0qug35Svxw81DEYyeigHBSb9AC9ADPdpIdewyCEPWMG
 tIDkPGZbpRnXttDitM2qAxQSnlhjoXs=
X-Authority-Analysis: v=2.4 cv=ErHiaycA c=1 sm=1 tr=0 ts=6a985fe0 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=EUspDBNiAAAA:8 a=Klaw4ZCgXAft-K6_E1UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=uKXjsCUrEbL0IQVhDsJ9:22
X-Proofpoint-ORIG-GUID: ZNihjdyeuGpnQBzkrHsMbXm89rnsYhKC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-02_04,2026-09-02_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 spamscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2609020156
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

On 9/2/2026 9:24 AM, Pierrick Bouvier wrote:
> On 9/2/2026 8:55 AM, Philippe Mathieu-Daudé wrote:
>> On 1/9/26 22:20, Pierrick Bouvier wrote:
>>> Now that we remove machine_typename, we don't need to keep duplicated
>>> file per target anymore. So we can just rely on target-info-stub.c.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> ---
>>>   configs/targets/aarch64-softmmu.c | 26 --------------------------
>>>   configs/targets/arm-softmmu.c     | 26 --------------------------
>>>   configs/targets/meson.build       |  6 ------
>>>   configs/targets/riscv32-softmmu.c | 25 -------------------------
>>>   configs/targets/riscv64-softmmu.c | 25 -------------------------
>>>   meson.build                       |  7 +------
>>>   6 files changed, 1 insertion(+), 114 deletions(-)
>>>   delete mode 100644 configs/targets/aarch64-softmmu.c
>>>   delete mode 100644 configs/targets/arm-softmmu.c
>>>   delete mode 100644 configs/targets/meson.build
>>>   delete mode 100644 configs/targets/riscv32-softmmu.c
>>>   delete mode 100644 configs/targets/riscv64-softmmu.c
>>
>> We also need to update MAINTAINERS. Anyway I rather keep that for
>> now (including the following patch). I'am squashing removal of
>> "*machines-qom.h" include lines where appropriate.
> 
> I don't mind this too much.
> 
> Out of curiosity, what's the reason to keep it?
> 
> The only reason it was duplicated was to specify different typenames.
> It could be argued that writing them without defines helps to see
> definitions for each target, but not sure it's worth the copy paste IMHO.
>

Answer from Philippe:
idea is to keep them is to remove more cpu defines, and eradicate
cpu-param.h headers. Sounds good to me.

> Regards,
> Pierrick


