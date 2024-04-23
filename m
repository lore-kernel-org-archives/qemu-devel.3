Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 643BAC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzGKw-0000jq-Qm; Tue, 23 Apr 2024 09:37:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzGKu-0000gq-LE
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:37:28 -0400
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzGKs-0005ul-1v
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:37:27 -0400
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-41a5b68ed4fso17758115e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 06:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713879444; x=1714484244; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=a96KnJupPRJ7KdLJXyk5fT4u8vAcedof3+AOh4R41iM=;
 b=tH4YZzLzO3QgiSWxLCuXtmufRTuFm83/RU7qD0EagUPuK4P9NCJDRMJvzSf2fX/6Ey
 G8N+HqKbk+KxGWLgBef3VXK1OWH++FfRcCv8WJqRR4ohNnwUDNESuVIUcS7ZqlvMzQh1
 +1iH0pS0ZkRuRNttfVUQvI4VJ5nXOgJRZ6r73vsZf2zs5dH8MAFzZXpKEBAVcoHZbJk0
 HfEU7f+waGe0rqKShm44Dfxv0BImDi7GgoAey9C8WkM6N9uAkbIu9O3GW4MpX1vBrG+n
 1HRy6WiNGcxqL5ZLwIXk2MO9T/KId/T/cXt37Z+ft+ZMOpBMWsBFGFTgSBo4+nrQjK47
 a+vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713879444; x=1714484244;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=a96KnJupPRJ7KdLJXyk5fT4u8vAcedof3+AOh4R41iM=;
 b=vC/AXy68iqgkH6DXwgFXeOZHeL1ZNOpuVctTYOPM9VunzpWAMBA6+TvEl94DbP0/sA
 ieHoThdjus30778EoL/yFDenAnoQP1LJgq/VbIhxAGFE+nE+NRJAFQB9B+lZmp6z633M
 wNo2JNE1Uwyd8dVJPZd54M/aG9h7Y2bKcJfR0N92ogkZPCUlf1JdZv9GYxvPe+7EhxHy
 KWinUQjOw16npfIttf5pI6je0LnHwZFkwgPTXsC17K3E6x1Yw8wcoXVMhwcXnsaWX5J+
 WSuXAPYEde2UWd5HVtKLEpbp7am45w67UpDwF1rUwUpw3+thWh/B3j3rSrZ7Waew0mWf
 jUQg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXYukExDG5vUlaodPJP7mNnQKyDtgM36s11kE3G26Su6cfjKv6Gr5i1yIpEPgAxcMiar/pjhJUN34xKOpb/SKiJLXcCbRo=
X-Gm-Message-State: AOJu0YyfmGtBZYhsGl+4xD3aqkjGBSYLSKyLNZ4mhkVj1jerLEafg5XD
 bpU55RsWXC67zi5sjTK0WcDh0pTOqw8vsL+TNPxYkUWkhUGEQRq0ZhUG17G/2uw=
X-Google-Smtp-Source: AGHT+IFh2FelwXjeCQ3rfT8XC6R1q169NjE4TK6Tx1YUNuf7yy04P+Cty3xLIFZtgIkNZ+h5RkGhCg==
X-Received: by 2002:a05:600c:1992:b0:418:8df1:ca73 with SMTP id
 t18-20020a05600c199200b004188df1ca73mr7118608wmq.19.1713879444249; 
 Tue, 23 Apr 2024 06:37:24 -0700 (PDT)
Received: from [192.168.175.175] ([92.88.171.241])
 by smtp.gmail.com with ESMTPSA id
 f18-20020adff592000000b00343a0e2375esm14506328wro.27.2024.04.23.06.37.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Apr 2024 06:37:23 -0700 (PDT)
Message-ID: <d71df2d9-97f2-4ba7-abb5-860213357ee4@linaro.org>
Date: Tue, 23 Apr 2024 15:37:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/22] m68k: switch boards to "default y"
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: farosas@suse.de
References: <20240423131612.28362-1-pbonzini@redhat.com>
 <20240423131612.28362-10-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240423131612.28362-10-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

On 23/4/24 15:15, Paolo Bonzini wrote:
> Some targets use "default y" for boards to filter out those that require
> TCG.  For consistency we are switching all other targets to do the same.
> Continue with m68k.
> 
> No changes to generated config-devices.mak file.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   configs/devices/m68k-softmmu/default.mak | 13 ++++++-------
>   hw/m68k/Kconfig                          | 10 ++++++++++
>   2 files changed, 16 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


