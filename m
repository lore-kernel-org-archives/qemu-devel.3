Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40E69C48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 16:18:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rY76a-00030N-QJ; Thu, 08 Feb 2024 11:18:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rY76Y-0002w1-D7
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 11:18:26 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rY76S-0002lB-Gy
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 11:18:26 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-40fc22f372cso199215e9.1
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 08:18:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707409099; x=1708013899; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0gkAXAFt8coxJjuL0ecOXCsNCmTY4pPYoOAj+DkCTjQ=;
 b=SGp8Jpo36kwTZFY28zfCkWQzsGZB54RabcNvCuQXK04Sc0hSPGo56oXGWw058nUl7H
 wmOZ8YDEawe3F+xtuZT+d8tlwO0xFBlHDh4r7wuh63IlUV9rAZFlA2l1ikNMYV0MlAgz
 zpNKpI4Z97bx/7EbJeihTfQkP9HINLnL+xqS1PPnQJq7EixAjXvvnp7hVOi7rhdGkETg
 WOmGIWgvEwzOfwAcKDaJLTuvlUP/L10FJcHjDN77oKTf10aWp6QjOOUc+jUaZ1lw2TR7
 zacuwuTlUkgJDgh25MUmW2RxCBCgW8NnQh/iheijYI54LffkXaosq5+U5JkTee95uPwf
 y9zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707409099; x=1708013899;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0gkAXAFt8coxJjuL0ecOXCsNCmTY4pPYoOAj+DkCTjQ=;
 b=s0nnmADCv8SOuiB90gj4aVV7zdVA0sXZuopd50r5bBtAQyMNYY3in0r5KtCwExTg+K
 oUspgq3HT9gFc6tcUtfkREA59mn5Hli4/midND9aikoGQXPyhVHZYnn3cCHVYkaUmrEj
 R7bQfJlgWPlmSO18c/vGdH1kiYdOoZdlhNi+BAB/xp8/sVTv3rSgjrP75aQf6YYJlqxd
 GmKS1nboT/0VT12crRlKemDl23mLYt5VnI7R1CPwv7Ays2plvtfXbuRbhgI4NwR6hWTF
 WURgwr71jROalHTJdG44vgukp9acEYQTIi2clmiJWZeCpXZi+Njg7Vr2fGE4mJneeMSp
 lY6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVsjEfM4fenbCrGhK+P6zBu5pxqMbnlPlGDwIMnyYSSMmsHf3PBaaP9ocwXQZ6So2+rnxrbfU9RrvVP2MgPv28DauckUAU=
X-Gm-Message-State: AOJu0Yw6XG0QtsApfWar8fAqGqCARmb2Am1MrjfgWO15xlDHT8O18WaR
 PBkdStd+zDPBr5d7c4uU8tzt4ag/Dc4JOmRgn1HN2HnC+/vZ87dT
X-Google-Smtp-Source: AGHT+IHr8VgJCYQCNf8XTfFi9ZwDLaqP3xPBQagUThOOBSScARnzeU6JECGCF3czSwJ3VO5q3c+52A==
X-Received: by 2002:a05:600c:a47:b0:40e:5ed3:ccf4 with SMTP id
 c7-20020a05600c0a4700b0040e5ed3ccf4mr6683574wmq.16.1707409098762; 
 Thu, 08 Feb 2024 08:18:18 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUEa9KsN/x62kD5DHv/ZN7qKW2A5ULLIfR+hHS4wsehaHElEOxMcfjD3NsUPZRaOzISCH3LTuAym9t/NFSXGyGKfanSxR4=
Received: from ?IPv6:::1?
 (p200300faaf1724007ccdd0ba9e70da1e.dip0.t-ipconnect.de.
 [2003:fa:af17:2400:7ccd:d0ba:9e70:da1e])
 by smtp.gmail.com with ESMTPSA id
 m20-20020a05600c4f5400b0040e3635ca65sm2075129wmq.2.2024.02.08.08.18.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Feb 2024 08:18:18 -0800 (PST)
Date: Thu, 08 Feb 2024 16:18:16 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
CC: philmd@linaro.org
Subject: Re: [PATCH v2 4/8] isa: fix ISA_SUPERIO dependencies
In-Reply-To: <20240207111411.115040-5-pbonzini@redhat.com>
References: <20240207111411.115040-1-pbonzini@redhat.com>
 <20240207111411.115040-5-pbonzini@redhat.com>
Message-ID: <475D7723-FD31-44EC-B8B1-A7C33CD1478C@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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



Am 7=2E Februar 2024 11:14:06 UTC schrieb Paolo Bonzini <pbonzini@redhat=
=2Ecom>:
>ISA_SUPERIO does not provide an ISA bus, so it should not select the symb=
ol:
>instead it requires one=2E  Among its users, VT82C686 is the only one tha=
t
>is a PCI-ISA bridge and does not already select ISA_BUS=2E
>
>Signed-off-by: Paolo Bonzini <pbonzini@redhat=2Ecom>

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

>---
> hw/isa/Kconfig | 3 ++-
> 1 file changed, 2 insertions(+), 1 deletion(-)
>
>diff --git a/hw/isa/Kconfig b/hw/isa/Kconfig
>index 7884179d08b=2E=2E5df3c09cd51 100644
>--- a/hw/isa/Kconfig
>+++ b/hw/isa/Kconfig
>@@ -15,7 +15,7 @@ config I82378
>=20
> config ISA_SUPERIO
>     bool
>-    select ISA_BUS
>+    depends on ISA_BUS
>     select PCKBD
>     select PARALLEL
>     select SERIAL_ISA
>@@ -47,6 +47,7 @@ config PIIX
>=20
> config VT82C686
>     bool
>+    select ISA_BUS
>     select ISA_SUPERIO
>     select ACPI
>     select ACPI_SMBUS

