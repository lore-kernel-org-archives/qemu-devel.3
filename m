Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4DA2F4BB7F
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 19:32:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuy8z-0003pt-QG; Tue, 24 Feb 2026 14:32:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuy8u-0003gd-Ek
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 14:32:25 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuy8t-0000ul-0n
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 14:32:24 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4834826e5a0so73142305e9.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 11:32:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771961541; x=1772566341; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=W7d3JdkLy79Vv89t3HHGKit4zR22jIobwOAhl0LquoQ=;
 b=Jqm0WDhIPMvCwNir5NjJRt8wznP7TYCgKbT+v2gtxMKzXbWNLgNqeUr1iXiOICiGio
 4jD3rStatJsLQljKRSkihO9NSpJ5J3FgfYMD1ddk8WjyJQOt01mynvIcFzN+IuEkjyE4
 Z/9DfvgxTf+1Qv70bW6P+1xPOK0cC4n1KzWN45//FPn/nsAyMMMBncXuQbi9fb76hzBn
 K7hM6ahIMjjYSkxMbiDgrST+rxeTWalQfQBZYZDXfN1TcYZ7SoccLdZ1USAnnh5MIQ2k
 77Appw6VMFE5yY0fY1metCw60qTKJpBDzjuV6t+RA2+esN4O3w+S7oG1kLp1/9Y3R4Ga
 OMnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771961541; x=1772566341;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W7d3JdkLy79Vv89t3HHGKit4zR22jIobwOAhl0LquoQ=;
 b=Em7wme9IKTqIwnsY+5fVuihuU0MIdAceyzCrgXerCYUPkQyHIWohxY1IR0L5rekhRh
 gJcY42frF38sVR1DTYLZKxaijWFCFsajQAKnvmoXbnLTwulWgWlcN0HM/IDcVfrnAy/k
 LI0BTdQ4DMClbs4bICBjvA0EJHNH9wzEBNJIhVuFlgSAM/6cI1VeLY0VGqTVwscV0iL+
 D72MY1/jziASgVfJJ0JFrtFYKARzIqYbxp4sxA9pgMoycMFGAH63Q8TKLopdAZzEokGV
 zpB/bZH9FazCpPN+6EI7vmINIlQMuA5467VTYXIisyz5mwYKeCInilPyff4I8+sWs+7n
 N/FQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXO8GBtbRHa/LtWoE6YjHAD+83UKp0PYSAvG7oVxaOKB69XFUDWo5gyNXerzFF1m1zGBYogqPdAAO37@nongnu.org
X-Gm-Message-State: AOJu0Yz1J3W80H5HtjOtTrc+lwaKkPwX3Cs+8M4ZPsEMx/BulqO5wiF6
 WYs5zRXgSC/9nu/32MXvdB8Cq3tXNHEL1FAm8TSaSrUN6leQKYU2sMpc3OhMF8Rucds=
X-Gm-Gg: AZuq6aLxKbZp5qyygEwdnOtO58Xlg9i5ShWTAfpFZsI0vj+oYy5lsQdg5u6Bg72ROcG
 PngV38dOCZyOsUgBQUJAqVjyabkE1WJDyJ0WYfk66RuvwkOBv6JWfJfqtqKR1fZlCmXnz1eGsqq
 RNVjYc14pXM6sIwT86hwDXoqYj1jRV8X6feOX7rn9M4sabSTtcVL9PnptNOT4HEAPXsfcGK43q3
 ijfpCobIxwX+ViOATFCKRnIteGLAL09MwAg3gFeNd8wGOxWrN9xgikgWTQQSdjpXqaV0aUUpqgW
 w+R7whbJTe+DZxCsxe1M+3NOroAFhbMgAwjLCK+W1KOKqK0XbrDXARis/sKmqDBFjW/4BbEH3gE
 hJpEgMd0sQFSs+kKxo6bNky8SzD7RSIFRH4TzMmwU8r2/zk8VNzH+ezvvXIOtrFWcjghvDUxSlo
 qzDaYbhe+5Cb09/MIPQAJVUvsQ8URWzhuJJIEy3J2ojj9uxMqRCpWB1RLkhky7quVRPw==
X-Received: by 2002:a05:600c:3e8d:b0:46e:761b:e7ff with SMTP id
 5b1f17b1804b1-483a95f5a48mr208779775e9.28.1771961541323; 
 Tue, 24 Feb 2026 11:32:21 -0800 (PST)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970bfa015sm29068159f8f.8.2026.02.24.11.32.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 11:32:20 -0800 (PST)
Message-ID: <e820181f-f039-4ed7-8a55-ed9a826358e0@linaro.org>
Date: Tue, 24 Feb 2026 20:32:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/10] hw/acpi: Move acpi_send_event() function out of
 acpi_interface.c
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Ani Sinha <anisinha@redhat.com>
References: <20260224182017.99865-1-philmd@linaro.org>
 <20260224182017.99865-3-philmd@linaro.org>
 <42588a53-5f23-41da-966e-f6e2c2568162@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <42588a53-5f23-41da-966e-f6e2c2568162@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 24/2/26 20:23, Pierrick Bouvier wrote:
> On 2/24/26 10:20 AM, Philippe Mathieu-Daudé wrote:
>> acpi_interface.c should only register QOM interfaces. Move
>> the acpi_send_event() function to core.c with the other
>> event handlers.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   hw/acpi/acpi_interface.c |  9 ---------
>>   hw/acpi/core.c           | 10 ++++++++++
>>   2 files changed, 10 insertions(+), 9 deletions(-)
>>
> 
> Should you move the function declaration to hw/acpi/acpi.h in this case?

Good point, will do.

> Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

Thanks!

