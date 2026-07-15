Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4983C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jul 2026 17:36:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wk3X1-0004rI-Fk; Wed, 15 Jul 2026 13:36:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wk3X0-0004qt-2u
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 13:36:26 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wk3Wy-0003N4-92
 for qemu-devel@nongnu.org; Wed, 15 Jul 2026 13:36:25 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-47f3e6cc44aso3189205f8f.3
 for <qemu-devel@nongnu.org>; Wed, 15 Jul 2026 10:36:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1784136982; x=1784741782; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JekWEvXpHMqlYSqN9um6ByVrQS37S6Ci+FgNewpDVcM=;
 b=WqIFkBmHhDfOZmw32eV8L6uXrIXF6oTCPJsP8uMkoa2ykJ1umjoUDE67XKqhFGAMGO
 E7q5lQceC0J0bSigG9vdLv1DthE+Dq67ALJY9dhOtgLEO/epbUmL6x9H/XX5oRv0qbk2
 UvUU9vuIgo8aRHnbSfBugwJQGcFE1lCCeZry4q/3SwAytivNuzv42sWSHNXnCHUFLNOS
 Yd+9Ac2weZURV9edu/Lfh/HObSOEgrdnFYmrkUhDksWoT9pq1ikcKlCd8cFjUYmeToP3
 pvenqHFbx8BY33SFBD9ygW/+687ubI3M0l7XsI+AOqcL64OL/tJ/VK9N/441dk3e9Le2
 MItw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784136982; x=1784741782;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=JekWEvXpHMqlYSqN9um6ByVrQS37S6Ci+FgNewpDVcM=;
 b=bHOCq33z9Q8GdXHAjcoEPvWLThpK5IHqrXltj8wOb1K7RhkBN/HKdn+SsM0by3qU6j
 KYJcVIA+9iIfFuRqv09jK5nN2zVcBa528AAZysqV3KVXL2i2tucSTTrUFsvlvTSjv9f5
 nGBX+OIjbAs4m/BRHc9rwNaLwy8GEk81JIAEjRkBGL1PjDTP8rRF4zSy14CAhFF7l2oe
 opVYrihGux5seuLUmp01maO2mQd4asEvBjK/UQXPjNHmloGBrGq3wkre173dIFfSkyuN
 obGRn/i2GVm3J/hZBi/Lqsgmz9ulfJSb91qt02nIYen5u4/yvay63jenswHtzvSqrk87
 YIvQ==
X-Gm-Message-State: AOJu0Yx6ZQCF2kwIhPQrDtQJtfJGnoOL8zIsHpTTbqMjQlA+DVnEZjAc
 GHOceYeXkxBebHvYsdCrdJVonQ1r1sE7eZfCgwUIYnvf530O/OMbdb1kxlutVwMBR/E=
X-Gm-Gg: AfdE7clPUtS3LVBbCEYbDvh8uM0WiQO6M/nmLA/t4LoGO0cWpc+HLngClAibSiYHz84
 czCsSwChRUGoaKJl26NkmNInlXTNwTpL3U44l9Hg6wcA7R6zF7TSm2CyomiR1xmp2nTiE2cvx4K
 IjN3ZGoGp371rbcPPHS2lErWTdefWFU3RddOrDa9hp/awbRVDuCuz/A2AgCADbgL43IuilUxM6p
 LS0hneyucl8BHH7lf8QQnzEmGcQSvAqZ70dIWuH0NqpdmTgNaEbC3yFojnM5y8Mlo08gwhh/RtU
 Ne17xhK4dGkYCnPU9YH6ognMSfsSP6IsBl7XcMh9irPMtz2G8Gnb1Ayt6AoZdqFUNwYYv8oHU7k
 QGoKkcZl8lXtKjdjl4Mn91F3Fso8EylqJWQY2EvjDxdhVeBuvuo36Sg2vIMq+nu3tajgex5txqV
 UVxU3eSDk0bAce
X-Received: by 2002:a05:600d:84ca:20b0:493:c984:db9c with SMTP id
 5b1f17b1804b1-495389ce041mr59568585e9.2.1784136981826; 
 Wed, 15 Jul 2026 10:36:21 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4953b35105esm91753005e9.9.2026.07.15.10.36.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Jul 2026 10:36:20 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8C6C25F892;
 Wed, 15 Jul 2026 18:36:19 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Brian Cain <brian.cain@oss.qualcomm.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Philippe =?utf-8?Q?Mathieu-Daud?=
 =?utf-8?Q?=C3=A9?=
 <philmd@oss.qualcomm.com>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,  Ilya Leoshkevich <iii@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,  Gustavo Romero
 <gustavo.romero@linaro.org>,  Helge Deller <deller@gmx.de>
Subject: Re: [PATCH v5 95/98] tests: remove tcg tests machinery
In-Reply-To: <20260710214343.2065491-96-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Fri, 10 Jul 2026 14:43:39 -0700")
References: <20260710214343.2065491-1-pierrick.bouvier@oss.qualcomm.com>
 <20260710214343.2065491-96-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.3-pre1; emacs 30.1
Date: Wed, 15 Jul 2026 18:36:19 +0100
Message-ID: <87pl0ognos.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x431.google.com
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

> It's now built-in meson, which offers targets check-tcg and check-tcg-*.
>
> Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
> ---
>  tests/Makefile.include | 68 ++----------------------------------------
>  1 file changed, 2 insertions(+), 66 deletions(-)
>
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 494d0109f26..9f82552ab54 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -19,9 +19,7 @@ check-help:
>  ifneq ($(filter $(all-check-targets), check-softfloat),)
>  	@echo " $(MAKE) check-softfloat               Run FPU emulation tests"
>  	@echo " $(MAKE) check-tcg                     Run TCG tests"
> -	@echo " $(MAKE) run-tcg-tests-TARGET          Run TCG tests for a given=
 target"
> -	@echo
> -	@echo "The variable TCG_TEST_FILTER will select the subset of matching =
tests."
> +	@echo " $(MAKE) check-tcg-TARGET              Run TCG tests for a given=
 target"
>  endif
>  	@echo
>  	@echo " $(MAKE) check-report.junit.xml        Generates an aggregated X=
ML test report"
> @@ -40,67 +38,6 @@ export SRC_PATH
>=20=20
>  SPEED =3D quick
>=20=20
> -
> -# TCG_TESTS_WITH_COMPILERS represents the test targets we have cross com=
piler
> -# support for, CONFIGURED_TCG_TARGETS it what meson has finally
> -# configured having rejected stuff we can't build.
> -CONFIGURED_TCG_TARGETS=3D$(patsubst %-config-target.h, %, $(wildcard *-c=
onfig-target.h))
> -
> -# This is the intersection of what tests we can build and is configured
> -TCG_TESTS_TARGETS=3D$(filter $(CONFIGURED_TCG_TARGETS), $(TCG_TESTS_WITH=
_COMPILERS))
> -
> -# Per guest TCG tests
> -BUILD_TCG_TARGET_RULES=3D$(patsubst %,build-tcg-tests-%, $(TCG_TESTS_TAR=
GETS))
> -CLEAN_TCG_TARGET_RULES=3D$(patsubst %,clean-tcg-tests-%, $(TCG_TESTS_TAR=
GETS))
> -DISTCLEAN_TCG_TARGET_RULES=3D$(patsubst %,distclean-tcg-tests-%, $(TCG_T=
ESTS_TARGETS))
> -RUN_TCG_TARGET_RULES=3D$(patsubst %,run-tcg-tests-%, $(TCG_TESTS_TARGETS=
))
> -
> -$(foreach TARGET,$(TCG_TESTS_TARGETS), \
> -        $(eval $(BUILD_DIR)/tests/tcg/config-$(TARGET).mak: config-host.=
mak))
> -
> -# $1 =3D the stem (e.g., arm-softmmu or x86_64-linux-user)
> -get-qemu-bin =3D $(if $(findstring softmmu,$1),qemu-system-$(subst -soft=
mmu,,$1),qemu-$(subst -linux-user,,$1))
> -
> -$(foreach TARGET,$(TCG_TESTS_TARGETS), \
> -        $(eval .ninja-goals.run-tcg-tests-$(TARGET) +=3D $(call get-qemu=
-bin,$(TARGET))))
> -
> -.PHONY: $(TCG_TESTS_TARGETS:%=3Dbuild-tcg-tests-%)
> -$(TCG_TESTS_TARGETS:%=3Dbuild-tcg-tests-%): build-tcg-tests-%: $(BUILD_D=
IR)/tests/tcg/config-%.mak
> -	$(call quiet-command, \
> -            $(MAKE) -C tests/tcg/$* $(SUBDIR_MAKEFLAGS), \
> -        "BUILD","$* guest-tests")
> -
> -.PHONY: $(TCG_TESTS_TARGETS:%=3Drun-tcg-tests-%)
> -$(TCG_TESTS_TARGETS:%=3Drun-tcg-tests-%): run-tcg-tests-%: build-tcg-tes=
ts-%
> -	$(call quiet-command, \
> -           $(MAKE) -C tests/tcg/$* $(SUBDIR_MAKEFLAGS) SPEED=3D$(SPEED) =
TCG_TEST_FILTER=3D$(TCG_TEST_FILTER) run, \
> -        "RUN", "$* guest-tests")
> -
> -.PHONY: $(TCG_TESTS_TARGETS:%=3Dclean-tcg-tests-%)
> -$(TCG_TESTS_TARGETS:%=3Dclean-tcg-tests-%): clean-tcg-tests-%:
> -	$(call quiet-command, \
> -           $(MAKE) -C tests/tcg/$* $(SUBDIR_MAKEFLAGS) clean, \
> -        "CLEAN", "$* guest-tests")
> -
> -.PHONY: $(TCG_TESTS_TARGETS:%=3Ddistclean-tcg-tests-%)
> -$(TCG_TESTS_TARGETS:%=3Ddistclean-tcg-tests-%): distclean-tcg-tests-%:
> -	$(call quiet-command, \
> -           $(MAKE) -C tests/tcg/$* $(SUBDIR_MAKEFLAGS) distclean, \
> -        "CLEAN", "$* guest-tests")
> -
> -.PHONY: build-tcg
> -build-tcg: $(BUILD_TCG_TARGET_RULES)
> -
> -.PHONY: check-tcg
> -.ninja-goals.check-tcg =3D all test-plugins
> -check-tcg: $(RUN_TCG_TARGET_RULES)
> -
> -.PHONY: clean-tcg
> -clean-tcg: $(CLEAN_TCG_TARGET_RULES)

We still need a clean-tcg or similar rule to force a rebuild of the
tests without killing the whole build dir.

> -
> -.PHONY: distclean-tcg
> -distclean-tcg: $(DISTCLEAN_TCG_TARGET_RULES)
> -
>  # Build up our target list from the filtered list of ninja targets
>  TARGETS=3D$(patsubst libqemu-%.a, %, $(filter libqemu-%.a, $(ninja-targe=
ts)))
>=20=20
> @@ -128,7 +65,6 @@ check-build: run-ninja
>  check-clean:
>  	rm -rf $(BUILD_DIR)/tests/functional
>=20=20
> -clean: check-clean clean-tcg
> -distclean: distclean-tcg
> +clean: check-clean
>=20=20
>  endif

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

