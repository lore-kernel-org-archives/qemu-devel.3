Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFA08C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2024 13:34:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s939A-0007Fe-5W; Mon, 20 May 2024 09:33:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s9397-0007Es-SI
 for qemu-devel@nongnu.org; Mon, 20 May 2024 09:33:45 -0400
Received: from mail-lf1-x12a.google.com ([2a00:1450:4864:20::12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s9394-0004X4-Mp
 for qemu-devel@nongnu.org; Mon, 20 May 2024 09:33:45 -0400
Received: by mail-lf1-x12a.google.com with SMTP id
 2adb3069b0e04-52327368e59so4791191e87.1
 for <qemu-devel@nongnu.org>; Mon, 20 May 2024 06:33:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716212020; x=1716816820; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/xhUt7Ys5fiocTW2IHLmuS2NWIIF3Fg1f5heled7zrM=;
 b=UqDLfwdSinJ9fQZ3cSZFkJZT5lJdwZSev8Jii7dnsYOs8TlaBKnRS2N/s6qhDbuaxB
 pd72QX469YJ6YMoqJBJxHQGts/n8VQRrv8Xsyyf+Xl4iaOLyi7Lta8YIQp315Thrjrm0
 MvQG8lyyo+C99QERhb+k3CjyFsdwum+q52tBzg71OEI70bXlJiZzbdHlbWr/2ZanmI+q
 68cQaSGXny3MY4oBBvcrj4iSInD12vB2g4odyBjg/M9jQfEtdJZe5DJhCKczKQAlmW48
 MXj4+iEK/p870kb2N1xNF/Tn4SlDo8n2ihDdttmrloO5yMenE/3vs7b9FPzZVaDY5EHZ
 DnNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716212020; x=1716816820;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/xhUt7Ys5fiocTW2IHLmuS2NWIIF3Fg1f5heled7zrM=;
 b=AVpI4+grGEoY1OiNjjf+ORA6FXpaModWX6C7CTqO8Ly/I0g8mCCA2djXtyrDQZIVhy
 yYbmwv3rWb5NiAJ8ZdBmwuOb+BdoEiJhrpOpgbDGpMLC280RUxi/3g9RzVOWnMJpLqcO
 bniifnybkaPMNnFumGaNNmW/vOaDwkNbgHKAtlVxiIQQY7Q+AhUatAdatBCVs6aQi1tu
 Tri+9NTW3qxKp9ibqRFSdKNqnTzgGKkmQlMifqQJR6vJBACl9ZQtTWNka0GwV+NE7+54
 mcLyQ0HTfSNPcNXn+vg+snDWZKmtKemJbm/VL1yM3kuW8ggPw63UQ+N0CNUJGhHvmSXy
 nlow==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbLWhgxXKnaWur2MOjOPn7MjJZz3aE2KU3KJKe9g/1UR6JyELj0NBmARZAzVkEMecwGrEyACg3/eeR6zlLrJZAW5DSTOM=
X-Gm-Message-State: AOJu0YySBnWh8DcBbYj3kd+3l76WDFC3QbZqQxAdzQCw+Ac0jCsYo1Vx
 noXNosr+kxNbT2TqOHT1kFKAHIdbDLXlG+rN31QLh5Tgll0uBmEonkOLYmMQXhC5cAcCSTEJ7/1
 ieVvRaXxsy0B7NLdqxLWACXBTJTzQ87NeBGaLXg==
X-Google-Smtp-Source: AGHT+IGWNJ1PHTFKreiSNh3r2UzYK6INa6ahvIIRZnW8D38LMI2vmiPQh1bNf6WwhCP9yeWb1G8wCUpa4kDW2j/Kt4Y=
X-Received: by 2002:a05:6512:3990:b0:51a:f1bf:544c with SMTP id
 2adb3069b0e04-5221007483fmr24088259e87.52.1716212020497; Mon, 20 May 2024
 06:33:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA8DAt+o-XZepg8xtj4i3xLW_yChwPnDZVM0O=rW8+9qJQ@mail.gmail.com>
 <20240507130038.86787-2-sebastian.huber@embedded-brains.de>
In-Reply-To: <20240507130038.86787-2-sebastian.huber@embedded-brains.de>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 May 2024 14:33:29 +0100
Message-ID: <CAFEAcA9+uOJ73Ot-1T4P=Uwk-oMBtJxm9ZEHWESXHb3yuZTwPQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/intc/arm_gic: Fix writes to GICD_ITARGETSRn
To: Sebastian Huber <sebastian.huber@embedded-brains.de>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Luc Michel <luc@lmichel.fr>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> According to the GICv2 specification section 4.3.12, "Interrupt Processor
> Targets Registers, GICD_ITARGETSRn":
>
> "Any change to a CPU targets field value:
> [...]
> * Has an effect on any pending interrupts. This means:
>   - adding a CPU interface to the target list of a pending interrupt makes that
>     interrupt pending on that CPU interface
>   - removing a CPU interface from the target list of a pending interrupt
>     removes the pending state of that interrupt on that CPU interface."
>
> Signed-off-by: Sebastian Huber <sebastian.huber@embedded-brains.de>
> ---
>  hw/intc/arm_gic.c | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
> index 20b3f701e0..79aee56053 100644
> --- a/hw/intc/arm_gic.c
> +++ b/hw/intc/arm_gic.c
> @@ -1397,6 +1397,13 @@ static void gic_dist_writeb(void *opaque, hwaddr offset,
>                  value = ALL_CPU_MASK;
>              }
>              s->irq_target[irq] = value & ALL_CPU_MASK;
> +            if (irq >= GIC_INTERNAL && s->irq_state[irq].pending) {
> +                /*
> +                 * Changing the target of an interrupt that is currently
> +                 * pending updates the set of CPUs it is pending on.
> +                 */
> +                GIC_DIST_SET_PENDING(irq, value);

Looking back at the 2021 thread this is the change I suggested then,
but I think I was wrong. This will set the pending bit for the new
specified set of targets, but it won't remove it from any CPUs that
previously were targeted and are not in the new target list (because
GIC_DIST_SET_PENDING does a logical OR into the pending field).
So I think what we want is
                   s->irq_state[irq].pending = value & ALL_CPU_MASK;

> +            }
>          }
>      } else if (offset < 0xf00) {
>          /* Interrupt Configuration.  */
> --

thanks
-- PMM

