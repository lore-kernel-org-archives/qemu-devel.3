Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57964C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 11:15:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh6Hf-0005r7-2p; Mon, 04 Mar 2024 06:15:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rh6Hd-0005qQ-GW
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 06:15:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rh6HW-0001TE-Jo
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 06:15:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709550892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9PogRwBzpxY83qcL/GnKChzqfLdsnwasrcAqLf98QYQ=;
 b=W5gN4jx0c9+CBUKc28un/WkFtZvJ8g9PlIPnIhCEwek9IHX19Kh3UdDGVYM1AjFXLh4T5k
 tqhCpH9Cmvj0GqQUuHywOKvuLUljiPWM94/kJv+4IbcssQWc1h6exjgMk/N4wOvztkCh1J
 5GoyJVxuWHbRwkKo7ukntcEY91vM/jM=
Received: from mail-oa1-f72.google.com (mail-oa1-f72.google.com
 [209.85.160.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-77-lD-bWCEgOU2KsJDCuWkHsw-1; Mon, 04 Mar 2024 06:14:51 -0500
X-MC-Unique: lD-bWCEgOU2KsJDCuWkHsw-1
Received: by mail-oa1-f72.google.com with SMTP id
 586e51a60fabf-21e7751f76fso5581110fac.2
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 03:14:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709550890; x=1710155690;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=9PogRwBzpxY83qcL/GnKChzqfLdsnwasrcAqLf98QYQ=;
 b=PjJzKjsUgZL2WFM76tGMmSGDJEI/gbCVPz5nAqVO8zWeyHDhZUtUf0iQuyMKHbWQ1J
 hywfNGW9xRIqOZDsvDEB6o3O9/KJVTr3CsuIxQVz3sRYA6c+1Miy8RoimETPFHuhKCfY
 89wfOCmbRa6Cx54yIUuv227Oo8U0OEXn1IYdRSqoNJvQOSN4kxRhU8MdSysPtxKLpE2J
 RbjC5B4OXtPSvly2e5LZIPZKdvancxqCgP0qZ3502WN1gpoEOlVrH+kjjSpSo2K5kim6
 lKcusVHQXHVIqNebl+qlEh/JlMOz0vFIQigZPzR5pDZGK3fOak/JPDSD9lC6iWGmZfgx
 kj4w==
X-Gm-Message-State: AOJu0Yw7tWyNJoKpkn/cgW8eBDbDG8kNKMax6NfBsZqFr6ervlj1VQVh
 6xQDm9dhAIQRBImZlx3ekpeuDx+BSXbP4033rfT9SBNefbbAlJo6y/xbrFWmUuGxzbtn2C40sxd
 FtJeqBwHChx94szyOCXeek1jJOBAsFUp140TRjkpDyErBJUeTv016
X-Received: by 2002:a05:6870:5708:b0:21e:3c57:18d4 with SMTP id
 k8-20020a056870570800b0021e3c5718d4mr9929346oap.19.1709550890587; 
 Mon, 04 Mar 2024 03:14:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGnzxmNfRwHH6GMG0tRXmllsnBM3Y2FXGwgxaDUoCa3XIl3ow3apa6cAXjZsQv86bbp7/fGpA==
X-Received: by 2002:a05:6870:5708:b0:21e:3c57:18d4 with SMTP id
 k8-20020a056870570800b0021e3c5718d4mr9929319oap.19.1709550890261; 
 Mon, 04 Mar 2024 03:14:50 -0800 (PST)
Received: from fc37-ani ([115.96.159.226])
 by smtp.googlemail.com with ESMTPSA id
 a19-20020a05620a125300b00787b93d8df1sm4247574qkl.99.2024.03.04.03.14.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 03:14:49 -0800 (PST)
Date: Mon, 4 Mar 2024 16:44:34 +0530 (IST)
From: Ani Sinha <anisinha@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com, 
 mst@redhat.com, gaosong@loongson.cn, alistair.francis@wdc.com, 
 palmer@dabbelt.com, bin.meng@windriver.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, philmd@linaro.org, 
 wangyanan55@huawei.com, eblake@redhat.com, armbru@redhat.com, 
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org, f.ebner@proxmox.com
Subject: Re: [PATCH 10/19] smbios: handle errors consistently
In-Reply-To: <20240227154749.1818189-11-imammedo@redhat.com>
Message-ID: <00c2eb0d-1667-5922-ac4b-8b11c099deef@redhat.com>
References: <20240227154749.1818189-1-imammedo@redhat.com>
 <20240227154749.1818189-11-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=170.10.129.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.589,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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



On Tue, 27 Feb 2024, Igor Mammedov wrote:

> Current code uses mix of error_report()+exit(1)
> and error_setg() to handle errors.
> Use newer error_setg() everywhere, beside consistency
> it will allow to detect error condition without killing
> QEMU and attempt switch-over to SMBIOS3.x tables/entrypoint
> in follow up patch.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Other than the nit below,

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
>  include/hw/firmware/smbios.h |  4 ++--
>  hw/i386/fw_cfg.c             |  3 ++-
>  hw/smbios/smbios.c           | 32 ++++++++++++++++++++------------
>  hw/smbios/smbios_legacy.c    | 22 ++++++++++++++--------
>  4 files changed, 38 insertions(+), 23 deletions(-)
>
> diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
> index a6d8fd6591..d1194c9cc2 100644
> --- a/include/hw/firmware/smbios.h
> +++ b/include/hw/firmware/smbios.h
> @@ -310,7 +310,7 @@ struct smbios_type_127 {
>      struct smbios_structure_header header;
>  } QEMU_PACKED;
>
> -void smbios_validate_table(void);
> +bool smbios_validate_table(Error **errp);
>  void smbios_add_usr_blob_size(size_t size);
>  void smbios_entry_add(QemuOpts *opts, Error **errp);
>  void smbios_set_cpuid(uint32_t version, uint32_t features);
> @@ -318,7 +318,7 @@ void smbios_set_defaults(const char *manufacturer, const char *product,
>                           const char *version,
>                           bool uuid_encoded, SmbiosEntryPointType ep_type);
>  void smbios_set_default_processor_family(uint16_t processor_family);
> -uint8_t *smbios_get_table_legacy(size_t *length);
> +uint8_t *smbios_get_table_legacy(size_t *length, Error **errp);
>  void smbios_get_tables(MachineState *ms,
>                         const struct smbios_phys_mem_area *mem_array,
>                         const unsigned int mem_array_size,
> diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
> index d1281066f4..e387bf50d0 100644
> --- a/hw/i386/fw_cfg.c
> +++ b/hw/i386/fw_cfg.c
> @@ -71,7 +71,8 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg)
>      smbios_set_cpuid(cpu->env.cpuid_version, cpu->env.features[FEAT_1_EDX]);
>
>      if (pcmc->smbios_legacy_mode) {
> -        smbios_tables = smbios_get_table_legacy(&smbios_tables_len);
> +        smbios_tables = smbios_get_table_legacy(&smbios_tables_len,
> +                                                &error_fatal);
>          fw_cfg_add_bytes(fw_cfg, FW_CFG_SMBIOS_ENTRIES,
>                           smbios_tables, smbios_tables_len);
>          return;
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index fb1f05fcde..7c28b5f748 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -19,7 +19,6 @@
>  #include "qemu/units.h"
>  #include "qapi/error.h"
>  #include "qemu/config-file.h"
> -#include "qemu/error-report.h"
>  #include "qemu/module.h"
>  #include "qemu/option.h"
>  #include "sysemu/sysemu.h"
> @@ -448,23 +447,25 @@ opts_init(smbios_register_config);
>   */
>  #define SMBIOS_21_MAX_TABLES_LEN 0xffff
>
> -static void smbios_check_type4_count(uint32_t expected_t4_count)
> +static bool smbios_check_type4_count(uint32_t expected_t4_count, Error **errp)
>  {
>      if (smbios_type4_count && smbios_type4_count != expected_t4_count) {
> -        error_report("Expected %d SMBIOS Type 4 tables, got %d instead",
> -                     expected_t4_count, smbios_type4_count);
> -        exit(1);
> +        error_setg(errp, "Expected %d SMBIOS Type 4 tables, got %d instead",
> +                   expected_t4_count, smbios_type4_count);
> +        return false;
>      }
> +    return true;
>  }
>
> -void smbios_validate_table(void)
> +bool smbios_validate_table(Error **errp)
>  {
>      if (smbios_ep_type == SMBIOS_ENTRY_POINT_TYPE_32 &&
>          smbios_tables_len > SMBIOS_21_MAX_TABLES_LEN) {
> -        error_report("SMBIOS 2.1 table length %zu exceeds %d",
> -                     smbios_tables_len, SMBIOS_21_MAX_TABLES_LEN);
> -        exit(1);
> +        error_setg(errp, "SMBIOS 2.1 table length %zu exceeds %d",
> +                   smbios_tables_len, SMBIOS_21_MAX_TABLES_LEN);
> +        return false;
>      }
> +    return true;
>  }
>
>  bool smbios_skip_table(uint8_t type, bool required_table)
> @@ -1027,15 +1028,18 @@ void smbios_get_tables(MachineState *ms,
>      smbios_build_type_41_table(errp);
>      smbios_build_type_127_table();
>
> -    smbios_check_type4_count(ms->smp.sockets);
> -    smbios_validate_table();
> +    if (!smbios_check_type4_count(ms->smp.sockets, errp)) {

nit: I would do a gfree(smbios_tables) here ..

> +        goto err_exit;
> +    }
> +    if (!smbios_validate_table(errp)) {
> +        goto err_exit;

and here. Then in err_exit ...

> +    }
>      smbios_entry_point_setup();
>
>      /* return tables blob and entry point (anchor), and their sizes */
>      *tables = smbios_tables;
>      *tables_len = smbios_tables_len;
>      *anchor = (uint8_t *)&ep;
> -
>      /* calculate length based on anchor string */
>      if (!strncmp((char *)&ep, "_SM_", 4)) {
>          *anchor_len = sizeof(struct smbios_21_entry_point);
> @@ -1044,6 +1048,10 @@ void smbios_get_tables(MachineState *ms,
>      } else {
>          abort();
>      }
> +
> +    return;
> +err_exit:

I would add a return here.

That way all paths explicitly return void.

> +    g_free(smbios_tables);

No return here?


>  }
>
>  static void save_opt(const char **dest, QemuOpts *opts, const char *name)
> diff --git a/hw/smbios/smbios_legacy.c b/hw/smbios/smbios_legacy.c
> index 21f143e738..a6544bf55a 100644
> --- a/hw/smbios/smbios_legacy.c
> +++ b/hw/smbios/smbios_legacy.c
> @@ -19,7 +19,7 @@
>  #include "qemu/bswap.h"
>  #include "hw/firmware/smbios.h"
>  #include "sysemu/sysemu.h"
> -#include "qemu/error-report.h"
> +#include "qapi/error.h"
>
>  struct smbios_header {
>      uint16_t length;
> @@ -128,7 +128,7 @@ static void smbios_build_type_1_fields(void)
>      }
>  }
>
> -uint8_t *smbios_get_table_legacy(size_t *length)
> +uint8_t *smbios_get_table_legacy(size_t *length, Error **errp)
>  {
>      int i;
>      size_t usr_offset;
> @@ -136,15 +136,15 @@ uint8_t *smbios_get_table_legacy(size_t *length)
>      /* complain if fields were given for types > 1 */
>      if (find_next_bit(smbios_have_fields_bitmap,
>                        SMBIOS_MAX_TYPE + 1, 2) < SMBIOS_MAX_TYPE + 1) {
> -        error_report("can't process fields for smbios "
> +        error_setg(errp, "can't process fields for smbios "
>                       "types > 1 on machine versions < 2.1!");
> -        exit(1);
> +        goto err_exit;
>      }
>
>      if (test_bit(4, smbios_have_binfile_bitmap)) {
> -        error_report("can't process table for smbios "
> -                     "type 4 on machine versions < 2.1!");
> -        exit(1);
> +        error_setg(errp, "can't process table for smbios "
> +                   "type 4 on machine versions < 2.1!");
> +        goto err_exit;
>      }
>
>      g_free(smbios_entries);
> @@ -173,7 +173,13 @@ uint8_t *smbios_get_table_legacy(size_t *length)
>
>      smbios_build_type_0_fields();
>      smbios_build_type_1_fields();
> -    smbios_validate_table();
> +    if (!smbios_validate_table(errp)) {
> +        goto err_exit;
> +    }
> +
>      *length = smbios_entries_len;
>      return smbios_entries;
> +err_exit:
> +    g_free(smbios_entries);
> +    return NULL;
>  }
> --
> 2.39.3
>
>


