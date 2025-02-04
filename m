Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C152C02194
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2025 09:51:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tfFaK-00082i-LE; Tue, 04 Feb 2025 04:51:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfFaJ-00082X-0w
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 04:51:11 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tfFaG-0004Q9-Bb
 for qemu-devel@nongnu.org; Tue, 04 Feb 2025 04:51:10 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-385d7b4da2bso4821650f8f.1
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2025 01:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1738662666; x=1739267466; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zHTiKGciijEmOOrMPs2vI15Mn9KBYN9ZOQdMuU5NI3o=;
 b=g1H725uJnN7lcF/ExWHKUxy60q63M6D/g+jHU7VuaGIe//v7yvudU1QdSr7ZLWgJmg
 DKoJBdi1qLfC+n1ycRPIvcC6CYaTqnyzB/jvVrNCV6WZHLSck7+XPtYENr3dWYMNLNj0
 fl/WBHsftWcUPDDdRgS0H67QX6Jd1jN1OIpxiKQrwVUb4zipkAzXzz0YV5jx1tuFKAa3
 fM8Y5J7FBNG+kBhS/2wrH47A3HIa9F8JXGhQvB4yKEC/RTk/+Qc3lHwcYOKBRiTxQFHd
 kLD57IARe6NksKNLrp9r/zNrZXivFOSuMEUOCI/8F18x7+XZrs5BGIfQYevh46mbHXHn
 YHAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1738662666; x=1739267466;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zHTiKGciijEmOOrMPs2vI15Mn9KBYN9ZOQdMuU5NI3o=;
 b=bzpW9b5z98VHihnkx7n1l2xuokLLolWkj0qDn/tHgva6pzHs926D3H6StbvsfcSoK2
 QQMD01rmOpCNKt7Tu0o864oGlWVhajCJEEnxoRfrmDTtfNneuUovum0AUs6y0C/vmX82
 SQ785HAV7DSqQ1v1wuvw1pWxhOg4cN16rvTCldq2FAcUPt9Bg3FH41hhvBvtZHEv8XAJ
 RCr6PG/hchgXO3EA22aW296YAJ38qkdTqUwU7blPIVpuERtpuuwp2vtSxYshmUB3EVod
 7higBMggZmHKlPBokE4Up3y7i4gFSStLU5kia3hvdgQ6zRby/lyHy3cCsrvHHudgjRLg
 QItg==
X-Gm-Message-State: AOJu0Yy4f2fDMboIm+1skbSb9ynrrNhPSHb0QjG9Amdo9VY3Nv01xHog
 AKfNEywJ9+I1SHS8s7lF1qlYAnoKeFNZTh8gFVc+5TriQ2WMA85M6DRw6btfMa0=
X-Gm-Gg: ASbGncugRuO9D56jHuZAhFOxNZd8ilfpoX3IFFg7gYNy0XhfEnqyzHocTIK60mvUfeO
 SVq8h61nrr+rJj1p59hvnfoBBETv8qMVt74cQsZfyqGgrKJGdIX8Ryia5QFQ3uH7dbOrV8XV9Cn
 +THldr0ty8O5H84BuHHiQaaJTdadnRyyj5W1ExHEP8UAGnbYp01kV+BhbcShcDK4iNo6vKZRkdf
 34s2hfkYYcG3+VZQaGET6K6VSFlNNmPcRg8/1L+hibutEh/JlfjfXQMtEny2gUpT/67IvaZQd46
 oUQS1BZF7HZgkTQNrI7Orn4tsU+HKtJMa6OLhyq+EP5FSc74B4gt/A==
X-Google-Smtp-Source: AGHT+IHsjir6Y1YP0vKuYkcSeYGJbHjfoOK+M+2YiB12ZURwGXwSSIIDmRpizXJCbMttApG1sErjwQ==
X-Received: by 2002:a5d:64e4:0:b0:382:3959:f429 with SMTP id
 ffacd0b85a97d-38c519378b7mr23839129f8f.5.1738662666550; 
 Tue, 04 Feb 2025 01:51:06 -0800 (PST)
Received: from [10.53.21.213] (88.171.88.92.rev.sfr.net. [92.88.171.88])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38da1a11f16sm4235694f8f.14.2025.02.04.01.51.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Feb 2025 01:51:05 -0800 (PST)
Message-ID: <e32a54f2-ef46-4964-89d4-a8969b6d1b05@linaro.org>
Date: Tue, 4 Feb 2025 10:51:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/12] hw/arm/raspi: Deprecate old raspiX machine names
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, BALATON Zoltan <balaton@eik.bme.hu>,
 Laurent Vivier <lvivier@redhat.com>,
 Ovchinnikov Vitalii <vitalii.ovchinnikov@auriga.com>,
 Jared Mauch <jared+home@puck.nether.net>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 devel@lists.libvirt.org
References: <20250204002240.97830-1-philmd@linaro.org>
 <20250204002240.97830-12-philmd@linaro.org>
 <CAFEAcA-3JJ1tZAXsik5hAonuSO9sCqDF1xqPQVhAeN-XwAAhDw@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CAFEAcA-3JJ1tZAXsik5hAonuSO9sCqDF1xqPQVhAeN-XwAAhDw@mail.gmail.com>
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

On 4/2/25 10:22, Peter Maydell wrote:
> On Tue, 4 Feb 2025 at 00:23, Philippe Mathieu-Daudé <philmd@linaro.org> wrote:
>>
>> All previous raspi machines can be created using the
>> generic machine. Deprecate the old names to maintain
>> a single one. Update the tests.
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index 4a3c302962a..c9a11a52f78 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -257,6 +257,19 @@ Big-Endian variants of MicroBlaze ``petalogix-ml605`` and ``xlnx-zynqmp-pmu`` ma
>>   Both ``petalogix-ml605`` and ``xlnx-zynqmp-pmu`` were added for little endian
>>   CPUs. Big endian support is not tested.
>>
>> +ARM ``raspi0``, ``raspi1ap``, ``raspi2b``, ``raspi3ap``, ``raspi3b`` and ``raspi4b`` machines (since 10.0)
>> +''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>> +
>> +The Raspberry Pi machines have been unified under the generic ``raspi`` machine,
>> +which takes the model as argument.
>> +
>> +    - `raspi0`` is now an alias for ``raspi,model=Zero``
>> +    - `raspi1ap`` is now an alias for ``raspi,model=1A+``
>> +    - `raspi2b`` is now an alias for ``raspi,model=2B``
>> +    - `raspi3ap`` is now an alias for ``raspi,model=3A+``
>> +    - `raspi3b`` is now an alias for ``raspi,model=3B``
>> +    - `raspi4b`` is now an alias for ``raspi,model=4B``
> 
> This is not how we typically handle "we have a bunch
> of different devboards in one family". What's wrong with the
> existing set of machine names?

Zoltan and you don't want to add more machine names, then you
don't want a generic machine. This is very confusing.

See previous patch:

   $ qemu-system-aarch64 -M raspi,model=help
   Available models (processor):
   - A          (BCM2835)
   - B          (BCM2835)
   - A+         (BCM2835)
   - B+         (BCM2835)
   - CM1        (BCM2835)
   - Zero       (BCM2835)
   - ZeroW      (BCM2835)
   - 2B         (BCM2836)
   - 3B         (BCM2837)
   - CM3        (BCM2837)
   - 3B+        (BCM2837)
   - 3A+        (BCM2837)
   - CM3+       (BCM2837)
   - 4B         (BCM2838)

Can we or not add the other raspi models?

> Can we implement "support more than just the fixed amount
> of RAM" by making '-m 2G' work, without changing the
> machine names at all, please?

We surely can if we find developers motivated to do the work.

Regards,

Phil.

