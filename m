Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 436D4606A329
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Nov 2026 14:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=fOwAsntK
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWwZC-0001iU-UM; Fri, 27 Nov 2026 09:04:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWwZ7-0001hP-6z
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:04:42 -0500
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xWwZ3-0005ud-Jf
 for qemu-devel@nongnu.org; Fri, 27 Nov 2026 09:04:39 -0500
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-67da7d18f2fso9040051d50.0
 for <qemu-devel@nongnu.org>; Fri, 27 Nov 2026 06:04:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795788274; cv=none;
 d=google.com; s=arc-20260327;
 b=TEgMOOT64sSSDHP2E83BQ6DQWtsRpEUrR3QxiNoARdQq3Hwpxp5Mu0X1pNDRCNFu/g
 KjaxmJiL+j8ffyzfgoudrNdI8s7oOhEI4cpWeGh3I5ZX27we7uzUYyvBA2msHzy4LR/2
 lq6SkwedJyAlHMtdTbgbyhpqgjVutIUPdPqfaD1CS7R0Q30n/JlELbmx83383nvufxRA
 qmTnXPOuFHIJflRTXBBQeoQp6xMnxzCinm3LIU8EBDgO4v7tQXhMTx4FGPrOEJE38Tn3
 8wwPYWIh7cuoVgqiTQf1A0QZkPNFfWDqc8tLX5UmewHPBuHvRFS2N8aCofmNxEZSZFox
 UiAQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=HO8gbxvtHV0ttf030G+4UYWvnJS9QThRTKP4jUomrzQ=;
 fh=5KEn1GVqht6GsS4/s2FKEcSVLRglHDRGYt0j2fynRZQ=;
 b=RYznsZq8RsmW/D23Q8J1KzQEWnHd/pvvrIFb62/5W3qBrR8qtoRn9B1uILzz9XiBho
 OTFqPS2psNCAQt0fvwuZ6FoNZjWL3bN8lp6ytuPdWOcax3UzcQ39HrCLEZvV+EGNBhyH
 eDKBZ5pv4j1ZmStwWHIUQkghP3brEgNsky0+mCLK5TWRVrX999dh2OM6HVG93+mOyaul
 6tyJh9u7dzM3GpDyAG7AvbBwkPRnAel+QxtAMV5F3BlqAJjUa5awigXEFCWNh07QBlKh
 JchvAOvQWO7RFNgj6UoVDD+03TWdGipsUelj/S2BcEdbHedjfw8xLoYipovqfbQDDTx4
 UJ+w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795788274; x=1796393074; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=HO8gbxvtHV0ttf030G+4UYWvnJS9QThRTKP4jUomrzQ=;
 b=fOwAsntK9LQ7/2CMrI7KaKDrnB9qOhEvr8iFei36DblxC/T334PZw4IgeEAi+3b7wk
 Z6gnOpvULxXb6BYbIp0Ip/uJgBfmVFH3rTWdI4+6Wbnsk9EdrcfYU1EiCx8mZxHKAI95
 OUOvy6ipu1YMgqCccszpY9Hl5njD3Zauhu9UIjmWk1YXwDQSIXZ32PxKsN4OVmri/nUP
 lNgdaTWVEVtXd7Fzn7Bd6OuaSOgDZ9A4Kep4rBKoodEFFgb+0mb1JhY88G5Rk+vcqNxW
 MIJCt5n4+dy2nfBt/DxOqxxBlqdmNLRSkaSLTnnl5TmG1nzK4QiTw4vCLoQtouFzfoc4
 ikEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795788274; x=1796393074;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=HO8gbxvtHV0ttf030G+4UYWvnJS9QThRTKP4jUomrzQ=;
 b=2NEJr460kyha9YAE6wzSH2JmWeoV1yDiFAMeOwnl9F4U6XsT+O3OStWuhCQKWSetQw
 zvwFmIP/7IpLJ/lKPuDgQvXh3UsnDnPRxuuLt7ciAdDqkhel9czzWo7YSC140+2K7se8
 j/LgB5QbsAodriAUnYH30uvZi78Z8wWUc/VoDqlgBPjYYeYzMFfQRfjIdsbLWJ4rNH4w
 6lyrYghGfM3Tiiz0n89vT5MKU8/cuCRzbTIO3sEqK3QximbIBYB0tMgrCgi3kVKSnMDg
 Q9bmvM9OdJ4XmROKGkK5DLYT4Ut9ckw3gI133wkw4cXaLjNlkev4aaSN2lbb6p2mSC4H
 jBOw==
X-Gm-Message-State: APuU4Z8FvtGuPBGH4GrBlLYXlXiihsPULD0MWbUEJvx087zaETvcNDzk
 Xsg6elY78LULMlSFUlOG25P7pprQYt/r6QVjeITz8TAR+xnIIdG4DIaERqu2hu6TMu/SCZWH1ZL
 2HM/MJdpuOi4xBtRxZKU+vxTGNomt6365BphuhnL/Ww==
X-Gm-Gg: AZFdTZchiiZGcow/d6xbIBDo9OukunPGOMX1sWInYXLodA6cpDRaxm6q7MbWDLbDRdo
 XdV1NyQ+F9bbpvzvdoI7VjtADj61mvxFMoyY8+bLEWJEZzvxzbncH6ocKugA2olsmLIniQ/0ePU
 BGtV/QoZPWlvF4tmSpsFID7PsB3dCDgisd8IbiEEtPHwg2ZyOjTtSwEkKdUcON7zeOl5E5C7n3w
 nTTKUMO/AvGlplH9ag2CkO11dFXgGtEK3ib541y3Se89G30oZLSw3fGWVzyoyKl0tysW6DuWrGM
 27oCYm+Vh0WqSCCFcz0avqZXLgTJvdBg6DHECt3Wc/YL71FiJWVWUJCo/GzyKo5cKjN108IVXCc
 /rA/PwQ6Lf77EkIYfCm43O9eCIAesLYoKQNGshK4Qm1bueoRtE7+YNeXXy9uo7ukveoGVu4MkOk
 6LgFnrpFJ0Ri2W8cL6zkF4
X-Received: by 2002:a53:ca0c:0:b0:67d:c878:7dea with SMTP id
 956f58d0204a3-67df4503baamr6034712d50.50.1795788274084; Fri, 27 Nov 2026
 06:04:34 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261022145437.3546795-2-marcandre.lureau@redhat.com>
In-Reply-To: <20261022145437.3546795-2-marcandre.lureau@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Nov 2026 14:04:22 +0000
X-Gm-Features: Aa3M54rI5b04q8ILszJ62-EJBR5AI3xTTOhPg5Q4KiKKk5tOIBplmPdInf48yqQ
Message-ID: <CAFEAcA9Hq8b2uQwZBacSUzdhdbFP_oU20na1PEktO6qtOipfTg@mail.gmail.com>
Subject: Re: [PATCH] hw/display/ramfb: reject invalid framebuffer mappings
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, kraxel@redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Thu, 22 Oct 2026 at 15:55, <marcandre.lureau@redhat.com> wrote:
>
> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> ramfb_create_display_surface() passes the guest-controlled address
> straight to physical_memory_map() and only checks whether the returned
> length matches the requested size.  Two problems follow.
>
> An address backed by a non-directly-mappable region (device MMIO, an
> unassigned hole, ...) is bounced through a temporary host buffer.
> Bouncing is pointless for a framebuffer that is only ever read, and it
> consumes the limited address_space_memory bounce buffer budget.
>
> When address_space_map() cannot obtain bounce buffer space it returns
> NULL with *plen set to 0.  The size check then fails and the function
> calls physical_memory_unmap(NULL, 0, ...).  address_space_unmap() treats
> the NULL pointer as a BounceBuffer and dereferences its magic field,
> crashing QEMU.
>
> A guest can trigger the latter by writing the same configuration twice
> via etc/ramfb: the first 16x64 XRGB8888 surface at an unmapped GPA
> consumes the entire 4096 byte bounce buffer allowance, and the second
> mapping fails because that surface is still being displayed.
>
> Validate up front that the whole framebuffer range is backed by
> directly accessible memory, and still return early if the mapping
> fails, leaving the previous surface in place.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4740
> Reported-by: Karl Mehltretter <https://gitlab.com/kmehltretter>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/display/ramfb.c      | 38 ++++++++++++++++++++++++++++++++++++--
>  hw/display/trace-events |  4 ++++
>  2 files changed, 40 insertions(+), 2 deletions(-)
>
> diff --git a/hw/display/ramfb.c b/hw/display/ramfb.c
> index f477bdcc2186..8e2be33b0fcc 100644
> --- a/hw/display/ramfb.c
> +++ b/hw/display/ramfb.c
> @@ -17,8 +17,10 @@
>  #include "hw/display/ramfb.h"
>  #include "hw/display/bochs-vbe.h" /* for limits */
>  #include "ui/console.h"
> +#include "system/memory.h"
>  #include "system/physmem.h"
>  #include "system/reset.h"
> +#include "trace.h"
>  #include "exec/cpu-common.h"
>
>  struct QEMU_PACKED RAMFBCfg {
> @@ -46,6 +48,31 @@ static void ramfb_unmap_display_surface(pixman_image_t=
 *image, void *unused)
>      physical_memory_unmap(data, size, 0, 0);
>  }
>
> +/*
> + * A framebuffer must live in directly mappable host memory. Reject
> + * addresses backed by unrelated regions (MMIO, unassigned holes, ...)
> + */
> +static bool ramfb_range_is_direct_access(hwaddr addr, hwaddr size)
> +{
> +    WITH_RCU_READ_LOCK_GUARD() {
> +        while (size > 0) {
> +            MemoryRegion *mr;
> +            hwaddr len =3D size, xlat;
> +
> +            mr =3D address_space_translate(&address_space_memory, addr,
> +                                         &xlat, &len, false,
> +                                         MEMTXATTRS_UNSPECIFIED);
> +            if (len =3D=3D 0 || !memory_region_supports_direct_access(mr=
)) {
> +                return false;
> +            }
> +            addr +=3D len;
> +            size -=3D len;
> +        }
> +    }
> +
> +    return true;
> +}

Isn't there a TOCTOU problem here ? We check for "is this all
real RAM" but the address space might be changed between the
check and when we call physical_memory_map().

A variant of address_space_map() that let you tell it "never use
a bounce buffer" seems like it would be cleaner.

> +
>  static DisplaySurface *ramfb_create_display_surface(int width, int heigh=
t,
>                                                      pixman_format_code_t=
 format,
>                                                      hwaddr stride, hwadd=
r addr)
> @@ -65,9 +92,16 @@ static DisplaySurface *ramfb_create_display_surface(in=
t width, int height,
>      }
>
>      mapsize =3D size =3D stride * (height - 1) + linesize;
> +    if (!ramfb_range_is_direct_access(addr, size)) {
> +        trace_ramfb_bad_range(addr, size);
> +        return NULL;
> +    }




>      data =3D physical_memory_map(addr, &mapsize, false);
> -    if (size !=3D mapsize) {
> -        physical_memory_unmap(data, mapsize, 0, 0);
> +    if (!data || size !=3D mapsize) {
> +        trace_ramfb_map_failed(addr, size, mapsize);
> +        if (data) {
> +            physical_memory_unmap(data, mapsize, 0, 0);
> +        }
>          return NULL;
>      }
>

This part of the change is what's fixing the actual bug, right?
We could take that for 11.2 and address the "we don't expect or
want a bounce buffer" part for 12.0.

thanks
-- PMM

