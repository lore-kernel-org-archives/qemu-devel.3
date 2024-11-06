Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E998D59F55
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 17:30:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8jrN-0008H3-V1; Wed, 06 Nov 2024 12:30:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t8jrM-0008Gq-FE
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:30:24 -0500
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1t8jrK-0003xR-QV
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 12:30:24 -0500
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43167ff0f91so574985e9.1
 for <qemu-devel@nongnu.org>; Wed, 06 Nov 2024 09:30:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730914221; x=1731519021; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Tf718EOL74g/6nEJvDHdEh+2XawNqVleAO0KvRS5KgM=;
 b=JPO7q7aRM1F2wNiXTWDC1ZgettceNp73YSGA0exzgfS3VYiI+3PyHk8PolmxweylE1
 qvK1S0gxKZffb5tgEWqmXQKWUgks6crCaqL0XdvQkkq/cl5qjihPb45syXEkC0rN3Aaj
 sLzWrkVwD4HF5LOlQuejIeX6c2l8loN6jBkHReAhdeBsfDsLNQgNvuAMkZX22rMfUTH3
 t2Z8y39cOyRVDXmwdGFGjmOWB1hekQfkwYEXBZotEhcu2EKF39D6XvVz88qhm/t3NKEp
 sk/47lfpKZel9CYbILBGEd22OU71z489GGXVnq0xnMwnjSpRWZ9/pz3F85QR+GGLIgup
 GH8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730914221; x=1731519021;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Tf718EOL74g/6nEJvDHdEh+2XawNqVleAO0KvRS5KgM=;
 b=Z/Ck15bCg4b3f99xmu8mXA2V0qmuKIUBg1nvqaz61XNtHVxVTePd8qPmEj4flIEEhH
 ZCd5gAJtWPsVygstn2hGOUb56FlZqTf9ppdcPeZ9oZm10VblVRRtfNvKdTZIWXg5LFoH
 Th/4MDO+YbgwkSJ4TTiaOWdgUhrsErW2Oyfkm4s/oDoPkt/CESEyACqBYW3TdU9gYQiL
 i+SK7ZcYIzTpQtWiQShiojj5PXWh2UcH+UxXFsooqWXu5YE/WrBbXrfiFySodhxMVWyl
 tITStbqppA2HXQgrcfCpHUrrpZPIIYgArBKsa3S/6tX+6LRISwMrFlpSAjErA9s8tlp0
 JLPg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKIz75iq3a4Q+dZXtrrXM7dIWr21os9LGhAx2YFM3kODXsK09O8pHam3CMwS5xt/Ee2RyBaWGcMHQJ@nongnu.org
X-Gm-Message-State: AOJu0YxUyRxQRSswG7STIZvO/T7G0nQYlKAJx09RCiS+Y3TQ2ElBwLJo
 Rn/z5GtzXz+bhaN+BbBQ00LKKesVZbRShZwfBJm61VFx3R6YdiSCZRq5/lNrPGA=
X-Google-Smtp-Source: AGHT+IE410QssLHloXHAJy1g+UkoTtAtCwm0vSvBfEejZ5GtpsLU7NHzlTN5p7mlNK6HNceNuQPzbg==
X-Received: by 2002:a05:6000:18a5:b0:369:9358:4634 with SMTP id
 ffacd0b85a97d-381be7c80a7mr23462057f8f.19.1730914220994; 
 Wed, 06 Nov 2024 09:30:20 -0800 (PST)
Received: from [10.134.195.192] ([193.32.126.165])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-381c113e885sm19889621f8f.89.2024.11.06.09.30.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 Nov 2024 09:30:20 -0800 (PST)
Message-ID: <235c9cc1-aba0-4612-ba19-32885cb4b138@linaro.org>
Date: Wed, 6 Nov 2024 09:30:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional: Bump timeouts of functional tests
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20241106170946.990731-1-thuth@redhat.com>
 <c233a6b5-bfea-4d5e-9b1f-5bc3a467e17d@linaro.org>
 <CAFEAcA-MVg2EU2cKJz+drZp3=GBCPJXqbP7iNimg8fs0NYfhOQ@mail.gmail.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <CAFEAcA-MVg2EU2cKJz+drZp3=GBCPJXqbP7iNimg8fs0NYfhOQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-wm1-x32d.google.com
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

On 11/6/24 09:26, Peter Maydell wrote:
> On Wed, 6 Nov 2024 at 17:21, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
>> I noticed by --enable-debug in configure is a combination of enabling
>> checks (enable-debug-tcg + graph + mutex), and deactivating optimizations.
>>
>> Would it be worth keeping the optimizations and runtime checks instead?
>> This way, there would be no more "timeout" issue.
>>
>> I'm not sure which added value we get from O0, except for debugging
>> locally QEMU.
> 
> "Debugging locally QEMU" is exactly what --enable-debug is intended for...
> 

Yes...
but it seems like we take it for "enable debug checks" in CI as well and 
it impacts runtime, because optimizations are deactivated. I think I've 
not been the only one confused about this.

So my point is that we should maybe differentiate the two use cases at 
configure level.

--enable-debug and
--enable-runtime-checks (or something more explicit)

> thanks
> -- PMM


