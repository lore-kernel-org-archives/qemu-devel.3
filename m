Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABEF1C4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 09:33:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkIS2-0007un-Gk; Thu, 16 Jul 2026 05:32:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wkIS1-0007uZ-4r
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 05:32:17 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wkIRz-0007ih-33
 for qemu-devel@nongnu.org; Thu, 16 Jul 2026 05:32:16 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-476a130c138so2975458f8f.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jul 2026 02:32:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784194332; x=1784799132; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=sC430UQSLXNDCblP7YEOFz54D93brO7i9OUVdoX0+bo=;
 b=Aq0rJCCeCo4BvUk6l0FNvamCTZQyTrOl8FOD+J7EpGFouQelnvmwhEiYw0DqwGkuq5
 bELjDSLESRTZ2jXSRFbXFQKlVm7+/ww+Hvurvls2BCR3NQjZ8C32qOBfLbLh4+9fPXt3
 qaOaiVcKtfy39UQqtlyb7VjVbPOi2TftmmsV2HaFWrOmNXCdXrmAjh9jtRl0zYVDHC5p
 no6cLBT6WXyxgDYK8DB+3UBEgBr2mT5ceCZ8+9eJbm3fRPRZNURas8sW+W+OCT3drP9B
 tsNlcrAAegHPo+VPGvlPp8zYtJ72gRjHYmouKGMmHtaXkSCRDRQY3t83Xm5WVXBwKje/
 imWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784194332; x=1784799132;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=sC430UQSLXNDCblP7YEOFz54D93brO7i9OUVdoX0+bo=;
 b=Ad3scjVgkt9Yo4QZ9QvY6SVZ59BkYUjnwaJ9QgpWNfhZo7CazGXj+SvArkMT4y6pxY
 yOgs9Ajumf+Wcl+EfbsJeV12WGans6aspvHXxLADyOg90LhHm/oz59dmm16PejEbu6K9
 9DqK7mBaIMvnnve23cF4dWiDuY723X2PPvciz7xtdDQgfE0d1SVok87PWdSwEas10ykT
 5bQpjDQ2auztIYKStFW0JRFZni8KBhxSl7DM3cbtD0IQyFggV+WSh0dhqHvGq58yAnEB
 hBGkzgOKY+120vvVy1/guhP/sZWCJllqEjkSIFtqw00DC0o9sNnW3DFvqWWPNw1eLNy7
 hfkA==
X-Gm-Message-State: AOJu0YyxXVOmR2iuXQ4SLFQWKgSN+7sv7he2E19eFvzQky+E25ogE7XC
 gsPxNcQNGoQfClrroKzSNlOUzulNyxAGrCX7j/W11Z6dgYWzQNsHLBT4FLSXW72gA6o=
X-Gm-Gg: AfdE7cnYmb9Yd2STs/BS/Pj33PS3Mugydvxf0y6DNoQ9bJhrWk/eM82WLBTk1eeuwWM
 Q3scoNGGTZVrDjpi1SOFwIE3tiOM5xPTjMueikRJmx3S8tZfBcKyecL0Q63++tV33AaaZyKXPar
 dhncRy1z7Tigm7jYctlMOah5upeggTVpXspeagFpy2Y6OMlutyKc3i67d8+PX0T1s584t6hb8NP
 wDVLi+M1ILxSuF9xRKcZBrr5uqeyueXonjvU9Ujdf5Jh5IKJORe/bObSMnN8d5pHjq2MHKDEjz3
 wwvF9RpExrLHZmYsS3VaLo2sYuKbZmYO54YezaxKdMZ99BG22pnaoKBI7pPE/d878K2vLrKDEx9
 NxgwBiKWNu3OOBbxGV6ZO/sHRcswDXPciuXRldMAR32Vdc+KYz60yZPgFxLY8mIMFPprFOyaNbx
 qmLQ==
X-Received: by 2002:a5d:5f02:0:b0:47d:fc20:f6f9 with SMTP id
 ffacd0b85a97d-47f2dd2f413mr23221431f8f.45.1784194332368; 
 Thu, 16 Jul 2026 02:32:12 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f464d6fa7sm23532637f8f.37.2026.07.16.02.32.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jul 2026 02:32:11 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8D8F85F8E7;
 Thu, 16 Jul 2026 10:32:10 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Brian Cain <brian.cain@oss.qualcomm.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@oss.qualcomm.com>,  Daniel =?utf-8?Q?P=2EBerrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v5 95/98] tests: remove tcg tests machinery
In-Reply-To: <a7b40c16-fd9b-4d81-b767-19fd3523c533@oss.qualcomm.com> (Pierrick
 Bouvier's message of "Wed, 15 Jul 2026 10:42:45 -0700")
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710214343.2065491-96-pierrick.bouvier@oss.qualcomm.com>
 <87pl0ognos.fsf@draig.linaro.org>
 <a7b40c16-fd9b-4d81-b767-19fd3523c533@oss.qualcomm.com>
User-Agent: mu4e 1.14.3-pre1; emacs 30.1
Date: Thu, 16 Jul 2026 10:32:10 +0100
Message-ID: <87jyqvgu05.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> On 7/15/2026 10:36 AM, Alex Benn=C3=A9e wrote:
>> Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:
>>=20
>>> It's now built-in meson, which offers targets check-tcg and check-tcg-*.
>>>
>>> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
>>> ---
>>>  tests/Makefile.include | 68 ++----------------------------------------
>>>  1 file changed, 2 insertions(+), 66 deletions(-)
>>>
>>> diff --git a/tests/Makefile.include b/tests/Makefile.include
>>> index 494d0109f26..9f82552ab54 100644
>>> --- a/tests/Makefile.include
>>> +++ b/tests/Makefile.include
>>> @@ -19,9 +19,7 @@ check-help:
>>>  ifneq ($(filter $(all-check-targets), check-softfloat),)
>>>  	@echo " $(MAKE) check-softfloat               Run FPU emulation tests"
>>>  	@echo " $(MAKE) check-tcg                     Run TCG tests"
>>> -	@echo " $(MAKE) run-tcg-tests-TARGET          Run TCG tests for a giv=
en target"
>>> -	@echo
>>> -	@echo "The variable TCG_TEST_FILTER will select the subset of matchin=
g tests."
>>> +	@echo " $(MAKE) check-tcg-TARGET              Run TCG tests for a giv=
en target"
>>>  endif
>>>  	@echo
>>>  	@echo " $(MAKE) check-report.junit.xml        Generates an aggregated=
 XML test report"
>>> @@ -40,67 +38,6 @@ export SRC_PATH
>>>=20=20
>>>  SPEED =3D quick
>>>=20=20
>>> -
>>> -# TCG_TESTS_WITH_COMPILERS represents the test targets we have cross c=
ompiler
>>> -# support for, CONFIGURED_TCG_TARGETS it what meson has finally
>>> -# configured having rejected stuff we can't build.
>>> -CONFIGURED_TCG_TARGETS=3D$(patsubst %-config-target.h, %, $(wildcard *=
-config-target.h))
>>> -
>>> -# This is the intersection of what tests we can build and is configured
>>> -TCG_TESTS_TARGETS=3D$(filter $(CONFIGURED_TCG_TARGETS), $(TCG_TESTS_WI=
TH_COMPILERS))
>>> -
>>> -# Per guest TCG tests
>>> -BUILD_TCG_TARGET_RULES=3D$(patsubst %,build-tcg-tests-%, $(TCG_TESTS_T=
ARGETS))
>>> -CLEAN_TCG_TARGET_RULES=3D$(patsubst %,clean-tcg-tests-%, $(TCG_TESTS_T=
ARGETS))
>>> -DISTCLEAN_TCG_TARGET_RULES=3D$(patsubst %,distclean-tcg-tests-%, $(TCG=
_TESTS_TARGETS))
>>> -RUN_TCG_TARGET_RULES=3D$(patsubst %,run-tcg-tests-%, $(TCG_TESTS_TARGE=
TS))
>>> -
>>> -$(foreach TARGET,$(TCG_TESTS_TARGETS), \
>>> -        $(eval $(BUILD_DIR)/tests/tcg/config-$(TARGET).mak: config-hos=
t.mak))
>>> -
>>> -# $1 =3D the stem (e.g., arm-softmmu or x86_64-linux-user)
>>> -get-qemu-bin =3D $(if $(findstring softmmu,$1),qemu-system-$(subst -so=
ftmmu,,$1),qemu-$(subst -linux-user,,$1))
>>> -
>>> -$(foreach TARGET,$(TCG_TESTS_TARGETS), \
>>> -        $(eval .ninja-goals.run-tcg-tests-$(TARGET) +=3D $(call get-qe=
mu-bin,$(TARGET))))
>>> -
>>> -.PHONY: $(TCG_TESTS_TARGETS:%=3Dbuild-tcg-tests-%)
>>> -$(TCG_TESTS_TARGETS:%=3Dbuild-tcg-tests-%): build-tcg-tests-%: $(BUILD=
_DIR)/tests/tcg/config-%.mak
>>> -	$(call quiet-command, \
>>> -            $(MAKE) -C tests/tcg/$* $(SUBDIR_MAKEFLAGS), \
>>> -        "BUILD","$* guest-tests")
>>> -
>>> -.PHONY: $(TCG_TESTS_TARGETS:%=3Drun-tcg-tests-%)
>>> -$(TCG_TESTS_TARGETS:%=3Drun-tcg-tests-%): run-tcg-tests-%: build-tcg-t=
ests-%
>>> -	$(call quiet-command, \
>>> -           $(MAKE) -C tests/tcg/$* $(SUBDIR_MAKEFLAGS) SPEED=3D$(SPEED=
) TCG_TEST_FILTER=3D$(TCG_TEST_FILTER) run, \
>>> -        "RUN", "$* guest-tests")
>>> -
>>> -.PHONY: $(TCG_TESTS_TARGETS:%=3Dclean-tcg-tests-%)
>>> -$(TCG_TESTS_TARGETS:%=3Dclean-tcg-tests-%): clean-tcg-tests-%:
>>> -	$(call quiet-command, \
>>> -           $(MAKE) -C tests/tcg/$* $(SUBDIR_MAKEFLAGS) clean, \
>>> -        "CLEAN", "$* guest-tests")
>>> -
>>> -.PHONY: $(TCG_TESTS_TARGETS:%=3Ddistclean-tcg-tests-%)
>>> -$(TCG_TESTS_TARGETS:%=3Ddistclean-tcg-tests-%): distclean-tcg-tests-%:
>>> -	$(call quiet-command, \
>>> -           $(MAKE) -C tests/tcg/$* $(SUBDIR_MAKEFLAGS) distclean, \
>>> -        "CLEAN", "$* guest-tests")
>>> -
>>> -.PHONY: build-tcg
>>> -build-tcg: $(BUILD_TCG_TARGET_RULES)
>>> -
>>> -.PHONY: check-tcg
>>> -.ninja-goals.check-tcg =3D all test-plugins
>>> -check-tcg: $(RUN_TCG_TARGET_RULES)
>>> -
>>> -.PHONY: clean-tcg
>>> -clean-tcg: $(CLEAN_TCG_TARGET_RULES)
>>=20
>> We still need a clean-tcg or similar rule to force a rebuild of the
>> tests without killing the whole build dir.
>>
>
> It was needed before, since we only had partial dependencies.
> But now considering that all dependencies are correctly tracked, what's
> the use case?
> - If a test is mtime modified, it rebuilds the test.
> - If a dockerfile is mtime modified, associated tests are rebuilt.
> - If docker.py is modified, it will rebuild tests transitively.
> - If cflags are modified, test will be rebuilt also.
> - All input of a test (.h, .c, ...) are all tracked.
> - If user installs a cross compiler or remove podman/docker, next meson
> configuration will identify this and rebuild all associated tests.
>
> In case you find a missing dep, we just need to add it in meson. clean
> is not needed anymore.

OK I was testing the changing of the cross compiler and I noticed its
not reported in the config summary if we have the fallback to
podman/docker.

I suspect the logic here:

  # snarf the cross-compilation information for tests
  summary_info =3D {}
  have_cross =3D false
  foreach target: target_dirs
    tcg_mak =3D meson.current_build_dir() / 'tests/tcg' / target / 'config-=
target.mak'
    if fs.exists(tcg_mak)
      config_cross_tcg =3D keyval.load(tcg_mak)
      if 'CC' in config_cross_tcg
        summary_info +=3D {config_cross_tcg['TARGET_NAME']: config_cross_tc=
g['CC']}
        have_cross =3D true
      endif
    endif
  endforeach
  if have_cross
    summary(summary_info, bool_yn: true, section: 'Cross compilers')
  endif

needs to be cleaned up.

>
>>> -
>>> -.PHONY: distclean-tcg
>>> -distclean-tcg: $(DISTCLEAN_TCG_TARGET_RULES)
>>> -
>>>  # Build up our target list from the filtered list of ninja targets
>>>  TARGETS=3D$(patsubst libqemu-%.a, %, $(filter libqemu-%.a, $(ninja-tar=
gets)))
>>>=20=20
>>> @@ -128,7 +65,6 @@ check-build: run-ninja
>>>  check-clean:
>>>  	rm -rf $(BUILD_DIR)/tests/functional
>>>=20=20
>>> -clean: check-clean clean-tcg
>>> -distclean: distclean-tcg
>>> +clean: check-clean

I wonder if check-clean is redundant as well now if the functional test
dependencies are properly encoded.

>>>=20=20
>>>  endif
>>=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

