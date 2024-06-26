Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B04CC27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 14:10:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMTLS-0004n8-WF; Wed, 26 Jun 2024 10:09:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sMTLR-0004jk-7k
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 10:09:57 -0400
Received: from mail-ej1-x62e.google.com ([2a00:1450:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sMTLP-0004Lp-G5
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 10:09:56 -0400
Received: by mail-ej1-x62e.google.com with SMTP id
 a640c23a62f3a-a689ad8d1f6so901137966b.2
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 07:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719410993; x=1720015793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=Kb/rUJvAJjCHGS7f4Ys34/yH37oh1jmL/xUtcv7u0aA=;
 b=fOQYq9YuwrIGj/a8TshMYKNyeXdSWeWa0nJbgHgFq2I7Uw84jIiWWieatWKyO+Ed7S
 BjdNDOmASdmyk7jqbAbHK9aLyRBUu1VdSlAQ+NhT2fPoFg41JOoh/uWpxdIXzE62ZQVf
 kT24IgnAxxD1ShJKPo3dbiLIx7YuJQUjIwdkv6MGu/wYQKLDpAtDuDBn4tzSogSAOMgQ
 jASVBw3nBaJhIHttrPWizTL7dONxnpj7uZcBZ8TPmhRSnJxvMfHS6u4DbzRS2M5jV7A7
 Yr3wepdDEh5fuoky5OZBpzG/blJfY8L9rRDQwE+j1ntK8RihuKGoiC6G/AjwQur2cTM6
 uKog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719410993; x=1720015793;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Kb/rUJvAJjCHGS7f4Ys34/yH37oh1jmL/xUtcv7u0aA=;
 b=u8uXlp56hhHfDpcYf128MVG2vd9RVdiFCUjoOM2NufKQP18HamuRIUWO/MaE0wXIkI
 6HmAjv7qc46OvFUn9rPIe6Aij179cnAYw8WRymAhyXfDHqT1VUdpdbALaQnDk7v/hkMR
 wvnrvWq8U7dqtEQVqX11nQ0iJG+GoQ7eeY2KOhcITcOQjjFiQqImfz/wwFj6OwgZMqNL
 zTATpunlOWgvR+w3idM6yTeYOaGhmkwNW78QtLdCiiHW4221aewidavrU+9vU70p/D8z
 3hW0vIYV9IBxvjSXA6j9Wm68NcvrJ9F/tocLPf6s+8KFO/Bjsli0izu0WNTyyah9FwA2
 F4+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaor3Xr+wZjSL7fMitqTFszWCvxYvlvavuvoNSFij0lwS+RthkAkGme80+fo4RE4SfwgiYVwtW6GjsVmkRroFnjScBZZo=
X-Gm-Message-State: AOJu0YwqZEuCczhzjDcoh0OLZWqgEUxUjJFFnnchSqxFxurL6WMpkD8Z
 MvtU4KUmMo8gnIr/l/QbPXMlHrIvbt5BWw8HyJOMcluRJWdhfa2ywUNXjKbIdhs=
X-Google-Smtp-Source: AGHT+IFfmp/bHv7cTb8g3Qa5opZnZhApOMLKK0xsMQ0EQ7i3RzqOG7TFlg0k1bMaGKZh8pjnGLTBDA==
X-Received: by 2002:a17:907:d401:b0:a72:46f3:ffc4 with SMTP id
 a640c23a62f3a-a7246f4005cmr754374666b.26.1719410992654; 
 Wed, 26 Jun 2024 07:09:52 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a72451fd535sm427734666b.149.2024.06.26.07.09.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Jun 2024 07:09:52 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0EAFB5F8AA;
 Wed, 26 Jun 2024 15:09:51 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,  qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 0/6] tests/tcg/aarch64: Fix inline assemblies for clang
In-Reply-To: <20240626-tcg-v1-0-0bad656307d8@daynix.com> (Akihiko Odaki's
 message of "Wed, 26 Jun 2024 20:26:21 +0900")
References: <20240626-tcg-v1-0-0bad656307d8@daynix.com>
Date: Wed, 26 Jun 2024 15:09:51 +0100
Message-ID: <878qyrpzgw.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62e;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62e.google.com
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

Akihiko Odaki <akihiko.odaki@daynix.com> writes:

> Unlike GCC, clang checks if the operands in assembly matches with the
> type in C. It also does not support "x" constraint for AArch64 and
> complains about them.

When are the test cases ever built with clang? Is this for Arm on Arm
testing only?

>
> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> ---
> Akihiko Odaki (6):
>       tests/tcg/arm: Fix fcvt result messages
>       tests/tcg/aarch64: Fix test architecture specification
>       tests/tcg/aarch64: Explicitly specify register width
>       tests/tcg/aarch64: Fix irg operand type
>       tests/tcg/aarch64: Do not use x constraint
>       tests/tcg/arm: Manually bit-cast half-precision numbers
>
>  tests/tcg/aarch64/bti-1.c         |   6 +-
>  tests/tcg/aarch64/bti-3.c         |   6 +-
>  tests/tcg/aarch64/mte-1.c         |   2 +-
>  tests/tcg/aarch64/sme-smopa-2.c   |   2 +-
>  tests/tcg/arm/fcvt.c              |  20 +-
>  tests/tcg/aarch64/Makefile.target |  12 +-
>  tests/tcg/aarch64/fcvt.ref        | 604 +++++++++++++++++++-------------=
------
>  7 files changed, 331 insertions(+), 321 deletions(-)
> ---
> base-commit: 74abb45dac6979e7ff76172b7f0a24e869405184
> change-id: 20240624-tcg-bf8116e80afa
>
> Best regards,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

