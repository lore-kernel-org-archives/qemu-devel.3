Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17F75CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:15:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgBo-0002Ze-AE; Thu, 28 Aug 2025 13:13:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdef-0005Sj-Ue
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:31:10 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdeb-0007qX-TT
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:31:09 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-71d608e34b4so8399077b3.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:31:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756391462; x=1756996262; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=vArf32SiwXxLQ2TAHAgK1zZnFcJeUWenVJUBhKAsdsY=;
 b=aHhqbdcbN9S4xKAvZKtr7aBGz+vwS2BGC8WCyAiubuBrO2keQdrlcUdk5MGnH4WrHW
 /bxFuuUmH9ctFiuod+0rEiBEOgAoSQll8uB8tW25KYrxwn6bErLnhIY8G+nb697S2hCs
 Vl/eHTyVtQWgdbm8lptF5txMWQx/Uuq8pWfBP2nn/J8kSweExbgg6fgIrupDjiLhmqp2
 Em1wo3AZPG65U1blgata10qYlhOavZKjS8X60zf893aZv759+g5xElREco2zErSSSVQy
 REuepEw4j/qfx75SiI67y2U3UITGtwGEqwXe9N+N5JBppVEdcnsG4JwVkVxS7WdtJOCf
 s9VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756391462; x=1756996262;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vArf32SiwXxLQ2TAHAgK1zZnFcJeUWenVJUBhKAsdsY=;
 b=RxkEvXe8V6qYinIPPcwcjidt7HhYAX46Vgn7wt1x4++HznzYOtlXIU+FwNtQWOH4tO
 TVTapp1fYUPwhwmk8TZ1MdE7CoHkftoQZoOodDTam1awjFDt5nW0lEH5Kg3hJN7VRzj6
 tvAR+uJjEOHlMFBZjorVNPCHCSljxLlatYE87OlXTGLS1LZbA43FgMl7Iqp5tGIoHWib
 29yByK7eAR4u3vo4Zu+JuIfB+/towmUEcvu5Th7Klb2PgtycMnYYsUWFGmEUCYZ86M9C
 ZrBEQvdLM5fnrhN+7sVoqdty6386AxUryY0WY63fbpGgjSlxJEId8VywSLGdWNq4FR6w
 779Q==
X-Gm-Message-State: AOJu0YyALpw+mrIFGVhh2dCtOzNpzgEDFrpltiD9S+BXa/i5J2F3ygD6
 fbOMAM7WMtL6wCJqpjRgXjIJokeG3q4eBpyymgrY7M77kpPfh37041HiImQ6aQwym5oxaV/MGkO
 yYgEjLoKYTzc7K+K0AC1ZWdaxpjwwB2fFPygdTVTZLeHF09VhIvS2
X-Gm-Gg: ASbGnctHHaR/l4xVVcxbd1C8i5kfgV6rOuoVpVvpCbuNJuTBOCovy0nEEgNag0c1W2I
 eb7byCtiN7en+b35FVMaKoLm0K7RTetEZEUIdjJo/OQV3eG4hkoSIg149tTaDb352pZ8d6ovPfw
 xhhNkefgQYoQGX6opSXiVGJYC9sKXry2fDWVRnwl5iN7nw7Y7PPmY7nyyHhyx+JN+oo1dXU5ann
 IO501cwU68LmD9jwvk=
X-Google-Smtp-Source: AGHT+IG+V8sI4ivGAG55zxAqQ5ZfTO9EIOIVk3IegHPLWmMKCLZAOruMsqS4LGOTIE0IkJvHA967zOVh4JCSHDWZi+0=
X-Received: by 2002:a05:690c:6182:b0:721:30a5:3bf1 with SMTP id
 00721157ae682-72130a53f15mr113123077b3.16.1756391461458; Thu, 28 Aug 2025
 07:31:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-21-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-21-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:30:49 +0100
X-Gm-Features: Ac12FXzgRt1cSD-0z7IRadcW6h-tXMQ4OtyQkrAZe9qevUwyadQUqr_bQQzh2NY
Message-ID: <CAFEAcA8A8_DY7DGEg4uYTCQJuRQwDoa8=3xE0B_eJ4NFEgCp7Q@mail.gmail.com>
Subject: Re: [PATCH v3 20/87] linux-user: Move elf_core_copy_regs to
 ppc/elfload.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Thu, 28 Aug 2025 at 13:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move elf_core_copy_regs to elfload.c.
> Move HAVE_ELF_CORE_DUMP, ELF_NREGS, target_elf_gregset_t to target_elf.h.
> For now, duplicate the definitions of target_elf_greg_t and tswapreg.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/ppc/target_elf.h |  9 +++++++++
>  linux-user/elfload.c        | 26 --------------------------
>  linux-user/ppc/elfload.c    | 22 ++++++++++++++++++++++
>  3 files changed, 31 insertions(+), 26 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

