Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E37CBCD37AC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 17:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNDSM-0007Be-QN; Wed, 13 May 2026 13:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNDS7-00077x-46
 for qemu-devel@nongnu.org; Wed, 13 May 2026 13:33:00 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNDS4-0003Bu-Lv
 for qemu-devel@nongnu.org; Wed, 13 May 2026 13:32:58 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DFdqZT1242893
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 17:32:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 E0H1tkO3RvwQeczhdQvUwjnT0UcJx1nvc3Fcb5o4kd0=; b=pwYy9ZhT4DwH9u5Y
 Mtb+kDfaRyAUoSqjJAZ4bMgoQaDo5bbQc7ArBdFSZ4weTeMkDSSHyYuR+fZ4t8IN
 73nqjnEOarSXGnKfQJLrjK6GVMkYqjjpUz9i+p09pjYk6lZW2OnsKbiiofEUXonc
 dUADbXgy9T30XpufjH3dmyGCL0yNmmuaGKkjYYSdHYQexO7Jh1nD0mRaIv+Q7QMf
 Zj8HdlyUA6Zzq24EbV9INrwqtAmkTTFP2XV7T3zERM2SPDxuJyWCPv30+utKul8N
 hl1+Bi+Cw2JqUdEAQJZ+O233n0piILVs9sJ1q0ZB/VmkZLREvPdjzQD+aMUzwcdy
 vPb5EA==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4v4trf1v-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 17:32:54 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2f3ec2e8d07so1339817eec.1
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 10:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778693574; x=1779298374; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E0H1tkO3RvwQeczhdQvUwjnT0UcJx1nvc3Fcb5o4kd0=;
 b=hZW+m2OhChEUVTezYmjIWZvGz2qNKcOpGfUTKzQE/Deef/qq+7T1jwaarBnAkqCxY4
 i8+kn0hqqF3Uq27Q6kIbHRU49/TPhzmo93DyDmmWHWwkMAvtzs4wixKchuhsuI6dgWY1
 m+6gN/PZfExy31yepn2O8F/jx8vqvwlK6QmRzYBG4b5CtQauoi5BStamtzYAJ1XjlZ58
 ll3E8KOYQ4uXgKH1SYkU5sZzrjxc51WHntClAK6oW/tPGp9xbM1E8/lNqdZJfi36oHTf
 3o+JKdkrnkkX8JFtrNwrxOkC13iWOEzYqNofIDpZXmwx2paKDeDpW3JoKhdFdL6TRPxG
 4xdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778693574; x=1779298374;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E0H1tkO3RvwQeczhdQvUwjnT0UcJx1nvc3Fcb5o4kd0=;
 b=fPBYQa0IrEHpnNaSKRzegPBpwMH0nKc0vYUzSNJ99zhGeJbNL6fvtQt/GLGKkPdaAe
 7uOPQ4tgs+hEte4aYq6MTl6gYSpG/10yl0zza82UWSaNS7qHH8TBXDJGkYpzKRAzCt8z
 Hyil9rvXo9Km4XLOP+PlGNaNJuVHlBOUsDLvzCCmAEbVItWF82TInOgJC5SxVdfu/URy
 JgkXxrmawQb6V067N09z+bgHMXPBAgE5CCfrHx8CM0bLC3bppKKXy+DHmy3wf3lSdz7Y
 Frz1F5sSkMeTINIyXQTLor+hhlSl6aJlVoHHzzN2mob/A9fkxr8c5wBxvOxUkpYy4CO9
 gdww==
X-Gm-Message-State: AOJu0Yy8ZdM28J4Xl8h+QMezWxLDZPEctGW7MOR+oRyNPSq9X7x7pQxz
 sW51kswxDZTXs8eRkS9506/+wdZ8S3RmiZJQRovpzINRJ2EPb74A3+IzNEfCIe3RwAkPhguzZ5s
 H8TdidO1iVKVzPC2Rr5xafT/GFfdZA54DgfB0i2yKrT2LAE+4UUPcotiFQg==
X-Gm-Gg: Acq92OGR/RHkYwehGrLWT7d3FdkmDkKWWgp29EXL1SYWgeI0qj7kmCMngK33cLTcs8w
 DC28ckvo8N0jHqnWjdi1aqsoc5qp3LDDMJ8sVYK0oCmURCKyVHEqo43SLJ0fQoilhryDcIOsGWG
 tvsqUsrXMe4pgBZNcCNS3/NjYFO4qZYOQ0GSL363HaHjBZ2NR0ZzR4k8lCR8uXK05RDxrZHBxKA
 awl5UFExNA14DG158IwVvL21Cr8mceCeLcuXyIsOfeB2McpMLX7xm67ACcBbol556E7O2fVKkZ6
 DtA73/0OsA5DMZGNIQq/oi8iZa8F68Nc/31bMSVWGtYf9eF5EC/NG0V0Br/2x/xZSy0tAl3zwb0
 r6aMGkbrciFoZ6lg/Ww1z+kk/CFN0v8kNDPSps2ZRfM1ys2EDELx97H3JFRaPZWDzVEE7pve+Bv
 wYXj1LWAaQlEmvNQ==
X-Received: by 2002:a05:7300:d70e:b0:2f2:32bc:788a with SMTP id
 5a478bee46e88-30119397d3fmr2657157eec.25.1778693573596; 
 Wed, 13 May 2026 10:32:53 -0700 (PDT)
X-Received: by 2002:a05:7300:d70e:b0:2f2:32bc:788a with SMTP id
 5a478bee46e88-30119397d3fmr2657137eec.25.1778693572935; 
 Wed, 13 May 2026 10:32:52 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f8859eafc2sm28991154eec.4.2026.05.13.10.32.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 10:32:52 -0700 (PDT)
Message-ID: <3a4b19ae-bcbe-4341-b052-afec7594b399@oss.qualcomm.com>
Date: Wed, 13 May 2026 10:32:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/16] scripts/mtest2make: support optional tests grouping
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20260424154205.364268-1-berrange@redhat.com>
 <20260424154205.364268-8-berrange@redhat.com>
 <170b791e-ee66-4d7a-80d0-5c959c9ff359@oss.qualcomm.com>
 <agRNn9JP_THW6cgV@redhat.com>
 <a9cbb995-efff-4681-8936-ad91aa246617@oss.qualcomm.com>
 <agSxrJ8kW0xEYaQa@redhat.com>
 <8defa72f-6e14-410e-a6cf-88ccae2e75c9@oss.qualcomm.com>
 <agS0VK-FQpt9oWq_@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <agS0VK-FQpt9oWq_@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=XIIAjwhE c=1 sm=1 tr=0 ts=6a04b5c6 cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=mV-WrPRTJjL0zxRbQqgA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE3NiBTYWx0ZWRfX74t0oU7QyHYu
 ForcokocsZyrss7CzOAqOETBAhpkdgwNOZ/Q3M2WLIiu9apqWDhSpw0JawQeW0XppBXw0Aj2KLz
 BiXPIc2S6OO32IfaU79I3GkGUJAEj0KiyIpi9lvUvE+O93WJbHPAHFONnZfKNUZ7f8dLOkjXTrg
 WUwYk+lKXHm5sodmbQ9m3tNlhEPOV1Y3bkyPHW8TFRU5sFj+cb0Zq6u4sSTVaOStAT7+UGeNhMM
 cXWK5deneNlwvzon+uER42TGQadEZ7MVmm4EbXovZvLqjwEDi+Z3vKxdEt236fJwXAQnzIqkwn7
 jlfViBFBw9ARsZKKk4skyRZxt076j6HdnhcOYPcltnXYvkFsY08tsH+Tv4JA+JnhqvIbFuzDF9h
 szjj2iarrPy1rwsz3/ISVIpze/qME2VZwUZRtTLJAiBS1xTgWTkkRRErp+73du3849eDXjcxEa0
 ZBLmdPqVmSxgx+Rs2Ag==
X-Proofpoint-ORIG-GUID: 23YyOb4_s0GSADutrej85ibLsTjGfxVy
X-Proofpoint-GUID: 23YyOb4_s0GSADutrej85ibLsTjGfxVy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 impostorscore=0 malwarescore=0
 bulkscore=0 clxscore=1015 spamscore=0 lowpriorityscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130176
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

On 5/13/2026 10:26 AM, Daniel P. Berrangé wrote:
> On Wed, May 13, 2026 at 10:23:07AM -0700, Pierrick Bouvier wrote:
>> On 5/13/2026 10:15 AM, Daniel P. Berrangé wrote:
>>> On Wed, May 13, 2026 at 08:49:39AM -0700, Pierrick Bouvier wrote:
>>>> On 5/13/2026 3:08 AM, Daniel P. Berrangé wrote:
>>>>> On Tue, May 12, 2026 at 08:45:42AM -0700, Pierrick Bouvier wrote:
>>>>>> On 4/24/2026 8:41 AM, Daniel P. Berrangé wrote:
>>>>>>> Currently tests can be classified into three speed groups depending on
>>>>>>> whether the meson suite name ends in '-slow' or '-thorough' or neither.
>>>>>>>
>>>>>>> This gets turned into make targets that match the name of the meson
>>>>>>> suite, with the speed suffix stripped. e.g.
>>>>>>>
>>>>>>>  * suite=block ->  'make check-block'
>>>>>>>  * suite=block-slow -> 'make check-block SPEED=slow'
>>>>>>>  * suite=block-thorough -> 'make check-block SPEED=thorough'
>>>>>>>
>>>>>>> The set of tests under the "thorough" speed, however, can get rather
>>>>>>> large and it would be useful to have a way to expose further make
>>>>>>> targets for directly running a particular subset of tests.
>>>>>>>
>>>>>>> This needs a way to run a target without requiring the SPEED variable,
>>>>>>> while also not having them enabled by default as if they were 'quick'
>>>>>>> tests.
>>>>>>>
>>>>>>> This modifies mtest2make.py to support this idea by allowing for a new
>>>>>>> suffix '-optional' on a suite. When this is present, a correspondingly
>>>>>>> named make target will be created without the '-optional' suffix which
>>>>>>> will never be run automatically.
>>>>>>>
>>>>>>> This is intended to be combined with use of other suites. For example,
>>>>>>> a single NBD test might be added to two suites, 'block-thorough' and
>>>>>>> 'block-nbd-optional'.
>>>>>>>
>>>>>>> This would allow running it as part of all the block tests with
>>>>>>> 'make check-block SPEED=thorough', and as part of a standalone target
>>>>>>> 'make check-block-nbd'.
>>>>>>>
>>>>>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>>>>>> ---
>>>>>>>  scripts/mtest2make.py | 22 +++++++++++++++-------
>>>>>>>  1 file changed, 15 insertions(+), 7 deletions(-)
>>>>>>>
>>>>>>> diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
>>>>>>> index 915f02d600..383ea68b16 100644
>>>>>>> --- a/scripts/mtest2make.py
>>>>>>> +++ b/scripts/mtest2make.py
>>>>>>> @@ -22,7 +22,7 @@ def names(self, base):
>>>>>>>  print(r'''
>>>>>>>  SPEED = quick
>>>>>>>  
>>>>>>> -.speed.quick = $(sort $(filter-out %-slow %-thorough, $1))
>>>>>>> +.speed.quick = $(sort $(filter-out %-slow %-thorough %-optional, $1))
>>>>>>>  .speed.slow = $(sort $(filter-out %-thorough, $1))
>>>>>>>  .speed.thorough = $(sort $1)
>>>>>>>  
>>>>>>> @@ -66,10 +66,15 @@ def process_tests(test, targets, suites):
>>>>>>>              s = s[:-9]
>>>>>>>              suites[s].speeds.add('thorough')
>>>>>>>  
>>>>>>> +def target_name(suite):
>>>>>>> +    if suite.endswith('-optional'):
>>>>>>> +        return suite[0:-9]
>>>>>>> +    return suite
>>>>>>> +
>>>>>>>  def emit_prolog(suites, prefix):
>>>>>>> -    all_targets = ' '.join((f'{prefix}-{k}'
>>>>>>> +    all_targets = ' '.join((f'{prefix}-{target_name(k)}'
>>>>>>>                              for k in sorted(suites.keys())))
>>>>>>> -    all_xml = ' '.join((f'{prefix}-report-{k}.junit.xml'
>>>>>>> +    all_xml = ' '.join((f'{prefix}-report-{target_name(k)}.junit.xml'
>>>>>>>                          for k in sorted(suites.keys())))
>>>>>>>      print()
>>>>>>>      print(f'all-{prefix}-targets = {all_targets}')
>>>>>>> @@ -83,14 +88,17 @@ def emit_prolog(suites, prefix):
>>>>>>>      print(f'\t$(MAKE) {prefix}$* MTESTARGS="$(MTESTARGS) --logbase {prefix}-report$*" && ln -f meson-logs/$@ .')
>>>>>>>  
>>>>>>>  def emit_suite(name, suite, prefix):
>>>>>>> +    tgtname = target_name(name)
>>>>>>>      deps = ' '.join(sorted(suite.deps))
>>>>>>>      print()
>>>>>>> -    print(f'.{prefix}-{name}.deps = {deps}')
>>>>>>> -    print(f'.ninja-goals.check-build += $(.{prefix}-{name}.deps)')
>>>>>>> +    print(f'.{prefix}-{tgtname}.deps = {deps}')
>>>>>>> +    print(f'.ninja-goals.check-build += $(.{prefix}-{tgtname}.deps)')
>>>>>>>  
>>>>>>>      names = ' '.join(sorted(suite.names(name)))
>>>>>>> -    targets = f'{prefix}-{name} {prefix}-report-{name}.junit.xml'
>>>>>>> -    if not name.endswith('-slow') and not name.endswith('-thorough'):
>>>>>>> +    targets = f'{prefix}-{tgtname} {prefix}-report-{tgtname}.junit.xml'
>>>>>>> +    if not name.endswith('-slow') and \
>>>>>>> +       not name.endswith('-thorough') and \
>>>>>>> +       not name.endswith('-optional'):
>>>>>>>          targets += f' {prefix} {prefix}-report.junit.xml'
>>>>>>>      print(f'ifneq ($(filter {targets}, $(MAKECMDGOALS)),)')
>>>>>>>      # for the "base" suite possibly add FOO-slow and FOO-thorough
>>>>>>
>>>>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>>>>
>>>>>> Not blocking this patch, thus reviewed, but I think it would be a better
>>>>>> abstraction to use meson suites for this (a test can be added in
>>>>>> multiple suites), instead of adding more clunk to makefile layer.
>>>>>
>>>>> This *is* using meson suites. The mtest2make script takes the list
>>>>> of meson suites and generates makefile targets which can be used to
>>>>> select execution of the meson suites. This change is exposing more
>>>>> of the suites as makefile targets, since make is our primary entry
>>>>> point.
>>>>>
>>>>>
>>>>> With regards,
>>>>> Daniel
>>>>
>>>> Maybe I can't read this patch correctly, but from it, and the message
>>>> description, I understand that -optional is a pure Makefile abstraction,
>>>> and does not reflect any real meson suite.
>>>
>>> Actually its the other way around. In the next patch in this series
>>> we create meson suites like  "block-nbd-optional" and that gets turned
>>> into a makefile target  "check-block-nbd". The "optional" part of the
>>> meson suite name determines that "check-block-nbd" is NOT added as a
>>> depedency of "check".  IOW, it doesn't get run by "make check", but
>>> must be optionally run through "make check-block-nbd" when needed.
>>>
>>
>> Oh right.
>> Just to double check, will everything still run when using
>> make check-block SPEED=thorough, or is there some new behaviour on this
>> side?
> 
> Yes, this commit doesn't affect that existing make target, so it
> operates as before.
> 
> Patch 5 does however fix a pre-existing problem - currently even
> with SPEED=thorough most of the qcow2 tests didn't get run, only
> the "quick" tests. With this series SPEED=thorough correctly does
> what people thought it was already doing.
>

Sounds good, thanks Daniel.

> With regards,
> Daniel


