Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29A80C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 17:29:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk3Pb-0003wB-Ro; Wed, 15 Jul 2026 13:28:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wk3PR-0003vt-TI
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 13:28:39 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wk3PP-00026N-Nl
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 13:28:37 -0400
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66FHBHOp050592
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 17:28:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 /WjudwRurotWeF7bDAVEL8xq/hEAZtTARjZOhS4jnBA=; b=fcaQoCK8lCYFkKfZ
 pRwVsinSY435jACLsBnLBaF6QqUHaR0Q4Z6zbJr/pzldyMg1viQlrol+T6KidAGo
 mC4v7D1IPM7oN+TsDLcyKmo8PuFLK/7sPR8usiiR7XW9yfOXO/+H//vU1lZn6bdz
 sQX2M1la2/ndI/6MilNRoYm+MCuXH9ksOJLuGWefORCdJdJL/kV4+SBXc6hqP/qm
 ijfM/iZFyiFA8FrOWcbllsqwtywNIJRbhK/30SN6pUeI68wYXG3xZRl1zl2cRE9f
 DK9JY0xzOF7V4jH7U549Y/PSPaFdSs8+mWM/oXNoteZVSPC5AmvHo5XKHD+jh/2R
 mFFHgA==
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fecny8n99-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 17:28:33 +0000 (GMT)
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-c9fe4c5eb39so4155315a12.1
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 10:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784136513; x=1784741313; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=/WjudwRurotWeF7bDAVEL8xq/hEAZtTARjZOhS4jnBA=;
 b=ULMR7zHlOpECr4bj0/+l/8+sBEXrm8RbsWLIqezm2LPVbKJHPJpsT7TwPKoM/nayXZ
 C0TneiiJkrfgLwOGNdbOARJR9N62XKkTIp3FYd2n/4ulORuraqTBjJNL889I+fSCIaN2
 QAGzK9l8ZW06O397Hh9MOIXAFQdESXUVeS5vSUHewlc10NVBctq18rv3e0rO75L3XsOa
 HU3vmeQLPPmika+8qRnh5zWaXYZPIsRmLmt4ddDAhgSo0JD+2z/R2iZaDinnaWLxV9tP
 GAZgdsZWrYd8g2M/kWRlhALBkDTi0QLMB4mPHOENKFtoqqKtwAULhhb37CmL0WtI1W4M
 Zl6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784136513; x=1784741313;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=/WjudwRurotWeF7bDAVEL8xq/hEAZtTARjZOhS4jnBA=;
 b=YHQI9UsAAVVCvzc3kGuYrqFt+jx9cYb7e7wumVrFZPysFlz1nGP615GMEPBkbfuVZM
 d9HUGR4ftYG9TWGfenvLc4I923qftqc4l/CGWD6SHRNUu86dkoDS3LduxJv4PEkNwE9e
 zbnShI1ZuAbUWy9XMzw9ONvRw+vs9moBXCXo7QorvLWYJnBlbGcnGmIyMPPv3OYJ/ua/
 a8EBBFuVDL6oPRSQtRbhxsExqM3Rox4c3QeaN/1IGZghNMbC7WP6rEPyrKlz4SujYQaU
 +YxuMt9ULckzSDCIPgL+ZCtYGkGc9rq8yX9ITPVtplL1A66fh1+s0AKihh+j4zGcoyEa
 R6rw==
X-Gm-Message-State: AOJu0YylGj9tXWTyGbptM1Im9CyS3XPYmaaEEsViol6Awaj1HbfPocA+
 uzftbQBDZIw+LeUIDoU9EfzfVETsIptZ2gEetYDDg+0aubrqKojI0+/wxrFlaJlnB6prxcf1lJl
 JBs9rE6o//M0QkT6dco2E+5rpVXk+AtFAk93lmemphR/IVr2eFkxu4hhhMQ==
X-Gm-Gg: AfdE7cmbWyTStMWHVCEOTfe/ooYasI5X32lG+wLpUMuXiERrQ0DgCM8xJ/tI9nyIXNw
 JjLX5hvi+OXdNzsrvhu80jvERdbGD9hKUAuBBcgn88SEBte6BVci2RUwnPpqsd8Mof0qzGT7u8Q
 IOUTP7SGsrYbH2aEh/Ho6IS/5fTVMKs1QUPkw1YHOfmeCh0+hrHNCE3XtJPRWfc3QYICBzB1tdL
 o7vmfMgvzgx+pgIWxAqG2B7TIl8Uc0HtXLlCOjCwj78ZgjIyVdqSq5qcMbTluuwryTSXU2ppL7H
 HH/CpLXu2+YJGbiD2vYaQ8prxiAlKImwt9J0StQQx7C98eUchj9BUoBnoTIvefFSMSxlcu8A57W
 RzSEQ99k4Qd+/dUqm1IRj+VapQO183A5DdUHvFCNkFu5vwYRRidjErUOSfOqqoZzZQKKIKLfS0C
 ySQNY=
X-Received: by 2002:a05:6a20:a120:b0:3c0:9c19:659a with SMTP id
 adf61e73a8af0-3c36c4139b8mr4416596637.66.1784136512782; 
 Wed, 15 Jul 2026 10:28:32 -0700 (PDT)
X-Received: by 2002:a05:6a20:a120:b0:3c0:9c19:659a with SMTP id
 adf61e73a8af0-3c36c4139b8mr4416551637.66.1784136512184; 
 Wed, 15 Jul 2026 10:28:32 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-13cd432f1cesm4719758c88.11.2026.07.15.10.28.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2026 10:28:31 -0700 (PDT)
Message-ID: <b23acda5-ae40-4f88-9762-ec00adcb6b23@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 10:28:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 00/98] tests/tcg: run tests with meson
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Brian Cain <brian.cain@oss.qualcomm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 =?UTF-8?Q?Daniel_P=2EBerrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>,
 Gustavo Romero <gustavo.romero@linaro.org>, Helge Deller <deller@gmx.de>
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 <87cxwpj3rj.fsf@draig.linaro.org>
 <8cf29764-387d-4465-b630-db1742a58eda@oss.qualcomm.com>
 <87v7aggr13.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87v7aggr13.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE3NCBTYWx0ZWRfX3yBi8vKwcyYG
 RIWPdLBxHINkW7AvJ2Mmam/3MEwAd/XWNkL5kLQGXuMoAZku6Hw0cza3UHL+SLyfbhZBvCDdJIK
 5ad6Edu5+pazZRNipMz++9GnHnpSncY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE3NCBTYWx0ZWRfX1RDD5DNEtWGU
 LbD8gMN6V/cE6lqJEMqBoH4WBG3arRaQeJAhwYF29te8IZQGGCwHzRX9kqfYsr3xLNPx/amBbXc
 xzP2G1mzpQPS0bgI8TfHXoOAFJHFNuVHgL6D0ASeK8WkYRylmVFyqBiu8+UTEitZX09UqyCE1kf
 7S7GPQiNvV4yt6ZcQrLGe2EzfZ5cyggWdXfdJu4kWoJxRugu0o7gCt/FWt9s9NBbKBywGP0zIqu
 Hj8ULbYY6VvHx8ailhrn3AHveWAlOBgcLD/pCH/4UJL86Ic2XDqsxqvapDRzoK+6H0QYREP1kKt
 sI3X80ffk4VfnaRSdyqD8ttVhRBQ83wJjFLRz6pM98mf4UMQfZ/7sfrqQTASMSjZM5J5BxbfNPM
 yhAEhJDh+VRYMkVX6uMz6cjithG5YqLf2xWZGnq1gRUIRBlaqQtI8iUrQ0jVeo8LOnqi9cIBv2H
 j6ceB+H9sHhaWKg3cMw==
X-Proofpoint-ORIG-GUID: IjrZxb8JpxkkSEdWtAVnY6L_xyP3zQ29
X-Authority-Analysis: v=2.4 cv=Lt2iDHdc c=1 sm=1 tr=0 ts=6a57c341 cx=c_pps
 a=rz3CxIlbcmazkYymdCej/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=yx91gb_oNiZeI1HMLzn7:22
 a=VwQbUJbxAAAA:8 a=KKAkSRfTAAAA:8 a=jtyxVqDdAAAA:8 a=MrQ0Z4aQAAAA:8
 a=EUspDBNiAAAA:8 a=SjvqWVyGsqdrZl9cGMwA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=bFCP_H2QrGi7Okbo017w:22 a=cvBusfyB2V15izCimMoJ:22 a=D0qpmhatDSoHz4RXNCtZ:22
X-Proofpoint-GUID: IjrZxb8JpxkkSEdWtAVnY6L_xyP3zQ29
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150174
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

On 7/15/2026 9:24 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> On 7/14/2026 2:53 AM, Alex Bennée wrote:
>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>
>>>> This series replaces TCG tests makefiles with meson, with the
>>>> goal of having something more readable and maintainable in the long term.
>>>> Also it closes the gap that tcg tests had with the rest of tests, by integrating
>>>> them with meson directly.
>>>>
>>>> It covers all existing tests for all architectures, including
>>>> user/system/multiarch-user/multiarch-system. It implements all requirements
>>>> listed on original thread [1].
>>>>
>>>> [1] https://lore.kernel.org/qemu-devel/87wlwfsay4.fsf@draig.linaro.org/
>>>>
>>>> We also have for free:
>>>> - correct and complete dependencies for any test, including:
>>>>   scripts, c.inc, headers, reference files and binaries/plugins.
>>>> - catch test declaration issues at configure time vs test time.
>>>> - proper data types for variables instead of string expansion with make.
>>>>
>>>> Series first introduce the meson machinery needed in tests/tcg/meson.build, step
>>>> by step. Then it adds support for all existing archs. Finally, we remove
>>>> Makefiles and configure bits, and add documentation.
>>>>
>>>> Usage:
>>>>
>>>> ```
>>>> make check-tcg
>>>> make check-tcg-aarch64-linux-user
>>>> make check-tcg-aarch64-softmmu
>>>> make tcg-tests
>>>>
>>>> ninja tcg-tests
>>>
>>> This does work but I couldn't see tcg-tests (or individual tests) when
>>> running:
>>>
>>>   ninja -C . -t query all
>>>
>>> (which is what my Emacs's helper uses to query potential targets from
>>> ninja).
>>>
>>> The plugins, unit and qtest tests all appear in the list.
>>>
>>
>> This is because tcg tests are not built by default (so not included in
>> all), but they are under target tcg-tests.
>> Good news is that updating emacs config won't be too hard:
>> ninja -C build/ . -t query all tcg-tests
> 
> Thanks.
> 
> The helper is intending to be a generic introspection helper for
> multiple projects. Do you know if its possible to query for the list of
> groups(?) with ninja?
>

When you think about it twice, 'all' is just the default implicit
target. It's not generic, just a consequence of following original make
design.

If you consider the build graph, the really "generic" part are the roots
of it: nodes who are not dependencies of any other.

That's similar to what ninja -t targets, that you found, does. The only
difference is that its definition is targets producing outputs, instead
of just considering nodes in the graph. I don't think it matter too much
for your use case though.

https://ninja-build.org/manual.html#_extra_tools
```
targets
If used like ninja -t targets depth digit it prints the list of targets
in a depth-first manner starting by the root targets (the ones with no
outputs).
```
I'm just a bit puzzled that depth 1 (and not 0) is the default.

> I guess something like:
> 
>   ninja -t targets | grep phony
> 
> would work but I wonder if there is a better way?
>

More simply, you can stick to 'all' and assume that dependencies are now
correct, and that launching a test will automatically build what's needed.
That's the whole point of the series, that we don't need to "build"
tests or binaries by hand, or artificial make dependency, anymore. I
added the target tcg-tests for convenience, demonstration purpose, and
because people are used to do that, but it should not even exists to be
honest.

At this point, the "generic" part you really want to add in emacs is
which tests and suites are available. VSCode has this kind of feature
with Test Explorer:
https://code.visualstudio.com/docs/debugtest/testing.
- tests:
./pyvenv/bin/meson test --list | sed -e 's/.* - //'
- suites:
./pyvenv/bin/meson test --list |
sed -e 's/ - .*//' |
tr '+' '\n' |
sort -u
Regards,
Pierrick

