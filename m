Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38681C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 06:33:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rer0k-0002nJ-OB; Tue, 27 Feb 2024 01:32:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rer0i-0002mO-Ed; Tue, 27 Feb 2024 01:32:16 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rer0g-00067S-N8; Tue, 27 Feb 2024 01:32:16 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-29aa8c4710bso1616670a91.1; 
 Mon, 26 Feb 2024 22:32:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1709015533; x=1709620333; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NsEoopzsNT4TRZwBrcM54O8FVWq5cCJrqAl3BqtWfiE=;
 b=Byp2spMlEIF7qTQ1Bsdwrm1J2Jmjg1TKUvW6yDl0uFrhLutwGcC4t4Hx1yK9maIJXJ
 ebFklwOacdDWU/qyNddRveDPXwQmqtRQP+Z0BQt706WgA8793g+LBUjXgatLY3RRZoPk
 902ZSB1PcDGII2wqVgfTYMgmVDEQZLbiUYGRNnEF8QtdRQhKh76rUdDQ1lg1uu3uqn1z
 WPvZjkmHMeawLX0G2cetcyX75cwi5IdstZGXkGTg/ePuobzztJXDIIcX5KJUYc39Dvz9
 YiCI4dGozpmrlxSBWcDRAZkdr51ipAWXIWeF10aDJO4lbS/qNXShzWhOqdTtj5NwTve7
 hvtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709015533; x=1709620333;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NsEoopzsNT4TRZwBrcM54O8FVWq5cCJrqAl3BqtWfiE=;
 b=aBtE8y2UVeyMvD1XGHhsXHpMCC+Puc9+F7UV8+RSJ73R8Ow8/RrSztiFNXc/Fb+GSD
 W9mWN7+NEd8k1gXKXaZSgJUNxvVWlZjmQlV9EfwfFzmBlY7ZGWH5sIJA3LKuL2roWdyf
 T52rafC7HlYSanELSs62pzdCNOfmJ7/bnAzOvYt21Ban//xNRiAzzYkWLYt32Rkkf7cO
 8rpmZuDXux3n24q/7hBAgvOt3VMcicmuTrN8Vo5hngszzA4sJwj5mvTjVD437lIRaAsY
 NJpf5WNE1H/PgvsOA7mTZ7dEcU7xc5UIUbW2Lj0AhjXH2iBuc3+BG2uSRUQtXW/VPV9v
 U4mw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaseEfEe/a20vkcqBFoI3JfUo8lHTD8VcJ48qEul6Azu9J2vQmOHBfjyOrR6RxeE3yko1C0LKptu6qjzBbKqK0hhlRiH1/LftvI6sXPd9AUVinxz6+1yM6yIQ=
X-Gm-Message-State: AOJu0YwgwEyxMKkJjaJ/vH2ZddP2bWXcj+wynN1HyHMxTl2vMA5Db9NG
 A7O/SYRf6Hjhy1GuxZOIt89Ma4l9k6U/xRBUMYmRXex797KxNBq8
X-Google-Smtp-Source: AGHT+IHvGJymNiMtTZjMf+gPD8Yd6989RiYqhHWspeKFPvN0pumCeSxd3IjwdwSTXTjUWdLG/xHbfA==
X-Received: by 2002:a17:90a:d597:b0:29a:b4c5:eba7 with SMTP id
 v23-20020a17090ad59700b0029ab4c5eba7mr7540776pju.0.1709015532785; 
 Mon, 26 Feb 2024 22:32:12 -0800 (PST)
Received: from localhost (110-175-163-154.tpgi.com.au. [110.175.163.154])
 by smtp.gmail.com with ESMTPSA id
 o3-20020a17090a5b0300b00298d203d359sm5626867pji.24.2024.02.26.22.32.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Feb 2024 22:32:12 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 27 Feb 2024 16:32:07 +1000
Message-Id: <CZFNFYXMKB4I.1DQHUYL82SDXC@wheely>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>, <clg@kaod.org>
Subject: Re: [PATCH v6 5/9] target/ppc: Simplify syscall exception handlers
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.15.2
References: <cover.1708601065.git.balaton@eik.bme.hu>
 <5441ced92de39f712378e8aac4346aef809301c7.1708601065.git.balaton@eik.bme.hu>
In-Reply-To: <5441ced92de39f712378e8aac4346aef809301c7.1708601065.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102e.google.com
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

On Thu Feb 22, 2024 at 9:33 PM AEST, BALATON Zoltan wrote:
> After previous changes the hypercall handling in 7xx and 74xx
> exception handlers can be folded into one if statement to simpilfy
> this code. Also add "unlikely" to mark the less freqiently used branch
> for the compiler.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Reviewed-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>  target/ppc/excp_helper.c | 24 ++++++++----------------
>  1 file changed, 8 insertions(+), 16 deletions(-)
>
> diff --git a/target/ppc/excp_helper.c b/target/ppc/excp_helper.c
> index 411d67376c..035a9fd968 100644
> --- a/target/ppc/excp_helper.c
> +++ b/target/ppc/excp_helper.c
> @@ -762,26 +762,22 @@ static void powerpc_excp_7xx(PowerPCCPU *cpu, int e=
xcp)
>      case POWERPC_EXCP_SYSCALL:   /* System call exception               =
     */
>      {
>          int lev =3D env->error_code;
> -
> -        if (lev =3D=3D 1 && cpu->vhyp) {
> -            dump_hcall(env);
> -        } else {
> -            dump_syscall(env);
> -        }
>          /*
>           * The Virtual Open Firmware (VOF) relies on the 'sc 1'
>           * instruction to communicate with QEMU. The pegasos2 machine
>           * uses VOF and the 7xx CPUs, so although the 7xx don't have
>           * HV mode, we need to keep hypercall support.
>           */
> -        if (lev =3D=3D 1 && cpu->vhyp) {
> +        if (unlikely(lev =3D=3D 1 && cpu->vhyp)) {
>              PPCVirtualHypervisorClass *vhc =3D
>                  PPC_VIRTUAL_HYPERVISOR_GET_CLASS(cpu->vhyp);
> +            dump_hcall(env);
>              vhc->hypercall(cpu->vhyp, cpu);
>              powerpc_reset_excp_state(cpu);
>              return;
> +        } else {
> +            dump_syscall(env);
>          }
> -
>          break;

You could avoid the else statement for these because the
hcall branch returns.

Actually books could be changed similarly too, I think dump_hcall can be
done in the books_vhyp_handles_hcall() branch. But you don't need to
change that in your patch since it's behaviour change.

Thanks,
Nick

