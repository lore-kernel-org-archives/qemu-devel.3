Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFED0C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 15:42:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKIvF-0001bT-53; Wed, 28 May 2025 11:42:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uKIvB-0001ae-GL
 for qemu-devel@nongnu.org; Wed, 28 May 2025 11:42:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uKIv9-0007Ch-JU
 for qemu-devel@nongnu.org; Wed, 28 May 2025 11:42:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748446942;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JkVFHjCN69rMIYnSueLHuwO87ncH71LzvKdYlcB5jDE=;
 b=Zx/A+UwEPLuMyS6gkozJ/qmr+ajWqfsaaNLquNdJERkzfaPtoez0kWgSiZ9NvjMGgyIXWq
 KBsS2cVDf7ttHbNkhSVgiVBoPVlt9ZYCaeGS2hxg2EZVRfdyxInt0yE+UwoM9vonZCq+oy
 QijdAXWgRgEugyiZvQ4mk82j0YilGaY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-YmGR9cQxMri4EeEEKqNo_g-1; Wed, 28 May 2025 11:42:16 -0400
X-MC-Unique: YmGR9cQxMri4EeEEKqNo_g-1
X-Mimecast-MFC-AGG-ID: YmGR9cQxMri4EeEEKqNo_g_1748446935
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-450cb8ff0c6so3510975e9.3
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 08:42:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748446935; x=1749051735;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JkVFHjCN69rMIYnSueLHuwO87ncH71LzvKdYlcB5jDE=;
 b=ue24mGFJ7tq6hLk59iSoKRbfYk4BdB5pHOI7Cv+IDjfRiw8AsUzQ0l/1p8UuFogolU
 WdJwzFCkR5z6JFSmpgLVMtHSd46LXixfzrjy4/ciOTALmN2M2BJ4chsGWFMNp3rdMa1w
 IGPgq5XlaQt65e4ECEB4BXME8GZzfGgiEsRZbWGp1mwMN2m33//mFB2zkzqstUONimlh
 ApinbkjeeOmYHUIr4djFLduwmLnXRfYoOTLXtNRXM7i2g9hg5ahXR400PC+DqAuiCvwA
 0cpXcQF6IOJmJwSgfPM3azInlqwOKLDsiIe8ddzg+l0mk0mnrL/oQ9HKELZLr8x/q+R9
 qoMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfYQI67XIgROnIqG9gL8j2IVc2c76IwWZBj5ByOX5vRUEob7QsOWR+b/JLm2QuHNfMkEx/xnv1j0lF@nongnu.org
X-Gm-Message-State: AOJu0YxriqZKefl6iyoX4lVnsdCjj8/X/64pTfxU9knRFgSnzUd1ez61
 8gOY960B1epz5DHHsmFys7YAl6PgbbnXd9haKW/QAXWk/0TWETvbHmlt2wNtin3cp0Ol5ZlGO92
 KJ5rJhF1bW04ainBaYhsxILFdyeez3f4qGEsIQkz4zs7F1XlcjFRcLkSl
X-Gm-Gg: ASbGncvs8SDFJOXaF/BOw6MDDIXZ1e3nM/ELJbAZnJC1C8ndMYx8FvNxJbFRiA/5Gwc
 XONISmZNz1g7l/HmEMGeikMJg4X6TSSJGbCvuuaTm78pXFEdyn2FANcMg909zB2H3l+YgSSFg9I
 6yXT/50BX9qSHpwM4jsq3cPwgjErt+TKot+piLhVDv9X4LxRfPClpPpQLjusY7/T1xIKq/bO8uJ
 p4LG6Qlynl6oCZ9QeNjPOvKm/4rSo3iKCxp7PEiqCExyye5a1WMymHc6/bbUVClQCeDT+jTxWCr
 3+VyD0ankh2Us1ZnpUbHxoxnbDxt3MNx
X-Received: by 2002:a05:600c:4ecc:b0:43c:ec28:d31b with SMTP id
 5b1f17b1804b1-44c941880cbmr198078785e9.10.1748446934784; 
 Wed, 28 May 2025 08:42:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEhMhP3AFA8siIQZeA7ho8Lq7zKFRO7eRXp30XQAFRSeMpQ9zxWigwT0rvakMhJPQqK4OZRhg==
X-Received: by 2002:a05:600c:4ecc:b0:43c:ec28:d31b with SMTP id
 5b1f17b1804b1-44c941880cbmr198078455e9.10.1748446934380; 
 Wed, 28 May 2025 08:42:14 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4500e1dd785sm25901345e9.39.2025.05.28.08.42.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 08:42:13 -0700 (PDT)
Date: Wed, 28 May 2025 17:42:12 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Jonathan Cameron
 <Jonathan.Cameron@huawei.com>, Shiju Jose <shiju.jose@huawei.com>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, Philippe =?UTF-8?B?TWF0aGll?=
 =?UTF-8?B?dS1EYXVkw6k=?= <philmd@linaro.org>, Ani Sinha
 <anisinha@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, Peter Maydell
 <peter.maydell@linaro.org>, Shannon Zhao <shannon.zhaosl@gmail.com>, Yanan
 Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v9 12/20] acpi/generic_event_device: add logic to detect
 if HEST addr is available
Message-ID: <20250528174212.2823d3de@imammedo.users.ipa.redhat.com>
In-Reply-To: <aa74b756f633dbee5442cf4baa2c1d81a669d2f9.1747722973.git.mchehab+huawei@kernel.org>
References: <cover.1747722973.git.mchehab+huawei@kernel.org>
 <aa74b756f633dbee5442cf4baa2c1d81a669d2f9.1747722973.git.mchehab+huawei@kernel.org>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.904,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Tue, 20 May 2025 08:41:31 +0200
Mauro Carvalho Chehab <mchehab+huawei@kernel.org> wrote:

> Create a new property (x-has-hest-addr) and use it to detect if
> the GHES table offsets can be calculated from the HEST address
> (qemu 10.0 and upper) or via the legacy way via an offset obtained
> from the hardware_errors firmware file.


it doesn't apply to current master anymore


> 
> Signed-off-by: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Reviewed-by: Igor Mammedov <imammedo@redhat.com>
> ---
>  hw/acpi/generic_event_device.c |  2 ++
>  hw/arm/virt-acpi-build.c       | 18 ++++++++++++++++--
>  hw/core/machine.c              |  5 ++++-
>  3 files changed, 22 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/acpi/generic_event_device.c b/hw/acpi/generic_event_device.c
> index d292f61b4e41..3cf9dab0d01a 100644
> --- a/hw/acpi/generic_event_device.c
> +++ b/hw/acpi/generic_event_device.c
> @@ -318,6 +318,8 @@ static void acpi_ged_send_event(AcpiDeviceIf *adev, AcpiEventStatusBits ev)
>  
>  static const Property acpi_ged_properties[] = {
>      DEFINE_PROP_UINT32("ged-event", AcpiGedState, ged_event_bitmap, 0),
> +    DEFINE_PROP_BOOL("x-has-hest-addr", AcpiGedState,
> +                     ghes_state.use_hest_addr, false),
>  };
>  
>  static const VMStateDescription vmstate_memhp_state = {
> diff --git a/hw/arm/virt-acpi-build.c b/hw/arm/virt-acpi-build.c
> index da3ebf403ef9..3126234e657d 100644
> --- a/hw/arm/virt-acpi-build.c
> +++ b/hw/arm/virt-acpi-build.c
> @@ -893,6 +893,10 @@ static const AcpiNotificationSourceId hest_ghes_notify[] = {
>      { ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA },
>  };
>  
> +static const AcpiNotificationSourceId hest_ghes_notify_10_0[] = {
> +    { ACPI_HEST_SRC_ID_SYNC, ACPI_GHES_NOTIFY_SEA },
> +};
> +
>  static
>  void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>  {
> @@ -947,15 +951,25 @@ void virt_acpi_build(VirtMachineState *vms, AcpiBuildTables *tables)
>  
>      if (vms->ras) {
>          AcpiGedState *acpi_ged_state;
> +        static const AcpiNotificationSourceId *notify;
> +        unsigned int notify_sz;
>          AcpiGhesState *ags;
>  
>          acpi_ged_state = ACPI_GED(vms->acpi_dev);
>          ags = &acpi_ged_state->ghes_state;
>          if (ags) {
>              acpi_add_table(table_offsets, tables_blob);
> +
> +            if (!ags->use_hest_addr) {
> +                notify = hest_ghes_notify_10_0;
> +                notify_sz = ARRAY_SIZE(hest_ghes_notify_10_0);
> +            } else {
> +                notify = hest_ghes_notify;
> +                notify_sz = ARRAY_SIZE(hest_ghes_notify);
> +            }
> +
>              acpi_build_hest(ags, tables_blob, tables->hardware_errors,
> -                            tables->linker, hest_ghes_notify,
> -                            ARRAY_SIZE(hest_ghes_notify),
> +                            tables->linker, notify, notify_sz,
>                              vms->oem_id, vms->oem_table_id);
>          }
>      }
> diff --git a/hw/core/machine.c b/hw/core/machine.c
> index b8ae155dfa11..dfd36cf063c7 100644
> --- a/hw/core/machine.c
> +++ b/hw/core/machine.c
> @@ -35,9 +35,12 @@
>  #include "hw/virtio/virtio-pci.h"
>  #include "hw/virtio/virtio-net.h"
>  #include "hw/virtio/virtio-iommu.h"
> +#include "hw/acpi/generic_event_device.h"
>  #include "audio/audio.h"
>  
> -GlobalProperty hw_compat_10_0[] = {};
> +GlobalProperty hw_compat_10_0[] = {
> +    { TYPE_ACPI_GED, "x-has-hest-addr", "false" },
> +};
>  const size_t hw_compat_10_0_len = G_N_ELEMENTS(hw_compat_10_0);
>  
>  GlobalProperty hw_compat_9_2[] = {


