Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5305AD60D1A
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 04:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDFwN-0004PG-GT; Mon, 18 Nov 2024 23:34:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tDFwK-0004Ok-OP; Mon, 18 Nov 2024 23:34:13 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tDFwI-000895-1t; Mon, 18 Nov 2024 23:34:12 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-211fd6a0a9cso3689915ad.3; 
 Mon, 18 Nov 2024 20:34:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731990848; x=1732595648; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NRJeG+XkngYkWa0TyQz7cP5qyWV3iredJ9ga/xPTTbw=;
 b=jKyghyA1GK0tHJWDv2Ra9bq3kXzLTkq/3XgdeAFYYymfZGzawI0OnewbKbLVQGwVJs
 N37EJGNNyhPhT9AJl7Y+inCby8dztO7d1AZvCTNVmQus9Lp4+eH+RLsQ06jy3ddF+ueA
 blhCX0CWjwEat4uNYmyrLSg7fjmDnCwVx2KkvfqtW7lH0Xi75NenRNmINyYXvb7mOS7i
 E2N58fUsHavORyK9cFXzxAZlF7+6MgrddlMGtqirNOfi+xw51S0vjsaem0tDa/vlGy+F
 4R2DxOuyyOh7WA2JeWl5Dfw5UIgiIlN/8jGPvinr8oIiM5BYl5QXJU6cdRgtm7Lb/zMl
 k8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731990848; x=1732595648;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=NRJeG+XkngYkWa0TyQz7cP5qyWV3iredJ9ga/xPTTbw=;
 b=YRtbntxCHIvxds07hgqAa34+SeZxiXMKePryFyivG+bVddlquG8pXekWoNVTYb7CPS
 EFEXi43CVSavP8JTgdme5nF9Ci2wMCSot2sS6Dk1jN7BZ2+G9Fx7eUpeVbKf8AXXy/dr
 LCsw219BU+yIHSAVES1GNribqKcdnPmLAS+cgX8g9SVXV0QCTNwasF2CL2REeYsyEka9
 OvUqQic/RuBPlqmu6vft0V3J/w5FhXZC/PhsMGFxNBNsuaTBnGR3TEqFrejUT73iPqhj
 KwPh6ElUtOdoRwpGLjp+wU4gxswxGsUYg0cL+7U4AMVVxPVRr3aBG+5AKMkdB6ksPOnJ
 hI4w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiA12amuob0dyFvJH069WA35AqcKf/1ybU+co8fw64ubSzE9/LPnJj6IB4IRTANgZ/h2F6E64lLrID@nongnu.org
X-Gm-Message-State: AOJu0YyiHOnX7bzy6a2V3lqobjevnwUkwAaE9Q2V66BYJw+wZ6SthGWO
 ht8QVT3RhvsO41eZUjeai4jDEJ/TM7gGJKVx0WqPuxjdECYNU9iw
X-Google-Smtp-Source: AGHT+IGSUA5mlETpcBC7Er2WyGPPffky2+yh7KrtHPnXGnedXZOcwEOjs7iPFywtxPJO+XQfdqiGjQ==
X-Received: by 2002:a17:903:3a8d:b0:20c:3d9e:5f2b with SMTP id
 d9443c01a7336-211d0ef6d53mr184734265ad.57.1731990848137; 
 Mon, 18 Nov 2024 20:34:08 -0800 (PST)
Received: from localhost (124-171-72-210.tpgi.com.au. [124.171.72.210])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-21253619d4bsm3645945ad.173.2024.11.18.20.34.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 20:34:07 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Nov 2024 14:34:00 +1000
Message-Id: <D5PVIFZABR4L.20XCWB75DIEW@gmail.com>
Cc: <qemu-ppc@nongnu.org>, <clg@kaod.org>, <fbarrat@linux.ibm.com>,
 <milesg@linux.ibm.com>, <danielhb413@gmail.com>,
 <david@gibson.dropbear.id.au>, <harshpb@linux.ibm.com>, <thuth@redhat.com>,
 <lvivier@redhat.com>, <pbonzini@redhat.com>
Subject: Re: [PATCH 06/14] ppc/xive2: Process group backlog when updating
 the CPPR
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Michael Kowal" <kowal@linux.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.18.2
References: <20241015211329.21113-1-kowal@linux.ibm.com>
 <20241015211329.21113-7-kowal@linux.ibm.com>
In-Reply-To: <20241015211329.21113-7-kowal@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x631.google.com
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
> When the hypervisor or OS pushes a new value to the CPPR, if the LSMFB
> value is lower than the new CPPR value, there could be a pending group
> interrupt in the backlog, so it needs to be scanned.
>
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
> ---
>  include/hw/ppc/xive2.h |   4 +
>  hw/intc/xive.c         |   4 +-
>  hw/intc/xive2.c        | 173 ++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 177 insertions(+), 4 deletions(-)
>
> diff --git a/include/hw/ppc/xive2.h b/include/hw/ppc/xive2.h
> index d88db05687..e61b978f37 100644
> --- a/include/hw/ppc/xive2.h
> +++ b/include/hw/ppc/xive2.h
> @@ -115,6 +115,10 @@ typedef struct Xive2EndSource {
>   * XIVE2 Thread Interrupt Management Area (POWER10)
>   */
> =20
> +void xive2_tm_set_hv_cppr(XivePresenter *xptr, XiveTCTX *tctx,
> +                          hwaddr offset, uint64_t value, unsigned size);
> +void xive2_tm_set_os_cppr(XivePresenter *xptr, XiveTCTX *tctx,
> +                          hwaddr offset, uint64_t value, unsigned size);
>  void xive2_tm_push_os_ctx(XivePresenter *xptr, XiveTCTX *tctx, hwaddr of=
fset,
>                             uint64_t value, unsigned size);
>  uint64_t xive2_tm_pull_os_ctx(XivePresenter *xptr, XiveTCTX *tctx,
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index 8ffcac4f65..2aa6e1fecc 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -603,7 +603,7 @@ static const XiveTmOp xive2_tm_operations[] =3D {
>       * MMIOs below 2K : raw values and special operations without side
>       * effects
>       */
> -    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_CPPR,       1, xive_tm_set_os_cppr=
,
> +    { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_CPPR,       1, xive2_tm_set_os_cpp=
r,
>                                                       NULL },
>      { XIVE_TM_HV_PAGE, TM_QW1_OS + TM_WORD2,      4, xive2_tm_push_os_ct=
x,
>                                                       NULL },
> @@ -611,7 +611,7 @@ static const XiveTmOp xive2_tm_operations[] =3D {
>                                                       NULL },
>      { XIVE_TM_OS_PAGE, TM_QW1_OS + TM_LGS,        1, xive_tm_set_os_lgs,
>                                                       NULL },
> -    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, xive_tm_set_hv_cppr=
,
> +    { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, xive2_tm_set_hv_cpp=
r,
>                                                       NULL },
>      { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, xive_tm_vt_push,
>                                                       NULL },
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 7130892482..0c53f71879 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -18,6 +18,7 @@
>  #include "hw/ppc/xive.h"
>  #include "hw/ppc/xive2.h"
>  #include "hw/ppc/xive2_regs.h"
> +#include "trace.h"
> =20
>  uint32_t xive2_router_get_config(Xive2Router *xrtr)
>  {
> @@ -764,6 +765,172 @@ void xive2_tm_push_os_ctx(XivePresenter *xptr, Xive=
TCTX *tctx,
>      }
>  }
> =20
> +static int xive2_tctx_get_nvp_indexes(XiveTCTX *tctx, uint8_t ring,
> +                                      uint32_t *nvp_blk, uint32_t *nvp_i=
dx)
> +{
> +    uint32_t w2, cam;
> +
> +    w2 =3D xive_tctx_word2(&tctx->regs[ring]);
> +    switch (ring) {
> +    case TM_QW1_OS:
> +        if (!(be32_to_cpu(w2) & TM2_QW1W2_VO)) {
> +            return -1;
> +        }
> +        cam =3D xive_get_field32(TM2_QW1W2_OS_CAM, w2);
> +        break;
> +    case TM_QW2_HV_POOL:
> +        if (!(be32_to_cpu(w2) & TM2_QW2W2_VP)) {
> +            return -1;
> +        }
> +        cam =3D xive_get_field32(TM2_QW2W2_POOL_CAM, w2);
> +        break;
> +    case TM_QW3_HV_PHYS:
> +        if (!(be32_to_cpu(w2) & TM2_QW3W2_VT)) {
> +            return -1;
> +        }
> +        cam =3D xive2_tctx_hw_cam_line(tctx->xptr, tctx);
> +        break;
> +    default:
> +        return -1;
> +    }
> +    *nvp_blk =3D xive2_nvp_blk(cam);
> +    *nvp_idx =3D xive2_nvp_idx(cam);
> +    return 0;
> +}
> +
> +static void xive2_tctx_set_cppr(XiveTCTX *tctx, uint8_t ring, uint8_t cp=
pr)

Some of the xive1 code kind of has placeholder for group code or routes
group stuff through to xive2 code, so I wonder if this duplication is
really necessary or it can just be added to xive1?

I kind of hoped we could unify xive1 and 2 more, but maybe it's too late
without a lot more work, and all new development is going to go into
xive2...

Okay for now I guess, we could look at unification one day maybe.

> +{
> +    uint8_t *regs =3D &tctx->regs[ring];
> +    Xive2Router *xrtr =3D XIVE2_ROUTER(tctx->xptr);
> +    uint8_t old_cppr, backlog_prio, first_group, group_level =3D 0;
> +    uint8_t pipr_min, lsmfb_min, ring_min;
> +    bool group_enabled;
> +    uint32_t nvp_blk, nvp_idx;
> +    Xive2Nvp nvp;
> +    int rc;
> +
> +    trace_xive_tctx_set_cppr(tctx->cs->cpu_index, ring,
> +                             regs[TM_IPB], regs[TM_PIPR],
> +                             cppr, regs[TM_NSR]);
> +
> +    if (cppr > XIVE_PRIORITY_MAX) {
> +        cppr =3D 0xff;
> +    }
> +
> +    old_cppr =3D regs[TM_CPPR];
> +    regs[TM_CPPR] =3D cppr;

If CPPR remains the same, can return early.

If CPPR is being increased, this scanning is not required (a
redistribution of group interrupt if it became precluded is
required as noted in the TODO, but no scanning should be needed
so that TODO should be moved up here).

If there is an interrupt already presented and CPPR is being
lowered, nothing needs to be done either (because the presented
interrupt should already be the most favoured).

> +
> +    /*
> +     * Recompute the PIPR based on local pending interrupts. It will
> +     * be adjusted below if needed in case of pending group interrupts.
> +     */
> +    pipr_min =3D xive_ipb_to_pipr(regs[TM_IPB]);
> +    group_enabled =3D !!regs[TM_LGS];
> +    lsmfb_min =3D (group_enabled) ? regs[TM_LSMFB] : 0xff;
> +    ring_min =3D ring;
> +
> +    /* PHYS updates also depend on POOL values */
> +    if (ring =3D=3D TM_QW3_HV_PHYS) {
> +        uint8_t *pregs =3D &tctx->regs[TM_QW2_HV_POOL];
> +
> +        /* POOL values only matter if POOL ctx is valid */
> +        if (pregs[TM_WORD2] & 0x80) {
> +
> +            uint8_t pool_pipr =3D xive_ipb_to_pipr(pregs[TM_IPB]);
> +            uint8_t pool_lsmfb =3D pregs[TM_LSMFB];
> +
> +            /*
> +             * Determine highest priority interrupt and
> +             * remember which ring has it.
> +             */
> +            if (pool_pipr < pipr_min) {
> +                pipr_min =3D pool_pipr;
> +                if (pool_pipr < lsmfb_min) {
> +                    ring_min =3D TM_QW2_HV_POOL;
> +                }
> +            }
> +
> +            /* Values needed for group priority calculation */
> +            if (pregs[TM_LGS] && (pool_lsmfb < lsmfb_min)) {
> +                group_enabled =3D true;
> +                lsmfb_min =3D pool_lsmfb;
> +                if (lsmfb_min < pipr_min) {
> +                    ring_min =3D TM_QW2_HV_POOL;
> +                }
> +            }
> +        }
> +    }
> +    regs[TM_PIPR] =3D pipr_min;
> +
> +    rc =3D xive2_tctx_get_nvp_indexes(tctx, ring_min, &nvp_blk, &nvp_idx=
);
> +    if (rc) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: set CPPR on invalid contex=
t\n");
> +        return;
> +    }
> +
> +    if (cppr < old_cppr) {
> +        /*
> +         * FIXME: check if there's a group interrupt being presented
> +         * and if the new cppr prevents it. If so, then the group
> +         * interrupt needs to be re-added to the backlog and
> +         * re-triggered (see re-trigger END info in the NVGC
> +         * structure)
> +         */
> +    }
> +
> +    if (group_enabled &&
> +        lsmfb_min < cppr &&
> +        lsmfb_min < regs[TM_PIPR]) {
> +        /*
> +         * Thread has seen a group interrupt with a higher priority
> +         * than the new cppr or pending local interrupt. Check the
> +         * backlog
> +         */
> +        if (xive2_router_get_nvp(xrtr, nvp_blk, nvp_idx, &nvp)) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVP %x/%x\n",
> +                          nvp_blk, nvp_idx);
> +            return;
> +        }
> +
> +        if (!xive2_nvp_is_valid(&nvp)) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid NVP %x/%x\n",
> +                          nvp_blk, nvp_idx);
> +            return;
> +        }
> +
> +        first_group =3D xive_get_field32(NVP2_W0_PGOFIRST, nvp.w0);
> +        if (!first_group) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "XIVE: invalid NVP %x/%x\n",
> +                          nvp_blk, nvp_idx);
> +            return;
> +        }
> +
> +        backlog_prio =3D xive2_presenter_backlog_check(tctx->xptr,
> +                                                     nvp_blk, nvp_idx,
> +                                                     first_group, &group=
_level);
> +        tctx->regs[ring_min + TM_LSMFB] =3D backlog_prio;

LSMFB may not be the same as lsmfb_min, so you can't present
unconditionally.

I think after updating, it should test

  if (lsmfb_min !=3D backlog_prio) {
      goto scan_again;
  }

Where scan_again: goes back to recomputing min priorities and scanning.

Thanks,
Nick

> +        if (backlog_prio !=3D 0xFF) {
> +            xive2_presenter_backlog_decr(tctx->xptr, nvp_blk, nvp_idx,
> +                                         backlog_prio, group_level);
> +            regs[TM_PIPR] =3D backlog_prio;
> +        }
> +    }
> +    /* CPPR has changed, check if we need to raise a pending exception *=
/
> +    xive_tctx_notify(tctx, ring_min, group_level);
> +}
> +
> +void xive2_tm_set_hv_cppr(XivePresenter *xptr, XiveTCTX *tctx,
> +                          hwaddr offset, uint64_t value, unsigned size)
> +{
> +    xive2_tctx_set_cppr(tctx, TM_QW3_HV_PHYS, value & 0xff);
> +}
> +
> +void xive2_tm_set_os_cppr(XivePresenter *xptr, XiveTCTX *tctx,
> +                          hwaddr offset, uint64_t value, unsigned size)
> +{
> +    xive2_tctx_set_cppr(tctx, TM_QW1_OS, value & 0xff);
> +}
> +
>  static void xive2_tctx_set_target(XiveTCTX *tctx, uint8_t ring, uint8_t =
target)
>  {
>      uint8_t *regs =3D &tctx->regs[ring];
> @@ -934,7 +1101,9 @@ int xive2_presenter_tctx_match(XivePresenter *xptr, =
XiveTCTX *tctx,
> =20
>  bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring, uint8_t priority)
>  {
> -    uint8_t *regs =3D &tctx->regs[ring];
> +    /* HV_POOL ring uses HV_PHYS NSR, CPPR and PIPR registers */
> +    uint8_t alt_ring =3D (ring =3D=3D TM_QW2_HV_POOL) ? TM_QW3_HV_PHYS :=
 ring;
> +    uint8_t *alt_regs =3D &tctx->regs[alt_ring];
> =20
>      /*
>       * The xive2_presenter_tctx_match() above tells if there's a match
> @@ -942,7 +1111,7 @@ bool xive2_tm_irq_precluded(XiveTCTX *tctx, int ring=
, uint8_t priority)
>       * priority to know if the thread can take the interrupt now or if
>       * it is precluded.
>       */
> -    if (priority < regs[TM_CPPR]) {
> +    if (priority < alt_regs[TM_CPPR]) {
>          return false;
>      }
>      return true;

These last two are logically separate patch for enabling group for POOL?


