Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5349DC10F1A
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2024 06:02:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4wqR-0007nH-55; Thu, 09 May 2024 02:01:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4wqD-0007ll-N9; Thu, 09 May 2024 02:01:18 -0400
Received: from mail-pg1-x532.google.com ([2607:f8b0:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1s4wqA-0002IJ-UM; Thu, 09 May 2024 02:01:16 -0400
Received: by mail-pg1-x532.google.com with SMTP id
 41be03b00d2f7-5e152c757a5so325061a12.2; 
 Wed, 08 May 2024 23:01:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1715234473; x=1715839273; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iYghtmEU3Ova8Cj8/5R1jBc8IJ1vFh2gb5KFJgj7R4U=;
 b=BLKRlaN1EzT9eh8YGjzBmwspWg+sKImkreOywIuS5Y703C3ymtqh/UfmYxQpQa4Mye
 /dlJTxPaFLmznGNIzdG/6xKp1kFU3k3VNk1b//t8NaF1/JDPPmLo/GiaThifEYzK/ySc
 6zqd8/Xa3QMFle5wLtcOeG5AjjTPveG1jLdCcyjFL7yigYeFhxg8O1q5WC4ecUedzlRs
 w66xGCFTCI343z3m5z9JH754spAauhIedPU5eiOJzaku6Ty/yTSuGD2vlPgmngRfeuZi
 +EBIYDF/lqznYUd/zD06nAR+Bi87nYBqMmT4hSYCM90e5SvD7CuTYvpCTI5Cagiq5tF8
 I8Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715234473; x=1715839273;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=iYghtmEU3Ova8Cj8/5R1jBc8IJ1vFh2gb5KFJgj7R4U=;
 b=DhJIA/x5w6a3G0k6Hk7slMLbYBxs3M8U+0wV1nHcGJpI/vnDTUVOQdth/3pHRvhY1F
 VMECp+3Aym2Y6koCvpId++QUJPhFi/XtCdbLknZCtt/gjKh5NYbMnxX4LnwW0NwcMG5C
 9LT1U4srpR7Xp2CCXX40AkdlfgMzMHn8njsHHZmG0yrCNWlFvlMDwN6KGUy57gC4BCE+
 9CTZJ0k/hrWKkI/5OKah0wI2duf5wl48xu3FpWdU/Ty6obrfVsXVF0h6T0bATUl/lGCE
 eV9FzsaQJCgLypuAa1Ng8jxTaUzPHTDjk6riSVQ2SWTBDWcEvKRS6L8GNzOARZB8ORrR
 zjFQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVy8NUbYzLQizuzJ3WuTdsv28KTUvuPO7FC+cCkF1DYAAVJYebeO+AWRVhPAponp0SiSiN0cS02n4QzEcRqRSYa/71R/Mw6gvGmuP8nrbYovDr53p7x797YC58=
X-Gm-Message-State: AOJu0Yz8gMlGg5siNMoiF7WfRwuaBewpiO0/zys33XrddK06RwkLFa41
 mh26ht89ZAjjFcOh05bUy3zg+cNNq4v3E8mYeXvhRgSm3UbTrvuYTpf8vQ==
X-Google-Smtp-Source: AGHT+IEmbvg4ulIWf/GfjnpEMBAmB32TwWTAH6mr9pn/EiLx9BmjRAWidAYzD8woJsIpH5MVHNXGZA==
X-Received: by 2002:a05:6a20:9745:b0:1a7:7fbb:262d with SMTP id
 adf61e73a8af0-1afc8d6bcb4mr4667380637.36.1715234473191; 
 Wed, 08 May 2024 23:01:13 -0700 (PDT)
Received: from localhost (220-245-239-57.tpgi.com.au. [220.245.239.57])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2b5d4c8cc5asm2945866a91.0.2024.05.08.23.01.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 23:01:12 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 09 May 2024 16:01:07 +1000
Message-Id: <D14VVGBLHU3B.3IUZU1YZ8CQ40@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH v4 08/33] target/ppc/mmu_common.c: Drop cases for
 unimplemented MPC8xx MMU
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1715209155.git.balaton@eik.bme.hu>
 <71aafa52bdf95e4c82e0ed2f6ca045eaccb56abe.1715209155.git.balaton@eik.bme.hu>
In-Reply-To: <71aafa52bdf95e4c82e0ed2f6ca045eaccb56abe.1715209155.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::532;
 envelope-from=npiggin@gmail.com; helo=mail-pg1-x532.google.com
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
> Drop MPC8xx cases from get_physical_address_wtlb() and ppc_jumbo_xlate().
> The default case would still catch this and abort the same way and
> there is still a warning about it in ppc_tlb_invalidate_all() which is
> called in ppc_cpu_reset_hold() so likely we never get here but to make
> sure add a case to ppc_xlate() to the same effect.
>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/mmu_common.c | 12 ++----------
>  1 file changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/target/ppc/mmu_common.c b/target/ppc/mmu_common.c
> index 886fb6a657..3391df61cb 100644
> --- a/target/ppc/mmu_common.c
> +++ b/target/ppc/mmu_common.c
> @@ -1219,10 +1219,6 @@ int get_physical_address_wtlb(CPUPPCState *env, mm=
u_ctx_t *ctx,
>          ret =3D mmubooke206_get_physical_address(env, ctx, eaddr, access=
_type,
>                                                 mmu_idx);
>          break;
> -    case POWERPC_MMU_MPC8xx:
> -        /* XXX: TODO */
> -        cpu_abort(env_cpu(env), "MPC8xx MMU model is not implemented\n")=
;
> -        break;
>      case POWERPC_MMU_REAL:
>          if (real_mode) {
>              ret =3D check_physical(env, ctx, eaddr, access_type);
> @@ -1353,8 +1349,6 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr =
eaddr,
>                      env->spr[SPR_BOOKE_DEAR] =3D eaddr;
>                      env->spr[SPR_BOOKE_ESR] =3D mmubooke206_esr(mmu_idx,=
 MMU_DATA_LOAD);
>                      break;
> -                case POWERPC_MMU_MPC8xx:
> -                    cpu_abort(cs, "MPC8xx MMU model is not implemented\n=
");
>                  case POWERPC_MMU_REAL:
>                      cpu_abort(cs, "PowerPC in real mode should never rai=
se "
>                                "any MMU exceptions\n");
> @@ -1427,9 +1421,6 @@ static bool ppc_jumbo_xlate(PowerPCCPU *cpu, vaddr =
eaddr,
>                          env->spr[SPR_40x_ESR] =3D 0x00000000;
>                      }
>                      break;
> -                case POWERPC_MMU_MPC8xx:
> -                    /* XXX: TODO */
> -                    cpu_abort(cs, "MPC8xx MMU model is not implemented\n=
");
>                  case POWERPC_MMU_BOOKE206:
>                      booke206_update_mas_tlb_miss(env, eaddr, access_type=
, mmu_idx);
>                      /* fall through */
> @@ -1539,7 +1530,8 @@ bool ppc_xlate(PowerPCCPU *cpu, vaddr eaddr, MMUAcc=
essType access_type,
>      case POWERPC_MMU_32B:
>          return ppc_hash32_xlate(cpu, eaddr, access_type, raddrp,
>                                 psizep, protp, mmu_idx, guest_visible);
> -
> +    case POWERPC_MMU_MPC8xx:
> +        cpu_abort(env_cpu(&cpu->env), "MPC8xx MMU model is not implement=
ed\n");
>      default:
>          return ppc_jumbo_xlate(cpu, eaddr, access_type, raddrp,
>                                 psizep, protp, mmu_idx, guest_visible);


