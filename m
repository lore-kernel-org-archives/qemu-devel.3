Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB2DC5321E
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2024 16:12:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sicJj-0005Pp-AB; Mon, 26 Aug 2024 12:11:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sicJh-0005Or-OH
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 12:11:41 -0400
Received: from mail-qv1-xf2a.google.com ([2607:f8b0:4864:20::f2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sicJg-0000JS-0e
 for qemu-devel@nongnu.org; Mon, 26 Aug 2024 12:11:41 -0400
Received: by mail-qv1-xf2a.google.com with SMTP id
 6a1803df08f44-6bf747371ecso21201506d6.3
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2024 09:11:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724688699; x=1725293499; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ll0Bv0e9ifVMdX16PbaLptHbvOdXV+Mp0DUceSHpQ4g=;
 b=VZlTE24xT5Io81ZMOtRJZbZTWG5QD/5ECXyKd9CwzWwEVzdVZfJz9AyuOVzsPfTqoH
 eJg0xFE93yXbCi+VmqZ8jKZ83TqNXpa7kozVVEeFs1jWMBbjrlgBSQ1imVnNjlIMO1VZ
 1a7XppoLUYTetsLf2buyPT1zLpQdUds1r2jng4YK5LEnsZtwWu2yvMrQ/5swMATKD6/+
 6s1jPPS3Sb539q/fFYai4aLJ+2W1v7jOz3fgheP7Nx7jdas9dCyvkYK6w87tFltYAWHe
 vXn8ZJClA6S3ZBChfyFikBsqUkEEH7QW9gSuvT78Skyrz/R3RZBNTAsbX4dcUq7vFafH
 Z1MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724688699; x=1725293499;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ll0Bv0e9ifVMdX16PbaLptHbvOdXV+Mp0DUceSHpQ4g=;
 b=gkwb0UrZfElFv185BkHzOZUgm60t4HNtpTAfOFMbraIXU3klwAL+L7p5gctNtUQRQP
 aonT9ctsH3L9eG9M/DjPzxAVokjpJs2aAT2dXUjbTwf66ObjHIpoGZMm1cFrmr2DO5Kl
 ziZsOt0FrsW5Q4vPNGtoERjIsNOgH/5PpseavRzx3fkUT8jm7ATZb4YiGCiFZAnrXCrQ
 fFtV5zQA/ajg0qtfOxI/FLuqhHkG06cWDlg/psqe3/m5fC3qHmHJcK/NWfIezBjS97sJ
 feBaFIkADWBjfN1rvkyzPYOM5jGgOzYE4HY59pb5HmnKKyhVAWL4Wsd+p8D2W7AUBC+X
 JRdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVaGF0VWNrcyspopiZ2jKt8je8GlcYl5YBOeTjJ4Xk6YKPCQuree7fFsUg+phb3/wvQ3XHMAdv00WpC@nongnu.org
X-Gm-Message-State: AOJu0YzW3o8EW2donQrikgla2opn8JVnMObLj7lUaDPRTt12BL2oBi7l
 gQSpOSJRUSnFEXqjNYsnkla3hmwaG4hzhSJf+ra9iBSpUv4ITYeOP7xE25UwDmA=
X-Google-Smtp-Source: AGHT+IGh+MKFANzWS+UmRT0dxTQ83tyjCfFxiujn7fNXy4lBleNxM6VndR6m8ygWyWE+Px7oOJ5REA==
X-Received: by 2002:a05:6214:318d:b0:6c1:6ad1:faee with SMTP id
 6a1803df08f44-6c16dc2180fmr129043186d6.3.1724688698735; 
 Mon, 26 Aug 2024 09:11:38 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.216.241])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c162d6e750sm47559096d6.67.2024.08.26.09.11.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 26 Aug 2024 09:11:38 -0700 (PDT)
Message-ID: <3f305742-def7-48b7-bdf9-42bd33dc9d34@linaro.org>
Date: Mon, 26 Aug 2024 18:11:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/avocado: Move LinuxTest related code into a
 separate file
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Auger <eric.auger@redhat.com>,
 qemu-arm@nongnu.org
References: <20240719095031.32814-1-thuth@redhat.com>
 <3e530db3-99e2-4878-a927-e6eebc0f92fe@linaro.org>
 <16c8e2b1-e9ae-44fe-ac97-adcce3a2900d@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <16c8e2b1-e9ae-44fe-ac97-adcce3a2900d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::f2a;
 envelope-from=philmd@linaro.org; helo=mail-qv1-xf2a.google.com
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

On 21/8/24 17:14, Thomas Huth wrote:
> On 21/08/2024 17.11, Philippe Mathieu-Daudé wrote:
>> On 19/7/24 11:50, Thomas Huth wrote:
>>> Only some few tests are using the LinuxTest class. Move the related
>>> code into a separate file so that this does not pollute the main
>>> namespace.
>>>
>>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>>> ---
>>>   tests/avocado/avocado_qemu/__init__.py  | 239 +---------------------
>>>   tests/avocado/avocado_qemu/linuxtest.py | 253 ++++++++++++++++++++++++
>>>   tests/avocado/boot_linux.py             |   3 +-
>>>   tests/avocado/hotplug_blk.py            |   2 +-
>>>   tests/avocado/hotplug_cpu.py            |   2 +-
>>>   tests/avocado/intel_iommu.py            |   2 +-
>>>   tests/avocado/replay_linux.py           |   2 +-
>>>   tests/avocado/smmu.py                   |   3 +-
>>>   8 files changed, 262 insertions(+), 244 deletions(-)
>>>   create mode 100644 tests/avocado/avocado_qemu/linuxtest.py
>>>
>>> diff --git a/tests/avocado/avocado_qemu/__init__.py 
>>> b/tests/avocado/avocado_qemu/__init__.py
>>> index 304c428168..a3da2a96bb 100644
>>> --- a/tests/avocado/avocado_qemu/__init__.py
>>> +++ b/tests/avocado/avocado_qemu/__init__.py
>>> @@ -10,7 +10,6 @@
>>>   import logging
>>>   import os
>>> -import shutil
>>>   import subprocess
>>>   import sys
>>>   import tempfile
>>> @@ -18,7 +17,7 @@
>>>   import uuid
>>>   import avocado
>>> -from avocado.utils import cloudinit, datadrainer, process, ssh, vmimage
>>> +from avocado.utils import ssh
>>
>> Unfortunately we don't run the user mode tests on CI and missed
>> 'process' is used by the QemuUserTest class.
> 
> Oh, sorry ... apparently I'm not running these locally on my machine 
> either ... could you send a patch to fix it, or want me to do it?

Updating this thread, the patch is here:
https://lore.kernel.org/qemu-devel/20240822095045.72643-4-philmd@linaro.org/


