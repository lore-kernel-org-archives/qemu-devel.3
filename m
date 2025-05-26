Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 080C3C54FB3
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 15:29:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJZks-0005Qi-Q5; Mon, 26 May 2025 11:28:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uJZkq-0005QP-HA
 for qemu-devel@nongnu.org; Mon, 26 May 2025 11:28:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uJZki-0007Gr-T6
 for qemu-devel@nongnu.org; Mon, 26 May 2025 11:28:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748273314;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0D4G09sMAs0RI5p0M++zlUeeduTrotw29CxcbTEtKGM=;
 b=OMKllwRQTwK70c0zKh33kB7VFc7ZVO5RV6GuxzqACSbeUYpeKeZlCBfJTnkcztrjI9AnkO
 rGDlGTnrUG40taHtgfWuTOsPXbabezOOAifN+oWWFzBY0I/Lpvi0pZd5zQyXe+C5Msejg0
 NyR/LjkIREo1FeuvlYOnd9ziar1YmHk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-QBnAXOsTMsyQIFhrIv2xMg-1; Mon, 26 May 2025 11:28:33 -0400
X-MC-Unique: QBnAXOsTMsyQIFhrIv2xMg-1
X-Mimecast-MFC-AGG-ID: QBnAXOsTMsyQIFhrIv2xMg_1748273312
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4dcfc375aso526870f8f.2
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 08:28:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748273311; x=1748878111;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0D4G09sMAs0RI5p0M++zlUeeduTrotw29CxcbTEtKGM=;
 b=XssVuedb4GTR8dlSrKf+e9zq6lW261PsZpUWJT4B0OQ2qSHKNq5PBvZcmCW9kErwHw
 Ag03Ab0XVZ6r2yfbD5Xa1AZH2nTxGNye26JzVyCsYKcTyXqlfJmyrjO7ZolqVULaO8Dd
 9479S+jlSlIln2ov4lts4BQJ4te7iaAb56HVRWfEeecipPClne9njNJwTIT4cLaUL+t5
 tDrnbY/zTTNLLD6pR1Z7EQhjR1yAxh7DuwYi3X22igCdpg6s4Z8oyK54GV0zd+EWsHTn
 VFzuNG8NlHBxr/2rqTocbg5lPyWWVUp9oHJNxl52V3Kfo51UeONEsnlRfXqXG5QBmc7D
 8LZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV28URdWo3n6mcdtRksb+f+xBbCPy9MovBKSCJWA7bT+qhGpI01uVPJtsLKmFgUY468o6tKNfI6RQwV@nongnu.org
X-Gm-Message-State: AOJu0Yzb6QjuK/j9LF3F+khtHr84MRMvWiHwOIyFuh2zdDmOpl/zwmRS
 jAL0vfya1Ihvu4cGV11B6E/J2fMNYWrLhurgOuzvTWtkgg8x0w8SUb/yyDh6maCQcE0LvBrl/en
 FNG0MzuNyszxVPD497VJkBNwUwpP002tbOHKdKHSFSSikCqG/0KRa8hXZ
X-Gm-Gg: ASbGncuKMl090HPphCMo1SzQuOUcYeVfdb1eSryBjuxYi2vSkwpd3+QS+CqTQAPJAdz
 oPK2lyg1Qr7tY0rQaNYEy6hIUhn+xfqtdB8FmPpFVfTAVJI7EwiBk0d0Q1RZRfxgqimh0wdXp5e
 E+wg2ufLD6JS9tQsFvEgn2jKX9fLTAU5rpI1FXtw7Kj0HRZvyL8ByKWdlLi94CZUaxJcIdfEPM7
 cniPQe+UHWiqxu3RkJUqAM/2d0Vqomy1t3LYbj1o8pfJVi1ENzKaqMtUjz5JlcXkhRer2PHV6A0
 7CqzX4FL4zDOo8/I41g5+lHS9xRppK7X3JcKyPzO0BnsUOaRZNijhnY4ycI=
X-Received: by 2002:a05:6000:4203:b0:3a4:79e8:d1d8 with SMTP id
 ffacd0b85a97d-3a4cb0eaf18mr7382042f8f.0.1748273311643; 
 Mon, 26 May 2025 08:28:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuo4ZjT3WRUKvBnT35tg9hXEHu6UvFu8ynqDn31C+dT6wU4vrZGFcK3HxRJMcD91eIB053rg==
X-Received: by 2002:a05:6000:4203:b0:3a4:79e8:d1d8 with SMTP id
 ffacd0b85a97d-3a4cb0eaf18mr7382021f8f.0.1748273311244; 
 Mon, 26 May 2025 08:28:31 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a4c591c044sm9910815f8f.52.2025.05.26.08.28.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 May 2025 08:28:30 -0700 (PDT)
Message-ID: <a9a8d55f-7409-4dd6-97f6-a373de9870df@redhat.com>
Date: Mon, 26 May 2025 17:28:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/5] tests/qtest/bios-tables-test: Keep ACPI PCI hotplug
 off
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, thuth@redhat.com, alex.bennee@linaro.org,
 mst@redhat.com, imammedo@redhat.com
References: <20250526053123.1434204-1-gustavo.romero@linaro.org>
 <20250526053123.1434204-3-gustavo.romero@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250526053123.1434204-3-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Gustavo,

On 5/26/25 7:31 AM, Gustavo Romero wrote:
> ACPI PCI hotplug is now turned on by default so we need to change the
> existing tests to keep it off. However, even setting the ACPI PCI
> hotplug off in the existing tests, there will be changes in the ACPI
> tables because the _OSC method was modified, hence in the next patch of
> this series the blobs are updated accordingly.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>  tests/qtest/bios-tables-test.c | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 0a333ec435..216941dbb5 100644
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
> @@ -1775,7 +1775,8 @@ static void test_acpi_aarch64_virt_tcg_pxb(void)
>       * to solve the conflicts.
>       */
>      data.variant = ".pxb";
> -    test_acpi_one(" -device pcie-root-port,chassis=1,id=pci.1"
> +    test_acpi_one(" -machine acpi-pcihp=off"
> +                  " -device pcie-root-port,chassis=1,id=pci.1"
>                    " -device virtio-scsi-pci,id=scsi0,bus=pci.1"
>                    " -drive file="
>                    "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2,"
> @@ -1846,7 +1847,7 @@ static void test_acpi_aarch64_virt_tcg_acpi_hmat(void)
>  
>      data.variant = ".acpihmatvirt";
>  
> -    test_acpi_one(" -machine hmat=on"
> +    test_acpi_one(" -machine hmat=on,acpi-pcihp=off"
>                    " -cpu cortex-a57"
>                    " -smp 4,sockets=2"
>                    " -m 384M"
> @@ -2123,6 +2124,7 @@ static void test_acpi_aarch64_virt_tcg(void)
>      data.smbios_cpu_max_speed = 2900;
>      data.smbios_cpu_curr_speed = 2700;
>      test_acpi_one("-cpu cortex-a57 "
> +                  "-machine acpi-pcihp=off "
>                    "-smbios type=4,max-speed=2900,current-speed=2700", &data);
>      free_test_data(&data);
On my end I also need to add -machine acpi-pcihp=off in
test_acpi_aarch64_virt_tcg_numamem

with that fixed,

Reviewed-by: Eric Auger <eric.auger@redhat.com>


Thanks

Eric
>  }
> @@ -2142,6 +2144,7 @@ static void test_acpi_aarch64_virt_tcg_topology(void)
>      };
>  
>      test_acpi_one("-cpu cortex-a57 "
> +                  "-machine acpi-pcihp=off "
>                    "-smp sockets=1,clusters=2,cores=2,threads=2", &data);
>      free_test_data(&data);
>  }
> @@ -2227,6 +2230,7 @@ static void test_acpi_aarch64_virt_viot(void)
>      };
>  
>      test_acpi_one("-cpu cortex-a57 "
> +                  "-machine acpi-pcihp=off "
>                    "-device virtio-iommu-pci", &data);
>      free_test_data(&data);
>  }


