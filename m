Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B4BEC36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 13:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzbsz-0005uv-DH; Tue, 01 Apr 2025 09:42:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tzbsk-0005dK-4U
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:42:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tzbsi-0006ca-Ew
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:42:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743514936;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kwRyqMwxv8nN6Tke/csvG/5mcfX4Br5ZXB2uKVLFZbA=;
 b=c8Fxjhti0bl+dsbE6QNIql900uEA3/9197zJ18U1QUho4zfqSjgLD7miqk2F7UhWSdbzSo
 o0U8oPf5rA44OrCb/EsJoWqga1t1CCsNRyFf+d3uNqkRSJ+TP1Hu5EonBLDU24daH+zzGS
 6cOBRVpn2GUeWizsoomp+jUUtph+cIk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-665-vB28ulZMMMqpsiEZycxd6Q-1; Tue, 01 Apr 2025 09:41:07 -0400
X-MC-Unique: vB28ulZMMMqpsiEZycxd6Q-1
X-Mimecast-MFC-AGG-ID: vB28ulZMMMqpsiEZycxd6Q_1743514866
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43d5ca7c86aso34345125e9.0
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 06:41:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743514866; x=1744119666;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=kwRyqMwxv8nN6Tke/csvG/5mcfX4Br5ZXB2uKVLFZbA=;
 b=bigoIfBwU1quL+BiK2MAA3mkA2yNinoLKZL5jzcYzEhpf0ekXDeicltmOKTlphQTSp
 Q0hRSzUOz/C35dYSIr9dDUfkscKDk2NwYqcd6zHr8IBVyVmP7PpRUlIpTN+uiZMUVgLN
 ZfkuvUbFQd1w+j1yORtL52syRm6Yhfu2fndcowhu/Y5mvURWo6H47i5VpCUSWHIFaeVE
 Mbsc0NtZoVXAl6pkWzslRX6710FHtw+b5302sHJdVn3nlpss2U5tvWOXdpmhJKRIET/g
 PVbQ9TQbbpmRN3hEA3CiwvUu65aSaZexwIh4EiqYK8S0+qbvBmS2O2siKP3L+xPZUkc5
 k/HQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiGFYVcGr9XgU2q+PZlROlw3Kj/yKKBv481d7H5GuUAGQlEsM45PZVhZQxC3VVtUIgqfCqTLkrSWEB@nongnu.org
X-Gm-Message-State: AOJu0Yx20/jYDzjnlzGK3tihwFQwV/jR9gTkAgj6o/eIW0g/kqdIffY4
 mYqnaSF7hL8ka43dtBI6XEXqhXDT4kN1z0m32uPR8zbTzDb8IorDGNNqQ6EWrKIx2373c21ZcW9
 u0jbGhinN4+OjxyelqZrc4upA2EYLU9j5rSUm0+Fq4RJBg9MlxRpI
X-Gm-Gg: ASbGncteYipSeSGP0xgaXkeFUzPYzVR28BeRqP1RFKSQ+mqfAPpBw8qEMuF18h5RPMb
 GmRXz2FlO9wY13AZlR/rZJBSvUJ/Vc0Qqg7IS+FK7lGFzpLU3ffoFlfE0S/J4VXuibgTm4oqBGQ
 U43FxNAHsiNjXBPMss/LL/F/Is6C5cwZFuMVDBzUcBmOr/+r4zO8TZskbcFcd3zL0HIDZw26eB7
 aq1BSKmQ01IBb57+VvgI/wW5DMgDk6gIS+dR+Pg0JxBxKtWXvzjcuBvIT9GhLCQx/nDtSZUiKdD
 dNwF4Q71PR/2DLDWg4pjDSfze/ku1/ahUE8J
X-Received: by 2002:a05:6000:1a8b:b0:39a:c9c1:5453 with SMTP id
 ffacd0b85a97d-39c2367439dmr2445203f8f.49.1743514866069; 
 Tue, 01 Apr 2025 06:41:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFuFVvFmBqjjixsV+Ao2C2VU+PL/Qs96vKJVmOn2BAbk+TKkmuwCn1dqtPhUe7M7fRpYJk/xg==
X-Received: by 2002:a05:6000:1a8b:b0:39a:c9c1:5453 with SMTP id
 ffacd0b85a97d-39c2367439dmr2445181f8f.49.1743514865668; 
 Tue, 01 Apr 2025 06:41:05 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d82dede21sm199490445e9.4.2025.04.01.06.41.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 06:41:04 -0700 (PDT)
Date: Tue, 1 Apr 2025 15:41:04 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVk?=
 =?UTF-8?B?w6k=?= <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 3/6] tests/qtest/bios-tables-test: Add basic testing for
 LoongArch64
Message-ID: <20250401154104.13219e16@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250228092729.543097-4-maobibo@loongson.cn>
References: <20250228092729.543097-1-maobibo@loongson.cn>
 <20250228092729.543097-4-maobibo@loongson.cn>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.997,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 28 Feb 2025 17:27:26 +0800
Bibo Mao <maobibo@loongson.cn> wrote:

> Add basic ACPI table test case for LoongArch64.
> 
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  tests/qtest/bios-tables-test.c | 62 ++++++++++++++++++++++++++++++++++
>  1 file changed, 62 insertions(+)
> 
> diff --git a/tests/qtest/bios-tables-test.c b/tests/qtest/bios-tables-test.c
> index 0a333ec435..008d7a0497 100644
> --- a/tests/qtest/bios-tables-test.c
> +++ b/tests/qtest/bios-tables-test.c
> @@ -2420,6 +2420,59 @@ static void test_acpi_aarch64_virt_oem_fields(void)
>      g_free(args);
>  }
>  
> +#define LOONGARCH64_INIT_TEST_DATA(data)                          \
> +    test_data data = {                                            \
> +        .machine = "virt",                                        \
> +        .arch    = "loongarch64",                                 \
> +        .tcg_only = true,                                         \
> +        .uefi_fl1 = "pc-bios/edk2-loongarch64-code.fd",           \
> +        .uefi_fl2 = "pc-bios/edk2-loongarch64-vars.fd",           \
> +        .cd = "tests/data/uefi-boot-images/"                      \
> +              "bios-tables-test.loongarch64.iso.qcow2",           \
> +        .ram_start = 0,                                           \
> +        .scan_len = 128ULL * 1024 * 1024,                         \

while it consistent with other test, we should switch to using MiB macro
so I'd like to ask
 * 1st convert all similar places in bios-tables-test.c 'x * MiB' style
 * fix up this patch to use that as well

> +    }
> +
> +static void test_acpi_loongarch64_virt(void)
> +{
> +    LOONGARCH64_INIT_TEST_DATA(data);
> +
> +    test_acpi_one("-cpu la464 ", &data);
> +    free_test_data(&data);
> +}
> +
> +static void test_acpi_loongarch64_virt_topology(void)
> +{
> +    LOONGARCH64_INIT_TEST_DATA(data);
> +
> +    data.variant = ".topology";
> +    test_acpi_one("-cpu la464 -smp sockets=1,cores=4,threads=2", &data);
> +    free_test_data(&data);
> +}
> +
> +static void test_acpi_loongarch64_virt_numamem(void)
> +{
> +    LOONGARCH64_INIT_TEST_DATA(data);
> +
> +    data.variant = ".numamem";
> +    test_acpi_one(" -cpu la464 -object memory-backend-ram,id=ram0,size=128M"
> +                  " -numa node,memdev=ram0", &data);
> +    free_test_data(&data);
> +}
> +

> +static void test_acpi_loongarch64_virt_memhp(void)
> +{
> +    LOONGARCH64_INIT_TEST_DATA(data);
> +
> +    data.variant = ".memhp";
> +    test_acpi_one(" -cpu la464 -m 128,slots=3,maxmem=1G"

> +                  " -object memory-backend-ram,id=ram0,size=64M"
> +                  " -object memory-backend-ram,id=ram1,size=64M"
> +                  " -numa node,memdev=ram0 -numa node,memdev=ram1"
> +                  " -numa dist,src=0,dst=1,val=21",
I'd test numa specific stuff in test_acpi_loongarch64_virt_numamem()
and simplify this test case.

> +                  &data);
> +    free_test_data(&data);
> +}
>  
>  int main(int argc, char *argv[])
>  {
> @@ -2593,6 +2646,15 @@ int main(int argc, char *argv[])
>              qtest_add_func("acpi/virt/numamem",
>                             test_acpi_riscv64_virt_tcg_numamem);
>          }
> +    } else if (strcmp(arch, "loongarch64") == 0) {
> +        if (has_tcg && qtest_has_device("virtio-blk-pci")) {
                          ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
is it necessary?
if yes, then add explanation to commit message, why it's need.

> +            qtest_add_func("acpi/virt", test_acpi_loongarch64_virt);
> +            qtest_add_func("acpi/virt/topology",
> +                           test_acpi_loongarch64_virt_topology);
> +            qtest_add_func("acpi/virt/numamem",
> +                           test_acpi_loongarch64_virt_numamem);
> +            qtest_add_func("acpi/virt/memhp", test_acpi_loongarch64_virt_memhp);
> +        }
>      }
>      ret = g_test_run();
>      boot_sector_cleanup(disk);


