Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACDF0C4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 14 Apr 2024 22:51:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rw8gD-0001BE-V4; Sun, 14 Apr 2024 18:50:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bazz1tv2@gmail.com>)
 id 1rw8gB-0001B0-Vv
 for qemu-devel@nongnu.org; Sun, 14 Apr 2024 18:50:31 -0400
Received: from mail-vs1-f48.google.com ([209.85.217.48])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bazz1tv2@gmail.com>)
 id 1rw8gA-00086u-Cr
 for qemu-devel@nongnu.org; Sun, 14 Apr 2024 18:50:31 -0400
Received: by mail-vs1-f48.google.com with SMTP id
 ada2fe7eead31-479d3ee92d2so833175137.2
 for <qemu-devel@nongnu.org>; Sun, 14 Apr 2024 15:50:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713135029; x=1713739829;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tnd1jwAkfju/oNsMYGa5lO+DQ6AZUzNXxKpDuUykwMA=;
 b=jx1dT5GE6iWUI8NNvhFoQdPN2jPgsJwp0HpK/gFF5VxG7wpTrsl94FvtFn+9k+7PDo
 48FNPX/Pz5pJ2pNPtEfNR9ZGYqOCl2OM7+9XP/u7BiwKfw5vU+GlDNF032oY/RbvDh/w
 yzDa4aLGUaJprsFiYcBrkuchs5XFj7tFOi1A0mASn+NvWGh/ITdC7X+OaQLkAHYMKcoM
 8UhMWQhT1CPawSxvSNcPvnPJEi+Q3c2pH1lZp5CzxhEIZ3D5axCziz6/6YpZW7snlAM2
 PaSXcKNOSfXq0WcKfBF1pJZrw6cydMgiPCT3b8UhqNRevWylXuuzqPZVL1fKiLXf/J/8
 qV2g==
X-Gm-Message-State: AOJu0YyozZiJgnxtQE5lomx09YcFKQmUQ3T5RTOUslOVGsWNSaxQj+G+
 N1MzAaVl7oLGsygszSYv4vHxq4tYtzhlLlF84ZordJTG5s6OMP4eNtaZBw==
X-Google-Smtp-Source: AGHT+IHkWIsqoO8Bt4yZjPPyx4ME6tzCC0Nf0LRRtlPIWhfWhUF020aOviRvinekSaYUI8hJfy0tBg==
X-Received: by 2002:a05:6102:3f15:b0:47a:1b4f:7bdd with SMTP id
 k21-20020a0561023f1500b0047a1b4f7bddmr9899297vsv.34.1713135028712; 
 Sun, 14 Apr 2024 15:50:28 -0700 (PDT)
Received: from mail-vk1-f180.google.com (mail-vk1-f180.google.com.
 [209.85.221.180]) by smtp.gmail.com with ESMTPSA id
 q22-20020a056122005600b004cc053fb001sm980613vkn.21.2024.04.14.15.50.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 14 Apr 2024 15:50:28 -0700 (PDT)
Received: by mail-vk1-f180.google.com with SMTP id
 71dfb90a1353d-4dac112e142so1212438e0c.1
 for <qemu-devel@nongnu.org>; Sun, 14 Apr 2024 15:50:28 -0700 (PDT)
X-Received: by 2002:a05:6102:290a:b0:47a:2545:13c with SMTP id
 cz10-20020a056102290a00b0047a2545013cmr9829513vsb.5.1713135028305; Sun, 14
 Apr 2024 15:50:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240411212936.945-1-bazz@bazz1.com>
 <dfa87b87-8685-46ea-ae5d-3735124fc76a@linaro.org>
 <CAMFqb-anRmzo1HP8Gn2y0eD98+ZsG_a54c_fLMaMc=0AGAz7DA@mail.gmail.com>
 <48ec5cfe-e584-4e84-85d8-856bfd46345a@linaro.org>
 <CAMFqb-Y5mRrVk7dmEjt=EWerFu3qKAVjxE74=X6yfrRJJnqF5g@mail.gmail.com>
 <d831adc5-bfd7-482c-9e83-a10da1014b4b@linaro.org>
In-Reply-To: <d831adc5-bfd7-482c-9e83-a10da1014b4b@linaro.org>
From: M Bazz <bazz@bazz1.com>
Date: Sun, 14 Apr 2024 18:48:47 -0400
X-Gmail-Original-Message-ID: <CAMFqb-ZV9FJ3JBZNv9APpkmLWdBm1YsWRJyGkKqyN7F0HbNVZw@mail.gmail.com>
Message-ID: <CAMFqb-ZV9FJ3JBZNv9APpkmLWdBm1YsWRJyGkKqyN7F0HbNVZw@mail.gmail.com>
Subject: Re: [PATCH] target/sparc: resolve ASI_USERTXT correctly
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, Artyom Tarasenko <atar4qemu@gmail.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=209.85.217.48; envelope-from=bazz1tv2@gmail.com;
 helo=mail-vs1-f48.google.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_ENVFROM_END_DIGIT=0.25,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi Henry,

I want to thank you for every chance I get to learn from you. Each
email excites me.

On Sun, Apr 14, 2024 at 1:20=E2=80=AFPM Richard Henderson
<richard.henderson@linaro.org> wrote:
> The "current" permission, as computed by
>
> > -    case ASI_KERNELTXT: /* Supervisor code access */
> > -        oi =3D make_memop_idx(memop, cpu_mmu_index(env_cpu(env), true)=
);
>
> was correct for ASI_KERNELTXT, because as you say "lda" is a supervisor-o=
nly instruction
> prior to sparcv9.
>

I noticed that cpu_mmu_index() would have returned MMU_USER_IDX
if the supervisor bit hadn't happened to be set (not sure if this
execution path can
occur for lda). Note that this check is gone in your patch.

I consider you my sensei, so while I'm confident in your work I also
want to show
the things I catch.

If I understand everything you've taught me, then the following patch would
have also satisfied the permissions issue. Could you confirm this please?
The essential change is the MMU_USER_IDX in the call to make_memop_idx()

diff --git a/target/sparc/ldst_helper.c b/target/sparc/ldst_helper.c
index e581bb42ac..be3c03a3b6 100644
--- a/target/sparc/ldst_helper.c
+++ b/target/sparc/ldst_helper.c
@@ -702,6 +702,24 @@ uint64_t helper_ld_asi(CPUSPARCState *env,
target_ulong addr,
             break;
         }
         break;
+    case ASI_USERTXT: /* User code access */
+        oi =3D make_memop_idx(memop, MMU_USER_IDX);
+        switch (size) {
+        case 1:
+            ret =3D cpu_ldb_code_mmu(env, addr, oi, GETPC());
+            break;
+        case 2:
+            ret =3D cpu_ldw_code_mmu(env, addr, oi, GETPC());
+            break;
+        default:
+        case 4:
+            ret =3D cpu_ldl_code_mmu(env, addr, oi, GETPC());
+            break;
+        case 8:
+            ret =3D cpu_ldq_code_mmu(env, addr, oi, GETPC());
+            break;
+        }
+        break;
     case ASI_M_TXTC_TAG:   /* SparcStation 5 I-cache tag */
     case ASI_M_TXTC_DATA:  /* SparcStation 5 I-cache data */
     case ASI_M_DATAC_TAG:  /* SparcStation 5 D-cache tag */
@@ -779,7 +797,6 @@ uint64_t helper_ld_asi(CPUSPARCState *env,
target_ulong addr,
     case 0x4c: /* SuperSPARC MMU Breakpoint Action */
         ret =3D env->mmubpaction;
         break;
-    case ASI_USERTXT: /* User code access, XXX */
     default:
         sparc_raise_mmu_fault(cs, addr, false, false, asi, size, GETPC());
         ret =3D 0;

> Unfortunately, we do not have any good documentation for tcg softmmu or t=
he intended role
> of the mmu_idx.  Partly that's due to the final use of the mmu_idx is tar=
get-specific.

I love learning from code, but the lack of documentation definitely
increases the value of your
discourse with me.

Thank you,
Sincerely,
-bazz

