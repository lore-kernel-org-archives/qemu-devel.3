Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6EFAC3DA7E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 11:25:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYky8-0004h7-JF; Tue, 30 Jul 2024 07:24:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sYky7-0004gA-Ho
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 07:24:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sYky5-0001xA-9M
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 07:24:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722338675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8X8bjq/3ai/H7MS5YO/WvfPpMtT+MudOcS3FU2wnAmg=;
 b=SPXCMXPT2SilJipfJkvElyRK34o6zzWIQ5ddxNZMESmmACdhvzs4xveXjVVAzScXYYZ46L
 LMgYUoellJqwSXCNZCd7ry4z9rZfkThr6iZUJH8UUUj9Wf/9dCdIVE/CXZkgYx6w0b2GjY
 /Qd5nc9TjxF2BF0vuX0e2m7dF+2t+Do=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-6KVIqV3PPqOHI_33tOS-zg-1; Tue, 30 Jul 2024 07:24:33 -0400
X-MC-Unique: 6KVIqV3PPqOHI_33tOS-zg-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4281ca9f4dbso18087135e9.0
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 04:24:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722338672; x=1722943472;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8X8bjq/3ai/H7MS5YO/WvfPpMtT+MudOcS3FU2wnAmg=;
 b=kc6q38D+p4NYZ4tdeySn6Rwskwdb5/0rSun6/+YYbDPzZPO3d+idGvXe0Js+OPuTFa
 s82mcafOOXgRJuK02eA50fWuJbBfSPCXQBHYmTOAMb54UWlP67ugXbMOlpz2m01/r9wl
 d52ea0wQMIIx7hqKhlU6vXKLsx0kVuguAttjNtw4V7GAk/LlYJTQmyDCXVCm+Bg9cq9A
 o8LTcmhP0xLB/1JZ2yFT6V2Ae6X+Xd9DwMbaI9+HNa54+X640A+iO0pyFhVDJ25QLal/
 fCLUb0RLAm19zgsQgUlLtchUt/evOGK8VYvsdgBwS3dyJiseNZuOGuATXb4xBYzIIy/2
 bN0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuS2hT6EmMJ+zxhmeJwXeVXDNZ4xGA8iEb3Wo2yp+dCTXLIgK1r05jV0juUoSs2Q2HpktiJlgwgbZ/nBE/l3kxsNi7SwU=
X-Gm-Message-State: AOJu0Yx869zNUtgTbN7/1h82h+jAo4jBL0fiAJBhNzh23jy2k0KucGZJ
 ue1g5Yk11PM1DiLCRRGYM/Eht+V0UhC2M0wtOH/F8SBSjcA7/pYX2Tu/Jwi2oEOpQ/irwuNPyXm
 tgsS2jeXMop3Wkb/uZzt3/bB1n4v1PU0cparYnC6eXQkMFslKy567
X-Received: by 2002:a05:600c:4511:b0:424:a2be:c161 with SMTP id
 5b1f17b1804b1-42811da3ff2mr71535175e9.20.1722338672466; 
 Tue, 30 Jul 2024 04:24:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHRB6QABXzjf+/OlbIvLEiNfswDduiWR63EnhwhwCm8/rzXApsvNazCL9ktWG5SIag2bROfMg==
X-Received: by 2002:a05:600c:4511:b0:424:a2be:c161 with SMTP id
 5b1f17b1804b1-42811da3ff2mr71534985e9.20.1722338671949; 
 Tue, 30 Jul 2024 04:24:31 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42813e5067dsm121306335e9.16.2024.07.30.04.24.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 04:24:31 -0700 (PDT)
Date: Tue, 30 Jul 2024 13:24:30 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, Shiju Jose
 <shiju.jose@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>, Ani Sinha
 <anisinha@redhat.com>, Dongjiu Geng <gengdongjiu1@gmail.com>,
 linux-kernel@vger.kernel.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 6/7] acpi/ghes: update comments to point to newer
 ACPI specs
Message-ID: <20240730132430.44d9e4ae@imammedo.users.ipa.redhat.com>
In-Reply-To: <66c1ab4988589be99ae925c6361548f55fea58b0.1721630625.git.mchehab+huawei@kernel.org>
References: <cover.1721630625.git.mchehab+huawei@kernel.org>
 <66c1ab4988589be99ae925c6361548f55fea58b0.1721630625.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, 22 Jul 2024 08:45:58 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> There is one reference to ACPI 4.0 and several references
> to ACPI 6.x versions.
> 
> Update them to point to ACPI 6.5 whenever possible.

when it comes to APCI doc comments, they should point to
the 1st (earliest) revision that provides given feature/value/field/table.


> There's one reference that was kept pointing to ACPI 6.4,
> though, with HEST revision 1.
> 
> ACPI 6.5 now defines HEST revision 2, and defined a new
> way to handle source types starting from 12. According
> with ACPI 6.5 revision history:
> 
> 	2312 Update to the HEST table and adding new error
> 	     source descriptor - Table 18.2.
> 
> Yet, the spec doesn't define yet any new source
> descriptors. It just defines a different behavior when
> source type is above 11.
> 
> I also double-checked GHES implementation on an open
> source project (Linux Kernel). Currently upstream
> doesn't currently handle HEST revision, ignoring such
> field.
> 
> In any case, revision 2 seems to be backward-compatible
> with revison 1 when type <= 11 and just one error is
> contained on a HEST record.
> 
> So, while it is probably safe to update it, there's no
> real need. So, let's keep the implementation using
> an ACPI 6.4 compatible table, e. g. HEST revision 1.
> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> ---
>  hw/acpi/ghes.c | 48 ++++++++++++++++++++++++++++--------------------
>  1 file changed, 28 insertions(+), 20 deletions(-)
> 
> diff --git a/hw/acpi/ghes.c b/hw/acpi/ghes.c
> index 6075ef5893ce..ebf1b812aaaa 100644
> --- a/hw/acpi/ghes.c
> +++ b/hw/acpi/ghes.c
> @@ -45,9 +45,9 @@
>  #define GAS_ADDR_OFFSET 4
>  
>  /*
> - * The total size of Generic Error Data Entry
> - * ACPI 6.1/6.2: 18.3.2.7.1 Generic Error Data,
> - * Table 18-343 Generic Error Data Entry
> + * The total size of Generic Error Data Entry before data field
> + * ACPI 6.5: 18.3.2.7.1 Generic Error Data,
> + * Table 18.12 Generic Error Data Entry
>   */
>  #define ACPI_GHES_DATA_LENGTH               72
>  
> @@ -65,8 +65,8 @@
>  
>  /*
>   * Total size for Generic Error Status Block except Generic Error Data Entries
> - * ACPI 6.2: 18.3.2.7.1 Generic Error Data,
> - * Table 18-380 Generic Error Status Block
> + * ACPI 6.5: 18.3.2.7.1 Generic Error Data,
> + * Table 18.11 Generic Error Status Block
>   */
>  #define ACPI_GHES_GESB_SIZE                 20
>  
> @@ -82,7 +82,8 @@ enum AcpiGenericErrorSeverity {
>  
>  /*
>   * Hardware Error Notification
> - * ACPI 4.0: 17.3.2.7 Hardware Error Notification
> + * ACPI 6.5: 18.3.2.9 Hardware Error Notification,
> + * Table 18.14 - Hardware Error Notification Structure
>   * Composes dummy Hardware Error Notification descriptor of specified type
>   */
>  static void build_ghes_hw_error_notification(GArray *table, const uint8_t type)
> @@ -112,7 +113,8 @@ static void build_ghes_hw_error_notification(GArray *table, const uint8_t type)
>  
>  /*
>   * Generic Error Data Entry
> - * ACPI 6.1: 18.3.2.7.1 Generic Error Data
> + * ACPI 6.5: 18.3.2.7.1 Generic Error Data,
> + * Table 18.12 - Generic Error Data Entry
>   */
>  static void acpi_ghes_generic_error_data(GArray *table,
>                  const uint8_t *section_type, uint32_t error_severity,
> @@ -148,7 +150,8 @@ static void acpi_ghes_generic_error_data(GArray *table,
>  
>  /*
>   * Generic Error Status Block
> - * ACPI 6.1: 18.3.2.7.1 Generic Error Data
> + * ACPI 6.5: 18.3.2.7.1 Generic Error Data,
> + * Table 18.11 - Generic Hardware Error Source Structure
>   */
>  static void acpi_ghes_generic_error_status(GArray *table, uint32_t block_status,
>                  uint32_t raw_data_offset, uint32_t raw_data_length,
> @@ -429,15 +432,18 @@ void build_ghes_error_table(GArray *hardware_errors, BIOSLinker *linker)
>          0, sizeof(uint64_t), ACPI_GHES_ERRORS_FW_CFG_FILE, 0);
>  }
>  
> -/* Build Generic Hardware Error Source version 2 (GHESv2) */
> +/*
> + * Build Generic Hardware Error Source version 2 (GHESv2)
> + * ACPI 6.5: 18.3.2.8 Generic Hardware Error Source version 2 (GHESv2 - Type 10),
> + * Table 18.13: Generic Hardware Error Source version 2 (GHESv2)
> + */
>  static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
>  {
>      uint64_t address_offset;
> -    /*
> -     * Type:
> -     * Generic Hardware Error Source version 2(GHESv2 - Type 10)
> -     */
> +    /* Type: (GHESv2 - Type 10) */
>      build_append_int_noprefix(table_data, ACPI_GHES_SOURCE_GENERIC_ERROR_V2, 2);
> +
> +    /* ACPI 6.5: Table 18.10 - Generic Hardware Error Source Structure */
>      /* Source Id */
>      build_append_int_noprefix(table_data, source_id, 2);
>      /* Related Source Id */
> @@ -481,11 +487,8 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
>      /* Error Status Block Length */
>      build_append_int_noprefix(table_data, ACPI_GHES_MAX_RAW_DATA_LENGTH, 4);
>  
> -    /*
> -     * Read Ack Register
> -     * ACPI 6.1: 18.3.2.8 Generic Hardware Error Source
> -     * version 2 (GHESv2 - Type 10)
> -     */
> +    /* ACPI 6.5: fields defined at GHESv2 table */
> +    /* Read Ack Register */
>      address_offset = table_data->len;
>      build_append_gas(table_data, AML_AS_SYSTEM_MEMORY, 0x40, 0,
>                       4 /* QWord access */, 0);
> @@ -504,11 +507,16 @@ static void build_ghes_v2(GArray *table_data, int source_id, BIOSLinker *linker)
>      build_append_int_noprefix(table_data, 0x1, 8);
>  }
>  
> -/* Build Hardware Error Source Table */
> +/*
> + * Build Hardware Error Source Table
> + * ACPI 6.4: 18.3.2 ACPI Error Source
> + * Table 18.2: Hardware Error Source Table (HEST)
> + */
>  void acpi_build_hest(GArray *table_data, BIOSLinker *linker,
>                       const char *oem_id, const char *oem_table_id)
>  {
> -    AcpiTable table = { .sig = "HEST", .rev = 1,
> +    AcpiTable table = { .sig = "HEST",
> +                        .rev = 1,                   /* ACPI 4.0 to 6.4 */
>                          .oem_id = oem_id, .oem_table_id = oem_table_id };
>  
>      acpi_table_begin(&table, table_data);


