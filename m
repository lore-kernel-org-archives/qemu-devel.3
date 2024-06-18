Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39686C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 15:34:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJapn-0003yb-0z; Tue, 18 Jun 2024 11:33:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJapl-0003yR-Uv
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 11:33:21 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sJapk-00026x-9K
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 11:33:21 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-35f2c9e23d3so4355598f8f.0
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 08:33:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718724795; x=1719329595; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=GXoNLb9tJfNMQdHVW66XdKbwpkpC2Ion4bI8J7om/BI=;
 b=EwoJdE2DPb6pk0cQ6mz0caCj/LJp3nPWNeO37iH6rfUwdiv82HA0quj3/ldBAjXw3X
 v2IOT3L0ZTYSocBpbvqRSmmZsLCE8L+9oqtIc2darNLVSqR4v1szm/3kLi8TUyLm76in
 QfO1h0eoh17kIvb0DdXHL7LnmJ98QYIHxFRh5fpdcSYEP7o5C1QIME4SEDAoVVpO/cin
 RPEbEm2hUIigb7u2nT7b9LPY4oBnugQvFjel7kqRaVoobPB6gSzuJhQe3WGfJ4/4mf/G
 oHa67bkki3+jGv9QmAzY8dbEgHsP37CUICsKLRuQxvE6+U7fVOFYYDIWwZuiHOzqldUJ
 6S3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718724795; x=1719329595;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GXoNLb9tJfNMQdHVW66XdKbwpkpC2Ion4bI8J7om/BI=;
 b=fwUn/duOD81/N86s0GZTmKBBpOpD82obps58U8tzr360Kx0Lf1Gbv/0v6QxgDY5TPS
 DP1ayy1zwjMitSgK3KLFws0jSjW/HDoFTsLPtUvtbgDPa6bbNuEUqWo8PbOw+7QCkW4Z
 r70Yoa3JEvTpmm+eUUrUfw9ymZ+pLDh8Z9Y2ctgpDsMW6ISB0OUcpKWI6ntYcktv5mAg
 3cggQY5PczTiTAMXPQ3OfdPPYP7QkEgFbQ+3viDu64SezBSiSb3joMXH2eLJ6gFIozwX
 aVJs9sJRXxNxzc2dyXaCNBJGur8qGQq+nsh091z0B0XGkw2tYe3suZyP9ecLu2my3Hpx
 GcUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwvMf5CHo8KWa3UGJajA1iqiLzwKIrWujBOtkq6wKIa6m9RMVloN7yl8jbf9Y3F7y2BYKHu/Y+E1PGqCUuQmvX3fFv4UM=
X-Gm-Message-State: AOJu0YyZ8C2zo/NXk4N127HBJQodIpDiIXRBviX+3VpX+x101ljkcTRV
 RgHXg0jMkeZ7+XWCwKf5bPB6DCdo7913NLpalpYqFOJe6srHW/7S66kNc4KPm1Y=
X-Google-Smtp-Source: AGHT+IH5OQYf93lt0qt+m2PeVYJLGNY9NFfV8+SDKyewe9MQxz3lsV9S3HAZk3xeyUIWsxBx9SzQSA==
X-Received: by 2002:a5d:6d4c:0:b0:360:7856:fa62 with SMTP id
 ffacd0b85a97d-3609ea6c58emr2971482f8f.15.1718724795416; 
 Tue, 18 Jun 2024 08:33:15 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.212.55])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4246b67f0aesm60070905e9.45.2024.06.18.08.33.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 08:33:14 -0700 (PDT)
Message-ID: <6072516b-b8db-443e-b32d-3bcd597cce48@linaro.org>
Date: Tue, 18 Jun 2024 17:33:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/3] hw/usb: Introduce x-query-usbhost QMP command
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20240611102305.60735-1-philmd@linaro.org>
 <20240611102305.60735-3-philmd@linaro.org>
 <7c8cf4f0-c717-47dd-8390-41c7fd7d0a0b@linaro.org>
Content-Language: en-US
In-Reply-To: <7c8cf4f0-c717-47dd-8390-41c7fd7d0a0b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 18/6/24 16:15, Philippe Mathieu-Daudé wrote:
> On 11/6/24 12:23, Philippe Mathieu-Daudé wrote:
>> This is a counterpart to the HMP "info usbhost" command. It is being
>> added with an "x-" prefix because this QMP command is intended as an
>> adhoc debugging tool and will thus not be modelled in QAPI as fully
>> structured data, nor will it have long term guaranteed stability.
>> The existing HMP command is rewritten to call the QMP command.
>>
>> Since host-libusb.c can be built as part of the 'hw-usb' module,
>> we introduce the libusb_register_hmp_info_hrt() helper to allow late
>> registration when the module is loaded.
>>
>> Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   qapi/machine.json           | 18 ++++++++++++++++
>>   hw/usb/host-libusb.h        | 16 ++++++++++++++
>>   include/hw/usb.h            |  3 ---
>>   hw/usb/bus-stub.c           |  7 +++++-
>>   hw/usb/host-libusb-common.c | 31 ++++++++++++++++++++++++++
>>   hw/usb/host-libusb.c        | 43 +++++++++++++++++++++++++------------
>>   tests/qtest/qmp-cmd-test.c  |  3 +++
>>   hmp-commands-info.hx        |  2 ++
>>   hw/usb/meson.build          |  1 +
>>   9 files changed, 106 insertions(+), 18 deletions(-)
>>   create mode 100644 hw/usb/host-libusb.h
>>   create mode 100644 hw/usb/host-libusb-common.c


>> diff --git a/hw/usb/bus-stub.c b/hw/usb/bus-stub.c
>> index fcabe8429e..948429bb33 100644
>> --- a/hw/usb/bus-stub.c
>> +++ b/hw/usb/bus-stub.c
>> @@ -11,7 +11,6 @@
>>   #include "qapi/error.h"
>>   #include "qapi/qapi-commands-machine.h"
>>   #include "sysemu/sysemu.h"
>> -#include "monitor/monitor.h"
>>   #include "hw/usb.h"
>>   USBDevice *usbdevice_create(const char *driver)
>> @@ -26,3 +25,9 @@ HumanReadableText *qmp_x_query_usb(Error **errp)
>>       error_setg(errp, "Support for USB devices not built-in");
>>       return NULL;
>>   }

Also missing:

    #ifdef CONFIG_USB_LIBUSB

>> +HumanReadableText *qmp_x_query_usbhost(Error **errp)
>> +{
>> +    error_setg(errp, "Support for USB devices not built-in");
>> +    return NULL;
>> +}

    #endif

But still failing the build-without-defaults job:

▶ 59/61 /x86_64/qmp/x-query-usbhost - 
ERROR:../tests/qtest/qmp-cmd-test.c:88:test_query: assertion failed: 
(error) FAIL

So dropping patches 2 & 3 for now.

