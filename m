Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A6CC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 09:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4H0r-0006VU-Rz; Tue, 07 May 2024 05:21:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4H0S-0006QF-AK; Tue, 07 May 2024 05:21:09 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4H0P-0007tC-9Q; Tue, 07 May 2024 05:21:03 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6f4496af4cdso2383195b3a.0; 
 Tue, 07 May 2024 02:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715073659; x=1715678459; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2R/JeQa5neRnIvZTQgz67iETPUyeo07GbRbtW1CRjhE=;
 b=fqpY72uo/I4oCrgwg8JARs1wTBRlRrSR4m90jPEH30RX2N7PvbrxIoq90M0VgJbmAv
 fP+5tqJti9OE01iMv7YnDiTnci0BsMJUh7+vSp6mtYTIO6vW1EmRuE2x3kFfqyYRT35o
 TolX+rdcSL5YAp1H6QawVC3S6HSfiHYXg0qpYk6fOcMLoub62WxcM2uFKW40tI+XHakB
 i46ljIHHmOnJpuu/0zjgjuTqsH9KoUifCzYtFxM/4EnGz5MAHBs6iC6Jbn0xelhw12vX
 f2DRfiEGWaCzPSrJxPWCYAjuNQsQ1ktqC9q+ynbTokbR6lhARzi+YCRKSLA7bAm+mai9
 BJmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715073659; x=1715678459;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2R/JeQa5neRnIvZTQgz67iETPUyeo07GbRbtW1CRjhE=;
 b=leKCk7QBeQZlGkYLXKVby4OARM//YxLaNCDnH2AJYPPWgXX/vYTfuAJrtM5Du1x7WG
 Ez3jktCnTBB4Hy7cz2Xw2rlAV/DfX/3ifxjjs1YcKuhYOCAKkb4VKg4JP4VJWZWwaaSg
 GpA8TvGIBSdUMagZAZIX0e9LDkTHtuEQsQj87NlzHrHabAgtJ3fJS2QrzJEY3RGhDXdE
 r8v7uWDjRrLSufZjAaq6XnmrdSK6987Rany/4Q62/Wf3KvPznxXZk1TN+wvhxXd3fxYk
 cKjytvAtrrb+O4ZvBMo6SE9gIGt/vx5wUI1vudyAVfbXeYk4wdxzQ18tjBjUbKwdec6G
 cwMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+Dfb4zfJwiE4cutPaZOp7+P+YJLYt49jzSHy78+Fxq3pIMiCk2OFqXl9400+lAR5NHHajzL4LOhg0Vsci+OpBHxiOnUMnMUEl/pup8asbNspidKRJ3sR+L1o=
X-Gm-Message-State: AOJu0Yyc0EnDHWOmvwcv/LTNChlLEwN+IF82fTx7+RmyapeU3InfIGMs
 FN+AuUfsFEtlbAzxm5hCYFEAi44d3LUyiQk4HEBAFJclny0iaoMb
X-Google-Smtp-Source: AGHT+IGR8PBhYEf/kK7SgJWwFEk1JDUX6I1Pk+mXbOap2FVpSJiOteAhKbTOYMOp/N/O3dK/fvQkDA==
X-Received: by 2002:a05:6a21:3288:b0:1aa:a6dc:38ca with SMTP id
 yt8-20020a056a21328800b001aaa6dc38camr12380037pzb.16.1715073659465; 
 Tue, 07 May 2024 02:20:59 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 la8-20020a170902fa0800b001e421f98ebdsm9583728plb.280.2024.05.07.02.20.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 May 2024 02:20:59 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 07 May 2024 19:20:54 +1000
Message-Id: <D13AVBNB9QPC.3YXDYSSSQR0@gmail.com>
Subject: Re: [PATCH v2 06/28] target/ppc/mmu_common.c: Move calculation of a
 value closer to its usage
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
X-Mailer: aerc 0.17.0
References: <cover.1714606359.git.balaton@eik.bme.hu>
 <41b1a7009a742d88a4338da8ba2335e657f18f91.1714606359.git.balaton@eik.bme.hu>
In-Reply-To: <41b1a7009a742d88a4338da8ba2335e657f18f91.1714606359.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x433.google.com
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
> In mmubooke206_check_tlb() prot2 is calculated first but only used
> after an unrelated check that can return before tha value is used.
> Move the calculation after the check, closer to where it is used, to
> keep them together and avoid computing it when not needed.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviwed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/mmu_common.c | 25 ++++++++++++-------------
>  1 file changed, 12 insertions(+), 13 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 168ff842a5..b0aca8ec02 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -828,6 +828,18 @@ static int mmubooke206_check_tlb(CPUPPCState *env, p=
pcmas_tlb_t *tlb,
> =20
>  found_tlb:
> =20
> +    /* Check the address space and permissions */
> +    if (access_type =3D=3D MMU_INST_FETCH) {
> +        /* There is no way to fetch code using epid load */
> +        assert(!use_epid);
> +        as =3D FIELD_EX64(env->msr, MSR, IR);
> +    }
> +
> +    if (as !=3D ((tlb->mas1 & MAS1_TS) >> MAS1_TS_SHIFT)) {
> +        qemu_log_mask(CPU_LOG_MMU, "%s: AS doesn't match\n", __func__);
> +        return -1;
> +    }
> +
>      if (pr) {
>          if (tlb->mas7_3 & MAS3_UR) {
>              prot2 |=3D PAGE_READ;
> @@ -849,19 +861,6 @@ found_tlb:
>              prot2 |=3D PAGE_EXEC;
>          }
>      }
> -
> -    /* Check the address space and permissions */
> -    if (access_type =3D=3D MMU_INST_FETCH) {
> -        /* There is no way to fetch code using epid load */
> -        assert(!use_epid);
> -        as =3D FIELD_EX64(env->msr, MSR, IR);
> -    }
> -
> -    if (as !=3D ((tlb->mas1 & MAS1_TS) >> MAS1_TS_SHIFT)) {
> -        qemu_log_mask(CPU_LOG_MMU, "%s: AS doesn't match\n", __func__);
> -        return -1;
> -    }
> -
>      *prot =3D prot2;
>      if (prot2 & prot_for_access_type(access_type)) {
>          qemu_log_mask(CPU_LOG_MMU, "%s: good TLB!\n", __func__);


