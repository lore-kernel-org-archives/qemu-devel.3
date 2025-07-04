Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD7AC8303D
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Jul 2025 04:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uXXdF-0002Jw-Cl; Fri, 04 Jul 2025 00:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXXd3-0002I5-36; Fri, 04 Jul 2025 00:02:27 -0400
Received: from mail-vs1-xe33.google.com ([2607:f8b0:4864:20::e33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uXXd1-0005Eu-FW; Fri, 04 Jul 2025 00:02:24 -0400
Received: by mail-vs1-xe33.google.com with SMTP id
 ada2fe7eead31-4e98a88fa5aso138736137.0; 
 Thu, 03 Jul 2025 21:02:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1751601741; x=1752206541; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BiODqgsc2Jff2U2D0bnIfrKoIRrJyr4h7Wd//7bJ+A0=;
 b=OSk8To//vuQBcmBRtw4uYsRAqqEV1RNfYBDLZO7rGvLgUieK1tmOEaEQ+Pm2td6jZ3
 0HOSPt6HoohZRkVjrbv0mT32AYClKvE7iw80DHJsv85AUErOqizAgdq6quIjhEDdOH1Z
 bE+eydu28GqHB6a3ttHmjqtDUv9KdiY5l8VeCcgMy6N7oHEBRQyM7GM/caS9jPPNnB+x
 wLBcLziVLZrXsvQO+U4vUjG3qMHgpkjRVXpoVFjcN4km7z2jksUPYY9srrUgLOljLpe/
 4HtFhqAggrA2qWb/2RM381Gjb964h1/sl9jE5Qe74PbGWGgUW5Qm0J47Yh/PjYdrK3DF
 WEmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751601741; x=1752206541;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BiODqgsc2Jff2U2D0bnIfrKoIRrJyr4h7Wd//7bJ+A0=;
 b=ln/ZaS+TvLnE8iWP1bc9bGOfNokOx5UpjmsODFVeANYSmgFvHT0US85fJ3NaqRk8L5
 tQvyopr+PAavGz+colXutSBmJesmnIzzeAv6aJHSxTOt/5Vm73PT54rNj4fxAgwVbPEm
 Ud+/Q1YGIE1HCJAL5/XPArxLYXzErTnNnVY2Dus6vBieNn3SlXuLKACLzkGVIjt6Z7SN
 rdBJnmxRpUY3WP6IQUuecDzmUZGUcsek1BjQYclCrHoSh+JwvvHMSY4ruRym6PJObrll
 Rq8TdRLOUN/iZGKycINPO3VDy6oDjgqgt03yhRec8TGzvtbInac6s4Ub5kByhkcREnwj
 1Zdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWQ4JFFBodXNoUB9DbcqHUWlTDM1wsBJXWjBYwg8rTZIB3bGbIXkrWhPbQA+AO+ivqE83fHEwpkHK4G@nongnu.org
X-Gm-Message-State: AOJu0Yxf5tPDdLIwwYKn7h/8pHC3fF+OekLTZ98s+Pyge6KgdVXE3R2h
 CJTYJo5molKSPeQvGCwniIajHSQ3xgom6eCl84fZGtUGQ9fQD2q77Me2ktq3UUGyzvx/i09Ccyn
 bGrieXwDaI74gfcdGUIgHso4q7SwQgNI=
X-Gm-Gg: ASbGncu7TTMuLg2iYsSUtorZpWQjBI8gw4HlfLwoBkbif28XNCpbM2wNhdsbjG3gDq/
 WVeRpw15m/Dziw5Y3O1+U9ETrbqNFsqX3dL/5QEnj4vNo2OlTBaxkfTjgIO2VuHSIMmOZEfpn17
 oN3K3yiNpOOhIjQE5AnhDhpShH6zN/2f8gE9ENETkeyegdlgDgA0RCIhhtVn9Y9VR3uW7Mz+Rv5
 Q==
X-Google-Smtp-Source: AGHT+IE74QoAA3uD+H974VO5AYzYAQVAb5E83inr5AzRqV6e5BLC/bEvxElc3R3vbrI8H7kg1hqsOhGPPiPpFeV4g8E=
X-Received: by 2002:a05:6102:1609:b0:4da:fc9d:f0c with SMTP id
 ada2fe7eead31-4f2ee1d3d77mr947101137.12.1751601741395; Thu, 03 Jul 2025
 21:02:21 -0700 (PDT)
MIME-Version: 1.0
References: <20250623145306.991562-1-dbarboza@ventanamicro.com>
In-Reply-To: <20250623145306.991562-1-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 4 Jul 2025 14:01:55 +1000
X-Gm-Features: Ac12FXxrRf92VNsEZJrvmt7kAFwDw2q5lI_zpjQin8yjm69f8JBvEO_k23sdLwA
Message-ID: <CAKmqyKOKCb_GNcwsQHWB8jvpXzfewCMG8=xhOsRCcDj7KWJNLw@mail.gmail.com>
Subject: Re: [PATCH] hmp-cmds-target.c: add CPU_DUMP_VPU in
 hmp_info_registers()
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@dabbelt.com, 
 "Dr. David Alan Gilbert" <dave@treblig.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::e33;
 envelope-from=alistair23@gmail.com; helo=mail-vs1-xe33.google.com
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

On Tue, Jun 24, 2025 at 12:54=E2=80=AFAM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> Commit b84694defb added the CPU_DUMP_VPU to allow vector registers to be
> logged by log_cpu_exec() in TCG. This flag was then used in commit
> b227f6a8a7 to print RISC-V vector registers using this flag. Note that
> this change was done in riscv_cpu_dump_state(), the cpu_dump_state()
> callback for RISC-V, the same callback used in hmp_info_registers().
>
> Back then we forgot to change hmp_info_registers(), and 'info registers'
> isn't showing RISC-V vector registers as a result. No other target is
> impacted since only RISC-V is using CPU_DUMP_VPU.
>
> There's no reason to not show VPU regs in info_registers(), so add
> CPU_DUMP_VPU to hmp_info_registers(). This will print vector registers
> for all RISC-V machines and, as said above, has no impact in other
> archs.
>
> Cc: Dr. David Alan Gilbert <dave@treblig.org>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  monitor/hmp-cmds-target.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/monitor/hmp-cmds-target.c b/monitor/hmp-cmds-target.c
> index 8eaf70d9c9..e982061146 100644
> --- a/monitor/hmp-cmds-target.c
> +++ b/monitor/hmp-cmds-target.c
> @@ -102,7 +102,7 @@ void hmp_info_registers(Monitor *mon, const QDict *qd=
ict)
>      if (all_cpus) {
>          CPU_FOREACH(cs) {
>              monitor_printf(mon, "\nCPU#%d\n", cs->cpu_index);
> -            cpu_dump_state(cs, NULL, CPU_DUMP_FPU);
> +            cpu_dump_state(cs, NULL, CPU_DUMP_FPU | CPU_DUMP_VPU);
>          }
>      } else {
>          cs =3D vcpu >=3D 0 ? qemu_get_cpu(vcpu) : mon_get_cpu(mon);
> @@ -117,7 +117,7 @@ void hmp_info_registers(Monitor *mon, const QDict *qd=
ict)
>          }
>
>          monitor_printf(mon, "\nCPU#%d\n", cs->cpu_index);
> -        cpu_dump_state(cs, NULL, CPU_DUMP_FPU);
> +        cpu_dump_state(cs, NULL, CPU_DUMP_FPU | CPU_DUMP_VPU);
>      }
>  }
>
> --
> 2.49.0
>
>

