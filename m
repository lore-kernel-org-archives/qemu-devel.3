Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46A15C52D6F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 09:21:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sisO8-0001Tt-3O; Tue, 27 Aug 2024 05:21:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sisO6-0001SV-OZ
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 05:21:18 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sisO4-0005Dx-SI
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 05:21:18 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-a867a564911so624113966b.2
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 02:21:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724750475; x=1725355275; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OXN8mHBDtwIEaJNeTegVPbNznzAEmH+ycUuUvBNkqso=;
 b=EpMKrvvgzquLfdEJXECLIaHkmx+GcZ4pAUiQ1gjrnDvj3ktactQ6pyCYtjvFwWPmzb
 5XfNgiFi4qLOOV5yk5p4GPMb1lFcCHZX2+5y6XwdQ9CAgL+pZJULG9fTvKu4xAcmfN7i
 ywDsqRQDIhJzef+49xC+poCGRKNYvh+uk73aNlMHL1Y0LSON2FNWBfHYnXW06bzO/V/u
 zSmWjO01upQgvmI1PfJ5J89QdCWGbGXJG/bNzi3zMWSHYrpgQ2YR1xh78INKGyQAyFo9
 8T5+OebL6/Hvk6woekLru/fXt+D+bjP/x09RIYenVrNBVoxTnVP2jpR83Gu0nXG7LA4+
 7shQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724750475; x=1725355275;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OXN8mHBDtwIEaJNeTegVPbNznzAEmH+ycUuUvBNkqso=;
 b=CIJCTX5TN3dHdlXQfxxEGvAMgYO3WhtPA1N38CpOZEru8sZ2UsS/jd8fzw35hjlnSf
 Jz5N76LppG9Ow9ZJ8X9RPJAGngQ+AwzS+XTLMsIWlqLHB42mCIiZ9I9VItPoCf39Ylsn
 3VuUsAGZDOm9CpaVPgDl0aJOT5ip856mvJIHiu+RBxdSCktcOGOksU1ZvBPBzI1ILgtW
 AoYZgGRwNe4FepDL3oh3799VMMZTNbaU7rLI6+FirHTXaVHCzt3FuCq4gAeKtIXljvi8
 xrG6NEzxrzBQ9s3jWo1x12Xq7bzbcid+Cg/9vJT1KpywUfe+ChvibcbFoWhJmCjxmY0O
 n2jQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX+IulHOP5ZWrRTk0Ymmtf6ksWTytcOM8ClVI6aCtmI18ucMJ1dkOBeUok8DYYrNmaAgPRTORIdmq/L@nongnu.org
X-Gm-Message-State: AOJu0YzLZJbdPRuUXmBxjwI7TcTnrZAd9aax095hpoWmTVFcUvUoSzzZ
 LfpU0+U3GgaU0HzoG2xd/52lbNom4RptqQLLizFXpaXUvOtHn9VedFDYW0+cnAA=
X-Google-Smtp-Source: AGHT+IEDnPVV6IRkqwEKR0YOLxr+MGkX+QJAi6FMbwjygGYXWIAvoXFONi+0JTC0LtBRkr5VgUi1ug==
X-Received: by 2002:a17:906:bc24:b0:a7d:a080:bb7 with SMTP id
 a640c23a62f3a-a86a52c3981mr904945466b.36.1724750474834; 
 Tue, 27 Aug 2024 02:21:14 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.206.45])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a86e5878597sm85727066b.175.2024.08.27.02.21.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Aug 2024 02:21:14 -0700 (PDT)
Message-ID: <aeb7bd72-095f-43cf-8216-18c341310915@linaro.org>
Date: Tue, 27 Aug 2024 11:21:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] tests/functional: Add a class containing Linux kernel
 helpers
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Cleber Rosa <crosa@redhat.com>,
 Sergey Kambalin <sergey.kambalin@auriga.com>, qemu-arm@nongnu.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20240826221058.75126-1-philmd@linaro.org>
 <20240826221058.75126-2-philmd@linaro.org>
 <e66847a0-7390-42d9-a51d-190e0734d25e@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <e66847a0-7390-42d9-a51d-190e0734d25e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x633.google.com
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

Hi Thomas,

On 27/8/24 07:34, Thomas Huth wrote:
> On 27/08/2024 00.10, Philippe Mathieu-Daudé wrote:
>> Use the 'linux_kernel' namespace to provide common helpers
>> to functional tests booting a Linux kernel.
>>
>> Suggested-by: Thomas Huth <thuth@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   tests/functional/qemu_test/linux_kernel.py | 19 +++++++++++++++++++
>>   1 file changed, 19 insertions(+)
>>   create mode 100644 tests/functional/qemu_test/linux_kernel.py
>>
>> diff --git a/tests/functional/qemu_test/linux_kernel.py 
>> b/tests/functional/qemu_test/linux_kernel.py
>> new file mode 100644
>> index 0000000000..917beb7fb6
>> --- /dev/null
>> +++ b/tests/functional/qemu_test/linux_kernel.py
>> @@ -0,0 +1,19 @@
>> +# Linux kernel functional test helpers
>> +#
>> +# Copyright (c) 2024 Linaro Ltd.
>> +#
>> +# Author:
>> +#  Philippe Mathieu-Daudé <philmd@linaro.org>
>> +#
>> +# SPDX-License-Identifier: GPL-2.0-or-later
>> +
>> +from . import wait_for_console_pattern
>> +
>> +KERNEL_COMMON_COMMAND_LINE = 'printk.time=0 '
>> +
>> +KERNEL_PANIC_MESSAGE = 'Kernel panic - not syncing'
>> +
>> +def linux_kernel_wait_for_pattern(test, success_message):
>> +    wait_for_console_pattern(test,
>> +                             success_message=success_message,
>> +                             failure_message=KERNEL_PANIC_MESSAGE)
> 
> I'd prefer to have the whole LinuxKernelTest class here (without the 
> BootLinuxConsole class of course), that way the modifications that we 
> have to do to the converted tests are definitely smaller when we don't 
> have to change the "wait_for_console_pattern" lines everywhere. And it's 
> also nicer if the variables are properly wrapped in a class.

I'm a bit confused by your comment. I exposed my view on LinuxKernelTest
methods (which I don't see specific to this class) here:
https://lore.kernel.org/qemu-devel/9910ebc8-b7c4-4505-a987-3a5e308fb3d1@linaro.org/

Could your request be implemented on top on this patch, as we go (as it
is already helpful in its current state)? Otherwise I'll ask you to
share a snippet of what you mean, or even better to post a v2 :)

Regards,

Phil.

