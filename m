Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A70BC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2024 01:45:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sGqZu-0004Jp-SK; Mon, 10 Jun 2024 21:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sGqZq-0004JG-JK; Mon, 10 Jun 2024 21:45:36 -0400
Received: from mail-vk1-xa2c.google.com ([2607:f8b0:4864:20::a2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sGqZl-0006GN-0m; Mon, 10 Jun 2024 21:45:34 -0400
Received: by mail-vk1-xa2c.google.com with SMTP id
 71dfb90a1353d-4e4f05835b5so2941903e0c.0; 
 Mon, 10 Jun 2024 18:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1718070328; x=1718675128; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uoK4mhxbPgcSMBl3V0sVM/yDgj3Tg4jeUzBf/pZn4bw=;
 b=Xa/1t/O7xrCU3624Y1gwewCFswMGVlshQdveppw8w+bGmsjdrcgkoPhTK5J/XLIhTu
 DeLMbSAjDFlW1Ey5OI9i97lsfz0gd2XtzTFpYx+jb6GvESVxg+cd4a3H8T7xGsZ0fi7z
 GqY8S2DpB11HWDIVGJwfX0BwZ8pfrp780bh7TnrMV4OW9Nbh8OvLJi/CsG402ZyMbj19
 nr89t6f0I/JNxcRw+2SxTChtQ7QqIyaXQq1T3gFIPUZxfHTjToxWaRyMmHKYFu71fPCG
 LGQLhTlQmsOofqnI/aOtBtu5EiGh8h0UANLPrf6eBxcSTiZtHJXKWXq2dnTShj/uHZk6
 b2Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718070328; x=1718675128;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=uoK4mhxbPgcSMBl3V0sVM/yDgj3Tg4jeUzBf/pZn4bw=;
 b=klJfm0EdWvFL5wY8mPaB9yxh7P8evhEsXOu3MLyHZSP17493RfYNLZw4JbHo8hq6I4
 jfQhakXoqMGrf1LgmKUmbEamNi9vWbuZCGLpVm5PAKQ2pkysjP5IKQ3OeOICRiA+imtv
 Bp82X+bo7ycv3qQtPZPFociv/zy2WE65X6oijAt4X+qLiI5XM7nQw+59wrWfyit1QVPF
 Ku5AzIuOdvfuE5h73cGQgUStSkBShMUszR5f7PajtDkfzBPpgyri33lMNFiO7yd8h/I8
 SGSvUMK3WxRMwKHgm775DRXkTDCXQlwS7++1t6u3n2y2LebBsdjGzgc1Zc4v36IN/AwX
 JY/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCV/wjmw2oaWvIzPXm7+KKiU/Z60+2CUW0hN8uIwI4Z4pA3wGtQaQyhopIhcym6TDd2/J8p+SUEcJYBzolf/Qm2uPMRF708=
X-Gm-Message-State: AOJu0Yx69Ax011FP6yYzzmz7Cyo9izkUR3SHY/O9RK2bfZwhd7E6c6k3
 pyvEQlRfvCJHTWpmXfOB1vxVv5XeAogzuTXGJltGWEvixKKVqDgHfM3z+azZcH0g2Ot3ro0y93y
 gIroheCmpzJTXDA8PPpD27Dt1BZ8=
X-Google-Smtp-Source: AGHT+IF9a4IPCdDKJUBZdWlmLeML3c5hnZQ3AKjH0t72vEYHQqFvG5UqveV1BoO+d41hMDSyLNM1VR4sg0JKp/DNRYQ=
X-Received: by 2002:a05:6122:3990:b0:4eb:d2a:293b with SMTP id
 71dfb90a1353d-4ecf28b5f85mr1522307e0c.5.1718070327617; Mon, 10 Jun 2024
 18:45:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240605063154.31298-1-frank.chang@sifive.com>
 <20240605063154.31298-5-frank.chang@sifive.com>
In-Reply-To: <20240605063154.31298-5-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 11 Jun 2024 11:45:01 +1000
Message-ID: <CAKmqyKNZNX-NO1GBd8s5fqm25=YOCeWVyq3RX4BsQvdGCQNT0Q@mail.gmail.com>
Subject: Re: [PATCH RESEND 4/6] target/riscv: Add standard extension implied
 rules
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2c;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01,
 UPPERCASE_50_75=0.008 autolearn=no autolearn_force=no
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

On Wed, Jun 5, 2024 at 4:35=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> Add standard extension implied rules to enable the implied extensions of
> the standard extension recursively.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c | 340 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 340 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index a6e9055c5f..80b238060a 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2289,12 +2289,352 @@ static RISCVCPUImpliedExtsRule RVV_IMPLIED =3D {
>      },
>  };
>
> +static RISCVCPUImpliedExtsRule ZCB_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_zcb),
> +    .implied_exts =3D {
> +        CPU_CFG_OFFSET(ext_zca),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZCD_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_zcd),
> +    .implied_misas =3D RVD,
> +    .implied_exts =3D {
> +        CPU_CFG_OFFSET(ext_zca),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZCE_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_zce),
> +    .implied_exts =3D {
> +        CPU_CFG_OFFSET(ext_zcb), CPU_CFG_OFFSET(ext_zcmp),
> +        CPU_CFG_OFFSET(ext_zcmt),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZCF_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_zcf),
> +    .implied_misas =3D RVF,
> +    .implied_exts =3D {
> +        CPU_CFG_OFFSET(ext_zca),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZCMP_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_zcmp),
> +    .implied_exts =3D {
> +        CPU_CFG_OFFSET(ext_zca),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZCMT_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_zcmt),
> +    .implied_exts =3D {
> +        CPU_CFG_OFFSET(ext_zca), CPU_CFG_OFFSET(ext_zicsr),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZDINX_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_zdinx),
> +    .implied_exts =3D {
> +        CPU_CFG_OFFSET(ext_zfinx),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZFA_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_zfa),
> +    .implied_misas =3D RVF,
> +    .implied_exts =3D { RISCV_IMPLIED_EXTS_RULE_END },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZFBFMIN_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_zfbfmin),
> +    .implied_misas =3D RVF,
> +    .implied_exts =3D { RISCV_IMPLIED_EXTS_RULE_END },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZFH_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_zfh),
> +    .implied_exts =3D {
> +        CPU_CFG_OFFSET(ext_zfhmin),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZFHMIN_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_zfhmin),
> +    .implied_misas =3D RVF,
> +    .implied_exts =3D { RISCV_IMPLIED_EXTS_RULE_END },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZFINX_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_zfinx),
> +    .implied_exts =3D {
> +        CPU_CFG_OFFSET(ext_zicsr),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZHINX_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_zhinx),
> +    .implied_exts =3D {
> +        CPU_CFG_OFFSET(ext_zhinxmin),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZHINXMIN_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_zhinxmin),
> +    .implied_exts =3D {
> +        CPU_CFG_OFFSET(ext_zfinx),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZICNTR_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_zicntr),
> +    .implied_exts =3D {
> +        CPU_CFG_OFFSET(ext_zicsr),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZIHPM_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_zihpm),
> +    .implied_exts =3D {
> +        CPU_CFG_OFFSET(ext_zicsr),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZK_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_zk),
> +    .implied_exts =3D {
> +        CPU_CFG_OFFSET(ext_zkn), CPU_CFG_OFFSET(ext_zkr),
> +        CPU_CFG_OFFSET(ext_zkt),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZKN_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_zkn),
> +    .implied_exts =3D {
> +        CPU_CFG_OFFSET(ext_zbkb), CPU_CFG_OFFSET(ext_zbkc),
> +        CPU_CFG_OFFSET(ext_zbkx), CPU_CFG_OFFSET(ext_zkne),
> +        CPU_CFG_OFFSET(ext_zknd), CPU_CFG_OFFSET(ext_zknh),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZKS_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_zks),
> +    .implied_exts =3D {
> +        CPU_CFG_OFFSET(ext_zbkb), CPU_CFG_OFFSET(ext_zbkc),
> +        CPU_CFG_OFFSET(ext_zbkx), CPU_CFG_OFFSET(ext_zksed),
> +        CPU_CFG_OFFSET(ext_zksh),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZVBB_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_zvbb),
> +    .implied_exts =3D {
> +        CPU_CFG_OFFSET(ext_zvkb),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZVE32F_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_zve32f),
> +    .implied_misas =3D RVF,
> +    .implied_exts =3D {
> +        CPU_CFG_OFFSET(ext_zve32x),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZVE32X_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_zve32x),
> +    .implied_exts =3D {
> +        CPU_CFG_OFFSET(ext_zicsr),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZVE64D_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_zve64d),
> +    .implied_misas =3D RVD,
> +    .implied_exts =3D {
> +        CPU_CFG_OFFSET(ext_zve64f),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZVE64F_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_zve64f),
> +    .implied_misas =3D RVF,
> +    .implied_exts =3D {
> +        CPU_CFG_OFFSET(ext_zve32f), CPU_CFG_OFFSET(ext_zve64x),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZVE64X_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_zve64x),
> +    .implied_exts =3D {
> +        CPU_CFG_OFFSET(ext_zve32x),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZVFBFMIN_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_zvfbfmin),
> +    .implied_exts =3D {
> +        CPU_CFG_OFFSET(ext_zve32f),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZVFBFWMA_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_zvfbfwma),
> +    .implied_exts =3D {
> +        CPU_CFG_OFFSET(ext_zvfbfmin), CPU_CFG_OFFSET(ext_zfbfmin),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZVFH_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_zvfh),
> +    .implied_exts =3D {
> +        CPU_CFG_OFFSET(ext_zvfhmin), CPU_CFG_OFFSET(ext_zfhmin),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZVFHMIN_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_zvfhmin),
> +    .implied_exts =3D {
> +        CPU_CFG_OFFSET(ext_zve32f),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZVKN_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_zvkn),
> +    .implied_exts =3D {
> +        CPU_CFG_OFFSET(ext_zvkned), CPU_CFG_OFFSET(ext_zvknhb),
> +        CPU_CFG_OFFSET(ext_zvkb), CPU_CFG_OFFSET(ext_zvkt),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZVKNC_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_zvknc),
> +    .implied_exts =3D {
> +        CPU_CFG_OFFSET(ext_zvkn), CPU_CFG_OFFSET(ext_zvbc),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZVKNG_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_zvkng),
> +    .implied_exts =3D {
> +        CPU_CFG_OFFSET(ext_zvkn), CPU_CFG_OFFSET(ext_zvkg),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZVKNHB_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_zvknhb),
> +    .implied_exts =3D {
> +        CPU_CFG_OFFSET(ext_zve64x),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZVKS_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_zvks),
> +    .implied_exts =3D {
> +        CPU_CFG_OFFSET(ext_zvksed), CPU_CFG_OFFSET(ext_zvksh),
> +        CPU_CFG_OFFSET(ext_zvkb), CPU_CFG_OFFSET(ext_zvkt),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZVKSC_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_zvksc),
> +    .implied_exts =3D {
> +        CPU_CFG_OFFSET(ext_zvks), CPU_CFG_OFFSET(ext_zvbc),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
> +static RISCVCPUImpliedExtsRule ZVKSG_IMPLIED =3D {
> +    .ext =3D CPU_CFG_OFFSET(ext_zvksg),
> +    .implied_exts =3D {
> +        CPU_CFG_OFFSET(ext_zvks), CPU_CFG_OFFSET(ext_zvkg),
> +
> +        RISCV_IMPLIED_EXTS_RULE_END
> +    },
> +};
> +
>  RISCVCPUImpliedExtsRule *riscv_misa_implied_rules[] =3D {
>      &RVA_IMPLIED, &RVD_IMPLIED, &RVF_IMPLIED,
>      &RVM_IMPLIED, &RVV_IMPLIED, NULL
>  };
>
>  RISCVCPUImpliedExtsRule *riscv_ext_implied_rules[] =3D {
> +    &ZCB_IMPLIED, &ZCD_IMPLIED, &ZCE_IMPLIED,
> +    &ZCF_IMPLIED, &ZCMP_IMPLIED, &ZCMT_IMPLIED,
> +    &ZDINX_IMPLIED, &ZFA_IMPLIED, &ZFBFMIN_IMPLIED,
> +    &ZFH_IMPLIED, &ZFHMIN_IMPLIED, &ZFINX_IMPLIED,
> +    &ZHINX_IMPLIED, &ZHINXMIN_IMPLIED, &ZICNTR_IMPLIED,
> +    &ZIHPM_IMPLIED, &ZK_IMPLIED, &ZKN_IMPLIED,
> +    &ZKS_IMPLIED, &ZVBB_IMPLIED, &ZVE32F_IMPLIED,
> +    &ZVE32X_IMPLIED, &ZVE64D_IMPLIED, &ZVE64F_IMPLIED,
> +    &ZVE64X_IMPLIED, &ZVFBFMIN_IMPLIED, &ZVFBFWMA_IMPLIED,
> +    &ZVFH_IMPLIED, &ZVFHMIN_IMPLIED, &ZVKN_IMPLIED,
> +    &ZVKNC_IMPLIED, &ZVKNG_IMPLIED, &ZVKNHB_IMPLIED,
> +    &ZVKS_IMPLIED,  &ZVKSC_IMPLIED, &ZVKSG_IMPLIED,
>      NULL
>  };
>
> --
> 2.43.2
>
>

