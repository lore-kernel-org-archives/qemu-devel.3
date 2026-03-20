Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41C7C1099B30
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Mar 2026 21:53:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3hlv-0002V2-3J; Fri, 20 Mar 2026 17:52:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w3hlt-0002Ug-Jq
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 17:52:45 -0400
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w3hls-0001ag-6h
 for qemu-devel@nongnu.org; Fri, 20 Mar 2026 17:52:45 -0400
Received: by mail-pg1-x52e.google.com with SMTP id
 41be03b00d2f7-c2af7d09533so1714729a12.1
 for <qemu-devel@nongnu.org>; Fri, 20 Mar 2026 14:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774043563; x=1774648363; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g5PTryZjhpUvvyFkVWpM4L1FKGHNhUWmX1wXgnRF/jI=;
 b=e8fSFwS5dlf5a2AvDCc56mvLHuiu4Q+5cnj36gKBJqU/g059iXZcbkxKWIYgnVPgYH
 3Xftz7CHmacWhxqED5lzeVE/ZhU9Qt4FbbIeuAxXAp0JzHE3vearWhjrj3Te1MZXSsdR
 FRXKDvzFEhgPf81KG6ZHr9LThgE+M87cKbCbpNoK1FWbB084kq+22HjKlPCzzMUa0pJD
 vOttghJyAU1NF0pgf3CdhFuzqPWfKUWCEr1s8MAPfL+uP9eKCkaYXkTpG+LPjIBzTT0E
 m8UQ0xRdAfGkoJhM6oUX18UFajLQMDO+lv9cidUWgWKP8/7TLSr0VchuIkhPshwUxoAH
 IdzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774043563; x=1774648363;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g5PTryZjhpUvvyFkVWpM4L1FKGHNhUWmX1wXgnRF/jI=;
 b=V2Nujsmr3/1mX6GISvRqWYwBPYFwkOce6pYT7WOBf9Z0N1MGCtwhlDxlYhg7RnGhDm
 D09i0VyWys3c2qGHLtvzAGV9bjJk99nfJvwiLiU5ZuXTKx7nxDqz2gX82tYUe4PFg570
 HIuJna6hjeNYNfVcaV+qAQW7s0YzLydPPYXLTuoGaSYuuQmkPjC7gSEb5d0Rx+899JcC
 UUR8p1ifrAuf9QNTQ7CvG8didhLIPYCob5pza1I5J0u1+bZoCZ8UtkH0ET5E6ldGvBGP
 HjO0PP6ojsUOulH/FpYip1lB4SUx94hJ/3NsNqeqy7rW+xoXk/SBJB8x3VDH/KCuV6dP
 TcpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwxdmMq2VBnCZTr8FPDts7j/msqdnPdQ5/shKIx4So2N1yAIYsW85ouPq6P3Di4G8nQltjHlD7AtGH@nongnu.org
X-Gm-Message-State: AOJu0YzzeDOcwRaOaZVpiE+t18mOCLCuZPzmp0D66arnfA/iDDeG0039
 FfRpD7Sf3cdA4rWbONXYgLqg/T3JHkA2Mr4vmdzeFlrCPbeiU+Lcl9yZ0sddphmlPdW0QbME9e+
 GAH7cgBM=
X-Gm-Gg: ATEYQzwTg+lwhDUSN7bBS5Z8BWnZeyK1oo1jt+VYTY0WxqFTPI1zqtThac63ph9dLc5
 MGoKr0tycdFuI/lvihqoDWYINk+CVnpHOu+Zwey25wGhHceq5LUA5Bm4GYysqBBSWvSfy0AoEuq
 cbOdlC6xlLsosuxigcyzdIvqx8Pz1s0ugSYBrFxnm7JEa9vGv/CAHICRTKanG1eDNk7oRnv7XAz
 sl32Gyfanx0rfSrmjR81NFLgxqj3HjuYQa+8rHoP2eY7aWPC8evOv+r2zDMmOSSMEktyfupcZrn
 2RmLwjwURgAGj4Gz44id5KkChvvbaexCo4LCB+ZLy1Z1nsLYINJyfbGFH2wUWNFyFnvqxyRZfen
 osrf/h6buTNzRF/yxQ4iXdQiAb/7N/oO/q3DBBP/Fk0OfqeLzsLkAT9D33tKBBrMQI/KcRe9L/l
 Fn80Is3tYW04dz5vKWI0PVSpABtrpLCOMBmo7ZhsBt99uorXRywyV5yiZfMkYcqMjkv0pS
X-Received: by 2002:a05:6a20:1586:b0:398:9466:2ee8 with SMTP id
 adf61e73a8af0-39bce97c801mr4132622637.7.1774043562744; 
 Fri, 20 Mar 2026 14:52:42 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c743a814548sm2513811a12.9.2026.03.20.14.52.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Mar 2026 14:52:42 -0700 (PDT)
Message-ID: <edc820e5-dbf7-4a81-9304-35c2ba6e49d0@linaro.org>
Date: Fri, 20 Mar 2026 14:52:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-11.1 01/10] monitor: Extract completion declarations
 to 'monitor/hmp-completion.h'
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Dr . David Alan Gilbert" <dave@treblig.org>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Jason Wang <jasowang@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
References: <20260320160811.28611-1-philmd@linaro.org>
 <20260320160811.28611-2-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260320160811.28611-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52e.google.com
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

On 3/20/26 9:08 AM, Philippe Mathieu-Daudé wrote:
> Many files include "monitor/hmp.h", but few of them really need
> the completion declarations: move them to a distinct header.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   MAINTAINERS                      |  1 +
>   include/monitor/hmp-completion.h | 40 ++++++++++++++++++++++++++++++++
>   include/monitor/hmp.h            | 21 -----------------
>   chardev/char-hmp-cmds.c          |  1 +
>   migration/migration-hmp-cmds.c   |  1 +
>   monitor/hmp-target.c             |  1 +
>   net/net-hmp-cmds.c               |  1 +
>   qom/qom-hmp-cmds.c               |  1 +
>   system/qdev-monitor.c            |  1 +
>   system/runstate-hmp-cmds.c       |  1 +
>   trace/trace-hmp-cmds.c           |  1 +
>   ui/ui-hmp-cmds.c                 |  1 +
>   12 files changed, 50 insertions(+), 21 deletions(-)
>   create mode 100644 include/monitor/hmp-completion.h
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

