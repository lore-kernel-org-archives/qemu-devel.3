Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9CC1C02180
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 09:24:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYM6e-0007xW-Um; Thu, 16 Jan 2025 04:24:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tYM6b-0007wc-9t
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 04:24:02 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <ajones@ventanamicro.com>)
 id 1tYM6Z-00072h-7p
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 04:24:01 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-38632b8ae71so553568f8f.0
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2025 01:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1737019437; x=1737624237; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=b5Dhkp2yMFlr3DOu7jV73dzQBALI6mf8f0t2QiTjX3o=;
 b=iNFRqDyByMoePmQkat5q26i9+ObP+Qj1NKYziWe5HaMG1D81O82PdrcaFbBjpxVeqM
 p0slTYoN+HQd+6845xbFhFxkEDOJlRDkIoFWrjS79EZbjlXUc0PMUWF3/trf5lyN3Qov
 CHyT+AnTXLV8ztuCZ/LOUJKf74Qgl5FU3LwwScJhn5VocoZIeWb7yeV+hNsRVTq/U9oE
 Zzz3CAeaM8aNr86jr3QaUg/y4417HlmhWp6xdRK5uV5Vr2P9V8FjvED+/UbtmEWgtm1W
 rCz9/NGN4XTUrrKwhJG8Ru6QkuHhYjo/R5FEMOcwJRaidgEug2ErbqID5UQFIm9EjWgI
 e53A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737019437; x=1737624237;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=b5Dhkp2yMFlr3DOu7jV73dzQBALI6mf8f0t2QiTjX3o=;
 b=L2wchYjcs80HhLdkWp73+OwI5IDUCHZCoTmD/OE89vlD0UUZCc+VmEwZkkZIHqtkxp
 QUY6DJZnesuWfe0iwKGejliEIno6MWa9yTRddgBZCBp94fOVQ4zK76PBY4jFr6N1WV9d
 z8QchejxahyhJr03of6L9MNGkFs8t3yC6pZS6iirsflm/4fH2X/SzPf+/KFuyKcGAW5P
 Ac9/RasShDSmWlejRQMHkoabcVCmVSmuufXrGvGH7oF7hv3347XV+AriKe1I9BQSXeuK
 IDbt3bvqw9mEHD+mATXhQoa9q4f+bhkav0p0fQ0cyIF+LybIhk1RLu9pTJ/5cPgHtU2e
 Kv8w==
X-Gm-Message-State: AOJu0YzMlDCBqy008NjQkfOwZhQ0Umd3yIRYyGJ9QyUs45Yhnwitmapn
 U/62L2qMPi4ijd/2vJJKTGgdu+PdgG106MnLWgLDCMx5Q6qeDYXAfHUpcluqnRQ=
X-Gm-Gg: ASbGncvdY1R/p8tK+NxzhAhdCCPvAfFiRM2nn1NDl6bx+jAfgVxJLXQnlYBGgULhViI
 rCO2sFxUtNDJY04CGwR0oNfw+VLAYA9wen5ErnKD7rhKXfxddG2dSmFKLXSVK36onuqpy8lYq0o
 EiC20E+Ftk6jhE6cGxx1J73L867CfROyDe1ar7VqA3DiuEVjzlPW+TTtQwMPG4TecSWbVucTuXd
 Ss2USt/WkK4RWfq36+vle0TkadacOTU81cJi8aDjXi1JQ1nAVbs5cMOZI+zC9hsPqp8wBKYKYzl
 FdgwIZjIEQP/KmMcAN0E3gQnxDT0dFJscFk4o9kzGQ==
X-Google-Smtp-Source: AGHT+IG5Coe+PZ6XkKM1iuZuFak9ftPrINRJJbjfoFgocoRYX1v1be2/+Duu9oF32EAQKOCxJsWUfw==
X-Received: by 2002:a5d:598d:0:b0:386:3711:ff8c with SMTP id
 ffacd0b85a97d-38a873067b9mr32099598f8f.23.1737019437592; 
 Thu, 16 Jan 2025 01:23:57 -0800 (PST)
Received: from localhost (2001-1ae9-1c2-4c00-20f-c6b4-1e57-7965.ip6.tmcz.cz.
 [2001:1ae9:1c2:4c00:20f:c6b4:1e57:7965])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a8e37d01dsm19756853f8f.9.2025.01.16.01.23.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Jan 2025 01:23:57 -0800 (PST)
Date: Thu, 16 Jan 2025 10:23:56 +0100
From: Andrew Jones <ajones@ventanamicro.com>
To: Vasilis Liaskovitis <vliaskovitis@suse.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, palmer@dabbelt.com, 
 alistair.francis@wdc.com, jason.chien@sifive.com, zhiwei_liu@linux.alibaba.com,
 dbarboza@ventanamicro.com, bmeng.cn@gmail.com, liwei1518@gmail.com,
 philmd@linaro.org
Subject: Re: [RFC PATCH] hw/riscv/virt: Add serial alias in DTB
Message-ID: <20250116-089f795c1302e6f2b4a6b8c0@orel>
References: <20250116084629.19983-1-vliaskovitis@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250116084629.19983-1-vliaskovitis@suse.com>
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=ajones@ventanamicro.com; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Jan 16, 2025 at 09:46:29AM +0100, Vasilis Liaskovitis wrote:
> This patch adds an "aliases" node with a "serial0" entry for the
> single UART in the riscv64 virt machine.
> 
> This was requested in Gitlab #2774. However, since the machine only
> has one UART at the moment, it's not clear that this addition makes
> sense.
> 
> Fixes: https://gitlab.com/qemu-project/qemu/-/issues/2774

s/Fixes/Resolves/ (see docs/devel/submitting-a-patch.rst)

> Signed-off-by: Vasilis Liaskovitis <vliaskovitis@suse.com>
> ---
>  hw/riscv/virt.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index 2bc5a9dd98..67b80e9430 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -971,6 +971,8 @@ static void create_fdt_uart(RISCVVirtState *s, const MemMapEntry *memmap,
>      }
>  
>      qemu_fdt_setprop_string(ms->fdt, "/chosen", "stdout-path", name);
> +    qemu_fdt_add_subnode(ms->fdt, "/aliases");

create_fdt_uart() is called at machine-done time, so we should create the
/aliases node in create_fdt() in case we ever have other uses for it.

> +    qemu_fdt_setprop_string(ms->fdt, "/aliases", "serial0", name);
>  }
>  
>  static void create_fdt_rtc(RISCVVirtState *s, const MemMapEntry *memmap,
> -- 
> 2.46.0
>

Thanks,
drew

