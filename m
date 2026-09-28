Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1BB9CA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 16:23:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBE8D-0001J8-Ns; Mon, 28 Sep 2026 12:23:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBE8C-0001Is-Fd
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 12:23:08 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@oss.qualcomm.com>)
 id 1xBE8A-0000bH-So
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 12:23:08 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68SEe2VG1498408
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 16:23:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 XBRUbalEuVSBMAsgaXq5YW8pHpXIUy5r9Hqlqefs7BA=; b=LzInmiNP8TjoSY6t
 zpfYtdkasuempYoMRdhMEhr8613SWsnL01d6a8POIF9TiZ3SikwY7fn8Ma3yxVNi
 MVSP4HuAXA8rqsaB58tYwxTNV0n+WqjpYIpeSglTxmvYRCnHjuDNa+fTwjU6kXzD
 bQlXvxzUPSlVpGSHeQr4njjP6iMuqIIMAdn0zeYfvuN/0OpHOSSOd0UgDRYwO5nx
 dyPxvAPTeT0Yn9k+4QL8sVisbjXbizp1OqSvMUBVVWRug0x+xUEx6autlyof3BkJ
 TEeJg7fA9CValYYrXP54GlWISeTkSurK+uPx7Zc8M+JLlf7zqM7mwqMx3VSdeHGL
 z1u0aw==
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4gyk5mt8dx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 16:23:05 +0000 (GMT)
Received: by mail-ua1-f71.google.com with SMTP id
 a1e0cc1a2514c-97e9e1dd7fbso2629893241.0
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 09:23:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790612584; x=1791217384; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=XBRUbalEuVSBMAsgaXq5YW8pHpXIUy5r9Hqlqefs7BA=;
 b=cC7gSYr2/ualqOEvXtLkVSbCsPylJ/Y/UBlQ/W5kyLfuZs5Q3OxtyQvi9KVIQq/F3B
 O2WlPKAh/FvNiNgYCXYHQ1Ap0XQEz9VfMCbs7I7vuYVHuB7XgttTOKpnYB3dYN3hNWxp
 Tr6rKSjw+VIXqOuKF5pkJU8LS/zhn7OZWbrhrmUx/NeI6gTkj5NByR/rC2kUhTWWbGaP
 S1Eln2svio/coRY1OhVX52swVugEoo34KJRhT8BotSi2uAhkFtUkX8XK55lgKkD23mao
 A6zMYnuVkgwqr299kh4nzSjwqDc7/Vs2RLY1c+U3bpZ2pDKthESGkLJi6os4vHjbEx+Y
 C/Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790612584; x=1791217384;
 h=content-transfer-encoding:content-type:in-reply-to:from:references
 :cc:to:content-language:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XBRUbalEuVSBMAsgaXq5YW8pHpXIUy5r9Hqlqefs7BA=;
 b=Fav/S8/pa5GosXe9WWinpZHCIumPNcuUCFxKGW4hl/IUmoOxBRJsFM4sSQomO4OnIb
 o9ez9+5YmvuMf9yUZvQuXRtY1Q948har+Ldm1HxdI/CXra86v7/BbWPhPU2BTxbuaJYS
 HS05kWHsxD1qK9u+zdbRsyBMMtgyy26seAVhl5UjSb1/qYSXPAPjxm7pdguu+/r77wZf
 xN021XeW9anaiL+1QiVWZ09RDoMq8JIp4uP2nCWw8dxY8LFF1/8ZC1PqYA/kt//IYr+Y
 Lzso4CW7hMLpN0fZFiBDiTsZOD4hDbogTc/TcOCQBfNeYZOzf8r8DpI5SAhNJprXLAEO
 VFTQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBz8k5rHRUa75T86RVibKo/OdcBSiTUkJe05tr/gAr72Qya8pXmtmXUEZgZQ+AJDOq54KW+RJgjfEmWj@nongnu.org
X-Gm-Message-State: AFq9FYIlUjUkrMBowSvX/xaMwOaV++e3p6yz2ojcV91eSx3nuB738Xhy
 f6vJUeSj9rrlI+73IzAconKVdfGibUFwKnjrZZHgl/s61DUT1fF0QHkU7l7k5jexul5mwCSx8wL
 ZVzmxUnju+ZoZbyvVY92SUZ/5uPTJlb1JKsfgrhzH11NLTKHnwoZ8YUn8rg==
X-Gm-Gg: AYBFou1wawcu+dfNj0Au9WF2hQY6P9KrQVbnLO8rUdqjptqGZNb+ExXDSVtrEJAQmpX
 K6vqTzIbe60kFUxbZVU+l25fzTtdKKGIweoknUch5Vn6cB20vhj/Ct3Nm5KXN9oBxaeIElCuEHV
 T/QXJ0P93PWyCgFJsEHp6prf+2dDaA1BFYuK59AKEYjJJGhbHHI6qfEGKPc40J5XWTM9FOwv0PJ
 0JGbPHqf4lZstDJY4YHoyNNpz4jz86OAuvka9TgNo9YNn7jShMVpuC4eRTHaS+AYaSca1mcuD8T
 LIN5Zb4FcisSdi57FMDMyj0YlBYwUBX9mZSGKvxWe3tKaeMb+eBrc97UgpTEInLBDQZPL3A7jtc
 kVisUlIiibIrbCGUTjUT/whagZf+E8h6hUQ==
X-Received: by 2002:a05:6102:3f0d:b0:7b3:4199:2dd7 with SMTP id
 ada2fe7eead31-7b341994399mr2733206137.0.1790612584408; 
 Mon, 28 Sep 2026 09:23:04 -0700 (PDT)
X-Received: by 2002:a05:6102:3f0d:b0:7b3:4199:2dd7 with SMTP id
 ada2fe7eead31-7b341994399mr2733199137.0.1790612583940; 
 Mon, 28 Sep 2026 09:23:03 -0700 (PDT)
Received: from [192.168.69.225] (pmd666.hd.free.fr. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a00cf86859sm3457045e9.3.2026.09.28.09.23.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Sep 2026 09:23:03 -0700 (PDT)
Message-ID: <963c0d5c-5c6a-4e79-9825-5cf2ee2c50fe@oss.qualcomm.com>
Date: Mon, 28 Sep 2026 18:23:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 002/101] include/qemu/compiler: Define QEMU_ALIAS
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: mattst88@gmail.com, Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260927090011.10724-1-richard.henderson@linaro.org>
 <20260927090011.10724-3-richard.henderson@linaro.org>
 <9e71b3a6-4afb-4208-a6a8-9c100775b061@oss.qualcomm.com>
 <c8448194-1576-4b5d-8d85-5d594ff26c09@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
In-Reply-To: <c8448194-1576-4b5d-8d85-5d594ff26c09@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: JV_CqJsqy8gBDnyFkaB-uRlez_Tb1mQa
X-Proofpoint-GUID: JV_CqJsqy8gBDnyFkaB-uRlez_Tb1mQa
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI4MDA2NSBTYWx0ZWRfX3BxtW47J3h+I
 d9aG7nZYSCOl/d33jnLZ9n7QnuOz7C0HCHanTy1Bl3+FbrN4qUBT4fSfonNuta1aJ/QDSpp0u3k
 lfn+VdQGeTRvawUYa50wVqTwbC2OKaO8MA7oGzlBMGTNpukws8jcYEqEE/IS5e0xQzhEfDN5QT9
 oGYQytNt7L2ya+Y51Wto/lE1IoRNdxEBEGSTE99nMGxPe6YksCyN7xnTbX9uqvv6GEGepIdQwT2
 pIrqKy0E+kiwEZ7P0rA9JeGzCYqdBCWTICFK0Zg69/JONxE2paBBII2gsmRKCsR1YUKOAwC6HDE
 FiipBoSfKtfYK0h089/nuCk7wg1ICq1AcHiLCIy0uQ6lO7pgbXjOauHyw1J3oBLA2UaUxAUwdzb
 X7ML+KQAqYhmn7UMuE1694HBQi9SXGAdnvsMMbUAi6OW9Bn09DzfDE4B71t5kzu4ZQHq20dHcQK
 E8TBnZSJ2XtphgB66sQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI4MDA2NSBTYWx0ZWRfX5a8HOQQe9rG7
 7zZOBTBEB93t0ZlvfnTDlW7EtSWKkoJULJQERF6rwsuq676Y3OugwS9w+5s/4vIrsz3kHvI7RKA
 Krf/TPmwBJKYOHz4tJHu5VyyzSIiTmM=
X-Authority-Analysis: v=2.4 cv=asYnmiZV c=1 sm=1 tr=0 ts=6aba9469 cx=c_pps
 a=KB4UBwrhAZV1kjiGHFQexw==:117 a=4s3hRJSeHn4rkQlkrse1kQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=M51BFTxLslgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=Twlkf-z8AAAA:8 a=KKAkSRfTAAAA:8 a=EUspDBNiAAAA:8 a=dkWDCtPVlL_HdN4M51UA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=o1xkdb1NAhiiM49bd1HK:22
 a=-74SuR6ZdpOK_LpdRCUo:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-28_04,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609280065
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

On 28/9/26 00:35, Richard Henderson wrote:
> On 9/27/26 08:51, Philippe Mathieu-Daudé wrote:
>> On 27/9/26 10:58, Richard Henderson wrote:
>>> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
>>> ---
>>>   include/qemu/compiler.h | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/include/qemu/compiler.h b/include/qemu/compiler.h
>>> index 3661dc5fbaa..8fa4552ef8f 100644
>>> --- a/include/qemu/compiler.h
>>> +++ b/include/qemu/compiler.h
>>> @@ -230,6 +230,13 @@
>>>   # define QEMU_UNINITIALIZED
>>>   #endif
>>> +/*
>>> + * Alias the current function definition to another.
>>> + */
>>> +
>>> +#define QEMU_ALIAS(N) \
>>> +    __attribute__((alias(stringify(glue(__USER_LABEL_PREFIX__, N)))))
>>> +
>>>   /*
>>>    * http://clang.llvm.org/docs/ThreadSafetyAnalysis.html
>>>    *
>>
>> On macOS:
>>
>> ../../tcg/tcg-op.c:1820:38: error: aliases are not supported on darwin
>>   1820 | void tcg_gen_discard_ptr(TCGv_ptr a) 
>> QEMU_ALIAS(tcg_gen_discard_i64);
>>        |                                      ^
>> include/qemu/compiler.h:238:20: note: expanded from macro 'QEMU_ALIAS'
>>    238 |     
>> __attribute__((alias(stringify(glue(__USER_LABEL_PREFIX__, N)))))
>>        |                    ^
>>
> 
> Bah.  Ok.

Otherwise for QEMU_ALIAS idea:

Reviewed-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>


