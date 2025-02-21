Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 316B1C021AA
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2025 10:12:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tlPzk-00038f-4V; Fri, 21 Feb 2025 05:10:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>)
 id 1tlPze-00038O-S7; Fri, 21 Feb 2025 05:10:52 -0500
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <th.huth@gmail.com>)
 id 1tlPzc-0005Yi-Gs; Fri, 21 Feb 2025 05:10:50 -0500
Received: by mail-wm1-f41.google.com with SMTP id
 5b1f17b1804b1-43690d4605dso11931525e9.0; 
 Fri, 21 Feb 2025 02:10:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740132646; x=1740737446;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FP8RwPyV644IP7Cxg0fHu3PhVMjCMcjQhZCVS3A2oyA=;
 b=tEgRN2qAoEGGtWgUp9dkYyZzYGfSvkgLjcSIbjqsrF7+a7e1alTqvGvxnRc2L0NAm8
 /WSgm543UHzeXhahug2RMfrHMa3rGdQoNfD1WHdou2Sus+rV01tV3eUlwX1jjTOLDBV8
 lpx7tA3UF061pu1yHZZYB9zZxy6JMbgNFwFzbENw3uGw22cxlAtf7mG7vov3rBT51X1q
 intrTjYuldt39/EzO7AhOsh6t3qy02yGv96T4e1QJ4VzgRLy0X2+K8nHVwQHJW0i8MfX
 8H3cEuopkGS5TtniPtLmZRPu8Ofw5xOdwYCev4LvDFPK+41Z/TCsPkIlroIpaBjrBSpu
 OttA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQmluKTXiJPJHrK7z0AY45OP0NTQfaw1mYEsGthzdGzt6/e+wO8PknMJzU+t4w0WjBS+cop0WjEQ==@nongnu.org
X-Gm-Message-State: AOJu0Ywg91i1NClmXSkIdE0YIwy/f1vnnnY1f8wzWi1DPiy/FS3UemGH
 tRqHjjDOsn3A++nXTDOuRYdCq4YINUnwxqfTdr0mGSeLrLeag71+
X-Gm-Gg: ASbGnctC5QMmoXGYRXFbx5ZapB1uW6SagrOnPLAg8oadvQ6Qh/6XCDg91Hd1cnZ4p8/
 WppOxsXY3jhJIM8UQi00oWouKQveDjOVxAgJnuq1xGz4XXMm2Kwo7V7KY0mB/U2R/bDZif47p+l
 BWLrztdJp+z5I85Jl7C+UAmb93qNNZqkPaYXa2wTkFYqMw4oGgQMTbps81XsTATlDJZsGe/mjf8
 02NnxfLekaWEL4vbgSrZywzXnT7zhddSjW7spiaLAhHNZwHxYRJrMG0xAotE6cAwEIenFq8ab/s
 LWSHSefUoHH4d6lh0O22/eCIUso9TvaNHc0NHP8kkuleLWEY
X-Google-Smtp-Source: AGHT+IE6LfnYu4sY5P0Se25D5TQSkvvopjHqNUh7lEcQ+f3F8IeJZabezMNS0bp/iplA/4W3CqXtnA==
X-Received: by 2002:a5d:648a:0:b0:38f:43c8:f751 with SMTP id
 ffacd0b85a97d-38f6f0959c5mr2795062f8f.35.1740132645751; 
 Fri, 21 Feb 2025 02:10:45 -0800 (PST)
Received: from tpx1 (ip-109-42-51-157.web.vodafone.de. [109.42.51.157])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38f259f8730sm23519623f8f.93.2025.02.21.02.10.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Feb 2025 02:10:45 -0800 (PST)
Date: Fri, 21 Feb 2025 11:10:43 +0100
From: Thomas Huth <huth@tuxfamily.org>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau
 <marcandre.lureau@redhat.com>, Alex =?UTF-8?B?QmVubsOpZQ==?=
 <alex.bennee@linaro.org>, Magnus Damm <magnus.damm@gmail.com>, Shin'ichiro
 Kawasaki <shinichiro.kawasaki@wdc.com>, Rayhan Faizel
 <rayhan.faizel@gmail.com>, qemu-arm@nongnu.org, Evgeny Iakovlev
 <eiakovlev@linux.microsoft.com>, Paolo Bonzini <pbonzini@redhat.com>, Peter
 Maydell <peter.maydell@linaro.org>, Luc Michel <luc.michel@amd.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>
Subject: Re: [PATCH v2 7/9] hw/char/mcf_uart: Use FIFO_DEPTH definition
 instead of magic values
Message-ID: <20250221111043.6417c938@tpx1>
In-Reply-To: <20250220092903.3726-8-philmd@linaro.org>
References: <20250220092903.3726-1-philmd@linaro.org>
 <20250220092903.3726-8-philmd@linaro.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.128.41; envelope-from=th.huth@gmail.com;
 helo=mail-wm1-f41.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

Am Thu, 20 Feb 2025 10:29:00 +0100
schrieb Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>:

> Defines FIFO_DEPTH and use it, fixing coding style.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> Reviewed-by: Luc Michel <luc.michel@amd.com>
> ---
>  hw/char/mcf_uart.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)

Reviewed-by: Thomas Huth <huth@tuxfamily.org>

