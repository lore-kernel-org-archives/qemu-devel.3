Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD40AC7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 08:23:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTcSQ-00022z-5b; Mon, 23 Jun 2025 04:23:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uTcSO-00022b-59
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 04:23:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uTcSM-0008KU-4M
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 04:23:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750666989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=hdcp9RwtfZi8FMSc5dPMRPQIL7xDdgS875H69vG9FfM=;
 b=I+roycRMKOPqeLIFQsio02jMLx4pMg3npNOHZGOLcMy5Pv2hrPQESbDurhsFqw9ppZEmpz
 cWPuvj5uB9v6o9s4WOdwHIs8d7CuTL/f5BnEkJKd375tC99VRRQSHrX3gAeRhKoAB7Z+f7
 hI6d5YFal1xR7b5OQkoSvgY2uaxaeE0=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-538-jSuwDv97M0yPlgX3oikLsw-1; Mon, 23 Jun 2025 04:23:06 -0400
X-MC-Unique: jSuwDv97M0yPlgX3oikLsw-1
X-Mimecast-MFC-AGG-ID: jSuwDv97M0yPlgX3oikLsw_1750666985
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4f6ff23ccso2117071f8f.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 01:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750666985; x=1751271785;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hdcp9RwtfZi8FMSc5dPMRPQIL7xDdgS875H69vG9FfM=;
 b=pYFJs3Tc/w6+g1uf1DOdOGs4xT8fziRnh0s7N5soradgG2myi1CJpzX5hvqQBxYv0p
 wloSnpfP1Rdw4np62tMYI3WpSWx8uGpg/XfE8aQjwIvXyLRfom3jWmPeu6XjeXH0GLki
 1YClxHTJ3hmvFddWXLJMl+W8rBYuiy64jceyRFENS4/sBUohkSskhBokqi4wT3flo9E6
 berBG+ftFcDo7RP2LRHiY4W0XVlxnRqIZvD/cnu/FmMtMUn4Wq2L7ly/2cpR3Y6ihU2P
 wmY8J/NnM1BwdXrTqXJcmbQbmXbMJCfmRXUOLq2ZpXWX6TuseDZRYp+oM0G9FIZgppXG
 wG1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWiZ5ckHNhPM+aMarQDFRnPbeOv9Covt9cuMmRCHgZ+itK6AKLFnKfAAgEGngvURp1ngAk+FblgoyXu@nongnu.org
X-Gm-Message-State: AOJu0YzWt+4vvvXfHzrzyAXATAYXeWA6KAjr3Y4gSy/GA9l56CNLDdkw
 +0s6cV7jGzaej506W0mjzgyJTgiCtXYKzVcljqIh5Iw5lqajOyHGNxDHvdrxwETA4UpWcoo/dgU
 JwlCft8zyD9PAwqfjGRBOrCk5QAnlij4MJ5pa0tlgeetmgtbCSzhw2gQS
X-Gm-Gg: ASbGncuWo8K4XUZP/DAbRnQ2uNXxGgAamr8E40GKXMBtGP8KIFHbi0lMFfyV8mc32Xi
 3V9W+zfB/pZE5GZ9SyGFb55cEO7LZH70u0L/tw417+hv/6t+jvviZE+WwURHadErvkKD1anT914
 2oBHgIgfkWVuCS38uOgFANekfIAotTiUhBtEhIAQ7fToZbWpigzJ99yAgVPT3padsHy/Gu63nux
 EvSNiYhMfPGIQxW7PJVyOWfN0rl+n4w5vvOefD89lve5oZRDwxHXy1dk92tJz/Ww9xoFOH4eQMi
 W0k4p5vdbm7LnoENEaD3ynywDDVkqbrHBiMDZaWFbt/hQvYMCofnbQhbTDW+pQc=
X-Received: by 2002:a05:6000:2111:b0:3a4:f6d6:2d68 with SMTP id
 ffacd0b85a97d-3a6d1314667mr7319755f8f.56.1750666985456; 
 Mon, 23 Jun 2025 01:23:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHuFdh/3OHmpcX1gjUBEaKfgix1OYvNvXrCo2m+GurC+ynCyYQRv3aqbi+XZ8/v4Jo85Eu9bA==
X-Received: by 2002:a05:6000:2111:b0:3a4:f6d6:2d68 with SMTP id
 ffacd0b85a97d-3a6d1314667mr7319723f8f.56.1750666984983; 
 Mon, 23 Jun 2025 01:23:04 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-114-166.pools.arcor-ip.net.
 [47.64.114.166]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-453770470b3sm17430525e9.30.2025.06.23.01.23.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 01:23:04 -0700 (PDT)
Message-ID: <c8d2da2b-f44b-46ab-baca-de8b9a4c25e5@redhat.com>
Date: Mon, 23 Jun 2025 10:23:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 26/26] tests/functional: Expand Aarch64 SMMU tests to
 run on HVF accelerator
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Bernhard Beschow <shentey@gmail.com>,
 Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, John Snow <jsnow@redhat.com>
References: <20250620130709.31073-1-philmd@linaro.org>
 <20250620130709.31073-27-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250620130709.31073-27-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 20/06/2025 15.07, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   tests/functional/test_aarch64_smmu.py | 9 +++++++--
>   1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/functional/test_aarch64_smmu.py b/tests/functional/test_aarch64_smmu.py
> index c65d0f28178..59b62a55a9e 100755
> --- a/tests/functional/test_aarch64_smmu.py
> +++ b/tests/functional/test_aarch64_smmu.py
> @@ -22,6 +22,7 @@
>   
>   class SMMU(LinuxKernelTest):
>   
> +    accel = 'kvm'
>       default_kernel_params = ('earlyprintk=pl011,0x9000000 no_timer_check '
>                                'printk.time=1 rd_NO_PLYMOUTH net.ifnames=0 '
>                                'console=ttyAMA0 rd.rescue')
> @@ -45,11 +46,11 @@ def set_up_boot(self, path):
>           self.vm.add_args('-device', 'virtio-net,netdev=n1' + self.IOMMU_ADDON)
>   
>       def common_vm_setup(self, kernel, initrd, disk):

Wouldn't it be more straight-forward to do something like this here:

	if hvf_available():
		accel = "hvf"
	else:
		accel = "kvm"

... IMHO that's nicer than duplicating the test classes below.

  Thomas


> -        self.require_accelerator("kvm")
> +        self.require_accelerator(self.accel)
>           self.require_netdev('user')
>           self.set_machine("virt")
>           self.vm.add_args('-m', '1G')
> -        self.vm.add_args("-accel", "kvm")
> +        self.vm.add_args("-accel", self.accel)
>           self.vm.add_args("-cpu", "host")
>           self.vm.add_args("-machine", "iommu=smmuv3")
>           self.vm.add_args("-d", "guest_errors")
> @@ -201,5 +202,9 @@ def test_smmu_ril_nostrict(self):
>           self.run_and_check(self.F33_FILENAME, self.F33_HSUM)
>   
>   
> +class SMMU_HVF(SMMU):
> +    accel = 'hvf'



