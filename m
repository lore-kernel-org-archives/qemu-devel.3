Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B578BC52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 14:09:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seb9h-0000UC-Kr; Thu, 15 Aug 2024 10:08:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1seb9Z-0000P6-Gn
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:08:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crosa@redhat.com>) id 1seb9W-0001ZQ-AO
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 10:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723730905;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vzr3KYLk8750O7gOgaxuZ0lSzVhIlcuDGPfj02xRDb8=;
 b=i46vzONJdrFMVJI0IKH2Ufv5UU37TcSJ/3bt9nYJdavbPhMgU8oXPJueUJFQnNOOOLPi+b
 E85Tmkzcs8p7jqL2t9IRu/CgsuREtSOn6KTUwcMG5ppLEg0SxQN+zfUgHC3sUmQZyXycCG
 sqe8WGcxXUl4IOakrYL0Ze0YQpatSOY=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-177-rbr-FshRNFq_FMpdt9haqw-1; Thu, 15 Aug 2024 10:08:24 -0400
X-MC-Unique: rbr-FshRNFq_FMpdt9haqw-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-6b0fa22d9faso2969607b3.1
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 07:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723730903; x=1724335703;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=vzr3KYLk8750O7gOgaxuZ0lSzVhIlcuDGPfj02xRDb8=;
 b=EkNBjM23S+AIi5mz1mTlpyOyKSEsCU2jkOMIs0GdUFYsehCHiwy5s74zAmSIaX0OpC
 dRg1pUDQuvWW26EYE45fX0nXHJaa6HOORDkXjmhGrwQOEoQ1tUTO6uwbilPZbMoIjHUZ
 PiciY61bF17k8/XNHXJTIcETuWdqUk1caDUPq3mb4dXTWvrbuxp9E8RJFsrM7qhBsrtm
 tuLfxhVhXg8SwW+YCq28HD6vR0y9seCO3qkbDvRXTk5f9sZI4Az5JZ/pfFFd5LFryc3k
 173gDNV0gJI2iFCb/yr0nMQJbiKnZ2gZ4TVLn7inlrVUqi+HY/t550gKKofnLKQkH9SH
 u0Fg==
X-Gm-Message-State: AOJu0Yz/zfNvLzfx4mQfP8lHT+1GnjQqenIst4yb/LArCSgJs3OXK5bg
 Vx4RJQTGsHLAoPvUgPXe3sZQHuUlnK7YsqxbNL+B1jEHmHiUWXOyz/NPBX6RNSN05xuGqgSmbGw
 vU2HH5I9HeZjLG6J+LoXMuEZrA9+jN+mvvfSrF2JKn/DLMVjKPx6b+hMhyTuzymMLVwgDwbak2H
 MHspn+FI/KzXKWpQaoGbj1vpEjWkQ=
X-Received: by 2002:a05:690c:4710:b0:651:6e6f:32d2 with SMTP id
 00721157ae682-6ac9a4787c2mr61877217b3.43.1723730902725; 
 Thu, 15 Aug 2024 07:08:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFT7vDXefVC4Et5zdVF0bwaa4s7FPKN+0th/aIjv2bWaCiNvtKshmdfN94YlL0srm5N1LZPSBnK/+GCQt+WDjs=
X-Received: by 2002:a05:690c:4710:b0:651:6e6f:32d2 with SMTP id
 00721157ae682-6ac9a4787c2mr61876777b3.43.1723730902291; Thu, 15 Aug 2024
 07:08:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240806173119.582857-1-crosa@redhat.com>
 <20240806173119.582857-10-crosa@redhat.com>
 <1f645137-c621-4fa3-ace0-415087267a7b@redhat.com>
In-Reply-To: <1f645137-c621-4fa3-ace0-415087267a7b@redhat.com>
From: Cleber Rosa <crosa@redhat.com>
Date: Thu, 15 Aug 2024 10:08:11 -0400
Message-ID: <CA+bd_6LTqGbx2+GOyYHyJ4d5gpg4v8Ddx5apjghiB0vjt8Abhg@mail.gmail.com>
Subject: Re: [PATCH v2 9/9] Avocado tests: allow for parallel execution of
 tests
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, 
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Radoslaw Biernacki <rad@semihalf.com>, 
 Troy Lee <leetroy@gmail.com>, Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Beraldo Leal <bleal@redhat.com>, kvm@vger.kernel.org,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Aurelien Jarno <aurelien@aurel32.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, Paul Durrant <paul@xen.org>, 
 Eric Auger <eric.auger@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 qemu-arm@nongnu.org, Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jamin Lin <jamin_lin@aspeedtech.com>, 
 Steven Lee <steven_lee@aspeedtech.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Leif Lindholm <quic_llindhol@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=crosa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Mon, Aug 12, 2024 at 6:17=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:
> ...
> > diff --git a/tests/Makefile.include b/tests/Makefile.include
> > index 537804d101..545b5155f9 100644
> > --- a/tests/Makefile.include
> > +++ b/tests/Makefile.include
> > @@ -94,6 +94,9 @@ TESTS_RESULTS_DIR=3D$(BUILD_DIR)/tests/results
> >   ifndef AVOCADO_TESTS
> >       AVOCADO_TESTS=3Dtests/avocado
> >   endif
> > +ifndef AVOCADO_PARALLEL
> > +     AVOCADO_PARALLEL=3D1
> > +endif
> >   # Controls the output generated by Avocado when running tests.
> >   # Any number of command separated loggers are accepted.  For more
> >   # information please refer to "avocado --help".
> > @@ -141,7 +144,8 @@ check-avocado: check-venv $(TESTS_RESULTS_DIR) get-=
vm-images
> >               --show=3D$(AVOCADO_SHOW) run --job-results-dir=3D$(TESTS_=
RESULTS_DIR) \
> >               $(if $(AVOCADO_TAGS),, --filter-by-tags-include-empty \
> >                       --filter-by-tags-include-empty-key) \
> > -            $(AVOCADO_CMDLINE_TAGS) --max-parallel-tasks=3D1 \
> > +            $(AVOCADO_CMDLINE_TAGS) --max-parallel-tasks=3D$(AVOCADO_P=
ARALLEL) \
> > +                     -p timeout_factor=3D$(AVOCADO_PARALLEL) \
> >               $(if $(GITLAB_CI),,--failfast) $(AVOCADO_TESTS), \
> >               "AVOCADO", "tests/avocado")
>
> I think it was nicer in the previous attempt to bump the avocado version:
>
> https://gitlab.com/qemu-project/qemu/-/commit/ec5ffa0056389c3c10ea2de1e78=
3
>
> This re-used the "-j" option from "make", so you could do "make -j$(nproc=
)
> check-avocado" just like with the other "check" targets.
>

Hi Thomas,

I can see why it looks better, but in practice, I'm not getting the
best behavior with such a change.

First, the fact that it enables the parallelization by default, while
there still seems to be issues with test timeout issues, and even
existing races between tests (which this series tried to address as
much as possible) will not result in the best experience IMO.  On my
12 core machine, and also on GitLab CI, having 4 tests running in
parallel gets a nice speed up (as others have reported) while still
being very stable.

I'd say making the number of parallel tests equal to `nproc` is best
kept for a future round.

Let me know if this sounds reasonable to you.

Regards,
- Cleber.

>   Thomas
>


