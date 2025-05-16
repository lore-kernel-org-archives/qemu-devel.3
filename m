Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B67CC2D0CD
	for <qemu-devel@archiver.kernel.org>; Fri, 16 May 2025 00:19:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFinC-0000AF-4n; Thu, 15 May 2025 20:19:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFinB-00009y-6o; Thu, 15 May 2025 20:19:13 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1uFin6-0003lp-DO; Thu, 15 May 2025 20:19:12 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-74248a3359fso1694390b3a.2; 
 Thu, 15 May 2025 17:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1747354747; x=1747959547; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2PV9gfiYKXOIm4Ch8bjBdiEjmBWp/VnjAVTsV//e3vo=;
 b=f+2F3fZHKWuRFPYxQQK//Gn3yHsgG/vpqYuncKXt4iJaN4k3VoJbQmNr6LauL6n3SK
 AnncsqPyrLIXd8odov2ZS/Ow8MWisbfXeU/LLeLihgaLiGcjlJmWweZrHIxPFi3biARq
 YoATv6Wgg2tRoC5cy1QyY3hK19PN1D536xvxgy1Gb4ZURgQcXSGPcBdtx1L3KyawFXPC
 0NGH6YeKuZD9bj0OH/QzZbC8iBF+NyXtkyMMGCC4kckRNhwUifEDQ/jn9mgWL19xg84z
 hc3AiQXvUbIx+VZHSrdEpFe3hZq0TbIzc/MUwPH/KqpaVCAE1qhwhuMU5DiFF0OsYf8/
 thLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747354747; x=1747959547;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=2PV9gfiYKXOIm4Ch8bjBdiEjmBWp/VnjAVTsV//e3vo=;
 b=V62rfY3gQJY2KUt0iJqVLYlrSlq4g5fhtlYf2HxMhpBxcLywh46pSMb5MlKS54eC5R
 bOpS322kzlZiKut+MiAMgG4Mx9VqGN19B1H3bMHCBRzZB6yDaAUFXvHmG0MnxwIkukcK
 kg7Ya5WClF8U9x+Z2b76XgFY4t5H08a1THYp3rk5YtEk+0amXpmLumNHvATV+uPNnG/7
 Q+HjXT6L+heE15KgInlXD7U1rDyflG4X0ym3WODb0aDkHqNYt0+Bn/kwgZiN/Z5UkmcV
 XTlBa03FRcmK5n5WntCYtOKcoJoIBniVZWQtW6yykL+dE2ba46sXm0vL2nCOgVicx2sE
 2q+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWvkowX72pE49EeQ3jNejTq10bZcIQmcQnKt3xxdKCx4GlahS8nmlH4ExIS1DXpU0bDkyehs2f9Nw==@nongnu.org
X-Gm-Message-State: AOJu0YwcKBaKaV90S2yWzBSFkc3TEDgBXjfeCYA3pNYALnTctf1/t5sn
 3/6Bl9KX6A+sEymfgOXkaexDKwG+zot/+LAc4fL26UgLkqNQeXcI4tsZ
X-Gm-Gg: ASbGnctdMUWg404SFuSqOfuVwzbnb3dG3lNN2uvRAMxxyK4hknKS2StByKn9ma0hgED
 v0Z5Qbm7BCUWUqq+w84OePBxF56/JaAj17RGfsmUaGMnQ9bU8X6wRVBbxZT8O0ILnTmPvioDvwu
 aGMXv2OBhjSHTXCpJtMyrPCm+/k5VA73Th8OkCjniHpxsAJRztGHzOdPUPzfEebwimSz73EF5EC
 TKqY3B8eEInARTguwzrhrFKjlza3oxylSr7NFDQtycGh50kDRS/rlPY9DI+5RJHkdu1KAQLhIGj
 2nTV3JWxXkGuIawD6/kwCwFyK8ScSGx5bNj0sLfYG4HQPTY=
X-Google-Smtp-Source: AGHT+IHfV7TGXKk9Z1SdIDbFM+Pg0xdauentAv0NU0jk4V+sWtGkm2kuSOHcsd31Nr8LSth6mWjklA==
X-Received: by 2002:a05:6a00:464f:b0:742:9d65:d00e with SMTP id
 d2e1a72fcca58-742a97a1746mr1617621b3a.7.1747354746612; 
 Thu, 15 May 2025 17:19:06 -0700 (PDT)
Received: from localhost ([118.209.229.237]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-742a970bd2asm396936b3a.44.2025.05.15.17.19.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 May 2025 17:19:06 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 16 May 2025 10:19:01 +1000
Message-Id: <D9X5K6DXZNQR.3H2QMK607KTCP@gmail.com>
Cc: <qemu-devel@nongnu.org>, =?utf-8?q?Fr=C3=A9d=C3=A9ric_Barrat?=
 <fbarrat@linux.ibm.com>, "Glenn Miles" <milesg@linux.ibm.com>, "Michael
 Kowal" <kowal@linux.ibm.com>, "Caleb Schlossin" <calebs@linux.vnet.ibm.com>
Subject: Re: [PATCH 22/50] ppc/xive2: Support redistribution of group
 interrupts
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Nicholas Piggin" <npiggin@gmail.com>, <qemu-ppc@nongnu.org>
X-Mailer: aerc 0.19.0
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-23-npiggin@gmail.com>
In-Reply-To: <20250512031100.439842-23-npiggin@gmail.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=npiggin@gmail.com; helo=mail-pf1-x429.google.com
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

On Mon May 12, 2025 at 1:10 PM AEST, Nicholas Piggin wrote:
> From: Glenn Miles <milesg@linux.ibm.com>
>
> When an XIVE context is pulled while it has an active, unacknowledged
> group interrupt, XIVE will check to see if a context on another thread
> can handle the interrupt and, if so, notify that context.  If there
> are no contexts that can handle the interrupt, then the interrupt is
> added to a backlog and XIVE will attempt to escalate the interrupt,
> if configured to do so, allowing the higher privileged handler to
> activate a context that can handle the original interrupt.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

>
> Signed-off-by: Glenn Miles <milesg@linux.ibm.com>
> ---
>  hw/intc/xive2.c             | 84 +++++++++++++++++++++++++++++++++++--
>  include/hw/ppc/xive2_regs.h |  3 ++
>  2 files changed, 83 insertions(+), 4 deletions(-)
>
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 0993e792cc..34fc561c9c 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -19,6 +19,10 @@
>  #include "hw/ppc/xive2_regs.h"
>  #include "trace.h"
> =20
> +static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
> +                                    uint32_t end_idx, uint32_t end_data,
> +                                    bool redistribute);
> +
>  uint32_t xive2_router_get_config(Xive2Router *xrtr)
>  {
>      Xive2RouterClass *xrc =3D XIVE2_ROUTER_GET_CLASS(xrtr);
> @@ -597,6 +601,68 @@ static uint32_t xive2_tctx_hw_cam_line(XivePresenter=
 *xptr, XiveTCTX *tctx)
>      return xive2_nvp_cam_line(blk, 1 << tid_shift | (pir & tid_mask));
>  }
> =20
> +static void xive2_redistribute(Xive2Router *xrtr, XiveTCTX *tctx,
> +                               uint8_t nvp_blk, uint32_t nvp_idx, uint8_=
t ring)
> +{
> +    uint8_t nsr =3D tctx->regs[ring + TM_NSR];
> +    uint8_t crowd =3D NVx_CROWD_LVL(nsr);
> +    uint8_t group =3D NVx_GROUP_LVL(nsr);
> +    uint8_t nvgc_blk;
> +    uint8_t nvgc_idx;
> +    uint8_t end_blk;
> +    uint32_t end_idx;
> +    uint8_t pipr =3D tctx->regs[ring + TM_PIPR];
> +    Xive2Nvgc nvgc;
> +    uint8_t prio_limit;
> +    uint32_t cfg;
> +
> +    /* convert crowd/group to blk/idx */
> +    if (group > 0) {
> +        nvgc_idx =3D (nvp_idx & (0xffffffff << group)) |
> +                   ((1 << (group - 1)) - 1);
> +    } else {
> +        nvgc_idx =3D nvp_idx;
> +    }
> +
> +    if (crowd > 0) {
> +        crowd =3D (crowd =3D=3D 3) ? 4 : crowd;
> +        nvgc_blk =3D (nvp_blk & (0xffffffff << crowd)) |
> +                   ((1 << (crowd - 1)) - 1);
> +    } else {
> +        nvgc_blk =3D nvp_blk;
> +    }
> +
> +    /* Use blk/idx to retrieve the NVGC */
> +    if (xive2_router_get_nvgc(xrtr, crowd, nvgc_blk, nvgc_idx, &nvgc)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: no %s %x/%x\n",
> +                      crowd ? "NVC" : "NVG", nvgc_blk, nvgc_idx);
> +        return;
> +    }
> +
> +    /* retrieve the END blk/idx from the NVGC */
> +    end_blk =3D xive_get_field32(NVGC2_W1_END_BLK, nvgc.w1);
> +    end_idx =3D xive_get_field32(NVGC2_W1_END_IDX, nvgc.w1);
> +
> +    /* determine number of priorities being used */
> +    cfg =3D xive2_router_get_config(xrtr);
> +    if (cfg & XIVE2_EN_VP_GRP_PRIORITY) {
> +        prio_limit =3D 1 << GETFIELD(NVGC2_W1_PSIZE, nvgc.w1);
> +    } else {
> +        prio_limit =3D 1 << GETFIELD(XIVE2_VP_INT_PRIO, cfg);
> +    }
> +
> +    /* add priority offset to end index */
> +    end_idx +=3D pipr % prio_limit;
> +
> +    /* trigger the group END */
> +    xive2_router_end_notify(xrtr, end_blk, end_idx, 0, true);
> +
> +    /* clear interrupt indication for the context */
> +    tctx->regs[ring + TM_NSR] =3D 0;
> +    tctx->regs[ring + TM_PIPR] =3D tctx->regs[ring + TM_CPPR];
> +    xive_tctx_reset_signal(tctx, ring);
> +}
> +
>  static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr, XiveTCTX *tctx,
>                                    hwaddr offset, unsigned size, uint8_t =
ring)
>  {
> @@ -608,6 +674,7 @@ static uint64_t xive2_tm_pull_ctx(XivePresenter *xptr=
, XiveTCTX *tctx,
>      uint8_t cur_ring;
>      bool valid;
>      bool do_save;
> +    uint8_t nsr;
> =20
>      xive2_cam_decode(cam, &nvp_blk, &nvp_idx, &valid, &do_save);
> =20
> @@ -624,6 +691,12 @@ static uint64_t xive2_tm_pull_ctx(XivePresenter *xpt=
r, XiveTCTX *tctx,
>          memcpy(&tctx->regs[cur_ring + TM_WORD2], &ringw2_new, 4);
>      }
> =20
> +    /* Active group/crowd interrupts need to be redistributed */
> +    nsr =3D tctx->regs[ring + TM_NSR];
> +    if (xive_nsr_indicates_group_exception(ring, nsr)) {
> +        xive2_redistribute(xrtr, tctx, nvp_blk, nvp_idx, ring);
> +    }
> +
>      if (xive2_router_get_config(xrtr) & XIVE2_VP_SAVE_RESTORE && do_save=
) {
>          xive2_tctx_save_ctx(xrtr, tctx, nvp_blk, nvp_idx, ring);
>      }
> @@ -1352,7 +1425,8 @@ static bool xive2_router_end_es_notify(Xive2Router =
*xrtr, uint8_t end_blk,
>   * message has the same parameters than in the function below.
>   */
>  static void xive2_router_end_notify(Xive2Router *xrtr, uint8_t end_blk,
> -                                    uint32_t end_idx, uint32_t end_data)
> +                                    uint32_t end_idx, uint32_t end_data,
> +                                    bool redistribute)
>  {
>      Xive2End end;
>      uint8_t priority;
> @@ -1380,7 +1454,7 @@ static void xive2_router_end_notify(Xive2Router *xr=
tr, uint8_t end_blk,
>          return;
>      }
> =20
> -    if (xive2_end_is_enqueue(&end)) {
> +    if (!redistribute && xive2_end_is_enqueue(&end)) {
>          xive2_end_enqueue(&end, end_data);
>          /* Enqueuing event data modifies the EQ toggle and index */
>          xive2_router_write_end(xrtr, end_blk, end_idx, &end, 1);
> @@ -1560,7 +1634,8 @@ do_escalation:
>          xive2_router_end_notify(xrtr,
>                                 xive_get_field32(END2_W4_END_BLOCK,     e=
nd.w4),
>                                 xive_get_field32(END2_W4_ESC_END_INDEX, e=
nd.w4),
> -                               xive_get_field32(END2_W5_ESC_END_DATA,  e=
nd.w5));
> +                               xive_get_field32(END2_W5_ESC_END_DATA,  e=
nd.w5),
> +                               false);
>      } /* end END adaptive escalation */
> =20
>      else {
> @@ -1641,7 +1716,8 @@ void xive2_notify(Xive2Router *xrtr , uint32_t lisn=
, bool pq_checked)
>      xive2_router_end_notify(xrtr,
>                              xive_get_field64(EAS2_END_BLOCK, eas.w),
>                              xive_get_field64(EAS2_END_INDEX, eas.w),
> -                            xive_get_field64(EAS2_END_DATA,  eas.w));
> +                            xive_get_field64(EAS2_END_DATA,  eas.w),
> +                            false);
>      return;
>  }
> =20
> diff --git a/include/hw/ppc/xive2_regs.h b/include/hw/ppc/xive2_regs.h
> index 2c535ec0d0..e222038143 100644
> --- a/include/hw/ppc/xive2_regs.h
> +++ b/include/hw/ppc/xive2_regs.h
> @@ -224,6 +224,9 @@ typedef struct Xive2Nvgc {
>  #define NVGC2_W0_VALID             PPC_BIT32(0)
>  #define NVGC2_W0_PGONEXT           PPC_BITMASK32(26, 31)
>          uint32_t        w1;
> +#define NVGC2_W1_PSIZE             PPC_BITMASK32(0, 1)
> +#define NVGC2_W1_END_BLK           PPC_BITMASK32(4, 7)
> +#define NVGC2_W1_END_IDX           PPC_BITMASK32(8, 31)
>          uint32_t        w2;
>          uint32_t        w3;
>          uint32_t        w4;


