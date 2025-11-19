Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF75FCF34DA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 15:38:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLkGb-0005bH-7e; Wed, 19 Nov 2025 10:38:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vLkGY-0005af-3v
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 10:38:42 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vLkGW-0000KL-Lj
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 10:38:41 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4777771ed1aso48400965e9.2
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 07:38:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763566719; x=1764171519; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kLwTfj1c0GEchCKTMBOzYgegwpgue75uL7ogMnvuAJk=;
 b=sV10uDC61ukY+ZHZDlLlUoQ/JhxQN/rdlQwwbgOgQxf55QgxLD8/sh1ZyFibGWP70S
 7HWyLFYfRNczXdPGc+VaxI/qacEUjbu9rtwhXFFojeppo0SX3aS6VMFMcR5g85ibSuD7
 N2ypEKTu7YUmzyrm3mwpbHDFXxHEWKZKv5azBv7Ku0Elg/W08UENzWrxRFUGVDs2BH3o
 6t7ztSlfD9lqNIAgxAfPNQUfVZMXRpHJY3vhEkCvYUTImzkfqjacfHbJvsB8/wIcGsEC
 +rXeO3+EaoWN44ylQh9cWWG1dH0mZfiIIJGLveZuTqlXXWL4tjytZeiafSvBSYl5mMz7
 wgiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763566719; x=1764171519;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kLwTfj1c0GEchCKTMBOzYgegwpgue75uL7ogMnvuAJk=;
 b=KKKQE14p3NA2BCyLslMeLSCaW6WrCKeS7exhnqlb9MQM90kjE/YuchqJg2LvKqvvhE
 on+QFS50j3D0AuSJ34DwC7Xorac+bquYRUiDnl4I4Cz43YlElQFQerUWBfe+/uqi04so
 n2e1QvLXIm5+iCY1Cm9YjIzgN6ld3Ur1MOaaC3p/nYy6hb9i8ihadncNkfZuNT+ysM0u
 Dd5edVm8HZuNYzkn5BgQ6JGcNOFOeTXf5yRTKMBXOIRilwvU5F+wG4I04+Br9wHmp5QV
 w8+Osfsvo3awM8C1ssPuOHl971RrIptz0gKn7N7L5ZBRJzHkDg5M6VkVAaZ5mNIFmUGD
 fuhg==
X-Gm-Message-State: AOJu0YxE9RuUDgY6h84xfG3RMVgRlSMRZ3UAPNsNBf2pA9WKTjgi/iyk
 /D/9a3NTERoIf1H9pE6fvkgimOQ+4pKH00CxKv2LpoQ4dKRdmHZ7MP3pHn9DvnxSZ/Bls0dVJv9
 y2ztp1X0=
X-Gm-Gg: ASbGncswjhnergyG2Xt41LLqCcYjlhnN5AnuhSWcVGgnVJz+FWPhDYzhveWyV4MKNak
 YzvkLhbH1DNc+weXyupeI1n7bTGR3seL4JkuSirvWH/WOTIr37h1vOdWw04/w8omo7xGFl+SR1J
 iVXf0O8/6ZP6XrrGsxytyjAXoQ1izYGJRkJmCoeejhWuJpYthT9zcm0g3r3dQrprZM+PBAa2Bmp
 UnOA7WB3t13eBBmlfkRuYiP5hyUQsqb68q7+9L/PwkYMWKJ60Ji9XK51x6CSHsMuSAFOKc1O3VK
 SMuSxK7OKNtGaBA0tfexDqmRir2rUn0syAee1LOGqozngpVRVf4qr6Xg/l3TCsksw3POOER+G2f
 u60SImi6adilTDWEJgGUwL7A/DXRlKlHvHRsBKisPjsOR99oIAlIky86aNoVAz4h/6F1NaSJhg6
 HE3/W83e6wrRlwsVAahRsrg6qfwqQJcBOei81LEMKUnP5saegfrKRphkWOvSIg0SKBwy5539dGn
 ACPJw==
X-Google-Smtp-Source: AGHT+IHs7YiahgQYmNV9eUfQvz+mpD3upj7YIjYWCqhU+M5OrrGyzO9TxMubMTf2AKEQTrSxEJ9ahA==
X-Received: by 2002:a05:600c:450b:b0:477:7b9a:bb0a with SMTP id
 5b1f17b1804b1-477b19d13e0mr26603935e9.21.1763566718625; 
 Wed, 19 Nov 2025 07:38:38 -0800 (PST)
Received: from ?IPV6:2a01:e0a:ed5:b1f0:6d32:aed8:c0be:1d44?
 ([2a01:e0a:ed5:b1f0:6d32:aed8:c0be:1d44])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a9de46cdsm41822375e9.8.2025.11.19.07.38.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Nov 2025 07:38:37 -0800 (PST)
Message-ID: <56d73c32-641c-49b2-b81e-37e711abd825@linaro.org>
Date: Wed, 19 Nov 2025 16:38:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] error: error_free(NULL) is safe, drop unnecessary
 conditionals
To: qemu-devel@nongnu.org
References: <20251119130855.105479-1-armbru@redhat.com>
 <20251119130855.105479-5-armbru@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251119130855.105479-5-armbru@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x334.google.com
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

On 11/19/25 14:08, Markus Armbruster wrote:
> Signed-off-by: Markus Armbruster<armbru@redhat.com>
> ---
>   hw/acpi/pcihp.c             | 4 +---
>   io/channel-websock.c        | 4 +---
>   io/task.c                   | 4 +---
>   migration/migration.c       | 6 ++----
>   tests/unit/test-smp-parse.c | 5 +----
>   5 files changed, 6 insertions(+), 17 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

