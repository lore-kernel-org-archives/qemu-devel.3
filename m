Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A5C0CD11C2
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 10:56:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rshEi-0007US-RK; Fri, 05 Apr 2024 06:55:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rshEf-0007Sm-Ky
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:55:54 -0400
Received: from mail-ej1-x631.google.com ([2a00:1450:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rshEd-0001JJ-SD
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 06:55:53 -0400
Received: by mail-ej1-x631.google.com with SMTP id
 a640c23a62f3a-a519e1b0e2dso117106266b.2
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 03:55:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712314550; x=1712919350; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=CG/3LhoR0qkIj6cIiK9XCnRTJWYW3BFglM8ByuNXqC8=;
 b=ZmzKGBa5Zhb9EreEu0SyqPprANvlW9D4UONKSWOPUt7OoB4u9kVuX6t3l3VD6zhi4L
 xa8iRCuz/IVYV9MMp9xqZnFHKC34qkBjmYKS72SgKlZ3R0YCpWmF/8HbRWK5EMstkrKm
 h3SqlsMxAxNVctBzvD01HEET8NlIYysQidRbtYK4orWsQGVNwfvpT4NkXwjVzl54FI7Q
 9v2pvLwREvHnGQs25jm3BZY0otj0uBONPTUkJ4XxY3GyOfwkGHLBBTzTsGrccRC30bVU
 SlvpQT3FcO87mT6/Wms7qlaKf7xlWvrBuGUGG0uyTYQYNjqt0+gPxXXw8Bq6kZgEhdiN
 5iNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712314550; x=1712919350;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CG/3LhoR0qkIj6cIiK9XCnRTJWYW3BFglM8ByuNXqC8=;
 b=niMlJkrrPiUV14oChVceIzd6Tcb4rg6VrtF6eNL2a6oavg7IB/03D4j2oL5UxLXxtS
 mJAI85Pdv15/+gxGev3aH54O2o4sNkeCUC+6MwC2mnSU41fbRw/LGdlV4SB4ehIKvgOt
 uuO9KjOqCd8f7VOd/bSmAF6cifoKeubK0soXNgXWIQkdUuYOov2RT49uiuhB7uFY9BgH
 AzwP9vIo6ecb9jLyZebm3ZVyx4pZtfBlfoSVeQMQFh8r1aA+9XJP0GOE7CQ+DXr8cUC/
 NynjAyZ85+zkHEeobbC4c1hvC5b9jbzcUkI7RP+H9oTWyYH6XmzZX0udQtKco06UTjHU
 YGKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXNNSVbYh7lPv6+7f3oTcdMA2EPliFXE0Gls70RCHqEnapxRUeP58mezM1iQbCvTJ5TBFKQ3DjR0pZfy3V274yUdHtwh9Q=
X-Gm-Message-State: AOJu0YwgaMb1Syxxttq07gp8yU5qmd5FZysVtIEjFNvt/QKqtIKkw/6H
 P26CytbNUSVWN7aKAAxa01lIm98xVgpPcSqw0qsEIvwYR+8WXsP6MlGZVDvP6f0=
X-Google-Smtp-Source: AGHT+IEMJ5mEk0WeuU2qlp8e1ViZslBqIfQ6tugyZ4fst2+yxt4Vg8vic7ooTC1zMnU6TSyeQCw87g==
X-Received: by 2002:a17:906:35cb:b0:a4e:2b75:e1de with SMTP id
 p11-20020a17090635cb00b00a4e2b75e1demr672058ejb.22.1712314550107; 
 Fri, 05 Apr 2024 03:55:50 -0700 (PDT)
Received: from meli-email.org (adsl-197.37.6.0.tellas.gr. [37.6.0.197])
 by smtp.gmail.com with ESMTPSA id
 e3-20020a170906844300b00a4e5ab88803sm701875ejy.183.2024.04.05.03.55.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Apr 2024 03:55:49 -0700 (PDT)
Date: Fri, 05 Apr 2024 13:54:46 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-stable@nongnu.org, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Zheyu Ma <zheyuma97@gmail.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>
Subject: Re: [PATCH v1 0/1] virtio-snd: fix invalid tx/rx message handling
 logic
User-Agent: meli 0.8.5-rc.3
References: <cover.virtio-snd-rewrite-invalid-tx-rx-message-handling-v1.manos.pitsidianakis@linaro.org>
In-Reply-To: <cover.virtio-snd-rewrite-invalid-tx-rx-message-handling-v1.manos.pitsidianakis@linaro.org>
Message-ID: <bgucz.0f0amac25xfr@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::631;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x631.google.com
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

ping

On Sun, 24 Mar 2024 12:04, Manos Pitsidianakis <manos.pitsidianakis@linaro.org> wrote:
>This is a logic fix for the error handling in the TX/RX virt queue 
>handlers. A potential invalid address dereference was reported and fixed 
>by Zheyu Ma in <20240322110827.568412-1-zheyuma97@gmail.com>. This patch 
>moves the invalid message storage from the stream structs to the virtio 
>device struct to
>
>1. make such bug impossible
>2. reply to invalid messages again with VIRTIO_SND_S_BAD_MSG, which was 
>not possible before.
>
>Patch based on master base-commit: 853546f8128476eefb701d4a55b2781bb3a46faa
>with the following patch applied:
>
>  Subject: [PATCH v2] virtio-snd: Enhance error handling for invalid
>   transfers
>  From: Zheyu Ma <zheyuma97@gmail.com>
>  Date: Fri, 22 Mar 2024 12:08:27 +0100
>  Message-Id: <20240322110827.568412-1-zheyuma97@gmail.com>
>
>
>Manos Pitsidianakis (1):
>  virtio-snd: rewrite invalid tx/rx message handling
>
> include/hw/audio/virtio-snd.h |  16 +++-
> hw/audio/virtio-snd.c         | 137 +++++++++++++++-------------------
> 2 files changed, 77 insertions(+), 76 deletions(-)
>
>
>base-commit: 853546f8128476eefb701d4a55b2781bb3a46faa
>prerequisite-patch-id: 8209301569bd30ba806d06b3452a2f3156503a7a
>-- 
>γαῖα πυρί μιχθήτω
>

