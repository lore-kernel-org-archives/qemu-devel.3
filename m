Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56603C83F17
	for <qemu-devel@archiver.kernel.org>; Fri, 18 Jul 2025 09:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ucheL-0002J8-Gq; Fri, 18 Jul 2025 05:45:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ucheC-0002ET-V3
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 05:44:58 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1ucheB-0006Ac-0i
 for qemu-devel@nongnu.org; Fri, 18 Jul 2025 05:44:56 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-60700a745e5so3422562a12.3
 for <qemu-devel@nongnu.org>; Fri, 18 Jul 2025 02:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752831892; x=1753436692; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XrMHJtz8OYSgsIDn5oIb/Wuqjjj28pK4+/mi9DzYpP4=;
 b=BOiAGBe6AU5J290e2SQvshvSBp0Wr3nMqaFaG8d/wnfvWCSz0dBXxI7/BUkVwkWZ+d
 2ir8LTjP3tiemvQOIu9vxfSAe/oREd2+9QMhRRn9uFU7kbZSFu6GSeJ5CexnCgLV3n48
 NJrnG2QCF5rlgeCPNZcAW2qxhe149YC/Wfvy8C9witBIadws1MW/yF7d2rG+hbmHGNzs
 oQefJLugblfmb4gL3CE8EHNuYI5hCKxyqxA72IDA9fGFv2fw6pkswgarUC9YTZtDyUW6
 AEk4gv0oyNapH8dED95eTzrNn4uDaJ4K8DA5TPC7qW9vXE6y0ZVpvl5uvXqX8lRYo2OJ
 hFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752831892; x=1753436692;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XrMHJtz8OYSgsIDn5oIb/Wuqjjj28pK4+/mi9DzYpP4=;
 b=aTtMqK4Ge7C0xbJ7z5oHb7oqWg63dZhCd7TXBCl0oEcIxwN+M3Yv8QPj63mN/lAnxf
 pIgTW/MjYv0SWnt+HyhYfV4gog6+SKz1IuXLcwo3CpA6sZNR3hvnNMhIIPhAh3K1m7tW
 j2gYBtBBIwFwQBCRdefqfXehzZ3RwxURoGOR53UCoM+sGPWOSFeXZ+JbWXhiiLb7JU6F
 NFCKkphHUd1u0744dyHokXEkqqrx37ImHG7iPN4f30OdOVrnVmHfvUBN56nNx0E5aBgT
 K+mkpbstcjgcqyhHzdTLB9+bSgvC/AlPuRVqJ5u594YrodkSayVl6hW8BIwo9sPYYaxX
 avGQ==
X-Gm-Message-State: AOJu0YxK32lWWSWdokkFq8jYc6B1XGlsqOYFzEwegpUhRsL0Ezy0AX7k
 h7ab31ybdfWeBXhcpQoEYfxfFfTwj8MJFo4FMUCSELdnm6d8EInoJ+2b5CbvCQA6s1ANP5mDim7
 MUG+vx2TDL81TEJn6bCU++2SoZ+S1rCAJFb7N708lXw==
X-Gm-Gg: ASbGncsH6MVGKi9YSQa8/4QDScWeRvXCTMgFGyugNGuO0e32NwaqNG4M0RgZY1IYPJp
 3/UU6FHsRlEvc/buZvmS6AXcv0itquydCo85Ff0Bw2MNjTArm9P+L3MuUM59OysJXwceqbzXok5
 gGbKeAOxVl9sjpYjAUz5krB3pWslXP+kfcL/VI+fUJ3M9RO15TsGpfxMd1jWpSx7HXd6FwxqjdO
 eL+aw==
X-Google-Smtp-Source: AGHT+IGxzpH2PJF1IAmZJJh7hHeIQqJO9TEhF7IbTCXjtwZhH8Xf5nYTut/IWsISzOzh2Jl5ymn9o5yNxeQjoymjBDI=
X-Received: by 2002:a17:907:80b:b0:aec:5516:239c with SMTP id
 a640c23a62f3a-aec55163f91mr492482466b.58.1752831891605; Fri, 18 Jul 2025
 02:44:51 -0700 (PDT)
MIME-Version: 1.0
References: <20250718-functional_tests_args-v1-0-54d4c6207690@linaro.org>
 <20250718-functional_tests_args-v1-3-54d4c6207690@linaro.org>
 <1c805fa1-09c2-417a-9529-6ee9122d37dd@redhat.com>
In-Reply-To: <1c805fa1-09c2-417a-9529-6ee9122d37dd@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 18 Jul 2025 12:44:25 +0300
X-Gm-Features: Ac12FXzu-J7hHV7W1ZZez25VKsPT-AsDEtWOya2aBlWo-UJYKWzgWJhPm9MxQ5g
Message-ID: <CAAjaMXacnuROUjUawd7PVjTvXDQtvCg2dQYz0UjtL2-5ggXx_w@mail.gmail.com>
Subject: Re: [PATCH 3/3] tests/functional: add -k TEST_NAME_PATTERN CLI arg
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x52f.google.com
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

On Fri, Jul 18, 2025 at 12:37=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
>
> On 7/18/25 11:12, Manos Pitsidianakis wrote:
> > Add a CLI argument that takes fnmatch(3)-style patterns as value and ca=
n
> > be specified many times. Only tests that match the pattern will be
> > executed. This argument is passed to unittest.main which takes the same
> > argument.
> >
> > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > ---
> >   tests/functional/qemu_test/testcase.py | 14 +++++++++++++-
> >   1 file changed, 13 insertions(+), 1 deletion(-)
> >
> > diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/=
qemu_test/testcase.py
> > index 4455fcc38016c14db04019bbd64eaae9b47363c1..b7a660fd729afe39ff8cf7a=
0be97c2fc2f2f573f 100644
> > --- a/tests/functional/qemu_test/testcase.py
> > +++ b/tests/functional/qemu_test/testcase.py
> > @@ -55,6 +55,14 @@ def parse_args(test_name: str) -> argparse.Namespace=
:
> >           action=3D"store_true",
> >           help=3D"List all tests that would be executed and exit.",
> >       )
> > +    parser.add_argument(
> > +        "-k",
> > +        dest=3D"test_name_patterns",
> > +        action=3D"append",
> > +        type=3Dstr,
> > +        help=3D"Only run tests which match the given substring. "
> > +        "This argument is passed to unittest.main verbatim.",
> > +    )
> >       return parser.parse_args()
> >
> >
> > @@ -301,8 +309,12 @@ def main():
> >
> >           tr =3D pycotap.TAPTestRunner(message_log =3D pycotap.LogMode.=
LogToError,
> >                                      test_output_log =3D pycotap.LogMod=
e.LogToError)
> > +        argv =3D ["__dummy__", path] + (
> > +            (["-k"] + args.test_name_patterns)
> > +            if args.test_name_patterns else []
> > +        )
>
> This does not work for >1 occurrences of -k. Maybe something like:
>
> argv =3D list(itertools.chain(
>      ["__dummy__", "path"],
>      *[["-k", x] for x in args.test_name_patterns]))


Oops, good catch!

Thanks

> Paolo
>
> >           res =3D unittest.main(module =3D None, testRunner =3D tr, exi=
t =3D False,
> > -                            argv=3D["__dummy__", path])
> > +                            argv=3Dargv)
> >           for (test, message) in res.result.errors + res.result.failure=
s:
> >
> >               if hasattr(test, "log_filename"):
> >
>

