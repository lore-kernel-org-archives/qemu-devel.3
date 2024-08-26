Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F4D5C5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 00:24:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siNWB-00037m-6X; Sun, 25 Aug 2024 20:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1siNW9-00034R-Bb; Sun, 25 Aug 2024 20:23:33 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1siNW7-0002gg-3V; Sun, 25 Aug 2024 20:23:32 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5befd2f35bfso4375199a12.2; 
 Sun, 25 Aug 2024 17:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1724631809; x=1725236609; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yWpIgJ/2PZAzjgerYFKCsRdOCl9Nb8U+roCJxlAnDJU=;
 b=BcBDAWHGENRuOq5nZOHUFS/bGA0WCgcqf8zwE9Ritoh4WYvu2o6ZDgchhEJcn7fQe4
 KGfOl8gopJlHL7f55Kv3nFEgMeIBxqaeSs253Uztzf9r+XaiMV1CFpHplwwglS4etdkh
 421NyPzPjTNgWwQCz4QoXGGoz8ychiQHdMnYFKDtD7+DIIxNbnPyRnJwFQczZFFrXDHI
 rBFM00+y3RHRopmZl0gD++Rgac1QPTQXboQtN1iNeYAvf3dXHvKArxiI8JhIts7Gt/CG
 riNfPbV58N8RG5K/MK3bdgKpLdFwiGzYo3/rBwnUsahj+yElnqfmCq+MmBHh0pkV09Kf
 X3iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724631809; x=1725236609;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yWpIgJ/2PZAzjgerYFKCsRdOCl9Nb8U+roCJxlAnDJU=;
 b=Jo8ag7nX3dUUXCTLPMovzaT/8Vyx9XjqGGQ0SsDnsitqc8xQOI0MlJjFcI42oZ6Rvs
 dBmhm+MTkhVYW4HWDM45fDeM5HOeVxRKyuEXIPPAeL4dRAh6ie11mxXD1jMobeJHxUop
 I38YUUQIqpT+KtOvNDfyS6e0aSRqzaTPwoyXjcWiNc7NLhJejTnmZJZuj/aHmtMrA2wW
 h40EeWffu0F36xfNd6fq6VMkIFHPoxxQj1ApHeq2b9WMpU6ICJv8BSHhOu2Llbo7Vy2Z
 lYgHhPeG3SL471dROREsWMBrs+eNnRX8Gc6QtTAX0uLa0fHjOGTAiu/UwkGjacVU11jn
 cjMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWS5BlgOjF0PKFMG7yuqOm01uvcwXTLlLdpL+UniwL2uMo4HP5Jj6nhSvIgArmZjN7+M/+7Z3JVYGRb@nongnu.org
X-Gm-Message-State: AOJu0YyHuDGspk0ZzgNT5A3bLuWqJ09qG9U2G7ftyFpKtt0L5re0cWab
 Oy+aLW6OhONH6HUseRM3qLoShDetHaBRB13SW/FpZZtd2FY56LZ+4BAO0l3V1VS8t9QzMl/zF4f
 RfWDtBeZYxRUYCB+GpEp4Ym5D+V5DAXqyvYQ=
X-Google-Smtp-Source: AGHT+IFt1REYcQw0r4RDxk8Ss3GfFWdH/dM7Uwfw0UzgiGCCwJxVt0UXgwXPlAS5mBIxO4rTb2doLAnp3+2df+rvjdg=
X-Received: by 2002:a05:6402:2354:b0:5c0:a8d0:8be6 with SMTP id
 4fb4d7f45d1cf-5c0a8d08c67mr1309072a12.19.1724631807985; Sun, 25 Aug 2024
 17:23:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240823003231.3522113-1-alistair.francis@wdc.com>
In-Reply-To: <20240823003231.3522113-1-alistair.francis@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 26 Aug 2024 10:23:00 +1000
Message-ID: <CAKmqyKMx=oW=-yCSONMWXjS_39QOF=gRxaGxWddL8iq7ryo3sQ@mail.gmail.com>
Subject: Re: [PATCH] target: riscv: Enable Bit Manip for OpenTitan Ibex CPU
To: qemu-devel@nongnu.org
Cc: liwei1518@gmail.com, atishp@rivosinc.com, bmeng.cn@gmail.com, 
 zhiwei_liu@linux.alibaba.com, qemu-riscv@nongnu.org, 
 dbarboza@ventanamicro.com, Alistair Francis <alistair.francis@wdc.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=alistair23@gmail.com; helo=mail-ed1-x531.google.com
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

On Fri, Aug 23, 2024 at 10:32=E2=80=AFAM Alistair Francis <alistair23@gmail=
.com> wrote:
>
> The OpenTitan Ibex CPU now supports the the Zba, Zbb, Zbc
> and Zbs bit-manipulation sub-extensions ratified in
> v.1.0.0 of the RISC-V Bit- Manipulation ISA Extension, so let's enable
> them in QEMU as well.
>
> 1: https://github.com/lowRISC/opentitan/pull/9748
>
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/cpu.c | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a90808a3ba..7e13fb2c0f 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -701,6 +701,11 @@ static void rv32_ibex_cpu_init(Object *obj)
>      cpu->cfg.ext_zicsr =3D true;
>      cpu->cfg.pmp =3D true;
>      cpu->cfg.ext_smepmp =3D true;
> +
> +    cpu->cfg.ext_zba =3D true;
> +    cpu->cfg.ext_zbb =3D true;
> +    cpu->cfg.ext_zbc =3D true;
> +    cpu->cfg.ext_zbs =3D true;
>  }
>
>  static void rv32_imafcu_nommu_cpu_init(Object *obj)
> --
> 2.46.0
>

