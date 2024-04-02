Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54D15C6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 10:04:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrazg-0007Ar-L6; Tue, 02 Apr 2024 06:03:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rrayw-0006ex-2U
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 06:03:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1rrays-0002IE-6d
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 06:03:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712052179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+jt2f6hEUXWAc0F21N/nI3NazjW/SSDHRA3MxvTFR/4=;
 b=TTlUWe/CaV82MuOu9ZjXdX+W+0d/E91j1oSFJb2IX70P/ODHTwdcSF7hApo1ZfrAK2RCKs
 Ve8xdkTCQWjzBVGR58/fE2aG1XXaktCKn/sZIHr75A1cAqWxOeCJBTujin6sQZzVp9qSU1
 FBk5TdidumYX3711OYDifgxgwq6kqUE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-NMU7G0TwOF-8QaLXNvwTxw-1; Tue, 02 Apr 2024 06:02:58 -0400
X-MC-Unique: NMU7G0TwOF-8QaLXNvwTxw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2d45c064742so50757531fa.3
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 03:02:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712052176; x=1712656976;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+jt2f6hEUXWAc0F21N/nI3NazjW/SSDHRA3MxvTFR/4=;
 b=BzkPQGdE0f7riHz5TJtd5c3dXeDBqDB51BVaKtRyWwk9tGJmUWku6cp3+6cyl2xszP
 PKUDR1aDX2TEcbrMY8QGJg5xRXsbykhosRgBJDceC9MG4qDivr1DxZirL9vvnoEYNeGt
 CIJIQgN5hkS1An12IXuSU8KAisxnOp2yzUIazlCnwlGs7BOBgwBYBhKI2xPaQDNnNzGy
 oGoSZcfBV7rjR/sgOXdV8R5WBZ5yua6rpRGgD4LwWqzUafXa3bAgpmXV7l4kdl70Lwx4
 JC05MG6q0c1fcN7+1bqMbTpU5o3nAx7gv8U0mwzRah1GiQ2uG6f7JZ6NjODQvOXWH5PI
 CG/A==
X-Forwarded-Encrypted: i=1;
 AJvYcCWDpsrHjaePk88Ifh6/AgLQkWsaWjyB7Km0uycvOtac760+mtwPoLVcOsjPdLhiLHwZN6VtZwY5MO1+9DeCHw/VZ1yHwcw=
X-Gm-Message-State: AOJu0Yxnjg6J/aJbCxt4grzm13H/cW+drHIBfdsNK+vmskRheJ+7I4Nb
 5mFxT8YxRPqpjp70LYjCpZNow5YH2Y08kSJazumJ//Ij5c4Oey4vsWeUKrCRQhP45EX3OIjDuFj
 cDwzsaQMhr7Yq0S68+JPNzcnscFRPEcvk75FRJyEO5OMgqPgEPc7I8GFVZpn9kRM=
X-Received: by 2002:a2e:9c82:0:b0:2d2:b840:1c78 with SMTP id
 x2-20020a2e9c82000000b002d2b8401c78mr7450960lji.48.1712052176018; 
 Tue, 02 Apr 2024 03:02:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvB0FoBIR31Y+Fb3awN2DD+lf/4knp9Fx+bfE38ziLOfnH9lcu+Bq8TXXCpB5zpf5qc+uMcg==
X-Received: by 2002:a2e:9c82:0:b0:2d2:b840:1c78 with SMTP id
 x2-20020a2e9c82000000b002d2b8401c78mr7450941lji.48.1712052175422; 
 Tue, 02 Apr 2024 03:02:55 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1f4:2fbc:c1b6:60e7:b08c:a69d])
 by smtp.gmail.com with ESMTPSA id
 r15-20020a05600c35cf00b004156c501e24sm3753051wmq.12.2024.04.02.03.02.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Apr 2024 03:02:55 -0700 (PDT)
Date: Tue, 2 Apr 2024 06:02:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xiaoyao Li <xiaoyao.li@intel.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org,
 isaku.yamahata@intel.com
Subject: Re: [PATCH] hw/i386/acpi: Set PCAT_COMPAT bit only when pic is not
 disabled
Message-ID: <20240402060109-mutt-send-email-mst@kernel.org>
References: <20240402082516.2921143-1-xiaoyao.li@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240402082516.2921143-1-xiaoyao.li@intel.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Apr 02, 2024 at 04:25:16AM -0400, Xiaoyao Li wrote:
> Set MADT.FLAGS[bit 0].PCAT_COMPAT based on x86ms->pic.
> 
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>

Please include more info in the commit log:
what is the behaviour you observe, why it is wrong,
how does the patch fix it, what is guest behaviour
before and after.

The commit log and the subject should not repeat
what the diff already states.

> ---
>  hw/i386/acpi-common.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/i386/acpi-common.c b/hw/i386/acpi-common.c
> index 20f19269da40..0cc2919bb851 100644
> --- a/hw/i386/acpi-common.c
> +++ b/hw/i386/acpi-common.c
> @@ -107,7 +107,9 @@ void acpi_build_madt(GArray *table_data, BIOSLinker *linker,
>      acpi_table_begin(&table, table_data);
>      /* Local APIC Address */
>      build_append_int_noprefix(table_data, APIC_DEFAULT_ADDRESS, 4);
> -    build_append_int_noprefix(table_data, 1 /* PCAT_COMPAT */, 4); /* Flags */
> +    /* Flags. bit 0: PCAT_COMPAT */
> +    build_append_int_noprefix(table_data,
> +                              x86ms->pic != ON_OFF_AUTO_OFF ? 1 : 0 , 4);
>  
>      for (i = 0; i < apic_ids->len; i++) {
>          pc_madt_cpu_entry(i, apic_ids, table_data, false);
> -- 
> 2.34.1


