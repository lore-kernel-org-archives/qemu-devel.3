Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A1B4C48BF6
	for <qemu-devel@archiver.kernel.org>; Thu, 29 Feb 2024 14:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfhPm-0002Nj-TQ; Thu, 29 Feb 2024 09:29:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rfhPi-0001zO-Rk
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 09:29:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1rfhPd-00068s-TK
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 09:29:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709216968;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=StbiZXwla8vIuHHbeT4VZbIjdaKRKNSm18LQtWP/rZQ=;
 b=K8eqRpa7JQ6Phq9D9odBnPhbAUAilzL5XUD+Ree4tS0MkCV62GTlZOwOW/rjhZBc0T1lND
 WgHkMiWvX1rrjoA+VOuMNzQropwINsvCHvgExsch8ayr90FdMN102LGoo8W4M+uzPjbBBy
 tf+3YMANppyfub2sr89Uu0QFZtLh6m0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-460-1c8xQ0cHNIaEQ0odqm8nPQ-1; Thu, 29 Feb 2024 09:29:27 -0500
X-MC-Unique: 1c8xQ0cHNIaEQ0odqm8nPQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-33d256ca4c8so549145f8f.3
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 06:29:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709216966; x=1709821766;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=StbiZXwla8vIuHHbeT4VZbIjdaKRKNSm18LQtWP/rZQ=;
 b=EgKEN8ie35xyTkz8gC2uurhWvwxxPj7Mox2iscati9QR43mu5LZgbFpPz9kRxXf0WH
 O0G1Voy1CZLxLTR+U4HavOutpJ2Bf2KwMkkGsmYSaLkZwN0/cvEzFEBTjIsuRFvyjK0L
 cSJN1aV8DsiDZE8K7jB0H/cEr9/1Ezr+KjPoBs4f0sGURa7UxLSh2kbbEN5j5xv+idBN
 pACF5BZAASGap/5WrKWpcvy+hMK84lzj07tMv7K5PudeqyqgfCxro9cBGKfd8WMDKUXF
 J/4gelHOsJM7/JGRqUuamxzCaQ2+d8F3lDHKfkrjjVzQyCOxMa4tJod6wlXOETS5fzB4
 q9Wg==
X-Gm-Message-State: AOJu0Yxo31KdzvCSBptcLYktZvFVJ+xVnmV7Cyp8rHxmxCplC2m1nk8I
 mouD0o85La3KJNxomtWCJ8xhLdxxI+k+viLgT9bRxVSw2wQnmwxFkYlPEJqOKR+eYZsp9ilU6Hs
 vyToK8/FuFLoJyHKRWU7kXbBIi34biKZQca0u0JwZudh3IJxMlSiO
X-Received: by 2002:a05:600c:1c0d:b0:412:ace9:9d85 with SMTP id
 j13-20020a05600c1c0d00b00412ace99d85mr2219370wms.3.1709216965746; 
 Thu, 29 Feb 2024 06:29:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFF8tCz7L/WxQDM3B1qriCeSoM8c7kJ324p+93qr8j2fs1rmLR43Yjf7/+lBceVIN2D/TTzLg==
X-Received: by 2002:a05:600c:1c0d:b0:412:ace9:9d85 with SMTP id
 j13-20020a05600c1c0d00b00412ace99d85mr2219349wms.3.1709216965338; 
 Thu, 29 Feb 2024 06:29:25 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 bw1-20020a0560001f8100b0033db0c866f7sm1954508wrb.11.2024.02.29.06.29.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 06:29:24 -0800 (PST)
Date: Thu, 29 Feb 2024 15:29:23 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Peter Maydell
 <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, "Michael
 S. Tsirkin" <mst@redhat.com>, Song Gao <gaosong@loongson.cn>, Alistair
 Francis <alistair.francis@wdc.com>, palmer@dabbelt.com,
 bin.meng@windriver.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com, Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?=
 <philmd@linaro.org>, Yanan Wang <wangyanan55@huawei.com>, Eric Blake
 <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org, f.ebner@proxmox.com
Subject: Re: [PATCH 06/19] smbios: get rid of smbios_legacy global
Message-ID: <20240229152923.46919312@imammedo.users.ipa.redhat.com>
In-Reply-To: <0129FA3E-A566-481A-85A6-439E72C5594B@redhat.com>
References: <20240227154749.1818189-1-imammedo@redhat.com>
 <20240227154749.1818189-7-imammedo@redhat.com>
 <0129FA3E-A566-481A-85A6-439E72C5594B@redhat.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.41; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On Thu, 29 Feb 2024 16:23:21 +0530
Ani Sinha <anisinha@redhat.com> wrote:

> > On 27-Feb-2024, at 21:17, Igor Mammedov <imammedo@redhat.com> wrote:
> > 
> > clean up smbios_set_defaults() which is reused by legacy
> > and non legacy machines from being aware of 'legacy' notion
> > and need to turn it off. And push legacy handling up to
> > PC machine code where it's relevant.
> > 
> > Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> > ---
> > PS: I've moved/kept legacy smbios_entries to smbios_get_tables()
> > but it at least is not visible to API users. To get rid of it
> > as well, it would be necessary to change how '-smbios' CLI
> > option is processed. Which is done later in the series.
> > ---
> > include/hw/firmware/smbios.h |  2 +-
> > hw/arm/virt.c                |  2 +-
> > hw/i386/fw_cfg.c             |  7 ++++---
> > hw/loongarch/virt.c          |  2 +-
> > hw/riscv/virt.c              |  2 +-
> > hw/smbios/smbios.c           | 35 +++++++++++++++--------------------
> > 6 files changed, 23 insertions(+), 27 deletions(-)
> > 
> > diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
> > index a187fbbd3d..0818184834 100644
> > --- a/include/hw/firmware/smbios.h
> > +++ b/include/hw/firmware/smbios.h
> > @@ -293,7 +293,7 @@ struct smbios_type_127 {
> > void smbios_entry_add(QemuOpts *opts, Error **errp);
> > void smbios_set_cpuid(uint32_t version, uint32_t features);
> > void smbios_set_defaults(const char *manufacturer, const char *product,
> > -                         const char *version, bool legacy_mode,
> > +                         const char *version,
> >                          bool uuid_encoded, SmbiosEntryPointType ep_type);
> > void smbios_set_default_processor_family(uint16_t processor_family);
> > uint8_t *smbios_get_table_legacy(uint32_t expected_t4_count, size_t *length);
> > diff --git a/hw/arm/virt.c b/hw/arm/virt.c
> > index 0af1943697..8588681f27 100644
> > --- a/hw/arm/virt.c
> > +++ b/hw/arm/virt.c
> > @@ -1633,7 +1633,7 @@ static void virt_build_smbios(VirtMachineState *vms)
> >     }
> > 
> >     smbios_set_defaults("QEMU", product,
> > -                        vmc->smbios_old_sys_ver ? "1.0" : mc->name, false,
> > +                        vmc->smbios_old_sys_ver ? "1.0" : mc->name,
> >                         true, SMBIOS_ENTRY_POINT_TYPE_64);
> > 
> >     /* build the array of physical mem area from base_memmap */
> > diff --git a/hw/i386/fw_cfg.c b/hw/i386/fw_cfg.c
> > index fcb4fb0769..c1e9c0fd9c 100644
> > --- a/hw/i386/fw_cfg.c
> > +++ b/hw/i386/fw_cfg.c
> > @@ -63,15 +63,16 @@ void fw_cfg_build_smbios(PCMachineState *pcms, FWCfgState *fw_cfg)
> >     if (pcmc->smbios_defaults) {
> >         /* These values are guest ABI, do not change */
> >         smbios_set_defaults("QEMU", mc->desc, mc->name,
> > -                            pcmc->smbios_legacy_mode, pcmc->smbios_uuid_encoded,
> > +                            pcmc->smbios_uuid_encoded,
> >                             pcms->smbios_entry_point_type);
> >     }
> > 
> >     /* tell smbios about cpuid version and features */
> >     smbios_set_cpuid(cpu->env.cpuid_version, cpu->env.features[FEAT_1_EDX]);
> > 
> > -    smbios_tables = smbios_get_table_legacy(ms->smp.cpus, &smbios_tables_len);
> > -    if (smbios_tables) {
> > +    if (pcmc->smbios_legacy_mode) {
> > +        smbios_tables = smbios_get_table_legacy(ms->smp.cpus,
> > +                                                &smbios_tables_len);
> >         fw_cfg_add_bytes(fw_cfg, FW_CFG_SMBIOS_ENTRIES,
> >                          smbios_tables, smbios_tables_len);
> >         return;
> > diff --git a/hw/loongarch/virt.c b/hw/loongarch/virt.c
> > index 0ad7d8c887..73fb3522ba 100644
> > --- a/hw/loongarch/virt.c
> > +++ b/hw/loongarch/virt.c
> > @@ -320,7 +320,7 @@ static void virt_build_smbios(LoongArchMachineState *lams)
> >         return;
> >     }
> > 
> > -    smbios_set_defaults("QEMU", product, mc->name, false,
> > +    smbios_set_defaults("QEMU", product, mc->name,
> >                         true, SMBIOS_ENTRY_POINT_TYPE_64);
> > 
> >     smbios_get_tables(ms, NULL, 0, &smbios_tables, &smbios_tables_len,
> > diff --git a/hw/riscv/virt.c b/hw/riscv/virt.c
> > index fd35c74781..e2c9529df2 100644
> > --- a/hw/riscv/virt.c
> > +++ b/hw/riscv/virt.c
> > @@ -1235,7 +1235,7 @@ static void virt_build_smbios(RISCVVirtState *s)
> >         product = "KVM Virtual Machine";
> >     }
> > 
> > -    smbios_set_defaults("QEMU", product, mc->name, false,
> > +    smbios_set_defaults("QEMU", product, mc->name,
> >                         true, SMBIOS_ENTRY_POINT_TYPE_64);
> > 
> >     if (riscv_is_32bit(&s->soc[0])) {
> > diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> > index 15339d8dbe..c46fc93357 100644
> > --- a/hw/smbios/smbios.c
> > +++ b/hw/smbios/smbios.c
> > @@ -54,7 +54,6 @@ struct smbios_table {
> > 
> > static uint8_t *smbios_entries;
> > static size_t smbios_entries_len;
> > -static bool smbios_legacy = true;
> > static bool smbios_uuid_encoded = true;
> > /* end: legacy structures & constants for <= 2.0 machines */
> > 
> > @@ -570,9 +569,16 @@ static void smbios_build_type_1_fields(void)
> > 
> > uint8_t *smbios_get_table_legacy(uint32_t expected_t4_count, size_t *length)
> > {
> > -    if (!smbios_legacy) {
> > -        *length = 0;
> > -        return NULL;
> > +    /* drop unwanted version of command-line file blob(s) */
> > +    g_free(smbios_tables);
> > +    smbios_tables = NULL;
> > +
> > +    /* also complain if fields were given for types > 1 */
> > +    if (find_next_bit(have_fields_bitmap,
> > +                      SMBIOS_MAX_TYPE + 1, 2) < SMBIOS_MAX_TYPE + 1) {
> > +        error_report("can't process fields for smbios "
> > +                     "types > 1 on machine versions < 2.1!");
> > +        exit(1);
> >     }
> > 
> >     if (!smbios_immutable) {
> > @@ -1006,28 +1012,13 @@ void smbios_set_default_processor_family(uint16_t processor_family)
> > }
> > 
> > void smbios_set_defaults(const char *manufacturer, const char *product,
> > -                         const char *version, bool legacy_mode,
> > +                         const char *version,
> >                          bool uuid_encoded, SmbiosEntryPointType ep_type)
> > {
> >     smbios_have_defaults = true;
> > -    smbios_legacy = legacy_mode;
> >     smbios_uuid_encoded = uuid_encoded;
> >     smbios_ep_type = ep_type;
> > 
> > -    /* drop unwanted version of command-line file blob(s) */
> > -    if (smbios_legacy) {
> > -        g_free(smbios_tables);
> > -        /* in legacy mode, also complain if fields were given for types > 1 */
> > -        if (find_next_bit(have_fields_bitmap,
> > -                          SMBIOS_MAX_TYPE+1, 2) < SMBIOS_MAX_TYPE+1) {
> > -            error_report("can't process fields for smbios "
> > -                         "types > 1 on machine versions < 2.1!");
> > -            exit(1);
> > -        }
> > -    } else {
> > -        g_free(smbios_entries);
> > -    }
> > -
> >     SMBIOS_SET_DEFAULT(type1.manufacturer, manufacturer);
> >     SMBIOS_SET_DEFAULT(type1.product, product);
> >     SMBIOS_SET_DEFAULT(type1.version, version);
> > @@ -1103,6 +1094,10 @@ void smbios_get_tables(MachineState *ms,
> > {
> >     unsigned i, dimm_cnt, offset;
> > 
> > +    /* drop unwanted (legacy) version of command-line file blob(s) */
> > +    g_free(smbios_entries);
> > +    smbios_entries = NULL;
> > +  
> 
> Can you please explain why you do this unconditionally without checking for legacy mode? Seems wrong?

with this patch legacy tables build is moved to fw_cfg_build_smbios(),
however at this point QEMU still has option processing that fills
both new and legacy smbios_entries blobs. 

this hunk cleanups not needed blob smbios_entries when building
modern tables, and smbios_get_table_legacy() has a corresponding
smbios_tables cleanup since modern is not needed there.

[7/19] removes this in favor of a single blob.

> 
> >     if (!smbios_immutable) {
> >         smbios_build_type_0_table();
> >         smbios_build_type_1_table();
> > -- 
> > 2.39.3
> >   
> 


