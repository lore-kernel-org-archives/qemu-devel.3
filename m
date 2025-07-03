Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA82AC83F03
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Jul 2025 12:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXJOt-0001CY-7Z; Thu, 03 Jul 2025 08:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXJOW-0000yi-Lx
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:50:34 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uXJOP-0007fo-MG
 for qemu-devel@nongnu.org; Thu, 03 Jul 2025 08:50:28 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-70f94fe1e40so10945377b3.1
 for <qemu-devel@nongnu.org>; Thu, 03 Jul 2025 05:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751547016; x=1752151816; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=w+T9JHMDfq0eVANfUnn11mY1JTc6iS4QNE+cWfX90Ps=;
 b=MPDh509ORIaKUeXnK/UIO5/QfuFdVYGiFpXDojXHb32NnQbH4884e7//aik6zi0UTk
 K5eZWxuQQz0Yjb+AFly6rJ2/Ii3hCjHYSoR3Ra1hgif6k3QANdltMvf95lFOzlMpfgx3
 8TqLw2FKU2QYB6PsgikG93eVeHEytp2pfNmW5CrjUF6y5EOwTkRnvZPrh1/USSfIj23c
 FQF/bOkz62Jg/LGeA5MuO1QB6LxhOanxITVl5jIZpLCO8wYkkp0JxavQo18fyzDWodT8
 vzF1g85vhrEZrz1bvf07CtRfgw60NIWh3tCAXOOPGj8KhTwm+V7cEzGrzDGRS4pY3f5J
 rhBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751547016; x=1752151816;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=w+T9JHMDfq0eVANfUnn11mY1JTc6iS4QNE+cWfX90Ps=;
 b=S9tkLScFkxhXJutOetyIlu2k4prMC7WkmzoVBHZUvyduawsic+cK3Zhr8tUubdtY37
 33ohj96EmHCNgoAbfly/kaA0NWvu0eBP4YmAVgn+qSUJEyXgLzhm3MvhmZ/vUFMguwsc
 HhSOjKxtdE734G2SRYhZULAglgBtoA07EWOd3Al6QYdgI+6Wkksf1V2dscQRD6qODCyD
 d9McFcDd6yVBPaINvxNTbw5taOtL3HkXl91gT1q0dWDkg4HayMgIWKtwaA02djYHV7wX
 gjTm1vo6Hgsx4dWATFY7jdgq09xPIAVrmIHqMB2LafrhQO8p/VWTBLve8MoGlOV0Ub2T
 yf8Q==
X-Gm-Message-State: AOJu0Yx8z9+Bsj7eS7UphFymdS4qIiDR6aik6xp7GtHiuA+XlLJMDWxH
 eMKpvKoYVJlMdEvxbGwOZFoRYsu1ggsoeCpliWSpIianKrIa+KsFLSrHqw+QdCXEkKVBld5Frek
 o4gDSulETfXE0IAYtex1YYITdW7Pbesqi2IRrvOXyvg==
X-Gm-Gg: ASbGnctu1vGPu06OrSp9103HHgYYfrUftMHHhOesNGehqF4YqFZw+w9yfJV4Y/WIEgS
 Ty+vANHgwP1BW3Ik7tNPC9FkLed0gm4vZ9gzIjYLQHN9dBz8ZpuRUp+cfHl6aNGkWJEkan8cOtv
 0zEju7ygNrfV2fPm5xPvkUIIDFmN4DJMVJGCoG3AAv3aFldcPsshPQ7EU=
X-Google-Smtp-Source: AGHT+IEwQJ4579ipImkoAJ8OP1rEiku092kfViaGI3hbMkWbBrqhVsUhyqEphbbQZKJzqJRsahd36E4jqYJueAcecsM=
X-Received: by 2002:a05:690c:fc7:b0:712:c55c:4e5c with SMTP id
 00721157ae682-7165d123328mr26407197b3.5.1751547016704; Thu, 03 Jul 2025
 05:50:16 -0700 (PDT)
MIME-Version: 1.0
References: <20250702123410.761208-1-richard.henderson@linaro.org>
 <20250702123410.761208-97-richard.henderson@linaro.org>
In-Reply-To: <20250702123410.761208-97-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Jul 2025 13:50:05 +0100
X-Gm-Features: Ac12FXxaOsYAJdDxtulHWX8wP1YoH3ZRSy4BcR25okZTlUPoJ1ed1_inAx3vHxo
Message-ID: <CAFEAcA-Z82KKRDSX=8+oO=YjwvPk0oHt2SLOvKRbH9exnE3bMg@mail.gmail.com>
Subject: Re: [PATCH v3 96/97] linux-user/aarch64: Set hwcap bits for
 SME2p1/SVE2p1
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, 2 Jul 2025 at 13:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

