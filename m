Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0CE94C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 16:07:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBzMB-0007gP-T3; Tue, 28 May 2024 12:07:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzM7-0007aO-NN
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:07:22 -0400
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sBzM4-0008OC-WD
 for qemu-devel@nongnu.org; Tue, 28 May 2024 12:07:18 -0400
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5766cd9ca1bso1404359a12.0
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 09:07:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716912435; x=1717517235; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=UrjMMSZqsXckP1I06/IUCiHBF1/i4AGmVGNEHj0CK4k=;
 b=RoYq1uu2AMfUIiP7Gt/sDY2SO6l7MzYEtwtWFtAq4YK6uK2IhBxvvQ34hoHIJaBg64
 8DH8B4gmw4TLfeOy3t2yz8iJLmxD2BCl77B6YGEUkjwS1dIMYrfx6yKNi4mY3Q53Lxio
 PdppnhII5Q3Y+QJdvSK4X+lK+G+vMQX9dbygBBYo5kpDZfVuuJUCsewIIGdVBfehbS+v
 q4vlqh1LGUTCmAyX8WRvOnrPWX6wsSc3brwKknTe6csCgmiYcm9DnvLt9T4Fz2GiaRgI
 Fphlc+KwWv1IQ7ukRLJmT66WCV9FpaXX4H1NvAju9qx8l5wgyMJeihLJiJkvdGScM1e9
 fEJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716912435; x=1717517235;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UrjMMSZqsXckP1I06/IUCiHBF1/i4AGmVGNEHj0CK4k=;
 b=wqKITq8MgOGViQqx44/h+6ZngHqOFNuF+KofmS+irGMxJ7G+6JE+uVB6UKcOsuK/w1
 2rsgX+JEqm6GCxfvtJ7b21kMGz/QjnG8Pyi5fM8O2dl5mDlwT9NdrIMss4Q9VMB1zjp2
 +z/TmSVTWrLo1iPmjo7c3fYbH5C0wyCnA1z/cH3H5FCJvfplD/ti9ZITpeOOq77xXVGT
 lVmKbdb3ZOodBBykfXlxsPdJk+kNIo05FuRQOgPn6IzaHbH+SVaYe5nteBGJZ+ot4DlK
 OqGUnTAnak4xPAT9z9zqTElAJgeeYJRvwxhKbymTqEkrjr1ELFyn5ARNrQsttZ/o3wCh
 rf3g==
X-Gm-Message-State: AOJu0Yy36NzJErNjwYwO1iRU7CeYIpDkcPW9bIxZ1HEsbeyNU7/o4PH8
 BdFUymVwW0TUyLAq3ASxEMuXvRn6QPGQhrBf9JSRiCfR9Wqnw8j4ix9z1UhAn/JSBc14ahwVN3e
 B1fsVC5IGJvd5Ajcht8MtU3J7ECMeSjleIoqW3xiJXXkNIL2Q
X-Google-Smtp-Source: AGHT+IEyAjmI6zKQjt/cPUlDFpJBmoRbs5Mp6YwWEj6Al73/5X+HJffbn4pL2ictQXfZAPzZRjtJ3zeHqFfmwT0gYaQ=
X-Received: by 2002:a50:d510:0:b0:574:eb26:74a with SMTP id
 4fb4d7f45d1cf-57851972f47mr10261592a12.21.1716912435654; Tue, 28 May 2024
 09:07:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240524232121.284515-1-richard.henderson@linaro.org>
 <20240524232121.284515-64-richard.henderson@linaro.org>
In-Reply-To: <20240524232121.284515-64-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 28 May 2024 17:07:04 +0100
Message-ID: <CAFEAcA_g4LqnDk=QDep37LNkma09Mhe=51z4zVqqB4Z4Q7qpmA@mail.gmail.com>
Subject: Re: [PATCH v2 63/67] target/arm: Convert MLA, MLS to decodetree
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
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

On Sat, 25 May 2024 at 00:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/tcg/a64.decode      |  8 ++++
>  target/arm/tcg/translate-a64.c | 77 ++++++++++------------------------
>  2 files changed, 31 insertions(+), 54 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

