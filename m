Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2C43D3C92D
	for <qemu-devel@archiver.kernel.org>; Sun, 20 Oct 2024 18:47:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2axW-00008a-3C; Sun, 20 Oct 2024 14:47:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t2axO-00008D-2D
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 14:47:14 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t2axL-0004xp-S7
 for qemu-devel@nongnu.org; Sun, 20 Oct 2024 14:47:13 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-71e4fa3ea7cso2946798b3a.0
 for <qemu-devel@nongnu.org>; Sun, 20 Oct 2024 11:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729450027; x=1730054827; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=K0rgne+RllSD4dCojokc08O6fyLjqxPDouNOsGVSJrE=;
 b=YFFcsljjM/NGW691gQrmT+24UedCw/xg7rUhfHh01B2K2HpdBSGnIaGs/lbnAvk16u
 Urx/amqDZV4Xz9Sm7hukvjE8xb7ft97ci6xMh49ZTZOyM9/TpswbLTmI88YPue8xB12M
 UygTtHNyPJLm/m29/nwbCShhn9EVoSI0TRS4TBg56jET9pAN4Kv0P0wOBgf1EHK9EYKA
 brlzAxBo1jJ1kBJfdXxSFAh96mrjKbsFrQI2odbxwN3SFYSXoBUc2/yBf8+vWDHc0Ah/
 JGIjUmRUNVs9WNKBEzMZXm3ujxRSDSwsPYmDsFrvXct/jW5ipbx1INAltw+eAdgt7OiM
 olyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729450027; x=1730054827;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=K0rgne+RllSD4dCojokc08O6fyLjqxPDouNOsGVSJrE=;
 b=OdGJT4DcWp2T8BhODpOc9Vu5FXpLbHJ4u/GB6ViL9HngpmEhQhzMlRtw5MDvJGla80
 /ExdvA3zTyBq+8Ptr31iA5aE9cYdrsyM0rF82zBm0dEv1txVugq0vFzDDiQkHWmkRY15
 L+gFnpU2QxN9eai4Y7vlPM6XbtJHHiYRMlexhmm9ybOITGJ0eCW0PQ6QSRqCIeEPr/+D
 y5VoHM9qrAIVp/d4TVpyOk6Nls6FBMLllNQgGZDWFFsvYrrh6jLts4YVwPue+8Om/wMX
 fUYYhLk1XNRLTRE3X60XqgkC7bTsJ/USTEQTYP+cdrC5CjggDh6z3VOtdK0Gy1gDBX1q
 bFfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV0CpJ9GhEXD7+G/nH3ASeb/PnluOI62YwvIH/kyOp7yCJudsWNSH2dWGHnnC5L7jez9HAMIAq94xcG@nongnu.org
X-Gm-Message-State: AOJu0Yw12ol8b/5wrKuNcaWEOPF1YvRN6GeMjjuxrqdD+4DKNEwMpG+c
 tx/4nTsM4Tny90LkNeKzF7CX4KvyUnMPJBETj+oAk+3Yh90hBIg8KEwnO5fy0ikstdtUBW+QZBX
 L
X-Google-Smtp-Source: AGHT+IEKJ2tZYebKlsmIfal4MlXfWP2VdJ72brsGz4X8tn78fB0n6xx0/1+LKeIcGrc9RV2fJRuazQ==
X-Received: by 2002:a05:6a00:140c:b0:71e:cd0:cc99 with SMTP id
 d2e1a72fcca58-71ea31a57famr13485118b3a.4.1729450027298; 
 Sun, 20 Oct 2024 11:47:07 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71ec1407da1sm1443694b3a.191.2024.10.20.11.47.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 20 Oct 2024 11:47:06 -0700 (PDT)
Message-ID: <9aa82e51-8330-4be1-89ea-bcfadcecea29@linaro.org>
Date: Sun, 20 Oct 2024 11:47:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Qemu v9.0.2: Boot failed qemu-arm with Linux next-20241017 tag.
To: Naresh Kamboju <naresh.kamboju@linaro.org>,
 open list <linux-kernel@vger.kernel.org>,
 Linux ARM <linux-arm-kernel@lists.infradead.org>,
 lkft-triage@lists.linaro.org, Linux Regressions
 <regressions@lists.linux.dev>, qemu-devel@nongnu.org
Cc: Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Aishwarya TCV <Aishwarya.TCV@arm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Anders Roxell <anders.roxell@linaro.org>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Geert Uytterhoeven <geert@linux-m68k.org>
References: <CA+G9fYt86bUAu_v5dXPWnDUwQNVipj+Wq3Djir1KUSKdr9QLNg@mail.gmail.com>
 <CA+G9fYsMg0fA-jraEvC==0a-22J97o-uBmbLJt16_ZKBpOT8EQ@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CA+G9fYsMg0fA-jraEvC==0a-22J97o-uBmbLJt16_ZKBpOT8EQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42c.google.com
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

On 10/20/24 10:39, Naresh Kamboju wrote:
> On Fri, 18 Oct 2024 at 12:35, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>>
>> The QEMU-ARMv7 boot has failed with the Linux next-20241017 tag.
>> The boot log is incomplete, and no kernel crash was detected.
>> However, the system did not proceed far enough to reach the login prompt.
>>
>> Please find the incomplete boot log links below for your reference.
>> The Qemu version is 9.0.2.
>> The arm devices TI beaglebone x15 boot pass.
>>
>> This is always reproducible.
>> First seen on Linux next-20241017 tag.
>>    Good: next-20241016
>>    Bad: next-20241017
>>
>> qemu-armv7:
>>    boot:
>>      * clang-19-lkftconfig
>>      * gcc-13-lkftconfig
>>      * clang-nightly-lkftconfig
> 
> Anders bisected this boot regressions and found,
> # first bad commit:
>    [efe8419ae78d65e83edc31aad74b605c12e7d60c]
>      vdso: Introduce vdso/page.h
> 
> We are investigating the reason for boot failure due to this commit.

Probably fixed on qemu master with

commit 67d762e716a7127ecc114e9708254316dd521911
Author: Ard Biesheuvel <ardb@kernel.org>
Date:   Fri Sep 27 09:10:51 2024 +0200

     target/arm: Avoid target_ulong for physical address lookups



r~

