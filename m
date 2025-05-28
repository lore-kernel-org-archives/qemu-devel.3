Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F00C5AD49
	for <qemu-devel@archiver.kernel.org>; Wed, 28 May 2025 09:39:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uKDEx-0006kO-8H; Wed, 28 May 2025 05:38:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uKDEs-0006jX-Ry
 for qemu-devel@nongnu.org; Wed, 28 May 2025 05:38:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1uKDEq-0002qc-7g
 for qemu-devel@nongnu.org; Wed, 28 May 2025 05:38:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748425098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=krFMIC+eTZXcDknndge0Xr7QUcgAcGAFRiTpmtefKt0=;
 b=Yl27hQYKwgQ9D/1VP4I70Zj0qvX3OM68JGVRBvD7+rObZ64mtjgriP16hfViLsbWQxc4W8
 jRClmctyLeZTVWJldFP3n/rY8b+vLKLqCOs0oknjLSpFGJ/nf/T8u/hmxciuLsypoz++Jj
 A28HvbjDHcfvoFJI7unvJlu+BD1pNgE=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-84RQUfydOByoW_R-m19Qmg-1; Wed, 28 May 2025 05:38:16 -0400
X-MC-Unique: 84RQUfydOByoW_R-m19Qmg-1
X-Mimecast-MFC-AGG-ID: 84RQUfydOByoW_R-m19Qmg_1748425096
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-442dc6f0138so21875115e9.0
 for <qemu-devel@nongnu.org>; Wed, 28 May 2025 02:38:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748425095; x=1749029895;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=krFMIC+eTZXcDknndge0Xr7QUcgAcGAFRiTpmtefKt0=;
 b=jT1RPmXb/Lo1vLNUyKiiXYS6vAiQ7as9HGSganOGb/OhhrIs6ZZBOGubBwLB8U/k1c
 4qG3P+i68HCYN+b0lCD8nnYEd+906qy0y2b0JI1ugwbPN+oJQHojsdULYhMpOLC4Y1EH
 2mTqqZUgu2/+Ygt9GdgwtA07EW7E5DMlDZ1uC8VGYkTKOStP+R5jlkDaXopFDziL2upt
 INawwUfhK7tBgskZFRaSEj4VTf4kKWMjfaEVKdbxVultoaNIZZRpdac4C/JcpGa5Ygx9
 Qb++TehMaovu/zNe/r216JDXOLsVIyFNGskQzy7cq9KU6uaTlRK3j39B5Lia9rKk3VES
 El/w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUm+fJmLJnCDbi6rlXbemz3uIFMmZpx72pdVvYizwX/ARxWGoXh7glD0U/fYZ18KiwLZ1tsYHle9vJO@nongnu.org
X-Gm-Message-State: AOJu0Yw798viwSdv0MXJ6JbRVlb7l8rbaWvadJIPvpG9O4nHgYZZ234D
 USX/NidDuddnXvIuS4XSrcJ4ZWdCQ16yHNkBTmS4tREIz4w/WA1UyN3iCpPeCkPIC1hl5hmB4HV
 l42mRPspBxM7ItwXU/RpiTEv4sy2M+SdqXQQ17eVFHWE9aBQF1WoRVdOo
X-Gm-Gg: ASbGnct7CjmDbVfBjBh87BsRH/QsVbPCOt/U7jhYgKmp6FuhFaa+Ylw+CpDjfLiEZMb
 NFCnE6/Xbp/VLy3nNdmooZmeTY+cWEDXIKAj2yyTmidsg0nXvVYhleGP5SqHnJhuCASzsMTirdv
 sNM9MMhLhblhJVKzMdJkc3YR/uvVry/pRU3BghHKQCHrAsTv2Y7fdfPcGnK8JnZs9cm6Dxw2L9S
 hNCmnGYOC/BqQmUU5xj7W70bzuv9jQt9e8lO5rSQ7cB6ybW1k18oijuGi160/MEr3LKaWSKDvS/
 5eq6dd8jSzu0bFvQypxjxD5zxq5mXtMR
X-Received: by 2002:a05:600c:46c3:b0:441:d4e8:76c6 with SMTP id
 5b1f17b1804b1-44c9301912cmr162783205e9.30.1748425095468; 
 Wed, 28 May 2025 02:38:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG8gr64tZwEGsTohMi3Ythi1JtTkkppU+1vJw3jk+NmRjeosMnhnaL4pnixKLZB8mbRqAfpPQ==
X-Received: by 2002:a05:600c:46c3:b0:441:d4e8:76c6 with SMTP id
 5b1f17b1804b1-44c9301912cmr162783005e9.30.1748425095057; 
 Wed, 28 May 2025 02:38:15 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4500e1d3c6asm15262575e9.26.2025.05.28.02.38.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 May 2025 02:38:14 -0700 (PDT)
Date: Wed, 28 May 2025 11:38:13 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Eric Auger <eric.auger@redhat.com>
Cc: eric.auger.pro@gmail.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 peter.maydell@linaro.org, gustavo.romero@linaro.org, anisinha@redhat.com,
 mst@redhat.com, shannon.zhaosl@gmail.com, pbonzini@redhat.com,
 Jonathan.Cameron@huawei.com, philmd@linaro.org, alex.bennee@linaro.org
Subject: Re: [PATCH v2 24/25] tests/qtest/bios-tables-test: Keep ACPI PCI
 hotplug off
Message-ID: <20250528113813.47086516@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250527074224.1197793-25-eric.auger@redhat.com>
References: <20250527074224.1197793-1-eric.auger@redhat.com>
 <20250527074224.1197793-25-eric.auger@redhat.com>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.49; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) DKIMWL_WL_HIGH=-2.907, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

On Tue, 27 May 2025 09:40:26 +0200
Eric Auger <eric.auger@redhat.com> wrote:

> From: Gustavo Romero <gustavo.romero@linaro.org>
> 
> ACPI PCI hotplug is now turned on by default so we need to change the
> existing tests to keep it off. However, even setting the ACPI PCI
> hotplug off in the existing tests, there will be changes in the ACPI
> tables because the _OSC method was modified, hence in the next patch of
> this series the blobs are updated accordingly.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>

it would be better to test whatever default we end up with.
(like x86)

> 
> ---
> 
> [Eric] also added acpi-pcihp=off to test_acpi_aarch64_virt_tcg_numamem
> ---
>  tests/qtest/bios-tables-test.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 0a333ec435..6379dba714 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -1626,7 +1626,7 @@ static void test_acpi_aarch64_virt_tcg_memhp(void)
>      };
>  
>      data.variant = ".memhp";
> -    test_acpi_one(" -machine nvdimm=on"
> +    test_acpi_one(" -machine nvdimm=on,acpi-pcihp=off"
>                    " -cpu cortex-a57"
>                    " -m 256M,slots=3,maxmem=1G"
>                    " -object memory-backend-ram,id=ram0,size=128M"
> @@ -1747,7 +1747,8 @@ static void test_acpi_aarch64_virt_tcg_numamem(void)
>      };
>  
>      data.variant = ".numamem";
> -    test_acpi_one(" -cpu cortex-a57"
> +    test_acpi_one(" -machine acpi-pcihp=off"
> +                  " -cpu cortex-a57"
>                    " -object memory-backend-ram,id=ram0,size=128M"
>                    " -numa node,memdev=ram0",
>                    &data);
> @@ -1775,7 +1776,8 @@ static void test_acpi_aarch64_virt_tcg_pxb(void)
>       * to solve the conflicts.
>       */
>      data.variant = ".pxb";
> -    test_acpi_one(" -device pcie-root-port,chassis=1,id=pci.1"
> +    test_acpi_one(" -machine acpi-pcihp=off"
> +                  " -device pcie-root-port,chassis=1,id=pci.1"
>                    " -device virtio-scsi-pci,id=scsi0,bus=pci.1"
>                    " -drive file="
>                    "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2,"
> @@ -1846,7 +1848,7 @@ static void test_acpi_aarch64_virt_tcg_acpi_hmat(void)
>  
>      data.variant = ".acpihmatvirt";
>  
> -    test_acpi_one(" -machine hmat=on"
> +    test_acpi_one(" -machine hmat=on,acpi-pcihp=off"
>                    " -cpu cortex-a57"
>                    " -smp 4,sockets=2"
>                    " -m 384M"
> @@ -2123,6 +2125,7 @@ static void test_acpi_aarch64_virt_tcg(void)
>      data.smbios_cpu_max_speed = 2900;
>      data.smbios_cpu_curr_speed = 2700;
>      test_acpi_one("-cpu cortex-a57 "
> +                  "-machine acpi-pcihp=off "
>                    "-smbios type=4,max-speed=2900,current-speed=2700", &data);
>      free_test_data(&data);
>  }
> @@ -2142,6 +2145,7 @@ static void test_acpi_aarch64_virt_tcg_topology(void)
>      };
>  
>      test_acpi_one("-cpu cortex-a57 "
> +                  "-machine acpi-pcihp=off "
>                    "-smp sockets=1,clusters=2,cores=2,threads=2", &data);
>      free_test_data(&data);
>  }
> @@ -2227,6 +2231,7 @@ static void test_acpi_aarch64_virt_viot(void)
>      };
>  
>      test_acpi_one("-cpu cortex-a57 "
> +                  "-machine acpi-pcihp=off "
>                    "-device virtio-iommu-pci", &data);
>      free_test_data(&data);
>  }


