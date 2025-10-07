Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34131CCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 23:00:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6GdN-0002xQ-0z; Tue, 07 Oct 2025 18:58:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6GdL-0002x2-Ea
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 18:58:15 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6GdH-0000Z5-5s
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 18:58:14 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-78af743c232so5734200b3a.1
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 15:58:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759877883; x=1760482683; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=M8R5zpo/GpKkU6pkx65jXcQWBpgTjkCoMw2o0txe2Vc=;
 b=tn7nbVMCFHBAtDlnT6ucV+V2xmY0MLsLHEfeAAg8MgKvPA2PO1gSqedRUeqGhWHcgC
 wwJvEri13WfPk2C9Cq89jRx4vSkholpV+pfDyVY48AYP03vxkQaNvVVWF61NsGw3gAEE
 +MxOtfS5enI0zhhGsBGUzlRiC3OQImHWmvIhqo0q3jIV0ndRQ7VyH7eLM/lH1JQSC0Gc
 LXWMhcHNu7Ox2WAlWYBTed4TRGZECrpZpNkmVZ9Q1bis3d/Ibqcr62rcUF1Nc3MAHZcp
 YagT54d6R5Tr90GvD2TI0jLdLxfQrOEcItZerlqT8w2lveefhcIjDBHqqPRDB+oWKbhe
 2omA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759877883; x=1760482683;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M8R5zpo/GpKkU6pkx65jXcQWBpgTjkCoMw2o0txe2Vc=;
 b=h3TqXOXOKPGE64NP1YvhviGD6SY9hpKv3AdNbZlLQiQQhTX4C2MeFsncl7wIqjMzDt
 Z3X6Lmr5HMvnt8sztkhrVNQjYyXKnnoMd0jWYnC9fjnlXuHMYXlj7vFBvYUhgmhtMnL6
 EpRUwnLyRimbeEetSsSFIpWR5tFn5kRVzcAFg/RaKNHXtlLs5wIA9MWwnHXxh3ijcZ0p
 hndKmAcEcJGB11i+27liGRUX5qPx3A4YngWiU/lUFeHzJMNKGZ8SocwsKoC9hveDzFuV
 q9ewVkT0YnoMjWyVYkKNp/YUOhmT8I1Axkju9pRqVGpo1F3Vx8zpMmFscvJK4oyjCP1n
 xGaA==
X-Gm-Message-State: AOJu0Yz/0KSLCpMcQfYc5eTHq+9M8GctxSZbg88506ck/Sf6LKAHG6Ks
 K0z9KaLB4wphv4sSft9MUvfYhKP5RmyqD81Ps8PQmXnlQ+QO/TCZFpA3doM926+8waBuqPllJCQ
 c1THR
X-Gm-Gg: ASbGncteTuef5npTWRMYHoEFStf881p1ojPAgZ8oq5BUVqazo0Hj78LlyfhNlawD1py
 u1755iqDO+9gfwSyeR4L84nidN1f4ZQRZyPwc9GCTjN9cfAHvGQYxJCB1cROtrigADjC7P8mRwp
 Im7T0ygiGEY9jlGnSASHtOiLZE2eQ12v0TNfWcYvTlToaYRXPv/P6BpmvT3oY3KtsmbfVCT1xyF
 YRbF8RoHj4TDmOTqpkrWRMIGLTVX6uVzSWfR9gitxBr/kHLOSRwTUE9UVNgAN2FcTRu+HRzUJRj
 QQHrNu7OgMAZdfmlkypzhoWfvu5jWe7UPzXZl1qX9LDYe6WH6DknJOiOyO+Asx+e+DBjiTnSkle
 2NxH7KnB6B8jMpXuI/4P9vTFeZXAYKoW3YDa2+JgMzcrARhgtRnpZFqjL06GZVVKhYqwre+qPuC
 wMeA5X
X-Google-Smtp-Source: AGHT+IFhyyoaL9NbBx4p9GeD+2VPvMldxLwtH06Il0ZAd/WG2kr8AWl0swl2MTtq/uoE5ltR5s6/dg==
X-Received: by 2002:a05:6a00:2d8f:b0:781:16de:cc0c with SMTP id
 d2e1a72fcca58-793870524bamr1343381b3a.19.1759877883100; 
 Tue, 07 Oct 2025 15:58:03 -0700 (PDT)
Received: from [192.168.1.10] ([172.56.105.179])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b81760e58sm15043053b3a.24.2025.10.07.15.58.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Oct 2025 15:58:02 -0700 (PDT)
Message-ID: <aa3e777b-507f-4942-b830-082746242c26@linaro.org>
Date: Tue, 7 Oct 2025 15:58:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/41] Memory patches for 2025-10-07
To: qemu-devel@nongnu.org
References: <20251007014958.19086-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251007014958.19086-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/6/25 18:49, Philippe Mathieu-Daudé wrote:
> The following changes since commit eb7abb4a719f93ddd56571bf91681044b4159399:
> 
>    hw/intc/loongarch_dintc: Set class_size for LoongArchDINTCClass (2025-10-06 13:54:50 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/philmd/qemu.git tags/physmem-20251007
> 
> for you to fetch changes up to 9ccfde942d8b4e66eb012cf975dac16913875a2c:
> 
>    system/physmem: Extract API out of 'system/ram_addr.h' header (2025-10-07 03:37:40 +0200)
> 
> ----------------------------------------------------------------
> Memory patches
> 
> - Cleanups on RAMBlock API
> - Cleanups on Physical Memory API
> - Remove cpu_physical_memory_is_io()
> - Remove cpu_physical_memory_rw()
> - Legacy conversion [cpu_physical_memory -> address_space]_[un]map()


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

