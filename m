Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67929C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 03:46:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trU5a-0006FB-2a; Sun, 09 Mar 2025 23:46:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trU5O-0006E8-S0; Sun, 09 Mar 2025 23:45:51 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trU5L-0001Td-UG; Sun, 09 Mar 2025 23:45:50 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2235189adaeso60426565ad.0; 
 Sun, 09 Mar 2025 20:45:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741578343; x=1742183143; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Mw/jeUERkLKAweK7RS1n9/MfoGe6ceetjaT2xMBOY3w=;
 b=DTRQLuurUW7NFDiAhh85wVG/n4KnphFxM1fyOEpEPCDnCtmLsrLhG67D2QJBAEBaZi
 65RqKaHlRX/PpsvcP8Cn+RI5A/cL+GtT4UZod/ZPfHCSeL+v42JRSoUEKEPOVI39yqXa
 /cRb9PGw42TWavV3yoK3P5mCSdp5UudkgfkSr2Pv0yJsuXxNUMp44ZL66AYHC6ixlB0x
 VwoBhIyoft0hiAiRKjVCYK7y5Xvsoksh10PbMuX4Sn8qnUro1YNAumumuCX9uZMPYXgP
 O948eet9OflcPFfWOxZ5A+OCxrpBAh6F6lDZIFA8/jwI3aX9pitfCpn8/FyX3dvFbtKq
 nQ5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741578343; x=1742183143;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=Mw/jeUERkLKAweK7RS1n9/MfoGe6ceetjaT2xMBOY3w=;
 b=xRpVPMp95AA/Ic+heapu9/SgGLGUVOs2pfaoNN5TY7nMKX2BDn/wGIVgiCN3QvcYtM
 QjKGuSVz+PtcVb2Li/uKAufruhCbb9qpqnTtszor+eYjPIbw67HvWgjPC5wqd9i3fyZ8
 muKzHQj+JrhQoXITm5kUD7ilKE5TsgHKK5LJUWCFWIv8owSQU4exkFNqEyeFwg14W1By
 /O5CcDXfwnCTQ3f7QpRKCFqz3azM0e2ByxvI5c018nbMOXs5gd7zuipDoDoebCK77Na8
 BpMeDNb6gAwRXLdmr8MFvxOc3km7XUpoDfoA0Z/EZ7t+IWd2Gx2sl1ruB+DHZO8D2Pxc
 sMHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFRPWmR+MjF9m/vy1sF+YPBHqudra4pOrdIwXmbgEy10betw10Lsd/5sqe1QZBh/QS7iK17A5Wimq1@nongnu.org
X-Gm-Message-State: AOJu0YyDCFjIBQnARH5Gy5IyBqLCJt1MrfuWVRxLA00rkZfL9oNg2krK
 4b0jF7t3JVCFdxfRdbPnEg2NzLb5XGQOn6uU3JTwumQw9U/dW4+o
X-Gm-Gg: ASbGncsNtMKqh7GsOjRxEBXZPjzv28T5z6X1HU0fXzgatzKBrvV7R2XvEw0hBzt2Vh1
 u1mcuxOyFHgy6LptedYcd5b7lz17tcRKQfI9r3B+Bx+0guFRkZ9QoSwt2XrmrEwbu9DzOner4Uo
 ICT2Id4MkzPxW94sQBQ/JAQHjq7ZKq+nofAZaeRHWwf8Qc3AMI9YXqdFhuELNAofcJzOwPqzoQt
 kTWuIZG0K8AQX6GjDzAouGttVKiqwvIvAbwD/aJIJMjTy3o5Jk23bj8zRrjwf+eLocUIhxFbU2+
 nQLOKC7CQkRTbRCX0W1CDo16vu/ok8EtX2HHu8jaFIqYfiO8kos=
X-Google-Smtp-Source: AGHT+IE/clwcB/avF7in6VmHWT9tVSTl/Ax2K+FDdg5y5h8VJo/IWaTy3H/lE6pPV4MiYZK87+YjCg==
X-Received: by 2002:a17:902:ced1:b0:223:5187:a886 with SMTP id
 d9443c01a7336-2246454ad58mr118137345ad.22.1741578343457; 
 Sun, 09 Mar 2025 20:45:43 -0700 (PDT)
Received: from localhost ([118.208.151.101]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22410aa5ebbsm67126535ad.229.2025.03.09.20.45.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Mar 2025 20:45:43 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Mar 2025 13:45:37 +1000
Message-Id: <D8C9ZUZXOE3W.NOK6K9FTGTMP@gmail.com>
Cc: <qemu-ppc@nongnu.org>, <fbarrat@linux.ibm.com>, <milesg@linux.ibm.com>,
 <danielhb413@gmail.com>, <david@gibson.dropbear.id.au>,
 <harshpb@linux.ibm.com>, <thuth@redhat.com>, <lvivier@redhat.com>,
 <pbonzini@redhat.com>
Subject: Re: [PATCH v2 02/14] ppc/xive: Rename ipb_to_pipr() to
 xive_ipb_to_pipr()
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Michael Kowal" <kowal@linux.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20241210000527.9541-1-kowal@linux.ibm.com>
 <20241210000527.9541-4-kowal@linux.ibm.com>
In-Reply-To: <20241210000527.9541-4-kowal@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x62f.google.com
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

On Tue Dec 10, 2024 at 10:05 AM AEST, Michael Kowal wrote:
> Renamed function to follow the convention of the other function names.
>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  include/hw/ppc/xive.h | 16 ++++++++++++----
>  hw/intc/xive.c        | 22 ++++++----------------
>  2 files changed, 18 insertions(+), 20 deletions(-)
>
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index ebee982528..41a4263a9d 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -130,11 +130,9 @@
>   *   TCTX   Thread interrupt Context
>   *
>   *
> - * Copyright (c) 2017-2018, IBM Corporation.
> - *
> - * This code is licensed under the GPL version 2 or later. See the
> - * COPYING file in the top-level directory.
> + * Copyright (c) 2017-2024, IBM Corporation.
>   *
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> =20
>  #ifndef PPC_XIVE_H
> @@ -510,6 +508,16 @@ static inline uint8_t xive_priority_to_ipb(uint8_t p=
riority)
>          0 : 1 << (XIVE_PRIORITY_MAX - priority);
>  }
> =20
> +/*
> + * Convert an Interrupt Pending Buffer (IPB) register to a Pending
> + * Interrupt Priority Register (PIPR), which contains the priority of
> + * the most favored pending notification.
> + */
> +static inline uint8_t xive_ipb_to_pipr(uint8_t ibp)
> +{
> +    return ibp ? clz32((uint32_t)ibp << 24) : 0xff;
> +}
> +
>  /*
>   * XIVE Thread Interrupt Management Aera (TIMA)
>   *
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 245e4d181a..7b06a48139 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -3,8 +3,7 @@
>   *
>   * Copyright (c) 2017-2018, IBM Corporation.
>   *
> - * This code is licensed under the GPL version 2 or later. See the
> - * COPYING file in the top-level directory.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
> =20
>  #include "qemu/osdep.h"
> @@ -27,15 +26,6 @@
>   * XIVE Thread Interrupt Management context
>   */
> =20
> -/*
> - * Convert an Interrupt Pending Buffer (IPB) register to a Pending
> - * Interrupt Priority Register (PIPR), which contains the priority of
> - * the most favored pending notification.
> - */
> -static uint8_t ipb_to_pipr(uint8_t ibp)
> -{
> -    return ibp ? clz32((uint32_t)ibp << 24) : 0xff;
> -}
> =20
>  static uint8_t exception_mask(uint8_t ring)
>  {
> @@ -159,7 +149,7 @@ static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_=
t ring, uint8_t cppr)
>       * Recompute the PIPR based on local pending interrupts.  The PHYS
>       * ring must take the minimum of both the PHYS and POOL PIPR values.
>       */
> -    pipr_min =3D ipb_to_pipr(regs[TM_IPB]);
> +    pipr_min =3D xive_ipb_to_pipr(regs[TM_IPB]);
>      ring_min =3D ring;
> =20
>      /* PHYS updates also depend on POOL values */
> @@ -169,7 +159,7 @@ static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_=
t ring, uint8_t cppr)
>          /* POOL values only matter if POOL ctx is valid */
>          if (pool_regs[TM_WORD2] & 0x80) {
> =20
> -            uint8_t pool_pipr =3D ipb_to_pipr(pool_regs[TM_IPB]);
> +            uint8_t pool_pipr =3D xive_ipb_to_pipr(pool_regs[TM_IPB]);
> =20
>              /*
>               * Determine highest priority interrupt and
> @@ -193,7 +183,7 @@ void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t rin=
g, uint8_t ipb)
>      uint8_t *regs =3D &tctx->regs[ring];
> =20
>      regs[TM_IPB] |=3D ipb;
> -    regs[TM_PIPR] =3D ipb_to_pipr(regs[TM_IPB]);
> +    regs[TM_PIPR] =3D xive_ipb_to_pipr(regs[TM_IPB]);
>      xive_tctx_notify(tctx, ring);
>  }
> =20
> @@ -841,9 +831,9 @@ void xive_tctx_reset(XiveTCTX *tctx)
>       * CPPR is first set.
>       */
>      tctx->regs[TM_QW1_OS + TM_PIPR] =3D
> -        ipb_to_pipr(tctx->regs[TM_QW1_OS + TM_IPB]);
> +        xive_ipb_to_pipr(tctx->regs[TM_QW1_OS + TM_IPB]);
>      tctx->regs[TM_QW3_HV_PHYS + TM_PIPR] =3D
> -        ipb_to_pipr(tctx->regs[TM_QW3_HV_PHYS + TM_IPB]);
> +        xive_ipb_to_pipr(tctx->regs[TM_QW3_HV_PHYS + TM_IPB]);
>  }
> =20
>  static void xive_tctx_realize(DeviceState *dev, Error **errp)


