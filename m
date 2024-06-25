Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D16CC30653
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 00:33:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMGRE-0000A4-Fs; Tue, 25 Jun 2024 20:23:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMGQy-00007i-BI
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 20:22:54 -0400
Received: from mail-qk1-x733.google.com ([2607:f8b0:4864:20::733])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sMGQD-0003BL-KM
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 20:22:34 -0400
Received: by mail-qk1-x733.google.com with SMTP id
 af79cd13be357-79c076c0d83so70585685a.3
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 17:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719361254; x=1719966054; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fbp/p0rJJv8e2G4lRh69XillF98ah82eoVD3RJE9QZM=;
 b=PmxWptYW7EYG37CdoeV+4OxwDd5pe0xPGbSHqGpSXfcSKElNClaePoOcZyNWcBVUE0
 wSMaZ/b/BYTFEvaaeufM2sOZ+k9ADZYVWrehu/6dxCI0daLWI30H1pCRfmMt1siCrUfL
 nZpagfJBIHmExtc78V2292E8WCumnH6DHhcvI+BBaLWUaQMqMLBodxOHMuIY/xF4+UmM
 1Xeq+LCxs0zYiy+DT50YWVh+tnq1+8ko/9IwgwKfFqd76+oT/sNhB/2TeZ8W0NOIlIul
 pvD9f75yeG9YRbyEu6Pst8s7wjLeyOLGOaaDLBU6TXzX6FevT4hsG5qQDcHWMBD2A3sD
 6Jrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719361254; x=1719966054;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Fbp/p0rJJv8e2G4lRh69XillF98ah82eoVD3RJE9QZM=;
 b=QMBNPZZkJlak2j4LpygErY02whKhxJqbySzE0YX8a6QwroR5/DgPgTfXm4Q6lr7o3u
 3Y1HWsAwhdfJGNCNPzbTduf93BxfW/mI4sVZxB7qhho+xI08RiCfwh89yoyQmSvQ5DJ6
 Njx/x0K2iYqFD9YKJeqUvLfG/Imkav1EB+bSDw5+F1U0RDfEB7TY1j0c3mXofTHb9BJp
 0iKwJRmRJ5pFaO5iAM7TFpuxLbVCsPIPwRcGPfohVanPPrbiDqZKmb4MOEr6o4mAH8uo
 4HnN7seawFu1zWzB+J1SOZjcHJzAVMbnGGGS32McVksO2qOfA2iN1vAc7s15+SJzJkWH
 ecfg==
X-Gm-Message-State: AOJu0YznD5a0jLH3kS/wMEe2yWeewy0Zhkctn32zxXLLNDaSptelM+/e
 aZl9oBRbLKJJG6Fs2WWQs9gkTbV7Ocery2YqkfoC6r05h3i9HNQIv9RKCGDd33TgIqO6FgI/YSR
 2l7O+Nmh2oLrzG59if7mI+TRcXFwPRg==
X-Google-Smtp-Source: AGHT+IGSulW5NySdGWHKmNhJudYLsEgTAxBqXOYbIi9guoYzOMJN+ELfChd/HcSLO2Tz1I1MNai2oDFbf9we6IV5UUs=
X-Received: by 2002:a05:6122:1827:b0:4ef:5b2c:df25 with SMTP id
 71dfb90a1353d-4ef6d8094eemr8011295e0c.6.1719359629029; Tue, 25 Jun 2024
 16:53:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240625114629.27793-1-frank.chang@sifive.com>
 <20240625114629.27793-2-frank.chang@sifive.com>
In-Reply-To: <20240625114629.27793-2-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 26 Jun 2024 09:53:22 +1000
Message-ID: <CAKmqyKOdM3_2tQKN=kJn5sR2YCR8xvHT-bqR10oqnvhrNhin6w@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] target/riscv: Introduce extension implied rules
 definition
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 "open list:RISC-V TCG CPUs" <qemu-riscv@nongnu.org>,
 Jerry Zhang Jian <jerry.zhangjian@sifive.com>, 
 Max Chou <max.chou@sifive.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::733;
 envelope-from=alistair23@gmail.com; helo=mail-qk1-x733.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Jun 25, 2024 at 9:47=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> RISCVCPUImpliedExtsRule is created to store the implied rules.
> 'is_misa' flag is used to distinguish whether the rule is derived
> from the MISA or other extensions.
> 'ext' stores the MISA bit if 'is_misa' is true. Otherwise, it stores
> the offset of the extension defined in RISCVCPUConfig. 'ext' will also
> serve as the key of the hash tables to look up the rule in the following
> commit.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Jerry Zhang Jian <jerry.zhangjian@sifive.com>
> Tested-by: Max Chou <max.chou@sifive.com>
> Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.c |  8 ++++++++
>  target/riscv/cpu.h | 23 +++++++++++++++++++++++
>  2 files changed, 31 insertions(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 4760cb2cc1..7b071ade04 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -2250,6 +2250,14 @@ RISCVCPUProfile *riscv_profiles[] =3D {
>      NULL,
>  };
>
> +RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[] =3D {
> +    NULL
> +};
> +
> +RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[] =3D {
> +    NULL
> +};
> +
>  static Property riscv_cpu_properties[] =3D {
>      DEFINE_PROP_BOOL("debug", RISCVCPU, cfg.debug, true),
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 90b8f1b08f..87742047ce 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -124,6 +124,29 @@ typedef enum {
>      EXT_STATUS_DIRTY,
>  } RISCVExtStatus;
>
> +typedef struct riscv_cpu_implied_exts_rule {
> +#ifndef CONFIG_USER_ONLY
> +    /*
> +     * Bitmask indicates the rule enabled status for the harts.
> +     * This enhancement is only available in system-mode QEMU,
> +     * as we don't have a good way (e.g. mhartid) to distinguish
> +     * the SMP cores in user-mode QEMU.
> +     */
> +    unsigned long *enabled;
> +#endif
> +    /* True if this is a MISA implied rule. */
> +    bool is_misa;
> +    /* ext is MISA bit if is_misa flag is true, else multi extension off=
set. */
> +    const uint32_t ext;
> +    const uint32_t implied_misa_exts;
> +    const uint32_t implied_multi_exts[];
> +} RISCVCPUImpliedExtsRule;
> +
> +extern RISCVCPUImpliedExtsRule *riscv_misa_ext_implied_rules[];
> +extern RISCVCPUImpliedExtsRule *riscv_multi_ext_implied_rules[];
> +
> +#define RISCV_IMPLIED_EXTS_RULE_END -1
> +
>  #define MMU_USER_IDX 3
>
>  #define MAX_RISCV_PMPS (16)
> --
> 2.43.2
>
>

