Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 038A7C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 18:21:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiFqC-0002U4-8q; Fri, 10 Jul 2026 14:20:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiFqA-0002Tw-BY
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 14:20:46 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wiFq8-0007g7-16
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 14:20:46 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66AH43JO1326513
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 18:20:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 28oowZWD7L5UKWM8XWo5kcsWjb8K2kJgyuHuZWN10xI=; b=e8T4coHUzubZzhew
 yyXrhAowDNj76ybTFuqYGWVJU9rLNqri78jYVHwJJMZ3zUC1sWKQNwQtfEF2/TIt
 t6hj5tMgp5uFPyrUeCyVdoiIA9wd/psW0txes8K5WLQaFH22EbS9OyQ+CiZ0NqZ6
 A4uhJMvBILZ53hSKGTU6ZEcf668/5bYhEcjxddYNkmCn7CxHc9Nmu/Y4G8qC/zNs
 zFPHpT6hgZKSh0mKU+ADX7gTJA10WedaESGlJq+wOoPMH9KMp8J+xR3A3ozhHUKs
 dggldoMXSCF7yHZ8my5vI0nUjOkA8SPo+lVVURG/mV6aRTMhfZqkvErbOroyDnOy
 kSqOlw==
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fb339rpnh-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 18:20:41 +0000 (GMT)
Received: by mail-pj1-f70.google.com with SMTP id
 98e67ed59e1d1-38dc4401dc7so157940a91.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 11:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1783707641; x=1784312441; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=28oowZWD7L5UKWM8XWo5kcsWjb8K2kJgyuHuZWN10xI=;
 b=GHzaFkFtJufNlA2e6+unVQxc5vaB3vGN8fPN1dbLv+uSSBB6JkIGxN/rdyDX2BpsCd
 c4bBg4DjnlC1T82wOG1nudRhL/LdffZT+HxBuJ2JkcG6C2aPNIoY+AgPmZPTCfNs9O/o
 gr3SkbQ2vHJmyutgN4bkHMFvPum6HN9bG2ELjtfggXU6cJnMWwnLYN4YC9jSlz7yaAdO
 eJR++OMHi0DBThfUWbiIDH/FyLQ5s1HXOftZgBLMvI/O/ebFDkXSvAXN7DR1nzgzqoBE
 1VuAvtzYFCTWfgYslc432bbjs3bHLeJEHlYDFz4o0ijxl++ijMkAowabP16vPg67B1mK
 2ehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783707641; x=1784312441;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=28oowZWD7L5UKWM8XWo5kcsWjb8K2kJgyuHuZWN10xI=;
 b=iDLTsx0y5E2X34lVA8SVJh6saa0zRTdrWIGlOHR+fgMA8/6gjwzIncxp6i7NPSIaSN
 dXSbLC4zrtH2TosU59s34jm3IbnOdXrlV4CYVzjkM0oMOsgKxVfthe4RIZ6KuIgsBcLL
 O+3XxwqBIv+8wtjLY/gxNzYNhFySImFJ1P+Wcdr5PAtxJ+C8hrPIa3Gp8CvSOFcT3b65
 zOA0qlfrAjMm0kYtdAgrLk5fY9+Kutna6he4n5C96/Kz9/rUfJ4zMNqsZoikU+31bbR5
 jhOiqWh0At9Amz/kL7JWiN92gy33twlV2+qRKQ+LQpzWs2E2F1ACmPRLImH8QG4qDQyz
 DlQw==
X-Gm-Message-State: AOJu0YzOqasL2haJ65lavqWxM9y6sjV06oXHrNYptiHm+u0y+743ZOmk
 I0pDyFjjO0xq48PdwnQHRktQMhVAUbCFVL5IGz+fqRUXvvHlJpy+gqEzyAPJdM4rpcZwxVTbvxk
 jdiTqwwvwmicwSZ635o0p1iny0gDIWK4td6LR63TRerm2z0c4a4QqexhgsQ==
X-Gm-Gg: AfdE7cna/xNjn5JceoCn5P/YPseKb4N0h5QFL49kYAtu87zfSMIGJCe0sPLq8b+UbC7
 jYchWX+bZeV1JuI66cpvn+GlXfihwX2W5H3/Kcz3/02eqcf8ocbTEOIlseubBcBR67R+5A4CMOD
 lTbKhAntjMczxhCqEQtGr1I630WTEpMhn+JS+zeXYznm4ELt3sOBgo5JiNp69KBe8LyegcrLAZU
 F+5POcrmOuhvuYOGTCfL4oxlec+O5tvB5mPg3fJdx7WwM9m0aSvbBOc3CWAuWOTVTdRPr9f5FXM
 j953IhmX2CtsaaU73uaPW6D+q6VVY95lxrGK1Gj1RUX+6+LyofL5lHNleqXy+JiJLJVjTGDa7L0
 WN+HX39OCr8kZBb0utSS4qGWoqQ/qiJ0dqY9B21QLraZ6by/sEyAlb/+/T1+rYSoBXZvBB7jalj
 C6FAs=
X-Received: by 2002:a17:90b:4b8d:b0:381:12d5:1ab5 with SMTP id
 98e67ed59e1d1-38dc7611412mr112218a91.0.1783707640545; 
 Fri, 10 Jul 2026 11:20:40 -0700 (PDT)
X-Received: by 2002:a17:90b:4b8d:b0:381:12d5:1ab5 with SMTP id
 98e67ed59e1d1-38dc7611412mr112186a91.0.1783707640001; 
 Fri, 10 Jul 2026 11:20:40 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3117483dec6sm44017910eec.11.2026.07.10.11.20.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 11:20:39 -0700 (PDT)
Message-ID: <2bbe43b8-2654-40f3-ac7f-c68ab6ebdcce@oss.qualcomm.com>
Date: Fri, 10 Jul 2026 11:20:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] tests/docker: add support for podman remote access
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, "Edgar E . Iglesias" <edgar.iglesias@amd.com>
References: <20260210163556.713841-1-berrange@redhat.com>
 <20260210163556.713841-3-berrange@redhat.com>
 <cbc2e0d7-72d6-4350-a906-e0003e8b5964@oss.qualcomm.com>
 <ak_IsMGkkMY8wERc@redhat.com>
 <947a4843-34ae-43f7-8fbc-80109bc0c077@oss.qualcomm.com>
 <alCoHiXzBAcwnOxJ@redhat.com> <87ldbjqd67.fsf@draig.linaro.org>
 <alDdCh7zfJvdD0tn@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <alDdCh7zfJvdD0tn@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEwMDE4NCBTYWx0ZWRfX/SGNO5ygl7R2
 InlmgPtJ8ZeRuBBglGOTNhExewebY2NxWcZB6zwrZDJrVReXfFUGnobOFTN9IqsF/3IXqJsFdPB
 YUdkMYHyZzw+WilNxlAU0ICj+uHF57M=
X-Authority-Analysis: v=2.4 cv=Re6gzVtv c=1 sm=1 tr=0 ts=6a5137f9 cx=c_pps
 a=0uOsjrqzRL749jD1oC5vDA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=p0WdMEafAAAA:8 a=20KFwNOVAAAA:8 a=nYIUxUqRKmhLqxvdhLQA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=mQ_c8vxmzFEMiUWkPHU9:22
X-Proofpoint-ORIG-GUID: 8Fpj1moL4a8NHbV8rfREaaO8bxLUPgys
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEwMDE4NCBTYWx0ZWRfXzWBLRZhV0FHj
 6M4Ccxc9gpcQif3l6AW0dVrWik4xemrRJpA0eN0hDA255dQ+7AjNh6Muf8hdS+xLPIG+tuu42Wt
 8bQZ0B7b9tKUZY8SBUUrgogIbjCwohdW1OarGJteIvIdWfZeqBEUBiZ1RwaJvFIqV9KMhWo18Oo
 mrVDG19bakBEmlbV+6lldifUkDo2ul3KVrRU8KsM+b1GgndZs5bicFgWXnJss6P95zaQhvHaT1j
 iD9Wwioi7eQhqLqjRSJp5KopP4lxEeDNU4nOSsgll3FVWd96hM3dNAIuQozooDYczJapH0oIhJE
 kgj43QCY68hQ5hib+uSGt50mc2oYwfR118259xeyIzCe4377BtJYQM3s+s3+L38Tf/S3NjftkR+
 xtpa2st+kcV/aGEscmWR6KUejUGk68C97goswfFYEfn0hA8te5jUmyHBpLc/Uv6Krn0akjGsSDm
 pvjWCQvbXvVhjgISmVQ==
X-Proofpoint-GUID: 8Fpj1moL4a8NHbV8rfREaaO8bxLUPgys
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-10_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 bulkscore=0
 malwarescore=0 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607100184
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

On 7/10/2026 4:52 AM, Daniel P. Berrangé wrote:
> On Fri, Jul 10, 2026 at 12:47:28PM +0100, Alex Bennée wrote:
>> Daniel P. Berrangé <berrange@redhat.com> writes:
>>
>> (added Edgar for Microblaze)
>>
>>> On Thu, Jul 09, 2026 at 09:24:12AM -0700, Pierrick Bouvier wrote:
>>>> On 7/9/2026 9:13 AM, Daniel P. Berrangé wrote:
>>>>> On Thu, Jul 09, 2026 at 07:48:14AM -0700, Pierrick Bouvier wrote:
>>>>>> On 2/10/2026 8:35 AM, Daniel P. Berrangé wrote:
>>>>>>> When a developer's environment is already within a podman container it
>>>>>>> is not possible to use 'podman' again to create containers. It will
>>>>>>> usually result in wierd errors such as:
>>>>>>>
>>>>>>>   Error: fatal error, invalid internal status, unable to create a new pause process: cannot re-exec process to join the existing user namespace. Try running "podman system migrate" and if that doesn't work reboot to recover
>>>>>>>
>>>>>>> Podman offers the ability to talk to a daemon outside the container,
>>>>>>> however, which could be leveraged by QEMU.
>>>>>>>
>> <snip>
>>>>>> Taking a look at why tcg tests are slow to compile, I reached this
>>>>>> commit. It seems like that calling 'podman info' is 5 to 10 times slower
>>>>>> than calling 'podman version'.
>>>>>> Thus, a container run now takes +1s when it was 0.2 before.
>>>>>
>>>>> Hmmm, but we call 'docker.py probe' in configure and cache the result,
>>>>> so that probe should only be done once.  0.2 vs 1s is just noise in
>>>>> the context of configure.
>>>>>
>>>>> That you're seeing any negative effects suggests that we've got
>>>>> something not using the cached probe result, which we should fix.
>>>>>
>>>>
>>>> Not really, docker.py --engine X still calls X info.
>>>>
>>>> https://gitlab.com/qemu-project/qemu/-/blob/master/tests/docker/docker.py#L675
>>>> https://gitlab.com/qemu-project/qemu/-/blob/master/tests/docker/docker.py#L78
>>>>
>>>> Maybe the fix is to remove the check if user specified an explicit
>>>> engine. But in this case, there is a problem with podman-remote not
>>>> being detected anymore.
>>>>
>>>> We can fix this by introducing engine=podman-remote, and skip the check
>>>> if engine is explicitly set.
>>>> What do you think?
>>>
>>> Urgh, so i see now we have two code paths / make variables
>>>
>>>   RUNC=podman --remote
>>>   CONTAINER_ENGINE=auto
>>>
>>> Sometimes we'll invoke docker.py --engine $(CONTAINER_ENGINE)
>>> and sometimes we'll directly invoke $(RUNC).
>>
>> Yeah that could do with cleaning up. I suspect the only places we
>> actually still need the script is where we are doing binfmt_misc enabled
>> containers unless there is a way to emulate the copying of qemu into the
>> container with a plain call? Maybe all the systems now have the
>> persistent flags which would skip this.
> 
> Yeah, I'd be inclined to say this is a job for the distros to have
> qemu-user integration, and simplify our life. THe docker.py script
> always confuses me.  We could choose podman vs podman --remote vs
> docker simply in the meson.build file, as we do for other dev env
> choices.
> 
>> The toolchain case could be skipped if we could find hosted compilers
>> for microblaze. However I do see we have a patch in there.
>>
>>>
>>> The result of "probe" cannot be fed back in to "--engine" which
>>> is a bit of a mess. I think the "engine" concept should not be
>>> exposed on the cli, and instead have a "--runc" arg which takes
>>> the full arg(s), since we need probe to report the runc args
>>> for other reasons.
>>>
>>> With regards,
>>> Daniel
>>
>> -- 
>> Alex Bennée
>> Virtualisation Tech Lead @ Linaro
>>
> 
> With regards,
> Daniel

Is it me or did we incredibly derailed from original issue which was:
"It was fast to query which container engine is available, and now it's
5-10 times slower to accommodate toolbox workflow where podman is
available but not really available?"

I agree it's sad to have several ways to set container engine, but it's
absolutely not related to the current issue.

Daniel, since you introduced the slow check path with podman info for
your personal need, I would appreciate if it's something you could fix also.

Regards,
Pierrick

