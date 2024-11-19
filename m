Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F2BCD60CEF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2024 04:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tDFjD-00032N-5j; Mon, 18 Nov 2024 23:20:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tDFjB-00031c-E6; Mon, 18 Nov 2024 23:20:37 -0500
Received: from mail-oo1-xc32.google.com ([2607:f8b0:4864:20::c32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tDFj9-0006wL-Mg; Mon, 18 Nov 2024 23:20:37 -0500
Received: by mail-oo1-xc32.google.com with SMTP id
 006d021491bc7-5ee9e209bb6so208027eaf.0; 
 Mon, 18 Nov 2024 20:20:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731990033; x=1732594833; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eyh/6ey5dwVGpoZOA8crYPv8c/+uT0OL9wQAPmf2WMg=;
 b=JJJsCXovGtbbj7ckSVSy32tvjvljxmH6IckYWguXVKyM08mnA3eVtnWm75AoTzZypl
 eAKMN2rXxy+A2VIW0aJmdav3UV08eopvEOYeQgLeing7hnJMz2BrH6ZjNSUdZzZmRrzD
 m8e/xQQ5DJZfh51JA8rgG66KP37eSNT+IV3YcZRRtdo3UBgFYkZUVhsbEiA8/a/rFY23
 trdqn3dhFG2+MMcrprlV+PZHIO/mtPPuJ2d/wa3QgeIO+IebPsgEMj6B8IVFodBmKeUM
 8q/dnXJYkh51Szyg2XjhXL4BKQeFOY8O59tn/7Y3oycPLo4Ry8qX4jnlyoavWAVT8Ki+
 /m9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731990033; x=1732594833;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=eyh/6ey5dwVGpoZOA8crYPv8c/+uT0OL9wQAPmf2WMg=;
 b=Bm4L6PMF4ZfyCcLvLeMNKEGYfyB8JDnb2zl9IUPj9VNXES54yKKDWxIEOBzRyYxX5x
 1GWC8v90qxOmQXqEGXuETQK0nojYVcbEAoLuTQrY+7OIDxvnkQEwyjOQ0GeCxA4o9OzT
 jgPAh3RFQJUjg/dk/R+tHVJdoekpbd+5iQeOsmNR27f0ToM2wxIEqOlzVnoN/e90Nsdu
 A5SUAbu/DJH5N0OdUh+QXXWRRdZItntOt9uHbehNH/DvRvXOS5WnRBArJ2/z1Ii0uwLc
 V6tbJsz8evMt7d/+RIvvBlROiTcX5tgYoRimsQ8BxBFuvEQi2jjgZOgrFHseOztDSQ46
 bx8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEe+pL4/gwQN7eUEaHuwQK2yx2hJbckWH9dWrSsFT9HARl5dd8kTEaQqNrvgT2328AUdjAWEGYNDMK@nongnu.org
X-Gm-Message-State: AOJu0YyPI0Hl34oH7BrH5nMGRm7DP3QqcLBXtwrZUH1kN1q+kFpwLY9k
 mo7EuYS3X955qRGgtmqQO0T5kgrfqM49BlZIIo2KXd+XKtHRAbTU
X-Google-Smtp-Source: AGHT+IFTOp2pwFBHxiwu88LOUWtAMebDXfNRtJ9uLftaQO2Fl8Xf2+tqLuYh0wFryI/nBKhJfgDtww==
X-Received: by 2002:a05:6870:514e:b0:277:7147:26ff with SMTP id
 586e51a60fabf-2962e2899d8mr14017666fac.35.1731990033410; 
 Mon, 18 Nov 2024 20:20:33 -0800 (PST)
Received: from localhost (124-171-72-210.tpgi.com.au. [124.171.72.210])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7f8c1c644b1sm6672669a12.42.2024.11.18.20.20.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2024 20:20:32 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Tue, 19 Nov 2024 14:20:25 +1000
Message-Id: <D5PV81KUWVZR.2RN5ASJJK7JJU@gmail.com>
Cc: <qemu-ppc@nongnu.org>, <clg@kaod.org>, <fbarrat@linux.ibm.com>,
 <milesg@linux.ibm.com>, <danielhb413@gmail.com>,
 <david@gibson.dropbear.id.au>, <harshpb@linux.ibm.com>, <thuth@redhat.com>,
 <lvivier@redhat.com>, <pbonzini@redhat.com>
Subject: Re: [PATCH 05/14] ppc/xive2: Process group backlog when pushing an
 OS context
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Michael Kowal" <kowal@linux.ibm.com>, <qemu-devel@nongnu.org>
X-Mailer: aerc 0.18.2
References: <20241015211329.21113-1-kowal@linux.ibm.com>
 <20241015211329.21113-6-kowal@linux.ibm.com>
In-Reply-To: <20241015211329.21113-6-kowal@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::c32;
 envelope-from=npiggin@gmail.com; helo=mail-oo1-xc32.google.com
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
> When pushing an OS context, we were already checking if there was a
> pending interrupt in the IPB and sending a notification if needed.  We
> also need to check if there is a pending group interrupt stored in the
> NVG table. To avoid useless backlog scans, we only scan if the NVP
> belongs to a group.
>
> Signed-off-by: Frederic Barrat <fbarrat@linux.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
> ---
>  hw/intc/xive2.c | 100 ++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 97 insertions(+), 3 deletions(-)
>
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index a6dc6d553f..7130892482 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -279,6 +279,85 @@ static void xive2_end_enqueue(Xive2End *end, uint32_=
t data)
>      end->w1 =3D xive_set_field32(END2_W1_PAGE_OFF, end->w1, qindex);
>  }
> =20
> +/*
> + * Scan the group chain and return the highest priority and group
> + * level of pending group interrupts.
> + */
> +static uint8_t xive2_presenter_backlog_check(XivePresenter *xptr,
> +                                             uint8_t nvp_blk, uint32_t n=
vp_idx,
> +                                             uint8_t first_group,
> +                                             uint8_t *out_level)

Could we call that xive2_presenter_backlog_scan(), which I think
matches how the specification refers to it.

Thanks,
Nick

> +{
> +    Xive2Router *xrtr =3D XIVE2_ROUTER(xptr);
> +    uint32_t nvgc_idx, mask;
> +    uint32_t current_level, count;
> +    uint8_t prio;
> +    Xive2Nvgc nvgc;
> +
> +    for (prio =3D 0; prio <=3D XIVE_PRIORITY_MAX; prio++) {
> +        current_level =3D first_group & 0xF;
> +
> +        while (current_level) {
> +            mask =3D (1 << current_level) - 1;
> +            nvgc_idx =3D nvp_idx & ~mask;
> +            nvgc_idx |=3D mask >> 1;
> +            qemu_log("fxb %s checking backlog for prio %d group idx %x\n=
",
> +                     __func__, prio, nvgc_idx);
> +
> +            if (xive2_router_get_nvgc(xrtr, false, nvp_blk, nvgc_idx, &n=
vgc)) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVG %x/%x\n",
> +                              nvp_blk, nvgc_idx);
> +                return 0xFF;
> +            }
> +            if (!xive2_nvgc_is_valid(&nvgc)) {
> +                qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid NVG %x/%x\=
n",
> +                              nvp_blk, nvgc_idx);
> +                return 0xFF;
> +            }
> +
> +            count =3D xive2_nvgc_get_backlog(&nvgc, prio);
> +            if (count) {
> +                *out_level =3D current_level;
> +                return prio;
> +            }
> +            current_level =3D xive_get_field32(NVGC2_W0_PGONEXT, nvgc.w0=
) & 0xF;
> +        }
> +    }
> +    return 0xFF;
> +}
> +
> +static void xive2_presenter_backlog_decr(XivePresenter *xptr,
> +                                         uint8_t nvp_blk, uint32_t nvp_i=
dx,
> +                                         uint8_t group_prio,
> +                                         uint8_t group_level)
> +{
> +    Xive2Router *xrtr =3D XIVE2_ROUTER(xptr);
> +    uint32_t nvgc_idx, mask, count;
> +    Xive2Nvgc nvgc;
> +
> +    group_level &=3D 0xF;
> +    mask =3D (1 << group_level) - 1;
> +    nvgc_idx =3D nvp_idx & ~mask;
> +    nvgc_idx |=3D mask >> 1;
> +
> +    if (xive2_router_get_nvgc(xrtr, false, nvp_blk, nvgc_idx, &nvgc)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: No NVG %x/%x\n",
> +                      nvp_blk, nvgc_idx);
> +        return;
> +    }
> +    if (!xive2_nvgc_is_valid(&nvgc)) {
> +        qemu_log_mask(LOG_GUEST_ERROR, "XIVE: Invalid NVG %x/%x\n",
> +                      nvp_blk, nvgc_idx);
> +        return;
> +    }
> +    count =3D xive2_nvgc_get_backlog(&nvgc, group_prio);
> +    if (!count) {
> +        return;
> +    }
> +    xive2_nvgc_set_backlog(&nvgc, group_prio, count - 1);
> +    xive2_router_write_nvgc(xrtr, false, nvp_blk, nvgc_idx, &nvgc);
> +}
> +
>  /*
>   * XIVE Thread Interrupt Management Area (TIMA) - Gen2 mode
>   *
> @@ -588,8 +667,9 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr,=
 XiveTCTX *tctx,
>                                     uint8_t nvp_blk, uint32_t nvp_idx,
>                                     bool do_restore)
>  {
> -    uint8_t ipb, backlog_level;
> -    uint8_t backlog_prio;
> +    XivePresenter *xptr =3D XIVE_PRESENTER(xrtr);
> +    uint8_t ipb, backlog_level, group_level, first_group;
> +    uint8_t backlog_prio, group_prio;
>      uint8_t *regs =3D &tctx->regs[TM_QW1_OS];
>      Xive2Nvp nvp;
> =20
> @@ -624,8 +704,22 @@ static void xive2_tctx_need_resend(Xive2Router *xrtr=
, XiveTCTX *tctx,
>      backlog_prio =3D xive_ipb_to_pipr(ipb);
>      backlog_level =3D 0;
> =20
> +    first_group =3D xive_get_field32(NVP2_W0_PGOFIRST, nvp.w0);
> +    if (first_group && regs[TM_LSMFB] < backlog_prio) {
> +        group_prio =3D xive2_presenter_backlog_check(xptr, nvp_blk, nvp_=
idx,
> +                                                   first_group, &group_l=
evel);
> +        regs[TM_LSMFB] =3D group_prio;
> +        if (regs[TM_LGS] && group_prio < backlog_prio) {
> +            /* VP can take a group interrupt */
> +            xive2_presenter_backlog_decr(xptr, nvp_blk, nvp_idx,
> +                                         group_prio, group_level);
> +            backlog_prio =3D group_prio;
> +            backlog_level =3D group_level;
> +        }
> +    }
> +
>      /*
> -     * Compute the PIPR based on the restored state.
> +    * Compute the PIPR based on the restored state.
>       * It will raise the External interrupt signal if needed.
>       */
>      xive_tctx_pipr_update(tctx, TM_QW1_OS, backlog_prio, backlog_level);


