Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28C37C10F16
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 04:48:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2kpD-0002pg-4v; Fri, 03 May 2024 00:47:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s2kou-0002o0-KC; Fri, 03 May 2024 00:46:53 -0400
Received: from mail-pj1-x1033.google.com ([2607:f8b0:4864:20::1033])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s2kop-000715-3r; Fri, 03 May 2024 00:46:52 -0400
Received: by mail-pj1-x1033.google.com with SMTP id
 98e67ed59e1d1-2ab1ddfded1so7505678a91.1; 
 Thu, 02 May 2024 21:46:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714711604; x=1715316404; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2nLS0kQnSWCitBKKgUPaN9NajP8s8UZrbebLEcSaDrM=;
 b=V90zbi55iaBKoemNHnRJHF37yxd/szgFc4xU5baXaEwHSgXdOS156Dyk0hlv+Y2dc/
 PtoVIO3N1nP3fZntxb3zMEgUtwo5chOU0WhPVzf7/qDBVtIw8xYvkj5QKfGu2on/+kyb
 GeLHNneRscedA73i44+8l6F6NDUhjX1AHkT7gn5x4MzCKVf9D/JA2a56m2NiG9kSsIz1
 XF1zshT9OcrqUY/SHUho5cb3ed8j3xGTj1N8FGsAIAYc6iD1iGq5wmnWFecBfIx4WRec
 MSR/Xpn8Q+OFFHLDD1YpHQ8sabem/A0IE2FcKneFnoyoK3tti7lN0/2HajdrgBnvSv9Q
 FeGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714711604; x=1715316404;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2nLS0kQnSWCitBKKgUPaN9NajP8s8UZrbebLEcSaDrM=;
 b=P1x2JP/xsbgo+9IRascIzQH0KCtXTxxbXEtdApXpKl8hAU8K60/KKg4GhR/IJHbMJr
 0DrLcbfSUrdzMzi7JnByKZfQTpxzA2oQrfWBiAMceNfDveKsmXo4hqPlIH0+Vtce+DRo
 nar1PEXiWDEJ/9R5bMatoqwnzrEIoerlc5UUaL/nGe67qoyM2NP6hWrZ3QmUh27KSQQd
 ozv3zl/JpBCHjT9aROkr+hX/ro8pSqBdX5InYTvio5XndLUHvOtkoaLj6SWT5n5FxmzE
 H/ut5011vcBQO3insc8mfkmvpZXfOD/TsFDTOfZCWRSGDkoXHdtuu7jGfqcJqsq/YSXp
 Nqqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWXedRCG911JUESeSN0AaKeFwQWuh/dExQ6hnRKr3hspSSn7I6opB51TUOynrSMkcU/2azaidq8KtXiPHr84XiXdNJmDrI=
X-Gm-Message-State: AOJu0YzpB7Zi3ExEfclkXY2Pokd0g4Q09RZZNYy762RVL4Q7AY2NwPIn
 g7Wz0PAChAQQ5MyAWpKOfGjR5QjwbjMj9hV71ieoubbT68LtVnMw
X-Google-Smtp-Source: AGHT+IH4R78qjWRf/tmKXhJVGp1QBLZr5XjUdb3cbrTKWrUli3N7SZHvLjmyJjp0jCOknS1J3C380A==
X-Received: by 2002:a17:90a:a888:b0:2b4:3669:8b87 with SMTP id
 h8-20020a17090aa88800b002b436698b87mr793290pjq.4.1714711604173; 
 Thu, 02 May 2024 21:46:44 -0700 (PDT)
Received: from localhost ([1.146.23.181]) by smtp.gmail.com with ESMTPSA id
 gz13-20020a17090b0ecd00b002b143417622sm2192703pjb.12.2024.05.02.21.46.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 May 2024 21:46:43 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 03 May 2024 14:46:38 +1000
Message-Id: <D0ZQJ5JD4FF1.WSLV5C6W8A4H@gmail.com>
Cc: <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [PATCH] ppc/pnv: Introduce pnv_chip_foreach_cpu()
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?= <fbarrat@linux.ibm.com>
X-Mailer: aerc 0.17.0
References: <20240424093048.180966-1-clg@redhat.com>
In-Reply-To: <20240424093048.180966-1-clg@redhat.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1033;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x1033.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed Apr 24, 2024 at 7:30 PM AEST, C=C3=A9dric Le Goater wrote:
> This helper routine uses the machine definition, sockets, cores and
> threads, to loop on all CPUs of the machine. Replace CPU_FOREACH()
> with it.
>
> Signed-off-by: C=C3=A9dric Le Goater <clg@redhat.com>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  hw/ppc/pnv.c | 48 ++++++++++++++++++++++++++++++++++++------------
>  1 file changed, 36 insertions(+), 12 deletions(-)
>
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 6e3a5ccdec764c8f6cbd076e27f59c7082e64876..5f400ed127921c4c3a45bc548=
63b2cafa53e7030 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -2264,6 +2264,21 @@ PowerPCCPU *pnv_chip_find_cpu(PnvChip *chip, uint3=
2_t pir)
>      return NULL;
>  }
> =20
> +static void pnv_chip_foreach_cpu(PnvChip *chip,
> +                   void (*fn)(PnvChip *chip, PowerPCCPU *cpu, void *opaq=
ue),
> +                   void *opaque)
> +{
> +    int i, j;
> +
> +    for (i =3D 0; i < chip->nr_cores; i++) {
> +        PnvCore *pc =3D chip->cores[i];
> +
> +        for (j =3D 0; j < CPU_CORE(pc)->nr_threads; j++) {
> +            fn(chip, pc->threads[j], opaque);
> +        }
> +    }
> +}
> +
>  static ICSState *pnv_ics_get(XICSFabric *xi, int irq)
>  {
>      PnvMachineState *pnv =3D PNV_MACHINE(xi);
> @@ -2332,23 +2347,26 @@ static ICPState *pnv_icp_get(XICSFabric *xi, int =
pir)
>      return cpu ? ICP(pnv_cpu_state(cpu)->intc) : NULL;
>  }
> =20
> +static void pnv_pic_intc_print_info(PnvChip *chip, PowerPCCPU *cpu,
> +                                    void *opaque)
> +{
> +    PNV_CHIP_GET_CLASS(chip)->intc_print_info(chip, cpu, opaque);
> +}
> +
>  static void pnv_pic_print_info(InterruptStatsProvider *obj,
>                                 Monitor *mon)
>  {
>      PnvMachineState *pnv =3D PNV_MACHINE(obj);
>      int i;
> -    CPUState *cs;
> =20
> -    CPU_FOREACH(cs) {
> -        PowerPCCPU *cpu =3D POWERPC_CPU(cs);
> +    for (i =3D 0; i < pnv->num_chips; i++) {
> +        PnvChip *chip =3D pnv->chips[i];
> =20
> -        /* XXX: loop on each chip/core/thread instead of CPU_FOREACH() *=
/
> -        PNV_CHIP_GET_CLASS(pnv->chips[0])->intc_print_info(pnv->chips[0]=
, cpu,
> -                                                           mon);
> -    }
> +        /* First CPU presenters */
> +        pnv_chip_foreach_cpu(chip, pnv_pic_intc_print_info, mon);
> =20
> -    for (i =3D 0; i < pnv->num_chips; i++) {
> -        PNV_CHIP_GET_CLASS(pnv->chips[i])->pic_print_info(pnv->chips[i],=
 mon);
> +        /* Then other devices, PHB, PSI, XIVE */
> +        PNV_CHIP_GET_CLASS(chip)->pic_print_info(chip, mon);
>      }
>  }
> =20
> @@ -2549,12 +2567,18 @@ static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, r=
un_on_cpu_data arg)
>      }
>  }
> =20
> +static void pnv_cpu_do_nmi(PnvChip *chip, PowerPCCPU *cpu, void *opaque)
> +{
> +    async_run_on_cpu(CPU(cpu), pnv_cpu_do_nmi_on_cpu, RUN_ON_CPU_NULL);
> +}
> +
>  static void pnv_nmi(NMIState *n, int cpu_index, Error **errp)
>  {
> -    CPUState *cs;
> +    PnvMachineState *pnv =3D PNV_MACHINE(qdev_get_machine());
> +    int i;
> =20
> -    CPU_FOREACH(cs) {
> -        async_run_on_cpu(cs, pnv_cpu_do_nmi_on_cpu, RUN_ON_CPU_NULL);
> +    for (i =3D 0; i < pnv->num_chips; i++) {
> +        pnv_chip_foreach_cpu(pnv->chips[i], pnv_cpu_do_nmi, NULL);
>      }
>  }
> =20


