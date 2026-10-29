Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4C4606A31D
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Oct 2026 19:46:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ONKl6CI4
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMW4T-0000Qq-P2; Thu, 29 Oct 2026 15:45:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <fredrik.noring@gmail.com>)
 id 1xMUmf-00032S-RF
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 14:23:29 -0400
Received: from mail-lf1-x12c.google.com ([2a00:1450:4864:20::12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <fredrik.noring@gmail.com>)
 id 1xMUme-00083w-5H
 for qemu-devel@nongnu.org; Thu, 29 Oct 2026 14:23:29 -0400
Received: by mail-lf1-x12c.google.com with SMTP id
 2adb3069b0e04-5be3ed646a5so2266083e87.1
 for <qemu-devel@nongnu.org>; Thu, 29 Oct 2026 11:23:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793298205; x=1793903005; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=8GgbRpUPKeFiwy86aSG84empC9GNf7WIOxnDVHHYCno=;
 b=ONKl6CI4mg7JNIoACRIsD+F2KPkhwRX0jzq6nfgR0l+aebaZczc4l44cs+Ex/O6Xh8
 JZqVF4nNgF5jtml343xz4nQwDqxgjvuZvK4p75f6m6T+HiTKzXs4MvwjmvODbXbJFDuW
 OeiEhmGqBvr0xCgzb+rvna1pd2dcpVTlx8wAST6kK5HrQXDZLbdvQIu2kWVkXvtxeAie
 0wl9STVxyVfMeL2E7Grumak+A39pldmnHdhgiaHpLYoWJiY430XwXWb/cmvmJfFOKuOR
 8dTPgcHCndhIw8CoFcTn6HJYjeHlvdvqtMNHaqmU0afL6NiT61NsswGl9Ffj+7fUQlBt
 WlSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793298205; x=1793903005;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=8GgbRpUPKeFiwy86aSG84empC9GNf7WIOxnDVHHYCno=;
 b=sWymBgOURqn2fWB920fljw2739yHOWJytkwWAwJTYaMuBs52Y9nbhNsql+UnpHQxid
 9ugpqT2FomX+1HReDI3fgMg6lXJLwffJaCGy+kfSR7C8KNyDugboGvx48W1REJ8kYEjt
 BQ08aozOGmBvgMmctUetujnkgpuQDnWUg5sqR+4m2RN5VP/7uVj4aSn4L6lnV/arjZel
 xQf471xB8u1nT+7tOPlU+ijGLze3UE+XdjULnRw5Wsp+kaDKd+Odj6rEvBjLt7/ReXcB
 oET0DgXDXVqwgwkswpg6IRkh9Oni/fwbzBU8+w/v7uukyG+yBIaicpTg4qqUpNtwP3+x
 3mLA==
X-Gm-Message-State: AFq9FYKHKdOqlllDTMHmBcYEhhL/O0MnpKRI4NnNfNYddFMsU6itMDIl
 qp4PMeL5DLxSzGytT17AAMFA42oiLFlqbMyDj/IftXGcZme6fG0zhOgC
X-Gm-Gg: AYBFou2l36ll5HZJGaAddEMZoZWQD/ZDPedD8hPMdyrMPW+eNknMXLjIFdq4jY9wFw/
 2T8UhSPfn0jmn38OmeiHZhSolYz9v+ob/nXsKZbGaNZJMRrkAFwXqq7kBvY6FI3R2iSQXoJ60r/
 ScCp1NernewyFy82Z598ntyfhMf0jjKJ00hR1RAgT5ebrhy9Ct4Lsrgr/sFFnGfTkinDFcDBaEi
 PNQXG34rkWY54/LzIEed+fsosoLpRCNbU7kD/alrtFphhHBj57SuzheP/kW5KSNDBoY+3I5R6xd
 l/XgEt0jJ+AkNy2t8sHGkuNRAmEHgFz0WIXkbGzes084c9XDq1J0/2MIXBHcg/DoXcE2Ih1DyF6
 ezErQQWmdiCtCVu2HbTN67wrQaIUQPvbPLTTZIl1IPNgzZp7OeDF8pplkXK5Mk7NXWESV6eKrhG
 SUkzz6Ypi1eGL1qZ3HEqSScdhhu0bhD03YE4kS6RDzp+w/wznkPvxp3AmPkZB1yf9E5hl0aCUuR
 s/OH52TBpz1vUmOwsukN0zXj3gccmgfIcQW+j/pXz6+8pvXJiC2ZDdHgLkSi9MBUr6FjDoqbHU4
 2oh9XYe9zLMg3iewWzi5G5zNgS1h/VKQAQ==
X-Received: by 2002:a05:6512:10c3:b0:5bc:b0b9:f457 with SMTP id
 2adb3069b0e04-5bfcadf01c4mr2659361e87.47.1793298205249; 
 Thu, 29 Oct 2026 11:23:25 -0700 (PDT)
Received: from localhost ([192.165.153.208]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-5bfd7eeac3dsm36489e87.35.2026.10.29.11.23.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Oct 2026 11:23:24 -0700 (PDT)
Date: Thu, 29 Oct 2026 19:23:24 +0100
From: Fredrik Noring <fredrik.noring@gmail.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>,
 Helge Deller <deller@gmx.de>, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Aleksandar Rikalo <arikalo@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Subject: Re: [PATCH v2 4/9] tests/tcg/mips64el: Add bare-metal harness for
 R5900 system tests
Message-ID: <auOPHGG6lAEIlGr-@aerith>
References: <20261028192538.31600-1-philmd@oss.qualcomm.com>
 <20261028192538.31600-5-philmd@oss.qualcomm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261028192538.31600-5-philmd@oss.qualcomm.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::12c;
 envelope-from=fredrik.noring@gmail.com; helo=mail-lf1-x12c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Thu, 29 Oct 2026 15:45:56 -0400
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Philippe, Maciej,

[ Maciej, a post [*] from you in 2021 is referenced in the following. ]

On 28 October 2026, Philippe Mathieu-Daudé wrote:
> There is no libc for the R5900, so its tests can not run in user
> mode [*].

Both Glibc and Musl are available for the R5900.[1][2] In fact, we also
compile Gentoo for it. I believe the -mfix-r5900 option is used for the
official Gentoo MIPS downloads.[3]

As for QEMU, I maintain my own fork with R5900 user mode support since
2020, based on QEMU v5.2, as well as a corresponding Gentoo package,[4][5]
because later versions of QEMU became unfixable and unusable for R5900
user mode emulation.

A proper QEMU R5900 user mode must emulate the FPU like the Linux kernel
does, which is why QEMU 5.2 remains the latest usable version of QEMU for
the R5900.

It’s worth mentioning that there are discussions on introducing additional
FPU modes for the R5900 and Linux, which would allow use of FPU hardware,
despite its noncompliance with IEEE 754.[6][7]

> [*] https://lore.kernel.org/qemu-devel/alpine.DEB.2.21.2103172243160.21463@angie.orcam.me.uk/
> 
> Inspired-by: Maciej W. Rozycki <macro@orcam.me.uk>

Fredrik

[1] https://github.com/frno7/gentoo-mipsr5900el
[2] https://github.com/frno7/gentoo-mipsr5900el/blob/d84d04b2fd9d47d5cce9c1c0884026cc37d008cf/scripts/install-crossdev#L16-L17
[3] https://www.gentoo.org/downloads/mips/
[4] https://github.com/frno7/qemu
[5] https://github.com/frno7/gentoo.overlay/tree/main/app-emulation/qemu-mipsr5900el
[6] https://github.com/frno7/linux/wiki/R5900-floating-point-unit-(FPU)
[7] https://github.com/frno7/linux/issues/3

