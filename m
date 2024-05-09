Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B20C10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 06:17:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4x5l-0000R1-JW; Thu, 09 May 2024 02:17:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4x5h-0000MY-8U; Thu, 09 May 2024 02:17:17 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4x5c-0000mX-CY; Thu, 09 May 2024 02:17:15 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-5ce2aada130so412120a12.1; 
 Wed, 08 May 2024 23:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715235429; x=1715840229; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=CRXfcinz93g/7TJ8CJis/JgeP6WheRpv4+F+roTEeYM=;
 b=M+bigrpNwepDyTlmekB7Qv1DWFX2O8uVwgtzOaLD5K6zawIHkbD/tZ7XytX7hpamrI
 hSLFI0jNxNE4MXzMLyi6/OksFoFFKM2eqOM2gFaGTKML4tV2nchBH669KVR2KoYDVBHU
 R05HcYsTjnQMalC77m/LV9n1Ci9eJb91guXYfSa/hv59wcTHaGh6hy1NfAmi39+Mb/Z9
 rIPG3265ngy61p1zxit/kPX4tftyCoONhnk6I6dyh9+PMhtYPDz+hbAzgz3PIt37Crap
 LVNOAI9sh4OmeizlgPV1UpXu5yfcpQh+7nk2L6OpkCxCg+DNdew97OA7KK8oPQQYUVUX
 RjEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715235429; x=1715840229;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=CRXfcinz93g/7TJ8CJis/JgeP6WheRpv4+F+roTEeYM=;
 b=CzMxLrHBrs15t3S0YBpfIpYN8g1GVtRXn5gXmsfgZo82DN4enYVJqSdTy/5La5A4jt
 rs3HoqKAMHFJHMuyxfBvzSARIf4Ky4OxQJge5tle7B7G4oh8mkFEJPLGkwn6LAx2X7RO
 cwwOXtEcsCcgu2DpzlqiAHnggN3ztbnKkM8Lr8IP3KE3Ig3YD4nzCK5K99S97TFYX5Yd
 qz1bbgmVrEFgRkamZIZ7Ugre1eGU0A4yErb9IP4dj2CUvLH2PZgQ+QSG3Mnr+yq8AXJj
 ga/Y7JdiXuiVGFwBgbUIrUzlBE9gJvsmCJBAWlp07BEA+qqv1zchebxIzV3xBLLIRK3+
 qPXA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtH4b5i1Y84Tmi1yYbrkyT0tTjTWzg449rBqoJ9CsBUok1dkBcUabIDgfD3ikfXGUym42vyK77coXnFcRkxA7d9aHz3ulzFxaQ7lJWQtOzZpi0aH4zew2IbGo=
X-Gm-Message-State: AOJu0YzEj9NT5LzwsrGvw3Mt4JbWHpjk1xFZPc6CzuUURrOaNVFwCvQm
 Nq0QgAgOmV71JvR+oMpSxT+Oe3omCFKbWemXRxdRBHW3U564UQjW
X-Google-Smtp-Source: AGHT+IEOiFzVV6H9EyDHE0MtULwxXK1Jfh36594imi0WA5tFNr7zc7Qdop0fsOFPkMbGIW0J93LUTQ==
X-Received: by 2002:a17:90a:fe05:b0:2b4:32ae:7216 with SMTP id
 98e67ed59e1d1-2b6169deedamr4606775a91.35.1715235429330; 
 Wed, 08 May 2024 23:17:09 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b67158c325sm617302a91.40.2024.05.08.23.17.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 23:17:09 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 May 2024 16:17:04 +1000
Message-Id: <D14W7O3WA7FB.1OSJA0R512Y2U@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v4 22/33] target/ppc/mmu_common.c: Make
 get_physical_address_wtlb() static
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1715209155.git.balaton@eik.bme.hu>
 <398c274f9759cf2587088b6e2b0f45e560e2e3c9.1715209155.git.balaton@eik.bme.hu>
In-Reply-To: <398c274f9759cf2587088b6e2b0f45e560e2e3c9.1715209155.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52a.google.com
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

On Thu May 9, 2024 at 9:36 AM AEST, BALATON Zoltan wrote:
> This function is not used from any other files so make it static and
> fix the maybe used uninitialised warnings this has uncovered. Also
> remove mmu_ctx_t definition from internal.h as this type is only used
> within this file.

get_physical_address_wtlb and mmu_ctx_t is becoming basically 6xx
specific after this. Nice.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/internal.h   | 17 +----------------
>  target/ppc/mmu_common.c | 17 ++++++++++++++---
>  2 files changed, 15 insertions(+), 19 deletions(-)
>
> diff --git a/target/ppc/internal.h b/target/ppc/internal.h
> index 98b41a970c..4a90dd2584 100644
> --- a/target/ppc/internal.h
> +++ b/target/ppc/internal.h
> @@ -257,28 +257,13 @@ static inline int prot_for_access_type(MMUAccessTyp=
e access_type)
> =20
>  /* PowerPC MMU emulation */
> =20
> -typedef struct mmu_ctx_t mmu_ctx_t;
> -
>  bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAccessType access_type,
>                        hwaddr *raddrp, int *psizep, int *protp,
>                        int mmu_idx, bool guest_visible);
> -int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
> -                                     target_ulong eaddr,
> -                                     MMUAccessType access_type, int type=
,
> -                                     int mmu_idx);
> +
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
> index bffa06455d..2a7b4a275c 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -36,6 +36,17 @@
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
> @@ -653,7 +664,7 @@ static int mmubooke_get_physical_address(CPUPPCState =
*env, hwaddr *raddr,
>      qemu_log_mask(CPU_LOG_MMU,
>                    "%s: access %s " TARGET_FMT_lx " =3D> " HWADDR_FMT_plx
>                    " %d %d\n", __func__, ret < 0 ? "refused" : "granted",
> -                  address, ret < 0 ? -1 : *raddr, *prot, ret);
> +                  address, ret < 0 ? -1 : *raddr, ret =3D=3D -1 ? 0 : *p=
rot, ret);
>      return ret;
>  }
> =20
> @@ -865,7 +876,7 @@ found_tlb:
>      qemu_log_mask(CPU_LOG_MMU, "%s: access %s " TARGET_FMT_lx " =3D> "
>                    HWADDR_FMT_plx " %d %d\n", __func__,
>                    ret < 0 ? "refused" : "granted", address,
> -                  ret < 0 ? -1 : *raddr, *prot, ret);
> +                  ret < 0 ? -1 : *raddr, ret =3D=3D -1 ? 0 : *prot, ret)=
;
>      return ret;
>  }
> =20
> @@ -1113,7 +1124,7 @@ void dump_mmu(CPUPPCState *env)
>      }
>  }
> =20
> -int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
> +static int get_physical_address_wtlb(CPUPPCState *env, mmu_ctx_t *ctx,
>                                       target_ulong eaddr,
>                                       MMUAccessType access_type, int type=
,
>                                       int mmu_idx)


