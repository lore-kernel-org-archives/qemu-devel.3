Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E3D9C67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 12:48:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rsiz5-00012N-G0; Fri, 05 Apr 2024 08:47:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsiz2-000126-Bq
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 08:47:52 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rsiz0-0007pA-RF
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 08:47:52 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-41631d7b172so2833305e9.0
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 05:47:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712321269; x=1712926069; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wrUruDC6C4hD6QGp8o5r+hmX2cGPN22BVywJl8ams0E=;
 b=HNeygffUPicuG1PoJQBwrCUgkoSv//2aDRHW8AvjburGnf6pYRyLSOeEeeVUhavSIc
 ja1FsbgjLZTYoGRiVNLjeQn9YkL/Yqm7oPfNK8NdMdaChJtur+qmazTNdQBegrXwrQSu
 mW7OVKIatYGO8nfIx0OA7w4OXarjF9Juoh2RGJWlcUP+mfykKAjxsvAdorhlCRGmjiWM
 xfnqW68HUKK8Bjfjc1QmxOVERs9Va2AI/HdryFD4wzQWPXy9VpzsIQmkz0bjT+nmduP4
 GBB51Bk9ubECMuQ9uv8m8wBm1vEyLOQrzOBEbmIxOJlZ6k22nZcn8R+uPe9DJwsGfaqh
 VM/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712321269; x=1712926069;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wrUruDC6C4hD6QGp8o5r+hmX2cGPN22BVywJl8ams0E=;
 b=cZWwhLVD8wkLQ3MrGiyCANPSmJZ0un3NHf9w3ORO2uv8wZRAgPud/o+iWUsEnXpTkJ
 8SsdPSp8+b3qbmd3PWpZivOEZOEKlTRuq7XLSgzsr6mAO2pX0NUdy1Vo3yD+HiiHeA3W
 mT8tQKUWCZ+WaYR/gqauOkHb5RRE8gN/PNDDd+egLNnHoppfGNfm3+NXc1FBkKFJwMsY
 e1dqs4SGxGys+GT9w5NgsKqJodDvh40ngdDraIbtDKs73VYGRv1onz/FelH8JGbiowuU
 BPSpYVYURLQlif0qjiRMO2AJI5M2D+bVQuexdtGFD6D4Ys0hakW6uw7KeXj6iZgkaPuE
 DG9w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+8NZvbEP+j2fs3HdNis/v3UqhWGnaCTCKdzWiLXELU6uby84M/909YCgiErRd37qZcvTqTdVlTNhRTFztI3fo/wCiHNc=
X-Gm-Message-State: AOJu0YzTfOPiJFHXY+pdyTCiweepHpqAqRi71HbkSwAYeh8kIUHTbJt9
 93BMAKWC5nD9gGeFSrD9IFnlqvB6Kn2vai6zHgb5ZzZ94WOdY8FDl8y5eFzcL78=
X-Google-Smtp-Source: AGHT+IGYQ0j3L5g5r2zQ8wLkXLNa4jrTwKFUEFHHNfKiDJJer+zQOAe7WxHozrmothnEMCtUrM8oxA==
X-Received: by 2002:a5d:4003:0:b0:343:c35d:1406 with SMTP id
 n3-20020a5d4003000000b00343c35d1406mr982457wrp.15.1712321269301; 
 Fri, 05 Apr 2024 05:47:49 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.216.34])
 by smtp.gmail.com with ESMTPSA id
 q23-20020adfab17000000b003437799a373sm1968718wrc.83.2024.04.05.05.47.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Apr 2024 05:47:48 -0700 (PDT)
Message-ID: <fa4af8b2-ed50-4f97-a636-2e72267bcd1a@linaro.org>
Date: Fri, 5 Apr 2024 14:47:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/32] accel/tcg: Introduce translator_fake_ld
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240405102459.462551-1-richard.henderson@linaro.org>
 <20240405102459.462551-21-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240405102459.462551-21-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 5/4/24 12:24, Richard Henderson wrote:
> Replace translator_fake_ldb, which required multiple calls,
> with translator_fake_ld, which can take all data at once.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/exec/translator.h    | 8 ++++----
>   accel/tcg/translator.c       | 5 ++---
>   target/s390x/tcg/translate.c | 8 ++++----
>   3 files changed, 10 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


