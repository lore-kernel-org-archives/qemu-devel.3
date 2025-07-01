Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A018C8303C
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Jul 2025 16:22:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uWdkI-0000Uh-Kl; Tue, 01 Jul 2025 12:22:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWdkH-0000UZ-Js
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 12:22:09 -0400
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uWdkF-0005Cx-HB
 for qemu-devel@nongnu.org; Tue, 01 Jul 2025 12:22:09 -0400
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e81ec95d944so6056172276.1
 for <qemu-devel@nongnu.org>; Tue, 01 Jul 2025 09:22:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751386925; x=1751991725; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8ExA9I6n9mEFV/h0Xvk4Dw216G4bffe2efKYjgHrqHg=;
 b=L04P40Ptks91JGE9i6GuKROQaqnN2RLv2NQQtKRtAV9jW1MRPb8nNwVqwFBDpETkq4
 VHDKGp1or1+g1eNbhmoUk+PNZrUUnwsnoaZrplplADVIDdHRFpOSNkb+q7T+J5t6RcTb
 XSJ2uPQsoXVdqdoLakh3yhz9ZAl6Ddb7wzpGZPV4IAVBmXksPBpuhY7+Fvc/OELCnm5v
 BsKMCqQgFUOHqbMu9G9Ars9WtKyL4aY5+wlpOYxa1NSlPRRvSl3HbRejPCG8qG/xi7bi
 7LAOGaxMTkGnKzfATB6luZjA4jSeNQ8bKMJLNiHQUAYzXh/EgMGpAy3eRMu+ADBIgms0
 H/ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751386925; x=1751991725;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8ExA9I6n9mEFV/h0Xvk4Dw216G4bffe2efKYjgHrqHg=;
 b=Pzf4FOKlJCl9bB1ocXTN+HvLEW816LLc/Xa4XKauBsgy2xkJtnVHTCgDDXq17QLtmh
 eUETjwCoAawW3UZyn6efvrb7qmzmRoZ09gme04XF/YIwzLm79QJyGbBa7N+e9tMUSKXQ
 f7YSlqEiUCNOSFVFy1BA+U71HWmeaeWFezHoCg+7kKFodWRj3oFqjH3ao8RWAT9ulU43
 j6Ck2jpbcDQfIAfEKDIhK88J5XCnjrKVp38sjCzPS+dG/awVZbdTuWqgKwk5Ib1v9+c+
 dKrFSVSPIWcvH6J3JF4YqT5CwOfGHhThuEk5+llc/DlUdaGcGK0Pffc05hSy+BNqyDdk
 ktzg==
X-Gm-Message-State: AOJu0Ywdp77lKiIG/IfZS+yj/4BSycN11zGZh4gp6Is/oOwsP47MX7Re
 VSfdJ/rsSrUtEWBci7ISQCHE3otkpQB6JcIpYDWotk+q8oq5CEWJ16sDfFosH4V2WP3iBmK1XJs
 Wq1wbM8P/Eyex9z9nhq5lJjmlYTD7PHTxAee1xf2K6A==
X-Gm-Gg: ASbGnctiMoy01kgnORKBNXBJ1u88VoZNuIhqmVuhFqWe5vJZ135yWe/8IEhAUqc9kMm
 Wvdbrik1UNddFTgPEHcMNQcyhMWJ5EUEX20B7b6RZNBvLUQFKTWw1w8jxirgAHax10oqmCt5iyl
 Df9Kt0UHsk5AUYXW+S2n5ecFGbEy4r4gxMF6aygwxBXn85
X-Google-Smtp-Source: AGHT+IGIclKVjViD0WW3iV4YwGI3dhj48xyfWmiyY3aBzOAs9kfGDc0yU1Ej0pH1/RrI6013XX48ffAzkmY9zk2fHf0=
X-Received: by 2002:a05:690c:700e:b0:70f:8830:809c with SMTP id
 00721157ae682-7163ee96597mr60163237b3.12.1751386924710; Tue, 01 Jul 2025
 09:22:04 -0700 (PDT)
MIME-Version: 1.0
References: <20250623121845.7214-1-philmd@linaro.org>
 <20250623121845.7214-26-philmd@linaro.org>
 <CAFEAcA9MLMJBFk+PQCJT8Bd+6R+vaho9_vXmDCjPU5cp6B7LfQ@mail.gmail.com>
In-Reply-To: <CAFEAcA9MLMJBFk+PQCJT8Bd+6R+vaho9_vXmDCjPU5cp6B7LfQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 1 Jul 2025 17:21:53 +0100
X-Gm-Features: Ac12FXzEimJKLq31uljceBjRMKAA4MUmsh56mOzsO1SwCyld8EJ-MmtJd7PAg0s
Message-ID: <CAFEAcA_=Jo5aDsKHjNwz7DNAqoS7iGDudSEvbjYVhcEZ9P+keQ@mail.gmail.com>
Subject: Re: [PATCH v3 25/26] tests/functional: Add hvf_available() helper
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Leif Lindholm <leif.lindholm@oss.qualcomm.com>, 
 qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Alexander Graf <agraf@csgraf.de>, Bernhard Beschow <shentey@gmail.com>,
 John Snow <jsnow@redhat.com>, Thomas Huth <thuth@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 kvm@vger.kernel.org, Eric Auger <eric.auger@redhat.com>, 
 Cameron Esfahani <dirty@apple.com>, Cleber Rosa <crosa@redhat.com>, 
 Radoslaw Biernacki <rad@semihalf.com>, Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb29.google.com
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

On Tue, 1 Jul 2025 at 16:50, Peter Maydell <peter.maydell@linaro.org> wrote=
:
>
> On Mon, 23 Jun 2025 at 13:20, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.=
org> wrote:
> >
> > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > ---
> >  python/qemu/utils/__init__.py          | 2 +-
> >  python/qemu/utils/accel.py             | 8 ++++++++
> >  tests/functional/qemu_test/testcase.py | 6 ++++--
> >  3 files changed, 13 insertions(+), 3 deletions(-)
>
> This seems to trigger errors in the check-python-minreqs job:
> https://gitlab.com/pm215/qemu/-/jobs/10529051338
>
> Log file "stdout" content for test "01-tests/flake8.sh" (FAIL):
> qemu/utils/__init__.py:26:1: F401 '.accel.hvf_available' imported but unu=
sed
> qemu/utils/accel.py:86:1: E302 expected 2 blank lines, found 1
> Log file "stderr" content for test "01-tests/flake8.sh" (FAIL):
> Log file "stdout" content for test "04-tests/isort.sh" (FAIL):
> ERROR: /builds/pm215/qemu/python/qemu/utils/__init__.py Imports are
> incorrectly sorted and/or formatted.
>
> I'll see if I can fix this up locally. (The missing blank line
> is easy; I think probably hvf_available needs to be in the
> __all__ =3D () list in __init__.py like kvm_available and
> tcg_available. Not sure about the incorrectly-sorted warning.)

Squashing this in fixed things. I guess that going from three
imports to four makes the linter want you to list them one
per line...

diff --git a/python/qemu/utils/__init__.py b/python/qemu/utils/__init__.py
index d2fe5db223c..be5daa83634 100644
--- a/python/qemu/utils/__init__.py
+++ b/python/qemu/utils/__init__.py
@@ -23,13 +23,19 @@
 from typing import Optional

 # pylint: disable=3Dimport-error
-from .accel import hvf_available, kvm_available, list_accel, tcg_available
+from .accel import (
+    hvf_available,
+    kvm_available,
+    list_accel,
+    tcg_available,
+)


 __all__ =3D (
     'VerboseProcessError',
     'add_visual_margin',
     'get_info_usernet_hostfwd_port',
+    'hvf_available',
     'kvm_available',
     'list_accel',
     'tcg_available',
diff --git a/python/qemu/utils/accel.py b/python/qemu/utils/accel.py
index 376d1e30005..f915b646692 100644
--- a/python/qemu/utils/accel.py
+++ b/python/qemu/utils/accel.py
@@ -83,6 +83,7 @@ def tcg_available(qemu_bin: str) -> bool:
     """
     return 'tcg' in list_accel(qemu_bin)

+
 def hvf_available(qemu_bin: str) -> bool:
     """
     Check if HVF is available.


-- PMM

