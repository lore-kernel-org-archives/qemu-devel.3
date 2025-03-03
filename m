Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C84C282C5
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Mar 2025 10:38:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tp3BO-0004Vs-OZ; Mon, 03 Mar 2025 05:37:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1tp3BK-0004VP-VU
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 05:37:54 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <christoph.muellner@vrull.eu>)
 id 1tp3BG-0007fn-7a
 for qemu-devel@nongnu.org; Mon, 03 Mar 2025 05:37:54 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5dca468c5e4so7528264a12.1
 for <qemu-devel@nongnu.org>; Mon, 03 Mar 2025 02:37:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=vrull.eu; s=google; t=1740998268; x=1741603068; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IWsvP4Est0D00X1+iHeKuTEp0GBJk+uTvXqR44SSYzw=;
 b=sjjm3gCShZQ2Y3KmnKiylhOF/2x+U6eY0qiGhuop2E7IYqrFtyxFkX9mtN/MSIjGTT
 9A4bz74xbb4tRqcmUZupqskra2l+wIS7TdcAO3lH3w76UHpN+yNl0lynFS+5VKjCMB0Y
 AGDRqw3ty0PeIJKojYtpuLBYdJmKaRn+4FASlocYNz3bfDdedBNeBa6+SBhu94fwZJkf
 4DuvC3aHpuSNbRFMqoS8nOypFMUAOAelmqiN6ItCnlqtAZrasfjTiC6ofp8x+SNnmppz
 4s3w3L0rVYjpzYvmOMpicwhOjBFvbYufzy7cbqYnNJjNJlk4Zl8cf2PDzSUjzOeeWbbm
 aH2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740998268; x=1741603068;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IWsvP4Est0D00X1+iHeKuTEp0GBJk+uTvXqR44SSYzw=;
 b=m9UVEri2Led+9oD1naey6HNveCRs/NDtocIQA+Mn/POhjuDj6hqPSM2F81ZQEF5ArH
 btsczOgtB4BVN2z5X0mTOPcd7C5f5bEsbze2/lbuDZKLyKc9Zu5rC8hcevg1yaeO0gQp
 SDnPDdvqEzeef5mSeMEhgvuEw7GJsaMkNLzNN1LcuDEofu/9pZeQ5LsnPhsks7AGrICA
 g9gpuTwQSt/8pZ3wmtpz5gAO2eB59xlK7fQK9gdKOLghhiktdPF2id1VulRbBWUZOri+
 AWeogz9nzHItfcZjqT42K/4ov2ejjia289fIWRNR096G9uomMoqRgXcQEkIigsiVVUkS
 m1zw==
X-Gm-Message-State: AOJu0YxEwZNWksmlZv6K2Khrj+G3/kVpW7HJRn5Crc/0r3UVGb7xAmOL
 XhUlH5+D3wpEgmMKRrz2qN+oUQgIs3iSk6jKES6asyBDPhehH09/aquP+d4qr/Vrv2nHZVi/fCA
 /VSzQ44lXLUsiAIyLWDh38tc8eCwEQcRXWprYFg==
X-Gm-Gg: ASbGncuFD21ByRu9YGTH8RDBro0DlX7IkJKAfEm2aaKmTdInvrT+2Wr5SC7M8wDN1cW
 r24M6QqJ9pIlgUFL1JKUbzt9cxoNE32ZhR40wAoqzLaKDLuZmAhxStdXkn8DB/I1p8dBq7NLYj9
 78sLw+K3sThfWB63BNfxL2ogTLtLA=
X-Google-Smtp-Source: AGHT+IE+HwDQ65bo90jmzgdRBNthRqYlWzC2CGVqjoLZ0RQfKal78AO4TFnOY8ElajtCcUyHmLFDj7STiquAxZrfxSo=
X-Received: by 2002:a05:6402:2711:b0:5d0:aa2d:6eee with SMTP id
 4fb4d7f45d1cf-5e4d6b6fcf1mr13907321a12.26.1740998267830; Mon, 03 Mar 2025
 02:37:47 -0800 (PST)
MIME-Version: 1.0
References: <20250303100927.3443321-1-christoph.muellner@vrull.eu>
 <CAHtqR7WAa09mwhO1QeQb9b7NR==ajLnuDC=L=NzYHNSS-6kjZQ@mail.gmail.com>
In-Reply-To: <CAHtqR7WAa09mwhO1QeQb9b7NR==ajLnuDC=L=NzYHNSS-6kjZQ@mail.gmail.com>
From: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Date: Mon, 3 Mar 2025 11:37:37 +0100
X-Gm-Features: AQ5f1Jqq5EUbs-jVu5Ma4c-O7Xiqkv9niW-76ZTDsORok2mdSk7tr_HL8gAcgzw
Message-ID: <CAEg0e7gHD+=YipqOrv_TBuMuZ3zxwtmERHVt0g8ZfiuwUK6mUQ@mail.gmail.com>
Subject: Re: [PATCH] contrib/plugins: Install plugins to moddir
To: =?UTF-8?B?5rGq6bmP56iL?= <wangpengcheng.pp@bytedance.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=christoph.muellner@vrull.eu; helo=mail-ed1-x532.google.com
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

On Mon, Mar 3, 2025 at 11:24=E2=80=AFAM =E6=B1=AA=E9=B9=8F=E7=A8=8B <wangpe=
ngcheng.pp@bytedance.com> wrote:
>
> What about plugins under `tests/tcg/plugins/`?

It feels a bit odd to install something from the tests directory.
If certain plugins in tests/tcg/plugins are of general use (not just
for testing) then it might be
reasonable to move them to contrib/plugins.



> From: "Christoph M=C3=BCllner"<christoph.muellner@vrull.eu>
> Date: Mon, Mar 3, 2025, 18:09
> Subject: [External] [PATCH] contrib/plugins: Install plugins to moddir
> To: <qemu-devel@nongnu.org>, "Alex Benn=C3=A9e"<alex.bennee@linaro.org>, =
"Alexandre Iooss"<erdnaxe@crans.org>, "Mahmoud Mandour"<ma.mandourr@gmail.c=
om>, "Pierrick Bouvier"<pierrick.bouvier@linaro.org>
> Cc: "Wang Pengcheng"<wangpengcheng.pp@bytedance.com>, "Christoph M=C3=BCl=
lner"<christoph.muellner@vrull.eu>
> Currently the built plugins can only be found in the build directory.
> This patch lists them as installable objects, which will be copied
> into qemu_moddir with `make install`.
>
> Signed-off-by: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>
> ---
>  contrib/plugins/meson.build | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/plugins/meson.build b/contrib/plugins/meson.build
> index 82c97ca0f5..c25a1871b7 100644
> --- a/contrib/plugins/meson.build
> +++ b/contrib/plugins/meson.build
> @@ -14,11 +14,15 @@ if get_option('plugins')
>                          include_directories: '../../include/qemu',
>                          link_depends: [win32_qemu_plugin_api_lib],
>                          link_args: win32_qemu_plugin_api_link_flags,
> -                        dependencies: glib)
> +                        dependencies: glib,
> +                        install: true,
> +                        install_dir: qemu_moddir)
>      else
>        t +=3D shared_module(i, files(i + '.c'),
>                          include_directories: '../../include/qemu',
> -                        dependencies: glib)
> +                        dependencies: glib,
> +                        install: true,
> +                        install_dir: qemu_moddir)
>      endif
>    endforeach
>  endif
> --
> 2.47.1

