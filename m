Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2E0CC021B3
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 02:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmOdA-0008ME-2M; Sun, 23 Feb 2025 21:55:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmOd5-0008Ko-Jy; Sun, 23 Feb 2025 21:55:35 -0500
Received: from mail-vk1-xa2e.google.com ([2607:f8b0:4864:20::a2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1tmOd3-00011W-Qk; Sun, 23 Feb 2025 21:55:35 -0500
Received: by mail-vk1-xa2e.google.com with SMTP id
 71dfb90a1353d-5209cd689fcso796049e0c.1; 
 Sun, 23 Feb 2025 18:55:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1740365732; x=1740970532; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ncW+7KYjB+qtcOguuQtGiTg6DkZoCWE0n0vy7Rzppmo=;
 b=NImSouebtxNPEpNvMwg862iHIkV53dCGVYzOxL8mAx/vZ7HKQxdSGIHaIw9Etx3/xA
 Ld0MLJPeSmDE/7YfeResjaaYb12qnQnB9FO2+y+AMEwuT+3k0OfD16MkDq1aKRo5Lq1B
 ArgwnSN+1+xvamL7OLzcJ/wl1UTKd9MyMuBv9LORe/qBhA9DuXqxUUYu7+lXev8ycLQV
 EWLr6z/oQ8wslC47XWF1fLuJRLPNZyX35jcY0d9X6fEKaLz2Z9xecmCZBnGelrE5Wo8W
 X6rXUcCiAaelEUT2CL5ytrxz18wkar/NvQq71cDwiIM3S+RVCEYbIiF/yyuhZ5oAomTU
 3YBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740365732; x=1740970532;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ncW+7KYjB+qtcOguuQtGiTg6DkZoCWE0n0vy7Rzppmo=;
 b=rE7cp+VKlfVlpkqGmzYFTfipaTcvoDvCWts2PBzMltgNQbSDay2jTCeFhqpCKCgJ84
 hAPvp1OAeQ2DTlYueB5KwmKu+NzfNVf2J0dfwPNmD6+DwEqBwyNDKN5dA3xJerfomXRA
 yCXRRztt+bI7618sSjdQ/7bhqDGPypkLURmiNyZgFN4LFzYIwORUgeLC12mT5DE2UJEx
 EJE/V6p4bfipdwQwpV30iHv9dR9AdhkF5dR/1pMWzebhf14ymm1vvk3pWvmuqenVPOyU
 mj79e5YJux6PFlRTokuSsnR04KRHs+PBG02eu52UYNwi4zoZKjhX6o8dgSGNT+qt2zjo
 hJJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCt2ZJSVxDgIqdeWzQ8TQwwLxW2zQZfXcdzquTqTDCt2WiGwwumsx+dIZA+JyaOct0IwJLHYyBQwH3@nongnu.org
X-Gm-Message-State: AOJu0YwtbHxdVZy/J9aaA7i56utuVqzKyb05KGk64oiaAQEFJLoEiZmK
 XZOopqdUj97TvCPRJX0OhNniM6SqtSE+L0pDEYXw7LQOA6MjgT9eZ2/eTLyzHMzieofZQOJYRpj
 sVZ/c5blUGtYmAeW/teVxY6j2R/w=
X-Gm-Gg: ASbGnctW5Xqe23iGpUDjNMkhAb1cJip4Gb4np3QSlLmKQgpaZfN9IFTjqF1c1n7finG
 N35rFQEZHO+LMVXrQFvlN44hm0926HM8Nz/XWwMq2lYtwjyH8Elq8RB5J8AZUuMwzr1/+1rKSst
 NS8OYnPAwAd1SKxzJSG/DHaPzshVV9F6uI1eWn
X-Google-Smtp-Source: AGHT+IEEv5VtRelR8Mng40MPznYg2oeJyLFmYp8C9B6mdDL06fWEdsjGXgqU0jvRtA8nzThV1OGrpHw/lhVy8m0SSP0=
X-Received: by 2002:a05:6122:8b04:b0:515:4b68:c37f with SMTP id
 71dfb90a1353d-521efca4450mr5490982e0c.6.1740365731728; Sun, 23 Feb 2025
 18:55:31 -0800 (PST)
MIME-Version: 1.0
References: <20241205133003.184581-1-dbarboza@ventanamicro.com>
 <20241205133003.184581-6-dbarboza@ventanamicro.com>
In-Reply-To: <20241205133003.184581-6-dbarboza@ventanamicro.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 24 Feb 2025 12:55:05 +1000
X-Gm-Features: AWEUYZkF_QMGkHsfRW7FVshj3iL1UuMvv2oOHVSww3fVDAektx2D7nTf-oWy8qY
Message-ID: <CAKmqyKNNJn38v22AEuZo2CkDUDMAaFuyPmyL0dtKcZ2uxPdXtQ@mail.gmail.com>
Subject: Re: [PATCH for-10.0 05/11] hw/riscv/riscv-iommu: instantiate hpm_timer
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 bmeng@tinylab.org, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 palmer@rivosinc.com, Tomasz Jeznach <tjeznach@rivosinc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a2e;
 envelope-from=alistair23@gmail.com; helo=mail-vk1-xa2e.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Thu, Dec 5, 2024 at 11:35=E2=80=AFPM Daniel Henrique Barboza
<dbarboza@ventanamicro.com> wrote:
>
> From: Tomasz Jeznach <tjeznach@rivosinc.com>
>
> The next HPM related changes requires the HPM overflow timer to be
> initialized by the riscv-iommu base emulation.
>
> Signed-off-by: Tomasz Jeznach <tjeznach@rivosinc.com>
> Signed-off-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

Acked-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/riscv/riscv-iommu-hpm.c | 36 ++++++++++++++++++++++++++++++++++++
>  hw/riscv/riscv-iommu-hpm.h |  1 +
>  hw/riscv/riscv-iommu.c     |  3 +++
>  hw/riscv/riscv-iommu.h     |  2 ++
>  4 files changed, 42 insertions(+)
>
> diff --git a/hw/riscv/riscv-iommu-hpm.c b/hw/riscv/riscv-iommu-hpm.c
> index 8eca5ee17e..325088333e 100644
> --- a/hw/riscv/riscv-iommu-hpm.c
> +++ b/hw/riscv/riscv-iommu-hpm.c
> @@ -166,3 +166,39 @@ void riscv_iommu_hpm_incr_ctr(RISCVIOMMUState *s, RI=
SCVIOMMUContext *ctx,
>          hpm_incr_ctr(s, ctr_idx);
>      }
>  }
> +
> +/* Timer callback for cycle counter overflow. */
> +void riscv_iommu_hpm_timer_cb(void *priv)
> +{
> +    RISCVIOMMUState *s =3D priv;
> +    const uint32_t inhibit =3D riscv_iommu_reg_get32(
> +        s, RISCV_IOMMU_REG_IOCOUNTINH);
> +    uint32_t ovf;
> +
> +    if (get_field(inhibit, RISCV_IOMMU_IOCOUNTINH_CY)) {
> +        return;
> +    }
> +
> +    if (s->irq_overflow_left > 0) {
> +        uint64_t irq_trigger_at =3D
> +            qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) + s->irq_overflow_left=
;
> +        timer_mod_anticipate_ns(s->hpm_timer, irq_trigger_at);
> +        s->irq_overflow_left =3D 0;
> +        return;
> +    }
> +
> +    ovf =3D riscv_iommu_reg_get32(s, RISCV_IOMMU_REG_IOCOUNTOVF);
> +    if (!get_field(ovf, RISCV_IOMMU_IOCOUNTOVF_CY)) {
> +        /*
> +         * We don't need to set hpmcycle_val to zero and update hpmcycle=
_prev to
> +         * current clock value. The way we calculate iohpmcycs will over=
flow
> +         * and return the correct value. This avoids the need to synchro=
nize
> +         * timer callback and write callback.
> +         */
> +        riscv_iommu_reg_mod32(s, RISCV_IOMMU_REG_IOCOUNTOVF,
> +            RISCV_IOMMU_IOCOUNTOVF_CY, 0);
> +        riscv_iommu_reg_mod64(s, RISCV_IOMMU_REG_IOHPMCYCLES,
> +            RISCV_IOMMU_IOHPMCYCLES_OVF, 0);
> +        riscv_iommu_notify(s, RISCV_IOMMU_INTR_PM);
> +    }
> +}
> diff --git a/hw/riscv/riscv-iommu-hpm.h b/hw/riscv/riscv-iommu-hpm.h
> index 411d869dce..cd896d3b7c 100644
> --- a/hw/riscv/riscv-iommu-hpm.h
> +++ b/hw/riscv/riscv-iommu-hpm.h
> @@ -25,5 +25,6 @@
>  uint64_t riscv_iommu_hpmcycle_read(RISCVIOMMUState *s);
>  void riscv_iommu_hpm_incr_ctr(RISCVIOMMUState *s, RISCVIOMMUContext *ctx=
,
>                                unsigned event_id);
> +void riscv_iommu_hpm_timer_cb(void *priv);
>
>  #endif
> diff --git a/hw/riscv/riscv-iommu.c b/hw/riscv/riscv-iommu.c
> index 5ce0d24359..2ec388ff3d 100644
> --- a/hw/riscv/riscv-iommu.c
> +++ b/hw/riscv/riscv-iommu.c
> @@ -2281,6 +2281,8 @@ static void riscv_iommu_realize(DeviceState *dev, E=
rror **errp)
>      address_space_init(&s->trap_as, &s->trap_mr, "riscv-iommu-trap-as");
>
>      if (s->cap & RISCV_IOMMU_CAP_HPM) {
> +        s->hpm_timer =3D
> +            timer_new_ns(QEMU_CLOCK_VIRTUAL, riscv_iommu_hpm_timer_cb, s=
);
>          s->hpm_event_ctr_map =3D g_hash_table_new(g_direct_hash, g_direc=
t_equal);
>      }
>  }
> @@ -2294,6 +2296,7 @@ static void riscv_iommu_unrealize(DeviceState *dev)
>
>      if (s->cap & RISCV_IOMMU_CAP_HPM) {
>          g_hash_table_unref(s->hpm_event_ctr_map);
> +        timer_free(s->hpm_timer);
>      }
>  }
>
> diff --git a/hw/riscv/riscv-iommu.h b/hw/riscv/riscv-iommu.h
> index a21ab51491..6ddc59f474 100644
> --- a/hw/riscv/riscv-iommu.h
> +++ b/hw/riscv/riscv-iommu.h
> @@ -88,8 +88,10 @@ struct RISCVIOMMUState {
>      QLIST_HEAD(, RISCVIOMMUSpace) spaces;
>
>      /* HPM cycle counter */
> +    QEMUTimer *hpm_timer;
>      uint64_t hpmcycle_val;      /* Current value of cycle register */
>      uint64_t hpmcycle_prev;     /* Saved value of QEMU_CLOCK_VIRTUAL clo=
ck */
> +    uint64_t irq_overflow_left; /* Value beyond INT64_MAX after overflow=
 */
>
>      /* HPM event counters */
>      GHashTable *hpm_event_ctr_map; /* Mapping of events to counters */
> --
> 2.47.1
>
>

