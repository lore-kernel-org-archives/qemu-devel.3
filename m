Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5039FC0218A
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jan 2025 13:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tcP0R-0000IO-3h; Mon, 27 Jan 2025 08:18:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcP0O-0000G8-LY
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 08:18:20 -0500
Received: from mail-yb1-xb35.google.com ([2607:f8b0:4864:20::b35])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tcP0N-0002oE-6C
 for qemu-devel@nongnu.org; Mon, 27 Jan 2025 08:18:20 -0500
Received: by mail-yb1-xb35.google.com with SMTP id
 3f1490d57ef6-e53c9035003so6943227276.2
 for <qemu-devel@nongnu.org>; Mon, 27 Jan 2025 05:18:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737983898; x=1738588698; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Xtpi4qgkL8JkagCn6wQDzBxcxQZeuPDplrYKg6/I3qY=;
 b=M0msuB+Rzbki9GfIcinDEIUyMrd/YFUpftR0brYgDz1QyRiJSr3DWbJfV+g2lLkt1Z
 g0jgniCNvaMqlJIg00kV2wSOU+T6BHTdmV99qUCrPT/n59FetDO4b/B6MXpwL0SZWNqD
 avvN0CMK1UJSyAm7BgkNp5os30AOgtdZJvHp/T/yClDc5En7SobP1LVHxE3e4e13IqMd
 vxwu3Gkh/3oOPLybXKcqDLhujYd7IQsfT2YLS6vnLlErnSqU5IErGGLs6yzd7WrAQzDo
 9+gHQD3AcquBIy5DtNOBwFUZH7ld0lNlzBNensS2RBB/hKxLBuqioyNzX/B93l6TOzsQ
 i7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737983898; x=1738588698;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Xtpi4qgkL8JkagCn6wQDzBxcxQZeuPDplrYKg6/I3qY=;
 b=Aul+1k/0FO2Gc2mlzei9xMCgv9BJEIu9OSKOywGclT3DRNCVq2WyMJE2fBAvQ2LxIZ
 V6tFzGNojN67+8IIkajIM+a1m3ZtGz2fCqylWWrdE5imjE5DrxJ7OBOFGv74+2+iR998
 kT58BbpDnDUdVlYPOH1urLFw2iiMkt9EJJqi1jnjXJwq7Gmmm0PlEPji6LlKGqevTwW8
 JOjQRfuS+6NW40/GND5uikEo200MsuXErKbwLussXzZgvtKtmrUAvb+foR+7OrGGB+DH
 aoyzbuF+sxGF/nSghjl+0CsN/crLr32ltqxk+/SE6JdYomXJEbyAOA8iEBEX0U7QcirA
 3Sqg==
X-Gm-Message-State: AOJu0Yz6KiUjHx4Sn5vJJGw/5bP58lTNEGks13xGq51czX7Y4cfCg5+y
 czKtcGEVRBrQMMPThocjqMtzmRr1szxrdjzA36t5yuiLFMK5/zOgvB/hsr+vbIZNYlDgn1QfR2/
 xmHmlMbnpjPHeY8dj7KwAsPhiqU53hiG72goX6HRi7WxAY5tU
X-Gm-Gg: ASbGncs5Ud74m8kPqaSso0NPPfskrU5iMssW3CujeJO1WVKXY6tcGp3FXiTYhY1DeaY
 ib2hqIUXac4hHR2ZhOhO49GjAAemylJFPDYI4lMV7NbgyekARew1xqjFe2HcWQNQ=
X-Google-Smtp-Source: AGHT+IGch3mtnmf+mCN8yBwsD9pAvcUd2YnKiHrMwbXFBMQGDCnUdI2eCAt9+rTTeg7G9FaLRZ1UCLkjydDs/C/YrBY=
X-Received: by 2002:a05:6902:72c:b0:e58:32b4:4868 with SMTP id
 3f1490d57ef6-e5832b44a6cmr11961205276.3.1737983897770; Mon, 27 Jan 2025
 05:18:17 -0800 (PST)
MIME-Version: 1.0
References: <20250111183711.2338-1-shentey@gmail.com>
 <20250111183711.2338-3-shentey@gmail.com>
In-Reply-To: <20250111183711.2338-3-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 27 Jan 2025 13:18:06 +0000
X-Gm-Features: AWEUYZmR7ST3QpmICCYcdkXNbaVyh6Mt6einpxGGwOCmVeA0KUGPnwzNeWgAzn0
Message-ID: <CAFEAcA-LYW+uAXA4nzkT5mXYr_rSmpdth6K+roBxP_2ySfA4Ng@mail.gmail.com>
Subject: Re: [PATCH v2 02/13] hw/char/imx_serial: Fix reset value of UFCR
 register
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, Guenter Roeck <linux@roeck-us.net>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Laurent Vivier <lvivier@redhat.com>, Bin Meng <bmeng.cn@gmail.com>, 
 qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b35;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb35.google.com
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

On Sat, 11 Jan 2025 at 18:37, Bernhard Beschow <shentey@gmail.com> wrote:
>
> The value of the UCFR register is respected when echoing characters to the
> terminal, but its reset value is reserved. Fix the reset value to the one
> documented in the datasheet.
>
> While at it move the related attribute out of the section of unimplemented
> registers since its value is actually respected.
>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

