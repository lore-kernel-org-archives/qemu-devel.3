Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFC6CC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 20:06:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzirx-000176-Bg; Wed, 24 Apr 2024 16:05:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rzirw-00016x-DJ
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 16:05:28 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rziru-0008Sa-PK
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 16:05:28 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-571c22d9de4so223125a12.3
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 13:05:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1713989123; x=1714593923; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SYORqT/gXMRj8hBF7cziEW/dwRHovily7KUN6x64r68=;
 b=C1XmogzDv5AOH8VTx/5R3mj8o3vsURda3H1zWvzAkwOnFsgXj1JdrANY7ZRCLedqdW
 H/F8vv1AAPKYzTL2KGYvhwGrTcQiMlln+g8tCFYmpA+qJd5ZAEBwAU1H9kFj7KX0jO5y
 2FfQW+4KJSr7dvlhlw2c58swBixZmEfIuAceMYdwqU2ju2AM9XZUn7ylrRSGP4zBIoM5
 jAtyyf81HZTNZUbwPNLf/9jhEp9Sv/0quFY12sIY+08SMtQJDx91RZqtEeyDaMXNj5E3
 S8qw1gzhl3GDrBIeHy0vfIP66d7nTA/Gp/HpwxAZArJPDCjjpFZK/FOAyablgGQp0riX
 ducw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713989123; x=1714593923;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SYORqT/gXMRj8hBF7cziEW/dwRHovily7KUN6x64r68=;
 b=BaCvQXOe7jrLurtIDVdE0IO2IC0YDGfV3Wi9BujMuTH14s5jjv6ntfm3jcXFOJ2nWj
 gagRa+mwtV1tPgWvSk4JLb72wr/Fwsutn4TrXuhTjONasqP2HpBzG4Hsb6bdHpzVB3RD
 fb910N3u5ki4A22lc2MfgI9Ds44tUXl7vIRjAiafZwtfa80R/5zF3zL6VrauGn4zycRN
 mSAc9ceJYmLUl95NIoeGVOE/8nKjul8+2PmCrkZxcbVRZej07nTfO/pp4tTEEXFybnAq
 S47UG4PUSz0TiuXUqEu3LtqXkoFaXWoq/XIHyEEGG1KHcVH7dun4YFjDptwqrHpvma+H
 k7eg==
X-Gm-Message-State: AOJu0YzSR9csdGWQhZv6xl4rYvFZRim7f9UYjYrD98Q3LHT6VkxG1IVo
 6wHmjV0fIk1qUxgzmI1xEp2oZX/jaXMCvaWw1KmbEu0jSJW3VWgIPo0uZg==
X-Google-Smtp-Source: AGHT+IH1DENYzUkPFcw7bnVzHDUW5rMKX68YNCAfyBq1KfnWrkFZV7E+liKwPGKfYZa3GZYxSO6ohQ==
X-Received: by 2002:a17:906:6bda:b0:a52:1e53:febf with SMTP id
 t26-20020a1709066bda00b00a521e53febfmr2249549ejs.69.1713989123033; 
 Wed, 24 Apr 2024 13:05:23 -0700 (PDT)
Received: from [127.0.0.1] (dynamic-078-055-120-248.78.55.pool.telefonica.de.
 [78.55.120.248]) by smtp.gmail.com with ESMTPSA id
 e20-20020a170906315400b00a5591a644c8sm6655257eje.17.2024.04.24.13.05.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Apr 2024 13:05:22 -0700 (PDT)
Date: Wed, 24 Apr 2024 20:05:06 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
CC: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 0/4] X86: Alias isa-bios area and clean up
In-Reply-To: <20240422200625.2768-1-shentey@gmail.com>
References: <20240422200625.2768-1-shentey@gmail.com>
Message-ID: <7F22191C-C726-434D-BE18-ECB67134EC74@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x535.google.com
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

+Michael=20

Am 22=2E April 2024 20:06:21 UTC schrieb Bernhard Beschow <shentey@gmail=
=2Ecom>:
>This series changes the "isa-bios" MemoryRegion to be an alias rather tha=
n a
>
>copy in the pflash case=2E This fixes issuing pflash commands in the isa-=
bios
>
>region which matches real hardware and which some real-world legacy biose=
s I'm
>
>running rely on=2E Furthermore, aliasing in the isa-bios area is already =
the
>
>current behavior in the bios (a=2Ek=2Ea=2E ROM) case, so this series cons=
olidates
>
>behavior=2E
>
>
>
>The consolidateion results in duplicate code which is resolved in the sec=
ond
>
>half (patches 3 and 4) in this series=2E
>
>
>
>Question: AFAIU, patch 2 changes the behavior for SEV-enabled guests sinc=
e the
>
>isa-bios area is now encrypted=2E Does this need compat machinery or is i=
t a
>
>bugfix?
>
>
>
>Testing done:
>
>* `make check` with qemu-system-x86_64 (QEMU 8=2E2=2E2) installed=2E All =
tests
>
>  including migration tests pass=2E
>
>* `make check-avocado`
>
>
>
>Best regards,
>
>Bernhard
>
>
>
>Bernhard Beschow (4):
>
>  hw/i386/pc_sysfw: Remove unused parameter from pc_isa_bios_init()
>
>  hw/i386/pc_sysfw: Alias rather than copy isa-bios region
>
>  hw/i386/x86: Eliminate two if statements in x86_bios_rom_init()
>
>  hw/i386: Consolidate isa-bios creation
>
>
>
> include/hw/i386/x86=2Eh |  2 ++
>
> hw/i386/pc_sysfw=2Ec    | 38 ++++----------------------------------
>
> hw/i386/x86=2Ec         | 35 +++++++++++++++++++----------------
>
> 3 files changed, 25 insertions(+), 50 deletions(-)
>
>
>
>-- >
>2=2E44=2E0
>
>
>

