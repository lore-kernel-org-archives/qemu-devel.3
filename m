Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C872C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 14:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roljb-0000BD-Bg; Mon, 25 Mar 2024 10:55:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1roljU-0000Aj-Gl
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 10:55:29 -0400
Received: from mail-lf1-x133.google.com ([2a00:1450:4864:20::133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1roljS-0003mE-3P
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 10:55:27 -0400
Received: by mail-lf1-x133.google.com with SMTP id
 2adb3069b0e04-513e134f73aso5694737e87.2
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 07:55:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711378522; x=1711983322; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=qY+cucr7njz5e8ZCgvfC9KD0DaTkoI+Uv9JUOxqL04U=;
 b=R61Ql4SHPNYRj6C1mpGrIdj/KQxmb7fpLcF1q0x6O4jQlkBSnNs0vc1tHiqFPXnUKS
 bNOGqtow2PVRK7x9hpRl2z1qzCJ4ki6/xS0SRREhWWaRGCByHS50jhXLQCZkwjY+KlZg
 uS86vHnw4zhY+3FV9yonRSZgfAeJwbsjRE4a80J3unK+R+sOmWgVi4pJE1bI4whD/tWT
 /E5KalrsY0BRw/+AkUbJ46hftU7nQai05JupQM3sY2r9hgqIj7I9Frg1EOmkEumqd16E
 QbNnzAwoILx5nwBA9wxXtL6cV9Aoqbpe+JODDOw+Ow+jeQ6tBhm/8toQPNTqkbPHZgf8
 nEdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711378522; x=1711983322;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=qY+cucr7njz5e8ZCgvfC9KD0DaTkoI+Uv9JUOxqL04U=;
 b=k9ARVNGoCfY+exjGiqWIAN6zws3VrTiA/4khUW87olVTq6PtB17JNkjWR3e3BtIL/i
 UbUGghQFEQOjgkx0g/M2kEmGNU/JzHa3cy/39TaXGi3qnYK13zzw5slcJv0UBxJjizGk
 /GFWhwHTmXVQtYSXMZr2ZtcL9gNhv1OVFDNffa8RWM6YOllYe+klr+Z7tZUw7j8ZD+RR
 rXLt1jskbyNovS4e8jtM6WxdPr3bj/Pwa23TWF5nnke+0ENHFTxlaTgZDxLkad5/J07z
 WfMW5kn64D0TXcUGpv3tNcEKhaFQ3gnBoC3TRBj4F34UXJ6Ob70Vtv4MGuwpIzNwloNt
 o8mg==
X-Gm-Message-State: AOJu0Yws9gCu/VS6iAQOA2AhfjxExj1VkPDZiCnD5+yiAKq1lWwNH0tq
 GDjnh7etTdrmIAjGjsJM2Xx3IwTGUduxX1z5pVY/iG25pjcVrKj1xiE/sxxaRgezAxfdsFSWGki
 76viqFChTo1TUAuKMuKrq6i3VFCCCJZ+aeQwTZQ==
X-Google-Smtp-Source: AGHT+IEB2EqI0FxxZ12XEep1WClOX3F9XRR6aOPJokYn6Gjufyhc1Fnf8nmYZIDPA+y2EB6fh0TaDoiJ8QwNqiEyCnc=
X-Received: by 2002:a19:ca1a:0:b0:513:d22c:419a with SMTP id
 a26-20020a19ca1a000000b00513d22c419amr5284602lfg.61.1711378522224; Mon, 25
 Mar 2024 07:55:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240325144440.1069662-1-kraxel@redhat.com>
In-Reply-To: <20240325144440.1069662-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 25 Mar 2024 14:55:11 +0000
Message-ID: <CAFEAcA9PkAyqVcKMLQZw71FMh6YTpNDNwuKoO0u7i_mRxsJizQ@mail.gmail.com>
Subject: Re: [PATCH] edk2: get version + date from git submodule
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::133;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x133.google.com
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

On Mon, 25 Mar 2024 at 14:45, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> Turned out hard-coding version and date in the Makefile wasn't a bright
> idea.  Updating it on edk2 updates is easily forgotten.  Fetch the info
> from git instead.
>
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>  roms/Makefile | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/roms/Makefile b/roms/Makefile
> index edc234a0e886..534eba17ebd0 100644
> --- a/roms/Makefile
> +++ b/roms/Makefile
> @@ -51,6 +51,8 @@ SEABIOS_EXTRAVERSION="-prebuilt.qemu.org"
>  # efi ia32, efi x64) into a single rom binary.
>  #
>  EDK2_EFIROM = edk2/BaseTools/Source/C/bin/EfiRom
> +EDK2_STABLE = $(shell cd edk2; git describe --tags --match 'edk2-stable*')
> +EDK2_DATE = $(shell cd edk2; git show --pretty='format:%cd' --date='format:%m/%d/%Y'| head -1)

I don't think there's any guarantee that the user has 'git'
installed. scripts/qemu-version avoids using "git describe"
unless it's building in a git tree.

You can avoid the "| head -1" by using
  git log -1 --pretty='format:%cd' --date='format:%m/%d/%Y'
I think.

Also, does EDK2 really want month/day/year? Typically silly
choice if so :-)

thanks
-- PMM

