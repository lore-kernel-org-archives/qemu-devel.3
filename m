Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 459F5C021A4
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 20:16:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmerI-0000HI-7s; Mon, 24 Feb 2025 15:15:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmerF-0000Fr-Em; Mon, 24 Feb 2025 15:15:17 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>)
 id 1tmerD-0004he-4J; Mon, 24 Feb 2025 15:15:17 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5e0939c6456so7706306a12.3; 
 Mon, 24 Feb 2025 12:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740428112; x=1741032912; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NyPAshIXenK9idrD/7VjTl4ZEDnGzzoPoyhm8ItuLJw=;
 b=gBOKSbh2V0j2cEyxrSECd14tWrlce2daQO4K0WrQ8oAdPmMKQz4J+aJ2TH8HHEGRXW
 DN6PRRmeBiKbDnG2mqIMjH1GRhku47elFZx2d4iGu1sc9y8nifmCyRZQnhcsOHNnxg0t
 8yuP98ea34vW6Hy9/RLR5je+yIKUNwlciu0dxC8dfLrNLWZnOnvdHjfTOkjdfQFce7PR
 4VoghzzKIYMvfzO3Vr2kxIi1kOlSWH5q0xKoRY0wvK5AtIC/XOyN/y6fgvi7GNytXt9c
 6GCnoX39kkLRjHxPjp1mxGPfg718U2/9g36LxXgpl/f2H8UcFxR7AHsR9yavenQbbFtq
 5qtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740428112; x=1741032912;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NyPAshIXenK9idrD/7VjTl4ZEDnGzzoPoyhm8ItuLJw=;
 b=itJ5YzeDB2M9TgXk31fPSp4JpEn5lRS/pmJ/433LKiYFrNh5+/SFlY1P2eBAgDwdYa
 9ilBTtdbxc7xJ1asOzV5+Gs58/nepAijcq0HHPWzJaPYHNh8TdXkOP12BOZFiziAcRqq
 r4Z9UvKTtMbel+KdMzBQknbgAoRvRS1vKTVSdW1RzTgImmzW/LS8tu+1QnUKiyki7NxS
 fvNivLAPAElvOLHRzeVh7ks6wSfRIJ+YOTS96kMPvQqL9s/itRHeAGWop1RvkJltoj92
 spJuNfh9QMWGEi4YqiPr1l1q1WcGqKfoGhyyuvli/zGCmdhROa4PLChPql3ofThRuAfd
 bszA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrrZ2S+8m9QfI2XD+OKpYNCK7RdPRHozc8qehZVCS6KU26YXTqdUBX2ap4j+ISV0/ZtJBD9tAemQ==@nongnu.org
X-Gm-Message-State: AOJu0YxxeNAkC/OxhLVCTKITVvV/De/cU2q33I5GZ3SBKbXbLxIEREr7
 au1LHCoQUwe+7mq0vEpnwwPBYxG4ZQyMM37ZwjPwMjcy/WAzsdqSvvZNKg==
X-Gm-Gg: ASbGncsFMiCnGxKEIeFdFeQfuxA5Ord9zHAwOYoVGqp2h1C/+MinuIXhDCb7dgRXVmp
 d5ICsSADhNYOCnM3d6DuNIiIN1WgyKyRIwtQpPWZGD7AJtNbk/CqT0LNqgW+mWGUejm6LIEsW7Y
 Ej0JZz8urVbbmoetw/h7bA+XHUhc26tSCk6WTa/23L3r1nacVV5VV0skwzI8RQehBT/3kv5yPVx
 TOyEZV/b6jfkzgxxxl69MUePv5zwdO9JxOWNz8uZrWaZCQYQXLAa6KANk6dQBsIznbNivrLcI0V
 srF9lgC6Eer/oxMR5B98nP/0yqNB+LLlfkdMGrks4i50xdiday+FN5W4KEswoVQ34UxrRrPEa4W
 wJQ==
X-Google-Smtp-Source: AGHT+IHfVGu9u8mVndwTf4ofJaaClyXtwSJ31FNXZmpMmN75rBnvgVGy1cD9he/u0Sfet6wSf5Jjwg==
X-Received: by 2002:a05:6402:40c6:b0:5df:a651:32ef with SMTP id
 4fb4d7f45d1cf-5e0b7231cadmr14710552a12.27.1740428111854; 
 Mon, 24 Feb 2025 12:15:11 -0800 (PST)
Received: from [127.0.0.1] (dynamic-077-183-167-055.77.183.pool.telefonica.de.
 [77.183.167.55]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5e46212761bsm90705a12.80.2025.02.24.12.15.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Feb 2025 12:15:11 -0800 (PST)
Date: Mon, 24 Feb 2025 19:04:46 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, BALATON Zoltan <balaton@eik.bme.hu>,
 qemu-ppc@nongnu.org
CC: Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH 0/4] ppc/amigaone patches
In-Reply-To: <cover.1740243918.git.balaton@eik.bme.hu>
References: <cover.1740243918.git.balaton@eik.bme.hu>
Message-ID: <ACCAE066-F36F-45DA-8768-0BBD956AA475@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 22=2E Februar 2025 17:52:27 UTC schrieb BALATON Zoltan <balaton@eik=2Eb=
me=2Ehu>:
>Hello,
>
>This series adds NVRAM and support for -kernel, -initrd and -append
>options to the amigaone machine=2E This makes it easier to boot AmigaOS
>and avoids a crash in the guest when it tries to access NVRAM=2E

Looks like the above information could be added to the changelog=2E While=
=2E=2E=2E

>
>While the -kernel option emulates what U-Boot passes to the kernel,
>old Linux kernels for amigaone may not work with it because of two
>reasons: these come in legacy U-Boot Multi-File image format that QEMU
>cannot read and even after unpacking that and creating a kernel uimage
>it won't find PCI devices because it does not initialise them
>correctly=2E This works when booted from U-Boot because U-Boot inits PCI
>devices=2E So does my BBoot loader which can be used to load AmigaOS so
>I don't intend to emulate that part of U-Boot=2E
>
>I'd like this to be merged for the next release please=2E When merging
>please update https://wiki=2Eqemu=2Eorg/ChangeLog/10=2E0 with the followi=
ng:
>
>amigaone
>
>Added support for NVRAM and -kernel, -initrd, -append command line
>options=2E

=2E=2E=2E this:

>By default the NVRAM contents are not preserved between
>sessions=2E To make it persistent create a backing file with 'qemu-image
>create -f raw nvram=2Ebin 4k' and add -drive
>if=3Dmtd,format=3Draw,file=3Dnvram=2Ebin to keep NVRAM contents in the ba=
cking
>file so settings stored in it will be preserved between sessions=2E
>
>To run AmigaOS with BBoot using the -kernel option at least BBoot
>version 0=2E8 is needed=2E Older BBoot versions only work with -device
>loader and cannot be used with -kernel on amigaone=2E

=2E=2E=2E information could be added to the amigaone section in the QEMU m=
anual to keep the documentation in one place=2E

Best regards,
Bernhard

>
>Regards,
>
>BALATON Zoltan (4):
>  ppc/amigaone: Simplify replacement dummy_fw
>  ppc/amigaone: Implement NVRAM emulation
>  ppc/amigaone: Add default environment
>  ppc/amigaone: Add kernel and initrd support
>
> hw/ppc/amigaone=2Ec | 269 ++++++++++++++++++++++++++++++++++++++++++++--
> 1 file changed, 261 insertions(+), 8 deletions(-)
>

