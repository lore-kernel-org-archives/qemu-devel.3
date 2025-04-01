Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3CFF0C36010
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Apr 2025 14:01:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzc1e-0000du-Gz; Tue, 01 Apr 2025 09:51:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tzc0p-0008Th-0B
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:50:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tzc0n-0007Xh-82
 for qemu-devel@nongnu.org; Tue, 01 Apr 2025 09:50:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1743515440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FimNuAvNHPXMUfJfSY+a3FqUY0CSnbtGI00gSyxpzSE=;
 b=K36a6ihW+I6m/S/HTzOyg818eRC+fM/2VxSFFMjq3rhU0O8iYMyp0kzZe6Dmu160TKWktd
 /yErOrz0S/RCyHiHR54M0IFRnZ4B+iYNrjT9ZkC+mSytVgLdwYfksavEZgnEvmgW+2uYM1
 D11SOpMKB4iUH5IASe9ImX9fJQKExWk=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-592-8xz4aiwDP4a8Sijpc1QhMQ-1; Tue, 01 Apr 2025 09:50:37 -0400
X-MC-Unique: 8xz4aiwDP4a8Sijpc1QhMQ-1
X-Mimecast-MFC-AGG-ID: 8xz4aiwDP4a8Sijpc1QhMQ_1743515436
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43cf172ff63so36512105e9.3
 for <qemu-devel@nongnu.org>; Tue, 01 Apr 2025 06:50:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743515436; x=1744120236;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=FimNuAvNHPXMUfJfSY+a3FqUY0CSnbtGI00gSyxpzSE=;
 b=GaL62hRoWHpXqad6CfeyT92T6GbX7S8nO7w9OnXjXwD8+t9LRabzPLFXnr+aAF7cWK
 E8oUMbEdrvnvxmG3Sqdkj9wWgjQ6vhCxf3Oq1Pl6ES4URTlOJLAQGQJyqpNQjmtwBspA
 3Vq9185YClLqEi+R1FYoTdGKhum/dsji2ENml3Gllhc2i2vzmioct/8F77OB4D+uH4AD
 Y45VEoWTw2/8/rRwj2nYD6tNU5wV1BSzI2u+6skfY0lACtHePUlShcTOBi3XD+YeWLDe
 u5NbytsV61bxCoUk8lV+1XzpgL5iJ93V59mf8rOd6OBszmLqwiMNgcaCaOOAJfzqFrqg
 Igbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZtCs7IXu6oAbqwD0VXtWYFAkWOUSyjpQM8ULlX02dxQzHJEK5tSUwW1Q3YBaOFRVisE46hU8lOF7B@nongnu.org
X-Gm-Message-State: AOJu0Yygtn6zXPM+EfPyTKbie+Ak9TEn4OH1TbeINDxDX7MmWBCgIaqv
 XBUUo10fzz7cjjVL0F3SZCfr9zej2K/woU41rVnVCjoO2wkl72iwbl3GcYzXWoI2h441c6/5yd6
 SLQOJluPzuvZb1AI2qjr47tTaIDw/7CnJwvUe5VQ/C5cfzjjCuBf5
X-Gm-Gg: ASbGncsGI3B62G4ynokPqSYdmgWi5OeD2uYRaWduHq21Eq0N8KL6t5kVKuwV3wAsP+Z
 yAkgrqvXT7VJfyF9anREnmq21LiBp44H8oInJpdbUiYTGbXYYo58vuAm+1D9ef6Jd2jzCCGFY0M
 16umk2jB6F7386+0zn4eJIU61rSgV3h+bJAzAfmQWKIq8zBuD3Lkse3yclpdHWUGfRkLaXmKKOl
 KSHcOdHkxbcpubfgJzZxhvMdDApjijZnV+6ixxyOd8nMD3+Imx+uac9AzXQ5R7li8iqpwY3SD/Z
 gDK7S6cozo7YJuzu7PMsdxEBZeI6NYGgCCll
X-Received: by 2002:a05:600c:4fce:b0:43b:cc42:c54f with SMTP id
 5b1f17b1804b1-43ea7c71a97mr33129005e9.14.1743515436019; 
 Tue, 01 Apr 2025 06:50:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEB7vA9Nbv2xo+w4fCuBVjMa5Xv9r7t/3qIGoFfzgAxsj9lRaW3zq3YTwAezJtSRhZhpUckpg==
X-Received: by 2002:a05:600c:4fce:b0:43b:cc42:c54f with SMTP id
 5b1f17b1804b1-43ea7c71a97mr33128675e9.14.1743515435634; 
 Tue, 01 Apr 2025 06:50:35 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com ([85.93.96.130])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b66ab86sm14580909f8f.51.2025.04.01.06.50.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 01 Apr 2025 06:50:35 -0700 (PDT)
Date: Tue, 1 Apr 2025 15:50:34 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Bibo Mao <maobibo@loongson.cn>
Cc: Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Philippe =?UTF-8?B?TWF0aGlldS1EYXVk?=
 =?UTF-8?B?w6k=?= <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH 0/6] Add bios-tables-test for LoongArch64 system
Message-ID: <20250401155034.528b35a8@imammedo.users.ipa.redhat.com>
In-Reply-To: <20250228092729.543097-1-maobibo@loongson.cn>
References: <20250228092729.543097-1-maobibo@loongson.cn>
X-Mailer: Claws Mail 4.3.1 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=imammedo@redhat.com;
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

On Fri, 28 Feb 2025 17:27:23 +0800
Bibo Mao <maobibo@loongson.cn> wrote:

> This patchset add bios-tables-test for LoongArch64 virt machine
> system. It works with UEFI bios, with uefi-test-tools LoongArch64
> support is added to build bios-tables-test.loongarch64.iso.
> 
> Also with test case bios-tables-test, LoongArch64 support is added
> and some basic ACPI tables is added here. It passes with command
> make check-qtest-loongarch64 with the result:
>  qtest-loongarch64/bios-tables-test OK 29.52s 4 subtests passed
> 
> Bibo Mao (6):
>   uefi-test-tools:: Add LoongArch64 support
>   tests/data/uefi-boot-images: Add ISO image for LoongArch system
>   tests/qtest/bios-tables-test: Add basic testing for LoongArch64
>   tests/acpi: Add empty ACPI data files for LoongArch64
>   tests/acpi: Fill acpi table data for LoongArch

blobs no longer match (since cpu hotplug was merged after this series)
so blobs need to be updated and series needs to be re-spun

>   tests/qtest: Enable bios-tables-test for LoongArch
> 
>  tests/data/acpi/loongarch64/virt/APIC         | Bin 0 -> 108 bytes
>  .../data/acpi/loongarch64/virt/APIC.topology  | Bin 0 -> 213 bytes
>  tests/data/acpi/loongarch64/virt/DSDT         | Bin 0 -> 3614 bytes
>  tests/data/acpi/loongarch64/virt/DSDT.memhp   | Bin 0 -> 4951 bytes
>  tests/data/acpi/loongarch64/virt/FACP         | Bin 0 -> 268 bytes
>  tests/data/acpi/loongarch64/virt/MCFG         | Bin 0 -> 60 bytes
>  tests/data/acpi/loongarch64/virt/PPTT         | Bin 0 -> 76 bytes
>  .../data/acpi/loongarch64/virt/PPTT.topology  | Bin 0 -> 296 bytes
>  tests/data/acpi/loongarch64/virt/SLIT         |   0
>  tests/data/acpi/loongarch64/virt/SLIT.memhp   | Bin 0 -> 48 bytes
>  tests/data/acpi/loongarch64/virt/SPCR         | Bin 0 -> 80 bytes
>  tests/data/acpi/loongarch64/virt/SRAT         | Bin 0 -> 104 bytes
>  tests/data/acpi/loongarch64/virt/SRAT.memhp   | Bin 0 -> 184 bytes
>  .../data/acpi/loongarch64/virt/SRAT.topology  | Bin 0 -> 216 bytes
>  .../bios-tables-test.loongarch64.iso.qcow2    | Bin 0 -> 12800 bytes
>  tests/qtest/bios-tables-test.c                |  62 ++++++++++++++++++
>  tests/qtest/meson.build                       |   3 +-
>  tests/uefi-test-tools/Makefile                |   5 +-
>  .../UefiTestToolsPkg/UefiTestToolsPkg.dsc     |   6 +-
>  tests/uefi-test-tools/uefi-test-build.config  |  10 +++
>  20 files changed, 82 insertions(+), 4 deletions(-)
>  create mode 100644 tests/data/acpi/loongarch64/virt/APIC
>  create mode 100644 tests/data/acpi/loongarch64/virt/APIC.topology
>  create mode 100644 tests/data/acpi/loongarch64/virt/DSDT
>  create mode 100644 tests/data/acpi/loongarch64/virt/DSDT.memhp
>  create mode 100644 tests/data/acpi/loongarch64/virt/FACP
>  create mode 100644 tests/data/acpi/loongarch64/virt/MCFG
>  create mode 100644 tests/data/acpi/loongarch64/virt/PPTT
>  create mode 100644 tests/data/acpi/loongarch64/virt/PPTT.topology
>  create mode 100644 tests/data/acpi/loongarch64/virt/SLIT
>  create mode 100644 tests/data/acpi/loongarch64/virt/SLIT.memhp
>  create mode 100644 tests/data/acpi/loongarch64/virt/SPCR
>  create mode 100644 tests/data/acpi/loongarch64/virt/SRAT
>  create mode 100644 tests/data/acpi/loongarch64/virt/SRAT.memhp
>  create mode 100644 tests/data/acpi/loongarch64/virt/SRAT.topology
>  create mode 100644 tests/data/uefi-boot-images/bios-tables-test.loongarch64.iso.qcow2
> 
> 
> base-commit: b69801dd6b1eb4d107f7c2f643adf0a4e3ec9124


