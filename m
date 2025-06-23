Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177C2C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 11:54:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTfkd-0001M5-1E; Mon, 23 Jun 2025 07:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTfkI-0001KC-OJ
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 07:54:01 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTfkC-0005Ab-Io
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 07:53:53 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a6d1369d4eso1486320f8f.2
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 04:53:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750679619; x=1751284419; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4UkoQNG73kAls5FXW8j8XArdkpFVe7XI2g2lDPVsTBA=;
 b=s7FbqoBa9B8WgVuCquZEsE6ULobJvE/oIDkNWN1XC1gXePVulijdDiw3XgbUIIbR8N
 I7tjsbUlnJeE9FvsMUnxEjbGBGuTAf/pp55ZwyzubgDjjvIPpN/gY/fYL59ebT7UoHRC
 caKJjogCjiXmy6+vXR7e4Y1NI22oGh6ZWxuut2WJWB/BdxS9bV23MIsU7WCwJqIbpOKF
 WO3NTh5qDk1EEFD1FQ4lftRzCRSH7WDxMrxPH+ja44lMpX/iqtN5rpFHGEYyqBup14Gd
 MehfF3BgLAa89ACeZrdoaBQJNPhgrvCiH4FeKeye82KfvB0AdQ7k816ZCbDo41m8kYbB
 7wpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750679619; x=1751284419;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4UkoQNG73kAls5FXW8j8XArdkpFVe7XI2g2lDPVsTBA=;
 b=pNIoz3RTBTFbXl9AhmnmYaJYpGTgH6MCxp/tZqCV1xcOFUBOtgPWupFtRavc1n8PmF
 8+3c4GYtKxw2Ne4bedgV08eZ4P0GygIyQabO7tSBxWiSwyM35b1khO90iR/ZVUXid1z1
 K/QynPkCNGtMbCHOwT4vZeIG98exKbOjIBlCQHN50djWYySrIMfBPeyDKgDu8L6rKBQS
 U7kNfWlHEZNm6RTsn69HhhUgqXLrlu18k3fWIthRQRKeHV1A3FyMDE+88NQ24l7Xa0wj
 ZMqyElr6th4bXMKXA6ExMSpc3ZrVMpIBPcy+/qvC/bXy4ncUuUzkr0lm1/S80mcwqmhI
 gyrw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUGolKVisUDes5Yd4keCweExtwwWSI15RNySjzvnV5Ze4OL4wAmGQGQLuO2P5nIJyEEGCNJzQbi7J5X@nongnu.org
X-Gm-Message-State: AOJu0YzHbokq5U4apA3qlMWRxteO4qfBk3UBxd0N3inSZajSvL4sKbvA
 BFHbO+ob//PxCOpfmdYT9kOFaSklqSZq2THL6dvY1LvsfqdAsUvYE0hmrTwvhgRoh1XXKLgb1So
 D4EJK
X-Gm-Gg: ASbGncsr9f689FzbOk5LIPmiRAN3w0jDI/JT6jNn8RJURHQg1/nS/PGznvLoDjn/K5a
 HxBJkwW248njwnr9wQZCrFcFWHCijAldfhFNMOAEc+Me+CTmntSZ48GbK4Be3oOcjU1C6N99B3i
 /Gjd8v6dLdOZMI4WfNvNVzE3zpCPulxcfHewHr8Iv0k419466Lgzal5lLIfFj/fqd8zqu7uTiU0
 I7V/YZPMSfM62nyLx+bdmBcuGgB1sWDDyAzBKEjtj5C3kfQnNVzv3C6eAenPfE4puOe42Ub64aT
 4XRCvO81Oi3QK11EejXAEbAfH/JoD5HRXgBVtPqyzCuSdeBjaraU7wnsNjLhmre8CrlQ1+I38+3
 geRUCwcGDCwB285xmv71I9TC+RdJGOA==
X-Google-Smtp-Source: AGHT+IGRCN6iUoyXqRv7gWL3CyrqT7BwgRkI/KO/oALd94G+AMGsRYNNsEs1oFkM62KVQ+Wcsduwjw==
X-Received: by 2002:a05:6000:230e:b0:3a4:ef48:23db with SMTP id
 ffacd0b85a97d-3a6d12f9af7mr10786713f8f.59.1750679618956; 
 Mon, 23 Jun 2025 04:53:38 -0700 (PDT)
Received: from [192.168.69.167] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4536466596asm112628545e9.0.2025.06.23.04.53.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 04:53:38 -0700 (PDT)
Message-ID: <94d6e871-fcf1-448a-8a6a-f6a7f7720882@linaro.org>
Date: Mon, 23 Jun 2025 13:53:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 26/26] tests/functional: Expand Aarch64 SMMU tests to
 run on HVF accelerator
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
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
 <c8d2da2b-f44b-46ab-baca-de8b9a4c25e5@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <c8d2da2b-f44b-46ab-baca-de8b9a4c25e5@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 23/6/25 10:23, Thomas Huth wrote:
> On 20/06/2025 15.07, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   tests/functional/test_aarch64_smmu.py | 9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/tests/functional/test_aarch64_smmu.py b/tests/functional/ 
>> test_aarch64_smmu.py
>> index c65d0f28178..59b62a55a9e 100755
>> --- a/tests/functional/test_aarch64_smmu.py
>> +++ b/tests/functional/test_aarch64_smmu.py
>> @@ -22,6 +22,7 @@
>>   class SMMU(LinuxKernelTest):
>> +    accel = 'kvm'
>>       default_kernel_params = ('earlyprintk=pl011,0x9000000 
>> no_timer_check '
>>                                'printk.time=1 rd_NO_PLYMOUTH 
>> net.ifnames=0 '
>>                                'console=ttyAMA0 rd.rescue')
>> @@ -45,11 +46,11 @@ def set_up_boot(self, path):
>>           self.vm.add_args('-device', 'virtio-net,netdev=n1' + 
>> self.IOMMU_ADDON)
>>       def common_vm_setup(self, kernel, initrd, disk):
> 
> Wouldn't it be more straight-forward to do something like this here:
> 
>      if hvf_available():
>          accel = "hvf"
>      else:
>          accel = "kvm"
> 
> ... IMHO that's nicer than duplicating the test classes below.

Good idea, thank you :)


