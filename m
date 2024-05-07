Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4C2FC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 09:30:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4H9W-0005Tm-5O; Tue, 07 May 2024 05:30:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4H9R-0005KX-0q; Tue, 07 May 2024 05:30:22 -0400
Received: from mail-oa1-x2a.google.com ([2001:4860:4864:20::2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4H9O-0001Im-Gd; Tue, 07 May 2024 05:30:20 -0400
Received: by mail-oa1-x2a.google.com with SMTP id
 586e51a60fabf-23bd61fbd64so2016639fac.0; 
 Tue, 07 May 2024 02:30:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715074215; x=1715679015; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EWfeKHutv1hGflkS2VGbGxzwr5SuEdP4sDX10fX2SfM=;
 b=Hjpq8SCmXjUKydCZceZDCEw49HxnQHCgj+UVCgO/9CdMnjrJSYPPGLe4tiDyIGU6V/
 VQN8V2tmzQCSeSg5HB3qHLZK+JMWnxdmfc5jaH9XXG6XNL3Qj8JDW+k5T296r/MaoPTQ
 z7T5ovaumIU0A02jJj2e/QItxGz1AEHNcUCJ6ubcY0DF02ku/MhamyxKa7NUyHpk+cQA
 nUaaMZMpHTFBvZyYjgvGgPw6gg/syItdVLjseoBb3P9wR1CRm4DRZzpaB7gTtg7MR7cW
 WIk2/TFa12w0cYIkaB+n42VhD/PDNee7z/nPyQambulTosM5DIKxcBdNrtq32kIip6Aq
 7JZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715074215; x=1715679015;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=EWfeKHutv1hGflkS2VGbGxzwr5SuEdP4sDX10fX2SfM=;
 b=qMfRpKjpCWi7spFfghXKsNdID7IrMIZCX2UlFzggfLz+jAdM2EgZAA4SK4+4Q1N1R+
 xtRuVlGWmKF2pPqvpW0ozgKR4DtCpjE2j+SWDXFcjYeMyod7YeUg2k2NANhB+dZebX2e
 0S6ImV3fyPCN5wn6kz+Q7/1BmY1rsDxIa4H/c4lxJZ9iB6YCua2LDetlH+tbwGBDr1Yy
 2WokEdEu/y4OTcinXMtHRB7z04aY14rbCCDhf5uqh1Rkdf2n+3BJcLXEoodK4AdaIrSu
 YH0FToi7dkHYquLFH+v50LTj/DUM9eQrfNGTR6viG/85c10Kmqxw3PTevgOF1YorSsp/
 971A==
X-Forwarded-Encrypted: i=1;
 AJvYcCX5oc06y+9iQC2d3fQPIVXP2xm3JncMG1EzcHxiWwkIcYqoKbcgPiUL2W8AMUfS0MoPYaHBdu40P+kcDcrO8aBgQFA6CBwPxxHQPHutB3y8mfU+qrG+zf5kLCY=
X-Gm-Message-State: AOJu0YySQvCNNsuEeDRdTZck2lIgSrx3TSpYKHzPqZVUOP6sWXYt7A8r
 O/+E/HmSJ8cmAt5W143nlNWMJsYW/kkHlmdDPsxICKM6WhRBTJSi
X-Google-Smtp-Source: AGHT+IGszwckOo03BCbmwxcedgt6/V6VZqoxlnATo/pc1oiIS/lPKH6goA52nMlQG+5BYrntDq5Sjg==
X-Received: by 2002:a05:6871:5223:b0:23d:a4ce:b82f with SMTP id
 ht35-20020a056871522300b0023da4ceb82fmr14961793oac.5.1715074215010; 
 Tue, 07 May 2024 02:30:15 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 fx13-20020a056a00820d00b006ead1509847sm8942436pfb.216.2024.05.07.02.30.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 02:30:14 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 May 2024 19:30:09 +1000
Message-Id: <D13B2EWZN5GU.3L686RNTRX35A@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v2 07/28] target/ppc/mmu_common.c: Remove unneeded local
 variable
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1714606359.git.balaton@eik.bme.hu>
 <99eb8fb0b992a30e9588226c6c1010185cf1341b.1714606359.git.balaton@eik.bme.hu>
In-Reply-To: <99eb8fb0b992a30e9588226c6c1010185cf1341b.1714606359.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2001:4860:4864:20::2a;
 envelope-from=npiggin@gmail.com; helo=mail-oa1-x2a.google.com
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
> In mmubooke_check_tlb() and mmubooke206_check_tlb() we can assign the
> value directly the the destination, no need to have a separate local
> variable for it.
>

For a minute I thought this changed the interface to now update
ctx->prot even if the lookup failed, but it already does that in
some cases so... no issue.

If this was more widely used API we'd rather change it to never
update *prot on failure, but okay we can do this.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu_common.c | 30 +++++++++++++-----------------
>  1 file changed, 13 insertions(+), 17 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index b0aca8ec02..74c3b814c9 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -627,8 +627,6 @@ static int mmubooke_check_tlb(CPUPPCState *env, ppcem=
b_tlb_t *tlb,
>                                hwaddr *raddr, int *prot, target_ulong add=
ress,
>                                MMUAccessType access_type, int i)
>  {
> -    int prot2;
> -
>      if (!mmubooke_check_pid(env, tlb, raddr, address, i)) {
>          qemu_log_mask(CPU_LOG_MMU, "%s: TLB entry not found\n", __func__=
);
>          return -1;
> @@ -643,17 +641,16 @@ static int mmubooke_check_tlb(CPUPPCState *env, ppc=
emb_tlb_t *tlb,
>      }
> =20
>      if (FIELD_EX64(env->msr, MSR, PR)) {
> -        prot2 =3D tlb->prot & 0xF;
> +        *prot =3D tlb->prot & 0xF;
>      } else {
> -        prot2 =3D (tlb->prot >> 4) & 0xF;
> +        *prot =3D (tlb->prot >> 4) & 0xF;
>      }
> -    *prot =3D prot2;
> -    if (prot2 & prot_for_access_type(access_type)) {
> +    if (*prot & prot_for_access_type(access_type)) {
>          qemu_log_mask(CPU_LOG_MMU, "%s: good TLB!\n", __func__);
>          return 0;
>      }
> =20
> -    qemu_log_mask(CPU_LOG_MMU, "%s: no prot match: %x\n", __func__, prot=
2);
> +    qemu_log_mask(CPU_LOG_MMU, "%s: no prot match: %x\n", __func__, *pro=
t);
>      return access_type =3D=3D MMU_INST_FETCH ? -3 : -2;
>  }
> =20
> @@ -794,7 +791,6 @@ static int mmubooke206_check_tlb(CPUPPCState *env, pp=
cmas_tlb_t *tlb,
>                                   target_ulong address,
>                                   MMUAccessType access_type, int mmu_idx)
>  {
> -    int prot2 =3D 0;
>      uint32_t epid;
>      bool as, pr;
>      bool use_epid =3D mmubooke206_get_as(env, mmu_idx, &epid, &as, &pr);
> @@ -840,34 +836,34 @@ found_tlb:
>          return -1;
>      }
> =20
> +    *prot =3D 0;
>      if (pr) {
>          if (tlb->mas7_3 & MAS3_UR) {
> -            prot2 |=3D PAGE_READ;
> +            *prot |=3D PAGE_READ;
>          }
>          if (tlb->mas7_3 & MAS3_UW) {
> -            prot2 |=3D PAGE_WRITE;
> +            *prot |=3D PAGE_WRITE;
>          }
>          if (tlb->mas7_3 & MAS3_UX) {
> -            prot2 |=3D PAGE_EXEC;
> +            *prot |=3D PAGE_EXEC;
>          }
>      } else {
>          if (tlb->mas7_3 & MAS3_SR) {
> -            prot2 |=3D PAGE_READ;
> +            *prot |=3D PAGE_READ;
>          }
>          if (tlb->mas7_3 & MAS3_SW) {
> -            prot2 |=3D PAGE_WRITE;
> +            *prot |=3D PAGE_WRITE;
>          }
>          if (tlb->mas7_3 & MAS3_SX) {
> -            prot2 |=3D PAGE_EXEC;
> +            *prot |=3D PAGE_EXEC;
>          }
>      }
> -    *prot =3D prot2;
> -    if (prot2 & prot_for_access_type(access_type)) {
> +    if (*prot & prot_for_access_type(access_type)) {
>          qemu_log_mask(CPU_LOG_MMU, "%s: good TLB!\n", __func__);
>          return 0;
>      }
> =20
> -    qemu_log_mask(CPU_LOG_MMU, "%s: no prot match: %x\n", __func__, prot=
2);
> +    qemu_log_mask(CPU_LOG_MMU, "%s: no prot match: %x\n", __func__, *pro=
t);
>      return access_type =3D=3D MMU_INST_FETCH ? -3 : -2;
>  }
> =20


