Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1001C5475B
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Mar 2024 07:16:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhlVG-0003yf-O4; Wed, 06 Mar 2024 02:15:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rhlV0-0003uD-Vr
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 02:15:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anisinha@redhat.com>)
 id 1rhlUw-0005tg-3r
 for qemu-devel@nongnu.org; Wed, 06 Mar 2024 02:15:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709709326;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RHY32HO7HoWbA8Scfodp0U3q2/gjdnJugyADIFMJVqY=;
 b=Gb4Qz7I7gy5WI2sNIyNIE6UTDCq1FhNj6GQ6E0uYRDwahEBLJbwZ79ebydVGLnlzu6BX+m
 j4ursD0xJF5oXgo2hEj4xwYwKjNNCR+d+V3QgGNdhuubrDXyePbFKthfLGLTpECxJMn91J
 9KdWVc4yianp9Y2BaNAUyL+iW25z0o8=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-EBo3lws9M3iY5yVMUIKDmQ-1; Wed, 06 Mar 2024 02:15:24 -0500
X-MC-Unique: EBo3lws9M3iY5yVMUIKDmQ-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6e04e1ac036so7429679b3a.3
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 23:15:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709709323; x=1710314123;
 h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
 :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RHY32HO7HoWbA8Scfodp0U3q2/gjdnJugyADIFMJVqY=;
 b=A+JtZ++3vbZ1oGghwaQ6MA0FN56A7uTEBVCnBwyTL3CfDUlSd4czQ9NTJi7D5bquDW
 m16a/l8smAsecNJSZy3sXWCTH1GRV6Roz7KCy0SD0fub24brF6QNkiAGQFi/KKjf0XOD
 PmAUmF1pxsG4TIv6PxIJnnmVsjTR7R/vQu/4OamNnZsSaibRiTqvZfsg32FACRcweW5N
 5Yvgta4YrHbey4vwBNIxWUtn6zHgZaxGSk/jCSLWyd59IVjfD2JOyPGbr2Aduo4g1FZs
 SwlLGTq/8ZQhsrAfa3aw7XuCeu3iyevJrsbDFIOFAU5N+DNGbQnfDktmjMvQIKzQVXc6
 d3Eg==
X-Gm-Message-State: AOJu0Yz+tnw/vN8AiNRdkDwMRjsgK+2mg8E+7FkwH2ckqYmpHMBfls+V
 4rNMuUCCZL/ybKoBjLBeNuzIGrQI0s+WoKynaVZ211oFA5Al/Z2028ehNechSHQwGsYVlRQID2Q
 lVMYhWHMULxp9yknfSKqKArHgHoFLitKuqgXDBhWO7RtV2E39NQBR
X-Received: by 2002:a05:6a00:190e:b0:6e6:4647:998e with SMTP id
 y14-20020a056a00190e00b006e64647998emr3402597pfi.8.1709709323490; 
 Tue, 05 Mar 2024 23:15:23 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHZ5eEepS9YVq/UUBXy+aukJ0P/hjhP7fugPwTdQj5KHc9rIP3xiYJC4oxFRMFXsVUHFzxXdA==
X-Received: by 2002:a05:6a00:190e:b0:6e6:4647:998e with SMTP id
 y14-20020a056a00190e00b006e64647998emr3402564pfi.8.1709709322986; 
 Tue, 05 Mar 2024 23:15:22 -0800 (PST)
Received: from fc37-ani ([115.96.30.47]) by smtp.googlemail.com with ESMTPSA id
 z12-20020aa785cc000000b006e56e5c09absm10420451pfn.14.2024.03.05.23.15.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Mar 2024 23:15:22 -0800 (PST)
Date: Wed, 6 Mar 2024 12:45:13 +0530 (IST)
From: Ani Sinha <anisinha@redhat.com>
To: Igor Mammedov <imammedo@redhat.com>
cc: qemu-devel@nongnu.org, peter.maydell@linaro.org, pbonzini@redhat.com, 
 mst@redhat.com, gaosong@loongson.cn, alistair.francis@wdc.com, 
 palmer@dabbelt.com, bin.meng@windriver.com, liwei1518@gmail.com, 
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com, philmd@linaro.org, 
 wangyanan55@huawei.com, eblake@redhat.com, armbru@redhat.com, 
 qemu-arm@nongnu.org, qemu-riscv@nongnu.org, f.ebner@proxmox.com
Subject: Re: [PATCH v2 10/20] smbios: rename/expose structures/bitmaps used
 by both legacy and modern code
In-Reply-To: <20240305155724.2047069-11-imammedo@redhat.com>
Message-ID: <b14d998d-91a1-c2b1-9d9b-5e4b41dfb045@redhat.com>
References: <20240305155724.2047069-1-imammedo@redhat.com>
 <20240305155724.2047069-11-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Received-SPF: pass client-ip=170.10.133.124; envelope-from=anisinha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
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



On Tue, 5 Mar 2024, Igor Mammedov wrote:

> As a preparation to move legacy handling into a separate file,
> add prefix 'smbios_' to type0/type1/have_binfile_bitmap/have_fields_bitmap
> and expose them in smbios.h so that they can be reused in
> legacy and modern code.
>
> Doing it as a separate patch to avoid rename cluttering follow-up
> patch which will move legacy code into a separate file.
>

I checked that after application of this patch in the patcset, QEMU build
goes through fine. Therefore,

> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Ani Sinha <anisinha@redhat.com>

> ---
>  include/hw/firmware/smbios.h |  16 +++++
>  hw/smbios/smbios.c           | 113 ++++++++++++++++-------------------
>  2 files changed, 69 insertions(+), 60 deletions(-)
>
> diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
> index 1fbff3c55f..bea5c3f1b1 100644
> --- a/include/hw/firmware/smbios.h
> +++ b/include/hw/firmware/smbios.h
> @@ -2,6 +2,7 @@
>  #define QEMU_SMBIOS_H
>
>  #include "qapi/qapi-types-machine.h"
> +#include "qemu/bitmap.h"
>
>  /*
>   * SMBIOS Support
> @@ -16,8 +17,23 @@
>   *
>   */
>
> +typedef struct {
> +    const char *vendor, *version, *date;
> +    bool have_major_minor, uefi;
> +    uint8_t major, minor;
> +} smbios_type0_t;
> +extern smbios_type0_t smbios_type0;
> +
> +typedef struct {
> +    const char *manufacturer, *product, *version, *serial, *sku, *family;
> +    /* uuid is in qemu_uuid */
> +} smbios_type1_t;
> +extern smbios_type1_t smbios_type1;
>
>  #define SMBIOS_MAX_TYPE 127
> +extern DECLARE_BITMAP(smbios_have_binfile_bitmap, SMBIOS_MAX_TYPE + 1);
> +extern DECLARE_BITMAP(smbios_have_fields_bitmap, SMBIOS_MAX_TYPE + 1);
> +
>  #define offsetofend(TYPE, MEMBER) \
>         (offsetof(TYPE, MEMBER) + sizeof_field(TYPE, MEMBER))
>
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index 01180bd82c..86cf66b5ce 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -78,19 +78,11 @@ static int smbios_type4_count = 0;
>  static bool smbios_have_defaults;
>  static uint32_t smbios_cpuid_version, smbios_cpuid_features;
>
> -static DECLARE_BITMAP(have_binfile_bitmap, SMBIOS_MAX_TYPE+1);
> -static DECLARE_BITMAP(have_fields_bitmap, SMBIOS_MAX_TYPE+1);
> +DECLARE_BITMAP(smbios_have_binfile_bitmap, SMBIOS_MAX_TYPE + 1);
> +DECLARE_BITMAP(smbios_have_fields_bitmap, SMBIOS_MAX_TYPE + 1);
>
> -static struct {
> -    const char *vendor, *version, *date;
> -    bool have_major_minor, uefi;
> -    uint8_t major, minor;
> -} type0;
> -
> -static struct {
> -    const char *manufacturer, *product, *version, *serial, *sku, *family;
> -    /* uuid is in qemu_uuid */
> -} type1;
> +smbios_type0_t smbios_type0;
> +smbios_type1_t smbios_type1;
>
>  static struct {
>      const char *manufacturer, *product, *version, *serial, *asset, *location;
> @@ -536,36 +528,36 @@ static void smbios_maybe_add_str(int type, int offset, const char *data)
>  static void smbios_build_type_0_fields(void)
>  {
>      smbios_maybe_add_str(0, offsetof(struct smbios_type_0, vendor_str),
> -                         type0.vendor);
> +                         smbios_type0.vendor);
>      smbios_maybe_add_str(0, offsetof(struct smbios_type_0, bios_version_str),
> -                         type0.version);
> +                         smbios_type0.version);
>      smbios_maybe_add_str(0, offsetof(struct smbios_type_0,
>                                       bios_release_date_str),
> -                         type0.date);
> -    if (type0.have_major_minor) {
> +                         smbios_type0.date);
> +    if (smbios_type0.have_major_minor) {
>          smbios_add_field(0, offsetof(struct smbios_type_0,
>                                       system_bios_major_release),
> -                         &type0.major, 1);
> +                         &smbios_type0.major, 1);
>          smbios_add_field(0, offsetof(struct smbios_type_0,
>                                       system_bios_minor_release),
> -                         &type0.minor, 1);
> +                         &smbios_type0.minor, 1);
>      }
>  }
>
>  static void smbios_build_type_1_fields(void)
>  {
>      smbios_maybe_add_str(1, offsetof(struct smbios_type_1, manufacturer_str),
> -                         type1.manufacturer);
> +                         smbios_type1.manufacturer);
>      smbios_maybe_add_str(1, offsetof(struct smbios_type_1, product_name_str),
> -                         type1.product);
> +                         smbios_type1.product);
>      smbios_maybe_add_str(1, offsetof(struct smbios_type_1, version_str),
> -                         type1.version);
> +                         smbios_type1.version);
>      smbios_maybe_add_str(1, offsetof(struct smbios_type_1, serial_number_str),
> -                         type1.serial);
> +                         smbios_type1.serial);
>      smbios_maybe_add_str(1, offsetof(struct smbios_type_1, sku_number_str),
> -                         type1.sku);
> +                         smbios_type1.sku);
>      smbios_maybe_add_str(1, offsetof(struct smbios_type_1, family_str),
> -                         type1.family);
> +                         smbios_type1.family);
>      if (qemu_uuid_set) {
>          /* We don't encode the UUID in the "wire format" here because this
>           * function is for legacy mode and needs to keep the guest ABI, and
> @@ -583,14 +575,14 @@ uint8_t *smbios_get_table_legacy(size_t *length)
>      size_t usr_offset;
>
>      /* also complain if fields were given for types > 1 */
> -    if (find_next_bit(have_fields_bitmap,
> +    if (find_next_bit(smbios_have_fields_bitmap,
>                        SMBIOS_MAX_TYPE + 1, 2) < SMBIOS_MAX_TYPE + 1) {
>          error_report("can't process fields for smbios "
>                       "types > 1 on machine versions < 2.1!");
>          exit(1);
>      }
>
> -    if (test_bit(4, have_binfile_bitmap)) {
> +    if (test_bit(4, smbios_have_binfile_bitmap)) {
>          error_report("can't process table for smbios "
>                       "type 4 on machine versions < 2.1!");
>          exit(1);
> @@ -631,10 +623,10 @@ uint8_t *smbios_get_table_legacy(size_t *length)
>
>  bool smbios_skip_table(uint8_t type, bool required_table)
>  {
> -    if (test_bit(type, have_binfile_bitmap)) {
> +    if (test_bit(type, smbios_have_binfile_bitmap)) {
>          return true; /* user provided their own binary blob(s) */
>      }
> -    if (test_bit(type, have_fields_bitmap)) {
> +    if (test_bit(type, smbios_have_fields_bitmap)) {
>          return false; /* user provided fields via command line */
>      }
>      if (smbios_have_defaults && required_table) {
> @@ -661,25 +653,25 @@ static void smbios_build_type_0_table(void)
>  {
>      SMBIOS_BUILD_TABLE_PRE(0, T0_BASE, false); /* optional, leave up to BIOS */
>
> -    SMBIOS_TABLE_SET_STR(0, vendor_str, type0.vendor);
> -    SMBIOS_TABLE_SET_STR(0, bios_version_str, type0.version);
> +    SMBIOS_TABLE_SET_STR(0, vendor_str, smbios_type0.vendor);
> +    SMBIOS_TABLE_SET_STR(0, bios_version_str, smbios_type0.version);
>
>      t->bios_starting_address_segment = cpu_to_le16(0xE800); /* from SeaBIOS */
>
> -    SMBIOS_TABLE_SET_STR(0, bios_release_date_str, type0.date);
> +    SMBIOS_TABLE_SET_STR(0, bios_release_date_str, smbios_type0.date);
>
>      t->bios_rom_size = 0; /* hardcoded in SeaBIOS with FIXME comment */
>
>      t->bios_characteristics = cpu_to_le64(0x08); /* Not supported */
>      t->bios_characteristics_extension_bytes[0] = 0;
>      t->bios_characteristics_extension_bytes[1] = 0x14; /* TCD/SVVP | VM */
> -    if (type0.uefi) {
> +    if (smbios_type0.uefi) {
>          t->bios_characteristics_extension_bytes[1] |= 0x08; /* |= UEFI */
>      }
>
> -    if (type0.have_major_minor) {
> -        t->system_bios_major_release = type0.major;
> -        t->system_bios_minor_release = type0.minor;
> +    if (smbios_type0.have_major_minor) {
> +        t->system_bios_major_release = smbios_type0.major;
> +        t->system_bios_minor_release = smbios_type0.minor;
>      } else {
>          t->system_bios_major_release = 0;
>          t->system_bios_minor_release = 0;
> @@ -709,18 +701,18 @@ static void smbios_build_type_1_table(void)
>  {
>      SMBIOS_BUILD_TABLE_PRE(1, T1_BASE, true); /* required */
>
> -    SMBIOS_TABLE_SET_STR(1, manufacturer_str, type1.manufacturer);
> -    SMBIOS_TABLE_SET_STR(1, product_name_str, type1.product);
> -    SMBIOS_TABLE_SET_STR(1, version_str, type1.version);
> -    SMBIOS_TABLE_SET_STR(1, serial_number_str, type1.serial);
> +    SMBIOS_TABLE_SET_STR(1, manufacturer_str, smbios_type1.manufacturer);
> +    SMBIOS_TABLE_SET_STR(1, product_name_str, smbios_type1.product);
> +    SMBIOS_TABLE_SET_STR(1, version_str, smbios_type1.version);
> +    SMBIOS_TABLE_SET_STR(1, serial_number_str, smbios_type1.serial);
>      if (qemu_uuid_set) {
>          smbios_encode_uuid(&t->uuid, &qemu_uuid);
>      } else {
>          memset(&t->uuid, 0, 16);
>      }
>      t->wake_up_type = 0x06; /* power switch */
> -    SMBIOS_TABLE_SET_STR(1, sku_number_str, type1.sku);
> -    SMBIOS_TABLE_SET_STR(1, family_str, type1.family);
> +    SMBIOS_TABLE_SET_STR(1, sku_number_str, smbios_type1.sku);
> +    SMBIOS_TABLE_SET_STR(1, family_str, smbios_type1.family);
>
>      SMBIOS_BUILD_TABLE_POST;
>  }
> @@ -1055,9 +1047,9 @@ void smbios_set_defaults(const char *manufacturer, const char *product,
>      smbios_uuid_encoded = uuid_encoded;
>      smbios_ep_type = ep_type;
>
> -    SMBIOS_SET_DEFAULT(type1.manufacturer, manufacturer);
> -    SMBIOS_SET_DEFAULT(type1.product, product);
> -    SMBIOS_SET_DEFAULT(type1.version, version);
> +    SMBIOS_SET_DEFAULT(smbios_type1.manufacturer, manufacturer);
> +    SMBIOS_SET_DEFAULT(smbios_type1.product, product);
> +    SMBIOS_SET_DEFAULT(smbios_type1.version, version);
>      SMBIOS_SET_DEFAULT(type2.manufacturer, manufacturer);
>      SMBIOS_SET_DEFAULT(type2.product, product);
>      SMBIOS_SET_DEFAULT(type2.version, version);
> @@ -1329,13 +1321,13 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
>          }
>
>          if (header->type <= SMBIOS_MAX_TYPE) {
> -            if (test_bit(header->type, have_fields_bitmap)) {
> +            if (test_bit(header->type, smbios_have_fields_bitmap)) {
>                  error_setg(errp,
>                             "can't load type %d struct, fields already specified!",
>                             header->type);
>                  return;
>              }
> -            set_bit(header->type, have_binfile_bitmap);
> +            set_bit(header->type, smbios_have_binfile_bitmap);
>          }
>
>          if (header->type == 4) {
> @@ -1366,41 +1358,42 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
>              return;
>          }
>
> -        if (test_bit(type, have_binfile_bitmap)) {
> +        if (test_bit(type, smbios_have_binfile_bitmap)) {
>              error_setg(errp, "can't add fields, binary file already loaded!");
>              return;
>          }
> -        set_bit(type, have_fields_bitmap);
> +        set_bit(type, smbios_have_fields_bitmap);
>
>          switch (type) {
>          case 0:
>              if (!qemu_opts_validate(opts, qemu_smbios_type0_opts, errp)) {
>                  return;
>              }
> -            save_opt(&type0.vendor, opts, "vendor");
> -            save_opt(&type0.version, opts, "version");
> -            save_opt(&type0.date, opts, "date");
> -            type0.uefi = qemu_opt_get_bool(opts, "uefi", false);
> +            save_opt(&smbios_type0.vendor, opts, "vendor");
> +            save_opt(&smbios_type0.version, opts, "version");
> +            save_opt(&smbios_type0.date, opts, "date");
> +            smbios_type0.uefi = qemu_opt_get_bool(opts, "uefi", false);
>
>              val = qemu_opt_get(opts, "release");
>              if (val) {
> -                if (sscanf(val, "%hhu.%hhu", &type0.major, &type0.minor) != 2) {
> +                if (sscanf(val, "%hhu.%hhu", &smbios_type0.major,
> +                           &smbios_type0.minor) != 2) {
>                      error_setg(errp, "Invalid release");
>                      return;
>                  }
> -                type0.have_major_minor = true;
> +                smbios_type0.have_major_minor = true;
>              }
>              return;
>          case 1:
>              if (!qemu_opts_validate(opts, qemu_smbios_type1_opts, errp)) {
>                  return;
>              }
> -            save_opt(&type1.manufacturer, opts, "manufacturer");
> -            save_opt(&type1.product, opts, "product");
> -            save_opt(&type1.version, opts, "version");
> -            save_opt(&type1.serial, opts, "serial");
> -            save_opt(&type1.sku, opts, "sku");
> -            save_opt(&type1.family, opts, "family");
> +            save_opt(&smbios_type1.manufacturer, opts, "manufacturer");
> +            save_opt(&smbios_type1.product, opts, "product");
> +            save_opt(&smbios_type1.version, opts, "version");
> +            save_opt(&smbios_type1.serial, opts, "serial");
> +            save_opt(&smbios_type1.sku, opts, "sku");
> +            save_opt(&smbios_type1.family, opts, "family");
>
>              val = qemu_opt_get(opts, "uuid");
>              if (val) {
> --
> 2.39.3
>
>


