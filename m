Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2379EE7719F
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jan 2025 12:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXJge-0006wh-K0; Mon, 13 Jan 2025 07:36:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tXJeC-000501-59
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 07:34:24 -0500
Received: from mail-yb1-xb2a.google.com ([2607:f8b0:4864:20::b2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tXJeA-0006k9-IZ
 for qemu-devel@nongnu.org; Mon, 13 Jan 2025 07:34:23 -0500
Received: by mail-yb1-xb2a.google.com with SMTP id
 3f1490d57ef6-e5447fae695so7212076276.2
 for <qemu-devel@nongnu.org>; Mon, 13 Jan 2025 04:34:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736771661; x=1737376461; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sWygGX54bUS6Xr9BP9hLEUCT7We4y0UtGm5Lh6nvwXA=;
 b=y/9jZn98u676DLJfS7KM6W9pVF0ySHJm6bniiqOyvsN6LhD7BNzy+mw8MpouPNg/6U
 zTyR/CasOD1u8Xi16RT/OJroomY+I7W57Sd9hhcPY3sLc43b1NoGfuHpNyDlfQbbE90W
 i383Q7sjMm/hpJjeDHR/TJKumTVbMLrE38a+XSckp06NuMbsfkaHHEJtx97ms1RkCSsO
 2GJCrG8YzwHNfv3OdhqV3bU+gPQMXnJEi1SHVQAhjfQvx2RrT3pA5x4jfcTf2F7bjOQ3
 l28YA/5XH5pyr9SyvpZ/9eyaT9mFSd+QIqtH3FeFYOGTLH1tI9OwpWtN6ouF4ipWp9sH
 +VbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736771661; x=1737376461;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sWygGX54bUS6Xr9BP9hLEUCT7We4y0UtGm5Lh6nvwXA=;
 b=LvaRFOg9Wj1TqBw2AezZdM5FrGGnlfR4QpFxpN512qNWj5/MTihIZ0JOXJNF5nz2i8
 E7gBomFMjk5epcWs9WeMdEV/K0Q6lt5NgmRzfyUcGkyGvLPyZDqHyu/yoCctVFCZlPv2
 Npz+45V1eFNdqRNSXwlr5ZZtqYq68jdcYW7GGN5eZ4RKKaa1QpyhRLN4GgUA3tdLO3Ek
 QEaLp+FabV7TIEjO1rxK7p32OxzIcqyuAB6KXJ9IS+yxDtZ3ESR36AsSmwFnIg9pA8gc
 fCaVyg2BmuPOS2A2SPoiGchzTpQHrFPBLBkiHDdGO5f0xhSvLnkT/a8oiILfe8gQAOOi
 8YqQ==
X-Gm-Message-State: AOJu0Yy7KkkhaANpTqeNQ5wgf2oKZ/Zw/UgpHYABHa3Vf+NT/kM8nOvj
 ByD2GTy3keu8SqX3pt+7FCGAtEaRpCOXM6D+L6stjXsjUkG8j/0fehrwYpluRCywt986xmYwiW1
 umiu0ZtdNOYFUatCCe7Pz7YG4wkcxn+FxS+wGMw==
X-Gm-Gg: ASbGncsjXg7k8abWzNFigt3FJEmjramrCxWFxGvurI2rNe92jIkBIKA0LyIqdHuISlt
 8DZ7JjMDcDFgFm72zUmunZTTCmPgdq5yxHcZF/qc=
X-Google-Smtp-Source: AGHT+IFrKpYd5kb50Opt5hUL7c74+3nb/MFsBxR0JS61r8IH5jEbPuDeh/NkZ4GebwSaz5zhAQVT+AVBi0SuosgyV6w=
X-Received: by 2002:a05:690c:6b85:b0:6f0:237e:fc4c with SMTP id
 00721157ae682-6f531216d81mr154664387b3.12.1736771661080; Mon, 13 Jan 2025
 04:34:21 -0800 (PST)
MIME-Version: 1.0
References: <20241219183211.3493974-1-pierrick.bouvier@linaro.org>
 <CAFEAcA_ChARwKyvRXsEk1U3q1T2528753Eu7LgDSsDbF1s5tNQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_ChARwKyvRXsEk1U3q1T2528753Eu7LgDSsDbF1s5tNQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jan 2025 12:34:09 +0000
X-Gm-Features: AbW1kvagXbO9F7jszKQ8n4Mp2TUE4_UDJZM71lyOoAUghuZkBzmh7LOOclHyXc0
Message-ID: <CAFEAcA_SHz2a0ZU=3e9AmZyJ_qn3e7nNhNm-hR9MdiTRjOyqWg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Change default pointer authentication algorithm on
 aarch64 to impdef
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, 
 Fabiano Rosas <farosas@suse.de>, Yanan Wang <wangyanan55@huawei.com>,
 Zhao Liu <zhao1.liu@intel.com>, 
 qemu-arm@nongnu.org, Laurent Vivier <lvivier@redhat.com>,
 alex.bennee@linaro.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, 10 Jan 2025 at 16:28, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 19 Dec 2024 at 18:32, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
> >
> > qemu-system-aarch64 default pointer authentication (QARMA5) is expensive, we
> > spent up to 50% of the emulation time running it (when using TCG).
> >
> > Switching to pauth-impdef=on is often given as a solution to speed up execution.
> > Thus we talked about making it the new default.
> >
> > The first patch introduce a new property (pauth-qarma5) to allow to select
> > current default algorithm.
> > The second one change the default.
> > The third one updates documentation.
> >
> > v2:
> > - ensure we don't break migration compatibility, by using a specific backward
> >   compatible property.
> > - added some documentation about migration for arm virt machine model.
>
> Other than a minor change to the 3rd docs patch which I'll note there:
> applied to target-arm.next, thanks.

I just noticed that this series breaks 'make check-tcg', because
the pauth-3 test is explicitly checking the output of the
pointer-auth operation. I'm going to add in this patch, which
goes between patches 1 and 2 of this series:

Author: Peter Maydell <peter.maydell@linaro.org>
Date:   Mon Jan 13 11:42:57 2025 +0000

    tests/tcg/aarch64: force qarma5 for pauth-3 test

    The pauth-3 test explicitly tests that a computation of the
    pointer-authentication produces the expected result.  This means that
    it must be run with the QARMA5 algorithm.

    Explicitly set the pauth algorithm when running this test, so that it
    doesn't break when we change the default algorithm the 'max' CPU
    uses.

    Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

diff --git a/tests/tcg/aarch64/Makefile.softmmu-target
b/tests/tcg/aarch64/Makefile.softmmu-target
index d08d9b01ded..9c52475b7ae 100644
--- a/tests/tcg/aarch64/Makefile.softmmu-target
+++ b/tests/tcg/aarch64/Makefile.softmmu-target
@@ -91,6 +91,9 @@ EXTRA_RUNS+=run-memory-replay

 ifneq ($(CROSS_CC_HAS_ARMV8_3),)
 pauth-3: CFLAGS += $(CROSS_CC_HAS_ARMV8_3)
+# This test explicitly checks the output of the pauth operation so we
+# must force the use of the QARMA5 algorithm for it.
+run-pauth-3: QEMU_BASE_MACHINE=-M virt -cpu max,pauth-qarma5=on -display none
 else
 pauth-3:
        $(call skip-test, "BUILD of $@", "missing compiler support")


thanks
-- PMM

