Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 157CECAC5A7
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 07:26:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0avL-0004PA-66; Mon, 22 Sep 2025 03:25:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0avI-0004OH-Kp
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 03:25:20 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v0avG-0005XT-Ia
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 03:25:20 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4694ac46ae0so24743095e9.0
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 00:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758525915; x=1759130715; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Bnm4ipD6PNHt9FhJVm8A1AnhPEJNitWcoXVsEx0XDsE=;
 b=NqbWhLv5DESzkVT4NEw5VFZp149PE+M0BHtBJkggv+ongNlB7hPON392h9JliR1V1v
 w6KHB4EWDms1d9GRFSo4Z87q1p7CpDtYG38UUwQlKnqFqDTGlGDQxzMktX7Z47GO52HU
 oyGtZxGSHgP613NxkiCcIWz9F/cEtG4R7ALWu69EXooiscDwC/ZkaOTWsKfUzzGE0T6i
 j+aD3kEAO8atdRLis2YoLNsj31mcFusRovhV6HGuK/Wb3WGvaYQKXk/7kHfgINwEhXWv
 efH1J1D4N1ItG12QH+Z8BYwUBUzCQtN6WyYYPpP+bPE0oMKM1HLcuMlJ0DAQ/QMypm/e
 j97Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758525915; x=1759130715;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Bnm4ipD6PNHt9FhJVm8A1AnhPEJNitWcoXVsEx0XDsE=;
 b=xLIxA5FcCQJjrKks7Xa5zIQnBglY3zKXndHbp1ltzqM8fC9SsBmRyPlm4mmZ3An76Z
 Z6PnT8OEGrNUIp7Cdq/+Dw/MQyc88Yahd2MpSEpl5wV+Cn/0VT58iHrLQCXlk/P6jBKO
 zSaJv5XXyF75OpveFgR3515n7aBzXxfUwDhENG/wk1W0awSVwX5VgxEopBwf1UlJ3saH
 IhN38NUVSRgqLlQAbYRrYgRQt63WpYr6wCDLiTlMlGmMwyrAjUzZlpVfm4LzUgPj28jg
 cnchCzYejPOjCg7VOMIIME9QSj9btmWj2hgbuWEB0aL4RVLJaUJ/aiQ8ZzlqklAVTdb5
 KFJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNrx8Ke+Rl2Jo8TdYz10rea7k5bVEBfMjebmVJxAQQ/NPSy+piwB4RG9V6ZOXXsKuN7o2UwW90V2dn@nongnu.org
X-Gm-Message-State: AOJu0YwEDe2hisCUgsQkTHia5v1qbOmEJN7bLpkSluemR6Mm51qvmUnW
 JcM7nkwwRwRq9Rl+zhmY5zXciJr/B1pDjuBkk68mIsD3WfO6xaTLC1g4P2/ApI6sGZM=
X-Gm-Gg: ASbGnctf3j+EoSaBWz8aEKX0fgo0ek7fYHvgv8zBBrokid97A+ym9DM50G3tuwcfXOH
 ZA4B7U2P4Rw1+1+WPcOlPr8APCB9W6MOFiibmyJVR7idpJMeJwoM7uumrh6HMrP5BI5hNFbLUEB
 hDG/mQWXmrsuhQ4Gec/DBmGvqxgxRQD6scupHH5xCiP7fv0pzl5CQZFSEgL9t48nwPxsEP31bMW
 szEc4jbwrFRNrSI5H3/2V4HsIUhPTolYxfJAAgDrCrhCetzMxlwg+x6VDvDrpx89iQ2Vd3gkvSw
 EdNRlV9WcuVB5W9WYvkg9XYUOHnWYUtu70ZSJVR0Ymkhg6MH/RHm9wOtpVXKKNdKyQOEtns6asv
 GhWqUkYZNWUVWE9GzYVGdPrQW4WEtohF6n9BwsFdmaqxf4rWPwpmwBLOQLOtopybxWqbsktg=
X-Google-Smtp-Source: AGHT+IEq4uyStHzi8kMHWUgeUYnkuAeUyuevUdhY1bkv8Q6D8wcdK3QrSCL3liOH/90K8QHTeaCshw==
X-Received: by 2002:a05:600c:46c9:b0:45d:d68c:2a36 with SMTP id
 5b1f17b1804b1-467f0b4f285mr84373695e9.27.1758525914789; 
 Mon, 22 Sep 2025 00:25:14 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46139123102sm227900375e9.9.2025.09.22.00.25.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Sep 2025 00:25:14 -0700 (PDT)
Message-ID: <86c686a7-69b6-4d6b-b454-e28d699588cd@linaro.org>
Date: Mon, 22 Sep 2025 09:25:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/functional/m68k: Use proper polling in the
 next-cube test
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 "Daniel P . Berrange" <berrange@redhat.com>
References: <20250909074817.84661-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250909074817.84661-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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

On 9/9/25 09:48, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> The next-cube tests currently sleep for 2 seconds to wait for the
> guest's display to come up with the expected results. That's bad
> since there is still a theoretical race left here, and since there
> are two subtests, the whole test takes more than 4 seconds this way.
> 
> Looking at what the firmware does, there is a better way instead of
> blindly waiting for two seconds: The firmware is writing some values
> to the FPU registers during a test (and never touches them again
> afterwards, so we can be sure about the final values), so we can
> poll for the right values in those registers to know when we reached
> a state when the display is initialized for sure. We just have to
> also make sure to not look for text anymore that is only printed
> after the FPU test has been done by the guest firmware.
> 
> This way the whole tests finishes in less than 1 second here, and
> there should be no race condition here anymore.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/m68k/test_nextcube.py | 17 ++++++++++++-----
>   1 file changed, 12 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


