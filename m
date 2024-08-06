Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6891DC3DA7F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 01:52:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sb9Mf-0007Zu-VG; Mon, 05 Aug 2024 21:51:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sb9Me-0007YW-CQ; Mon, 05 Aug 2024 21:51:52 -0400
Received: from mail-vk1-xa31.google.com ([2607:f8b0:4864:20::a31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sb9Mb-0002aD-Ce; Mon, 05 Aug 2024 21:51:51 -0400
Received: by mail-vk1-xa31.google.com with SMTP id
 71dfb90a1353d-4f511fddfcfso75859e0c.1; 
 Mon, 05 Aug 2024 18:51:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1722909106; x=1723513906; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=99hNN65zoORcaaySPQmwpDhXeR0aMyowbweb/8MhFKc=;
 b=kMimcS4kEKYvjfTRO6ZvPWE7CgAzwz4SHmizVeBshwwHjfVdG+y49Q1WsEUI/xeAjL
 6SuNqL+CabPKRcfmomuUVzs8acRruGwBxmgdLlYVAZE2Ub76iFoDiV76z/V/pmUFR1G8
 g7IIIOfJ+DfOqt2ZxyXQZ7gv7WVEP0LUKzC+j8Y0QPUS0rv+mb8Nvv2+nL/0RqSh1MnO
 FfnECwNtH3rH7ufYgbxABykNnC7bVqiL+/F96CGRYBuk9mDDnqE8HpMC6azOaIwxfjxj
 gi/RKKTsH09MmZ1QYLpHf1A2i4hclSFK3VC58GbQzGeflNfObSCbrbi08S5KEDupE7lC
 iNVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722909106; x=1723513906;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=99hNN65zoORcaaySPQmwpDhXeR0aMyowbweb/8MhFKc=;
 b=HNeHy9XyZrdt6Eg0/Xk+qRrmPKVwPFvbFx/2q1QtweGRXbVZVP3+EArE4boqM/B1JU
 nMMcRcWLCNwp8aoZlf/VYDPLlqc87l9+1EW1bJhB4LMinq6agJckvi0qoYphFQbq05d+
 RGeR/j7Tj9U249adFpQ0jQP/sPMJOdhDNkNMFPJJg1RwyyfARtUDZ8Thy8v6Mrm2UJc5
 5jHh+3PG2KmtuuMROTFWFAqTr7EGai74VRQ/1kW7KjeAWybUpQSUV++tZBpQXZX65lpn
 GAav3hn7KDCUsRyfeWkBjoMwF9tnU+W9rYnMj7RMKu0xS0H7UnZ2LXCtn3BritsyxZNe
 d9LQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXO2ykXHKmY8Gl3OMa8suAxvE0hL3VJtYRwQtC2rwiSkRXqFBze++XSpwSjZpQD4YMIPq9dVPElOZ/74yRpMbveVIETzk=
X-Gm-Message-State: AOJu0YxSs6zrFLmUTkPfPouJrN8kx8ctbCFQ/30VHtlkXKmgkXRKwUWB
 hGrCP7YbpE+qe7+E/ZnoaBkK625r+Bi+afLP3JbaRuxOwTQApZQISuCFd6fBKVDzx9SHeAhhwox
 pMZViGXvpNRdvrJBTuhKGVwnn5MM=
X-Google-Smtp-Source: AGHT+IGSKto8RTM2CRZfVftLFBs4bBd6OxWJo62zLfb9wkpaYsllgYOZLIYUhQ18Vexxx5qaM9C6iffjp/nPgcfBMAU=
X-Received: by 2002:a05:6122:3b04:b0:4ef:64a2:8e18 with SMTP id
 71dfb90a1353d-4f8a0020c63mr14938244e0c.12.1722909106259; Mon, 05 Aug 2024
 18:51:46 -0700 (PDT)
MIME-Version: 1.0
References: <20240723-counter_delegation-v2-0-c4170a5348ca@rivosinc.com>
 <20240723-counter_delegation-v2-10-c4170a5348ca@rivosinc.com>
In-Reply-To: <20240723-counter_delegation-v2-10-c4170a5348ca@rivosinc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 6 Aug 2024 11:51:20 +1000
Message-ID: <CAKmqyKPfVkiiiOTZnFfLEY527AmPqLRxAMG8SS2_X_rZ8RaBFg@mail.gmail.com>
Subject: Re: [PATCH v2 10/13] target/riscv: Enable sscofpmf for bare cpu by
 default
To: Atish Patra <atishp@rivosinc.com>
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, palmer@dabbelt.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, bin.meng@windriver.com, 
 dbarboza@ventanamicro.com, alistair.francis@wdc.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a31;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa31.google.com
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

On Wed, Jul 24, 2024 at 9:33=E2=80=AFAM Atish Patra <atishp@rivosinc.com> w=
rote:
>
> Sscofpmf has been supported on virt machine for a long time. It is
> required to enable profiling on virt machines. Let's enable it
> by default for ease of usage.
>
> Signed-off-by: Atish Patra <atishp@rivosinc.com>
> ---
>  target/riscv/cpu.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
> index 1731dc461376..393d1d67120e 100644
> --- a/target/riscv/cpu.c
> +++ b/target/riscv/cpu.c
> @@ -494,6 +494,7 @@ static void rv64_base_cpu_init(Object *obj)
>      env->priv_ver =3D PRIV_VERSION_LATEST;
>  #ifndef CONFIG_USER_ONLY
>      set_satp_mode_max_supported(RISCV_CPU(obj), VM_1_10_SV57);
> +    cpu->cfg.ext_sscofpmf =3D true;

Unfortunately we don't want to do this, the base CPU should be bare
bones and then users can enable extensions.

Alistair

>  #endif
>  }
>
>
> --
> 2.34.1
>
>

