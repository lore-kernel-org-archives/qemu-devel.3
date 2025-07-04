Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78BAAC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 12:20:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXfO1-0003Mj-12; Fri, 04 Jul 2025 08:19:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uXfNm-0003Kw-83
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 08:19:10 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uXfNh-0003kM-S5
 for qemu-devel@nongnu.org; Fri, 04 Jul 2025 08:19:07 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-60c6fea6742so1778699a12.1
 for <qemu-devel@nongnu.org>; Fri, 04 Jul 2025 05:19:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751631542; x=1752236342; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oJfIR9UWsxS+bqd1tEuMyoRls3ClDB7lB9jYjN8f+ck=;
 b=NbvGuKaXdGy6vlJHqB6R0hTyaasE8TtBELA7NnrvTKyy0D8IDggmPqeglUozoMNPAR
 V1FWeWflNZUsgC/2J5YVCugIGVz3nQaszy5JT0nGA09poZ7RnaD5aAc3UVZzCyo52tQa
 Dt8YOojiExWS3nyVz0xPol3dIuHNR9ssZc9TZzxARFcTY5NN5QDbXbSq5DqMlhZ3kKzI
 2N0sNa16RO6bI2rZ1B0I/IBjEDSciZy9HgWuvO2Q+GnCgb1vyhP1KadQ1Jz1dZ27MWOU
 8rcZqQoLcUo3OIsWEDJPIOjUJwdp6n0MwsZaYJX0LGnpuj7wBBtvd5QHBrjc78cmBOy3
 dxSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751631542; x=1752236342;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oJfIR9UWsxS+bqd1tEuMyoRls3ClDB7lB9jYjN8f+ck=;
 b=HzxE72Yq+FuAmDqTJLlg0YnhZKjSmND2ybbYntlIsr7PuxBUi9rDpOIJrNCw8ZtjQB
 E8ESihA89eI49eOpFQyEMCsHnj2gv0e0r7WA2Av3D8AWcq+2h8jj7ce6+nIJorBTSNiR
 fqPovGbaIpCqg2Z1iKDB25Om7srnl5Xtsnd8MY+ObO5Lb2pQGftlOY1qik7iDGYLTAQl
 +RTn2vzlPGiN76GcPitkxHqGZgWkM3Zz+3YesTaPqcYCTLlMNLVJdXgxM4TXrR9hn7Br
 vi271iif4Hx+Dd5NnKT/12U1KXxB1YZT2XcX7hjafOF3jxXoAvsGNhmE9eB/2K83H7wS
 hg2Q==
X-Gm-Message-State: AOJu0YxyF3RyMgAiw+cT57SvjMGXt+ba04pklQeSWxVrawG5Qh+emSsr
 hC9l+1zDpf6wg7ly9UhdgFTHgQRvUfNVWKwN6Zkt4j3JuS3/CJtfBc2SBO0u8wpm2SiexuYf5Ag
 4bb0N4uSxFbH3TD2cLtDHGa3nfjm5v/vXp3u3L7aIMOag9J18lOts+gfIKQ==
X-Gm-Gg: ASbGnct3oo2i7WjuR/OysnEEcQJ4LTXSAI+rPwQ8CzsMYZNBianpo6z2IMo3kvallF7
 uByfI4atBNRLOiUJk4C8Yj2JCH3z60dwuuV5fiiWVgDqcd7HsPkBfwWhFhiSWtAoc/Uf9urqU9+
 NHZVCDva83KfsicdKOVeUEoTqF+b7tB9ZULC1YPt0Kd8k=
X-Google-Smtp-Source: AGHT+IG9gO9hDSEDs9TdXGLVglUNhefZJCU/vSM31F8AZB4cRpN4KdvlB5Qzcbu7EihJSWszmFisKItdNp/FO9jht3A=
X-Received: by 2002:a17:907:d94:b0:ad8:a329:b490 with SMTP id
 a640c23a62f3a-ae3fbc56cbamr223334666b.23.1751631542216; Fri, 04 Jul 2025
 05:19:02 -0700 (PDT)
MIME-Version: 1.0
References: <20250704-rust_add_derive_macro_unit_tests-v1-0-ebd47fa7f78f@linaro.org>
 <aGfKqbywpiZEUr37@intel.com>
In-Reply-To: <aGfKqbywpiZEUr37@intel.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 4 Jul 2025 15:18:18 +0300
X-Gm-Features: Ac12FXwJFj4tmBXIKE-Le9yl85wKgJs-a03DIJc5x9ddVZvMRDKl8DF45VekluM
Message-ID: <CAAjaMXbcMUmdUFMYfiZsygjhrmzKWqBWhdtBwwtt2JgvnrxoKg@mail.gmail.com>
Subject: Re: [PATCH 0/2] rust: add Derive macro unit tests
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
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

On Fri, Jul 4, 2025 at 3:14=E2=80=AFPM Zhao Liu <zhao1.liu@intel.com> wrote=
:
>
> > You can run the added tests directly with this meson command:
> >
> >   meson test rust-qemu-api-macros-tests
>
> Hi Manos, do you meet this error:
>
> Traceback (most recent call last):
>   File "/usr/lib/python3/dist-packages/mesonbuild/mesonmain.py", line 146=
, in run
>     return options.run_func(options)
>   File "/usr/lib/python3/dist-packages/mesonbuild/mtest.py", line 2004, i=
n run
>     b =3D build.load(options.wd)
>   File "/usr/lib/python3/dist-packages/mesonbuild/build.py", line 2868, i=
n load
>     obj =3D pickle.load(f)
> ModuleNotFoundError: No module named 'mesonbuild.options'
>
> ERROR: Unhandled python exception
>
>     This is a Meson bug and should be reported!
> ---
>
> But I've tested this series via `make check`.
>
>
>
>

Sounds like it used your global meson installation instead of the one
from the virtual environment of your build directory.

Thank you for testing!

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

