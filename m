Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CE6CD11BF
	for <qemu-devel@archiver.kernel.org>; Sat, 23 Mar 2024 13:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ro1Bl-0003eo-40; Sat, 23 Mar 2024 09:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1ro1Bj-0003eV-ML; Sat, 23 Mar 2024 09:13:31 -0400
Received: from mail-lf1-x12d.google.com ([2a00:1450:4864:20::12d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1ro1Bh-0005J2-CC; Sat, 23 Mar 2024 09:13:31 -0400
Received: by mail-lf1-x12d.google.com with SMTP id
 2adb3069b0e04-513dc9d6938so3930850e87.2; 
 Sat, 23 Mar 2024 06:13:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711199606; x=1711804406; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DbMU85BT53DMjbn5JQEFy+jPQnDXIrhZAdVJYZ20OYc=;
 b=SwBSW1QZrIn1Xgn/NTElLMEsvkexABluyek7BIgscYg3RCpTj+t01EFnGYCjihx126
 +Y2wmiB8axUeP6R+fftR8G9DQcyqaxNtEYGXGHbQapJ/mVOfR2UqLecHUGQiFOOFJS9Y
 RWWMEvYWc62G7qWf+RZ/ZfyfKuzndJHymyZR5icX62OhAri7jBvbPVEoALPrvCvLAAYG
 RXZzfDWsVQzZFQcwOdJwxr3MhilCn775w3EbBmGNC4RvR8q+qlVkTOPKPVKoprFXcyH8
 YgURYL0ldpViu+Zqx5AgFLBEn0sMmMSDSFp7OLBBl0zTAF5wYArMwpk0gmMuEnafiCm3
 9dMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711199606; x=1711804406;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DbMU85BT53DMjbn5JQEFy+jPQnDXIrhZAdVJYZ20OYc=;
 b=I0PUNuxXwJTkMG82toxPJys+xt+uULC5bZZTw2UhBvmVv4pdWnXSc1GUNeXqJ/5aM+
 MAOGfRGykcZZS68YH//wJw82TAMwQf1w1nbayck1/5kc8tCiYEF6RyQ4Lz4JYl3OOsCJ
 zPq+WSdzFfRsY5LQKlZJCQ5G0zoZhs51R30o/+yD7Ht2GxYD+X4/AHqqr33g5P5adpcn
 4nnkY6rQ6xHkZXuBJsvtGNJSOuxy8fGlNbAHazPHCZaydju5dz8RZyUkkAVF1TXdYaTc
 OfUm0lFfNfvuREqYp/ykLcaq/wPRURwttbYcWl35pNPQDFXoh4R6ylpKSuV2YgeLpE0T
 8uXQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTYzZqHWHg082XDp3uNDXIXDjndbiVhwXWVy+PCB73VxCcG4BzWGL2krKxy/KQAtmm6Tno7u98kqmRwXOfzabymNZW
X-Gm-Message-State: AOJu0YwB+qe87SYt8saZYgSffiT83vidXdXs/DA4hiEw2QDz+l4igOOG
 92Z3D4c+Xe/POyCEhfBHIcJ5mV56B8wqX0ZDE1JeixfpXAT7kIJn+s62cQ4B+adxuEsCalBcQJg
 GqWCvRzq8haRb9/F+vkn7hGcLP6Y=
X-Google-Smtp-Source: AGHT+IG6yWqQeP5jyLZfBxdNjUWxUWzCv3GJPA+LsGBJcOZ7lEsXAOVv1r0ZPW3hf31Uh5bPqvw0WQUQQGOP61HzTuQ=
X-Received: by 2002:ac2:5bd0:0:b0:513:d3a2:6350 with SMTP id
 u16-20020ac25bd0000000b00513d3a26350mr1293113lfn.66.1711199605755; Sat, 23
 Mar 2024 06:13:25 -0700 (PDT)
MIME-Version: 1.0
References: <20240321154838.95771-1-philmd@linaro.org>
 <20240321154838.95771-9-philmd@linaro.org>
In-Reply-To: <20240321154838.95771-9-philmd@linaro.org>
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Date: Sat, 23 Mar 2024 14:13:13 +0100
Message-ID: <CAJy5ezpxDNYmNOmb3Ew795gK86M0UFVFJDuPnVKhLx70ixvETQ@mail.gmail.com>
Subject: Re: [PATCH-for-9.1 08/21] target/microblaze: Prefix MMU API with 'mb_'
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, 
 Chris Wulff <crwulff@gmail.com>, Marek Vasut <marex@denx.de>,
 Max Filippov <jcmvbkbc@gmail.com>, 
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>, 
 Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: multipart/alternative; boundary="000000000000a417eb061453b470"
Received-SPF: pass client-ip=2a00:1450:4864:20::12d;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lf1-x12d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 HTML_MESSAGE=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

--000000000000a417eb061453b470
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Mar 21, 2024 at 4:49=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <philmd=
@linaro.org>
wrote:

> MicroBlaze MMU API is exposed in "mmu.h". In order to avoid
> name clashing with other targets, prefix the API with 'mb_'.
>


Reviewed-by: Edgar E. Iglesias <edgar.iglesias@amd.com>



>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
>  target/microblaze/mmu.h       | 10 +++++-----
>  target/microblaze/cpu.c       |  2 +-
>  target/microblaze/helper.c    |  4 ++--
>  target/microblaze/mmu.c       | 14 +++++++-------
>  target/microblaze/op_helper.c |  4 ++--
>  5 files changed, 17 insertions(+), 17 deletions(-)
>
> diff --git a/target/microblaze/mmu.h b/target/microblaze/mmu.h
> index 1068bd2d52..5b51e0a9c6 100644
> --- a/target/microblaze/mmu.h
> +++ b/target/microblaze/mmu.h
> @@ -85,10 +85,10 @@ typedef struct {
>      } err;
>  } MicroBlazeMMULookup;
>
> -unsigned int mmu_translate(MicroBlazeCPU *cpu, MicroBlazeMMULookup *lu,
> -                           target_ulong vaddr, MMUAccessType rw, int
> mmu_idx);
> -uint32_t mmu_read(CPUMBState *env, bool ea, uint32_t rn);
> -void mmu_write(CPUMBState *env, bool ea, uint32_t rn, uint32_t v);
> -void mmu_init(MicroBlazeMMU *mmu);
> +unsigned int mb_mmu_translate(MicroBlazeCPU *cpu, MicroBlazeMMULookup *l=
u,
> +                              target_ulong vaddr, MMUAccessType rw, int
> mmu_idx);
> +uint32_t mb_mmu_read(CPUMBState *env, bool ea, uint32_t rn);
> +void mb_mmu_write(CPUMBState *env, bool ea, uint32_t rn, uint32_t v);
> +void mb_mmu_init(MicroBlazeMMU *mmu);
>
>  #endif
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index 96c2b71f7f..59bfb5c45d 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -205,7 +205,7 @@ static void mb_cpu_reset_hold(Object *obj)
>      mb_cpu_write_msr(env, MSR_EE | MSR_IE | MSR_VM | MSR_UM);
>  #else
>      mb_cpu_write_msr(env, 0);
> -    mmu_init(&env->mmu);
> +    mb_mmu_init(&env->mmu);
>  #endif
>  }
>
> diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c
> index d25c9eb4d3..961687bae7 100644
> --- a/target/microblaze/helper.c
> +++ b/target/microblaze/helper.c
> @@ -57,7 +57,7 @@ bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int
> size,
>          return true;
>      }
>
> -    hit =3D mmu_translate(cpu, &lu, address, access_type, mmu_idx);
> +    hit =3D mb_mmu_translate(cpu, &lu, address, access_type, mmu_idx);
>      if (likely(hit)) {
>          uint32_t vaddr =3D address & TARGET_PAGE_MASK;
>          uint32_t paddr =3D lu.paddr + vaddr - lu.vaddr;
> @@ -238,7 +238,7 @@ hwaddr mb_cpu_get_phys_page_attrs_debug(CPUState *cs,
> vaddr addr,
>      attrs->secure =3D mb_cpu_access_is_secure(cpu, MMU_DATA_LOAD);
>
>      if (mmu_idx !=3D MMU_NOMMU_IDX) {
> -        hit =3D mmu_translate(cpu, &lu, addr, 0, 0);
> +        hit =3D mb_mmu_translate(cpu, &lu, addr, 0, 0);
>          if (hit) {
>              vaddr =3D addr & TARGET_PAGE_MASK;
>              paddr =3D lu.paddr + vaddr - lu.vaddr;
> diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c
> index 234006634e..5fb8ee8418 100644
> --- a/target/microblaze/mmu.c
> +++ b/target/microblaze/mmu.c
> @@ -74,8 +74,8 @@ static void mmu_change_pid(CPUMBState *env, unsigned in=
t
> newpid)
>  }
>
>  /* rw - 0 =3D read, 1 =3D write, 2 =3D fetch.  */
> -unsigned int mmu_translate(MicroBlazeCPU *cpu, MicroBlazeMMULookup *lu,
> -                           target_ulong vaddr, MMUAccessType rw, int
> mmu_idx)
> +unsigned int mb_mmu_translate(MicroBlazeCPU *cpu, MicroBlazeMMULookup *l=
u,
> +                              target_ulong vaddr, MMUAccessType rw, int
> mmu_idx)
>  {
>      MicroBlazeMMU *mmu =3D &cpu->env.mmu;
>      unsigned int i, hit =3D 0;
> @@ -175,7 +175,7 @@ done:
>  }
>
>  /* Writes/reads to the MMU's special regs end up here.  */
> -uint32_t mmu_read(CPUMBState *env, bool ext, uint32_t rn)
> +uint32_t mb_mmu_read(CPUMBState *env, bool ext, uint32_t rn)
>  {
>      MicroBlazeCPU *cpu =3D env_archcpu(env);
>      unsigned int i;
> @@ -228,7 +228,7 @@ uint32_t mmu_read(CPUMBState *env, bool ext, uint32_t
> rn)
>      return r;
>  }
>
> -void mmu_write(CPUMBState *env, bool ext, uint32_t rn, uint32_t v)
> +void mb_mmu_write(CPUMBState *env, bool ext, uint32_t rn, uint32_t v)
>  {
>      MicroBlazeCPU *cpu =3D env_archcpu(env);
>      uint64_t tmp64;
> @@ -304,8 +304,8 @@ void mmu_write(CPUMBState *env, bool ext, uint32_t rn=
,
> uint32_t v)
>                  return;
>              }
>
> -            hit =3D mmu_translate(cpu, &lu, v & TLB_EPN_MASK,
> -                                0, cpu_mmu_index(env_cpu(env), false));
> +            hit =3D mb_mmu_translate(cpu, &lu, v & TLB_EPN_MASK,
> +                                   0, cpu_mmu_index(env_cpu(env), false)=
);
>              if (hit) {
>                  env->mmu.regs[MMU_R_TLBX] =3D lu.idx;
>              } else {
> @@ -319,7 +319,7 @@ void mmu_write(CPUMBState *env, bool ext, uint32_t rn=
,
> uint32_t v)
>     }
>  }
>
> -void mmu_init(MicroBlazeMMU *mmu)
> +void mb_mmu_init(MicroBlazeMMU *mmu)
>  {
>      int i;
>      for (i =3D 0; i < ARRAY_SIZE(mmu->regs); i++) {
> diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.=
c
> index f6378030b7..58475a3af5 100644
> --- a/target/microblaze/op_helper.c
> +++ b/target/microblaze/op_helper.c
> @@ -386,12 +386,12 @@ void helper_stackprot(CPUMBState *env, target_ulong
> addr)
>  /* Writes/reads to the MMU's special regs end up here.  */
>  uint32_t helper_mmu_read(CPUMBState *env, uint32_t ext, uint32_t rn)
>  {
> -    return mmu_read(env, ext, rn);
> +    return mb_mmu_read(env, ext, rn);
>  }
>
>  void helper_mmu_write(CPUMBState *env, uint32_t ext, uint32_t rn,
> uint32_t v)
>  {
> -    mmu_write(env, ext, rn, v);
> +    mb_mmu_write(env, ext, rn, v);
>  }
>
>  void mb_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr addr=
,
> --
> 2.41.0
>
>

--000000000000a417eb061453b470
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div dir=3D"ltr"><br></div><br><div class=3D"gmail_quote">=
<div dir=3D"ltr" class=3D"gmail_attr">On Thu, Mar 21, 2024 at 4:49=E2=80=AF=
PM Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@linaro.org">phi=
lmd@linaro.org</a>&gt; wrote:<br></div><blockquote class=3D"gmail_quote" st=
yle=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204);padd=
ing-left:1ex">MicroBlaze MMU API is exposed in &quot;mmu.h&quot;. In order =
to avoid<br>
name clashing with other targets, prefix the API with &#39;mb_&#39;.<br></b=
lockquote><div><br></div><div><br></div><div>Reviewed-by: Edgar E. Iglesias=
 &lt;<a href=3D"mailto:edgar.iglesias@amd.com">edgar.iglesias@amd.com</a>&g=
t;<br></div><div><br></div><div>=C2=A0</div><blockquote class=3D"gmail_quot=
e" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,204,204)=
;padding-left:1ex">
<br>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:philmd@lin=
aro.org" target=3D"_blank">philmd@linaro.org</a>&gt;<br>
---<br>
=C2=A0target/microblaze/mmu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0| 10 +++++-----<br>
=C2=A0target/microblaze/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 2 +-<br>
=C2=A0target/microblaze/helper.c=C2=A0 =C2=A0 |=C2=A0 4 ++--<br>
=C2=A0target/microblaze/mmu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0| 14 +++++++-------=
<br>
=C2=A0target/microblaze/op_helper.c |=C2=A0 4 ++--<br>
=C2=A05 files changed, 17 insertions(+), 17 deletions(-)<br>
<br>
diff --git a/target/microblaze/mmu.h b/target/microblaze/mmu.h<br>
index 1068bd2d52..5b51e0a9c6 100644<br>
--- a/target/microblaze/mmu.h<br>
+++ b/target/microblaze/mmu.h<br>
@@ -85,10 +85,10 @@ typedef struct {<br>
=C2=A0 =C2=A0 =C2=A0} err;<br>
=C2=A0} MicroBlazeMMULookup;<br>
<br>
-unsigned int mmu_translate(MicroBlazeCPU *cpu, MicroBlazeMMULookup *lu,<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0target_ulong vaddr, MMUAccessType rw, int mmu_idx);=
<br>
-uint32_t mmu_read(CPUMBState *env, bool ea, uint32_t rn);<br>
-void mmu_write(CPUMBState *env, bool ea, uint32_t rn, uint32_t v);<br>
-void mmu_init(MicroBlazeMMU *mmu);<br>
+unsigned int mb_mmu_translate(MicroBlazeCPU *cpu, MicroBlazeMMULookup *lu,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_ulong vaddr, MMUAccessType rw, int m=
mu_idx);<br>
+uint32_t mb_mmu_read(CPUMBState *env, bool ea, uint32_t rn);<br>
+void mb_mmu_write(CPUMBState *env, bool ea, uint32_t rn, uint32_t v);<br>
+void mb_mmu_init(MicroBlazeMMU *mmu);<br>
<br>
=C2=A0#endif<br>
diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c<br>
index 96c2b71f7f..59bfb5c45d 100644<br>
--- a/target/microblaze/cpu.c<br>
+++ b/target/microblaze/cpu.c<br>
@@ -205,7 +205,7 @@ static void mb_cpu_reset_hold(Object *obj)<br>
=C2=A0 =C2=A0 =C2=A0mb_cpu_write_msr(env, MSR_EE | MSR_IE | MSR_VM | MSR_UM=
);<br>
=C2=A0#else<br>
=C2=A0 =C2=A0 =C2=A0mb_cpu_write_msr(env, 0);<br>
-=C2=A0 =C2=A0 mmu_init(&amp;env-&gt;mmu);<br>
+=C2=A0 =C2=A0 mb_mmu_init(&amp;env-&gt;mmu);<br>
=C2=A0#endif<br>
=C2=A0}<br>
<br>
diff --git a/target/microblaze/helper.c b/target/microblaze/helper.c<br>
index d25c9eb4d3..961687bae7 100644<br>
--- a/target/microblaze/helper.c<br>
+++ b/target/microblaze/helper.c<br>
@@ -57,7 +57,7 @@ bool mb_cpu_tlb_fill(CPUState *cs, vaddr address, int siz=
e,<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return true;<br>
=C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 hit =3D mmu_translate(cpu, &amp;lu, address, access_type, mm=
u_idx);<br>
+=C2=A0 =C2=A0 hit =3D mb_mmu_translate(cpu, &amp;lu, address, access_type,=
 mmu_idx);<br>
=C2=A0 =C2=A0 =C2=A0if (likely(hit)) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t vaddr =3D address &amp; TARGET_P=
AGE_MASK;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint32_t paddr =3D lu.paddr + vaddr - lu.=
vaddr;<br>
@@ -238,7 +238,7 @@ hwaddr mb_cpu_get_phys_page_attrs_debug(CPUState *cs, v=
addr addr,<br>
=C2=A0 =C2=A0 =C2=A0attrs-&gt;secure =3D mb_cpu_access_is_secure(cpu, MMU_D=
ATA_LOAD);<br>
<br>
=C2=A0 =C2=A0 =C2=A0if (mmu_idx !=3D MMU_NOMMU_IDX) {<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 hit =3D mmu_translate(cpu, &amp;lu, addr, 0, 0=
);<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 hit =3D mb_mmu_translate(cpu, &amp;lu, addr, 0=
, 0);<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (hit) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0vaddr =3D addr &amp; TARGET=
_PAGE_MASK;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0paddr =3D lu.paddr + vaddr =
- lu.vaddr;<br>
diff --git a/target/microblaze/mmu.c b/target/microblaze/mmu.c<br>
index 234006634e..5fb8ee8418 100644<br>
--- a/target/microblaze/mmu.c<br>
+++ b/target/microblaze/mmu.c<br>
@@ -74,8 +74,8 @@ static void mmu_change_pid(CPUMBState *env, unsigned int =
newpid)<br>
=C2=A0}<br>
<br>
=C2=A0/* rw - 0 =3D read, 1 =3D write, 2 =3D fetch.=C2=A0 */<br>
-unsigned int mmu_translate(MicroBlazeCPU *cpu, MicroBlazeMMULookup *lu,<br=
>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0target_ulong vaddr, MMUAccessType rw, int mmu_idx)<=
br>
+unsigned int mb_mmu_translate(MicroBlazeCPU *cpu, MicroBlazeMMULookup *lu,=
<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 target_ulong vaddr, MMUAccessType rw, int m=
mu_idx)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0MicroBlazeMMU *mmu =3D &amp;cpu-&gt;env.mmu;<br>
=C2=A0 =C2=A0 =C2=A0unsigned int i, hit =3D 0;<br>
@@ -175,7 +175,7 @@ done:<br>
=C2=A0}<br>
<br>
=C2=A0/* Writes/reads to the MMU&#39;s special regs end up here.=C2=A0 */<b=
r>
-uint32_t mmu_read(CPUMBState *env, bool ext, uint32_t rn)<br>
+uint32_t mb_mmu_read(CPUMBState *env, bool ext, uint32_t rn)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0MicroBlazeCPU *cpu =3D env_archcpu(env);<br>
=C2=A0 =C2=A0 =C2=A0unsigned int i;<br>
@@ -228,7 +228,7 @@ uint32_t mmu_read(CPUMBState *env, bool ext, uint32_t r=
n)<br>
=C2=A0 =C2=A0 =C2=A0return r;<br>
=C2=A0}<br>
<br>
-void mmu_write(CPUMBState *env, bool ext, uint32_t rn, uint32_t v)<br>
+void mb_mmu_write(CPUMBState *env, bool ext, uint32_t rn, uint32_t v)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0MicroBlazeCPU *cpu =3D env_archcpu(env);<br>
=C2=A0 =C2=A0 =C2=A0uint64_t tmp64;<br>
@@ -304,8 +304,8 @@ void mmu_write(CPUMBState *env, bool ext, uint32_t rn, =
uint32_t v)<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0}<br>
<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hit =3D mmu_translate(cpu, &amp;=
lu, v &amp; TLB_EPN_MASK,<br>
-=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 0, cpu_mmu_index(env_cpu(env), false=
));<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 hit =3D mb_mmu_translate(cpu, &a=
mp;lu, v &amp; TLB_EPN_MASK,<br>
+=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A00, cpu_mmu_index(env_cp=
u(env), false));<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (hit) {<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0env-&gt;mmu.r=
egs[MMU_R_TLBX] =3D lu.idx;<br>
=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0} else {<br>
@@ -319,7 +319,7 @@ void mmu_write(CPUMBState *env, bool ext, uint32_t rn, =
uint32_t v)<br>
=C2=A0 =C2=A0 }<br>
=C2=A0}<br>
<br>
-void mmu_init(MicroBlazeMMU *mmu)<br>
+void mb_mmu_init(MicroBlazeMMU *mmu)<br>
=C2=A0{<br>
=C2=A0 =C2=A0 =C2=A0int i;<br>
=C2=A0 =C2=A0 =C2=A0for (i =3D 0; i &lt; ARRAY_SIZE(mmu-&gt;regs); i++) {<b=
r>
diff --git a/target/microblaze/op_helper.c b/target/microblaze/op_helper.c<=
br>
index f6378030b7..58475a3af5 100644<br>
--- a/target/microblaze/op_helper.c<br>
+++ b/target/microblaze/op_helper.c<br>
@@ -386,12 +386,12 @@ void helper_stackprot(CPUMBState *env, target_ulong a=
ddr)<br>
=C2=A0/* Writes/reads to the MMU&#39;s special regs end up here.=C2=A0 */<b=
r>
=C2=A0uint32_t helper_mmu_read(CPUMBState *env, uint32_t ext, uint32_t rn)<=
br>
=C2=A0{<br>
-=C2=A0 =C2=A0 return mmu_read(env, ext, rn);<br>
+=C2=A0 =C2=A0 return mb_mmu_read(env, ext, rn);<br>
=C2=A0}<br>
<br>
=C2=A0void helper_mmu_write(CPUMBState *env, uint32_t ext, uint32_t rn, uin=
t32_t v)<br>
=C2=A0{<br>
-=C2=A0 =C2=A0 mmu_write(env, ext, rn, v);<br>
+=C2=A0 =C2=A0 mb_mmu_write(env, ext, rn, v);<br>
=C2=A0}<br>
<br>
=C2=A0void mb_cpu_transaction_failed(CPUState *cs, hwaddr physaddr, vaddr a=
ddr,<br>
-- <br>
2.41.0<br>
<br>
</blockquote></div></div>

--000000000000a417eb061453b470--

