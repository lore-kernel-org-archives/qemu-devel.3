Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BB74C83F26
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Jul 2025 09:01:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ufEIc-0002Lh-8H; Fri, 25 Jul 2025 05:01:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ufEIZ-0002IJ-8S
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 05:01:03 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ufEIX-0003BK-CM
 for qemu-devel@nongnu.org; Fri, 25 Jul 2025 05:01:03 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-60c93c23b08so3742432a12.3
 for <qemu-devel@nongnu.org>; Fri, 25 Jul 2025 02:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753434056; x=1754038856; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=U0zsCl632JxiFG78PGxVFJHp5a1rZWy+r42n1YvHcF8=;
 b=MfJ0B+3mZf7b/tnnWNPpIUyzwjmmjV9o95Y40EDiklerambgy9ZGIpYFcZj0QVoHFr
 dKJ5cArt/DYUK+wHeaXBcFsYXSS7qXtPCzJGFjCvnIVC8kjjEYugjPQnAVUkM//thBQe
 rFZNb5tiKPEO/ngqq8PasqDda//hFctxarwFRn0pml9NrEgEiA8QvXT0bw2UiWu5RLTz
 IVmngKvpPwSpslKwHUn/j8BpF+LIBfF5WcWia2X0YipW4sizToNnSUFuugyG5veNpVb8
 8uHFSXsrQy7TfhNN4ab69Axjq938nECNOseYsR/6WjUb+yw4Z3QXJu1Ub0ChFhNfPHvq
 IY0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753434056; x=1754038856;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=U0zsCl632JxiFG78PGxVFJHp5a1rZWy+r42n1YvHcF8=;
 b=woMU/7OrNrk3WDyQUkC3KqXu1SoTyeh+WJMKlQCjpfaucrsmC8shfjltR5dJ1dNu5a
 VQvh2RmGLJhOEguzVh7Ka1MZZtgibgP2DccEueiow6moAUwwJrezqf+QbBWe3Jk1xzzH
 2TKtUksM4hD7IYZAcTG30bCsSMNBfi2rX/PTViJcahKz3WVDYNl7lFssJIdbXtp+2cC2
 /J8xMHTt8cQqQQtgVcSq2Zpfkd+zw3cShIqiIGkpnBK9eH/Af042WsK3egiCgXE7NJ6t
 W7kuG5ff3uGz6IvB4CUn8MfylZOa2mLzGIkPc68BxakF5pzkl79sygoLQqEG9wSDA9FC
 Y9Zw==
X-Gm-Message-State: AOJu0Yy+JLrGAGM29nYRI10H8/2drtrp31GLCq/yVcHwua2n6K6BYTiw
 fUPzjtwgvKQiKudj9MT8LR2WNve2EUyQMpmNFgUlVnvrSsq8WC4VV3CbTYtLlYckpCmyAYsKpKE
 AtZEMHR6K9dwWRxt+upRh3GS37aZAu3B8HChQLDPXeHIoLViKSDlz
X-Gm-Gg: ASbGncvobvVNg/luyD2dFJIAUKCNI+IdHZIFJiqqeNA97Sr9XVatWni4NyV3lSMCG51
 ZEs+0zyixszry8DhFtTxBEO2SREgjUYL38Rr+vbanzbyy0l0Mw/w6/9Mx6RDpgfC4TayehFYQd3
 kXdShVJgcY9K5gWkonCf3QkfVOfJXSu7Xr6OPnOYCcxAl+urX6saWU8jTjNNCb9MCgAmQM17q/P
 ioI6ntASmoKjPJY
X-Google-Smtp-Source: AGHT+IE8vdyMd0Wh3Nnocsw5SpGx/pxzAYoxO9dC11UaDH8uxY1+vucTPE5yau1nqrfvRsXUjZ3GaXp7xkGvtgGHxVI=
X-Received: by 2002:a05:6402:42d4:b0:612:c846:cb67 with SMTP id
 4fb4d7f45d1cf-614f1bd4a21mr927186a12.6.1753434055663; Fri, 25 Jul 2025
 02:00:55 -0700 (PDT)
MIME-Version: 1.0
References: <20250718-functional_tests_args-v2-0-cde6e08bf98e@linaro.org>
 <20250718-functional_tests_args-v2-2-cde6e08bf98e@linaro.org>
 <b5d0c17b-cd99-494b-8919-665fd2519233@redhat.com>
In-Reply-To: <b5d0c17b-cd99-494b-8919-665fd2519233@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 25 Jul 2025 12:00:29 +0300
X-Gm-Features: Ac12FXzVsBAl2lUKA3k2DJF0ALKiCQj9vu7dUlBnJH1RJPL0wybBADmMpAubirE
Message-ID: <CAAjaMXYKvrznEr6kVwWTGXjTgFCtnCFaRGuZS=qCd1C6fYgOFQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] tests/functional: add --list-tests CLI arg
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x536.google.com
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

On Fri, Jul 25, 2025 at 7:40=E2=80=AFAM Thomas Huth <thuth@redhat.com> wrot=
e:
>
> On 18/07/2025 13.04, Manos Pitsidianakis wrote:
> > Add CLI argument to list tests and exit.
> >
> > Example output (current dir is build directory under root dir):
> >
> >    $ export PYTHONPATH=3D../python:../tests/functional
> >    $ export QEMU_TEST_QEMU_BINARY=3D"$(pwd)/qemu-system-aarch64"
> >    $ ./pyvenv/bin/python3 ../tests/functional/test_aarch64_virt.py --li=
st-tests
> >    test_aarch64_virt_gicv2 (test_aarch64_virt.Aarch64VirtMachine.test_a=
arch64_virt_gicv2)
> >    test_aarch64_virt_gicv3 (test_aarch64_virt.Aarch64VirtMachine.test_a=
arch64_virt_gicv3)
> >    test_alpine_virt_tcg_gic_max (test_aarch64_virt.Aarch64VirtMachine.t=
est_alpine_virt_tcg_gic_max)
> >
> > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > ---
> >   tests/functional/qemu_test/testcase.py | 16 ++++++++++++----
> >   1 file changed, 12 insertions(+), 4 deletions(-)
> >
> > diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/=
qemu_test/testcase.py
> > index 9b00c63e6ca7a2a669fd456f1d1b51501ce4a726..bfee6638edf6f9853ead1e3=
809ae3c9152089406 100644
> > --- a/tests/functional/qemu_test/testcase.py
> > +++ b/tests/functional/qemu_test/testcase.py
> > @@ -50,6 +50,11 @@ def parse_args(test_name: str) -> argparse.Namespace=
:
> >           "This is equivalent to setting QEMU_TEST_KEEP_SCRATCH=3D1 in =
the "
> >           "environment.",
> >       )
> > +    parser.add_argument(
> > +        "--list-tests",
> > +        action=3D"store_true",
> > +        help=3D"List all tests that would be executed and exit.",
> > +    )
> >       return parser.parse_args()
> >
> >
> > @@ -280,10 +285,13 @@ def tearDown(self):
> >
> >       def main():
> >           path =3D os.path.basename(sys.argv[0])[:-3]
> > -        # If argparse receives --help or an unknown argument, it will =
raise a
> > -        # SystemExit which will get caught by the test runner. Parse t=
he
> > -        # arguments here too to handle that case.
> > -        parse_args(path)
> > +        args =3D parse_args(path)
>
> As mentioned for the initial --debug patch already: How's about changing
> that "args" into a class variable instead and get rid of the parse_args()=
 in
> the setUp() function?
>
>   Thomas

Yes that sounds good. Will merge the two patch series and resubmit,
thanks Thomas!

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

