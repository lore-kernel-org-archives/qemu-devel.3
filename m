Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EB211D6ACCF
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Nov 2024 13:27:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGI4T-0002E3-Ia; Wed, 27 Nov 2024 08:27:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tGI4Q-0002DS-27
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 08:27:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1tGI4J-0003bW-Gx
 for qemu-devel@nongnu.org; Wed, 27 Nov 2024 08:27:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732714015;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xYDncLwCXWDAwVz5JHz851F+6WeD9R+AN/VtwfKsQEU=;
 b=Kg4qj5TcwurJM2mwV3mPEKQTNNWNiL7FfHBC92aNCo1xspAL/YFXtneuTi4AmUpN4lWYpX
 pfqUAUWqQPq+wPKvSN+KEE8TZgparM6dD9llWjwBZ8vgTdT9AfxmOdnK88+q8SUe9UJVTp
 ocp/uOuHuUVqRDMMj6/i/r1XeChtBFM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-35-emiJa-sxM_GRM8cuzuGT_A-1; Wed, 27 Nov 2024 08:26:52 -0500
X-MC-Unique: emiJa-sxM_GRM8cuzuGT_A-1
X-Mimecast-MFC-AGG-ID: emiJa-sxM_GRM8cuzuGT_A
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-434a96889baso6436315e9.2
 for <qemu-devel@nongnu.org>; Wed, 27 Nov 2024 05:26:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732714009; x=1733318809;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xYDncLwCXWDAwVz5JHz851F+6WeD9R+AN/VtwfKsQEU=;
 b=frbhoMuH0R+DXUgOJI1o0i1SJWg+ajKCLdYQTGiR0sqAgHcKgmtjWUvT+CFvRBu9gT
 QWG3/jFH5+D1B5ENZHnIbUE80Qlo/Z1aB4UkDAmh4gwAP+NeyCK9RexZuZRdOwDLetxU
 +5CFmWodX1VTn6086CAPL8h/l3yJhoGxaleJskeeTAFQf3h3zOlncpwiEaHgdCXGbdEu
 syxpGXDqlKVTRZh2HvtJxR+ehCMq0+n6k7Z31LDW5jHuMP8X/CV+fcLWQ3oBnfzEVM+5
 ECB1QmVbK7ImNBG74ubcZT4mkQVfnQDKA13ai1iTpr+lh+zIxnIQgHNrkNPOdFfIGC97
 EYIA==
X-Gm-Message-State: AOJu0YxpG1Xj8j6m9eyksMDek4RiDjWnwQye2Tl1LYa1Y0xus9Rdvnwl
 8G8ac9T5/CZmUUv80cL2vsIzN8oipUFqC/vYyNI2Dexr1fS1komPiI9hIXdKhxAla9G6QX8T3go
 RqCpXWJZDwMr71IS9+TY8hXbiozhP36WmMSWFpDEESR1bzCpClP1CxIcZYcDPQ4yDEBIvXD+Zg9
 yJPYcaO+zK7u1uHuhG7XeRIG/Gnhesum5AzgB/OSs=
X-Gm-Gg: ASbGncutMG9OLirAlFxL3Sq6FTQMa0EVt8T/+HJCwto72LQny+4ORjpuUs4m5AHoivX
 SaP2/Npauoz/pUbqStFXu9BBB+NxkDTDyYoktkng0XgecDtMwvhVYlhKsa7AINv4OdXoZhhazoh
 kVWGOmTJVExATU0bwdMiOdSKg1tk0d8Lbgnz+kYSrtml/Uq6j0quQ79/T2RELwqZ1dgKow38Az0
 +rp46obFOMEFIHfNiHqCgPAQP3cMVHZ/MXyEAfu8oCmmV72X3yd5garjpoRk8xPEDQe1vZ3yRlQ
 xfyIZpUL0ZoRYzqBeDsFBA==
X-Received: by 2002:a05:6000:a1c:b0:37c:d12c:17e5 with SMTP id
 ffacd0b85a97d-385c6ebbafcmr2495100f8f.23.1732714009370; 
 Wed, 27 Nov 2024 05:26:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEZqj73wAp7Qg9XitLwxQNGHRZNRxA8+GKs6MrcpzH6VOgEYY1enCwFWsgH/ebyRY1nOZEuWA==
X-Received: by 2002:a05:6000:a1c:b0:37c:d12c:17e5 with SMTP id
 ffacd0b85a97d-385c6ebbafcmr2495063f8f.23.1732714008886; 
 Wed, 27 Nov 2024 05:26:48 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434aa7cdd93sm21034435e9.23.2024.11.27.05.26.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Nov 2024 05:26:47 -0800 (PST)
Date: Wed, 27 Nov 2024 14:26:46 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: qemu-devel@nongnu.org
Cc: salil.mehta@huawei.com, mst@redhat.com, jonathan.cameron@huawei.com,
 linuxarm@huawei.com, anisinha@redhat.com, karl.heubaum@oracle.com,
 miguel.luis@oracle.com, gustavo.romero@linaro.org
Subject: Re: [PATCH 0/7 for-9.2] Fix broken cpu hotplug after migration
Message-ID: <20241127142646.15fa9a36@imammedo.users.ipa.redhat.com>
In-Reply-To: <20241112170258.2996640-1-imammedo@redhat.com>
References: <20241112170258.2996640-1-imammedo@redhat.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.931,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, 12 Nov 2024 18:02:51 +0100
Igor Mammedov <imammedo@redhat.com> wrote:

> 1st 4 patches are fixing regression and getting rid of not needed changes
> that were merged out of context (ARM CPU hotplug) without proper review,
> by simply reverting offendining patches to keep history clean as patches
> not 9.2 material to begin with.
> 
> The rest [5-7/7] are not tested RFC (not for merging to 9.2) for how problem
> could be dealt with and could be adopted/changed for the future ARM CPU hotplug
> series. 
> 
> Igor Mammedov (6):
>   Revert "hw/acpi: Update ACPI `_STA` method with QOM vCPU ACPI Hotplug
>     states"
>   Revert "hw/acpi: Make CPUs ACPI `presence` conditional during vCPU
>     hot-unplug"

ping

Michael,
are you going to pick it up for 9.2?


>   tests/acpi: update expected blobs
>   acpi: cpuhp: add option to AML genrator to opt-in to always present
>     vCPUs
>   acpi: cpuhp: use 'realized' status of vCPU to check if CPU is enabled
>   acpi: cpuhp: preserve always present vCPUs on unplug
> 
> Salil Mehta (1):
>   qtest: allow ACPI DSDT Table changes
> 
>  include/hw/acpi/cpu.h                         |   5 +-
>  include/hw/core/cpu.h                         |   2 -
>  hw/acpi/acpi-cpu-hotplug-stub.c               |   3 +-
>  hw/acpi/cpu.c                                 |  72 +++++-------------
>  hw/acpi/cpu_hotplug.c                         |   2 +-
>  hw/acpi/generic_event_device.c                |   2 +-
>  tests/data/acpi/x86/pc/DSDT                   | Bin 8560 -> 8526 bytes
>  tests/data/acpi/x86/pc/DSDT.acpierst          | Bin 8471 -> 8437 bytes
>  tests/data/acpi/x86/pc/DSDT.acpihmat          | Bin 9885 -> 9851 bytes
>  tests/data/acpi/x86/pc/DSDT.bridge            | Bin 15431 -> 15397 bytes
>  tests/data/acpi/x86/pc/DSDT.cphp              | Bin 9024 -> 8990 bytes
>  tests/data/acpi/x86/pc/DSDT.dimmpxm           | Bin 10214 -> 10180 bytes
>  tests/data/acpi/x86/pc/DSDT.hpbridge          | Bin 8511 -> 8477 bytes
>  tests/data/acpi/x86/pc/DSDT.hpbrroot          | Bin 5067 -> 5033 bytes
>  tests/data/acpi/x86/pc/DSDT.ipmikcs           | Bin 8632 -> 8598 bytes
>  tests/data/acpi/x86/pc/DSDT.memhp             | Bin 9919 -> 9885 bytes
>  tests/data/acpi/x86/pc/DSDT.nohpet            | Bin 8418 -> 8384 bytes
>  tests/data/acpi/x86/pc/DSDT.numamem           | Bin 8566 -> 8532 bytes
>  tests/data/acpi/x86/pc/DSDT.roothp            | Bin 12353 -> 12319 bytes
>  tests/data/acpi/x86/q35/DSDT                  | Bin 8389 -> 8355 bytes
>  tests/data/acpi/x86/q35/DSDT.acpierst         | Bin 8406 -> 8372 bytes
>  tests/data/acpi/x86/q35/DSDT.acpihmat         | Bin 9714 -> 9680 bytes
>  .../acpi/x86/q35/DSDT.acpihmat-noinitiator    | Bin 8668 -> 8634 bytes
>  tests/data/acpi/x86/q35/DSDT.applesmc         | Bin 8435 -> 8401 bytes
>  tests/data/acpi/x86/q35/DSDT.bridge           | Bin 12002 -> 11968 bytes
>  tests/data/acpi/x86/q35/DSDT.core-count       | Bin 12947 -> 12913 bytes
>  tests/data/acpi/x86/q35/DSDT.core-count2      | Bin 33804 -> 33770 bytes
>  tests/data/acpi/x86/q35/DSDT.cphp             | Bin 8853 -> 8819 bytes
>  tests/data/acpi/x86/q35/DSDT.cxl              | Bin 13180 -> 13146 bytes
>  tests/data/acpi/x86/q35/DSDT.dimmpxm          | Bin 10043 -> 10009 bytes
>  tests/data/acpi/x86/q35/DSDT.ipmibt           | Bin 8464 -> 8430 bytes
>  tests/data/acpi/x86/q35/DSDT.ipmismbus        | Bin 8477 -> 8443 bytes
>  tests/data/acpi/x86/q35/DSDT.ivrs             | Bin 8406 -> 8372 bytes
>  tests/data/acpi/x86/q35/DSDT.memhp            | Bin 9748 -> 9714 bytes
>  tests/data/acpi/x86/q35/DSDT.mmio64           | Bin 9519 -> 9485 bytes
>  tests/data/acpi/x86/q35/DSDT.multi-bridge     | Bin 13242 -> 13208 bytes
>  tests/data/acpi/x86/q35/DSDT.noacpihp         | Bin 8269 -> 8235 bytes
>  tests/data/acpi/x86/q35/DSDT.nohpet           | Bin 8247 -> 8213 bytes
>  tests/data/acpi/x86/q35/DSDT.numamem          | Bin 8395 -> 8361 bytes
>  tests/data/acpi/x86/q35/DSDT.pvpanic-isa      | Bin 8490 -> 8456 bytes
>  tests/data/acpi/x86/q35/DSDT.thread-count     | Bin 12947 -> 12913 bytes
>  tests/data/acpi/x86/q35/DSDT.thread-count2    | Bin 33804 -> 33770 bytes
>  tests/data/acpi/x86/q35/DSDT.tis.tpm12        | Bin 8995 -> 8961 bytes
>  tests/data/acpi/x86/q35/DSDT.tis.tpm2         | Bin 9021 -> 8987 bytes
>  tests/data/acpi/x86/q35/DSDT.type4-count      | Bin 18623 -> 18589 bytes
>  tests/data/acpi/x86/q35/DSDT.viot             | Bin 14646 -> 14612 bytes
>  tests/data/acpi/x86/q35/DSDT.xapic            | Bin 35752 -> 35718 bytes
>  47 files changed, 29 insertions(+), 57 deletions(-)
> 


