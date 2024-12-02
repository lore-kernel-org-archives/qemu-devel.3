Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DD8D10DDD
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 09:28:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI2j2-0002Om-9S; Mon, 02 Dec 2024 04:28:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tI2hv-0002Ll-20
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 04:27:07 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tI2ht-00022e-Dc
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 04:27:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733131623;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=jSwf9zoW9tugDylWKOukYJEwQVnPPGTd3FLh/Hzbbe4=;
 b=KabmUbtLbptl8/p65+VrXlBZUmfs+UObPjSqdrE6yum8QqoGwlnc14Gfyg+ouHnHaFOpEf
 aB6+OTldopPfH8J8RG6nYR9QgXgx4EeziFO0omerEjpYYbZS9q3ZSyODu2mCLnHeqTk7nY
 Ywc9vsOzG5mXAp+mpiO5kPCXMvhVb/Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-67-Nhmj9I9eNA-e3P0Ey0S6iA-1; Mon, 02 Dec 2024 04:27:02 -0500
X-MC-Unique: Nhmj9I9eNA-e3P0Ey0S6iA-1
X-Mimecast-MFC-AGG-ID: Nhmj9I9eNA-e3P0Ey0S6iA
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-434a4ad78a1so33441595e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2024 01:27:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733131621; x=1733736421;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jSwf9zoW9tugDylWKOukYJEwQVnPPGTd3FLh/Hzbbe4=;
 b=RXPRpKANnsWYzRJZzYHfRWXfGCPehFDvXYFybBUWHzsc3osBdSveuQYpjXhUrF2BPS
 8yBbeoVvJw/acetUoR1MoQ1xy2cunBD3Xj3aKtO4H67cztY5sZaju+XYAbE+XEu06erM
 5C/rWq1ZfsLeHkrFFrnP7RDKpPBE5tF5UlhRBfH0q+bC4SFTQapvFOpvqttd2Cuu1bhL
 shOxVHUz1Px0FnqkXs9zx/SNJd1IJe1TYueLR/hMAruEKFRYGWmKu8qv0Z7aZ0bx3QRt
 TPHJ+07ugyBTvvTUwLUs6jll+RrYEt+U1NwZyn6859bgqRXilcQBpLkualWU1IS9YrQ+
 sy9g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYwcBtvyfAteWK539trChv+rUxtb6v7EPoEeKtxNCok0ashjAJxEpDwyhDzclQm0tggQA5xW5S4bXF@nongnu.org
X-Gm-Message-State: AOJu0Yx12e9Zys9rhW1ARaJfwK791aGADMVJB64x27fJ0WUs8c6W4wrZ
 dADV7bRsAPy+4ttZ3y42DikCEl4+GlqjflG0Qc1jsrMW7UiNA7hHbt9FXLr8S2ZiLzxkV8E0tLs
 G4+UUFc1ASsxQb6o767Mr4Ks090PSGGD5TMzY5Vz9lbaogxznLrdBPJBVmsiCti8=
X-Gm-Gg: ASbGncv5moFgtmbiQWbO6g6rHsNDuV27aUK2eKWXGq3N00gz34gyvzn8iARFjD1ND2/
 TYX1Hiq3xHa21cuWNryg7xD0JIH3WGZwlkflTHDwkeUMUtWMKrq0CMuFFudFu11vMQlMuWhb51u
 CAvmXG2fKTTwNdbnp7a4Sv+xHR7ZYSMayNGfsule2kOUcJmlM2oY3oMlgHDfVQ4FGV03y0vkznt
 sqFRDDzhXPa4y9DVxMuAsgq5Hvb9FGiCCRUJBPI6tazh+d5eNYRnR1lwLSglCAqTVQk/YjTpVk=
X-Received: by 2002:a05:600c:5102:b0:431:59ab:15cf with SMTP id
 5b1f17b1804b1-434a9dc8227mr187388845e9.19.1733131621216; 
 Mon, 02 Dec 2024 01:27:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGveG09cKQWe25M1B7u+ynnzDkn5QqqxBnBRs1P0+13hgh5jvjp5e/mngfqLFP5a3xT67NhHw==
X-Received: by 2002:a05:600c:5102:b0:431:59ab:15cf with SMTP id
 5b1f17b1804b1-434a9dc8227mr187388645e9.19.1733131620849; 
 Mon, 02 Dec 2024 01:27:00 -0800 (PST)
Received: from [10.33.192.206] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434b0d9bc5asm144523785e9.2.2024.12.02.01.27.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2024 01:27:00 -0800 (PST)
Message-ID: <a3e41776-4253-4c1d-b3bf-37d4702a871a@redhat.com>
Date: Mon, 2 Dec 2024 10:26:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/22] tests/functional: switch over to using
 self.build_file(...)
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20241129173120.761728-1-berrange@redhat.com>
 <20241129173120.761728-11-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241129173120.761728-11-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On 29/11/2024 18.31, Daniel P. Berrangé wrote:
> This removes direct access of the 'BUILD_DIR' variable.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/testcase.py | 4 ++--
>   tests/functional/test_aarch64_virt.py  | 6 +++---
>   tests/functional/test_virtio_gpu.py    | 9 ++++-----
>   3 files changed, 9 insertions(+), 10 deletions(-)
> 
> diff --git a/tests/functional/qemu_test/testcase.py b/tests/functional/qemu_test/testcase.py
> index 5b1e6ba04f..2f32742387 100644
> --- a/tests/functional/qemu_test/testcase.py
> +++ b/tests/functional/qemu_test/testcase.py
> @@ -127,8 +127,8 @@ def setUp(self, bin_prefix):
>           self.arch = self.qemu_bin.split('-')[-1]
>           self.socketdir = None
>   
> -        self.outputdir = os.path.join(BUILD_DIR, 'tests', 'functional',
> -                                      self.arch, self.id())
> +        self.outputdir = self.build_file('tests', 'functional',
> +                                         self.arch, self.id())
>           self.workdir = os.path.join(self.outputdir, 'scratch')
>           os.makedirs(self.workdir, exist_ok=True)
>   
> diff --git a/tests/functional/test_aarch64_virt.py b/tests/functional/test_aarch64_virt.py
> index 07b78f6a84..29eeb8e32d 100755
> --- a/tests/functional/test_aarch64_virt.py
> +++ b/tests/functional/test_aarch64_virt.py
> @@ -14,7 +14,7 @@
>   import os
>   import logging
>   
> -from qemu_test import (BUILD_DIR, QemuSystemTest, Asset, exec_command,
> +from qemu_test import (QemuSystemTest, Asset, exec_command,
>                          wait_for_console_pattern, get_qemu_img, run_cmd)
>   
>   
> @@ -52,8 +52,8 @@ def test_alpine_virt_tcg_gic_max(self):
>                            "mte=on,"
>                            "gic-version=max,iommu=smmuv3")
>           self.vm.add_args("-smp", "2", "-m", "1024")
> -        self.vm.add_args('-bios', os.path.join(BUILD_DIR, 'pc-bios',
> -                                               'edk2-aarch64-code.fd'))
> +        self.vm.add_args('-bios', self.build_file('pc-bios',
> +                                                  'edk2-aarch64-code.fd'))
>           self.vm.add_args("-drive", f"file={iso_path},media=cdrom,format=raw")
>           self.vm.add_args('-device', 'virtio-rng-pci,rng=rng0')
>           self.vm.add_args('-object', 'rng-random,id=rng0,filename=/dev/urandom')
> diff --git a/tests/functional/test_virtio_gpu.py b/tests/functional/test_virtio_gpu.py
> index c4562618d9..39dcf376dd 100755
> --- a/tests/functional/test_virtio_gpu.py
> +++ b/tests/functional/test_virtio_gpu.py
> @@ -6,8 +6,7 @@
>   # later.  See the COPYING file in the top-level directory.
>   
>   
> -from qemu_test import (BUILD_DIR, QemuSystemTest, Asset,
> -                       wait_for_console_pattern,
> +from qemu_test import (QemuSystemTest, Asset, wait_for_console_pattern,
>                          exec_command_and_wait_for_pattern,
>                          is_readable_executable_file)
>   from qemu.utils import kvm_available
> @@ -17,12 +16,12 @@
>   import subprocess
>   
>   
> -def pick_default_vug_bin():
> +def pick_default_vug_bin(test):
>       relative_path = "./contrib/vhost-user-gpu/vhost-user-gpu"
>       if is_readable_executable_file(relative_path):
>           return relative_path

I wonder whether we should drop the above two lines of special casing and 
always use the code below instead?

> -    bld_dir_path = os.path.join(BUILD_DIR, relative_path)
> +    bld_dir_path = test.build_file(relative_path)

... then you could also get rid of the hard-coded slashes in relative_path?

>       if is_readable_executable_file(bld_dir_path):
>           return bld_dir_path
>   
> @@ -85,7 +84,7 @@ def test_vhost_user_vga_virgl(self):
>           # FIXME: should check presence of vhost-user-gpu, virgl, memfd etc
>           self.require_accelerator('kvm')
>   
> -        vug = pick_default_vug_bin()
> +        vug = pick_default_vug_bin(self)
>           if not vug:
>               self.skipTest("Could not find vhost-user-gpu")
>   

Anyway:
Reviewed-by: Thomas Huth <thuth@redhat.com>


