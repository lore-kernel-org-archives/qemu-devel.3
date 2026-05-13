Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F92ACD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 15:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNBqL-0004Is-9v; Wed, 13 May 2026 11:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNBqF-0004I0-Fc
 for qemu-devel@nongnu.org; Wed, 13 May 2026 11:49:51 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wNBqD-0001KZ-Db
 for qemu-devel@nongnu.org; Wed, 13 May 2026 11:49:47 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DEd5BX3474786
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 15:49:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 YYMolFMHQgC/z2nbIoAKejqY0/z4LxhvE/lqh1GPqM0=; b=SFYtjPRiqfxTs73Y
 g5IeM3ZVIqIKECG9U2dPbaL3ME8m8mSUrIISsmvFV1OsdezvgangI+MQ5/vd1We/
 Ex7Mxl0Z0uf20ITOWLfpG74Hra+ruVCa332A05jQrTjEhznoSJ/ILWjbt8XHARu2
 1/Hy9sVfZuSGQd4BPZf++DS15Kc+bTVL4AbP3HF39DIw0RD7S23L+xwZwQ0xfnzc
 zC3X3amDmFNq2qTxVF0H7/n7QQ1dWtdacgr8068IPRSnj5BgpjlFvuJZVO69ju3B
 msY06agbOFV9EYCEavfWPb8fv0G3C9LVHk9GmiZnYqtJYHkpGefTUAD0nUfeviMe
 UULZCw==
Received: from mail-dl1-f70.google.com (mail-dl1-f70.google.com [74.125.82.70])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4p419ndx-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 15:49:42 +0000 (GMT)
Received: by mail-dl1-f70.google.com with SMTP id
 a92af1059eb24-134a9388abfso435775c88.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 08:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778687382; x=1779292182; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=YYMolFMHQgC/z2nbIoAKejqY0/z4LxhvE/lqh1GPqM0=;
 b=PfmY0QPIJUwH4dMx5gy9f1lTsgyQNxkHpzviW0xQLq8R8225SENfYGnLKtyzelGh6C
 hDinsWGRhMO7Yk80KIooAwnP+dPQuR/JvyNe0kZKdLb/xdSWexFWbY/1FNM5r3zRC/VM
 Q58FaAdQ7LUA7ZuFVMwuIyEiGXpzPKTE59cc7ICGSr1oG5NhKsfzwQJ4VG5gbGvDxtbO
 qk5jB9L43eZmf36t240KlIZ/dH50WAracG5X6j5Jfx6li9GAN8rY0Dm3EObwgIZXrWFj
 nl7ZGZ8mKaP4LJ49HorSlBopaL4Xg4NYIp+y7uwdOFXFMv10H4pYKfUOvJ6f2H3A3/Z6
 gHJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778687382; x=1779292182;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YYMolFMHQgC/z2nbIoAKejqY0/z4LxhvE/lqh1GPqM0=;
 b=jnDKGVJXqRnwMn6eTBTaS46I2REMrxQz5+bFcbjwkJNPcEXk22ZzotICZqek4o2/av
 pCfVAwjK3qPHv6cI13fmmAdgWlGxGAIoT9/o7aPcwL9Ieb+X+SjefcekIVq9NPspMvkb
 PsSEoI3KpMWXpRELnR1PFS2OT9ZUiFP5/bsYuta/iiD1x8996WHKjr9vh36sxfEd3jxl
 5/ixxASEF4SCUSgqNR56PsvZrnrFUBOsacg4eQiyn+z+Gdvhb+YVRqBqyGO/o3diUyF1
 OPGBxb2hbaBw1TxpYghjdqGddL0uZuNY0V95F7oAFTHwaqPpREWMUpE5hURC17oNstep
 sQfA==
X-Gm-Message-State: AOJu0Yz3H/0ZiJutsGJ3A2kEEeGnaXZF0T3w75NlO9nfwxtCT49M1ElE
 r4nzMrnSVa9A3BWxHt2UHQubCNy1A2fb02gocmrfEIquSWqOpbANuPGvUdZ0McsdNjpuXSCPuwK
 0qhkMSZ46TlfmB4UGDU8yRFY3Ys2c1ws0VNLlW9AR8LrCVP30iGQChzkvMg==
X-Gm-Gg: Acq92OETU5jbz9WUC4ccvOtpjZAjJJCbh2BFgWLctktNWDBIuy8O9V7kXfKC63LJgeO
 lYUYykmlgP+i9CRweuqTMTyjhKWmHvSBYF9mKOJGfCyCumnPUQz+kSio/zdQJTcPbgr1N3alw9/
 01kw/xli0gusO/IGSuE/duHkI5u6kOazllkmSKfCFovz6otx79IpQ7zQrvi11Ok/+wzip3kut2l
 4r7Yoyz2GdJWst2soOUKXYTaBrL4k9gXxrzWBVXxTuuP1So6bMabQWUOQCyaFvRRWyvHYZxdA8T
 eVpyuHztb69Y/n93Z8PVsQQEmatR6MP4+qRb0xiIdrqSSUIDRYTWecncfiPRNMO/CAzYUAwAVtN
 /QUICnddLPP/bbHH/d5YiJVqyDyaFFwF9mvLUNyF2gXVsrmPx95YjhLBQpTSqj/cQVJ27kbv4R/
 3NjkwZgdpYHv+vPg==
X-Received: by 2002:a05:7022:6a1:b0:134:a700:785f with SMTP id
 a92af1059eb24-134c890fc9emr54799c88.10.1778687381875; 
 Wed, 13 May 2026 08:49:41 -0700 (PDT)
X-Received: by 2002:a05:7022:6a1:b0:134:a700:785f with SMTP id
 a92af1059eb24-134c890fc9emr54777c88.10.1778687381233; 
 Wed, 13 May 2026 08:49:41 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-1327865700asm23847621c88.9.2026.05.13.08.49.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 08:49:40 -0700 (PDT)
Message-ID: <a9cbb995-efff-4681-8936-ad91aa246617@oss.qualcomm.com>
Date: Wed, 13 May 2026 08:49:39 -0700
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
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <agRNn9JP_THW6cgV@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=df+wG3Xe c=1 sm=1 tr=0 ts=6a049d97 cx=c_pps
 a=SvEPeNj+VMjHSW//kvnxuw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=20KFwNOVAAAA:8 a=EUspDBNiAAAA:8 a=hcKpCKI0f3N_H2S-SZAA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=Kq8ClHjjuc5pcCNDwlU0:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDE2MSBTYWx0ZWRfX/V+DxDMssB++
 0zwfdzi+i0agEDVvlf0GhzqPDFGQLXsvzlCKeCc0jMna20k80eOl6xcqg7tzT4uxgRU2sfdIryq
 QtbZ/foIsEmUSNgDhp+xFZ4KtC2dT2+JjBcyaMcN3rY7nHqV/a0+8S1zVgYSpeRl+IlQN5M45/7
 TYjk30c4F5wmbD92nGMBHJ3SWhvOmtMRUFVa/MIDlMaRv18Y0VWGZwV8oNoeswjm8Ne2YGgDYhr
 gBqNEm2Li5b8sjFcxPQBsb827vu4JBvaNmdzpp+rFsklTs7qH0nuH4UKjA1UELgw7IvHH7ycsgU
 tZCyGkgGeCPUOvRdjcWXP9c4Z4GZiZU79xT85E9l6R/21/FmIbaVmRM75LZyuTIuj1aII3cAzlF
 mTRpnrREp37525xU0D0LnT/j0hnFqqnSkMvCbHCotrLKElEqfTSbLCyP24m/56LKs6Ys6hKOfQU
 wayxB76r0iYPAEcgwoA==
X-Proofpoint-GUID: ZsUOqQpGJtHGLIv8FRbJHz2lcwMjqJx0
X-Proofpoint-ORIG-GUID: ZsUOqQpGJtHGLIv8FRbJHz2lcwMjqJx0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-13_01,2026-05-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 malwarescore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 impostorscore=0 phishscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605130161
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

On 5/13/2026 3:08 AM, Daniel P. Berrangé wrote:
> On Tue, May 12, 2026 at 08:45:42AM -0700, Pierrick Bouvier wrote:
>> On 4/24/2026 8:41 AM, Daniel P. Berrangé wrote:
>>> Currently tests can be classified into three speed groups depending on
>>> whether the meson suite name ends in '-slow' or '-thorough' or neither.
>>>
>>> This gets turned into make targets that match the name of the meson
>>> suite, with the speed suffix stripped. e.g.
>>>
>>>  * suite=block ->  'make check-block'
>>>  * suite=block-slow -> 'make check-block SPEED=slow'
>>>  * suite=block-thorough -> 'make check-block SPEED=thorough'
>>>
>>> The set of tests under the "thorough" speed, however, can get rather
>>> large and it would be useful to have a way to expose further make
>>> targets for directly running a particular subset of tests.
>>>
>>> This needs a way to run a target without requiring the SPEED variable,
>>> while also not having them enabled by default as if they were 'quick'
>>> tests.
>>>
>>> This modifies mtest2make.py to support this idea by allowing for a new
>>> suffix '-optional' on a suite. When this is present, a correspondingly
>>> named make target will be created without the '-optional' suffix which
>>> will never be run automatically.
>>>
>>> This is intended to be combined with use of other suites. For example,
>>> a single NBD test might be added to two suites, 'block-thorough' and
>>> 'block-nbd-optional'.
>>>
>>> This would allow running it as part of all the block tests with
>>> 'make check-block SPEED=thorough', and as part of a standalone target
>>> 'make check-block-nbd'.
>>>
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> ---
>>>  scripts/mtest2make.py | 22 +++++++++++++++-------
>>>  1 file changed, 15 insertions(+), 7 deletions(-)
>>>
>>> diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
>>> index 915f02d600..383ea68b16 100644
>>> --- a/scripts/mtest2make.py
>>> +++ b/scripts/mtest2make.py
>>> @@ -22,7 +22,7 @@ def names(self, base):
>>>  print(r'''
>>>  SPEED = quick
>>>  
>>> -.speed.quick = $(sort $(filter-out %-slow %-thorough, $1))
>>> +.speed.quick = $(sort $(filter-out %-slow %-thorough %-optional, $1))
>>>  .speed.slow = $(sort $(filter-out %-thorough, $1))
>>>  .speed.thorough = $(sort $1)
>>>  
>>> @@ -66,10 +66,15 @@ def process_tests(test, targets, suites):
>>>              s = s[:-9]
>>>              suites[s].speeds.add('thorough')
>>>  
>>> +def target_name(suite):
>>> +    if suite.endswith('-optional'):
>>> +        return suite[0:-9]
>>> +    return suite
>>> +
>>>  def emit_prolog(suites, prefix):
>>> -    all_targets = ' '.join((f'{prefix}-{k}'
>>> +    all_targets = ' '.join((f'{prefix}-{target_name(k)}'
>>>                              for k in sorted(suites.keys())))
>>> -    all_xml = ' '.join((f'{prefix}-report-{k}.junit.xml'
>>> +    all_xml = ' '.join((f'{prefix}-report-{target_name(k)}.junit.xml'
>>>                          for k in sorted(suites.keys())))
>>>      print()
>>>      print(f'all-{prefix}-targets = {all_targets}')
>>> @@ -83,14 +88,17 @@ def emit_prolog(suites, prefix):
>>>      print(f'\t$(MAKE) {prefix}$* MTESTARGS="$(MTESTARGS) --logbase {prefix}-report$*" && ln -f meson-logs/$@ .')
>>>  
>>>  def emit_suite(name, suite, prefix):
>>> +    tgtname = target_name(name)
>>>      deps = ' '.join(sorted(suite.deps))
>>>      print()
>>> -    print(f'.{prefix}-{name}.deps = {deps}')
>>> -    print(f'.ninja-goals.check-build += $(.{prefix}-{name}.deps)')
>>> +    print(f'.{prefix}-{tgtname}.deps = {deps}')
>>> +    print(f'.ninja-goals.check-build += $(.{prefix}-{tgtname}.deps)')
>>>  
>>>      names = ' '.join(sorted(suite.names(name)))
>>> -    targets = f'{prefix}-{name} {prefix}-report-{name}.junit.xml'
>>> -    if not name.endswith('-slow') and not name.endswith('-thorough'):
>>> +    targets = f'{prefix}-{tgtname} {prefix}-report-{tgtname}.junit.xml'
>>> +    if not name.endswith('-slow') and \
>>> +       not name.endswith('-thorough') and \
>>> +       not name.endswith('-optional'):
>>>          targets += f' {prefix} {prefix}-report.junit.xml'
>>>      print(f'ifneq ($(filter {targets}, $(MAKECMDGOALS)),)')
>>>      # for the "base" suite possibly add FOO-slow and FOO-thorough
>>
>> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>
>> Not blocking this patch, thus reviewed, but I think it would be a better
>> abstraction to use meson suites for this (a test can be added in
>> multiple suites), instead of adding more clunk to makefile layer.
> 
> This *is* using meson suites. The mtest2make script takes the list
> of meson suites and generates makefile targets which can be used to
> select execution of the meson suites. This change is exposing more
> of the suites as makefile targets, since make is our primary entry
> point.
> 
> 
> With regards,
> Daniel

Maybe I can't read this patch correctly, but from it, and the message
description, I understand that -optional is a pure Makefile abstraction,
and does not reflect any real meson suite.

```
This modifies mtest2make.py to support this idea by allowing for a new
suffix '-optional' on a suite. When this is present, a correspondingly
named make target will be created without the '-optional' suffix which
will never be run automatically.
```

Regards,
Pierrick

