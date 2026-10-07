Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2CDDCA6009
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 23:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEb3n-0004gj-42; Wed, 07 Oct 2026 19:28:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEb3j-0004gK-U5
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 19:28:29 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1xEb3g-0001rI-4j
 for qemu-devel@nongnu.org; Wed, 07 Oct 2026 19:28:27 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 697LtcVD1970919
 for <qemu-devel@nongnu.org>; Wed, 7 Oct 2026 23:28:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 4iGpP1eqSrTJygk28lL0nxza/9rUyLn3v8Lar5FaX1g=; b=F7hc9VCkdx9xQq7u
 jIPETvPwLWUFShFqbb8C07wMhJJ1u+0Fb/E76m8A6/VGxRHBwvshofHF+Ar/j+Gf
 nuNu6PkLFArc37zhrqbdx0zrHe/yBbIjRdP34zzHwQIxeSImjB+nxF6okA/8zC/y
 xEcUCUN9Yzm8Sq6GPZ353s1pU6iRkzjQa5bunPzxvA0FA2hS/6DXs/vqx7X23kul
 8k6Dpq5FI0crloOei9UnbxiE3A6jJ/n82l0NPnczpYsEFauBiw23OEgGL5Y7YWLU
 pIqiuyt1CW4+gP2mvuEJyvClCxwdKQbRz5T/1Tm+RH7q5aPvl8QILlVKO7iYJVDE
 j0UNrg==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h5xe688s6-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 23:28:22 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-3515d2fc5ebso4903691eec.1
 for <qemu-devel@nongnu.org>; Wed, 07 Oct 2026 16:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1791415701; x=1792020501; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=4iGpP1eqSrTJygk28lL0nxza/9rUyLn3v8Lar5FaX1g=;
 b=TWlJ4ZJVsrC3n+VwgBfehIVlg5/8ykp+1t7/cPiMxlT2GFExRY3fE5VmI0yEb1qirN
 G0QZHOe6UA/GYPaGaH3d5Xt8FyeqFBVFhc1N8eAhrIc5PY0NIrvANXKRpDlZTQGykhJ6
 JklgHyRO7vVUs8rXuCtHt6YCBItTKrsPN7dUtYQpAW6RKVeGwnj2CO8w+tU1PyJJt0Zq
 xI2YiEtB7br1nQkGLg2ORFDISb11NTUVYig7s/aBKHwf///nL+b5KYfMq6jvDc05z/hX
 E+cBu0ascGKf4UaTHrrs/7sslQnPsGQz2WvcorqFnAxKfsq7p/X1AINdIiei3QVMkIMc
 XhMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791415701; x=1792020501;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=4iGpP1eqSrTJygk28lL0nxza/9rUyLn3v8Lar5FaX1g=;
 b=NKChyl4pgCar1g/Lxoqb6L6bNj/Ht/IpbauUqhhfMvxpEwZ9vCKft7769PiSyCi2vU
 OtUa6qGyYjR3Vn9O3x3PzejPZTev0GVrX76RsQnIL290LUX61MsYob6vgZEv/GIMv/ch
 h6FbYv7gtnluZvcTMJmclsbMhhzd808e38+LxxX8N+BGbdvKO/ivfPeOmTSNDnHfRLFV
 wefqOzkdC3/ccm9DnKXnApjh8otvTnlzn4JrGmjqPkHwju6C0TIFMcN6FmvaTTyD9lYd
 /j5O60PSHJdFSbGyknjUBcfmiXXIAn9ILF9NbCqqV175ujhnIpzltTMaxVgPbzP1EYiR
 eUqw==
X-Gm-Message-State: AFuF++lxujqeuJjLu5ruNiw8InzZ007sJ6/V51C+nc9byA4C9aCxCT8O
 SZfaBUjzrwUYHYaJ9yPEmDPanEnn199qwK7Cl9bhBMHqkfnPN2L2IBmRyUGf3O3HzxZWgL0m6gw
 L5cl7pk3ZUzNyaKtbProq8gXxcLjJxZQrzPI75S4bAfrOxDW70YqBadMZvw==
X-Gm-Gg: AYBFou2ul7gt3sjKGeZOUXkF+05pY8WPwJYFnwOJhXY1A+UawH9t6G5B1YgInWbB1SK
 4BUzTgWyYuFh3zD42dSDnqbfJ0hyUEdOinH4KGzFPI9b6Y+pETxLhL9O3xyv0lednwgbZAkyHzA
 cdLSHrc9bZisjLI/AfeUuB8PUAdOpnn5ONrZyAh1URdjMjJAubY0mkMKm4NwrjocDP3sU0IUU+j
 j+TZj9BQhLF6l9RVxGE4XYd1kwAJTZQXPKyY1+dC5t1yKaGTwSONqyWlgzsQaU3AfQFpF/0p4r0
 4Icfi50thKCtOhZovGTs+iO87gfN+L7VxmMRYF/rL43gn5p5H155auNeq4N2Y2NA2bUS/jNlnmr
 JtmoKlhxVeGcxxtk13ClS+Giy5Rc8oX5NmKeuLWKgXlV79XaPUVkU3+PlYSUQS8Mi2v0JRg==
X-Received: by 2002:a05:7301:3d12:b0:342:645a:5cf with SMTP id
 5a478bee46e88-3515dbd00c9mr6255127eec.1.1791415701321; 
 Wed, 07 Oct 2026 16:28:21 -0700 (PDT)
X-Received: by 2002:a05:7301:3d12:b0:342:645a:5cf with SMTP id
 5a478bee46e88-3515dbd00c9mr6255075eec.1.1791415700574; 
 Wed, 07 Oct 2026 16:28:20 -0700 (PDT)
Received: from [192.168.1.199] (192-80-163-190.dyn.novuscom.net.
 [192.80.163.190]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3515aeb6076sm11386007eec.9.2026.10.07.16.28.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 07 Oct 2026 16:28:20 -0700 (PDT)
Message-ID: <72ed88c4-5f31-46c3-ab48-fdaa7c2743b7@oss.qualcomm.com>
Date: Wed, 7 Oct 2026 16:28:17 -0700
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
 <919a1a75-78b9-42a9-93ed-9edf6757f707@oss.qualcomm.com>
 <CAE2XoE-XeHnywvAGOCgxO30a_qCMgxbnBF5kjtStGa9=5D=Rkg@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <CAE2XoE-XeHnywvAGOCgxO30a_qCMgxbnBF5kjtStGa9=5D=Rkg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: BEaXIORQXF3AjMh23_O_3ZWeK3xgeMLq
X-Authority-Analysis: v=2.4 cv=HcWB3SE8 c=1 sm=1 tr=0 ts=6ac6d596 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=9852oil1ID9t5xBSyQ/BEA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=p0WdMEafAAAA:8 a=VwQbUJbxAAAA:8 a=pGLkceISAAAA:8 a=EUspDBNiAAAA:8
 a=gqMGv8y4M0eXLZAej-0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-GUID: BEaXIORQXF3AjMh23_O_3ZWeK3xgeMLq
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA3MDA5MyBTYWx0ZWRfXzxhAfxyxHckd
 MP+WbHEbf+rgS9vrDqabk7v2b2Mg5KmC7awEYDqEPdPhwtOGSjSZqnuQJ/02daifUHAMSoIKJHu
 c1CuSpL/pRWKs0A/iSY1hD4tUco6olYBT3BlaOon/dLvp/V/r1wzfld0i4ON7P2n+MyK3Ibp7yN
 IpVMcPSmo7qOYvhtb+1ip+4WPsx6m9Obgu1kTOm8N2A7jdOd0XA+X3+sBcz8vb7+xTEdPYP1P0h
 cURy/Ja8J6cE2p4bdfRccsO8Se4uazYmvoOFLNyoNe/jKkyZ2J47f018G/JOT+gjxBKUDZwhpGg
 S2+IPYXYUg59bApk8Vbe0ZW3cDAQPNv7iiNK4qAQztRTcLYKa5nm+hd7htVaIrvq0k9/Ss5Dgg/
 AUXSlUDIYkxGQMoi1YSxt+JwYtacynhkHXPv1desgTCbHVTzPUK47q2rlSFNp4xnbSRN1Ti4JGi
 SMa/64CAItryYdxSG+w==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA3MDA5MyBTYWx0ZWRfXwvawOZBMRpxO
 D02Bb/XR8xmd7ZZw3bpSvUrfEZo8vDzXu0yq5vieW9RkrjYpUfVvxdJsz2W0uF56niDrqlfj4f4
 wGeNvZleplJ+SIZgYnUAe6bPJQMiJgk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-07_07,2026-10-06_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 spamscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610070093
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

On 10/7/2026 4:02 PM, Yonggang Luo wrote:
> On Thu, Oct 8, 2026 at 6:31 AM Pierrick Bouvier
> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>
>> On 10/7/2026 1:50 PM, Yonggang Luo wrote:
>>> On Thu, Oct 8, 2026 at 4:29 AM Pierrick Bouvier
>>> <pierrick.bouvier@oss.qualcomm.com> wrote:
>>>>
>>>> On 10/7/2026 4:48 AM, Yonggang Luo wrote:
>>>>> Register target definitions through constructors instead of
>>>>> MODULE_INIT_TARGET_INFO, making target_info_list() and target_info()
>>>>> available on entry to main(), without explicit initialization or a
>>>>> call to module_call_init(MODULE_INIT_QOM).
>>>>>
>>>>> Keep the target list sorted by target_arch and default to its first
>>>>> entry. Provide an unknown TargetInfo fallback for target-independent
>>>>> tools such as qemu-img and unit tests that link no target-info-def.c
>>>>> objects.
>>>>>
>>>>> Remove the obsolete QOM target-info registration infrastructure and
>>>>> update the multi-target test to inspect target information before
>>>>> initializing QOM.
>>>>>
>>>>> Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
>>>>> ---
>>>>>  include/qemu/module.h           |  1 -
>>>>>  include/qemu/target-info-def.h  | 56 +++++++++++++++++++++++++++---
>>>>>  include/qemu/target-info-init.h | 53 ----------------------------
>>>>>  include/qemu/target-info-qom.h  | 31 -----------------
>>>>>  include/qemu/target-info.h      |  9 +++++
>>>>>  meson.build                     |  6 ++--
>>>>>  system/vl.c                     |  4 ---
>>>>>  target-info-def.c               |  1 -
>>>>>  target-info-qom.c               | 60 --------------------------------
>>>>>  target-info.c                   | 61 ++++++++++++++++++++++++++++++++-
>>>>>  tests/qtest/fuzz/fuzz.c         |  3 --
>>>>>  tests/unit/test-multi-target.c  | 12 +++----
>>>>>  12 files changed, 129 insertions(+), 168 deletions(-)
>>>>>  delete mode 100644 include/qemu/target-info-init.h
>>>>>  delete mode 100644 include/qemu/target-info-qom.h
>>>>>  delete mode 100644 target-info-qom.c
>>>>>
>>>>
>>>> This approach (custom list based) was considered before implementing
>>>> things with QOM Types. The rationale I followed was that if everything
>>>> is in QOM, we might better follow that for consistency sake.
>>>> Yes, the compromise if that we need an extra init step, but it was not a
>>>> problem to add it.
>>> I have issue to add the init step for unit-tests, and hard to write the -target
>>> parse procedure and get it right. Not means this won't work. but for
>>> me, too much
>>> coupled.
>>>
>>
>> We already have such a test upstream:
>> https://gitlab.com/qemu-project/qemu/-/blob/master/tests/unit/test-multi-target.c#L35
>>
>> The init sequence is quite straightforward:
>>
>> ```
>> /* initialize target types, and only them */
>> module_call_init(MODULE_INIT_TARGET_INFO);
>>
>> /* we can get the list if we want, for -target or any other purpose */
>> g_autoptr(GSList) targets = object_class_get_list(TYPE_TARGET_INFO, false);
>>
>> /* set the global target info from any element in this list */
>> TargetInfo* ti = ...;
>> target_info_qom_set_target_info(ti);
>>
>> /* register rest of QOM types */
>> module_call_init(MODULE_INIT_QOM);
>> ```
>>
>> It works fine to implement -target (if we would like to do it), since I
>> implemented it myself. That was also my initial motivation by the way.
>>
>> Also, I appreciate that target-info is NULL by default, it crashes
>> loudly when it has not been set, and make it easy to find who depends on it.
>>
>>> If we treat target_info as a QOM, but QOM needs target_info to set
>>> up(is_avaible). That makes
>>> the init sequence too much of a burden.
>>>
>>
>> See sequence above, the solution is to initialize TARGET_INFO first,
>> before the rest of QOM. You end up with the same result than with a
>> statically initialized list.
>>
>>>
>>> is_available is depends on target_arch
>>> And before this patch, target_arch depends on QOM, pulls user/softmmu because
>>> target_info_init. By moving target-info to be a custom list based, we
>>> can decouple
>>> target-info from qom/softmmu/user. and target-info will always
>>> available once "main(argv, argc)" is entered. We also have the
>>> advantage of doing all sorts
>>> of tests against it.
>>>
>>
>> Which kind of tests are you trying to add?
>>
>> For now, the exact list of places where we need to do this initialize
>> target dance are:
>> - system/vl.c:    module_call_init(MODULE_INIT_TARGET_INFO);
>> - tests/qtest/fuzz/fuzz.c:    module_call_init(MODULE_INIT_TARGET_INFO);
>> - tests/unit/test-multi-target.c:
> 
> # Multi targets test
> if multi_target_objects != []
>   test('test-multi-target',
>        executable('test-multi-target',
>                   sources: [multi_target_crates, files('test-multi-target.c')],
>                   dependencies: multi_target_deps,
>                   objects: multi_target_objects,
>                   link_depends: [block_syms, qemu_syms],
>                   link_args: multi_target_link_args),
>        suite: ['unit'])
> endif
> 
> I see this test, I am trying to add tests that do not pull so many
> multi_target_objects, as it would be huge.

Agree, we should not add more binary.
If you need truly multi targets test, this existing binary is a good
place to start: just add a second test in it.

> Just pull qom only.  And I am trying to call target_info() in
> object.c, as inspect machines with
> qemu-system is rejected, so maybe that's not an issue anymore
>

Seems like a good candidate for the multi-target.c test.

> 
> I means Subject: [PATCH v3 00/10] machine: uniquify virt QOM names
> https://lore.kernel.org/qemu-devel/20260926081551.29-1-luoyonggang@gmail.com/#r
> 
> So the current design always rejects types that do not belong to the
> current target. Listing them
> all is not an option at all. With this restriction, then these are
> indeed not needed.
> So I'll wait for your work first, otherwise it's always conflicting.
> 
> 
>> module_call_init(MODULE_INIT_TARGET_INFO);
>>
>> If we want more tests, I'm totally ok to move this init code to
>> target-info.c, and replace call sites if needed.
>>
>>>
>>> Tools such as qemu-img and unit tests may link target-info.c without any
>>> target-info-def.c objects. Their target list remains empty, so use this
>>> fallback.
>>>
>>
>> Why should this tool get access to target list? qemu-img deals with disk
>> images, and is unrelated to targets.
>>
>>>
>>> static TypeImpl *type_register_internal(const TypeInfo *info)
>>> {
>>>     TypeImpl *ti;
>>>
>>>     if (!type_name_is_valid(info->name)) {
>>>         fprintf(stderr, "Registering '%s' with illegal type name\n",
>>> info->name);
>>>         abort();
>>>     }
>>>
>>>     if (info->is_available && !info->is_available()) {
>>>         return NULL;
>>>     }
>>>
>>>     ti = type_new(info);
>>>
>>>     type_table_add(ti);
>>>     return ti;
>>> }
>>>
>>>>
>>>> Is there another good value this list approach brings compared to what
>>>> exists?
>>>>
>>>> Regards,
>>>> Pierrick
>>>
>>>
>>>
>>
> 
> 


