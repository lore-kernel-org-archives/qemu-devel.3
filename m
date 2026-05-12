Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DB23BCD4F24
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 16:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMppv-0003Nm-6z; Tue, 12 May 2026 12:19:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMppq-0003Mi-60
 for qemu-devel@nongnu.org; Tue, 12 May 2026 12:19:55 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMppm-0008Ox-QW
 for qemu-devel@nongnu.org; Tue, 12 May 2026 12:19:52 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CB5N5Z591937
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 16:19:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 1+VBAzdK5VZ9l0emB2VyWn6IxnHcmWQFf+RYrtwi09c=; b=TSi52WzoKLal3L/i
 N3YR5VhFvqsCs3nUKiIANtQzK3VrfuYG/X0mubLO42UeQE6Ndf5eUQ1677aEiJju
 30VmejfDWR9EL2m7IrTrnteXx4FhuX/zIOBzWMTfnmBMXnEPtVW17pYCudTdURRz
 4Rh8lr7MDM9VzhGgG3VZixWl8rHmTXLZ+xs0unQzI9sgChESzGO0U5xNkZJ/U+Dp
 9dSzdQGSSgAQyYKKO4tj6+PoF/ObJKal16LktImmO6tk2+6o5Ojk1WwnBvvFjckW
 dLt6juIBOs3iEW9ekSf/KW7Cpb5PdZTK91Yr4flIC5cIcEWK6zp3bP/huS/eVeYV
 17onYQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e4319s9e2-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 16:19:49 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2bda35eab74so4609403eec.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 09:19:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778602788; x=1779207588; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=1+VBAzdK5VZ9l0emB2VyWn6IxnHcmWQFf+RYrtwi09c=;
 b=GI2NDecMx4SubS4M8e08TNLsPnmN6d/kJU7D2cwijJCmgn4q2NeTOC2DZCCIkIh5Td
 bPVKcC0klRKgRQBdFFHcUjJpupUqqQS+OYwSz6KbjWLW9BZw0w70RzolbvujnVKtwr56
 iCZOaGBsHUWsGgVOqUoaxYJ5FhU2HZv/hg4fSl3nQn/ys0Te5KHy2c+ivKVSYVbrNR+i
 R3E+5Br43eyvx9y9BF3tHlHmtgy0DxVfnnM2jt5EwKI2ix/XsGlsxU51DgzP2wL1Upjp
 b0QBtxQA8fH62fj2PUbWUiHeRcggU/QaFvkUIItITvg1oDloAKCJJVH8HAgOaLLqawAo
 UiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778602788; x=1779207588;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1+VBAzdK5VZ9l0emB2VyWn6IxnHcmWQFf+RYrtwi09c=;
 b=iI9Nm6ljo46GPPXpED1NJRxsKQ4lUYv5hZuy4k3uoH8JF5Q3EmryozKzoNhKp5mt6P
 2ovq31+QeDSaVriWv6z6Xge4xBzmhqT8j4qdGJDp3o5I/yXeYJlVrtroiVLCiEJaldLi
 oy4q9x+XZjtKWczQP7z4KBQakodtJodb4xBO1N7VxJSWg3xPaGRn0amxm7rS2uWPWZgX
 WEfoxtPfG5XqWub9Bz/+UxrKW8nd0ZtOz//35AgGKyv++bQbtnAFZvZhf6JG4+sN/6Gx
 QiSk5n36S31bCIvZiH/+FQNKMkvRkhTlp6fqasksH6aZBrBuzjNOqGe/7s7jd+DyBIcn
 IxSQ==
X-Gm-Message-State: AOJu0YxVJm0ZHpaEHgmBnZvSiwwHfSyN4qAmcPuR8OKGP52718sLKOFl
 E3SKxQ2nc6UHC+MJZPmcMV/4/3o+dkbbND/YT2yBUOJ+YfbwWqN4aDMg8FBY6Xa/oQxMQRr6bKX
 H6/7kUBeBolFsNtdqIL4bMIJ1LGJn9l7wE/iklX/UTbdUlPKrMAn0pYU14Q==
X-Gm-Gg: Acq92OHCnwjoR/rhQdlsYXmMZQhPHQOuYGrwASxhoGb+ScDniRZw1Kt22mLtyJnkKUk
 pV6jJh6tjsziHaigR13JHrVDVQhy6iaheiYvethMTFacnxk+YeAASLunnfrXfOsmgjPXvN7NsPG
 ZXfBDqOY3BFFecKqyx9f5UxJQj+c7dzwXUhZmRk/RhUw2j71GbxtuNy8qoUNQUIUuizIVbylAQ6
 HzCmccg2yafI60HMvM4pAVeiaoCu8WSnECEivr9HOaVCCAJIpWKYX0Ona9nfVLx/br++eaTK+4Q
 Ivd0rt/NgzpSWVfrsYrtxAmNB510mZrdIQNfICjuApvBX/pJA8gifB1+DwPS4DcTyhXyT05YObv
 BpmKezjQKIJP8XQm/qXvfSAg8lBnUQQnIbNeJKRwlf3MwzxDTn2HWG2KfsiffJE2jj7hG3nnQlw
 qVsPw/A4w/rIZyNQ==
X-Received: by 2002:a05:7300:748e:b0:2ed:e16:6b37 with SMTP id
 5a478bee46e88-2ff943ed315mr2593420eec.15.1778602788043; 
 Tue, 12 May 2026 09:19:48 -0700 (PDT)
X-Received: by 2002:a05:7300:748e:b0:2ed:e16:6b37 with SMTP id
 5a478bee46e88-2ff943ed315mr2593392eec.15.1778602787446; 
 Tue, 12 May 2026 09:19:47 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f888e381c9sm18129955eec.26.2026.05.12.09.19.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 09:19:46 -0700 (PDT)
Message-ID: <cc8714c3-143d-4f63-a608-d301e8ba023b@oss.qualcomm.com>
Date: Tue, 12 May 2026 09:19:45 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/16] tests: add QEMU_TEST_IO_SKIP for skipping I/O tests
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-block@nongnu.org, Cleber Rosa <crosa@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>
References: <20260424154205.364268-1-berrange@redhat.com>
 <20260424154205.364268-15-berrange@redhat.com>
 <fa8be3d8-6d76-4811-83ab-69c256e8e44f@oss.qualcomm.com>
 <agNPkLRe0Rf4NYcU@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <agNPkLRe0Rf4NYcU@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE2OSBTYWx0ZWRfX5TnKlph+2oJB
 Abx1VAcE91JiNlmqAc/XOsnyGZaRwCQ4U4Fly0nOBRZwkKDMb0K/h//MClRmvumIDgAHmVqVJU2
 OcytPvhxnEYtDnPVo8XAOLY4nSxK61JJy1CE06bfH+E/FVL3Af+uod8SgUK7gznoxAZBRQPtpN9
 M+9c5s2pA4Ujx1Yp2Ehm5qSYNAaGJzNVkwDZcmw84sdJbj0CUvit2zQ5+2TQ3llW5STcGMX++4h
 /ZG4op39lCTF6+Qa+1+Va8Dvu1GU2Bw8MUtNh7Qs3Jigr6vHHD1ZVmKSpZ9b3Dn9huJ0kvKOKih
 NjW9HE37Jp/hOkDBwBWFG6d13vYPyOdNYWZx8hQ1ucYIL3Tie8hTi16Yk9ASLkRauOv5dmTsyJ8
 EkFbHwedO97sikaOUmv4wup2GYNDeutM1LW1pvL2QHV8XgrhxDUb1PxLeJIAcVS5njVoZAxdwDF
 TD6hMpzq/QoW9W/87aA==
X-Proofpoint-GUID: Ww0jK0iv6N8QMHAaLQIfIJB1vLjsseAd
X-Authority-Analysis: v=2.4 cv=bp98wkai c=1 sm=1 tr=0 ts=6a035325 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=20KFwNOVAAAA:8 a=ERjs-R0v0R5jnaaS1A4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: Ww0jK0iv6N8QMHAaLQIfIJB1vLjsseAd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 adultscore=0 clxscore=1015 bulkscore=0 malwarescore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120169
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

On 5/12/2026 9:06 AM, Daniel P. Berrangé wrote:
> On Tue, May 12, 2026 at 08:56:54AM -0700, Pierrick Bouvier wrote:
>> On 4/24/2026 8:42 AM, Daniel P. Berrangé wrote:
>>> The nature of block I/O tests is such that there can be unexpected false
>>> positive failures in certain scenarios that have not been encountered
>>> before, and sometimes non-deterministic failures that are hard to
>>> reproduce.
>>>
>>> Before enabling the I/O tests as gating jobs in CI, there needs to be a
>>> mechanism to dynamically mark tests as skipped, without having to commit
>>> code changes.
>>>
>>> This introduces the QEMU_TEST_IO_SKIP environment variable that is set
>>> to a list of FORMAT-OR-PROTOCOL:NAME pairs. The intent is that this
>>> variable can be set as a GitLab CI pipeline variable to temporarily
>>> disable a test while problems are being debugged.
>>>
>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>> ---
>>>  docs/devel/testing/main.rst      |  7 +++++++
>>>  tests/qemu-iotests/testrunner.py | 16 ++++++++++++++++
>>>  2 files changed, 23 insertions(+)
>>>
>>> diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
>>> index 797111009a..f779a64415 100644
>>> --- a/docs/devel/testing/main.rst
>>> +++ b/docs/devel/testing/main.rst
>>> @@ -284,6 +284,13 @@ that are specific to certain cache mode.
>>>  More options are supported by the ``./check`` script, run ``./check -h`` for
>>>  help.
>>>  
>>> +If a test program is known to be broken, it can be disabled by setting
>>> +the ``QEMU_TEST_IO_SKIP`` environment variable with a list of tests to
>>> +be skipped. The values are of the form FORMAT-OR-PROTOCOL:NAME, the
>>> +leading component can be omitted to skip the test for all formats and
>>> +protocols. For example ``export QEMU_TEST_IO_SKIP="luks:149 185 iov-padding``
>>> +will skip ``149`` for LUKS only, and ``185`` and ``iov-padding`` for all.
>>> +
>>>  Writing a new test case
>>>  ~~~~~~~~~~~~~~~~~~~~~~~
>>>  
>>> diff --git a/tests/qemu-iotests/testrunner.py b/tests/qemu-iotests/testrunner.py
>>> index dbe2dddc32..ecb5d4529f 100644
>>> --- a/tests/qemu-iotests/testrunner.py
>>> +++ b/tests/qemu-iotests/testrunner.py
>>> @@ -145,6 +145,18 @@ def __init__(self, env: TestEnv, tap: bool = False,
>>>  
>>>          self._stack: contextlib.ExitStack
>>>  
>>> +        self.skip = {}
>>> +        for rule in os.environ.get("QEMU_TEST_IO_SKIP", "").split(" "):
>>> +            rule = rule.strip()
>>> +            if rule == "":
>>> +                continue
>>> +            if ":" in rule:
>>> +                fmt, name = rule.split(":")
>>> +                if fmt in ("", env.imgfmt, env.imgproto):
>>> +                    self.skip[name] = True
>>> +            else:
>>> +                self.skip[rule] = True
>>> +
>>>      def __enter__(self) -> 'TestRunner':
>>>          self._stack = contextlib.ExitStack()
>>>          self._stack.enter_context(self.env)
>>> @@ -251,6 +263,10 @@ def do_run_test(self, test: str) -> TestResult:
>>>                                description='No qualified output '
>>>                                            f'(expected {f_reference})')
>>>  
>>> +        if f_test.name in self.skip:
>>> +            return TestResult(status='not run',
>>> +                              description='Listed in QEMU_TEST_IO_SKIP')
>>> +
>>>          args = [str(f_test.resolve())]
>>>          env = self.env.prepare_subprocess(args)
>>>  
>>
>> Why not simply remove the broken tests, and create issues to add them
>> again in the future?
> 
> In theory that's what our policy today is, but in practice it is
> too much of a burden on the release co-ordinator, to expect them
> to create such a patch themselves, or wait on a subsys maintainer
> todo it for them.
> 
> They end up just ignoring brokenness in CI which is a bad practice,
> and will prevent us ever making CI truely gating or switching to
> using MRs for pull requests. This gives us a super-fast way to skip
> flaky tests, while the subsystem maintainers figure out the right
> permanent answer.
>

I disagree on this one, merging a single patch doing a git rm, and a git
revert later is not more expensive than merging a variable modifying a
variable in a yaml file.

The issue with this approach is that people running tests locally will
not see which tests are skipped, and will see false positives. So you
just keep CI green, but not the test base itself.

The risk I see is that some tests will stay forever in this skip
variable, so it will be dead code for CI, but still alive and failing
for people running tests manually who hit the regression.

If you still want an alternative to removing test, implementing a
skip_list in tests/qemu-iotests/meson.build is better than an env var
IMHO, and achieves the exact same effect, for CI and for users.

What do you think?

>> Once it's green, in theory, code breaking existing tests should not be
>> merged, right? So what would be the usage of this variable?
> 
> We have had a pretty decent chunk of non-deterministic test failures,
> so there is high likelihood we can merge stuff that passes once and
> then subsequently fails some subset of the time. This non-determinism
> is one of the key reasons that we currently only have a hand picked
> selection of block I/O tests run by meson.
> 
> While I've tested this series and haven't see any non-determinstic
> failures in what I'm proposing to enable thus far, I think there is
> still a pretty high chance we'll uncover some more.
>

Fair point.

> With regards,
> Daniel


