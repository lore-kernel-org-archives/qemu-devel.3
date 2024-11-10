Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE3C2D12D42
	for <qemu-devel@archiver.kernel.org>; Sun, 10 Nov 2024 15:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tA9jd-0000HB-GO; Sun, 10 Nov 2024 10:20:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1tA9jc-0000Gu-Ar
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 10:20:16 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1tA9ja-0002xe-Tf
 for qemu-devel@nongnu.org; Sun, 10 Nov 2024 10:20:16 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a9ed0ec0e92so524694566b.0
 for <qemu-devel@nongnu.org>; Sun, 10 Nov 2024 07:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731252013; x=1731856813; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ol776bEBnJ10lxdse6Fhge0PL2A/xzpKCiIBQp8DFg4=;
 b=S4zo4dMSSmlD8YQWneJsMyp1kO6kyglssczgFbmg/FxseJ8o4Mgi5vx6KvtdKK+yAb
 v+kjSGPCel/kDQtWiFEN8u8zYipOPSpTMFl0Opx+pPAyTuu4gkkToNFv4Cpmm8i9iNDE
 g8s+GYF7IRjHE9iIW2M6YKIfQ6sOcUO9okifWtxOem7XprfmW3NIOgboA57mxzve9WBz
 S8xGXtNIWiEmm7k/NQr+SA5xuGZ+byRnbwTAFJKgkP0c9dU2PnsprO0XZ0d97M0gppbJ
 FlUjnNyY1HGRP91rInnn6dM256OvXOVt3FcO3e58GI524TQ4Z36Yyg9TyZjYlQnUbufU
 KqsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731252013; x=1731856813;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ol776bEBnJ10lxdse6Fhge0PL2A/xzpKCiIBQp8DFg4=;
 b=bOzB2kLCHT90j6EUpoCDo81hGEUgHuSL7ryigScYWq1oitfLqv8CGC7kzcp3FcMqus
 s5Jn/VjzskNb/l7M/6gP3YITkVaGUeS/waF/nRde7ISSRZJUApz+QZO3da80GyeSG6lc
 TkCBNMS0V2r3KUoLU2Kj3Pcr4A6MQR3EhPTYTz+7+P7W1yscMo9Qqsje6KNjOFcGasov
 wzSnfpoOIxpoPFdVbxEyeRGcXT4SjHx0i2cueSa+RVxd9cFflCVCdVSbjzDIcZ8lgBpq
 k6X5UKVszsOafE/f2luXZzHZ6/RXmXwkDhDPX+GGOQl7J0crI5BQNtbG+09vE+FiLvwq
 mtVw==
X-Gm-Message-State: AOJu0YxqVa7JqeDm6Jq6nxgDO36SG7bygOMMzHkORKJJ5K7ky+zFub5j
 sTf/Ew7AB3YXttL9Bxqyktnep59rml52rWCaDbNaYn8jPIN78oLoPXi2cJAy6EshSLVOD0uiJ2X
 MxG+spfBffsT6TQ6W0qw+lblVqN/f2beoUH+IAw==
X-Google-Smtp-Source: AGHT+IEDaI7WiwzE18+zhzrPM7p8PihVlxIyNedxMApFB1dg8GaLEKJe+dFkfy/iZdWdqO0n7wZN6SnbrPNvTVGkH+4=
X-Received: by 2002:a17:907:9486:b0:a99:4f40:3e82 with SMTP id
 a640c23a62f3a-a9eefeb2bacmr817987566b.7.1731252012435; Sun, 10 Nov 2024
 07:20:12 -0800 (PST)
MIME-Version: 1.0
References: <20241109-update-maintainers-file-rust-v1-1-f4daba6f782f@linaro.org>
 <aa360d5f-b4f2-4a61-a5b8-decc87a97a7b@linaro.org>
In-Reply-To: <aa360d5f-b4f2-4a61-a5b8-decc87a97a7b@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Sun, 10 Nov 2024 17:19:46 +0200
Message-ID: <CAAjaMXayR_Ugkz76OuYe97tEKvHuuJA79f71GJA=zt8L=ESb2Q@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: CC rust/ patches to qemu-rust list
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org, 
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62c.google.com
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

On Sun, Nov 10, 2024 at 3:59=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> On 9/11/24 19:29, Manos Pitsidianakis wrote:
> > As of CAFEAcA-ZQuyGTtG-vhRTEwpz0L4cpimNxkKix45Yw6gVHXozRQ@mail.gmail.co=
m
>
> "As of [*] ..." but I'm not sure about the usefulness of "like
> qemu-block, qemu-arm, qemu-ppc etc but", maybe scratch it?

I definitely find it useful, for what it's worth. It's an all
all-encompassing topic, like block or arm, and some people are
interested in keeping an eye on those topics if they are not CCed on
the main list.

--=20
Manos Pitsidianakis
Emulation and Virtualization Engineer at Linaro Ltd

