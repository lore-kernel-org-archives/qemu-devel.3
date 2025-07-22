Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41BFAC83F1A
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Jul 2025 12:03:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueBhq-0001ZX-Dj; Tue, 22 Jul 2025 08:02:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ngompa13@gmail.com>)
 id 1ueBhg-0001L6-MK; Tue, 22 Jul 2025 08:02:42 -0400
Received: from mail-ej1-f45.google.com ([209.85.218.45])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ngompa13@gmail.com>)
 id 1ueBhd-0001Pb-7b; Tue, 22 Jul 2025 08:02:39 -0400
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-af0dc229478so253145166b.1; 
 Tue, 22 Jul 2025 05:02:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753185749; x=1753790549;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wKchTSFkgT9LHWbhAAmAfGOhLIhg/J0mzwd7ts9T860=;
 b=ZzR6g1nSRNv355f5M9Zhy0KjOISL6gg2hbYmtpgIrcyhhS5nECs4GPPlCeQipk0zpI
 KmkxPowFDI/N0REgUvumcGWuAkBVIrzxWWnsLP1i7nTUwjq58SderP1AxCIo7Xf7SHjl
 6fvOc7okC3uqsImUzPtgJM+iaYaJJA7XEaDAVV7O/BfPBQuFqSexdRMQvy+OQp1GZohl
 r9ypZXRVZp9W367LqXZhFSjsmAGY84xE71Uv7dnHWQ7JL7jW+5ty8aSx509Aie9Xi0lj
 ROD8wQpUZO/yqwBFmMxTeg0oS1Q5DTrMsOWzY9s8oiOdWvDqa9Qsm9ZPIMpvV1AHDhnB
 hfWw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXUsvjgzvxGQnjefR9zgGtC/UVrRwWODmbm8gbcXrNV7GY3I/ntT9FtWddL/NXf04gEkoGieu5z79Q=@nongnu.org
X-Gm-Message-State: AOJu0YwdCN6MdnZzHRkKSWHuWCY/gkCVVGjr8pTDAbf3dLxFzVWmwApg
 8CYCT8+l3blIk+Kjj9Qqz+9vCqL0PaP68P4REYS2ZzPVPS+LvWPq5jvAMPo1ZiMw
X-Gm-Gg: ASbGncvS3NFZ954Q0NPZVsxbsM62sWK3C1DdXrBvyZXN/PyWh/Jl+9QZfhY695eSHsm
 vbfkjJyP7D6wVKUYihWo/r9Wc8Ica7ds11D0JmE21UaMMEhAegySfsgAgGtb8Gd6J6apbuH0Hmz
 KIc0PlKr7IGOEwRP6ua65CFYixCKXGsltZoW3CjGgADP2LbiKG7K4PRzA34uZ628rlrtSO5+V2T
 rYn4Yxm1NtMOpn50jJ4+OUILRI25mZ7557/2Gz02Ue9t3yX2sMkyBI0f20f5qxs8HjDgOm02BR8
 B7cyAgU0DE9LX6L9pKtyamq+R4BUFCudCLfSeZtEeyWh1aulxOdOKFzgyoW6X67sp48TvwtgsRy
 q7Grg0lvznUW9CLYFBrTQ5VatM+FveegjiKT7hA74toqNkTM6Yj1PGyXvry3iAbsfeg==
X-Google-Smtp-Source: AGHT+IFNBQGrS/zbGoS0lzNAME9rd0OKauH9oTXy0cSfc8ZTjR9gLBP4Yqh4DNnE6aReWsJUpfU6MA==
X-Received: by 2002:a05:6402:164d:b0:60c:5853:5b7f with SMTP id
 4fb4d7f45d1cf-61285dfca8dmr19237858a12.32.1753185738149; 
 Tue, 22 Jul 2025 05:02:18 -0700 (PDT)
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com.
 [209.85.208.51]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-612f21073e6sm5036792a12.56.2025.07.22.05.02.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Jul 2025 05:02:17 -0700 (PDT)
Received: by mail-ed1-f51.google.com with SMTP id
 4fb4d7f45d1cf-60c9d8a169bso9244917a12.1; 
 Tue, 22 Jul 2025 05:02:17 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCXR6Yg2rrkyCSHjvCh9ydKCf59WMWnVglkBzI9U1bNuUg1d1WYvZAQanlWxIb0I6/Y6WtK4bO2jqQ8=@nongnu.org
X-Received: by 2002:a05:6402:2683:b0:612:bd30:d326 with SMTP id
 4fb4d7f45d1cf-612bd30d6e9mr16689528a12.22.1753185736482; Tue, 22 Jul 2025
 05:02:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250722083507.678542-1-pbonzini@redhat.com>
In-Reply-To: <20250722083507.678542-1-pbonzini@redhat.com>
From: Neal Gompa <ngompa@fedoraproject.org>
Date: Tue, 22 Jul 2025 08:01:38 -0400
X-Gmail-Original-Message-ID: <CAEg-Je8cctYdMik1+sEM7yAsATvUuOwC0pNzqH80UbHSn3B+Ww@mail.gmail.com>
X-Gm-Features: Ac12FXzjOGfO3BS2nXdgOUOuU-piBWEzMROVxJh7Zrhf87poH4F2UvJ2wz_GoQk
Message-ID: <CAEg-Je8cctYdMik1+sEM7yAsATvUuOwC0pNzqH80UbHSn3B+Ww@mail.gmail.com>
Subject: Re: [PATCH] scripts: add script to help distro use global Rust
 packages
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, berrange@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.218.45; envelope-from=ngompa13@gmail.com;
 helo=mail-ej1-f45.google.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.158, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Tue, Jul 22, 2025 at 4:35=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.com>=
 wrote:
>
> Some distros prefer to avoid vendored crate sources, and instead use
> local sources from e.g. ``/usr/share/cargo/registry``.  Add a
> script, inspired by the Mesa spec file(*), that automatically
> performs this task.  The script is meant to be invoked after unpacking
> the QEMU tarball.
>
> (*) This is the hack that Mesa uses:
>
>     export MESON_PACKAGE_CACHE_DIR=3D"%{cargo_registry}/"
>     %define inst_crate_nameversion() %(basename %{cargo_registry}/%{1}-*)
>     %define rewrite_wrap_file() sed -e "/source.*/d" -e "s/%{1}-.*/%{inst=
_crate_nameversion %{1}}/" -i subprojects/%{1}.wrap
>     %rewrite_wrap_file proc-macro2
>     ... more %rewrite_wrap_file invocations follow ...
>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  docs/about/build-platforms.rst           |   8 +
>  scripts/get-wraps-from-cargo-registry.py | 191 +++++++++++++++++++++++
>  2 files changed, 199 insertions(+)
>  create mode 100755 scripts/get-wraps-from-cargo-registry.py
>

I am impressed how much code my three lines in the Mesa spec file produced.

The code looks good to me and seems to do what it says on the tin.

Reviewed-by: Neal Gompa <ngompa@fedoraproject.org>



--=20
Neal Gompa (FAS: ngompa)

