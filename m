Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA966CD6E60
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2026 15:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wUR9c-0007PL-5A; Tue, 02 Jun 2026 11:35:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUR9T-0007P1-H1
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 11:35:36 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wUR9R-0008Op-03
 for qemu-devel@nongnu.org; Tue, 02 Jun 2026 11:35:35 -0400
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 652Catcx2767170
 for <qemu-devel@nongnu.org>; Tue, 2 Jun 2026 15:35:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 5gv+u3Wg42FWBcGluoVyuAOB5EBfTd1okya7jGyBDQQ=; b=HJ+Ds3hx10tgTRuL
 sqCjaDhJqiKqKAYfqGMNubBnB4grQs7MgBcty1GrXT5zmWjXgsCGtz1iOu68tDlD
 z/BQZ2IDbkVj90hRed4xf/Dv0IYJ8W9NGhBnh/+KLuiEWEQT4GcpVphsg0l76YlA
 sjRzbPamV+vrWiIwoqRkkAARw434+1zqwazcPElGro9Yj824BOFzkTPKYLK573OH
 ki83gpz/Nm+wC3NBMV5aErEFJ4NlpiH1sGEHraYpW5lj1KjQNrsonaIFhGsD4Q/b
 YDEwcB/+lUdjfmk1Q4ODKWBaFBJ55BE6I7lA3US8jTw9gjnUP9JoI/Zsz2dSblem
 hE7L7A==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4ehsus2839-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 15:35:28 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-137d003cf09so9071953c88.1
 for <qemu-devel@nongnu.org>; Tue, 02 Jun 2026 08:35:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1780414528; x=1781019328; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5gv+u3Wg42FWBcGluoVyuAOB5EBfTd1okya7jGyBDQQ=;
 b=EIwjOTkPh72FqbqUWDcqY2SFfNiMRI+Zkcz5ZdB/vr31TxpGJb8SWUf/l8dFt+hhhY
 Pk5SUSAhNKGbco2AcOLXAdpzJgv+Efn601TkOetuL6Kw1ebG0WwjW7+nkecqVd+GaQD2
 4IKhQhJtooPH7lWKE3nf1xBr/Tf2GhSRnU7a2s19wCf06CdOqLSQN0PqD9rPAp16EJ0a
 PzMAVEL4wJ+zefSwqg1+GNQZpsh+p3hbKkbum5kt8Q591jAB7oWcgr52ku8X+DBsgPk6
 2AeP81J8YBFBFrDbNGF75j9WkKmBnLFOZQEF27ZHxwxDUfoBfkACRqM8hO+ci75LHXxR
 bjqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780414528; x=1781019328;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5gv+u3Wg42FWBcGluoVyuAOB5EBfTd1okya7jGyBDQQ=;
 b=YL+fjM25B/jeUPzT7YY9GaFJWK0pEbR5ZlMmI/Hb3hxwruHBXHqPGDXu4WQfla3TnT
 2JwCPJhd+1eGx+hU1FwlHOBVIuORZHAZMBb1QNv+dJknZGHbpq19L1uthlLzLGH+pQFx
 aSDPJsQC766hKxC8PTnhNHoUOJ9yMYbiPZ38MFaD8BFK2UpfORj9noZYPrPI12zNU6ID
 /QKuReI+6r/HcNNNXuPZCJI0dIWkN1jzVvyluIUgYKSRWC/OxroupPh/kM0L/4XLcgcI
 A1mLXPjOLxCyl4iPVkvnlOo8X91tHvm2dF1T2uhxft9LxinzFVjzxL1SAbVtpa9zhRQg
 3d8g==
X-Gm-Message-State: AOJu0Yw0aDa5N7CMvI05a4CImIbt4xxHTuHWJbe/ngM5WJ31+oM5sRMq
 Ih6BqjPGSSrNaDE7Ued1giiQIqvFdDXWv+Kkt9z3WeyGwGt+1AYt9BXKbsFWXM6oTX9xEWE7LiI
 xroc5U/IfXTamVXIXI9erSz9uJyKw3BzMF4lPUwp7pa59Rob+iwYcYg05jg==
X-Gm-Gg: Acq92OEkwzuwOK+VYyr27Mgt5h09igVNOolA8z19DvDNU7V/OMjMcO7ucdyHKq7cBDV
 VHma9MTCLaNcWkO4reblMY9+Af5LlqUyLXm+MBkxeFAcSoOp+0WwJk5jYJ4m1/YUfe26pLlwo5k
 I1CkXfhN/Lc4EOBNLWBotdjBbSk1U70gTikq4kDz4QhEkJZSgmKNTEuXVIvwyrx60sLwQDjG/MQ
 M2Fl4g/WsC5b52Vo8LNI6RSwcG1VuUtsmcDVA9rjfFsBZA9jrqEIPKMnCmz/EHM08CHxVyxc3zX
 KihBdry+PNanPL2uZV9NSbgIAlfVvo8M9ronsxSRGkvHTCUZarQyeZJOFXF4GYoaoTTiXefpLCG
 z7B6Hhdio/uLsIzKvYzO0B/QdnkuMKTDo4R91sNyE5+A3vD73HIhQ82ulVz1eYo+CxZsnny4TqG
 VFM/OcyloORLCO1FPsH0FoHviP
X-Received: by 2002:a05:7022:6192:b0:134:fc89:40c5 with SMTP id
 a92af1059eb24-137d401c3a1mr6747048c88.10.1780414527341; 
 Tue, 02 Jun 2026 08:35:27 -0700 (PDT)
X-Received: by 2002:a05:7022:6192:b0:134:fc89:40c5 with SMTP id
 a92af1059eb24-137d401c3a1mr6747026c88.10.1780414526321; 
 Tue, 02 Jun 2026 08:35:26 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-304ee0dd6fdsm11200692eec.23.2026.06.02.08.35.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Jun 2026 08:35:22 -0700 (PDT)
Message-ID: <35c9d179-821a-48e5-8c71-22236053d67c@oss.qualcomm.com>
Date: Tue, 2 Jun 2026 08:35:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/39] MAINTAINERS: Fix F: lines
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, philmd@linaro.org, John Snow <jsnow@redhat.com>,
 Cleber Rosa <cleber@redhat.com>
References: <20260521080511.999266-1-armbru@redhat.com>
 <d52c0fca-3a8a-4d4f-abff-f772605512b8@oss.qualcomm.com>
 <87y0gy8thg.fsf@pond.sub.org>
 <c7cc0040-872d-425c-827f-c57db87ee12c@oss.qualcomm.com>
 <87wlwh77gv.fsf@pond.sub.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87wlwh77gv.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: jnhDEvT2omFBG4DocFz3E3h-ZmjT8WGZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjAyMDE1MCBTYWx0ZWRfXw8kuCL7CpoyU
 mXihJe2s+EMwHh/HJL8aPFS2Z/eE+yUUqUbBOavEc6x97DWMPBR/XND1joFoVBECBOvb/ArMsim
 1N0g4p3z8jX5A3+x4e7jTKqUIP1DoeenquhlnD2asXjaFRBsr5oHa5siRmLOj66vPRmCOqOGMMX
 bc7rRYyGIDZ4yC53mE6VKTaUbiY46FfVEfoJo+yfQxMDRMJaMieqEfaCCFvXcVfIQvdZ5/tLeTm
 Ct4MPs0FqzJvaVTy0FWLAg8T1MlNEQWqaML9xM4g3XzxJlrXNbVOYpKS9HjQ+VSEm2mJaV5MFfB
 OUaRlRIUoeOjYx6kvUOQDF0FCzlnStEa2Zd3AW9iKOdTSjqCtEr1w5FtunYn1SOdfmQQUMWUIHM
 O1ridUbugF3ivwe92d8eHMkPROjK24A8PLcDBByaGIJZb51+jCjeUOOCc8p4tc0qd7pQgWQeWRy
 5M3XXlaE9diikj2Ma4Q==
X-Authority-Analysis: v=2.4 cv=ZYAt8MVA c=1 sm=1 tr=0 ts=6a1ef840 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=eoimf2acIAo5FJnRuUoq:22
 a=ukH1R-b_AAAA:8 a=EUspDBNiAAAA:8 a=20KFwNOVAAAA:8 a=Z5DR0hOY1AJPjyUOk9AA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=Fk4IpSoW4aLDllm1B1p-:22
 a=zUGFzhdS3I8ccRoxxLmr:22
X-Proofpoint-GUID: jnhDEvT2omFBG4DocFz3E3h-ZmjT8WGZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-02_02,2026-05-28_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 priorityscore=1501 clxscore=1015 adultscore=0 impostorscore=0
 spamscore=0 phishscore=0 suspectscore=0 malwarescore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606020150
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

On 6/2/2026 12:00 AM, Markus Armbruster wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> On 6/1/2026 3:06 AM, Markus Armbruster wrote:
>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>
>>>> Hi Markus,
>>>>
>>>> On 5/21/2026 1:04 AM, Markus Armbruster wrote:
>>>>> Quite a few F: lines don't match any files.  The quick & dirty check
>>>>>
>>>>>     $ ls `sed -n 's/^F: *//p' MAINTAINERS ` >/dev/null
>>>>>
>>>>> finds about fifty.
>>>>>
>>>>> Philippe Mathieu-Daudé recently posted a few fixes:
>>>>>
>>>>>   MAINTAINERS: Fix docker/dockerfiles/debian-hexagon-cross.docker path
>>>>>   MAINTAINERS: Cover debian-loongarch-cross.docker with LoongArch section
>>>>>   MAINTAINERS: Cover debian-xtensa-cross.docker with Xtensa section
>>>>>   MAINTAINERS: Cover debian-tricore-cross.docker with TriCore section
>>>>>   MAINTAINERS: Cover python.docker with Python library section
>>>>>   MAINTAINERS: Fix s390x storage key/attribute device paths
>>>>>   MAINTAINERS: Fix tcg/s390x/ path
>>>>>   MAINTAINERS: Correct scripts/coverity-model.c path
>>>>>   MAINTAINERS: Fix hexagon-linux-user.mak path
> 
> [...]
> 
>>>> In addition, see the patch attached to this email.
>>>> It integrates checking this directly at configure time, so we never run
>>>> into any missing entry again in the future.
>>>>
>>>> I share this here not for a review, but simply to avoid a duplicated
>>>> effort, and make sure people know it will be sent after this series.
>>>>
>>>> I don't believe in adding this in checkpatch, because it's not enforced
>>>> systematically unfortunately. Breaking the meson configuration is a good
>>>> way to make sure it's enforced by design.
>>>
>>> No objection.
>>>
>>>> With your series applied, the left entries are:
>>>
>>> Most of these are fixed in Philippe's patches mentioned above.
>>>
>>
>> 👍
>>
>>>> No matching files for /usr2/pbouvier/.work/qemu/MAINTAINERS +258:
>>>> configs/targets/hexagon-linux-user/default.mak
>>>
>>> MAINTAINERS: Fix hexagon-linux-user.mak path
>>>
>>>> No matching files for /usr2/pbouvier/.work/qemu/MAINTAINERS +259:
>>>> docker/dockerfiles/debian-hexagon-cross.docker
>>>
>>> MAINTAINERS: Fix docker/dockerfiles/debian-hexagon-cross.docker path
>>>
>>>> No matching files for /usr2/pbouvier/.work/qemu/MAINTAINERS +2956:
>>>> hw/s390x/storage-keys.h
>>>> No matching files for /usr2/pbouvier/.work/qemu/MAINTAINERS +2965:
>>>> hw/s390x/storage-attributes.h
>>>
>>> MAINTAINERS: Fix s390x storage key/attribute device paths
>>>
>>>> No matching files for /usr2/pbouvier/.work/qemu/MAINTAINERS +3241:
>>>> scripts/coverity-model.c
>>>
>>> MAINTAINERS: Correct scripts/coverity-model.c path
>>>
>>>> No matching files for /usr2/pbouvier/.work/qemu/MAINTAINERS +3468:
>>>> tests/*.py
>>>
>>> This is the exception I mentioned above.
>>>
>>> The intent is to match *.py below tests/.  It actually matches only in
>>> tests/, not in its subdirectories.
>>>
>>> Here's a dumb fix:
>>>
>>>     F: tests/*.py
>>>     F: tests/*/*.py
>>>     F: tests/*/*/*.py
>>>     F: tests/*/*/*/*.py
>>>
>>
>> It's acceptable, and nice because it's not ambiguous.
>> Also, it shows us the first line is not a correct entry (there is no
>> tests/*.py).
> 
> It's also brittle: breaks when we add the first .py at level.
> 
>>> for however many levels we have.  Same for the scripts/ line next to it.
>>> Blech.
>>>
>>> The smart fix might be to port N: from the kernel.
>>>
>>> 	N: Files and directories *Regex* patterns.
>>> 	   N:	[^a-z]tegra	all files whose path contains tegra
>>> 	                        (not including files like integrator)
>>> 	   One pattern per line.  Multiple N: lines acceptable.
>>> 	   scripts/get_maintainer.pl has different behavior for files that
>>> 	   match F: pattern and matches of N: patterns.  By default,
>>> 	   get_maintainer will not look at git log history when an F: pattern
>>> 	   match occurs.  When an N: match occurs, git log history is used
>>> 	   to also notify the people that have git commit signatures.
>>>
>>> But I wonder: is this section useful at all?
>>
>> I would prefer to use the manual entries approach above, especially if
>> there is only folder that is concerned.
>> When we'll have two different use case, maybe we can consider a more
>> generic approach.
> 
> I'm aware of just two:
> 
>     Python scripts
>     M: John Snow <jsnow@redhat.com>
>     M: Cleber Rosa <crosa@redhat.com>
>     S: Odd Fixes
>     F: scripts/*.py
>     F: tests/*.py
> 
> The section was added almost a decade ago (commit ad904f6689f), and
> never worked as intended.  I asked John Snow about deleting it to
> unblock your work.  He told me he'd be fine with that.  Could add it
> back later fixed.
> 
>>>> No matching files for /usr2/pbouvier/.work/qemu/MAINTAINERS +4149:
>>>> tcg/s390/
>>>
>>> MAINTAINERS: Fix tcg/s390x/ path
>>>
>>>> Once your current series is pulled, I'll fix the remaining and send the
>>>> attached patch. Or feel free to do it directly if you like the idea :)
>>>>
>>>> Regards,
>>>> Pierrick
>>>
>>> Two remarks inline.
>>>
>>>> From 6c9b49ac7ec06c0159d2b4ba9c9d1081e02ef765 Mon Sep 17 00:00:00 2001
>>>> From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>> Date: Fri, 22 May 2026 12:23:17 -0700
>>>> Subject: [PATCH] meson.build: check MAINTAINERS file is consistent with source
>>>>  tree
>>>>
>>>> We add a new script: scripts/check-maintainers-file.py, that will run at
>>>> configuration time (and not at build time), to not hurt build time.
>>>> This script runs in 0.2s on my dev VM, which has an old cpu.
>>>>
>>>> We can expect things to be mostly in sync since adding or removing a
>>>> source or test file will trigger a configure step.
>>>> For the rest, like docs, tcg tests, or remaining files, GitLab CI will
>>>> build things from scratch and always run the configure step.
>>>>
>>>> With this, it should be impossible by design to have an upstream
>>>> MAINTAINERS file with non existing file entries.
>>>>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>> ---
>>>>  meson.build                       |  5 +++
>>>>  scripts/check-maintainers-file.py | 53 +++++++++++++++++++++++++++++++
>>>>  2 files changed, 58 insertions(+)
>>>>  create mode 100755 scripts/check-maintainers-file.py
>>>>
>>>> diff --git a/meson.build b/meson.build
>>>> index eeb096c1487..ddfb0b90ca6 100644
>>>> --- a/meson.build
>>>> +++ b/meson.build
>>>> @@ -18,6 +18,11 @@ add_test_setup('thorough',
>>>>  
>>>>  meson.add_postconf_script(find_program('scripts/symlink-install-tree.py'))
>>>>  
>>>> +# check our MAINTAINERS file is consistent
>>>> +check_maintainers = find_program('scripts/check-maintainers-file.py')
>>>> +maintainers_file = files('MAINTAINERS')
>>>> +run_command([check_maintainers, maintainers_file], check: true, console: true)
>>>
>>> My version of meson (1.8.5) chokes on console: true.  According to
>>> https://mesonbuild.com/Reference-manual_functions_run_command.html#run_command_console
>>> it's new in 1.11.0.
>>>
>>
>> Our configure script creates a venv with an updated version of meson,
>> which is 1.11.1 at the moment.
>> If you called meson directly (which uses your host meson), it's not how
>> we're supposed to build QEMU.
>> How did you try this?
> 
> I ran make :)
> 
>>> I tested with it deleted.
>>>
>>>> +
>>>>  ####################
>>>>  # Global variables #
>>>>  ####################
>>>> diff --git a/scripts/check-maintainers-file.py b/scripts/check-maintainers-file.py
>>>> new file mode 100755
>>>> index 00000000000..b001816a401
>>>> --- /dev/null
>>>> +++ b/scripts/check-maintainers-file.py
>>>> @@ -0,0 +1,53 @@
>>>> +#! /usr/bin/env python3
>>>> +
>>>> +# Check incorrect file entries in MAINTAINERS
>>>> +#
>>>> +# Author: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>> +#
>>>> +# SPDX-License-Identifier: GPL-2.0-or-later
>>>> +
>>>> +import argparse
>>>> +import glob
>>>> +import sys
>>>> +
>>>> +
>>>> +def check_one_entry(line) -> bool:
>>>> +    return True
>>>> +
>>>> +
>>>> +def main() -> None:
>>>> +    parser = argparse.ArgumentParser(description="Check MAINTAINERS file")
>>>> +    parser.add_argument("maintainers", help="Path to MAINTAINERS file")
>>>> +    args = parser.parse_args()
>>>> +
>>>> +    found_file_entry = False
>>>> +    found_incorrect_entries = False
>>>> +    line_counter = 0
>>>> +
>>>> +    with open(args.maintainers) as file:
>>>> +        for entry in file:
>>>> +            line_counter += 1
>>>> +
>>>> +            if not entry.startswith("F:"):
>>>> +                continue
>>>> +            entry = entry[2:].strip()
>>>> +            found_file_entry = True
>>>> +
>>>> +            file_exists = len(glob.glob(entry, recursive=True)) > 0
>>>
>>> I'm afraid this matches files not in git, just like my quick & dirty
>>> one-liner.  Shouldn't we match against contents of HEAD, say output of
>>> "git-ls-tree -r --name-only @"?
>>>
>>
>> I don't think it's needed to restrict to git ls-tree. The only risk is
>> that people have a local file they forgot (or didn't want) to add in
>> git. It will be caught by CI that won't have such a file, so we're safe.
>>
>> What do you think?
> 
> Yes, we're safe, but the earlier we catch mistakes, the better.  Now,
> the juice isn't always worth the squeeze.  How hard would we have to
> squeeze here?  We could use fnmatch.filter(names, pat) to test whether
> @pat matches anything in @names, where @names is from git-ls-tree.
>

"the earlier we catch mistakes, the better" is a good paradigm, but I
don't think we should project that to developer machine. The only thing
we need to keep "green" are our upstream branches.

I like the simplicity of current script, only dealing with file paths,
instead of having to do string regexp compare with git ls-files output,
but it's just a matter of personal taste and choosing the easiest
solution for a given problem.

That said, if filtering through git ls-files is a strong requirement, I
would be happy to implement it. Only thing that matters is that we have
something catching mistakes.

>>>> +            if file_exists:
>>>> +                continue
>>>> +
>>>> +            found_incorrect_entries = True
>>>> +            print(
>>>> +                f"No matching files for {args.maintainers} +{line_counter}: {entry}",
>>>> +                file=sys.stderr,
>>>> +            )
>>>> +
>>>> +    if not found_file_entry:
>>>> +        raise Exception("no file entry found - is MAINTAINERS path correct?")
>>>> +    if found_incorrect_entries:
>>>> +        raise Exception(f"incorrect entries found in {args.maintainers}")
>>>> +
>>>> +
>>>> +if __name__ == "__main__":
>>>> +    main()
>>>
>>
>> Regards,
>> Pierrick
> 


