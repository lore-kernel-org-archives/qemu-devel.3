Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 828B3CED272
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Oct 2024 06:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sy42g-0007cn-JN; Tue, 08 Oct 2024 02:49:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sy42e-0007cP-KY; Tue, 08 Oct 2024 02:49:56 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sy42c-0006Ai-UB; Tue, 08 Oct 2024 02:49:56 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-20b7eb9e81eso62772745ad.2; 
 Mon, 07 Oct 2024 23:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1728370193; x=1728974993; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Znq1mo330lvqj+KEQJUcBJP6xk4f1nfBaPHjdsQ6NIA=;
 b=ANFMx/0QWJjdF9XcHIXbjLKKoRM9/7P7dZxY3+y7AqppAgCvtl4H1Si5kIWXgkH5sP
 bfkIYhrpkEHi9VwHY9Oei0DLXwzNCSu24gyNy7JHqtgC+iXfItr78TMCIfUTT53cBDgc
 K9S3NfHjPATxKaPX/5dGcYYrY3DpWj6lKBCHY4e2vZV1osYvcIM0JeD3PL+I0wUm1Z4L
 iBsaslFDBise5V0ZCv7ZQFa7QTvRNoNAJijxch/KHV3NmRqBULgbZ7D8mtfaqbXT5afX
 mPe37xVoj1cd9UDFDeETOfFat/WOcrZW7SGHLzydUUZSbDwSeBLTDon+5HesM+sGpvGt
 EtNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728370193; x=1728974993;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Znq1mo330lvqj+KEQJUcBJP6xk4f1nfBaPHjdsQ6NIA=;
 b=Sh/Fe/HA3udI1ZF9kT/lWSMN9tLpKXaJg/EpSs/7vh4eq3N9QuBJdvTxGh2FDSDdQi
 bQmlW6djqgQ0JxZ9y0WlyHeTwZC8hx0rgq4193zgzmX6YvKgHhwfsLlDpIA8Hkpr2qUp
 G1mtXeVsbLdqXMTyG6bsQ/qxyfQ0YuJvBh6W6dCvCQjNtfolN7VnDSkDJ4zdtm/L0zwP
 +G+F7aX7ZaS8CRDe/9kpWOaY6aTKVrQKRoFkue13OLqLUfe8ivb2/mvP49YhjoaGmGmG
 +1ZR5Y8OJa7NJeW+6tI/7ZBX4e1OIetqdRp3sNfFnYhSEMnb+xQ8lG3zPFlLlgaKF6FX
 vTpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUnOU/x2XCqJpnIYghIyocibkrJ+CvJzbUsweQdHVaqfvB7nOyXxBSrh8f5xFWSywhevGOHRWEwRPU=@nongnu.org,
 AJvYcCVtgM1TEwo55+wLuMMfxeaAPoXs14HM7EJZr9REf+LiungjbCQ2opITUuKaLbwmNDlpHTVwA32QMMxs@nongnu.org
X-Gm-Message-State: AOJu0YxKr3Ipz+ifFmSs99SPY5RIKgy4Ph9J0IiPOKtRjc2OuHHMtBBT
 n+m1uHSUUbfNijes5MU26YJe/VSTaMP/zfgUlmyzX/cFwhtR/XG2s4obIg==
X-Google-Smtp-Source: AGHT+IHmF30SknaWSj1fn9bU+Kb191QfROo+a00M6jKkckJpKOwG00zquhU0PMwxbh4CtteJrlLwNQ==
X-Received: by 2002:a17:902:f608:b0:20b:ce30:878d with SMTP id
 d9443c01a7336-20bfdfdd2f3mr215923905ad.23.1728370193127; 
 Mon, 07 Oct 2024 23:49:53 -0700 (PDT)
Received: from localhost ([118.210.103.101]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20c139a32e1sm49468405ad.296.2024.10.07.23.49.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 07 Oct 2024 23:49:52 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 08 Oct 2024 16:49:48 +1000
Message-Id: <D4Q83JB58Q2M.3UHBQE0UIYM1L@gmail.com>
Cc: <balaton@eik.bme.hu>, <danielhb413@gmail.com>
Subject: Re: [PATCH v3 06/10] target/ppc: reduce duplicate code between
 init_proc_POWER{9, 10}
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>,
 <qemu-devel@nongnu.org>
X-Mailer: aerc 0.18.2
References: <20240913041337.912876-1-harshpb@linux.ibm.com>
 <20240913041337.912876-7-harshpb@linux.ibm.com>
In-Reply-To: <20240913041337.912876-7-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62e.google.com
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

On Fri Sep 13, 2024 at 2:13 PM AEST, Harsh Prateek Bora wrote:
> Historically, the registration of sprs have been inherited alongwith
> every new Power arch support being added leading to a lot of code
> duplication. It's time to do necessary cleanups now to avoid further
> duplication with newer arch support being added.

Looks okay.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

Nit, could you move this out to the end of the series, since it is in
the middle of several other patches that deal with interrupt delivery.

Thanks,
Nick

>
> Signed-off-by: Harsh Prateek Bora <harshb@linux.ibm.com>
> ---
>  target/ppc/cpu_init.c | 58 +++++++++----------------------------------
>  1 file changed, 12 insertions(+), 46 deletions(-)
>
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 9cb5dd4596..de1dd63bf7 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -6410,7 +6410,7 @@ static struct ppc_radix_page_info POWER9_radix_page=
_info =3D {
>  #endif /* CONFIG_USER_ONLY */
> =20
>  #define POWER9_BHRB_ENTRIES_LOG2 5
> -static void init_proc_POWER9(CPUPPCState *env)
> +static void register_power9_common_sprs(CPUPPCState *env)
>  {
>      /* Common Registers */
>      init_proc_book3s_common(env);
> @@ -6429,7 +6429,6 @@ static void init_proc_POWER9(CPUPPCState *env)
>      register_power5p_ear_sprs(env);
>      register_power5p_tb_sprs(env);
>      register_power6_common_sprs(env);
> -    register_HEIR32_spr(env);
>      register_power6_dbg_sprs(env);
>      register_power7_common_sprs(env);
>      register_power8_tce_address_control_sprs(env);
> @@ -6447,16 +6446,21 @@ static void init_proc_POWER9(CPUPPCState *env)
>      register_power8_rpr_sprs(env);
>      register_power9_mmu_sprs(env);
> =20
> -    /* POWER9 Specific registers */
> -    spr_register_kvm(env, SPR_TIDR, "TIDR", NULL, NULL,
> -                     spr_read_generic, spr_write_generic,
> -                     KVM_REG_PPC_TIDR, 0);
> -
>      /* FIXME: Filter fields properly based on privilege level */
>      spr_register_kvm_hv(env, SPR_PSSCR, "PSSCR", NULL, NULL, NULL, NULL,
>                          spr_read_generic, spr_write_generic,
>                          KVM_REG_PPC_PSSCR, 0);
> =20
> +}
> +
> +static void init_proc_POWER9(CPUPPCState *env)
> +{
> +    register_power9_common_sprs(env);
> +    register_HEIR32_spr(env);
> +    /* POWER9 Specific registers */
> +    spr_register_kvm(env, SPR_TIDR, "TIDR", NULL, NULL,
> +                     spr_read_generic, spr_write_generic,
> +                     KVM_REG_PPC_TIDR, 0);
>      /* env variables */
>      env->dcache_line_size =3D 128;
>      env->icache_line_size =3D 128;
> @@ -6562,50 +6566,12 @@ static struct ppc_radix_page_info POWER10_radix_p=
age_info =3D {
>  #define POWER10_BHRB_ENTRIES_LOG2 5
>  static void init_proc_POWER10(CPUPPCState *env)
>  {
> -    /* Common Registers */
> -    init_proc_book3s_common(env);
> -    register_book3s_207_dbg_sprs(env);
> -
> -    /* Common TCG PMU */
> -    init_tcg_pmu_power8(env);
> -
> -    /* POWER8 Specific Registers */
> -    register_book3s_ids_sprs(env);
> -    register_amr_sprs(env);
> -    register_iamr_sprs(env);
> -    register_book3s_purr_sprs(env);
> -    register_power5p_common_sprs(env);
> -    register_power5p_lpar_sprs(env);
> -    register_power5p_ear_sprs(env);
> -    register_power5p_tb_sprs(env);
> -    register_power6_common_sprs(env);
> +    register_power9_common_sprs(env);
>      register_HEIR64_spr(env);
> -    register_power6_dbg_sprs(env);
> -    register_power7_common_sprs(env);
> -    register_power8_tce_address_control_sprs(env);
> -    register_power8_ids_sprs(env);
> -    register_power8_ebb_sprs(env);
> -    register_power8_fscr_sprs(env);
> -    register_power8_pmu_sup_sprs(env);
> -    register_power8_pmu_user_sprs(env);
> -    register_power8_tm_sprs(env);
> -    register_power8_pspb_sprs(env);
> -    register_power8_dpdes_sprs(env);
> -    register_vtb_sprs(env);
> -    register_power8_ic_sprs(env);
> -    register_power9_book4_sprs(env);
> -    register_power8_rpr_sprs(env);
> -    register_power9_mmu_sprs(env);
>      register_power10_hash_sprs(env);
>      register_power10_dexcr_sprs(env);
>      register_power10_pmu_sup_sprs(env);
>      register_power10_pmu_user_sprs(env);
> -
> -    /* FIXME: Filter fields properly based on privilege level */
> -    spr_register_kvm_hv(env, SPR_PSSCR, "PSSCR", NULL, NULL, NULL, NULL,
> -                        spr_read_generic, spr_write_generic,
> -                        KVM_REG_PPC_PSSCR, 0);
> -
>      /* env variables */
>      env->dcache_line_size =3D 128;
>      env->icache_line_size =3D 128;


