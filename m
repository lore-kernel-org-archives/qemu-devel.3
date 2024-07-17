Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2027EC3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jul 2024 11:36:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sU2xN-0007cQ-5S; Wed, 17 Jul 2024 07:36:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sU2xM-0007Xw-1F; Wed, 17 Jul 2024 07:36:24 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sU2xK-0006BE-Af; Wed, 17 Jul 2024 07:36:23 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-71871d5e087so4818652a12.1; 
 Wed, 17 Jul 2024 04:36:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1721216180; x=1721820980; darn=nongnu.org;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SjDNCrVZri2OQLEfs/BSYvxXh9QSml29l48AO2Q549g=;
 b=fP4O4iPfSr1KPyIlZaNV7HuOJWaPIhHfikDHiU53IBZzaxnYqIKcxhHxJdgEDXyucO
 4yJs6brCHpjeb1YMfpp91/C66lUuXQBsh4Eoqu1VZMSyAC/q48Lwt36sDYvJhMCkUrr1
 jUf2+prPG6nF68XZxocmDHt0BDMRod4NZT3w13TQjh+eUP5PqemQqie8LC6/5zu1+Fsd
 ojTgL2XIj1b2+4TN+Gx2ywl/725lgvQvh0+ceSfyv0CAzqVp2GBnqclAESdB/YgHDhin
 aY02Tu+iCx380yV1gdyIILwGMLnZ3+ubtWdPY9cNHyBB6iQ8JmX+HU4lhCRCiIE4vHSB
 ezEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721216180; x=1721820980;
 h=in-reply-to:references:subject:cc:to:from:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=SjDNCrVZri2OQLEfs/BSYvxXh9QSml29l48AO2Q549g=;
 b=leTh0tPPynq+dgycF/RhRlb6AdfttLK1zPQYBSsVOrxo/C9mh1ynkTtFtG7bSiWLyf
 pSsABN01GEUrEPZY672zvlqdcRxy/E7sBObj+g0FpkGoL0zTC+6zSYXhmRAy0rppyn9t
 G2Hr3gLZJ7cTgmNt9TtryHKnB7kz4Hgy3K2Bbl3SlpYm68Fj5jM2PKCI9hJXTT/SQapd
 Zp7gYv0rtYPiqQ36HhI1el/XM7RRCMtMwKEPsgnDCQe92lLCNW0oeLUedH/wI3s69zyN
 TB2E3s5kRgVVXEkMI+yEJ711xLKeheFfl3spaMki0KtQ/c1PNLWKALLsIQEPppE3VVOi
 Qs6A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUymm85B4M1kl76ZEPrm2CVB69RcoW3q+fWfTdEJlWHghk2lJ0/E+nXDeMTd0VpK2OOIB7reRvryvclwUkcZpOXqxQbdJM=
X-Gm-Message-State: AOJu0YxkDJioBZhZa7HuN6ly7L2JS1FtWC5AzjSSoto9wckK7DUqKPsl
 M1bGQGYOFIaKiEgPtE8lVlzYIDaMjGngSYi3mEUZ85FEDvid8xL/
X-Google-Smtp-Source: AGHT+IGNAooj++Z2F6n75oMX3EChxlljU7nO7GFSPmE9t2VjOSoaqHzoNPfENJBxR6SD6dzTo8nyVw==
X-Received: by 2002:a05:6a20:9c8d:b0:1bd:a048:7fcc with SMTP id
 adf61e73a8af0-1c3fdd88503mr1703352637.46.1721216180531; 
 Wed, 17 Jul 2024 04:36:20 -0700 (PDT)
Received: from localhost ([1.146.100.214]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2caedc137e6sm7875860a91.32.2024.07.17.04.36.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jul 2024 04:36:20 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 17 Jul 2024 21:36:15 +1000
Message-Id: <D2RS7N16U915.3TZB6FC33BXQB@gmail.com>
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Richard Henderson" <richard.henderson@linaro.org>, <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, <balaton@eik.bme.hu>
Subject: Re: [PATCH 1/4] target/ppc/mem_helper.c: Remove a conditional from
 dcbz_common()
X-Mailer: aerc 0.17.0
References: <20240702234659.2106870-1-richard.henderson@linaro.org>
 <20240702234659.2106870-2-richard.henderson@linaro.org>
In-Reply-To: <20240702234659.2106870-2-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x52c.google.com
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

On Wed Jul 3, 2024 at 9:46 AM AEST, Richard Henderson wrote:
> From: BALATON Zoltan <balaton@eik.bme.hu>
>
> Instead of passing a bool and select a value within dcbz_common() let
> the callers pass in the right value to avoid this conditional
> statement. On PPC dcbz is often used to zero memory and some code uses
> it a lot. This change improves the run time of a test case that copies
> memory with a dcbz call in every iteration from 6.23 to 5.83 seconds.
>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> Message-Id: <20240622204833.5F7C74E6000@zero.eik.bme.hu>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/ppc/mem_helper.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
>
> diff --git a/target/ppc/mem_helper.c b/target/ppc/mem_helper.c
> index f88155ad45..361fd72226 100644
> --- a/target/ppc/mem_helper.c
> +++ b/target/ppc/mem_helper.c
> @@ -271,12 +271,11 @@ void helper_stsw(CPUPPCState *env, target_ulong add=
r, uint32_t nb,
>  }
> =20
>  static void dcbz_common(CPUPPCState *env, target_ulong addr,
> -                        uint32_t opcode, bool epid, uintptr_t retaddr)
> +                        uint32_t opcode, int mmu_idx, uintptr_t retaddr)
>  {
>      target_ulong mask, dcbz_size =3D env->dcache_line_size;
>      uint32_t i;
>      void *haddr;
> -    int mmu_idx =3D epid ? PPC_TLB_EPID_STORE : ppc_env_mmu_index(env, f=
alse);
> =20
>  #if defined(TARGET_PPC64)
>      /* Check for dcbz vs dcbzl on 970 */
> @@ -309,12 +308,12 @@ static void dcbz_common(CPUPPCState *env, target_ul=
ong addr,
> =20
>  void helper_dcbz(CPUPPCState *env, target_ulong addr, uint32_t opcode)
>  {
> -    dcbz_common(env, addr, opcode, false, GETPC());
> +    dcbz_common(env, addr, opcode, ppc_env_mmu_index(env, false), GETPC(=
));
>  }
> =20
>  void helper_dcbzep(CPUPPCState *env, target_ulong addr, uint32_t opcode)
>  {
> -    dcbz_common(env, addr, opcode, true, GETPC());
> +    dcbz_common(env, addr, opcode, PPC_TLB_EPID_STORE, GETPC());
>  }
> =20
>  void helper_icbi(CPUPPCState *env, target_ulong addr)


