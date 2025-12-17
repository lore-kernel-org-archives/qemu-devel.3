Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C7BD3D66B86
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Dec 2025 18:42:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVwTe-0001jQ-HG; Wed, 17 Dec 2025 13:42:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVwTY-0001iP-Pj
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 13:42:18 -0500
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vVwTW-0000Vd-5M
 for qemu-devel@nongnu.org; Wed, 17 Dec 2025 13:42:16 -0500
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-34ccbf37205so1977790a91.2
 for <qemu-devel@nongnu.org>; Wed, 17 Dec 2025 10:42:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765996931; x=1766601731; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bCLOqGk+DqGS4lnyqYx0zF5KMa+Z9dDgqU4xiG8Sdqw=;
 b=wF962QRRxB3/UK6nPxF1P28fAexAfcqJzwd7pP/cdxhctRWL5klStowuq2qNLZaMd7
 By5zsybrA7rnPArpGQIPLa6/OVAF/Oj1yanncwTZzuikVSngHbTLjKgBGihIG/ZHZq+M
 EKUhrYj6O6zzWJNvxHUPmNS+GeR7xb9DSFTAEx4nurCeE1JW9fed/ewPim02AtiZWpa4
 X65v21KBNCvnxhP1hMTPbzXN6ArCqsk6SR8XNdR5sBtS14620hx/x9vMgwHmIi2UIxCD
 RINYtKf0kdZKitHzmZA3+OKcXvTEM6/y3jA8XAepmSUh/hvOo78JgNs5wLH1YNpXqgwi
 2fnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765996931; x=1766601731;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bCLOqGk+DqGS4lnyqYx0zF5KMa+Z9dDgqU4xiG8Sdqw=;
 b=EbhKY0ltc6BZL2OcfOkDGjTswQxL+h9n4WSi6vsdk3BoyMXU511PKtg3HuTQYoAYKu
 B6OL4tVan95skS2R354q0hsmLTZqi98RSqii5oOxgIsqm5jUCT6R+rVZxX0bYXErvR00
 oLsp3eysK67JykvXG5+ZCe4YCoycEUhkPtMC6NbKPUkb2qkqMh1/uI0EJMj0enRfBcNc
 47hD+JH5EtpE4uQr7gyzxK5LHsRoE7dp2baboiOYS4R6sYFdkHNFhXXUfmVNg7HBnYHb
 3vVHqemhs/mNu7+cerhKN0871xlhyZR01xHscAcFMPQR2Do6zs1oKaBcwVW29aZXIjpt
 Avew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUL3TVtdVX+txqtdcxMF5mtwrCSXEPC2WIos4WelQwh7funTdOTD025k0uOq0OJlaD5ylhZ/XhjgnyE@nongnu.org
X-Gm-Message-State: AOJu0YzO694krHUuNisq10/xWHzRdwTWY2ZgyR4R4atCtb2HtzrdlxkX
 gCX7cjKEoTi+8ZAQJE+aw86JOvu2sErLnszyrQi6IW7hAkt1ffQtdKC0+jg13+2+uCY=
X-Gm-Gg: AY/fxX4xSGngr7PEcXDgnFWFHkB/Q/0U2CTKdjlNhZ1eIrQ1qJ9kgsuir4QEceC/zDj
 03c2rujVw//tdL+XGuAfPMRU8xrBEngrGBA3YXDJYTwAT89A3HfZXnfD27w8qbavPv4CMsZv9QJ
 YATS3J2UHcaVdBgnM3ro3ePKmIq1qzDE/CHNYxo749GepLDAiuf8IW/6fssycMcJjM5MFsQzhk0
 loswETH5eUIXiZ+ospCE3M0kAojnBzTnITd629QaLLPGUm66ps8QyFEe2NGB/osHhjRJsy0LGE+
 XQuB0u9V0X/EMqKAv/EDqB5iHi2TD/COdkNqCn6tU1Y9VYQJqLl5FESZHAycfbvibR6hlabUD4u
 RChz18E07KF3lMIPBSrN3Uv+nnASN7LlnFpCBUIa7NvtqUQ6NXMckkFstdgaHfku28eNA69okO/
 oVHzOUj+L3OCZG/1cZuQ4XC2uhKGESa3N6eKi0UMbj6HslcBB39LKF+Rcd552q/LZfsw==
X-Google-Smtp-Source: AGHT+IE+hJuZUAr9FNfNlaGSwdmEPfnJAVWA2YAzD2N6stJBQ8tFeVPlqzJdZ4KWK9RZbrrarjZmZg==
X-Received: by 2002:a17:90a:fc45:b0:340:e8e9:cc76 with SMTP id
 98e67ed59e1d1-34abd7bf1femr17806567a91.11.1765996931254; 
 Wed, 17 Dec 2025 10:42:11 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34e70dbd618sm272674a91.12.2025.12.17.10.42.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Dec 2025 10:42:10 -0800 (PST)
Message-ID: <ecf4d522-027e-4ca9-a571-9aa46cff14ad@linaro.org>
Date: Wed, 17 Dec 2025 10:42:08 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/14] system/physmem: Inline and remove leul_to_cpu()
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 David Hildenbrand <david@kernel.org>, Peter Xu <peterx@redhat.com>
References: <20251217143150.94463-1-philmd@linaro.org>
 <20251217143150.94463-6-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251217143150.94463-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x102d.google.com
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

On 12/17/25 6:31 AM, Philippe Mathieu-Daudé wrote:
> leul_to_cpu() is only used within physmem.c: inline it
> and remove.
> Since @bitmap is of 'unsigned long' type, use its size
> with ldn_le_p() instead of using HOST_LONG_BITS.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/qemu/bswap.h | 11 -----------
>   system/physmem.c     |  5 +++--
>   2 files changed, 3 insertions(+), 13 deletions(-)
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


