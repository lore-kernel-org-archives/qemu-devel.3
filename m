Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0C7EC54E67
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 15:59:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp9C1-0002Qh-2z; Tue, 26 Mar 2024 11:58:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp9Bz-0002QZ-Sl
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 11:58:27 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rp9By-0004Hq-7s
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 11:58:27 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-3416df43cabso3974084f8f.3
 for <qemu-devel@nongnu.org>; Tue, 26 Mar 2024 08:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711468704; x=1712073504; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7NUieXuq/rRaVan7nPVoZS8XXT72WR75c4yXRI230lM=;
 b=tKxe8yJQrfqHx56CZObP48ZOVWQd6uAEVTjiT1N4WELnXo9GTA+ju2nkODNBZ5E+ZA
 us0BJyE6jdLa4HBhoAb+diHdqslAUCynxceFfs5YYqXf/ceQeqP+BIBIwlxLTDvZEXcM
 ifY8oIbYi/Lzl7WFeWaFkjenjREbdnjbDKklKaKHcryRg0syTTn4yGumJe3/3uGZVBoQ
 IwtxThkmJjpI6Q9pe+Jz0izjFVMJqs9TxkpKYoAo52VAxeXEB6ng9szKGq8VZayCejI8
 q2B9AEwBefB/rjeiVQwNsv6K41HjrgPeFbeszD3XNwlPHnCWu86SPX1sww5WmNa108yw
 E+Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711468704; x=1712073504;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7NUieXuq/rRaVan7nPVoZS8XXT72WR75c4yXRI230lM=;
 b=jRpbo/W8mN/Gi22XqdaiM2zZV93CW1pOBYCmk/OS6M9yLK/XF42k0dhYIvR6oOXSWZ
 srHK8Nzy6ZaPg7q6AQGc97V9v4KnevNoqggXDWYouVMcXm5nGHDEoKGDW474d6ipO1hj
 nFFFCHOWXwhwd5i3F6zW2QEzeBUd7tGCFyythE4t+WfwQlNYV3uMYXzApYWWn2yemia0
 iv8jQ8mBtg/t3zI7BP9+xlOCwe3BU5I8OFTaaOGzTkEoXp9uu3yi0Sbcs1HgDBL2Z3eo
 x0Hsc6Kyrr2kHMpdECopPWAz/L71a3/eX6DIEfDDHc9o4nIBbIdEIwAfG5ys8hSPYgd/
 86xQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWxv+NDA5lJFH/2+Y8KxQtfY8SPTP7Jwpo0P8Oym/OcLHGtR7FlZmOFZj60FEgSn/1/Noi3DtA5t1aBvBKQZf9EQITaB5o=
X-Gm-Message-State: AOJu0YylvnzzDS2OVdgY3qnfMqHgHd8OqVl2zeA4aZoOowhg0TlONeHb
 Vz27f/tmf8/kmPeJOgLUXpIXRfuoTnhaBfJE/+IOdA+Hi4mxCzktoCjFC/3tAD8=
X-Google-Smtp-Source: AGHT+IFJOVH/g3EtzULqiNm5Wwx2fzGm/TgZS4YlQH/pvzTboeTJPzumkoLuEBwMw1bVj0/Quj3DUQ==
X-Received: by 2002:a05:6000:d1:b0:33e:78c1:acfa with SMTP id
 q17-20020a05600000d100b0033e78c1acfamr1165077wrx.1.1711468704255; 
 Tue, 26 Mar 2024 08:58:24 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.155.229])
 by smtp.gmail.com with ESMTPSA id
 v16-20020a5d5910000000b003418364032asm12544381wrd.112.2024.03.26.08.58.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Mar 2024 08:58:23 -0700 (PDT)
Message-ID: <d5ff6e5e-963f-467a-9d5b-3e2d12e16695@linaro.org>
Date: Tue, 26 Mar 2024 16:58:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1] hw/i386: Add a config to only build the microvm
 machine
Content-Language: en-US
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Sergio Lopez <slp@redhat.com>
Cc: mst@redhat.com, Eduardo Habkost <eduardo@habkost.net>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Ani Sinha <anisinha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
References: <20240326131410.93866-1-philmd@linaro.org>
 <517935ff-6f0f-4ef8-878c-9778f6b1bb98@tls.msk.ru>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <517935ff-6f0f-4ef8-878c-9778f6b1bb98@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 26/3/24 16:48, Michael Tokarev wrote:
> 26.03.2024 16:14, Philippe Mathieu-Daudé wrote:
>> Add a config file to build a binary only containing the
>> microvm machine, inspired by a discussion on the list:
>> https://lore.kernel.org/qemu-devel/604bf457-23a7-4d06-b59f-a7b46945c626@tls.msk.ru/
>>
>> As suggested in commit d1d5e9eefd ("configure: allow the
>> selection of alternate config in the build"), it can be
>> built using:
>>
>>    $ ../configure --without-default-features \
>>                   --target-list=x86_64-softmmu \
>>                   --with-devices-x86_64=microvm
>>
>> Inspired-by: Michael Tokarev <mjt@tls.msk.ru>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   configs/devices/x86_64-softmmu/microvm.mak | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>   create mode 100644 configs/devices/x86_64-softmmu/microvm.mak
> 
> This is not enough.  This step is good already, but it lacks default 
> machine
> type selection.  In debian we carry a tiny patch to make microvm the 
> default
> machine type or else it crashes at startup not finding "pc" machine or one
> of its required devices.

No crash here, what is your base commit?

./qemu-system-x86_64
qemu-system-x86_64: No machine specified, and there is no default
Use -machine help to list supported machines
$ ./qemu-system-x86_64 -M help
Supported machines are:
microvm              microvm (i386)
none                 empty machine
$

> 
> /mjt


