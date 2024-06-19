Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC801C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2024 10:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJsJI-0002o6-DJ; Wed, 19 Jun 2024 06:13:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sJsJG-0002nh-HZ
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 06:12:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sJsJF-0004mY-0B
 for qemu-devel@nongnu.org; Wed, 19 Jun 2024 06:12:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718791975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yxcEACsROowAyIbQBJWZ0dhTLTQHNsHOEPITA/EhrVs=;
 b=XObLlucyUq8y90nFvOihTkERIluYtavobnsigWwbwMzqs+04e+UjKC+mA0yThPABt4VxDO
 Iw9n8UzLL3BGJq9ePts5fj7Np+GFBcPI36Or2i9moGkpIGLpSugu6x2gGr92rM2A+XIs26
 dQBSNbCpA6r4OkmeK5OBc2sKSR6ryrc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-iefNf-mdP-6YyqP-U_OxsA-1; Wed, 19 Jun 2024 06:12:53 -0400
X-MC-Unique: iefNf-mdP-6YyqP-U_OxsA-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-422a0f21366so49875665e9.1
 for <qemu-devel@nongnu.org>; Wed, 19 Jun 2024 03:12:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718791972; x=1719396772;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yxcEACsROowAyIbQBJWZ0dhTLTQHNsHOEPITA/EhrVs=;
 b=AnTTSODLEHWV55BmzBoqdulkr3gw/5d2FHPUExJ2on0L6B+SKiqrS9K5c273RSc2WP
 vD9AfDE8QJkF8wFEhQ8HKqxhwAob7lWQMSWEF519K87KRV4VsC2y3c1bF3ECJ1z+ANXZ
 PaTygjjBB6gVSR0Rrjr4F5fSNn/bEBmj+b0afcrlYHVc73yB1SF6hTALH76v0apNS5SZ
 c+/KG6P1B+nN9eRYrUi38lJ5R0VOirxLzY8DedXBNFVlO2FDGfJa8sVTALWH0yTKzIy1
 VoF6EifsXH9cf7LWN6DA/GsIrp8wVTyNwODjtiUX85/DDkl2R/9XfCHpB2drB56LDzyB
 +yag==
X-Gm-Message-State: AOJu0YyQg+Y7QaGux6xo559zjvgUV6MZIktK9FZARf/EI/KubxMpuH6Q
 SUmigQR9FwkfnlAOnlj9rnQRIbr5HYYrvB7R4lMiGTJyhtifB4VT6geZATBjDHXPSIEM5pycF0x
 QZsyD1FZDv8u5KcUv/O2BZ/1Qg3fmAilBTGDP9ib72u4dU9goBzoq
X-Received: by 2002:a05:600c:3587:b0:422:6e65:a4cb with SMTP id
 5b1f17b1804b1-4247507865fmr15130825e9.3.1718791972550; 
 Wed, 19 Jun 2024 03:12:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHjBSjMJ2/B3FndbIHKgreaVhYjyIQLl2w9f1caZ/dsb5i8nbfceMaH27XuzHEYtOaWHByyWA==
X-Received: by 2002:a05:600c:3587:b0:422:6e65:a4cb with SMTP id
 5b1f17b1804b1-4247507865fmr15130675e9.3.1718791972222; 
 Wed, 19 Jun 2024 03:12:52 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42307d5b78fsm174578745e9.6.2024.06.19.03.12.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Jun 2024 03:12:51 -0700 (PDT)
Date: Wed, 19 Jun 2024 12:12:50 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Sunil V L <sunilvl@ventanamicro.com>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org, qemu-riscv@nongnu.org, Paolo
 Bonzini <pbonzini@redhat.com>, =?UTF-8?B?TWFyYy1BbmRyw6k=?= Lureau
 <marcandre.lureau@redhat.com>, "Daniel P . =?UTF-8?B?QmVycmFuZ8Op?="
 <berrange@redhat.com>, Thomas Huth <thuth@redhat.com>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, "Michael S . Tsirkin"
 <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>, Laurent Vivier
 <lvivier@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, Alistair Francis
 <alistair23@gmail.com>, Sia Jee Heng <jeeheng.sia@starfivetech.com>, Haibo1
 Xu <haibo1.xu@intel.com>, Anup Patel <apatel@ventanamicro.com>, Andrew
 Jones <ajones@ventanamicro.com>, Daniel Henrique Barboza
 <dbarboza@ventanamicro.com>, Peter Maydell <peter.maydell@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Bin Meng <bmeng.cn@gmail.com>, Weiwei
 Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [PATCH v2 11/12] tests/qtest/bios-tables-test.c: Enable basic
 testing for RISC-V
Message-ID: <20240619121250.38040a20@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240524061411.341599-12-sunilvl@ventanamicro.com>
References: <20240524061411.341599-1-sunilvl@ventanamicro.com>
 <20240524061411.341599-12-sunilvl@ventanamicro.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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

On Fri, 24 May 2024 11:44:10 +0530
Sunil V L <sunilvl@ventanamicro.com> wrote:

> Add basic ACPI table test case for RISC-V.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> ---
>  tests/qtest/bios-tables-test.c | 27 +++++++++++++++++++++++++++
>  1 file changed, 27 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index c73174ad00..880435a5fa 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -1935,6 +1935,29 @@ static void test_acpi_microvm_acpi_erst(void)
>  }
>  #endif /* CONFIG_POSIX */
>  
> +static void test_acpi_riscv64_virt_tcg(void)
> +{
> +    ->cd data = {
> +        .machine = "virt",
> +        .arch = "riscv64",
> +        .tcg_only = true,
> +        .uefi_fl1 = "pc-bios/edk2-riscv-code.fd",
> +        .uefi_fl2 = "pc-bios/edk2-riscv-vars.fd",
> +        .ram_start = 0x80000000ULL,
> +        .scan_len = 128ULL * 1024 * 1024,
> +    };
> +
> +    /*
> +     * RHCT will have ISA string encoded. To reduce the effort
> +     * of updating expected AML file for any new default ISA extension,
> +     * use the profile rva22s64.
> +     */
> +    test_acpi_one("-cpu rva22s64 -device virtio-blk-device,drive=hd0 "
> +                  "-drive file=tests/data/uefi-boot-images/bios-tables-test.riscv64.iso.qcow2,id=hd0",

Can you reuse test_data->cd, instead of specifying disk here? 

> +                  &data);
> +    free_test_data(&data);
> +}
> +
>  static void test_acpi_aarch64_virt_tcg(void)
>  {
>      test_data data = {
> @@ -2404,6 +2427,10 @@ int main(int argc, char *argv[])
>                  qtest_add_func("acpi/virt/viot", test_acpi_aarch64_virt_viot);
>              }
>          }
> +    } else if (strcmp(arch, "riscv64") == 0) {
> +        if (has_tcg && qtest_has_device("virtio-blk-pci")) {
> +            qtest_add_func("acpi/virt", test_acpi_riscv64_virt_tcg);
> +        }
>      }
>      ret = g_test_run();
>      boot_sector_cleanup(disk);


