Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74AA7C54E49
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 01:59:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhgY6-0002Ll-4v; Tue, 05 Mar 2024 20:58:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhgY3-0002LD-LL; Tue, 05 Mar 2024 20:58:23 -0500
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rhgY2-0002vx-4h; Tue, 05 Mar 2024 20:58:23 -0500
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-4affeacaff9so1988040e0c.3; 
 Tue, 05 Mar 2024 17:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709690301; x=1710295101; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pYv6el1R0wiaajesRzDXWa19ly/VfVvA2N/kryP6fgE=;
 b=L2QE54wSxaq0CITj3mSYFaeMC84e0AQ5n8ZBWkYI4WVa5EJAPDS5X+u8nsKC9zePp8
 fiuY1nQ8sl/agZZ+xppSUu3+YPElvQqgFhpBeHHSvVJ09PUi8dDTD0GrMHpHViu9WeDX
 7SRdRaUIJ1bSq720Kbp66QhbIlpML+nxL+7IFD9+HQrbN2zjtMBlC9qkHhkHYEDgA+1w
 u3sS5eOjr1h+FrlKaw1QWMTxkywkv5v0fsHHHgF6j2X0P0FtCsurekFkLIYDfL5igqvh
 lrOjoay36Dm56MVGousa6KkSB5MjlOsdZCspMu0thkbpOXeSF7jo3qkZuaBni6hY6yhj
 N0Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709690301; x=1710295101;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pYv6el1R0wiaajesRzDXWa19ly/VfVvA2N/kryP6fgE=;
 b=Jt197o12zULJeuMg6dTQI1F4sHDCvgnmPqtm/WpLOAzT0D7iFgrVX/dUhlX/tpqY3k
 SrNiR0ehlJ9wp6bBIxQ9yFZMyowAw2FDyJCm29bcF+ulPkul644iiRo7bgIOiywAVZbm
 tKUc3zF3AwkQU3znlcZ7auuni8Q5sz+USPzaGmAWpCE2jm7xYtbul7inuJeudD9Uofxm
 +mjQWnQMjvC9u/XZQrrMrS0OASUzhMC3JANZ4xwi2y3xPEH2Yr/u5DC0d/y70nAW1yLR
 zhyXpgbIb1jFoXrVV1cJVKNDqM3R7KDaYG2M1+AhF3QCJ7vI/PJV7GcUjzEwkQXQoCC+
 /ggg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU28dA1lKjHo1bqRjQhUkbmA1muaBGuXmxQDfpNgQSvcoehD/q5vDSAiNVhf9+WmFlTYok0WNk/XZEYrS/IB5gn+lC4d2Y=
X-Gm-Message-State: AOJu0Yxu2C8AJmQNCx3QR8z2eMAV52em5yjTjMMn/82TSRO84miJguJx
 JWqYR/M1xjDKdSsi+KQV+aak8Ftxrvr4INj2+ttGs00oovrckSdnrMr+DwGJtHl2RKMbq8zut/b
 y8NswmHKYoSV64IVffaulrbi0sEA=
X-Google-Smtp-Source: AGHT+IF0AV9KKXnn1dAKF+cTTBIO6/Inhd1wrnPhcQmw2ZCK0wjAf1shUuomQCgxf+oa8lUqPb1bifPszWh86ct0bzM=
X-Received: by 2002:a05:6122:311b:b0:4d1:3e69:3fa4 with SMTP id
 cg27-20020a056122311b00b004d13e693fa4mr4153762vkb.12.1709690300725; Tue, 05
 Mar 2024 17:58:20 -0800 (PST)
MIME-Version: 1.0
References: <20240229180656.1208881-1-christoph.muellner@vrull.eu>
In-Reply-To: <20240229180656.1208881-1-christoph.muellner@vrull.eu>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 6 Mar 2024 11:57:54 +1000
Message-ID: <CAKmqyKPQx2x6L1R137k-0zA0UMZyPY9X7XW0FW1fdtNoQ8VEFQ@mail.gmail.com>
Subject: Re: [PATCH] tests: riscv64: Use 'zfa' instead of 'Zfa'
To: =?UTF-8?Q?Christoph_M=C3=BCllner?= <christoph.muellner@vrull.eu>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bin.meng@windriver.com>,
 Philipp Tomsich <philipp.tomsich@vrull.eu>, Palmer Dabbelt <palmer@dabbelt.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Andrew Jones <ajones@ventanamicro.com>, 
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2d;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2d.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Fri, Mar 1, 2024 at 4:07=E2=80=AFAM Christoph M=C3=BCllner
<christoph.muellner@vrull.eu> wrote:
>
> Running test-fcvtmod triggers the following deprecation warning:
>   warning: CPU property 'Zfa' is deprecated. Please use 'zfa' instead
> Let's fix that.
>
> Signed-off-by: Christoph M=C3=BCllner <christoph.muellner@vrull.eu>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  tests/tcg/riscv64/Makefile.target | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tests/tcg/riscv64/Makefile.target b/tests/tcg/riscv64/Makefi=
le.target
> index a7e390c384..4da5b9a3b3 100644
> --- a/tests/tcg/riscv64/Makefile.target
> +++ b/tests/tcg/riscv64/Makefile.target
> @@ -17,4 +17,4 @@ run-test-aes: QEMU_OPTS +=3D -cpu rv64,zk=3Don
>  TESTS +=3D test-fcvtmod
>  test-fcvtmod: CFLAGS +=3D -march=3Drv64imafdc
>  test-fcvtmod: LDFLAGS +=3D -static
> -run-test-fcvtmod: QEMU_OPTS +=3D -cpu rv64,d=3Dtrue,Zfa=3Dtrue
> +run-test-fcvtmod: QEMU_OPTS +=3D -cpu rv64,d=3Dtrue,zfa=3Dtrue
> --
> 2.43.2
>
>

