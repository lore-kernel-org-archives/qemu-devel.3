Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E5ABC021A9
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 02:18:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkDAO-0006LD-JZ; Mon, 17 Feb 2025 21:16:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tkDAN-0006Ku-Pp; Mon, 17 Feb 2025 21:16:55 -0500
Received: from mail-vk1-xa2a.google.com ([2607:f8b0:4864:20::a2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tkDAL-0004aS-LO; Mon, 17 Feb 2025 21:16:55 -0500
Received: by mail-vk1-xa2a.google.com with SMTP id
 71dfb90a1353d-51eb1a6954cso1408779e0c.0; 
 Mon, 17 Feb 2025 18:16:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1739845011; x=1740449811; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+X6QnEum7wB50F6J7MZFbaK5kiLcnsoM/Nc4b+dONmA=;
 b=ngHHGa4Bj3RQVCETA39Z1KPv9jEzVlIGUUFfpPPNpIiDUw5PszHxqSb7bs/z8zYgCd
 vjWLKX8NRoFgsJuw0qKrtevda6tKlLAoy0iRYyzSPsBF93zGG1KSqN5UmZqDmJ7fxGj/
 yJ7VgvCOjfiq+B9bwZFaj8mqQGpwpCw4o2Wiyi9+t5mIqlpc6Flaa2Tg7ee03Jl/qGsY
 tlKLQP4E1BuRpqlnocSxcORU9yYomWRkNe6XzIV4Px2XnbE/I3Ao4Cl8xTyEt6jz59Ws
 KYPkJYPAZEkv9G63wVEyvyMHoqtfJ6PcGjemUNSvZ6Fd+nz3mErKUIz8IGaepPfIrv/A
 E7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739845011; x=1740449811;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=+X6QnEum7wB50F6J7MZFbaK5kiLcnsoM/Nc4b+dONmA=;
 b=PX6lnugfiJLpUTeF3krw2Wa83fyrSuoX4FngTRE0ex1zy69D2x3J+exjJ6DlaqsCH+
 ULZ6ruulIOW4pX79zqL7LORMH4TRkxjRAEP8E6O8fPF5BGmaAMQ2DBr+9F2HpQjX0/AY
 7f4O57p+w8t5y9jRvdKsLJ/6h5NoQP5/erGQCSvlmK5RySwm+JiG7xZHg8PAc14oNXfM
 6O+lVRBOI/74ROYqjdaPQzn5vuo9anGJa8A/RjZh3vf8CbnH2JcXTzhlt/oHbMq52MgI
 +xxxB9I4Qx118oc5USZFtwE1y7t2hgW3WkUYDw/Jq6yYaxy5FlH8HNsJbpBLJP6OwRvn
 Qazg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNwwT6CNOumtAAL7GTKO1VaVnT/2J4UTzD57P+17SJQL9Vp3tE7/TKo8bpBx+5t3q7gnGFxAzp5vPo@nongnu.org
X-Gm-Message-State: AOJu0YwxfkEKDodioeP7NKDFgVSMMHdDuMS5ZnQPkEb2bcJ+7HDW1fS7
 PyNTdJ7m9whJ6NIIhdsIshGvV3AWtbTiPSdN+qOwVDuthK6izWoSyGOchW2T6pBa+xjHQQi0rK9
 MyNNtpls0jY2B13nH6axJ0TEsdmU=
X-Gm-Gg: ASbGnct/ZbB1bknfr2On00EK6QYEXl/F73p+ApowtmDsI/onwEhHqVx53Hiu1AXZQ2O
 p2/PoK+8DSfXvt5KHmB4UUMl1UDGeW9CNotQkM6YTYFz3qom/Efhzzqp3TDcg20v14atoKX8uxF
 +/GJ/j85MFUJgyvuayLGMo/JAnBg==
X-Google-Smtp-Source: AGHT+IFbA/HeTy70qVLAsZ0Q6o6w0vAsc5ybRMdKyt1o0eH73YbjqpkRD2yhXtITsL48HF5RXFyoF/ROeUnuC/Nehmk=
X-Received: by 2002:a05:6122:3d10:b0:520:6773:e5ca with SMTP id
 71dfb90a1353d-5209dcb847emr4797002e0c.6.1739845011530; Mon, 17 Feb 2025
 18:16:51 -0800 (PST)
MIME-Version: 1.0
References: <20250210153713.343626-1-rbradford@rivosinc.com>
In-Reply-To: <20250210153713.343626-1-rbradford@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 18 Feb 2025 12:16:25 +1000
X-Gm-Features: AWEUYZmFbBZG4GV3MvxnOmf82fJPVIt-T-6FzE1nPELSEN4zwFb2iQ-fr8GdmZw
Message-ID: <CAKmqyKNfA8ScP9LqM4D91K5de8fpN7adkyjT1H=BuDgjjm41kw@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Respect mseccfg.RLB bit for TOR mode PMP
 entry
To: Rob Bradford <rbradford@rivosinc.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, qemu-riscv@nongnu.org, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2a;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2a.google.com
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

On Tue, Feb 11, 2025 at 1:38=E2=80=AFAM Rob Bradford <rbradford@rivosinc.co=
m> wrote:
>
> When running in TOR mode (Top of Range) the next PMP entry controls
> whether the entry is locked. However simply checking if the PMP_LOCK bit
> is set is not sufficient with the Smepmp extension which now provides a
> bit (mseccfg.RLB (Rule Lock Bypass)) to disregard the lock bits. In
> order to respect this bit use the convenience pmp_is_locked() function
> rather than directly checking PMP_LOCK since this function checks
> mseccfg.RLB.
>
> Signed-off-by: Rob Bradford <rbradford@rivosinc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/pmp.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/target/riscv/pmp.c b/target/riscv/pmp.c
> index a185c246d6..85ab270dad 100644
> --- a/target/riscv/pmp.c
> +++ b/target/riscv/pmp.c
> @@ -524,7 +524,7 @@ void pmpaddr_csr_write(CPURISCVState *env, uint32_t a=
ddr_index,
>              uint8_t pmp_cfg =3D env->pmp_state.pmp[addr_index + 1].cfg_r=
eg;
>              is_next_cfg_tor =3D PMP_AMATCH_TOR =3D=3D pmp_get_a_field(pm=
p_cfg);
>
> -            if (pmp_cfg & PMP_LOCK && is_next_cfg_tor) {
> +            if (pmp_is_locked(env, addr_index + 1) && is_next_cfg_tor) {
>                  qemu_log_mask(LOG_GUEST_ERROR,
>                                "ignoring pmpaddr write - pmpcfg + 1 locke=
d\n");
>                  return;
> --
> 2.48.1
>
>

