Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE28C38150
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 02:02:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQdhF-0008Ug-Vv; Sun, 07 Jul 2024 22:01:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sQdhE-0008TJ-MX; Sun, 07 Jul 2024 22:01:40 -0400
Received: from mail-ua1-x92c.google.com ([2607:f8b0:4864:20::92c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sQdhD-0007mM-08; Sun, 07 Jul 2024 22:01:40 -0400
Received: by mail-ua1-x92c.google.com with SMTP id
 a1e0cc1a2514c-8101b144fddso806858241.3; 
 Sun, 07 Jul 2024 19:01:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720404097; x=1721008897; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j8KuolbZbpJz3+BmmHTAiTNBanrZbLCa5wxZZONf+54=;
 b=UB/IuwwIc5YAjS39ljHcauH8kHPI3iUzj+BMHLVnex8wsKyqs/3w35brZ/7LLc8Sax
 H3OZbTKQcEIdK6TYAG/bu5LSTOOUyd0UnQrxDzYtSNFGZZ1F9Fyu2rXDmw/YkuekNSpJ
 C9MIp89r5UjUpjtov/UgJyzSiQDLzkxAv0j6QUNIAfvmMNJnpNgDHR89fau9AKoZP5zY
 TZPXYiaanD8MZhESSz8OIjEuvU8eOaoy4L2C5i2bMhkQMt5cV0LAcK8XegnA1c4aUf6H
 ZjjE1cX5EW003NJDTR7ItKBpWHg4JERXmws2Y+N2TzvBodFbb67pbr+rq1yUNdlrqlLx
 lCCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720404097; x=1721008897;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j8KuolbZbpJz3+BmmHTAiTNBanrZbLCa5wxZZONf+54=;
 b=A2ntDAHPqeTSTxSpy+DWjjmvjPEvXI6RjKV6jHMvROHAyWt/U6/+VQgLKxvG+615W8
 HsDDCHbJEE5P37T1+XEv2AnRnH/XmZtVTrV0I3FDbJpVn+liYyGcKJ3xfr56LMWu5+7x
 ZucZU8oSxcPOAjXSjaPhtTm78yaMSmNCxpz8KP0g3TUocoGcZYUiRNoPAKHQjwKW12Cf
 kahsZiTZ7bI70ByXeFHlPvE1aexuRjuP4K7LVyw78KEWSphJ0rD506lrq9QiMCML+Vjx
 A6fO7n3H8thKJjNy1hpIgXmAfoqqJCx5iPJZllo2LXmpyoifVzedVnMnBkmrug8kAm8y
 V7Nw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXMh4cFlTzHF/ZEUy/2Ek/+86O9UDVTpPgUd1b01gP69U2iomPr132f8ETmZWBEBq7y1zBDrE1zGq9rTkTs/685m2HERE=
X-Gm-Message-State: AOJu0YyHCeMQjxn00LhCBZ0P6VgMCmMWQ/JXsDhClcbBw+h/4AqB9Wwp
 S0y2GYOgJw1Um9y2BkgNbpn2yaQxWBW2fhuggXCFCCtaIa/ujRHc4b0Dwl1H02pfSBWKJ+FefZV
 8S+9+Kczda90zhfmKmUGEWo7ELIM=
X-Google-Smtp-Source: AGHT+IELvzKzZT6HXpcgEdE8YIVgHpBKi0abZvUerIaLn7230gCoflxJbITp846b034X+BLRErezluZzzvzftKqrSTw=
X-Received: by 2002:a05:6122:6607:b0:4f2:f1df:89c3 with SMTP id
 71dfb90a1353d-4f2f3adde5amr11429499e0c.0.1720404097127; Sun, 07 Jul 2024
 19:01:37 -0700 (PDT)
MIME-Version: 1.0
References: <20240703144921.1281-1-zhiwei_liu@linux.alibaba.com>
 <20240703144921.1281-4-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240703144921.1281-4-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 8 Jul 2024 12:01:10 +1000
Message-ID: <CAKmqyKOXuOtonzLY775VbcA92eHFE7N7TgAMm9yXQHG2f=Td+Q@mail.gmail.com>
Subject: Re: [PATCH v3 3/7] target/riscv: Correct SXL return value for RV32 in
 RV64 QEMU
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 bmeng.cn@gmail.com, TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::92c;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x92c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Jul 4, 2024 at 12:53=E2=80=AFAM LIU Zhiwei <zhiwei_liu@linux.alibab=
a.com> wrote:
>
> From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>
> Ensure that riscv_cpu_sxl returns MXL_RV32 when runningRV32 in an
> RV64 QEMU.
>
> Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
> Fixes: 05e6ca5e156 ("target/riscv: Ignore reserved bits in PTE for RV64")
> Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu.h | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 87742047ce..49de81be7e 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -693,8 +693,11 @@ static inline RISCVMXL riscv_cpu_sxl(CPURISCVState *=
env)
>  #ifdef CONFIG_USER_ONLY
>      return env->misa_mxl;
>  #else
> -    return get_field(env->mstatus, MSTATUS64_SXL);
> +    if (env->misa_mxl !=3D MXL_RV32) {
> +        return get_field(env->mstatus, MSTATUS64_SXL);
> +    }
>  #endif
> +    return MXL_RV32;
>  }
>  #endif
>
> --
> 2.25.1
>
>

