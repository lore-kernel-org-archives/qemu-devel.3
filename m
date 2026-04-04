Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A307FE63FFD
	for <qemu-devel@archiver.kernel.org>; Sat,  4 Apr 2026 22:32:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w99Wm-0001e6-Bw; Sat, 04 Apr 2026 18:31:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w99Wg-0001dn-FW
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 18:31:34 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w99We-000607-G6
 for qemu-devel@nongnu.org; Sat, 04 Apr 2026 18:31:34 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2ad9a9be502so18927495ad.0
 for <qemu-devel@nongnu.org>; Sat, 04 Apr 2026 15:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775341886; x=1775946686; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=50H8KlSjOPbpsPSVOBB8KOpM4xXhtXmjg3XOCNkYTV0=;
 b=D5MQpWUu1w8liPDGJy0Ti9fuyh1Kx3A0OsuYg3Cyp8fNybbM7WGfgC2je8ToPPLRGK
 IhQ12YSsted8lT8B80CCOslqjHniIkfNpVEy1I17uQmhSEUNPzvgKacx/BogrsQP3onn
 noSueTZnI6XE2NuzHqbkAzsLWK2Z4KqtPE1O692HCrxtJ/pTvvM5E/sNrycw8X9Lq5Ub
 VdoT1uF6mBRF7TrDtmXUZGlkZLEzQq40AA5a+RmdkcZH8r7oMtahjFAVBMBY360s9Rgb
 yRMnZsrN+4T7Vgj1RI2IhE8zAkBo3tVdq6pbUCEkUjt1NCoTSuVujwNqSWPf3332J+cQ
 YQgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775341886; x=1775946686;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=50H8KlSjOPbpsPSVOBB8KOpM4xXhtXmjg3XOCNkYTV0=;
 b=MRiV5ORfiFMZa25wRJJ+R5ptjS9csXHSJwdJcuOuHxBIIAiyg+uZpSZ8Sg+iYjSH56
 P8XGa3JIxFBk/9slY28KtZHdd7bymEWxHT9CUlhbKtyGJffokwWrCf0tzJwNJP1qybJD
 GlZaV4T9qd4dzBKM0iowpUMV2ZncFzgHKwjnu2I5GZ7TRzwPJH8LzEQkmqJh0aKiOEI1
 L6n7svmUyC+tn21zYJGkGiX3eoBp6pHec4Gmkpz+XENJ/eNUtgt82LIjrzVtbWYiy6FD
 9FvB6B5EAyb3w7btyCye+O2CN0kYBY2bl34oW7q0ozEVqUYPJtIlLAEkNHjEHYqxjjK+
 8a7Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVGZthV2yUbC+MWJvXQBac5n0t43FjZmkgDseHQcamIh6zybB+I5Suvsp4AUMwj8GT8WV3xSkEsIKK9@nongnu.org
X-Gm-Message-State: AOJu0Yykpx4dIphWWvAiJlSS9+nyHzjbOOnoUiPS6NlSjdPY/srekAPg
 7oP7EtyQ6Lh4roEhATOoTc3wUMbQfazlpf1b4wBWyeChf8k1AmEP6AzlWjMSN3Z1V7M=
X-Gm-Gg: AeBDietYJE37Pp0HWIYTSX9+NTDbA8rz88GcOz7TENaI8zoTRFdrTm6c4hwU89rYhST
 fHB/mkRdeO8gfyih+MsjQDNb2atpBOiZkxUhP0bnC+5Y4Svx4F8cHjEwKYrhF2STONyYk3z1aR+
 qT0pMfZfmiePtrd9bjVc0IVulTpcENWivyQjrLXgJ+OIpf25lnsOLqGEHON3YZd/bBhftZJQm8l
 l4N1JLpoAw5CvXKvxxE3iqxDwd1Axzzj4Vc7SVqyEZoZvM6U6gBZtTDi395KM4QIualA7/Jq4i/
 WYOYcXkeVptCM8zyc7O9dpaPGqSj8NrXzxMueoJTVJTXWvhBYzGCnOuNLjgdVMgV8xhoJOM/1CD
 QxqclxcWAwBYAgTeZxnQmT/uhIAzbnaXlYDma6HiC4RE1u2uLv4tKQH4sgIpfIP7FKd4IB7rr7s
 zNkqWHTUV9o1JkJ2r/BFJyV4B5HNBHcqqaz6mEBAFGTXTY/5wXvCzCa5sy0d/zXUvMAgg=
X-Received: by 2002:a17:903:4b28:b0:2b0:6829:9414 with SMTP id
 d9443c01a7336-2b2817070dbmr74160815ad.8.1775341886008; 
 Sat, 04 Apr 2026 15:31:26 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b27472d1a2sm101636225ad.7.2026.04.04.15.31.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 04 Apr 2026 15:31:25 -0700 (PDT)
Message-ID: <209a6f85-7136-4599-b4eb-0d5a03e1eb0c@linaro.org>
Date: Sun, 5 Apr 2026 08:31:19 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] [PATCH v2] Allow building qemu tools on 32-bit hosts
To: Helge Deller <deller@kernel.org>, qemu-devel@nongnu.org
Cc: deller@gmx.de, Michael Tokarev <mjt@tls.msk.ru>
References: <20260404061215.505913-1-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260404061215.505913-1-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 4/4/26 17:12, Helge Deller wrote:
> +  qemu_ldflags += cc.get_supported_link_arguments('-Wl,-latomic')

You don't need "-Wl".

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

