Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FA60EE2084
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 11:16:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voJoZ-0004fU-14; Fri, 06 Feb 2026 06:15:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1voJoX-0004de-48
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 06:15:53 -0500
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shorne@gmail.com>) id 1voJoU-0006hY-SA
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 06:15:52 -0500
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4806dffc64cso17256375e9.1
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 03:15:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1770376549; x=1770981349; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=Ta4TTHyAkS6lM/UndoQEF21/rcTn2yE80qwE9t/lEUk=;
 b=cpfec8qB87oFt9jNh2iF3vvj0ZExccXbkiBH8Yr++W//ZFXTlsgMrS3vXOWWHVvyi5
 BrjpkOYnUDxF5tAoBi+eMnamSHx3o2ZbdRc3xftcdGR+ueSy+uihCUBZQlwsM+08BxfX
 3dW7F7maGV4FcdPiYHap2g9i2LiiwygbLljlGuVodfliDC/azBzhA091fm+gz0gEaBSt
 pb4fbCTpLeKLHTOBrKkRxrWFFY3JT7KXu+WQzdWqbNE9YbrK4xQZNasiIzP5ROuQsYvr
 GQqS1ZJ99iRocwGuI3MRu0GKTkV/I9RjkaDttY1nNb+Q8pMySU4Saptmz+2+hYWUP29A
 HCbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770376549; x=1770981349;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Ta4TTHyAkS6lM/UndoQEF21/rcTn2yE80qwE9t/lEUk=;
 b=gLxWXo2cH/jZi2G6dGIhee7ORq6oYR6A6uycpNnr+vrgryd9fBqnthoPJCm0Kawa3e
 EJbwCYKO8/Rt3z2LcxMFh6nNrnFbbxKTToNYY4GXvWMmVs/tGWMEtAjE8h+7mXD48Oho
 eHEifwImaqbyuHK92BNfUyyGO0gjQInkHu0iU3GZSMpfAt4eiHZRFecrMA5uW9X/scL8
 JSLKvRSj5NTPMX81gchaLxWl33o0gSslH1CWPa/OYUOnasUrkw3KzIO28hEd18kGr4HM
 tipFoRRWllnZn4b3co5+C3FQdoiNeMCA5GKpULtQ2HfnUZQ7f2OgQwguEUhByex+LJwo
 er6w==
X-Gm-Message-State: AOJu0YyG4OaoIEeU4938erQfFCNw0C3mPjs7zEKUi9DwVhaFLqENTdpl
 Zxuhhvb3Jdpf8fmcuO0Ri2ohOQ1AxkAOZxYJPyVtrfPTRQ1sDLhPVlTbcojnEGsj
X-Gm-Gg: AZuq6aLA+U446Z3UNng7fBtmM65UzblPeM2x1haWmYI9sNomncap/7tbs24cVLorDPR
 Y2lKdv+XfkisX+u+dgtoXDeYCNVBHGEIqq0Kitht5A6G+XhGPcDw+jqvp7k71532pE0wUFVxV+/
 QBjTx6+WzVmP+lop8f2Bd2Ye64BC3ObGlwOEqEdIc6gRMhHhgDYPn90dnJjjFLYmTHKU/OUVj2W
 32HcegyBdKt5cXqN9AW4mRChHJetSJ0xYzXZnUYYfMadHGx1Hctt8m5gtaxpUQGQlkoHVjSvT6V
 2tMzNUACB6FQbf3MHwRQK3KK63SX8N72+lz24QTMmw76q/twleciAcVdLeuCqnv/5zKVzm6L29J
 cT5lFxarBjyxwnhN/1ejfybrwcfJW/ul80zlC5UzaXBo1mrKe0njjU/b2pw9hYnJwIkDvArsyCh
 vQsUoJApga0/I6aIOiaAQsUTQoo6f8AghcnVozz5G3WQ1Jbto/dbmeGoe99la0RLiW
X-Received: by 2002:a05:600c:19d1:b0:477:9a28:b09a with SMTP id
 5b1f17b1804b1-483208b9470mr28350835e9.0.1770376548393; 
 Fri, 06 Feb 2026 03:15:48 -0800 (PST)
Received: from localhost
 (brnt-04-b2-v4wan-170138-cust2432.vm7.cable.virginm.net. [94.175.9.129])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483203e126dsm34863755e9.2.2026.02.06.03.15.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 Feb 2026 03:15:47 -0800 (PST)
Date: Fri, 6 Feb 2026 11:15:46 +0000
From: Stafford Horne <shorne@gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, pierrick.bouvier@linaro.org
Subject: Re: [PATCH 2/6] include/hw/or1k: Rename from openrisc
Message-ID: <aYXNYtGl6fVk3_7a@antec>
References: <20260205030244.266447-1-richard.henderson@linaro.org>
 <20260205030244.266447-3-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260205030244.266447-3-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=shorne@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Richard,

On Thu, Feb 05, 2026 at 01:02:40PM +1000, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

This looks fine to me.

Acked-by: Stafford Horne <shorne@gmail.com>

> ---
>  include/hw/{openrisc => or1k}/boot.h | 6 +++---
>  hw/openrisc/boot.c                   | 2 +-
>  hw/openrisc/openrisc_sim.c           | 2 +-
>  hw/openrisc/virt.c                   | 2 +-
>  MAINTAINERS                          | 2 +-
>  5 files changed, 7 insertions(+), 7 deletions(-)
>  rename include/hw/{openrisc => or1k}/boot.h (93%)
> 
> diff --git a/include/hw/openrisc/boot.h b/include/hw/or1k/boot.h
> similarity index 93%
> rename from include/hw/openrisc/boot.h
> rename to include/hw/or1k/boot.h
> index 3c481bdea6..2e6131580c 100644
> --- a/include/hw/openrisc/boot.h
> +++ b/include/hw/or1k/boot.h
> @@ -16,8 +16,8 @@
>   * this program.  If not, see <http://www.gnu.org/licenses/>.
>   */
>  
> -#ifndef OPENRISC_BOOT_H
> -#define OPENRISC_BOOT_H
> +#ifndef OR1K_BOOT_H
> +#define OR1K_BOOT_H
>  
>  #include "exec/cpu-defs.h"
>  #include "hw/core/boards.h"
> @@ -32,4 +32,4 @@ hwaddr openrisc_load_initrd(void *fdt, const char *filename,
>  uint32_t openrisc_load_fdt(MachineState *ms, void *fdt, hwaddr load_start,
>                             uint64_t mem_size);
>  
> -#endif /* OPENRISC_BOOT_H */
> +#endif /* OR1K_BOOT_H */
> diff --git a/hw/openrisc/boot.c b/hw/openrisc/boot.c
> index 6256babc42..c18f4a6a9f 100644
> --- a/hw/openrisc/boot.c
> +++ b/hw/openrisc/boot.c
> @@ -12,7 +12,7 @@
>  #include "exec/target_page.h"
>  #include "elf.h"
>  #include "hw/core/loader.h"
> -#include "hw/openrisc/boot.h"
> +#include "hw/or1k/boot.h"
>  #include "system/device_tree.h"
>  #include "system/qtest.h"
>  #include "system/reset.h"
> diff --git a/hw/openrisc/openrisc_sim.c b/hw/openrisc/openrisc_sim.c
> index 603d8ca0d9..f1b1f63274 100644
> --- a/hw/openrisc/openrisc_sim.c
> +++ b/hw/openrisc/openrisc_sim.c
> @@ -26,7 +26,7 @@
>  #include "hw/core/boards.h"
>  #include "hw/char/serial-mm.h"
>  #include "net/net.h"
> -#include "hw/openrisc/boot.h"
> +#include "hw/or1k/boot.h"
>  #include "hw/core/qdev-properties.h"
>  #include "system/address-spaces.h"
>  #include "system/device_tree.h"
> diff --git a/hw/openrisc/virt.c b/hw/openrisc/virt.c
> index 54ce96666e..39f54058ab 100644
> --- a/hw/openrisc/virt.c
> +++ b/hw/openrisc/virt.c
> @@ -16,7 +16,7 @@
>  #include "hw/core/boards.h"
>  #include "hw/char/serial-mm.h"
>  #include "hw/core/split-irq.h"
> -#include "hw/openrisc/boot.h"
> +#include "hw/or1k/boot.h"
>  #include "hw/misc/sifive_test.h"
>  #include "hw/pci/pci.h"
>  #include "hw/pci-host/gpex.h"
> diff --git a/MAINTAINERS b/MAINTAINERS
> index a0422936ad..508d37ab7a 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -305,7 +305,7 @@ S: Odd Fixes
>  F: docs/system/openrisc/cpu-features.rst
>  F: target/or1k/
>  F: hw/openrisc/
> -F: include/hw/openrisc/
> +F: include/hw/or1k/
>  F: tests/functional/or1k/meson.build
>  F: tests/tcg/openrisc/
>  
> -- 
> 2.43.0
> 

