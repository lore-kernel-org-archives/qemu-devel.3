Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B71C83F26
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Jul 2025 11:08:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uetnh-000513-Pd; Thu, 24 Jul 2025 07:07:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uetnf-0004vH-MF
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 07:07:48 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1uetnd-0001p6-TL
 for qemu-devel@nongnu.org; Thu, 24 Jul 2025 07:07:47 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-60700a745e5so1883277a12.3
 for <qemu-devel@nongnu.org>; Thu, 24 Jul 2025 04:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753355264; x=1753960064; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=H/9eGEZLtW/sQLAOBONs4PEoJgIKUca9bXo6UHR0Clw=;
 b=ch8fiWz8fcN2amTiYZ5k68WC7G7ey+OAW0nN07SloyLoheOQjokAHEwDiEy+xHSUL6
 IFdYqwFWauK3PVs1WCeqDmqlUUEeWubq/1par3F/uTF6NSKwRxDtu8UZKFIbQFf1CvMe
 jYT6b9mTX9Z+WLu3LJR3cZINzPjFyL9d2UASpOFaaax5UVvPogwyZB41fEfbw2qZUFXN
 SFx4Y2C0tucNlyWD2qO5EUCPMH4pdKlaydi+9d77xPSb05c9HXwk/sjhcv4cTbrlT97k
 CRojgPFw3Xz4erurBGemESFDVYs2n3f58tXgQIDcIQnzcgoBf4wpAchTYXwMQ22gqzIy
 qKjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753355264; x=1753960064;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H/9eGEZLtW/sQLAOBONs4PEoJgIKUca9bXo6UHR0Clw=;
 b=YQt9k7Io7L1Lpe1CcmqrYp+OZ7KFrlCKv+pYCdoAXvlezwufivM6A8BZZW/fmfSDjY
 wA9uohBHTfMvJF75WZJRNrMNrdkSkGMxgdbL2ssIDt+mhLpVzv905f4BqW3DA2936TJm
 JWcagW+IS117GwHeztJxnJgyyFuj++/jySgJcX/OTQXFCVUF5MdoX0FWFukir1lZdW8P
 OlF/hklftN/AyIEPbo6sj6LK4vcVlBzMzBfOCBHPxYYtsb9jx/naJ5XuJdwT3zJf8h97
 OJjtrbyrB8g/NrwIWNV3hdUFznybmsOZI8WV12PdTmTjcCmbPrDWYECNdWGFz5Ze05+h
 OzTg==
X-Gm-Message-State: AOJu0YwDI+Ca4Bro9TJGF/6mY8v784Rl/RTKE3RK3J9m1W4mlyRnDLpl
 4xnBlcRCSrVZLHYRjxYUE/dQALHP/RU2pcWS+7LDQu++yp4x+7lwS72tjEIvpt9pkh1G6yPZTUT
 4T18vAb1Ymec49O/xeP4ppg7rQtNyvhuE288jZz8USQ==
X-Gm-Gg: ASbGncssIvwYw2OGKFXOIzBhk+hjiUT1zylgaGuh0BZQ/kn/49xqyKmnLu1dUdHw7RC
 N9ML+N4D5WU+xEmMecwRp8V1h/t8h/bEOEa0/5sTw8LKtXiFGABDYG3/f+UAtPy7sR0cI+R/sC4
 Tyzlb0WPsbonw19eqGaryRcL0wGzpUvHumK02OkU6NYR0E04bFAEheZCbPB+kvryA1lhRC5mSTl
 aLxsg==
X-Google-Smtp-Source: AGHT+IFewSDfQQeeEehis7l9ToR+IdufJkH16ZuwIi++ZVLQ7FnkrgOzQQ7CX2VqvKV1/qPN1M3epGGkCXf/JTS2nbU=
X-Received: by 2002:a05:6402:3593:b0:60c:44d6:281f with SMTP id
 4fb4d7f45d1cf-6149b409f56mr6578929a12.7.1753355263568; Thu, 24 Jul 2025
 04:07:43 -0700 (PDT)
MIME-Version: 1.0
References: <20250724105939.2393230-1-alex.bennee@linaro.org>
 <20250724105939.2393230-3-alex.bennee@linaro.org>
In-Reply-To: <20250724105939.2393230-3-alex.bennee@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Thu, 24 Jul 2025 14:07:16 +0300
X-Gm-Features: Ac12FXzyQzVRbNGCv1puOicQN9F2kncNPjm6qcHf8xKctdqyagylh7WSv60vtY0
Message-ID: <CAAjaMXazPf0MtOFdN1kZ+rmxpeta16+zDVTfveB9iL3UJA_viA@mail.gmail.com>
Subject: Re: [PATCH for 10.1 02/13] docs/system: reword the TAP notes to
 remove tarball ref
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ed1-x536.google.com
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

On Thu, Jul 24, 2025 at 2:02=E2=80=AFPM Alex Benn=C3=A9e <alex.bennee@linar=
o.org> wrote:
>
> We don't ship the tarball and users should generally look to the
> distribution specific packaging.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/560
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
> ---
>  docs/system/devices/net.rst | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
>
> diff --git a/docs/system/devices/net.rst b/docs/system/devices/net.rst
> index 4d787c3aeb0..7d76fe88c45 100644
> --- a/docs/system/devices/net.rst
> +++ b/docs/system/devices/net.rst
> @@ -21,11 +21,17 @@ configure it as if it was a real ethernet card.
>  Linux host
>  ^^^^^^^^^^
>
> -As an example, you can download the ``linux-test-xxx.tar.gz`` archive
> -and copy the script ``qemu-ifup`` in ``/etc`` and configure properly
> -``sudo`` so that the command ``ifconfig`` contained in ``qemu-ifup`` can
> -be executed as root. You must verify that your host kernel supports the
> -TAP network interfaces: the device ``/dev/net/tun`` must be present.
> +A distribution will generally provide specific helper scripts when it
> +packages QEMU. By default these are found at ``/etc/qemu-ifup`` and
> +``/etc/qemu-ifdown`` and are called appropriately when QEMU wants to
> +change the network state.
> +
> +If QEMU is being run as a non-privileged user you may need properly
> +configure ``sudo`` so that network commands in the scripts can be
> +executed as root.
> +
> +You must verify that your host kernel supports the TAP network
> +interfaces: the device ``/dev/net/tun`` must be present.
>
>  See :ref:`sec_005finvocation` to have examples of command
>  lines using the TAP network interfaces.
> --
> 2.47.2
>
>

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

