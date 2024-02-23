Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F576C48BC4
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Feb 2024 04:44:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rdNPh-0004w3-IM; Thu, 22 Feb 2024 23:43:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rdNPf-0004vg-PG; Thu, 22 Feb 2024 23:43:55 -0500
Received: from mail-ua1-x936.google.com ([2607:f8b0:4864:20::936])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rdNPd-0002cV-UI; Thu, 22 Feb 2024 23:43:55 -0500
Received: by mail-ua1-x936.google.com with SMTP id
 a1e0cc1a2514c-7d5a6b1dd60so154697241.3; 
 Thu, 22 Feb 2024 20:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708663431; x=1709268231; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=haxMd9l7C2HPxjvaECWqQxz5ejMqzV9lc+Z8MlxFLok=;
 b=f+nUS0e0NrnZU1sJD3UECkv2EDwKY+3rIFc5tHg/66WVSX7SHellDcOQOvYTEwAVQB
 wTNa5S2Z9J55wJlT7C0C/Tq7TEbQ7sMUGJjC+dmyd5LpGC22ovzZA4Do2KdbDy4ZJ8bf
 OIyhKOrWiMvGStUTF5u+hrcs45DzyOij0Nu3+fo4CzC++tVR4dCL2eeLzSintE0CIk4m
 Jxauhkk+QwnNvwg42sttYXLUcYsyczyWiDlXmDo5RSIEkff2xI0VvzLPfEFFL5PGn+uZ
 fssZapMnzOaj9kZC4pdQ9u4km1S53FctzyOGah89wzRSRZVZe19HiD393bD72ik68Apd
 bLNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708663431; x=1709268231;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=haxMd9l7C2HPxjvaECWqQxz5ejMqzV9lc+Z8MlxFLok=;
 b=YNsQq06GLh6eIFq9nTzOVfMQm4RJpQtfluhsPRYPUhdBNVy5P+SXH4vkPGm/pOZtGT
 ZItG3jC3uf+O1jJ2Km/M7iCQolrUmYWAiyGLAulrYWfQ9VODCOwXQLvCftYMHCW/nWHg
 xB9iWBe0Xsjcxv6mV9ZpDfEg1/g2BJvRQFrne+iffN9/8sB1jbmsbIdqQ3XgwZ+fShLQ
 etxTL/XumVIJOWuSDeo5LozQiwA4Xlu/zPUsNJPG8JjsSqG+KjBgej9tL4WtZY45OrZM
 KeDR5Ifw+aK0jFpvBlKhXITY7+gSh8rl0Wy1W8Hk7qmm/QdegcCrqxU2AklSKwZv+ny6
 gJCw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBfYoK+UL1FW2DfhBs/vHJ+eJg2Z4+YeK7xJFDhuFI2KDQkhf373UyEcM9odBZF2I9P1QhfFcctc1LlSnXBRFgICkU0hc=
X-Gm-Message-State: AOJu0YyKSaCOL5JFlVyOrDNdDk8/IDWsrYlnkRxHaz2nPwZa2BhjcEJD
 QwyWLsKL7WCqBR/SJhit/QBIyJcy3Bn2WmR5XnaZZeNXn6RJbCABbEZ1SxRfGtNC8+53Dw2CwYC
 BbXxdNZKbjMLKJVfeJkvpxSODi64=
X-Google-Smtp-Source: AGHT+IF5zo8C0ICDMaKroa2hGkpRTuvJDhLSwqxQOyJHQjvMFs0Yt6DE8ZCMok2cc9X2phHjVPFbX49rUvssIAAYInQ=
X-Received: by 2002:a67:cd81:0:b0:470:543d:ddca with SMTP id
 r1-20020a67cd81000000b00470543dddcamr912874vsl.11.1708663431273; Thu, 22 Feb
 2024 20:43:51 -0800 (PST)
MIME-Version: 1.0
References: <20240220110907.10479-1-frank.chang@sifive.com>
In-Reply-To: <20240220110907.10479-1-frank.chang@sifive.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 23 Feb 2024 14:43:25 +1000
Message-ID: <CAKmqyKPn-wsbXeZLSzKshQDN5q2KQZZOQhtJ2ZByV+hJS8SU7A@mail.gmail.com>
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
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

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

