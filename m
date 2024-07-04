Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA994C41513
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 07:11:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPGcF-00054T-KN; Thu, 04 Jul 2024 03:10:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPGcD-00053B-24; Thu, 04 Jul 2024 03:10:49 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPGc7-0007As-RH; Thu, 04 Jul 2024 03:10:48 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1fa9f540f45so1542615ad.1; 
 Thu, 04 Jul 2024 00:10:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720077040; x=1720681840; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2xpgrOCIHwKnooftRJcTKALjAOttjgEG43HsINvBCnQ=;
 b=I/5ouLYPykXhtBJK6Jk32t/kWLmqaKNe4GX9do919k/D6m4l1mw2Qr5jLgI8n2eyJs
 my6FvHP7BxmsPTI1FhlVlrn9qrUNVC3VAMi5vBwkXYvp/zOIUHDRhSn7z66zqk2ZEEg6
 RyjGqi0LRFYgYKM4qlryb8M5njymi1NtatjQhuF8ONt4Td3ETqQsQIVrWdBRVqIRf5Lk
 JIo1IPkLzTh9+SXiEdNOSPI6vvCPdeDlw1yuo3sML7hg17jG14pBKP23xzNwUUfv8kiT
 DADYtMJHMUrkZgRxUizH0km6PZrHKL1B+krpM38FYndewWSkibRvLW1jutNPbBn4ySfu
 +Z0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720077040; x=1720681840;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2xpgrOCIHwKnooftRJcTKALjAOttjgEG43HsINvBCnQ=;
 b=vdhO4BkA7CPRa3p+VrMQMYx/whBwPQukQ3U4Wb8/C9d3DIZBdkxkzzVe3CniOq1rM2
 nO6CENfs+rpP3iAlSsRNIUHOPWB2wEyeSesRdNwojdG3YHlfiyw8Xv0HDf7qCIL3NlTL
 iopvjgIWWf7XIMLLpnZop4ARmr19lK1rFXquh4MrjGbGOGP4k6g11q6+735EtY6igLxX
 sp7dfdeiUVwPxKDNTF4mP6GOS85ooUWYzWYeV/SW5/JJQkhehSY6mOfa9Vf4reIrtYO8
 XZ95KJn1I3q3s/9knxK//+gQbvsAi80QKqsUOJRIisf4jpq07oTSHdJnNS9Fc73ZTf6+
 WGJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3bn+9BW71l62B0itJEk8u8IBxcGNtZ12Ti5Cy016N7WZyTBtBxGDhsimZd7JOgae2OQMT2mQ0VJYc+nPdlqJC8246rysY2kAE/sClFjWWGChl3PDdeT1SwbE=
X-Gm-Message-State: AOJu0YxO2ua/eazzhwOS4Pr/CR8WWlFhF0H2ZRvabIEx7ZvN4ge4oVd0
 aUd0H1/hNAfaGfXjh8T/QxfumEQgGIUstseGtVO7UARgo+82TNhszFzJ0Q==
X-Google-Smtp-Source: AGHT+IEj2l3hUJb/kJmoJX95X+4OxAPGB4GCvGi5M/nufg9GgyiVBNt8vXUa3yKEeFxsMdvjcP/tBA==
X-Received: by 2002:a17:902:ea0c:b0:1f9:f217:85c with SMTP id
 d9443c01a7336-1fb33ef60c3mr6472275ad.52.1720077040212; 
 Thu, 04 Jul 2024 00:10:40 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac15694a4sm115064535ad.194.2024.07.04.00.10.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 00:10:39 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 17:10:34 +1000
Message-Id: <D2GKF53KZJ0C.XEF9MWU91A01@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 27/43] target/ppc/mmu_common.c: Remove mmu_ctx_t
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <de272971970fc6772ac84b691d01e4b03b2e47cf.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <de272971970fc6772ac84b691d01e4b03b2e47cf.1716763435.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x635.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon May 27, 2024 at 9:13 AM AEST, BALATON Zoltan wrote:
> Completely get rid of mmu_ctx_t after converting the remaining
> functions to pass raddr and prot without the context struct.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 25 +++++++------------------
>  1 file changed, 7 insertions(+), 18 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 4770b43630..60f8736210 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -37,12 +37,6 @@
> =20
>  /* #define DUMP_PAGE_TABLES */
> =20
> -/* Context used internally during MMU translations */
> -typedef struct {
> -    hwaddr raddr;      /* Real address             */
> -    int prot;          /* Protection bits          */
> -} mmu_ctx_t;
> -
>  void ppc_store_sdr1(CPUPPCState *env, target_ulong value)
>  {
>      PowerPCCPU *cpu =3D env_archcpu(env);
> @@ -264,8 +258,8 @@ static int get_bat_6xx_tlb(CPUPPCState *env, hwaddr *=
raddr, int *prot,
>      return ret;
>  }
> =20
> -static int mmu6xx_get_physical_address(CPUPPCState *env, mmu_ctx_t *ctx,
> -                                       target_ulong eaddr,
> +static int mmu6xx_get_physical_address(CPUPPCState *env, hwaddr *raddr,
> +                                       int *prot, target_ulong eaddr,
>                                         hwaddr *hashp, bool *keyp,
>                                         MMUAccessType access_type, int ty=
pe)
>  {
> @@ -277,8 +271,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *e=
nv, mmu_ctx_t *ctx,
> =20
>      /* First try to find a BAT entry if there are any */
>      if (env->nb_BATs &&
> -        get_bat_6xx_tlb(env, &ctx->raddr, &ctx->prot, eaddr,
> -                        access_type, pr) =3D=3D 0) {
> +        get_bat_6xx_tlb(env, raddr, prot, eaddr, access_type, pr) =3D=3D=
 0) {
>          return 0;
>      }
> =20
> @@ -316,7 +309,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *e=
nv, mmu_ctx_t *ctx,
>          *hashp =3D hash;
> =20
>          /* Software TLB search */
> -        return ppc6xx_tlb_check(env, &ctx->raddr, &ctx->prot, eaddr,
> +        return ppc6xx_tlb_check(env, raddr, prot, eaddr,
>                                  access_type, ptem, key, nx);
>      }
> =20
> @@ -333,7 +326,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *e=
nv, mmu_ctx_t *ctx,
>           * Should make the instruction do no-op.  As it already do
>           * no-op, it's quite easy :-)
>           */
> -        ctx->raddr =3D eaddr;
> +        *raddr =3D eaddr;
>          return 0;
>      case ACCESS_CODE: /* No code fetch is allowed in direct-store areas =
*/
>      case ACCESS_FLOAT: /* Floating point load/store */
> @@ -343,7 +336,7 @@ static int mmu6xx_get_physical_address(CPUPPCState *e=
nv, mmu_ctx_t *ctx,
>      }
>      if ((access_type =3D=3D MMU_DATA_STORE || !key) &&
>          (access_type =3D=3D MMU_DATA_LOAD || key)) {
> -        ctx->raddr =3D eaddr;
> +        *raddr =3D eaddr;
>          return 2;
>      }
>      return -2;
> @@ -681,7 +674,6 @@ static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr eadd=
r,
>  {
>      CPUState *cs =3D CPU(cpu);
>      CPUPPCState *env =3D &cpu->env;
> -    mmu_ctx_t ctx;
>      hwaddr hash =3D 0; /* init to 0 to avoid used uninit warning */
>      bool key;
>      int type, ret;
> @@ -700,12 +692,9 @@ static bool ppc_6xx_xlate(PowerPCCPU *cpu, vaddr ead=
dr,
>          type =3D ACCESS_INT;
>      }
> =20
> -    ctx.prot =3D 0;
> -    ret =3D mmu6xx_get_physical_address(env, &ctx, eaddr, &hash, &key,
> +    ret =3D mmu6xx_get_physical_address(env, raddrp, protp, eaddr, &hash=
, &key,
>                                        access_type, type);
>      if (ret =3D=3D 0) {
> -        *raddrp =3D ctx.raddr;
> -        *protp =3D ctx.prot;
>          *psizep =3D TARGET_PAGE_BITS;
>          return true;
>      } else if (!guest_visible) {


