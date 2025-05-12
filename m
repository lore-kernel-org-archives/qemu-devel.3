Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 893C0C3ABC3
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 13:03:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uESoW-0006Th-4H; Mon, 12 May 2025 09:03:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uESoM-0006T1-6P
 for qemu-devel@nongnu.org; Mon, 12 May 2025 09:03:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uESoJ-0006oc-KJ
 for qemu-devel@nongnu.org; Mon, 12 May 2025 09:03:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747054990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WLG8+p1uZqDosFlTdi3JJnXM7jjd7eOG1fVs4RBN+K0=;
 b=GuJMo5igKvGcfimY8q2aMat2/La7z+P+6N5dU4dm/8tL4S9Q75FAUZwbkn05TywDV3QCk6
 3WwlTWZNJFRoM4EwWDQpARrN3qWKApQ0r/2mFCF6PnPADKu7NXARENCQSA2KDn0R4bt96M
 kQrccijwOJTaCvuZWi/hNH/LlMTBcnU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-65-RGxU8jhJNN2xuyD6XT2NYA-1; Mon, 12 May 2025 09:03:08 -0400
X-MC-Unique: RGxU8jhJNN2xuyD6XT2NYA-1
X-Mimecast-MFC-AGG-ID: RGxU8jhJNN2xuyD6XT2NYA_1747054988
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43cf44b66f7so25081295e9.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 06:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747054988; x=1747659788;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WLG8+p1uZqDosFlTdi3JJnXM7jjd7eOG1fVs4RBN+K0=;
 b=JCKWPRb0if1J0rA7l3Mr35QpQZ1snY5zoUEm2kZ46jjx/AdGyvNxIC8xJX+H8Sftcy
 s31WnFG4m929c1Ub7thkoiChc27qkKCSWA6P71e2R1MEXcSnUVnbQjug5V/9XC/b/xVg
 4K8zTggFxWdWdxYngEZUFXq2otBDZS1y5up8cwtR1/wYJL1rEPVv2mJafXgs3DOiGQLQ
 96Q2ubt7hLE273ao8+rR/dQVGeFzOevtRE1WHWRUjDGywvvP56JlWtUvFy07Se+rQXMg
 h9nTbfYk3YCxM4g1J3R3W/pFvBM8wYXRbLt+AGxY6erfGZV1xGuGCfEjVpCZYC549yAR
 q6rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXIWEYvgrKwrZUoVB/sOBk3OYl1RpFed+S2+SpL+MX+UQED2dC13JHprHtGGXz//V+29XWxuKkp6t//@nongnu.org
X-Gm-Message-State: AOJu0YzG9UXDn0rEiVOAnyyj+hfvIIhnHgpurfzCVtAujkB6kVreDQjE
 iqVMom8/icjxYFwSH3ttk3pBUM4kpNXsxmf2v9zJJwlWS+u68Cba/BHC4THCrbMSLgkHRUFXmk2
 lM5HqWsH3+oJR2ad/+ohA5QqbffGnk1/iEB/tTclXNDFFm26+BQaL
X-Gm-Gg: ASbGncuNQm7kXsPUO/lLJu9LBmre65Xl1Jco3N0QU+Ng68CVI3xY+wA3WEv6hYK9Cqy
 lQ9fGrIcYeMHtZtCleRbjK2WpzfAlbcawjOBmSr876OHMNqYcroB4zNtjinHv30R68wPJtuAwAy
 0DpnrwLuFIJPODM/1QItD3pYLRqTpwv9RcQcnINSatZ4xRB/EG9CPgN/GSR+HZ2LLetxO0Cp63x
 PP0vh9xB/XhPfYz1bDmRC0/vd7LXjoiEycWmQlHzln4aSVUG+V4pBj6mngpm037foN6jFkC9MPO
 bN9Gonqw1pAoSvZKHKHBvAMlp3jxWgs4+jQc3s25WbPOCke8QNRB
X-Received: by 2002:a05:600c:4e46:b0:442:c993:6f94 with SMTP id
 5b1f17b1804b1-442d6d3dafbmr120262575e9.12.1747054987485; 
 Mon, 12 May 2025 06:03:07 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF04iccO2nage1E6xa44hihVC6fkXJA4BWJm3XXeHakujqUs6LMcf36ec83Gydfud4cRPza2A==
X-Received: by 2002:a05:600c:4e46:b0:442:c993:6f94 with SMTP id
 5b1f17b1804b1-442d6d3dafbmr120261795e9.12.1747054986905; 
 Mon, 12 May 2025 06:03:06 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-115-173.pools.arcor-ip.net.
 [47.64.115.173]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-442cd3285e0sm166217205e9.5.2025.05.12.06.03.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 May 2025 06:03:06 -0700 (PDT)
Message-ID: <1f9b943e-3c6c-47ea-929f-6c512e4c8ac7@redhat.com>
Date: Mon, 12 May 2025 15:03:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional: Add PCI hotplug test for aarch64
To: Gustavo Romero <gustavo.romero@linaro.org>, qemu-devel@nongnu.org
Cc: eric.auger@redhat.com, alex.bennee@linaro.org, philmd@linaro.org,
 peter.maydell@linaro.org
References: <20250512123646.157447-1-gustavo.romero@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250512123646.157447-1-gustavo.romero@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.551,
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

On 12/05/2025 14.36, Gustavo Romero wrote:
> Add a functional test, aarch64_hotplug_pci, to exercise PCI hotplug and
> hot-unplug on arm64. Currently, the aarch64 'virt' machine uses the PCIe
> native controller and does not support ACPI-based hotplugging. However,
> since support is planned, this test sets 'acpi=force' and specifies an
> EDK2 firmware image in advance. This is harmless and prepares for future
> ACPI support.
> 
> Signed-off-by: Gustavo Romero <gustavo.romero@linaro.org>
> ---
>   MAINTAINERS                                  |  5 ++
>   tests/functional/meson.build                 |  1 +
>   tests/functional/test_aarch64_hotplug_pci.py | 73 ++++++++++++++++++++
>   3 files changed, 79 insertions(+)
>   create mode 100755 tests/functional/test_aarch64_hotplug_pci.py
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 23174b4ca7..9ebb768214 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2065,6 +2065,11 @@ S: Supported
>   F: include/hw/pci/pcie_doe.h
>   F: hw/pci/pcie_doe.c
>   
> +ARM PCI Hotplug
> +M: Gustavo Romero <gustavo.romero@linaro.org>
> +S: Supported
> +F: tests/functional/test_aarch64_hotplug_pci.py
> +
>   ACPI/SMBIOS
>   M: Michael S. Tsirkin <mst@redhat.com>
>   M: Igor Mammedov <imammedo@redhat.com>
> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
> index 52b4706cfe..2d68840fa2 100644
> --- a/tests/functional/meson.build
> +++ b/tests/functional/meson.build
> @@ -83,6 +83,7 @@ tests_aarch64_system_quick = [
>   tests_aarch64_system_thorough = [
>     'aarch64_aspeed_ast2700',
>     'aarch64_aspeed_ast2700fc',
> +  'aarch64_hotplug_pci',
>     'aarch64_imx8mp_evk',
>     'aarch64_raspi3',
>     'aarch64_raspi4',
> diff --git a/tests/functional/test_aarch64_hotplug_pci.py b/tests/functional/test_aarch64_hotplug_pci.py
> new file mode 100755
> index 0000000000..05c92d7a45
> --- /dev/null
> +++ b/tests/functional/test_aarch64_hotplug_pci.py
> @@ -0,0 +1,73 @@
> +#!/usr/bin/env python3
> +#
> +# The test hotplugs a PCI device and checks it on a Linux guest.
> +#
> +# Copyright (c) 2025 Linaro Ltd.
> +#
> +# Author:
> +#  Gustavo Romero <gustavo.romero@linaro.org>
> +#
> +# This work is licensed under the terms of the GNU GPL, version 2 or
> +# later.  See the COPYING file in the top-level directory.
> +
> +from os import path
> +from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pattern
> +from qemu_test import BUILD_DIR
> +
> +class HotplugPCI(LinuxKernelTest):
> +
> +    ASSET_KERNEL = Asset(
> +        ('https://ftp.debian.org/debian/dists/stable/main/installer-arm64/'
> +         'current/images/netboot/debian-installer/arm64/linux'),
> +        '3821d4db56d42c6a4eac62f31846e35465940afd87746b4cfcdf5c9eca3117b2')
> +
> +    ASSET_INITRD = Asset(
> +        ('https://ftp.debian.org/debian/dists/stable/main/installer-arm64/'
> +         'current/images/netboot/debian-installer/arm64/initrd.gz'),
> +        '2583ec22b45265ad69e82f198674f53d4cd85be124fe012eedc2fd91156bc4b4')
> +
> +    def test_hotplug_pci(self):
> +
> +        self.set_machine('virt')
> +        self.vm.add_args('-m', '512M')
> +        self.vm.add_args('-cpu', 'cortex-a57')
> +        self.vm.add_args('-append',
> +                         'console=ttyAMA0,115200 acpi=force init=/bin/sh')
> +        self.vm.add_args('-device',
> +                         'pcie-root-port,bus=pcie.0,chassis=1,slot=1,id=pcie.1')
> +        self.vm.add_args('-bios', path.join(BUILD_DIR, 'pc-bios',
> +                         'edk2-aarch64-code.fd'))

Sorry for missing it in v1, but we've got a dedicated function for creating 
paths in the build directory: self.build_file() ... in case you respin, 
could you please that one instead?

Apart from that the patch now looks fine to me.

  Thomas


