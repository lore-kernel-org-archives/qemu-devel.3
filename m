Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9594BCD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 10:14:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMNes-0003xG-7G; Mon, 11 May 2026 06:14:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMNeI-0003hh-IX
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:14:08 -0400
Received: from mail-lj1-x230.google.com ([2a00:1450:4864:20::230])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wMNeH-0003Fx-0T
 for qemu-devel@nongnu.org; Mon, 11 May 2026 06:14:06 -0400
Received: by mail-lj1-x230.google.com with SMTP id
 38308e7fff4ca-39397d63804so47104481fa.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 03:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778494443; x=1779099243; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f/HAaEsQmycXNEvNnUfv1pzIqV5ELwQcXLm9FxD6Hik=;
 b=CqctkVTEam/pz9KwuRgB2bDsx5a5VzM9+SODIrX2DI03Vfpbf3lPxBHbovWBuQ4yOT
 Gq+cru3KMIyh8i11bjqgkoecTG027+zSeFnWu2nQg2sAGAhodnHDOS85hv+l8kykoRZN
 3SWsnrqBswunwy3J2FSWWvurHKIznwoODexsVzqKwZYZ8TxZsJEBYoEiD0KiJclPzbt4
 5LFZ1/7tpFYNq10/JvT12+zjkwj3GZ66IF7bjmz1i7fuNPS+9rAyWQr51/a3XSXwwL9b
 c6m9XewicAQi/4iq5u2Su/jWFyhXO2C3e1JXcy+7KPgkhZ4BY8LnGI2BydQ/aMeMgX/Z
 CWQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778494443; x=1779099243;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=f/HAaEsQmycXNEvNnUfv1pzIqV5ELwQcXLm9FxD6Hik=;
 b=lMfduL/4AEoVfxBZfHskVRDBg2ADGokT+FlsX2MJe1JXGlSbfL50wZQcctKBewLGqz
 +LuwmocuNlgTwRo4er9xvsKKb76U+yp5aZpgn6nqcLJlKzcg0pvvUQkrgulLzu6cbzB4
 a0YIUK8tVhTBSLlelOBRQZ+EtAJTrn320mC+fRymETf3SLFeaI/ANDZsbDBOF5aDncE6
 y9cMQJLYjFV3mh1Oxo47sOFmPc5mKX7VcuFaKIF+wwd6DMiudaqgV6aqq/uJ5BaaJndU
 aHvBI8wrkTBZPHDK6SA2dDcOSU3c9w71h7jBrzLxPfmQ7VIwyRuyFWvfAZMBkt1wLVsJ
 7FYg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9+VIgWDAjeUgbt5WOKDox/jAWjWA7GklfGh5l20lyRSdH5BQ5fyGxf3oBil3nRWFVs5fh4lqCm58Mx@nongnu.org
X-Gm-Message-State: AOJu0YzYbi1LeiZQ1WxZR6nNFqaxDn+M3li29v29wq2YPs6Oj5Ibs1mV
 jC/8pRbaHnTJQxPn3ZXMILzDsnRAMPWlGec9tX/H80oNsngsXvKAknk51WzBHkEaF7uSPatFRmT
 deUU6HK0=
X-Gm-Gg: Acq92OHnpGl06AWsveOaIPaN4/t9kMETeppwOTWJhoRazir+qG7aKn5bmVnIaKxew0F
 Kny/hLXJsRtPebZMKZICGEmP1t3gE02uC+L4zB5A7hacvOW2Dn9kjHCS98yi2WPomqvEe8ptYD3
 OVdNyh5v/HTWBkcRNfUW4JMC5Yw/arDxv/Us4pf2T3VPV3hXZGbaKJA10nf60jf/mhkGUPEgeWS
 sedIIuakM3lUKOv9hrk+dcvSwDD6EIeGwKAeZCcrvGPl93BVzqyAvm4MfxzKuNSm/SYaoPxoIZQ
 RNGwoquyDomus/zXJYYVAhX8T2Yvcxf04AynVYlnQErCA1DBAhqYzyYWGiDFZb9AkDoUdBd0U0m
 p340+N7lRGCoDHFyMWiIQUinH41muLqOjxNb+RJMCgQXETDXZhd4pDJ7zMh+DyB1/KfzqFKcee4
 pKvuj1v/pUMfI1RQkesMPCpCSnhLiOq7xRE/g=
X-Received: by 2002:a05:600d:8:b0:48a:58ae:993b with SMTP id
 5b1f17b1804b1-48e676a4e03mr194360865e9.16.1778490108061; 
 Mon, 11 May 2026 02:01:48 -0700 (PDT)
Received: from [192.168.69.200] ([88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e6fffba52sm197204705e9.3.2026.05.11.02.01.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 May 2026 02:01:47 -0700 (PDT)
Message-ID: <432d18d3-61ff-45fa-b6e4-95ea71cd30af@linaro.org>
Date: Mon, 11 May 2026 11:01:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/s390x: add gen-features.h dependency to
 s390x_system_ss
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 "open list:S390 TCG CPUs" <qemu-s390x@nongnu.org>
References: <20260510204640.2178926-1-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260510204640.2178926-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::230;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x230.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 10/5/26 22:46, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> Commit 0b83acf2f05 moved gen_features_h from s390x_ss to
> s390x_common_ss. However s390x_system_ss (containing ioinst.c) was left
> without the dependency, causing a build race: it can be compiled before
> gen-features.h is generated (via cpu.h -> cpu_models.h -> cpu_features.h
> -> gen-features.h)
> 
> Add gen_features_h to s390x_system_ss to correct the build ordering.
> 
> Fixes: 0b83acf2f05 ("target/s390x: Introduce common system/user meson source set")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   target/s390x/meson.build | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

