Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35756C35FF3
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 06:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tu3vm-0007Rr-3K; Mon, 17 Mar 2025 02:26:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tu3vR-0007Pp-3I
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 02:26:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tu3vN-0006YF-9U
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 02:26:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742192766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pFqeKHcZrFbjYMh1/cRWWIZVLM5LVO9hN6db9wPBBl0=;
 b=gMdGoW0h/7YCM3z0RfilaIVN1+nMNFyEnbud5nY/ywfOVw3t++GPhBEUeReFI8RFw8Ts54
 7pMYn8Ulf2Y5WWKb3cKsgTp6MvzcFC/6SBNOgyh4nZbyfUKBe1jgNG4pVM1pz3FhaCmLod
 N63mSAv3YsbS4mRAtLcbrYN3wAzJokI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-59-Cmo5CxqFMAaVReCgWr7cFg-1; Mon, 17 Mar 2025 02:26:03 -0400
X-MC-Unique: Cmo5CxqFMAaVReCgWr7cFg-1
X-Mimecast-MFC-AGG-ID: Cmo5CxqFMAaVReCgWr7cFg_1742192761
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-43d209dc2d3so9927785e9.3
 for <qemu-devel@nongnu.org>; Sun, 16 Mar 2025 23:26:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742192761; x=1742797561;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pFqeKHcZrFbjYMh1/cRWWIZVLM5LVO9hN6db9wPBBl0=;
 b=mP5dnofDzfD73OkdD9snRWCaJ2JJ8LdNJWiAS7UITHPjJhMhioTppbu8OCs5WML2mZ
 lS27Z2oAX64/RrPz2JJ1p9sbTyXh+qzGsFpQ7u4KxAgyAjpHlrFKKJlu4fUOOV07C+Uv
 VCuc1hvqAHzXVOzonIJLmV47KdD1wricbfqsTDbLvGY8o2QvUXDIo050HdW7jy1uRpra
 vi4TCWeSqoKgqgPqempT6QPrJsOrvKZEJfk5mpkozZ6WgTT8c726oTtEqJeNK3KD7rpZ
 CyaNUxlmCtFIHvw42u2WMik1DH757RwRH9JIR+5TgP60fGD5wkWLCWZEsXAG4YhPiKHf
 Xr3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUXTzXkq7pAimP9xyWnw6tkz+uiQk0mhSKlqHTAHTncGRRM1qoelEPTqIu74hHSSHyTmMhDZeVOigkK@nongnu.org
X-Gm-Message-State: AOJu0Yxeg+j4LGg9wCuohECK4IbE4ch7TpENCJf4H1H8FBJHFxDjElL0
 tnKHeVOaaQSiwxEVhY7zZ0hxzYkLm6IS4vqRzxW4/Cdh6OK7h7anO8oevUXV1aRntuCYArqcN0D
 we17Uxb1ABRNrVYroGzotzmccgGELpJyudXtipOdm5IHZNoVYi/Yn
X-Gm-Gg: ASbGnctBva2NqrcllRvWQovDlrIi2FGxJ/gyxdlq6NdSsJsBJE/sccoSuTSk4GQn2XT
 fkiTNhufPn8+5Oi81ipU3++IFX1PgAW4aZVXPX+tVEgHGFLvjiNrBU49yDqVzVzWK+7gRvudP3V
 sOpd6sprH3qdHLmi8C5mtJoDZvkjM0Y7v5PLwrDPbTiPFttLy8jdRhjbFWtxOxTksiS3KCwQFlE
 wEjFIqOj26OH0g5HDLFfbpue23qu3a8h1gws3e0UdccjRVpLpy35L3tkel69kplk6AlcI0Mv69G
 JtEoWlWnAwzd2phKmBbUXLbk4uKUlPmfC9xSjvZqqDPSGD8=
X-Received: by 2002:a05:600c:511c:b0:43c:fceb:91a with SMTP id
 5b1f17b1804b1-43d1ec729a9mr130929125e9.11.1742192760897; 
 Sun, 16 Mar 2025 23:26:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG0uXdhknQC0GClVBAUqvdgfTrHOcm4+BKA9K8cBPLQnfaMxwimDlTKN/C43mLxAEsf09F0sg==
X-Received: by 2002:a05:600c:511c:b0:43c:fceb:91a with SMTP id
 5b1f17b1804b1-43d1ec729a9mr130928975e9.11.1742192760474; 
 Sun, 16 Mar 2025 23:26:00 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-51-207.web.vodafone.de.
 [109.42.51.207]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d1fe292dbsm95071915e9.19.2025.03.16.23.25.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 16 Mar 2025 23:25:58 -0700 (PDT)
Message-ID: <8dad5654-6d0a-4045-abb1-2dee489f3102@redhat.com>
Date: Mon, 17 Mar 2025 07:25:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 8/8] tests/functional: Add test for fadump in PSeries
To: Aditya Gupta <adityag@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Sourabh Jain <sourabhjain@linux.ibm.com>,
 Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Hari Bathini <hbathini@linux.ibm.com>
References: <20250315064636.611714-1-adityag@linux.ibm.com>
 <20250315064636.611714-9-adityag@linux.ibm.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250315064636.611714-9-adityag@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.333,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

  Hi!

On 15/03/2025 07.46, Aditya Gupta wrote:
> Add testcases for testing fadump with PSeries and PSeries+KVM
> combinations
...
> diff --git a/tests/functional/test_ppc64_fadump.py b/tests/functional/test_ppc64_fadump.py
> new file mode 100755
> index 000000000000..3d6d3734e243
> --- /dev/null
> +++ b/tests/functional/test_ppc64_fadump.py
> @@ -0,0 +1,185 @@
> +#!/usr/bin/env python3

scripts/checkpatch.pl recently got a check for SPDX license tags, so please 
add a SPDX-License-Identifier here now to avoid a warning when the script is 
run with your patch.

> +import logging
> +import platform
> +import os
> +from unittest import skip, skipUnless
> +from qemu_test import Asset
> +from qemu_test import wait_for_console_pattern
> +from qemu_test import LinuxKernelTest
> +from qemu_test import exec_command, exec_command_and_wait_for_pattern
> +
> +class QEMUFadump(LinuxKernelTest):
> +    """
> +    Functional test to verify Fadump is working in following scenarios:
> +
> +    1. test_fadump_pseries:       PSeries
> +    2. test_fadump_pseries_kvm:   PSeries + KVM
> +    """
> +
> +    timeout = 90
> +    KERNEL_COMMON_COMMAND_LINE = 'console=hvc0 fadump=on '
> +    msg_panic = 'Kernel panic - not syncing'
> +    msg_not_supported = 'Firmware-Assisted Dump is not supported on this hardware'
> +    msg_registered_success = ''
> +    msg_registered_failed = ''
> +    msg_dump_active = ''
> +
> +    ASSET_EPAPR_KERNEL = Asset(
> +        ('https://github.com/open-power/op-build/releases/download/v2.7/'
> +         'zImage.epapr'),
> +        '0ab237df661727e5392cee97460e8674057a883c5f74381a128fa772588d45cd')
> +
> +    ASSET_VMLINUZ_KERNEL = Asset(
> +        ('https://archives.fedoraproject.org/pub/archive/fedora-secondary/'
> +         'releases/39/Everything/ppc64le/os/ppc/ppc64/vmlinuz'),
> +        ('81e5541d243b50c8f9568906c6918dda22239744d637bb9a7b22d23c3d661226'
> +         '8d5302beb2ca5c06f93bdbc9736c414ef5120756c8bf496ff488ad07d116d67f')
> +        )
> +
> +    ASSET_FEDORA_INITRD = Asset(
> +        ('https://archives.fedoraproject.org/pub/archive/fedora-secondary/'
> +        'releases/39/Everything/ppc64le/os/ppc/ppc64/initrd.img'),
> +        'e7f24b44cb2aaa67d30e551db6ac8d29cc57c934b158dabca6b7f885f2cfdd9b')
> +
> +    def do_test_fadump(self, is_kvm=False, is_powernv=False):
> +        """
> +        Helper Function for Fadump tests below
> +
> +        It boots the VM with fadump enabled, checks if fadump is correctly
> +        registered.
> +        Then crashes the system causing a QEMU_SYSTEM_RESET, after which
> +        dump should be available in the kernel.
> +        Finally it checks the filesize of the exported /proc/vmcore in 2nd
> +        kernel to verify it's same as the VM's memory size
> +        """
> +        if not is_kvm:
> +            self.require_accelerator("tcg")
> +
> +        if is_powernv:
> +            self.set_machine("powernv10")
> +        else:
> +            # SLOF takes upto >20s in startup time, use VOF
> +            self.set_machine("pseries")
> +            self.vm.add_args("-machine", "x-vof=on")
> +            self.vm.add_args("-m", "6G")
> +
> +        self.vm.set_console()
> +
> +        kernel_path = None
> +
> +        if is_powernv:
> +            kernel_path = self.ASSET_EPAPR_KERNEL.fetch()
> +        else:
> +            kernel_path = self.ASSET_VMLINUZ_KERNEL.fetch()
> +
> +        initrd_path = self.ASSET_FEDORA_INITRD.fetch()
> +
> +        self.vm.add_args('-kernel', kernel_path)
> +        self.vm.add_args('-initrd', initrd_path)
> +        self.vm.add_args('-append', "fadump=on"\
> +                         " -nodefaults -serial mon:stdio crashkernel=2G"\
> +                         " rdinit=/bin/sh ")
> +
> +        self.vm.launch()
> +
> +        # If kernel detects fadump support, and "fadump=on" is in command
> +        # line which we add above, it will print something like:
> +        #
> +        #     fadump: Reserved 1024MB of memory at 0x00000040000000 ...
> +        #
> +        # Else, if the kernel doesn't detect fadump support, it prints:
> +        #
> +        #     fadump: Firmware-Assisted Dump is not supported on this hardware
> +        #
> +        # Timeout after 10s if kernel doesn't print any fadump logs, this
> +        # can happen due to fadump being disabled in the kernel
> +        self.wait_for_regex_console_pattern(
> +            success_pattern="fadump: Reserved ",
> +            failure_pattern=r"fadump: (Firmware-Assisted Dump is not"\
> +            " supported on this hardware|Failed to find memory chunk for"\
> +            " reservation!)",
> +            timeout=10
> +        )
> +
> +        # Ensure fadump is registered successfully, if registration
> +        # succeeds, we get a log from rtas fadump:
> +        #
> +        #     rtas fadump: Registration is successful!
> +        self.wait_for_console_pattern(
> +            "rtas fadump: Registration is successful!"
> +        )
> +
> +        # Wait for the shell
> +        self.wait_for_console_pattern("#")
> +
> +        # Mount /proc since not available in the initrd used
> +        exec_command(self, command="mount -t proc proc /proc")
> +
> +        # Crash the kernel
> +        exec_command(self, command="echo c > /proc/sysrq-trigger")
> +
> +        # Check for the kernel panic message, setting timeout to 10s as it
> +        # should occur almost immediately after previous echo c
> +        self.wait_for_regex_console_pattern(
> +            success_pattern="Kernel panic - not syncing: sysrq" \
> +                " triggered crash",
> +            timeout=10
> +        )
> +
> +        # Check if fadump is active
> +        # If the kernel shows that fadump is active, that implies it's a
> +        # crashkernel boot
> +        # Else if the kernel shows "fadump: Reserved ..." then it's
> +        # treating this as the first kernel boot, this is likely the case
> +        # that qemu didn't pass the 'ibm,kernel-dump' device tree node
> +        wait_for_console_pattern(
> +            test=self,
> +            success_message="rtas fadump: Firmware-assisted dump is active",
> +            failure_message="fadump: Reserved "
> +        )
> +
> +        # In a successful fadump boot, we get these logs:
> +        #
> +        # [    0.000000] fadump: Firmware-assisted dump is active.
> +        # [    0.000000] fadump: Reserving <>MB of memory at <> for preserving crash data
> +        #
> +        # Check if these logs are present in the fadump boot
> +        self.wait_for_console_pattern("preserving crash data")
> +
> +        # Wait for prompt
> +        self.wait_for_console_pattern("sh-5.2#")
> +
> +        # Mount /proc since not available in the initrd used
> +        exec_command_and_wait_for_pattern(self,
> +            command="mount -t proc proc /proc",
> +            success_message="#"
> +        )
> +
> +        # Check if vmcore exists
> +        exec_command_and_wait_for_pattern(self,
> +            command="stat /proc/vmcore",
> +            success_message="File: /proc/vmcore",
> +            failure_message="No such file or directory"
> +        )
> +
> +    def test_fadump_pseries(self):
> +        return self.do_test_fadump(is_kvm=False, is_powernv=False)
> +
> +    @skip("PowerNV Fadump not supported yet")
> +    def test_fadump_powernv(self):
> +        return
> +
> +    @skipUnless(platform.machine().startswith("ppc64"),
> +                "KVM tests require the same host and guest architecture")

I think this is likely unreliable: The test could run on a ppc64 host, but 
KVM could still be unavailable, e.g. if it has been disabled in the kernel. 
It's better to use self.require_accelerator("kvm") instead (which will also 
skip the test if it is not available).

Also, shouldn't there be a "-accel kvm" somewhere if you really want to be 
sure to enable KVM ?

> +    def test_fadump_pseries_kvm(self):
> +        """
> +        Test Fadump in PSeries with KVM accel
> +        """
> +        self.do_test_fadump(is_kvm=True, is_powernv=False)
> +
> +if __name__ == '__main__':
> +    if os.getenv("DEBUG"):
> +        logging.basicConfig(level=logging.DEBUG)

The setUp function in QemuSystemTest already sets the log level to DEBUG, so 
this should not be necessary?

  Thomas


