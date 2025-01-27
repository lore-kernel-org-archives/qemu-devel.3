Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B272C02188
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 13:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcPbu-0001Wh-AC; Mon, 27 Jan 2025 08:57:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcPbs-0001P7-3z
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 08:57:05 -0500
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcPbq-0007gu-RF
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 08:57:03 -0500
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-e455bf1f4d3so5959293276.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 05:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737986222; x=1738591022; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=J9hySiJuW7zJ5/L5A5U9aPxWXWt3qzANoVEFjcetJ50=;
 b=wpiYnuGKylzY8lgWFFF5QO9WQsgPaxCE2/QhCFmUbmN4dVZE/WJSLOfM82G5RFYmlP
 kCBlHUOFzreBYku4T60ofSncNPbtWOoK+OPPpVkfh7+Zwaxi2f+Ag8Nz6wGQmvbXRSIh
 srSrFEBoLdELSrMsK3Hqa5pKCIOkA1+iU6guDoug+u+oHuVAgDTncioWFGyMb0oWvw2a
 a4mnxHmwOcBcybhPVv+4HzS0RUZqrJJiHOGtWJnEd/DM8qYn5zMgPpnWe3EFBiN90B72
 WMIfa9gTDUINmWgf6bKFruLw9aSQfR6jL6W/I5Tbfjn8L2lhTeUiaqUy1XuEb3wRwlLI
 bMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737986222; x=1738591022;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=J9hySiJuW7zJ5/L5A5U9aPxWXWt3qzANoVEFjcetJ50=;
 b=emPewPTkei8YdiLlIH/nCDDZodEiPkkSq+Yo7u80g39GmWw+JVG3Vnm0yeYLz88S8m
 1zqORBULuiDA9qpp3o42L8ao+AG63lmG5NdCO/ed49hJPh589ijx6w/E+U/9IOm0Q3vZ
 u7hDj3CHcswCOQuLpgdE7Y385eWZMtbdnp4uwOButilN96LHY7pmM8N/Ji/hCVLVCzUt
 1SF9DbVRHhWQW+2tj7YdNT8RC5WOSS9Y0HGXLttp77kLGbZRCk3zrEX33oS9UxXZZGRu
 LRX979VWPzfhhmC0gnn8Dqi5Kk2dXIwBgRKgbASTQzlQu5Pp2LAD2eUgD/7XfruuAmj9
 vFQg==
X-Gm-Message-State: AOJu0Yy/ZtS0HvPHFrT4IEEsApm4GrMvTIvljQpPr+Tc+Hk6aRl9dog6
 K9H6n0H3SYQTg6RWNjvrDIBNHPr61acyKXRNcuOp/2AqzNrhZWloPhFN0SRXJ3CtqtJLNL3H5OR
 JAs1U/HxK3P0Za9Mte4eWZItrrFeyZhmUWZCAmN6TlqhI5S/X
X-Gm-Gg: ASbGncs93xlFb5mIHbREIjC7bcb48PEWcsMRnmNexvRqlkNcKK+pehRkRmNOcp8GcSR
 8C2T1iXFw9Srgk5ZoMoURzoLbkYZcTT39Fwb+F2R/XgLQvRuYmo+gtuz4U7fxS1k=
X-Google-Smtp-Source: AGHT+IHFrQYPWvTaV+2vP+pYwbkHsPgojgZNyrFyavKxUNnc4sOx0bCEeNPLs6qUrxoNVrd+DmPUNPrY3D6UKLxnYDw=
X-Received: by 2002:a05:6902:20c6:b0:e54:ab05:4505 with SMTP id
 3f1490d57ef6-e57b134b2c7mr29199377276.44.1737986221878; Mon, 27 Jan 2025
 05:57:01 -0800 (PST)
MIME-Version: 1.0
References: <20250110160204.74997-1-philmd@linaro.org>
 <20250110160204.74997-3-philmd@linaro.org>
In-Reply-To: <20250110160204.74997-3-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jan 2025 13:56:49 +0000
X-Gm-Features: AWEUYZlmoT3WQRw0heBu9ghSDiwVJGz2t8pz8SKoBOzMap_wgGnTpDk_-No50qI
Message-ID: <CAFEAcA9pbN649LT0GrYv9j0AKQK++S6yFyvp6G_CgTnRhNr38A@mail.gmail.com>
Subject: Re: [PATCH 2/9] hw/arm/stellaris: Constify read-only arrays
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb29.google.com
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

On Fri, 10 Jan 2025 at 16:02, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/arm/stellaris.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

