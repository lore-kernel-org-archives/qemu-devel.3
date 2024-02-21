Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE22EC48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 16:11:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcpBT-0004d1-7T; Wed, 21 Feb 2024 11:10:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcpBR-0004ck-DG
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 11:10:57 -0500
Received: from mail-lf1-x130.google.com ([2a00:1450:4864:20::130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rcpBP-000234-PZ
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 11:10:57 -0500
Received: by mail-lf1-x130.google.com with SMTP id
 2adb3069b0e04-5129e5b8cecso6112798e87.3
 for <qemu-devel@nongnu.org>; Wed, 21 Feb 2024 08:10:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708531854; x=1709136654; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=amOl3kWIB9RHQXqv9gZxnCrTPOPpDUYd6cxqYb6aajc=;
 b=Betj7eByYoUVUEG04T1/YVto3L2P3EcRIG9kCKrPEDK5/h241BjhfPQnvttcbEltIJ
 RK2qSkAb3Z1UMPzyzlH0CVR8UcYx9GDfATyEdqECAHd5qmj626mksABqOWENRGcEZKu6
 5kWxL3wgIOOikP9rFgnpknbIskhQsoNsnlIbZ2FcMSiV6tBQDpCC30ImGynT3eNKeR1M
 cTvTxvdsjZpAT6SZPTTMnsY8O6hsRozOy+xAF9YMRTKQQuYxGh7P+yVLS+1CiZwuz2f8
 9zL9ZM1sJtGLBb6vicwdQ5nH5SMTjWlQELpTT1CNlj0fHrfLp65MOA5b5LC4L0iWMyVl
 AfIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708531854; x=1709136654;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=amOl3kWIB9RHQXqv9gZxnCrTPOPpDUYd6cxqYb6aajc=;
 b=wsv7l9CmLX9wf5I1goaC8UWbMt32oLkDIfWge6CStAQ1/L2zI4n618OI2zC2Hfy7WH
 gRG4ewt4tNm2jjoLI/qXdkvfziirgeyPoXYwo6ENbOVfBy6rm+ZUQErq25iqQseWdwpN
 4ov60NiyTuspYwnWKeSTZo5q8oMNnzK3nX+sW5NU62cgNIT5qwJIHrj6qG15/FTXsI+b
 s+ORbaoAHNBvoizDxAjesQkWyjxCD4bJFwzdR7WCVzCazh1Tvf0YaJyvJDW+rXMzlzEq
 F/UV9HAz3CWkFIBwbET+uUUs+xMAFIswbKnshyxoLrJU0V0FoZC6brfNJprzRqWuJ8LM
 mrqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWaZF9ZbmtvtCX/EHVFdt3wyseqxpLDgiAIJPOUAJ7VT+QBvAYEryv0/NM71CA6b1y9OX0hpbVxIhX4xHVjrc5Sfpjhxr0=
X-Gm-Message-State: AOJu0YyB4ywNHrzuCuoOo2mQuAyZMAB3i64RI04XXHv8a/tteSRPn41l
 84W922i4xhbgpFrmoH4qAYuzjv0xAiZ/bmBkJHMNuR+E/0FCwt16vucJJeypd5U=
X-Google-Smtp-Source: AGHT+IFcISEpk2U5CKMv4FcxsHKW+OV1D9zE3iRcvlyQnBuLY0uhQmCECk1ZzSJ1TdR4j7lUb48eeA==
X-Received: by 2002:a05:6512:10c6:b0:512:cd03:b0a5 with SMTP id
 k6-20020a05651210c600b00512cd03b0a5mr3222401lfg.10.1708531853876; 
 Wed, 21 Feb 2024 08:10:53 -0800 (PST)
Received: from [192.168.69.100] ([176.187.211.34])
 by smtp.gmail.com with ESMTPSA id
 vb7-20020a170907d04700b00a3d6737afe2sm5075282ejc.138.2024.02.21.08.10.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 21 Feb 2024 08:10:51 -0800 (PST)
Message-ID: <71bd7161-766e-4ff1-88d3-5cc86458c7ec@linaro.org>
Date: Wed, 21 Feb 2024 17:10:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/9] hw/i386/pc_sysfw: Inline pc_system_flash_create() and
 remove it
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Paolo Bonzini <pbonzini@redhat.com>,
 Sergio Lopez <slp@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240208220349.4948-1-shentey@gmail.com>
 <20240208220349.4948-8-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240208220349.4948-8-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::130;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x130.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 8/2/24 23:03, Bernhard Beschow wrote:
> pc_system_flash_create() checked for pcmc->pci_enabled which is redundant since
> its caller already checked it. The method can be turned into just two lines, so
> inline and remove it.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   hw/i386/pc_sysfw.c | 15 ++-------------
>   1 file changed, 2 insertions(+), 13 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


