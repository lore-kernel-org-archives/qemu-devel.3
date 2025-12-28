Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56F93E784BE
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Dec 2025 10:08:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZngc-0001Bj-SE; Sun, 28 Dec 2025 05:07:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZngb-0001BG-6G
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 05:07:41 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vZngZ-0000Lv-H5
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 05:07:40 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-47aa03d3326so52476375e9.3
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 02:07:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766916458; x=1767521258; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nFp4oSETAOPHxt81iiTGbUa68jbwyVikoXX7rE9NWmE=;
 b=up8hBFEXvv94b+5qX+wCfFoingueV3egWTiroZUaiS5qZnrnZVgaN2/vPZX/dnPpm9
 0183duOnHL3E1ZnTM10EvFVo956aosp0zHc4Otul8WVDgOvH9iVeY+8ZkZmjYI5HUV1a
 Hs4TNtSxlbVOwJBqPvkAsLMds9lI7cc+aViR0Og2jXxbjobUMQZr5QBp4UtS0ls70hi3
 iPkFxVnxAIpVy34JOUbpf2d9txfHINeV6GJ++4k+en9adf8sryrts5RRNlS/LIKR8j9i
 RZ8L5bouWbuuAq3Qzg9mSxc6GEt0TowgvbXsT+9Rc8v3b4xiYP3i6WPMmyYjig1cHn4u
 PqRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766916458; x=1767521258;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=nFp4oSETAOPHxt81iiTGbUa68jbwyVikoXX7rE9NWmE=;
 b=PL5gFJDtyFRfZD+wr9DXFQ2NGUHVVrjlAr5iLEvov/zg9H/8+DP8cDtl02Pi7nLbo7
 njWOFNn9PHDkbiM06jfPXyYPGEzBzC59NWZkyW1mekSm5I4URBRcb9K+SkxEWGX74RBz
 LrhfHMP5zhPY4nUONo/iln80c2KMB3MRfzYOseaTSW67AE/TptcxsLzBKBLkByDjrBfE
 HLkvLKspfwfGCkpzX1wEBkAx1zp20SMwLOU1HDcT05EiTw/IMUpaS+7h2/x+hUMAiMyw
 F5hnpMmIik4zSHINI+6Ywz1OSndPVIy4FNUSW0cUAesyCKHccLjCe/EOrxOYPRXhSqk7
 A2yg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV4kxa/tajp3MduhlKPWudoOgePnC/pc6FMTnOiLJLRO2zQpUZi95OnE9QeTuTfJBhktVqsU+vk2RKk@nongnu.org
X-Gm-Message-State: AOJu0YykgxJeSZLq4FKxZzAlo1xQBt9oeQxn92FRwLE2pWWgVeCkBUbZ
 WrgRklqJRJwhTtekSSocXl7E4S5pNBtjNObA4qyvbhrSGTSpZGwAsffYiG7XGdgD4ak=
X-Gm-Gg: AY/fxX5C1u0fiRlFJWmYbbsCTdGDcmohjkjNWG4L8Ftl2CCEmEBxy3fPmQZUMHkVJSD
 ARlNZ8yDo8G6yQ3GWLXulwGM8HlE7LEqCjhw7eWlGERWh8/HS3WnW3CBrjtTNBOwc6S5W3V9Dtm
 SwvdU6xG6uARqFbcDg6ClJiqNVI5iXVj7AaFzVjAnyZeVdREBIvSaSzYnVU1T++3yAtBkFfyyFq
 aSd94dd1A0UTJ6KZgmi7M+9pboMt8to1l4ZjCI+xfqkBBRXnSnXycUBRBqlA3BqlBMnzapjsW+L
 ku1A18/Cdvp+CW0t4QwoP4trhJJBlI7NLUFDPk74XkssYqul/NUqIzLwwpGuWU2IQrfQ3YDZreO
 x03bsP96Wea4yzgPJQ5JlnOkx7FQbFi11KRLOvylb34dsPy7ZbRjTPSXswV0iMkDnXlqgyn+w4g
 ytnrPkCEasIdNceOtUwryMd0rGeW9O4BDckm/SPhVGn8QboV68HZlTPOZ7LD0Ddlz8a2ekicTH
X-Google-Smtp-Source: AGHT+IFPHNViaNB9QW/+tLRWmf9jjgRtsqSc4cFKazD44OVCrkkjnXEhz30yC3is1upBnNEbzcEQRA==
X-Received: by 2002:a05:600c:3489:b0:477:7ae0:cd6e with SMTP id
 5b1f17b1804b1-47d206a9856mr267842465e9.5.1766916457575; 
 Sun, 28 Dec 2025 02:07:37 -0800 (PST)
Received: from [192.168.1.15] (alyon-655-1-564-32.w80-9.abo.wanadoo.fr.
 [80.9.105.32]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324e9ba877sm55445658f8f.0.2025.12.28.02.07.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 02:07:36 -0800 (PST)
Message-ID: <422ae192-4801-4f5e-b649-b8106fd79162@linaro.org>
Date: Sun, 28 Dec 2025 11:07:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 153/153] block: rename block/aio-wait.h to qemu/aio-wait.h
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
 <20251227094759.35658-79-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251227094759.35658-79-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 27/12/25 10:47, Paolo Bonzini wrote:
> AIO_WAIT_WHILE is used even outside the block layer; move the header file
> out of block/ just like the implementation is in util/.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   MAINTAINERS                        | 2 +-
>   include/block/block-io.h           | 2 +-
>   include/{block => qemu}/aio-wait.h | 0
>   block/io.c                         | 2 +-
>   blockjob.c                         | 2 +-
>   io/channel.c                       | 2 +-
>   job.c                              | 2 +-
>   net/colo-compare.c                 | 2 +-
>   net/filter-mirror.c                | 2 +-
>   util/aio-wait.c                    | 2 +-
>   util/vhost-user-server.c           | 2 +-
>   hw/display/apple-gfx-mmio.m        | 2 +-
>   hw/display/apple-gfx.m             | 2 +-
>   13 files changed, 12 insertions(+), 12 deletions(-)
>   rename include/{block => qemu}/aio-wait.h (100%)

As in 
https://lore.kernel.org/qemu-devel/754c984d-9082-49eb-8538-23e746d6a126@linaro.org/:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


