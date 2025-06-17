Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29275C71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 15:52:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYb9-0003Xc-HB; Tue, 17 Jun 2025 11:51:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRYKj-0004Bk-Ku
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:34:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eric.auger@redhat.com>)
 id 1uRWS6-0001bE-3z
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 09:34:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750167251;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ha0XZi3PC2IVQ1lBR0EUp81EerH9P6ZxpdcTmNxLBlw=;
 b=aOHTL12h+wQN6KBcCM6UWdi3LNxx0eOXSdgpqLtfe5u+5HLDAaMhvrLr5WySisDHTDvHAB
 CAXzQuML8J8gCG6ExR1femx4vFTJ69tox6Q+dGMJcsmG7ChaBEHVTUuJy7l1gifyETQLX8
 N+1LPqJ8kVHeowmU6SDRLFSniyklEok=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-1iE24AnvO12xqmOs6LT_-g-1; Tue, 17 Jun 2025 09:34:08 -0400
X-MC-Unique: 1iE24AnvO12xqmOs6LT_-g-1
X-Mimecast-MFC-AGG-ID: 1iE24AnvO12xqmOs6LT_-g_1750167247
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4eb6fcd88so3416616f8f.1
 for <qemu-devel@nongnu.org>; Tue, 17 Jun 2025 06:34:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750167247; x=1750772047;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:reply-to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ha0XZi3PC2IVQ1lBR0EUp81EerH9P6ZxpdcTmNxLBlw=;
 b=t2LQcOQXXagJkxNpCnEFAZieVykRxoIL66Tm53qkpx7h2NUz3AM97KoZrsAd4Q3Nlw
 NAMCkPu6I7rtHiSkZ7Jux9DbUp4Fn4sh+FmUvsgaY5eYGTWOAHVH3zlav9kQv6bcVDqe
 8d5LOYRIAdc+4mn8tkSUEDboD6/9MksDHLVoLTTIAHAs4pqCpAItcd6eh2U7yQahuPWw
 LXKuXi4ZBUOBocEGrknKB/+F8E7QBIvlzAKugcS6A0J0KC8erjilnFkG9NwHi8csOhzb
 f/iP3jMuzeEctjDIrwyVw5mMT+aAUZ/V0uEniAKCSYTEtUZtlCsYJNPcdmrT5J4v1g1+
 /ypA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr/M+AX/KByMxQe8vcMNwWyz9pMIGpVA3+2N2FeCcA9HkUbaSX/tiROGR2GXQ2uwe+gKzlPGhC9diB@nongnu.org
X-Gm-Message-State: AOJu0YwMakaTHcE5zYjyb/TJpzjgSAjNCCirMHDlaiegEh9UsZiX5Brk
 gpsjbw4zVfA8q9RhV8h95MF5mpR5+xrdEUHcfS6IgThzGj5bCPBd0hEXzAU76OUvF00OsUryjlS
 5wzBqMVydmb1RaH+T3GopOS73tSRCsgovhaMCUm/88qbuh/cULQ4Jq3PA
X-Gm-Gg: ASbGncsTiiEdLJrhL8SJDVqyMIBo5601JiO6V7JFFATjaVxQfGmiWE+ISNy7DrIZDjV
 gSGRTx9/5mTjKQHlC+i8kq1gikfES+0u9MLYZsAqDyzp9cKFn6ZXqeAiVRMzIsI7q7u5eXvVaFG
 VFH1HoQe8hCg5NCnsmrNP58jVIORmockkwJH4aCAJejc6W2dzfA/+5owHqWXaoU2zzgT73d3OWc
 LrQk1T8i3km5WXUCl09KwF9YqXdE7WoCUaBsIqnYH7jTP4iMUHQViDAjPT0Fh+eUIn/wg+8JsV1
 9Fv9b4g+PYXDHa4CkDBxp2X3gylN8EprGDkyWXfUkbllPm7qMEGTBoiylFhQ8B9LKzxs6w==
X-Received: by 2002:a05:6000:1447:b0:3a5:2fad:17af with SMTP id
 ffacd0b85a97d-3a572e58cbemr8799272f8f.57.1750167247311; 
 Tue, 17 Jun 2025 06:34:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEWuKpIzFA5EOrW7frVPEBawZ2k+SvHAPCXmr54cZJx+V/3fuGOT+6ARfwZpQgnkTzTkiXMbw==
X-Received: by 2002:a05:6000:1447:b0:3a5:2fad:17af with SMTP id
 ffacd0b85a97d-3a572e58cbemr8799244f8f.57.1750167246910; 
 Tue, 17 Jun 2025 06:34:06 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:f0e:9070:527b:9dff:feef:3874?
 ([2a01:e0a:f0e:9070:527b:9dff:feef:3874])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a568a68b0esm13828969f8f.29.2025.06.17.06.34.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Jun 2025 06:34:06 -0700 (PDT)
Message-ID: <fe166574-9e53-4e27-9c12-c91f3fc774c7@redhat.com>
Date: Tue, 17 Jun 2025 15:34:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/8] qtest/bios-tables-test: Add test for when ITS is
 off on aarch64
Content-Language: en-US
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org,
 philmd@linaro.org, mst@redhat.com
Cc: qemu-arm@nongnu.org, alex.bennee@linaro.org, udo@hypervisor.org,
 ajones@ventanamicro.com, peter.maydell@linaro.org, imammedo@redhat.com,
 anisinha@redhat.com
References: <20250616131824.425315-1-gustavo.romero@linaro.org>
 <20250616131824.425315-6-gustavo.romero@linaro.org>
From: Eric Auger <eric.auger@redhat.com>
In-Reply-To: <20250616131824.425315-6-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=eric.auger@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
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
Reply-To: eric.auger@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi Gustavo,

On 6/16/25 3:18 PM, Gustavo Romero wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
>
> Arm64 GIC ITS (Interrupt Translation Service) is an optional piece of
> hardware introduced in GICv3 and, being optional, it can be disabled
> in QEMU aarch64 VMs that support it using machine option "its=off",
> like, for instance: "-M virt,its=off".
>
> In ACPI, the ITS is advertised, if present, in the MADT (aka APIC)
> table and the remappings from the Root Complex (RC) and from the SMMU
I would rephrase "and the remappings" by "while the RID mappings from ..."
> nodes to the ITS Group nodes are described in the IORT table.
>
> This new test verifies that when the "its=off" option is passed to the
> machine the ITS-related data is correctly pruned from the ACPI tables.
>
> The new blobs for this test will be added in a following commit.
>
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  tests/qtest/bios-tables-test-allowed-diff.h |  2 ++
>  tests/qtest/bios-tables-test.c              | 21 +++++++++++++++++++++
>  2 files changed, 23 insertions(+)
>
> diff --git a/tests/qtest/bios-tables-test-allowed-diff.h b/tests/qtest/bios-tables-test-allowed-diff.h
> index dfb8523c8b..a88198d5c2 100644
> --- a/tests/qtest/bios-tables-test-allowed-diff.h
> +++ b/tests/qtest/bios-tables-test-allowed-diff.h
I still fail to understand whether empty tables + update if the

bios-tables-test-allowed-diff.h need to be done prior to adding the new test.

 * How to add or update the tests or commit changes that affect ACPI tables:
 * Contributor:
 * 1. add empty files for new tables, if any, under tests/data/acpi
 * 2. list any changed files in tests/qtest/bios-tables-test-allowed-diff.h
 * 3. commit the above *before* making changes that affect the tables

> @@ -1 +1,3 @@
>  /* List of comma-separated changed AML files to ignore */
> +"tests/data/acpi/aarch64/virt/APIC.its_off",
> +"tests/data/acpi/aarch64/virt/IORT.its_off",
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 0b2bdf9d0d..4201ec1131 100644
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
> +        .variant =".its_off",
you have a checkpatch error here.
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
Thanks

Eric


