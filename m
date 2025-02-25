Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99564C021BB
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 14:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmvwC-0000lL-4T; Tue, 25 Feb 2025 09:29:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmvw9-0000ky-RE
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 09:29:29 -0500
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tmvw8-0008KH-29
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 09:29:29 -0500
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-6fb7d64908fso48173307b3.3
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 06:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740493766; x=1741098566; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=lPHujlsLhltShdBoB8PvpgOtSi2hhPzbNlYdJCzOuL0=;
 b=LWDazoYDAPe2NKeaq0P4RqNwEccWIYjmsVxSwea0yBLCIh7u/T+nHO9gLkoi68NODQ
 Ek1tPPT08FOL9BV0OrpvdRwXnrwI7tgb/SOspukG1Bl1iuvu0+tg6gQYTwr5Zm3QrkaS
 km39bRlpKMR/hDkaoXzx9JTBWADYn0GBJ8jLUj+7O99it1DAWAinSXL9NeL1sdyB6m3d
 FWUFIBf7u9P3MJyKUV/g8XSdw021TEltVLk9iEzWfP7yq/S3iHceSPcf9pfdBvK6Cvoy
 DblOKxm9WdR/xNUzw0eAIpVPAJh/1+vS4uefUziP2Yulw+RuFS9hb+nLB8UHh7w6eS3V
 Ey7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740493766; x=1741098566;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lPHujlsLhltShdBoB8PvpgOtSi2hhPzbNlYdJCzOuL0=;
 b=WEXJ4XtV7S5qFXLISeuW/v2EvXN1L6q6Z+1RQAJG546LCapUlyk0Q7McAxEiUyxM2b
 SIcCxSpoEmRZQ0YwLSd+TO2a2wEocR8XELRmt3O+f9asCrYrEvUo4gJOXCZCYDQNQ8o+
 RpuRHhAsW61emCsTcnje2X0MtDvZ4LxJ2LmoVblPES2HJSS7Yek1pgc5G+im545S3vx6
 isuD5dgY7wK8NgP7aGt3NtYKkbowuodKmepoEiS3+M3KtB76DXlDsX8lpqWDyth7V9GU
 17L7eEcSKqqe8TYLktb5AkS9OK7l7v8/EOJrO39DbxG6ihHnLJenOkMep9EnqqNItrdR
 RORA==
X-Gm-Message-State: AOJu0YwCpBRtBq9A/bzBWDKFAljY+yvkB6w2ezfPrrepFYM+zKQ3x8/l
 DEwvdqMey7lrcX9w3gEn8w+W4JJXv+Hu1ccJSAzs1hd34XWu2umh6RcgBD+5rrTymUECOVioNph
 79FVN4cvbyYUFRxh2jCfQqX7Ft/tQ6ZNostSRyQ==
X-Gm-Gg: ASbGncvUiPvUcLrymofVnBuVDFGLjkfntW+bBV2mTzFgT8HFopWuNPKXPtQdlHgl58Q
 cDD3TL5OQUkWnyyK8BbM711RxXaXijnI6vkI9bn+8qfAR/yjRK0pWt+7iDHzZCYSrr7LMvuNrDw
 ZN1cbrbTwn
X-Google-Smtp-Source: AGHT+IF2pZimpMrjZz0DzDLoqS6vNb3AwGsBxI6uLGnhK4ADol+Tte+KsEaBsr+rtZCBJ1OBogZXvavM3UdQ7sZ7kSQ=
X-Received: by 2002:a05:690c:6f85:b0:6f9:7b99:8a29 with SMTP id
 00721157ae682-6fbcc3a3ee3mr150342067b3.34.1740493766452; Tue, 25 Feb 2025
 06:29:26 -0800 (PST)
MIME-Version: 1.0
References: <20250223114708.1780-1-shentey@gmail.com>
 <20250223114708.1780-17-shentey@gmail.com>
In-Reply-To: <20250223114708.1780-17-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 25 Feb 2025 14:29:15 +0000
X-Gm-Features: AWEUYZkQXFmCUgjaGJfkSE_kqM2ygGc7gci1ahus-kgRhkWasr957dmm07STbk8
Message-ID: <CAFEAcA8L6CFvuTC+UqG7r5R27Yohc9vSVtPBHttBKKj-s-L0oA@mail.gmail.com>
Subject: Re: [PATCH v2 16/18] hw/arm/fsl-imx8mp: Add boot ROM
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>, qemu-arm@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Laurent Vivier <lvivier@redhat.com>, Andrey Smirnov <andrew.smirnov@gmail.com>,
 Fabiano Rosas <farosas@suse.de>, Alistair Francis <alistair@alistair23.me>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Sun, 23 Feb 2025 at 11:47, Bernhard Beschow <shentey@gmail.com> wrote:
>
> On a real device, the boot ROM contains the very first instructions the CPU
> executes. Also, U-Boot calls into the ROM to determine the boot device. While
> we're not actually implementing this here, let's create the infrastructure and
> add a dummy ROM with all zeros. This allows for implementing a ROM later without
> touching the source code and even allows for users to provide their own ROMs.
>
> The imx8mp-boot.rom was created with
> `dd if=/dev/zero of=imx8mp-boot.rom bs=1 count=258048`.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Hi; I've thought about this a bit, and I think we should just
postpone having code to load a rom blob until we have an
actual rom blob that's not all zeroes. This makes this
board the same as e.g. imx7 which also doesn't try to load
a ROM blob. You can create a memory region for the ROM,
like imx7; just don't load anything into it, and that's
exactly the same as if there was an all-zeroes file that
got loaded.

This doesn't prevent users from experimenting with providing
their own ROM code, because they can do that with the
generic loader (passing it either an ELF file set up to
load to the ROM area or else a binary blob plus the
start address of 0).

That way we aren't carrying code we aren't using and an
awkward binary blob in git; we can add those when we need
them.

thanks
-- PMM

