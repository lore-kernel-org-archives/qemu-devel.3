Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049E6606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 11:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EjT+X8M3;
	dkim=pass (2048-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=google header.b=oy8fcRSX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xM1f1-0002Rc-7P; Wed, 28 Oct 2026 07:17:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM1ex-0002K8-EN
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 07:17:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1xM1eu-0002C0-TB
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 07:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793186251;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ShuwqV1HZ78GzIKN1qjjG2Fw9M5vJK52OQW2Ebds+80=;
 b=EjT+X8M3dKtUoXMaZptyCRuaHIEbU37UZedDpRUYM2iNLe/Gz+9lpYha+zY9/s1GcIYaiD
 5wFf9e8KLy9XKvyJtqI1aiUNtMBKdpZQZCW8hPagSk9+42QNQuc/L1gSgUflpS6+hLdjxV
 bon3WRoYun4JP5Z1NWJ59s1S891OyHQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-134-sI7fvfCROiy1b6bPTFN-eg-1; Wed, 28 Oct 2026 07:17:29 -0400
X-MC-Unique: sI7fvfCROiy1b6bPTFN-eg-1
X-Mimecast-MFC-AGG-ID: sI7fvfCROiy1b6bPTFN-eg_1793186248
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-48df02b91f9so1289240f8f.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 04:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1793186248; x=1793791048; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ShuwqV1HZ78GzIKN1qjjG2Fw9M5vJK52OQW2Ebds+80=;
 b=oy8fcRSXroYwKURozGrG7pX+TJHymbfhOb8WaGAbQqneCESMQoI5oTBWOZ/kM/uvYq
 JpczBuSO2RsHJ114/K6H2Bruqjb72ybJRiDKim6MWWCKEkn+GeTcxyrVtLjmOYwYnlMQ
 ugyyjgw88pBDROuRKA0sOPAg8C5ZsEjqoTVR6sfcUOqTBquZr3kd/r4ot1zI3SeiD+yX
 MnuFMVPBfMHd/Mmb4lLdXqdOISJaYMMwbFm+tx488BXaoKueO+aJ7TyJKlZttWZSskHu
 i7CtqZurdalOnFG3tVJ+dBef/LS+SepO7akNiw2ok+V0mYWi1FBCvlyFjWw1f7nVV5VP
 PqIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793186248; x=1793791048;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ShuwqV1HZ78GzIKN1qjjG2Fw9M5vJK52OQW2Ebds+80=;
 b=2AGsHB/33wHX1dNYcxDJ4hMyg/3Pe7drVY+5epvkjB7a/xpMzSOemXopyR4XX0sRfL
 8sko7aQuLbN/lEynQGJGi0jow1mfBbNcvGqkMuDkhbuY8uJ4BKQeQUJ7apYOyrTHJbeB
 382GuJsSwoVQNDWu5MSqRp/SMuaGBmWkvBt1oKr/1HMndJ1bwAexXiDXUc0mU8WM49jI
 ms8e2aj+OwEufpuOx+Hk1JjhsdkTrrYcYWrXoTxtqGxdTvczUy0pmUpcjN0JpwmqHs5J
 CF04sGQ1ghnI3aXV4mRHTtnprDot5Qr7jnH6Mp6F05NruuH48/HPoAWagzKERVbdHJII
 UHSQ==
X-Gm-Message-State: AFq9FYK4dV6FvXOBzdWXWJZsCHrhlZyru4pr+n4eS31x+n9inO++/lHb
 NL+CuCSA5++7m6r3p8DgWUt5R4oEPU7Urg3XTHRPDLy1ffHohLoe7Egx4vnKRGJ0+pNvWPZIi+T
 b7wVQcDHzin7FjQQu+lQ749ple17e94X2JREIIxgHX8N06RWz9LfQ3C0J
X-Gm-Gg: AYBFou1kvPbc1kRhPafx7jANvts3w0ObtGQbHaRU0+/B+Nyp5nkE0Onnq+Syoob0FuU
 XgNr6oySjUeAGp1o3bkf0qvXpcqi5fRN1xaXdgtE/9hPZO+xYX5RPeJ+UTS7Kep8B1/aFuTsTGa
 ko9GJvScoon2Nw3jnPWQDrL+HpPyHNMBmnc5tqa9tjchLD+o4ItWz6eXQl95P/VS3O6U0SYGrJw
 M69+0GOjto7dOWhFwKirMNkFr66GpnZVwVCH4PMZDsxIGcLBME2HBxT1zZFe3HgwAWorA637EE4
 rNSj4Ys+bCywrQekIDMclFiYtBloFs+Etz/S5aMuaxZlle9+I7OokBmMIpBVL+ZRnh8ahgsj1jc
 L+4ZYZxmGaFKg6aaaudcMPgbpBYEZD3I4lUCTjlSN
X-Received: by 2002:a5d:628c:0:b0:48d:eac6:5c2c with SMTP id
 ffacd0b85a97d-48e55a3ed51mr10554196f8f.15.1793186248184; 
 Wed, 28 Oct 2026 04:17:28 -0700 (PDT)
X-Received: by 2002:a5d:628c:0:b0:48d:eac6:5c2c with SMTP id
 ffacd0b85a97d-48e55a3ed51mr10554143f8f.15.1793186247584; 
 Wed, 28 Oct 2026 04:17:27 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48e3ecd3418sm25130102f8f.41.2026.10.28.04.17.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 04:17:26 -0700 (PDT)
Date: Wed, 28 Oct 2026 07:17:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Ray Lee <hburaylee@gmail.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com,
	richard.henderson@linaro.org
Subject: Re: [PATCH] hw/i386: reserve the initrd in e820 for direct kernel boot
Message-ID: <20261028071348-mutt-send-email-mst@kernel.org>
References: <20260902061056.118917-1-hburaylee@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260902061056.118917-1-hburaylee@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-20.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, Sep 02, 2026 at 02:10:56PM +0800, Ray Lee wrote:
> With -kernel/-initrd, x86_load_linux() places the initrd at the top
> of low RAM but does not reserve that range in e820.  SeaBIOS
> allocates virtio vrings top-down from the same area, so with enough
> devices the vrings overlap the initrd and firmware DMA corrupts it.
> 
> Reserve the initrd range in the e820 table; SeaBIOS and OVMF both
> honor "etc/e820" reservations when setting up their memory
> allocators.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/4396
> Signed-off-by: Ray Lee <hburaylee@gmail.com>

Hmm. Yes this would fix it, but it would steal this memory
from the guest permanently, won't it?

Could you check free -m, or cat /proc/meminfo, with and without the patch?




> ---
>  hw/i386/x86-common.c | 15 +++++++++++++++
>  1 file changed, 15 insertions(+)
> 
> diff --git a/hw/i386/x86-common.c b/hw/i386/x86-common.c
> index 8f9419e7d3..4e85fde987 100644
> --- a/hw/i386/x86-common.c
> +++ b/hw/i386/x86-common.c
> @@ -38,6 +38,7 @@
>  
>  #include "hw/core/irq.h"
>  #include "hw/core/loader.h"
> +#include "e820_memory_layout.h"
>  #include "multiboot.h"
>  #include "elf.h"
>  #include "standard-headers/asm-x86/bootparam.h"
> @@ -744,6 +745,13 @@ void x86_load_linux(X86MachineState *x86ms,
>  
>                  initrd_addr = (initrd_max - initrd_size) & ~4095;
>  
> +                /*
> +                 * Keep firmware (e.g. SeaBIOS) from allocating over the
> +                 * initrd at the top of RAM.
> +                 */
> +                e820_add_entry(initrd_addr, QEMU_ALIGN_UP(initrd_size, 4096),
> +                               E820_RESERVED);
> +
>                  fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, initrd_addr);
>                  fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
>                  fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, initrd_data,
> @@ -889,6 +897,13 @@ void x86_load_linux(X86MachineState *x86ms,
>  
>          initrd_addr = (initrd_max - initrd_size) & ~4095;
>  
> +        /*
> +         * Keep firmware (e.g. SeaBIOS) from allocating over the initrd
> +         * at the top of RAM.
> +         */
> +        e820_add_entry(initrd_addr, QEMU_ALIGN_UP(initrd_size, 4096),
> +                       E820_RESERVED);
> +
>          fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_ADDR, initrd_addr);
>          fw_cfg_add_i32(fw_cfg, FW_CFG_INITRD_SIZE, initrd_size);
>          fw_cfg_add_bytes(fw_cfg, FW_CFG_INITRD_DATA, initrd_data, initrd_size);
> -- 
> 2.53.0


