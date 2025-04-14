Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C408C369B2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Apr 2025 11:18:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4HoW-0008HW-Da; Mon, 14 Apr 2025 07:17:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ziqiaokong@gmail.com>)
 id 1u4HoS-0008HD-KS; Mon, 14 Apr 2025 07:17:16 -0400
Received: from mail-vk1-xa2d.google.com ([2607:f8b0:4864:20::a2d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ziqiaokong@gmail.com>)
 id 1u4HoQ-0002Aw-JK; Mon, 14 Apr 2025 07:17:16 -0400
Received: by mail-vk1-xa2d.google.com with SMTP id
 71dfb90a1353d-52446b21cfdso1780988e0c.1; 
 Mon, 14 Apr 2025 04:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744629433; x=1745234233; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FwU/3duoMzPmCLBmlSEEpQ+EfCjeAWRzJJ1nwlpKUxY=;
 b=YT6JQv501ie46YIu3Nglydh/iRADyVAlcsMgHMuf8w3Wx3PqSKgHOb//jZ/UUhYfbV
 pYT2BkqQ/WyiWmGBlvMq8ZgVGd5ZipjqQaiV+7OkQ2mx7W8m+vkpd/4zP4D6Af2xrBFc
 Z7ehq/88SpUwj1O/beJL1RW+N7t5y775qSlOF/3gRnIGppV48KDjM2UzrVYaJ/wAwB7y
 YDTekP30HlJcWX4lDDOHjbAoZea/wMO0RlfsGeuQLwR/EZSf8027bBmaKrEHl05Tblwd
 teW0+dkeQRscF82nu8gFUA3Vv7V4xGLqqDUyhIE6/+J6CnQKbNFB7fE2WWPXs99ldukZ
 f9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744629433; x=1745234233;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FwU/3duoMzPmCLBmlSEEpQ+EfCjeAWRzJJ1nwlpKUxY=;
 b=Dz5KIhkzIuGkOrzo/MLM/NCSClJzxvG+0MPCZsaR/P6PflQbVyPZwEzaGswZLT2f00
 yUhGjUGXXgOkBatN5BzMpzLYx5J+/3dXoyQRxh4gI205t6NQ9K5IEeaT8IBBxhRTNmEy
 2WP5JQEG6NIgel+HNROhDA25y0411fqH+HoDcbwi4M8jPyObbZ5apPvqfpW/CEN/pVAT
 PUsXFBCM20xBD5IfeamxnG9/gzdxpsdbycRBaI1AZ4Lywzh24qVAhc60nmw3xkRmG37o
 1luZGxXU1sVumSfULKmJBrbiJWPhhsT/KW7hTTaheEXKefZQh8kXwjLGiQlhJSm3cLVh
 n2fA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWK8taDMhJXKumQCpcguRxEiOeGxZCTWL8vxLfI6vZFiGURnWsoON7g4wwDL/l20iIZMzsjNXOrfXK8/b4=@nongnu.org
X-Gm-Message-State: AOJu0YwjP135qnSTr8IMEw9PlJbHkU4yKZewL/U827iOFlgXEa51hqSn
 SAb/oWbVnAWfWKaihdVkLdv/NJQd7PNKlCq6gC9ZmP3V3cmBSjYoiP+fovgHzSpjpORI526B8GJ
 wKUeMAksqPUxYuPc1ZjjGcTf6jHTJCfdc
X-Gm-Gg: ASbGncs2EuiQs+EWi3IxtsgcQLuRfOt2vp1UHYxBwEbVv9zPUitVAkVhlrIGHnZkwVJ
 bYdsmUHHqET1FqMlQPGfiDP2jJjrC6PaMeyqgORyuqL27lzxQ9w6b83uo+agd2adKkI/gmQ3gSN
 skCYVUT5srBPCxfnhoNz67Tg==
X-Google-Smtp-Source: AGHT+IEpy+/cAdKGWOTVqhnbJQN5yxJs38MxXbyz85OxySPY+/rDwZxMhk8szWuKREUW8K7WHSdfsWALGYi72J3w7JA=
X-Received: by 2002:a05:6122:8c6:b0:526:720:704 with SMTP id
 71dfb90a1353d-527c359743fmr6494705e0c.7.1744629432657; Mon, 14 Apr 2025
 04:17:12 -0700 (PDT)
MIME-Version: 1.0
References: <20250414034626.3491489-1-ziqiaokong@gmail.com>
 <20250414034626.3491489-2-ziqiaokong@gmail.com>
 <3c9e1adc-eb4e-49f4-be32-b273a5a161b8@linaro.org>
In-Reply-To: <3c9e1adc-eb4e-49f4-be32-b273a5a161b8@linaro.org>
From: Ziqiao Kong <ziqiaokong@gmail.com>
Date: Mon, 14 Apr 2025 19:17:00 +0800
X-Gm-Features: ATxdqUEuKvhtpv_hqx2zhvx-lskXItBGJAWym2WazV_QVc-PR4ipIt4qRhHFGYc
Message-ID: <CAM0BWNCVU3GNqAe-stRRYytqC2H7G2iC8Wmpe3sz0u4kkUpYDg@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] target/riscv: fix endless translation loop on big
 endian systems
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, alistair.francis@wdc.com, 
 richard.henderson@linaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2d;
 envelope-from=ziqiaokong@gmail.com; helo=mail-vk1-xa2d.google.com
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

On Mon, Apr 14, 2025 at 6:41=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> Hi,
>
> On 14/4/25 05:46, Ziqiao Kong wrote:
> > On big endian systems, pte and updated_pte hold big endian host data
> > while pte_pa points to little endian target data. This means the branch
> > at cpu_helper.c:1669 will be always satisfied and restart translation,
> > causing an endless translation loop.
> >
>
> Cc: qemu-stable@nongnu.org
> Fixes: 0c3e702aca7 ("RISC-V CPU Helpers")
>
> > Signed-off-by: Ziqiao Kong <ziqiaokong@gmail.com>
> > ---
> >   target/riscv/cpu_helper.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> > index 6c4391d96b..bc146771c8 100644
> > --- a/target/riscv/cpu_helper.c
> > +++ b/target/riscv/cpu_helper.c
> > @@ -1662,9 +1662,9 @@ static int get_physical_address(CPURISCVState *en=
v, hwaddr *physical,
> >               target_ulong *pte_pa =3D qemu_map_ram_ptr(mr->ram_block, =
addr1);
> >               target_ulong old_pte;
> >               if (riscv_cpu_sxl(env) =3D=3D MXL_RV32) {
> > -                old_pte =3D qatomic_cmpxchg((uint32_t *)pte_pa, pte, u=
pdated_pte);
> > +                old_pte =3D qatomic_cmpxchg((uint32_t *)pte_pa, cpu_to=
_le32(pte), cpu_to_le32(updated_pte));
> >               } else {
> > -                old_pte =3D qatomic_cmpxchg(pte_pa, pte, updated_pte);
> > +                old_pte =3D qatomic_cmpxchg(pte_pa, cpu_to_le64(pte), =
cpu_to_le64(updated_pte));
> >               }
> >               if (old_pte !=3D pte) {
> >                   goto restart;
>
> If PTEs are always stored in LE order, maybe what we want is earlier:
>
> -- >8 --
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 619c76cc001..b6ac2800240 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -1464,5 +1464,5 @@ static int get_physical_address(CPURISCVState
> *env, hwaddr *physical,
>           if (riscv_cpu_mxl(env) =3D=3D MXL_RV32) {
> -            pte =3D address_space_ldl(cs->as, pte_addr, attrs, &res);
> +            pte =3D address_space_ldl_le(cs->as, pte_addr, attrs, &res);
>           } else {
> -            pte =3D address_space_ldq(cs->as, pte_addr, attrs, &res);
> +            pte =3D address_space_ldq_le(cs->as, pte_addr, attrs, &res);

Unfortunately, this doesn't work in two ways:

1. Note pte is used in the following code and that means pte must hold
a correct value from the
view of host endian (in my case, big endian not little endian).
2. address_space_ldq_le will dispatch to ldq_le_p, while
address_space_leq will dispatch to ldq_p.
However, on little endian targets, ldq_p is an alias of ldq_le_p so
making no effects.

Per my testing, this patch doesn't have any effect indeed. To have a
brief view what is happening,
see the logs just before atomic_cmpxchg:

pte_pa 0xf14000000000000 =3D=3D pte 0x140f ? updated_pte 0x144f

>           }
> ---

