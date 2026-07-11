Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77D3AC44501
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2026 14:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiYWn-00055Y-Py; Sat, 11 Jul 2026 10:18:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiYWm-00055K-B4
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 10:18:00 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1wiYWk-0000Df-MV
 for qemu-devel@nongnu.org; Sat, 11 Jul 2026 10:18:00 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66BAo1gQ3604009
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2026 14:17:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 IkTPwBujc3bcPBobJBiyfKk9qLW8wgCUCnI79+jbQv0=; b=mYLc/QLqBqlAXtSG
 FpVFRiKMNcjChCa69sHehCmmsu9sZZgPdevw1e5RQqZP9kBEdIdCk4dwDFYnCGRB
 eihyZv8i/+tEBIqQSATm+cEV/4GkCoGTx/B9tRt0D2SMaGuXj8Gwwmmjl2sRse6z
 SZA2zdYzcIWTjaAvzAGAyl2bVXWsPwKj3W3CSUzCvgR+n9/NL3kWJ7J398LUJaLM
 NHWpW00jq+3ogS+QH5EntlnTg+hndguHKb9QBoCt4x7j7jKl1MJo4SroJ4PH60+E
 9kCLmvQ83yw5/7BvatBQZv5NsyU0oPZN0jAfSECxU/vkVzqYscj6gllV7PFGDdxd
 wJKsVg==
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fbeehgxu9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2026 14:17:55 +0000 (GMT)
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-51a87ef9713so31154941cf.1
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2026 07:17:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783779475; x=1784384275; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=IkTPwBujc3bcPBobJBiyfKk9qLW8wgCUCnI79+jbQv0=;
 b=KX3OmoYrW6kUREOFF5w1izmro7rNn/GHrxP7wI1K+KjSej3i8UB8ItBFpwXTuI9fe0
 7LYIm2STAqFKc8tCGKzhBiU2RpmmtIEVLES8+xwBPm0FvI1pe8x9sArhP6YXCanvmpb+
 O1/kpOIt8paCyJwq15kVrShIJNxe3Cx11cEf9ClabckWRdU2wOHgobxAoyTbNjM9WdS2
 J4Q5Tryq0GAwQvRLPWvxiNh/tmAwD3XfT0NQjGlYEyN3/ul61NhxehdwnXxg/leAOpYh
 sozBF28ev6xd4CU3eCjG6wLyzzFk+oqvWIb8MkyaFhB7svNjA1M3q6Oj7OM/TpLEoiMx
 +MIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783779475; x=1784384275;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=IkTPwBujc3bcPBobJBiyfKk9qLW8wgCUCnI79+jbQv0=;
 b=fvUnabhgAGcuhUpqOgUmBVFnZTV4Z2hGBTnU427LgX3bNMbl0vVho4lTXza9PPRLUM
 Sj5OPuvpg/w6ZMIqb0OVCx9dwzGXNlMBjRYet45yXFBs31abSrnL0gvxxhmscOYijlWO
 /jiw+7M3oZyTw+z8of2SBYGprcs3CRR+x18WSSckJecC43O7snVok+66/SFGcYPVHkGJ
 6eHP7WhQ6/s96czmIDoEcfi0YVY6DhQtpXOv8+a1xq/oaHRwqpdpiFLODkBVJ7ekVvWB
 xBTBIUkyvOkF7IgL4Llh/IhCLT8Z/QsnGr6nrUUMrBSpR+pTw0VkxFSjJ46w+nv391Is
 cvgQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrQNDiad3znTlK8EgSnfQD/cR/XCajbEMI3yoezPMEXJcrouSOxq3XT3ypeTBmYW3ZMUQIMjBUA8UmG@nongnu.org
X-Gm-Message-State: AOJu0Ywn1E0BfO/5nMTKlPx6YTBpEzvKES8ZkG1+FejUNPxZPOGwsMGS
 gY1XPFbmrUk54lNeRGstxvFpZQqTemAiSkU5QtDilKAXxEX4oa0YglHXMcaOljHl5Fb78r8nUhg
 df5gltXGL3cpygTnetFnaUA7b1N1/TAOrJqO8v6e1QH7sIOfsZpT5A6MBBQ==
X-Gm-Gg: AfdE7cmAO/LNbDTw1PoMLCMMO9JcaCQMmUnvg/StN0S3ei+WdpkG+kGcwWWosGuMwxM
 6eJ79zx0ZTUzC22F0AJ/xPMnyb+mz8iUro3Dm6JJSfNZmK9+4leSQMdNw0YP4Zz3ADefEkRUN2/
 9Lw2GG+zAotcWdXYIKyFVwHgENw5j4idKWlShO7O9YxBJgrqrrmh2oV+XGWUWvVs44HXdoAk0nY
 3Itzsi91n/jIYoqa2tfHCJWrXaJxPuZKbnNMcCA63Uk9i0HC4Eszhh/RlpFeg5blYK/vFAOG2K7
 6anVqBAUjt7fyhLcDYQPTLn1wJR/5T159vbhAe0PELVmD6i1o7pkKyB5+5Na6tvc55AQOSC9/k3
 vnGx1kObQvwQUG/HReAepzoQiNmH60hzDFmwLzhBiQ5ldE7IPnaecOHu0PFIB1w==
X-Received: by 2002:a05:622a:13cd:b0:51c:98f:f282 with SMTP id
 d75a77b69052e-51caa1286e9mr74726291cf.27.1783779475267; 
 Sat, 11 Jul 2026 07:17:55 -0700 (PDT)
X-Received: by 2002:a05:622a:13cd:b0:51c:98f:f282 with SMTP id
 d75a77b69052e-51caa1286e9mr74726011cf.27.1783779474866; 
 Sat, 11 Jul 2026 07:17:54 -0700 (PDT)
Received: from [192.168.69.219] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47a9de1e736sm74202814f8f.7.2026.07.11.07.17.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Jul 2026 07:17:54 -0700 (PDT)
Message-ID: <7f61b5f7-38a4-46d4-ad3e-2d70349475ea@oss.qualcomm.com>
Date: Sat, 11 Jul 2026 16:17:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 51/98] tests/tcg/hppa: user tests
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, qemu-devel@nongnu.org
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
 <20260710214343.2065491-52-pierrick.bouvier@oss.qualcomm.com>
 <eac788e5-bb7a-4644-8355-110975562531@oss.qualcomm.com>
 <a57b4879-b850-40de-a665-089b897b98a3@oss.qualcomm.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <a57b4879-b850-40de-a665-089b897b98a3@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzExMDE0MSBTYWx0ZWRfXw8n+fx1b7Oc+
 IYeBa0KzsJqc+glulGirf0WU8xGPo666cP0kZA/dzy4eAW2kdpXwrqoon8u9ZIE0gKgprNPSL3D
 UiaaHVX0wS2wv7e0XPBgM0ef9Eo11cg=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzExMDE0MSBTYWx0ZWRfXzBuLjx0iYMz5
 tYDRT1xyeII/6XNazGXY6xKABvKP8k3M5K78yVa6+H0acw5KgkDynFEy9MZuWzNho26DX3QKRTg
 dVoix3Kd1+ZL0EQtixaBu5wjWch2EBnrVRSGf4Z2D6YjtwZBT6jxV3nmYKNzAoqAvOaN3GDg8ng
 lHHtpAKtxpK7xv8YQ/phmfl7CMdRTCRaNqnJHhZnBpiJjrdO3R8Ao73KEtmjNZhgpwinqHuFJDV
 1+CdJdvJpzQ+rzjhUF1+cSum2CwxA+GLtxQOugXxxgkRzXj+sAuBLi0OGTcdqubvtyF+gBhw9WP
 BJvUP4fKxUYsYO6BvFV1QNXU0UGbQbKSaWHKGGNNVXpO8C18zCqqg3S8i0HCTCxLDErcMBrk19q
 G63Bh2VyhPXnN359CipAJ0wqU0y0U0R9r7hKPwkPi5F+LeDPng4YFliebbtoYych83gvBHTCKVM
 ogQJBO1FL9sV+n0MEYg==
X-Proofpoint-GUID: 9tYf-OuGL8vGjnFPXLQQgiwyCDnBjVV5
X-Proofpoint-ORIG-GUID: 9tYf-OuGL8vGjnFPXLQQgiwyCDnBjVV5
X-Authority-Analysis: v=2.4 cv=aPvAb79m c=1 sm=1 tr=0 ts=6a525093 cx=c_pps
 a=EVbN6Ke/fEF3bsl7X48z0g==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=TIKj5AyxKjWiKhh4rnkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=a_PwQJl-kcHnX1M80qC6:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-11_03,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 adultscore=0 suspectscore=0 bulkscore=0
 clxscore=1015 priorityscore=1501 spamscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607110141
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

On 11/7/26 01:15, Pierrick Bouvier wrote:
> On 7/10/2026 3:24 PM, Philippe Mathieu-Daudé wrote:
>> On 10/7/26 23:42, Pierrick Bouvier wrote:
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> ---
>>>    tests/tcg/hppa/Makefile.target | 14 --------------
>>>    tests/tcg/hppa/meson.build     | 22 ++++++++++++++++++++++
>>>    tests/tcg/meson.build          |  1 +
>>>    3 files changed, 23 insertions(+), 14 deletions(-)
>>>    delete mode 100644 tests/tcg/hppa/Makefile.target
>>>    create mode 100644 tests/tcg/hppa/meson.build
>>>
>>> diff --git a/tests/tcg/hppa/Makefile.target b/tests/tcg/hppa/
>>> Makefile.target
>>> deleted file mode 100644
>>> index ea5ae2186df..00000000000
>>> --- a/tests/tcg/hppa/Makefile.target
>>> +++ /dev/null
>>> @@ -1,14 +0,0 @@
>>> -# -*- Mode: makefile -*-
>>> -#
>>> -# HPPA specific tweaks - specifically masking out broken tests
>>> -
>>> -# This triggers failures for hppa-linux about 1% of the time
>>> -# HPPA is the odd target that can't use the sigtramp page;
>>> -# it requires the full vdso with dwarf2 unwind info.
>>> -run-signals: signals
>>> -    $(call skip-test, $<, "BROKEN awaiting vdso support")
>>> -
>>> -VPATH += $(SRC_PATH)/tests/tcg/hppa
>>> -TESTS += stby
>>> -
>>> -stby: CFLAGS += -pthread
>>> diff --git a/tests/tcg/hppa/meson.build b/tests/tcg/hppa/meson.build
>>> new file mode 100644
>>> index 00000000000..9ca8f29fa93
>>> --- /dev/null
>>> +++ b/tests/tcg/hppa/meson.build
>>> @@ -0,0 +1,22 @@
>>> +tests = []
>>> +
>>> +tests += tcg_tests['multiarch-linux-user']['tests']
>>> +
>>> +tests += {
>>> +  'stby.c': {'cflags': ['-pthread']},
>>
>> Should we mention the 'signals' test?
>>
> 
> It passes this torture test on my machine:
> ./build/pyvenv/bin/meson test -C build hppa-linux-user-signals \
> --repeat 100000  -j 256
> 
> So I would be inclined to give it a chance and let it run by default.
> What do you think?

HPPA vdso was added earlier in c7bc2a8fb14 ("linux-user/hppa: Add vdso")
but maybe not as "full with dwarf2 unwind info". Personally I'd add it
but I'll let Richard who wrote this comment to decide.

