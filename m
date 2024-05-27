Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A41AEC25B79
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 05:09:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBSbv-0003e1-0z; Mon, 27 May 2024 01:09:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBSbo-0003dO-OO; Mon, 27 May 2024 01:09:21 -0400
Received: from mail-lf1-x12b.google.com ([2a00:1450:4864:20::12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sBSbm-0007fI-Vr; Mon, 27 May 2024 01:09:20 -0400
Received: by mail-lf1-x12b.google.com with SMTP id
 2adb3069b0e04-52965199234so3077517e87.2; 
 Sun, 26 May 2024 22:09:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1716786557; x=1717391357; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5unej+xpbJlqvGivkj6VOJakoQDFJ0Y4udGcKkDJqVg=;
 b=iSBio7tiNuXD+qjNIFy3lfxVDhaTmFL/ZHzus7uK/Ib4334dkvMFueG9XBr07DT4n+
 cBY4TEc9lVvWGyCMPosAaq4ccgMnjbTwoUqq7gFLSnOUdqcokleImMeXwanMjbTABGq1
 VqqPJP1QydQBcpd/8oACiCwJYgo1zscbcADtKlfBcl3TLS876vx67vgik0UYbRKwFTjD
 9rQ3yu0Zi7fZZLUKGw3RgbZrQLFkYfMWs6lSXGOa2sVrAovx5hE6BKZon1B3d+l/Ibyf
 RNPSXOjH3n3YruHJ1/6/oDE1FWoYKldpfNUCvmDjzOyftsCCtDzD4j/4q64gwp8o0Mys
 /YWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716786557; x=1717391357;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5unej+xpbJlqvGivkj6VOJakoQDFJ0Y4udGcKkDJqVg=;
 b=qd9wyHyyklNmOaUnS1a25jwb3uRlQiP7k85KAi3gKFRoDy2s3Em+ymV+At+uyPPfJv
 5c7+pkJgQclL5FGXPheycfCSbiVHq3WJC49LvJmiZ4ZHR9XEcCXdLa/eA1YepfPpd7Ze
 OVlCY2rtZ6r0wmYknAHSOdTvtcDtinFrYz2IEZ2e92wVob6rXC3gUom/QtjmTtSdWEWV
 WnpoOUuL4nP0txmVNvNXxFCsOr1/FX8bKstihADIG12yVL6yeweSQzmbNsLwU5qw/n9w
 5B3E05ayWRTdRuNqnRCD4MWfSCSgDAhu19z1f9wA9np7IRBfTIKdNZEqvPe+mRZpcO+u
 fUvA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVladSOFQELXXB0v7QQJZWawsldXhGy0OD9H3BcOLii8tb8x4o/ru5OvIJoZQ3Mkcrer3Fr0ivK0Ffdi/S7OE6HEHooWhzjObAVQy4/cEYA/po6yzHyDDhwjcoiqw==
X-Gm-Message-State: AOJu0YxDdyX2q8/RjKeYTDeeSXfLbqeEhcO1qiNB+MRVJ89SknN9QMIT
 HSYpelXGRruaE3eOm0+8e8Bew0aMulJEN7vDnBnjPs2F9mRbBJwtTT0KWPSEUlwaIrU8lRQbn72
 RYQl02R57VqYtKX+rUdT7s+04bFk=
X-Google-Smtp-Source: AGHT+IHE3yks1omk9UZwFMVu4Y4pFfocf0sLgq1QNXdocwvaz4EWOT7/+4srxAveI0a0vZaRZdGLkCBBqdUeSQoDXKA=
X-Received: by 2002:a19:f716:0:b0:51c:bd90:e60b with SMTP id
 2adb3069b0e04-529649c5e74mr4847171e87.25.1716786556576; Sun, 26 May 2024
 22:09:16 -0700 (PDT)
MIME-Version: 1.0
References: <20240516123336.63534-1-jerry.zhangjian@sifive.com>
In-Reply-To: <20240516123336.63534-1-jerry.zhangjian@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 27 May 2024 15:08:49 +1000
Message-ID: <CAKmqyKNLGxB3D0z9UjoLwmeusXASx3LyDo_QV-ONVJqJf46AFA@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: zvbb implies zvkb
To: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
Cc: alistair.francis@wdc.com, palmer@dabbelt.com, frank.chang@sifive.com, 
 max.chou@sifive.com, paul.walmsley@sifive.com, qemu-devel@nongnu.org, 
 qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12b;
 envelope-from=alistair23@gmail.com; helo=mail-lf1-x12b.google.com
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

On Thu, May 16, 2024 at 10:35=E2=80=AFPM Jerry Zhang Jian
<jerry.zhangjian@sifive.com> wrote:
>
> - According to RISC-V crypto spec, Zvkb extension is a proper subset of t=
he Zvbb extension.
>
> - Reference: https://github.com/riscv/riscv-crypto/blob/1769c2609bf453563=
2e0c0fd715778f212bb272e/doc/vector/riscv-crypto-vector-zvkb.adoc?plain=3D1#=
L10
>
> Signed-off-by: Jerry Zhang Jian <jerry.zhangjian@sifive.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/tcg/tcg-cpu.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/target/riscv/tcg/tcg-cpu.c b/target/riscv/tcg/tcg-cpu.c
> index 40054a391a..f1a1306ab2 100644
> --- a/target/riscv/tcg/tcg-cpu.c
> +++ b/target/riscv/tcg/tcg-cpu.c
> @@ -658,6 +658,10 @@ void riscv_cpu_validate_set_extensions(RISCVCPU *cpu=
, Error **errp)
>          cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvbc), true);
>      }
>
> +    if (cpu->cfg.ext_zvbb) {
> +        cpu_cfg_ext_auto_update(cpu, CPU_CFG_OFFSET(ext_zvkb), true);
> +    }
> +
>      /*
>       * In principle Zve*x would also suffice here, were they supported
>       * in qemu
> --
> 2.42.0
>
>

