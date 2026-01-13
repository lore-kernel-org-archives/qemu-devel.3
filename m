Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 859F1D29DC2
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 03:48:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfVOF-0008QE-JA; Mon, 12 Jan 2026 22:48:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vfVOE-0008OD-1E
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 22:48:18 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1vfVOB-000351-K7
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 22:48:17 -0500
Received: by mail-ej1-x629.google.com with SMTP id
 a640c23a62f3a-b87108066c3so270949766b.2
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 19:48:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1768276094; x=1768880894; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ZENVwfTmyIM6KP04rfr2J3eT/B14EqovT4iIpCP8HKk=;
 b=L9sIGMAzBCfXTIdy8UG28ZzIlb9/oJkMCjYRkmdkD8QDQc9w5BoTOVyauUJ9DI3OKR
 v1qxiOOtdF5yMxBqPe85hzHGIShSPRUw6aZa4zNPvilhwqIzGw0gRtqRBaFhEsa+j6KJ
 Uy+QHH8XOAoG7E5LgJwdj0ONks016hcuJJpp4Pgut7bvoKvPvGr2a5jvUkQvZTBD9AHt
 w3kxrYTNi/H1qtAzy4E6NE5FworlmV3ysYsrw4WrPh12uGCt4ffYTva9EQyBwAMIPPR8
 98yZSMb/jpzeh/EZUb+liagPwXYymdXpqGNjapfFYV0Ri0wwoZycddUFYocPYOaU5rW5
 q+IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768276094; x=1768880894;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ZENVwfTmyIM6KP04rfr2J3eT/B14EqovT4iIpCP8HKk=;
 b=p8fFjEbMsuyIbwLbnP4tQOXrWbak2o3FBRjfgGzPaqZzwQLpSUND8EbXFVQFfabHyX
 2PYpo/uYIWfXpfVz+jIhCXaWZkSKc0GpP+zPG+6WNrixOxBn/SAhC1mDfoWcL5hBhgGf
 su0g9sCSKU2C990BSw9GL/hZ28MdSL5ULC0BcuEJ3LE84PAatUjsr3DUQUqY7zBtQaj+
 8GSc8UwmwO3RXTclhth7MDaTI7CEj90RDE4/dxAbFt2PhDaH+zedM9PVVrPQDQnGuSVI
 7C89pya5CeSnOyedrz6e39HalSST/73nsEs/rHYJMFhAgyxNTmkVOyy9CYYozV9qnyNY
 9hzA==
X-Gm-Message-State: AOJu0YzHbn5kPX7PuebruW0xACql9JiIfRfT5tGNNePRxyIv0FYOAIUb
 EpLMcOnXrHQjE7jwmCepDRZCStEj+xgeTqBoX3mEDGK39+YewrVT5nmJhmRqQF+a8rlPxxVO0Mf
 VC416MMXpJzPHpzE0FR493kGqGGivb/Uiag==
X-Gm-Gg: AY/fxX5D5W1sAsrnebTGpy2w1wvHnDM+fguHBmY8Rb+soLtCTP+cosgADvACP4i56tU
 mY4qTdf4TIcTB5g2eMH1zLPdeDmTqmoaj2BHfIZC6q5X/SiySUzLxpCLP/Rb8D4C2dbAQFSToOa
 1XJbMLH5ilSBdqeioJLSTrs3PyEyh59Cgzctc4T6bZmL2dAb/nE4KyyttCN1gcHWM4ZhRO+hXks
 CeBQkknhZ/B4Td+830huNZmq/uCY7X8bN8O/j4bq1aYsOYNlcmgZ//QC1Mh4YqFDgIVD3FtuAU9
 RMiMzys1CykAHmj9zF1CpvJA4A==
X-Google-Smtp-Source: AGHT+IHRCSAH3tWjRfjvmmgZLV9E/gQ5FqscJhX5/WW4bKnKFeqzMTe5q/gvtZ0F8uf61bC0fdMZ6dZJLxQlTXDSQ28=
X-Received: by 2002:a17:907:c06:b0:b87:2410:5957 with SMTP id
 a640c23a62f3a-b8724105b20mr383478866b.48.1768276094022; Mon, 12 Jan 2026
 19:48:14 -0800 (PST)
MIME-Version: 1.0
References: <20260112090458.2345280-1-djordje.todorovic@htecgroup.com>
 <20260112090458.2345280-3-djordje.todorovic@htecgroup.com>
In-Reply-To: <20260112090458.2345280-3-djordje.todorovic@htecgroup.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 13 Jan 2026 13:47:47 +1000
X-Gm-Features: AZwV_QhJ90KVk3cYJzPQiJqUobxKAg7N6Q8HA7aDlorZDUpRSMhNTcWWYazZ8Kc
Message-ID: <CAKmqyKN4KGymXXmHorKzRZcP=XCu_BOE2Ks72P5h9qRuVUpFng@mail.gmail.com>
Subject: Re: [PATCH v1 2/2] target/riscv: Fix null pointer dereference in
 cpu_set_exception_base
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>, 
 "cfu@mips.com" <cfu@mips.com>, "philmd@linaro.org" <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x629.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jan 12, 2026 at 7:05=E2=80=AFPM Djordje Todorovic
<Djordje.Todorovic@htecgroup.com> wrote:
>
> Add missing return statement after logging the error when cs is NULL.
>
> Resolves: Coverity CID 1644077
>
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 3b9d17d58d..10ece4bf63 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -83,6 +83,7 @@ void cpu_set_exception_base(int vp_index, target_ulong =
address)
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "cpu_set_exception_base: invalid vp_index: %u",
>                        vp_index);
> +        return;
>      }
>      cpu =3D RISCV_CPU(cs);
>      cpu->env.resetvec =3D address;
> --
> 2.34.1

