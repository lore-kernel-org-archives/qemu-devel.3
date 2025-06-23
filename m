Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72F5CC77B7F
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 13:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTgoK-0002AZ-1T; Mon, 23 Jun 2025 09:02:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uTgoC-00029V-Vn
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 09:02:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uTgo7-0006No-1V
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 09:01:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750683711;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=JH5umFS36US7IDsZT2yyveGcuseLmnIc9KBJy2RGDsk=;
 b=TwlqAR9som06MZDcdtOxrlnG/aLhzyaVMxpYVjJwPZKMJ+vqDUbbMc9eOn96MkcPJxFibb
 VbpNpUcPr+QQR8U4l5HtQpIpLQDfqhK6fboeurZ2dGaNKwtU+8FK+dA/6Ppzwr4MW8xObz
 E2ydmDZa4U38xeXCWv+CpuaQVA761yI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-511-TVl-mXJyOwGaqOjcm9sU7g-1; Mon, 23 Jun 2025 09:01:49 -0400
X-MC-Unique: TVl-mXJyOwGaqOjcm9sU7g-1
X-Mimecast-MFC-AGG-ID: TVl-mXJyOwGaqOjcm9sU7g_1750683709
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-451dda846a0so30166255e9.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 06:01:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750683708; x=1751288508;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JH5umFS36US7IDsZT2yyveGcuseLmnIc9KBJy2RGDsk=;
 b=v1rOmmO48K98hNnttGaawQnpHn6Ja0DZhyJfqKaBR9YuC1OaI7wuXTWMb3Nl8JPk+t
 fduhvEPUhNngzgGTmWXuxJE4fHaFW9zLx/FtRsDCQYCoPyw1fBxoOXzoC6qtsG8PPCOR
 cJu5/YaSzB3cyWgPSL/CfeaMrnLSdVsqUNm2qXvTFaHTy66uHT5Vq4xWdjsuJ5nQbdq6
 3c96J+Th8FAf9leEaGR3FxyUVlVCxW9s6hLLnp0JSxtYNEETLmrssDYx+y+wfN2Dkr6T
 xxKeIslS+lm7RrZuf3z0v/gHLdXHcJqxJzFDyMNeomg/k4BKrCmD0E/ayz83nCsPujwb
 SXLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoOXsfHjbrtlAmGK23EfTyEBTEAA3U8ehr6cCQHTAhyPG6+KmSThySdAm0l7+K7YuZHld8t5/CmyIN@nongnu.org
X-Gm-Message-State: AOJu0YzktyQS/EMTy7IWMFGjP47BH0XJB+Ddx6MOd0SrDq4PaYYs+DhR
 0ZyqPJ2F5qBZUm43PvFmZXm17MvkipHPyNkZ4RgR/qAdMaLdLwF0Chtwb9FgcmBKq6YKUuZAMLo
 mXFIaqNUMBYjxC5JrhUR36VFckjhZo01HgZTasoBjEWMhs2RgmCaFd7ci
X-Gm-Gg: ASbGncvcKoVRK5G+XooPoCDRA4xBRNoc9ucFng0+FIDcyBumbkUssnyxL71iMRqONAA
 ex+/HTK18LORkX8ScOpkxWf/mtAu4SLPrJuL0qSwftTVgxSsa1CjfWAn73/pzatOnRljUIlUQHP
 MsS72kA/6WvsO8+Y56vL6Mps5Jq20euCdLvPz+v/8jB6jSfi1f5mWyH6NniKG44hbNAxFOw/Ecd
 TChzWwW58e73Y8rfwZ8Xkmgr/kKBsPpvI7B7pb/xACEVcqCvkgOicKAyn1KfGB2ut7/kASqiQPs
 vLD4bMf8Xp6g2mjJ/Z9bVaVtjFQc/m8CoEhJNHgrYLgs2zh+5ehZbc7d9RGLkC0=
X-Received: by 2002:a05:600c:6994:b0:453:dda:a52e with SMTP id
 5b1f17b1804b1-453659d762cmr95488445e9.33.1750683708548; 
 Mon, 23 Jun 2025 06:01:48 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF4LNS7iB5vBtQ6zs4YvFzVlcbYjrW33VP4WFNfO45dGrtWDPfaFa8IJ6jz55xc+W6h2c8R/Q==
X-Received: by 2002:a05:600c:6994:b0:453:dda:a52e with SMTP id
 5b1f17b1804b1-453659d762cmr95487845e9.33.1750683708001; 
 Mon, 23 Jun 2025 06:01:48 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-166.pools.arcor-ip.net.
 [47.64.114.166]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4536c77b980sm68667655e9.23.2025.06.23.06.01.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 06:01:43 -0700 (PDT)
Message-ID: <0107a85c-3335-478a-9414-55cfdd2f763b@redhat.com>
Date: Mon, 23 Jun 2025 15:01:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 26/26] tests/functional: Expand Aarch64 SMMU tests to
 run on HVF accelerator
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Alexander Graf <agraf@csgraf.de>, Bernhard Beschow <shentey@gmail.com>,
 John Snow <jsnow@redhat.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, kvm@vger.kernel.org,
 Eric Auger <eric.auger@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, Cameron Esfahani <dirty@apple.com>,
 Cleber Rosa <crosa@redhat.com>, Radoslaw Biernacki <rad@semihalf.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250623121845.7214-1-philmd@linaro.org>
 <20250623121845.7214-27-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250623121845.7214-27-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 23/06/2025 14.18, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/functional/test_aarch64_smmu.py | 12 +++++++++---
>   1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/functional/test_aarch64_smmu.py b/tests/functional/test_aarch64_smmu.py
> index c65d0f28178..e0f4a922176 100755
> --- a/tests/functional/test_aarch64_smmu.py
> +++ b/tests/functional/test_aarch64_smmu.py
> @@ -17,7 +17,7 @@
>   
>   from qemu_test import LinuxKernelTest, Asset, exec_command_and_wait_for_pattern
>   from qemu_test import BUILD_DIR
> -from qemu.utils import kvm_available
> +from qemu.utils import kvm_available, hvf_available
>   
>   
>   class SMMU(LinuxKernelTest):
> @@ -45,11 +45,17 @@ def set_up_boot(self, path):
>           self.vm.add_args('-device', 'virtio-net,netdev=n1' + self.IOMMU_ADDON)
>   
>       def common_vm_setup(self, kernel, initrd, disk):
> -        self.require_accelerator("kvm")
> +        if hvf_available(self.qemu_bin):
> +            accel = "hvf"
> +        elif kvm_available(self.qemu_bin):
> +            accel = "kvm"
> +        else:
> +            self.skipTest("Neither HVF nor KVM accelerator is available")
> +        self.require_accelerator(accel)
>           self.require_netdev('user')
>           self.set_machine("virt")
>           self.vm.add_args('-m', '1G')
> -        self.vm.add_args("-accel", "kvm")
> +        self.vm.add_args("-accel", accel)
>           self.vm.add_args("-cpu", "host")
>           self.vm.add_args("-machine", "iommu=smmuv3")
>           self.vm.add_args("-d", "guest_errors")

Reviewed-by: Thomas Huth <thuth@redhat.com>


