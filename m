Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A6DC0218A
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 02:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdgN1-0004GW-5N; Thu, 30 Jan 2025 21:02:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tdgMt-0004FN-LA; Thu, 30 Jan 2025 21:02:51 -0500
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tdgMr-0005eN-RN; Thu, 30 Jan 2025 21:02:51 -0500
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-5174f9c0d2aso477166e0c.1; 
 Thu, 30 Jan 2025 18:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738288968; x=1738893768; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ELeHiLIcvWFtBOb3UEB1APK3nptoSWpTN2v5XS8N6Kc=;
 b=ivZhFH/Y5BkBQpN6tTljGNfmxsh4HXUFt7HMnw1h4lJW1+dXDfoDQq0YhLn0AmCV0c
 kT7YkpcIIca/OQHpPeup7o7k6MeUWyEHawE8h3sV6pE/IZdBOVtCHkzK0LMZrMzEzcsZ
 A76Hj5aTglc2YxrNqf8Vcv6sdM3b9+AjnWfHaR6PE7+lwsB8lc3ITYcuqTaXPLvcxXg+
 USqeDxddltqtUfHxB9ss5KDN0S7XklMF+3v2iZgWwzfowqGUF0wHLqaXwblQQjA4/dBW
 Js0GGT87NQbRgJ3NT1Y4gRZ2pCy+pHTA/aYSemIdP0RETRVEPfSL8ZN06aq3H463AhDI
 mzFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738288968; x=1738893768;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ELeHiLIcvWFtBOb3UEB1APK3nptoSWpTN2v5XS8N6Kc=;
 b=nyFZrH9Qj2ItGAa76RRDJ/kfhPdFC/jSqB5gaJ47yJvtoBjs66GFMOm9qTDfFLEICZ
 ayN9qMWTQCTFdvevAiPuGpjoQTVewxpSViBKkl9l1aXDuz1US+YJJBlyDsx08cWOIYfp
 DamxFRKKPIRhrETOtxMTmOZAAim1NJMT3Sd4HYFmoUlrDJnwNywugPyotqDqZ5CISMXP
 0XzHV3zkn55wEvn9IuZXFbYzJGHBcOYG3lE82YXMhn2ZZPAIWdauDkGkzAYEDaGm0bk3
 s5soVFCkT11mgMV/1y+m6twVF5okb3FeY4KGB50xtz7nqaaaHoy+olSSUZiaVjVDNRCV
 /+xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFO6w7kNQX53o0baxszUrRowYXzJvkSFr4kgoPwJjBId+LYlOkLyjc8yEzksxaS+fq4jw1n3WTB+ja@nongnu.org
X-Gm-Message-State: AOJu0YzEP9/UxrtV3qneOUoeQdbJK71KwIwmfsieY0CEwqZDfr9GKGRJ
 i9x7h7qajLPdrkaSA0E3nPjIwABNFS4KC0U5N+WmQ7vbKGGesNuphbiIQgdbhgTLHVZv1qbrOiY
 eqB53c8hA/em8zA88sKfTWmtKd8Dbzg==
X-Gm-Gg: ASbGncsC+BeRw8IequEYtwB7TJM2bi6BYNtI32JWInMjkpr8iarLgUIqIb7385DQUJs
 iW+d41+zShKap2qidDvlNnrQ/EA5D+1eSznOnEihSyuvzSpqo3f+rLlemKYt9POff+PM3BW92I2
 XcKnd9SgCtvSjomyiTPBzuaVWlk5U=
X-Google-Smtp-Source: AGHT+IE0pjK4efEoR/3hoYuZPYgCcYJbLnzn2JxTtFzJTV63OWehQhbIzUYr68ci9zvocQxAToVzQatiqLSao9VYHFY=
X-Received: by 2002:a05:6122:4281:b0:518:773b:39f with SMTP id
 71dfb90a1353d-51e9e3fe69fmr10114175e0c.4.1738288967529; Thu, 30 Jan 2025
 18:02:47 -0800 (PST)
MIME-Version: 1.0
References: <20250116161007.39710-1-vliaskovitis@suse.com>
In-Reply-To: <20250116161007.39710-1-vliaskovitis@suse.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 31 Jan 2025 12:02:21 +1000
X-Gm-Features: AWEUYZmQCdd9iVzwkFnxH5WQxuvT8CR6XFcH9_I1AbVZS1SgIrQr4SuttlgtgEk
Message-ID: <CAKmqyKOo+XT=rWdcjp6CYnWuw-iv71p_5dELt6dCOGakDBeVbA@mail.gmail.com>
Subject: Re: [PATCH v3] hw/riscv/virt: Add serial alias in DTB
To: Vasilis Liaskovitis <vliaskovitis@suse.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, jason.chien@sifive.com, 
 zhiwei_liu@linux.alibaba.com, dbarboza@ventanamicro.com, 
 ajones@ventanamicro.com, bmeng.cn@gmail.com, liwei1518@gmail.com, 
 philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa30.google.com
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

On Fri, Jan 17, 2025 at 2:13=E2=80=AFAM Vasilis Liaskovitis
<vliaskovitis@suse.com> wrote:
>
> Add an "aliases" node with a "serial0" entry for the single UART
> in the riscv virt machine.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/2774
> Signed-off-by: Vasilis Liaskovitis <vliaskovitis@suse.com>
> Reviewed-by: Andrew Jones <ajones@ventanamicro.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  hw/riscv/virt.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 2bc5a9dd98..fb1928cebf 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -971,6 +971,7 @@ static void create_fdt_uart(RISCVVirtState *s, const =
MemMapEntry *memmap,
>      }
>
>      qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
> +    qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", name);
>  }
>
>  static void create_fdt_rtc(RISCVVirtState *s, const MemMapEntry *memmap,
> @@ -1180,6 +1181,8 @@ static void create_fdt(RISCVVirtState *s, const Mem=
MapEntry *memmap)
>      qemu_fdt_setprop(ms->fdt, "/chosen", "rng-seed",
>                       rng_seed, sizeof(rng_seed));
>
> +    qemu_fdt_add_subnode(ms->fdt, "/aliases");
> +
>      create_fdt_flash(s, memmap);
>      create_fdt_fw_cfg(s, memmap);
>      create_fdt_pmu(s);
> --
> 2.46.0
>
>

