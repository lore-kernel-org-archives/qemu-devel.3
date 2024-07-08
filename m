Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8D92C38150
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jul 2024 02:44:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQeM0-00048a-Ch; Sun, 07 Jul 2024 22:43:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sQeLz-00047a-Cy; Sun, 07 Jul 2024 22:43:47 -0400
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1sQeLw-0006n1-Qf; Sun, 07 Jul 2024 22:43:46 -0400
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-4f2f39829a9so1132908e0c.2; 
 Sun, 07 Jul 2024 19:43:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720406623; x=1721011423; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eNa6Wo6vxVtiIHoZAyecmwpknnn5iGmere4Uz8Md2U0=;
 b=c3ENmiQXVHiXqNDfj4miT5rI0iJIWPye6yQ9BlVcn9kMvhIf9aixZmaM0AhAADWCJe
 7O6ed/yK2CiHPgUazrs6MEZTKQy+M7F/s/dGT+suM9ggE1QnowOjda+vrbcuOe2KsED6
 MMN5GpLAjKB+pOyWl0KSPt/YZOl5Oxc5txsSeJ4jfwn3tfLWP6m5MHHrKo0XQkOeMWGJ
 cMttPgSBzw5NdXttKd9luigPIE2bYJ0ycZIMKhKttc2eSAD5thKTrYOJdiNJycwXknyf
 zy/dRUyPgsDoDr2Yglc02M+lbZY8hJShVvWjVrPhke3qVRYiqPH9IMDWihBAV2t4OSPe
 j7Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720406623; x=1721011423;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=eNa6Wo6vxVtiIHoZAyecmwpknnn5iGmere4Uz8Md2U0=;
 b=UXTBQu7aZ9JIhXQe3TbaZsHta/284VSXFIS6WUrFRDWHzgrx8gZXbwR5PtkqQVTMLv
 dnHti4EX2SrM7dOZ4U0Q20afb3CC17tFswyrf5gVp0izZj/f9iIF/rb3e4k68UB/zPUL
 m5bWemhwmD/rQLfRp7zcdXmB2jQnRl+HIn/YzvsXl3nodgetvOUA9UfW9qok00aWxjJp
 /Rr0fWpL4uBruqd+Po5PAeCMhSJQKdYY6Y/ua3bN6C7eM59vex2/taVh2Rtrnsbf4WFu
 WfcJHQiCqwqbsjKeWMWwKY5EgOleW9cIKxlRyjqFFDxq2gTTi1PjQn3pyFkIr+jSHmw7
 +xjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVRlhbd6K7I/0rV7bOORVQqE+fbnw+Q2jYVHvp+O4LmGgh8EAHKUN5EALlcLuGmSVoB9Vmv6QPYF5X6Uqb7B2IYLAHzX8U=
X-Gm-Message-State: AOJu0YxakXIU60H2SaRXo7EOXEXEzpJDlgW6AUgTQBCXHnYotqsrP0k8
 5GyaxxWTz82N7prhTnwhCMiEaIRdvd/KFE16/3YLixZQ1ulzly8+cvCPtLDR/8COTjSTq0av8jf
 /x30tiHDiQFK1B3PtyS1Q/aLzxkw=
X-Google-Smtp-Source: AGHT+IEqwpNnO/36MJVXJiCOPC7H+91xjAG21dGYooxODP6erwkfGBai8uGCMBtLBnPYAlIN5UH76DXlTOxw55tX8Es=
X-Received: by 2002:a05:6122:1054:b0:4f2:ffa9:7700 with SMTP id
 71dfb90a1353d-4f2ffa978f9mr6893823e0c.15.1720406623006; Sun, 07 Jul 2024
 19:43:43 -0700 (PDT)
MIME-Version: 1.0
References: <20240703144921.1281-1-zhiwei_liu@linux.alibaba.com>
 <20240703144921.1281-5-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240703144921.1281-5-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 8 Jul 2024 12:43:17 +1000
Message-ID: <CAKmqyKOK4B_RNYL+P+L_Q4hFFiH7GJMWo11v=Cvu304n5ixYWA@mail.gmail.com>
Subject: Re: [PATCH v3 4/7] target/riscv: Detect sxl to set bit width for RV32
 in RV64
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, dbarboza@ventanamicro.com, liwei1518@gmail.com, 
 bmeng.cn@gmail.com, TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2e.google.com
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

On Thu, Jul 4, 2024 at 12:54=E2=80=AFAM LIU Zhiwei <zhiwei_liu@linux.alibab=
a.com> wrote:
>
> From: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
>
> Ensure correct bit width based on sxl when running RV32 on RV64 QEMU.
> This is required as MMU address translations run in S-mode.
>
> Signed-off-by: TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
> Reviewed-by: Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
> ---
>  target/riscv/cpu_helper.c | 17 ++++++++++++-----
>  1 file changed, 12 insertions(+), 5 deletions(-)
>
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 6709622dd3..fa3b845c85 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -887,12 +887,14 @@ static int get_physical_address(CPURISCVState *env,=
 hwaddr *physical,
>
>      CPUState *cs =3D env_cpu(env);
>      int va_bits =3D PGSHIFT + levels * ptidxbits + widened;
> +    int sxlen =3D 16UL << riscv_cpu_sxl(env);

A leftover UL here

Otherwise:

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> +    int sxlen_bytes =3D sxlen / 8;
>
>      if (first_stage =3D=3D true) {
>          target_ulong mask, masked_msbs;
>
> -        if (TARGET_LONG_BITS > (va_bits - 1)) {
> -            mask =3D (1L << (TARGET_LONG_BITS - (va_bits - 1))) - 1;
> +        if (sxlen > (va_bits - 1)) {
> +            mask =3D (1L << (sxlen - (va_bits - 1))) - 1;
>          } else {
>              mask =3D 0;
>          }
> @@ -961,7 +963,7 @@ restart:
>
>          int pmp_prot;
>          int pmp_ret =3D get_physical_address_pmp(env, &pmp_prot, pte_add=
r,
> -                                               sizeof(target_ulong),
> +                                               sxlen_bytes,
>                                                 MMU_DATA_LOAD, PRV_S);
>          if (pmp_ret !=3D TRANSLATE_SUCCESS) {
>              return TRANSLATE_PMP_FAIL;
> @@ -1113,7 +1115,7 @@ restart:
>           *   it is no longer valid and we must re-walk the page table.
>           */
>          MemoryRegion *mr;
> -        hwaddr l =3D sizeof(target_ulong), addr1;
> +        hwaddr l =3D sxlen_bytes, addr1;
>          mr =3D address_space_translate(cs->as, pte_addr, &addr1, &l,
>                                       false, MEMTXATTRS_UNSPECIFIED);
>          if (memory_region_is_ram(mr)) {
> @@ -1125,7 +1127,12 @@ restart:
>               */
>              *pte_pa =3D pte =3D updated_pte;
>  #else
> -            target_ulong old_pte =3D qatomic_cmpxchg(pte_pa, pte, update=
d_pte);
> +            target_ulong old_pte;
> +            if (riscv_cpu_sxl(env) =3D=3D MXL_RV32) {
> +                old_pte =3D qatomic_cmpxchg((uint32_t *)pte_pa, pte, upd=
ated_pte);
> +            } else {
> +                old_pte =3D qatomic_cmpxchg(pte_pa, pte, updated_pte);
> +            }
>              if (old_pte !=3D pte) {
>                  goto restart;
>              }
> --
> 2.25.1
>
>

