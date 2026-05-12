Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4964DCD4F25
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 16:48:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMqGQ-0002AG-4O; Tue, 12 May 2026 12:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMqGO-00029J-DT
 for qemu-devel@nongnu.org; Tue, 12 May 2026 12:47:20 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMqGL-0004Yv-TL
 for qemu-devel@nongnu.org; Tue, 12 May 2026 12:47:19 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CGjWp8740295
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 16:47:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 3yh9cfusnvR9C8pDlfwha0HpOSmkqLK7GcKOLa5qijk=; b=RIj7MZnEVjf5ncaP
 gYUpWd4Q6jBpYViv7LtzjFhj4oCxuFFJRmXR/LE8dEX0VYOBnVL+eb0VAJffKugy
 Jt8z3YGJAig7vcLhXsEBfyhGJV8ZrxLvDS97Avn5pgL/KQZZHGTJg4+IWJ54OtjT
 47DGGH4yw9dMFK0XlUBumqf9L7lgnOMz9KjgE8qzODMFWtywrw0DaHR5swQbvp6n
 kk5sMAC3CRoNJLw/ziLhnOLJV5iMWHXnqYKlxSHenoLkivErO0YwN0hmEXN56nvi
 yzjWPGgpB4+haSCBJ2UzgJ4sMn0tK9E2xT3LRRGLigJ03cRqeHGfdCMhzqfQaCtz
 t92doQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e42rhsjsa-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 16:47:16 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2c16233ee11so7781866eec.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 09:47:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778604436; x=1779209236; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3yh9cfusnvR9C8pDlfwha0HpOSmkqLK7GcKOLa5qijk=;
 b=DTvDmlo0+oAlKgIHS9wrpB1Iba8QflgidyvG6KzmhYxYUZpgkqRL5WnrXCVotLN1EJ
 dWKfYZC9OAQAAmQmTvGolmEEwXh4Aori/JC2JBXFyAlGG8seosbjegjtEw1IhMnb4klc
 JjJxIFP8uuF7eWBeIV3XLIWoSC9N05/ZfUR+06IUqivnKzh2SUpbNXBecVgrDzYCpTwZ
 swOoXCIMFl6zaEGPgzYPR2t2mqjCxAwkSQuXhhNS7yTTRxgSIop2+3BVHnSzDqy2ByD2
 PrXfhtWSvcoTMkZektSZGcOdH7KJL8DbtrnRDlEGyQ/ofaqAH6D3P7nXdhe3KmjG4rTO
 oaeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778604436; x=1779209236;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3yh9cfusnvR9C8pDlfwha0HpOSmkqLK7GcKOLa5qijk=;
 b=rvwEjk0Zhs/EE4xpRS+qZm7qgi9Us5N1PJSs5R/50t5CYZfzmsfSOvhIJCQKvWgVqE
 XCdGPIOXbk5Bk3G7NZCClb5uetWvBk/Lz8uSOf2oRHkZMh2xbk/pNL/RIPrx+nc6AAxe
 aYpNNpQCio+03Q4MENA8HQuxZ/XovS/HTK7eCExJQOVdRm+nvew3yiXnarhCT+MYTQdl
 f6DHQ/XLbo7VawuUnyp8mylx5EG/0mQPzb2HEcVs6aWblsQX3GxnyQScNNktODKhrmBi
 Zhv5I4LeIrDR0Y2vFm+6M/lrWxLEoPVWqQTYFrW+gmSUMeETnNEkNRfs3acVe+dD56Zd
 Tpqw==
X-Gm-Message-State: AOJu0Yz12K8VWgCqxvQup6evfFgBSrONGJqyp+DkPjhNMAGUWFY/6O65
 Wvnp+PSncLM+R8OAQZRRRR7KwSytD4zJH6B72tIcM3OyR0B0j7aTt79QZvltjvbMv70Z0qHgzpa
 DXmepSRqj3WnXPZSH2FS1jE8fT3pr9cy0lldBe1Bl70TBAwZtn+Rnxm5MMA==
X-Gm-Gg: Acq92OFWeVqv86b8oVmCT2NWlIglCYzMIp2O9bnB1QNqzMjqaGZ3Hlk23O7L1W/8pce
 y1cHBXcwhdpxbVl7viOCADzL3UQG+nTdPLO0Jv/yci4yPb7Rq2hM9kGqmWODdf84AESvY3uDHzH
 +4NbMEnq142t6SwbX7zS4bZTOC15fs2JHI0Dkl/dethAFhIrDKsJlojNxpG7oksWBmwmcD5UrFD
 2XS1SLg7ABWmtheq+fHZfwzkbRRDxtyaI7hXQfqHeZ7T104fNN337fE12lj75NLIxveNuMCf2Ev
 d+e5pKN6KD+YSbE0f8IaPwNiVYPfak680mOuDLjNCvih4HptNNag8FVyPtWAW/7NxQgSu5c9Kyc
 44VVQJwR4pQKHXf235GdBmADSmcvOTCaYBsLbj8orTi32oH5YRHFqnQt0bnjQB/CXvBMUw1UEce
 0qBg9wGkuAiqGMjg==
X-Received: by 2002:a05:7301:6589:b0:2ea:edc0:4fbe with SMTP id
 5a478bee46e88-2fb4bff7bdfmr7755973eec.14.1778604435431; 
 Tue, 12 May 2026 09:47:15 -0700 (PDT)
X-Received: by 2002:a05:7301:6589:b0:2ea:edc0:4fbe with SMTP id
 5a478bee46e88-2fb4bff7bdfmr7755929eec.14.1778604434672; 
 Tue, 12 May 2026 09:47:14 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f888c3b301sm23263948eec.23.2026.05.12.09.47.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 09:47:14 -0700 (PDT)
Message-ID: <55b66ce4-218c-462f-8e48-0775d5c36cba@oss.qualcomm.com>
Date: Tue, 12 May 2026 09:47:12 -0700
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
 <cc8714c3-143d-4f63-a608-d301e8ba023b@oss.qualcomm.com>
 <agNXCf5eXNQmhCAV@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <agNXCf5eXNQmhCAV@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE3NCBTYWx0ZWRfX8X/j99H3q9nY
 ERRc0MmApqBYyw/175xm9MnCTrskTjuY1Fz/C9+5ekHuamw0hlX2TsettL2Apqi/bK60bU7Y6Bq
 OaoT3hjoFmlX5ZAhvo3NpxCQxr58edt3yPbBLjDezRztgqAi6lS7bstDAXM96TioDe7rCW+GcUT
 hKVh5QmeB/HNPeyY2+YJqIVl5weGuukYFcUlgEb2NiJHPg7+wVJ/LZcVJlzhia/eSjvYzyAAm94
 4KdOmwZZuj4l9/n2nqMGVOnYKxAHeAOMsNQjFFbluwN5ztDXGr/OSV103M7w4duyCT/dKOGzQ7Z
 vJl85Q5ZHzLwoiF0GijT68JR55dQVZ7FV6hlyD0xGSzsQa4x1d66AQPJboYYGqerSz16z5PiB+x
 UYjT2InE7rtnZFzOzW8wO0hRGvC8DrM/PO6XqcKZOB/q1OI4Cw/nX2mPFE8NO5GDGA+pDzmp03m
 I1zBJ7+O6mMfbdXo+RQ==
X-Proofpoint-GUID: DAW-1ugYAGoEQfL7INiqMpGBslQr5Vep
X-Authority-Analysis: v=2.4 cv=GbMnWwXL c=1 sm=1 tr=0 ts=6a035994 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=aYdDyIVy427u4Ctd8iEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-ORIG-GUID: DAW-1ugYAGoEQfL7INiqMpGBslQr5Vep
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120174
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

On 5/12/2026 9:36 AM, Daniel P. Berrangé wrote:
> On Tue, May 12, 2026 at 09:19:45AM -0700, Pierrick Bouvier wrote:
>> On 5/12/2026 9:06 AM, Daniel P. Berrangé wrote:
>>> On Tue, May 12, 2026 at 08:56:54AM -0700, Pierrick Bouvier wrote:
>>>> On 4/24/2026 8:42 AM, Daniel P. Berrangé wrote:
>>>>> The nature of block I/O tests is such that there can be unexpected false
>>>>> positive failures in certain scenarios that have not been encountered
>>>>> before, and sometimes non-deterministic failures that are hard to
>>>>> reproduce.
>>>>>
>>>>> Before enabling the I/O tests as gating jobs in CI, there needs to be a
>>>>> mechanism to dynamically mark tests as skipped, without having to commit
>>>>> code changes.
>>>>>
>>>>> This introduces the QEMU_TEST_IO_SKIP environment variable that is set
>>>>> to a list of FORMAT-OR-PROTOCOL:NAME pairs. The intent is that this
>>>>> variable can be set as a GitLab CI pipeline variable to temporarily
>>>>> disable a test while problems are being debugged.
>>>>>
>>>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>>>> ---
>>>>>  docs/devel/testing/main.rst      |  7 +++++++
>>>>>  tests/qemu-iotests/testrunner.py | 16 ++++++++++++++++
>>>>>  2 files changed, 23 insertions(+)
>>>>>
>>>>> diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
>>>>> index 797111009a..f779a64415 100644
>>>>> --- a/docs/devel/testing/main.rst
>>>>> +++ b/docs/devel/testing/main.rst
>>>>> @@ -284,6 +284,13 @@ that are specific to certain cache mode.
>>>>>  More options are supported by the ``./check`` script, run ``./check -h`` for
>>>>>  help.
>>>>>  
>>>>> +If a test program is known to be broken, it can be disabled by setting
>>>>> +the ``QEMU_TEST_IO_SKIP`` environment variable with a list of tests to
>>>>> +be skipped. The values are of the form FORMAT-OR-PROTOCOL:NAME, the
>>>>> +leading component can be omitted to skip the test for all formats and
>>>>> +protocols. For example ``export QEMU_TEST_IO_SKIP="luks:149 185 iov-padding``
>>>>> +will skip ``149`` for LUKS only, and ``185`` and ``iov-padding`` for all.
>>>>> +
>>>>>  Writing a new test case
>>>>>  ~~~~~~~~~~~~~~~~~~~~~~~
>>>>>  
>>>>> diff --git a/tests/qemu-iotests/testrunner.py b/tests/qemu-iotests/testrunner.py
>>>>> index dbe2dddc32..ecb5d4529f 100644
>>>>> --- a/tests/qemu-iotests/testrunner.py
>>>>> +++ b/tests/qemu-iotests/testrunner.py
>>>>> @@ -145,6 +145,18 @@ def __init__(self, env: TestEnv, tap: bool = False,
>>>>>  
>>>>>          self._stack: contextlib.ExitStack
>>>>>  
>>>>> +        self.skip = {}
>>>>> +        for rule in os.environ.get("QEMU_TEST_IO_SKIP", "").split(" "):
>>>>> +            rule = rule.strip()
>>>>> +            if rule == "":
>>>>> +                continue
>>>>> +            if ":" in rule:
>>>>> +                fmt, name = rule.split(":")
>>>>> +                if fmt in ("", env.imgfmt, env.imgproto):
>>>>> +                    self.skip[name] = True
>>>>> +            else:
>>>>> +                self.skip[rule] = True
>>>>> +
>>>>>      def __enter__(self) -> 'TestRunner':
>>>>>          self._stack = contextlib.ExitStack()
>>>>>          self._stack.enter_context(self.env)
>>>>> @@ -251,6 +263,10 @@ def do_run_test(self, test: str) -> TestResult:
>>>>>                                description='No qualified output '
>>>>>                                            f'(expected {f_reference})')
>>>>>  
>>>>> +        if f_test.name in self.skip:
>>>>> +            return TestResult(status='not run',
>>>>> +                              description='Listed in QEMU_TEST_IO_SKIP')
>>>>> +
>>>>>          args = [str(f_test.resolve())]
>>>>>          env = self.env.prepare_subprocess(args)
>>>>>  
>>>>
>>>> Why not simply remove the broken tests, and create issues to add them
>>>> again in the future?
>>>
>>> In theory that's what our policy today is, but in practice it is
>>> too much of a burden on the release co-ordinator, to expect them
>>> to create such a patch themselves, or wait on a subsys maintainer
>>> todo it for them.
>>>
>>> They end up just ignoring brokenness in CI which is a bad practice,
>>> and will prevent us ever making CI truely gating or switching to
>>> using MRs for pull requests. This gives us a super-fast way to skip
>>> flaky tests, while the subsystem maintainers figure out the right
>>> permanent answer.
>>>
>>
>> I disagree on this one, merging a single patch doing a git rm, and a git
>> revert later is not more expensive than merging a variable modifying a
>> variable in a yaml file.
> 
> Any code changes like that need to be sent back to the subsystem
> maintainer to be acked. IMHO the release manager should not be
> unilaterally deleting tests without peer review.  So that's
> got a non-negligible turn around time, during which CI is broken.
>

I accept the argument, but it seems like a workaround for a human
process, more than a proper solution to the problem.

It would be better to have a proper policy for build/test fixes, instead
of implementing local overrides to this.

> Setting an env variable to skip a problematic test is something
> reasonable to do with zero oversight.
> 
>> The issue with this approach is that people running tests locally will
>> not see which tests are skipped, and will see false positives. So you
>> just keep CI green, but not the test base itself.
> 
> I would still expect the release manager to file a bug about any
> flaky test they disable via the env var, and the subsystem maintainer
> should still be fixing it or disabling it such that tests won't fail
> more broadly, or deciding to remove it if terminally broken.
> 
> We're just decoupling the process so that there is an immediate
> workaround possible. It can also be used by people working in
> their forks - often I've been testing stuff in my fork, but
> see spurious failures because git master has a non-deterministic
> test failure merged. I would like to easily skip those in my fork
> too, without adding extra commits to me working branches, as that
> would require the same commit to be duped into several in-progress
> branches, vs setting the env var once.
> 
>> The risk I see is that some tests will stay forever in this skip
>> variable, so it will be dead code for CI, but still alive and failing
>> for people running tests manually who hit the regression.
> 
> Again, there should be a bug filed for any flaky test. Anyone can
> do this, if they see it locally or in their fork CI, or in staging
> CI. If no one can see an obvious fix, then anyone can also propose
> to disable the test.
> 
>> If you still want an alternative to removing test, implementing a
>> skip_list in tests/qemu-iotests/meson.build is better than an env var
>> IMHO, and achieves the exact same effect, for CI and for users.
>>
>> What do you think?
> 
> IMHO there needs to be a way to skip flaky tests which does not
> require code changes as the only available option. Code changes
> are the permanent fix, env var is the immediate workaround.
>

I'm not sure all this answers to my question about How to ensure users
who run tests and the CI both see the same skip list.

I don't mind having an env var, a black list in meson or any other
solution, but having different results on a dev machine and in CI is not
a good design. So whatever the solution is, the CI yaml file is not the
proper place to store this information.

>>>> Once it's green, in theory, code breaking existing tests should not be
>>>> merged, right? So what would be the usage of this variable?
>>>
>>> We have had a pretty decent chunk of non-deterministic test failures,
>>> so there is high likelihood we can merge stuff that passes once and
>>> then subsequently fails some subset of the time. This non-determinism
>>> is one of the key reasons that we currently only have a hand picked
>>> selection of block I/O tests run by meson.
>>>
>>> While I've tested this series and haven't see any non-determinstic
>>> failures in what I'm proposing to enable thus far, I think there is
>>> still a pretty high chance we'll uncover some more.
>>>
>>
>> Fair point.
> 
> With regards,
> Daniel


