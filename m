Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B06C3CA101F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Sep 2025 04:23:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uy0it-00062s-9F; Mon, 15 Sep 2025 00:21:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uy0i9-0005bs-Nk
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 00:21:06 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1uy0i7-0004yz-FJ
 for qemu-devel@nongnu.org; Mon, 15 Sep 2025 00:21:05 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-b042cc3954fso669852166b.0
 for <qemu-devel@nongnu.org>; Sun, 14 Sep 2025 21:20:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1757910056; x=1758514856; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XIscQse6rRzky1C+APHweQPSvau+Qslqmy42YW2bpek=;
 b=ijV/h1kgxnfX/z3z9iyUOWHFRICjY86KUolEg/G5koET9xd5wy0OyvFQAAwV6/Jx/D
 qmxPovXZKCOaz8835t+8YiDHk3fni1evCJ2RQv7P6bo61Lc/6y/J4RuIOFXnp6NiNR31
 WKG1UJCZ4MrvF1QRvrhr44UKisWvDyiEr/WVzFSo2ZlD68WFwYmJ6YhEls+l+kEzKHlT
 Lck2aMBKTTQ20aeGIb0ZX5GmIPxeMKQnF/8G50wU3zOuxm7NVPHohaJM7KWNfhlgy7Ad
 tcucOyXJRqUhWe3oiVU5KbkryYnkZcs5QkJKWDMCAT+5ej54TwuYsBwC7urfPDJ2oyIL
 1aQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757910056; x=1758514856;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=XIscQse6rRzky1C+APHweQPSvau+Qslqmy42YW2bpek=;
 b=PKNm35bXHShVm4adTNhTOZAgKG2Jmb1tfYTWzbbaOZLLCl8smDnD6V0zZ5mM7cDz0R
 tzdwiB1M+MSy0MdFtb9rEY1xI+k3eYa8r5CTGkT4pOVWXV+PnXnzC1Ki+gmZIoS0b3y2
 EEBBbLWCxuT6SRirvU8/W34/VckC/vSdRY4XSHyhvftC6sioRJAyN3XUGbDbzIeiGr0J
 zPHYXwghiPsI359u4eSQInJKsdKk9FmxYAmx8GqHREfqCb8ZuDCzxjZIY2B85smNtOzr
 ozemDo7gW1vwQfbO9pUpPaGkWfxHnKbRVVt8rC9SG+/pJw4ItWSc/6IM6uUA3aoP3U8Q
 aYZg==
X-Gm-Message-State: AOJu0YxXYCM+SEDcpwA/B7SRTparEyNqu7Tl6iAu7aA44Sv6/y4F4aQC
 QWZfh945kOT76CqvUrfTcpwN8sFtvo+QgU3G/lh3aLFehWiI5x7bIal4FcfQW+kAliLDmll7SMj
 d48tq0WWoD1W+/b3q2atsmPqmngSxL5I=
X-Gm-Gg: ASbGncu3zN0esSTQhK6fZ00dcw2Kni2LF7m29xeFVQ6KeZ//SMViEUYflPNhuYs1fCF
 p9jKfLt/FBPNczCePa1uzFT9G0N0tNYxloV3Amkf7pxq5cN0GFxClihHMscKD67zlSiIJbZzWO5
 YI9RCLUWjrNtxZ2BneTSqFnBD1PVQ3UNqws9cIiBxopuUwdl1YpNyo3bXcZIv+9SctLXcWCJs80
 4w2HSf5W93i3wqvPluh3klovfHWQnIJj1sDX11/rWew3e1+
X-Google-Smtp-Source: AGHT+IHZnGx22gHF8feD4z5TF/B1K5J4hFV2n9qy2QITqARZdtg/Jqweq/0oJPWXicn8KCesTPqBkCDAioxGAbev774=
X-Received: by 2002:a17:907:6e9e:b0:b04:aa9d:2240 with SMTP id
 a640c23a62f3a-b07c37dbd64mr1104503866b.39.1757910056446; Sun, 14 Sep 2025
 21:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20250911-timers-v3-0-60508f640050@linux.alibaba.com>
 <20250911-timers-v3-3-60508f640050@linux.alibaba.com>
In-Reply-To: <20250911-timers-v3-3-60508f640050@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 15 Sep 2025 14:20:30 +1000
X-Gm-Features: Ac12FXySeSKkI_XtFQmkUQWYXR10NUbIlpWxKEG52B2vx2iPsxtid5Bpn20qFP4
Message-ID: <CAKmqyKOOoefb+bVs-OwGmor5+qL6HdthUvJbCjBHbubud1iAdQ@mail.gmail.com>
Subject: Re: [PATCH v3 3/4] hw/intc: Save timers array in RISC-V mtimer VMState
To: TANG Tiancheng <lyndra@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 qemu-riscv@nongnu.org, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=alistair23@gmail.com; helo=mail-ej1-x631.google.com
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

On Thu, Sep 11, 2025 at 7:58=E2=80=AFPM TANG Tiancheng <lyndra@linux.alibab=
a.com> wrote:
>
> The current 'timecmp' field in vmstate_riscv_mtimer is insufficient to ke=
ep
> timers functional after migration.
>
> If an mtimer's entry in 'mtimer->timers' is active at the time the snapsh=
ot
> is taken, it means riscv_aclint_mtimer_write_timecmp() has written to
> 'mtimecmp' and scheduled a timer into QEMU's main loop 'timer_list'.
>
> During snapshot save, these active timers must also be migrated; otherwis=
e,
> after snapshot load there is no mechanism to restore 'mtimer->timers' bac=
k
> into the 'timer_list', and any pending timer events would be lost.
>
> QEMU's migration framework commonly uses VMSTATE_TIMER_xxx macros to save
> and restore 'QEMUTimer' variables. However, 'timers' is a pointer array
> with variable length, and vmstate.h did not previously provide a helper
> macro for such type.
>
> This commit adds a new macro, 'VMSTATE_TIMER_PTR_VARRAY', to handle savin=
g
> and restoring a variable-length array of 'QEMUTimer *'. We then use this
> macro to migrate the 'mtimer->timers' array, ensuring that timer events
> remain scheduled correctly after snapshot load.
>
> Reviewed-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
> Signed-off-by: TANG Tiancheng <lyndra@linux.alibaba.com>

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Alistair

> ---
>  hw/intc/riscv_aclint.c         | 6 ++++--
>  include/hw/intc/riscv_aclint.h | 4 ++++
>  2 files changed, 8 insertions(+), 2 deletions(-)
>
> diff --git a/hw/intc/riscv_aclint.c b/hw/intc/riscv_aclint.c
> index 318a9c8248432a8cd4c3f3fa990739917ecf7ca1..9f4c36e965e2aa379d75c0a9f=
656177f0dd82a45 100644
> --- a/hw/intc/riscv_aclint.c
> +++ b/hw/intc/riscv_aclint.c
> @@ -323,13 +323,15 @@ static void riscv_aclint_mtimer_reset_enter(Object =
*obj, ResetType type)
>
>  static const VMStateDescription vmstate_riscv_mtimer =3D {
>      .name =3D "riscv_mtimer",
> -    .version_id =3D 2,
> -    .minimum_version_id =3D 2,
> +    .version_id =3D 3,
> +    .minimum_version_id =3D 3,
>      .fields =3D (const VMStateField[]) {
>              VMSTATE_UINT64(time_delta, RISCVAclintMTimerState),
>              VMSTATE_VARRAY_UINT32(timecmp, RISCVAclintMTimerState,
>                                    num_harts, 0,
>                                    vmstate_info_uint64, uint64_t),
> +            VMSTATE_TIMER_PTR_VARRAY(timers, RISCVAclintMTimerState,
> +                                     num_harts),
>              VMSTATE_END_OF_LIST()
>          }
>  };
> diff --git a/include/hw/intc/riscv_aclint.h b/include/hw/intc/riscv_aclin=
t.h
> index 693415eb6defe4454e5731a681e025f3bac3ad2e..4b7406eec005a06b7c040d848=
3a8790866a39297 100644
> --- a/include/hw/intc/riscv_aclint.h
> +++ b/include/hw/intc/riscv_aclint.h
> @@ -80,4 +80,8 @@ enum {
>      RISCV_ACLINT_SWI_SIZE              =3D 0x4000
>  };
>
> +#define VMSTATE_TIMER_PTR_VARRAY(_f, _s, _f_n)                        \
> +VMSTATE_VARRAY_OF_POINTER_UINT32(_f, _s, _f_n, 0, vmstate_info_timer, \
> +                                                        QEMUTimer *)
> +
>  #endif
>
> --
> 2.43.0
>
>

