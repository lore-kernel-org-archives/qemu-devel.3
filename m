Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE38B60A262B
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 22:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.a=rsa-sha256 header.s=qcppdkim1 header.b=NdRfqIOn;
	dkim=pass (2048-bit key, unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.a=rsa-sha256 header.s=google header.b=hO90A0DA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIveT-0003lx-Fj; Mon, 19 Oct 2026 18:16:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIveR-0003gx-CM
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:16:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brian.cain@oss.qualcomm.com>)
 id 1xIveP-00024Z-EI
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 18:16:15 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 69JLZPOC836428
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 hBWWlOrThsZ5WqKH/pMKWFjmh6NRfFkjmsN1vBLL1eE=; b=NdRfqIOnUYT2O3R+
 PKF4B7k0ICAxS54zg3tFjloQOpaA9L100HjCESB3f6PhuaxKGIpQk4zxzWloAp7n
 UsjPbjMTHbORr0vdw7kvNQU7KDgz5K7bfeR+YGjfHrp7znONnd7M8kanFGnEc5zH
 phIPALCiOIFvKXr5/58yFU4R0TT99QyAHypvQV8hw1wI8A7bmasUFuasK4TdOtEL
 cPj0jma2bGaPXeF4qR/yoIDcilwUWRgQY7/bNKCm3sYHjGaa0fBG4mJLUtScb0XM
 +zazUdHkHpXksSIxoyPipNAzn4YnWTXoOVpfsmA/yJN1YSCmZxXfjbdO4H+3OoUM
 cve6sQ==
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4hdf47kh8r-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 22:16:11 +0000 (GMT)
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-53664bfb2baso2428061cf.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 15:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1792448171; x=1793052971; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=hBWWlOrThsZ5WqKH/pMKWFjmh6NRfFkjmsN1vBLL1eE=;
 b=hO90A0DAVNnrjv8rrCnqvHk2TQzAxam/gWgAAKFcEdMLWQ8SR2A9R+AzpZJ05ockfh
 3Huj8/GJ5M1u8tQMs1Mi0xpeyeW74dsO3WrO/G8Mnvt9Vkjv9rmqzVHCI9vEvEj0+tAc
 psseRJaQOhWexTCH7jZq4tm1z3McB+t4rLMpLryHp9gHI4YGJj1ewbXpevAtbOx4p1NI
 BE3kDH/TjJYkcbniu6dVRHD1BytoVkLqaKOHlSloLOStcGqjISst/hTRHi9+rSFta+Mc
 DVysTSqOT6Z2kIh3nWDkikyIhW6xcxs/aG1JDNNogS4MDrbR+Mn5UKvKm7u1T66qjDWO
 O9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792448171; x=1793052971;
 h=content-transfer-encoding:content-type:in-reply-to:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hBWWlOrThsZ5WqKH/pMKWFjmh6NRfFkjmsN1vBLL1eE=;
 b=tGzWySSvBq7dSBXERPYBbOMRwxtXkUuNHSe7Wraf2MTuAMUBzWzRWqU8v5K/hzvjUb
 5yGaNlqO83ITBT0NBL+UGflN18d1Uci8sYQvcAgFBIAqRsvztDYBnEg/yNfc3pCVxlCc
 fG4V6wEMM0NJTKo9vhoPuSQ/YyfrMuQBe0V21GCKLY075UmqQZcKiBJJxKqkGfK7Ktzb
 yAS80yqUAOqzxFjKLWQT6p9iGHlhHtqSPHouhpXFQ+i7JVZh4X9JjaYJSuVvva46h7OK
 L/P1K9dPo+AkiEGeTFKPeveHdju6BVCoct4pbXSfIhGdVGFPsCXQQdmVEhlWnvm9Ci5H
 bn2g==
X-Forwarded-Encrypted: i=1;
 AKwUvBxgY+FsVNmUxS/7oG9hICApN/zXBHIuHpzDk+HYqQYSdg/ZqdyNwWPSIlDku9DZcipu9TUA11p3TmP6@nongnu.org
X-Gm-Message-State: AFq9FYIp5tcQqbVbpk8I9exytuTvPJ/QJSGKwSrxgre4z8HrBCLclzEk
 kA5/bIHF0xeIy9RQ2vm8J+J+N79PzXjgyx0q8g0Xgxf2ADjaK6cKx/L38uKXrOAPeWXMYA4FCKi
 k6pXpLjSjdISqO7ZBBnXrP9Uwb5QORAi6n8+/SCm6DoYcJmL2QWzX+wdu/A==
X-Gm-Gg: AYBFou0L4qHSwLFPqGn9cIosFBbzpMZRRgytTS6wdZc4psEvLBgtNSbZpnMsTSGk1PX
 5cgdsGojw+A8jJl3jC1sdnAFbO1VT/TcFn9O5XX7Ta6n5FnsnHBbpB0dPwWrgiTkB8VNEPvLZV6
 VbQ5gwGyulof5yuCA1Xl1YVS3l18VdjaLRJBx8n6qbR8z0/eppjKIiyg4CbyugDHfoi7IchFI6W
 2C8/Jt13TO6Bk7EQSEneQrCU/sAbKngnfIPQCzq2nhS/cM0Eg8352pup9bKjh8eN47YQ4Em2YF7
 XAU0wHO2KUMCRsPdww2TUW2i+uUG2S2E66jlmQ/Zkp0cuSc7EqizFN9IqcsByQZTIrxE+secL7b
 VGX0Hcl2Ecy0AMdPJXFEtp8ci520+xMJt7uHaFUX12qvYfSlMy/Mysks8w9Tpr9jt4D2yk7lsMp
 MZ+H0=
X-Received: by 2002:ac8:5ccd:0:b0:532:7ea5:f33d with SMTP id
 d75a77b69052e-53687091d5cmr7575731cf.34.1792448170455; 
 Mon, 19 Oct 2026 15:16:10 -0700 (PDT)
X-Received: by 2002:ac8:5ccd:0:b0:532:7ea5:f33d with SMTP id
 d75a77b69052e-53687091d5cmr7575351cf.34.1792448169984; 
 Mon, 19 Oct 2026 15:16:09 -0700 (PDT)
Received: from [192.168.1.199] (104-54-226-75.lightspeed.austtx.sbcglobal.net.
 [104.54.226.75]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5362aa332b0sm109373991cf.26.2026.10.19.15.16.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2026 15:16:08 -0700 (PDT)
Message-ID: <cfdd49fb-eca0-41b7-ab6e-2d3d73cad223@oss.qualcomm.com>
Date: Mon, 19 Oct 2026 17:16:07 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/11] target/hexagon: add v83 trap2 and vector stack
 instructions
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: Marco Liebel <marco.liebel@oss.qualcomm.com>,
 Alessandro Di Federico <ale@rev.ng>, Helge Deller <deller@gmx.de>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Anton Johansson <anjo@rev.ng>, Laurent Vivier <laurent@vivier.eu>
References: <20261019172603.2625677-1-brian.cain@oss.qualcomm.com>
 <20261019172603.2625677-7-brian.cain@oss.qualcomm.com>
 <88dd9e79-0802-4365-9755-b47be7723a20@oss.qualcomm.com>
Content-Language: en-US
From: Brian Cain <brian.cain@oss.qualcomm.com>
In-Reply-To: <88dd9e79-0802-4365-9755-b47be7723a20@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: Gs1k19t2mRB3XEdlZSlVR_2MqfVoR_sr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDE5MDA4OCBTYWx0ZWRfX2VtRqw/eoEHf
 nXNfLPTAmRtYCUUVz1+SHZ3kP2kg8qame9bLcE10xNUpoO4wmW4DxZr60OqO1zBeODr6pGEIfQg
 x0k/HqzoaSrl5/HTeURjkOAmGvt62TwcPtGWmPowi/Y7ey2paMLEwkfU+z2B7pn6YgT2f5yCY/F
 FXHyI7IKfSod9Q0UOM9tq01c4/+S7tAJBizCq4X0uR09PdJjZxBRQFtFP0yuI8xXW1edHD4pwrb
 h7en6O2O7zW0+v+v0KaGOLfjLduHbXK2qm54TA5dOd3cb6h/93zl+I4xJ/mqeLBdFxzSHekQSCw
 ll8HtmimbCY9rx0qe91E3dEAZFHo1rS0kEXXkL2y9wY2hKoJ7yFkG+o63jMCPlWnk5mTgD7a/BZ
 ynio0Ib8vdyrOIWJchHXLPMu9F8WHl+JtleAFn8E3tTdTBNKdDiY5/b6hyD5N7EBAaEZLZUEl8z
 /EORRfiv1KKA5u7Z5JQ==
X-Proofpoint-GUID: Gs1k19t2mRB3XEdlZSlVR_2MqfVoR_sr
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDE5MDA4OCBTYWx0ZWRfX4s2rVYda3q+X
 CbYsGFQzCCFLaFfCnxQIThx25PsshVF4b86tgH3uWGGsphENtaJ1VspfvGPuShq2tBNz9nJshji
 XL+V5Zvea7RHbIPKLEJPxIscWaLcM44=
X-Authority-Analysis: v=2.4 cv=cLt1IVeN c=1 sm=1 tr=0 ts=6ad696ab cx=c_pps
 a=mPf7EqFMSY9/WdsSgAYMbA==:117 a=x6rl1zRT+JsLSO7OGbGBKQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=EUspDBNiAAAA:8 a=gjBvQ8zWHIgRUBxJHpoA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=dawVfQjAaf238kedN5IG:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-19_06,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 phishscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 lowpriorityscore=0 bulkscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610190088
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=brian.cain@oss.qualcomm.com; helo=mx0a-0031df01.pphosted.com
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
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


On 10/19/2026 4:31 PM, Pierrick Bouvier wrote:
> On 10/19/2026 10:25 AM, Brian Cain wrote:
>> Add decode and translation for trap2 and the vallocframe and vdeallocframe instruction forms introduced with v83. Model vector stack overflow as a precise exception and report it to linux-user as SIGSEGV.
>>
>> Teach the IDEF parser about VSP and vector frame checks. Describe the vallocframe and vdeallocframe instruction semantics in system.idef, and move the vector stack overflow check into a shared TCG generator helper.
>>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> Not a problem in itself, but reviewed-by tag is duplicated.


Whoops!  Will fix it.

>
>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>> ---
>>   target/hexagon/cpu_bits.h                   |  1 +
>>   target/hexagon/gen_tcg.h                    | 51 +++++++++++++++++++++
>>   target/hexagon/genptr.h                     |  1 +
>>   target/hexagon/hex_regs.h                   |  2 +
>>   target/hexagon/idef-parser/parser-helpers.h |  1 +
>>   target/hexagon/translate.h                  |  1 +
>>   linux-user/hexagon/cpu_loop.c               |  4 ++
>>   target/hexagon/cpu.c                        |  2 +-
>>   target/hexagon/genptr.c                     | 21 +++++++++
>>   target/hexagon/hexswi.c                     |  5 ++
>>   target/hexagon/idef-parser/parser-helpers.c | 14 ++++++
>>   target/hexagon/translate.c                  |  2 +-
>>   target/hexagon/tag_rev_info.c.inc           | 10 ++++
>>   target/hexagon/gen_idef_parser_funcs.py     |  2 +-
>>   target/hexagon/idef-parser/idef-parser.lex  |  8 ++++
>>   target/hexagon/idef-parser/idef-parser.y    |  9 +++-
>>   target/hexagon/imported/encode_pp.def       |  5 ++
>>   target/hexagon/imported/system.idef         |  8 ++++
>>   18 files changed, 143 insertions(+), 4 deletions(-)
>>

