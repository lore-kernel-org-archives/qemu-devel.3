Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19240C77B7F
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Jun 2025 15:31:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVB2q-0000KL-Vb; Fri, 27 Jun 2025 11:31:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uVB2l-0000JW-VS
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 11:31:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uVB2i-0002fW-9I
 for qemu-devel@nongnu.org; Fri, 27 Jun 2025 11:31:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1751038263;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TsCrr17xly5aSqAX4ey7f6U6l3M4VCizqUxATFCa/40=;
 b=NSCB5q7GSgDitwqnODySGw9/Qh+qduN6NgwEkmN/lpEQbd3/OBRazEMd9I98HeQgeo91HT
 NUrY3Jd1dg9oYEErwyE7gGLJE4gBi+/7YHL5ARlqGHR/SWcq0hfY1P19+14BxMjARZthbT
 MhZI4bZO+WOhquE8Ho+s0zIhTAg52jA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-89Vjpg4ROwOE500MvgfSNg-1; Fri, 27 Jun 2025 11:31:02 -0400
X-MC-Unique: 89Vjpg4ROwOE500MvgfSNg-1
X-Mimecast-MFC-AGG-ID: 89Vjpg4ROwOE500MvgfSNg_1751038261
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-45311704d1fso44575e9.1
 for <qemu-devel@nongnu.org>; Fri, 27 Jun 2025 08:31:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751038261; x=1751643061;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TsCrr17xly5aSqAX4ey7f6U6l3M4VCizqUxATFCa/40=;
 b=A6XjjJHimwSX2aNZmmCkCeIsGFtjF3NUYQG1TW2WPo5AGfrthrk42/NeZBJMeliMWv
 D5NnK7QIlBDmanfRop67AmfD4OVPutge6hX+FgPCIk1gHKf61Mv4g5jTMS1+FIUn0MN7
 GLr/omPL4R23N76AdJiq5eq9PSfb+DBS6H2J4k+6TyGkVGP1K3XBgo8Kv5xOqpFktQmJ
 WU6D8kg8uTRJIa5AhQb7gEAIH24U47XmbU9LDUTz+26fJu+Fq4NEHovxoScaLz5BFHQx
 EuShxBNTEtInw5bBnC4U99mycL37/SXGxnqrdrU5K/bAuMNJy9DbJ6H1anxqEOMuRmsQ
 3fJw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1Pku0ViggCp5bvpPVvChp+ygQMnMPxLRbCswVcjfPO1TgEEK7p5/C/lUO0g79lemtTKPBc49jZ2j9@nongnu.org
X-Gm-Message-State: AOJu0YyF+FEkoqgFVYA1cdqr7X7gSLZMQDBF09dBT2CyGQ7DxudXE4Uo
 kauf0/pOdPQuJSC0m8StQAWDcldLkwIpb7eX0I6R6AdvAhtBe0HKB4ViOT2jqQbTxYjBiYwGXO6
 Op+qWjdxSWSGdrSA+J//r+ttP2taR/c5anzLUFBU3qR4yF6EkWntM7rLO
X-Gm-Gg: ASbGncvojg3dZ188pW0NHQz2Zt8Jf/kK8ubbbd2jfydRG3qZxdyQItQiAE10MqEPj6f
 it8pe6ZeIuf1t6c2qswoTtEBgL/udD0cAaTxlZv5Svs4z6+UvZsa5zWW+bBd1CjtxJ9Ac/1oFZQ
 SlEDgtwGxHnOG9s2W1Cr8OHRaz0kmhlApctSVLON1Y/q0cxbYbI9bMpNROHRP44S9KL9MMOfuAs
 v1BT5Hf/YAg8q1+BidJPeMP+FzhyRHDqDumhwaxiWGGO6KLaMYi604GZYKGtm5SA8j4oTTu0n9B
 q8PGPLxYtgeXECVe2R65hiydx5nvxizsljIx09W06sqhmcq3DVN8kMsjW/e8f8UaU6+L5Q==
X-Received: by 2002:a05:600c:3594:b0:450:d01e:78ee with SMTP id
 5b1f17b1804b1-4538ee6e8f1mr38534365e9.24.1751038260863; 
 Fri, 27 Jun 2025 08:31:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFwsK1UdyVKXEhFznazWs/m16XnmVVIaBCbOLDSRp18utEMQdKqsVp0FQq5NVEW0YoWu/NmHw==
X-Received: by 2002:a05:600c:3594:b0:450:d01e:78ee with SMTP id
 5b1f17b1804b1-4538ee6e8f1mr38533655e9.24.1751038260260; 
 Fri, 27 Jun 2025 08:31:00 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a88c7e7814sm2961797f8f.8.2025.06.27.08.30.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 27 Jun 2025 08:30:59 -0700 (PDT)
Message-ID: <b756df7e-2176-45e1-95ef-c758d8d33ddc@redhat.com>
Date: Fri, 27 Jun 2025 17:30:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/9] qtest/bios-tables-test: Add test for when ITS is
 off on aarch64
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 philmd@linaro.org, mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, udo@hypervisor.org,
 ajones@ventanamicro.com, peter.maydell@linaro.org, imammedo@redhat.com,
 anisinha@redhat.com
References: <20250623135749.691137-1-gustavo.romero@linaro.org>
 <20250623135749.691137-7-gustavo.romero@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250623135749.691137-7-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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



On 6/23/25 3:57 PM, Gustavo Romero wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>
> Arm64 GIC ITS (Interrupt Translation Service) is an optional piece of
> hardware introduced in GICv3 and, being optional, it can be disabled
> in QEMU aarch64 VMs that support it using machine option "its=off",
> like, for instance: "-M virt,its=off".
>
> In ACPI, the ITS is advertised, if present, in the MADT (aka APIC)
> table, while the ID mappings from the Root Complex (RC) and from the
> SMMU nodes to the ITS Group nodes are described in the IORT table.
>
> This new test verifies that when the "its=off" option is passed to the
> machine the ITS-related data is correctly pruned from the ACPI tables.
>
> The new blobs for this test will be added in a following commit.
>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
Reviewed-by: Eric Auger <eric.auger@redhat.com>

Eric
> ---
>  tests/qtest/bios-tables-test-allowed-diff.h |  2 ++
>  tests/qtest/bios-tables-test.c              | 21 +++++++++++++++++++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8b..a88198d5c2 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
> @@ -1 +1,3 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/aarch64/virt/APIC.its_off",
> +"tests/data/acpi/aarch64/virt/IORT.its_off",
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 0b2bdf9d0d..4dbc07ec5e 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -2146,6 +2146,25 @@ static void test_acpi_aarch64_virt_tcg_topology(void)
>      free_test_data(&data);
>  }
>  
> +static void test_acpi_aarch64_virt_tcg_its_off(void)
> +{
> +    test_data data = {
> +        .machine = "virt",
> +        .arch = "aarch64",
> +        .variant = ".its_off",
> +        .tcg_only = true,
> +        .uefi_fl1 = "pc-bios/edk2-aarch64-code.fd",
> +        .uefi_fl2 = "pc-bios/edk2-arm-vars.fd",
> +        .cd = "tests/data/uefi-boot-images/bios-tables-test.aarch64.iso.qcow2",
> +        .ram_start = 0x40000000ULL,
> +        .scan_len = 128ULL * 1024 * 1024,
> +    };
> +
> +    test_acpi_one("-cpu cortex-a57 "
> +                  "-M gic-version=3,iommu=smmuv3,its=off", &data);
> +    free_test_data(&data);
> +}
> +
>  static void test_acpi_q35_viot(void)
>  {
>      test_data data = {
> @@ -2577,6 +2596,8 @@ int main(int argc, char *argv[])
>                             test_acpi_aarch64_virt_tcg_acpi_hmat);
>              qtest_add_func("acpi/virt/topology",
>                             test_acpi_aarch64_virt_tcg_topology);
> +            qtest_add_func("acpi/virt/its_off",
> +                           test_acpi_aarch64_virt_tcg_its_off);
>              qtest_add_func("acpi/virt/numamem",
>                             test_acpi_aarch64_virt_tcg_numamem);
>              qtest_add_func("acpi/virt/memhp", test_acpi_aarch64_virt_tcg_memhp);


