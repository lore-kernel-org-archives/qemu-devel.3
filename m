Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D86CAC59A
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 13:22:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy988-0000Gb-8I; Mon, 15 Sep 2025 09:20:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uy983-000085-N3
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 09:20:24 -0400
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uy97q-0006kP-4m
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 09:20:21 -0400
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-3df726ecff3so2291844f8f.3
 for <qemu-devel@nongnu.org>; Mon, 15 Sep 2025 06:20:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757942404; x=1758547204; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tPtRKiIFi33S9+Y+4Q75JN86dN5SfMk6I761gsc/7+I=;
 b=hCTh96/CXgeszA+PKCDhFPMJponWPmek/drfxHoiQ8LEzYMky0YK+ByVjSXPOP8Wdf
 eC0Gf2dWiIwY7ZKdNTnjfwQXrPjDF/eDYQ5QFqsM4cI4V0I6QKtRrKF5FcGBujyzBaTz
 Dx+EmXaIlq8lv76VzrLmYJw7CDvzh80JTTHq38UJ/vgckM+kJ9zpwm3KkbNgq1+eSD24
 P3U/JzaV5/NhCpFmq+6fwIl5KkgWgedKfkVv+6CL2U0NRFbwX0mfH4wPh/93Q//aZo8R
 Y4Rfhfcwg4jvMsj2UdBSfZxZ+ok3tywxF0JP93oo7eLo2EFrqv5RAGiDtljcYZBJpbzg
 uK/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757942404; x=1758547204;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tPtRKiIFi33S9+Y+4Q75JN86dN5SfMk6I761gsc/7+I=;
 b=Q0z3NrSvH4FcsnkhE0e5XEdM8RUHGyd48b+madY4QZgHElMlIVtuYqOHeSeQQGztP+
 ffozyomIryIpWL+FeaQ0WAg2I71PVkJVud4vrgn4n99UNMVW6C3Zlbk5eDjnLFsLtiY7
 toaZoH+ZP7UHiGU/0m1tHkfYMfj4f17E6e+vjCvxBDrpXmEcA3qTwb1C6ltE4X5itMfj
 bwauEKgEYAcXVL/bcXgDPAk+ZQHGbLFeOxKfId651Ss++JdlLPraYB0YPH7nFQbnQbVW
 NOEXEydxCgeKwwgH187C3IQFQUCtj74jeIKmYXPirJ41l6E3QfowZz5FJr729FLo2S3k
 +oVQ==
X-Gm-Message-State: AOJu0YwiLdZxsWhXbRT74CCt9O1K/MwLfoByHs95rOFjEj8TtZLGO5sv
 FypeuLI1pFXPN2l32mvC1/lYkT5ti3qEvWCSb6LWczl+6h4UV+49ujBjqFDlU2l2sqUbqYWLo5V
 fWIW5Qj0=
X-Gm-Gg: ASbGncs1a/wqkrFS7mTXhzxVPLzFAdJweeAlwb9kxaXXQout4IeRXFM3bBTBYU3RWM4
 vOTDH0QLyN0xCelj48mY+OGJh0oCzTCFeAJpm7Jf+Onso4RzJyVp0PluiW0m4hrIKJeAdcqh/yE
 HEYfAbFUDuUfXbRk9KhDwaKh/j4Y2xeU7cioRh7/T4I1qh+DS8cgeHfIYhrhB+zzfjb8TYFL4Ra
 mtgo3M3w9pW7rwNCa2i+KAOgKEoQb/6Zbyx1HN14R4y6Efuel4e6zQjjBOpUOwsscQKOdsRMtLK
 z7E6w10cketUCnehdKt/YHAIh69mIEPMSF9epEmomhIixD6bB+Rz/AbYNfkYHhbbuVs7m50F2i2
 gPTb553v8KxLZqOpIc22PMWycnXtdsVyHwQ==
X-Google-Smtp-Source: AGHT+IGSuPnkwokPfDpkECZVumBI6kO+AKAaBsOn/n6xDV78BLYx90AGXbR2eqrXpMagN8irLW0i4A==
X-Received: by 2002:a05:6000:438a:b0:3eb:5ff:cb2e with SMTP id
 ffacd0b85a97d-3eb05ffcfdbmr1772234f8f.29.1757942403923; 
 Mon, 15 Sep 2025 06:20:03 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3e9a591a41csm7183521f8f.7.2025.09.15.06.20.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Sep 2025 06:20:02 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 8050F5F867;
 Mon, 15 Sep 2025 14:20:01 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  qemu-stable@nongnu.org, Michael Tokarev
 <mjt@tls.msk.ru>
Subject: Re: [PATCH] .gitmodules: move u-boot mirrors to qemu-project-mirrors
In-Reply-To: <aMgD83wAjZMurYnI@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Mon, 15 Sep 2025 13:17:55 +0100")
References: <20250908141911.2546063-1-alex.bennee@linaro.org>
 <aMgD83wAjZMurYnI@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Mon, 15 Sep 2025 14:20:01 +0100
Message-ID: <87segnq2da.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Mon, Sep 08, 2025 at 03:19:11PM +0100, Alex Benn=C3=A9e wrote:
>> To continue our GitLab Open Source Program license we need to pass an
>> automated license check for all repos under qemu-project. While U-Boot
>> is clearly GPLv2 rather than fight with the automated validation
>> script just move the mirror across to a separate project.
>>=20
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> Suggested-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>> Cc: qemu-stable@nongnu.org
>> ---
>>  .gitmodules | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>>=20
>> diff --git a/.gitmodules b/.gitmodules
>> index 73cae4cd4da..e27dfe8c2c1 100644
>> --- a/.gitmodules
>> +++ b/.gitmodules
>> @@ -15,7 +15,7 @@
>>  	url =3D https://gitlab.com/qemu-project/qemu-palcode.git
>>  [submodule "roms/u-boot"]
>>  	path =3D roms/u-boot
>> -	url =3D https://gitlab.com/qemu-project/u-boot.git
>> +	url =3D https://gitlab.com/qemu-project-mirrors/u-boot.git
>>  [submodule "roms/skiboot"]
>>  	path =3D roms/skiboot
>>  	url =3D https://gitlab.com/qemu-project/skiboot.git
>> @@ -27,7 +27,7 @@
>>  	url =3D https://gitlab.com/qemu-project/seabios-hppa.git
>>  [submodule "roms/u-boot-sam460ex"]
>>  	path =3D roms/u-boot-sam460ex
>> -	url =3D https://gitlab.com/qemu-project/u-boot-sam460ex.git
>> +	url =3D https://gitlab.com/qemu-project-mirrors/u-boot-sam460ex.git
>>  [submodule "roms/edk2"]
>>  	path =3D roms/edk2
>>  	url =3D https://gitlab.com/qemu-project/edk2.git
>
> Are these the only 2 repos that are still blocking the OSS program
> approval checks we need ?

There are two biosbits repos and the s390 tools as well, see:

  https://gitlab.com/qemu-project-mirrors

but we don't reference them as submodules.

>
> This is pretty ugly, but unless upstream u-boot is willing to add a COPYI=
NG
> file very quickly, I'm not seeing better options, given that GitLab's OSS
> Program approval is driven off entirely automated processing of the
> COPYING/LICENSE file contents.
>
> If upstream u-boot.git added a good COPYING file, we would have to handle
> the u-boot-sam460ex fork by pulling all of u-boot.git modern histry into
> u-boot-sam460ex.git and ensuring the primary branch was master so GitLab
> sees the COPYING file. The QEMU sub-module would still point to the
> original old commit with the sam640ex changes we need, lacking a COPYING
> file but that won't be a problem.
>
>
> My only comment is that if we go down the route of this patch, I think we
> should aim to move all read-only mirrored 3rd party stuff under the new
> /qemu-project-mirrors group, so that /qemu is exclusively for code which
> we actively maintain ourselves (and thus have control over licensing)

Sure - I just wanted the minimum to get over the renewal.

However I can't hit the button now, something is stopping me and its not
entirely clear. I think maybe we need a Tax ID.

> Every single active stable branch will need this change too, otherwise
> they'll be unable to find the submodules we moved.

Once this is in it will be easy enough to apply to the stable branches.

>
> Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
>
> With regards,
> Daniel

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

