Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D3C6CD343F
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 18:53:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMsDx-00008d-6V; Tue, 12 May 2026 14:52:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMsDu-00006x-Mo
 for qemu-devel@nongnu.org; Tue, 12 May 2026 14:52:54 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wMsDr-0007SO-OT
 for qemu-devel@nongnu.org; Tue, 12 May 2026 14:52:54 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64CCgstN1409947
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 18:52:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 w88siLQpJzbUeAxmO/8HHacyqBklk0nI3qMYaMUS3Wg=; b=aTXp2h7Gj7pNufQM
 JjuXELNBS1lgutVqw/TniQIr8VzVoX4nd5yTnXlEzjffXttIjdo6DGEh3HMhsmrh
 hQ7EeidMeMDe78p0XnpsrxyzBPfDwOBFmuMHDR0lewluzeLklWiIp2II7qMHQKlt
 3ukVaN95cZvVt8Q4Z4C6hDnFBPRxEE25zYr4qHPEiaZQInkceE7uaOpON4YqZ9BA
 hInP8DTqp1mEjj2/NySXX+bBYPf/0F+N/640jiDr4t++DrxxD0mDAnEIOy9hu3L9
 7awdj6D3foWmfZam0vqOuJMawOw5Om7T1VH2mdJUEOuOc4ACyd8LAQY3KX2zcMRv
 jBsmVA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4e44f31dyp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 18:52:49 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-2ee5b73c5f2so10038205eec.0
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 11:52:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1778611969; x=1779216769; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=w88siLQpJzbUeAxmO/8HHacyqBklk0nI3qMYaMUS3Wg=;
 b=Vji+BHF9j8TFkUgN+k5Zs8SzGW48E/IDC5ktls4a726LFlBYAG53IV0ETykKri1gW7
 k6eKFsIG4+CaNIiQChkHRBCG8+ohEoRLVHebFdUtAtMRUOggVDtUo/c1siv0CMtTBERJ
 2CleLbPsBzckK0iieTL1cciAkGn4dmP/5s4QHjiQRqlipJHg9UCBpQcRSjXtnuIL94g6
 Jm4SdVXCMnks9BEvpCkVkLaiyG6p66BynIjYMgPsC6GPD81jnSTabTcPu7yr5ylqzHIt
 Vummxr5IQOFaZaB4MTPeVMm+ZOx0I3OAgyICe5DHDE2Rr8aiuRKCbSNeaa0x1OpMicPf
 mIkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778611969; x=1779216769;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w88siLQpJzbUeAxmO/8HHacyqBklk0nI3qMYaMUS3Wg=;
 b=O5mtwcTG+y/CiGdKuc+FTmzXoDGfQzVlK+1PVqPrO/tiV0yiZjj3OOfZVp2Lvk041Z
 YSiEnAZs70BYOxVHFhJjiqxVIGlSut+2rDIxhX97ceJeHFtWOBh2H5mBx+NdxuE601jT
 SIhHinwr35SHwaHXcoik9tHOWTXFo/oJ9DGuvfHfep9rJPDlHrSNLZ16svM67NDSkLht
 SDduq5Xm9jtQZbFJtNW0+PrYuv0dGsIwI0CFpc4lRdNwYK+zjQVH4bNtmdquSIUXREAM
 sAx2iicqYVEWHs8BOojVkB/9kSzqC76H7TK3t6gpaJWS2xf/FYomv/ae+xhDK3cZplDE
 +9kA==
X-Gm-Message-State: AOJu0YxwQQCmQfj396CfVau6gVse7p5m/a3K7WT1Je1BELO3HW4OYSb9
 tffN+RyrK2sLTCorY67RGDvsmLO8AF2cIFmMy3GJpXOCOhhbaDtSMRi6Gb/XouBjecoTCMLGX4V
 +M66FTdNH4VFWCdjvSf03MZhlkuXjvR0NhrPDCv9wfy/LWpH3drWeUcbMvg==
X-Gm-Gg: Acq92OGQBDe7NQSMngw0rDCudfdHPeBcoH1Wgu9saptcpGhMVN7ov0FMGPn2iKqNY1N
 SqREdEk+pRVUucOgT1WRKc+Ayjog3F2cgFUj2MMspKjNtTXGYRR0/xHL+Lpb+IoG96D1ZGs8GRe
 Dt+ejDymQkQ2hlSarx495DjMpSRdoLdCl6QVYtELG9cX4TrQU5+geapLHlLI5ylybP7oDZlI3qE
 ouLUr2HUM7wyIJbsVzsW04mG2qK2C5rMrAvZDFeqWmHDBLuZP3zP9ApZWccWvZfJhZYJaZXbpuW
 +wjRcSIYvZFdt3e8ZFBdX4N0dTzEXk1kc79g3dPheVpblKnMSIcJdwaR8F3okupIAVZ4WQx1yxg
 1xbiv6BXtSTLIQVHlf7a8d/YwELfnX19rmVsGaotvP0K81UM3h9ly8Zh6qIOqw/GsVc9VWxDQsz
 5EGyOVGrpcbd4mog==
X-Received: by 2002:a05:7300:e105:b0:2f5:6d9c:7156 with SMTP id
 5a478bee46e88-30118da9e41mr204913eec.17.1778611968577; 
 Tue, 12 May 2026 11:52:48 -0700 (PDT)
X-Received: by 2002:a05:7300:e105:b0:2f5:6d9c:7156 with SMTP id
 5a478bee46e88-30118da9e41mr204893eec.17.1778611967937; 
 Tue, 12 May 2026 11:52:47 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-2f88885be8esm19332005eec.22.2026.05.12.11.52.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 May 2026 11:52:47 -0700 (PDT)
Message-ID: <d997f55b-2e27-478c-9135-a694b7aa8052@oss.qualcomm.com>
Date: Tue, 12 May 2026 11:52:45 -0700
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
References: <20260424154205.364268-15-berrange@redhat.com>
 <fa8be3d8-6d76-4811-83ab-69c256e8e44f@oss.qualcomm.com>
 <agNPkLRe0Rf4NYcU@redhat.com>
 <cc8714c3-143d-4f63-a608-d301e8ba023b@oss.qualcomm.com>
 <agNXCf5eXNQmhCAV@redhat.com>
 <55b66ce4-218c-462f-8e48-0775d5c36cba@oss.qualcomm.com>
 <agNbJS1WeWaxZ_Gx@redhat.com>
 <31eb8204-97bb-4f0e-b90a-048d1b5bf05d@oss.qualcomm.com>
 <agNiPRnoyxd7rBbz@redhat.com>
 <cd3c6a2a-96ad-4276-aa61-8d458d702ba5@oss.qualcomm.com>
 <agN1a8IULLnpAjUa@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <agN1a8IULLnpAjUa@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-ORIG-GUID: zOQj95aTxThiTOUQztPIU_xpZxybKbFP
X-Authority-Analysis: v=2.4 cv=SpSgLvO0 c=1 sm=1 tr=0 ts=6a037701 cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=20KFwNOVAAAA:8 a=RwUKE8_jf0P1rpL6sccA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=scEy_gLbYbu1JhEsrz4S:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEyMDE5NSBTYWx0ZWRfX0trnf/rdpe/7
 Fag2XjvxSE2kWYJZONUS/1AN5+DYYg9Qjj8/i3ASjkKg5ty8Z2NH4Mo8o4uWINGxw2W8B3MUbyJ
 hJiDrwKfvB87yN2q8AriFzMShTr6iVSs41HTPUBwcwjKw6pQjLllVR9gy5bvkfEr6J23bVMxi8Y
 dKEP5ibQpNmZzn/FOfDiZe6pUn5MA/qoUhiRuJEDK/Noux0fP4Iq7Q5UYTUHgrI35MGOrK4LDP/
 NSVLsNUOZBNOngkJcAqupNH7GOK2k+N+UOHfj45fKe8KFudpj6JC6dbFDIRx6yI8arJL3olrooo
 0MyoLITRwPJ6Xn9YgEqsbCWXENj36/rODAA9Wc4mhXR02/jb7xpwV92f6PHCsiinfq12E4KZRRt
 4H/8asUzZvo6pSnlyaX/1WwC6O7mal2kFDR5syP8aDDs5gxu3T0iPFo5KAhoRTuaT5jM6rP7O7b
 wU+Bd8wJahQnUBl16aw==
X-Proofpoint-GUID: zOQj95aTxThiTOUQztPIU_xpZxybKbFP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-11_05,2026-05-08_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 malwarescore=0 suspectscore=0 impostorscore=0 bulkscore=0
 spamscore=0 phishscore=0 priorityscore=1501 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605050000 definitions=main-2605120195
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

On 5/12/2026 11:46 AM, Daniel P. Berrangé wrote:
> On Tue, May 12, 2026 at 10:53:05AM -0700, Pierrick Bouvier wrote:
>> On 5/12/2026 10:24 AM, Daniel P. Berrangé wrote:
>>> On Tue, May 12, 2026 at 10:09:53AM -0700, Pierrick Bouvier wrote:
>>>> On 5/12/2026 9:53 AM, Daniel P. Berrangé wrote:
>>>>> On Tue, May 12, 2026 at 09:47:12AM -0700, Pierrick Bouvier wrote:
>>>>>> On 5/12/2026 9:36 AM, Daniel P. Berrangé wrote:
>>>>>>> On Tue, May 12, 2026 at 09:19:45AM -0700, Pierrick Bouvier wrote:
>>>>>>>> On 5/12/2026 9:06 AM, Daniel P. Berrangé wrote:
>>>>>>>>> On Tue, May 12, 2026 at 08:56:54AM -0700, Pierrick Bouvier wrote:
>>>>>>>>>> On 4/24/2026 8:42 AM, Daniel P. Berrangé wrote:
>>>>>>>>>>> The nature of block I/O tests is such that there can be unexpected false
>>>>>>>>>>> positive failures in certain scenarios that have not been encountered
>>>>>>>>>>> before, and sometimes non-deterministic failures that are hard to
>>>>>>>>>>> reproduce.
>>>>>>>>>>>
>>>>>>>>>>> Before enabling the I/O tests as gating jobs in CI, there needs to be a
>>>>>>>>>>> mechanism to dynamically mark tests as skipped, without having to commit
>>>>>>>>>>> code changes.
>>>>>>>>>>>
>>>>>>>>>>> This introduces the QEMU_TEST_IO_SKIP environment variable that is set
>>>>>>>>>>> to a list of FORMAT-OR-PROTOCOL:NAME pairs. The intent is that this
>>>>>>>>>>> variable can be set as a GitLab CI pipeline variable to temporarily
>>>>>>>>>>> disable a test while problems are being debugged.
>>>>>>>>>>>
>>>>>>>>>>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>>>>>>>>>>> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
>>>>>>>>>>> ---
>>>>>>>>>>>  docs/devel/testing/main.rst      |  7 +++++++
>>>>>>>>>>>  tests/qemu-iotests/testrunner.py | 16 ++++++++++++++++
>>>>>>>>>>>  2 files changed, 23 insertions(+)
>>>>>>>>>>>
>>>>>>>>>>> diff --git a/docs/devel/testing/main.rst b/docs/devel/testing/main.rst
>>>>>>>>>>> index 797111009a..f779a64415 100644
>>>>>>>>>>> --- a/docs/devel/testing/main.rst
>>>>>>>>>>> +++ b/docs/devel/testing/main.rst
>>>>>>>>>>> @@ -284,6 +284,13 @@ that are specific to certain cache mode.
>>>>>>>>>>>  More options are supported by the ``./check`` script, run ``./check -h`` for
>>>>>>>>>>>  help.
>>>>>>>>>>>  
>>>>>>>>>>> +If a test program is known to be broken, it can be disabled by setting
>>>>>>>>>>> +the ``QEMU_TEST_IO_SKIP`` environment variable with a list of tests to
>>>>>>>>>>> +be skipped. The values are of the form FORMAT-OR-PROTOCOL:NAME, the
>>>>>>>>>>> +leading component can be omitted to skip the test for all formats and
>>>>>>>>>>> +protocols. For example ``export QEMU_TEST_IO_SKIP="luks:149 185 iov-padding``
>>>>>>>>>>> +will skip ``149`` for LUKS only, and ``185`` and ``iov-padding`` for all.
>>>>>>>>>>> +
>>>>>>>>>>>  Writing a new test case
>>>>>>>>>>>  ~~~~~~~~~~~~~~~~~~~~~~~
>>>>>>>>>>>  
>>>>>>>>>>> diff --git a/tests/qemu-iotests/testrunner.py b/tests/qemu-iotests/testrunner.py
>>>>>>>>>>> index dbe2dddc32..ecb5d4529f 100644
>>>>>>>>>>> --- a/tests/qemu-iotests/testrunner.py
>>>>>>>>>>> +++ b/tests/qemu-iotests/testrunner.py
>>>>>>>>>>> @@ -145,6 +145,18 @@ def __init__(self, env: TestEnv, tap: bool = False,
>>>>>>>>>>>  
>>>>>>>>>>>          self._stack: contextlib.ExitStack
>>>>>>>>>>>  
>>>>>>>>>>> +        self.skip = {}
>>>>>>>>>>> +        for rule in os.environ.get("QEMU_TEST_IO_SKIP", "").split(" "):
>>>>>>>>>>> +            rule = rule.strip()
>>>>>>>>>>> +            if rule == "":
>>>>>>>>>>> +                continue
>>>>>>>>>>> +            if ":" in rule:
>>>>>>>>>>> +                fmt, name = rule.split(":")
>>>>>>>>>>> +                if fmt in ("", env.imgfmt, env.imgproto):
>>>>>>>>>>> +                    self.skip[name] = True
>>>>>>>>>>> +            else:
>>>>>>>>>>> +                self.skip[rule] = True
>>>>>>>>>>> +
>>>>>>>>>>>      def __enter__(self) -> 'TestRunner':
>>>>>>>>>>>          self._stack = contextlib.ExitStack()
>>>>>>>>>>>          self._stack.enter_context(self.env)
>>>>>>>>>>> @@ -251,6 +263,10 @@ def do_run_test(self, test: str) -> TestResult:
>>>>>>>>>>>                                description='No qualified output '
>>>>>>>>>>>                                            f'(expected {f_reference})')
>>>>>>>>>>>  
>>>>>>>>>>> +        if f_test.name in self.skip:
>>>>>>>>>>> +            return TestResult(status='not run',
>>>>>>>>>>> +                              description='Listed in QEMU_TEST_IO_SKIP')
>>>>>>>>>>> +
>>>>>>>>>>>          args = [str(f_test.resolve())]
>>>>>>>>>>>          env = self.env.prepare_subprocess(args)
>>>>>>>>>>>  
>>>>>>>>>>
>>>>>>>>>> Why not simply remove the broken tests, and create issues to add them
>>>>>>>>>> again in the future?
>>>>>>>>>
>>>>>>>>> In theory that's what our policy today is, but in practice it is
>>>>>>>>> too much of a burden on the release co-ordinator, to expect them
>>>>>>>>> to create such a patch themselves, or wait on a subsys maintainer
>>>>>>>>> todo it for them.
>>>>>>>>>
>>>>>>>>> They end up just ignoring brokenness in CI which is a bad practice,
>>>>>>>>> and will prevent us ever making CI truely gating or switching to
>>>>>>>>> using MRs for pull requests. This gives us a super-fast way to skip
>>>>>>>>> flaky tests, while the subsystem maintainers figure out the right
>>>>>>>>> permanent answer.
>>>>>>>>>
>>>>>>>>
>>>>>>>> I disagree on this one, merging a single patch doing a git rm, and a git
>>>>>>>> revert later is not more expensive than merging a variable modifying a
>>>>>>>> variable in a yaml file.
>>>>>>>
>>>>>>> Any code changes like that need to be sent back to the subsystem
>>>>>>> maintainer to be acked. IMHO the release manager should not be
>>>>>>> unilaterally deleting tests without peer review.  So that's
>>>>>>> got a non-negligible turn around time, during which CI is broken.
>>>>>>>
>>>>>>
>>>>>> I accept the argument, but it seems like a workaround for a human
>>>>>> process, more than a proper solution to the problem.
>>>>>>
>>>>>> It would be better to have a proper policy for build/test fixes, instead
>>>>>> of implementing local overrides to this.
>>>>>>
>>>>>>> Setting an env variable to skip a problematic test is something
>>>>>>> reasonable to do with zero oversight.
>>>>>>>
>>>>>>>> The issue with this approach is that people running tests locally will
>>>>>>>> not see which tests are skipped, and will see false positives. So you
>>>>>>>> just keep CI green, but not the test base itself.
>>>>>>>
>>>>>>> I would still expect the release manager to file a bug about any
>>>>>>> flaky test they disable via the env var, and the subsystem maintainer
>>>>>>> should still be fixing it or disabling it such that tests won't fail
>>>>>>> more broadly, or deciding to remove it if terminally broken.
>>>>>>>
>>>>>>> We're just decoupling the process so that there is an immediate
>>>>>>> workaround possible. It can also be used by people working in
>>>>>>> their forks - often I've been testing stuff in my fork, but
>>>>>>> see spurious failures because git master has a non-deterministic
>>>>>>> test failure merged. I would like to easily skip those in my fork
>>>>>>> too, without adding extra commits to me working branches, as that
>>>>>>> would require the same commit to be duped into several in-progress
>>>>>>> branches, vs setting the env var once.
>>>>>>>
>>>>>>>> The risk I see is that some tests will stay forever in this skip
>>>>>>>> variable, so it will be dead code for CI, but still alive and failing
>>>>>>>> for people running tests manually who hit the regression.
>>>>>>>
>>>>>>> Again, there should be a bug filed for any flaky test. Anyone can
>>>>>>> do this, if they see it locally or in their fork CI, or in staging
>>>>>>> CI. If no one can see an obvious fix, then anyone can also propose
>>>>>>> to disable the test.
>>>>>>>
>>>>>>>> If you still want an alternative to removing test, implementing a
>>>>>>>> skip_list in tests/qemu-iotests/meson.build is better than an env var
>>>>>>>> IMHO, and achieves the exact same effect, for CI and for users.
>>>>>>>>
>>>>>>>> What do you think?
>>>>>>>
>>>>>>> IMHO there needs to be a way to skip flaky tests which does not
>>>>>>> require code changes as the only available option. Code changes
>>>>>>> are the permanent fix, env var is the immediate workaround.
>>>>>>>
>>>>>>
>>>>>> I'm not sure all this answers to my question about How to ensure users
>>>>>> who run tests and the CI both see the same skip list.
>>>>>>
>>>>>> I don't mind having an env var, a black list in meson or any other
>>>>>> solution, but having different results on a dev machine and in CI is not
>>>>>> a good design. So whatever the solution is, the CI yaml file is not the
>>>>>> proper place to store this information.
>>>>>
>>>>> AFAICT the test 185 that is being skipped in the CI yaml file only
>>>>> fails when run under gitlab. I've never seen a failure running it
>>>>> locally.
>>>>>
>>>>> If it failed locally too, then I'd agree that it should not be
>>>>> skipped in the CI yaml, but universally skipped in all scenarios.
>>>>>
>>>>
>>>> If I get all this correctly, we add a generic mechanic to be able to
>>>> gate CI with block tests just because there is a single test failing
>>>> with a single driver. Is that the right approach?
>>>
>>> The env variable is the generic mechanism.
>>>
>>> The yaml file exclusion for 185 is the special case, but we get
>>> that basically for free with the former.
>>>
>>>> In the future, do we expect to merge code breaking tests?
>>>
>>> Yes. We will certainly merge more non-deterministic tests. We've seen
>>> this over & over again. Something passes CI initially but after a
>>> number of CI pipelines turns out to be flaky
>>>
>>
>> Then we can mark them as flaky in tests/qemu-iotests/meson.build.
> 
> That is a long term solution. It does not address the immediate
> time critical goal to have the ability to fix a broken CI pipeline
> immediately by skipping the test without waiting for code changes.
> 
>> It seems like you ignore the point that there is a problem between
>> setting something in CI only vs making something that works for all
>> users. I'm not against an env var, I just don't see how it answers this
>> need.
> 
> Again, I'm not saying that we fix this only for CI. The env var is
> to allow broken jobs to be immediately skipped, while waiting for
> code changes to permanently skipped/fix the tests. The latter
> addresses it for every scenario.
>

I might have missed where we have a default value for this env var, out
of yaml file, that makes it apply the exact same set of skip tests for
CI, and for users running tests manually.

Where is this default applied for both CI and users?

I understand it's not needed for test 185 which fails only in GitLab,
but as you mentioned, we'll probably have non deterministic tests in the
future, so we need to consider this.

> With regards,
> Daniel


