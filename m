Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32381C54FC6
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Sep 2024 00:55:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1slHou-000129-AA; Mon, 02 Sep 2024 20:54:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1slHos-00011F-KH; Mon, 02 Sep 2024 20:54:54 -0400
Received: from mail-ua1-x930.google.com ([2607:f8b0:4864:20::930])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1slHor-0002X2-3M; Mon, 02 Sep 2024 20:54:54 -0400
Received: by mail-ua1-x930.google.com with SMTP id
 a1e0cc1a2514c-846d414ea6bso348689241.3; 
 Mon, 02 Sep 2024 17:54:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1725324891; x=1725929691; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g+8Qyq5cWYAs8KxhkKG1KGTU4q4Xp05hHK78OsASezA=;
 b=YFRBkGLLZqOgHDArKb5hIAbcfE7KM8YUPsZ7xobI/VFYSIvpv/SaZTn5uBdPGVocKP
 27TcqVHGSwvJu9KcNzPJyRBWr/QtwTGb5NBdG1qDXLTOEhpSWnth+gJnIlAlm9n0A7rd
 feNtHscn+rUblskoNrQId66g3opB0jIXrRYI3SzdiAilptbpVvO15V0H4sKz9R+tb4LW
 KtbCam5nmoHBZN2wHyeI6B2+b6lqj5umHYBSxAwbXZLlTbpdsb3eG7T4HbodMexSy7EB
 lKFfGVFjz7ArKHOaOmUMpRK1BBA2i8j87DRQdxNxbXjNx5MxDPjIAIzTOSy8K8YY/rFn
 vi3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725324891; x=1725929691;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g+8Qyq5cWYAs8KxhkKG1KGTU4q4Xp05hHK78OsASezA=;
 b=wzoJ0R/mwAVUeORvB2w5LKrl9bZF6yMaKtuYFrqzPPTQ1ck/QJhUGBgsEJ11myzs6q
 0QE2ab1aQ8CNov1udMAvKCfMPNg0y1i6RGIRupGGGMTaOwd3cqwxJwMnIhfJO/oQpiXG
 lSu4YzKtCvMgdzL9YkYmTPx+lvol4F8Vb8DZhZKAVZZ8rU3s0BzE9EN9FLxW13AYtkxw
 qroDocvVisaENk5NBxoB8isAzOVYzBzrIbj85DHywEsSxhVrTBUFtB9f0YnZ/pvPotvj
 619k4w9e78cMdryv/EShwHf4XpH3oDuiu/7R2iKoaSYqa3nnMJStOky76h3S5vdsFMP0
 QhQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMFEEGE848qDpZVUdr0WL/yLzuUWQqwQhWlLwWVyzyKU+s8bPvgiJtNczEjmUTozoae8zsEOJnJyo/@nongnu.org
X-Gm-Message-State: AOJu0YwZaq3dbJRIfCHhRbb8+veLaGDSdor6SRBcSfJwjx0wU6NW12BG
 7DcXFEdYbxjPe7bdFLViSMOuEMR3PoEYInttC4FYzUCYD6/s8658Fyu0XCTPlpGK+GNWj+1Gi6r
 N6c/gEJ8TKO7DqilTj4NjbVOLEaE=
X-Google-Smtp-Source: AGHT+IGsnsO21sZXmBKmFV+cWOBX3S0ClDFH8OHGmeqAqMR7xOZscdD0a7x4xwx/UGXz9/eOunpFKjbJgrVUfu2xYKQ=
X-Received: by 2002:a05:6122:181f:b0:500:daf0:8909 with SMTP id
 71dfb90a1353d-500daf08b1dmr710119e0c.13.1725324890661; Mon, 02 Sep 2024
 17:54:50 -0700 (PDT)
MIME-Version: 1.0
References: <20240829084002.1805006-2-ajones@ventanamicro.com>
In-Reply-To: <20240829084002.1805006-2-ajones@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 3 Sep 2024 10:54:24 +1000
Message-ID: <CAKmqyKPBhKkOZAHw05BO9wmDNPiymOf3Bvc_z0zVWZ86VaNm6A@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Stop timer with infinite timecmp
To: Andrew Jones <ajones@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Anup Patel <apatel@ventanamicro.com>, palmer@dabbelt.com,
 alistair.francis@wdc.com, 
 bmeng.cn@gmail.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, atishp@rivosinc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::930;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x930.google.com
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

On Thu, Aug 29, 2024 at 6:40=E2=80=AFPM Andrew Jones <ajones@ventanamicro.c=
om> wrote:
>
> While the spec doesn't state it, setting timecmp to UINT64_MAX is
> another way to stop a timer, as it's considered setting the next
> timer event to occur at infinity. And, even if the time CSR does
> eventually reach UINT64_MAX, the very next tick will bring it back to
> zero, once again less than timecmp. For this reason
> riscv_timer_write_timecmp() special cases UINT64_MAX. However, if a
> previously set timecmp has not yet expired, then setting timecmp to
> UINT64_MAX to disable / stop it would not work, as the special case
> left the previous QEMU timer active, which would then still deliver
> an interrupt at that previous timecmp time. Ensure the stopped timer
> will not still deliver an interrupt by also deleting the QEMU timer
> in the UINT64_MAX special case.
>
> Fixes: ae0edf2188b3 ("target/riscv: No need to re-start QEMU timer when t=
imecmp =3D=3D UINT64_MAX")
> Signed-off-by: Andrew Jones <ajones@ventanamicro.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/time_helper.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/time_helper.c b/target/riscv/time_helper.c
> index 8d245bed3ae3..bc0d9a0c4c35 100644
> --- a/target/riscv/time_helper.c
> +++ b/target/riscv/time_helper.c
> @@ -92,6 +92,7 @@ void riscv_timer_write_timecmp(CPURISCVState *env, QEMU=
Timer *timer,
>       * equals UINT64_MAX.
>       */
>      if (timecmp =3D=3D UINT64_MAX) {
> +        timer_del(timer);
>          return;
>      }
>
> --
> 2.45.2
>
>

