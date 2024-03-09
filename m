Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C65C6C54798
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Mar 2024 14:03:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rixHj-00058W-6L; Sat, 09 Mar 2024 09:02:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rixHf-000565-Pz
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 09:02:44 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rixHe-0000iC-5k
 for qemu-devel@nongnu.org; Sat, 09 Mar 2024 09:02:43 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a446b5a08f0so527149466b.1
 for <qemu-devel@nongnu.org>; Sat, 09 Mar 2024 06:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709992960; x=1710597760; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HFT41bzVddHh6m4SBiS1v96R9WkJJN66wTsfxFXFbx4=;
 b=LtdDUqES/y/Do8smOJkkMSHDmmoJUxIB/bQmXh6By+evtO84Np2gk0SZazmB66i0vH
 cDgAKxFR0kDQb0AseiibtfvL/YCJVLHjcTkdVxmQ+U7gNr2HCmoMzw8CdU7r0xk3xR8X
 8l+Ed90470P9iq7D4M1IIf/yuwT82Uw509gFio0Xoa45pI0jNM73I7HrMv+OrJYNiION
 7fbL9KAYDnzNIXr6GMiph8SshupYkjo8u8aNFQ+6kUMHMm2IR5LqFHLAHNuqOCFfkbt/
 MTjdR8CZ64976UmlwkkTvnG6r8hOnJNkhxKcWVEToZSRD0mcsK22niCXgqc2S4W//vZ0
 ikmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709992960; x=1710597760;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HFT41bzVddHh6m4SBiS1v96R9WkJJN66wTsfxFXFbx4=;
 b=ljt38+EoV+QQbWE9Sl9yUShAVFpHHZT//TggOCTTF4ZBzrds0/vGGQ13HsWyEZ6AJk
 YyVy/Lhq4+V8bXGwW67vKTio+ZlrtztAixP38tw2gIHr7GWzxabY5tLBxOLKJ420c6NO
 Xz51l3cfIhrexw8uJlC+ju7ETyoztbvvmxz7qrPEQ0Cg13Us8tFv2rEN0kWtLVOpYPy5
 Mnf+w/RcCnNWnR58HU1lpBoQRxZWmLLe99/84pizmh+u/w7WfLhx7VYgSBZpynpeX1V8
 lVxKlyPq1eXB7w/OlVhEJArTNYFGa+phNgxRuGt9c6LjwhstiJYF0i8kkKEdvq+QekXg
 P4Tg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU0y03NpPKD1BnH+CjVUcA5vFs/lIwrWpCPlsX+VgCpBKUlh4LYZp5/nNaaxclTdpOqr61G54ZfAV8TWBBMGIdoK9pcm14=
X-Gm-Message-State: AOJu0YwqUwM17eoCZC1jOpxUyFVbsPH0AqPju0gEkkNuz1Gq0QoQ8Fpx
 qeoROelt2SoPfMpd9W260ay0YN/d2nDKDTYM4iipBVlNGxFNO5395FcMgB/c0X8=
X-Google-Smtp-Source: AGHT+IFM+tnucGIKWaic7nwT3kscGnHBMo/O6qFkK7YaHMTXn9IHzTEOwLVhwYSVXGOw+PapqgdNUA==
X-Received: by 2002:a17:906:3ad3:b0:a45:a2cc:eb93 with SMTP id
 z19-20020a1709063ad300b00a45a2cceb93mr1349135ejd.4.1709992959751; 
 Sat, 09 Mar 2024 06:02:39 -0800 (PST)
Received: from [192.168.69.100] ([176.176.181.237])
 by smtp.gmail.com with ESMTPSA id
 k20-20020a17090627d400b00a453b2261b4sm916295ejc.184.2024.03.09.06.02.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 09 Mar 2024 06:02:39 -0800 (PST)
Message-ID: <75c0c7b7-a229-4c71-bdff-229bc8e54b24@linaro.org>
Date: Sat, 9 Mar 2024 15:02:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] hw/pci-host/pam: Remove northbridge-specific
 PAM_REGIONS_COUNT
Content-Language: en-US
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
References: <20240309134056.1605-1-shentey@gmail.com>
 <20240309134056.1605-3-shentey@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240309134056.1605-3-shentey@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

On 9/3/24 14:40, Bernhard Beschow wrote:
> PAM_REGIONS_COUNT being 13 seems to be Intel-specific. There are VIA 82cXX
> northbridges having only 10, for example. Communicate this by having
> northbridge-specific constants.
> 
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> 
> --
> 
> Do we need the constants or can we omit them, given they're just used once?

We don't need but prefer, since the definition is self-explicit
and we don't have to lookup datasheet for magic value.

> ---
>   include/hw/pci-host/i440fx.h | 4 +++-
>   include/hw/pci-host/pam.h    | 2 --
>   include/hw/pci-host/q35.h    | 4 +++-
>   hw/pci-host/q35.c            | 2 +-
>   4 files changed, 7 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


