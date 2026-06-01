Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C7ACD6E55
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 18:14:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU79Y-0007u8-3I; Mon, 01 Jun 2026 14:14:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wU79W-0007st-4q
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 14:14:18 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wU79U-0000oU-Cp
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 14:14:17 -0400
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 651EoH2f2740402
 for <qemu-devel@nongnu.org>; Mon, 1 Jun 2026 18:14:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 p3h8njqx9+/eQmx4hbmqe9CxvT08jNKNcDMq10c24uY=; b=ikWVoaGFkE4mZ6+F
 Zitu7q9II4AiSztjiZxHLUItrutDJEklfQRdU17DdGMq0x1smDmqAZBbtYUkNr6U
 EvOr8lDqpRYh10+NADhD/YW5I5pFxP+nKvxfM4OmKgUI9NV4XMvZQxC3QzdqH5Dn
 XEMOEv2V2+nBX4D9eZl6ld9zQA+AFn38zcAvpo1ys4v0VHdDXCSZxMTExm3tyl0U
 pWj2fogi6vL6d1uHKnoLbGqJAPk7QIBrVHfkylP/YaqDQ+F5h2i6BcozuqkTl8SO
 OR9g9leDsnH6sumJxtkwuXHwa74wsZTU4v3LnN3myOsDXV4aTM1BZlWwni47i9eS
 ggevPA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4eh6sqjf23-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 18:14:13 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-305fe3b697cso1319761eec.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2026 11:14:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780337653; x=1780942453; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=p3h8njqx9+/eQmx4hbmqe9CxvT08jNKNcDMq10c24uY=;
 b=AmJjI6NamghEtqoxeLSQESjm+WpcvFG5nVILdSmqbuZSFbiu145jK8qNyNrTcjlBK/
 ELFstBxZUSc8SaZ12Fzar6FLPj4LiaB2t5z+Jw4iNIQ3vCklI8JWL5HemFLEEApvDLsu
 uO4wbWD16o3GaYc5KVz3A6nO5OBjBmeX6TOmNt8l6m2xg2S9OetCjtNQ9izpeUit79tT
 h7H2VexeQ0/F/LCX90rw9cCxVW0gYVnVr1DqD9oQA2BSgHvCBTpstbXsE07+qRCXmunc
 kXBj3mpWfluUdqJ7xjQao8OmRXs9YTNRrebTBwj2w3367hckAib7zv+Hg32QcTTr6EZw
 mLoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780337653; x=1780942453;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=p3h8njqx9+/eQmx4hbmqe9CxvT08jNKNcDMq10c24uY=;
 b=ZZ7QNDw857zXIGALneCofZElHYYTAoZ5nrTLWzW9yEm3bFvVcQeZmc2ayNBInM8wju
 FSKdnng/mIwzsmgIVdWztVBVEIW7a0GfQV9ON3OKO67TwaGYGSfLljCYZAcrvjqsWCGT
 Cp5IT3IfShNmscMUuirSC5BT7IDomP2tx/Q3k0cG7+n/To4fYB1TEXKRA+Y3xVXd2hNY
 Kskh4ZRqILUGEyQnPOCCny3Vs3LzWbiJTiYbV52QtbeHVg37lURdmx6IAlpdPQxgk6gh
 AywOtLS+7vp2NCq9WR6XYT9AvHuZFkVcZIhNt7eL5SBXxf5nrXdYd+QuVR81DzIkJQ0V
 hpPQ==
X-Gm-Message-State: AOJu0YxHN3UCzoOjzbZv+yeS9Mg4kZJyjQMacbCGK4vIdJM203EezSkH
 Sc4jgMzwizuuXuLreDaSLrg19Lou14Apf3vcgsxlvPvuOsBLO3OGM9YVh0BFK8H7ryWPDzhhAFK
 no/kAdfMH5nJh4Jya/7dY0qgGAdwiH3U8mT8m+4CP/oW5r8xzzlbNz0Hm0w==
X-Gm-Gg: Acq92OGb8h70riAaIIqXHWbYfGOKBu/kfLl2kRpZH9ZtdpFvHtKTZwIiPplach65T5X
 YvZEE2rNVlVxKXAX72Z8wu0jY3SjUf+JsDZ259auCRvfW0jZF6NNClEnW/zlQDOmSjOe/05WsgB
 3/Na9BFKeTfwbbTpKIwEm1HNkZ/Zx+W2Xw2z5Je0LV8rb5be3/nSKqmvmJ6M2VZNyzFx/CBqmE8
 FsPUI4yocDxir3zp5GHb++FUoRQXFEhKoiiwQNy++RW4m3jIrjfTeIV6AaH5cA5v5GQmvX5TvM9
 Xme6pJ9WKGwx7rNi48gcw4XTsg7oKq4FniOsOyKtywNlPDv8rZBg1vXWSKvXX3hykQCxWtiSA1j
 Qe7tKelKqgSnzT2Yr/01BiZ8KkFMGVQjoDkrsJQybGqTw5BJu7Xmy6acTdVJoucO45Y+n4RdZ0X
 33ewKn40zPmdXhKboeso3EDJGC
X-Received: by 2002:a05:7300:3215:b0:304:ed85:5f43 with SMTP id
 5a478bee46e88-304fa61bc01mr4875031eec.24.1780337652998; 
 Mon, 01 Jun 2026 11:14:12 -0700 (PDT)
X-Received: by 2002:a05:7300:3215:b0:304:ed85:5f43 with SMTP id
 5a478bee46e88-304fa61bc01mr4875010eec.24.1780337652413; 
 Mon, 01 Jun 2026 11:14:12 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ed5b9be7sm9096075eec.27.2026.06.01.11.14.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2026 11:14:11 -0700 (PDT)
Message-ID: <c89889fe-0f8d-4ba4-a66a-e8b71883a2b5@oss.qualcomm.com>
Date: Mon, 1 Jun 2026 11:14:09 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] gitlab: work around the inability to build targets
 for MacOS
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Kyle Evans <kevans@freebsd.org>, Peter Maydell <peter.maydell@linaro.org>,
 Brian Cain <brian.cain@oss.qualcomm.com>, John Snow <jsnow@redhat.com>,
 Thomas Huth <th.huth+qemu@posteo.eu>, Brad Smith <brad@comstyle.com>,
 Warner Losh <imp@bsdimp.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Cornelia Huck <cohuck@redhat.com>
References: <20260601143129.144786-1-alex.bennee@linaro.org>
 <20260601143129.144786-3-alex.bennee@linaro.org>
 <57d0477a-3bbd-4948-8e18-33df41991545@oss.qualcomm.com>
 <87bjduxmne.fsf@draig.linaro.org>
 <22a283dc-38a5-44f5-b402-c334205e81cc@oss.qualcomm.com>
 <875x42xj5s.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <875x42xj5s.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: SnroGmRoiYTe_WnJ1AHwMxU9eDKAPd8t
X-Proofpoint-GUID: SnroGmRoiYTe_WnJ1AHwMxU9eDKAPd8t
X-Authority-Analysis: v=2.4 cv=eqnvCIpX c=1 sm=1 tr=0 ts=6a1dcbf5 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yOCtJkima9RkubShWh1s:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=NpS5gwzfpwJlc3pBzMEA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAxMDE3OSBTYWx0ZWRfX6vuQZEcy4LAX
 INNh1P1hHrleZfFTLJmT0S2IjAfstjMqHOff7EDgn76aFeBpNg3AGkov76Rrf0w4fgDNxZYkHSa
 UaeOvreApN8sttxMNwjjSWJDEnoVYHz2vN9Lg8Wcidtcq/tXiOa6WAyOUU4o5ngfBJ0SNMIalue
 sVZhcWoUdh05+nGczjTSrXqTLC6vK2PKVIPsp9Y0ATQuCuV/1o7nLPfoNzl9ZABV06ZYGtC4VBC
 3Xz6JxJFsPCgk8WWHu800DdtIRJ3dRqd1kVvGocy9aG+c2b8g135+hbSIGxf+WSEoofNR2O+N8r
 W/bLClY45NyU3IQP8R8v0qvVZysedx8oB9gpNxzRaz/K0k7jQBUQ1Pix7qEwLlA8mHHiGT7odcr
 3LfzObN5e+kM7q38RXc9UyqVjTsGQxwMhKlib1EVg5xqgE6LfbwEQcR0neRQu5cAyk1eIMH3rji
 Jm/XOVu3dAGUqIvrljg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-01_05,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 impostorscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606010179
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

On 6/1/2026 10:30 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> On 6/1/2026 9:15 AM, Alex Bennée wrote:
>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>
>>>> On 6/1/2026 7:31 AM, Alex Bennée wrote:
>>>>> Unfortunately a previous fix to ensure .ninja-goals was set for the
>>>>> TCG tests broken the ability to run check-functional-FOO. As we have
>>>>> now reverted we need a solution for the MacOS gitlab run. The simplest
>>>>> is to add an explicit make invocation to build the signed binaries
>>>>> before we run the tests.
>>>>>
>>>>> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
>>>>> ---
>>>>>  .gitlab-ci.d/macos.yml | 3 +++
>>>>>  1 file changed, 3 insertions(+)
>>>>>
>>>>> diff --git a/.gitlab-ci.d/macos.yml b/.gitlab-ci.d/macos.yml
>>>>> index f61750a3f4a..8366b4ad564 100644
>>>>> --- a/.gitlab-ci.d/macos.yml
>>>>> +++ b/.gitlab-ci.d/macos.yml
>>>>> @@ -29,6 +29,7 @@
>>>>>      - cd build
>>>>>      - ../configure --enable-werror $CONFIGURE_ARGS || { cat config.log meson-logs/meson-log.txt; exit 1; }
>>>>>      - $MAKE -j$(sysctl -n hw.ncpu)
>>>>> +    - for TARGET in $TEST_BINARIES ; do $MAKE $TARGET ; done
>>>>>      - for TARGET in $TEST_TARGETS ; do $MAKE $TARGET ; done
>>>>>  
>>>>>  aarch64-macos-15-build:
>>>>> @@ -44,6 +45,7 @@ aarch64-macos-15-build:
>>>>>          --cross-prefix-i386=i686-elf-
>>>>>          --cross-prefix-x86_64=x86_64-elf-
>>>>>          --disable-plugins
>>>>> +    TEST_BINARIES: qemu-system-aarch64 qemu-system-i386 qemu-system-x86_64
>>>>>      TEST_TARGETS: check-unit run-tcg-tests-aarch64-softmmu run-tcg-tests-i386-softmmu run-tcg-tests-x86_64-softmmu
>>>>>  
>>>>>  aarch64-macos-26-build:
>>>>> @@ -60,4 +62,5 @@ aarch64-macos-26-build:
>>>>>          --cross-prefix-i386=i686-elf-
>>>>>          --cross-prefix-x86_64=x86_64-elf-
>>>>>          --disable-plugins
>>>>> +    TEST_BINARIES: qemu-system-aarch64 qemu-system-i386 qemu-system-x86_64
>>>>>      TEST_TARGETS: check-unit run-tcg-tests-aarch64-softmmu run-tcg-tests-i386-softmmu run-tcg-tests-x86_64-softmmu
>>>>
>>>> Could make all be enough?
>>>
>>> No - not without the goal having the signed binaries in them.
>>>
>>
>> Which comes back to my initial (unanswered question), why do we need
>> signed binaries for running tcg tests?
>> Signed is only for HVF access.
> 
> Because it exposes a bug in our build system: 20260505103649.68361-1-alex.bennee@linaro.org
> 
> Ideally we should build the final product - whatever it may be - from
> make all. However I suspect we can't achieve that given the circular
> Makefile dependency until check-tcg is integrated into meson.
> 
> I will review you suggested path forwards tomorrow.
>

Thanks for the link.
Maybe we could always build the signed binaries on macos?

>>
>>>>
>>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>
> 


