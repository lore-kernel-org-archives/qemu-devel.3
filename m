Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8D0FC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 07:18:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPGip-0001t7-75; Thu, 04 Jul 2024 03:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPGin-0001rX-Bh; Thu, 04 Jul 2024 03:17:37 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1sPGiY-0002nI-T2; Thu, 04 Jul 2024 03:17:37 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-2c98db7a10cso261008a91.3; 
 Thu, 04 Jul 2024 00:17:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1720077440; x=1720682240; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vTpyxUWKzuI1hRIYSt9ak4GZrTMTiXFPK7/9bzAxVp4=;
 b=ZXAPE3Hjw7gTMashBA1BGuw6ZH6XJq9Rqz02C+6BGhkp6qu9IOtRFbVSfn9RPTwV0+
 fRXaasdr5HW54+Xf+1IPNERrn1WJv0PLpnfb0eFa1zXgpOPyF+FzIUUoKARQRFKmqHIM
 2OtgncV+SFrgwEHdl+UJnv/26t5or/r2lpgy0ByncQYczghgH1TZn/q8TONveMQDRjyz
 vXdd9dU2sX/lrvnGvviON3g9n3Gd4m6A7/F0i5hi4cJLR3dBhS4EnL+/gOFzvWg2eYTT
 UfXvUlloMGU2uANwhXMYvT0vK92qy6EB1dIu/ZRB89FiepGszrpWT1NQ4y/zS0bXJJ0G
 324A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720077440; x=1720682240;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=vTpyxUWKzuI1hRIYSt9ak4GZrTMTiXFPK7/9bzAxVp4=;
 b=U+AJHOwCPNkQfzO/BctVDrT/SV8Ipb99/yUUcdCXWcpM/0roNMvEBkt67ILuXA9m3G
 0cg2xWvB+UJ2v70q7pKzaYfgjUB1xVwBjO3nSBJ8hfI+7YL7Q3Sxi+Mw8whc0X3Lkbo8
 c45fbrlCTLZBVoPfl6Vd+UPuQF29wW0/JDotnG4z4uupSA3noMqkox+I+O6aLPO9grTq
 nOeA68V/3Sv2iYRkBW3N17i0IGf0W7Z9/2rcHXcgMqFG47WPGMvIgU5SRGzzmlo0Ct+z
 Kd0BtDPZvjk3jIckhS5nIkijWJ/vmkW202wg4Qb0dKQ4a7dguBvhe37ZhtjuBwCH3R9j
 E/3g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlO/YgDo+thrYStbWzaIUIjHqxXCMxvYKlYHTjR/MQZXJrV8wkJirdZcqV3lCH1zK0QtRGMCHwO7rstohoF43tchjGXCNOUy89nbrtHWDPFszRZgaSaBCKmf8=
X-Gm-Message-State: AOJu0Ywsxy1SYkr/24xKqoajXypGBULDgEbvQJ+13UL/rkhMM1lh1mS2
 0jBYr1X1+kuH4yy7zeDv2A5e1Z5UA7Uh+4TR6kPNci8TcENFt+LkwXX+7w==
X-Google-Smtp-Source: AGHT+IFJ027/NdleAivqcE1Oe3JPsNZpo1PRn/zh4nb+9qn5HeRuf51sNTQq/Uf8hjA5TULJyvM/IA==
X-Received: by 2002:a17:90a:c908:b0:2c9:6cf4:8453 with SMTP id
 98e67ed59e1d1-2c99c6aab29mr625882a91.31.1720077440122; 
 Thu, 04 Jul 2024 00:17:20 -0700 (PDT)
Received: from localhost ([1.146.24.72]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c99a946fc8sm749107a91.1.2024.07.04.00.17.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 00:17:19 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Thu, 04 Jul 2024 17:17:14 +1000
Message-Id: <D2GKK8RB4GE3.3QUYEA75OHQOH@gmail.com>
Cc: "Daniel Henrique Barboza" <danielhb413@gmail.com>
Subject: Re: [PATCH 32/43] target/ppc: Remove includes from mmu-book3s-v3.h
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>, <qemu-devel@nongnu.org>,
 <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.17.0
References: <cover.1716763435.git.balaton@eik.bme.hu>
 <cf3dca03400d059de3dab761b11439d38e71d621.1716763435.git.balaton@eik.bme.hu>
In-Reply-To: <cf3dca03400d059de3dab761b11439d38e71d621.1716763435.git.balaton@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102d.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, FREEMAIL_FROM=0.001, SPF_HELO_NONE=0.001,
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

On Mon May 27, 2024 at 9:13 AM AEST, BALATON Zoltan wrote:
> Drop includes from header that is not needed by the header itself and
> only include them from C files that really need it.

Acked-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
>  target/ppc/mmu-book3s-v3.h | 3 ---
>  target/ppc/mmu-hash64.c    | 1 +
>  target/ppc/mmu-radix64.c   | 1 +
>  3 files changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/target/ppc/mmu-book3s-v3.h b/target/ppc/mmu-book3s-v3.h
> index 263ce55c1f..be66e26604 100644
> --- a/target/ppc/mmu-book3s-v3.h
> +++ b/target/ppc/mmu-book3s-v3.h
> @@ -20,9 +20,6 @@
>  #ifndef PPC_MMU_BOOK3S_V3_H
>  #define PPC_MMU_BOOK3S_V3_H
> =20
> -#include "mmu-hash64.h"
> -#include "mmu-books.h"
> -
>  #ifndef CONFIG_USER_ONLY
> =20
>  /*
> diff --git a/target/ppc/mmu-hash64.c b/target/ppc/mmu-hash64.c
> index 7bc0323f26..5e1983e334 100644
> --- a/target/ppc/mmu-hash64.c
> +++ b/target/ppc/mmu-hash64.c
> @@ -31,6 +31,7 @@
>  #include "hw/hw.h"
>  #include "internal.h"
>  #include "mmu-book3s-v3.h"
> +#include "mmu-books.h"
>  #include "helper_regs.h"
> =20
>  #ifdef CONFIG_TCG
> diff --git a/target/ppc/mmu-radix64.c b/target/ppc/mmu-radix64.c
> index cf9619e847..be7a45f254 100644
> --- a/target/ppc/mmu-radix64.c
> +++ b/target/ppc/mmu-radix64.c
> @@ -28,6 +28,7 @@
>  #include "internal.h"
>  #include "mmu-radix64.h"
>  #include "mmu-book3s-v3.h"
> +#include "mmu-books.h"
> =20
>  /* Radix Partition Table Entry Fields */
>  #define PATE1_R_PRTB           0x0FFFFFFFFFFFF000


