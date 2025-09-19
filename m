Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60244CAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 10:41:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzYYY-0004wk-QZ; Fri, 19 Sep 2025 06:41:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uzYYX-0004wT-5y
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 06:41:33 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uzYYU-0002wa-9u
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 06:41:32 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-afcb7ae6ed0so288103166b.3
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 03:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758278488; x=1758883288; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lerSm6n0kEc/ak2Qs+X5z0DYC9NL2LWkFkkl5WnCWCI=;
 b=K5h/cTefnmQjm+2expp61MrjUc4V3RoXM9JBnFYP5k8nJb7ZBewrjhDsGG9vi6jHJq
 C6zKBLAQjfoTcWJkNKDIUIPOuxVLPpqR0kR++951Hz+TnyorjXoysvxlD219UQOlYz3c
 2KddVMnx/8l0kgMmPBofazWXfnD9JToI7ETX+YLesExkKecA9ufS4goAk7SzqurUJSK3
 gXXhjp02VZOGK0kvtsdmiw7tPMCQ+2q6pd5KSw8yoX5y2u11qFl5xl44T7GtCmUAqK/4
 6WhjKICky2tpgvTVK8riOl5E8yTjkr7KnTCdtN/2gzGYtF62lnuwsjGfRcPTWA2q9PZp
 I6Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758278488; x=1758883288;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=lerSm6n0kEc/ak2Qs+X5z0DYC9NL2LWkFkkl5WnCWCI=;
 b=b8Y2WB3LrrRWFtufJJyQvTAiWKDJ4GPP3asfqDEXsu2p7wMWrcoVMTfom6vDAuVkoR
 GKah8M/bScauP1iXkImkuArSdocMVhM1z1ah1rjP9NiAtk541PYXKf2TsWDG523DwuP4
 Y7M2X/SXXlI87w7dH+62UViiBHdw3nWx687QmGFHUbqz7V8wJNdfAqeh9gqHk7V7ANYr
 zUullFeIdtk5QTlXmvnpKrhN8DxISlObtWpZXy1Ka9YqKrKuEnDa6EK2rhuSSYuMchp6
 AocLD1kXGUXI2wCg/cEbpF5D8vdpnNkyN8PwD3juiJG3HW2cFhxpSCBttW/9SAalxFkq
 dClw==
X-Gm-Message-State: AOJu0YyQJUk+Mz+6AP9hTp37TfxzW36VWFdNHMUADUL2Y8iitJd3CvZj
 3kW7H+DcJyUs88f2OGOH3/NRGyklOmsTE6lYZVOlxwcsMz3B4HK/yto9fGrI39K3lPU4B1PicIF
 PLBAqHVNGIJbhDnuCGs3G0pXn9cOC5v1jXLYCLmsyG0N+Y3INRKIb5Np0lA==
X-Gm-Gg: ASbGncsN2obrXQ5Xc19rNTgfhB3gNEviUJ+7ggrRhbkcQgryo00VvoefwPW9cP9pcAe
 1dBkPaXyGgMAHFAwfwXd9itjPAC0n76Lchipx8aOCxjLJyMHwt63/ni0YlrSE5H9gNamN7Zz54b
 AKz3XnpUxClB0SIFi6mTMGjJ3PI8SKoIz/uQKHy6R/qRqyE4bPQ88JubtGf9OYtZh6+KK2wG67X
 NQGeA==
X-Google-Smtp-Source: AGHT+IG2ly5GzPGbufCbZSQM7GVgtls4V5XGyYAgKETjPIt6zONASg2Tctahm/Az/1rCvyirkoYfG6p7rO9V/uX+x94=
X-Received: by 2002:a17:907:d1a:b0:b09:48c6:b7ad with SMTP id
 a640c23a62f3a-b24f65eca66mr300495066b.57.1758278487756; Fri, 19 Sep 2025
 03:41:27 -0700 (PDT)
MIME-Version: 1.0
References: <20250919083617.86582-1-pbonzini@redhat.com>
In-Reply-To: <20250919083617.86582-1-pbonzini@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 19 Sep 2025 13:41:01 +0300
X-Gm-Features: AS18NWAFI6NN5ftxhJ-E-MFpPQAhHDstqlEpCicCi_PAmcGSzZSkkrPF_EUsQDM
Message-ID: <CAAjaMXbYASsQuCRcN7ggCB-5GpMr6Qc+JYXUzMxRdh4E45M5nQ@mail.gmail.com>
Subject: Re: [PATCH] rust: build: add back common and util tests
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62d.google.com
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

On Fri, Sep 19, 2025 at 11:37=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com=
> wrote:
>
> These were dropped by mistake when extracting the crates.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  rust/common/meson.build | 3 +++
>  rust/util/meson.build   | 4 ++++
>  2 files changed, 7 insertions(+)
>
> diff --git a/rust/common/meson.build b/rust/common/meson.build
> index b805e0faf57..07d073182ed 100644
> --- a/rust/common/meson.build
> +++ b/rust/common/meson.build
> @@ -24,6 +24,9 @@ _common_rs =3D static_library(
>
>  common_rs =3D declare_dependency(link_with: [_common_rs])
>
> +rust.test('rust-common-tests', _common_rs,
> +          suite: ['unit', 'rust'])
> +
>  # Doctests are essentially integration tests, so they need the same depe=
ndencies.
>  # Note that running them requires the object files for C code, so place =
them
>  # in a separate suite that is run by the "build" CI jobs rather than "ch=
eck".
> diff --git a/rust/util/meson.build b/rust/util/meson.build
> index 87a893673d2..96330504459 100644
> --- a/rust/util/meson.build
> +++ b/rust/util/meson.build
> @@ -44,6 +44,10 @@ _util_rs =3D static_library(
>
>  util_rs =3D declare_dependency(link_with: [_util_rs], dependencies: [qem=
uutil, qom])
>
> +rust.test('rust-util-tests', _util_rs,
> +          dependencies: [qemuutil, qom],
> +          suite: ['unit', 'rust'])
> +
>  # Doctests are essentially integration tests, so they need the same depe=
ndencies.
>  # Note that running them requires the object files for C code, so place =
them
>  # in a separate suite that is run by the "build" CI jobs rather than "ch=
eck".
> --
> 2.51.0
>
>

