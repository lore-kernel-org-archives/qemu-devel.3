Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E89FEC9EC7A
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Jan 2026 16:33:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfKhB-0003vU-U7; Mon, 12 Jan 2026 11:23:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vfKfq-0003Yv-7B
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 11:21:48 -0500
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vfKfo-00088g-HH
 for qemu-devel@nongnu.org; Mon, 12 Jan 2026 11:21:45 -0500
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-81e7477828bso1521021b3a.0
 for <qemu-devel@nongnu.org>; Mon, 12 Jan 2026 08:21:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768234903; x=1768839703; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wlkIiqSZlMDBvce3juhwVe0pZE4IZJdrPBREhvrFg9Y=;
 b=kajoJkZQN4ZbzV9psUDdFqMztujzFS+tSIg6KGJCti+dKhpLW9yH8EzpqDBSba6ENE
 cQbt6/2HOqfbs7ThrOlq5kX/XhipnO5XBbHa8KsUMr+NMqv2Cbz1bAlkA+D4KJg/oAKE
 IGsLYgboiqAH6JOIE2FdLNaKf7CM2rtkuYOcwEj7JNI/tR8GsKf0P/1cNi047YhLwoRo
 UfzdoKgLD8DpncP61ZAwk98oy1FtNmdHwZ5ZxRZpDFItzbOSJC1zbIcmO5VAYNtbjOOB
 FHs3UaJ5Wu1WMOmHyT509aH1/yvWyakWUCrq2dg5dx7fXRuVeu78S2ZmifdPRMU9HqrH
 ym0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768234903; x=1768839703;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=wlkIiqSZlMDBvce3juhwVe0pZE4IZJdrPBREhvrFg9Y=;
 b=ptukGZVMMibnn1vslRA3yvLb0YEK+QNisvv/Smf+gH81/DmEzuGoWJNB1WN2YCr5BD
 bk0o0XRrlZojRgfDxMNIB8Yj5rRpbVFBux/FzYH04k2Nnu1GM06fjSfuABCQb0YVH/WF
 6OWr0xD/ZUZRUqRDFJzIBqfB4H6HqhAPXyDPfaSXGdogHT+LNf2xxhkxO9h7vUDWshV5
 duuamXAoHzgjObO0rYC9aAnMtlQbMeA4GShmm6wxFP0J9DGh+3LcEgfRn6zBoYeTP3Ya
 MUHjWibrLRruiC+fcb2I7EE1KDFTsPZypNzcasd0ANyhBTnKIQPBiXqzoWqce3fU5Nr4
 pkzg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrdWfNElI+36G9i8xHo0xJz99Pn10YNzY6/++Bv6xK67TCcI2TKGCcF7dAxWgfqWTQPEAuNLbfJpzU@nongnu.org
X-Gm-Message-State: AOJu0YyXZaaXix92WtwrnArs/XQspHQ749Cu3tXXpCT6T3iBK8XvVhrM
 0PagvhR31BfPnCinLoXKQ41/xXSUGDw/VMq/U9ROWVKD+hx7IFz0QFb/msSg3SjHRaE=
X-Gm-Gg: AY/fxX4phtxu14TYrz4lDq3WhWOxj/DXkQkTdgVMdE9y5UE5ieZ7FSuZ0pKulLLRe6M
 I9UlH/tlnSQ1OgORep1HMac4LIHedByWOr0PNZ179q2TX1ttRcqjHpLSqI2x/bQpu4FBZHCilaw
 +Zpu3P+jnkvc8apc7w+qhI6/A9X3ZGxMzbgpiGXXl2JgfQKTWOfbJDC6zK1dAxknXv4mZH/vib2
 2zGvTnD2P/FvffVS/vwavbx3dtPIAdoPC4F/g5gNXlEBz6YAxmALLxa+Bjtrm4TcU1CUI/A3c5a
 fZNhMxrIWQjDTMq3rnBpHVZGMJCMIkLTYbZDaHtLFG7bkV8s2rx7wTlPJBmleBudUm7AeGBxPOI
 NiJMGpF2E3jzrTL3t5k9zajEqyMCOWe4OdwtuUiOqJ4PVdL5Pb1zTah1KNUukkIbo4StJmdIy1w
 sP972aYszwaHqEvaLFobUl07DFFWMtODk50zrXDBqiBBoyTWCBXqjpA+dZ+1/CnXogt/s=
X-Google-Smtp-Source: AGHT+IHJ8bRZuqmFgbPVPBltyIHJGwivpcTtezTUqOJ1M5Qy5nFpGXH5sxvyr8IxaEuVTjxAAX3zeQ==
X-Received: by 2002:a05:6a00:8c10:b0:818:1e8c:a513 with SMTP id
 d2e1a72fcca58-81b77eea322mr17038321b3a.17.1768234902818; 
 Mon, 12 Jan 2026 08:21:42 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-81f32ccb4aesm7443647b3a.9.2026.01.12.08.21.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 12 Jan 2026 08:21:41 -0800 (PST)
Message-ID: <82940e3b-f9a7-4172-8ae7-680bc1a5785b@linaro.org>
Date: Mon, 12 Jan 2026 08:21:42 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5] hw/arm/smmu: add memory regions as property for an
 SMMU instance
Content-Language: en-US
To: eric.auger@redhat.com, qemu-devel@nongnu.org
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>, qemu-arm@nongnu.org,
 tangtao1634@phytium.com.cn, richard.henderson@linaro.org,
 Radoslaw Biernacki <rad@semihalf.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20260108210453.2280733-1-pierrick.bouvier@linaro.org>
 <08c42104-d7c5-4df8-b25f-7138ddc94a94@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <08c42104-d7c5-4df8-b25f-7138ddc94a94@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42a.google.com
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

On 1/12/26 1:58 AM, Eric Auger wrote:
> 
> 
> On 1/8/26 10:04 PM, Pierrick Bouvier wrote:
>> This will be used to access non-secure and secure memory. Secure support
>> and Granule Protection Check (for RME) for SMMU need to access secure
>> memory.
>>
>> As well, it allows to remove usage of global address_space_memory,
>> allowing different SMMU instances to have a specific view of memory.
>>
>> User creatable SMMU are handled as well for virt machine,
>> by setting the memory properties when device is plugged in.
>>
>> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> 
> Thanks
> 
> Eric

Would you be ok to pull this patch, or would you prefer someone else to 
do it?

Regards,
Pierrick

