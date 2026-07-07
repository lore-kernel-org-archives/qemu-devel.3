Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33FDC43458
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jul 2026 16:25:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wh8bl-0001LN-7d; Tue, 07 Jul 2026 12:25:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wh8bj-0001Kv-Bl
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 12:25:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wh8bh-0001Qw-R7
 for qemu-devel@nongnu.org; Tue, 07 Jul 2026 12:25:15 -0400
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 667FTiDP3996643
 for <qemu-devel@nongnu.org>; Tue, 7 Jul 2026 16:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 dJgCSK8xB9JQdXMqPg3CtYne+eAwQs+MLPcl9/hYUfk=; b=EpM1K6V3AQ/ZwrdR
 2OZOLIyW0uL1cL0SuOTt6rJQHvmphrf636fA4V2zQP8gnyvF15gduKynnXSrMqS2
 c9wScqQmOdQ+FOrRuUEuXp5gHXtzmlYmWJfECwm0cYrzTLQuQGWqhYasR4p6Tl8J
 2IK04BwbKk86I5Y8Urkq0+LwXT4B+vRymUNlykWgip1zncf6EH4YyKX3KSxJGaap
 WmJe9idl3hVU7qoyN6ISRBKAo0aakoihkC5IYH1RvXof4HU7rENt9EzFr6GgMinw
 4fiUApXi/GFaBVtu8OVZJ+ySJ7DUlU2NdiZ7d4su8dU41h31hHO00zCWkzmve4Lv
 vn/q6g==
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4f8su72xu2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 16:25:12 +0000 (GMT)
Received: by mail-pg1-f200.google.com with SMTP id
 41be03b00d2f7-c889d1eebafso10607599a12.0
 for <qemu-devel@nongnu.org>; Tue, 07 Jul 2026 09:25:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783441511; x=1784046311; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=dJgCSK8xB9JQdXMqPg3CtYne+eAwQs+MLPcl9/hYUfk=;
 b=E3KxrZeD9sawhsg2jDAvaFXGH8wy6g/UcgGAKjkOBOyx4RV2+QoJtlo26QI58fZppc
 iUMgUy0/kVfJeflIDrwZ4jyiVrceB3E1IyMTO8Tqz+pMT36amDdCTbDHgXgcVxS4D/uo
 7Xl77mu9f82wE0KnobsWvIGGbJ5khob9BXWZ7SbqP/JXsKwr3wxTgDsgnNAIo9En42cK
 7ZRTTJEPq4PNFcJ7CUVCO+FjGTWivSSxbcG+U5J0Prw6ddssMVaQcAtIVsEvQbk5Hq8v
 rwsxh0u24+EQfTwrov1twRWg547mNxXEfkkJ2wCEE74s4dGvTtHgejh0ImDrknCx3bJA
 PGng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783441511; x=1784046311;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=dJgCSK8xB9JQdXMqPg3CtYne+eAwQs+MLPcl9/hYUfk=;
 b=EUZMojQdyK1Ojpfp85TW2bQfliTWdiqf+AbIsUyn9BGmwvYoL0CLXApRBUVl4Pi94f
 8+0QCuRzyFjHzI0SH3u6glUx56baTif8V6YxiUi9YrSfC5Pm+lfnJrVzPHBkHbswnUBp
 I+aFzl76bGyViBRb2H4I2xcs89FnQQSL4k0ZAYweurS6XFqX7BTKQjDScAr9+vL4DUj0
 W8UtcwhV7l/zc/CA9MUHSm1+Tx3zdEGBe6FBFt7IqQTi1Qf931bKoM7mpJUBVNTAdN65
 MivA5qqXyQ5vhfCiFPv5P7fYgzflDmJTK1QyDfSGZJeQMj2DoLCsGJdRI+wxFMUHeGa6
 xJag==
X-Forwarded-Encrypted: i=1;
 AHgh+RrFAhWc2zPO/qlGykQ6nL3bIKNupa5oEDRdkCHlBWrPW00J3tgaf4pwSH9s3QtOehPVODlrlnEdqUgy@nongnu.org
X-Gm-Message-State: AOJu0YznmUnB6pr/HV+zptGD0e63aev6S7kfY1ZJu+Ldl/qsgGvFYItS
 sTluNj1pGLi7xC+zQF8iRdHu44IojpLY65RIGi+ZtFOg/rGMHBBG5IbHW7POfp+kMyCR7nr4B+z
 0xo450ZQHper5zGBUesfoAc3XGYM0oZca+sUVvSgVwgp4s2okoWJQF0S4pw==
X-Gm-Gg: AfdE7cnRM2kkf0AszJrJ0lAvcaVdQQLf9Ccg1iiOXbscVpgoHfB7SrSnnCTTouKkGGs
 N0Y27IuyiyazQu7lJAXakC3zhR1k3ZsaY6I+4JDlvvpQD+ANTEFJHHHAQuGmlFypvXMfbsZ8i7A
 9l9jFRXNI+YINwTELmoKr5LDPJYA1oIXAtmm4tgZVGb5TE+AJ6sIxMgjfUCSwRoOflgEuCekX7v
 Qc+iLsyxWxGxr954uBu1sNG5VFuxgIypDyNPNpP8rqQoLqT3CCgc3u03Xz1f7I0qd0yWrAWpI52
 cRutk/Q7d+NA8zO8BiFbROJauo98VLTCUtDkAxVCUyCHoKhiNanIkYE4g5hky5izUvVeHYuPfqq
 BHWSTLyp1gsvHswQLgEdF58w6HWqQtWNbjnQ1P250uJNODwHvXOSTrtmHDPflF7CuOLNUV2adti
 bQ3XI=
X-Received: by 2002:a05:6300:4c:b0:3a8:21e0:1ffa with SMTP id
 adf61e73a8af0-3c08ed577b6mr7510595637.27.1783441509672; 
 Tue, 07 Jul 2026 09:25:09 -0700 (PDT)
X-Received: by 2002:a05:6300:4c:b0:3a8:21e0:1ffa with SMTP id
 adf61e73a8af0-3c08ed577b6mr7510562637.27.1783441509251; 
 Tue, 07 Jul 2026 09:25:09 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13b659c8665sm10067583c88.10.2026.07.07.09.25.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Jul 2026 09:25:08 -0700 (PDT)
Message-ID: <7148b2c9-8874-4e9a-9217-577ffe8432e6@oss.qualcomm.com>
Date: Tue, 7 Jul 2026 09:25:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 69/91] tests/tcg/ppc64: remove dependency on
 qemu/compiler.h
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20260706223343.988769-1-pierrick.bouvier@oss.qualcomm.com>
 <20260706223343.988769-70-pierrick.bouvier@oss.qualcomm.com>
 <c9854a25-5b80-4c8d-a86b-ffdf118349d8@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <c9854a25-5b80-4c8d-a86b-ffdf118349d8@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA3MDE2MSBTYWx0ZWRfX6rdTWBrKdHkJ
 kNwqbPhM6eDFEyk+rxOiVIl334toLIxAXU9VLJDBJCsjEd+L9DdCoBaHhyLbq07cWhXe5Lbsihr
 GFGArJfUH8I/KBpjD1FZI45s+jQWecf+MC1/UFaJBRgiHLD9P8bilrrFCh5sT1J/9skntiHQNFq
 2WG0i3pDumyxk4+/OFuqrkrR92aHBwPfnoJU4gM0gbdYvcb4pRl5+IGb3vlY3ULrM9HBs+cw1GL
 pcRV1S2ZbeUcI7bXMyFTPmPZr8VLrDV/6VKC2FaMqGEgGc1+03wixuoJvaVFcOZNYbEBvI/dcmO
 o8ND+yWa8GYFt/tyLH3J1aEeXCb6bUT5KGT3hLdcqKEzzP5J8AwyMHwM+pbG7t9Bqqd/8KJh15e
 1+1RCsUABiTBFBuXAUPkRs0JyoVbEHFzjeYIZPAQ8JeZTNm2MF7PnzhRkRoidRd/LEi/Q2tK+uv
 Mxy2D7oPM7jVzK59i9g==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA3MDE2MSBTYWx0ZWRfX+v1bpZO9MURq
 6gyFbyT4Zr/YZNz+tpKZlqH7+Jdwb8FgcpXI/VZDajGYH6y0Ze5hcsdDVJtMKirBbogy0wXXTM+
 5g4no2zF3Fvk7yyw2M2APk3pACPRmgw=
X-Proofpoint-GUID: rN2OAnr76t1CLeopztiueyQxWfiwi_fJ
X-Proofpoint-ORIG-GUID: rN2OAnr76t1CLeopztiueyQxWfiwi_fJ
X-Authority-Analysis: v=2.4 cv=HN7z0Itv c=1 sm=1 tr=0 ts=6a4d2868 cx=c_pps
 a=oF/VQ+ItUULfLr/lQ2/icg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=DJpcGTmdVt4CTyJn9g5Z:22
 a=EUspDBNiAAAA:8 a=Le1lVUgQC06OxuFoSpAA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=3WC7DwWrALyhR5TkjVHa:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-07_04,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 priorityscore=1501 malwarescore=0 adultscore=0 clxscore=1015
 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607070161
Received-SPF: pass client-ip=205.220.168.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0a-0031df01.pphosted.com
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

On 7/6/2026 11:16 PM, Philippe Mathieu-Daudé wrote:
> On 7/7/26 00:33, Pierrick Bouvier wrote:
>> Replace definition of vector attribute, remove unlikely, and detect
>> endianness from __BYTE_ORDER__.
> 
> Why remove the dependency on qemu/compiler.h?
> 
>>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>   tests/tcg/ppc64/vector.c      | 11 ++++++-----
>>   tests/tcg/ppc64/vsx_f2i_nan.c |  7 ++++---
>>   2 files changed, 10 insertions(+), 8 deletions(-)
> 

It's the only tests that use this, so for consistency, I think it's
better to not make special rules all the time. Also, not having this
include path by defaults prevents anyone from having the "good" idea to
reuse any other header from qemu in the future.

What do you think?

Regards,
Pierrick

