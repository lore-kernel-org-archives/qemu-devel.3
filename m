Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6528C44511
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 16:05:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkOZd-0005px-HE; Thu, 16 Jul 2026 12:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkOZa-0005pb-Qo
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 12:04:30 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wkOZY-0005D3-Gj
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 12:04:30 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GDKM892857818
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 16:04:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 fYDVrbRB+LlR9DZ24ptHcBy6whX3UJ6tb5JuMlHfHzw=; b=fi4QMGNMaPNJKrVC
 RSnzlsJuSL/GhCL/gWAqUAN3Jgtb9TLKsTDsFkXRuOlqAUHcaD++a8GbX3ifBL9E
 lYN7HtXeluz5CyuUICA9RJTbYk/nXXZo0kG9I4IIxmaZgj4ckDs4POxdpxDumfYR
 2FA+5M2tiMMTTB7GtaQZFU56wccn3/nFkrKEyUX7Jgw+tCtiwj7mwCnohlBMIqJM
 8LKV2MT37SPiXOCqqrdDersD2tpfx6axQbvYGLOU0WYRnI9HW9gnpygP0vS521BI
 JmAg4S/pVE3EKJakguZSDu8T/X2uNf9+QB68Z8qitBS/jpYQSfnnxhcMQy528sBF
 m7o2yw==
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4feuex23n9-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 16:04:25 +0000 (GMT)
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2cc8bde6318so122993785ad.3
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 09:04:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784217865; x=1784822665; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=fYDVrbRB+LlR9DZ24ptHcBy6whX3UJ6tb5JuMlHfHzw=;
 b=RqwyK6jvBqreQmuSIuRp8PZMFHzyw8saVoSQgtQnMj85NPE2GlUlhmW9EiKwIwlgr2
 IpzhhHCns3Jjs70rFD/5IrWzsLZjpIT5iJ3/B/R4A/3pZd/R6h32/Q8Ksg+mqN2ZiZqx
 bxjDdS4Dopr5CbrNbYOdLqJN9u3mpapIaVT9UCMRClU1JNHUiSd9cczwoA5ksjCOZkkJ
 x2teZDUjjKDK6xohfqbBHDd4VR8pOkeDwcfLCSAk4vriyLV9KBWrvdbnN41YY4QuS7D8
 7zsPfiBzXDsUp+JeW9o0Ohrw1ziZ1P+/gOpJxwxKS6c5ScisaoU/aRXKGRQVXtC3gfiQ
 6I8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784217865; x=1784822665;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=fYDVrbRB+LlR9DZ24ptHcBy6whX3UJ6tb5JuMlHfHzw=;
 b=MOd6f8sly2K64b8uZT4RVhxEf24P7DBddtL2lzAKDVDZmj9ZEHqvZP67g80iNX8CAB
 MhO5E7vXsDMEy4HpbnfoLwbbwZhAsKsFTrn2eUmIaL1rNtOWzDER+kWnsYDalKfg79+w
 fqdr8BXJdOB1iR4wS9Ach+fmw/DfrSvXSG+jotmtQuqUV46HIZfa7aIxLGGT2j4XT050
 D3stNXtiCobHS3fPWFf5Wq2YtOWeSnzfLKQ1zwauF2weRNqwGHI+OlPFgE4sBsmi4qVx
 eq1yktprNZogNn5DOqKlM58eVCWFJxd5o9JwRGgIJ0mPSRx/I1dixUmdWagp+I0hKb52
 9OTA==
X-Gm-Message-State: AOJu0YyiXvPxT28zbYqiLvnGCqQHiZic8nJa4iv5E7QVPr0tZqI0fqFj
 VysS4Ian8lC7KLtOLPkmK1cXfBGjhZgxfNISiSEpP52nW6LQK/oqDQA47U94j7SfeXcfzHI6Fro
 BkUWgwZVuYtcVb/9iANlu57fL5XVP1UdEQc15BArZ/MaUU+vA5jkJVaL6zw==
X-Gm-Gg: AfdE7cnwA6wL+Vw5TNS/L46Bx08qJGzLerMwJG6ezBo5jwYm+5VQRnOx/RDhIToJhVv
 qHPQg2Okcw9rzmBw5CS8bDPJoRacKBKqMfdhrDaR4FekDwnY7Yw4b/nXhIdZwjo81uRo2q7ETH7
 ZjN5wYTEK0uZOyCFYPboqrktnB9iw4QwWzNw3TqMIE2h/ozr+npmcosMkPHEa9RSudiPvlxc9FC
 MkQm438FL4a4pxwyFUwFlVUFONDkP2n7QOWsXhY6ikmjdlkUzOcQx0znOJw2YuPKRi9jPZSM9B2
 1JlKIkQvx21mahFhZzm7S2JTCvwW2XfETesSC6W/QAQXF9SmQED3p90WdIzm7DKoOsx4KVguhIE
 SXWymBx52GPsTAED265JEu7sqW++QryDTyHGyiNTshgJIrr4rDAPtHccz7vg4q68U6Qod
X-Received: by 2002:a17:902:eccb:b0:2c9:bf82:dd11 with SMTP id
 d9443c01a7336-2cef1194387mr112042955ad.7.1784217864849; 
 Thu, 16 Jul 2026 09:04:24 -0700 (PDT)
X-Received: by 2002:a17:902:eccb:b0:2c9:bf82:dd11 with SMTP id
 d9443c01a7336-2cef1194387mr112042415ad.7.1784217864329; 
 Thu, 16 Jul 2026 09:04:24 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2cf100e3915sm22904875ad.3.2026.07.16.09.04.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jul 2026 09:04:23 -0700 (PDT)
Message-ID: <a88ec0dd-2daf-4bce-b08f-bc0e472c1932@oss.qualcomm.com>
Date: Thu, 16 Jul 2026 09:04:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 95/98] tests: remove tcg tests machinery
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
 <20260710214343.2065491-96-pierrick.bouvier@oss.qualcomm.com>
 <87pl0ognos.fsf@draig.linaro.org>
 <a7b40c16-fd9b-4d81-b767-19fd3523c533@oss.qualcomm.com>
 <87jyqvgu05.fsf@draig.linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87jyqvgu05.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Authority-Analysis: v=2.4 cv=JeeMa0KV c=1 sm=1 tr=0 ts=6a590109 cx=c_pps
 a=cmESyDAEBpBGqyK7t0alAg==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=x2NpYwA8f-TEMJUGOvwA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=1OuFwYUASf3TG4hYMiVC:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: MNaNXztnZkISiYc1V_5AVv8V1_Ox7jOE
X-Proofpoint-GUID: MNaNXztnZkISiYc1V_5AVv8V1_Ox7jOE
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2NSBTYWx0ZWRfX/7oPB6KFIHcd
 fa6EGueCIypWGDErnIx3T4Mg4fPkm3vRHGuG+k8y4NgIXbIBb9vXbHA9ISC8vMaTBfGxKxaZpr/
 4+lJwb9Kt8RodICTvD3FhYE+y4VXAUA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2NSBTYWx0ZWRfXynk35BoDWwSC
 aQzUBQkU0heePNEE8WxkvMNlOAtz4+/PAih0MB6gmgkddCa2onWeH/l0JXA+vQfxgDG0aV0qVY+
 of0oG3Uh5vHGkKUJlSgoWQlAhakX8AJ07UisbKw2A/rGiKHhLLOgBCFqufr3EKSQHt17aFRdg0f
 exCQDQvfekC2ebd3ChsBXSu6mZPyVfQVxUptUhSRty3TNS1rJaw/Zv9YMtj4j858og6VvzsVu7a
 gCP/JCwGjQb9EFNLea6MzaGc/G/ScEZ6X4UXaqPbDGkAKUFvXJOlSdHIUHqKPyYtsuK2bznynWL
 Ttf9aMxLOenvjP+gZT/nasHZNgnw6LbM9Fe/30QjN+qeBSvhqO2xCUaHOG9+0o4feunZCemOzfp
 JT2YQAHHVx7BHL2+U4R09RAdkprnhj6W9Fb3H9pevZELCFpNulT8IYlz6EytUjlLUAUz4YwAbrR
 oXRZDqQTc4rQbNUrHVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 clxscore=1015 suspectscore=0 lowpriorityscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160165
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

On 7/16/2026 2:32 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> On 7/15/2026 10:36 AM, Alex Bennée wrote:
>>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>>
>>>> It's now built-in meson, which offers targets check-tcg and check-tcg-*.
>>>>
>>>> Tested-by: Alex Bennée <alex.bennee@linaro.org>
>>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>>> ---
>>>>  tests/Makefile.include | 68 ++----------------------------------------
>>>>  1 file changed, 2 insertions(+), 66 deletions(-)
>>>>
>>>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>>>> index 494d0109f26..9f82552ab54 100644
>>>> --- a/tests/Makefile.include
>>>> +++ b/tests/Makefile.include
>>>> @@ -19,9 +19,7 @@ check-help:
>>>>  ifneq ($(filter $(all-check-targets), check-softfloat),)
>>>>  	@echo " $(MAKE) check-softfloat               Run FPU emulation tests"
>>>>  	@echo " $(MAKE) check-tcg                     Run TCG tests"
>>>> -	@echo " $(MAKE) run-tcg-tests-TARGET          Run TCG tests for a given target"
>>>> -	@echo
>>>> -	@echo "The variable TCG_TEST_FILTER will select the subset of matching tests."
>>>> +	@echo " $(MAKE) check-tcg-TARGET              Run TCG tests for a given target"
>>>>  endif
>>>>  	@echo
>>>>  	@echo " $(MAKE) check-report.junit.xml        Generates an aggregated XML test report"
>>>> @@ -40,67 +38,6 @@ export SRC_PATH
>>>>  
>>>>  SPEED = quick
>>>>  
>>>> -
>>>> -# TCG_TESTS_WITH_COMPILERS represents the test targets we have cross compiler
>>>> -# support for, CONFIGURED_TCG_TARGETS it what meson has finally
>>>> -# configured having rejected stuff we can't build.
>>>> -CONFIGURED_TCG_TARGETS=$(patsubst %-config-target.h, %, $(wildcard *-config-target.h))
>>>> -
>>>> -# This is the intersection of what tests we can build and is configured
>>>> -TCG_TESTS_TARGETS=$(filter $(CONFIGURED_TCG_TARGETS), $(TCG_TESTS_WITH_COMPILERS))
>>>> -
>>>> -# Per guest TCG tests
>>>> -BUILD_TCG_TARGET_RULES=$(patsubst %,build-tcg-tests-%, $(TCG_TESTS_TARGETS))
>>>> -CLEAN_TCG_TARGET_RULES=$(patsubst %,clean-tcg-tests-%, $(TCG_TESTS_TARGETS))
>>>> -DISTCLEAN_TCG_TARGET_RULES=$(patsubst %,distclean-tcg-tests-%, $(TCG_TESTS_TARGETS))
>>>> -RUN_TCG_TARGET_RULES=$(patsubst %,run-tcg-tests-%, $(TCG_TESTS_TARGETS))
>>>> -
>>>> -$(foreach TARGET,$(TCG_TESTS_TARGETS), \
>>>> -        $(eval $(BUILD_DIR)/tests/tcg/config-$(TARGET).mak: config-host.mak))
>>>> -
>>>> -# $1 = the stem (e.g., arm-softmmu or x86_64-linux-user)
>>>> -get-qemu-bin = $(if $(findstring softmmu,$1),qemu-system-$(subst -softmmu,,$1),qemu-$(subst -linux-user,,$1))
>>>> -
>>>> -$(foreach TARGET,$(TCG_TESTS_TARGETS), \
>>>> -        $(eval .ninja-goals.run-tcg-tests-$(TARGET) += $(call get-qemu-bin,$(TARGET))))
>>>> -
>>>> -.PHONY: $(TCG_TESTS_TARGETS:%=build-tcg-tests-%)
>>>> -$(TCG_TESTS_TARGETS:%=build-tcg-tests-%): build-tcg-tests-%: $(BUILD_DIR)/tests/tcg/config-%.mak
>>>> -	$(call quiet-command, \
>>>> -            $(MAKE) -C tests/tcg/$* $(SUBDIR_MAKEFLAGS), \
>>>> -        "BUILD","$* guest-tests")
>>>> -
>>>> -.PHONY: $(TCG_TESTS_TARGETS:%=run-tcg-tests-%)
>>>> -$(TCG_TESTS_TARGETS:%=run-tcg-tests-%): run-tcg-tests-%: build-tcg-tests-%
>>>> -	$(call quiet-command, \
>>>> -           $(MAKE) -C tests/tcg/$* $(SUBDIR_MAKEFLAGS) SPEED=$(SPEED) TCG_TEST_FILTER=$(TCG_TEST_FILTER) run, \
>>>> -        "RUN", "$* guest-tests")
>>>> -
>>>> -.PHONY: $(TCG_TESTS_TARGETS:%=clean-tcg-tests-%)
>>>> -$(TCG_TESTS_TARGETS:%=clean-tcg-tests-%): clean-tcg-tests-%:
>>>> -	$(call quiet-command, \
>>>> -           $(MAKE) -C tests/tcg/$* $(SUBDIR_MAKEFLAGS) clean, \
>>>> -        "CLEAN", "$* guest-tests")
>>>> -
>>>> -.PHONY: $(TCG_TESTS_TARGETS:%=distclean-tcg-tests-%)
>>>> -$(TCG_TESTS_TARGETS:%=distclean-tcg-tests-%): distclean-tcg-tests-%:
>>>> -	$(call quiet-command, \
>>>> -           $(MAKE) -C tests/tcg/$* $(SUBDIR_MAKEFLAGS) distclean, \
>>>> -        "CLEAN", "$* guest-tests")
>>>> -
>>>> -.PHONY: build-tcg
>>>> -build-tcg: $(BUILD_TCG_TARGET_RULES)
>>>> -
>>>> -.PHONY: check-tcg
>>>> -.ninja-goals.check-tcg = all test-plugins
>>>> -check-tcg: $(RUN_TCG_TARGET_RULES)
>>>> -
>>>> -.PHONY: clean-tcg
>>>> -clean-tcg: $(CLEAN_TCG_TARGET_RULES)
>>>
>>> We still need a clean-tcg or similar rule to force a rebuild of the
>>> tests without killing the whole build dir.
>>>
>>
>> It was needed before, since we only had partial dependencies.
>> But now considering that all dependencies are correctly tracked, what's
>> the use case?
>> - If a test is mtime modified, it rebuilds the test.
>> - If a dockerfile is mtime modified, associated tests are rebuilt.
>> - If docker.py is modified, it will rebuild tests transitively.
>> - If cflags are modified, test will be rebuilt also.
>> - All input of a test (.h, .c, ...) are all tracked.
>> - If user installs a cross compiler or remove podman/docker, next meson
>> configuration will identify this and rebuild all associated tests.
>>
>> In case you find a missing dep, we just need to add it in meson. clean
>> is not needed anymore.
> 
> OK I was testing the changing of the cross compiler and I noticed its
> not reported in the config summary if we have the fallback to
> podman/docker.
> 
> I suspect the logic here:
> 
>   # snarf the cross-compilation information for tests
>   summary_info = {}
>   have_cross = false
>   foreach target: target_dirs
>     tcg_mak = meson.current_build_dir() / 'tests/tcg' / target / 'config-target.mak'
>     if fs.exists(tcg_mak)
>       config_cross_tcg = keyval.load(tcg_mak)
>       if 'CC' in config_cross_tcg
>         summary_info += {config_cross_tcg['TARGET_NAME']: config_cross_tcg['CC']}
>         have_cross = true
>       endif
>     endif
>   endforeach
>   if have_cross
>     summary(summary_info, bool_yn: true, section: 'Cross compilers')
>   endif
> 
> needs to be cleaned up.
>

Thanks for reporting it, I didn't even notice this part of the code
existed to be honest. Indeed, it needs to be updated, and it should be
easy to present the same information from what we did during the test
configuration.

I'll add it in next version.

>>
>>>> -
>>>> -.PHONY: distclean-tcg
>>>> -distclean-tcg: $(DISTCLEAN_TCG_TARGET_RULES)
>>>> -
>>>>  # Build up our target list from the filtered list of ninja targets
>>>>  TARGETS=$(patsubst libqemu-%.a, %, $(filter libqemu-%.a, $(ninja-targets)))
>>>>  
>>>> @@ -128,7 +65,6 @@ check-build: run-ninja
>>>>  check-clean:
>>>>  	rm -rf $(BUILD_DIR)/tests/functional
>>>>  
>>>> -clean: check-clean clean-tcg
>>>> -distclean: distclean-tcg
>>>> +clean: check-clean
> 
> I wonder if check-clean is redundant as well now if the functional test
> dependencies are properly encoded.
>

It's not really used for dependencies issues (tests/functional has no
meson built binaries), but just to clean tests/functional folder, which
may contain logs, scratch files, and other things leftover from those tests.

I would keep it for now as it doesn't hurt.

>>>>  
>>>>  endif
>>>
> 

Regards,
Pierrick

