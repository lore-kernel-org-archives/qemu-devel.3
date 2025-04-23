Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76955C369CB
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 12:41:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7ZQ8-0006Pa-Cu; Wed, 23 Apr 2025 08:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u7ZPn-0006Ig-SF
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 08:41:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1u7ZPk-0004v9-Nm
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 08:41:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745412078;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ckZxkdJONfkosQCiOotJl1yLuDu8kBbsgLD3xp62fxA=;
 b=V74Lh4TTGIfQwL+U1pCI82fvBiFaheMRmylh3uxhhCj3iSl3E1levo2J/BZq0ZL300YQJv
 9PJT1F4VfvTK2b8aideQr0/hVvkapzK/tgBNDEBsALXjKN+FjlQxxnfaAahyHe8vtPEFY+
 qsf++ws6fExhSUpDqEXDma7gEJAAOpg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-643-GMoIc3ciNwyJ3Hea60OVmA-1; Wed, 23 Apr 2025 08:41:17 -0400
X-MC-Unique: GMoIc3ciNwyJ3Hea60OVmA-1
X-Mimecast-MFC-AGG-ID: GMoIc3ciNwyJ3Hea60OVmA_1745412076
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43d01024089so40993405e9.1
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 05:41:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745412076; x=1746016876;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ckZxkdJONfkosQCiOotJl1yLuDu8kBbsgLD3xp62fxA=;
 b=R1lRY+6FD2EuKqwRreqZFwFtn+swDvWZXhwj9UK/61yqc5U9O3oFjGrCobt6GIPQ2Q
 NrqqDy0zvGvMzxZPau8ktvUijDFYdGGJp/TUEGxbbYPegLyCFo2vPlIMYLX9w7nkSedO
 EsDl0aknqUwkhtVBgYM98LBNQzAYL2Ej4nCMR2HeoIkpwGPH7rhSZA3cQJPmcar507Id
 0GTZyFsE12+ujAW/xyCEMoDXpWw0E9NIWVHXETKLCPj3oS0cWEey+p+uJsXvz+T+XiCh
 v6nGQp+3/jV2K8ZO/k1KzBgSyq7kYNc84yWjt7KFLvIbKG99nb1e7bfuIdH1jqziMnHR
 mT0Q==
X-Gm-Message-State: AOJu0YwDTaOC61SDp0oM/hE6lVylLgYRQOPCWP183ZYgI3uO9ejuOXGM
 LatgbZnwnpZCfmTK3Sthmw7kohMgCC7fljZ3nrzdiYLd0wEgoOxncedZeD+tb5HoscC8fk/3Mei
 +F8s8ipxxU7I9adOpcqy/eibcLr28wnYNZ4Awpn3r3xz2jkn2UOMa
X-Gm-Gg: ASbGncvMkDgPONz+ZpqH8BZWclinLujBFKVMB00/3dGaNBVKurbWBPBabQYsGQqRbwn
 pPsN6gTv0j2jGl1kvWSOwejl1Y+brH9k87+N7Ha0zjZFsXQSNAuSgEMVJZTt8cuPrvjuxIWPP43
 AMXe4uz84AffR7OUGECJZ5wxcQ6wM8ohiOtHrlUq5TZCoDGeudVFCzh+zxUU+F2WPpC6m+ICZWo
 4AumUVRfhlD+dmIM7LXeu23N1S/BafSVyGplpgPKrrESErRzt00Y3+WZqqSYWGyUsGSevQUJPMu
 eCD6Qw==
X-Received: by 2002:a05:600c:a016:b0:440:68db:a013 with SMTP id
 5b1f17b1804b1-4407df92607mr98928005e9.25.1745412075991; 
 Wed, 23 Apr 2025 05:41:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH8QrBM4nLHoET6uBaaREp6izqQLa1MJl1CtF6vKrXS7h2MKpI9SGeNCNWHGjCoPSGdJZbzeA==
X-Received: by 2002:a05:600c:a016:b0:440:68db:a013 with SMTP id
 5b1f17b1804b1-4407df92607mr98927715e9.25.1745412075561; 
 Wed, 23 Apr 2025 05:41:15 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1517:1000:ea83:8e5f:3302:3575])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092d2e97dsm25489555e9.18.2025.04.23.05.41.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Apr 2025 05:41:14 -0700 (PDT)
Date: Wed, 23 Apr 2025 08:41:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: qemu-devel@nongnu.org, anisinha@redhat.com, imammedo@redhat.com,
 jonathan.cameron@huawei.com, linuxarm@huawei.com,
 peter.maydell@linaro.org, prime.zeng@hisilicon.com,
 shameerali.kolothum.thodi@huawei.com, wangyanan55@huawei.com,
 yangyicong@hisilicon.com
Subject: Re: [PATCH v3 3/5] hw/acpi/aml-build: Build a root node in the PPTT
 table
Message-ID: <20250423084013-mutt-send-email-mst@kernel.org>
References: <20250423114130.902-1-alireza.sanaee@huawei.com>
 <20250423114130.902-4-alireza.sanaee@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250423114130.902-4-alireza.sanaee@huawei.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Apr 23, 2025 at 12:41:28PM +0100, Alireza Sanaee wrote:
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

so how does the topology look before and after this change?


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

is separated?

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


