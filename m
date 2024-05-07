Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BED6C41513
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 14:34:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4LtZ-00041d-OG; Tue, 07 May 2024 10:34:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s4LtW-0003vK-3i
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:34:14 -0400
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s4LtT-0001T6-V0
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:34:13 -0400
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-a59a17fcc6bso736056466b.1
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 07:34:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715092450; x=1715697250; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ntWHXiVvwmKn2Krp2k/HmlVIEqFVi5OvZ8aK44T1d7I=;
 b=zcO9/SKT5YQisGj4g36pNqKIcuZmh0UMsOPjuGSVdDenbyCuuqHSXmcY3C/hJT/7dH
 ARZ384yZJ4nGzihy1EaeVfZbMPB6kRlGzbxJX4UVsFIUWop2KqoGauDZHbvzzlXvF5yj
 VQ3Us69y+mTL9SSqbDTB9dW4zx6wUv5xRn0X84Fpb20gEwrZhddwr5ZtCMaLBqn4+wQ2
 FEF3xViFKtILVyX6VwfvpTwalNNgL/vGkV8PB6Yl/F1+yUU6TRygxrRu5LMU+vbo7Kcv
 DbgRXMdcTbuUx2cFBuSigo6zikWVQIOTRoSILQsEAyI5rpwE3btiKqNkfFloDOcj0aGf
 R61A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715092450; x=1715697250;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ntWHXiVvwmKn2Krp2k/HmlVIEqFVi5OvZ8aK44T1d7I=;
 b=tbY5xMcCWk50BgtRt1lyLa7JWaJ1Wc6Uv9F2e+uRNwNoQG0BNWo0FGPDFxNn5b5uS1
 /ehkx0BMHDXVOqw7e/aXHBK3y7FzQOlkU9zNrbnE3z7KzQjBZ1jh4VgVeBrnINysPTxS
 z7ypPJGN4LkwA7WIIlbP36wOyrqcH8kIi8S/dbH9BTPAUmerOEOGOiVjr7qy1PSfn9em
 qOBrPUveiCCYRS1mxStp2EN+dvUPJyKt4LKhBL1CkPcNadIDHXrRRsdEIUTZcD0yWMJ/
 tSjR9x/13IbEc2jILYk1CdUniRE8nZUTWWA+0TcxNY9eEpEnpAw5umwgT+A1JQc9i7q3
 QiqQ==
X-Gm-Message-State: AOJu0YzP9pS+Qhol/rLUwyyJfod2muQGxhfxLfkGxrWgEG7v9uVtu1ig
 xn6rN4ckPYaIrhXBSnj9qAscDrFiaALRZkHkKPclbJ1Q7NEjBjB3SbF0UBnipsHqodbIwYGRhxv
 kIb/+cqSwo1LA2VnTYuEvHmFeleTALuhmPdYPuw==
X-Google-Smtp-Source: AGHT+IEgjbpMTYLl8o+SWEeZ4UueyoRyriKytYKBk6ZwWoViisHbVbBBffpDUCTAbha69xn34VxDWkHjdxifDW++Zs4=
X-Received: by 2002:a05:6402:14f:b0:572:a1ec:1562 with SMTP id
 s15-20020a056402014f00b00572a1ec1562mr1563524edu.13.1715092450408; Tue, 07
 May 2024 07:34:10 -0700 (PDT)
MIME-Version: 1.0
References: <20240507142737.95735-1-philmd@linaro.org>
In-Reply-To: <20240507142737.95735-1-philmd@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 May 2024 15:33:58 +0100
Message-ID: <CAFEAcA9-Dj76m9usxvZgRxcTXucX4+uo2pjxk1sHqAJwbnww5g@mail.gmail.com>
Subject: Re: [PATCH] misc: Use QEMU header path relative to include/ directory
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Song Gao <gaosong@loongson.cn>,
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, Jeuk Kim <jeuk20.kim@samsung.com>, 
 Gerd Hoffmann <kraxel@redhat.com>, Klaus Jensen <its@irrelevant.dk>, 
 Jesper Devantier <foss@defmacro.it>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 7 May 2024 at 15:28, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org=
> wrote:
>
> QEMU headers are relative to the include/ directory,
> not to the project root directory. Remove "include/".
>
> See also:
> https://www.qemu.org/docs/master/devel/style.html#include-directives
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  hw/audio/virtio-snd.c   | 2 +-
>  hw/rtc/ls7a_rtc.c       | 2 +-
>  target/i386/gdbstub.c   | 2 +-
>  tests/qtest/nvme-test.c | 2 +-
>  tests/qtest/ufs-test.c  | 2 +-

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

