Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 950F1FCC051
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 17:35:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyZ5M-0005rG-Ai; Fri, 06 Mar 2026 12:35:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyZ57-0005m0-SL
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 12:35:23 -0500
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vyZ56-0005DU-9e
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 12:35:21 -0500
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-82985f42664so1392990b3a.0
 for <qemu-devel@nongnu.org>; Fri, 06 Mar 2026 09:35:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772818518; x=1773423318; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=srTc2ADfMgquz1Z+Oo2OulhIsb1EYayo515U5LpuJoY=;
 b=SWoD0OG8lxi323ecQm9adb3FkIsgYyOlAoYnzxq+aQVwG1SPOGoPHeapbF8C7dVXSt
 CFYLZRv/pBmAqB4gPGcESpsximDDP0rw+iIgkvnQnlrzccLbPHCdQoO7GOGdnhOCJU9z
 d1PXyTllY5/dYM3jZXhHYVc/NyPJ793YJHcs1IVNLEjMiOkNobr6vczLVk3SDTN6w9IX
 PVq5RpUwivRuTH6eBBPaLE+9qSQd9o/SCIZvSUq1GKVs3v42bWiX9m40bZaLZHOfKwMK
 GfIIFZENyDj7jvxscl5rIa/oxVVVk7/VMSocjNZb7ry0hXQ9ff59zL+1OD/C8qv2QvEv
 PqdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772818518; x=1773423318;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=srTc2ADfMgquz1Z+Oo2OulhIsb1EYayo515U5LpuJoY=;
 b=giwFA6zOvx1zA5oiEZFihtt0ccAe2AgFjjVrt0jVKU3gaH31FhbXudMcYc/BwOe2P1
 GfqIwVsIPcX3DplpH0BrkCF6WBncuoibzn+8njXMLKM3I8JsMmhnC2yVySeQHcb2UYYp
 G++R2cg14Dx35QiVcBBhhXkoDUhr+AHZ//JRBpYjeA4q+8RYvTbxhwduRJksTw0sm9Mb
 AP4/PHXWPp3yaVUrZw2Zl68PZr35+4AuUmU4e0mwlHkqicOgjLHxBrvR7eQrXLl97I7E
 aS+Uv6r619FnVSWWk7FnT62SwVIxuPTTg1Zl2q0Y+4zDX4FTD6IJNPtuHvZZzQZvgjmz
 xYqg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVD6Fbxja4ZpaS8OB4oKyDRvqIHkqcNlMb3cE/1ODlx3i0oL/wY56s2UjqBHg9//2eejUz8kwii5edY@nongnu.org
X-Gm-Message-State: AOJu0YxAcQiH5lTQYAIu21RX/pHAbpZ6HEsjml5oF9g5DVRaWoPwz+RO
 D5g7nIJsQM6bU+sMLaZTDHFlfVtQCktgqP8NqPTe3Mu2hREC5ANAAsUtlUs9HwApL6Y=
X-Gm-Gg: ATEYQzwLKI+rGs+cJ1ndj1FPG7KTKWiBN4hs6xvABrDoOfqYaYS6Ln67Yo8uCjwR82D
 tKbl7bg2UYCCXY3vZ9u9tqdezeRg7ZAfZv9n5GeGIXcWOtZU50YNr+3pRdb8t5bwz7xWMsRvYqL
 EJabAMcO/vlzGn6DVIqlFeZlU75T7SNhO0ym4IxE6SuCOrItsHJ5iSHmANbpiL6mR2ENztD8YJY
 CWeyH2fDHtRwJ8oor55JdajZgwMIv6K0C1hr3+lwiyM2ZiGB1kVHk3h4F7+2/GjsOjWas/BVPSN
 PnidX0EpaKRRACyDEe+kf51m6F8btEtAhWdCp9n47QZBlHpyxBhJB86Dnu5fyDEwthTHTlfwcpB
 hKODpXP9bwZOqvm9YdQI45kAcajB8QfBLg0o0uS5HEHls5C1vaW/8BvbSjrWill1ipFL5rSJ/Ml
 pDFLPPM+ZIWoUFg4tnTBHceRtZ2eWiOBbiYdGWeo5n0eH4kyyDSiWvYbbaFkW5rySfIKaw
X-Received: by 2002:a05:6a00:3d13:b0:81f:50b1:51f2 with SMTP id
 d2e1a72fcca58-829a2f4a3bdmr2728719b3a.41.1772818517743; 
 Fri, 06 Mar 2026 09:35:17 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-829a4865c6csm2322046b3a.39.2026.03.06.09.35.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Mar 2026 09:35:17 -0800 (PST)
Message-ID: <d08b82bb-a1a8-4978-b7a4-0a695f873d33@linaro.org>
Date: Fri, 6 Mar 2026 09:35:16 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/7] tests/functional: teach uncompress about zip files
Content-Language: en-US
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Brad Smith <brad@comstyle.com>, qemu-arm@nongnu.org,
 Kyle Evans <kevans@freebsd.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Warner Losh <imp@bsdimp.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>
References: <20260306161728.2657486-1-alex.bennee@linaro.org>
 <20260306161728.2657486-5-alex.bennee@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260306161728.2657486-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x431.google.com
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

On 3/6/26 8:17 AM, Alex Bennée wrote:
> Yes people still use them.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   tests/functional/qemu_test/uncompress.py | 25 ++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

