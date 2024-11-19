Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E47D60D0B
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 02:09:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDDfP-0004h2-61; Mon, 18 Nov 2024 21:08:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tDDfN-0004gL-IS; Mon, 18 Nov 2024 21:08:33 -0500
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tDDfK-0000uk-F8; Mon, 18 Nov 2024 21:08:33 -0500
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7242f559a9fso426734b3a.1; 
 Mon, 18 Nov 2024 18:08:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731982108; x=1732586908; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h5s8AQVT15HW+qaQl3DYYSVQl/jyAzKMzRvCE6cCvAY=;
 b=QFvzkEZQZ1vncAnEYmotqu8HFCkfFBc0FqpMK9I/t2ixkK8dcUCgiodT7f8IH6lYF5
 4pMEM4HVmOCBlqiioDk+BhcmUffZE0TsjJV4ZgSn9U9Jdqk3t1crjIT4kQ4X2JluVzPH
 DXNroHkrWfMRThxKy1o7Pss/ByoeyMg4OM6uN4L+VlIu/KXMQ/a9HFuk8cZMk6Bbp4GK
 RfuB5CdUJWrQEvG3wk/5BTZ/BPUJ7q+D9AD65giy6j3d3seeYYhr0BPYcqAmFdKmIvze
 pLzgQF8Oy38iXoXB6iF+dqY93liySpVJzdeZUD6JUH/akxH76MOMkTRAH8y03GCoSsaM
 Dhcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731982108; x=1732586908;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=h5s8AQVT15HW+qaQl3DYYSVQl/jyAzKMzRvCE6cCvAY=;
 b=h1/hQJY7w4A9iazC8PaKiyeXz3D+TtYdqZsTp1qePvhfDxpUt/VVPgopJtn7JxAGDG
 uKdqKgvpdVo5fkdZi6gTcpzAJbzx6qO8qZDP9i9d/W0m7F7bP6cmdLQqw7eeVSijtzWC
 5TwgnuXYFdffGF02ttDKVveL3nmCnxugkUI6xvxX9VZ/weMPfyWAQhxuIz7oZnyXjE6I
 ymngtKa7AS12Z/XARxQhQTvE5IV6s5SV6Lq8LWzyFLuxLlDFFj9n5Q8HMaSgeg7AJTH6
 AkmQE+MLzoxt6iw+f7MYZI+8AXoUmpYt/osDFAwPK7Ref2/A6zn+lk5xWyoSf0KM3Qyf
 w6gA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwxhM3hxpjk5fluQRtVckH3wWmPT9oIGk8SdBPNw7D8BFKc4wpS3JjVeSiUGVthmEaheTqYB8Kcrzy@nongnu.org
X-Gm-Message-State: AOJu0YycFbuNr3YfbQMpjak8Ve89r/iM1Gf6R4bdTrdQjS28QvC9AQ0H
 tMC75rEO3QBMyXTcHYYwgMzXkgUKmeH0kZ/OP9jpW21ccer2bcuD
X-Google-Smtp-Source: AGHT+IHnsY2ejUaAbXXi0hIXl0QkpSuhTE+wrBR+tau1puKON02vR3U5EVuswZ+as4jxbZIXFyR21A==
X-Received: by 2002:a17:90a:e703:b0:2ea:5e0c:2853 with SMTP id
 98e67ed59e1d1-2ea5e1b739bmr8709257a91.4.1731982107617; 
 Mon, 18 Nov 2024 18:08:27 -0800 (PST)
Received: from localhost (124-171-72-210.tpgi.com.au. [124.171.72.210])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ea06f1c6c9sm8248432a91.22.2024.11.18.18.08.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 18:08:26 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Nov 2024 12:08:19 +1000
Message-Id: <D5PSEW94BJB5.KTCIM3LO579K@gmail.com>
Cc: <qemu-ppc@nongnu.org>, <clg@kaod.org>, <fbarrat@linux.ibm.com>,
 <milesg@linux.ibm.com>, <danielhb413@gmail.com>,
 <david@gibson.dropbear.id.au>, <harshpb@linux.ibm.com>, <thuth@redhat.com>,
 <lvivier@redhat.com>, <pbonzini@redhat.com>
Subject: Re: [PATCH 02/14] ppc/xive2: Add grouping level to notification
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Michael Kowal" <kowal@linux.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.18.2
References: <20241015211329.21113-1-kowal@linux.ibm.com>
 <20241015211329.21113-3-kowal@linux.ibm.com>
In-Reply-To: <20241015211329.21113-3-kowal@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x434.google.com
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

On Wed Oct 16, 2024 at 7:13 AM AEST, Michael Kowal wrote:
> From: Frederic Barrat <fbarrat@linux.ibm.com>
>
> The NSR has a (so far unused) grouping level field. When a interrupt
> is presented, that field tells the hypervisor or OS if the interrupt
> is for an individual VP or for a VP-group/crowd. This patch reworks
> the presentation API to allow to set/unset the level when
> raising/accepting an interrupt.
>
> It also renames xive_tctx_ipb_update() to xive_tctx_pipr_update() as
> the IPB is only used for VP-specific target, whereas the PIPR always
> needs to be updated.
>
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
> ---
>  include/hw/ppc/xive.h      | 19 +++++++-
>  include/hw/ppc/xive_regs.h | 20 +++++++--
>  hw/intc/xive.c             | 90 +++++++++++++++++++++++---------------
>  hw/intc/xive2.c            | 18 ++++----
>  hw/intc/trace-events       |  2 +-
>  5 files changed, 100 insertions(+), 49 deletions(-)
>
> diff --git a/include/hw/ppc/xive.h b/include/hw/ppc/xive.h
> index 31242f0406..27ef6c1a17 100644
> --- a/include/hw/ppc/xive.h
> +++ b/include/hw/ppc/xive.h
> @@ -510,6 +510,21 @@ static inline uint8_t xive_priority_to_ipb(uint8_t p=
riority)
>          0 : 1 << (XIVE_PRIORITY_MAX - priority);
>  }
> =20
> +static inline uint8_t xive_priority_to_pipr(uint8_t priority)
> +{
> +    return priority > XIVE_PRIORITY_MAX ? 0xFF : priority;
> +}
> +
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
> @@ -532,8 +547,10 @@ void xive_tctx_pic_print_info(XiveTCTX *tctx, GStrin=
g *buf);
>  Object *xive_tctx_create(Object *cpu, XivePresenter *xptr, Error **errp)=
;
>  void xive_tctx_reset(XiveTCTX *tctx);
>  void xive_tctx_destroy(XiveTCTX *tctx);
> -void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t ring, uint8_t ipb);
> +void xive_tctx_pipr_update(XiveTCTX *tctx, uint8_t ring, uint8_t priorit=
y,
> +                           uint8_t group_level);
>  void xive_tctx_reset_signal(XiveTCTX *tctx, uint8_t ring);
> +void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring, uint8_t group_level)=
;
> =20
>  /*
>   * KVM XIVE device helpers
> diff --git a/include/hw/ppc/xive_regs.h b/include/hw/ppc/xive_regs.h
> index 326327fc79..b455728c9c 100644
> --- a/include/hw/ppc/xive_regs.h
> +++ b/include/hw/ppc/xive_regs.h
> @@ -146,7 +146,14 @@
>  #define TM_SPC_PULL_PHYS_CTX_OL 0xc38   /* Pull phys ctx to odd cache li=
ne    */
>  /* XXX more... */
> =20
> -/* NSR fields for the various QW ack types */
> +/*
> + * NSR fields for the various QW ack types
> + *
> + * P10 has an extra bit in QW3 for the group level instead of the
> + * reserved 'i' bit. Since it is not used and we don't support group
> + * interrupts on P9, we use the P10 definition for the group level so
> + * that we can have common macros for the NSR
> + */
>  #define TM_QW0_NSR_EB           PPC_BIT8(0)
>  #define TM_QW1_NSR_EO           PPC_BIT8(0)
>  #define TM_QW3_NSR_HE           PPC_BITMASK8(0, 1)
> @@ -154,8 +161,15 @@
>  #define  TM_QW3_NSR_HE_POOL     1
>  #define  TM_QW3_NSR_HE_PHYS     2
>  #define  TM_QW3_NSR_HE_LSI      3
> -#define TM_QW3_NSR_I            PPC_BIT8(2)
> -#define TM_QW3_NSR_GRP_LVL      PPC_BIT8(3, 7)
> +#define TM_NSR_GRP_LVL          PPC_BITMASK8(2, 7)
> +/*
> + * On P10, the format of the 6-bit group level is: 2 bits for the
> + * crowd size and 4 bits for the group size. Since group/crowd size is
> + * always a power of 2, we encode the log. For example, group_level=3D4
> + * means crowd size =3D 0 and group size =3D 16 (2^4)
> + * Same encoding is used in the NVP and NVGC structures for
> + * PGoFirst and PGoNext fields
> + */
> =20
>  /*
>   * EAS (Event Assignment Structure)
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index efcb63e8aa..bacf518fa6 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -27,16 +27,6 @@
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
> -
>  static uint8_t exception_mask(uint8_t ring)
>  {
>      switch (ring) {
> @@ -87,10 +77,17 @@ static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint=
8_t ring)
> =20
>          regs[TM_CPPR] =3D cppr;
> =20
> -        /* Reset the pending buffer bit */
> -        alt_regs[TM_IPB] &=3D ~xive_priority_to_ipb(cppr);
> +        /*
> +         * If the interrupt was for a specific VP, reset the pending
> +         * buffer bit, otherwise clear the logical server indicator
> +         */
> +        if (regs[TM_NSR] & TM_NSR_GRP_LVL) {
> +            regs[TM_NSR] &=3D ~TM_NSR_GRP_LVL;
> +        } else {
> +            alt_regs[TM_IPB] &=3D ~xive_priority_to_ipb(cppr);
> +        }
> =20
> -        /* Drop Exception bit */
> +        /* Drop the exception bit */
>          regs[TM_NSR] &=3D ~mask;

NSR can just be set to 0 directly instead of clearing masks.

> =20
>          trace_xive_tctx_accept(tctx->cs->cpu_index, alt_ring,
> @@ -101,7 +98,7 @@ static uint64_t xive_tctx_accept(XiveTCTX *tctx, uint8=
_t ring)
>      return ((uint64_t)nsr << 8) | regs[TM_CPPR];
>  }
> =20
> -static void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring)
> +void xive_tctx_notify(XiveTCTX *tctx, uint8_t ring, uint8_t group_level)
>  {
>      /* HV_POOL ring uses HV_PHYS NSR, CPPR and PIPR registers */
>      uint8_t alt_ring =3D (ring =3D=3D TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS :=
 ring;
> @@ -111,13 +108,13 @@ static void xive_tctx_notify(XiveTCTX *tctx, uint8_=
t ring)
>      if (alt_regs[TM_PIPR] < alt_regs[TM_CPPR]) {
>          switch (ring) {
>          case TM_QW1_OS:
> -            regs[TM_NSR] |=3D TM_QW1_NSR_EO;
> +            regs[TM_NSR] =3D TM_QW1_NSR_EO | (group_level & 0x3F);
>              break;
>          case TM_QW2_HV_POOL:
> -            alt_regs[TM_NSR] =3D (TM_QW3_NSR_HE_POOL << 6);
> +            alt_regs[TM_NSR] =3D (TM_QW3_NSR_HE_POOL << 6) | (group_leve=
l & 0x3F);
>              break;
>          case TM_QW3_HV_PHYS:
> -            regs[TM_NSR] |=3D (TM_QW3_NSR_HE_PHYS << 6);
> +            regs[TM_NSR] =3D (TM_QW3_NSR_HE_PHYS << 6) | (group_level & =
0x3F);
>              break;
>          default:
>              g_assert_not_reached();


The big difference between presenting group and VP directed is that
VP can just be queued up in IPB, whereas group can not be, and must
be redistributed before they are precluded by a different interrupt.
So I wonder if we should assert if there is an existing group interrupt
in NSR being overwritten at this point.

Also should we be masking the group level here? Maybe just assert the
top 2 bits are clear, otherwise something has gone wrong if this is
chopping off bits here.

> @@ -159,7 +156,7 @@ static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_=
t ring, uint8_t cppr)
>       * Recompute the PIPR based on local pending interrupts.  The PHYS
>       * ring must take the minimum of both the PHYS and POOL PIPR values.
>       */
> -    pipr_min =3D ipb_to_pipr(regs[TM_IPB]);
> +    pipr_min =3D xive_ipb_to_pipr(regs[TM_IPB]);
>      ring_min =3D ring;
> =20
>      /* PHYS updates also depend on POOL values */
> @@ -169,7 +166,7 @@ static void xive_tctx_set_cppr(XiveTCTX *tctx, uint8_=
t ring, uint8_t cppr)
>          /* POOL values only matter if POOL ctx is valid */
>          if (pool_regs[TM_WORD2] & 0x80) {
> =20
> -            uint8_t pool_pipr =3D ipb_to_pipr(pool_regs[TM_IPB]);
> +            uint8_t pool_pipr =3D xive_ipb_to_pipr(pool_regs[TM_IPB]);
> =20
>              /*
>               * Determine highest priority interrupt and

Moving this function and changing ipb->pipr (before adding group) could
be split into its own patch, since the mechanical changes seem to be
the biggest part, would make the group change simpler to see.

> @@ -185,17 +182,27 @@ static void xive_tctx_set_cppr(XiveTCTX *tctx, uint=
8_t ring, uint8_t cppr)
>      regs[TM_PIPR] =3D pipr_min;
> =20
>      /* CPPR has changed, check if we need to raise a pending exception *=
/
> -    xive_tctx_notify(tctx, ring_min);
> +    xive_tctx_notify(tctx, ring_min, 0);
>  }
> =20
> -void xive_tctx_ipb_update(XiveTCTX *tctx, uint8_t ring, uint8_t ipb)
> -{
> +void xive_tctx_pipr_update(XiveTCTX *tctx, uint8_t ring, uint8_t priorit=
y,
> +                           uint8_t group_level)
> + {
> +    /* HV_POOL ring uses HV_PHYS NSR, CPPR and PIPR registers */
> +    uint8_t alt_ring =3D (ring =3D=3D TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS :=
 ring;
> +    uint8_t *alt_regs =3D &tctx->regs[alt_ring];
>      uint8_t *regs =3D &tctx->regs[ring];
> =20
> -    regs[TM_IPB] |=3D ipb;
> -    regs[TM_PIPR] =3D ipb_to_pipr(regs[TM_IPB]);
> -    xive_tctx_notify(tctx, ring);
> -}
> +    if (group_level =3D=3D 0) {
> +        /* VP-specific */
> +        regs[TM_IPB] |=3D xive_priority_to_ipb(priority);
> +        alt_regs[TM_PIPR] =3D xive_ipb_to_pipr(regs[TM_IPB]);
> +    } else {
> +        /* VP-group */
> +        alt_regs[TM_PIPR] =3D xive_priority_to_pipr(priority);
> +    }
> +    xive_tctx_notify(tctx, ring, group_level);
> + }
> =20
>  /*
>   * XIVE Thread Interrupt Management Area (TIMA)
> @@ -411,13 +418,13 @@ static void xive_tm_set_os_lgs(XivePresenter *xptr,=
 XiveTCTX *tctx,
>  }
> =20
>  /*
> - * Adjust the IPB to allow a CPU to process event queues of other
> + * Adjust the PIPR to allow a CPU to process event queues of other
>   * priorities during one physical interrupt cycle.
>   */
>  static void xive_tm_set_os_pending(XivePresenter *xptr, XiveTCTX *tctx,
>                                     hwaddr offset, uint64_t value, unsign=
ed size)
>  {
> -    xive_tctx_ipb_update(tctx, TM_QW1_OS, xive_priority_to_ipb(value & 0=
xff));
> +    xive_tctx_pipr_update(tctx, TM_QW1_OS, value & 0xff, 0);
>  }
> =20
>  static void xive_os_cam_decode(uint32_t cam, uint8_t *nvt_blk,
> @@ -495,16 +502,20 @@ static void xive_tctx_need_resend(XiveRouter *xrtr,=
 XiveTCTX *tctx,
>          /* Reset the NVT value */
>          nvt.w4 =3D xive_set_field32(NVT_W4_IPB, nvt.w4, 0);
>          xive_router_write_nvt(xrtr, nvt_blk, nvt_idx, &nvt, 4);
> -    }
> +
> +        uint8_t *regs =3D &tctx->regs[TM_QW1_OS];
> +        regs[TM_IPB] |=3D ipb;
> +}
> +

Whitespace damage here?

>      /*
> -     * Always call xive_tctx_ipb_update(). Even if there were no
> +     * Always call xive_tctx_pipr_update(). Even if there were no
>       * escalation triggered, there could be a pending interrupt which
>       * was saved when the context was pulled and that we need to take
>       * into account by recalculating the PIPR (which is not
>       * saved/restored).
>       * It will also raise the External interrupt signal if needed.
>       */
> -    xive_tctx_ipb_update(tctx, TM_QW1_OS, ipb);
> +    xive_tctx_pipr_update(tctx, TM_QW1_OS, 0xFF, 0); /* fxb */

I don't understand what's going on here. Why not ipb_to_pipr(ipb)?

>  }
> =20
>  /*
> @@ -841,9 +852,9 @@ void xive_tctx_reset(XiveTCTX *tctx)
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
> @@ -1660,6 +1671,12 @@ static uint32_t xive_tctx_hw_cam_line(XivePresente=
r *xptr, XiveTCTX *tctx)
>      return xive_nvt_cam_line(blk, 1 << 7 | (pir & 0x7f));
>  }
> =20
> +static uint8_t xive_get_group_level(uint32_t nvp_index)
> +{
> +    /* FIXME add crowd encoding */
> +    return ctz32(~nvp_index) + 1;
> +}
> +
>  /*
>   * The thread context register words are in big-endian format.
>   */
> @@ -1745,6 +1762,7 @@ bool xive_presenter_notify(XiveFabric *xfb, uint8_t=
 format,
>  {
>      XiveFabricClass *xfc =3D XIVE_FABRIC_GET_CLASS(xfb);
>      XiveTCTXMatch match =3D { .tctx =3D NULL, .ring =3D 0 };
> +    uint8_t group_level;
>      int count;
> =20
>      /*
> @@ -1758,9 +1776,9 @@ bool xive_presenter_notify(XiveFabric *xfb, uint8_t=
 format,
> =20
>      /* handle CPU exception delivery */
>      if (count) {
> -        trace_xive_presenter_notify(nvt_blk, nvt_idx, match.ring);
> -        xive_tctx_ipb_update(match.tctx, match.ring,
> -                             xive_priority_to_ipb(priority));
> +        group_level =3D cam_ignore ? xive_get_group_level(nvt_idx) : 0;
> +        trace_xive_presenter_notify(nvt_blk, nvt_idx, match.ring, group_=
level);
> +        xive_tctx_pipr_update(match.tctx, match.ring, priority, group_le=
vel);
>      }
> =20
>      return !!count;
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 4adc3b6950..db372f4b30 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -564,8 +564,10 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr=
, XiveTCTX *tctx,
>                                     uint8_t nvp_blk, uint32_t nvp_idx,
>                                     bool do_restore)
>  {
> +    uint8_t ipb, backlog_level;
> +    uint8_t backlog_prio;
> +    uint8_t *regs =3D &tctx->regs[TM_QW1_OS];
>      Xive2Nvp nvp;
> -    uint8_t ipb;

Put the uint8_ts all on the same line or keep them all on different
lines?

Thanks,
Nick

> =20
>      /*
>       * Grab the associated thread interrupt context registers in the
> @@ -594,15 +596,15 @@ static void xive2_tctx_need_resend(Xive2Router *xrt=
r, XiveTCTX *tctx,
>          nvp.w2 =3D xive_set_field32(NVP2_W2_IPB, nvp.w2, 0);
>          xive2_router_write_nvp(xrtr, nvp_blk, nvp_idx, &nvp, 2);
>      }
> +    regs[TM_IPB] =3D ipb;
> +    backlog_prio =3D xive_ipb_to_pipr(ipb);
> +    backlog_level =3D 0;
> +
>      /*
> -     * Always call xive_tctx_ipb_update(). Even if there were no
> -     * escalation triggered, there could be a pending interrupt which
> -     * was saved when the context was pulled and that we need to take
> -     * into account by recalculating the PIPR (which is not
> -     * saved/restored).
> -     * It will also raise the External interrupt signal if needed.
> +     * Compute the PIPR based on the restored state.
> +     * It will raise the External interrupt signal if needed.
>       */
> -    xive_tctx_ipb_update(tctx, TM_QW1_OS, ipb);
> +    xive_tctx_pipr_update(tctx, TM_QW1_OS, backlog_prio, backlog_level);
>  }
> =20
>  /*
> diff --git a/hw/intc/trace-events b/hw/intc/trace-events
> index 3dcf147198..7435728c51 100644
> --- a/hw/intc/trace-events
> +++ b/hw/intc/trace-events
> @@ -282,7 +282,7 @@ xive_router_end_notify(uint8_t end_blk, uint32_t end_=
idx, uint32_t end_data) "EN
>  xive_router_end_escalate(uint8_t end_blk, uint32_t end_idx, uint8_t esc_=
blk, uint32_t esc_idx, uint32_t end_data) "END 0x%02x/0x%04x -> escalate EN=
D 0x%02x/0x%04x data 0x%08x"
>  xive_tctx_tm_write(uint32_t index, uint64_t offset, unsigned int size, u=
int64_t value) "target=3D%d @0x%"PRIx64" sz=3D%d val=3D0x%" PRIx64
>  xive_tctx_tm_read(uint32_t index, uint64_t offset, unsigned int size, ui=
nt64_t value) "target=3D%d @0x%"PRIx64" sz=3D%d val=3D0x%" PRIx64
> -xive_presenter_notify(uint8_t nvt_blk, uint32_t nvt_idx, uint8_t ring) "=
found NVT 0x%x/0x%x ring=3D0x%x"
> +xive_presenter_notify(uint8_t nvt_blk, uint32_t nvt_idx, uint8_t ring, u=
int8_t group_level) "found NVT 0x%x/0x%x ring=3D0x%x group_level=3D%d"
>  xive_end_source_read(uint8_t end_blk, uint32_t end_idx, uint64_t addr) "=
END 0x%x/0x%x @0x%"PRIx64
> =20
>  # pnv_xive.c


