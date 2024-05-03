Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7462C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 08:41:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2oTg-0005Bz-NY; Fri, 03 May 2024 04:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2oTe-0005Ba-MQ
 for qemu-devel@nongnu.org; Fri, 03 May 2024 04:41:11 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2oTc-0005xj-QH
 for qemu-devel@nongnu.org; Fri, 03 May 2024 04:41:10 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-34d8f6cfe5bso2473530f8f.3
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 01:41:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714725665; x=1715330465; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2G/GmwK6YsHJZ2uqLTo27IyV0S3lTgKqdhOsDH6DO40=;
 b=h4PZwMi7Ov4hnir5RJ9ONF0uBzMQ3N/PUYPVdg6yrhfd/83WQbJ5+rL2cZfWlVX+4v
 +QXyrKPBMQYdDTRL+XJmMwXx3rM/uQVwU4Xr7BEf1UMUO8U+ojFWbhl0s7Iu+uLLRzOS
 8rzWDPIElQrzgcwKHpnRWV6nwvJqkKoeGr2ag1FL09kXJ1TI1CCgpKfnPYm+2q0QzmAw
 kdHFZAbxRyTwrn5KTB/t+zLtdf47lJjdQKwu0Tk5V9d449IrGcFfufgwldZ3ZlUS3xPV
 tvo9Yu6nCkX6SB2LhuvAEynokB/hXo+AAIxjzLRkgnF3s1SUMhGAJEvLiXNFjODl68O6
 jYhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714725665; x=1715330465;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2G/GmwK6YsHJZ2uqLTo27IyV0S3lTgKqdhOsDH6DO40=;
 b=Ttkble4onYpE9xVcbWgzVZHMkVVao+JxNT1l84JK1vk+/00hpB0WdS9WzFx8HJk3Ft
 F6Al7CWFWwfsoFeXlZaRlZYuWHC8/8Q8pA2F1Jy210MvJ02328oZGX0yG9d8/VGVg5h0
 Jx8Qfu8J7505g3Atz1DDU3VuywjsZK9PL7usPH7Jmy0fD65Ul2P+Gb/U13pZ1Nf1V9Jw
 cOq/r5yT0TeNaG0naBuYnmHHI/Fx1N/OTM2aGVnyIKGc5wLolFhTqDY+XacNHqZ2ecBk
 0zXSNCTpjczZT9KinmcXyDiqBNN1u7rEPs3fIT2oNqaGPjulT37BMYM628EoQ5ErdaaN
 ToCQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMznqadcktl2D6RrtBR870pdxb/SjbvQVulISrSkCX19Q0qBRPkUjZ/hTZm2HYN8iNBizOuv7qHlpIy7KdHmSsM3hMUjo=
X-Gm-Message-State: AOJu0YyGDOSny9vDi66UhQ5unT4P4a2G+4lj/hVChV+1FiGSimEUFjXT
 qzLAOxK7g9hRtub+oHLQX44syzRn+vE6nNhjrvMcPnHd2tGWC/YhfBHrMkZQn1w=
X-Google-Smtp-Source: AGHT+IH3+XzVcwn1P2oSBQoJwb+OoNY076A+F+c4kY0MJH8IH1xKd7jJVmP9d5WglxJ47l3vC+ZrXg==
X-Received: by 2002:a05:6000:235:b0:345:ca71:5ddb with SMTP id
 l21-20020a056000023500b00345ca715ddbmr1277418wrz.66.1714725665620; 
 Fri, 03 May 2024 01:41:05 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 s16-20020a5d4ed0000000b003436cb45f7esm3187558wrv.90.2024.05.03.01.41.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 01:41:05 -0700 (PDT)
Message-ID: <975de3d0-5e12-4ef8-85bc-5749e5f17d35@linaro.org>
Date: Fri, 3 May 2024 10:41:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/13] lockable: remove QemuLockable from typedefs.h
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240502155331.109297-1-pbonzini@redhat.com>
 <20240502155331.109297-8-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240502155331.109297-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 2/5/24 17:53, Paolo Bonzini wrote:
> Using QemuLockable almost always requires going through QEMU_MAKE_LOCKABLE().
> Therefore, there is little point in having the typedef always present.  Move
> it to lockable.h, with only a small adjustment to coroutine.h (which has
> a tricky co-dependency with lockable.h due to defining CoMutex *and*
> using QemuLockable as a part of the CoQueue API).
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/qemu/coroutine.h | 4 ++--
>   include/qemu/lockable.h  | 4 ++--
>   include/qemu/typedefs.h  | 1 -
>   3 files changed, 4 insertions(+), 5 deletions(-)

Possibly squash:

-- >8 --
diff --git a/tests/unit/test-coroutine.c b/tests/unit/test-coroutine.c
index 49d4d9b251..32f2f5a746 100644
--- a/tests/unit/test-coroutine.c
+++ b/tests/unit/test-coroutine.c
@@ -13,6 +13,7 @@

  #include "qemu/osdep.h"
  #include "qemu/coroutine_int.h"
+#include "qemu/lockable.h"

  /*
   * Check that qemu_in_coroutine() works
---

to avoid the implicit inclusion via "qemu/coroutine_int.h".

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


