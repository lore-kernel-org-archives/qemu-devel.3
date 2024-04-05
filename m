Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34EECC67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 13:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsjZJ-0002jC-4D; Fri, 05 Apr 2024 09:25:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsjZH-0002il-Gg
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 09:25:19 -0400
Received: from mail-lf1-x136.google.com ([2a00:1450:4864:20::136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rsjZF-0006R5-P3
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 09:25:19 -0400
Received: by mail-lf1-x136.google.com with SMTP id
 2adb3069b0e04-516d6e23253so358544e87.1
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 06:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712323515; x=1712928315; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=/faHNRafUdRJhvfF+2DKc8//5g/kYkjcQe6IuY2hny0=;
 b=lryVQd6FzGLXtkZsuXbC8gZXgMLScKPj+vPxRfbUlJ2o6oFGhEPrAHM2iUayO8H8vK
 YibeU6kMdscTUg5swXnp1wxzhwcLvpzsADyBMMNkWq5dfhm3swiboYxehWLd+CWWOebr
 FHQYz3bWWKotvVlRUKNLP7fTbaKqJcQdRRsmt3yK0fiatJGrox+KlDtbBUUwucI2JEgX
 3mOo1cYaQNXCJZClPVbkSukSkwhmv15Y38FYejEvr/BH2nOpHB7hVGrgBZZ1SaTT7bw6
 CY7I+x4/Vj27dZzvItVShRJQ+IOf5hWlChtdEa30u3UnJ8t9nHmo95ZbAHiOjIt/HCB+
 6RmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712323515; x=1712928315;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/faHNRafUdRJhvfF+2DKc8//5g/kYkjcQe6IuY2hny0=;
 b=QABNhzSY4u1UXxCHurn6xxNxsZ5mZr7MirDLREsf0VOLrhDddhJsBN3AP0z7PrUsad
 M8r4qTQOOrVby1JMrZEISw9+tGswKy953adJfxg9E3ClD9y26KeKPlNSOpRF6KkcrBSB
 qAqbaxuNDUO023lAWtnSUXOwbu0kBdKwQ+pJmiKOGNqFE4Sg4OZ6v+0ofePtDwU2wTQx
 y+KdhVtRcUrWttlk9HSPKe7sKqvZL0oymbMo1loUvQM6n63U0vkk8wNqhyXe/XeC8WLa
 AzcjY13X2nq8zX2GlfEO1NYy3dToqimT6eWmr3YC05OaAqog8xPxEW5veFHY7jd5s3SX
 RZRQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW5BGqJOnVrHZcxeIEKJ1xzazAn3iExvBzoA1AO61taFGI/PTDfAru9EF+lnHnEOA7Zqx/OQqnflcdyMnozbChNOg3PK4I=
X-Gm-Message-State: AOJu0YzwJVn8kbn4ymFPyLupwwWPmSaqqHNgcD5Gc0VjxKEhPTvpbY4y
 IwgYo24QLkfTSD15rqo7ZvyIJreLwdypHD7VhAHxCedfV4UnOnvOKNmiqS9TV6ZZXJEn+KluPdS
 89cb58tNd4mybRKzLDaaVAF2NIZSbwmV6Oz8afA==
X-Google-Smtp-Source: AGHT+IHavc+cUz2tJAFSbeRPgoJReCCJ+FiwIo7ioJANX9uIDuk4bWquYuRL7Iw2GTtnqdQxdpG3vL844pNpDBKtf0Y=
X-Received: by 2002:a19:ad0b:0:b0:516:d264:1ce8 with SMTP id
 t11-20020a19ad0b000000b00516d2641ce8mr1144916lfc.19.1712323515550; Fri, 05
 Apr 2024 06:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240403101611.3204086-1-ruanjinjie@huawei.com>
 <20240403101611.3204086-14-ruanjinjie@huawei.com>
In-Reply-To: <20240403101611.3204086-14-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 5 Apr 2024 14:25:04 +0100
Message-ID: <CAFEAcA-Jf4H4r4BVzPvDZGsm26T1QUjtaOAh+Ln2e=o2Gty-kQ@mail.gmail.com>
Subject: Re: [PATCH v12 13/23] hw/intc/arm_gicv3: Add has-nmi property to
 GICv3 device
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, richard.henderson@linaro.org, qemu-devel@nongnu.org, 
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::136;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x136.google.com
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

On Wed, 3 Apr 2024 at 11:18, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> Add a property has-nmi to the GICv3 device, and use this to set
> the NMI bit in the GICD_TYPER register. This isn't visible to
> guests yet because the property defaults to false and we won't
> set it in the board code until we've landed all of the changes
> needed to implement FEAT_GICV3_NMI.
>
> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>


> diff --git a/hw/intc/arm_gicv3_common.c b/hw/intc/arm_gicv3_common.c
> index c52f060026..2d2cea6858 100644
> --- a/hw/intc/arm_gicv3_common.c
> +++ b/hw/intc/arm_gicv3_common.c
> @@ -569,6 +569,7 @@ static Property arm_gicv3_common_properties[] = {
>      DEFINE_PROP_UINT32("num-irq", GICv3State, num_irq, 32),
>      DEFINE_PROP_UINT32("revision", GICv3State, revision, 3),
>      DEFINE_PROP_BOOL("has-lpi", GICv3State, lpi_enable, 0),
> +    DEFINE_PROP_BOOL("has-nmi", GICv3State, nmi_support, 0),
>      DEFINE_PROP_BOOL("has-security-extensions", GICv3State, security_extn, 0),
>      /*
>       * Compatibility property: force 8 bits of physical priority, even

I was thinking about how we'll (eventually) want to handle NMI
for non-TCG cases (KVM, hvf), and I realised there's a missing
piece here: we want to make it an error to try to set has-nmi=true
for the KVM GICv3, because it doesn't support NMIs yet.

So in hw/intc/arm_gicv3_kvm.c:kvm_arm_gicv3_realize(), we want
to add a check similar to the existing "fail if s->revision != 3"
and "fail if s->security_extn" that does

    if (s->nmi_support) {
        error_setg(errp, "NMI is not supported with the in-kernel GIC");
        return;
    }

(There are some work-in-progress kernel patches for NMI support
in the in-kernel GIC, but nothing has landed yet. When it does
we'll then be able to add the support in the QEMU code.)

thanks
-- PMM

