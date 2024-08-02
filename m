Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8915BC3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 16:11:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZurh-0002r6-V3; Fri, 02 Aug 2024 12:10:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZure-0002q6-CI
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 12:10:46 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZurb-0007n5-OQ
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 12:10:45 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5b391c8abd7so7754169a12.2
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 09:10:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722615040; x=1723219840; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=pCMyT+4RX2Ber53w8FL4O1Zeof1dTopndX83oDMWlmM=;
 b=StSidg4eAlSgBFmoBGY6YTf/nio23Qw+vnpRi6Z/dEvajw6XBVelrJVMMPN2iKL3TE
 lrZIacoiV/LaTaGtz9arwX19Vl8uCLkGZVu5A0P82H/2KoMDamHUrstf02aL0wa2KB6H
 DTzfSVXZX+mroxyVg4wKKr38S4fiDzps7EQpwAhLhJ6DdsWeeLQi/vJstPX44RTzr3f2
 bLXoyoFgLGAEbt/5aGKNn3T1EGdTW5MYGtwETAQJF63N5cdf4jiwcfGpP1cJnuMouz1X
 ay1k7RMTVLfBxBPy4H92eGFAVWO5olqMgnpw7IZmOFc864hcsOwhipPvc56zPVM0ic+X
 dIQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722615040; x=1723219840;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=pCMyT+4RX2Ber53w8FL4O1Zeof1dTopndX83oDMWlmM=;
 b=UIpUXAcrC3sK8tPVitAZIt3WQ3TWzpbeja+fkN45jW3vg1OET5RCSVBMFdWI3qbOeL
 AdfeShoJtb7Z1SBw71lONLDbOTctIVl2oN2GnkWa+NY1ezciyJ9l+Llbnb2froHq/ABP
 p+uGWbB7nlkoS+rK3LPYXko0u/EjRi79layaHOkbGkaNycksLjY+5XjtzdkjK4PCNTkp
 Ycsc71GTy8Edi9+IDdx/kTWg9vZCUtA1/lBsnXkNq9UjtXCp4keO0g8Y4C5tmfHqZ01p
 jaZk/uyZXzxh/CFqGNxLIk0kVSJy1dLPxa0LhcKlHimOxyQETx901kZwuEeiaHSUzemV
 IiQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsB0MiTGdcU5ev7tzAyFnYyWQj4cYQUa4KbKYxhTPi/cgaqL2SztMLgk6KV6cdqj3byUhycz0KOsKv/X2BOp7RAf17jwc=
X-Gm-Message-State: AOJu0Yw+UrmSZOBf5+mpLNVHtLx1VTooDzZx/Eeq7EWWxz1WofvOvQED
 ShfaTKoJS7kkVVP3zRkHpT8ddP4W2DAJaG/Xpxj48IeK3XIB+T6gQh5/J1hs+y4=
X-Google-Smtp-Source: AGHT+IEu/yq0Yqa9sQX0LrkoN9fC0yoW7VKbvAGj3DcrdDJSWpjqw9728sCN4MAIgX0u0wrP/A6dQQ==
X-Received: by 2002:a17:907:7b8a:b0:a77:cca9:b21c with SMTP id
 a640c23a62f3a-a7dc4e8c3e5mr337460966b.34.1722615039464; 
 Fri, 02 Aug 2024 09:10:39 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.211.94])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7dc9d4545dsm114721366b.124.2024.08.02.09.10.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 09:10:38 -0700 (PDT)
Message-ID: <37b06e6c-ed74-4782-8a47-5205d81e0a00@linaro.org>
Date: Fri, 2 Aug 2024 18:10:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 22/24] tests/functional: Convert the acpi-bits test
 into a standalone test
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-23-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240730170347.4103919-23-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x534.google.com
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

On 30/7/24 19:03, Daniel P. Berrangé wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Mostly a straight-forward conversion. Looks like we can simply drop
> the avocado datadrainer stuff when not using the avocado framework
> anymore.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   .../acpi-bits/bits-config/bits-cfg.txt        |  0
>   .../acpi-bits/bits-tests/smbios.py2           |  0
>   .../acpi-bits/bits-tests/smilatency.py2       |  0
>   .../acpi-bits/bits-tests/testacpi.py2         |  0
>   .../acpi-bits/bits-tests/testcpuid.py2        |  0
>   tests/functional/meson.build                  |  2 +
>   .../test_acpi_bits.py}                        | 81 ++++++++++---------
>   7 files changed, 43 insertions(+), 40 deletions(-)
>   rename tests/{avocado => functional}/acpi-bits/bits-config/bits-cfg.txt (100%)
>   rename tests/{avocado => functional}/acpi-bits/bits-tests/smbios.py2 (100%)
>   rename tests/{avocado => functional}/acpi-bits/bits-tests/smilatency.py2 (100%)
>   rename tests/{avocado => functional}/acpi-bits/bits-tests/testacpi.py2 (100%)
>   rename tests/{avocado => functional}/acpi-bits/bits-tests/testcpuid.py2 (100%)
>   rename tests/{avocado/acpi-bits.py => functional/test_acpi_bits.py} (86%)
>   mode change 100644 => 100755

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

