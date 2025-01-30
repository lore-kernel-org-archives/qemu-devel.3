Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B989C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 09:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdQzs-0000Ym-UK; Thu, 30 Jan 2025 04:38:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tdQzl-0000YL-Bs
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 04:37:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tdQzi-0002hx-QV
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 04:37:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738229873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=i3kUb7IthIj+r9ml4OdmnnEr1v35Pm+G+lAuErYtOpU=;
 b=E5jFFVtxP4Z4geCjli80UacN+eH9N2brGA3m31oXOGP6wilzokefTuTCRiPBil4wn2lbHL
 b0nQzZPtxKNpR6hFmDo3PcX+cNOyFJ7CO68ynymLuOOzi7Vv4s0UN+7gXlsOlhpnkgPmQ7
 jn+MwqUNdKpmKlKEbQ4TMZVHmleAk1Q=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-QORhWOsNOOOvidBuI5hl_A-1; Thu, 30 Jan 2025 04:37:51 -0500
X-MC-Unique: QORhWOsNOOOvidBuI5hl_A-1
X-Mimecast-MFC-AGG-ID: QORhWOsNOOOvidBuI5hl_A
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-467b19b5641so12050791cf.3
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2025 01:37:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738229870; x=1738834670;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=i3kUb7IthIj+r9ml4OdmnnEr1v35Pm+G+lAuErYtOpU=;
 b=O8u9Mtc6UM2L696Yn5hVAL4Df86GOtqI/gLHazsxX/v5a6EI1qWJLr5dpvzJ1kr8oQ
 tocJlsm5ggdSsA6qik7akTzjG6cs1dL/mpG0cG6QSVcth7NfcZnrqxNS/tolOJ4YHxDv
 8XXp8K5uoU5TTtwbbe9awA7yCV8lcnlaNabNuMmX1/UcH4sQXUTBXxNPPl+xqMvBnBpq
 amyG1GsBhoVZj6DZduT8jWhAZm98dBJ7tMqhTv0HFJVWqGoEo7HC2Ile267pxIPlj6Se
 QxFSQ34qw8ed6SDaqlu+iofMA11/KXBZs43pR0Xl1XjogN6w3HPoyZ04HAl4lej43ilt
 UsQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUTAxGoaKSOCcZEPenvNsL4tpNaM87MORtlHd9jhYYwAO81zcA4xlCgREVoS2lc5Hz9ax+tTxASCdOz@nongnu.org
X-Gm-Message-State: AOJu0YyWczzBTf6i0uZtvWXZW37Ag7KlCH4g8KhEfwV2kJAuwFebgSJN
 c2nSZjt8Koypb/2Ndbmhq40mEhxIvziyqZUJgp3N72Cb4x1DAksqcncdItFL4+i7eND84ipP5hj
 xpoaCbish2EBw7JL8i8V4BoNv3Eq1qGXE92I2MC8bWOpYaHs6dVU8
X-Gm-Gg: ASbGncvjPCJxMXN/an5XKOLtBXW1vu6SGxWoVbd/MaVI6CYSATUDSEc9/scyqWv5n7v
 YCmByxR5MUV2ikc7wss5pmZdM7weAQYTLHIWSydvwfMKbdN4Rb77dxUAVbZvUR/CkDol2rKWAhv
 PaGWvZMT/pbpxTmuHsYjX6xL6KA5iTeY8SJClWyuzwiA2g7afHXdREdxQVLTKVjI7U4eCyYTxaM
 rJ0NHpRg+CtYW2ezzf3TfN/i2PrOVutzPD8IUd5UcVaNVBIkF1/owaqVR1gSUNRrkszT9YzoPLS
 x0sW9o5Rw70K9Mdqe14CnCCOJe0o9MRRdIFU
X-Received: by 2002:a05:622a:544f:b0:467:867b:ff57 with SMTP id
 d75a77b69052e-46fd0ba140dmr109146531cf.44.1738229870693; 
 Thu, 30 Jan 2025 01:37:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGjHHezs6gQMc8rfrL9jr8F7sZkHmYtp7N/YAI3tBTjP1RMC4THe1QNO/rjRdDhDWG3/DjcRQ==
X-Received: by 2002:a05:622a:544f:b0:467:867b:ff57 with SMTP id
 d75a77b69052e-46fd0ba140dmr109146311cf.44.1738229870346; 
 Thu, 30 Jan 2025 01:37:50 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-50-234.web.vodafone.de.
 [109.42.50.234]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-46fe2fe0a21sm2764181cf.32.2025.01.30.01.37.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2025 01:37:49 -0800 (PST)
Message-ID: <33dee683-ab7b-4c3d-8c57-bc9bd2489858@redhat.com>
Date: Thu, 30 Jan 2025 10:37:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] tests/functional: Add a ppc64 mac99 test
To: BALATON Zoltan <balaton@eik.bme.hu>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>
Cc: qemu-ppc@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 qemu-devel@nongnu.org
References: <20250128212145.1186617-1-clg@redhat.com>
 <390bd0cd-c918-33e5-7647-3662944d3066@eik.bme.hu>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <390bd0cd-c918-33e5-7647-3662944d3066@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 29/01/2025 17.58, BALATON Zoltan wrote:
> On Tue, 28 Jan 2025, Cédric Le Goater wrote:
>> The test sequence boots from disk a mac99 machine in 64-bit mode, in
>> which case the CPU is a PPC 970.
>>
>> The buildroot rootfs is built with config :
>>
>> BR2_powerpc64=y
>> BR2_powerpc_970=y
>>
>> and the kernel with the g5 deconfig.
>>
>> Reviewed-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Cédric Le Goater <clg@redhat.com>
>> ---
>>
>> Changes in v2:
>>
>> - Moved self.set_machine('mac99') at the top
>> - Dropped sungem nic on the command line
>>
>> MAINTAINERS                          |  1 +
>> tests/functional/meson.build         |  2 ++
>> tests/functional/test_ppc64_mac99.py | 43 ++++++++++++++++++++++++++++
>> 3 files changed, 46 insertions(+)
>> create mode 100755 tests/functional/test_ppc64_mac99.py
>>
>> diff --git a/MAINTAINERS b/MAINTAINERS
>> index 3a2291d17d7e..ebf249173f00 100644
>> --- a/MAINTAINERS
>> +++ b/MAINTAINERS
>> @@ -1446,6 +1446,7 @@ F: include/hw/pci-host/uninorth.h
>> F: include/hw/input/adb*
>> F: pc-bios/qemu_vga.ndrv
>> F: tests/functional/test_ppc_mac.py
>> +F: tests/functional/test_ppc64_mac99.py
>>
>> Old World (g3beige)
>> M: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
>> diff --git a/tests/functional/meson.build b/tests/functional/meson.build
>> index 01a87b03e553..821a0a7c49ac 100644
>> --- a/tests/functional/meson.build
>> +++ b/tests/functional/meson.build
>> @@ -41,6 +41,7 @@ test_timeouts = {
>>   'ppc64_powernv' : 480,
>>   'ppc64_pseries' : 480,
>>   'ppc64_tuxrun' : 420,
>> +  'ppc64_mac99' : 120,
>>   'riscv64_tuxrun' : 120,
>>   's390x_ccw_virtio' : 420,
>>   'sh4_tuxrun' : 240,
>> @@ -181,6 +182,7 @@ tests_ppc64_system_thorough = [
>>   'ppc64_powernv',
>>   'ppc64_pseries',
>>   'ppc64_tuxrun',
>> +  'ppc64_mac99',
>> ]
>>
>> tests_riscv32_system_quick = [
>> diff --git a/tests/functional/test_ppc64_mac99.py b/tests/functional/ 
>> test_ppc64_mac99.py
>> new file mode 100755
>> index 000000000000..9aec7c020748
>> --- /dev/null
>> +++ b/tests/functional/test_ppc64_mac99.py
>> @@ -0,0 +1,43 @@
>> +#!/usr/bin/env python3
>> +#
>> +# Functional test that boots a mac99 machine with a PPC970 CPU
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +from qemu_test import LinuxKernelTest, Asset
>> +from qemu_test import exec_command_and_wait_for_pattern
>> +
>> +class mac99Test(LinuxKernelTest):
>> +
>> +    ASSET_BR2_MAC99_LINUX = Asset(
>> +        'https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main/ 
>> buildroot/qemu_ppc64_mac99-2023.11-8-gdcd9f0f6eb-20240105/vmlinux',
>> +        'd59307437e4365f2cced0bbd1b04949f7397b282ef349b7cafd894d74aadfbff')
>> +
>> +    ASSET_BR2_MAC99_ROOTFS = Asset(
>> +        'https://github.com/legoater/qemu-ppc-boot/raw/refs/heads/main// 
>> buildroot/qemu_ppc64_mac99-2023.11-8-gdcd9f0f6eb-20240105/rootfs.ext2',
>> +        'bbd5fd8af62f580bc4e585f326fe584e22856572633a8333178ea6d4ed4955a4')
>> +
>> +    def test_ppc64_mac99_buildroot(self):
>> +        self.set_machine('mac99')
>> +
>> +        linux_path = self.ASSET_BR2_MAC99_LINUX.fetch()
>> +        rootfs_path = self.ASSET_BR2_MAC99_ROOTFS.fetch()
>> +
>> +        self.vm.set_console()
>> +
>> +        self.vm.add_args('-kernel', linux_path,
>> +                         '-append', 'root=/dev/sda',
>> +                         '-drive', f'file={rootfs_path},format=raw',
>> +                         '-snapshot', '-nographic') # -nographic to get a 
>> console
> 
> Nit: # -nographic for serial console or get a console on serial

Ok, but the line is getting too long ... I'll squash this when
picking up the patch (unless there are any objections):

diff --git a/tests/functional/test_ppc64_mac99.py b/tests/functional/test_ppc64_mac99.py
index 9aec7c0207..dfd9c01371 100755
--- a/tests/functional/test_ppc64_mac99.py
+++ b/tests/functional/test_ppc64_mac99.py
@@ -25,10 +25,11 @@ def test_ppc64_mac99_buildroot(self):
  
          self.vm.set_console()
  
+        # Note: We need '-nographic' to get a serial console
          self.vm.add_args('-kernel', linux_path,
                           '-append', 'root=/dev/sda',
                           '-drive', f'file={rootfs_path},format=raw',
-                         '-snapshot', '-nographic') # -nographic to get a console
+                         '-snapshot', '-nographic')
          self.vm.launch()
  
          self.wait_for_console_pattern('>> OpenBIOS')

  Thomas


