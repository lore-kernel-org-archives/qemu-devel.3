Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34943CD37AC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 17:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNDIj-0004zd-0A; Wed, 13 May 2026 13:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNDIf-0004zB-Vo
 for qemu-devel@nongnu.org; Wed, 13 May 2026 13:23:14 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNDIe-0008Ht-3S
 for qemu-devel@nongnu.org; Wed, 13 May 2026 13:23:13 -0400
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DGAs5v2524326
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 17:23:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 gfyAtvR1R6AWpEE6rNLVk4ZlzseH9uwlbQygbmMNy5Q=; b=aQlZHklZ5ekJZfoy
 lrKZhyuR+yXv/GL+3g+fsRLwbElfLo+IxFwB5uZsbVRl83iDaSBM+Or6kEOv4Qcu
 mFvjxzoNXucVkhasQTTerkjOnlrxfNqn9z8Hrm7xLXHwdlTxZxg0RvwScDqmNqbY
 MtsdlXpMhU2cCSqvaRX57MyXGkS40o+9tLdHjKvhzVwFY+4h5ACf4IXe8g96zqZQ
 BvG+GgK/u3ayD+2L5Qb/XM3abMIQRE6CkCgHozyszijQu3rcOMdoWGqnf3tI3/US
 bFQQcwyzQ/TPMeCV8SgOwr87oVodpjSMHgNuPAHOz3OnIP/I2OZUTvNqkZvwTqB+
 GpJ3IQ==
Received: from mail-dl1-f72.google.com (mail-dl1-f72.google.com [74.125.82.72])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4vkjg9wd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 17:23:10 +0000 (GMT)
Received: by mail-dl1-f72.google.com with SMTP id
 a92af1059eb24-132a99125f8so12132868c88.1
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 10:23:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778692990; x=1779297790; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gfyAtvR1R6AWpEE6rNLVk4ZlzseH9uwlbQygbmMNy5Q=;
 b=EqCp26dJZowCJ4xx/YKeGyiiiwSfFizuIXNzNecczcZM+AlgWLwtDm3/pIn7Hts/a5
 TA96EZrUUnr8BhyE5zvdNsdressU6XmgX/H3939jITa0jp86j7c+gUaSoYqkIPA/6mxk
 l/Cv/LCPCCjaCJQLH9hvxmcmT1goBrCpMvglzOs8HXEm48uebIhUhWXUCgjZwAn7jZWA
 4FMP+sN7g2Vf+3kfUPqMG7mmnD2z9mcoCswU8LZ12iOwJvwPe5XvbX5iIY8Lu4e07it2
 XZicvE9f328I8K+eq2z9rOenSKjbQg16ukfmakSW8yli3SUCNRFAW7VBdSWQb70wDVIl
 A/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778692990; x=1779297790;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=gfyAtvR1R6AWpEE6rNLVk4ZlzseH9uwlbQygbmMNy5Q=;
 b=pUvSUAOeeqSqfC2KIfzCRWapc72KdMmEEUvWmVs8dVNFuwoWNi5bVTJZkbodCCnumD
 xed0hpu24+LkJ1jpsIy+AhlRZwwz7a396rP9l/oOnr6w6HBlhysJAlbsIz+etIiazYgv
 4o7B55O+bbMq+VHDaxhlCz6mQx6AwXWekg31umjnJSfMvb1Ng26nJ/lSjTog1w+4mCgU
 q1MWfBgcC9iz/+2nCIo5SG8Vgkec4/8v3zxPw+iHw0awsyEOzyEsWci/ZUiqN4GzHeSQ
 a75OxbRvk1G52l9rK7w+xXiqZPNeXxcDuKSSiZjnFRqbyPkWn4oTLZvVAZVJ3WZyu3TY
 MFpA==
X-Gm-Message-State: AOJu0Yw3IL7Sl6RjS5w9AIpTUVsGn8mTvgBZoSN/8PlBmlOE1wLFzhPm
 UZ+yK/Wk2aBqQFvhQhK9HkueIwToOHydDjsLQ3midPkGk9PhaSX+2SQI1eA7ckHi0Qa+p/j0C/J
 SaTo8BmljvCsDbmnoCghmWA6iJTn8Lo4Rr7c/K7k+lolRvrcT2ULTcGgLgA==
X-Gm-Gg: Acq92OG/UqQc8Gkt9qtYn+s10nFIPwOVG10PSYgHJga8E5hiTJZhLpBEkU9Njol0GUO
 Dka7wLme36eV2Ld2DWvwOkp1Kzl5cLUzYuriueVIaahexECPvZl9lfp0FdbpkVqxdnrxordTWc2
 moOi0FVvFOjpLGnw4ZXLXuG7uUT4lglA/x9j+BoFGwkWuYgabQ9xD+xPQeiImusJZZ0cPkMPm70
 Qxsdbg9KneIGTuv/95BqdwFobUpiu2wVlaxS2FnEXcK3f7guMZKSZ8tuEQFMtgxLtkBBikLeFyX
 aSn0S32txbZpfpiMJ8P3w/NRS1RNWmYs34BT1c5vUHGimIOrdwFdHMhIsRmhAllL1y7bsBiwRTq
 Z3E28WFE/1i66cuUp3fBLqAVJcrDvsCjWsbrY5pK2d2OpAadPzZzH6yOX6hIJsJcgSiiq8lHy8s
 gp+qgl0//TdGrj1w==
X-Received: by 2002:a05:7022:ea21:b0:12d:c9b6:bbdc with SMTP id
 a92af1059eb24-13436a9b1a3mr2847677c88.30.1778692989754; 
 Wed, 13 May 2026 10:23:09 -0700 (PDT)
X-Received: by 2002:a05:7022:ea21:b0:12d:c9b6:bbdc with SMTP id
 a92af1059eb24-13436a9b1a3mr2847625c88.30.1778692989005; 
 Wed, 13 May 2026 10:23:09 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-134cb5b3c20sm154114c88.0.2026.05.13.10.23.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 10:23:08 -0700 (PDT)
Message-ID: <8defa72f-6e14-410e-a6cf-88ccae2e75c9@oss.qualcomm.com>
Date: Wed, 13 May 2026 10:23:07 -0700
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
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <agSxrJ8kW0xEYaQa@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: DqJeY99IZQNs9E128DmqWDkMw51BTULD
X-Proofpoint-ORIG-GUID: DqJeY99IZQNs9E128DmqWDkMw51BTULD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE3NCBTYWx0ZWRfX7q6laKJPsjre
 l4IpIlDECun/utey7dcacBwWPc6VUNV7IdMGlyoIS+KpMjaxfODBGUw1q66qbSu5pAfiBsDNIHH
 86W4NRDxtH75AhyZLzCPjzR5mtV0PrbGSpPIxPTRAzMgERnWY033otzThxYUamI0pTRIlhQzVE/
 G5I1NPu6da0D2pOCFQgMY3+QJxBbxi6GrEqpIp0lp2Ib3ooPcr6AQqOWeTRBuoT6RVDOjh4nF7b
 Wg58Smc+kDqA6SUvgPsOyGjs6XgTE3uLCgZ0e6PDvE9oE7VP5biFMPZMShJpak3+6TtH62Kj122
 ShB8dcg3cZI0ttXv7gVbFim60HsrQ6awB26BiK9Dty9eZiAnEJcmvLl5y04TYO6+40ehVvoyXCs
 Uu9eqxOTDHyNfOWZGZDAkbPgeTarBXX7xcU807GUHb6oQtzM/6fs3buIcBSkvaic5Yz2nf+e25R
 P+abtmktHdcnWwsNqWA==
X-Authority-Analysis: v=2.4 cv=PbDPQChd c=1 sm=1 tr=0 ts=6a04b37e cx=c_pps
 a=bS7HVuBVfinNPG3f6cIo3Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_glEPmIy2e8OvE2BGh3C:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=ypSWOI0LR3jFnOhIlrwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=vBUdepa8ALXHeOFLBtFW:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 phishscore=0 malwarescore=0 spamscore=0
 clxscore=1015 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605130174
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

On 5/13/2026 10:15 AM, Daniel P. Berrangé wrote:
> On Wed, May 13, 2026 at 08:49:39AM -0700, Pierrick Bouvier wrote:
>> On 5/13/2026 3:08 AM, Daniel P. Berrangé wrote:
>>> On Tue, May 12, 2026 at 08:45:42AM -0700, Pierrick Bouvier wrote:
>>>> On 4/24/2026 8:41 AM, Daniel P. Berrangé wrote:
>>>>> Currently tests can be classified into three speed groups depending on
>>>>> whether the meson suite name ends in '-slow' or '-thorough' or neither.
>>>>>
>>>>> This gets turned into make targets that match the name of the meson
>>>>> suite, with the speed suffix stripped. e.g.
>>>>>
>>>>>  * suite=block ->  'make check-block'
>>>>>  * suite=block-slow -> 'make check-block SPEED=slow'
>>>>>  * suite=block-thorough -> 'make check-block SPEED=thorough'
>>>>>
>>>>> The set of tests under the "thorough" speed, however, can get rather
>>>>> large and it would be useful to have a way to expose further make
>>>>> targets for directly running a particular subset of tests.
>>>>>
>>>>> This needs a way to run a target without requiring the SPEED variable,
>>>>> while also not having them enabled by default as if they were 'quick'
>>>>> tests.
>>>>>
>>>>> This modifies mtest2make.py to support this idea by allowing for a new
>>>>> suffix '-optional' on a suite. When this is present, a correspondingly
>>>>> named make target will be created without the '-optional' suffix which
>>>>> will never be run automatically.
>>>>>
>>>>> This is intended to be combined with use of other suites. For example,
>>>>> a single NBD test might be added to two suites, 'block-thorough' and
>>>>> 'block-nbd-optional'.
>>>>>
>>>>> This would allow running it as part of all the block tests with
>>>>> 'make check-block SPEED=thorough', and as part of a standalone target
>>>>> 'make check-block-nbd'.
>>>>>
>>>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>>>> ---
>>>>>  scripts/mtest2make.py | 22 +++++++++++++++-------
>>>>>  1 file changed, 15 insertions(+), 7 deletions(-)
>>>>>
>>>>> diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
>>>>> index 915f02d600..383ea68b16 100644
>>>>> --- a/scripts/mtest2make.py
>>>>> +++ b/scripts/mtest2make.py
>>>>> @@ -22,7 +22,7 @@ def names(self, base):
>>>>>  print(r'''
>>>>>  SPEED = quick
>>>>>  
>>>>> -.speed.quick = $(sort $(filter-out %-slow %-thorough, $1))
>>>>> +.speed.quick = $(sort $(filter-out %-slow %-thorough %-optional, $1))
>>>>>  .speed.slow = $(sort $(filter-out %-thorough, $1))
>>>>>  .speed.thorough = $(sort $1)
>>>>>  
>>>>> @@ -66,10 +66,15 @@ def process_tests(test, targets, suites):
>>>>>              s = s[:-9]
>>>>>              suites[s].speeds.add('thorough')
>>>>>  
>>>>> +def target_name(suite):
>>>>> +    if suite.endswith('-optional'):
>>>>> +        return suite[0:-9]
>>>>> +    return suite
>>>>> +
>>>>>  def emit_prolog(suites, prefix):
>>>>> -    all_targets = ' '.join((f'{prefix}-{k}'
>>>>> +    all_targets = ' '.join((f'{prefix}-{target_name(k)}'
>>>>>                              for k in sorted(suites.keys())))
>>>>> -    all_xml = ' '.join((f'{prefix}-report-{k}.junit.xml'
>>>>> +    all_xml = ' '.join((f'{prefix}-report-{target_name(k)}.junit.xml'
>>>>>                          for k in sorted(suites.keys())))
>>>>>      print()
>>>>>      print(f'all-{prefix}-targets = {all_targets}')
>>>>> @@ -83,14 +88,17 @@ def emit_prolog(suites, prefix):
>>>>>      print(f'\t$(MAKE) {prefix}$* MTESTARGS="$(MTESTARGS) --logbase {prefix}-report$*" && ln -f meson-logs/$@ .')
>>>>>  
>>>>>  def emit_suite(name, suite, prefix):
>>>>> +    tgtname = target_name(name)
>>>>>      deps = ' '.join(sorted(suite.deps))
>>>>>      print()
>>>>> -    print(f'.{prefix}-{name}.deps = {deps}')
>>>>> -    print(f'.ninja-goals.check-build += $(.{prefix}-{name}.deps)')
>>>>> +    print(f'.{prefix}-{tgtname}.deps = {deps}')
>>>>> +    print(f'.ninja-goals.check-build += $(.{prefix}-{tgtname}.deps)')
>>>>>  
>>>>>      names = ' '.join(sorted(suite.names(name)))
>>>>> -    targets = f'{prefix}-{name} {prefix}-report-{name}.junit.xml'
>>>>> -    if not name.endswith('-slow') and not name.endswith('-thorough'):
>>>>> +    targets = f'{prefix}-{tgtname} {prefix}-report-{tgtname}.junit.xml'
>>>>> +    if not name.endswith('-slow') and \
>>>>> +       not name.endswith('-thorough') and \
>>>>> +       not name.endswith('-optional'):
>>>>>          targets += f' {prefix} {prefix}-report.junit.xml'
>>>>>      print(f'ifneq ($(filter {targets}, $(MAKECMDGOALS)),)')
>>>>>      # for the "base" suite possibly add FOO-slow and FOO-thorough
>>>>
>>>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>>
>>>> Not blocking this patch, thus reviewed, but I think it would be a better
>>>> abstraction to use meson suites for this (a test can be added in
>>>> multiple suites), instead of adding more clunk to makefile layer.
>>>
>>> This *is* using meson suites. The mtest2make script takes the list
>>> of meson suites and generates makefile targets which can be used to
>>> select execution of the meson suites. This change is exposing more
>>> of the suites as makefile targets, since make is our primary entry
>>> point.
>>>
>>>
>>> With regards,
>>> Daniel
>>
>> Maybe I can't read this patch correctly, but from it, and the message
>> description, I understand that -optional is a pure Makefile abstraction,
>> and does not reflect any real meson suite.
> 
> Actually its the other way around. In the next patch in this series
> we create meson suites like  "block-nbd-optional" and that gets turned
> into a makefile target  "check-block-nbd". The "optional" part of the
> meson suite name determines that "check-block-nbd" is NOT added as a
> depedency of "check".  IOW, it doesn't get run by "make check", but
> must be optionally run through "make check-block-nbd" when needed.
>

Oh right.
Just to double check, will everything still run when using
make check-block SPEED=thorough, or is there some new behaviour on this
side?

> With regards,
> Daniel


