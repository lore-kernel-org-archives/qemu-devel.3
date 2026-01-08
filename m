Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F8B7D185C6
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 11:13:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdnwb-0007VV-U0; Thu, 08 Jan 2026 06:12:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdnwY-0007FY-2f
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 06:12:42 -0500
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vdnwV-0002nY-FS
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 06:12:41 -0500
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-432d256c2a9so258990f8f.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 03:12:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767870757; x=1768475557; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TBWieyjSjK6kUF+L1ENlfdWC1Zj92QFEivNqpA8mNPA=;
 b=QTueLOkc/D2SThHuJxuYywbyO/hgyRipdj0OxUCskU0k6twmBXoNyEZbehvdXd2ZdM
 LV05gB8Dy9DxHmaAB5LRWAgN+L6TOpA5mWdBUNYgjdV/vME8JWVtl79cyMqNRvFCqD45
 DQOzG+QMCpAwcWyU1pDNWloOpBrkPN4kD5lsw6XR/saO5c1m3udzOj4Y8J/VXTjt8E38
 PNKtiRop6pi6T2MJRNJ22kYjpvNs5tzrAXCO891WaCsm3NM9ZHVezAXTITIYg7JVh73+
 E/uY/C8DLRcI4AMMvPFN/cIxY1PDiqSjmkLWkvf7wuQnrz9c+kpALbBg143b4yvOqYkz
 aqtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767870757; x=1768475557;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TBWieyjSjK6kUF+L1ENlfdWC1Zj92QFEivNqpA8mNPA=;
 b=Iy14huX4g9I4Xl9eDv6ea26Jtifk/hXRsvFd0p02JNAqaqKa+nkJYaL5ooka2/dmHq
 U75wN9D8k4jMhcDVYZ+XTLLn4tWX5W9IxvCv36YLPpJXErN4Nul0Zki3lEj6K7RvyFLe
 ZiVF5cElbkBFzLeij3lyjsnWsABcweQZXzgt9TTB8jJ2lok2hK6M8/+p4PUPaNIH3a04
 CIs7PPrfK1n9NCVErrfAiOhWSSiZGxXUb5xFSpeTq8hE+TARxbRsA9wfbBUfDouvJnlx
 tbOpisVgKncZKJXqRaDnsuyHrkN5K+u6ggXQEUG834UC08M3N2jk6SRbdh7GfG0vhZdV
 5p8A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUVOqqS2EuxeyN+6JsJ7XrILot7Uo/l3f6iLwHF8kdUmvotOaSVtN/yjamrewIFA7k+Mkom/ff8kRaW@nongnu.org
X-Gm-Message-State: AOJu0Yx9c0SzhU/3ytv79l+x3g4faTUAASfgTjgwXJSkL1SMwsP5eWPC
 tfSsRYhDnRvm//kMd+CtLU/AwsOnyxMT6dxgj+HNPYm2dWHIKPrla9nqrc2Nkxlp3tkAfVIcKuD
 /vlpxwJA=
X-Gm-Gg: AY/fxX4D+w4fOB8qzBc1ct3I1PmNugdQfjfZZjwnfNnoDHsKa6dcTFwQ8+zeKwNdp1E
 dOSZvAqBZ4/CfvMKxaKiUIphdfOKtc6geavSnGox1/rXCQjGhAC6ME4dKYIpeqbqaYJSTBK5SZb
 5ZaWCWZ/kUbvz4O0BOxZcv+pxJNI30ImHkOFM6x4YLLVDfFpBahGKJRdG+EGH1xApS2FrRAXp74
 Tzd39wdmtvnhneGJCTfuvjzd8srYMRs0iD3v0eMDLp1hKwhOsyebxoX+uNbIt8TGrCXnW3UiFsP
 76FtGEvh9GFSpM/SJ1+Xjg4sacEJzw0XUDHNPXAVK7uRfOnTOu45Qs21saMjQWsxdyW//QAP4Ph
 Hms8YqkxgVRXz6pwh02OK/aqun5XmJONXZXWQ+gdEYEX+8A6doy3ympAYIuVYVQb4jMKisBs/q3
 sI2MRCTkaDsqRTtTcbFXukUoSPP+ha595ZsVcckCZdQnc0IPOnTbgW7tMdrVrPT4tB
X-Google-Smtp-Source: AGHT+IHR8kiGjChw4O7v2CV23EZ+g+HcsA39PvW9kc4HYL/EZ505jiIjAbNBQZF1evhjjZ8Qh4WCcw==
X-Received: by 2002:a5d:64e7:0:b0:430:f5ed:83ee with SMTP id
 ffacd0b85a97d-432c374f583mr6925089f8f.7.1767870757095; 
 Thu, 08 Jan 2026 03:12:37 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-432bd5feaf8sm15715001f8f.39.2026.01.08.03.12.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 03:12:36 -0800 (PST)
Message-ID: <e964263d-f5b0-410b-a17d-b49cd755d7fe@linaro.org>
Date: Thu, 8 Jan 2026 12:12:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 16/18] target/s390x: Un-inline KVM Protected
 Virtualization stubs
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>
References: <20260107130807.69870-1-philmd@linaro.org>
 <20260107130807.69870-17-philmd@linaro.org>
 <def072a9-bab0-44ff-919d-a294adc8e03e@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <def072a9-bab0-44ff-919d-a294adc8e03e@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 8/1/26 09:51, Thomas Huth wrote:
> On 07/01/2026 14.08, Philippe Mathieu-Daudé wrote:
>> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
>> ---
>>   target/s390x/kvm/pv.h    | 27 ------------
>>   target/s390x/kvm/stubs.c | 94 ++++++++++++++++++++++++++++++++++++++++
>>   2 files changed, 94 insertions(+), 27 deletions(-)
> 
> Please add a reasoning as patch description.

By removing the target-specific 'CONFIG_KVM' definition this header
can be used by files in meson common_ss[].

I'll update.

