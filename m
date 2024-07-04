Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E14BC30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 09:36:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPItR-000327-RZ; Thu, 04 Jul 2024 05:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sPItQ-0002uf-AP
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:36:44 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sPItO-0003Ih-N5
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 05:36:43 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-57cbc2a2496so519718a12.0
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 02:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720085801; x=1720690601; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=yuLhLjASJ1XEpE9lWqsWVoEP/ie88qXwmF7fpyahyP0=;
 b=umj+/yro0wwqzZGeQ19G21nz70YWQXk1qlbrqiBBMJ8wKu03Rw31dyC/d3zg/CLcUk
 eXTDUDe1NOsU28AmSwBhjmwhIRQ99jiESOAQ85V9BTP8+Ic8K2Imv9tSnqgPcQZXShzJ
 lMevqBmNhf/P3BRjyqDgSiWIruNebECnT4FW/hVRvhn2Vc37Rljv6p3I+xpfkJZwFMvJ
 OwzR4tjTSgpsT6rp6mKtNoxYUhjk6AfINn76l9CaqI0O2Fzi+/UW0xDj7kEJv72jU4XU
 HrQdhHlPq441DQuWls55fsiFxeEG/Sdi4Km1MYvcjJ9YulZEuzquKGgNVXudhZcUa4+B
 Xmew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720085801; x=1720690601;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yuLhLjASJ1XEpE9lWqsWVoEP/ie88qXwmF7fpyahyP0=;
 b=hn9ym5F/Ls/td/W06vTNHiUK2gVD9KCa5/V+sdxw4M/5MkyxlHs1l7HNx6kMLKPrg/
 pBLCVtagTcWywNEmneOeuRQACB0wHmDLV69J6X4fleJMOeP+sK6TyB74GYcUjIJTmBJc
 64lvXG3tAXrxQesx6EBExnl7+5XhW3H31YBY8EQP3eG95U45+u2+LLbg6qUJsjqbPMxK
 bxtatyvKRwACBCjFCS9tcH0WtL3g7hL7sCkYAQKO0gGyG9y40AchHUgYqHzXM2CprEvl
 3Lvaf2hY9Yg/Gsr0n4QOOqQdoNX55V/+pz8IvdJeDGSZrJzuWT+nRolyyIctC5KBH9fC
 527g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvGNN4naBWpeG5aENuimC34FZRdi/gPIc5m1z4ejR4jNxr8jH2x/1z1ceiCrTM2mKR1xEYZ5gJarv2NnIki7cMnYnhdlI=
X-Gm-Message-State: AOJu0Yw3ceHZ+PSkp6+SZDglaS+wTqZrZ2zWaY2qm0cLfIZpZbUjinmw
 Yb9KU64GyQznD9SUP+R7G4mJkSOCynzQPZmoaahB2AS+gxsWbP0L6DwbtES74Ub8I5fetYomjGi
 5WRN1f4uGVZ3OMppwESViwTvyvBK91K0BSYSqMQ==
X-Google-Smtp-Source: AGHT+IFjApFLiaKc4LvPN6+NUbdiC47/rQJa7tmBT0CMBx29s5hQA5QcPVHPWq1Jtt5GMgox7SKgOIOQzLS3HUS8Pcw=
X-Received: by 2002:a05:6402:2108:b0:58d:410a:32a9 with SMTP id
 4fb4d7f45d1cf-58e5add2bfemr877931a12.15.1720085801214; Thu, 04 Jul 2024
 02:36:41 -0700 (PDT)
MIME-Version: 1.0
References: <20240704084759.1824420-1-zhao1.liu@intel.com>
 <20240704084759.1824420-3-zhao1.liu@intel.com>
In-Reply-To: <20240704084759.1824420-3-zhao1.liu@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 4 Jul 2024 10:36:30 +0100
Message-ID: <CAFEAcA_R+F+CoHvQY53K1sGsBe2fKm3mD35rLkLQ-RosoYEr-A@mail.gmail.com>
Subject: Re: [PATCH 2/4] hw/i386/x86: Fix superfluous trailing semicolon
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-trivial@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Thu, 4 Jul 2024 at 09:33, Zhao Liu <zhao1.liu@intel.com> wrote:
>
> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>  hw/i386/x86.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/i386/x86.c b/hw/i386/x86.c
> index a4aa8e081098..01fc5e656272 100644
> --- a/hw/i386/x86.c
> +++ b/hw/i386/x86.c
> @@ -242,7 +242,7 @@ static void x86_machine_get_pit(Object *obj, Visitor *v, const char *name,
>  static void x86_machine_set_pit(Object *obj, Visitor *v, const char *name,
>                                      void *opaque, Error **errp)
>  {
> -    X86MachineState *x86ms = X86_MACHINE(obj);;
> +    X86MachineState *x86ms = X86_MACHINE(obj);
>
>      visit_type_OnOffAuto(v, name, &x86ms->pit, errp);
>  }
> --
> 2.34.1

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

