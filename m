Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C7AAC0218A
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2025 01:29:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcwse-0005QQ-DG; Tue, 28 Jan 2025 20:28:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcwsa-0005Q0-FL; Tue, 28 Jan 2025 20:28:32 -0500
Received: from mail-vk1-xa2f.google.com ([2607:f8b0:4864:20::a2f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tcwsY-0001fp-N8; Tue, 28 Jan 2025 20:28:32 -0500
Received: by mail-vk1-xa2f.google.com with SMTP id
 71dfb90a1353d-518a52c8b5aso2064606e0c.2; 
 Tue, 28 Jan 2025 17:28:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1738114109; x=1738718909; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cG8yehSPIw7MwAxwKTF1P68Vgihkaupl72Rb/W4O0XI=;
 b=f7qSPmBUrrG2n6l/FA/5xihrVrdrEegGkY5DI5YTZ+LWogBbi5xiGsUHtSHNVKCUG6
 9ewpXY32UhMz0qvQLK5BcC/XrU+pA5WbjVq6EPW+0AVoObxz/Ju0TuAbUMcCPqW61CLh
 J+mCec9KqFw0BQmBlkquAMIZ216rK3oEOKDz8PIG3MqijNbIfvyex0vThf0O0/LFKin6
 +jiOhMHehgJHj3oEtRRv5Z6nQJWpPOE8PHOKy5PlaAHii+ZYpnjAhbFvV4NTJ56QqpVF
 jGhLMWeMTlwmc71xIlS5wAKCAfgn1lFf+IDv/R6XaFJ/PU0HxQ8Ir1GMK84Dggo+X3YW
 rgyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738114109; x=1738718909;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=cG8yehSPIw7MwAxwKTF1P68Vgihkaupl72Rb/W4O0XI=;
 b=QuapuPQeVLgkH25c7M4nOd781N/G9jfSkhTuvFlWCCA9uGygV+Ywho4K2BKUXw8rdN
 +CMX/aivxdzM5A9GLQqHHEg8TPveOln98QGJafUZeRBsHvPNwSD8m9eDpen6HaTMKj/i
 05p+fzGiuiezteyzfDe5PB4cFIlexoxGY11380TMVPN5JK57S+wx7Apnat24j9cuGuki
 ZmW/KZ8PWD8mIe2Hqb3B0Ip0w2WMFjzabJ/Swg1Lk/wnXPYqyQ1cgcECj/8FS0l3mu4q
 zMt3PLvnT/38DLpzA1BKI26IYMqacNN5y4VP8uIfEVqJccp+mQcv07t+ssEqw7PaXPfC
 6YVA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+4oiA8geUDdq3axuuc4jWVweoiUSTvwi4AZ5QXq2acWCxyqVedXCRQsf4DqYHuGNCIi9E2rVteUVe@nongnu.org,
 AJvYcCVJ1o7/ecYeRdCPxnMImgwZvRGqIaaXRsOzYhSS6Dyl3gJDbhl47hGVP0JBdYpZ6PUa7r8Zli/d7x5cSA==@nongnu.org
X-Gm-Message-State: AOJu0YxjRPgPumaNkg4a7WDjLXoUjwB0z+9Sqgdig1MLCDm4YqeArVsN
 KB/oTIrqo82vIhW2wn5ZNZdi8Zduj2zo5Brx3N5e/uDYDtTjlLaKF7FEyt7H+GPCMvWM1UfESAC
 gXPe53NtGaxYZHhapG09UBhE2AiQ=
X-Gm-Gg: ASbGncutwmnYws6+xo1GO9me3EKi+Krrr9IbMBWOG9P6QE2orGy4nLWsU8Pi77xXeLA
 MMP56jWIAIMXTjMCBnTTw1aPLvKpvT9uBwsXFnR8RymLyfkamhCFFp0RbJhdPVR8IfDb/aO9J1t
 LEMQcXT33A//Xiq5Dnex9Lhu8H2g==
X-Google-Smtp-Source: AGHT+IFiHdLxcTitrRcA1DOhx2X8kDIjMP2gctaXtBf63XewCItz0XzF7fUAD7k5DebyexybRigNib/pLFXxHPQwRTg=
X-Received: by 2002:a05:6122:4f90:b0:50b:e9a5:cd7b with SMTP id
 71dfb90a1353d-51e9e53e28fmr1686557e0c.9.1738114109242; Tue, 28 Jan 2025
 17:28:29 -0800 (PST)
MIME-Version: 1.0
References: <20250114092012.29024-1-evgenii.prokopiev@syntacore.com>
In-Reply-To: <20250114092012.29024-1-evgenii.prokopiev@syntacore.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 29 Jan 2025 11:28:03 +1000
X-Gm-Features: AWEUYZnal9Woe4wA-30YTyfZlXrdc3Hmmz_5CB5A8bCEg6-OiqWPnr4MBk2iV6s
Message-ID: <CAKmqyKNpF0+8AUcnC2hqqQLRG7sE-6RwQCrEV4vajYYFtuMzPw@mail.gmail.com>
Subject: Re: [PATCH] target/riscv/csr.c: Turn off mstatus.vs when misa.v is
 turned off
To: Evgenii Prokopiev <evgenii.prokopiev@syntacore.com>
Cc: palmer@dabbelt.com, alistair.francis@wdc.com, bmeng.cn@gmail.com, 
 liwei1518@gmail.com, dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, 
 qemu-riscv@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2f;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2f.google.com
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

On Tue, Jan 14, 2025 at 7:33=E2=80=AFPM Evgenii Prokopiev
<evgenii.prokopiev@syntacore.com> wrote:
>
> A behavior of misa.v must be similar as misa.f.
> So when this bit's field is turned off, mstatus.vs must be turned off
> too. It follows from the privileged manual of RISC-V, paragraph 3.1.1.
> "Machine ISA (misa) Register".
>
> Signed-off-by: Evgenii Prokopiev <evgenii.prokopiev@syntacore.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/csr.c | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/target/riscv/csr.c b/target/riscv/csr.c
> index eab8e50012..fca2b1b40f 100644
> --- a/target/riscv/csr.c
> +++ b/target/riscv/csr.c
> @@ -1537,6 +1537,10 @@ static RISCVException write_misa(CPURISCVState *en=
v, int csrno,
>          env->mstatus &=3D ~MSTATUS_FS;
>      }
>
> +    if (!(env->misa_ext & RVV)) {
> +        env->mstatus &=3D ~MSTATUS_VS;
> +    }
> +
>      /* flush translation cache */
>      tb_flush(env_cpu(env));
>      env->xl =3D riscv_cpu_mxl(env);
> --
> 2.34.1
>
>
>

