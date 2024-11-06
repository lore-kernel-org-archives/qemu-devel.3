Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93E08D59F55
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 17:27:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8jo5-0005hp-Fa; Wed, 06 Nov 2024 12:27:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8jo3-0005hS-H1
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:26:59 -0500
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t8jo2-0002R3-13
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:26:59 -0500
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c9c28c1e63so8281233a12.0
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 09:26:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730914016; x=1731518816; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=ZZ0ptxwGUii7tzxRhJatvT1+2EbnJIzEJz6zzlVRkX0=;
 b=SzbQeIw3Bc29Ru8Z0vrYf1VP/ZJIZNJ+Rkg+5MbDjulVl12NKxcbKhNP5r2f33eB6X
 G65QZ+Sg3u/LM0kw79wh04KIQAK2gCkuxfpGRvITgzxzI466hKkmCrLuogPAJNkOHwRj
 94KWL1p6gL/AHuZQgtY6NQHY8pbqn9DWQcxr8H/EHBIgry/OVpjPVPceF0wiJQ4FGX06
 Zq/7lPgHWZxNdqs7cSis3D9l3Iez0nU+3GEeMMPk69JL1zW1EpGEH8BtGAZ/GO3vSzb0
 JdLt/2shiNZBQKTqaYwXEVz8Da0UddxojiyHhmnQMk1Hcc/uIm72/82vV6isVBAezGLn
 0Ldg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730914016; x=1731518816;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZZ0ptxwGUii7tzxRhJatvT1+2EbnJIzEJz6zzlVRkX0=;
 b=bK0gXj/tdUk9nu4/lUY10eqFXqioEvYNCCtB3nOpj+SpqkYbbjcy4+Eu89AJo4oBjO
 9h2sc+r4uQEw2hBGedrVkJpOg24khZzjY6Uz0IB6dgDWfuPCLCkw3ZuPc8FviQR9k/YW
 BIWIL6CkYtOeE1yMXrWJ2PUh+Qt1qNt/ZXTaedbwEod9txNEUktcWZzEDqyMi08phVpJ
 y5Hiez5zQpzoAZUlOuMiFglXetgBBZwKGxqRrNYJqUs+6lXRmtlkMlh5th6m5KLD6yKx
 LkaBPwO5alw+Hgn7thyb0VBDp7YsnBwIUdH/tQIWK2ULolbeGOyo+33ayPcAVr7MRJLy
 4AaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXfmM44ZlBzuu131qmzQkFXr0wbayo0qpV9rZDfUTG/L6FUYSRBi14BwUjIcnY6a4im5MZDqYUD1GUu@nongnu.org
X-Gm-Message-State: AOJu0YxI0hA5wb8tCIPtYHVv2BBj84rS5Q+W9TX1ynI2qon7PEgE5A1K
 MOg6lwKBHiRTzAIxnLeLCWSOsoCO+w0tmzKnUaH7HZImt1sBj0XKEkQmub8WYnTdZfDnxAEWuVR
 3rGeNcWYcX8sw7l+MGfMhvYV4nbnS3BAZrpFTcg==
X-Google-Smtp-Source: AGHT+IGyBvgzDImkx88PE6NC1I5JYk9fQR9MA5MXSPlxis2OupzhtjQq0auV8VE0fxuv64uUBAaE3rfZYWUTKmWg5d0=
X-Received: by 2002:a05:6402:34d1:b0:5c9:6ae4:332e with SMTP id
 4fb4d7f45d1cf-5cea967a284mr19777592a12.8.1730914016400; Wed, 06 Nov 2024
 09:26:56 -0800 (PST)
MIME-Version: 1.0
References: <20241106170946.990731-1-thuth@redhat.com>
 <c233a6b5-bfea-4d5e-9b1f-5bc3a467e17d@linaro.org>
In-Reply-To: <c233a6b5-bfea-4d5e-9b1f-5bc3a467e17d@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 6 Nov 2024 17:26:45 +0000
Message-ID: <CAFEAcA-MVg2EU2cKJz+drZp3=GBCPJXqbP7iNimg8fs0NYfhOQ@mail.gmail.com>
Subject: Re: [PATCH] tests/functional: Bump timeouts of functional tests
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Wed, 6 Nov 2024 at 17:21, Pierrick Bouvier
<pierrick.bouvier@linaro.org> wrote:
> I noticed by --enable-debug in configure is a combination of enabling
> checks (enable-debug-tcg + graph + mutex), and deactivating optimizations.
>
> Would it be worth keeping the optimizations and runtime checks instead?
> This way, there would be no more "timeout" issue.
>
> I'm not sure which added value we get from O0, except for debugging
> locally QEMU.

"Debugging locally QEMU" is exactly what --enable-debug is intended for...

thanks
-- PMM

