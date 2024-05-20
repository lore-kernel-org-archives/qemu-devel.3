Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 902CFC04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 13:28:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9334-0004gl-Bl; Mon, 20 May 2024 09:27:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s932x-0004fR-Ck
 for qemu-devel@nongnu.org; Mon, 20 May 2024 09:27:23 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s932s-00039s-F4
 for qemu-devel@nongnu.org; Mon, 20 May 2024 09:27:22 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5766cd9ca1bso1888576a12.0
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 06:27:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716211636; x=1716816436; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/NlaVpdiQZap65Ll3md9sApNb4qyW0eEV07FMYaw3jk=;
 b=aKLaFpClVVwu/2NdHX/LgPVAy4jej7bZVEgz/uQLR9pDLg6l+hAQ/44ndcypL1rOLX
 8wUIKoah+iUvzsnrVpN/BucyqeZgFTa7+j3qx/D7gmmaHdIdcZ86Ucm4Nkbz0gG9dcF3
 MB6q6s+WNcBfGk+q6+o5V9SPukyK8XzqONYFafwWRHS8uWixwA40MyD9fDW5xYpF28cG
 mB1iy4expKmunpJBs/SpghtdJLHRbHIpScjbB1TyLE76t0wDTiYPt/MNQJy7DnliQ+Hk
 JW720fXLP54MfrPV4/HttOD1qDYFAKbYrnUVQzQHERPhELEKBXSITX0N65QcW8XuJ4ng
 9+Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716211636; x=1716816436;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/NlaVpdiQZap65Ll3md9sApNb4qyW0eEV07FMYaw3jk=;
 b=e+cOM388LJMGYVQ702YXQT/h3McYN6jUYW5dNBOd14teO4LYVLbIYq7BWcZJc76FQW
 TPL4rOSub3oSu/y4dohgA3S+1CezA8yk2WAl+9u8QXNorebIzEZINiqRQ/t2r3Z3RiqL
 cYKa6ABoxMcHGZ1q59Jjs1lGw1mUmYv1gLGP1PyFRtLmbbUx60e37cSn070FcHmjYomE
 YGvJko8cLMe9NUKijlbrgSI5lMgnRof3ABlAg78/9nsdaOalHOyDuhbtQPYxHJNWTbVK
 czTHQLQ2l1Djv0EuOler/tAVi0/djdlf2m9tRuixdzLV+nqLIqXXruNsG4/ZOFrzPDb2
 sEHA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdDjxhIllpH6xhDqZHkJahP0regLE0KeE6g+OOicFozzlyp1IdD+2cCl0/dZHZXhMxWY6mHX1XduTep8GlQOOlEnw9LpA=
X-Gm-Message-State: AOJu0YxnIuSFPu9RosHzIs8fWa/uvIz09YSdRFHF+4dTAQcnj+2PuvpC
 3w3mnPDoBBUqvqp/R39LIcpr8QeJzBqA61x4yGWErahJbNsZ74oSl/wiFbGXLAyqnHwPLEiQNjp
 gU1FnmmqlNxDMvMya1KPaZ1dz1VCOIs6ehGElSwPhLO2iWdre
X-Google-Smtp-Source: AGHT+IFs0+20bAofZpiIcU544qCLrDc5FcUF7DTssIenJ5P4F44TF6NOcJ/aLlUlF4d31L/j4/SWyikd8pP8YjssqcE=
X-Received: by 2002:a50:d5dc:0:b0:572:7319:ab83 with SMTP id
 4fb4d7f45d1cf-5734d5904c1mr21658500a12.6.1716211636514; Mon, 20 May 2024
 06:27:16 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA8DAt+o-XZepg8xtj4i3xLW_yChwPnDZVM0O=rW8+9qJQ@mail.gmail.com>
 <20240507130038.86787-1-sebastian.huber@embedded-brains.de>
In-Reply-To: <20240507130038.86787-1-sebastian.huber@embedded-brains.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 May 2024 14:27:05 +0100
Message-ID: <CAFEAcA-gHrmp2F2CpXRTZbox1KUXGbKs=E5pLZ1obu3BCChS1Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] hw/intc/arm_gic: Fix set pending of PPIs
To: Sebastian Huber <sebastian.huber@embedded-brains.de>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Luc Michel <luc@lmichel.fr>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 7 May 2024 at 14:00, Sebastian Huber
<sebastian.huber@embedded-brains.de> wrote:
>
> According to the GICv2 specification section 4.3.7, "Interrupt Set-Pending
> Registers, GICD_ISPENDRn":
>
> "In a multiprocessor implementation, GICD_ISPENDR0 is banked for each connected
> processor. This register holds the Set-pending bits for interrupts 0-31."

The commit message says it's only changing the handling of
setting the pending bit for a PPI, but...

> Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
> ---
>  hw/intc/arm_gic.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
> index 4da5326ed6..20b3f701e0 100644
> --- a/hw/intc/arm_gic.c
> +++ b/hw/intc/arm_gic.c
> @@ -1296,12 +1296,14 @@ static void gic_dist_writeb(void *opaque, hwaddr offset,
>
>          for (i = 0; i < 8; i++) {
>              if (value & (1 << i)) {
> +                int cm = (irq < GIC_INTERNAL) ? (1 << cpu) : ALL_CPU_MASK;
> +
>                  if (s->security_extn && !attrs.secure &&
>                      !GIC_DIST_TEST_GROUP(irq + i, 1 << cpu)) {
>                      continue; /* Ignore Non-secure access of Group0 IRQ */
>                  }
>
> -                GIC_DIST_SET_PENDING(irq + i, GIC_DIST_TARGET(irq + i));
> +                GIC_DIST_SET_PENDING(irq + i, cm);

... the patch changes also the handling of set-pending for
SPIs (which previously were marked pending on the target CPU
and are now marked pending on all CPUs).

Looking back at the thread from your 2021 patch this was also
noted in that version as being wrong:
https://lore.kernel.org/qemu-devel/20210725080817.ivlkutnow7sojoyd@sekoia-pc.home.lmichel.fr/

PS: for multi-patch patches please can you send also a cover
letter? Our automated tooling gets confused if there isn't one.
It looks also like you sent these respins of these patches as
followups to the thread of the original patch you sent back in
2021. Can you send new versions of patches as their own threads,
please (and with a "PATCH v2" (v3, etc) tag if they're respins?

thanks
-- PMM

