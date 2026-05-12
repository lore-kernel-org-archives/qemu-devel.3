Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC567CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 17:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMrIO-0002C5-A6; Tue, 12 May 2026 13:53:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMrIB-0002An-ET
 for qemu-devel@nongnu.org; Tue, 12 May 2026 13:53:17 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMrI6-0005lh-Pm
 for qemu-devel@nongnu.org; Tue, 12 May 2026 13:53:14 -0400
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CGjW19740295
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 17:53:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 tNIa0w50nrPAqHBCJxuAfdD613RgPb0sl3GAwAZ20pE=; b=mWm0bx4RShiCc3Kc
 MD3Ok9azGnsbFuShssCFys/Ir0hnQwULx7Yp0CPWBLC0m+keG8NqjS6+eJXosjcq
 bR+VVdQhJnkxnLkReGHCGSV65HbbDw/CgNT1B+zuUqz4oUibIGOYcAXx0iAosC2o
 3jnplynANrbuZe+5lLskR23Xh8lX3AT3laes9klsccVtWMRMHy2KuhqUzO0VIZ6K
 Dd+ARoG5NGk/p/P0R968vSO9rcZi22IYxH4fgnKtvimjLhgXR4g0HuB8OkCnjb55
 vbXW4zn+5os2sIPQwVRO2wPD35RphsJFKPHET3T4DnL7IjTaxD/mB7U+Y3NmsGNR
 D7dWpQ==
Received: from mail-dl1-f71.google.com (mail-dl1-f71.google.com [74.125.82.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e42rhstwq-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 17:53:08 +0000 (GMT)
Received: by mail-dl1-f71.google.com with SMTP id
 a92af1059eb24-13312be8a31so9363720c88.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 10:53:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778608388; x=1779213188; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tNIa0w50nrPAqHBCJxuAfdD613RgPb0sl3GAwAZ20pE=;
 b=Erl+tKvDaJdZkQdRmlOM0oJ+c7NZXyQHjLjewRTbiKXkOMiBzMI5kMCCpb/gmFjzvx
 d1vWZis/UfBDmdbeCEkjhc1lFC7A5Q1hOMYNBV644u5s8WFPysssgdq0dMjC5MjbWaRH
 iYzuKAFUl5T6oNLfjVyy4kHAZq/HmZHdRTcs3Jh9CIdYldIVSeIZ7+K3Wnnr6hh0CJRf
 8x8Wjpar1RMvrcKBGl3Dc5maDz2zK7TnzFzwjb7PhVBsvfq+O9ieI1Em8q23ON69gS8Y
 ueFU78LO+ZrMx/SCaRLZywtoNP5DfmyAIAhyJzdCUbPo6ktYNl7/8pl/BN+Bilay6dZj
 r8Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778608388; x=1779213188;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tNIa0w50nrPAqHBCJxuAfdD613RgPb0sl3GAwAZ20pE=;
 b=D4ZlKPQSze7uBhfw/6wz6SovLRrJZtUG3+5gHsz1/qW4Vo/dgz/ESFcRfMQbkFCxON
 VjJWTZvaTMSj4X2CarOuI+6MvGJ2ufVaLAJ8gvgA3Fya1rfRyxcPSwInWyc+e6y6zD1E
 RxaQ0mvRDPRJKNn+W/Hz6ji/fF2RARBcWsYO1BmqfjcOkb+7yrkMMNUQAZpdp12sHwJN
 UP0gtYbSmIWtTOHNxe32HxmE4ldqvzD4zo4cvMcPR4R4OChzgUoq6kiZ4y9/l/EQQrTd
 s2rFwQn+EQA+3UQHT+masUHkQCE8Peuc97N1fJZmCICxyF345MKwyUNJYENKnUcNb8Rw
 8vLw==
X-Gm-Message-State: AOJu0YyVY7O6PHxulGqeeFfqne5nhDbvme+JI8UioA5jlsIzRqlv3SJa
 sj3gE7G2TsmNgD2hWGx6bp26FGhZYgsTKS7GFRU7Gzy3NETCpmIM8Z8plc8J6QG0QRcd6vOQ9um
 nt59r15xeiNk540HSS9eDz5UrgoweGGEs8/UWpTm2BWF8D9qbQYmBtC9W3w==
X-Gm-Gg: Acq92OH20IgNaM6nPBjFGcU+qgQHiciXAwtNEKtx3jWOpnDjTUSzhQlnyxZ01ujpq09
 zdQzN13Hy6BurnMqfCAWUYusEjFu2x/PeuOoZobNSn0upXzHxBw+rzbJ2D2FNisCdXsPgFam6pU
 cimQ1ACfH6L9kOVQL9e3r7CmLLUHwbrdv93ff6pUkGWOlHUxVDAfumVRDHeBYGcSizr1xVsg1B4
 F1T1epypar4Bf/7ugIipn2hggC4t1p8jztbm0R9NdYIilTDApYtiYgrT6zhlAGF9G0Xt0NA0rjM
 DJhIRu940elwWqRPn+KM7M/BK9UrJa/AwT72FloIQYt+4UnyaCyDDNaUIRJLVfLgxX8XWRugNAo
 2R9gnMFXLaeMcUPmJfoEBzG7HbFb6Kg2TXvFUkmgNzgTMDoL59Zi4JYuau8v1wId2jnpxtl6dDm
 muBGm1QcyZCTqEbg==
X-Received: by 2002:a05:7022:2509:b0:130:9bce:c60f with SMTP id
 a92af1059eb24-13271377e33mr11561189c88.14.1778608387771; 
 Tue, 12 May 2026 10:53:07 -0700 (PDT)
X-Received: by 2002:a05:7022:2509:b0:130:9bce:c60f with SMTP id
 a92af1059eb24-13271377e33mr11561155c88.14.1778608387000; 
 Tue, 12 May 2026 10:53:07 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13277bb2b14sm25480959c88.0.2026.05.12.10.53.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 10:53:06 -0700 (PDT)
Message-ID: <cd3c6a2a-96ad-4276-aa61-8d458d702ba5@oss.qualcomm.com>
Date: Tue, 12 May 2026 10:53:05 -0700
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
 <55b66ce4-218c-462f-8e48-0775d5c36cba@oss.qualcomm.com>
 <agNbJS1WeWaxZ_Gx@redhat.com>
 <31eb8204-97bb-4f0e-b90a-048d1b5bf05d@oss.qualcomm.com>
 <agNiPRnoyxd7rBbz@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <agNiPRnoyxd7rBbz@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE4NSBTYWx0ZWRfX7BFUU45vKHwn
 Bx8vlQdficihf7FS9C9JkZzX0Im/r9gSU/57XRGdv7uX5ZgJQkYW5iuZek3kTSfZ61aKW1QuRqk
 m3GJU6DgvqC+0YPtPfVoDhjdg1919yq5TiadIcwyd2j6cnH463hOkQw2Npvrwq7dxKsGCdipFYY
 p0SmrkBpWuGCB7aCr+FIvW2x2v1z+vUIsU4/VJVXTorcJq/whFVNmLynVuLPM9DxPbwHA5VbG8Y
 VNEKF0DRhzlWuClxdn+o4J6SdesOZcLnXFFXQqRHgH1SPKBYFopbms7OO0WQFvhKLWu4IkuSGDS
 7MCXNKEucZBCmclnmLHM/bm7jbMtCkrFfuH87OHiXdkRWfARHdgSOVH9V2aK9vLQ65VLbGxYZY7
 Ld9S8NgW3QARWxFVyF6i7LScA+M/pCz+YOqX5v0YTSY7683grIUDheL96KRPG0XwXcUkrzKj1pe
 oAWx7t+206LJu03P0ag==
X-Proofpoint-GUID: 4pCJ3iwJ-XtjE78AX6aqSbI2r-f2rcWc
X-Authority-Analysis: v=2.4 cv=GbMnWwXL c=1 sm=1 tr=0 ts=6a036904 cx=c_pps
 a=JYo30EpNSr/tUYqK9jHPoA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22
 a=20KFwNOVAAAA:8 a=hEIxy1abHuJ2NYeIue0A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=Fk4IpSoW4aLDllm1B1p-:22
X-Proofpoint-ORIG-GUID: 4pCJ3iwJ-XtjE78AX6aqSbI2r-f2rcWc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 bulkscore=0 adultscore=0 clxscore=1015
 priorityscore=1501 suspectscore=0 lowpriorityscore=0 impostorscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605050000
 definitions=main-2605120185
Received-SPF: pass client-ip=205.220.180.131;
 envelope-from=pierrick.bouvier@oss.qualcomm.com;
 helo=mx0b-0031df01.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/12/2026 10:24 AM, Daniel P. Berrangé wrote:
> On Tue, May 12, 2026 at 10:09:53AM -0700, Pierrick Bouvier wrote:
>> On 5/12/2026 9:53 AM, Daniel P. Berrangé wrote:
>>> On Tue, May 12, 2026 at 09:47:12AM -0700, Pierrick Bouvier wrote:
>>>> On 5/12/2026 9:36 AM, Daniel P. Berrangé wrote:
>>>>> On Tue, May 12, 2026 at 09:19:45AM -0700, Pierrick Bouvier wrote:
>>>>>> On 5/12/2026 9:06 AM, Daniel P. Berrangé wrote:
>>>>>>> On Tue, May 12, 2026 at 08:56:54AM -0700, Pierrick Bouvier wrote:
>>>>>>>> On 4/24/2026 8:42 AM, Daniel P. Berrangé wrote:
>>>>>>>>> The nature of block I/O tests is such that there can be unexpected false
>>>>>>>>> positive failures in certain scenarios that have not been encountered
>>>>>>>>> before, and sometimes non-deterministic failures that are hard to
>>>>>>>>> reproduce.
>>>>>>>>>
>>>>>>>>> Before enabling the I/O tests as gating jobs in CI, there needs to be a
>>>>>>>>> mechanism to dynamically mark tests as skipped, without having to commit
>>>>>>>>> code changes.
>>>>>>>>>
>>>>>>>>> This introduces the QEMU_TEST_IO_SKIP environment variable that is set
>>>>>>>>> to a list of FORMAT-OR-PROTOCOL:NAME pairs. The intent is that this
>>>>>>>>> variable can be set as a GitLab CI pipeline variable to temporarily
>>>>>>>>> disable a test while problems are being debugged.
>>>>>>>>>
>>>>>>>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>>>>>>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>>>>>>>> ---
>>>>>>>>>  docs/devel/testing/main.rst      |  7 +++++++
>>>>>>>>>  tests/qemu-iotests/testrunner.py | 16 ++++++++++++++++
>>>>>>>>>  2 files changed, 23 insertions(+)
>>>>>>>>>
>>>>>>>>> diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
>>>>>>>>> index 797111009a..f779a64415 100644
>>>>>>>>> --- a/docs/devel/testing/main.rst
>>>>>>>>> +++ b/docs/devel/testing/main.rst
>>>>>>>>> @@ -284,6 +284,13 @@ that are specific to certain cache mode.
>>>>>>>>>  More options are supported by the ``./check`` script, run ``./check -h`` for
>>>>>>>>>  help.
>>>>>>>>>  
>>>>>>>>> +If a test program is known to be broken, it can be disabled by setting
>>>>>>>>> +the ``QEMU_TEST_IO_SKIP`` environment variable with a list of tests to
>>>>>>>>> +be skipped. The values are of the form FORMAT-OR-PROTOCOL:NAME, the
>>>>>>>>> +leading component can be omitted to skip the test for all formats and
>>>>>>>>> +protocols. For example ``export QEMU_TEST_IO_SKIP="luks:149 185 iov-padding``
>>>>>>>>> +will skip ``149`` for LUKS only, and ``185`` and ``iov-padding`` for all.
>>>>>>>>> +
>>>>>>>>>  Writing a new test case
>>>>>>>>>  ~~~~~~~~~~~~~~~~~~~~~~~
>>>>>>>>>  
>>>>>>>>> diff --git a/tests/qemu-iotests/testrunner.py b/tests/qemu-iotests/testrunner.py
>>>>>>>>> index dbe2dddc32..ecb5d4529f 100644
>>>>>>>>> --- a/tests/qemu-iotests/testrunner.py
>>>>>>>>> +++ b/tests/qemu-iotests/testrunner.py
>>>>>>>>> @@ -145,6 +145,18 @@ def __init__(self, env: TestEnv, tap: bool = False,
>>>>>>>>>  
>>>>>>>>>          self._stack: contextlib.ExitStack
>>>>>>>>>  
>>>>>>>>> +        self.skip = {}
>>>>>>>>> +        for rule in os.environ.get("QEMU_TEST_IO_SKIP", "").split(" "):
>>>>>>>>> +            rule = rule.strip()
>>>>>>>>> +            if rule == "":
>>>>>>>>> +                continue
>>>>>>>>> +            if ":" in rule:
>>>>>>>>> +                fmt, name = rule.split(":")
>>>>>>>>> +                if fmt in ("", env.imgfmt, env.imgproto):
>>>>>>>>> +                    self.skip[name] = True
>>>>>>>>> +            else:
>>>>>>>>> +                self.skip[rule] = True
>>>>>>>>> +
>>>>>>>>>      def __enter__(self) -> 'TestRunner':
>>>>>>>>>          self._stack = contextlib.ExitStack()
>>>>>>>>>          self._stack.enter_context(self.env)
>>>>>>>>> @@ -251,6 +263,10 @@ def do_run_test(self, test: str) -> TestResult:
>>>>>>>>>                                description='No qualified output '
>>>>>>>>>                                            f'(expected {f_reference})')
>>>>>>>>>  
>>>>>>>>> +        if f_test.name in self.skip:
>>>>>>>>> +            return TestResult(status='not run',
>>>>>>>>> +                              description='Listed in QEMU_TEST_IO_SKIP')
>>>>>>>>> +
>>>>>>>>>          args = [str(f_test.resolve())]
>>>>>>>>>          env = self.env.prepare_subprocess(args)
>>>>>>>>>  
>>>>>>>>
>>>>>>>> Why not simply remove the broken tests, and create issues to add them
>>>>>>>> again in the future?
>>>>>>>
>>>>>>> In theory that's what our policy today is, but in practice it is
>>>>>>> too much of a burden on the release co-ordinator, to expect them
>>>>>>> to create such a patch themselves, or wait on a subsys maintainer
>>>>>>> todo it for them.
>>>>>>>
>>>>>>> They end up just ignoring brokenness in CI which is a bad practice,
>>>>>>> and will prevent us ever making CI truely gating or switching to
>>>>>>> using MRs for pull requests. This gives us a super-fast way to skip
>>>>>>> flaky tests, while the subsystem maintainers figure out the right
>>>>>>> permanent answer.
>>>>>>>
>>>>>>
>>>>>> I disagree on this one, merging a single patch doing a git rm, and a git
>>>>>> revert later is not more expensive than merging a variable modifying a
>>>>>> variable in a yaml file.
>>>>>
>>>>> Any code changes like that need to be sent back to the subsystem
>>>>> maintainer to be acked. IMHO the release manager should not be
>>>>> unilaterally deleting tests without peer review.  So that's
>>>>> got a non-negligible turn around time, during which CI is broken.
>>>>>
>>>>
>>>> I accept the argument, but it seems like a workaround for a human
>>>> process, more than a proper solution to the problem.
>>>>
>>>> It would be better to have a proper policy for build/test fixes, instead
>>>> of implementing local overrides to this.
>>>>
>>>>> Setting an env variable to skip a problematic test is something
>>>>> reasonable to do with zero oversight.
>>>>>
>>>>>> The issue with this approach is that people running tests locally will
>>>>>> not see which tests are skipped, and will see false positives. So you
>>>>>> just keep CI green, but not the test base itself.
>>>>>
>>>>> I would still expect the release manager to file a bug about any
>>>>> flaky test they disable via the env var, and the subsystem maintainer
>>>>> should still be fixing it or disabling it such that tests won't fail
>>>>> more broadly, or deciding to remove it if terminally broken.
>>>>>
>>>>> We're just decoupling the process so that there is an immediate
>>>>> workaround possible. It can also be used by people working in
>>>>> their forks - often I've been testing stuff in my fork, but
>>>>> see spurious failures because git master has a non-deterministic
>>>>> test failure merged. I would like to easily skip those in my fork
>>>>> too, without adding extra commits to me working branches, as that
>>>>> would require the same commit to be duped into several in-progress
>>>>> branches, vs setting the env var once.
>>>>>
>>>>>> The risk I see is that some tests will stay forever in this skip
>>>>>> variable, so it will be dead code for CI, but still alive and failing
>>>>>> for people running tests manually who hit the regression.
>>>>>
>>>>> Again, there should be a bug filed for any flaky test. Anyone can
>>>>> do this, if they see it locally or in their fork CI, or in staging
>>>>> CI. If no one can see an obvious fix, then anyone can also propose
>>>>> to disable the test.
>>>>>
>>>>>> If you still want an alternative to removing test, implementing a
>>>>>> skip_list in tests/qemu-iotests/meson.build is better than an env var
>>>>>> IMHO, and achieves the exact same effect, for CI and for users.
>>>>>>
>>>>>> What do you think?
>>>>>
>>>>> IMHO there needs to be a way to skip flaky tests which does not
>>>>> require code changes as the only available option. Code changes
>>>>> are the permanent fix, env var is the immediate workaround.
>>>>>
>>>>
>>>> I'm not sure all this answers to my question about How to ensure users
>>>> who run tests and the CI both see the same skip list.
>>>>
>>>> I don't mind having an env var, a black list in meson or any other
>>>> solution, but having different results on a dev machine and in CI is not
>>>> a good design. So whatever the solution is, the CI yaml file is not the
>>>> proper place to store this information.
>>>
>>> AFAICT the test 185 that is being skipped in the CI yaml file only
>>> fails when run under gitlab. I've never seen a failure running it
>>> locally.
>>>
>>> If it failed locally too, then I'd agree that it should not be
>>> skipped in the CI yaml, but universally skipped in all scenarios.
>>>
>>
>> If I get all this correctly, we add a generic mechanic to be able to
>> gate CI with block tests just because there is a single test failing
>> with a single driver. Is that the right approach?
> 
> The env variable is the generic mechanism.
> 
> The yaml file exclusion for 185 is the special case, but we get
> that basically for free with the former.
> 
>> In the future, do we expect to merge code breaking tests?
> 
> Yes. We will certainly merge more non-deterministic tests. We've seen
> this over & over again. Something passes CI initially but after a
> number of CI pipelines turns out to be flaky
>

Then we can mark them as flaky in tests/qemu-iotests/meson.build.

It seems like you ignore the point that there is a problem between
setting something in CI only vs making something that works for all
users. I'm not against an env var, I just don't see how it answers this
need.

> With regards,
> Daniel


