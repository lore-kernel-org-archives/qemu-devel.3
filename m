Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C1E1CA6017
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 23:10:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xExFh-0002BC-7r; Thu, 08 Oct 2026 19:10:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xExFf-0002B3-3S
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 19:10:15 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xExFd-0003eQ-77
 for qemu-devel@nongnu.org; Thu, 08 Oct 2026 19:10:14 -0400
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L01GY3151749
 for <qemu-devel@nongnu.org>; Thu, 8 Oct 2026 23:10:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 n3b4Pi90dz0PhxNdTXtW0NigxRDtXBmCpXkaWH5jvnI=; b=AStsCBdQ7ulj2XbM
 9Yi765HXVZyUhei1stPJei48FS5TCQP6/2M45OD6GGfTPiCTNExIPpmZUP29ZMYH
 /cl93lc7iCnBtYDF5iJAbuIjGrMx0v/RECgYmv78MO4QhNJGx8zhYaO2j3QaYYCP
 KBmlmvKIrr4LqbgZ+IHszfaXFheG98gFErnl35Tzzm71xTnTlhEpMmNhnEDV3yZS
 I09uVvZO8jvPvGprObWUA+3VZU3ZVbHRKyN3UiddGTWpiW4zP6x1EGwlzEKj5xLr
 O8IuAZDWLBUGOAwsZ36QAu+6ByExAoNhdEZL/urwUtGhAjEZDUU9ujuoPBlArX8l
 VVmtqA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h6fxk109h-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 23:10:10 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-30c0d568830so12299928eec.1
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2026 16:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791501010; x=1792105810; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=n3b4Pi90dz0PhxNdTXtW0NigxRDtXBmCpXkaWH5jvnI=;
 b=TuITrhLYV9rstVg9Vbx/gQ/fmI22weE26jau65ZJ0/vlqPOmQaQDApEKOXgyqoGLJn
 eitqwwtBL1iEoMz1f3XHGcGgC+7+e8hfrZ0GRU13lMs+h2t4G3uHQcVHekoegl1EknyB
 nTMfq4QXHB1niJI1jEkqIHiwy+0PviGG5qyWQGejPZFwuTJbiCBAs/3awo0cfSxH2SST
 227lNbHgOEmEhU2qW2kb4ZBe+zz3Q25DR/J6pdRuIi48HepLRyobrV9mk9jk7E64uC7Q
 VW/0QEiXQCLuYIp47aoOO7txdPJrDSIIhGVV8gsrOGs9sbYzHG5ZYGrL9CzaG6YQ0m6U
 slxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791501010; x=1792105810;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=n3b4Pi90dz0PhxNdTXtW0NigxRDtXBmCpXkaWH5jvnI=;
 b=aXu5/G5E4raqNrBjjzerXgQHVJWVubUCepFZC81Nczk64FmiO01tOQZL/32p88vwT4
 RsMV+J/8BwP9YNbtS1vQC0sZ+Xzk+LGopO9z1r1oLW74m41d5MRu0FPWAEpct4yLdhCv
 tARwpVSWi6EcgLqUeXifG9R0ZDgstAAaCHmAAKgtxfWmn0DdW0hCnUVll1g2mLHPFsAG
 ITgfzaAMSLwC94YaqxMqw2ycMKfwCyeQ0msI8MqXyH1RUJLLE/7t2R3a+Q0ftMSNJ03c
 Iaq789c51XxcFmU4N6PnahbgJJ4xYftP2lY4/kK2vVXzitbzf0FcxpnETVM1+i9FmcP4
 0xpA==
X-Forwarded-Encrypted: i=1;
 AKwUvBz4F6n1F+rjiD6F5Pu4SiB2O0oyxZNDAp0XTG99xADVdBhm9rCzU1Qt++HLTJAsG3BAXXppms/YV1yh@nongnu.org
X-Gm-Message-State: AFq9FYL5jxTg/sGR7O3RJ1wVJ8SqApI/mHWNPlK0R/fmYpQbG1AIw2uc
 9UDzaBRWQof9+GIsqWy8HRQoQILUOf7waa5PMvPZwXeLHaC4nscfJ8e5SiBQ0mzQy4KRQvhNMjV
 T+EOj5hj+vFfcmKP04m11QyFzyGRVpFaE69tjSOpgG6MpXuuAKK7l9Rm8gA==
X-Gm-Gg: AYBFou209weE6BdwpBXQEdJ0DEyzzEquBh0BtK9s4QfX2n5No4deN9HQVfZ1ILrK46f
 rZ5Fj2nWZsivRIe70KCVb3xJTPWEnKor7sVIJOP5ZLMVZxsGZWbdhp4AbkcG7Y+fCwuKHIwQfnA
 1Ug0qDpH2gB+b3SnGbR5HY/R3WY1SJj0mYlzU9sx2h7GEqUZbInuevkDR16aD8a+pip4qAb/BSL
 iAY04+u4lWcDOebleAiNog4qT15126qacN26UgusDj54j9qhrdk4QQpQZln/95AeLdCECpSGcn4
 Bvznh/IFcV3yGS1yoX3lec/zQRVqOfG9xF91mKkLQxZLiMFRUuqb01hd1kiviwS+uMejUixL/tV
 g27ZtQvR+3PioVPERTc3gOycYPLhKdiLXnEZPvQlu0SZn4YnO7qBGEt61LzdbT1c0HR7pZg==
X-Received: by 2002:a05:7300:6c9e:b0:33c:e82:70c9 with SMTP id
 5a478bee46e88-3537e252b4fmr579220eec.32.1791501009530; 
 Thu, 08 Oct 2026 16:10:09 -0700 (PDT)
X-Received: by 2002:a05:7300:6c9e:b0:33c:e82:70c9 with SMTP id
 5a478bee46e88-3537e252b4fmr579180eec.32.1791501008955; 
 Thu, 08 Oct 2026 16:10:08 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3537cb68e56sm1050978eec.29.2026.10.08.16.10.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Oct 2026 16:10:08 -0700 (PDT)
Message-ID: <824d02f5-b9c0-4a3b-a31d-d34f8cbfa5c7@oss.qualcomm.com>
Date: Thu, 8 Oct 2026 16:10:07 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/4] target/hexagon: pass the packet PC to lock
 implementations
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com
References: <20261008211005.1853542-1-brian.cain@oss.qualcomm.com>
 <20261008211005.1853542-2-brian.cain@oss.qualcomm.com>
 <471263fb-bb06-47f6-83a9-764e603a7a68@oss.qualcomm.com>
 <6992a79a-96d8-4b73-8552-cae7d8102b17@oss.qualcomm.com>
 <b6fdd824-499c-4a4f-aaaa-04881381703b@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <b6fdd824-499c-4a4f-aaaa-04881381703b@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=fKesTpae c=1 sm=1 tr=0 ts=6ac822d2 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=YMgV9FUhrdKAYTUUvYB2:22
 a=EUspDBNiAAAA:8 a=kfRiH5CYyC6UmECoNLkA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-GUID: ujVeHurbP9Dn6XAu3oxs0OsF_pRrhBRq
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA5MiBTYWx0ZWRfX9y2A+8uR+trT
 EgkEhnvV1mCZVXBsmJp32ka2+YYxCoH8Rh8IIZFdeiATNvnjkiDffkcNWOZzBZQsXXzr7wyBNCD
 I6nFYg9473AYrHHBgcydVmSNkGZn91s=
X-Proofpoint-ORIG-GUID: ujVeHurbP9Dn6XAu3oxs0OsF_pRrhBRq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA5MiBTYWx0ZWRfX4JKHvEUSoAS5
 amqUS+0uykwHOwN0nVNW0dyNWaxPa7cdrHmoo2E+PTxYBXiW+s7WFlXtpQ0MCxhVrSz0P4YPXfO
 fWKMGY1TiVhZ0D5UMZ0cGtks3cUR54oHSGKDRWvrORkmRLymf/Xi9mUMb8aUPqQ6nrmCW0pfe8o
 j+gIfgj5RTFsUO0hrRQPpm3TRlQdeIlod6J9QukXzATzIOj/o+RrZsKniytDoSXXIfJZCuIEd8z
 1OuWEx408XSl/j3B9jEP+UqTqv5fkeOn5e/PiYvLux0Zu23zoZFS2ShZJrU9dQeZ/axuHT3BPEy
 WCxOkzZZAJ5Y4iGb+nk9kdnnLiGuxawg/qgIkOqE0Utw6/K5dZao/PlTHrmv+FUidIgJ919Sl2N
 FPV54DB8xRIzSHw+l6x236SQ8W0eF/BLidlX7EIc0PVkVpNsRwwaIccmmMLiLBEWeD7MZMJoU+L
 tUlCnH0YaWvXSNMkIsA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 clxscore=1015 suspectscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 bulkscore=0 lowpriorityscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080092
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

On 10/8/2026 4:02 PM, Philippe Mathieu-Daudé wrote:
> On 9/10/26 00:53, Pierrick Bouvier wrote:
>> On 10/8/2026 3:26 PM, Philippe Mathieu-Daudé wrote:
>>> Hi Brian,
>>>
>>> On 8/10/26 23:10, Brian Cain wrote:
>>>> Hand the k0lock/tlblock lock implementation functions the packet PC
>>>> as a
>>>> constant instead of relying on next_PC's opcode-dependent staging.
>>>>
>>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>>> ---
>>>>    target/hexagon/hex_mmu.h    |  2 +-
>>>>    target/hexagon/sys_macros.h |  4 ++--
>>>>    target/hexagon/hex_mmu.c    | 16 +++++++++-------
>>>>    target/hexagon/op_helper.c  | 16 +++++++++-------
>>>>    4 files changed, 21 insertions(+), 17 deletions(-)
>>>>
>>>
>>>> -extern void hex_tlb_lock(CPUHexagonState *env);
>>>> +extern void hex_tlb_lock(CPUHexagonState *env, target_ulong PC);
>>>
>>>> -void hex_tlb_lock(CPUHexagonState *env)
>>>> +void hex_tlb_lock(CPUHexagonState *env, target_ulong PC)
>>>
>>>> -static void hex_k0_lock(CPUHexagonState *env)
>>>> +static void hex_k0_lock(CPUHexagonState *env, target_ulong PC)
>>>
>>> Please do not re-introduce more target_ulong uses.
>>>
>>> @next_PC was converted from target_ulong to uint32_t in commit
>>> 613653e500c ("Hexagon Remove next_PC from runtime state").
>>
>> That's ideally "cleaner", but in practice, since hexagon currently has a
>> single variant (32 bit only), it's not a problem.
>>
>> In general, for targets having a single variant (only 32 or 64 bit), I'm
>> not sure we gain anything from chasing down usage of target_*long.
> 
> I prefer to share my thoughs because some maintainers realize
> "oh indeed this sed change will take me 37 seconds, let's do it now
> so Phil will stop bugging me about it" and directly reply "Since this
> series is fully reviewed I addressed that nit locally before posting
> the pull request, all good thanks!". Anyway nevermind I'll redo the
> audit in few months and clean that myself then.

Sure, it was not a "stop bugging about it Philippe" comment, just a
remark, for Brian also, that what we need to prevent is introducing
target_*long which create duplicated definitions.

It's fine to have target specific code, as long as there is a single
target variant. Just my 2 cents.

