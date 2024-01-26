Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11847C47422
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jan 2024 15:39:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTOIS-0002ng-Es; Fri, 26 Jan 2024 10:39:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTOIR-0002fw-Bg
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 10:39:11 -0500
Received: from mail-lj1-x229.google.com ([2a00:1450:4864:20::229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rTOIP-0007nf-E8
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 10:39:11 -0500
Received: by mail-lj1-x229.google.com with SMTP id
 38308e7fff4ca-2cf3a095ba6so5676581fa.2
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 07:39:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706283547; x=1706888347; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=KgFBM226wXASqzVFP2tWEDF0GEwEPS14SZjGnM7W1U8=;
 b=GTWPDIKHT02dT5cvU1Gqua7j+/dSqZV92WrgLgxsXPyCD58xv4GdksZF+TJEaf+i4u
 VvFbhDzz5JH3UHvei5FoSYrxBpDDxG9YBIxCDkkxC2DNP9LChKZEpUhg5eESEgsgs9RG
 AFC58N/yr3mD8sPUhLBkVAFVGxPaQEXf979bRxno229wOlD4D+OG9GGM87GgQgKP68fp
 g57mTXOHNZWuAAhgc8YKUs3UYFm84kNxPwCbPR7zJj6awT70KTWQy0152wOA9nrBD+xp
 w0vGTc3DgiXG7laF7yGizYIY9PnKvm5ak9djvKT4dt3VQhqO9ABc7/+7iKdfgHjz8Ga9
 KcEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706283547; x=1706888347;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KgFBM226wXASqzVFP2tWEDF0GEwEPS14SZjGnM7W1U8=;
 b=wTC7UTLm4f+EICw9qJIuiv1M0LunL8wwwYpn7fCYeLenBtp6pMXW5PXDbD/SWxPY73
 MucWSI4nMn88SvfRXxKKeKUJ3w4uvlt20KGChtpMcP96qOm6LmoAA4ZUr9D+XvPdrqOn
 Nlt8766iMwhL8GGe+8FzkYRCvXiMuJtaotkzXnMM0aKV7cYSNUYbDVR5rnu5O+kM+ppi
 iyOkrlENLJtYgl39HieJdl/IcV+Cozd/UGN7cJ/pY5EGIq+/IXALqNGJNT9txGE6nXYn
 2ILKCwg0wb94RaY8B8FWJH3SgTD1nw+pzwmLwwhPqRffD0plux1w3qWaCy36gCzcF1E8
 TF5Q==
X-Gm-Message-State: AOJu0YyckBp+lNl+aeXhTrUjtaHs1JdpbT4kk1WJ/Bgy2h6oM8VC2/sj
 mNlIT3rwaHuUOcwdz+qRHvaGkKihVbEATZsBd5NozzfFQa/UOXqJyj+Q+i2DVcwD9AKq0qz/jxr
 WWq5Un5RFHSNVnBbnml/g9e8urfQ0xXRSMSauAg==
X-Google-Smtp-Source: AGHT+IHGU/QlYzUZxb44eWShd620rBao9XgACHHt5E87FXbH3yWyUSsiER+nVvCJIe59ovS52owS5eo2pNlwJOhpPSI=
X-Received: by 2002:a05:651c:204d:b0:2cf:2ba3:e3d1 with SMTP id
 t13-20020a05651c204d00b002cf2ba3e3d1mr930943ljo.38.1706283547433; Fri, 26 Jan
 2024 07:39:07 -0800 (PST)
MIME-Version: 1.0
References: <20240125163408.1595135-1-peter.maydell@linaro.org>
 <20240125163408.1595135-5-peter.maydell@linaro.org>
 <ZbPSQUQ2UXhLQbRN@intel.com>
In-Reply-To: <ZbPSQUQ2UXhLQbRN@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Jan 2024 15:38:56 +0000
Message-ID: <CAFEAcA9aiYeYRyw68Kh0if+q0__MR6HTUBuDRRuPoEbB54xg3g@mail.gmail.com>
Subject: Re: [PATCH 04/10] aspeed: Clean up includes
To: Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::229;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x229.google.com
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

On Fri, 26 Jan 2024 at 15:26, Zhao Liu <zhao1.liu@intel.com> wrote:
>
> On Thu, Jan 25, 2024 at 04:34:02PM +0000, Peter Maydell wrote:
> > Date: Thu, 25 Jan 2024 16:34:02 +0000
> > From: Peter Maydell <peter.maydell@linaro.org>
> > Subject: [PATCH 04/10] aspeed: Clean up includes
> > X-Mailer: git-send-email 2.34.1
> >
> > This commit was created with scripts/clean-includes.
> >
> > All .c should include qemu/osdep.h first.  The script performs three
> > related cleanups:
> >
> > * Ensure .c files include qemu/osdep.h first.
> > * Including it in a .h is redundant, since the .c  already includes
> >   it.  Drop such inclusions.
> > * Likewise, including headers qemu/osdep.h includes is redundant.
> >   Drop these, too.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> > ---
> >  hw/arm/aspeed_eeprom.h     | 1 -
> >  tests/qtest/qtest_aspeed.h | 2 --
> >  hw/arm/aspeed_eeprom.c     | 1 +
> >  3 files changed, 1 insertion(+), 3 deletions(-)
> >
> > diff --git a/hw/arm/aspeed_eeprom.h b/hw/arm/aspeed_eeprom.h
> > index bbf9e54365b..f08c16ef506 100644
> > --- a/hw/arm/aspeed_eeprom.h
> > +++ b/hw/arm/aspeed_eeprom.h
> > @@ -7,7 +7,6 @@
> >  #ifndef ASPEED_EEPROM_H
> >  #define ASPEED_EEPROM_H
> >
> > -#include "qemu/osdep.h"
> >
> >  extern const uint8_t tiogapass_bmc_fruid[];
> >  extern const size_t tiogapass_bmc_fruid_len;
> > diff --git a/tests/qtest/qtest_aspeed.h b/tests/qtest/qtest_aspeed.h
> > index 235dfaa186a..d35b0c7cba5 100644
> > --- a/tests/qtest/qtest_aspeed.h
> > +++ b/tests/qtest/qtest_aspeed.h
> > @@ -12,8 +12,6 @@
> >  #ifndef QTEST_ASPEED_H
> >  #define QTEST_ASPEED_H
> >
> > -#include <stdint.h>
> > -
> >  #include "libqtest.h"
> >
> >  #define AST2600_ASPEED_I2C_BASE_ADDR 0x1e78a000
> > diff --git a/hw/arm/aspeed_eeprom.c b/hw/arm/aspeed_eeprom.c
> > index ace5266cec9..daa3d329d10 100644
> > --- a/hw/arm/aspeed_eeprom.c
> > +++ b/hw/arm/aspeed_eeprom.c
> > @@ -4,6 +4,7 @@
> >   * SPDX-License-Identifier: GPL-2.0-only
> >   */
> >
> > +#include "qemu/osdep.h"
>
> Just a question, as the code style, should we add a blank line after
> this header?

No, we don't generally include blank lines in the #include
block. (But all these patches are autogenerated, so you get
what the script generates :-))

thanks
-- PMM

