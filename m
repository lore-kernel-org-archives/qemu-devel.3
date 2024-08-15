Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A401C52D7D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 10:13:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seXTW-0000O9-1g; Thu, 15 Aug 2024 06:12:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1seXTT-0000LD-K7
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 06:12:55 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1seXTR-0003ig-Lp
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 06:12:55 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5a156557026so992365a12.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2024 03:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723716772; x=1724321572; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IBNryXwUQ1FmSedDlo0SbME5pHcOtJSt28zB17THPuk=;
 b=Xa8o/uEIqYjyylI4WBvhyOpgkEIG5KwKsAmm73OpJdnl1Yflj0plAThk/NejnWIPvT
 R3NSqILnz092OXo3HfTNzOXaiKRK+ioRP1zCYcDlW5IH9eaXHFrY3sEfqCex213vlIDF
 etnIDmyf8FXvMs8wpRmiTl8lUihKfBFDChfd5wdrBO6ds+j6ojYR3A4NnSuupyEwmaJk
 TnVq4X7wH9v0Lz/7UcWZWyAKG+7DI+DIBnfyInUbUdpOZPLPynQ4kDV4WRHcqWwxhHUb
 lxEc86ipnYVAraA96b9I+q0dk+X/qEH0R8z7WuwKudRM02CNZkJBM6wQVerZnub2cUGx
 i0OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723716772; x=1724321572;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IBNryXwUQ1FmSedDlo0SbME5pHcOtJSt28zB17THPuk=;
 b=BWORrCE8g6YLl7WPod9oOwTcBCy6WRiGTzOd3807ZzoQ1Kx768tKQ0a2HmMoLELYoo
 ntgkigxXZnJqRUaUOX19D1FpiLcce+aHcgm1FiwBUV8sdQSn2yTU49QASjZYCAZAqqIh
 uepK5D7dJNy7NG+D7B8yHQ1+bm/PlBXy4K66tN0mkX3v4AJQgBeGLVpZnrFbPaBktCMW
 rJ7Ai3MdVAPeV7CXzfzDUePAvLmBAMfab/k37TgJe0BmEJ8RFF0fbrsUxCi72G9fpKIb
 LMlVWtsgEqGEVlM/gHsXv5RHATNqxmWy5h87HWXjGc/RKuemn1/qbxwgQJY4nKSroWAj
 A3hg==
X-Gm-Message-State: AOJu0Yy1kq4g01E7q8M02IPbPV1ZPfYHSOgtRXFRR4HnIpgwHkD9ApEt
 WFTDmr7oFbYCqhOfggpmV6+OaWxpUL9H1JH3dXHwWQqb1vpwT2t11sNg/7ImtHGdJoxHfnCrLvR
 x756Fqgvo5Y6icnXP7EJCDqe1+NOesSvrBN7NBw==
X-Google-Smtp-Source: AGHT+IGNaYJf90yHZ/TRxldPcq5OdO7je4IKLHSYUqjFp+8oZOTGa63oYD4Ubggc5/tHzKEgewZOFYIFZFUJtMC9c+Y=
X-Received: by 2002:a05:6402:3788:b0:58b:7b90:94e2 with SMTP id
 4fb4d7f45d1cf-5bea1cb4e62mr2896445a12.38.1723716771475; Thu, 15 Aug 2024
 03:12:51 -0700 (PDT)
MIME-Version: 1.0
References: <20240814224132.897098-1-pierrick.bouvier@linaro.org>
 <20240814224132.897098-2-pierrick.bouvier@linaro.org>
In-Reply-To: <20240814224132.897098-2-pierrick.bouvier@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Aug 2024 11:12:39 +0100
Message-ID: <CAFEAcA-EAm9mEdGz6m2Y-yxK16TgX6CpxnXc6hW59iAxhXhHtw@mail.gmail.com>
Subject: Re: [PATCH v2 1/4] meson: hide tsan related warnings
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: qemu-devel@nongnu.org, Beraldo Leal <bleal@redhat.com>, 
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org, 
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-s390x@nongnu.org, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Ilya Leoshkevich <iii@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Wed, 14 Aug 2024 at 23:42, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
>
> When building with gcc-12 -fsanitize=3Dthread, gcc reports some
> constructions not supported with tsan.
> Found on debian stable.
>
> qemu/include/qemu/atomic.h:36:52: error: =E2=80=98atomic_thread_fence=E2=
=80=99 is not supported with =E2=80=98-fsanitize=3Dthread=E2=80=99 [-Werror=
=3Dtsan]
>    36 | #define smp_mb()                     ({ barrier(); __atomic_threa=
d_fence(__ATOMIC_SEQ_CST); })
>       |                                                    ^~~~~~~~~~~~~~=
~~~~~~~~~~~~~~~~~~~~~~~~~
>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>  meson.build | 10 +++++++++-
>  1 file changed, 9 insertions(+), 1 deletion(-)
>
> diff --git a/meson.build b/meson.build
> index 81ecd4bae7c..52e5aa95cc0 100644
> --- a/meson.build
> +++ b/meson.build
> @@ -499,7 +499,15 @@ if get_option('tsan')
>                           prefix: '#include <sanitizer/tsan_interface.h>'=
)
>      error('Cannot enable TSAN due to missing fiber annotation interface'=
)
>    endif
> -  qemu_cflags =3D ['-fsanitize=3Dthread'] + qemu_cflags
> +  tsan_warn_suppress =3D []
> +  # gcc (>=3D11) will report constructions not supported by tsan:
> +  # "error: =E2=80=98atomic_thread_fence=E2=80=99 is not supported with =
=E2=80=98-fsanitize=3Dthread=E2=80=99"
> +  # https://gcc.gnu.org/gcc-11/changes.html
> +  # However, clang does not support this warning and this triggers an er=
ror.
> +  if cc.has_argument('-Wno-tsan')
> +    tsan_warn_suppress =3D ['-Wno-tsan']
> +  endif

That last part sounds like a clang bug -- -Wno-foo is supposed
to not be an error on compilers that don't implement -Wfoo for
any value of foo (unless some other warning/error would also
be emitted). At any rate, that's how gcc does it
(see the paragraph "When an unrecognized warning option ..."
in https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html )
and I thought clang did too...

thanks
-- PMM

