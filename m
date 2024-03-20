Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8103CC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 04:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmndH-0007X0-Pr; Wed, 20 Mar 2024 00:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rmndF-0007Sy-Q7; Wed, 20 Mar 2024 00:32:53 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rmndE-0004DN-73; Wed, 20 Mar 2024 00:32:53 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1dde26f7e1dso46016435ad.1; 
 Tue, 19 Mar 2024 21:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710909170; x=1711513970; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h9rtxvCIzETuZUnS9W1quvxjGH0fkoLHMA2qUuv7fwk=;
 b=Fxq3SGVUAA6gb3pXWyXQJxNFMp4s/lXv0Pa24yY3a1FfDZuecVN3kg5jPIXYbI1JEP
 +WdoEb2LWo7BQpy3ukbC7cbHNsOpUDD/q6PP1BGG+xifFsOI0OzPOvYWtb0QG8bPvNN1
 Sld90hRm1DwuPv1PyQJz49oHwXUDF8Bw74+EZBMLMaePHJnKOQTlutNFGnV3RJiQ6xgp
 ZsiU53Vkwipuw78bRB19KdpYgcQfsQYC4K2y8YaVZPjMATvNt0+msW2XqKjr8OwIM5Uw
 Es0KMEjd10i7XpomKXgqDzGAN7YsZetBIyKBsp0mUz3aWeT6LWaYOeRJlm7TaA8fAihE
 M9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710909170; x=1711513970;
 h=in-reply-to:references:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=h9rtxvCIzETuZUnS9W1quvxjGH0fkoLHMA2qUuv7fwk=;
 b=dUO00CmCaFktJwdhHYx7hAsjh7bU8tH4VzWMIuDwfNNp10YU6kNizoQVCd1bAyfjoY
 qFtXNPUAfgPDUy3C8dYerQt8ikIDU2m286X/E74wFebKLQgWb9e6cfYF/o2KnZyd7Myj
 2bre/jJqUYsHNRWtLkEycHlUSFcd/xLMQ90uj8q1ZQClFAmAlTo0Y5a0g0wj75mxXuhK
 T1PrWaaCQC2O7wGrCYy/dB7gbYI7tA/EeLAFwe2reVGZthJpWy/bwmrpaNCPmmfzMgr3
 FXVoj2C8X+eOyZvMwDm81AaTGozeBpQ2FIm3hhjAzE3sYUQUfBeRitsnFYjFLEFLyw+F
 j1Fg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWi2KdY+5sy8RHvppUHTJUo5MnRcPOW2AIfHxmxiTPxxQDlB9uQEWizg0V0gvAL7VwATxSnubrwrsF3hBtumurG67RRPQCAAk9B2QGJa8QsRfc+lNT0ccOsurE=
X-Gm-Message-State: AOJu0YytL7FtB2W4G9LIcMI93pw+L5kV43LP4QsDuVSP4cMkiyXfgyNh
 q9vNoru7c9LNUxJ3RGtA3nNaJTO4wR2elbHFG2DF44l1T3iLGp/YHXIHuPW7Xl8=
X-Google-Smtp-Source: AGHT+IGmfjnLrP1lNbWHKstXSyXuFPUaxHFNI9wXOw+sn6T20ezipDX4+ypKiH3zoAe+y4J1m84+Bg==
X-Received: by 2002:a17:902:ec88:b0:1df:f8a4:5485 with SMTP id
 x8-20020a170902ec8800b001dff8a45485mr14427736plg.57.1710909170234; 
 Tue, 19 Mar 2024 21:32:50 -0700 (PDT)
Received: from localhost (193-116-208-39.tpgi.com.au. [193.116.208.39])
 by smtp.gmail.com with ESMTPSA id
 o1-20020a170902d4c100b001dd8d7d4a5csm6130175plg.90.2024.03.19.21.32.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 21:32:49 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Mar 2024 14:32:45 +1000
Message-Id: <CZYAOK7KXUIF.A67FWNEYD5VI@wheely>
Subject: Re: [PATCH 2/2] target/ppc: Fix GDB register indexing on secondary
 CPUs
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Benjamin Gray" <bgray@linux.ibm.com>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240320015025.372056-1-bgray@linux.ibm.com>
 <20240320015025.372056-2-bgray@linux.ibm.com>
In-Reply-To: <20240320015025.372056-2-bgray@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed Mar 20, 2024 at 11:50 AM AEST, Benjamin Gray wrote:
> The GDB server protocol assigns an arbitrary numbering of the SPRs.
> We track this correspondence on each SPR with gdb_id, using it to
> resolve any SPR requests GDB makes.
>
> Early on we generate an XML representation of the SPRs to give GDB,
> including this numbering. However the XML is cached globally, and we
> skip setting the SPR gdb_id values on subsequent threads if we detect
> it is cached. This causes QEMU to fail to resolve SPR requests against
> secondary CPUs because it cannot find the matching gdb_id value on that
> thread's SPRs.
>
> This is a minimal fix to first assign the gdb_id values, then return
> early if the XML is cached. Otherwise we generate the XML using the
> now already initialised gdb_id values.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Fixes: 1b53948ff8f7 ("target/ppc: Use GDBFeature for dynamic XML")
> Signed-off-by: Benjamin Gray <bgray@linux.ibm.com>
> ---
>  target/ppc/gdbstub.c | 31 ++++++++++++++++++++-----------
>  1 file changed, 20 insertions(+), 11 deletions(-)
>
> diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
> index 3f1e61bdb7..3b28d4e21c 100644
> --- a/target/ppc/gdbstub.c
> +++ b/target/ppc/gdbstub.c
> @@ -305,14 +305,6 @@ static void gdb_gen_spr_feature(CPUState *cs)
>      unsigned int num_regs =3D 0;
>      int i;
> =20
> -    if (pcc->gdb_spr.xml) {
> -        return;
> -    }
> -
> -    gdb_feature_builder_init(&builder, &pcc->gdb_spr,
> -                             "org.qemu.power.spr", "power-spr.xml",
> -                             cs->gdb_num_regs);
> -
>      for (i =3D 0; i < ARRAY_SIZE(env->spr_cb); i++) {
>          ppc_spr_t *spr =3D &env->spr_cb[i];
> =20
> @@ -320,9 +312,6 @@ static void gdb_gen_spr_feature(CPUState *cs)
>              continue;
>          }
> =20
> -        gdb_feature_builder_append_reg(&builder, g_ascii_strdown(spr->na=
me, -1),
> -                                       TARGET_LONG_BITS, num_regs,
> -                                       "int", "spr");
>          /*
>           * GDB identifies registers based on the order they are
>           * presented in the XML. These ids will not match QEMU's
> @@ -335,6 +324,26 @@ static void gdb_gen_spr_feature(CPUState *cs)
>          num_regs++;
>      }
> =20
> +    if (pcc->gdb_spr.xml) {
> +        return;
> +    }
> +
> +    gdb_feature_builder_init(&builder, &pcc->gdb_spr,
> +                             "org.qemu.power.spr", "power-spr.xml",
> +                             cs->gdb_num_regs);
> +
> +    for (i =3D 0; i < ARRAY_SIZE(env->spr_cb); i++) {
> +        ppc_spr_t *spr =3D &env->spr_cb[i];
> +
> +        if (!spr->name) {
> +            continue;
> +        }
> +
> +        gdb_feature_builder_append_reg(&builder, g_ascii_strdown(spr->na=
me, -1),
> +                                       TARGET_LONG_BITS, spr->gdb_id,
> +                                       "int", "spr");
> +    }
> +
>      gdb_feature_builder_end(&builder);
>  }
>  #endif


