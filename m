Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2740BC54E58
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Mar 2024 04:50:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmntv-0004kW-9y; Wed, 20 Mar 2024 00:50:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rmnts-0004jT-OV; Wed, 20 Mar 2024 00:50:04 -0400
Received: from mail-oi1-x229.google.com ([2607:f8b0:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1rmntr-0007NN-2G; Wed, 20 Mar 2024 00:50:04 -0400
Received: by mail-oi1-x229.google.com with SMTP id
 5614622812f47-3c38f4e18eeso1409665b6e.1; 
 Tue, 19 Mar 2024 21:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1710910199; x=1711514999; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cZZn/Pfxe040AC462dwpGPm88toKXgMiEgO9cldWtGk=;
 b=PmDJaDQ0xI24czpdNaDl5qAZSxPAfyVBa3UBodyWXU7JXDp8PV4o+xcuxX86qAmw63
 wI4kYUL9fRdS4JIHcz8a0BGsQ46z5ntfn+XpWMIpMT/00ZCwy7wU9hW6bx4ktsL975Bk
 tXCrfTz76P97m11HjsWBYjafb0olsdLqHeAHNV8w6r1+Rd7vYQN7p7nQJZzZZo5dpRmX
 9n+4jrPKp3iznGw3grwmUfmlMmClH5Uhxz3WrBGLKmJH/Qh6/Zd2wS3Bk+hnUc6FDfgJ
 Qp0nN3YWpMt26Eke4xx4eUarFWH+gKsKZjawjwndIk0onwpCbtD4bCUi3a5oS8jD89/y
 pT/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710910199; x=1711514999;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=cZZn/Pfxe040AC462dwpGPm88toKXgMiEgO9cldWtGk=;
 b=dNaVtb2idNvYzux/QYjTk0ehZ9pCPgqiEOdZwXG7wowbyTZfUvEqh6izgfU8sLxQd/
 TNqHYdtfpHiBU9aRg+nsNFQ6puHNB04jElAdp91CpkaqiGbQRGILQMpMSOikLUW4my1+
 BxHdfj7SbK4v/em/L5UkJLN5GhM4zr/yDI+NXjBpdFvW9SBNorVW/8IWzqnbM1m8TdXr
 01vJ6Q4UeVvKC8z5DnkJHm2TX5A4iBTM4pRPhYAMZlka12kQCQCATgmJcWiMvEEWizZ6
 1gX25vJo4bKYLGltFlLJbsRSXxaObAZ1wwJDTVyjkuv4VIJnir8O/D5QSl13Y2xCHX1n
 4FdQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjIY+1VTp6/c88Vc0GsKqQHprvnWF4TC2R+7chsRoEDJCLBNesfmtnWaVOAy5JWlpGME1RI/E1M4kIjWW0PEHmpNm4WdwHllF66n77JXi5iksB1SwbkS3BPHWwgDmwhghS+xmW5c/Bsmjpx6rY3rNbgKi4pjXXs4Z7/TGBDZkMGtAzm5QHrg==
X-Gm-Message-State: AOJu0YzPhDDT0K4l+y0SVt23EtOrnSo+G1a+Wwu6sn/MPEIYBwF4nod8
 TJfuhHpO4MPe4uPGZ65Clqn0upsVNdbHBdyJSI1kGV1L5l2+NqZd
X-Google-Smtp-Source: AGHT+IHBZnUIQfx//79fm5PzXNSRC/xNGRUyYFNEnuj24MB4ZIBL3TcNY+GcFiLIuyN8fB8a70o4Ng==
X-Received: by 2002:a05:6808:128f:b0:3c1:e79e:5b2a with SMTP id
 a15-20020a056808128f00b003c1e79e5b2amr5429241oiw.29.1710910199324; 
 Tue, 19 Mar 2024 21:49:59 -0700 (PDT)
Received: from localhost (193-116-208-39.tpgi.com.au. [193.116.208.39])
 by smtp.gmail.com with ESMTPSA id
 y14-20020a62f24e000000b006e6c74ae61dsm10478675pfl.217.2024.03.19.21.49.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 Mar 2024 21:49:59 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 20 Mar 2024 14:49:52 +1000
Message-Id: <CZYB1NZX8J4L.ZH6QH9QK7O1Z@wheely>
Cc: <qemu-s390x@nongnu.org>, "Richard Henderson"
 <richard.henderson@linaro.org>, <qemu-ppc@nongnu.org>,
 <qemu-arm@nongnu.org>, <qemu-riscv@nongnu.org>, "Anton Johansson"
 <anjo@rev.ng>, "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH-for-9.1 17/27] target/ppc: Indent ppc_tcg_ops[] with 4
 spaces
From: "Nicholas Piggin" <npiggin@gmail.com>
To: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 <qemu-devel@nongnu.org>
X-Mailer: aerc 0.15.2
References: <20240319154258.71206-1-philmd@linaro.org>
 <20240319154258.71206-18-philmd@linaro.org>
In-Reply-To: <20240319154258.71206-18-philmd@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::229;
 envelope-from=npiggin@gmail.com; helo=mail-oi1-x229.google.com
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

Acked-by: Nicholas Piggin <npiggin@gmail.com>

On Wed Mar 20, 2024 at 1:42 AM AEST, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/ppc/cpu_init.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)
>
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 7e65f08147..464e91faa2 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -7360,22 +7360,22 @@ static const struct SysemuCPUOps ppc_sysemu_ops =
=3D {
>  #include "hw/core/tcg-cpu-ops.h"
> =20
>  static const TCGCPUOps ppc_tcg_ops =3D {
> -  .initialize =3D ppc_translate_init,
> -  .restore_state_to_opc =3D ppc_restore_state_to_opc,
> +    .initialize =3D ppc_translate_init,
> +    .restore_state_to_opc =3D ppc_restore_state_to_opc,
> =20
>  #ifdef CONFIG_USER_ONLY
> -  .record_sigsegv =3D ppc_cpu_record_sigsegv,
> +    .record_sigsegv =3D ppc_cpu_record_sigsegv,
>  #else
> -  .tlb_fill =3D ppc_cpu_tlb_fill,
> -  .cpu_exec_interrupt =3D ppc_cpu_exec_interrupt,
> -  .do_interrupt =3D ppc_cpu_do_interrupt,
> -  .cpu_exec_enter =3D ppc_cpu_exec_enter,
> -  .cpu_exec_exit =3D ppc_cpu_exec_exit,
> -  .do_unaligned_access =3D ppc_cpu_do_unaligned_access,
> -  .do_transaction_failed =3D ppc_cpu_do_transaction_failed,
> -  .debug_excp_handler =3D ppc_cpu_debug_excp_handler,
> -  .debug_check_breakpoint =3D ppc_cpu_debug_check_breakpoint,
> -  .debug_check_watchpoint =3D ppc_cpu_debug_check_watchpoint,
> +    .tlb_fill =3D ppc_cpu_tlb_fill,
> +    .cpu_exec_interrupt =3D ppc_cpu_exec_interrupt,
> +    .do_interrupt =3D ppc_cpu_do_interrupt,
> +    .cpu_exec_enter =3D ppc_cpu_exec_enter,
> +    .cpu_exec_exit =3D ppc_cpu_exec_exit,
> +    .do_unaligned_access =3D ppc_cpu_do_unaligned_access,
> +    .do_transaction_failed =3D ppc_cpu_do_transaction_failed,
> +    .debug_excp_handler =3D ppc_cpu_debug_excp_handler,
> +    .debug_check_breakpoint =3D ppc_cpu_debug_check_breakpoint,
> +    .debug_check_watchpoint =3D ppc_cpu_debug_check_watchpoint,
>  #endif /* !CONFIG_USER_ONLY */
>  };
>  #endif /* CONFIG_TCG */


