Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFEAAD37E2A
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 13:32:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg0zI-0003ho-H2; Wed, 14 Jan 2026 08:32:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vg0zG-0003ed-R3
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:32:38 -0500
Received: from mail-qt1-x82a.google.com ([2607:f8b0:4864:20::82a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1vg0zD-00016I-GE
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 08:32:38 -0500
Received: by mail-qt1-x82a.google.com with SMTP id
 d75a77b69052e-4ee158187aaso93064841cf.0
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 05:32:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768397554; x=1769002354; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dYC9MECaOeYkArVj/smUxFw7t4bW/pDEQLXuKrDCVeA=;
 b=XQWVvqWQFF5O/NKqCSD0ZNYGDgDCOdb7x133v9vF8vR8A5t2cuWVgf3xXA6Y/Gjmnw
 GRLYu1MR+n0vJ5+FKE3xwTy5o+lLXFknVRCNUuvm/uUhz2bFlsmFrmopm7diBeE6QvKl
 I4gajl3MRmILTs5zXQwi/lWlPb3f8/2nGZwaoyQ3LGlXUOxoAnLn2+ApB0P+tN8Z5k2b
 RlFr14wJm3NPDiirniD0NC1CL2FzOpWLEazaRCNsolxw8PrlMYzX5HCLuVeA9hkN7LTe
 C9/FhU4t5VEcVvBIFke+xfkc5JFiegLt7idl7tSHpeCIZ01kzWGhaER8VetvQS8v48yl
 TutQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768397554; x=1769002354;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dYC9MECaOeYkArVj/smUxFw7t4bW/pDEQLXuKrDCVeA=;
 b=giRV/YrnnzSFUcPit1QyMX5x9ZKijF4Gdfork/uzTbOh9JcOznw1OJZ02dJter6eXV
 8TBvPutIhTpSZLVtjvw7b1hHa0CfqY1+NpgBxH0S7xaafXkb4TYi0XD/vEng2yO2nijK
 0usTSk3AGxgPRnI6BfScKSnIj5jlz7JGe35UNR7ntO7/O00d8MSA6FV4EFRF7hqX8Buj
 A4TpUyUNV71ZxUzIpf6kpNvaw4aeVuIk/jT+el0V3ozADU+jJor9nfAGKv4BTOseac9Z
 ADwlogZ/rHzxziJOABLndCAYIJAer1FInFTr6NxL9mZiS4VJx+tEFD2lm7CtmPbDIJ7y
 kNvw==
X-Gm-Message-State: AOJu0Yw2vogMP6rO9MZKNBjfV+JMBfH0Zarfi6z5GB8AKSUdk/gb86mk
 +Mcqmp5yGGOP9GvfcGH/nsPUPXHzrlie3U+SOdJGqWc9Zmb1/Lt6ykH1kTVylNHdL+VidozZKxs
 RbASUwpD74DX71Utlf04mSp4tT50gVD8=
X-Gm-Gg: AY/fxX4onw6r771n15MT6bFH8ObJnxaPDBCCLA+OhOSvhKujzn8nXICcYqFd2lfn7y4
 v8bVXJAPka1rG+qU7IgpwMcjuoEyKKCyu1UJ/t/dhK6DVsp8wu/MlTa75LMY9Yw0Aub80INC82/
 I/GUZxkKlKXW8Skpe5oIn8SzrukCnSL9+CuS36+4DXz9rw+mP0Isr38s8OSbPAhBhedGXq3dCyL
 G+foDBVVVSy68XjfTbIAjihcp7/Ywex6J1paXVrGxatJe4xbkyswVggkuXBidqH1DlAthNIprVn
 n5OoLEx/m4im5k1iUUHwnO540Pc=
X-Received: by 2002:ac8:4516:0:b0:501:48e9:68f with SMTP id
 d75a77b69052e-50148e90899mr21255751cf.62.1768397554189; Wed, 14 Jan 2026
 05:32:34 -0800 (PST)
MIME-Version: 1.0
References: <20260114090523.1315939-1-pbonzini@redhat.com>
In-Reply-To: <20260114090523.1315939-1-pbonzini@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Wed, 14 Jan 2026 17:32:21 +0400
X-Gm-Features: AZwV_Qjs-Bg2g1g8lHLILJyYJOvCTN8LjXznV6X7Rh9IE_A-58hKvouTjfJxmUI
Message-ID: <CAJ+F1CJ3n-z6EvRZpCDaezw4ytpyBxPWpos=Ge4CmHZ-uSzhcg@mail.gmail.com>
Subject: Re: [PATCH] rust: hwcore: add chardev symbols to integration tests
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, thuth@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::82a;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-qt1-x82a.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, Jan 14, 2026 at 1:06=E2=80=AFPM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Even though they are not used, rustc does not elide its symbols on msys2.
> This causes a linker error.
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

> ---
>         Yet another tiny bit.  For the remaining issue, which is another
>         linker error in the same test due to missing system/memory.c, I'm
>         posting (after retesting) a patch series from Marc-Andr=C3=A9 tha=
t is a
>         bit bigger but was going to be submitted anyway.
>
>  rust/hw/core/meson.build | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/rust/hw/core/meson.build b/rust/hw/core/meson.build
> index fa1765a2302..942ee9cdacf 100644
> --- a/rust/hw/core/meson.build
> +++ b/rust/hw/core/meson.build
> @@ -73,7 +73,7 @@ test('rust-hwcore-rs-integration',
>          override_options: ['rust_std=3D2021', 'build.rust_std=3D2021'],
>          rust_args: ['--test'],
>          install: false,
> -        dependencies: [common_rs, hwcore_rs, bql_rs, migration_rs, util_=
rs]),
> +        dependencies: [chardev_rs, common_rs, hwcore_rs, bql_rs, migrati=
on_rs, util_rs]),
>      args: [
>          '--test', '--test-threads', '1',
>          '--format', 'pretty',
> --
> 2.52.0
>
>


--=20
Marc-Andr=C3=A9 Lureau

