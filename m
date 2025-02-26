Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06FC5C18E7C
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Feb 2025 14:49:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnIhp-0000rs-OG; Wed, 26 Feb 2025 09:48:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tnIhn-0000rC-3R
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:48:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tnIhl-00048O-1t
 for qemu-devel@nongnu.org; Wed, 26 Feb 2025 09:48:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740581287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8vkoWrSDvFL6bPp2+SBWRgFUy47QB4e69nH0NyHiTjI=;
 b=eNSAQejS8YDpN0HZS2c487yHC/O1DzLsXq2aqPa5fd8npugBUiNiJ6S8+GEOaqaObti22C
 7UKKWYAldTatGfv046RDm0G6Nn4FKjikK4UpYM2v/FsFXlyX+K0UXgFmxn41L7EpeYR+As
 0+5Efl4BkkJpZyGlyvQl4gxN1IBlT1k=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-1YuQLvmwNEywKOWi2hg5Sw-1; Wed, 26 Feb 2025 09:48:05 -0500
X-MC-Unique: 1YuQLvmwNEywKOWi2hg5Sw-1
X-Mimecast-MFC-AGG-ID: 1YuQLvmwNEywKOWi2hg5Sw_1740581284
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-390d5f1e05cso338965f8f.3
 for <qemu-devel@nongnu.org>; Wed, 26 Feb 2025 06:48:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740581284; x=1741186084;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8vkoWrSDvFL6bPp2+SBWRgFUy47QB4e69nH0NyHiTjI=;
 b=GVOYMxJ+5vynlJK+Us3tCnPAuoJzG1qBbT+8N69OMTXIx7gnQg7sIH7XA51vmbVEZy
 ABVP4nGjq/Kus7SGAGSx/yfis29YRuxsoAM/Cwq7ZyBLCUhUInUb6EnVG1Wc55rFuOJI
 SBKAmq1UrQyhOhuwL2qxiMWOH37+GwRwS/YR3BG43BYEKlQlGOVeKteb92F+3iB5C0FB
 ymPWGopiAod0fmRa9nADx266BoUe8EJLwWgk/VgLRTwDfOg3AsyEljj3CtG7vWtMXq3+
 QWPkwZIeplii9TcmhQy6IVcJH94aFB9rgz+kYrwrEBSAtMmhkjHZ5m3LIsUkEzO3aY/o
 qnEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDxo/ayULRny8rRLDNjzSPctNiH/ZHQc9qL75Q4GMCvFS9zqYxUCXrbFvJ6h0v1O6stYRHFvVuxL5w@nongnu.org
X-Gm-Message-State: AOJu0Yzq7ILjXkLR15wx3kBlKrRNVe/D1yVjUH0ZTjHahZeKPewC0ixe
 wG2gDqF5lxwgn/ilpvS1mo3oXJBlT/FlB4QllB6z6y5dhljIHTrYr4fWwAPAx+eiwhzZ3K8Es40
 u2zzuYgWPwyYDjyurOIENqH9qAU9oTbGcfuCOU+WSn51ZoD6PMxal
X-Gm-Gg: ASbGnctY+0w12ID2jjZ6zsdlp1kbbrUsWQoLnDhbQzemumSrypD0jRzW/huykMBzV0z
 iDHCrgIcv96V4SDXZUOAw0XL63B9at0TnCQJcmXH+NeZfGAApFvvLU78B4hknHK68tppZMys4Up
 UBILxFoa6jRHDtc8YE+sSXr0551PK5now0w7aQzFgNGbHFvfSmNcg6MJ8sn2Nm+tD7jlHdcQ1hp
 pKkF8G59DCPfhUHFpDDYAc6OTLsVWubL3GCgkLclIhQE/F73gPj0r9ajMwD3+72vgLOxSZZe7/j
 hiXGLu2LXTlPY3bxSzJByV+RQ9Q9HT2JIrQw5p9yS1CX/vM7nzzff86Ibs4dD38=
X-Received: by 2002:a05:6000:1541:b0:38f:38eb:fcff with SMTP id
 ffacd0b85a97d-390cc60a682mr6467907f8f.29.1740581284331; 
 Wed, 26 Feb 2025 06:48:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHt0IdIIux70KZSKj21MuPK89m+sivEs5JGNzpiw8G6lG8AV6fs8fa3K3La96P0ieYxPdZd0Q==
X-Received: by 2002:a05:6000:1541:b0:38f:38eb:fcff with SMTP id
 ffacd0b85a97d-390cc60a682mr6467878f8f.29.1740581283918; 
 Wed, 26 Feb 2025 06:48:03 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd8e725dsm5991101f8f.63.2025.02.26.06.48.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Feb 2025 06:48:03 -0800 (PST)
Date: Wed, 26 Feb 2025 15:48:02 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 02/14] acpi/ghes: add a firmware file with HEST address
Message-ID: <20250226154802.58d865a8@imammedo.users.ipa.redhat.com>
In-Reply-To: <0866291724e8c276c5f7066991ce08250d7857d3.1740148260.git.mchehab+huawei@kernel.org>
References: <cover.1740148260.git.mchehab+huawei@kernel.org>
 <0866291724e8c276c5f7066991ce08250d7857d3.1740148260.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Fri, 21 Feb 2025 15:35:11 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Store HEST table address at GPA, placing its the start of the table at
> hest_addr_le variable.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/acpi/ghes.c         | 22 ++++++++++++++++++++--
>  include/hw/acpi/ghes.h |  7 ++++++-
>  2 files changed, 26 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index e49a03fdb94e..ba37be9e7022 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -30,6 +30,7 @@
>  
>  #define ACPI_HW_ERROR_FW_CFG_FILE           "etc/hardware_errors"
>  #define ACPI_HW_ERROR_ADDR_FW_CFG_FILE      "etc/hardware_errors_addr"
> +#define ACPI_HEST_ADDR_FW_CFG_FILE          "etc/acpi_table_hest_addr"
>  
>  /* The max size in bytes for one error block */
>  #define ACPI_GHES_MAX_RAW_DATA_LENGTH   (1 * KiB)
> @@ -341,6 +342,9 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
>  {
>      AcpiTable table = { .sig = "HEST", .rev = 1,
>                          .oem_id = oem_id, .oem_table_id = oem_table_id };
> +    uint32_t hest_offset;
> +
> +    hest_offset = table_data->len;
>  
>      build_ghes_error_table(ags, hardware_errors, linker);
>  
> @@ -352,6 +356,17 @@ void acpi_build_hest(AcpiGhesState *ags, GArray *table_data,
>                    ACPI_GHES_NOTIFY_SEA, ACPI_HEST_SRC_ID_SEA);
>  
>      acpi_table_end(linker, &table);
> +
> +    if (ags->use_hest_addr) {
> +        /*
> +         * Tell firmware to write into GPA the address of HEST via fw_cfg,
> +         * once initialized.
> +         */
> +        bios_linker_loader_write_pointer(linker,
> +                                         ACPI_HEST_ADDR_FW_CFG_FILE, 0,
> +                                         sizeof(uint64_t),
> +                                         ACPI_BUILD_TABLE_FILE, hest_offset);
> +    }
>  }
>  
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> @@ -361,7 +376,10 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>      fw_cfg_add_file(s, ACPI_HW_ERROR_FW_CFG_FILE, hardware_error->data,
>                      hardware_error->len);
>  
> -    if (!ags->use_hest_addr) {
> +    if (ags->use_hest_addr) {
> +        fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
> +            NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
> +    } else {
>          /* Create a read-write fw_cfg file for Address */
>          fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
>              NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
> @@ -501,7 +519,7 @@ bool acpi_ghes_present(void)
>          return false;
>      }
>      ags = &acpi_ged_state->ghes_state;
> -    if (!ags->hw_error_le)
> +    if (!ags->hw_error_le && !ags->hest_addr_le)
>          return false;
>  
>      return true;
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index a3d62b96584f..454e97b5341c 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -71,9 +71,14 @@ enum {
>   * meaning an offset from the etc/hardware_errors firmware address. This
>   * is the default on QEMU 9.x.
>   *
> - * An offset value equal to zero means that GHES is not present.

> + * When use_hest_addr is true, the stored offset is placed at hest_addr_le,
> + * meaning an offset from theHEST table address from etc/acpi/tables firmware.
                             ^^^^^^ missing whitespace

'offset' language is confusing here, is asks for explanation offset from what?

what is kept in hest_addr_le is GPA of HEST table, it would be better to address
wording here.
The same applies to similar comment in previous patch

> + * This is the default for QEMU 10.x and above.
> + *
> + * If both offset values are equal to zero, it means that GHES is not present
>   */
>  typedef struct AcpiGhesState {
> +    uint64_t hest_addr_le;
>      uint64_t hw_error_le;
>      bool use_hest_addr;         /* Currently, always false */
>  } AcpiGhesState;


