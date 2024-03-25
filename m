Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC5D7C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 15:21:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rom8C-0000d1-Dl; Mon, 25 Mar 2024 11:21:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rom8A-0000bp-QV
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:20:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rom88-0007xl-VG
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 11:20:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711380054;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k2yJZFqqLtCwBlTPSlEy1nH9OBn79RPRDIv5w/yrVMw=;
 b=Wl54m29aX+qbqPeQ72e/ILMtHaEzBFvaptzAPfwui4GnWTTS8yx2EANT4V0WGUEjtbPrBh
 gpo4GJBvdIRaIhCpyXG0sKXV1ejB2XJ+Zn0vVaKtQBPRZKa3GzSLAM36GXXtZ0SeEvA3cw
 EXFw+Vgc/B+FB2bElrDhWBgfJO5kvWU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-3SSc9xXxNxSsNkUQFVzC5A-1; Mon, 25 Mar 2024 11:20:52 -0400
X-MC-Unique: 3SSc9xXxNxSsNkUQFVzC5A-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-41488775a3eso5878115e9.2
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 08:20:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711380052; x=1711984852;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k2yJZFqqLtCwBlTPSlEy1nH9OBn79RPRDIv5w/yrVMw=;
 b=Msgzx9nL2yRkhpceUXCul5U2kZ7LjcgrZQbqxgf05aIQDZbRB7CFGXuYW3ETq1puYI
 xZd6y+8tdfxRGKwz1l7041sGjq+U0i6mKw0ok5GZgpmb3jkMEQqLdD01uSew1UTItV80
 qVhdbMO0zF3X43BksC/zJ4i7VEhHXPW76K3g+sZXGBJoWiJyxXkxCUUXyxD9wQQbQKqK
 zjGTURKGzk4ajHyMrAlDsDsm2TGm4l9WY2kxrEJBvDGPKOekIQTw6MNLy35R7k7iAeRG
 OYImnFnORlZyY7RhFibhYtbsrER+LSbD3qXc5j7e0xw2BaR5aKbZeEzSzfNvgahehxb2
 Rr0g==
X-Gm-Message-State: AOJu0Yy09H7LaHPrg5/tlJ6rxM0a7dTzecSqbiCpfRm9uC8am2DN6cB2
 3g70bPoQRDZp1AKm94xlX5uJEWYkRkWG84mn+dF7ximaYslf8/kjDEbMjtCewSNbNeBBoYS4hVM
 n6VLDS1tAqlgNgUJ5s1A/7igXrDsTvs8SyoKw3tTuUQksozAI3v9z
X-Received: by 2002:a5d:5cc2:0:b0:33d:c5c5:9bc6 with SMTP id
 cg2-20020a5d5cc2000000b0033dc5c59bc6mr4210234wrb.54.1711380051827; 
 Mon, 25 Mar 2024 08:20:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuBC9+mONGdiE+5lYUOaJTDigEVIv2fo5DUFzVT8YY3yYyyvZMJVuUQrDpbDakI/L0tnUf6g==
X-Received: by 2002:a5d:5cc2:0:b0:33d:c5c5:9bc6 with SMTP id
 cg2-20020a5d5cc2000000b0033dc5c59bc6mr4210223wrb.54.1711380051478; 
 Mon, 25 Mar 2024 08:20:51 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 r25-20020adfa159000000b00341b69e9162sm9148103wrr.90.2024.03.25.08.20.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Mar 2024 08:20:50 -0700 (PDT)
Date: Mon, 25 Mar 2024 16:20:49 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, "Michael S . Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>
Subject: Re: [PATCH trivial for-9.0] hw/i386/fw_cfg.c: fix non-legacy smbios
 build
Message-ID: <20240325162049.46c2a758@imammedo.users.ipa.redhat.com>
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

stub supposedly should have handled that 
what configure options do you use to build 'minimal microvm'?

> 
> Fixes: b42b0e4daaa5 "smbios: build legacy mode code only for 'pc' machine"
> Signed-off-by: Michael Tokarev <mjt@tls.msk.ru>
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


