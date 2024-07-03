Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51411C30658
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2024 02:29:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOpjj-0007D0-QQ; Tue, 02 Jul 2024 22:28:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOpjd-0007Av-Nq; Tue, 02 Jul 2024 22:28:41 -0400
Received: from mail-vs1-xe34.google.com ([2607:f8b0:4864:20::e34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sOpjX-0000Qx-SO; Tue, 02 Jul 2024 22:28:41 -0400
Received: by mail-vs1-xe34.google.com with SMTP id
 ada2fe7eead31-48fba334e95so1126484137.3; 
 Tue, 02 Jul 2024 19:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1719973713; x=1720578513; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NiXduaWiYD5qIkM01mZLNm3kaGNDHrb5nF8q+7P8K+M=;
 b=HJqnvL6L+7auc20TGqoijz1aEMmwj+RjA/3cMr2gZHoWvqF30NSxMv9Gg8TjCwF1y/
 FHTn8JauaZnpfZRNotHL/8HIhCp7HadUPEGxlqNf8ZEbbGucCiBNnKdxwSD4Xjx0ZNnR
 W4WCDfG5XKK+CmWZQM9T+iHEsVCrFgw2toelN97PRqyJdpE9YV7+A6qnxEdPDSd+YPHh
 /EFRMSdHX8W4HB55dlVNWOQ77+UE2pnIOirXxQznxiZdLpjVLTpZrGBNaFN+HL+fS2xV
 bc8gYFeCyCLg1xfLX2c9UaaZFIEfpZOePGOeCEm7x6oG71p8kh/4/jvCSyNWj4MWmKg5
 QVnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719973713; x=1720578513;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NiXduaWiYD5qIkM01mZLNm3kaGNDHrb5nF8q+7P8K+M=;
 b=WmnbNDWbpyNypepIA6AxvADXIjGc+J/UHqglKJmoHKLKZQ3uNZaQ8jmIo5aTxxZnEK
 f5khOcRSbp5pNt7Kr3KaQTm7+0+AzfXqdrUlWQ9ZwJxYahMW7Or2qcagv2WzLpWCzOi8
 pbH3pzwXASPKudn2aHzq3PVRmoqiogvyfHbJpMhh8i9AhPC/fMyR5wbKjRbb8xWsWDqc
 uk6GsgsZPqSNX6Gq3dtwtciKW2LXDhI9kItUMDma8vPkuhjW02kKUTzFJHJpFSP8l75P
 w1NJ2q+ABHmrAWo3AzERqgWFxCXDLvCzTgIMna0MlBgPbIy1AnBpcwsgjASKlwpHjD0O
 lTRA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTNRtutDs7XZOtNzgvSO6JTDgs9Qh8+F9yio/EYSZqFZ7Sg0ZdSciwoJI1I7i2I+tjWif/snBbEP7Ivqun6ezobUw9E/s=
X-Gm-Message-State: AOJu0Yy48Rv0F+Nsxl3XIqXNXtRhhjJGGL5/olG+myyNCp8+8cbP36sP
 RFi8Uuz4ZuF4KBCcdNoZdFnqD79wCqrkzawPx4ePbRktwTlTGQGR7SQ7mKHcJJBZzhcsXFxwt7S
 nKslWk6Pb8Mm2sryb2K1DYxXPzT8=
X-Google-Smtp-Source: AGHT+IE1EOe2lrn6YlbMdB7EN2CBH+miWh4iES7eq5fxPIH120aHo2MHIqpdSxkZG72BHyBs1tge/jAPtfJHUwj/h4w=
X-Received: by 2002:a05:6102:3051:b0:48f:79de:909e with SMTP id
 ada2fe7eead31-48faf0cf385mr14421031137.18.1719973713187; Tue, 02 Jul 2024
 19:28:33 -0700 (PDT)
MIME-Version: 1.0
References: <20240701033722.954-1-zhiwei_liu@linux.alibaba.com>
 <20240701033722.954-3-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240701033722.954-3-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 3 Jul 2024 12:28:07 +1000
Message-ID: <CAKmqyKODJjaYJi8AOWNr_VrRB12JOsxhZyt_xD7axAVUVp5rMQ@mail.gmail.com>
Subject: Re: [PATCH 2/6] target/riscv: Adjust PMP size for no-MMU RV64 QEMU
 running RV32
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 bmeng.cn@gmail.com, TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e34;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe34.google.com
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

On Mon, Jul 1, 2024 at 1:40=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux.alibaba=
.com> wrote:
>
> From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>
> Ensure pmp_size is correctly determined using mxl for RV32
> in RV64 QEMU.
>
> Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
> Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/pmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index 9eea397e72..f65aa3dba7 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -326,7 +326,7 @@ bool pmp_hart_has_privs(CPURISCVState *env, hwaddr ad=
dr,
>               */
>              pmp_size =3D -(addr | TARGET_PAGE_MASK);
>          } else {
> -            pmp_size =3D sizeof(target_ulong);
> +            pmp_size =3D 2UL << riscv_cpu_mxl(env);
>          }
>      } else {
>          pmp_size =3D size;
> --
> 2.43.0
>
>

