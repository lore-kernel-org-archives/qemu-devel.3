Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E74D9C54798
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 14:59:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1riy9z-0001kh-GW; Sat, 09 Mar 2024 09:58:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riy9w-0001i4-1I
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 09:58:48 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1riy9u-00023s-A9
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 09:58:47 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-564fd9eea75so4175312a12.3
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 06:58:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709996324; x=1710601124; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=diit0Jne5BuXGwmiRfpcSH7qAT67LsprBBw+6NlU8II=;
 b=pTlz+ZH1wt3HnHNUNRCrDOEkSU7bq4srfGniEP/6DNEINrDCawgbuBMmQttNTzDS3H
 WYle64oamUyXdUkoh+lpirKbieS1IRAmTrgfTO5p6tT/NoHFRgi2Mo2yvGabk3vb4yyS
 GlNiWHbzRxb9P8D/6BddIqOCxIsPfeotY2kpXh9TtjjXI3yOU2IBf+xAMZqT+nVydGCj
 cq3vZ78gMr+4mkTck5qXasRdcpoig0tUWh2z/YbuNX1f7jwmMrqHf3nfWjLDfGQWkwml
 6xYmL8t0oB3W79WcLGGMSgrY10RCLaeeamqF74BhT7sKp9l0hjAtmUo9rYNDN8FpywrH
 WVBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709996324; x=1710601124;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=diit0Jne5BuXGwmiRfpcSH7qAT67LsprBBw+6NlU8II=;
 b=TKyYPA7gjDb3dWxtRkIkXTdCKkRMJuBv/kqL4GcSCeNa/dyWF+ATEGqPU0RNy1jUUr
 GHaXldsyzrunguoyXcKapCE8yNxNWiRjbFetdtLsyHigsolk0pKJ+BNti5hhsKeiVJpY
 cGuN7u3ybXk6E3yKulAZLJmUMziKN6T12akJSG/A1ha93dtgBg4K7oZ3bcrxijcQGMg6
 dn+Ro+JZ/flgun2rpI5muo8WIHVI8pejgnGA3TuGWEd8MNFdnQuxIDmjqYBLGkZUlmnd
 sEFv5BdygqtZqdfXDIQtYU9zRSgIEjY3veIcnbdFU7lzaipSyYsDtAYmsmFoMv/14NxN
 Y34w==
X-Gm-Message-State: AOJu0YypuedzQANuCQN4edXa6F4Aw/LIpuVvz8IvDamD9KVWnX0KR3uY
 YgWLD8gIyl+1UxDanW2QDjXG0839gsOBLsVFylehUQaccxM6R7zK9pIruclckDuYY3xBEQ/7Fqi
 ZhLvtb9/faGYCxO0OIweUt7Jy1ZKXWOEWaynpSw==
X-Google-Smtp-Source: AGHT+IEzpa1IokZmKAF5ZocDxYose1vpvbPRu61lbZUg7qtXF3/MVZNJQuf/UwiETssvQmTB3HLHDQ5AKcpFjrWkaIg=
X-Received: by 2002:a50:baa5:0:b0:567:a2d8:ca92 with SMTP id
 x34-20020a50baa5000000b00567a2d8ca92mr1588421ede.23.1709996324177; Sat, 09
 Mar 2024 06:58:44 -0800 (PST)
MIME-Version: 1.0
References: <20240305110608.21618-1-philmd@linaro.org>
In-Reply-To: <20240305110608.21618-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 9 Mar 2024 14:58:33 +0000
Message-ID: <CAFEAcA-mBWcFBRwbQm6n3Vc4PtwEso3nCtf+2yD6VdWOUThDxg@mail.gmail.com>
Subject: Re: [PULL 00/12] Cocoa patches for 2024-03-05
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Tue, 5 Mar 2024 at 11:06, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> The following changes since commit 52e7db443bd8d233acc3977bd150bdadb62db8=
6c:
>
>   Merge tag 'hppa-latest-pull-request' of https://github.com/hdeller/qemu=
-hppa into staging (2024-03-04 16:01:33 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/philmd/qemu.git tags/darwin-20240305
>
> for you to fetch changes up to 5576663208b7c31766c580520df506375d00103e:
>
>   ui/cocoa: Remove stretch_video flag (2024-03-05 12:04:41 +0100)
>
> ----------------------------------------------------------------
> Darwin Cocoa patches:
>
> - Add 'zoom-interpolation' to smooth scaled display with 'zoom-to-fit' (C=
arwyn)
> - Set clipsToBounds on macOS 14 to fix window clipping (David)
> - Use NSWindow's ability to resize (Akihiko)
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

