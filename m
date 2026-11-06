Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 251BF606EE91
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2026 16:18:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=lDM2dpb0
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xPMdT-0006fz-7F; Fri, 06 Nov 2026 11:17:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xPMdR-0006fp-NF
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 11:17:49 -0500
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xPMdO-00045e-MJ
 for qemu-devel@nongnu.org; Fri, 06 Nov 2026 11:17:49 -0500
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-67c0ffaae1dso1603363d50.1
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2026 08:17:40 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1793981860; cv=none;
 d=google.com; s=arc-20260327;
 b=Vx4YsvGHtvhQZY4/KUr0sHRE/W9BcYOmo0PHYXpFL5JwK9rxCe015HAdMIZsIskh2j
 ScnRJfRiMpnDyNtHDDh9+PpB7fZzatQFvjTFswzhwZEWu+y8LcY67da5izNd8+17TP+Z
 Q6WtYwjpAtGMG+Qusp3GzyppAqM+unAmpSTeAw6l+ZGqh7JMNmmkJ/9bhTqqq4b7khsx
 urA0hJSK+p8IuTsVqCCM9ptgO5G0aLq05DOmaG0aG+mf+yQPdOJPy7VmG+RqXc1SDsix
 EFXE40Za4+0eUlvz+nKkGMc+vopbAzDaOP4HSHuXS3RWce5boZLoTNKjAJYJbSYOhue7
 X73Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:dkim-signature;
 bh=jl2ZjLFIQu/gMEu9w1BX2wi26nihMl9VYyUnvXuHXwo=;
 fh=5U2TeAM6w3E/qMVmPCCTsXGpXFFIzaEpZ50I9OgsRTg=;
 b=Fkb/wLhbBXAUMzglge3y77jOnRtSeF9ddeu1Hzci1Axpqe3vn5kE/IF531qxpmMmRk
 hx062VMjR/wQiSQJ5htmsj+gOC1uEKtKAnXl1nZ3HCIrXi3Y9Ma+BmpEvn5EfUsGzBYP
 1GfytLYb3pYNDpfM9rhrOLZCIMmHYOSMsWH5EW+tWEqwEgRQRv6MJ9kxLfDxkAh2MbQ6
 xwsRI75qr64Abv66DnwCWWmWz8WWW2XF0fBGM9DdVu2g/MEEZaBOZFMgOmnQifCJvz5R
 PUZTvEQELaHaeCttLo1cek9b4V92il4yKWGasNhW+Sjr0ydMwpHtEXLg6bI8gfaH1CCh
 2DTQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793981860; x=1794586660; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=jl2ZjLFIQu/gMEu9w1BX2wi26nihMl9VYyUnvXuHXwo=;
 b=lDM2dpb0kF/Ccr5yYyLlwj5iFHDX06urPLeOoc9uYfVyKTfQV/uLHyspT3U2u8iyGa
 Jl3WzGGc9IsnxW9qc0W5VjljrbpUmGaA/ZqPCMBd1y5F8zG/kCr8vKVwisW3nOwFAgTt
 ACk/t+5bDdnFlePf0z4AD/NtsptMgoeTvvg9YYkaR3ygC1VeDYXKBig4MTKfZVUMmf/a
 4L7/4cGBlD3cSbECZWRBSHycgNeea6lEWX2xhsdw2ZOZU+eCT2A2zvHcOYDSiI0PCHsF
 sV/a8eJBjmhnjD33DBzbEaeXY+ikaRYyirqfmfAoOyifZpgLkR8riEUJ807oKgwdM75w
 DbsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793981860; x=1794586660;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:reply-to:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=jl2ZjLFIQu/gMEu9w1BX2wi26nihMl9VYyUnvXuHXwo=;
 b=oKYgwQdha67q3g6gyRLp8zHmgkOmgKdgHlwo/7JFm0g1hw/nLFvwb5kHNwa5APlaud
 mmzezr7NIUgv28yEjBieyu+p4//m7TF1AxZTceBK4/1vEkaWfT8C+DZUhJvm3cJLVy6u
 Jp8LnwJUfvPXaonM5/ynhPy+P5EO6c68j+AibdBEiZ11BSDEMw0IVFJ1llgqXeIxTgsA
 Rc9tzxTG5MfNIWWVt/jUF8NHuF9FPKSENgL/hoeNIaUfDGyuwACu8y9oI86OIP9YaEaS
 0iKShtXGae8k32yRejbxfUPx407o+qjM9ty3hpKnoKQpadE+COtL9gZ/D0knxBPFwDWR
 5AYA==
X-Gm-Message-State: APuU4Z9UvqsRLArDWxJDiOlef4iNVmzgIXzONnC7cbafG1ZFZoGHruBn
 j77kMNhocBVX3uwy8kRcbDT1jirlFk5DHMz3AWkCNj+PMiGmZz8giJ56v/ctl/QQt+mky3CLBzk
 lWz/zficWoM33bVptHdFi7qimRQZFYbU=
X-Gm-Gg: AYBFou2fdSqfcZwiqVAqAE5m3PGyoqJQ0J5er3Vz9BKp5TpafzquPtFHMCp54ZU1d/N
 EQsnBqUmBeYjRhhWu4mDz9Z2+7m35M8fJ2T7FgCIjxbZVhPuPPOx/n07UEzJRNfisTNdI3yUjC/
 bWXnceEghenup4QgZs3891bfwfv2lONsEo0R4VaMc0a9xa5iP5J/2JRiaYLYn1JvRFbtIsxd3ty
 SSxOIvVOEa0D+GDgFOZ0YLP6BKcyPauUGbm9Bwrdy6KkUzJ79Vw70wsbRQz/3cUBHDEx9509xiu
 fXGztlOFhvJpPZq9WFN5pb9Iu7xb/Q2B/iDI57Wv9sNkXoYUNAPPPN+ImbFeqZy/9RbR7vHhWRK
 dloFRU0DevUXQnmaps0JPewyCfheFRPKVvWne
X-Received: by 2002:a05:690e:a49:b0:679:9310:6581 with SMTP id
 956f58d0204a3-67c035d441bmr3865366d50.23.1793981859576; Fri, 06 Nov 2026
 08:17:39 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261105190346.1539-1-luoyonggang@gmail.com>
 <20261105190346.1539-3-luoyonggang@gmail.com>
 <au31_UZnVUErwhKi@redhat.com>
In-Reply-To: <au31_UZnVUErwhKi@redhat.com>
From: Yonggang Luo <luoyonggang@gmail.com>
Date: Sat, 7 Nov 2026 00:17:23 +0800
X-Gm-Features: AclHuK_uVfF1zKJl1bSUKNOpG42lm0mjUhy20LfdEvXcPz4mjp99baDz2BkxI2I
Message-ID: <CAE2XoE8Mrvcv3Nhwyq1XHOk36go=H+9ZYBD=HicPW4266-=j=g@mail.gmail.com>
Subject: Re: [PATCH 2/5] target-info: add target_mask_selected()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Philippe Mathieu-Daude <philmd@mailo.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=luoyonggang@gmail.com; helo=mail-yx1-xb12e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: luoyonggang@gmail.com
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Nov 6, 2026 at 11:45=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Fri, Nov 06, 2026 at 03:03:43AM +0800, Yonggang Luo wrote:
> > Return the QEMU_ARCH_* mask of the selected target. System mode
> > returns QEMU_ARCH_ALL until a target is selected. User mode returns
> > that target's bit. Tools return 0.
>
> I was wondering if it was better to have system mode return
> 0 or QEMU_ARCH_ALL, when no target is selected.

Tools return 0, so only an object whose targets are
QEMU_ARCH_ALL is accepted. Any other mask is filtered out,
because 0 AND anything is 0.
System mode returns QEMU_ARCH_ALL until a target is
selected, so every target mask is accepted.
User mode always has a target selected, so it returns that
target's bitmask.
Tools and system mode need different values so the two
binaries can be distinguished. 0 is tools. QEMU_ARCH_ALL is
system mode before a target is selected.

>
> I guess QEMU_ARCH_ALL (or a mask of all arches that are
> built-in to the bniary) is a better approach, as it expresses

That "mask" is a subset of QEMU_ARCH_ALL. A user-mode binary
still contains every bit of QEMU_ARCH_ALL, so the subset
cannot replace it. TYPE_INTERFACE and TYPE_OBJECT are
registered with QEMU_ARCH_ALL. If the "mask" is still a
generated macro, registering them with it filters them out
for some user target, or object.c has to be compiled twice(user/system),
or we need a stub variable for the mask. That is far more
complicated. QEMU_ARCH_ALL has no such restriction.


> that the system's current state is capable of targetting
> any of the include arches, while '0' conceptually represents
> the "no arch specific features" scenario for tools.
>
> >
> > Signed-off-by: Yonggang Luo <luoyonggang@gmail.com>
> > ---
> >  include/qemu/target-info-init.h | 15 ++++++++++-----
> >  include/qemu/target-info.h      |  9 +++++++++
> >  stubs/meson.build               |  1 +
> >  stubs/target-mask-selected.c    | 13 +++++++++++++
> >  target-info-def.c               |  3 +++
> >  target-info-qom.c               | 10 ++++++++++
> >  6 files changed, 46 insertions(+), 5 deletions(-)
> >  create mode 100644 stubs/target-mask-selected.c
>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> this patch looks applicable independently of this
> series.
>
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

