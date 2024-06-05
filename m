Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 740E0C25B76
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 14:48:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sErw8-0004gq-VY; Wed, 05 Jun 2024 10:48:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sErw7-0004gG-FM
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 10:48:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sErw6-0005tv-0L
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 10:48:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717598901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EI/JUIPCCxx5G8XWN0i6kHG3bYfoclX/Xkp8mHTiDhY=;
 b=WTEicj0WfzKj8ivdh0fdi+dHge65AQaPRW5oAYi4kniY/nYyKb4r2tqo/zJHIemjkgj7N8
 VDnSoj8Bx5dhx7RXFFezl9WdGmg6M3lEQoZoBJwTVgO92N5eLCWf6ztZ8pl7OswVpSne7+
 bqsRaxClvSSwndbxp1EJIR8HIi4Gil4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-nzxXsd5ZPJSFlAU6w1oZ8w-1; Wed, 05 Jun 2024 10:48:20 -0400
X-MC-Unique: nzxXsd5ZPJSFlAU6w1oZ8w-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4215a37801aso1403045e9.2
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 07:48:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717598896; x=1718203696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=EI/JUIPCCxx5G8XWN0i6kHG3bYfoclX/Xkp8mHTiDhY=;
 b=cYIvKNRNUVU9CZXoomrRXTiV5FvNHXx8fPxeXt68ZGHI63YJC4/SvsQUE1NSzJ9qKT
 2ys5q+Z1+ap7MW6vZiymNRmKIQXaSsR1+ZPu5VSqNvqPI4C4EgDbNpNEqKC/5tm7ioWL
 wO+jq2F48gVBd7gK2gcpoeDNB66/m7eOd778kTGFH27m4KKtAZjqQZWdWB3vFgQKnFW0
 5iAqEVJYZc4FvOZGUpTjEASogH46dApLe25cj4p9hk6SwyunsuwsKy/i7v6KRyKlcAiZ
 e/pHW4CCE3FuDHdU+igFiyuJ5tFvaubkD4rBGI5FKvpuHoAf+c+Sc/ZOB0es8gBk5ZXH
 QaCA==
X-Gm-Message-State: AOJu0YxkKRciT+dJKpaX0htZZC6IDaL6OYWm2BFsjP9iUiiCRVYSuNaz
 V7woW7WeHXwCPgGhSZ3ieH3lUXuqHJiErW09RWsRQZ1y89wTwDgr+dxE1TZOboMl62455e810Q5
 5yxyPFQgUJg80WDjj55NAFUVvyxgFMX44mg/JH7CGapuWuGypUkw0
X-Received: by 2002:a05:600c:4fd1:b0:421:5597:ea27 with SMTP id
 5b1f17b1804b1-421562ed0damr26914165e9.22.1717598896484; 
 Wed, 05 Jun 2024 07:48:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH+cF7jfJiRYSJi9MRSB7eLiBxhQOWV6MuluiyfS1526cazmFDC+ZwSX3XOi4gkcw/5ajg34A==
X-Received: by 2002:a05:600c:4fd1:b0:421:5597:ea27 with SMTP id
 5b1f17b1804b1-421562ed0damr26913965e9.22.1717598896099; 
 Wed, 05 Jun 2024 07:48:16 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42158102aabsm25073515e9.13.2024.06.05.07.48.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 07:48:15 -0700 (PDT)
Date: Wed, 5 Jun 2024 16:48:14 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>, Bin Meng
 <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>, Daniel Henrique
 Barboza <dbarboza@ventanamicro.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Andrew Jones <ajones@ventanamicro.com>
Subject: Re: [PATCH 3/3] hw/riscv/virt-acpi-build.c: Update the HID of
 RISC-V UART
Message-ID: <20240605164814.0d79ef99@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240528073103.1075812-4-sunilvl@ventanamicro.com>
References: <20240528073103.1075812-1-sunilvl@ventanamicro.com>
 <20240528073103.1075812-4-sunilvl@ventanamicro.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Tue, 28 May 2024 13:01:03 +0530
Sunil V L <sunilvl@ventanamicro.com> wrote:

> RISC-V is going to use new HID RSCV0003 for generi UART. So, update the
> HID.

where does it come from?

> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  hw/riscv/virt-acpi-build.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/riscv/virt-acpi-build.c b/hw/riscv/virt-acpi-build.c
> index 47ec78e432..7f80368415 100644
> --- a/hw/riscv/virt-acpi-build.c
> +++ b/hw/riscv/virt-acpi-build.c
> @@ -192,7 +192,7 @@ acpi_dsdt_add_uart(Aml *scope, const MemMapEntry *uart_memmap,
>                      uint32_t uart_irq)
>  {
>      Aml *dev = aml_device("COM0");
> -    aml_append(dev, aml_name_decl("_HID", aml_string("PNP0501")));
> +    aml_append(dev, aml_name_decl("_HID", aml_string("RSCV0003")));

the only place I've found (that could serve as justification)
  https://github.com/riscv-non-isa/riscv-brs/blame/main/acpi.adoc

which mentions _CID and not _HID as it is in this patch

>      aml_append(dev, aml_name_decl("_UID", aml_int(0)));
>  
>      Aml *crs = aml_resource_template();


