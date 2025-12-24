Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A8C4E776F0
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Dec 2025 19:12:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vYUHF-0005yq-RO; Wed, 24 Dec 2025 14:12:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vYUH9-0005v2-Ey
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 14:12:00 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1vYUH7-00050H-KX
 for qemu-devel@nongnu.org; Wed, 24 Dec 2025 14:11:59 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-b736ffc531fso1114788966b.1
 for <qemu-devel@nongnu.org>; Wed, 24 Dec 2025 11:11:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766603516; x=1767208316; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1XDb1Wp0lG59V9lOrnUBHFw63Nuxp58NkxLNLgbiusk=;
 b=FyM1sP5ItFluq0w0iEpvu1DgIgw84kCPu32juaRIjXN22qBDkEjJn/HdydXo7L0irw
 C2uKS+IeipZhhmP8ZJSr/pezui6hWqqD2hqRfdb/ikNvF0n784ZNm1/gsz8l7oJBCy8T
 MYW+Iisuz14oZmRQR/+aatzUlpTXtvdboQVmv16zDgnA8SqhyENYrboNWJJHbL7dkoz+
 PXtRR2jMCKmT2eLLtVJUYzfIYnNC1JE2FfYNrzEqTgWF3d9mX+ZWkxyDZz7VkiNqL8Vj
 E/A7s0yfETpcMFE+VKzHARBAQ0G1mG0IfO63w09U9p1hYZ924ER70Pj/0S78m9DFSEOO
 LkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766603516; x=1767208316;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1XDb1Wp0lG59V9lOrnUBHFw63Nuxp58NkxLNLgbiusk=;
 b=YraR4VbcoZf2TVmeGd5UchbKMYeo+4aNxWXQlj5kcNDfFMBGTIUQnjvMYaKFm55eYM
 0Q4yE7eNSj2SlKLJd14AcX1RX0AX/bGj3tyj04Y0EYsHESFy9nDJJSRWkiZTmblm6Cle
 EHzzsnsRMjJPWn+sQpsvD7WD5D5Ce4xnFe2mb8MiFKST2YdCLuBtcAtMb3D8WkxE0Y1W
 sbelJSPQniVyBzj+aSbXLUqs48Xiq2Wg/jNxkZiJkwGVLncWgNa5i48vhRmwII/QcCND
 xQg4Yoop7Jhoe5XdJIjcMhAODPr4USWc9P5e7nsJ2zU08f62WDyqhHHT14bfPhWP0b96
 5srg==
X-Gm-Message-State: AOJu0YxToLWfLt0r+p1KWC+lqsNpeYiqeXl3UN0M8H5aDTwHnVTsxfnA
 i1vGBlA0vJJAmJMRo7Cdjx6dgZDdfGANcvMA2QXUhmtTxBCvSeaq/RCAYCtXPmEzqtFg1ttywv/
 MqVhmtBPe/Y4AJWMA4R4lBMK53B36nGE0uGfajxA/ZebXbW3k9Klc13k=
X-Gm-Gg: AY/fxX6ZKrLA5tKI61B3CXRkAvtS/nu+w9czq3QbKe4s+ccI0sj85xm3qkJumVH+FMN
 IZGWd2Jr8OnHYxcFHJgCQ0SJc6mhy43JPvtIc9mRnK8JB5jY49JrTKW5Hf7fkRUJaC7Oa9dWGKd
 QfFYJtk5xWuale4IMgTthCBehWMdGVPiBX5BvogR3a1lta1zxZlVS1XxEc/U+8qVTAbAv/6BN44
 RFd3HJeVpqRo+8ozQ1RXf2GBEUc7Uzw4JJ7pK5oTlwf0AqwW+EQN+36EVgK87ViGKdREyc=
X-Google-Smtp-Source: AGHT+IGdXWU8/LTowcdfFy2QbVs1YyYRCAmmWi9T3KELlpSFIl+RXAoZ3jFj+Q86p3+D9Ioo/7d/ngwKQm//W48yeQ4=
X-Received: by 2002:a17:907:9719:b0:b7a:2ba7:197f with SMTP id
 a640c23a62f3a-b803719e302mr2001448366b.52.1766603515761; Wed, 24 Dec 2025
 11:11:55 -0800 (PST)
MIME-Version: 1.0
References: <20251224152210.87880-1-philmd@linaro.org>
 <20251224152210.87880-24-philmd@linaro.org>
In-Reply-To: <20251224152210.87880-24-philmd@linaro.org>
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Date: Wed, 24 Dec 2025 21:11:29 +0200
X-Gm-Features: AQt7F2q1XIFi__QIuAxR7EV4Ptn3VVP0-xCo3xBkYsjFROc1drLmCinQz3K3IQw
Message-ID: <CAAjaMXZuWTJcv6wkApr=USKx83imE64FT_L6__wQhECTc8NxHQ@mail.gmail.com>
Subject: Re: [PATCH v3 23/25] tests/qtest: Remove unnecessary 'qemu/bswap.h'
 include
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Peter Xu <peterx@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>, 
 Troy Lee <leetroy@gmail.com>, Jamin Lin <jamin_lin@aspeedtech.com>, 
 Andrew Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta <adityag@linux.ibm.com>, 
 Glenn Miles <milesg@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62f.google.com
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

On Wed, Dec 24, 2025 at 5:25=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@linaro.org> wrote:
>
> None of these files use API declared in "qemu/bswap.h",
> remove the unnecessary inclusion.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---

Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

>  tests/qtest/pnv-xive2-common.h     | 1 -
>  tests/qtest/aspeed_smc-test.c      | 1 -
>  tests/qtest/ast2700-smc-test.c     | 1 -
>  tests/qtest/libqos/fw_cfg.c        | 1 -
>  tests/qtest/libqos/i2c-omap.c      | 1 -
>  tests/qtest/pnv-spi-seeprom-test.c | 1 -
>  tests/qtest/vmcoreinfo-test.c      | 1 -
>  7 files changed, 7 deletions(-)
>
> diff --git a/tests/qtest/pnv-xive2-common.h b/tests/qtest/pnv-xive2-commo=
n.h
> index 2077c05ebc7..3b842274243 100644
> --- a/tests/qtest/pnv-xive2-common.h
> +++ b/tests/qtest/pnv-xive2-common.h
> @@ -15,7 +15,6 @@
>  #define PPC_BITMASK(bs, be)     ((PPC_BIT(bs) - PPC_BIT(be)) | PPC_BIT(b=
s))
>  #define PPC_BITMASK32(bs, be)   ((PPC_BIT32(bs) - PPC_BIT32(be)) | \
>                                   PPC_BIT32(bs))
> -#include "qemu/bswap.h"
>  #include "hw/intc/pnv_xive2_regs.h"
>  #include "hw/ppc/xive_regs.h"
>  #include "hw/ppc/xive2_regs.h"
> diff --git a/tests/qtest/aspeed_smc-test.c b/tests/qtest/aspeed_smc-test.=
c
> index 50a87e62500..39af1df0ed7 100644
> --- a/tests/qtest/aspeed_smc-test.c
> +++ b/tests/qtest/aspeed_smc-test.c
> @@ -24,7 +24,6 @@
>   */
>
>  #include "qemu/osdep.h"
> -#include "qemu/bswap.h"
>  #include "libqtest-single.h"
>  #include "qemu/bitops.h"
>  #include "aspeed-smc-utils.h"
> diff --git a/tests/qtest/ast2700-smc-test.c b/tests/qtest/ast2700-smc-tes=
t.c
> index 62d538d8a3a..33fc47230ee 100644
> --- a/tests/qtest/ast2700-smc-test.c
> +++ b/tests/qtest/ast2700-smc-test.c
> @@ -7,7 +7,6 @@
>   */
>
>  #include "qemu/osdep.h"
> -#include "qemu/bswap.h"
>  #include "libqtest-single.h"
>  #include "qemu/bitops.h"
>  #include "aspeed-smc-utils.h"
> diff --git a/tests/qtest/libqos/fw_cfg.c b/tests/qtest/libqos/fw_cfg.c
> index 0ab3959171b..8611f648c14 100644
> --- a/tests/qtest/libqos/fw_cfg.c
> +++ b/tests/qtest/libqos/fw_cfg.c
> @@ -17,7 +17,6 @@
>  #include "malloc-pc.h"
>  #include "libqos-malloc.h"
>  #include "../libqtest.h"
> -#include "qemu/bswap.h"
>  #include "hw/nvram/fw_cfg.h"
>
>  void qfw_cfg_select(QFWCFG *fw_cfg, uint16_t key)
> diff --git a/tests/qtest/libqos/i2c-omap.c b/tests/qtest/libqos/i2c-omap.=
c
> index 6f98f54820b..71f70c64f85 100644
> --- a/tests/qtest/libqos/i2c-omap.c
> +++ b/tests/qtest/libqos/i2c-omap.c
> @@ -10,7 +10,6 @@
>  #include "i2c.h"
>
>
> -#include "qemu/bswap.h"
>  #include "../libqtest.h"
>
>  enum OMAPI2CRegisters {
> diff --git a/tests/qtest/pnv-spi-seeprom-test.c b/tests/qtest/pnv-spi-see=
prom-test.c
> index 8033261758b..44e0b92730b 100644
> --- a/tests/qtest/pnv-spi-seeprom-test.c
> +++ b/tests/qtest/pnv-spi-seeprom-test.c
> @@ -7,7 +7,6 @@
>   */
>  #include "qemu/osdep.h"
>  #include "libqtest.h"
> -#include "qemu/bswap.h"
>  #include "hw/ssi/pnv_spi_regs.h"
>  #include "pnv-xscom.h"
>
> diff --git a/tests/qtest/vmcoreinfo-test.c b/tests/qtest/vmcoreinfo-test.=
c
> index dcf3b5ae058..0110dcceffa 100644
> --- a/tests/qtest/vmcoreinfo-test.c
> +++ b/tests/qtest/vmcoreinfo-test.c
> @@ -16,7 +16,6 @@
>  #include "libqtest.h"
>  #include "standard-headers/linux/qemu_fw_cfg.h"
>  #include "libqos/fw_cfg.h"
> -#include "qemu/bswap.h"
>  #include "hw/misc/vmcoreinfo.h"
>
>  static void test_vmcoreinfo_write_basic(void)
> --
> 2.52.0
>

