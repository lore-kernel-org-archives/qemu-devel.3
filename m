Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E365CC54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 15:30:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1romGv-0005H9-1i; Mon, 25 Mar 2024 11:30:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1romGt-0005GB-Qq
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:29:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1romGs-0000Jn-Dj
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:29:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711380597;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kXdhjWLcZVSrCzqzMNe5+sdh72XKz5BSXFIujU5V2iM=;
 b=Asp2GfjlLjWzmmJF89IT4atIuq2jDDoUVmwwhMWa8HJ04olZEBcgw3pdFT+zRzKSQnpEez
 jCVHR6CVucNb22thsFLZE2nMqjgbzR92RjhRFNmMumPVXzkFeQo2et59L+vvd0PB5QuhEz
 F9IBelGhWMW5sJ+hVFZRMOTAeLmo4QM=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-Kr6rugYKPmeJOAqQMxvPFw-1; Mon, 25 Mar 2024 11:29:53 -0400
X-MC-Unique: Kr6rugYKPmeJOAqQMxvPFw-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2d48b182917so46259731fa.1
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 08:29:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711380592; x=1711985392;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kXdhjWLcZVSrCzqzMNe5+sdh72XKz5BSXFIujU5V2iM=;
 b=V0Y1MfnMsUh4WBKJJMlTbltlZ/2oviEnOKyyxjbh9FERI1/ZUI1zSPWYuuuaJf4IRs
 fsviexZl3U2LlsFGxwAcW3NZGoNxV/T4/qz63vkTl2MMz5OhT5zzXPbX2TXLDRInDU3w
 lPsD+QtUWFTPmfyraB7RY9O+AUgMyWv4Wp7LNqIRtdGkdjIVZ/mPNU9Da4dPLxps4Z5Y
 seNydW0OjOEtcXrAd5AYvQV1U7VYo8ZyjjTkaQvsg03eQFFfYDlWmkhkAoRGM3JD85Oz
 3md+gJWg8Xeags5ZztHsh0TSzMKplEa1JwnmqAmLRWreB8p0xrfxR/WI8f4H67W3k3aT
 C6oQ==
X-Gm-Message-State: AOJu0YxxlULbLLxU0CRICVxo1ouj8IYTB4e+jX51meHDkB94mMqdmOS8
 ifU60ZYJa1qOGo5gUxLoqpjMigRJL1l2rV8HbIOSQi7A/EZDjikgakTdQKsphaw9CuiOymif0jd
 fYxYgXFSqV0DtLAcC+JMlUoioe1aHswfd7SUZo5Wqd88WpQoFMH3K
X-Received: by 2002:a2e:7a0e:0:b0:2d6:cb40:e0a2 with SMTP id
 v14-20020a2e7a0e000000b002d6cb40e0a2mr98616ljc.53.1711380592407; 
 Mon, 25 Mar 2024 08:29:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHePtAuOG+6IWrEAQOeI4+FXXtjMz3xtZeNU9g/eXmDML9zOpwT7pAfuR78Cz1uUtTNtQxWlw==
X-Received: by 2002:a2e:7a0e:0:b0:2d6:cb40:e0a2 with SMTP id
 v14-20020a2e7a0e000000b002d6cb40e0a2mr98594ljc.53.1711380592053; 
 Mon, 25 Mar 2024 08:29:52 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 k2-20020a2e8882000000b002d2a710f864sm1498636lji.24.2024.03.25.08.29.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 08:29:51 -0700 (PDT)
Date: Mon, 25 Mar 2024 16:29:50 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, "Michael S . Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH trivial for-9.0] hw/i386/fw_cfg.c: fix non-legacy smbios
 build
Message-ID: <20240325162950.0b8f29c5@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240325130920.349521-1-mjt@tls.msk.ru>
References: <20240325130920.349521-1-mjt@tls.msk.ru>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.065,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Mon, 25 Mar 2024 16:09:20 +0300
Michael Tokarev <mjt@tls.msk.ru> wrote:

> When building qemu with smbios but not legacy mode (eg minimal microvm build),
> link fails with:
> 
>   hw/i386/fw_cfg.c:74: undefined reference to `smbios_get_table_legacy'
> 
> This is because fw_cfg interface can call this function if CONFIG_SMBIOS
> is defined.  Made this code block to depend on CONFIG_SMBIOS_LEGACY.
> 
> Fixes: b42b0e4daaa5 "smbios: build legacy mode code only for 'pc' machine"
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>


hmh, it looks like MICROVM doesn't select SMBIOS nor FW_CFG_DMA

which looks broken to me,
does following help:

diff --git a/hw/i386/Kconfig b/hw/i386/Kconfig
index a6ee052f9a..54c77b5bcc 100644
--- a/hw/i386/Kconfig
+++ b/hw/i386/Kconfig
@@ -119,6 +119,8 @@ config MICROVM
     select PCI_EXPRESS_GENERIC_BRIDGE
     select USB_XHCI_SYSBUS
     select I8254
+    select SMBIOS
+    select FW_CFG_DMA
 
 config X86_IOMMU
     bool


> ---
>  hw/i386/fw_cfg.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
> index d802d2787f..d5e78a9183 100644
> --- a/hw/i386/fw_cfg.c
> +++ b/hw/i386/fw_cfg.c
> @@ -70,6 +70,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
>      /* tell smbios about cpuid version and features */
>      smbios_set_cpuid(cpu->env.cpuid_version, cpu->env.features[FEAT_1_EDX]);
>  
> +#ifdef CONFIG_SMBIOS_LEGACY
>      if (pcmc->smbios_legacy_mode) {
>          smbios_tables = smbios_get_table_legacy(&smbios_tables_len,
>                                                  &error_fatal);
> @@ -77,6 +78,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
>                           smbios_tables, smbios_tables_len);
>          return;
>      }
> +#endif
>  
>      /* build the array of physical mem area from e820 table */
>      mem_array = g_malloc0(sizeof(*mem_array) * e820_get_num_entries());


