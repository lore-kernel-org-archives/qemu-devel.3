Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B7CEC25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 10:50:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4IO5-0008Je-Nh; Tue, 07 May 2024 06:49:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4INu-0008D8-NH; Tue, 07 May 2024 06:49:23 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4INs-0007Vk-VD; Tue, 07 May 2024 06:49:22 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1eab16c8d83so21941055ad.3; 
 Tue, 07 May 2024 03:49:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715078959; x=1715683759; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=REnlp3h0pLf5O6waaBHoThFYvF9f/f0guPiaD6nis6U=;
 b=ZL+s+pdMl18kP270x7JQfzaidfxGswl+MALEShi7mFLNULZDJQQAeBiHM+cT/Tbzy/
 ZO/QiiABXXUgC1Od8biWIrl/fAuiF7AQJUivvDc+230Fbxles05xCeQrUV94ucGz/+NH
 VqSntWJX3wDM/CTKNRSdn90kgjmWDOpxZQuEN5wpsNjqC9+lin1SA8eCpl13HvnEDBGK
 pIT/rSF1/CfmeW28PWfDfF7LIvur6UmvM1PrMbNcocedgp7xVkSikJ0K4nkf4OAKnhEq
 pcia3vdU44T7pqeX+8hJ+oVqreFzDOTjAup/VHvev3NBNLKfL/XcGyqUM/U7zQeM8lhF
 uXRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715078959; x=1715683759;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=REnlp3h0pLf5O6waaBHoThFYvF9f/f0guPiaD6nis6U=;
 b=a1itRUq9aQg8/OXzhybdrWiqmdKwE9xPfYJZunmG4PwLpuzg1TmOsOD63F4mlU/rC/
 UPieZcSGfkKv06gQOqCmWaUhENwwMCykLOqnfGy2psVt135llivCWm7nrDcSiSB3Cd2V
 s2IuIqVQlEzVuBPErYWc7h/XnBMyw8mylfBGaL7EqTH8J62QmiktNg+obO3S2rt4N4Dv
 W5DfwPTwGZcHGzrRoRfqi6HZxvK316gQFexyu323MQgaOd9XRTjQmJ4Uvltw05WERD09
 bQOJNL6doongbGOgbAH6ZNcfL76JM7LL+9c7EsCRJWUmEldvEcm6SS4fdbLfiDHAITCs
 mIIQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCULv5TmY5c8s+pW1HGB3MEkRxP5bZuX9FqS9SOcTDtG0CNZOxVhstjPF/Hig2XOhls53A+73M4EA0rpMWwK90GaJeubZqaba/YoOChN4YEa09jRQQL3c0b8Kho=
X-Gm-Message-State: AOJu0Yxmy1A7nrR5qcvTHG2g0O2LhoaKfUQJ7PStkuLMtFh5uw6LE4T8
 2fmyicba8Znzgjg1pGaLJt5xJ19vcD51bVJBDuVZaamW6piEcYgR
X-Google-Smtp-Source: AGHT+IEGMxwvcTG8PmLxBRBF3lrBxVgnKVvFWIaALXqapL/aXsvROhgznXrY4WUIPpjpvzimlnxcSg==
X-Received: by 2002:a17:902:d344:b0:1ea:f921:61db with SMTP id
 l4-20020a170902d34400b001eaf92161dbmr10504151plk.58.1715078958936; 
 Tue, 07 May 2024 03:49:18 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 q9-20020a17090311c900b001e944fc9248sm9716321plh.194.2024.05.07.03.49.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 03:49:18 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 May 2024 20:49:14 +1000
Message-Id: <D13CQYJAUWTM.1A6N55S7X77O7@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v2 21/28] target/ppc: Move mmu_ctx_t definition to
 mmu_common.c
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1714606359.git.balaton@eik.bme.hu>
 <441004d25ece7b536825906e0325235bc2614b5d.1714606359.git.balaton@eik.bme.hu>
In-Reply-To: <441004d25ece7b536825906e0325235bc2614b5d.1714606359.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62b.google.com
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

On Thu May 2, 2024 at 9:43 AM AEST, BALATON Zoltan wrote:
> This type is only used within mmu_common.c. Move its definition from
> internal.h to there.

This can be squashed with the previous patch unexport the
remaining user.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/internal.h   | 12 ------------
>  target/ppc/mmu_common.c | 11 +++++++++++
>  2 files changed, 11 insertions(+), 12 deletions(-)
>
> diff --git a/target/ppc/internal.h b/target/ppc/internal.h
> index 7a99f08dc8..61c2aadd0d 100644
> --- a/target/ppc/internal.h
> +++ b/target/ppc/internal.h
> @@ -256,8 +256,6 @@ static inline int prot_for_access_type(MMUAccessType =
access_type)
> =20
>  /* PowerPC MMU emulation */
> =20
> -typedef struct mmu_ctx_t mmu_ctx_t;
> -
>  bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
>                        hwaddr *raddrp, int *psizep, int *protp,
>                        int mmu_idx, bool guest_visible);
> @@ -265,16 +263,6 @@ bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAcce=
ssType access_type,
>  /* Software driven TLB helpers */
>  int ppc6xx_tlb_getnum(CPUPPCState *env, target_ulong eaddr,
>                                      int way, int is_code);
> -/* Context used internally during MMU translations */
> -struct mmu_ctx_t {
> -    hwaddr raddr;      /* Real address              */
> -    hwaddr eaddr;      /* Effective address         */
> -    int prot;                      /* Protection bits           */
> -    hwaddr hash[2];    /* Pagetable hash values     */
> -    target_ulong ptem;             /* Virtual segment ID | API  */
> -    int key;                       /* Access key                */
> -    int nx;                        /* Non-execute area          */
> -};
> =20
>  #endif /* !CONFIG_USER_ONLY */
> =20
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 4852cb5571..41ef174ab4 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -35,6 +35,17 @@
> =20
>  /* #define DUMP_PAGE_TABLES */
> =20
> +/* Context used internally during MMU translations */
> +typedef struct {
> +    hwaddr raddr;      /* Real address             */
> +    hwaddr eaddr;      /* Effective address        */
> +    int prot;          /* Protection bits          */
> +    hwaddr hash[2];    /* Pagetable hash values    */
> +    target_ulong ptem; /* Virtual segment ID | API */
> +    int key;           /* Access key               */
> +    int nx;            /* Non-execute area         */
> +} mmu_ctx_t;
> +
>  void ppc_store_sdr1(CPUPPCState *env, target_ulong value)
>  {
>      PowerPCCPU *cpu =3D env_archcpu(env);


