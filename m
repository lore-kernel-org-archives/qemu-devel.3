Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55D85C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 23:52:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rekkU-0000yu-JQ; Mon, 26 Feb 2024 18:51:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rekkR-0000wd-79; Mon, 26 Feb 2024 18:51:04 -0500
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rekkP-0001fB-LS; Mon, 26 Feb 2024 18:51:02 -0500
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-4cba3807eedso2036486e0c.0; 
 Mon, 26 Feb 2024 15:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708991460; x=1709596260; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4DJ8hDST936qlG7SpGQXIZYT/clARaw7J9RWmqp/CQk=;
 b=L5MRpQSvarWp7m51lU5TqBv92v1brcLnV4KsLQwOsCuMElOVfJzhF5CA7CReJm+pnz
 9IWoQzwSxSfS55MTC56bXw2H+VswWTQxJ52s3PtVJi7bIO38iJLgpUHUljykwopbUGqC
 9Mh9AJYZ2MLJ9FG21zWJUw+qDivPHIoiibJzssxSdJ527NXp2Mwsn3DsTXj6fapRaSDt
 1J0bW77pcFGPg5DOABFlAvLCV7jVEQHAGeWCtq5kbiacrAf4juJLwZHaH2yxIfx6+SFB
 yJfjrwbcaDpZsQPoUM14QDB8uVyzWesie21vDIj7NBpFgtVanBT7dQMbTL9cJyT+vOsJ
 wE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708991460; x=1709596260;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=4DJ8hDST936qlG7SpGQXIZYT/clARaw7J9RWmqp/CQk=;
 b=A1EP+U4O7hqe/rLFyVfVYCrj4T3aFC1ciAdvpYUMWIGtsIZQS3JhXWYyaq/Tw+ONO1
 MFDbO0rQmqFGjfo59SkHgJxY1eCJzmyWorU+GuzAo7fWU8iIO2LbsSQoU/2Nf1wzDNor
 UxGu8COYGs0vvXKCpILIyt/zH5POG4EXiDG0I7Lxk82FksGaXY0esvhMN1g2kOckTbdR
 06blnEbF6sz6RYYt6OWAIrclu+Tb6aFd/9sxnZW3qmWcWGbfozmNMwKh3FR8VErumYf4
 hiqhViLtf/tRztvRzl08rLd5HEULsv/F/6rjvNLFKbRkMTuvZQpRRfj6p0UN8C7JDvhh
 Y7oQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUOH6N9RNz7HdqorjqPSrCtTuwJPvOrDMm2VU+2bkA9GCd34GflFp7fz1df0LM+oXo+9IczcjANsi8ntEfg4jT1pAjNo+M=
X-Gm-Message-State: AOJu0YwZ38KErOv+XsWreNe6D3hIgHW8dh1dFDeRfrfpW6QqXuKGSMSN
 NWRRfa/kvJwHaN/PoFf89Zu2CuyQY19DmgNHINFno/4kkz1/BwGCXD+TgJf1Faacpv3O1jXymB/
 baitOc1ehitsqfckhlH0bxdOn15g=
X-Google-Smtp-Source: AGHT+IGdOFkW1pc8WaGFqGbILcl6CNRP/62b+qmufIeNz3JpNDakaCcWrDNkpMKDh5SUbQ3ihoejCmFuLNbu4sOzhJ4=
X-Received: by 2002:a1f:dfc4:0:b0:4c8:a2c6:c2be with SMTP id
 w187-20020a1fdfc4000000b004c8a2c6c2bemr6213691vkg.8.1708991460007; Mon, 26
 Feb 2024 15:51:00 -0800 (PST)
MIME-Version: 1.0
References: <20240223022119.41255-1-alvinga@andestech.com>
 <20240223022119.41255-3-alvinga@andestech.com>
In-Reply-To: <20240223022119.41255-3-alvinga@andestech.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 27 Feb 2024 09:50:32 +1000
Message-ID: <CAKmqyKPci0SngGhcanZ8tZDkDETv2yzo_+MOqbc8-o6xqt1V+Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] target/riscv: Apply modularized matching
 conditions for breakpoint
To: Alvin Chang <alvinga@andestech.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, alistair.francis@wdc.com, 
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 zhiwei_liu@linux.alibaba.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2e.google.com
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

On Fri, Feb 23, 2024 at 12:22=E2=80=AFPM Alvin Chang via <qemu-devel@nongnu=
.org> wrote:
>
> We have implemented trigger_common_match(), which checks if the enabled
> privilege levels of the trigger match CPU's current privilege level.
> Remove the related code in riscv_cpu_debug_check_breakpoint() and invoke
> trigger_common_match() to check the privilege levels of the type 2 and
> type 6 triggers for the breakpoints.
>
> This commit also changes the behavior of looping the triggers. In
> previous implementation, if we have a type 2 trigger and
> env->virt_enabled is true, we directly return false to stop the loop.
> Now we keep looping all the triggers until we find a matched trigger.
>
> Only the execution bit and the executed PC should be futher checked in
> riscv_cpu_debug_check_breakpoint().
>
> Signed-off-by: Alvin Chang <alvinga@andestech.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/debug.c | 26 ++++++--------------------
>  1 file changed, 6 insertions(+), 20 deletions(-)
>
> diff --git a/target/riscv/debug.c b/target/riscv/debug.c
> index 3891236b82..b7b0fa8945 100644
> --- a/target/riscv/debug.c
> +++ b/target/riscv/debug.c
> @@ -855,21 +855,17 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
>          for (i =3D 0; i < RV_MAX_TRIGGERS; i++) {
>              trigger_type =3D get_trigger_type(env, i);
>
> +            if (!trigger_common_match(env, trigger_type, i)) {
> +                continue;
> +            }
> +
>              switch (trigger_type) {
>              case TRIGGER_TYPE_AD_MATCH:
> -                /* type 2 trigger cannot be fired in VU/VS mode */
> -                if (env->virt_enabled) {
> -                    return false;
> -                }
> -
>                  ctrl =3D env->tdata1[i];
>                  pc =3D env->tdata2[i];
>
>                  if ((ctrl & TYPE2_EXEC) && (bp->pc =3D=3D pc)) {
> -                    /* check U/S/M bit against current privilege level *=
/
> -                    if ((ctrl >> 3) & BIT(env->priv)) {
> -                        return true;
> -                    }
> +                    return true;
>                  }
>                  break;
>              case TRIGGER_TYPE_AD_MATCH6:
> @@ -877,17 +873,7 @@ bool riscv_cpu_debug_check_breakpoint(CPUState *cs)
>                  pc =3D env->tdata2[i];
>
>                  if ((ctrl & TYPE6_EXEC) && (bp->pc =3D=3D pc)) {
> -                    if (env->virt_enabled) {
> -                        /* check VU/VS bit against current privilege lev=
el */
> -                        if ((ctrl >> 23) & BIT(env->priv)) {
> -                            return true;
> -                        }
> -                    } else {
> -                        /* check U/S/M bit against current privilege lev=
el */
> -                        if ((ctrl >> 3) & BIT(env->priv)) {
> -                            return true;
> -                        }
> -                    }
> +                    return true;
>                  }
>                  break;
>              default:
> --
> 2.34.1
>
>

