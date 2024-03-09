Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0ADEC54E60
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 20:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rj32a-0006TY-SF; Sat, 09 Mar 2024 15:11:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rj32Y-0006T4-LA
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 15:11:30 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rj32X-00021U-1k
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 15:11:30 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5684db9147dso134368a12.2
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 12:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710015087; x=1710619887; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=EX6MwxbpLOjlLYTjPU+oc0L2AGUTJwSiha1n1nEX3Cw=;
 b=ok/DguVgJzWmfj/OlY5jJLo77RBNRQ/g18QG3x7RLg17I+w8ny8rb4tfTNDd9YG/TK
 jdrmhEr57axSYmLxdVcUjCWQmI47AJnHLGuusOgaja6US0szrNraXG66GM0pavnYeaRu
 Ygweedt54r4JFe6aaQeRF33SFaRoIvTpVwf6RpF/WJHHyDm55HqJzmllnH5l2BqmtqFi
 PERHEJWBfYR/uBKBnTYUQJLn5L25IANEgQO3l6OPmUvmP+CVzZaAtcL+zPS0+xDrW5hB
 hsy+S5Tv2XSQEV0yob8QCb09MPAgbo3z0wHk6svsm1yxh9N5JLEd+I6LyaOVm8b0UC90
 UYtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710015087; x=1710619887;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=EX6MwxbpLOjlLYTjPU+oc0L2AGUTJwSiha1n1nEX3Cw=;
 b=RYVpcdi4M6F3QsdFZVYPAv4O89VkwsbvTIrvy/GZXAQl3pyxpQTGtYZxz0FAeGrIr2
 0cjgccPdmq5u8+AIcBG3Q4Hjbvfb8lpOTqCs4IgzSEfj+AlO2TvzjJDZzVJIuQBW5bg6
 Nltfxff1wy7HHIidgvCfT9lEyLwbdoh7XkxZwvCY5ZeK8unBUH2rTXJEZv1X18/vhtIs
 TDqSPFQZNVRm5UuUgAYVBsKf/eoR5hSjsjpZhpzAtx0LPlgSIgMdP4clUWvlR3CebwK9
 i2YXVtNKj4f9ilG14YrfsX43VqR6m/l7atBDxfdUmWTHhY2+b4qgpuLJw9XBLJQLsaFa
 +CjA==
X-Gm-Message-State: AOJu0YxOP/uGmzpcskNFXyWzAirab8I2A9LvgpCOzSh9IZlEPPsZVers
 MOU+9Q/TqZiZ9wBpMg36LeM08WOj702S7hpkscxAJ4kH1Vp7fImmqlBB14A0J1L4++6/I1X7snD
 oKr2x3OCY6x+0BCTHULx/FUSKDb4fyFzFJxzZutIgrCePgetC
X-Google-Smtp-Source: AGHT+IEW+RjwfjJZE9X5pW3xalrlltu4W+vu9RyIMC/Ww6Y+ZqHFYhqv+XzHimAU+ysgjbVoMoJeXBzy4f4FA0OazWc=
X-Received: by 2002:a05:6402:5c3:b0:565:b934:3301 with SMTP id
 n3-20020a05640205c300b00565b9343301mr1595825edx.16.1710015087412; Sat, 09 Mar
 2024 12:11:27 -0800 (PST)
MIME-Version: 1.0
References: <cover.1709916836.git.maciej.szmigiero@oracle.com>
In-Reply-To: <cover.1709916836.git.maciej.szmigiero@oracle.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 9 Mar 2024 20:11:16 +0000
Message-ID: <CAFEAcA8kd6SRfq8381YyFbytGEq19kKkr4aDjTyO6z72CD0Xjg@mail.gmail.com>
Subject: Re: [PULL 0/3] Hyper-V Dynamic Memory and VMBus misc small patches
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Fri, 8 Mar 2024 at 17:03, Maciej S. Szmigiero
<mail@maciej.szmigiero.name> wrote:
>
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
>
> The following changes since commit 8f6330a807f2642dc2a3cdf33347aa28a4c00a87:
>
>   Merge tag 'pull-maintainer-updates-060324-1' of https://gitlab.com/stsquad/qemu into staging (2024-03-06 16:56:20 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/maciejsszmigiero/qemu.git tags/pull-hv-balloon-20240308
>
> for you to fetch changes up to 6093637b4d32875f98cd59696ffc5f26884aa0b4:
>
>   vmbus: Print a warning when enabled without the recommended set of features (2024-03-08 14:18:56 +0100)
>
> ----------------------------------------------------------------
> Hyper-V Dynamic Memory and VMBus misc small patches
>
> This pull request contains two small patches to hv-balloon:
> the first one replacing alloca() usage with g_malloc0() + g_autofree
> and the second one adding additional declaration of a protocol message
> struct with an optional field explicitly defined to avoid a Coverity
> warning.
>
> Also included is a VMBus patch to print a warning when it is enabled
> without the recommended set of Hyper-V features (enlightenments) since
> some Windows versions crash at boot in this case.
>
> ----------------------------------------------------------------
> Maciej S. Szmigiero (3):
>       hv-balloon: avoid alloca() usage
>       hv-balloon: define dm_hot_add_with_region to avoid Coverity warning
>       vmbus: Print a warning when enabled without the recommended set of features
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

