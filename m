Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DABBEC87FCC
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 08:29:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhOeN-0000bE-Ty; Thu, 31 Jul 2025 04:28:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uhOdu-0000QQ-HF
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 04:28:04 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uhOds-0007ME-HX
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 04:28:02 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-3b79bddd604so105263f8f.0
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 01:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753950478; x=1754555278; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Jy9WYGBvFSPv+sDseReUU7D6ca1DQMeGAdfEVkMutUU=;
 b=CjofkNCFo8PmvIDGBHKQ5X+ybuKSMqo9koa6SYPQP66LBggRNmfEmc5LOBGQTXBpjx
 P9A3vima6k8CaMUDES8CcwW522pjpwxdvBGK2IwPYsW92g7gGzvuYnbJsodRgDm8eBBH
 XZoIm9kcxw4mytcpb5UukKsrcT6rfp4ZxCO75JLQplf3iqB+XEdvJmIEXoU7vSghtAp3
 CMPMTB2FCVRrGXXnykBfi1pAV/mZN9pahp5vLGw+p6FoTJ4gN2uuHvGO6cVvLi4G1ZoI
 UcwWy8oydE1Y7YEF/2EPUFJ6wRXNZ/PBoz4awmnPp9GLdSIOtK5I69s2Q6M1hPnibptq
 +SFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753950478; x=1754555278;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Jy9WYGBvFSPv+sDseReUU7D6ca1DQMeGAdfEVkMutUU=;
 b=gmQwfcSDdlDq/wNNigf8kO06sWeX90WJhMul/dm0ZcmVhtYSr+sbIH4Z6zTe5gYWvQ
 rgIGeCZp71sLEP9TGq2dUWmNj+5n8asSC5tHr2BN7/R8XmuEd1aWdgb83Ha1dNh0lhpA
 AdhuXXmjwoyrEJxAs7oR0JQIsWkevC12HUaGCFOwiREj7B2B6YewS+IBy35tWeL1Wt1n
 5jBOyLnIoVHXuO+uhTK9yn9twdSAvujwrFr45efrQuFM0kS2IhW9Y9oSbx75n4hUXTEr
 L07kT97OAqsHeCiNmPemZQ2SWa081YqEsiNrNc1ad5PULJCUIy9ObcL56VWNk5Ys8fwV
 foMg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtxkLGVdRsF/pK2PoWCZ5Zljf3KTDQlbzn5JWLPrlW0skaiHwewQDieJ9hxy55uL+zHoHen9iBz7dG@nongnu.org
X-Gm-Message-State: AOJu0YwSJvR/muftDuJ9KHyepe0+yDdsB6EfGUmyYaT+r1+tEmP/eNft
 qxwzU8AyyGPJ1NffRU5SSykMbeTp+0yN1F/W6R1+zEWzbkomX709Q30z7D18CPnNIVVUOKztLG3
 Tx4PV
X-Gm-Gg: ASbGncsKOYscnhW/UDi6gFP7LCHCAC+cVv1NPiivkxXvNF73lwGzfthL3h1fiUWl4mp
 bWEYHLJzG2J1BZNhVNSWMY7RfKxFwSWH8vOnzDGpTrwM6zMVEsUgxH+LE8mSxvOabACzsETicWF
 GUcPWlvURM0Fe1FZYuFKgPROsj+T7K6sg1RD8OmuQ5c8W1P90GV/MeO8h8B3OiQyfjuBbh6NxeS
 QXYKdctB3OJMIhVw5MJdB/ZIR2FZrayOzcNdJEgqOc+EG1cLHIGEmFl2eH4XzRoql2GTGoIkoLF
 nzT/adFBd6db4+TC5wTtmBX0rQVh9OzvxWc3sudK0bLz11s9XRFEHnReoU1csMDSt/cxbO/l1bM
 H3ny4YQTmzMIsmLwnOE60xOwLnyABdH3lEkamgNdldFqtOww0rXB0GvID/VQF6hxQTS3aUHLx59
 ty
X-Google-Smtp-Source: AGHT+IHe9a+pmtHRdzTLx7Jmt1lH5uW7ij9XHJf5JMSqUtpWWGhcuVkMrZ5DghPFcvdEhHe9jWUHCA==
X-Received: by 2002:a5d:5f48:0:b0:3a4:dde7:ee12 with SMTP id
 ffacd0b85a97d-3b795009476mr5548384f8f.53.1753950478137; 
 Thu, 31 Jul 2025 01:27:58 -0700 (PDT)
Received: from [192.168.69.209] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b79c489e81sm1596671f8f.68.2025.07.31.01.27.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 01:27:57 -0700 (PDT)
Message-ID: <52c8d9aa-ebb9-4cd3-aa61-5ab54600f193@linaro.org>
Date: Thu, 31 Jul 2025 10:27:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 1/9] whpx: Move around files before introducing AArch64
 support
To: Mohamed Mediouni <mohamed@unpredictable.fr>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
References: <20250731052753.93255-1-mohamed@unpredictable.fr>
 <20250731052753.93255-2-mohamed@unpredictable.fr>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250731052753.93255-2-mohamed@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

Hi Mohamed,

On 31/7/25 07:27, Mohamed Mediouni wrote:
> Switch to a design where we can share whpx code between x86 and AArch64 when it makes sense to do so.
> 
> Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
> ---
>   accel/meson.build                                     | 1 +
>   accel/whpx/meson.build                                | 6 ++++++
>   {target/i386 => accel}/whpx/whpx-accel-ops.c          | 8 ++++++--
>   {target/i386/whpx => include/system}/whpx-accel-ops.h | 0
>   {target/i386/whpx => include/system}/whpx-internal.h  | 7 ++++++-
>   target/i386/whpx/meson.build                          | 1 -
>   target/i386/whpx/whpx-all.c                           | 4 ++--
>   7 files changed, 21 insertions(+), 6 deletions(-)
>   create mode 100644 accel/whpx/meson.build
>   rename {target/i386 => accel}/whpx/whpx-accel-ops.c (96%)
>   rename {target/i386/whpx => include/system}/whpx-accel-ops.h (100%)
>   rename {target/i386/whpx => include/system}/whpx-internal.h (98%)

Missing updates in MAINTAINERS, otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


