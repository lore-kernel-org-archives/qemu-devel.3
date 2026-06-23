Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DDCFCD98F0
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jun 2026 04:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wbsXU-0001IS-Ny; Tue, 23 Jun 2026 00:15:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wbsXT-0001I7-Bk
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 00:15:07 -0400
Received: from mail-dy1-x1343.google.com ([2607:f8b0:4864:20::1343])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chao.liu.zevorn@gmail.com>)
 id 1wbsXR-0004bF-HK
 for qemu-devel@nongnu.org; Tue, 23 Jun 2026 00:15:07 -0400
Received: by mail-dy1-x1343.google.com with SMTP id
 5a478bee46e88-30bc871ecdfso6112420eec.1
 for <qemu-devel@nongnu.org>; Mon, 22 Jun 2026 21:15:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782188104; x=1782792904; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=rav0U9VxLm5fQsie1h/5mQ/idY6wHOT1/c1KoXQzOKw=;
 b=ZAeifxvna8LppkYLLifZFCW8WccDuqKgfSG+qBNagcHpXIeOkofuBUEEqZYoIfYrQ+
 eBxyvRJZt7z4AjqFdH3Upyi1h5ca1yot8Sf+ir1M+Gnt+cDd3d1UayIniuAyJnyMFdqR
 OC8AXlbUW/rtC3Igv4l/OC/Van5aqt3RJPXBKO6/eYv6LhNU4xt4OY+YzgIjFZtsD3jJ
 GKRm47pVzw7FBhjlmJS8bkH64xJaVjn5DxMTajHPpkmmgxutn6fcD7FPkXXfq2toTbKX
 TwjcT3B2xhNP9UtnMxuYoRki8jx4TydXZYDmuACAyY4mH28kDNHQZlnxeDlTBP8KCudT
 s6pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782188104; x=1782792904;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rav0U9VxLm5fQsie1h/5mQ/idY6wHOT1/c1KoXQzOKw=;
 b=rJecplr12ykNUX9OJXoZlsqecamczat/ps8RycmC0ocgBzCVRIY7BSCL30Sq5XQhvk
 1kmrwendxnPS68UXJR62olFCx+jFCWcsnboh6oBYsPUIVHlJMvviGF9CuJhmcJb4zK7e
 TcbUdydR1nxlBxmXk3Y3VTtAr+d93HWfZYfEGsgba2v+fLu+xBEjMEZ7CK1gG0Ie141Z
 CTB7/KSeeVMOd4znvh6pg2SHI+A8C0L4t+052BIHkjj9Bo38vZ3vmYuF6Nn3PvFcFQdB
 6Q/0JPA0hKHZd1X0h7Y7BC0z/yjnFrtRQLXk24mMiHEjvtPj/MfaArR3/WuPKp5FyxxT
 Gc3w==
X-Gm-Message-State: AOJu0Yzt6jUwr5a3Ysp/ijslmizq/RQ/Nc5Bv4MxlzVPH4XweYbvjTrk
 6Mq7VWoVnUFFXBy/aL1buOYDcUUdPVDYNOPMD4Be2YOrsMbSveKURZYBGKOXuTya
X-Gm-Gg: AfdE7cmXP6IcsPuhY9idgjaehpL21uhIlFl695kDGyuSiepYxltNH6k+6JgPded4YgM
 flKK2LOIEzwrKfqiY+JKazSG/7ikvpKRkhH1sA/8tW4TpzXeTnExx4rxOJFHkhIofvevnLgS9Kz
 v0fg3ox1Kv8E19125tFIqwmXeeDdDhNxUpMwPtc6YrttPnn6wR5+N5/Y3Z5MGsyKkznq2qV0ogP
 0i8Uz98hC3Zxxu9AFaup3jgYyjDcB+o8JC7e5u4fHRW5SagxHYAjA2TU9laG/KNLt3dYd5xTlZV
 F7LwMON87wfgI05OIyb/MKrLW2yZNBtvEJ4vYq4qOB3ezyB0epm2ICDfD91XgY444j/nivtWXDa
 6J/NEOSJiZT4F8h/m5su45tKlkIqG7Sk7DFGhpyT93z9ekcyvNbI5vq6eOhRG7Pp9v1sAjhHfOO
 vijF8Y/ny4oFaPhUOl3+PySYfbYdHNtjDXCUFFiYcXaxdL/2vw
X-Received: by 2002:a05:7300:2150:b0:2e0:1f09:d924 with SMTP id
 5a478bee46e88-30c06e0da93mr13756412eec.5.1782188102952; 
 Mon, 22 Jun 2026 21:15:02 -0700 (PDT)
Received: from localhost ([64.186.250.142]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-30c1ba1f14fsm12953238eec.5.2026.06.22.21.15.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 21:15:02 -0700 (PDT)
Date: Tue, 23 Jun 2026 12:14:59 +0800
From: Chao Liu <chao.liu.zevorn@gmail.com>
To: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, alistair.francis@wdc.com, 
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, 
 Palmer Dabbelt <palmer@dabbelt.com>
Subject: Re: [PATCH 3/5] hw/riscv/sifive_u: add #address-cells in PLIC FDT
Message-ID: <ajoILibMuVebKwlH@ChaodeMacBook-Pro.local>
References: <20260616235939.1358663-1-daniel.barboza@oss.qualcomm.com>
 <20260616235939.1358663-4-daniel.barboza@oss.qualcomm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260616235939.1358663-4-daniel.barboza@oss.qualcomm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1343;
 envelope-from=chao.liu.zevorn@gmail.com; helo=mail-dy1-x1343.google.com
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

On Tue, Jun 16, 2026 at 08:59:37PM +0800, Daniel Henrique Barboza wrote:
> By Linux FDT docs in [1] the "address-cells" property is mandatory.  Set
> it to zero.
> 
> While we're at it let's also put this new value and the interrupt-cells
> value in macros, like the 'virt' board is doing.
> 
> [1] https://www.kernel.org/doc/Documentation/devicetree/bindings/interrupt-controller/sifive%2Cplic-1.0.0.txt
> 
> Signed-off-by: Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>
Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>

Thanks,
Chao
> ---
>  hw/riscv/sifive_u.c         | 5 ++++-
>  include/hw/riscv/sifive_u.h | 2 ++
>  2 files changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> index b3468254f5..7dfc18d3ec 100644
> --- a/hw/riscv/sifive_u.c
> +++ b/hw/riscv/sifive_u.c
> @@ -213,7 +213,10 @@ static void create_fdt(SiFiveUState *s, const MemMapEntry *memmap,
>      nodename = g_strdup_printf("/soc/interrupt-controller@%lx",
>          (long)memmap[SIFIVE_U_DEV_PLIC].base);
>      qemu_fdt_add_subnode(fdt, nodename);
> -    qemu_fdt_setprop_cell(fdt, nodename, "#interrupt-cells", 1);
> +    qemu_fdt_setprop_cell(fdt, nodename, "#interrupt-cells",
> +                          SIFIVE_U_PLIC_INT_CELLS);
> +    qemu_fdt_setprop_cell(fdt, nodename, "#address-cells",
> +                          SIFIVE_U_PLIC_ADDR_CELLS);
>      qemu_fdt_setprop_string_array(fdt, nodename, "compatible",
>          (char **)&plic_compat, ARRAY_SIZE(plic_compat));
>      qemu_fdt_setprop(fdt, nodename, "interrupt-controller", NULL, 0);
> diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> index e4c9860d50..aed966a62d 100644
> --- a/include/hw/riscv/sifive_u.h
> +++ b/include/hw/riscv/sifive_u.h
> @@ -156,6 +156,8 @@ enum {
>  #define SIFIVE_U_MANAGEMENT_CPU_COUNT   1
>  #define SIFIVE_U_COMPUTE_CPU_COUNT      4
>  
> +#define SIFIVE_U_PLIC_ADDR_CELLS   0
> +#define SIFIVE_U_PLIC_INT_CELLS    1
>  #define SIFIVE_U_PLIC_NUM_SOURCES 54
>  #define SIFIVE_U_PLIC_NUM_PRIORITIES 7
>  #define SIFIVE_U_PLIC_PRIORITY_BASE 0x00
> -- 
> 2.43.0
> 

