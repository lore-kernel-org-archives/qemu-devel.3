Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 807E8CA6002
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 22:31:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEaAY-0000pU-Ks; Wed, 07 Oct 2026 18:31:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEaAW-0000os-Dq
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 18:31:24 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEaAU-00054J-80
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 18:31:24 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697Ltt4n1346072
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 22:31:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zHzuVP4G6vQWrt8lzNM2zSoGPyqDLFeHMWfNH3jIOSQ=; b=MC9ERxsSreH6sc0s
 0h3gRiligyoHm4z478DDlahgxGWlxW/LHNU5tF14BMv9N9FkrvIMNVk8pcOGgFHq
 k8YlktyyyxDRb95C9cIdttf9yt5Je1/NvLw75BHFHIYN8B3clzBJAjurnz+u8m3d
 jCiGwb4nhWf6ka4Yt6zst7rrso92YvO0orGVSAzHV2b/xp1KumCfEQzQNS9Kw/Tc
 COtaDclstMCORvBHF71f12VViYPTjPCnc02sfkKiHcz3Xsnldno9AqJnmGYeiaUR
 c3cukLAkiK+rUnGrmz+neAKdnYzEXR8DoxbfU7X0bQyX8mxz4RfO7QLfDHR30P3j
 PedW6Q==
Received: from mail-dy1-f198.google.com (mail-dy1-f198.google.com
 [74.125.82.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe803bk-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 22:31:20 +0000 (GMT)
Received: by mail-dy1-f198.google.com with SMTP id
 5a478bee46e88-3515266f6eeso1793399eec.0
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 15:31:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791412279; x=1792017079; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zHzuVP4G6vQWrt8lzNM2zSoGPyqDLFeHMWfNH3jIOSQ=;
 b=a1N0p6N/ikYpt01+bh/WQCQqoRX6gtQETnLPMp2+MUbL8tlbFqpxXmHY6Ml0k1w1NL
 Nozfv6FgWbGq3zyeG/X9t59s+0h+yW4CO2cqNfuXn66/XpLiSxNviStrHOT27aYdiFew
 s1h6VQFchgoaXaZYitGpX7Od5Z8Yr4FIySR8mJ8yPfW7jGH1GA5n5X7gKTFzy9UnmucT
 a4CjqKc6KGjeXwp5Y5DyNPM/ZYxPqatfnd3LHJQCjE09hgxUY/u7LULiWP7ZwVv84iYN
 m9Pg9Q4GewKCTuaGmirDDnV+hyK+EFiBQlGYmjaZEC9aFHrsx8aOQHXRItSXc8/OhxMW
 qpmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791412279; x=1792017079;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zHzuVP4G6vQWrt8lzNM2zSoGPyqDLFeHMWfNH3jIOSQ=;
 b=jfqMqnqaG55YA3TLavJjuXkxdzbwpEf1qVIoKlgRLV+f/OcArz9QcDY3tEE3EbJZA2
 jnFLVZOUbi7MSlELHi1yJq1yKA2x++Oc5oeQ/O7uO+E2lw4Dom1usotboNidAadCrpP/
 N+5+0EGpjtUvmVZCcAbL/aDDd4FklxF+2nTzsOLbN+8xdqiFxKVO35ew3TX6qJpDotmL
 EjJKwBJA+zdmwvN7UCFDyFGUQ7/jJjeliR6WIzuO1QCct/AdFGQtHddFHI8dfNh3InXp
 CzggSDo0dXtucsqjUYy4qV6fdlwkTiCkNWYvG1H0ZFSSwHu7MrW2FfoXfVR1UW5oCPtB
 aFoQ==
X-Gm-Message-State: AFuF++l9ICZ9A35chu8hNHYSdRMqpOWgT4F4eCdKG4V+gyWpLtMH0Oiz
 ZNcXcM839z8IGbOui2IeMf2o2ySqh5HmySgzBr82z3QsD9HcFv+LNr6h6MUoJpHNjivXRmkHNmr
 BuhdEJVtwYCSFM42xZ0J0ZTbaQBP0AIDt5CcHxXSOw9PDi23f2offdBIPWw==
X-Gm-Gg: AYBFou3/fk4A80WYQ7d0h502mI4uMne9IU7bjhpI4954dEZU8WXDkqGxZUDPFkvi70p
 Y/Pz13Eua3W5HZbceQ18zog/6bap3moYHuyt8Sa6PrBPJwnbUcZ49Y5UR4uNgIVglXC0otg1v+8
 tAcyn/a5A5ZeTe2lD8oSn8F/KU61n6WqBPvsVgffHwps111SLZHTa5Zb96PP1ae9j6DGTCn/OKB
 hSDIiQzC73Sk49BVOO9F48sxiRWBcnOodH51N9h+rETlsnTw5Rt6hROXN9FGtOG1XAuJ+E/0gfB
 VyvkRJ5wjnV3+TbUp8Hmvk6u2R3BW9OzjQekbfcAB8wTFSb6wHCgFylFBqfqiUNKieMAMEZ1Qip
 nKgGwvz9xt7wQtNKaDZvQJfNLhRi8zDXAirwvBPxmwJJEbZMU82lWvliqjw0j0Z21MX63iA==
X-Received: by 2002:a05:701b:2302:b0:144:f4b9:9be4 with SMTP id
 a92af1059eb24-162055138dbmr3863464c88.15.1791412279093; 
 Wed, 07 Oct 2026 15:31:19 -0700 (PDT)
X-Received: by 2002:a05:701b:2302:b0:144:f4b9:9be4 with SMTP id
 a92af1059eb24-162055138dbmr3863405c88.15.1791412278433; 
 Wed, 07 Oct 2026 15:31:18 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-163e3c5bed6sm3927485c88.7.2026.10.07.15.31.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 15:31:16 -0700 (PDT)
Message-ID: <919a1a75-78b9-42a9-93ed-9edf6757f707@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 15:31:14 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] target-info: replace QOM registration with a
 constructor list
To: luoyonggang@gmail.com
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Laurent Vivier <lvivier@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 John Snow <jsnow@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Joel Stanley <joel@jms.id.au>, Fabiano Rosas <farosas@suse.de>,
 Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>,
 Stafford Horne <shorne@gmail.com>, qemu-arm@nongnu.org,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@oss.qualcomm.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, Steven Lee <steven_lee@aspeedtech.com>,
 Alexander Bulekov <alxndr@bu.edu>, Darren Kenny <darren.kenny@oracle.com>
References: <20261007115253.328-1-luoyonggang@gmail.com>
 <20261007115253.328-5-luoyonggang@gmail.com>
 <37275f1f-aee9-444b-aaed-3e0bf34b63cd@oss.qualcomm.com>
 <CAE2XoE_GmDbA5SSUb3k_9HwE+bxnBjK+kBj-RE5BonEBC=GpMw@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE_GmDbA5SSUb3k_9HwE+bxnBjK+kBj-RE5BonEBC=GpMw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA4OSBTYWx0ZWRfX6lfit0jrocWZ
 031yJeQDR9KY1EvUdhXSrsjHB0EfH+DZSisJSpLq0VcZRmclooK9o7UIjfLm2UZvmEdX/pLdaR5
 oYg2+3V4wu5f+NcJ1/srPDkr8jEZYA07s2gBQD5dSL8awE3FVdLkhWbbDUyrYF6zT9PkwvCxmk3
 sI1oNemGCztq1NpHxHFuda5eNfWGZMI5ly78ddWNUk4kMa/uURdfvd4/Z3cK/Up9gArH1OPfPgN
 JfivsSsVkmr3G7tVpy2jQ254pzub1tIYR7CrRWG0vjEWgHIrg/qu5SYkJY3xqtlr5e9ai82tzYF
 UvlJpKi+DoukZA1RL34U6EA/X4zYFeUeVrdZKUY7kt67CzgA42+myHBc3q7YHr+UFhb76l/vwKw
 J1CuizKReMV9PPhwCpej9sT9ibUOjFIR9rE5lwaQTAojCCyBkFpLJXPk3Dtz0aMjsxxBIkFXYIQ
 flJNnopVLMC8BVdM0Pg==
X-Proofpoint-GUID: CsKTz9XpVI3a4TD2ThWRLEvvRbtvqCzt
X-Proofpoint-ORIG-GUID: CsKTz9XpVI3a4TD2ThWRLEvvRbtvqCzt
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA4OSBTYWx0ZWRfX+DOqlucAKOMH
 paskSHao0lebb4dcQci/70ahPU/9Ioudv5zmcDM6WfG0nble3x8zWCemvk77Y7/DOSFLlrNxIqt
 xeUnVOY/coX50+BQ/7n1RtRaCkOWQ6o=
X-Authority-Analysis: v=2.4 cv=MPT1C8Zl c=1 sm=1 tr=0 ts=6ac6c838 cx=c_pps
 a=wEP8DlPgTf/vqF+yE6f9lg==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=p0WdMEafAAAA:8 a=EUspDBNiAAAA:8 a=pGLkceISAAAA:8 a=nRLft1YshIEh5o0YeFEA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=bBxd6f-gb0O0v-kibOvt:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_07,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 adultscore=0 priorityscore=1501 suspectscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610070089
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

On 10/7/2026 1:50 PM, Yonggang Luo wrote:
> On Thu, Oct 8, 2026 at 4:29 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 10/7/2026 4:48 AM, Yonggang Luo wrote:
>>> Register target definitions through constructors instead of
>>> MODULE_INIT_TARGET_INFO, making target_info_list() and target_info()
>>> available on entry to main(), without explicit initialization or a
>>> call to module_call_init(MODULE_INIT_QOM).
>>>
>>> Keep the target list sorted by target_arch and default to its first
>>> entry. Provide an unknown TargetInfo fallback for target-independent
>>> tools such as qemu-img and unit tests that link no target-info-def.c
>>> objects.
>>>
>>> Remove the obsolete QOM target-info registration infrastructure and
>>> update the multi-target test to inspect target information before
>>> initializing QOM.
>>>
>>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>>> ---
>>>  include/qemu/module.h           |  1 -
>>>  include/qemu/target-info-def.h  | 56 +++++++++++++++++++++++++++---
>>>  include/qemu/target-info-init.h | 53 ----------------------------
>>>  include/qemu/target-info-qom.h  | 31 -----------------
>>>  include/qemu/target-info.h      |  9 +++++
>>>  meson.build                     |  6 ++--
>>>  system/vl.c                     |  4 ---
>>>  target-info-def.c               |  1 -
>>>  target-info-qom.c               | 60 --------------------------------
>>>  target-info.c                   | 61 ++++++++++++++++++++++++++++++++-
>>>  tests/qtest/fuzz/fuzz.c         |  3 --
>>>  tests/unit/test-multi-target.c  | 12 +++----
>>>  12 files changed, 129 insertions(+), 168 deletions(-)
>>>  delete mode 100644 include/qemu/target-info-init.h
>>>  delete mode 100644 include/qemu/target-info-qom.h
>>>  delete mode 100644 target-info-qom.c
>>>
>>
>> This approach (custom list based) was considered before implementing
>> things with QOM Types. The rationale I followed was that if everything
>> is in QOM, we might better follow that for consistency sake.
>> Yes, the compromise if that we need an extra init step, but it was not a
>> problem to add it.
> I have issue to add the init step for unit-tests, and hard to write the -target
> parse procedure and get it right. Not means this won't work. but for
> me, too much
> coupled.
>

We already have such a test upstream:
https://gitlab.com/qemu-project/qemu/-/blob/master/tests/unit/test-multi-target.c#L35

The init sequence is quite straightforward:

```
/* initialize target types, and only them */
module_call_init(MODULE_INIT_TARGET_INFO);

/* we can get the list if we want, for -target or any other purpose */
g_autoptr(GSList) targets = object_class_get_list(TYPE_TARGET_INFO, false);

/* set the global target info from any element in this list */
TargetInfo* ti = ...;
target_info_qom_set_target_info(ti);

/* register rest of QOM types */
module_call_init(MODULE_INIT_QOM);
```

It works fine to implement -target (if we would like to do it), since I
implemented it myself. That was also my initial motivation by the way.

Also, I appreciate that target-info is NULL by default, it crashes
loudly when it has not been set, and make it easy to find who depends on it.

> If we treat target_info as a QOM, but QOM needs target_info to set
> up(is_avaible). That makes
> the init sequence too much of a burden.
>

See sequence above, the solution is to initialize TARGET_INFO first,
before the rest of QOM. You end up with the same result than with a
statically initialized list.

> 
> is_available is depends on target_arch
> And before this patch, target_arch depends on QOM, pulls user/softmmu because
> target_info_init. By moving target-info to be a custom list based, we
> can decouple
> target-info from qom/softmmu/user. and target-info will always
> available once "main(argv, argc)" is entered. We also have the
> advantage of doing all sorts
> of tests against it.
>

Which kind of tests are you trying to add?

For now, the exact list of places where we need to do this initialize
target dance are:
- system/vl.c:    module_call_init(MODULE_INIT_TARGET_INFO);
- tests/qtest/fuzz/fuzz.c:    module_call_init(MODULE_INIT_TARGET_INFO);
- tests/unit/test-multi-target.c:
module_call_init(MODULE_INIT_TARGET_INFO);

If we want more tests, I'm totally ok to move this init code to
target-info.c, and replace call sites if needed.

> 
> Tools such as qemu-img and unit tests may link target-info.c without any
> target-info-def.c objects. Their target list remains empty, so use this
> fallback.
>

Why should this tool get access to target list? qemu-img deals with disk
images, and is unrelated to targets.

> 
> static TypeImpl *type_register_internal(const TypeInfo *info)
> {
>     TypeImpl *ti;
> 
>     if (!type_name_is_valid(info->name)) {
>         fprintf(stderr, "Registering '%s' with illegal type name\n",
> info->name);
>         abort();
>     }
> 
>     if (info->is_available && !info->is_available()) {
>         return NULL;
>     }
> 
>     ti = type_new(info);
> 
>     type_table_add(ti);
>     return ti;
> }
> 
>>
>> Is there another good value this list approach brings compared to what
>> exists?
>>
>> Regards,
>> Pierrick
> 
> 
> 


