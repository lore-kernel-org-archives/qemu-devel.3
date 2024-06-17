Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B27F9C27C6E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 08:40:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJ7tk-0007h7-Ad; Mon, 17 Jun 2024 04:39:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1sJ7th-0007gK-Qu; Mon, 17 Jun 2024 04:39:29 -0400
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ardb@kernel.org>)
 id 1sJ7te-00006L-BJ; Mon, 17 Jun 2024 04:39:29 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id A4CC5CE0FC9;
 Mon, 17 Jun 2024 08:39:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3BD1C2BD10;
 Mon, 17 Jun 2024 08:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1718613558;
 bh=JOLp1OjjbV8DtKvJbienrS7UP2dtEUeiE1WSuWxmQnM=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=JiKi6mAAnuAW4sCZO+hRETI0CAJXxkRH8EZugvHO9jbth9J+DhAGzdzlnOyay+w+k
 u72PCinSEVOSVr9p4vUBg4ZgJDyWF19OqVW6olLTxet1inizhuJogJZGeeJk4pN7OC
 ADnTEsFpO38d6w49vzFvFLDG12rE2b4bU/s0wPqb37NSp1Z0xDZOvUrtTrscjaewR+
 8FknOE5GZhgJHP0oTpdlPD+gU3VQHa80qwdBojy1kubnatkJtq+v6zW7VwIr59c6NS
 0Q0s5krltYs3WEZ4G7wjoY63AZSsraw3UxIdnabM0jgdf5U+gFFusMJPM0g6/A+eQM
 UjBJDBU3dR6hg==
Received: by mail-lf1-f49.google.com with SMTP id
 2adb3069b0e04-52c9034860dso5091140e87.2; 
 Mon, 17 Jun 2024 01:39:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1;
 AJvYcCUwBO2OY6W9Kq82bP2PgbzhRHse/6364YYUdR29qgl3qw4JyoxM6vQkQjuh3A3qM4cmTW8R1ZDNj/fqnAdHkzBfc/lg
X-Gm-Message-State: AOJu0YwaWV71dHGlkLFaAl1MA7XaAkq+pBbxUWta5JzIwBeJcMXq/+WT
 0bootyiGciAVxy49oAQT+8IybhMM8IUNCtBu3EyRruI3diWiq91eRwboB0zd7nHtf6HQ7Z75Akt
 VPRtKyR71IWD8UKnllvcYp3bgGho=
X-Google-Smtp-Source: AGHT+IHWdttgfkT+zId4hxpI05lDd3otRnr5/iTHZT3n52Hb3uRtRyPmVn5NJ0tpKzym9hxozaM3mIV8AqyGyDH0sP8=
X-Received: by 2002:ac2:4c02:0:b0:52c:a20e:4da4 with SMTP id
 2adb3069b0e04-52ca6e9b912mr6853483e87.57.1718613557089; Mon, 17 Jun 2024
 01:39:17 -0700 (PDT)
MIME-Version: 1.0
References: <fcdc0626-a0f7-4796-a05d-2462c896f5ba@bsdio.com>
 <20240617083639.379608-1-marcin.juszkiewicz@linaro.org>
In-Reply-To: <20240617083639.379608-1-marcin.juszkiewicz@linaro.org>
From: Ard Biesheuvel <ardb@kernel.org>
Date: Mon, 17 Jun 2024 10:39:05 +0200
X-Gmail-Original-Message-ID: <CAMj1kXEukirF7UZTRbdHCx-ppyX=7Msrwpw-b-OJpV33R8d0=g@mail.gmail.com>
Message-ID: <CAMj1kXEukirF7UZTRbdHCx-ppyX=7Msrwpw-b-OJpV33R8d0=g@mail.gmail.com>
Subject: Re: [PATCH 1/1] BootLogoLib: align logo coords to be even
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: qemu-devel@nongnu.org, Leif Lindholm <quic_llindhol@quicinc.com>, 
 Ard Biesheuvel <ardb+tianocore@kernel.org>, qemu-arm@nongnu.org, 
 Taylor Beebe <taylor.d.beebe@gmail.com>,
 Pedro Falcato <pedro.falcato@gmail.com>, 
 Theo Jehl <theojehl76@gmail.com>, Rebecca Cran <rebecca@bsdio.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2604:1380:40e1:4800::1;
 envelope-from=ardb@kernel.org; helo=sin.source.kernel.org
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Mon, 17 Jun 2024 at 10:37, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> If we draw logo at odd coords then BootLogoLib goes into exception and
> boot process ends:
>
> Synchronous Exception at 0x00000101FB943E48
> PC 0x0101FB943E48 (0x0101FB93F000+0x00004E48) [ 0] QemuVideoDxe.dll
> PC 0x0101FB943314 (0x0101FB93F000+0x00004314) [ 0] QemuVideoDxe.dll
> PC 0x0101FB92F798 (0x0101FB92D000+0x00002798) [ 1] ConSplitterDxe.dll
> PC 0x0101FBA96BC4 (0x0101FBA8E000+0x00008BC4) [ 2] BdsDxe.dll
> PC 0x0101FF7FDF50 (0x0101FF7F3000+0x0000AF50) [ 3] DxeCore.dll
>
> This change resizes logo from 193x58 to 194x58px to make it's sizes
> even. And if coords are odd then they are bumped a bit to make things
> work.
>
> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>

This should be fixed in the SBSA firmware - unaligned accesses are
fine on arm64 as long as they don't target device memory. So this
likely implies that the framebuffer is mapped with device attributes
while it should be mapped normal-non-cacheable.


> ---
>  .../Library/BootLogoLib/BootLogoLib.c         |   4 ++++
>  MdeModulePkg/Logo/Logo.bmp                    | Bin 12446 -> 34010 bytes
>  2 files changed, 4 insertions(+)
>
> diff --git a/MdeModulePkg/Library/BootLogoLib/BootLogoLib.c b/MdeModulePkg/Library/BootLogoLib/BootLogoLib.c
> index 478ec2d40e2b..3b7b5f3146e8 100644
> --- a/MdeModulePkg/Library/BootLogoLib/BootLogoLib.c
> +++ b/MdeModulePkg/Library/BootLogoLib/BootLogoLib.c
> @@ -205,6 +205,10 @@ BootLogoEnableLogo (
>      DestX += OffsetX;
>      DestY += OffsetY;
>
> +    // align logo to even coords
> +    if (DestX % 2 != 0) DestX++;
> +    if (DestY % 2 != 0) DestY++;
> +
>      if ((DestX >= 0) && (DestY >= 0)) {
>        if (GraphicsOutput != NULL) {
>          Status = GraphicsOutput->Blt (
> diff --git a/MdeModulePkg/Logo/Logo.bmp b/MdeModulePkg/Logo/Logo.bmp
> index 3e85229e17595ba1f9c59e13692a4f8362ebc850..136345a56ac44e3ea8d3c91114b5a2676dc90e2a 100644
> GIT binary patch
> literal 34010
> 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
> F{{z+$A|L<&
>
> literal 12446
> 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
>
> --
> 2.45.1
>

