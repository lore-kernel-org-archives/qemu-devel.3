Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D652D68B02
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 12:54:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBZLt-0003Ug-2Y; Thu, 14 Nov 2024 07:53:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBZLr-0003UK-Gl
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 07:53:35 -0500
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tBZLp-0005Uv-Pd
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 07:53:35 -0500
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a9ee097a478so37985166b.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 04:53:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731588812; x=1732193612; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=M3mfTEfKdxOywnm+iZvD8KBR3LErUOlqd1NYZnAjRs4=;
 b=CfkuViUmx4H+oEtCIhnhEKc/8twddwXCa+8sppjAJ9e+LmYcBTpL/p7Lr3TF/gbq7d
 dUuHx5EG1mHXLV885+m+0zZN/SzaycR3cQ6HEQbe37tgWTtD6B0acVSgYF1HwBLql9B4
 0ZUfY7bcc4BdBMpQYUtMusVci6cMHiBjFPh8z3I4pMTP8DMJW3LyiRkejmPNk2C2qtN3
 d7zbmExir8Y0jF0e86RppLjAsvdtfo4zZU4vBFL2mUWwmIj/j4DZ/xWd6qx/Ut60bjbO
 Guy7X01G8CtwEMHS/bG7t4lukQkRDDfrxuGeDqZoYMg3PSbr2B5XzoSTVOvyk2QVjlWL
 YXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731588812; x=1732193612;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M3mfTEfKdxOywnm+iZvD8KBR3LErUOlqd1NYZnAjRs4=;
 b=J5GesDdhaGlC33NJ7VtF/fTMjriRhyPEA3yzyAtUJknDAHqjMzeI8yTuxuMbrDfgz3
 W67EQ34EgxSxFbaCQS9YkalEl2TpdaTR8F/HO/WAYzgWrWGUPby5JFChgNzwVIZCwqcW
 hueWi0uXNFG3VrSMPQr1UsZ/3Usbb19tEPQKkqgitA4vhMO12Iw8zxxfDtaBw6zTSqVe
 1Hztcwj3JhhC377USsVCfweC762BPJGF5zdfl0pSSLHSFEM5Ka3MBTrdvbK35bnNyFXb
 3vhpyBsuRDUVyzR3w9I7ZrVDDmQNLNB8/j65cKhbYBKP80ghANAc6hy2f343i6B9aH6M
 bOdw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1XsndnWxfamFaV9qACkEHbNBJnDZs5suddXBi0OLKHmEKy5s4QNOhODWUKbcL0AaY/kJv36qOLhrz@nongnu.org
X-Gm-Message-State: AOJu0YyoxNs8dXOmaVImzkJKUc+6pVWFfJfqUGjJS85tfK3dJJFAozgX
 fPjLcQxgysIQ6x8a4uf7r1Xrl0uJk50N9GDi8TPl+1F9ICOHEbdE8z5pBPh8xhomX7YnYKoVfoc
 asjMgNwXF5B8QL5ftjxLYH/UV1rpfFF/aC8p5YA==
X-Google-Smtp-Source: AGHT+IGngNrm6IK1avInvkZJQ7DMWks6wKrI6vnWsX/O1tutZvx2H0uPeZ8qfeukQVg2NJ20Z3znBQB26reAmKuneJE=
X-Received: by 2002:a05:6402:510f:b0:5cb:bebb:38d8 with SMTP id
 4fb4d7f45d1cf-5cf77e956f8mr2257317a12.14.1731588812016; Thu, 14 Nov 2024
 04:53:32 -0800 (PST)
MIME-Version: 1.0
References: <20241108191024.2931097-1-roqueh@google.com>
 <20241108191024.2931097-2-roqueh@google.com>
In-Reply-To: <20241108191024.2931097-2-roqueh@google.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Nov 2024 12:53:21 +0000
Message-ID: <CAFEAcA8bWb=PV=R2-UZCDLzkuV-THmNb3yd+BY167B+P+u3JJQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] hw/watchdog/cmsdk_apb_watchdog: Fix INTEN issues
To: Roque Arcudia Hernandez <roqueh@google.com>
Cc: farosas@suse.de, lvivier@redhat.com, slongfield@google.com, 
 komlodi@google.com, pbonzini@redhat.com, venture@google.com, 
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x632.google.com
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

On Fri, 8 Nov 2024 at 19:10, Roque Arcudia Hernandez <roqueh@google.com> wrote:
>
> Current watchdog is free running out of reset, this combined with the
> fact that current implementation also ensures the counter is running
> when programing WDOGLOAD creates issues when the firmware defer the
> programing of WDOGCONTROL.INTEN much later after WDOGLOAD. Arm
> Programmer's Model documentation states that INTEN is also the
> counter enable:
>
> > INTEN
> >
> > Enable the interrupt event, WDOGINT. Set HIGH to enable the counter
> > and the interrupt, or LOW to disable the counter and interrupt.
> > Reloads the counter from the value in WDOGLOAD when the interrupt
> > is enabled, after previously being disabled.
>
> Source of the time of writing:
>
> https://developer.arm.com/documentation/ddi0479/d/apb-components/apb-watchdog/programmers-model

I see that the URL in the current sources
https://developer.arm.com/products/system-design/system-design-kits/cortex-m-system-design-kit
is no longer working -- would you mind including a patch that updates
the URL in the comment at the top of the file to the new one
https://developer.arm.com/documentation/ddi0479/

please?

> Signed-off-by: Roque Arcudia Hernandez <roqueh@google.com>
> Reviewed-by: Stephen Longfield <slongfield@google.com>
> Reviewed-by: Joe Komlodi <komlodi@google.com>
> ---
>  hw/watchdog/cmsdk-apb-watchdog.c | 29 ++++++++++++++++++++++++++---
>  1 file changed, 26 insertions(+), 3 deletions(-)
>
> diff --git a/hw/watchdog/cmsdk-apb-watchdog.c b/hw/watchdog/cmsdk-apb-watchdog.c
> index 7ad46f9410..e6ddc0a53b 100644
> --- a/hw/watchdog/cmsdk-apb-watchdog.c
> +++ b/hw/watchdog/cmsdk-apb-watchdog.c
> @@ -202,10 +202,10 @@ static void cmsdk_apb_watchdog_write(void *opaque, hwaddr offset,
>           */
>          ptimer_transaction_begin(s->timer);
>          ptimer_set_limit(s->timer, value, 1);
> -        ptimer_run(s->timer, 0);
>          ptimer_transaction_commit(s->timer);
>          break;

This looks like a correct change, but the comment just
above here needs to be updated to match it (it currently
says "and make sure we're counting").

Otherwise this change looks good.

-- PMM

