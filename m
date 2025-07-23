Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D87C83F17
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Jul 2025 09:14:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ueVYZ-0003bI-EK; Wed, 23 Jul 2025 05:14:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ueVYX-0003YY-8B
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 05:14:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1ueVYQ-0008BA-M1
 for qemu-devel@nongnu.org; Wed, 23 Jul 2025 05:14:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753262065;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wlLDA7xXJSjSzbMcTM8Z1Ob2QwUXr3MXCmZD1J2DUMo=;
 b=iXb8eDfyJrtydRzIl3+a/UHJ2Lh2E4hi9AY8Vr6NJ1MOav5USja3KA6e2zRl8LFrdRvlSO
 VjSQCP5RgHUCWbc5/4k83ofkNYTNVDk/eMSdT9RZu+XaiTGN4GiMWPiOSCIBAO5VN/IfnY
 J31QOWR8HvY6Bv0VsimpeP8jpkLNMgw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-240-wnX9caNbOx-sUvROGS1H8w-1; Wed, 23 Jul 2025 05:14:24 -0400
X-MC-Unique: wnX9caNbOx-sUvROGS1H8w-1
X-Mimecast-MFC-AGG-ID: wnX9caNbOx-sUvROGS1H8w_1753262062
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-451d7de4ae3so36561845e9.2
 for <qemu-devel@nongnu.org>; Wed, 23 Jul 2025 02:14:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753262061; x=1753866861;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wlLDA7xXJSjSzbMcTM8Z1Ob2QwUXr3MXCmZD1J2DUMo=;
 b=i51hxdyhNDVgF0r5j+xidbMDF5SfKQwumzPMHQVVQKe7TBmvPvTt88WAaxO9jqGNCi
 +VuufirdRRLHWGyKgNxlrlc93x6BNVMM110GeXel7OFFOzCXS/EFD95g4U0wJgdH0iXa
 /8NDTg7k2JLLnW18aC5kezFjmNnwoI2WK9y/OvRJ5VTdiPHmyIKGeR4XQhgWpf/i4Cd8
 eD00x4cZWssgex64wG0TqrtGq45koXqWeK7RodjyxPoXFFUmOA7XAnG+EDnOuMwM4kLV
 R2lBKM9GpzHSNMFp4r+yOmxIVw4ahGOWLSp6pyyMlC+2tGutru4NvLEjDHK/1lt36IEO
 YT1Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTeMXXLU0BgFJwqJg/ZRZ0OtMBc5lnaVCyzah+yJ5aHgoDnp7w9YBl7J9hHXDgji6quwZrToh0FjYe@nongnu.org
X-Gm-Message-State: AOJu0Yx7GaRvWkaxzriUYKsZ01EieSq5Bszdrc0glJE6yReFOV/9oBdt
 +rNOC6rv3TGUCx0RHEXvSARg4JDrAN6eOi8MSboJXeTcTyLOUkq4x0KaYri/M2cZU8qF0OQEcdG
 +PkTcI5mMj52laRErOXipOTzJk/MwV152NYh7v5+tiLFzcEhPm1GmwxGA
X-Gm-Gg: ASbGncuJSBPs+IefvchiFNmHRkZ4vASH5h+BhzgFsSAHiKkSJXJuLyTStifxY/Ptn+U
 E952DAu8hL4nlLHPmK5BSOuYmpOjIHrBNCqcx8RCJkOH8y5nE+UlUEFcdsoT9kkeZ3qa+L46nz/
 CbQlVVi6WPwnzQc1zaYgvLqJjiKjyewQHedFWUDt8d1puCJUT5B+afsRRqMuO7ZK/8Z0h64xQ7+
 u9qnm9Zjnsfl5rNNQpl5hocgNHctLOZ15kXeg0vfeewyumti0TUHcEwa1EpJCaYlJCwKsF4c+s+
 qnp6enFkeE4du0aIGNYhqeSJ9O1sMgqHOAg=
X-Received: by 2002:a05:600c:4f50:b0:43d:9d5:474d with SMTP id
 5b1f17b1804b1-4586a8ce615mr11912175e9.0.1753262061460; 
 Wed, 23 Jul 2025 02:14:21 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnPM6rUNoBbKLZ+WoB5rB4azDKcxv8VJ8jKcwBb/cLq4ePldZnGkrDndQ7XKbh2AkD44+9bA==
X-Received: by 2002:a05:600c:4f50:b0:43d:9d5:474d with SMTP id
 5b1f17b1804b1-4586a8ce615mr11911815e9.0.1753262060885; 
 Wed, 23 Jul 2025 02:14:20 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:153d:b500:b346:7481:16b2:6b23])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45869199418sm16571595e9.13.2025.07.23.02.14.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Jul 2025 02:14:20 -0700 (PDT)
Date: Wed, 23 Jul 2025 05:14:18 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniil Tatianin <d-tatianin@yandex-team.ru>
Cc: Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/smbios: add an ability to set extension bytes in the
 type0 table
Message-ID: <20250723051334-mutt-send-email-mst@kernel.org>
References: <20250723090128.977364-1-d-tatianin@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250723090128.977364-1-d-tatianin@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.633,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Jul 23, 2025 at 12:01:28PM +0300, Daniil Tatianin wrote:
> This is useful to be able to indicate various supported features to the
> guest, or freeze a specific version of SeaBIOS to prevent guest visible
> changes between BIOS updates. This is currently not possible since the
> extension bytes indicated by SeaBIOS are slightly different than those
> QEMU sets by default.
> 
> Signed-off-by: Daniil Tatianin <d-tatianin@yandex-team.ru>
> ---
>  hw/smbios/smbios.c           | 66 +++++++++++++++++++++++++++++++++---
>  include/hw/firmware/smbios.h |  3 ++
>  2 files changed, 64 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/smbios/smbios.c b/hw/smbios/smbios.c
> index ad4cd6721e..73699e8a62 100644
> --- a/hw/smbios/smbios.c
> +++ b/hw/smbios/smbios.c
> @@ -178,6 +178,14 @@ static const QemuOptDesc qemu_smbios_type0_opts[] = {
>          .name = "uefi",
>          .type = QEMU_OPT_BOOL,
>          .help = "uefi support",
> +    },{
> +        .name = "extension_byte_1",
> +        .type = QEMU_OPT_NUMBER,
> +        .help = "BIOS characteristics extension byte 1"
> +    },{
> +        .name = "extension_byte_2",
> +        .type = QEMU_OPT_NUMBER,
> +        .help = "BIOS characteristics extension byte 2"
>      },
>      { /* end of list */ }
>  };
> @@ -572,10 +580,23 @@ static void smbios_build_type_0_table(void)
>      t->bios_rom_size = 0; /* hardcoded in SeaBIOS with FIXME comment */
>  
>      t->bios_characteristics = cpu_to_le64(0x08); /* Not supported */
> -    t->bios_characteristics_extension_bytes[0] = 0;
> -    t->bios_characteristics_extension_bytes[1] = 0x14; /* TCD/SVVP | VM */
> -    if (smbios_type0.uefi) {
> -        t->bios_characteristics_extension_bytes[1] |= 0x08; /* |= UEFI */
> +
> +    if (smbios_type0.have_extension_bytes[0]) {
> +        t->bios_characteristics_extension_bytes[0] =
> +            smbios_type0.extension_bytes[0];
> +    } else {
> +        t->bios_characteristics_extension_bytes[0] = 0;
> +    }
> +
> +    if (smbios_type0.have_extension_bytes[1]) {
> +        t->bios_characteristics_extension_bytes[1] =
> +            smbios_type0.extension_bytes[1];
> +    } else {
> +        t->bios_characteristics_extension_bytes[1] = 0x14; /* TCD/SVVP | VM */
> +
> +        if (smbios_type0.uefi) {
> +            t->bios_characteristics_extension_bytes[1] |= 0x08; /* |= UEFI */
> +        }

should we not or these in, anyway?

>      }
>  
>      if (smbios_type0.have_major_minor) {
> @@ -1403,7 +1424,42 @@ void smbios_entry_add(QemuOpts *opts, Error **errp)
>              save_opt(&smbios_type0.vendor, opts, "vendor");
>              save_opt(&smbios_type0.version, opts, "version");
>              save_opt(&smbios_type0.date, opts, "date");
> -            smbios_type0.uefi = qemu_opt_get_bool(opts, "uefi", false);
> +
> +            if (qemu_opt_get(opts, "extension_byte_1")) {
> +                uint64_t ex_val;
> +
> +                ex_val = qemu_opt_get_number(opts, "extension_byte_1", 0);
> +                if (ex_val > 0xFF) {
> +                    error_setg(errp, "Invalid extension_byte_1");
> +                    return;
> +                }
> +
> +                smbios_type0.extension_bytes[0] = ex_val;
> +                smbios_type0.have_extension_bytes[0] = true;
> +            }
> +
> +            if (qemu_opt_get(opts, "extension_byte_2")) {
> +                uint64_t ex_val;
> +
> +                ex_val = qemu_opt_get_number(opts, "extension_byte_2", 0);
> +                if (ex_val > 0xFF) {
> +                    error_setg(errp, "Invalid extension_byte_2");
> +                    return;
> +                }
> +
> +                smbios_type0.extension_bytes[1] = ex_val;
> +                smbios_type0.have_extension_bytes[1] = true;
> +            }
> +
> +            if (qemu_opt_get(opts, "uefi")) {
> +                if (smbios_type0.have_extension_bytes[1]) {
> +                    error_setg(errp, "'uefi' and 'extension_byte_2' are "
> +                                     "mutually exclusive");
> +                    return;
> +                }
> +
> +                smbios_type0.uefi = qemu_opt_get_bool(opts, "uefi", false);
> +            }
>  
>              val = qemu_opt_get(opts, "release");
>              if (val) {
> diff --git a/include/hw/firmware/smbios.h b/include/hw/firmware/smbios.h
> index f066ab7262..67b3b28471 100644
> --- a/include/hw/firmware/smbios.h
> +++ b/include/hw/firmware/smbios.h
> @@ -24,6 +24,9 @@ typedef struct {
>      const char *vendor, *version, *date;
>      bool have_major_minor, uefi;
>      uint8_t major, minor;
> +
> +    bool have_extension_bytes[2];
> +    uint8_t extension_bytes[2];
>  } smbios_type0_t;
>  extern smbios_type0_t smbios_type0;
>  
> -- 
> 2.34.1


