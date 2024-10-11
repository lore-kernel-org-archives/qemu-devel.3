Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01EC5D2446B
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Oct 2024 04:00:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz6ou-0004Ob-NT; Fri, 11 Oct 2024 00:00:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sz6or-0004NW-7q; Fri, 11 Oct 2024 00:00:01 -0400
Received: from mail-vk1-xa34.google.com ([2607:f8b0:4864:20::a34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sz6op-0006R4-Mh; Fri, 11 Oct 2024 00:00:00 -0400
Received: by mail-vk1-xa34.google.com with SMTP id
 71dfb90a1353d-509fc9d2074so477499e0c.3; 
 Thu, 10 Oct 2024 20:59:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728619198; x=1729223998; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=l89AYc8XCaPwenDg14ziDugjNtw8rWMmRU0xmJlBtGQ=;
 b=VtNOtxoEl1mvzwQPYRhXK+RScgBmlDtiqT115xJdE7BKnlkJle25flX876d4JZpLyv
 YVWZ+BeIQmxCyur1qK+FLKRo3t18NSBi1UUryHODP0RagGa78QRP+rc29AqY9pANWLKZ
 5bmi80+ryXZ6GcSd9XfYzV+cQG+e6oHujT2ORm7COGJMfFo5Z/U/LOJBy/pbx57ac2Lw
 kTEblle928JMrBGBZtv6jZ7vhzKO4pe5J6Itg/1I8eLhi6PoOrZ1R6E8z8fDKwJmd6t2
 RZXm7y56CzbUFHaLYimDopBdWpWKB9oEFdr1QcOanzkZU6Tw7uJJAhJXivStPa4mbW3+
 SWbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728619198; x=1729223998;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=l89AYc8XCaPwenDg14ziDugjNtw8rWMmRU0xmJlBtGQ=;
 b=QXMfJgN+1pPDh6yph5szmDxowmZDLW5WMUbdCusS+g5ooKm782a98M6fqn4Lm866fY
 VGUUC/DWJTRsZ3dC9rD5yueaBHxy/qZjY0yBP2IowEJfKLJ7vJzilNGcRnxeuR7WwQBl
 ZfkcIkYdmVFwB/AuW11aaqF3Z986xjqRIBRTYi9EdmMmxfbyyjnZLa4boc7iapqRKwWO
 N9MQ8ChHzh/ASsORBGQl/fd+63yB4BlGC6XZtJzb87Y/Yu7MGiCpazOVoLKKKvRjDbaP
 RsOqwNWfyJmEkvGBzS/893gWB3aTjimaFl03DlfUZEufebLlZbTNFeRzGvmsGxRKmt1d
 9cDQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXmcoIqHqH4Aq3ifffVJWFCN8sN8R1PHwVX+MFIGQsmIGBojEjbQZsHrqyPF3DuJeuxWmS1zOTxdJlh@nongnu.org
X-Gm-Message-State: AOJu0Yyc2MYvJ8wW/0hsfx5D3fLnJBEzH5N8D6hZJwYRQ6O2MCoeK/jk
 KeMsrHD6v7zTf+FWMVx8DCbeGhIc4VtGsxczUyCV2o858t88hKvGJbe1jqo0FoISPU1xlZtMApS
 A9gcBzFIRSOKAVbhAp/zg49zghHa5HXWx
X-Google-Smtp-Source: AGHT+IF+DClzt9xGA6xq3K2sycNEKj6eEUyCm4SQfw9zfdhTo+z/WzOhpjfWjiuQiCyF9BNcDDy2vt3EPTOjRTCc6k4=
X-Received: by 2002:a05:6122:3d01:b0:50c:9834:57b3 with SMTP id
 71dfb90a1353d-50d1f3b9805mr720185e0c.4.1728619198318; Thu, 10 Oct 2024
 20:59:58 -0700 (PDT)
MIME-Version: 1.0
References: <20241007033400.50163-1-zhiwei_liu@linux.alibaba.com>
 <20241007033400.50163-4-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20241007033400.50163-4-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 11 Oct 2024 13:59:32 +1000
Message-ID: <CAKmqyKMoJ_ixn4xK0w_qrrdwy8DSaDW-8dkDqcuzPNYw+77Cug@mail.gmail.com>
Subject: Re: [PATCH v1 3/7] target/riscv: Read pte and satp based on SXL in PTW
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 bmeng.cn@gmail.com, TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a34;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa34.google.com
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

On Mon, Oct 7, 2024 at 1:36=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux.alibaba=
.com> wrote:
>
> From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>
> Satp and PTE are always SXLEN-bit. when SXLEN is 32,
> read PTE as 4 bytes, and treat satp as SATP32.
>
> Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  target/riscv/cpu_helper.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 077f6d77c3..773789e02e 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -851,7 +851,7 @@ static int get_physical_address(CPURISCVState *env, h=
waddr *physical,
>                  vm =3D get_field(env->vsatp, SATP64_MODE);
>              }
>          } else {
> -            if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> +            if (riscv_cpu_sxl(env) =3D=3D MXL_RV32) {
>                  base =3D (hwaddr)get_field(env->satp, SATP32_PPN) << PGS=
HIFT;
>                  vm =3D get_field(env->satp, SATP32_MODE);
>              } else {
> @@ -972,7 +972,7 @@ restart:
>              return TRANSLATE_PMP_FAIL;
>          }
>
> -        if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> +        if (riscv_cpu_sxl(env) =3D=3D MXL_RV32) {
>              pte =3D address_space_ldl(cs->as, pte_addr, attrs, &res);
>          } else {
>              pte =3D address_space_ldq(cs->as, pte_addr, attrs, &res);
> --
> 2.43.0
>
>

