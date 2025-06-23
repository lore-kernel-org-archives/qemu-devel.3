Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDBC6C7115B
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Jun 2025 12:00:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uTfpn-00044h-SB; Mon, 23 Jun 2025 07:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTfpm-00044F-9b
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 07:59:34 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uTfpf-0005re-7w
 for qemu-devel@nongnu.org; Mon, 23 Jun 2025 07:59:33 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-3a4fd1ba177so2599893f8f.0
 for <qemu-devel@nongnu.org>; Mon, 23 Jun 2025 04:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1750679965; x=1751284765; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZNl0GNUoL+pUzh6aZuBV7rBwC2JelgKVfHJY1PQe040=;
 b=sEl3dQpogD4Ig1BvAOtVDwLyRJQCfaPEHko9SONaYPqhq2ktlvrmG5PeLZVp96+NeH
 3gcoFyop6mT6QhkaIAJeWLAp7o6QlFH24zM3f1mHf2fBYt3cki90uzLA879LyAhUyixA
 aJfQIsEQ1OPPkLPjIlNJWPrJ9W37IlqBI6Ffb10vkofNN7nf267wbSBxmnL5XfQaxU4V
 F01lfXimTfhk7jFHcggd3DZNCfP0zvoug/TKLaSzzD0J0Ao5jSuFW27W1Cs6OLp2V5na
 wyuJ7FyH0DhaoCMksPbP1yyMlTaRjeZUNW6CzD0epAwDZvF5xtacVF1EIFI75g2fvaKx
 DOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1750679965; x=1751284765;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZNl0GNUoL+pUzh6aZuBV7rBwC2JelgKVfHJY1PQe040=;
 b=YFk2qDBeVqic8SrqIo2cT4sw/wINm/HqWAy0EeFOz6uBILnpVmnzLDVFD1Hc9y1qkq
 aB4nKI88XsDA0lEcxoMH2ngupYATSI6bE0wwjMCqwtf1ts3Sg6SVEnDjrG/KcPS358t2
 KYTjq0mln7N8fo++gxCKvtXyefACSBT7ByyloZRDdcyg4Q1wcFe7ecJX2bsNvOUpcxAU
 OSWruUXn/+YuRPNvtEPPxGO3CGXo2WswCau4S5HuhDm3vM7dDjgYxXQkzjdLN6iH11DS
 beQgciyCfqfrgwmFwVe30E+p8ogYIy0mHTVDFNcJqVTLKZcZRmqbeuaYNvlE1vsIzgEq
 c6kw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKuVXazi4nuRRfBRHRnj849+1l3jEedvYqyG66NbCALQxTjzeDKjWPn/vD9B4nT+xPKfNUA/H9oGVG@nongnu.org
X-Gm-Message-State: AOJu0YxjSrfuDlscXkDfksKFS/VtoldF08LEng9pVuuJhyAyZjkEBzrg
 vLb1bO02JQUWXo5WzyzOR+nIO9hb8HCD6regexyA3Ed2eFx/86kcj2caOwCt7RaPHUA=
X-Gm-Gg: ASbGncs89UQVu8bRuw/V2hEnuOva/TxaZwwdO+Pl9K6bLWuKyG+NTuVsuGfO3LfEysU
 Z7pojFIdL1Q4K1LnbIbDK6faarJpTD8+OX8YQ6Q5nu8U42+Y/RbZvT02F7jJuqS2CeOWKZdfSob
 TYPJxzWHH6XyXKGgiB93yCtEDqEGe2sV4+FE3V4mcULsRF3DBj24DPrdIRYu4TFEW/cj+pJLEaR
 Z0latoFC1SmgQXEaasrLDr34aS8JW/IpyHbWcZpr9tdqwUqDjIn2uDgum6xRckZ0A3ANZ4Lxw/V
 4H8uevX/TNcaT9m6hDBUGDYSRBtrQrGZAuXwj1Ym1oF7DZUfvuP+FaX7+TeGTSqxvqffi8x1q3q
 DR8p/ajSyfYeLDSUDeUlMzB6IfQF2ZOIUZ+eTGIq3
X-Google-Smtp-Source: AGHT+IHOxtkdXSM3EMBB+rtXAYT6HLDRhKe1XTMmCY2e3R+6NO7I2w8zqwom52rHbrwAtgyuUqWVsQ==
X-Received: by 2002:a05:6000:2010:b0:3a3:598f:5a97 with SMTP id
 ffacd0b85a97d-3a6d2799df4mr8969438f8f.9.1750679964791; 
 Mon, 23 Jun 2025 04:59:24 -0700 (PDT)
Received: from [192.168.69.167] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a6d128cf7asm9177773f8f.100.2025.06.23.04.59.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 23 Jun 2025 04:59:24 -0700 (PDT)
Message-ID: <be71c7cc-a5ba-4ba5-b697-60814b712eea@linaro.org>
Date: Mon, 23 Jun 2025 13:59:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 23/26] tests/functional: Restrict nexted Aarch64 Xen
 test to TCG
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>,
 David Woodhouse <dwmw2@infradead.org>
Cc: Leif Lindholm <leif.lindholm@oss.qualcomm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Radoslaw Biernacki <rad@semihalf.com>, Alexander Graf <agraf@csgraf.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Bernhard Beschow <shentey@gmail.com>,
 Cleber Rosa <crosa@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Cameron Esfahani <dirty@apple.com>, kvm@vger.kernel.org,
 qemu-arm@nongnu.org, Eric Auger <eric.auger@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, John Snow <jsnow@redhat.com>
References: <20250620130709.31073-1-philmd@linaro.org>
 <20250620130709.31073-24-philmd@linaro.org>
 <497fc7b1-dfd2-49ad-938c-47fca1153590@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <497fc7b1-dfd2-49ad-938c-47fca1153590@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 23/6/25 10:11, Thomas Huth wrote:
> On 20/06/2025 15.07, Philippe Mathieu-Daudé wrote:
>> On macOS this test fails:
>>
>>    qemu-system-aarch64: mach-virt: HVF does not support providing 
>> Virtualization extensions to the guest CPU
>>
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   tests/functional/test_aarch64_xen.py | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/tests/functional/test_aarch64_xen.py b/tests/functional/ 
>> test_aarch64_xen.py
>> index 339904221b0..261d796540d 100755
>> --- a/tests/functional/test_aarch64_xen.py
>> +++ b/tests/functional/test_aarch64_xen.py
>> @@ -33,6 +33,7 @@ def launch_xen(self, xen_path):
>>           """
>>           Launch Xen with a dom0 guest kernel
>>           """
>> +        self.require_accelerator("tcg") # virtualization=on
> 
> What about kvm (or xen) as accelerator? Would that work?

IIUC this tests boots a nested Xen guest running at Aarch64 EL2,
and at this point we can only run EL2/EL3 on TCG. HVF and KVM
can not for now (we are working on it).

I don't know if Xen can accelerate EL2, it would need support for
such hardware (like the Apple Silicon M4). Cc'ing Xen folks to
figure it out.

