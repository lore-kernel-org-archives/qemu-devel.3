Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6109AD6A228
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 19:38:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBfef-0002Be-76; Thu, 14 Nov 2024 14:37:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBfed-0002AT-V2
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 14:37:23 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBfeb-0004qP-CB
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 14:37:23 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-20ca388d242so11254615ad.2
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 11:37:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731613039; x=1732217839; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=h9VScUMDwExPnRl1LaPrf3ik6OlripIhAnEXmb6tN0g=;
 b=Y7d/kAfhH9P0HpypuOBgAl3C0d05pou4haOukoZqT5X6AXaiX15QYAZu/7gnoypA9S
 BJWKmAgqPKypjzaPUQX3RwgHJBwwnMStGOLeLcJXuB2IRpYuQhKDZETotOJXVV4B3kdS
 Cj95eQUzvA6QvpL/WwEnOwXlE6JcVx7514jgDDsJJhryjMlAHSthGJzOG7NcWK9Ki6VQ
 zvA/l/9X6QYU3LFsxlf1UQrohaQAelfTsy1fZ5xYViYOYfKRq74rwrZDmcQaCXDPRM6C
 v23JkwLpITRNrUSD4zv9OeifqwzT/dwvf5ElcLMgaVXj+H5nyXk5t1rH+sVVh9Gdt12n
 Fazg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731613039; x=1732217839;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=h9VScUMDwExPnRl1LaPrf3ik6OlripIhAnEXmb6tN0g=;
 b=YPuMXXYBfcfoPMl2LcF+73E0V1p179EWTKLSMyCucJ8LZs9FlgOnL+x2P1xxK/w8jL
 34KGYfyIWAWCw4Il/jGGgKvGLZnZgRjYBAD+zeuL/q4lxUhLMfbVENkKI4OGTpn3kG3M
 aaNEC7j++5cpWFJUm5Jr+AA7m6UtlN9SG1cWWGW6nrqvtmg/PvjnW5OHxuo2ezPvQTcX
 fFfrCjLnCrIp3n66KXVq5P+pCTAhwA9xdyMx60Y1iCzt8ol+N7072JTtT05dMUBVjD3c
 b4jMBVGUFwd1J/1Gf/89YfGwv7qse9mBH7UxZhCMdxGBTEymSo7njQESNuuRs0bBlG19
 mBRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqKvi63MEsuQVvEb0PGD51wWnvrsI0XrZQMTdc/YCsDGGk8vI3sSpM8XHF4DOPGTVb1ayfWz3ezeL0@nongnu.org
X-Gm-Message-State: AOJu0YzGXrUmxxla7UGIiO0KWBTndVHjKXP3wBuTpfeKWaVHSLtteAVh
 OG56KkAkoRUuG/4CFPGhZC5a0Xckmdg+vr2ccqjoiw272I2XcBc/25ldxUn0biI=
X-Google-Smtp-Source: AGHT+IHP8mXDu/xXn4g3XBqb/mvm+a7Wf+heNGBbYjnFnMF4LSwYHrLw+01UOl5bsXvYz1OjLP9YLw==
X-Received: by 2002:a05:6a20:3d89:b0:1db:e1ce:8eaf with SMTP id
 adf61e73a8af0-1dc833611b7mr4266453637.6.1731613039479; 
 Thu, 14 Nov 2024 11:37:19 -0800 (PST)
Received: from [192.168.0.4] ([71.212.136.242])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211c7d064acsm13877105ad.207.2024.11.14.11.37.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 11:37:19 -0800 (PST)
Message-ID: <994a6dc1-42e3-4e7a-9d1b-b1c2cbbf9e01@linaro.org>
Date: Thu, 14 Nov 2024 11:37:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/24] exec: Declare tlb_hit*() in 'exec/cputlb.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Anton Johansson <anjo@rev.ng>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, 
 Peter Xu <peterx@redhat.com>, Pierrick Bouvier
 <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-s390x@nongnu.org
References: <20241114011310.3615-1-philmd@linaro.org>
 <20241114011310.3615-20-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241114011310.3615-20-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 11/13/24 17:13, Philippe Mathieu-Daudé wrote:
> Move CPU TLB related methods to "exec/cputlb.h".
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/exec/cpu-all.h | 23 -----------------------
>   accel/tcg/cputlb.c     | 23 +++++++++++++++++++++++
>   2 files changed, 23 insertions(+), 23 deletions(-)

These are not actually used outside of accel/tcg/cputlb.c.


r~

