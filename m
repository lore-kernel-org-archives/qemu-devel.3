Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D6CF5C54798
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 04:44:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdNQ7-00057D-Aw; Thu, 22 Feb 2024 23:44:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rdNQ5-00055x-NE; Thu, 22 Feb 2024 23:44:21 -0500
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rdNQ0-0002hU-Cc; Thu, 22 Feb 2024 23:44:21 -0500
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-7d2940ad0e1so307826241.1; 
 Thu, 22 Feb 2024 20:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708663454; x=1709268254; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R2qyJU4UFichwZizbV1c6YZASRQP684XsW5OD9lTT/Q=;
 b=X8swepFMNj4PvaAIOe2sjkj54wEelSN3tCgWljAZwUTLliL1k4ydUXjot1C+HhjNyP
 16QJgOnuvKz5rwzXV+oL1wVPo3Re1klAzK0YpShI8iM/X9Kh8Xm6vnrG7a/1fi1mh/KB
 oRBrx9mgJrxfWJxs1c3q8Ngr+L4WXgMbJ3pYj3yuaTiegMvUeFKeOCzkowK1jCbfuKMF
 Wz0W4ioXWwxhStjUJmt1dnpXXAVJmo6sN+nLV46bQPOJ3aZqlPMppj6LG79LA46LBQNP
 scZl9yzjutsDFGdGiWiT2bcQP6U6S8FL7kgIIXXGV9CapzzESLRzLxmyu5WYLxL3wb53
 q+mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708663454; x=1709268254;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=R2qyJU4UFichwZizbV1c6YZASRQP684XsW5OD9lTT/Q=;
 b=NDFFO/vsbpbq/qQbectgbF4v3E0UKr2bI1UVRRS/4hYjKTed666HY3kqRgMoGnRI93
 6sLZm+wZDOpJH3HGJyE4kV/cXS34XfFpwpiN6taGM932x8gmM0Tps60bRS89V+8XqYp+
 1fzU9TxPURTz20b5SIavNv/I6Knm28BK2BT/vinVYHk73ee+K+UroF5XSPjSiuXh+LzU
 NchIeHFUrrN2tLrGIORhuksFkKiyvrgw+/vuT6K/oJnZvGJkUHYKNPt2Fk+jvBXqVdKA
 6BMy++ch4ywKYlH6vEdl28ZicZaCT0r4elyASOM+eew10tiBQFZ88KDeZksdysF0kZp6
 MVig==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGCZ7NQWBg+UV+DmtwYJea+OIKIyw0zUVgkgVleZCPxCJ/y1RwfGf+CaE0ig6vA8zoGesKlpey7Ze7RUb9avfIpPebPSU=
X-Gm-Message-State: AOJu0Yx7AxACzeupo1QLLr+W5BnLWnva03OvhjiIPhASrF6OpXDdUD9e
 F3u9jm4npdUp5zu12aumD+LW3LExrH7h0yoUufAE/2A1+V2klJIropSxVPe5aHoQ129UTA7PW7L
 OrOkzWDgIBrTtJpokVqiKEAurpVGq9gGDAS0=
X-Google-Smtp-Source: AGHT+IEYeaz6pkcdGgp6AP1LJKKCjHbw8UXny0c8k2zOZUuhEb8s2Pps4I9zCsNsTJH9tXDUzSJqsGLs30xeHdRptX8=
X-Received: by 2002:a1f:ea44:0:b0:4d0:36e3:40c3 with SMTP id
 i65-20020a1fea44000000b004d036e340c3mr990577vkh.13.1708663453998; Thu, 22 Feb
 2024 20:44:13 -0800 (PST)
MIME-Version: 1.0
References: <20240220110907.10479-1-frank.chang@sifive.com>
In-Reply-To: <20240220110907.10479-1-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 23 Feb 2024 14:43:47 +1000
Message-ID: <CAKmqyKPrC6QR8k_PSENwkWiW2=Dyf2-gN=xaqecN5u7-q6ON-A@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: Add missing include guard in pmu.h
To: frank.chang@sifive.com
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::936;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x936.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Feb 20, 2024 at 9:09=E2=80=AFPM <frank.chang@sifive.com> wrote:
>
> From: Frank Chang <frank.chang@sifive.com>
>
> Add missing include guard in pmu.h to avoid the problem of double
> inclusion.
>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/pmu.h | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/target/riscv/pmu.h b/target/riscv/pmu.h
> index 505fc850d3..7c0ad661e0 100644
> --- a/target/riscv/pmu.h
> +++ b/target/riscv/pmu.h
> @@ -16,6 +16,9 @@
>   * this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>
> +#ifndef RISCV_PMU_H
> +#define RISCV_PMU_H
> +
>  #include "cpu.h"
>  #include "qapi/error.h"
>
> @@ -31,3 +34,5 @@ int riscv_pmu_incr_ctr(RISCVCPU *cpu, enum riscv_pmu_ev=
ent_idx event_idx);
>  void riscv_pmu_generate_fdt_node(void *fdt, uint32_t cmask, char *pmu_na=
me);
>  int riscv_pmu_setup_timer(CPURISCVState *env, uint64_t value,
>                            uint32_t ctr_idx);
> +
> +#endif /* RISCV_PMU_H */
> --
> 2.43.0
>
>

