Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5006AC27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 12:36:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJY31-0004ks-6t; Tue, 18 Jun 2024 08:34:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sJY2u-0004ja-G1
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 08:34:46 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1sJY2s-0003LI-TH
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 08:34:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718714081;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=soFDg/JDY7uG8Ly+ZcdmlCyJ+aAaVEHDj25czzys79w=;
 b=DdotZgxKfWkdO0a+dnKMV35DG7MaSQYUhbhym3FOq7pq3IcmiMML0qKMZvAZbEVyWoKJoG
 EebICDm65zVWxJ2RvhT5SwGlgNQ9k5zZGvCq+twBCl6w7bB8m9VnUjkof40+UQwhXIzmyM
 /pYFudXCYqB7RG2Bhy4mqMTg8vM+RFw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-46-ix1CtFEhMNSmHkkR108B5Q-1; Tue, 18 Jun 2024 08:34:39 -0400
X-MC-Unique: ix1CtFEhMNSmHkkR108B5Q-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-421759c3556so32272805e9.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 05:34:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718714078; x=1719318878;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=soFDg/JDY7uG8Ly+ZcdmlCyJ+aAaVEHDj25czzys79w=;
 b=abil5f29xCm2AEzVXQOnZ8S0cTpHcUi4b/1DQSGJlh/tVVZEe/ZPmFi5Pxdpbt5l9x
 mQFRHaogrKLLUg3pPBON/FGkyy4Eupy3i6WIwy0kdrgNu+Am/E05awKuuKCRbwZY45S+
 p3msQ9UsPBB8wAlp/VoCTrELRSKJaGoyLP+SHSY22EMRLdMAI57830UIIkzYHoBpEe+i
 wSKM1H0VkSDrRBVgaeRiCr1lMBqpP7QNG7zqVrW8bmzuj9Q38FdrNA/Gi7H69uCjklMz
 7Y0UozHLsQZgbpYaYJ2hYbdpLNjw8qQyBMmCGLCz7yBK+BoAtrKEujqHYC0w8kDpK14V
 FAgQ==
X-Gm-Message-State: AOJu0YyUdjDFdg6reaT0io3Y13HsrO65oj0fS/LFH3axTNZQeaimbqJB
 aZkx0nLQicRIT1oJDENI80GdEEEyKtWZQV5NzN+3XH8tWFXGFdqdOzHeqLcLVeaaG8UfWPveeTp
 ELOumTY2rwaixpmgMAMFUA7qzUXxzAOI/EzUgZRfm6u7V8enIgigm
X-Received: by 2002:a05:600c:54e4:b0:41b:d6ca:eefa with SMTP id
 5b1f17b1804b1-4246f5ae5famr21873705e9.16.1718714078005; 
 Tue, 18 Jun 2024 05:34:38 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEHDBDQ190fyaiWWB2k2IcuL9V4oRkfhwdsETDW0ZM5CJpKksrTkvybipLzjV2sLzb4n3mmog==
X-Received: by 2002:a05:600c:54e4:b0:41b:d6ca:eefa with SMTP id
 5b1f17b1804b1-4246f5ae5famr21873415e9.16.1718714077589; 
 Tue, 18 Jun 2024 05:34:37 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4246bddc59bsm50478065e9.5.2024.06.18.05.34.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jun 2024 05:34:37 -0700 (PDT)
Date: Tue, 18 Jun 2024 14:34:36 +0200
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
 Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Alistair Francis <alistair.francis@wdc.com>
Subject: Re: [PATCH v2 04/12] qtest: bios-tables-test: Rename aarch64 tests
 with aarch64 in them
Message-ID: <20240618143436.0981cb2c@imammedo.users.ipa.redhat.com>
In-Reply-To: <20240524061411.341599-5-sunilvl@ventanamicro.com>
References: <20240524061411.341599-1-sunilvl@ventanamicro.com>
 <20240524061411.341599-5-sunilvl@ventanamicro.com>
X-Mailer: Claws Mail 4.2.0 (GTK 3.24.42; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.148,
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

On Fri, 24 May 2024 11:44:03 +0530
Sunil V L <sunilvl@ventanamicro.com> wrote:

> Existing AARCH64 virt test functions do not have AARCH64 in their name.
> To add RISC-V virt related test cases, better to rename existing
> functions to indicate they are ARM only.
> 
> Signed-off-by: Sunil V L <sunilvl@ventanamicro.com>
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>

Reviewed-by: Igor Mammedov <imammedo@redhat.com>

> ---
>  tests/qtest/bios-tables-test.c | 35 ++++++++++++++++++----------------
>  1 file changed, 19 insertions(+), 16 deletions(-)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index d1ff4db7a2..c4a4d1c7bf 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -1570,7 +1570,7 @@ static void test_acpi_piix4_tcg_dimm_pxm(void)
>      test_acpi_tcg_dimm_pxm(MACHINE_PC);
>  }
>  
> -static void test_acpi_virt_tcg_memhp(void)
> +static void test_acpi_aarch64_virt_tcg_memhp(void)
>  {
>      test_data data = {
>          .machine = "virt",
> @@ -1663,7 +1663,7 @@ static void test_acpi_microvm_ioapic2_tcg(void)
>      free_test_data(&data);
>  }
>  
> -static void test_acpi_virt_tcg_numamem(void)
> +static void test_acpi_aarch64_virt_tcg_numamem(void)
>  {
>      test_data data = {
>          .machine = "virt",
> @@ -1685,7 +1685,7 @@ static void test_acpi_virt_tcg_numamem(void)
>  
>  }
>  
> -static void test_acpi_virt_tcg_pxb(void)
> +static void test_acpi_aarch64_virt_tcg_pxb(void)
>  {
>      test_data data = {
>          .machine = "virt",
> @@ -1758,7 +1758,7 @@ static void test_acpi_piix4_tcg_acpi_hmat(void)
>      test_acpi_tcg_acpi_hmat(MACHINE_PC);
>  }
>  
> -static void test_acpi_virt_tcg_acpi_hmat(void)
> +static void test_acpi_aarch64_virt_tcg_acpi_hmat(void)
>  {
>      test_data data = {
>          .machine = "virt",
> @@ -1914,7 +1914,7 @@ static void test_acpi_microvm_acpi_erst(void)
>  }
>  #endif /* CONFIG_POSIX */
>  
> -static void test_acpi_virt_tcg(void)
> +static void test_acpi_aarch64_virt_tcg(void)
>  {
>      test_data data = {
>          .machine = "virt",
> @@ -1933,7 +1933,7 @@ static void test_acpi_virt_tcg(void)
>      free_test_data(&data);
>  }
>  
> -static void test_acpi_virt_tcg_topology(void)
> +static void test_acpi_aarch64_virt_tcg_topology(void)
>  {
>      test_data data = {
>          .machine = "virt",
> @@ -2016,7 +2016,7 @@ static void test_acpi_q35_cxl(void)
>  }
>  #endif /* CONFIG_POSIX */
>  
> -static void test_acpi_virt_viot(void)
> +static void test_acpi_aarch64_virt_viot(void)
>  {
>      test_data data = {
>          .machine = "virt",
> @@ -2192,7 +2192,7 @@ static void test_acpi_microvm_oem_fields(void)
>      g_free(args);
>  }
>  
> -static void test_acpi_virt_oem_fields(void)
> +static void test_acpi_aarch64_virt_oem_fields(void)
>  {
>      test_data data = {
>          .machine = "virt",
> @@ -2364,16 +2364,19 @@ int main(int argc, char *argv[])
>          }
>      } else if (strcmp(arch, "aarch64") == 0) {
>          if (has_tcg && qtest_has_device("virtio-blk-pci")) {
> -            qtest_add_func("acpi/virt", test_acpi_virt_tcg);
> +            qtest_add_func("acpi/virt", test_acpi_aarch64_virt_tcg);
>              qtest_add_func("acpi/virt/acpihmatvirt",
> -                            test_acpi_virt_tcg_acpi_hmat);
> -            qtest_add_func("acpi/virt/topology", test_acpi_virt_tcg_topology);
> -            qtest_add_func("acpi/virt/numamem", test_acpi_virt_tcg_numamem);
> -            qtest_add_func("acpi/virt/memhp", test_acpi_virt_tcg_memhp);
> -            qtest_add_func("acpi/virt/pxb", test_acpi_virt_tcg_pxb);
> -            qtest_add_func("acpi/virt/oem-fields", test_acpi_virt_oem_fields);
> +                           test_acpi_aarch64_virt_tcg_acpi_hmat);
> +            qtest_add_func("acpi/virt/topology",
> +                           test_acpi_aarch64_virt_tcg_topology);
> +            qtest_add_func("acpi/virt/numamem",
> +                           test_acpi_aarch64_virt_tcg_numamem);
> +            qtest_add_func("acpi/virt/memhp", test_acpi_aarch64_virt_tcg_memhp);
> +            qtest_add_func("acpi/virt/pxb", test_acpi_aarch64_virt_tcg_pxb);
> +            qtest_add_func("acpi/virt/oem-fields",
> +                           test_acpi_aarch64_virt_oem_fields);
>              if (qtest_has_device("virtio-iommu-pci")) {
> -                qtest_add_func("acpi/virt/viot", test_acpi_virt_viot);
> +                qtest_add_func("acpi/virt/viot", test_acpi_aarch64_virt_viot);
>              }
>          }
>      }


