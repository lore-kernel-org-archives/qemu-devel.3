Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFDF1C02194
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2025 13:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tewi6-0001ks-CD; Mon, 03 Feb 2025 08:41:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tewi4-0001kd-RT
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 08:41:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tewi3-0003fm-AJ
 for qemu-devel@nongnu.org; Mon, 03 Feb 2025 08:41:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738590113;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dhBJ+hCaRcSX/GLOKrl8eXDZTHXwWK2qzC6ZUGkMnLM=;
 b=GXx9BVNjlJCe0baUQwpOMKvnZ2lUAU53iPaHhVSda9o9qpg6HxIx0SQxfN70Z3o9msY3SG
 VCDqBrLQj1BPd74gw9x2tBRvNXE56IkwhbxiHVCzWRCa4j1Ah0hiIdWnBsDss+dUEAdDw2
 VfaRRR8o8RlRvYfXM0rpCnDDFtnUgeM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-659-i03gYJjhNRuZdjQ1Le98ig-1; Mon, 03 Feb 2025 08:41:50 -0500
X-MC-Unique: i03gYJjhNRuZdjQ1Le98ig-1
X-Mimecast-MFC-AGG-ID: i03gYJjhNRuZdjQ1Le98ig
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-385e03f54d0so1757794f8f.3
 for <qemu-devel@nongnu.org>; Mon, 03 Feb 2025 05:41:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738590109; x=1739194909;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dhBJ+hCaRcSX/GLOKrl8eXDZTHXwWK2qzC6ZUGkMnLM=;
 b=XhUvHUq6At/Ht6ZHVnBs/JLbF06Q/hTT6/Y2m1W7lgxofcQQpfxEgVr0A0NLzm9w9O
 RlHvQ+z9bik3jaNGzqtEAPSMPIK8ANVh3XBCwtU8pVRiNPQBH767uvgRDIiHf5QsDoHr
 +IT+NHV0e7hzV91dPlSID5MD9DLrvlfMeIs3VbEUmNaY2m/noU3gXlGH6Q9t+Uo1zs5/
 8HXuNeraJ1g+NS2X4WJktNDl2AvA/W3niNeYYK8s5bepgus7VMEwv42B9T/LMbnO3MX5
 rneyLHIfJWIwDvf0N0jXuMg9QOd1ncLzEief9NRoAh6nMU/V57Vo1E77oMpgJG1Kh3Bm
 yyMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXm/q2fDx817R4A8rVQqkIBW6sfEkXNfXdtEpHdQJSO/7YTG0XDt3XPWxnkoAQE6oO1LqMhNqm0BxSf@nongnu.org
X-Gm-Message-State: AOJu0YzzZlLBA/rHmMhvCG8LwDwBAzlMsL2shVigZxBvH5cMLKd09Nv4
 ncW1g4T1ecJjUbolZNUspe5aorMf4tVvYXX3UHNW1ZFfcnMF0rdy6osSfc7EReo6Up85S46b7hv
 TJIdeUmqn8pJyVDeW8dSLhJ3n9+lpI4BqAV+RQSnwigVc7xLrTZhG
X-Gm-Gg: ASbGnctdWNKioKgrZ8ymi/BaXYJAr5Ra6zBGqAcIVVuHdCG5yZbWcNw6vg6ufID+X5B
 TrZpYDT3MGljjottXHL3zQvLBtF0ZBjRmP+PNVYpRynZb1Wt4Lr3wZJUGkJ1WG/CydwakH3kmM1
 ALJmhNQANJS7epXc33hiPfxDx40uHuvMnPGcLCTEGcgL0Q4pDQPmV+4d6UuX/U5E0PhqUDs5swd
 9xbsLc7eHgzJp2hTNi3/SKAplLGAu19cxB0BM7HTfmQGFS6VLeIyn+kkwz3MebA3Rx2F1tpgiqE
 qdq/LyA6M1N9iPsscR2IpXkrP7nSQXXCLURpyyVYkhcO3NDB+WC3
X-Received: by 2002:a5d:6c66:0:b0:382:6f3:a20f with SMTP id
 ffacd0b85a97d-38c51930efdmr16806879f8f.11.1738590108838; 
 Mon, 03 Feb 2025 05:41:48 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFseaFy2uoghFvsLt3OCFWC6qb8SE+SmhTMyVZiVfT94VaAqxVWgt+Vb4X+ABRz55jVdTlA4A==
X-Received: by 2002:a5d:6c66:0:b0:382:6f3:a20f with SMTP id
 ffacd0b85a97d-38c51930efdmr16806854f8f.11.1738590108485; 
 Mon, 03 Feb 2025 05:41:48 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438e23de772sm154182255e9.13.2025.02.03.05.41.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Feb 2025 05:41:47 -0800 (PST)
Date: Mon, 3 Feb 2025 14:41:46 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/14] acpi/ghes: add a firmware file with HEST address
Message-ID: <20250203144146.67655189@imammedo.users.ipa.redhat.com>
In-Reply-To: <5082df62da57450674413f13c20e937330676a0a.1738345063.git.mchehab+huawei@kernel.org>
References: <cover.1738345063.git.mchehab+huawei@kernel.org>
 <5082df62da57450674413f13c20e937330676a0a.1738345063.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
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
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, 31 Jan 2025 18:42:43 +0100
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Store HEST table address at GPA, placing its the start of the table at
> hest_addr_le variable.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  hw/acpi/ghes.c         | 16 ++++++++++++++++
>  include/hw/acpi/ghes.h |  1 +
>  2 files changed, 17 insertions(+)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 4cabb177ad47..27478f2d5674 100644
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
> @@ -349,8 +350,11 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>  {
>      AcpiTable table = { .sig = "HEST", .rev = 1,
>                          .oem_id = oem_id, .oem_table_id = oem_table_id };
> +    uint32_t hest_offset;
>      int i;
>  
> +    hest_offset = table_data->len;
> +
>      build_ghes_error_table(hardware_errors, linker, num_sources);
>  
>      acpi_table_begin(&table, table_data);
> @@ -362,6 +366,15 @@ void acpi_build_hest(GArray *table_data, GArray *hardware_errors,
>      }
>  
>      acpi_table_end(linker, &table);
> +
> +    /*
> +     * Tell firmware to write into GPA the address of HEST via fw_cfg,
> +     * once initialized.
> +     */
> +    bios_linker_loader_write_pointer(linker,
> +                                     ACPI_HEST_ADDR_FW_CFG_FILE, 0,
> +                                     sizeof(uint64_t),
> +                                     ACPI_BUILD_TABLE_FILE, hest_offset);
>  }
>  
>  void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
> @@ -375,6 +388,9 @@ void acpi_ghes_add_fw_cfg(AcpiGhesState *ags, FWCfgState *s,
>      fw_cfg_add_file_callback(s, ACPI_HW_ERROR_ADDR_FW_CFG_FILE, NULL, NULL,
>          NULL, &(ags->hw_error_le), sizeof(ags->hw_error_le), false);
>  
> +    fw_cfg_add_file_callback(s, ACPI_HEST_ADDR_FW_CFG_FILE, NULL, NULL,
> +        NULL, &(ags->hest_addr_le), sizeof(ags->hest_addr_le), false);
> +
>      ags->present = true;
>  }
>  
> diff --git a/include/hw/acpi/ghes.h b/include/hw/acpi/ghes.h
> index 9f0120d0d596..237721fec0a2 100644
> --- a/include/hw/acpi/ghes.h
> +++ b/include/hw/acpi/ghes.h
> @@ -58,6 +58,7 @@ enum AcpiGhesNotifyType {
>  };
>  
>  typedef struct AcpiGhesState {
> +    uint64_t hest_addr_le;
>      uint64_t hw_error_le;
>      bool present; /* True if GHES is present at all on this board */
>  } AcpiGhesState;


