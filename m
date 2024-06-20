Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3576FC27C79
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Jun 2024 10:44:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sKFGj-00053a-2C; Thu, 20 Jun 2024 06:43:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKFGQ-0004rK-8s
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 06:43:35 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sKFGM-0005ir-KI
 for qemu-devel@nongnu.org; Thu, 20 Jun 2024 06:43:33 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-57a4d7ba501so696690a12.2
 for <qemu-devel@nongnu.org>; Thu, 20 Jun 2024 03:43:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718880209; x=1719485009; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=VCHaOBI/pzcWFl4PSGNo6VIcNzZ9wgQjXBKizEWy4ek=;
 b=PodmgwQ++L+Idn51/gD95KMVDkesV9O82RrJaDs0NIK2ciYOiWkgqHs2f8cD1L/qJz
 84cV9QeYnLlkxR2tt3fsoC6rifytvUxR/2Gj6uHyZD9dE/TNfFA34rgLXKadbyW5swkg
 s/vs64ied4zTt/x172/EwVhHLEf66cjFhjfaivUwv07zAcQ8bahqKLrwqJ/lxKZtKUVA
 sVv/3sQAQ14gQmOacOQcprer7CKjiFYOC5TrcVE1sIb8pFtXKc0Q+5caHRpvaq/+MDsk
 5Y5h4rIMN5yrMe0r7aLbH/pwQ7ck0QmH9rgpEqCyeAzejpg2zV7B3K7UvPAsrff9I+7n
 EFIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718880209; x=1719485009;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=VCHaOBI/pzcWFl4PSGNo6VIcNzZ9wgQjXBKizEWy4ek=;
 b=AWaZZE1SVjPMqBfXpW8lb4jXt7zpH5BkUEKT/2P8D2bUwpcpXC4+d5dW4s+WGFUDL/
 ICeVA561NInRzH5/uW6Me+YAG0bjlqrI5EGc8Z1Dh9aV59ZHdz33mTDi//vmWCjWFIu/
 UjJvT4sf93H+Y4vAcyk0Od3FfwnYP43nZ464CcIKYhON9+kwWoE0fV3T0dmp+a9bbBWB
 KYbvh8vhxKJf35LAImWLDZGWIK98UR+N6gPanGOKPgVjpvBb37HiU/c3fsb/K4DsHo4s
 0aSypxz1fM4M9VvHDDkxZVs8X4mzjm1choUCbKnNOvdmk02/QcGHz2PJyZDPSXfeKjE2
 Jhdw==
X-Gm-Message-State: AOJu0YyB5V0LY5niK6kQfTqxctdHrPPycQJFaNz1Ycv99Cf6Vp2GkX0+
 pko1A/egON+dhwxTJ69JtR0ePnTp6OdguMJOj3APCPU5zRdbequ1C5AxyaR3XOaSVhWIpAHq8JI
 M6B6irwey7Pmt2YuOLa0rGCh6cO5fJCbW2mKihw==
X-Google-Smtp-Source: AGHT+IHlHajhGew6hb6CDJS+myMTq399D0C/kt3Pf9YkCJ2NVejDx/snMlzMTRPm6hd6YghS/vqFJoDV3T5GwxqKM20=
X-Received: by 2002:a50:9b15:0:b0:57c:6861:d735 with SMTP id
 4fb4d7f45d1cf-57d07e6b560mr3081170a12.19.1718880208839; Thu, 20 Jun 2024
 03:43:28 -0700 (PDT)
MIME-Version: 1.0
References: <20240615185423.49474-1-florian.lugou@provenrun.com>
In-Reply-To: <20240615185423.49474-1-florian.lugou@provenrun.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jun 2024 11:43:17 +0100
Message-ID: <CAFEAcA_+WrzM4fXQMUxMi3L5yiUWMrUGTSZH=NDdYDKUCP+8NQ@mail.gmail.com>
Subject: Re: [PATCH] target/arm/helper: Fix timer interrupt masking when
 HCR_EL2.E2H == 0
To: Florian Lugou <florian.lugou@provenrun.com>
Cc: qemu-devel@nongnu.org, "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Sat, 15 Jun 2024 at 19:56, Florian Lugou <florian.lugou@provenrun.com> wrote:
>
> CNTHCTL_EL2 based masking of timer interrupts was introduced in
> f6fc36deef6abcee406211f3e2f11ff894b87fa4. This masking was however
> effective no matter whether EL2 was enabled in the current security
> state or not, contrary to arm specification.
>
> Signed-off-by: Florian Lugou <florian.lugou@provenrun.com>
> ---
>  target/arm/helper.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/target/arm/helper.c b/target/arm/helper.c
> index ce31957235..60e2344c68 100644
> --- a/target/arm/helper.c
> +++ b/target/arm/helper.c
> @@ -2684,7 +2684,8 @@ static void gt_update_irq(ARMCPU *cpu, int timeridx)
>       * If bit CNTHCTL_EL2.CNT[VP]MASK is set, it overrides IMASK.
>       * It is RES0 in Secure and NonSecure state.
>       */
> -    if ((ss == ARMSS_Root || ss == ARMSS_Realm) &&
> +    if ((arm_hcr_el2_eff(env) & HCR_E2H) &&
> +        (ss == ARMSS_Root || ss == ARMSS_Realm) &&

When the architecture says "is EL2 enabled in the current security state"
it doesn't mean "is HCR_EL2.E2H set?", it means "is this either NonSecure/Realm
or else is SCR_EL2.EEL2 set?". Compare the pseudocode EL2Enabled()
and QEMU's arm_is_el2_enabled() and arm_is_el2_enabled_secstate() functions.
This doesn't mean much in Root state, and for Realm state EL2 is always
enabled (assuming it is implemented).

For this timer check, we're doing I think the same thing as the
pseudocode AArch64.CheckTimerConditions(), which does:

  if (IsFeatureImplemented(FEAT_RME) && ss IN {SS_Root, SS_Realm} &&
      CNTHCTL_EL2.CNTPMASK == '1') then
     imask = '1';

so I'm inclined to say that our current implementation in QEMU is correct.

>          ((timeridx == GTIMER_VIRT && (cnthctl & R_CNTHCTL_CNTVMASK_MASK)) ||
>           (timeridx == GTIMER_PHYS && (cnthctl & R_CNTHCTL_CNTPMASK_MASK)))) {
>          irqstate = 0;
> --

thanks
-- PMM

