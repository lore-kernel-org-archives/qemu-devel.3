Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7D8CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 19:13:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMsXE-0007BR-7h; Tue, 12 May 2026 15:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMsXB-0007AX-Mc
 for qemu-devel@nongnu.org; Tue, 12 May 2026 15:12:49 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMsX8-0006Hp-Lh
 for qemu-devel@nongnu.org; Tue, 12 May 2026 15:12:49 -0400
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CEYY4f1733313
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 19:12:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 yDa8OFIsRhm+/WIxkv9k6v6rY1Lgy2GbmQdXuQ5Umnk=; b=LXRw9g+92J//XYT7
 aXlWDJSMW9v/3QkNdRnhhFR7oxgjJyghX4N7+TViy1irBL0fU7dwVvQxcuNxc8yN
 C2Rx/YBsoOZInvWxu0LVfPuJvT2neb8S5XXcC6342DzJDXDkxyJJaw4nwTCJ/q+r
 Dsj3Z4pZ860b9PttBpyK6frA3dzgO+dBmjA3C0iNxwcWlKyesSAcRdvo9ivDrkyO
 vFPNQIK3VNX3+uxHOgKcTEadOQ+xtC1FdAaQrd+J8tkR5xq71QKfnHCGvBnf5f+d
 vaCfcyz9/cXYeVSyDPXiSJC/u/2Ig67XusDrSYWd+GUMoPk1G1EGHxUfHst3+Dme
 GIuXiQ==
Received: from mail-dy1-f197.google.com (mail-dy1-f197.google.com
 [74.125.82.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e463dh3h9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 19:12:44 +0000 (GMT)
Received: by mail-dy1-f197.google.com with SMTP id
 5a478bee46e88-2f2d983d109so8184236eec.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 12:12:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778613163; x=1779217963; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yDa8OFIsRhm+/WIxkv9k6v6rY1Lgy2GbmQdXuQ5Umnk=;
 b=J5PAf17ibqNbi1+iF17pSJHX9wRrAPj7tm49S7STtxsxkB3LOiZtt5m5LUjWHCzXnz
 8RIw3NCTuATuIk8DATGp2MdgxT7+IB04YXgD3K7odMv+tFlDYNnL6CKv5pUMDDgM42vu
 s0ydSUZDJaINKbShCo0XX9ZgbtwezqstMuJv82yOFLEFV38I7aRxJqTlPgu0Ozs1zFS9
 IXUmZRZQ43KW0uUPFtQrqV64dhNI8IlHr5xd02p11L0gdCKXlFSmhmTP9fS2bF0Qo4s+
 eSQGWaPhXcSxdyP5KjONPj8NrteJhlBjd0X+dlwS6qjMIZ2HrD6NMRjHynir7NVQCNHV
 xwxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778613163; x=1779217963;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yDa8OFIsRhm+/WIxkv9k6v6rY1Lgy2GbmQdXuQ5Umnk=;
 b=HqhBI2m3BRet7g1rRfK88cbhpS/Z8aQxO8vCJlz1f7eY1eHGi8iwZjDPPWnXBXR+j1
 yQvm/dlcV4ugLMnMHFVtQYVXqTtZVqxITy3++DehYyghXQGXWb2iNGWmKN/SA76rMv10
 dk9wFMwnSzukRpAJ/xdy8/nlDEMiOKRgMQDxAzp6oRaseVZzb/LiT/FR858Yfn/+b+F2
 LGOogAabKXyRhRvJdMnArfpSxk+7XpQuS6p/sQ/lmBQrfn/HW9bZVEcViwWCdCCaeDQ4
 0A36glc2YmZKfULK7cimRvWsY4Wd3sOlB8dvUZqqPGlq4l6rnYLU/vhXmvWQ0x9lReUZ
 mV4Q==
X-Gm-Message-State: AOJu0Yy5MEnYyxIuQLKCbAe9SmgmqZu33XeQKcrgwSuMoqSVUXx+KGQr
 VDeZrbza52nH+DUo9CNe8lHlXDnFJhpmQfUEaXn9AOHo+ltlWmvFXx3dZ7syDU/ktj9wPEm/jyr
 p3DBIlNVyPZ8BsmwG2CgJDzsKFbpMAY1ZHYl7idOYfI+ptnA1Sxeq8Tc2EA==
X-Gm-Gg: Acq92OGThCMnlfAtY4XS52fcb0BUcpFXC+LqtMPJ6yJqQXLG/XF+5tlH9yvo2ZCgxAc
 tC5EiS8JDXaPr0VudF8CSoQ/lvHmE5WQqcqvS65cuncR/PuMfEYI6lm+gXBww+iNtZqF30bkX5+
 bPFz0StvC0BTobLdyMsNytJONs500xfmDz8EHhk3g81fyeri+kaIiSsAaxVUWmaoBwq6oQJ6Gqe
 L/vjdt+P9grmT9OzVGYRPtTyEQLOReCwt1qTKxCVwjO2TSTDDMYKzWmVNbOzpX7YkSltRZLR/Gf
 ZEtF9jm2pICTLs+L/QD7Dxk3n+IgQ/7GHae9AKWJPXRRXileWb1YCvINzEOSr2iyBaAVflBedwt
 gDMEoYmcZuD+jfiFnHNeAmKUU8tja/Ea4rEZx9rU+tffKFaIVw9h8cGdkQVEU2b1ldx92f2hgh9
 AqcwewlmB8TojSww==
X-Received: by 2002:a05:7301:292e:b0:2c0:c5e4:605f with SMTP id
 5a478bee46e88-30119395caemr245807eec.24.1778613163245; 
 Tue, 12 May 2026 12:12:43 -0700 (PDT)
X-Received: by 2002:a05:7301:292e:b0:2c0:c5e4:605f with SMTP id
 5a478bee46e88-30119395caemr245769eec.24.1778613162564; 
 Tue, 12 May 2026 12:12:42 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f88847504dsm19275592eec.15.2026.05.12.12.12.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 12:12:41 -0700 (PDT)
Message-ID: <dd212ed3-8cde-4397-9585-9eb5439fe44e@oss.qualcomm.com>
Date: Tue, 12 May 2026 12:12:40 -0700
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
References: <agNPkLRe0Rf4NYcU@redhat.com>
 <cc8714c3-143d-4f63-a608-d301e8ba023b@oss.qualcomm.com>
 <agNXCf5eXNQmhCAV@redhat.com>
 <55b66ce4-218c-462f-8e48-0775d5c36cba@oss.qualcomm.com>
 <agNbJS1WeWaxZ_Gx@redhat.com>
 <31eb8204-97bb-4f0e-b90a-048d1b5bf05d@oss.qualcomm.com>
 <agNiPRnoyxd7rBbz@redhat.com>
 <cd3c6a2a-96ad-4276-aa61-8d458d702ba5@oss.qualcomm.com>
 <agN1a8IULLnpAjUa@redhat.com>
 <d997f55b-2e27-478c-9135-a694b7aa8052@oss.qualcomm.com>
 <agN4xgx6Hh2FdYIq@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <agN4xgx6Hh2FdYIq@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: eq5mfINd4PoxIYx1mP1-RkcSx2zzdq4s
X-Proofpoint-ORIG-GUID: eq5mfINd4PoxIYx1mP1-RkcSx2zzdq4s
X-Authority-Analysis: v=2.4 cv=aLTAb79m c=1 sm=1 tr=0 ts=6a037bac cx=c_pps
 a=Uww141gWH0fZj/3QKPojxA==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=Um2Pa8k9VHT-vaBCBUpS:22
 a=20KFwNOVAAAA:8 a=-tVkd6iuIJ_Q1t5A810A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=PxkB5W3o20Ba91AHUih5:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE5OCBTYWx0ZWRfX+lB/cgDvg3TE
 Zawfh1Bq6D7k7DLEv9H7d5Deu81DEqHrZuRiDm3jGJHsBBuqSR/AFgIFD8LsxcCtM+7SoUIcWgL
 NDmaJ7tqno5dFvU4dJdojLZa7kAaQHzrYC2xBR+YtK/FOWJ86R4XRZ/YNSbJRcVUbc2DhCkFIub
 X4D6vhIIAUboNgB7VwCxYuJqZ1Y0Adb0rVprdUlRl2NLfXgTHZmUWGWczighNguVNvCShrkEYAW
 NBWYGf6ooWDuM7Kg4Ptgm5ux6V4ABFwBE4mAj9rP4BEKF7fDKvtVH0no3lt+G2w8dhCaKod30cY
 0OFSEjb19kHEzPSz6imFTZDQZNxhT4kFTMeRV+li7l37EUAtEEOTl8BIGIlvdIckDr8WwCsBVNU
 M/yCwz6f40Dqw5IEUjQ3JUej0mcoij85CFDYdo4gSyhzk4wcgzsh/NOgTDiqLFaykTERPbGgRuh
 FP5sfH/AzMTvutyn2vw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 spamscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 phishscore=0 impostorscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120198
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

On 5/12/2026 12:00 PM, Daniel P. Berrangé wrote:
> On Tue, May 12, 2026 at 11:52:45AM -0700, Pierrick Bouvier wrote:
>> On 5/12/2026 11:46 AM, Daniel P. Berrangé wrote:
>>> On Tue, May 12, 2026 at 10:53:05AM -0700, Pierrick Bouvier wrote:
>>>> On 5/12/2026 10:24 AM, Daniel P. Berrangé wrote:
>>>>> On Tue, May 12, 2026 at 10:09:53AM -0700, Pierrick Bouvier wrote:
>>>>>> On 5/12/2026 9:53 AM, Daniel P. Berrangé wrote:
>>>>>>> On Tue, May 12, 2026 at 09:47:12AM -0700, Pierrick Bouvier wrote:
>>>>>>>> On 5/12/2026 9:36 AM, Daniel P. Berrangé wrote:
>>>>>>>>> On Tue, May 12, 2026 at 09:19:45AM -0700, Pierrick Bouvier wrote:
>>>>>>>>>> On 5/12/2026 9:06 AM, Daniel P. Berrangé wrote:
>>>>>>>>>>> On Tue, May 12, 2026 at 08:56:54AM -0700, Pierrick Bouvier wrote:
>>>>>>>>>>>> On 4/24/2026 8:42 AM, Daniel P. Berrangé wrote:
>>>>>>>>>>>>> The nature of block I/O tests is such that there can be unexpected false
>>>>>>>>>>>>> positive failures in certain scenarios that have not been encountered
>>>>>>>>>>>>> before, and sometimes non-deterministic failures that are hard to
>>>>>>>>>>>>> reproduce.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Before enabling the I/O tests as gating jobs in CI, there needs to be a
>>>>>>>>>>>>> mechanism to dynamically mark tests as skipped, without having to commit
>>>>>>>>>>>>> code changes.
>>>>>>>>>>>>>
>>>>>>>>>>>>> This introduces the QEMU_TEST_IO_SKIP environment variable that is set
>>>>>>>>>>>>> to a list of FORMAT-OR-PROTOCOL:NAME pairs. The intent is that this
>>>>>>>>>>>>> variable can be set as a GitLab CI pipeline variable to temporarily
>>>>>>>>>>>>> disable a test while problems are being debugged.
>>>>>>>>>>>>>
>>>>>>>>>>>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>>>>>>>>>>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>>>>>>>>>>>> ---
>>>>>>>>>>>>>  docs/devel/testing/main.rst      |  7 +++++++
>>>>>>>>>>>>>  tests/qemu-iotests/testrunner.py | 16 ++++++++++++++++
>>>>>>>>>>>>>  2 files changed, 23 insertions(+)
>>>>>>>>>>>>>
>>>>>>>>>>>>> diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
>>>>>>>>>>>>> index 797111009a..f779a64415 100644
>>>>>>>>>>>>> --- a/docs/devel/testing/main.rst
>>>>>>>>>>>>> +++ b/docs/devel/testing/main.rst
>>>>>>>>>>>>> @@ -284,6 +284,13 @@ that are specific to certain cache mode.
>>>>>>>>>>>>>  More options are supported by the ``./check`` script, run ``./check -h`` for
>>>>>>>>>>>>>  help.
>>>>>>>>>>>>>  
>>>>>>>>>>>>> +If a test program is known to be broken, it can be disabled by setting
>>>>>>>>>>>>> +the ``QEMU_TEST_IO_SKIP`` environment variable with a list of tests to
>>>>>>>>>>>>> +be skipped. The values are of the form FORMAT-OR-PROTOCOL:NAME, the
>>>>>>>>>>>>> +leading component can be omitted to skip the test for all formats and
>>>>>>>>>>>>> +protocols. For example ``export QEMU_TEST_IO_SKIP="luks:149 185 iov-padding``
>>>>>>>>>>>>> +will skip ``149`` for LUKS only, and ``185`` and ``iov-padding`` for all.
>>>>>>>>>>>>> +
>>>>>>>>>>>>>  Writing a new test case
>>>>>>>>>>>>>  ~~~~~~~~~~~~~~~~~~~~~~~
>>>>>>>>>>>>>  
>>>>>>>>>>>>> diff --git a/tests/qemu-iotests/testrunner.py b/tests/qemu-iotests/testrunner.py
>>>>>>>>>>>>> index dbe2dddc32..ecb5d4529f 100644
>>>>>>>>>>>>> --- a/tests/qemu-iotests/testrunner.py
>>>>>>>>>>>>> +++ b/tests/qemu-iotests/testrunner.py
>>>>>>>>>>>>> @@ -145,6 +145,18 @@ def __init__(self, env: TestEnv, tap: bool = False,
>>>>>>>>>>>>>  
>>>>>>>>>>>>>          self._stack: contextlib.ExitStack
>>>>>>>>>>>>>  
>>>>>>>>>>>>> +        self.skip = {}
>>>>>>>>>>>>> +        for rule in os.environ.get("QEMU_TEST_IO_SKIP", "").split(" "):
>>>>>>>>>>>>> +            rule = rule.strip()
>>>>>>>>>>>>> +            if rule == "":
>>>>>>>>>>>>> +                continue
>>>>>>>>>>>>> +            if ":" in rule:
>>>>>>>>>>>>> +                fmt, name = rule.split(":")
>>>>>>>>>>>>> +                if fmt in ("", env.imgfmt, env.imgproto):
>>>>>>>>>>>>> +                    self.skip[name] = True
>>>>>>>>>>>>> +            else:
>>>>>>>>>>>>> +                self.skip[rule] = True
>>>>>>>>>>>>> +
>>>>>>>>>>>>>      def __enter__(self) -> 'TestRunner':
>>>>>>>>>>>>>          self._stack = contextlib.ExitStack()
>>>>>>>>>>>>>          self._stack.enter_context(self.env)
>>>>>>>>>>>>> @@ -251,6 +263,10 @@ def do_run_test(self, test: str) -> TestResult:
>>>>>>>>>>>>>                                description='No qualified output '
>>>>>>>>>>>>>                                            f'(expected {f_reference})')
>>>>>>>>>>>>>  
>>>>>>>>>>>>> +        if f_test.name in self.skip:
>>>>>>>>>>>>> +            return TestResult(status='not run',
>>>>>>>>>>>>> +                              description='Listed in QEMU_TEST_IO_SKIP')
>>>>>>>>>>>>> +
>>>>>>>>>>>>>          args = [str(f_test.resolve())]
>>>>>>>>>>>>>          env = self.env.prepare_subprocess(args)
>>>>>>>>>>>>>  
>>>>>>>>>>>>
>>>>>>>>>>>> Why not simply remove the broken tests, and create issues to add them
>>>>>>>>>>>> again in the future?
>>>>>>>>>>>
>>>>>>>>>>> In theory that's what our policy today is, but in practice it is
>>>>>>>>>>> too much of a burden on the release co-ordinator, to expect them
>>>>>>>>>>> to create such a patch themselves, or wait on a subsys maintainer
>>>>>>>>>>> todo it for them.
>>>>>>>>>>>
>>>>>>>>>>> They end up just ignoring brokenness in CI which is a bad practice,
>>>>>>>>>>> and will prevent us ever making CI truely gating or switching to
>>>>>>>>>>> using MRs for pull requests. This gives us a super-fast way to skip
>>>>>>>>>>> flaky tests, while the subsystem maintainers figure out the right
>>>>>>>>>>> permanent answer.
>>>>>>>>>>>
>>>>>>>>>>
>>>>>>>>>> I disagree on this one, merging a single patch doing a git rm, and a git
>>>>>>>>>> revert later is not more expensive than merging a variable modifying a
>>>>>>>>>> variable in a yaml file.
>>>>>>>>>
>>>>>>>>> Any code changes like that need to be sent back to the subsystem
>>>>>>>>> maintainer to be acked. IMHO the release manager should not be
>>>>>>>>> unilaterally deleting tests without peer review.  So that's
>>>>>>>>> got a non-negligible turn around time, during which CI is broken.
>>>>>>>>>
>>>>>>>>
>>>>>>>> I accept the argument, but it seems like a workaround for a human
>>>>>>>> process, more than a proper solution to the problem.
>>>>>>>>
>>>>>>>> It would be better to have a proper policy for build/test fixes, instead
>>>>>>>> of implementing local overrides to this.
>>>>>>>>
>>>>>>>>> Setting an env variable to skip a problematic test is something
>>>>>>>>> reasonable to do with zero oversight.
>>>>>>>>>
>>>>>>>>>> The issue with this approach is that people running tests locally will
>>>>>>>>>> not see which tests are skipped, and will see false positives. So you
>>>>>>>>>> just keep CI green, but not the test base itself.
>>>>>>>>>
>>>>>>>>> I would still expect the release manager to file a bug about any
>>>>>>>>> flaky test they disable via the env var, and the subsystem maintainer
>>>>>>>>> should still be fixing it or disabling it such that tests won't fail
>>>>>>>>> more broadly, or deciding to remove it if terminally broken.
>>>>>>>>>
>>>>>>>>> We're just decoupling the process so that there is an immediate
>>>>>>>>> workaround possible. It can also be used by people working in
>>>>>>>>> their forks - often I've been testing stuff in my fork, but
>>>>>>>>> see spurious failures because git master has a non-deterministic
>>>>>>>>> test failure merged. I would like to easily skip those in my fork
>>>>>>>>> too, without adding extra commits to me working branches, as that
>>>>>>>>> would require the same commit to be duped into several in-progress
>>>>>>>>> branches, vs setting the env var once.
>>>>>>>>>
>>>>>>>>>> The risk I see is that some tests will stay forever in this skip
>>>>>>>>>> variable, so it will be dead code for CI, but still alive and failing
>>>>>>>>>> for people running tests manually who hit the regression.
>>>>>>>>>
>>>>>>>>> Again, there should be a bug filed for any flaky test. Anyone can
>>>>>>>>> do this, if they see it locally or in their fork CI, or in staging
>>>>>>>>> CI. If no one can see an obvious fix, then anyone can also propose
>>>>>>>>> to disable the test.
>>>>>>>>>
>>>>>>>>>> If you still want an alternative to removing test, implementing a
>>>>>>>>>> skip_list in tests/qemu-iotests/meson.build is better than an env var
>>>>>>>>>> IMHO, and achieves the exact same effect, for CI and for users.
>>>>>>>>>>
>>>>>>>>>> What do you think?
>>>>>>>>>
>>>>>>>>> IMHO there needs to be a way to skip flaky tests which does not
>>>>>>>>> require code changes as the only available option. Code changes
>>>>>>>>> are the permanent fix, env var is the immediate workaround.
>>>>>>>>>
>>>>>>>>
>>>>>>>> I'm not sure all this answers to my question about How to ensure users
>>>>>>>> who run tests and the CI both see the same skip list.
>>>>>>>>
>>>>>>>> I don't mind having an env var, a black list in meson or any other
>>>>>>>> solution, but having different results on a dev machine and in CI is not
>>>>>>>> a good design. So whatever the solution is, the CI yaml file is not the
>>>>>>>> proper place to store this information.
>>>>>>>
>>>>>>> AFAICT the test 185 that is being skipped in the CI yaml file only
>>>>>>> fails when run under gitlab. I've never seen a failure running it
>>>>>>> locally.
>>>>>>>
>>>>>>> If it failed locally too, then I'd agree that it should not be
>>>>>>> skipped in the CI yaml, but universally skipped in all scenarios.
>>>>>>>
>>>>>>
>>>>>> If I get all this correctly, we add a generic mechanic to be able to
>>>>>> gate CI with block tests just because there is a single test failing
>>>>>> with a single driver. Is that the right approach?
>>>>>
>>>>> The env variable is the generic mechanism.
>>>>>
>>>>> The yaml file exclusion for 185 is the special case, but we get
>>>>> that basically for free with the former.
>>>>>
>>>>>> In the future, do we expect to merge code breaking tests?
>>>>>
>>>>> Yes. We will certainly merge more non-deterministic tests. We've seen
>>>>> this over & over again. Something passes CI initially but after a
>>>>> number of CI pipelines turns out to be flaky
>>>>>
>>>>
>>>> Then we can mark them as flaky in tests/qemu-iotests/meson.build.
>>>
>>> That is a long term solution. It does not address the immediate
>>> time critical goal to have the ability to fix a broken CI pipeline
>>> immediately by skipping the test without waiting for code changes.
>>>
>>>> It seems like you ignore the point that there is a problem between
>>>> setting something in CI only vs making something that works for all
>>>> users. I'm not against an env var, I just don't see how it answers this
>>>> need.
>>>
>>> Again, I'm not saying that we fix this only for CI. The env var is
>>> to allow broken jobs to be immediately skipped, while waiting for
>>> code changes to permanently skipped/fix the tests. The latter
>>> addresses it for every scenario.
>>>
>>
>> I might have missed where we have a default value for this env var, out
>> of yaml file, that makes it apply the exact same set of skip tests for
>> CI, and for users running tests manually.
>>
>> Where is this default applied for both CI and users?
>>
>> I understand it's not needed for test 185 which fails only in GitLab,
>> but as you mentioned, we'll probably have non deterministic tests in the
>> future, so we need to consider this.
> 
> I was considering any change in meson.build to permanently skip a
> test would be independent of the env var handling, and outside the
> scope of this series since there's no need for it here.
>

Where is the default value for this env var applied for both CI and
users? yaml is for CI only.

> 
> With regards,
> Daniel


