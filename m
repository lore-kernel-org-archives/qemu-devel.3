Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8FF3C282EC
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 15:15:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ts1Jg-0000v0-6I; Tue, 11 Mar 2025 11:14:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts1Jc-0000rM-Ry
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:14:44 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ts1Ja-0004nL-Ev
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 11:14:44 -0400
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-391342fc148so2738815f8f.2
 for <qemu-devel@nongnu.org>; Tue, 11 Mar 2025 08:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741706078; x=1742310878; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
 :cc:subject:date:message-id:reply-to;
 bh=nRRe0V6hTnTEa/ywDXDKo4kqBN5ZydvlC5M+vqDkq1c=;
 b=sYvCkXB/yvjkriFQsUeZVqbJPRAmf/bsMuMNo7GsD7lo5S41Hk6Amn0IvLy/x8aQfH
 h0BAC7mPl5rMqmr9LvwhjRDB3upYoiXZ5U6iiG8G10VYviuerEBnYVTc0cdafzHdwxQY
 zIuuKVhBPsVnRz+F4ujKCZW7xwTi03hvB5q56ubSeQqXHu6jbiQ/duEAp2zKaCfO3nd5
 uI/a0paFae3EETAPQiSUU2M97q0XkOGcfJZPsfuIXEIPv6i77nFjJgRfFqDN4xL0806n
 EVfZipqtoH7K4PizYFQ/+kt6HsN1VCjVDhEIYox2IaSv06mACtjxjs2s+9TfsqpNspQG
 Rm0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741706078; x=1742310878;
 h=content-transfer-encoding:in-reply-to:content-language:references
 :cc:to:from:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nRRe0V6hTnTEa/ywDXDKo4kqBN5ZydvlC5M+vqDkq1c=;
 b=FMtliFi5yWbPuBolg6QICVM22mrcaXJi0LZq6WJq99N5IyKIGHRIUv9tZ25y+aofoO
 wlA5O6TAbM9cuiAMA+BEVqHjH6nYzIWz+A50fFd7Z8Kv5A24ZYmy0nUmVvUlgr4MIxHr
 pyFy+/f5anE63x9BMpdNBlGTq2mSmIpMAQ2p4iSHodIchUkVkSt5BaEZfHbZjK+EeIHI
 6kAOlrAEveMITS071mGDPPp1P1ub6g6QRiWluDXBU+wKXZoYXojzY8H5JQRwr2FDv5EI
 C5tlzDCkcHPBaCKMTYmz/EakJS8J2q2MU5Io8ZPBGrQ59T1tBnFFQO34aO2lBgQ9nQtJ
 3Phg==
X-Forwarded-Encrypted: i=1;
 AJvYcCX6vZGuI6ID+DH/LeV9W00JIrwELdTg6ct0yJP8hxvmN4cUeUNMNH9d8oOCwGIb9AQrSK6LoQFT9VmF@nongnu.org
X-Gm-Message-State: AOJu0YxMbIW2gM4XHJ7zY8EqgwA823JNW42OICogGng5/lGelDnLl6Tf
 6aQ+DziOvWxtyf94lF9W5ZPD8jRwYho48FxRYIkhYmMB41ESmJzncFP2u9qz8Oc=
X-Gm-Gg: ASbGncvpTr5bdfH2/AfOPOi8G1/LzzR/dfhhsGikXO2m87K2MdfgZ0hWcoeqauu5YuR
 zl2F3Mf+j0wluI8o33bL5193Dul8TiKqCrDG2a5LEjRVeqWNs4ob6vlb1KbnpTP1DhVn0wXhvXg
 iHHNOYuPDqK5WIwTkQmZ2mHk3xz49jO9t9QAdZETgY1DfwqMuEZXRQRUxdny2TlFHgq1ROlw1ke
 nt37xJRJ76dfzwxZxM6CkyzfXYk4uC22KBQPO65AxXlRhrTo/g2JIea6GUTzatqUsI8O5eNKGpk
 aVfwxjN7Ns80Ix8OhGZfWvy58N3NeSOgrF/pF/RRJgyhmS0vdN34z6QfNZlaDiTw42rDc53kZIg
 fLyLvbEgPvnxN
X-Google-Smtp-Source: AGHT+IGMZq9Zv5IrDzGNXyfZard2uq17hlvG5nfa9qRcDr6dl5yVlBL8PHub5h9dwcelWjylk5GmVQ==
X-Received: by 2002:a05:6000:18a5:b0:391:13ef:1b1b with SMTP id
 ffacd0b85a97d-3926469486emr5385934f8f.30.1741706077939; 
 Tue, 11 Mar 2025 08:14:37 -0700 (PDT)
Received: from [192.168.69.199] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d032afc2esm15042685e9.2.2025.03.11.08.14.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 11 Mar 2025 08:14:37 -0700 (PDT)
Message-ID: <b5f9e231-8c29-4992-89a0-5cdea7c08b34@linaro.org>
Date: Tue, 11 Mar 2025 16:14:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] hw/hyperv/hyperv.h: header cleanup
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 alex.bennee@linaro.org, Marcelo Tosatti <mtosatti@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 richard.henderson@linaro.org, manos.pitsidianakis@linaro.org
References: <20250307215623.524987-1-pierrick.bouvier@linaro.org>
 <20250307215623.524987-3-pierrick.bouvier@linaro.org>
 <f957fbdb-c7c3-4a31-a76a-144ff31ea158@linaro.org>
Content-Language: en-US
In-Reply-To: <f957fbdb-c7c3-4a31-a76a-144ff31ea158@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 11/3/25 16:05, Philippe Mathieu-Daudé wrote:
> On 7/3/25 22:56, Pierrick Bouvier wrote:
>> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
>> ---
>>   include/hw/hyperv/hyperv.h | 3 ++-
>>   1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/hw/hyperv/hyperv.h b/include/hw/hyperv/hyperv.h
>> index d717b4e13d4..63a8b65278f 100644
>> --- a/include/hw/hyperv/hyperv.h
>> +++ b/include/hw/hyperv/hyperv.h
>> @@ -10,7 +10,8 @@
>>   #ifndef HW_HYPERV_HYPERV_H
>>   #define HW_HYPERV_HYPERV_H
>> -#include "cpu-qom.h"
>> +#include "exec/hwaddr.h"
>> +#include "hw/core/cpu.h"
> 
> I don't see where "hw/core/cpu.h" is used.

OK found it:

static inline uint32_t hyperv_vp_index(CPUState *cs)
{
     return cs->cpu_index;
}

First, bringing this huge header for this single use is way overkill,
then I doubt this method deserves to be inlined, third @cpu_index is
an accelerator specific field, often incorrectly used. Maybe in this
case it is OK although, since IIUC we only support HyperV with KVM,
right?

