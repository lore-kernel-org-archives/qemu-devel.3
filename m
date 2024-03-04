Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B57A7C5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 17:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhCGz-0006oU-ND; Mon, 04 Mar 2024 12:38:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rhCGw-0006nm-Su
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:38:43 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1rhCGq-0001tT-TI
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 12:38:42 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6e627596554so775766b3a.2
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 09:38:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1709573915; x=1710178715; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gT9V8gf5JdyxQS9HahQsmnOnff7m4uio6mQ4X/pOT8Y=;
 b=eKCozVwkKzsCe4hL/eFIpo1HXTq9FqB5c2qH9pZMp/fVq7qbYyWw+claDgHzI4Kpmv
 ZK/XWe1cgnWYrsPPTguOTw/Djt+DYhGLyA/EnxaxnKoRW0ax0RgDJKgvT7JS52+QidQW
 yOYuqa96wABAuHNqsqhb+AjWU0X1+4FJHPbeBMmjhXFH71zDVT6hxjOa/ZPFhYhbEM+i
 y2cx2KeAv37nCqZPkScpZisdVCp3z0w7v4VJlG6diJEBdJtR76PyB+aFBh9Dv7IHDCzA
 N/fuNotnb1SdNuuqj+670AZKcztCNXrBLuIK3m4kUrptS1Tx/BN0HsCo5JkL1tGnIfzt
 ogCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709573915; x=1710178715;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gT9V8gf5JdyxQS9HahQsmnOnff7m4uio6mQ4X/pOT8Y=;
 b=YtQWYpuH7LYxxvJUAcxJKAptlojMYo6jwn1n+UcZYsXyeRb0P7Sfhr8i2mUXDSnxjg
 HtHKgeQSEx/V9c6y1aUwJjRqk/vj4bPWjRxcmd8ssgx2JEuLAkBrRMQ/m5PkKmEVEYIY
 8nGGOttoH1zAZIY/dzvOgZp4c4/QHNHx+ZejAgFLYRW3h1cNT69/qoxf5dRDu+ecHPel
 bUeOnJRfdQI0gnCX/3t4Suq7Kbks6vPC8EDdo0CbDXNyi1q2xBvJ6tkIFzCVUQhc1Z7u
 sApqnFWk7n8TZzo97uVek6gwSlUccRnZeo8M5OvFWL2zvkbu+hesJ1Ac9JrTB1idMMxh
 l4UQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXXsI3xK3HatqIUkVmEHQ9ihhWXSZfnzMjclePCmQGU7N+Yp7UcJPVtNZ0NL4cVOzVw2w+CJAcdy4iT3qTg4yGXu1y8Nws=
X-Gm-Message-State: AOJu0Yz9xHD1JFpmpyiUaGq4gSC6vB+c+pjBJub5q2MLEm31RZu8KQtW
 vqm2Vgtn6KAxK1cOqROs5LdcRAdEA17cgJetuG32usNwNrFAaSjVFuz+PUbvXBs=
X-Google-Smtp-Source: AGHT+IHJLTDjoy/4PEM3kTr4NXMB7A/8KUNlr/qoTk7NUpN/W5u1Y6icfwusaDgVyVYV+0LJgGJkFQ==
X-Received: by 2002:a05:6a00:c95:b0:6e4:7a93:b627 with SMTP id
 a21-20020a056a000c9500b006e47a93b627mr9993779pfv.15.1709573915249; 
 Mon, 04 Mar 2024 09:38:35 -0800 (PST)
Received: from [192.168.68.110] ([177.94.15.159])
 by smtp.gmail.com with ESMTPSA id
 d18-20020a056a00199200b006e56c8f572esm7765946pfl.141.2024.03.04.09.38.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Mar 2024 09:38:34 -0800 (PST)
Message-ID: <a72378d4-9d65-4b23-a566-d58c01dcf3a1@ventanamicro.com>
Date: Mon, 4 Mar 2024 14:38:28 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/19] smbios: get rid of smbios_legacy global
Content-Language: en-US
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, pbonzini@redhat.com, mst@redhat.com,
 gaosong@loongson.cn, alistair.francis@wdc.com, palmer@dabbelt.com,
 bin.meng@windriver.com, liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com,
 anisinha@redhat.com, philmd@linaro.org, wangyanan55@huawei.com,
 eblake@redhat.com, armbru@redhat.com, qemu-arm@nongnu.org,
 qemu-riscv@nongnu.org, f.ebner@proxmox.com
References: <20240227154749.1818189-1-imammedo@redhat.com>
 <20240227154749.1818189-7-imammedo@redhat.com>
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240227154749.1818189-7-imammedo@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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



On 2/27/24 12:47, Igor Mammedov wrote:
> clean up smbios_set_defaults() which is reused by legacy
> and non legacy machines from being aware of 'legacy' notion
> and need to turn it off. And push legacy handling up to
> PC machine code where it's relevant.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> ---

For hw/riscv/virt.c changes:

Acked-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>


> PS: I've moved/kept legacy smbios_entries to smbios_get_tables()
> but it at least is not visible to API users. To get rid of it
> as well, it would be necessary to change how '-smbios' CLI
> option is processed. Which is done later in the series.
> ---
>   include/hw/firmware/smbios.h |  2 +-
>   hw/arm/virt.c                |  2 +-
>   hw/i386/fw_cfg.c             |  7 ++++---
>   hw/loongarch/virt.c          |  2 +-
>   hw/riscv/virt.c              |  2 +-
>   hw/smbios/smbios.c           | 35 +++++++++++++++--------------------
>   6 files changed, 23 insertions(+), 27 deletions(-)
> 
> diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
> index a187fbbd3d..0818184834 100644
> --- a/include/hw/firmware/smbios.h
> +++ b/include/hw/firmware/smbios.h
> @@ -293,7 +293,7 @@ struct smbios_type_127 {
>   void smbios_entry_add(QemuOpts *opts, Error **errp);
>   void smbios_set_cpuid(uint32_t version, uint32_t features);
>   void smbios_set_defaults(const char *manufacturer, const char *product,
> -                         const char *version, bool legacy_mode,
> +                         const char *version,
>                            bool uuid_encoded, SmbiosEntryPointType ep_type);
>   void smbios_set_default_processor_family(uint16_t processor_family);
>   uint8_t *smbios_get_table_legacy(uint32_t expected_t4_count, size_t *length);
> diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> index 0af1943697..8588681f27 100644
> --- a/hw/arm/virt.c
> +++ b/hw/arm/virt.c
> @@ -1633,7 +1633,7 @@ static void virt_build_smbios(VirtMachineState *vms)
>       }
>   
>       smbios_set_defaults("QEMU", product,
> -                        vmc->smbios_old_sys_ver ? "1.0" : mc->name, false,
> +                        vmc->smbios_old_sys_ver ? "1.0" : mc->name,
>                           true, SMBIOS_ENTRY_POINT_TYPE_64);
>   
>       /* build the array of physical mem area from base_memmap */
> diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
> index fcb4fb0769..c1e9c0fd9c 100644
> --- a/hw/i386/fw_cfg.c
> +++ b/hw/i386/fw_cfg.c
> @@ -63,15 +63,16 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg)
>       if (pcmc->smbios_defaults) {
>           /* These values are guest ABI, do not change */
>           smbios_set_defaults("QEMU", mc->desc, mc->name,
> -                            pcmc->smbios_legacy_mode, pcmc->smbios_uuid_encoded,
> +                            pcmc->smbios_uuid_encoded,
>                               pcms->smbios_entry_point_type);
>       }
>   
>       /* tell smbios about cpuid version and features */
>       smbios_set_cpuid(cpu->env.cpuid_version, cpu->env.features[FEAT_1_EDX]);
>   
> -    smbios_tables = smbios_get_table_legacy(ms->smp.cpus, &smbios_tables_len);
> -    if (smbios_tables) {
> +    if (pcmc->smbios_legacy_mode) {
> +        smbios_tables = smbios_get_table_legacy(ms->smp.cpus,
> +                                                &smbios_tables_len);
>           fw_cfg_add_bytes(fw_cfg, FW_CFG_SMBIOS_ENTRIES,
>                            smbios_tables, smbios_tables_len);
>           return;
> diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> index 0ad7d8c887..73fb3522ba 100644
> --- a/hw/loongarch/virt.c
> +++ b/hw/loongarch/virt.c
> @@ -320,7 +320,7 @@ static void virt_build_smbios(LoongArchMachineState *lams)
>           return;
>       }
>   
> -    smbios_set_defaults("QEMU", product, mc->name, false,
> +    smbios_set_defaults("QEMU", product, mc->name,
>                           true, SMBIOS_ENTRY_POINT_TYPE_64);
>   
>       smbios_get_tables(ms, NULL, 0, &smbios_tables, &smbios_tables_len,
> diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> index fd35c74781..e2c9529df2 100644
> --- a/hw/riscv/virt.c
> +++ b/hw/riscv/virt.c
> @@ -1235,7 +1235,7 @@ static void virt_build_smbios(RISCVVirtState *s)
>           product = "KVM Virtual Machine";
>       }
>   
> -    smbios_set_defaults("QEMU", product, mc->name, false,
> +    smbios_set_defaults("QEMU", product, mc->name,
>                           true, SMBIOS_ENTRY_POINT_TYPE_64);
>   
>       if (riscv_is_32bit(&s->soc[0])) {
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 15339d8dbe..c46fc93357 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -54,7 +54,6 @@ struct smbios_table {
>   
>   static uint8_t *smbios_entries;
>   static size_t smbios_entries_len;
> -static bool smbios_legacy = true;
>   static bool smbios_uuid_encoded = true;
>   /* end: legacy structures & constants for <= 2.0 machines */
>   
> @@ -570,9 +569,16 @@ static void smbios_build_type_1_fields(void)
>   
>   uint8_t *smbios_get_table_legacy(uint32_t expected_t4_count, size_t *length)
>   {
> -    if (!smbios_legacy) {
> -        *length = 0;
> -        return NULL;
> +    /* drop unwanted version of command-line file blob(s) */
> +    g_free(smbios_tables);
> +    smbios_tables = NULL;
> +
> +    /* also complain if fields were given for types > 1 */
> +    if (find_next_bit(have_fields_bitmap,
> +                      SMBIOS_MAX_TYPE + 1, 2) < SMBIOS_MAX_TYPE + 1) {
> +        error_report("can't process fields for smbios "
> +                     "types > 1 on machine versions < 2.1!");
> +        exit(1);
>       }
>   
>       if (!smbios_immutable) {
> @@ -1006,28 +1012,13 @@ void smbios_set_default_processor_family(uint16_t processor_family)
>   }
>   
>   void smbios_set_defaults(const char *manufacturer, const char *product,
> -                         const char *version, bool legacy_mode,
> +                         const char *version,
>                            bool uuid_encoded, SmbiosEntryPointType ep_type)
>   {
>       smbios_have_defaults = true;
> -    smbios_legacy = legacy_mode;
>       smbios_uuid_encoded = uuid_encoded;
>       smbios_ep_type = ep_type;
>   
> -    /* drop unwanted version of command-line file blob(s) */
> -    if (smbios_legacy) {
> -        g_free(smbios_tables);
> -        /* in legacy mode, also complain if fields were given for types > 1 */
> -        if (find_next_bit(have_fields_bitmap,
> -                          SMBIOS_MAX_TYPE+1, 2) < SMBIOS_MAX_TYPE+1) {
> -            error_report("can't process fields for smbios "
> -                         "types > 1 on machine versions < 2.1!");
> -            exit(1);
> -        }
> -    } else {
> -        g_free(smbios_entries);
> -    }
> -
>       SMBIOS_SET_DEFAULT(type1.manufacturer, manufacturer);
>       SMBIOS_SET_DEFAULT(type1.product, product);
>       SMBIOS_SET_DEFAULT(type1.version, version);
> @@ -1103,6 +1094,10 @@ void smbios_get_tables(MachineState *ms,
>   {
>       unsigned i, dimm_cnt, offset;
>   
> +    /* drop unwanted (legacy) version of command-line file blob(s) */
> +    g_free(smbios_entries);
> +    smbios_entries = NULL;
> +
>       if (!smbios_immutable) {
>           smbios_build_type_0_table();
>           smbios_build_type_1_table();

