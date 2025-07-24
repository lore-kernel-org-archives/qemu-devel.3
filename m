Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D90EDC83F1A
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 11:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uetz5-0007zq-Fl; Thu, 24 Jul 2025 07:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uetyt-0007v8-Cn
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 07:19:26 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uetyr-00075R-1b
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 07:19:23 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6148e399effso1471463a12.2
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 04:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753355957; x=1753960757; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uySEDISY/7xP3DjJltKwZW0CJA5uBFX1JiHRNj9TeP4=;
 b=vsYXHmyuaq17fH5s5UU83ePCJ25mCnpC7rvvksnXpCCm9OnArbOBk9TLbmmsuFm0Bd
 5mZaH9IDkahvTRnnIz/2JlkpUSIh2pYyBejLbF6E8kIm3CNlQwvlYFFDzwF01aTkzerm
 wdnyOCWE12Zis0QavSX4yrEDOadTHBDVULBxyZgUKUiPAVxn0hSuHAq6HdOo9dfl8Y6I
 NR+1dN4Ttk5J+UXksK/MXKh1GOHHXOcjkOeVQD8CQE2dkUE/aHvYhucVU/Cj1J5XZoHy
 0Q32Fm6YINVQ01hWS7y0umQzzUirUYI9aPGD8FzO6WjdIPSgUL65o10Kl8lP3dgS+t8z
 DTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753355957; x=1753960757;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uySEDISY/7xP3DjJltKwZW0CJA5uBFX1JiHRNj9TeP4=;
 b=PLOAFThGVUkQ1aDWBfu/XsjOTlAWWvDgm5UBf48N9IjDdTaTH8fTGMH0q/xx7U5xpK
 nEQ+hTc59Mx858rlWUvKlhMrGUwAr5AEjsNWb+rEOJCt0eJaQP6u/7p++lzF4+Iun7A5
 UCVdWcZCzPMTzJwDgLoh/apqkcj5Sys22wDmvyGfKH+imS9GX7zHfuHWC3kYTFSn/WKr
 +XiqOCPlgvh4guh0vv/sF/GIiDK8A05pAvo+Ch9/9qyPj6ADy0qs5GcNdfzOQ7nRUYM0
 HCa24n4m3hHl5Vzjv+k0kpyjfxQSE2a8l5CYHwlO8SrANUu7RWSGREBajzD14qov2EzU
 xMYQ==
X-Gm-Message-State: AOJu0YxEu5kdlDHsDDuqBHXDumkza7WtP6pNmPSK4A+flor2QRsGq9AF
 rbzdyr5Tz55YCjT6rm2lI7INohMYV1XXjX1xgz2+LY8UInFYHLtQVE5i3wd0Nmv41rfVvfhbP8T
 XvNLCwaD8UeUk8cIt9CIXeSIBmGQGEzFF5NCkjfzKz3Tzng4H3HI4W4E=
X-Gm-Gg: ASbGnctDLU1d1hKB3z+HtmkEfd4LKZfzVwT9YmWVVwnqWj0uKcWDyQr+Z8rSbFWV26A
 g8/G7kOHcRZ+WZsnqq72yMQw9yADN5LRFjz62kPggZ9as9udd71fzKK8AZVPm2OhByeT8Ex5xuC
 FMlnJ5Etr6bTgQTbMItxmkTzHu22Urux283xJ+jpm7nYT1zU3MrJYHX0nmOR+gbnllrmj5hxYzh
 5E2yw==
X-Google-Smtp-Source: AGHT+IFqGM8UoqIvgC1FFobZLsSXjBECdLJy5la2W2aO+pTTBLRvw0jU7hAold6fszRRMnaHGhtuP3PNBI0U9vhedA0=
X-Received: by 2002:a05:6402:51cc:b0:608:493a:cccf with SMTP id
 4fb4d7f45d1cf-6149b5a6afcmr5864829a12.30.1753355956971; Thu, 24 Jul 2025
 04:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250724105939.2393230-1-alex.bennee@linaro.org>
 <20250724105939.2393230-11-alex.bennee@linaro.org>
In-Reply-To: <20250724105939.2393230-11-alex.bennee@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 24 Jul 2025 14:18:49 +0300
X-Gm-Features: Ac12FXyxs2PCEMvmdBnh8pu47GL-MSBQ_l_mWXwz0QcYqmyU8bUlxfj7kUJ1IcA
Message-ID: <CAAjaMXa+_8nHGNPzO3PnJsW9ZYVQSTWEeWGOjY1SNZzv-QWBFQ@mail.gmail.com>
Subject: Re: [PATCH for 10.1 10/13] configure: expose PYTHON to
 test/tcg/config-host.mak
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x533.google.com
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

On Thu, Jul 24, 2025 at 2:01=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> This will be useful for making $shell calls to something more flexible
> than the shell builtins.
>
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  configure | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configure b/configure
> index 95f67c1a827..825057ebf15 100755
> --- a/configure
> +++ b/configure
> @@ -1800,6 +1800,7 @@ echo "SRC_PATH=3D$source_path" >> tests/tcg/$config=
_host_mak
>  if test "$plugins" =3D "yes" ; then
>      echo "CONFIG_PLUGIN=3Dy" >> tests/tcg/$config_host_mak
>  fi
> +echo "PYTHON=3D$python" >> tests/tcg/$config_host_mak
>
>  tcg_tests_targets=3D
>  for target in $target_list; do
> --
> 2.47.2
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

