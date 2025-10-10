Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2185CCD185
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Oct 2025 14:15:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7DtT-0007bx-VD; Fri, 10 Oct 2025 10:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1v7DtM-0007Vf-Fx
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 10:14:46 -0400
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1v7DtC-0003gh-SW
 for qemu-devel@nongnu.org; Fri, 10 Oct 2025 10:14:42 -0400
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-628f29d68ecso4457890a12.3
 for <qemu-devel@nongnu.org>; Fri, 10 Oct 2025 07:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760105672; x=1760710472; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=058w4CnQoaWYCrsWvckRBoaK3UCOTYkXq/JMaiKx6Lg=;
 b=BBMPmbvUsXMQBxgQ3CZRmfdgWl007a4jmPejpm3TMbG2OJy/nBckxvFbUoMa9NpoLn
 kNEEH2v2fubStlevCdowbot3eY7cY3FZyp/97rPENR2caXAtoUjI+oWCLxiRT+WYqoCb
 itAROP2Ej+3GSQ/oGXYvhDfZgTabvAR3jBuG0iPYKv3vTDxoPwGKydCtu/HOkZYti/Rj
 i8bu1i3MgFdIZgAlcZmm10DPAyTfFKYV8k4ybNnHa1GXP+ShgDjQPUW1JdV3Yvuu81xy
 zrDw0yLJO+sGmPJhXdnZwfpBtEHXtkO3mOSdXM2kOZBEcDkpZh+heuv1okJ7xngk0J3L
 kgYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760105672; x=1760710472;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=058w4CnQoaWYCrsWvckRBoaK3UCOTYkXq/JMaiKx6Lg=;
 b=uIrY/E1X5FfEchlXnQvQpfoPNx+ItM4P+wrez9vahw1QwOSgkP+2UMUgUOQ+uZl8u6
 sHJ7GDMM0vkQgA9QzrLqZxahaxHtpNKbuJFc1SKABLtYY4x1QjJVixiJx2HWWW0KmDIB
 zFlEySeFXwzT35S8HdQyh1EbgGmQeHBd1XuTs/FBXhP9G5Lv4oRuvn5+rRiS5pDoXllL
 2TannCKVGJABeE2m9Oktp8hlmluZnq1D69ZQUU0r3A1gKOsMYElnvajG4/x1EGZEtS5v
 c7ZFpm4dCHyxtndaNW1MuqolywQY4tG4BmnbwOe6QDa4hYVFIIgRpfrusQEJVNyTuhUg
 KeGA==
X-Gm-Message-State: AOJu0Yx7ZR+iGQDl1MTX8NIs9m12ETUJQSVj1boQGZvmA8A9AltuVzAb
 FNiMpcMuofN3G+OPgsDNnSClQsgCFAQrUkCoIZ4U8Orp8T0pseksHPXdbXOHeygkjj8sSnagO/D
 2l2IqZ6PN6QeQ+HfdNuWxALIqPmovOKrLHqFw55RFC3ZP0UiCXvSer8E=
X-Gm-Gg: ASbGncvmF7K6DKJAdievDPwdGIX+1CaJdEzYjzk2Y67WtdwfpwOk1QB2ClIS5DvQuh8
 ZH+ptz+wVWo/gDPHXLp8Qj1IZ0K6veaFXavSHvPgDWdnf+dsoovGAdzmRDL/ttFctZt+691kd4q
 HDcZYdDrZArj7gTuk2uoJCp6bPFJjoRIqOb3SHnBdBNCl0FIFcQdjMjdMaf5QArza/mTwJxw4Ag
 XoByHLgOntjU581CPAbmBUWbHVNjR/6zENqTQ==
X-Google-Smtp-Source: AGHT+IGxtlECE4+UHktRUMy+A//VOGAnjBHD2SX5viARvXdAzr32tIoT43FoqQrmT5PrGe95cp7q14jQB4EmZ3Ck21U=
X-Received: by 2002:a05:6402:254c:b0:62a:a4f0:7e4f with SMTP id
 4fb4d7f45d1cf-639d5c52babmr10087997a12.29.1760105671989; Fri, 10 Oct 2025
 07:14:31 -0700 (PDT)
MIME-Version: 1.0
References: <20251009211208.643222-1-pbonzini@redhat.com>
 <CAAjaMXaPv+hENfLuZUeLEOjakuw7dOTLQCeaUbuveZW4Y_2PBQ@mail.gmail.com>
 <0766dc6c-6cab-4f56-a8ab-c573aff15421@redhat.com>
In-Reply-To: <0766dc6c-6cab-4f56-a8ab-c573aff15421@redhat.com>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Fri, 10 Oct 2025 17:14:06 +0300
X-Gm-Features: AS18NWAPD9S-wVx_UgSXe0blu_FRPrLgrbxk0hk695JasrsM-S9HRdjcGWkRVig
Message-ID: <CAAjaMXbTonve3KrHm_AfizEq4vH9R53encUwpRG7sNtthqh0HA@mail.gmail.com>
Subject: Re: [PATCH] rust: temporarily disable double_parens check
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, 
 Richard Henderson <richard.henderson@linaro.org>
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

On Fri, Oct 10, 2025 at 5:12=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> On 10/10/25 14:23, Manos Pitsidianakis wrote:
> > On Fri, Oct 10, 2025 at 12:12=E2=80=AFAM Paolo Bonzini <pbonzini@redhat=
.com> wrote:
> >>
> >> It is showing in the output of the bits! macro and not easy to fix the=
re
> >> (at least not without making the macro more complex).  Disable it for
> >> now.
> >>
> >> Link: https://github.com/rust-lang/rust-clippy/issues/15852
> >> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> >> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> >> ---
> >
> > How about putting it in the macro expansion instead of globally allowin=
g it?
> >
> > macro_rules! foo {
> >      ($a:expr, $b:expr, $c:expr, $d:expr) =3D> {
> >          #[allow(clippy::double_parens)]
> >          InterruptMask(((($a.union($b).union($c).union($d))).into_bits(=
)) as u32)
> >      }
> > }
>
> Can you do it for procedural macros as well?

Of course!

>
> > Why is the double parenthesis needed here by the way? It's a method cha=
in
> It's just how the macro works, occasionally generating double
> parentheses keeps the parser simple.

Makes sense.

