Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FFB8C54E66
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 17:08:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkS5E-0007IE-UP; Wed, 13 Mar 2024 13:08:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rkS5B-0007HS-LB
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 13:08:02 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rkS51-00026T-6P
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 13:08:01 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-5684ea117a3so84791a12.0
 for <qemu-devel@nongnu.org>; Wed, 13 Mar 2024 10:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710349669; x=1710954469; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=84u12z5tBD1ig2wTaFhzjeNfhm+pPyPzjnK+AMDU7RE=;
 b=JIOyQ1NQ0bfwNwAMBm1j8uqeMhEmwS5NUsdSqv/81Q63AJAmC6l/ZVJ3CN9erchDdv
 lqW6HNo7iLggj4yqvPSiUpT7vR5WohkrsxGpFfYjQofMQd6zs5Nl71nyi5asScqsnlFc
 JkGhnqRMwLBwPo2oLdTfvFWyQOqee0Dibi5M5riYgsWAb9roD2RTw58vRT1Ftf/UoTt2
 NZ8cd5cJBCQ9noMAcSI68dvNbOylAyHWP+LLgErHdxmucWlLxT42PRy1Bcn7CTVHqIfH
 meLYsyunnJ3P9YYhaDAN1vpIv9y4rJvGitadhpmjOZJdhEKN5b/p5NWRknSd2R2qLtQR
 KI7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710349669; x=1710954469;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=84u12z5tBD1ig2wTaFhzjeNfhm+pPyPzjnK+AMDU7RE=;
 b=hZk75844y9zUDvRFFmCdFQpNm4WLYF1go6ZrFyD15n5wTQ3igeclIddnJfxyQKosDz
 EaHZ/atuoOokY2/4dYI/pyPG+MfQ8kCAe6Qc5r52DNJ3cm0vSSEm29VrHGujl7IX2zfO
 4oU64rmTiCC8FWZLSX0750WuGmphC4o677upy4jqfneOUuMN4B+ACMuxS5f8IAxsZ7w4
 q50H7xlXeVpWp0IprKJLOkQ0Z82zvAWSNK1glAbWD+I5kMZWmE2UcxWquqFjQN7R1NN1
 t44m0uA4qH/o2lS3laYEyOJSk87fZK94SWtuU/qlC+pMFZJ9CiG3jGyBMgNsD7L+GdYk
 sVTw==
X-Gm-Message-State: AOJu0YwItiPt4ggwDULzFzvLNaUQU2nvBF+PeDeYoG4QvxGiHM89kvrN
 tYj9nDuLOg0u/stXnAj5mdX2LPxrJ67c1axheKHgKUeUb0/lzkd/kPJVASmKdqNBkByo5f7yzl6
 ump9IH8Q9Z/gHOgTdrrWclA/mYN6Jb7uqwCXEB+GfqsJ5mclq
X-Google-Smtp-Source: AGHT+IGbPa0nBHEmW2n6Sna+UByg9TnlQBZiE5Sb4oTZKl5MoF4+VmGuaO13aRe51iroPFLDN5vvlYW1S1yAA2XVSHA=
X-Received: by 2002:a50:d588:0:b0:566:4624:b120 with SMTP id
 v8-20020a50d588000000b005664624b120mr2785751edi.26.1710349669732; Wed, 13 Mar
 2024 10:07:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240313114906.20979-1-alex.bennee@linaro.org>
In-Reply-To: <20240313114906.20979-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 13 Mar 2024 17:07:38 +0000
Message-ID: <CAFEAcA8+dPuJvhB20KBKwW8fNCJ-O8UUKFf-1mKsea+L9LW4VA@mail.gmail.com>
Subject: Re: [PULL v2 for 9.0 0/7] final maintainer updates (testing, gdbstub)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Wed, 13 Mar 2024 at 11:50, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> The following changes since commit 0748129684be2773117b0b8fc3c60161abdb7b=
b8:
>
>   Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu=
 into staging (2024-03-12 16:56:13 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stsquad/qemu.git tags/pull-maintainer-final-130324-1
>
> for you to fetch changes up to 6971998e241d8edc842b165b447f706c05166ae6:
>
>   gdbstub: Fix double close() of the follow-fork-mode socket (2024-03-13 =
11:43:52 +0000)
>
> ----------------------------------------------------------------
> final updates for 9.0 (testing, gdbstub):
>
>   - fix the over rebuilding of test VMs
>   - support Xfer:siginfo:read in gdbstub
>   - fix double close() in gdbstub
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

