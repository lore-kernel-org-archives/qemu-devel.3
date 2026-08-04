Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57B77C55822
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 21:36:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrMnX-0004h5-6u; Tue, 04 Aug 2026 17:35:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wrMnV-0004gi-FR
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 17:35:41 -0400
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wrMnT-00078t-Dv
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 17:35:41 -0400
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 674JlRHN428154
 for <qemu-devel@nongnu.org>; Tue, 4 Aug 2026 21:35:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 zXG7QMpY+RDbCQyoz9fwASLLBzSO4sCG4k/Dr+f0kIE=; b=NDUUKzuQ9pjZTU2R
 qmTP2og+0MKhTBu+8hVh6MkazJxcfZ9VZc3F2N+12pZhZN/er/HZhIOS6Fn+0ZaM
 Ie4f4E4In5UDq+GGwZzrkswEvkXtrour9uqOWCeXNi2VgcLhoDt6NRAaGpNPTisa
 y2KjDaBDJyMtvMNqkMqiE/YUFHKGL91K3vZbek+TydEkIoRoKnxnfrqTPSJS+Zm3
 Q+WpdWLKwqtAJ0zvrDR3DbyL/Zi0xVDpAc4WY7EP/RvIoglRNf1ef+Sd2baVogHv
 +2CEUYIU+KCKpuy2k8vOBC27fj6/fRJh2FmqGexReo2s2/evSWct3d4wobU35yAT
 bNVFMg==
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fugmgjcwe-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2026 21:35:35 +0000 (GMT)
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cb5bdd8450dso145115a12.0
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2026 14:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1785879335; x=1786484135; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=zXG7QMpY+RDbCQyoz9fwASLLBzSO4sCG4k/Dr+f0kIE=;
 b=iMYQ8xAAJZ2KyuZApRo+RQGQFogaQ2+wkOzUeN0G7xeGrEQ8/ZZpweySyPES5MNFCJ
 fCTEVn8za8GLOnFPkT0cPJrWd0DYuKQlSqqo47vEHHDiygt9aezWoZFDSZN7WPdHqfA7
 VulF14mNNJchkQnBFvteNTGvm9cP6GDZk340ewpGq7aOLNHMPd+AkVwfdAbNkgx8cOJo
 AtiWxSpVuCpe2OxtmY8vOI1iJvQ1qSSOU/MvX34Fu1okxKdHeeDmZBaoSa4Sni346FLF
 BfW2835K2vmZ+qJZXNzOarKvOTQ74QInWf61dlz1lTN2/Sb1lNracmeCCDPQAgrQ1kDK
 BHYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785879335; x=1786484135;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zXG7QMpY+RDbCQyoz9fwASLLBzSO4sCG4k/Dr+f0kIE=;
 b=MbVxpvikVZsg3t9qzDem50R6+8JymAwBwEmK89iuKh/8X8JAMxKx7bYpuzDA8TTPxh
 ZCNkAc2t8N9tBbwTdjt6IcHEkbzLtIJm+DO360DUzpa4b0V+QvO0h2XcWKVy9p5GJB1r
 u0wuUZfAQkk2N/ZdWwRoabu8QU1VJ/nXxj+UJ9mCudqR/tMmuuhG0jyxE0YRfvyeCqkR
 Filmnjkahe5I0Q72de+kyfPayjCH2QWh3kkTpa/lrtY6K3sfnLsBfA7dwvnQXZJtUhX2
 WVXDri3l4ZVAJUrupiqxTTqV9uEDMY0XyW8Ozo4fNm1jnjWpilfDSbkXvLaA48JtTQI/
 YyJA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpYECDyba6Lj1BfkkzZGhp6nQKsoEVeTsctzHNBGXgRJbgxEbRFDGXohIpdvqgNr435FaRpnIajnCO+@nongnu.org
X-Gm-Message-State: AOJu0YwO9+V5v1Rae7GwxYsR7g067JH/JvqVKyJWBW0vXru7ms2FXDNz
 41qOoA2pr3/Mu09E69Bvv4ShDKKX8dfz89GZIicmgikChebDh9/quPVXC2vaw9LkpHLU2g0esBa
 /DtmEUi8SjttNhPhhaqYrmyKwKBewJMuW/WdaQO+kvR6Z3Jqhjo17ew78rQ==
X-Gm-Gg: AR+sD13mZSAjaYaf30PkWx0zALHJ5fSfsLDkYqKuby+WIsfLEyMzsNGkLQdjR0YL83m
 Lbr8Y7fOGpHH2D9tscqtBcvS1a0ywqn1r8XIyWPA16WPXfqrn5YbF5S1bxpDjgKd7McTO6+SzaF
 9mbtghxlGJ+vqIES+OHrb0FDi9jJ19wYTXHE1/oYUSa9DRGjSgEuAY4oWNu+EDVHV7zpzv43Tyz
 wLQuBJR2D7mj8svBfYVVJllunpOa20u7u5Da5boL/77k0HATDmP4LlWCq3nGMZdewKnmh/vwbjY
 /cWYntJApwOYgBw97r1Kc5qtZPVJnCg/5tc7eHlGDtiuHC9jiZ/7wElif3dKiW/31JmlDgdAmBC
 IPOdkmw+oOqlE2zlJ6IZsZLr1GLObqQxn2raOQ1HSWHG/PJMd725KHZx+nGQnPj2vl8JV
X-Received: by 2002:a05:6a21:6f11:b0:3bf:6237:4d4a with SMTP id
 adf61e73a8af0-3cb85ef97abmr2112158637.24.1785879334923; 
 Tue, 04 Aug 2026 14:35:34 -0700 (PDT)
X-Received: by 2002:a05:6a21:6f11:b0:3bf:6237:4d4a with SMTP id
 adf61e73a8af0-3cb85ef97abmr2112060637.24.1785879334095; 
 Tue, 04 Aug 2026 14:35:34 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315867bc341sm14697156eec.27.2026.08.04.14.35.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Aug 2026 14:35:32 -0700 (PDT)
Message-ID: <99dbdbc5-06a4-4d17-bcde-e5985a25d294@oss.qualcomm.com>
Date: Tue, 4 Aug 2026 14:35:30 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 18/18] tests/functional/hexagon: enable more arch_tests
 cases
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>
Cc: philmd@oss.qualcomm.com, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 matheus.bernardino@oss.qualcomm.com
References: <20260730012824.1135905-1-brian.cain@oss.qualcomm.com>
 <20260730012824.1135905-19-brian.cain@oss.qualcomm.com>
 <0c791fd2-f4d0-4f3e-8ad5-4d61ccd724fe@oss.qualcomm.com>
 <6dfdd807-c6e7-4548-b4c0-73460295a7e7@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <6dfdd807-c6e7-4548-b4c0-73460295a7e7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA0MDE3NCBTYWx0ZWRfX7Sjv9avi275E
 LDqKgwgoiz3eTJ1GB8m7522ADfB7h97Sr0R6fPuXFlTf5xEE72Jw3NhIAbxcvhide8WZkdHxL/6
 AesVVzDsmZiEcPx8GoE5CiUoIrRsguavzHd1gDqxOb3Z8bmfr9PohVl1cMK/ReYxG0uf1qnQ+IG
 2zDoM2v94rz+yfmih3Fh/37SElVH//TH48AZb2aSZRRukB9IAFWn16bNeiyXgoPrRtUDg/b6t5l
 ATLWJpuJRCBpFT3gIqqfuJgZZ5ZndRX7/H6kWxjLzU/UT29nrAH73k++4Q080Ww7Ht3tV3Lhrgh
 cvgMWy/FrIliyh7H5uoMMT6j8dTJ6EPzloYz2gd/sVcpvrEGZyolCKtZO95zTfmFNbwIUESONDl
 xbqC3c58AVKrvFx63z6iuScYS+IBTljXeumyaYgNCnMlRDB0bYYQmrNaJPwIsq+URHMVw27JzHO
 rf3UFl0QK4kqWBtptWg==
X-Proofpoint-GUID: VwPF8PQvtK5l-ypdbQPrryVzRXtYW3A5
X-Proofpoint-ORIG-GUID: VwPF8PQvtK5l-ypdbQPrryVzRXtYW3A5
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA0MDE3NCBTYWx0ZWRfX+5EGz0BwxrEo
 QQqaP3wxWtVeLihQTplEQTq671rt3OqQiq2LCN/cGAM81OaL8NKrt1atQMaMiz5qbolxXtLMSjN
 Rd0r/ML4N4GFR8fNwG6oLyXPbQgKQNw=
X-Authority-Analysis: v=2.4 cv=XYC5Co55 c=1 sm=1 tr=0 ts=6a725b27 cx=c_pps
 a=Qgeoaf8Lrialg5Z894R3/Q==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=_K5XuSEh1TEqbUxoQ0s3:22
 a=EUspDBNiAAAA:8 a=rEkoFQyQWuQbJpjok6UA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=x9snwWr2DeNwDh03kgHS:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-04_05,2026-08-04_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0
 clxscore=1015 bulkscore=0 impostorscore=0 priorityscore=1501 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608040174
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

On 8/3/2026 8:43 AM, Brian Cain wrote:
> 
> On 7/31/2026 12:42 PM, Pierrick Bouvier wrote:
>> On 7/29/2026 6:28 PM, Brian Cain wrote:
>>> Add more tests from hexagon-arch-tests, enabled by QTimer device.
>>>
>>> These exercise cache maintenance ops, l2vic, thread start/stop, tlb/mmu
>>> operations, and user-mode transitions.
>>>
>>> Signed-off-by: Brian Cain <brian.cain@oss.qualcomm.com>
>>> ---
>>>   tests/functional/hexagon/test_arch_tests.py | 32 +++++++++++++++++++++
>>>   1 file changed, 32 insertions(+)
>>>
>>> diff --git a/tests/functional/hexagon/test_arch_tests.py b/tests/
>>> functional/hexagon/test_arch_tests.py
>>> index 2bb34f9b8dc..0834398c3b1 100755
>>> --- a/tests/functional/hexagon/test_arch_tests.py
>>> +++ b/tests/functional/hexagon/test_arch_tests.py
>>> @@ -58,6 +58,38 @@ def test_int_steering(self) -> None:
>>>           """
>>>           self.run_uart_test("test_int_steering")
>>>   +    def test_cache(self) -> None:
>>> +        """Tests cache operations: dckill/ickill, l2kill, dczeroa,
>>> +        dccleaninva, cache disable/enable, barriers, and dcinva/
>>> dccleana.
>>> +        """
>>> +        self.run_uart_test("test_cache")
>>> +
>>> +    def test_l2vic(self) -> None:
>>> +        """Tests the L2VIC interrupt controller: enable readback,
>>> +        interrupt type readback, VID capture, and the fast interface.
>>> +        """
>>> +        self.run_uart_test("test_l2vic")
>>> +
>>> +    def test_threads(self) -> None:
>>> +        """Tests hardware thread management: start/stop, MODECTL state,
>>> +        per-thread HTID, shared memory, wait/resume, STID priority, and
>>> +        SCHEDCFG/BESTWAIT readback.
>>> +        """
>>> +        self.run_uart_test("test_threads")
>>> +
>>> +    def test_tlb_mmu(self) -> None:
>>> +        """Tests TLB/MMU operations: write/read/probe/invalidate,
>>> +        global entries, multiple entries, overwrite, ASID matching,
>>> +        and permission checks.
>>> +        """
>>> +        self.run_uart_test("test_tlb_mmu")
>>> +
>>> +    def test_user_mode(self) -> None:
>>> +        """Tests user mode / privilege transitions: supervisor mode,
>>> +        SSR UM/IE/XE/CE/PE bits, and the trap0 user-mode exit handler.
>>> +        """
>>> +        self.run_uart_test("test_user_mode")
>>> +
>>>     if __name__ == "__main__":
>>>       QemuSystemTest.main()
>> A general question on the pattern we have here.
>>
>> If those tests can be compiled with hexagon-cross container, would it
>> make sense to add them to tcg/tests/hexagon/system directly in the
>> future?
>> Hopefully will be more easy once we have meson tcg-tests, so you don't
>> need to add all dependencies by hand.
> 
> 
> Glad you asked -- in a downstream fork, we originally did have several
> tests like these (not these particular ones but ~similar scope) running
> in check-tcg.  But we pivoted away from that because:
> 
> 1. they're not testing merely translation: they depend on several sysemu
> devices.  More like integration/functional testing.
>

That's a fair point. I'm not sure where is the exact border of what we
should/should not exercise through tcg tests.

@Alex: As tcg tests maintainer, do you have on opinion on this?
@Richard: as tcg maintainer, would you consider it as part of tcg test
suite for system mode?

> 2. sometimes it's useful to verify not merely the exit code but also
> some output text to semihost/uart console.  This *can* be done with
> shell programs in make/meson, but it feels like "coloring outside of the
> lines."
>

We can add the necessary wrappers for that. Functional tests are such
programs in some way.

> 3. most other architectures seem to have fairly ~light system emu check-
> tcg tests, perhaps because of #1/2?
> 
> 
> We did this change with the assumption that these sysemu check-tcg tests
> wouldn't be welcomed by community because it diverges from what other
> targets do.  But maybe that was an overreaction?
> 
> It's certainly convenient to have test cases in-project so that changes
> to the tests don't require an indirect step to update a test code repo. 
> So, we can do whatever best conforms to the project idioms in this
> regard.  Note that these particular tests in this patch are written in
> Rust and would introduce a new dependency (in the existing container, I
> suppose) beyond the C/C++ toolchain.  Fine w/me but food for thought.
>

For now, having it outside of QEMU is totally fine, and it doesn't seem
we should move it. We can revisit this in the future.

> 
>>
>> Regards,
>> Pierrick

