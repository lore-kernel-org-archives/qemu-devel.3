Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18D83CCD184
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Oct 2025 02:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v7lpn-0003Ce-0N; Sat, 11 Oct 2025 22:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1v7lpk-0003CN-33
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 22:29:16 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1v7lpi-00039z-9r
 for qemu-devel@nongnu.org; Sat, 11 Oct 2025 22:29:15 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6364eb29e74so5654146a12.0
 for <qemu-devel@nongnu.org>; Sat, 11 Oct 2025 19:29:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1760236150; x=1760840950; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=kPdHNrdBvirF2XCVKlYe3wMWqYSLncgB7JJirp8dSSA=;
 b=FY6YWn1x1K/nkQBkHp0l77YWsS3gdEK/8/2bflWs6aZV+XynWO+JiQ4RY1zrOsAEjb
 TOld/Vqj9khVhrUMXsHDibA0xB3/ku34oCtxXeN2rfLKo5wnkoh8FEcyNda3paqRB719
 wcZbimiS1gO8craSSVQswOYKHtFyYxGuCNEYm/7MLd06wi2funthYlBRQhJuDaiI2mjA
 jMljQUifANGMxGssk24F2D9y1cOW7qAYGQq+0Dtfoixn+4iTjwRuVgXMpqU3VKP60LOj
 t5I/sMIytuhwfiuwT3WO7c+Ub761CFGIsSH0RGeUc0fs1DE0u7WkW3NUs3C0opzc2txU
 CLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760236150; x=1760840950;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :reply-to:in-reply-to:references:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kPdHNrdBvirF2XCVKlYe3wMWqYSLncgB7JJirp8dSSA=;
 b=BgX5WMtYqr8WBfMfmSuN1Q0+nfEZih6+YKNnUMGvPWtJXXL/VVxTH4aK9URcfH+AQf
 hJCMQ7bZEqiHIEVCEPtMaP3Qo1jI1WyTz6reA7OAfFrpnMlUfxngdO31Ql7xPmXElhNk
 OCCu4w36duYen9B7gcDaktgpLsAx+jmVp3IcnWuhOFOolep0Yan2fIcZSTTUKGXwMwWb
 4Au/64C9pK0K2HVtx5y9ml3sSPwAmTWCg0YyhpztvtZossXyQ8hZgEPJ+1NWUtwPwUil
 HM8zsAh5gu6F+TX8hmHrRvrNECrBZkK4HYgC+t5CSgMUPsQ6sP4nlo2D0QP1k8A4fd1u
 X8yA==
X-Gm-Message-State: AOJu0YwyF1V/IOXrEsYilZoiPoerCXSPBywunVXUC7RJSmr2Rz7c5+ne
 LRX5Rr6ejg9fHrjIZ3eraGsqww7BHXK4YnL0I8C0ksJzI1GZYVqpPm2zdqVYz5apGMRG14EvZuR
 48r6UkBWJLjBcbbBZLt+Q7zgmk9ByJ7w=
X-Gm-Gg: ASbGncsrRHoKePHiEaE/IoGnYPaqrEIXOjCR0B5s2YN5Oie5pAuATV3W/PrFI98Hb4D
 S7n/7oNBY8PQb4fAFAhfnnWh6lcQWh+ZZJdSF6b/u26BlVZ9X+wMvzGJVT+BzyoNwNcLXsspDxJ
 61Pxz3xJszGplvXAsIaxeTDpvU7UoiFsnjxDhvHooFOQ3MqvcAMfyWoOsmlC1RUlFDnossrHB8K
 GT3/dnh62W88ulgRc+Bl/L4ug==
X-Google-Smtp-Source: AGHT+IH/ukQfvdVsV7YHpbYMnfOYE93Zll0U4H8IoxKiDocXfKnvXI+SuLB4WJvJALnl9dGaGsUMjPrxEEtf3BqusVo=
X-Received: by 2002:a17:906:ef04:b0:b3c:8b25:ab74 with SMTP id
 a640c23a62f3a-b50aa393c32mr1871030166b.10.1760236149880; Sat, 11 Oct 2025
 19:29:09 -0700 (PDT)
MIME-Version: 1.0
References: <20251010160545.144760-1-berrange@redhat.com>
In-Reply-To: <20251010160545.144760-1-berrange@redhat.com>
From: =?UTF-8?B?572X5YuH5YiaKFlvbmdnYW5nIEx1byk=?= <luoyonggang@gmail.com>
Date: Sun, 12 Oct 2025 10:28:58 +0800
X-Gm-Features: AS18NWDHA9bPiQxy8OOYhRCiog90QgnYdjjp33do2fhuHdsq6ncPtl1Lo7f6fg4
Message-ID: <CAE2XoE-QgRZydYk44eO-Ops5jk1uzosyiCwpomTfBaPf1DGgtA@mail.gmail.com>
Subject: Re: [PATCH] gitlab: purge msys pacman cache
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, Michael Tokarev <mjt@tls.msk.ru>,
 Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=luoyonggang@gmail.com; helo=mail-ed1-x531.google.com
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
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: luoyonggang@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Sat, Oct 11, 2025 at 12:05=E2=80=AFAM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> For the Windows msys2 CI job we install many packages using pacman
> and use the GitLab cache to preserve the pacman cache across CI
> runs. While metadata still needs downloading, this avoids pacman
> re-downloading packages from msys2 if they have not changed.
>
> The problem is that pacman never automatically purges anything
> from its package cache. Thus the GitLab cache is growing without
> bound and packing/unpacking the cache is consuming an increasing
> amount of time in the CI job.
>
> If we run 'pacman -Sc' /after/ installing our desired package set,
> it will purge any cached downloaded packages that are not matching
> any installed package.
>
> This will (currently) cap the pacman download cache at approx
> 256 MB.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  .gitlab-ci.d/windows.yml | 1 +
>  1 file changed, 1 insertion(+)
>
> See a test job with this change, plus a find across the msys
> pacman cache, showing the cleanup effects....
>
> Before cleanup:
>
>   https://gitlab.com/berrange/qemu/-/jobs/11679136531#L34
>
> After cleanup:
>
>   https://gitlab.com/berrange/qemu/-/jobs/11679136531#L1126
>
> diff --git a/.gitlab-ci.d/windows.yml b/.gitlab-ci.d/windows.yml
> index 1e6a01bd9a..6e1135d8b8 100644
> --- a/.gitlab-ci.d/windows.yml
> +++ b/.gitlab-ci.d/windows.yml
> @@ -87,6 +87,7 @@ msys2-64bit:
>        mingw-w64-x86_64-pkgconf
>        mingw-w64-x86_64-python
>        mingw-w64-x86_64-zstd"
> +  - .\msys64\usr\bin\bash -lc "pacman -Sc --noconfirm"
>    - Write-Output "Running build at $(Get-Date -Format u)"
>    - $env:JOBS =3D $(.\msys64\usr\bin\bash -lc nproc)
>    - $env:CHERE_INVOKING =3D 'yes'  # Preserve the current working direct=
ory
> --
> 2.50.1
>

Reviewed-by: Yonggang Luo <luoyonggang@gmail.com>

--=20
         =E6=AD=A4=E8=87=B4
=E7=A4=BC
=E7=BD=97=E5=8B=87=E5=88=9A
Yours
    sincerely,
Yonggang Luo

