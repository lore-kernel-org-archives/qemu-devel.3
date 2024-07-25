Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB6C3C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jul 2024 14:24:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWzNQ-0002r0-KO; Thu, 25 Jul 2024 10:23:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sWzNO-0002qS-Na
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 10:23:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1sWzNL-0000oU-N1
 for qemu-devel@nongnu.org; Thu, 25 Jul 2024 10:23:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721917402;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UjkH55pUAqJ3BIpsEuBD/w0IaUj3TAvuda9Tz/kMjiw=;
 b=Wt1RdJRD5+9pAJTnw1xHNrWmSqoKwPDi3uqMc5Yy6fmiqayL/zlFwR2+bl7fyFD2S7g6xT
 MnhyezYAL/EAmdO4N5D9mxWvgHb1m972a/LE0nl+uWNb6wLs6GpS83/2hThHd2ocpg3Wtj
 E4fBvplH8Snuv7ozGLmRg+l2ul5acEM=
Received: from mail-yw1-f199.google.com (mail-yw1-f199.google.com
 [209.85.128.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-435-PahcZxnENIO_CIxZ2Wk-iw-1; Thu, 25 Jul 2024 10:22:11 -0400
X-MC-Unique: PahcZxnENIO_CIxZ2Wk-iw-1
Received: by mail-yw1-f199.google.com with SMTP id
 00721157ae682-665a6dd38c8so31234867b3.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jul 2024 07:22:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721917329; x=1722522129;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UjkH55pUAqJ3BIpsEuBD/w0IaUj3TAvuda9Tz/kMjiw=;
 b=eVc5UJ/02C+ppmvp3bEtCl6v2NP3sHk2Z7o4f1/nNw+71qoERmBCH+XJ2hOTbHlV4H
 fQ1+pUN7Smx5szXnglsLyyBV6QUxSa1K0jX205zSr1Car7H1RQakVS4hR8L/A3BHZ0Fe
 PdzNmXQqjGdprQ3n1Z9t/V6qHl1fBDLv0XlqlKSYMiOT09rdN4Zmo5bahA2jRz7lBcgE
 cM1Ejic+DTX9ViI4dHxbKu5jzyGC5j+SZ9bh8M4blJN+xkKMcR/jS1mR1z6WJ9/T0Yid
 o03UEcrU5KCrbsmpJipoqEC/QWvejTLXGbEtRivcVEfJvAvU07y9xPN29XfQy/EkTQ1c
 qYpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUupYDwhT+nC/jdytnnSBBhhzRVNpTqxBsDjy21TnVx7IR257elNqUpLB5kwZCjRxTayvPJ1GZimE8TAmaG9E5yhD704ZE=
X-Gm-Message-State: AOJu0YzBtLrIWnoie5XFw+zGDeUF9OJPjkeHRikMzAqOLd81TsMh2Srh
 fm7yMeoMQjtmxZUwwk3HnCOI4UkW0APF7z4NSY595HyySGc19HoStlz2xaL5f7kLSV7wa/3t7To
 k34h6CLmo1SKXhkUkEq8heFX5/6IahQjKYNhMLWKcDj3oI7TWStvOhXKCag+VeNYXEGS96O7or+
 aBUiZ+A+YEuSnk4hPw2VUv0DQ87R4=
X-Received: by 2002:a0d:fc81:0:b0:65f:93c1:feea with SMTP id
 00721157ae682-675109209edmr28370777b3.1.1721917328663; 
 Thu, 25 Jul 2024 07:22:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGiFycFWURGNWhULXjyRfG2vnEYSG0uAuWlktqUGtOi5Nz74hdip6d5agcEndw/Fi+IEEDApka4IzULl7T7rWU=
X-Received: by 2002:a0d:fc81:0:b0:65f:93c1:feea with SMTP id
 00721157ae682-675109209edmr28370547b3.1.1721917328277; Thu, 25 Jul 2024
 07:22:08 -0700 (PDT)
MIME-Version: 1.0
References: <20240716112614.1755692-1-thuth@redhat.com>
In-Reply-To: <20240716112614.1755692-1-thuth@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 25 Jul 2024 10:21:54 -0400
Message-ID: <CA+bd_6LbLbR5hEqUhn5Vutf1k5HsB4Zg=qYF-Tq_pOrxDeWo1A@mail.gmail.com>
Subject: Re: [PATCH v1 00/11] Convert avocado tests to normal Python unittests
To: Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Ani Sinha <anisinha@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P . Berrange" <berrange@redhat.com>, John Snow <jsnow@redhat.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jul 16, 2024 at 7:28=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> The Avocado v88 that we use in QEMU is already on a life support
> system: It is not supported by upstream anymore, and with the latest
> versions of Python, it won't work anymore since it depends on the
> "imp" module that has been removed in Python 3.12.
>

Hi Thomas,

Let me start by saying that this is my attempt to explain the context
of the lack of updates on QEMU when it comes to the Avocado update,
and point to the actual updates.

> There have been several attempts to update the test suite in QEMU
> to a newer version of Avocado, but so far no attempt has successfully
> been merged yet.
>

So, we've seen in the past an attempt to update Avocado from 88.1 to a
regular release, and the troubles it caused, including a revert.  My
take was that a LTS version should be used, but during this time,
Avocado experienced a rewrite and having it replacing the old
implementation in a production level project such as QEMU was tricky.
Then 103.0 LTS was released, and there was extensive work to test the
QEMU tests before that release was cut.  Additionally, there was
further work, but unfortunately not posted yet, to make use of 103.0
features in the existing tests[2].   I've tested on GitLab with tests
running in parallel, cutting job times in 1/3[2].  A side node is
that, because 103.0 is an LTS release, it will receive the needed bug
fixes and updates that we deem necessary, including things we find in
QEMU tests.  In fact, 103.1[3] is in the works.

> Additionally, the whole "make check" test suite in QEMU is using the
> meson test runner nowadays, so running the python-based tests via the
> Avocodo test runner looks and feels quite like an oddball, requiring
> the users to deal with the knowledge of multiple test runners in
> parallel (e.g. the timeout settings work completely differently).
>

Now I believe we can be very much in sync here.  I've thought for a
while that there's no reason for Avocado to cooperate or be compatible
with Meson.  There's no reason why users can't simply pick how the
test gets run.  In fact, with the new Avocado architecture, you don't
even need to run "avocado" to run an "avocado-instrumented" test.  You
could pretty much run "avocado-runner-avocado-instrumented" with the
right parameters through Meson.

> So instead of trying to update the python-based test suite in QEMU
> to a newer version of Avocado, we should maybe try to better integrate
> it with the meson test runner instead. Indeed most tests work quite
> nicely without the Avocado framework already, as you can see with
> this patch series - it does not convert all tests, just a subset so
> far, but this already proves that many tests only need small modifi-
> cations to work without Avocado.
>
> Only tests that use the LinuxTest / LinuxDistro and LinuxSSHMixIn
> classes (e.g. based on cloud-init images or using SSH) really depend
> on the Avocado framework, so we'd need a solution for those if we
> want to continue using them. One solution might be to simply use the
> required functions from avocado.utils for these tests, and still run
> them via the meson test runner instead, but that needs some further
> investigation that will be done later.
>

So, I believe this type of higher level testing is something that
needs to remain, and even grow.  Speaking for Red Hat, I see the
movement of QE contributing more Avocado-VT style tests into QEMU
itself.  This means way more libraries and features that go into a
common set of utilities and features (more on that later) than it
currently exists in avocado.utils.

This brings the autils[4] initiative into the picture.  We're about
80% done with the project structure, and after that, it will be a
common utility project (such as the cloudinit and ssh) which can be
released automatically when the maintainer votes (through GitHub) that
a new release is needed.  With that, we can have all the existing QEMU
tests (and more) running in either meson or Avocado (for users that
want Avocado runner only features, such as dependency resolution,
container support, etc).

Now, if you think any of this makes sense, I'd love to cooperate with
you on an update that does both: update Avocado, and allow for the
execution of all tests through meson.

Thanks and I'm very very sorry for the delay in this update.
- Cleber.

[1] https://gitlab.com/cleber.gnu/qemu/-/commits/WIP/avocado_test_updates_l=
ts?ref_type=3Dheads
[2] https://gitlab.com/cleber.gnu/qemu/-/jobs/7085879478
[3] https://github.com/avocado-framework/avocado/pull/5953
[4] https://github.com/avocado-framework/autils


