Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FE3C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 08:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhQKv-0006V8-1X; Tue, 05 Mar 2024 03:39:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rhQKr-0006UO-Fh
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 03:39:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rhQKo-0008Rd-Mp
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 03:39:41 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709627976;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5LcInpHYYuUiy4B3hRcWcyDRSUDFhfdYJTKi9Iv68I4=;
 b=I7YzH05HbIYhaDeTJuGCOd1QN8+K/mNN+sas7sxVq/1FGrhqoko0W3Wk2N3I2av2qI8gm0
 sKAk8bPqxytuRV7BPUU92DZIucVWa1tOerT9OYC4tjXp5vJ2WMkLsDIu2v6SJ1XShfq/nx
 Gz/yOE+FqtD01yupy8pwQNyFzqvtLA8=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-_ehmNaqiN7G0wrwGrsuYcA-1; Tue, 05 Mar 2024 03:39:34 -0500
X-MC-Unique: _ehmNaqiN7G0wrwGrsuYcA-1
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-1dbcbffd853so55163545ad.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 00:39:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709627973; x=1710232773;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5LcInpHYYuUiy4B3hRcWcyDRSUDFhfdYJTKi9Iv68I4=;
 b=MV8Q93xj27Xh0l80VAS8jg5F5pm3jwXujQKaTvYGTRD7PwvREbiQFWatIxSDTwGM2r
 TMRqw8tb9ZvRgTZdFGl7LOvWFNnnoFzgGN3NTPPPhTRxOKXPgmXExmeINGWU1z1QfRFk
 PKxM/Nmswu7WD7S8YndgDnsaXc+8iJELHzG0R7OKzBUOHoNgLQsF2e8Kl3EmNPb11pjR
 MDomj+LqsozNnY84WwF6uoaY9Hrlnud4nQqys4VlzIq6VPYjdhLrhXK44qg21UNFVpf6
 SCuxop4ecc4gck8T6rlKFPSsQfecBoiyg3Ctll2hBNI5tas5TxHOTaR8D5DwB21HcfAr
 FdNQ==
X-Gm-Message-State: AOJu0Yykt5aX520eypXBcwMRmC2Q3qv7TA6JeFaB3KmkjFUCUENOF2w4
 FV1DqGZpxw0PUWYzjEDj0wZjCurhbCXKuDHrN6sih8oUL69GggKMrQ7ivsCIk713GIOyNzJ5oH/
 c5IXl3wFjTOEFmSFafXYXpT92RnVWqEBKLRfhpm8pW19266z9fScZ
X-Received: by 2002:a17:902:e88b:b0:1db:d7a8:8508 with SMTP id
 w11-20020a170902e88b00b001dbd7a88508mr1118559plg.52.1709627973535; 
 Tue, 05 Mar 2024 00:39:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGrbbAsnRe/VAzlN+NEZk4Jzpeo9p8315L23eLDv9vpiKaFQw27Z/+TpKSdNr36qUp4dF+rNw==
X-Received: by 2002:a17:902:e88b:b0:1db:d7a8:8508 with SMTP id
 w11-20020a170902e88b00b001dbd7a88508mr1118541plg.52.1709627973049; 
 Tue, 05 Mar 2024 00:39:33 -0800 (PST)
Received: from fc37-ani ([203.163.238.152])
 by smtp.googlemail.com with ESMTPSA id
 i3-20020a17090332c300b001dd0c5d5227sm4136485plr.193.2024.03.05.00.39.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 00:39:32 -0800 (PST)
Date: Tue, 5 Mar 2024 14:09:23 +0530 (IST)
From: Ani Sinha <anisinha@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com, 
 mst@redhat.com, gaosong@loongson.cn, alistair.francis@wdc.com, 
 palmer@dabbelt.com, bin.meng@windriver.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, philmd@linaro.org, 
 wangyanan55@huawei.com, eblake@redhat.com, armbru@redhat.com, 
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org, f.ebner@proxmox.com
Subject: Re: [PATCH 12/19] get rid of global smbios_ep_type
In-Reply-To: <20240227154749.1818189-13-imammedo@redhat.com>
Message-ID: <4a4d45f1-2bc6-9ff0-ad9d-078a737ea244@redhat.com>
References: <20240227154749.1818189-1-imammedo@redhat.com>
 <20240227154749.1818189-13-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.571,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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


please add "smbios:" prefix just like your other patches in the commit
header.

On Tue, 27 Feb 2024, Igor Mammedov wrote:

> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

I have not checked all the code paths for the changed function signatures
and left that instead for the compiler. Assuming the build is fine,

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
>  hw/i386/fw_cfg.h             |  3 ++-
>  include/hw/firmware/smbios.h |  5 +++--
>  hw/arm/virt.c                |  4 ++--
>  hw/i386/fw_cfg.c             |  8 ++++----
>  hw/i386/pc.c                 |  2 +-
>  hw/loongarch/virt.c          |  7 ++++---
>  hw/riscv/virt.c              |  6 +++---
>  hw/smbios/smbios.c           | 27 +++++++++++++++------------
>  hw/smbios/smbios_legacy.c    |  2 +-
>  9 files changed, 35 insertions(+), 29 deletions(-)
>
> diff --git a/hw/i386/fw_cfg.h b/hw/i386/fw_cfg.h
> index 1e1de6b4a3..92e310f5fd 100644
> --- a/hw/i386/fw_cfg.h
> +++ b/hw/i386/fw_cfg.h
> @@ -23,7 +23,8 @@
>  FWCfgState *fw_cfg_arch_create(MachineState *ms,
>                                 uint16_t boot_cpus,
>                                 uint16_t apic_id_limit);
> -void fw_cfg_build_smbios(PCMachineState *ms, FWCfgState *fw_cfg);
> +void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
> +                         SmbiosEntryPointType ep_type);
>  void fw_cfg_build_feature_control(MachineState *ms, FWCfgState *fw_cfg);
>  void fw_cfg_add_acpi_dsdt(Aml *scope, FWCfgState *fw_cfg);
>
> diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
> index d1194c9cc2..d59c2f5a13 100644
> --- a/include/hw/firmware/smbios.h
> +++ b/include/hw/firmware/smbios.h
> @@ -310,16 +310,17 @@ struct smbios_type_127 {
>      struct smbios_structure_header header;
>  } QEMU_PACKED;
>
> -bool smbios_validate_table(Error **errp);
> +bool smbios_validate_table(SmbiosEntryPointType ep_type, Error **errp);
>  void smbios_add_usr_blob_size(size_t size);
>  void smbios_entry_add(QemuOpts *opts, Error **errp);
>  void smbios_set_cpuid(uint32_t version, uint32_t features);
>  void smbios_set_defaults(const char *manufacturer, const char *product,
>                           const char *version,
> -                         bool uuid_encoded, SmbiosEntryPointType ep_type);
> +                         bool uuid_encoded);
>  void smbios_set_default_processor_family(uint16_t processor_family);
>  uint8_t *smbios_get_table_legacy(size_t *length, Error **errp);
>  void smbios_get_tables(MachineState *ms,
> +                       SmbiosEntryPointType ep_type,
>                         const struct smbios_phys_mem_area *mem_array,
>                         const unsigned int mem_array_size,
>                         uint8_t **tables, size_t *tables_len,
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 8588681f27..780224ee5b 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1634,13 +1634,13 @@ static void virt_build_smbios(VirtMachineState *vms)
>
>      smbios_set_defaults("QEMU", product,
>                          vmc->smbios_old_sys_ver ? "1.0" : mc->name,
> -                        true, SMBIOS_ENTRY_POINT_TYPE_64);
> +                        true);
>
>      /* build the array of physical mem area from base_memmap */
>      mem_array.address = vms->memmap[VIRT_MEM].base;
>      mem_array.length = ms->ram_size;
>
> -    smbios_get_tables(ms, &mem_array, 1,
> +    smbios_get_tables(ms, SMBIOS_ENTRY_POINT_TYPE_64, &mem_array, 1,
>                        &smbios_tables, &smbios_tables_len,
>                        &smbios_anchor, &smbios_anchor_len,
>                        &error_fatal);
> diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
> index e387bf50d0..d802d2787f 100644
> --- a/hw/i386/fw_cfg.c
> +++ b/hw/i386/fw_cfg.c
> @@ -48,7 +48,8 @@ const char *fw_cfg_arch_key_name(uint16_t key)
>      return NULL;
>  }
>
> -void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg)
> +void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg,
> +                         SmbiosEntryPointType ep_type)
>  {
>  #ifdef CONFIG_SMBIOS
>      uint8_t *smbios_tables, *smbios_anchor;
> @@ -63,8 +64,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg)
>      if (pcmc->smbios_defaults) {
>          /* These values are guest ABI, do not change */
>          smbios_set_defaults("QEMU", mc->desc, mc->name,
> -                            pcmc->smbios_uuid_encoded,
> -                            pcms->smbios_entry_point_type);
> +                            pcmc->smbios_uuid_encoded);
>      }
>
>      /* tell smbios about cpuid version and features */
> @@ -89,7 +89,7 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg)
>              array_count++;
>          }
>      }
> -    smbios_get_tables(ms, mem_array, array_count,
> +    smbios_get_tables(ms, ep_type, mem_array, array_count,
>                        &smbios_tables, &smbios_tables_len,
>                        &smbios_anchor, &smbios_anchor_len,
>                        &error_fatal);
> diff --git a/hw/i386/pc.c b/hw/i386/pc.c
> index f8eb684a49..56562e7d9e 100644
> --- a/hw/i386/pc.c
> +++ b/hw/i386/pc.c
> @@ -689,7 +689,7 @@ void pc_machine_done(Notifier *notifier, void *data)
>
>      acpi_setup();
>      if (x86ms->fw_cfg) {
> -        fw_cfg_build_smbios(pcms, x86ms->fw_cfg);
> +        fw_cfg_build_smbios(pcms, x86ms->fw_cfg, pcms->smbios_entry_point_type);
>          fw_cfg_build_feature_control(MACHINE(pcms), x86ms->fw_cfg);
>          /* update FW_CFG_NB_CPUS to account for -device added CPUs */
>          fw_cfg_modify_i16(x86ms->fw_cfg, FW_CFG_NB_CPUS, x86ms->boot_cpus);
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 73fb3522ba..d2ed15da75 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -320,10 +320,11 @@ static void virt_build_smbios(LoongArchMachineState *lams)
>          return;
>      }
>
> -    smbios_set_defaults("QEMU", product, mc->name,
> -                        true, SMBIOS_ENTRY_POINT_TYPE_64);
> +    smbios_set_defaults("QEMU", product, mc->name, true);
>
> -    smbios_get_tables(ms, NULL, 0, &smbios_tables, &smbios_tables_len,
> +    smbios_get_tables(ms, SMBIOS_ENTRY_POINT_TYPE_64,
> +                      NULL, 0,
> +                      &smbios_tables, &smbios_tables_len,
>                        &smbios_anchor, &smbios_anchor_len, &error_fatal);
>
>      if (smbios_anchor) {
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index e2c9529df2..b730ff2030 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1235,8 +1235,7 @@ static void virt_build_smbios(RISCVVirtState *s)
>          product = "KVM Virtual Machine";
>      }
>
> -    smbios_set_defaults("QEMU", product, mc->name,
> -                        true, SMBIOS_ENTRY_POINT_TYPE_64);
> +    smbios_set_defaults("QEMU", product, mc->name, true);
>
>      if (riscv_is_32bit(&s->soc[0])) {
>          smbios_set_default_processor_family(0x200);
> @@ -1248,7 +1247,8 @@ static void virt_build_smbios(RISCVVirtState *s)
>      mem_array.address = s->memmap[VIRT_DRAM].base;
>      mem_array.length = ms->ram_size;
>
> -    smbios_get_tables(ms, &mem_array, 1,
> +    smbios_get_tables(ms, SMBIOS_ENTRY_POINT_TYPE_64,
> +                      &mem_array, 1,
>                        &smbios_tables, &smbios_tables_len,
>                        &smbios_anchor, &smbios_anchor_len,
>                        &error_fatal);
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index d9ba2072b1..5a791fd9eb 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -43,7 +43,6 @@ uint8_t *smbios_tables;
>  size_t smbios_tables_len;
>  unsigned smbios_table_max;
>  unsigned smbios_table_cnt;
> -static SmbiosEntryPointType smbios_ep_type = SMBIOS_ENTRY_POINT_TYPE_32;
>
>  static SmbiosEntryPoint ep;
>
> @@ -457,9 +456,9 @@ static bool smbios_check_type4_count(uint32_t expected_t4_count, Error **errp)
>      return true;
>  }
>
> -bool smbios_validate_table(Error **errp)
> +bool smbios_validate_table(SmbiosEntryPointType ep_type, Error **errp)
>  {
> -    if (smbios_ep_type == SMBIOS_ENTRY_POINT_TYPE_32 &&
> +    if (ep_type == SMBIOS_ENTRY_POINT_TYPE_32 &&
>          smbios_tables_len > SMBIOS_21_MAX_TABLES_LEN) {
>          error_setg(errp, "SMBIOS 2.1 table length %zu exceeds %d",
>                     smbios_tables_len, SMBIOS_21_MAX_TABLES_LEN);
> @@ -605,14 +604,15 @@ static void smbios_build_type_3_table(void)
>      SMBIOS_BUILD_TABLE_POST;
>  }
>
> -static void smbios_build_type_4_table(MachineState *ms, unsigned instance)
> +static void smbios_build_type_4_table(MachineState *ms, unsigned instance,
> +                                      SmbiosEntryPointType ep_type)
>  {
>      char sock_str[128];
>      size_t tbl_len = SMBIOS_TYPE_4_LEN_V28;
>      unsigned threads_per_socket;
>      unsigned cores_per_socket;
>
> -    if (smbios_ep_type == SMBIOS_ENTRY_POINT_TYPE_64) {
> +    if (ep_type == SMBIOS_ENTRY_POINT_TYPE_64) {
>          tbl_len = SMBIOS_TYPE_4_LEN_V30;
>      }
>
> @@ -888,11 +888,10 @@ void smbios_set_default_processor_family(uint16_t processor_family)
>
>  void smbios_set_defaults(const char *manufacturer, const char *product,
>                           const char *version,
> -                         bool uuid_encoded, SmbiosEntryPointType ep_type)
> +                         bool uuid_encoded)
>  {
>      smbios_have_defaults = true;
>      smbios_uuid_encoded = uuid_encoded;
> -    smbios_ep_type = ep_type;
>
>      SMBIOS_SET_DEFAULT(smbios_type1.manufacturer, manufacturer);
>      SMBIOS_SET_DEFAULT(smbios_type1.product, product);
> @@ -909,9 +908,9 @@ void smbios_set_defaults(const char *manufacturer, const char *product,
>      SMBIOS_SET_DEFAULT(type17.manufacturer, manufacturer);
>  }
>
> -static void smbios_entry_point_setup(void)
> +static void smbios_entry_point_setup(SmbiosEntryPointType ep_type)
>  {
> -    switch (smbios_ep_type) {
> +    switch (ep_type) {
>      case SMBIOS_ENTRY_POINT_TYPE_32:
>          memcpy(ep.ep21.anchor_string, "_SM_", 4);
>          memcpy(ep.ep21.intermediate_anchor_string, "_DMI_", 5);
> @@ -961,6 +960,7 @@ static void smbios_entry_point_setup(void)
>  }
>
>  void smbios_get_tables(MachineState *ms,
> +                       SmbiosEntryPointType ep_type,
>                         const struct smbios_phys_mem_area *mem_array,
>                         const unsigned int mem_array_size,
>                         uint8_t **tables, size_t *tables_len,
> @@ -969,6 +969,9 @@ void smbios_get_tables(MachineState *ms,
>  {
>      unsigned i, dimm_cnt, offset;
>
> +    assert(ep_type == SMBIOS_ENTRY_POINT_TYPE_32 ||
> +           ep_type == SMBIOS_ENTRY_POINT_TYPE_64);
> +
>      g_free(smbios_tables);
>      smbios_tables = g_memdup2(usr_blobs, usr_blobs_len);
>      smbios_tables_len = usr_blobs_len;
> @@ -983,7 +986,7 @@ void smbios_get_tables(MachineState *ms,
>      assert(ms->smp.sockets >= 1);
>
>      for (i = 0; i < ms->smp.sockets; i++) {
> -        smbios_build_type_4_table(ms, i);
> +        smbios_build_type_4_table(ms, i, ep_type);
>      }
>
>      smbios_build_type_8_table();
> @@ -1031,10 +1034,10 @@ void smbios_get_tables(MachineState *ms,
>      if (!smbios_check_type4_count(ms->smp.sockets, errp)) {
>          goto err_exit;
>      }
> -    if (!smbios_validate_table(errp)) {
> +    if (!smbios_validate_table(ep_type, errp)) {
>          goto err_exit;
>      }
> -    smbios_entry_point_setup();
> +    smbios_entry_point_setup(ep_type);
>
>      /* return tables blob and entry point (anchor), and their sizes */
>      *tables = smbios_tables;
> diff --git a/hw/smbios/smbios_legacy.c b/hw/smbios/smbios_legacy.c
> index a6544bf55a..06907cd16c 100644
> --- a/hw/smbios/smbios_legacy.c
> +++ b/hw/smbios/smbios_legacy.c
> @@ -173,7 +173,7 @@ uint8_t *smbios_get_table_legacy(size_t *length, Error **errp)
>
>      smbios_build_type_0_fields();
>      smbios_build_type_1_fields();
> -    if (!smbios_validate_table(errp)) {
> +    if (!smbios_validate_table(SMBIOS_ENTRY_POINT_TYPE_32, errp)) {
>          goto err_exit;
>      }
>
> --
> 2.39.3
>
>


