Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15E67C3ABCB
	for <qemu-devel@archiver.kernel.org>; Sun, 11 May 2025 18:11:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uEB8p-0003fY-F6; Sun, 11 May 2025 14:11:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uEB8c-0003cd-6f
 for qemu-devel@nongnu.org; Sun, 11 May 2025 14:11:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1uEB8Z-0001zC-U7
 for qemu-devel@nongnu.org; Sun, 11 May 2025 14:10:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746987053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=gFs4jfthcpyRIMK867LkDfDS7PHn2SlPNolDlaqYlDo=;
 b=C7D82y6z57WuZh5fGXdDhacA5fgEreczdiUbmuxCqV7DALIDkUuosZCcuHpv9JYeNX81n3
 TlmW9kmzD8BvFqfYadVFHX20/TpqWQ8/gMg6fiHVAz9O54xdNbcbFcwQidYAWnsv2pL4+p
 /1i6VRrC0NOCEhk1Y0BFlSKckfidZ3o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-17-JogPK75MOSCaiwE8FaLBdg-1; Sun, 11 May 2025 14:10:52 -0400
X-MC-Unique: JogPK75MOSCaiwE8FaLBdg-1
X-Mimecast-MFC-AGG-ID: JogPK75MOSCaiwE8FaLBdg_1746987051
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a2057d164bso97627f8f.1
 for <qemu-devel@nongnu.org>; Sun, 11 May 2025 11:10:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746987051; x=1747591851;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gFs4jfthcpyRIMK867LkDfDS7PHn2SlPNolDlaqYlDo=;
 b=qSaZxVioSCroCoCLguK932KQJ0gIGKaiQta9a7ptq3Z3OuCX6jvOnFYEdmGoCgxtZ5
 tHX01skOoExnmMKZnO6KfopBxz+V5vCfhnO2FhkK6zWjNKlIUzUboMM4KZH7723XtviV
 2BeF4ejgK4Si/mX3C+jY7twQTluchxl9C2NRMdaW4YJQvbbB4uU9LUGpDqd6MYhVKeqB
 2kjdXx2rMarMzYKOSFtuyZnU/I7i/VGSGX6QVMF3FBx/337VTN0pnyJh1vsTKLyU/Na8
 LR4fXZXMkNFzdi32vSQd6NHANMgzrqBI74HS0eigqJOtToorqI9MJD+SJ+/3oJe9knXW
 06Mw==
X-Gm-Message-State: AOJu0Yz3h+Ty+NpkK3F+THlHLYFYhqc1AI7bz+LwTC+3ESqtkIksSJFA
 XjTQYvJO3TMAfpI8YxngSohzvo3e/6BLHSFj3V0Q/uY9xger2wwMX02hqwDiLbzqj9fYgBlJlNV
 7FVd6+jJvWE9qevRNBnUggENNZVR5xL2Pyr97okle7abCb+OH9QNf
X-Gm-Gg: ASbGncsbqBdwM4cPEeLuUWqGxYQBNztUHGVk27mdTXCBePXSwWwl73GKx+EoiqV71yq
 gXuHqaxcNMUr/I+UfeqnapucqKewPpMG010UGHPpGudzL9YQguK/noskLXGiS5liHCWt8tqWtYj
 E5/1uGH92+GyjE/UMLK0Fotq5LlpNVLxHPddZVhmNJbfjUncYrZ3J9UtoXk8Yp0OsrAssGGeU+r
 ySKa/d+ccxz+km0JWuWbwfMlZpiIp3iPftLOKW/vs5VTRxti0dkQKCtRrLFxb0vZoXmyWtmtM1A
 WIJayg==
X-Received: by 2002:a5d:64e2:0:b0:3a0:b8b0:4418 with SMTP id
 ffacd0b85a97d-3a1f64a2ba3mr7908426f8f.50.1746987050854; 
 Sun, 11 May 2025 11:10:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEBTtpsMn7PTQSzqvPUsd/6Vj7KW8Cfq/Ruhz3tR/LMKk0TBu0nvVo4CBxq9ahmeAfRQu9cAQ==
X-Received: by 2002:a5d:64e2:0:b0:3a0:b8b0:4418 with SMTP id
 ffacd0b85a97d-3a1f64a2ba3mr7908404f8f.50.1746987050504; 
 Sun, 11 May 2025 11:10:50 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a1f58f28f7sm9782503f8f.41.2025.05.11.11.10.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 May 2025 11:10:49 -0700 (PDT)
Date: Sun, 11 May 2025 14:10:46 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: qemu-devel@nongnu.org, anisinha@redhat.com, imammedo@redhat.com,
 jonathan.cameron@huawei.com, linuxarm@huawei.com,
 peter.maydell@linaro.org, prime.zeng@hisilicon.com,
 shameerali.kolothum.thodi@huawei.com, wangyanan55@huawei.com,
 yangyicong@hisilicon.com
Subject: Re: [PATCH v4 3/4] hw/acpi/aml-build: Build a root node in the PPTT
 table
Message-ID: <20250511140938-mutt-send-email-mst@kernel.org>
References: <20250424122439.550-1-alireza.sanaee@huawei.com>
 <20250424122439.550-4-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250424122439.550-4-alireza.sanaee@huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -46
X-Spam_score: -4.7
X-Spam_bar: ----
X-Spam_report: (-4.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.587,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Apr 24, 2025 at 01:24:38PM +0100, Alireza Sanaee wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Currently we build the PPTT starting from the socket node and each
> socket will be a separate tree. For a multi-socket system it'll
> be hard for the OS to know the whole system is homogeneous or not
> (actually we're in the current implementation) since no parent node
> to telling the identical implementation informentation. Add a
> root node for indicating this.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Alireza Sanaee <alireza.sanaee@huawei.com>
> ---
>  hw/acpi/aml-build.c | 15 ++++++++++++++-
>  1 file changed, 14 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/acpi/aml-build.c b/hw/acpi/aml-build.c
> index 560cee12a24b..3010325ca423 100644
> --- a/hw/acpi/aml-build.c
> +++ b/hw/acpi/aml-build.c
> @@ -2153,12 +2153,25 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
>      int64_t socket_id = -1, cluster_id = -1, core_id = -1;
>      uint32_t socket_offset = 0, cluster_offset = 0, core_offset = 0;
>      uint32_t pptt_start = table_data->len;
> +    uint32_t root_offset;
>      int n;
>      AcpiTable table = { .sig = "PPTT", .rev = 2,
>                          .oem_id = oem_id, .oem_table_id = oem_table_id };
>  
>      acpi_table_begin(&table, table_data);
>  
> +    /*
> +     * Build a root node for all the processor nodes. Otherwise when
> +     * building a multi-socket system each socket tree are separated

is separated

> +     * and will be hard for the OS like Linux to know whether the
> +     * system is homogeneous.
> +     */
> +    root_offset = table_data->len - pptt_start;
> +    build_processor_hierarchy_node(table_data,
> +        (1 << 0) | /* Physical package */
> +        (1 << 4), /* Identical Implementation */
> +        0, 0, NULL, 0);
> +
>      /*
>       * This works with the assumption that cpus[n].props.*_id has been
>       * sorted from top to down levels in mc->possible_cpu_arch_ids().
> @@ -2175,7 +2188,7 @@ void build_pptt(GArray *table_data, BIOSLinker *linker, MachineState *ms,
>              build_processor_hierarchy_node(table_data,
>                  (1 << 0) | /* Physical package */
>                  (1 << 4), /* Identical Implementation */
> -                0, socket_id, NULL, 0);
> +                root_offset, socket_id, NULL, 0);
>          }
>  
>          if (mc->smp_props.clusters_supported && mc->smp_props.has_clusters) {
> -- 
> 2.34.1


