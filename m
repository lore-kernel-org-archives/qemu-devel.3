Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33600C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 16:37:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmFyw-0000se-Lx; Mon, 18 Mar 2024 12:37:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmFyu-0000jM-9O
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:37:00 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rmFyn-00008A-Vr
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 12:36:59 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-41409dc5becso13532195e9.3
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 09:36:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710779812; x=1711384612; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ff4y2hYdBHU6+ERPH49T0I+rjcJQzaop2+p+j6BSWIw=;
 b=BKGhWIIUCpYIfS4Mc5Y2HsE1MbFKvC1kWJz4zyUw4iHHP9ZRyEFtfCVaP+qi9R/xv0
 WwdSKj8ifa6mY53dtqKHTphyOrVG4GzKgn3nRVKWQVPYHreQsO92q6PXjCT49ywC1p5l
 GNyljfZFoih18FqCSVKeQqY2iqncYURakuf17Zdc/mwx+ukjSv07FbE2R/karXrM50Mz
 DCOQAYRZIxD2rdqLAaeZqIkM/m2YVauAIHKtVkaZrAFGOutpOtmX8epxBIilW/v+M/C1
 DVFVbEOiHGtnb/gOYScn8VxsxgIPycn+9u5oE5OyRN2XbEr3UevJA1lxxfvCY2FogAZi
 F+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710779812; x=1711384612;
 h=content-transfer-encoding:in-reply-to:references:cc:to:from
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ff4y2hYdBHU6+ERPH49T0I+rjcJQzaop2+p+j6BSWIw=;
 b=Lmd4PlBSOgBZuC1bHY5hXZoa/u49pVAuv7wsUHbjMwMKOytQmMM5QnuRU4im2NMedQ
 GTkP0skGyqE6uXza2WOozRU2HiDsMZ1LnB6oJYiKn0hv3N0lGmpcqt6najOoe1QIPgq0
 ev3Pirz4GgnbItaGCGrbV84ETzGjF86AiMYTqIjqA6Eb7tn0UeyeMFSwuwoKBW6WhmCP
 CbTD/ZymeJT+V4mj3e7TPwXyxuf6Sm38RWnus+TUS/48gBEBmWP+FaXhvmsK0Z3Id3oU
 hKqheQeVrkxBMPzH1KJq+DcESXnWNZhzlC3qAvBxgaxKUitqAGEdociSuZGTVLEELgZm
 jg7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVSm1IgKD7cJgxy24lq8FdY9KA7wecmy/y2rR61Lrn/yFOcnbasN3w7nuU35Rg+AzKBOLrKPnnV+8C8ett3CKUqZTrRg2k=
X-Gm-Message-State: AOJu0Yw4Z9EzEOVJGGc1L0gf4flWA2djIDQqyOErS0pufPN4IUH+wHly
 Vm4Dob5jz+R+O6yBCyyCRVP1LY1CUEhRqdZ57QsLKzmZ7BAbaufRgRC1HTUrEQg=
X-Google-Smtp-Source: AGHT+IGp/6ti0Y4D1Vi/Yl0ew+YWFyUSVfPdP3waYX4ubw0B6xVruVBNnYAmg4uVdSFhL7Jv/cinIg==
X-Received: by 2002:a7b:cc9a:0:b0:412:fa5f:7f85 with SMTP id
 p26-20020a7bcc9a000000b00412fa5f7f85mr7333469wma.19.1710779811772; 
 Mon, 18 Mar 2024 09:36:51 -0700 (PDT)
Received: from [192.168.69.100] (vit94-h02-176-184-29-165.dsl.sta.abo.bbox.fr.
 [176.184.29.165]) by smtp.gmail.com with ESMTPSA id
 bg28-20020a05600c3c9c00b0041330d49604sm18520814wmb.45.2024.03.18.09.36.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Mar 2024 09:36:51 -0700 (PDT)
Message-ID: <534576b9-be78-4481-8c87-41387ab4a31a@linaro.org>
Date: Mon, 18 Mar 2024 17:36:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] tests/avocado: update sbsa-ref firmware to latest
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: Radoslaw Biernacki <rad@semihalf.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Leif Lindholm <quic_llindhol@quicinc.com>, Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Brad Smith <brad@comstyle.com>,
 qemu-arm@nongnu.org
References: <20240318-sbsa-ref-firmware-update-v3-0-1c33b995a538@linaro.org>
 <42cdcb79-1873-4987-9a20-92c803b3668d@linaro.org>
In-Reply-To: <42cdcb79-1873-4987-9a20-92c803b3668d@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 18/3/24 17:30, Philippe Mathieu-Daudé wrote:
> Hi Marcin,
> 
> On 18/3/24 15:08, Marcin Juszkiewicz wrote:
>> Updating sbsa-ref firmware for QEMU CI was manual task. Now it is
>> replaced by CI job run on CodeLinaro Gitlab instance.
>>
>> This patchset updates to current state:
>>
>> - Trusted Firmware v2.10.2 (latest LTS)
>> - Tianocore EDK2 stable202402 (latest release)
>>
>> And Tianocore EDK2-platforms commit 085c2fb (edk2-platforms does not
>> have releases).
>>
>> Firmware images were built using Debian 'bookworm' cross gcc 12.2.0
>> compiler.
>>
>> And while I am in that file I dropped use of 'virtio-rng-pci' device as
>> sbsa-ref is supposed to emulate physical hardware.
>>
>> Added 'max' tests with 'pauth=off' and 'pauth-impdef=on' variants.
>>
>> (01/11) test_sbsaref_edk2_firmware: PASS (2.51 s)
>> (02/11) test_sbsaref_alpine_linux_cortex_a57: PASS (23.72 s)
>> (03/11) test_sbsaref_alpine_linux_neoverse_n1: PASS (23.70 s)
>> (04/11) test_sbsaref_alpine_linux_max_pauth_off: PASS (23.00 s)
>> (05/11) test_sbsaref_alpine_linux_max_pauth_impdef: PASS (29.03 s)
>> (06/11) test_sbsaref_alpine_linux_max: PASS (80.69 s)
> 
> This one is timeouting for me, should we skip it with
> AVOCADO_TIMEOUT_EXPECTED? (See below)

Well AVOCADO_TIMEOUT_EXPECTED is present but apparently ignored :/

>> (07/11) test_sbsaref_openbsd73_cortex_a57: PASS (16.05 s)
>> (08/11) test_sbsaref_openbsd73_neoverse_n1: PASS (15.97 s)
>> (09/11) test_sbsaref_openbsd73_max_pauth_off: PASS (16.22 s)
>> (10/11) test_sbsaref_openbsd73_max_pauth_impdef: PASS (16.11 s)
>> (11/11) test_sbsaref_openbsd73_max: PASS (16.08 s)
>>
>> Signed-off-by: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
>> ---
>> Changes in v3:
>> - left OpenBSD at 7.3 (7.4+ is known to not boot)
>>    https://gitlab.com/qemu-project/qemu/-/issues/2224
>>    https://marc.info/?l=openbsd-arm&m=171050428327850&w=2
>> - added pauth variants of 'max' to OpenBSD tests
>> - Link to v2: 
>> https://lore.kernel.org/r/20240314-sbsa-ref-firmware-update-v2-0-b557c56559cd@linaro.org
>>
>> Changes in v2:
>> - disabled 'max' tests on OpenBSD
>> - moved tags to 'one tag per line'
>> - added 'os:linux' tags to Alpine ones
>> - Link to v1: 
>> https://lore.kernel.org/r/20240313-sbsa-ref-firmware-update-v1-0-e166703c5424@linaro.org
>>
>> ---
>> Marcin Juszkiewicz (4):
>>        tests/avocado: update sbsa-ref firmware
>>        tests/avocado: drop virtio-rng from sbsa-ref tests
>>        tests/avocado: sbsa-ref: add Alpine tests for misc 'max' setup
>>        tests/avocado: sbsa-ref: add OpenBSD tests for misc 'max' setup
> 
> $ make check-avocado AVOCADO_TAGS='machine:sbsa-ref'
> ninja: no work to do.
> JOB ID     : 76d5dc90c6f70f0801c5269ff1c1db6c0d2cb27b
> JOB LOG    : 
> build/system_arm/tests/results/job-2024-03-18T15.54-76d5dc9/job.log
>   (1/7) 
> tests/avocado/machine_aarch64_sbsaref.py:Aarch64SbsarefMachine.test_sbsaref_edk2_firmware: PASS (4.96 s)
>   (2/7) 
> tests/avocado/machine_aarch64_sbsaref.py:Aarch64SbsarefMachine.test_sbsaref_alpine_linux_cortex_a57: PASS (52.67 s)
>   (3/7) 
> tests/avocado/machine_aarch64_sbsaref.py:Aarch64SbsarefMachine.test_sbsaref_alpine_linux_neoverse_n1: PASS (51.01 s)
>   (4/7) 
> tests/avocado/machine_aarch64_sbsaref.py:Aarch64SbsarefMachine.test_sbsaref_alpine_linux_max: INTERRUPTED: Test interrupted by SIGTERM\nRunner error occurred: Timeout reached\nOriginal status: ERROR\n{'name': '4-tests/avocado/machine_aarch64_sbsaref.py:Aarch64SbsarefMachine.test_sbsaref_alpine_linux_max', 'logdir': 'build/system_... (180.50 s)
>   (5/7) 
> tests/avocado/machine_aarch64_sbsaref.py:Aarch64SbsarefMachine.test_sbsaref_openbsd73_cortex_a57: PASS (21.15 s)
>   (6/7) 
> tests/avocado/machine_aarch64_sbsaref.py:Aarch64SbsarefMachine.test_sbsaref_openbsd73_neoverse_n1: PASS (20.88 s)
>   (7/7) 
> tests/avocado/machine_aarch64_sbsaref.py:Aarch64SbsarefMachine.test_sbsaref_openbsd73_max: PASS (20.70 s)
> RESULTS    : PASS 6 | ERROR 0 | FAIL 0 | SKIP 0 | WARN 0 | INTERRUPT 1 | 
> CANCEL 0
> JOB TIME   : 355.21 s
> make: *** [tests/Makefile.include:139: check-avocado] Error 8
> 
> Looking at debug.log:
> 
> 15:56:17 DEBUG| Opening console file
> 15:56:17 DEBUG| Opening console socket
> 15:56:17 DEBUG| NOTICE:  Booting Trusted Firmware
> 15:56:17 DEBUG| NOTICE:  BL1: v2.9(release):v2.9.0-764-g7c3ff62d2
> 15:56:17 DEBUG| NOTICE:  BL1: Built : 12:32:06, Sep 27 2023
> 15:56:17 DEBUG| NOTICE:  BL1: Booting BL2
> 15:56:17 DEBUG| NOTICE:  BL2: v2.9(release):v2.9.0-764-g7c3ff62d2
> 15:56:17 DEBUG| NOTICE:  BL2: Built : 12:32:06, Sep 27 2023
> 15:56:17 DEBUG| NOTICE:  BL1: Booting BL31
> 15:56:17 DEBUG| NOTICE:  BL31: v2.9(release):v2.9.0-764-g7c3ff62d2
> 15:56:17 DEBUG| NOTICE:  BL31: Built : 12:32:06, Sep 27 2023
> 15:56:17 DEBUG| UEFI firmware (version 1.0 built at 15:45:23 on Sep 20 
> 2023)
> ...
> 15:57:48 DEBUG| * Mounting security filesystem ... [ ok ]
> 15:57:49 DEBUG| * Mounting debug filesystem ... [ ok ]
> 15:57:49 DEBUG| * Mounting persistent storage (pstore) filesystem ... [ 
> ok ]
> 15:57:50 DEBUG| * Mounting efivarfs filesystem ... [ ok ]
> 15:57:51 DEBUG| * Starting busybox mdev ... [ ok ]
> 15:58:05 DEBUG| * Scanning hardware for mdev ... [ ok ]
> 15:59:05 DEBUG| * Loading hardware drivers ... [ ok ]
> 15:59:05 DEBUG| * WARNING: clock skew detected!
> 15:59:07 DEBUG| * Setting the local clock based on last shutdown time 
> ... [ ok ]
> 15:59:11 DEBUG| * Loading modules ... [ ok ]
> 15:59:13 ERROR|
> 15:59:13 ERROR| RuntimeError: Test interrupted by SIGTERM
> 


