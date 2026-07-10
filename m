Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C55CC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 23:19:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiKUt-0002Yc-Vd; Fri, 10 Jul 2026 19:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiKUq-0002YA-FB
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 19:19:04 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiKUo-0004pe-UF
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 19:19:04 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66ANIcVJ2251227
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 23:19:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 QZ6maGE1IwixwywvLKMZTX4Av9Wc2zSRlIWc5PrKQe8=; b=EpUJFxlu9xBqwUfe
 YGSWomDlJgkZ33XhTwlyUMMBW3iMJO+zAePomplGWqpALLQ2NgiSldKVmDHU0LjE
 t0KO2Xx8RHqMUbLvMUKUqarRY1WvJcdilL06L097qgxAHkjeqL2r7wYMc8Z0Dprr
 DSWVCsSCiGmyGrjOlpISj2RGDX7AJQatnUK7q57eIbK0a0rSzO5BSXA0zwvDS8z4
 /Q1DyTtRxku91N6AKo0njSASHchFzvnsfSCjeSEQ7lheVkaNLWqshd6RcrL5Y7BW
 A+gTmVXDOm+zx/VKCSl7OxKKRa10+aoWi0mAZIUuhPrgZAhS3n8+3VIE7CALJVep
 q86a2w==
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb86egbbv-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 23:19:01 +0000 (GMT)
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-c894391f000so417437a12.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 16:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783725540; x=1784330340; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=QZ6maGE1IwixwywvLKMZTX4Av9Wc2zSRlIWc5PrKQe8=;
 b=F+lbPpCyl5Om/hzTdCqkwVw7X/RybhNLevv0Dx2xMdilEm6W26w7X1P4801vbKjtK9
 YvKGGAZiFh71DtrgGERolOigPoxSRYL2t9e58JiCqtkTIVkU0+IahwEn7YHa2o5wJATa
 hredmdtMQNOL1kMFFlgv8lM4h3bSysrIMDgCgPIqZ9CO3M8CcX1mjPGtCbRZc6mUlggs
 98FVuESPuliAziQwbM+5utK5r/jOogitrdOv+2D220SczJxm8fFORyHPlsDo+WTrG/ZW
 W48YXdZJQmVwxu/odCn8HAdOBgSNBHpEa3jBtrMeD62nk/knZJ55jwwf+yBmpoSBCKQX
 6p8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783725540; x=1784330340;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :references:cc:to:from:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=QZ6maGE1IwixwywvLKMZTX4Av9Wc2zSRlIWc5PrKQe8=;
 b=AzbEfqrwA72QNuGgVkT/gwaysGZATD969xJMWJr5S4LqFQA9ZS3rlng/+JFN/STjAx
 T+1IjL0DeXpmTBXFC/E2xD3RO25d+Luh1hQ9WHPN2dAKLyoN3ZiGfMqqPPoSssI10QOO
 EXrJe/h+xobrawG+ofeHPKJktWoQorAru6ie7+nv5Ibhlp6ABs8KP9VS4Gbuwa6htsUW
 vJd50gohgpkbmUzVpi3WsjNZrspR05l8Ko3rzi6ekCx2Bs5krkq9iDUo0uFnfux4mj1F
 LImxKFoshI2mbUqVZyCaE7hK6sEs16tOSKz0QWaInFwsrUwWpDRnM1Tu51IGFQUGDyqO
 e49g==
X-Forwarded-Encrypted: i=1;
 AHgh+RrXtFVQxr2Cpvkud1WFfAIjgiCF+MdTsiQO4eX0Sqz0cKZVQ65dLVKqfR2xVPF3NwQSRLCOppsMpxLh@nongnu.org
X-Gm-Message-State: AOJu0Ywc7tWiqeFMKmOzV4Rut/GuUYYSRTs6vKBjgDTai4ei0FJ1aLl1
 Yl6IQabzbmVacfqwOktjRt3VBtAih5BdqkTmGHPsCX0zKu3rt4eV2RJYix+WeOb4ZlUES1lAL1M
 ZVXXyo+uJ55o211sDC0ZgWddSczWX0bfB1TPvSXcUVFnIsJJN54bQmflHLg==
X-Gm-Gg: AfdE7clYccDbBzIV3exBKRfm8VZm27qiXJNX/N0E5KqLi4n9Coq1S0vYngh/KrNXLYs
 s0adKqXtSZ20XUpE6LArIfNZYVDOn0vszabDZ+q/PfFZSsBsJNsHCWQ2e5kR4+n6H8pLm+2kvm5
 3bdR8EaZv054hB51W7S8K7YaLM9h39rXbaZ+SHfodal7LJNIsTsiKlzugOoQGwhmy7XnxFew6Da
 ooyHL5rZr8/cy4TqOYLugh16ickI3GwKvDZzT2ZjXU8tx/TfsG+LzJHcmKVcOUiNMxayFrAqc8I
 rCS7Grp+w81Y7JWuPiAfcpLN6g4GUjRsFxip/Xe6gBZNFp5oM83MCiLWIiUG8TLsmhnO+BFRkug
 E7iL4qSyEuB17QVAdD1QH/uA6q/LCU2zNpzeKpOHkjztdv9ARSUBYRu2wj5Io7jkFB/i1GTVUya
 rStaM=
X-Received: by 2002:a05:6a21:10b:b0:3bf:b1d3:393e with SMTP id
 adf61e73a8af0-3c110009b76mr1041612637.2.1783725540379; 
 Fri, 10 Jul 2026 16:19:00 -0700 (PDT)
X-Received: by 2002:a05:6a21:10b:b0:3bf:b1d3:393e with SMTP id
 adf61e73a8af0-3c110009b76mr1041588637.2.1783725539943; 
 Fri, 10 Jul 2026 16:18:59 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-313b4cbafa1sm15187438eec.6.2026.07.10.16.18.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 16:18:59 -0700 (PDT)
Message-ID: <01423f18-3b22-4473-8c57-b78d4b1c80dc@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 16:18:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 29/98] tests/tcg/meson.build: check host cross cc is
 working
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710214343.2065491-30-pierrick.bouvier@oss.qualcomm.com>
 <1425950c-0063-498d-9b61-9101bc68f60a@oss.qualcomm.com>
 <5ad9b263-fad5-40ce-a8d2-82c3c626afb1@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <5ad9b263-fad5-40ce-a8d2-82c3c626afb1@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDIzNCBTYWx0ZWRfXz96fPWeB/pOk
 8kGAj1SjSinFhwlh2pPKrgxsVlhDDh7PMOpviUmL2MCcMHZsAzH/bpzsnUGkE01Vs80mrUTOEZj
 ddjil7A7FCrz16a7XJzHlisKGcSXz/ASHyItlPw5TXwx9qX3NfV20GRPG+Mu1lVlVN2WOEO6+tN
 94OHYSxL0rLilhz2AIAMPkRyzBr9fb8QTptcEQM4M/mU5CEf2pknVCKmTOX/zQvzfXaOmoJ1Yhn
 aFg3bHKWoclH1GNu5aucj3IcVm0FmBuci2G0lBMl0+HRyTjhBLTdYd51ovhlc/vhngvOMfgRYU6
 yFRUsNQinzYQ53LUjD5dwQsZUy0GNCAcQi+x22Rqmcerle6XMSkXi7XuzMJGa3mL1XjmULyXfXd
 IfTfpaIQbOCLf4qLSQtrf+4l0E/80Wo/oA29ElTs5oPU88hKIZ9IAI5lRWWjwHMC7sDnnbNkurh
 86lwjre93feyUFObxag==
X-Proofpoint-ORIG-GUID: RedANf1Ja8KfRf8nSRUqcBWbGkwGSO7c
X-Authority-Analysis: v=2.4 cv=IOQyzAvG c=1 sm=1 tr=0 ts=6a517de5 cx=c_pps
 a=Oh5Dbbf/trHjhBongsHeRQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=EUspDBNiAAAA:8 a=_GX_rOy366xbzcy2M8IA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=_Vgx9l1VpLgwpw_dHYaR:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDIzNCBTYWx0ZWRfX74HXRxm86P0K
 j43Fxj5z4UrP/p/XcWyTID37p5+ZROVJbz0FKDqqjQ4dMPUvkrAyzLKOcGDqWVoxP0txR8tacIp
 AIvrjyxO3N9vhh62SObdUyRTKOB5tEk=
X-Proofpoint-GUID: RedANf1Ja8KfRf8nSRUqcBWbGkwGSO7c
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_07,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 phishscore=0 suspectscore=0 spamscore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100234
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

On 7/10/2026 4:01 PM, Pierrick Bouvier wrote:
> On 7/10/2026 3:43 PM, Philippe Mathieu-Daudé wrote:
>> On 10/7/26 23:42, Pierrick Bouvier wrote:
>>> On Fedora, cross compilers are provided without runtime or header files.
>>> Thus, even if program is present, it can't be used to compile files
>>> directly. Check this, and fallback on docker if not working.
>>>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> ---
>>>   tests/tcg/meson.build | 13 +++++++++++++
>>>   tests/tcg/test_cc.c   |  7 +++++++
>>>   2 files changed, 20 insertions(+)
>>>   create mode 100644 tests/tcg/test_cc.c
>>
>>
>>> diff --git a/tests/tcg/test_cc.c b/tests/tcg/test_cc.c
>>> new file mode 100644
>>> index 00000000000..b8a0dae6c8a
>>> --- /dev/null
>>> +++ b/tests/tcg/test_cc.c
>>> @@ -0,0 +1,7 @@
>>> +/* SPDX-License-Identifier: GPL-2.0-or-later */
>>> +
>>> +#include <stdint.h>
>>
>> Why include this header?
>>
> 
> On fedora distro, aarch64-linux-gnu-gcc will compile this example if no
> header is required. By adding an explicit header, we make sure it
> provides them, which is not the case.
>

I'll add a comment and return a default value.

>>> +
>>> +int main(void)
>>> +{
>>
>>      return 69;
>>
>>> +}
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
>>
> 


