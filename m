Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D90C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 17:43:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk3dH-0005qZ-AS; Wed, 15 Jul 2026 13:42:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wk3dF-0005qQ-H7
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 13:42:53 -0400
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@oss.qualcomm.com>)
 id 1wk3dD-0003xX-EN
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 13:42:53 -0400
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66FHBKNs170265
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 17:42:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
 DOIwRVIAKhJgEEFMEfWI4etGN/cxtCYNLrSlp/+gV7E=; b=Q8Yjnkoiz9+Ak8TM
 rV83BPQbybSRYugRSUF6jndWXAro4996QsAx6xh/10m9+IWouMHkN+avL4i6qjfE
 lNW8GQON3S1HQSQqUTIT2bwOpDcGMLB1Oz9RU2/oJFMzWHyAwdNiC4i3FDLvB3dp
 B1kqheEk2L+B/jYea97j0ggY1Qi/LU7/8rFp8HBqca/fCWEZ+Lh49SpZJWsRBcQa
 kqdF5OdgvgDNk4AW6NPgnIQZzJp69obsF1D7XI/m+PTnC50e3lJkKAg/aThmDXwf
 Qh85CbOoQFRHwXEmWLKY6UbP9JnzXnrMrpOD3rLvGLhLwXNcTOeZP1dUzE5RVUhp
 FdG4Jw==
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4fe7q621k4-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 17:42:49 +0000 (GMT)
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-38e04a53a7aso3572008a91.2
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 10:42:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1784137368; x=1784742168; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=DOIwRVIAKhJgEEFMEfWI4etGN/cxtCYNLrSlp/+gV7E=;
 b=K4Y9Nir2PpM0DMo6qJhi7u2G6se1VN62LHLpysevErQ3TqL0LKN9TTf+NNSEtF8+8y
 52D+5ETXC/8qZy86nxYnoF56yWOBySoXH9NcPyAAooLYGxeSMoqIQ1KDLOM/nE8DKudm
 rbk4zcwAfONKT2PpgRNMscI5CLuZx2wpHiWk85cpqHxaHgr6xw2Alwv2lASmwoBT5Qme
 bRN02xk/nGssEyX72uvtt2iG8fWzUpibY9FOdrDqvvBsDW32cOLNmiMilKwuSHtE1Dto
 tmuz8ceYGw7HojiFtg/0tRR7QR1YdI0ovJ5CEKeleINDEPaAkIUZmVz2Rq1GyrS70MVA
 zQPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784137368; x=1784742168;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=DOIwRVIAKhJgEEFMEfWI4etGN/cxtCYNLrSlp/+gV7E=;
 b=eMqUxaSB1JlFHIgE6auY700Bl1Q0H/SPON33/HWRoi6lc0bZ8Fr12o+ggeFuWi21sE
 4a3yTemNiNW9yXlX+PBMg9tWbHSARNQktAEEI3DJr2M3bifN1YLf9dcCJoNhP13vdhhb
 Jg9T08DlXJe7UVCEm/2umhReEpnZ+bQhrEzArwLOI9VSiq1FNMFcY7C8UsuPS+ExGm65
 xPqI5a6RGrXwL/YcpcyKlvI18fR9ZHjq4nQFF4X0U5pX6bw1D1le4zF0wiRnjgf1/6CO
 5un167PajKDYYPUPDlLDf1eFdE5XvqHscY4Rqme5v3yTn8YRykU9sOzFbChmgpK2JnGz
 WzHA==
X-Gm-Message-State: AOJu0YyQom5WS4WuJC8XP+TdN4yWxAtb+72d1C6W0AWaUxZj5ChQpqUu
 zjAUqw9CSuMWkK1mKckIx1izedgRhkA9gkBUhYyN96tvush8LchMizU21RF+ajMRe6BsMsCCUXG
 qVnjeU+O47K2QqqaB4Ga9Z7lydTjjYlBhB/mWqOd5suqktlhd2ULeLqWuBg==
X-Gm-Gg: AfdE7ckeqHG4X3hxYZJWHeolrkjgZYgedJren+PjCYRUuCmXnJQ15wd8ZUIr9iCrH/y
 WpCnFcWbU5lxL9A6RQMxyapwX3YRT9tRSJB1+QE87A3YQ1mt2VAN+Dq5M+VwWghiCAohDESv/cD
 mvs32qKfjvoh2sPtlMl6CM6AqkHmuFNnA1aUPo2pWfd3CqpkNnSU5ramL2W3yKm2GaMX+BQncW9
 o+sS9jObq7aCf6PFUlnpPjfnYySHoHjIgABY+hP0TW6Vx6vJuszI9psNL6RugEjyfs5T5yDt09H
 go9un5xOyXb9Tie2bHVHn9kJuU86lNl4LIWznQSsybUzsWKJUe8lu+cWLKm92zYmckVN1hc4p4T
 dCF1RzQEhjVBdXyEvPqsw3/1UO6Br+Trgkhp2IrUB3oATSyHnvJDdT26jvPSu+ZpZY0jEX45XRE
 fhWuE=
X-Received: by 2002:a17:90b:134f:b0:380:540:d499 with SMTP id
 98e67ed59e1d1-38e29ff93d5mr3290673a91.6.1784137368064; 
 Wed, 15 Jul 2026 10:42:48 -0700 (PDT)
X-Received: by 2002:a17:90b:134f:b0:380:540:d499 with SMTP id
 98e67ed59e1d1-38e29ff93d5mr3290651a91.6.1784137367479; 
 Wed, 15 Jul 2026 10:42:47 -0700 (PDT)
Received: from [192.168.1.170] (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3140e3a0d69sm3452528eec.0.2026.07.15.10.42.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 15 Jul 2026 10:42:47 -0700 (PDT)
Message-ID: <a7b40c16-fd9b-4d81-b767-19fd3523c533@oss.qualcomm.com>
Date: Wed, 15 Jul 2026 10:42:45 -0700
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
From: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Language: en-US
In-Reply-To: <87pl0ognos.fsf@draig.linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE1MDE3NiBTYWx0ZWRfX360HzpUCQSM1
 GhvqL2/nOtc1CizcWFCnbTjrCFhtVi74nuWck8Ll9V7SO/TySoosfJfEbj1rJRbiP6Wtaew6Ih2
 J5/mVoD+bYGnGBK+gO/z1AVT5RFRt94=
X-Proofpoint-ORIG-GUID: KVqNGGtxWVyrN53vVXyRFqnqVDaDI2cl
X-Proofpoint-GUID: KVqNGGtxWVyrN53vVXyRFqnqVDaDI2cl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE1MDE3NiBTYWx0ZWRfX9QSLyV1wkLnT
 qtFnxf50ZvR5YyWbhYRE2bn7kJNvTnhDwNuBtZPxnty0E2hoGegoczBDvLhK8VEFMN271KN56tE
 /YC6O3we3Fx1JoZ6VGfOgI92InG1nM3mxm+I04uUi8jVropOhGyYzC+oIBrvdP5uMi3QGwUz+sX
 p+WjkeflPtK8Lk6uulgT26dYVwyyQEsxwcU7/1B90LP5x+sDMNb46DdZIC2xNdCtSBzEkDwBMu4
 7eK52V0RM/6KgQfMh3H3HE8tBEUsHNJOMcBZgDJJ2+zcrfDpnzoRKOmBDOQBh/xCnJwUvAG2G7L
 o/5iri97FqCkwCYdsSl5O0Ge8A3JTuPZdTfV3ucHmWgIBeeAhKgiMtIlU5q+jBhSPxa6yl4wXEx
 pDC9+ziJKOo0gsCaAxS4K6Rw0M3/6+09WlaJj2zLtU9k4pGPfctrevlidiamsRYQxjHScJlUUk2
 S1i9pcgd5Mb4tUPZ+Jg==
X-Authority-Analysis: v=2.4 cv=BajoFLt2 c=1 sm=1 tr=0 ts=6a57c699 cx=c_pps
 a=UNFcQwm+pnOIJct1K4W+Mw==:117 a=iLqgmErQAxjCjdq5jj1Aqg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=s4-Qcg_JpJYA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=u7WPNUs3qKkmUXheDGA7:22 a=ZpdpYltYx_vBUK5n70dp:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=r1IlNvYoa7QnD5ULU6UA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=uKXjsCUrEbL0IQVhDsJ9:22 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-15_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 phishscore=0 malwarescore=0 clxscore=1015 bulkscore=0
 impostorscore=0 adultscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607150176
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

On 7/15/2026 10:36 AM, Alex Bennée wrote:
> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
> 
>> It's now built-in meson, which offers targets check-tcg and check-tcg-*.
>>
>> Tested-by: Alex Bennée <alex.bennee@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>> ---
>>  tests/Makefile.include | 68 ++----------------------------------------
>>  1 file changed, 2 insertions(+), 66 deletions(-)
>>
>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>> index 494d0109f26..9f82552ab54 100644
>> --- a/tests/Makefile.include
>> +++ b/tests/Makefile.include
>> @@ -19,9 +19,7 @@ check-help:
>>  ifneq ($(filter $(all-check-targets), check-softfloat),)
>>  	@echo " $(MAKE) check-softfloat               Run FPU emulation tests"
>>  	@echo " $(MAKE) check-tcg                     Run TCG tests"
>> -	@echo " $(MAKE) run-tcg-tests-TARGET          Run TCG tests for a given target"
>> -	@echo
>> -	@echo "The variable TCG_TEST_FILTER will select the subset of matching tests."
>> +	@echo " $(MAKE) check-tcg-TARGET              Run TCG tests for a given target"
>>  endif
>>  	@echo
>>  	@echo " $(MAKE) check-report.junit.xml        Generates an aggregated XML test report"
>> @@ -40,67 +38,6 @@ export SRC_PATH
>>  
>>  SPEED = quick
>>  
>> -
>> -# TCG_TESTS_WITH_COMPILERS represents the test targets we have cross compiler
>> -# support for, CONFIGURED_TCG_TARGETS it what meson has finally
>> -# configured having rejected stuff we can't build.
>> -CONFIGURED_TCG_TARGETS=$(patsubst %-config-target.h, %, $(wildcard *-config-target.h))
>> -
>> -# This is the intersection of what tests we can build and is configured
>> -TCG_TESTS_TARGETS=$(filter $(CONFIGURED_TCG_TARGETS), $(TCG_TESTS_WITH_COMPILERS))
>> -
>> -# Per guest TCG tests
>> -BUILD_TCG_TARGET_RULES=$(patsubst %,build-tcg-tests-%, $(TCG_TESTS_TARGETS))
>> -CLEAN_TCG_TARGET_RULES=$(patsubst %,clean-tcg-tests-%, $(TCG_TESTS_TARGETS))
>> -DISTCLEAN_TCG_TARGET_RULES=$(patsubst %,distclean-tcg-tests-%, $(TCG_TESTS_TARGETS))
>> -RUN_TCG_TARGET_RULES=$(patsubst %,run-tcg-tests-%, $(TCG_TESTS_TARGETS))
>> -
>> -$(foreach TARGET,$(TCG_TESTS_TARGETS), \
>> -        $(eval $(BUILD_DIR)/tests/tcg/config-$(TARGET).mak: config-host.mak))
>> -
>> -# $1 = the stem (e.g., arm-softmmu or x86_64-linux-user)
>> -get-qemu-bin = $(if $(findstring softmmu,$1),qemu-system-$(subst -softmmu,,$1),qemu-$(subst -linux-user,,$1))
>> -
>> -$(foreach TARGET,$(TCG_TESTS_TARGETS), \
>> -        $(eval .ninja-goals.run-tcg-tests-$(TARGET) += $(call get-qemu-bin,$(TARGET))))
>> -
>> -.PHONY: $(TCG_TESTS_TARGETS:%=build-tcg-tests-%)
>> -$(TCG_TESTS_TARGETS:%=build-tcg-tests-%): build-tcg-tests-%: $(BUILD_DIR)/tests/tcg/config-%.mak
>> -	$(call quiet-command, \
>> -            $(MAKE) -C tests/tcg/$* $(SUBDIR_MAKEFLAGS), \
>> -        "BUILD","$* guest-tests")
>> -
>> -.PHONY: $(TCG_TESTS_TARGETS:%=run-tcg-tests-%)
>> -$(TCG_TESTS_TARGETS:%=run-tcg-tests-%): run-tcg-tests-%: build-tcg-tests-%
>> -	$(call quiet-command, \
>> -           $(MAKE) -C tests/tcg/$* $(SUBDIR_MAKEFLAGS) SPEED=$(SPEED) TCG_TEST_FILTER=$(TCG_TEST_FILTER) run, \
>> -        "RUN", "$* guest-tests")
>> -
>> -.PHONY: $(TCG_TESTS_TARGETS:%=clean-tcg-tests-%)
>> -$(TCG_TESTS_TARGETS:%=clean-tcg-tests-%): clean-tcg-tests-%:
>> -	$(call quiet-command, \
>> -           $(MAKE) -C tests/tcg/$* $(SUBDIR_MAKEFLAGS) clean, \
>> -        "CLEAN", "$* guest-tests")
>> -
>> -.PHONY: $(TCG_TESTS_TARGETS:%=distclean-tcg-tests-%)
>> -$(TCG_TESTS_TARGETS:%=distclean-tcg-tests-%): distclean-tcg-tests-%:
>> -	$(call quiet-command, \
>> -           $(MAKE) -C tests/tcg/$* $(SUBDIR_MAKEFLAGS) distclean, \
>> -        "CLEAN", "$* guest-tests")
>> -
>> -.PHONY: build-tcg
>> -build-tcg: $(BUILD_TCG_TARGET_RULES)
>> -
>> -.PHONY: check-tcg
>> -.ninja-goals.check-tcg = all test-plugins
>> -check-tcg: $(RUN_TCG_TARGET_RULES)
>> -
>> -.PHONY: clean-tcg
>> -clean-tcg: $(CLEAN_TCG_TARGET_RULES)
> 
> We still need a clean-tcg or similar rule to force a rebuild of the
> tests without killing the whole build dir.
>

It was needed before, since we only had partial dependencies.
But now considering that all dependencies are correctly tracked, what's
the use case?
- If a test is mtime modified, it rebuilds the test.
- If a dockerfile is mtime modified, associated tests are rebuilt.
- If docker.py is modified, it will rebuild tests transitively.
- If cflags are modified, test will be rebuilt also.
- All input of a test (.h, .c, ...) are all tracked.
- If user installs a cross compiler or remove podman/docker, next meson
configuration will identify this and rebuild all associated tests.

In case you find a missing dep, we just need to add it in meson. clean
is not needed anymore.

>> -
>> -.PHONY: distclean-tcg
>> -distclean-tcg: $(DISTCLEAN_TCG_TARGET_RULES)
>> -
>>  # Build up our target list from the filtered list of ninja targets
>>  TARGETS=$(patsubst libqemu-%.a, %, $(filter libqemu-%.a, $(ninja-targets)))
>>  
>> @@ -128,7 +65,6 @@ check-build: run-ninja
>>  check-clean:
>>  	rm -rf $(BUILD_DIR)/tests/functional
>>  
>> -clean: check-clean clean-tcg
>> -distclean: distclean-tcg
>> +clean: check-clean
>>  
>>  endif
> 


