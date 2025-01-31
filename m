Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98408C0218F
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2025 16:47:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tduAH-0005xv-9n; Fri, 31 Jan 2025 11:46:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tduAB-0005vF-49
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 11:46:39 -0500
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tduA9-0000Q1-Iv
 for qemu-devel@nongnu.org; Fri, 31 Jan 2025 11:46:38 -0500
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-216426b0865so40142355ad.0
 for <qemu-devel@nongnu.org>; Fri, 31 Jan 2025 08:46:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738341996; x=1738946796; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eb9R/potxLbKcWtTBrZYpzuUeavSfgFfRVFByzPaJ5s=;
 b=rP9aET5sDnv3Y5w/nixvFiw5qACMSr/fsL6UpmieDwVBqqT9cmkIg4K2WGkIP1iP+b
 HAOBDYpuqq0x4otEKB/bX5mCvVbaYSay2uqtVFkQBpQuzc/83hETyNNcqsCFsU8IypvF
 +7couaTvbJHV714ShUe1jCiZU106rG7nSNd65Fym6IgyNobPZo7kcIs/shtnG1r2q4QD
 rd0ZOGGSwYyg6eKWngmapSms2PmtjoCKtIRsuub4ZmrZpwPHYZkAYR9aDFixj4cQkdmz
 H2//57R7abJxj/N+ctBZtRj1T+LDqZiTF6qaN2B9z05TAhUYa57GpvmYg1/RSVd0OaAJ
 nxiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738341996; x=1738946796;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=eb9R/potxLbKcWtTBrZYpzuUeavSfgFfRVFByzPaJ5s=;
 b=u8icf+ouCNFTGr6Qkfcy5MqZpLwrspcFobHhubQmN/86tDVSJyqXCQqvo8+6ES3x2A
 +GqTGeIvdPhF0A1z+/vuUptiC8/76dfMcISNhNLpToApMqBZzEMgZ7Ad4FvcZnPPu8Eg
 AI6up6ZRoDAe/kRFUiNUBJeKbkFadf1QVmWaGId2r82iRcsY1WCIQCZeOc0Addbq0KZd
 /GaHY1nt++NKVWThrFqO8welCzDgtyT7hx86gtKFGhz805hlzYLZX5eHgDOpyEJnaooS
 Li/zJGiKMAkf65EhGHPpX/LD/2wmZOT8sYX8rCf+V3sZZpLQH5npgASHPd8iic2FXneO
 fXEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVf1mB2u53dWh57bdU0T1CoFiGUhoWv7m8SXhv5sKWi1zN+bvae3i9+Cn7XphPhjUBDDh4gIv9L/YLw@nongnu.org
X-Gm-Message-State: AOJu0YwqzKYKeYkWvO/K2jvlJD9W4i+c7QX5FLb8PcGOBW5cImdiWRe7
 yyCcq6w+nPzRY3DTCvLt0TDSvmf3qp8p+xVignBxwMBsXuHaVpA4a7CVo/NDB1k=
X-Gm-Gg: ASbGncuGfgSXWWi/BO3JV49hiDLgrljkiADMfRiyp7y0GKg99xx4kvm9WhtDhm7L7Le
 h5R/5VP+OvNQb4AIAWMY5cYNOEdU8BCdmudMPsuPCMx6Rg8Kt736VDX/m8lE4DrBjM+nU3MUydS
 EOPg2KZnnpv+TR/7fqE28OI5nQnqciBi3leDiXWjAVHubQ7Nt2Em5V0EVYRIg3Exo7MiqdKvIcU
 kJ7I3vbg7wVtBkA+0wi9bljlX3FVKqAp1G0h3FJQlemv9gKqlr6UKF9ecg1JqodsfrtdeF8RTrG
 jiN+WrbFfknkmJoAwN+08kXJgokG/Tps
X-Google-Smtp-Source: AGHT+IFv0hfSYB67wyovVHwxih0a7b9k3zgc1jq5U4oEDjMmxDLzkYQBLjrEqYX2olLX2yGnWIIIbg==
X-Received: by 2002:a17:902:d2c8:b0:21d:3bd7:afe8 with SMTP id
 d9443c01a7336-21dd7e00b71mr181200665ad.49.1738341995917; 
 Fri, 31 Jan 2025 08:46:35 -0800 (PST)
Received: from [192.168.163.227] ([50.233.235.3])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f848aa0874sm3870306a91.32.2025.01.31.08.46.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jan 2025 08:46:35 -0800 (PST)
Message-ID: <62449bfd-eb65-41d6-ae53-0333bcb603b3@linaro.org>
Date: Fri, 31 Jan 2025 08:46:32 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/1] meson: Deprecate 32-bit host systems
To: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, stefanha@redhat.com, mark.cave-ayland@ilande.co.uk,
 Liviu Ionescu <ilg@livius.net>
References: <20250128004254.33442-1-richard.henderson@linaro.org>
 <9a280789-9248-4eca-b50c-048fc58e3f53@redhat.com>
 <87plk72tvr.fsf@draig.linaro.org>
 <ad6ca73a-c38a-4a9b-bdcb-ab50aa53ccd1@linaro.org>
 <Z5ii-ueFt5-5Brxz@redhat.com>
 <8c0eea44-d0bf-4b86-9b1b-1c2082ab2df9@linaro.org>
 <9bf6d4b0-7a89-4110-a1e1-46bbdb2fc793@linaro.org>
 <c13e207e-06a5-4f40-b319-f4f2e59d919a@redhat.com>
 <CAFEAcA_CfVfypS5yUtT3V34CDxmAqx7wYnDoKPfHq-o=54GgAg@mail.gmail.com>
 <8a54600c-ff3f-42dd-b164-62a57de867df@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <8a54600c-ff3f-42dd-b164-62a57de867df@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 1/29/25 04:47, Paolo Bonzini wrote:
> The difference with TCG of course is that TCG is in active development, and therefore its 
> 32-bit host support is not surviving passively in the same way that a random device is.  
> Still, I think we can identify at least three different parts that should be treated 
> differently: 64-on-32, 32-on-32 system-mode emulation and 32-on-32 user-mode emulation.

Why the user/system split for 32-on-32?

> We could and should remove 64-on-32, maybe even without a deprecation period, but the rest 
> I'm not so sure.  I don't know enough to understand their maintenance cost (other than the 
> mere existence of the 32-bit TCG backends), but it's certainly not comparable to 64-on-32.

Ok, lemme see how easy it is to prohibit configuring 64-on-32.

But I also think we should still deprecate 32-bit hosts, sooner rather than later.  Even 
if we have no immediate plans to remove them.  I think we want interested parties to speak 
up.  At some point this decade I want to be able to say: we've given you fair warning and 
time is up.


r~

