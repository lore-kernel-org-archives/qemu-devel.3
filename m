Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E359AC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 07:39:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPH34-0002iH-MR; Thu, 04 Jul 2024 03:38:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPH32-0002eP-02; Thu, 04 Jul 2024 03:38:32 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPH30-0001eh-6x; Thu, 04 Jul 2024 03:38:31 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1fb3037b47dso2308135ad.2; 
 Thu, 04 Jul 2024 00:38:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720078707; x=1720683507; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=TLA9wWkmSK7sZ4PTxw2n+RD9rNTP46vLwVKdbFjOfnU=;
 b=XXDK8PVZxCHg816UaNRlRE8bVbOj3mqAZy8/17JWsDnouME1K9Zd61dKBcbLv7/Wyx
 KbBBj/HEs8nygw6EsfG+cgbRmoNH/uLtY1OAGHG6g2INY2Zwe5KuOybYBZxS8vqrEZHw
 2vCY/wS7K2WnmeGwG57u+70YEvR6VGdtKwktuczGT9mzE+3BpTREke3nwqTAtruzJbes
 IgfvuAbG0FQNKSA1N4bbpS72rehKbVEEhMKzfQKR3L1ll4IjfDX+XSUovlvzgWI5Q8Ow
 adtKchUCMdVpOYqm3VtIXpdRZkIdA3czvTnwku1g232lMTmrteozmbfvkXGZMLw3UT9V
 3fsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720078707; x=1720683507;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=TLA9wWkmSK7sZ4PTxw2n+RD9rNTP46vLwVKdbFjOfnU=;
 b=tO9ShLjMFn1qVKLkI1LOKbuqMkrmmYb4SulNAo+n0Im512G5jS0n8IQby4olU3f6vy
 SaqGZ00+ZQGAJUhw+QPU8SQw6/b20EAD/5J8bBGNRHRermqcKhUvEJpsnDvfx1zvZXr0
 zPA3QifFpwaboIm27P3h8Cs9d80i1T7WTbivls1znt09GXxqLrx05b8lf/4mOQ4Py/mf
 C5opl3JU5O+pcHKYwTQyolK0CN74E2OxuhwjJFuVVGacY8IHVUbgqO8bryLChW3+CmOQ
 C1WnJMxoRQdSxSVGR2f1l7Lbuz1z/KQN4YF8r/L1D7Vpm7VE9JJaEVkDQqwa2rtD6Pko
 zRsA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVHQHdQ3LT00WCJQ4KGpPN8Pthr2SgDvXWdFxpDalm8YlgEa2/+2HgHO9s3CxzvNgY/IvkQXfBP6EVzAMSLMQ7Otg4ZkkCQaUCqekVwMgFOblI0L8FYuWky6+8=
X-Gm-Message-State: AOJu0YwOf6MFwn9i7+5B2TWg/FQx6Yr7bXOPJSdZgPb/RXyn9HZi0njI
 aY2RasfucBFNT/fQ9p4d/Y7fJSKAiaZ8Rsu3drtWuvEfXUnFdcoQ1mxXdw==
X-Google-Smtp-Source: AGHT+IFn8czwch0apLt/fW60i88UxWP75Y0kkM5XXlgGMzj5BiBAFKPixew4MLBQniZtW5PrFVgN7w==
X-Received: by 2002:a17:903:244c:b0:1f9:ecb6:c6c6 with SMTP id
 d9443c01a7336-1fb33e123bbmr7096135ad.3.1720078707382; 
 Thu, 04 Jul 2024 00:38:27 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fac1569192sm115790235ad.214.2024.07.04.00.38.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 00:38:27 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 17:38:21 +1000
Message-Id: <D2GL0EXPBTWH.3M9QTJYZO9C6A@gmail.com>
Cc: <balaton@eik.bme.hu>, <danielhb413@gmail.com>
Subject: Re: [PATCH v2 3/7] target/ppc: optimize hreg_compute_pmu_hflags_value
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Harsh Prateek Bora" <harshpb@linux.ibm.com>, <qemu-ppc@nongnu.org>,
 <qemu-devel@nongnu.org>
X-Mailer: aerc 0.17.0
References: <20240523051412.226970-1-harshpb@linux.ibm.com>
 <20240523051412.226970-4-harshpb@linux.ibm.com>
In-Reply-To: <20240523051412.226970-4-harshpb@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62c.google.com
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

On Thu May 23, 2024 at 3:14 PM AEST, Harsh Prateek Bora wrote:
> The second if-condition can be true only if the first one above is true.
> Enclose the latter into the former to avoid un-necessary check if first
> condition fails.
>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Reviewed-by: BALATON Zoltan <balaton@eik.bme.hu>

Ditto for this it's possible compiler can transform it, but I
like the code.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  target/ppc/helper_regs.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/target/ppc/helper_regs.c b/target/ppc/helper_regs.c
> index d09dcacd5e..261a8ba79f 100644
> --- a/target/ppc/helper_regs.c
> +++ b/target/ppc/helper_regs.c
> @@ -66,9 +66,9 @@ static uint32_t hreg_compute_pmu_hflags_value(CPUPPCSta=
te *env)
>  #ifndef CONFIG_USER_ONLY
>      if (env->pmc_ins_cnt) {
>          hflags |=3D 1 << HFLAGS_INSN_CNT;
> -    }
> -    if (env->pmc_ins_cnt & 0x1e) {
> -        hflags |=3D 1 << HFLAGS_PMC_OTHER;
> +        if (env->pmc_ins_cnt & 0x1e) {
> +            hflags |=3D 1 << HFLAGS_PMC_OTHER;
> +        }
>      }
>  #endif
>  #endif


