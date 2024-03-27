Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04C5FC54E67
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 18:30:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpY1k-0006pk-SQ; Wed, 27 Mar 2024 14:29:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpY1j-0006nk-IN
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 14:29:31 -0400
Received: from mail-lj1-x234.google.com ([2a00:1450:4864:20::234])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rpY1g-0006xK-Rr
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 14:29:30 -0400
Received: by mail-lj1-x234.google.com with SMTP id
 38308e7fff4ca-2d46dd5f222so867311fa.1
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 11:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711564167; x=1712168967; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=N0/W6f6Y2HCbQrIuO4sgGsr5h7YeHtw7/e4Okdbq9Fg=;
 b=EDsEjk5GPVHJMijqMNEmjU0LZGk0iJTgyCvq07NUSB3MAsuDvxeA4IufaUky1F7ABL
 xxaL8ioD9IDixT6n6fsudmcbbXvLrqftBhs68OABMpU7bC42cBkgTmDNu+vNnrsJMngL
 cRfheMXbp1wbhvnyM2R/mdUO2JmyQlL3i9NPik3phjmv/QwUYf3FwDWG5wrSzs97420x
 KY5M9LS2LftbfI1yI/9DCHK7ccWMF3psplgbwXli6kYdSrJZ15YXg4yBV6mS7vD2tUh8
 4N4quanxXkbPLruVmX57dZoybx1ZhsXSg8PPHtjKGd/TxBmS8daBnJdv9stxOpcCXIgX
 Kkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711564167; x=1712168967;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=N0/W6f6Y2HCbQrIuO4sgGsr5h7YeHtw7/e4Okdbq9Fg=;
 b=uRID99UFPvcxVGK7OPXQUx74OKAy0N12HTn/qgHdS/EEhXXxDZkyQjrlSYkIdISu77
 WrAvUgetxDcxLCud0eBFol2SilwMbA/tqJQMb+V4TThu0rl0CATJp4kL/ZHCrmbjThym
 VcMzYXALDJ8WJSUDW8+yW1C+qY/w4O3yhqh2ZA6l4JdUh2XAXuoRTt8M5sbeJzpD3vq0
 +D9B9SGrfJzZJOLY+V2If6BAV81Rsy7pwZcnXDVbDhNrYyzU9j9WxuVkTcFj5JU8V4Rr
 iVAKJ5+nZcSMU4j62D8jNMiJ0FnrJM9w7N8F7rXNqWiqNRREN321mLwDgSjbDJWVeNdI
 4SEA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMXictYdBv8z1k0sW85R1HMJDiy2P8cwA1iy12955LbOWBaeIMBFPYtLqM3TPmQGnzMX/93ldG1VjCOVHqNuryfuE107k=
X-Gm-Message-State: AOJu0YySnaL4Gwrg96NAaD+CLmP8nkCwlbXj9jneOsGwhhgO/XHI5Yb1
 /7FXvFTcf1w425gAAqOXxeBXRWoDKlgRPZ3zAN/D390pnb9u7velzA9BkrQ9vHM=
X-Google-Smtp-Source: AGHT+IHyMeEd8tPsMXNgrRmVRP8aJhnObTqqBQrkzcIeBCHW2b1hpQhHmMi/XHY4KRqBWWf1MwW6iw==
X-Received: by 2002:a2e:8ed2:0:b0:2d6:a244:1ba4 with SMTP id
 e18-20020a2e8ed2000000b002d6a2441ba4mr559006ljl.33.1711564166578; 
 Wed, 27 Mar 2024 11:29:26 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.205.175])
 by smtp.gmail.com with ESMTPSA id
 r14-20020aa7da0e000000b0056bf31fa2a3sm5594948eds.80.2024.03.27.11.29.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Mar 2024 11:29:25 -0700 (PDT)
Message-ID: <aa691f0f-1146-476b-8879-25931f0878ba@linaro.org>
Date: Wed, 27 Mar 2024 19:29:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.0 v2] hw/i386/pc: Deprecate 64-bit CPUs on ISA-only
 PC machine
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>, qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, devel@lists.libvirt.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20240327165456.34716-1-philmd@linaro.org>
 <0b0c623e-b9f7-4178-ab2e-c89b109ea999@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <0b0c623e-b9f7-4178-ab2e-c89b109ea999@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::234;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x234.google.com
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

On 27/3/24 18:29, Marcin Juszkiewicz wrote:
> W dniu 27.03.2024 o 17:54, Philippe Mathieu-Daudé pisze:
>> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
>> index 7b548519b5..345c35507f 100644
>> --- a/docs/about/deprecated.rst
>> +++ b/docs/about/deprecated.rst
>> @@ -208,6 +208,13 @@ is no longer packaged in any distro making it 
>> harder to run the
>>   ``check-tcg`` tests. Unless we can improve the testing situation there
>>   is a chance the code will bitrot without anyone noticing.
>> +64-bit (x86_64) CPUs on the ``isapc`` machine (since 9.0)
>> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''
>> +
>> +The ``isapc`` machine aims to emulate old PC machine without PCI was
>> +generalized, so hardware available around 1995, before 64-bit intel
>> +CPUs were produced.
> 
> Can you s/Intel/x86-64/ here? Intel was not first with x86-64 (AMD 
> invented it). Also "64-bit Intel" smells of Itanium too much.

OK ;)

