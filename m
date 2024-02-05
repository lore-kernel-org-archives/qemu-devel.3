Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE1BC48286
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 00:22:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rWmkP-0006ai-S4; Sun, 04 Feb 2024 19:22:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWmkO-0006aI-Hg; Sun, 04 Feb 2024 19:22:04 -0500
Received: from mail-ua1-x931.google.com ([2607:f8b0:4864:20::931])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alistair23@gmail.com>)
 id 1rWmkM-0002pW-DC; Sun, 04 Feb 2024 19:22:04 -0500
Received: by mail-ua1-x931.google.com with SMTP id
 a1e0cc1a2514c-7d2e15193bbso1998646241.0; 
 Sun, 04 Feb 2024 16:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1707092520; x=1707697320; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hw9KILQWzk0umDd3OPOGWXUnnnWHtkraqxiMosTIYfo=;
 b=HhudK6ElM98/olDmxWu8AocgOwjkMxNFsipVAcSNt9pm0a7W4bFGZX7xOsQ52vOX1o
 aCP0JALDfqch1wzLukwYPMRwX2LhMtdS/tcbeuYBfrPZJ2bu0ETe9X33ctC5Mp1K+tiO
 L1pWvZXROeK1yGnAzVThqrNlE3XI9tBLLs7A01s30HHH4iU3d++F3e1OTLAZZ09GasgP
 t212LWnVmIWm38ObqAWSn4xSuJNIk490dYsO7okq+qvK34jVZAK7NpS2jYWt/SGWJyvP
 KrjBArwXv/QkqPY0vVqivpdReDo1AArefehPI13v1LgOuvVxiJAJhV0rktDHLh/oiJLR
 KM/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707092520; x=1707697320;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hw9KILQWzk0umDd3OPOGWXUnnnWHtkraqxiMosTIYfo=;
 b=UcKDDbp38xO/E2T9PmKE/9mbq5rqMTdW5UbCM1FpzI1RTNRbN7uhVrbu/GP1s0OABu
 mn+l1qHmbjk1vaVdpDGfqWPa0vLdFPBZwHqmi4Vq8MgEcf3/7aMQC07/3CI8w4FcYEox
 LBgRC0M66GAygAlZKgp0Xk052Irg/CZVBzpp6MQbYlc3DoE0sF6fRuOHYJp9UKEXDNnx
 NTTpFyu4OeerKjqcfAVW1XGv0RV17Wy9UGVOELGM9U3y17pPMrDh4B/5kDtGmq8/eYSC
 cLCNO4a9H019GbQcsUC8zjYVNdwDoYUPNOn3RixtuU2a2MfNhWczzpJ4dPrE2Ct4Tx7v
 goeQ==
X-Gm-Message-State: AOJu0YwX1Zu/quIEXXf4JCAjwnLzJxjUBvy7E23ZbxsvWhvXsCg13WrI
 FgVDNdnAeB1cwIDXZpNoHWlQwKR+I9cgfhI92JVpPtilIzzazTS7ISK5MTcTdMB1EH03JMu0bq+
 Uuk4Pobkd2Tvg1bBhCijg3OB1URXOQIA/zwg=
X-Google-Smtp-Source: AGHT+IH/Gf4mkkopBnzmJlvhlHVMhJ6NXP4YiruCxgUVVZQCXBtjVnSDy5b+/S5gvQYbjPgiLuCI5gsBpTGKEYF/cbk=
X-Received: by 2002:a05:6102:3b91:b0:46d:310a:7c99 with SMTP id
 z17-20020a0561023b9100b0046d310a7c99mr623587vsu.28.1707092520502; Sun, 04 Feb
 2024 16:22:00 -0800 (PST)
MIME-Version: 1.0
References: <20240130110945.486-1-zhiwei_liu@linux.alibaba.com>
In-Reply-To: <20240130110945.486-1-zhiwei_liu@linux.alibaba.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 5 Feb 2024 10:21:34 +1000
Message-ID: <CAKmqyKM2SaaKRO9VU4n43uz1jisBuyYEG9UbXyhMVi-Tx9zwcw@mail.gmail.com>
Subject: Re: [PATCH] target/riscv: FCSR doesn't contain vxrm and vxsat
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>
Cc: qemu-devel@nongnu.org, Alistair.Francis@wdc.com, palmer@dabbelt.com, 
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com, 
 qemu-riscv@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::931;
 envelope-from=alistair23@gmail.com; helo=mail-ua1-x931.google.com
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

On Tue, Jan 30, 2024 at 9:10=E2=80=AFPM LIU Zhiwei <zhiwei_liu@linux.alibab=
a.com> wrote:
>
> vxrm and vxsat have been moved into a special register vcsr since
> RVV v1.0. So remove them from FCSR for vector 1.0.
>
> Signed-off-by: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>

Thanks!

Applied to riscv-to-apply.next

Alistair

> ---
>  target/riscv/cpu_bits.h | 8 --------
>  1 file changed, 8 deletions(-)
>
> diff --git a/target/riscv/cpu_bits.h b/target/riscv/cpu_bits.h
> index ebd7917d49..e116f6c252 100644
> --- a/target/riscv/cpu_bits.h
> +++ b/target/riscv/cpu_bits.h
> @@ -32,14 +32,6 @@
>  #define FSR_NXA             (FPEXC_NX << FSR_AEXC_SHIFT)
>  #define FSR_AEXC            (FSR_NVA | FSR_OFA | FSR_UFA | FSR_DZA | FSR=
_NXA)
>
> -/* Vector Fixed-Point round model */
> -#define FSR_VXRM_SHIFT      9
> -#define FSR_VXRM            (0x3 << FSR_VXRM_SHIFT)
> -
> -/* Vector Fixed-Point saturation flag */
> -#define FSR_VXSAT_SHIFT     8
> -#define FSR_VXSAT           (0x1 << FSR_VXSAT_SHIFT)
> -
>  /* Control and Status Registers */
>
>  /* User Trap Setup */
> --
> 2.25.1
>
>

