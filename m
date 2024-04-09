Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A4B4CD128A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 21:30:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruJ2M-0007vO-7q; Tue, 09 Apr 2024 17:29:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruJ2I-0007uy-Q8
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 17:29:47 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ruJ2H-0005qh-1x
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 17:29:46 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2d8b2389e73so10831301fa.3
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 14:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712698183; x=1713302983; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=SbwaFZX33WXCaG3llpXj7h3ccdMSPDC5uOIkJuTERGc=;
 b=KBMg5tHBckWH/q2vO+4za0ereXbQjRLQ26Jqjk2FbVkOUGlCRliCxSmYakKcMBKe2D
 XIv6/FCVgNjOZ4JCWrFz2cnym8C2Bm0ezKAAFuMC187pYsVNjsMu2qyy+K7cijL1hxRQ
 6bUotuFsylf7+ZAGEQDt4VhVCnHvVC46PMGADJNxTqNukCROvn70opwuwZbIe4fh9m9G
 UZiF2qG8Q48O7i+9JKqFstBXRXcb6611Gv9k3byy7AkquhDixidI62YMmI7zOqonK7i7
 JFrrqTwgkbEB7RrJwEm1m8lxEosJaQ8aKOCs98RT/NuBROVzg4qZwnmCNorrYVlRTWmV
 Usrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712698183; x=1713302983;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SbwaFZX33WXCaG3llpXj7h3ccdMSPDC5uOIkJuTERGc=;
 b=DvQCh+NuOoajQprN053NgRzkbsT835wpIe2yTASZTViPpHAIP6ZRb2vzkVZSRMlB4g
 gYHftH9TPGFwHE7LT4/d6O9+00VyOumAU6F/mJSoKuJQMCxPnYLeFrWFoL1hB+VYGYL/
 afjyuvKQUhQc6pA5/Fl2aWBft22xOWi/VQ2hoyYIwh6X5xnW1M4+sXtJA35t5OJnJLMe
 DMzNY17btFF7BCN2g1td4K2GqdqcH+7iNTI6zWWJO1+mgqJcKoYN/y4Ao0ACe4LPzPEV
 RQ2zHW4E+sJokPeOCYRkSMPUN4q7h130AiouxLynCqtfcSTzzl5tKeKxrNTf6bLegtfM
 AEHg==
X-Gm-Message-State: AOJu0YzLjNwSWc79+9P9UsF+HSXj5kZ7fIaRpbJnJNKeRhzVtH6vy9kb
 TuJhBc7bngRg4PpXwvTNxPRdDH6Ob+RA3UnzNK1WZlG/gujVnR0tJFD+i03V29+3gP1nAH5rmvK
 yZS6nH2Yy8mwGigU29sgaT3GNc5EXCNq/gtZXWg==
X-Google-Smtp-Source: AGHT+IGxtYA9e3RpqF6tlPpVKz3cut7q7i5Z2aTIQCV8SYCb5riTzY53VuQAXFWIzUX0O1FwDZrGmw59N4HVLu268Rs=
X-Received: by 2002:a2e:730a:0:b0:2d8:658e:7e9f with SMTP id
 o10-20020a2e730a000000b002d8658e7e9fmr656830ljc.39.1712698182674; Tue, 09 Apr
 2024 14:29:42 -0700 (PDT)
MIME-Version: 1.0
References: <20240409162942.454419-1-kraxel@redhat.com>
In-Reply-To: <20240409162942.454419-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Apr 2024 22:29:31 +0100
Message-ID: <CAFEAcA_FNv_BY+4ZGEq95KhUtGAG_0zYcHMfbyjVjRyc8rh0DQ@mail.gmail.com>
Subject: Re: [PULL 0/4] Edk2 20240409 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22d.google.com
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

On Tue, 9 Apr 2024 at 17:29, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit e5c6528dce86d7a9ada7ecf02fcb7b8560955131:
>
>   Update version for v9.0.0-rc2 release (2024-04-02 20:59:43 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/kraxel/qemu.git tags/edk2-20240409-pull-request
>
> for you to fetch changes up to e3404e01c7f74efdc3440ddfd339d67bf7a8410e:
>
>   edk2: rebuild binaries with correct version information (2024-04-09 18:21:23 +0200)
>
> ----------------------------------------------------------------
> edk2: fix version information, rebuild binaries.
>
> ----------------------------------------------------------------
>
> Gerd Hoffmann (4):
>   edk2: get version + date from git submodule
>   edk2: commit version info
>   edk2/seabios: use common extra version
>   edk2: rebuild binaries with correct version information


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

