Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D03B3C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 15:54:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJL9-0006n1-TE; Mon, 01 Jul 2024 11:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sOJL8-0006mb-1i
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:53:14 -0400
Received: from mail-pf1-x432.google.com ([2607:f8b0:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1sOJL6-00010m-A6
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 11:53:13 -0400
Received: by mail-pf1-x432.google.com with SMTP id
 d2e1a72fcca58-7067435d376so2296513b3a.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 08:53:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1719849191; x=1720453991; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=uzu0ulmSb0VkwKIzHQbyj8CiJcovL3I1+1nR72hgyKI=;
 b=IE2iNjPt4r2P4WRXCgTrXJoTxzB3WW2PMiNlM++PKnMKI/IYJiDIztN1QJYwFcHZxE
 WwLAJSLMNVW+sqm4lYqSxYpHXZ/N66z3v3uJ8ctlqeTsan9IVGKTylu3kCQzn6/8efft
 wtR5cNWDapygfr6YdSmK/pqNVy6XNNRNtLEaair1F88S/Gko1xblf4DXw2UksWCDOcgH
 PG2UnUrbbjNJUX8A5rOUSgjyAUsWSzX4YFGpkLQkkr2BNXC9kMq/iTylPUQTUedLkaN2
 2nNN5I9WGyojCF+5xb8ADgZKncC0j9J3Y97X9VkI634Nl5n2s4yB/ChJRq8pkM4EBlop
 Z3Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719849191; x=1720453991;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uzu0ulmSb0VkwKIzHQbyj8CiJcovL3I1+1nR72hgyKI=;
 b=DjFbwRjS62azfjQxGyBVu7yIWmEmAESxeBN3FRMX1l/wYG6kv3yoHdywxx8BsR6aAj
 k63SP3fhAonV3uwhQbb7KWtRX9uC6cJl1ZPrkPg/FUoNE02gArR06DXvyLG8UueP6A/A
 R3SVp8osCfDBePEW0Av+kFdqzcIrW3pGG3zr7cHf+UVsUqq8DIVOKhWmkCMUOZ5nq0To
 2+xSUPW7e7cic36HsR2YtTcw67MpyGqXL80+NOo6wUVATef7lBEDOSvT79TTLFyS0Tbr
 IasSO9G3iv0q8OWbyPWgPQJaytnaNdkSjRAyLiHHV4KijiU0JY+EyBLiGCm48LtZstcS
 jspw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWHHOyHS7Z+WLLZoExwur7ZqO7VXM2RWYbIHJAFNhaA563euIDO/jR1+zm5JRl8PtE5U8NWMl64ecttczMPNgHIYg/YPM=
X-Gm-Message-State: AOJu0YwmmI5J7nJV0MpdYAvUVKMlWm12q/TYeFW8iTQgvHSOkgsyhhRC
 w67C3NZ4fqxFMDDB5z3LPITkXCP2TgIhiA9scSFixQgbg5/70/MvsoTV5amqYOA=
X-Google-Smtp-Source: AGHT+IGPnCTy77lRtkcqt9NNeQ2HC7FiVtA+uJxKiFoDSOGu8MEKYRKTeuPzZtgE0d0QR/MX81HZKQ==
X-Received: by 2002:a05:6a00:22d2:b0:706:1f67:64d3 with SMTP id
 d2e1a72fcca58-70aaaba8fc5mr9749714b3a.14.1719849190542; 
 Mon, 01 Jul 2024 08:53:10 -0700 (PDT)
Received: from [192.168.68.109] ([179.193.8.43])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-7080256d3c5sm6686075b3a.83.2024.07.01.08.53.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 08:53:10 -0700 (PDT)
Message-ID: <8c356054-0921-4437-b64a-8bbf68751ce6@ventanamicro.com>
Date: Mon, 1 Jul 2024 12:53:06 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] system/vl.c: do not allow mixed -accel opts
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: ajones@ventanamicro.com, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>
References: <20240701133038.1489043-1-dbarboza@ventanamicro.com>
 <20240701133038.1489043-2-dbarboza@ventanamicro.com>
 <522ccd9b-8551-49a9-ac01-0c26776a3d57@linaro.org>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <522ccd9b-8551-49a9-ac01-0c26776a3d57@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::432;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pf1-x432.google.com
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



On 7/1/24 12:23 PM, Richard Henderson wrote:
> On 7/1/24 06:30, Daniel Henrique Barboza wrote:
>> We're allowing multiple -accel options to be used with different
>> accelerators, even though we don't have any machine that supports mixed
>> acceleration.
>>
>> In fact, it will only parse the first occurence of -accel and, aside
>> from a help option (e.g. -accel help) that will always cause the process
>> to print the help text, it will accept every other accel option
>> regardless of being correct or not. E.g. this:
>>
>> qemu-system-x86_64 -accel kvm -accel tcg -accel IamNotAnAccel (...)
>>
>> will happily boot a x86_64 KVM guest.
>>
>> Do not allow for different accelerators to be used when multiple
>> instances of -accel are present.
>>
>> Cc: Paolo Bonzini<pbonzini@redhat.com>
>> Cc: Thomas Huth<thuth@redhat.com>
>> Signed-off-by: Daniel Henrique Barboza<dbarboza@ventanamicro.com>
>> ---
>>   system/vl.c | 15 ++++++++++++++-
>>   1 file changed, 14 insertions(+), 1 deletion(-)
> 
> We use '-accel kvm -accel tcg' to allow kvm to fail (e.g. no /dev/kvm permission) and proceed with tcg.
> 
> This patch will cause testsuite failures.

For the issue I want to fix patch 2 alone is enough. I'll re-send.


Thanks,

Daniel


> 
> 
> r~

