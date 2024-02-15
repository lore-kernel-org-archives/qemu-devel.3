Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2426C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 14:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rad3Z-0000xJ-Uq; Thu, 15 Feb 2024 09:49:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rad3Z-0000wz-0W
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:49:45 -0500
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rad3W-0007Qp-SH
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 09:49:44 -0500
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a28a6cef709so124335066b.1
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 06:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708008581; x=1708613381; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aqr7wWcuqB9yP7xREpIQs/l1ZNVyP4RyA++HWsSqjYk=;
 b=JhBv/dXYnzJj4ri9ts2Ui32g4euzqD+O48EcV1Iy9F1ZqWTsNoxLACcIM5y/IdhSuJ
 kYgEo10pyTExAnyQpy8kWRVJwWHy5aiis/+7n1740hj8OTrBXLb4IemcTKt9MxuegXQm
 dIiLJFzPRwNC5kQJxP1s22n1gfJBooi6dxFbrft0/KLXpsdSHZvnRwgahbN4voZmP2R9
 Qb1uMHiSSfmaC5hX3YIgIhjOcZxEFCnIAvazDIpciAiy1xrDaJaFowP14TbWrr7F5nOd
 DkNQ9GlOdWLG0Vdd3oMjRBIqMKzax4w9qyCI364PV6S6zYvZX/Wbi77UrY173DNDkJ62
 IypA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708008581; x=1708613381;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aqr7wWcuqB9yP7xREpIQs/l1ZNVyP4RyA++HWsSqjYk=;
 b=VmzE5tcbSlQO5ByH2ZK9LXuLkPUHQO0L4UZJXVw5HOIvO4ZIAwOFuXtqyxx0P/ffoK
 ia806bbaft5j2DpmxJiteJTeBL7msuoWfLdiJ4q8Tj/wDG8f7cLfdy8JIvqgMq7wQa+0
 j9lDgFLruO9fzbn+qN87CitgPIPIMfgVhkuRdsgDGjZ4aObgtWJqtPQr9Oz0+pZ95lFJ
 A83KlKQYfEUjDz1uuzAoU8SXAtlvgnpLqV3+CXyJwB9549pDf/UuRttyKasQv+HsLsyt
 Ft9/sJ4k+78b4zkixJ+/YzoFTwh7uuJWnhaVgiilXtYiSzuYW389CC1ha36qMg5RWXir
 Ocbg==
X-Gm-Message-State: AOJu0YxaovjH9sUz5s3ZO8cESEO8VcN+8CR1sk/6WDRyfSRm2gAqpEfM
 S+KDLu3C3fkcfFf7/WhUg8TFX+mSSnbuR54+Wn4ZJ7q1A1GIqJ6kVtLhkOfou/m0SKHb214Ymtx
 B8TM=
X-Google-Smtp-Source: AGHT+IHR+MQNfCCXanh9nA0RYrDgNOW0/02hZeQFNv3c75DzG6ULdbqrtxiRs3IUDgxPgF6XSetbYg==
X-Received: by 2002:a17:906:f156:b0:a3d:7c4f:9c5b with SMTP id
 gw22-20020a170906f15600b00a3d7c4f9c5bmr1580255ejb.66.1708008580988; 
 Thu, 15 Feb 2024 06:49:40 -0800 (PST)
Received: from [192.168.69.100] ([176.187.193.50])
 by smtp.gmail.com with ESMTPSA id
 gs36-20020a1709072d2400b00a3d0a094574sm629020ejc.66.2024.02.15.06.49.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Feb 2024 06:49:40 -0800 (PST)
Message-ID: <b6503fb9-b3a3-4b28-a18a-3254dab1a6bd@linaro.org>
Date: Thu, 15 Feb 2024 15:49:38 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/dma: Pass parent object to i8257_dma_init()
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: BALATON Zoltan <balaton@eik.bme.hu>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno
 <aurelien@aurel32.net>, Eduardo Habkost <eduardo@habkost.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-ppc@nongnu.org,
 qemu-trivial@nongnu.org, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240213114426.87836-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240213114426.87836-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 13/2/24 12:44, Philippe Mathieu-Daudé wrote:
> Set I8257 instances parent (migration isn't affected).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/dma/i8257.h | 2 +-
>   hw/dma/i82374.c        | 2 +-
>   hw/dma/i8257.c         | 4 +++-
>   hw/i386/pc_piix.c      | 2 +-
>   hw/isa/lpc_ich9.c      | 2 +-
>   hw/isa/piix.c          | 2 +-
>   hw/isa/vt82c686.c      | 2 +-
>   hw/mips/jazz.c         | 2 +-
>   8 files changed, 10 insertions(+), 8 deletions(-)

Patch queued.

