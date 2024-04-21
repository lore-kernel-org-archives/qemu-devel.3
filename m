Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 84C5CC4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2024 16:53:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryaQt-00062b-5v; Sun, 21 Apr 2024 12:52:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryaQq-00061a-Ia
 for qemu-devel@nongnu.org; Sun, 21 Apr 2024 12:52:48 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryaQn-00034V-1o
 for qemu-devel@nongnu.org; Sun, 21 Apr 2024 12:52:48 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-1e9320c2ef6so5598475ad.2
 for <qemu-devel@nongnu.org>; Sun, 21 Apr 2024 09:52:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713718363; x=1714323163; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S5TVtZGaltNicInXlF3zmRiIbJyeBcFpWjIy6Br2PL4=;
 b=xniz1hIOJCLOsK6H4gZueLVShUsojm0KbGD4QiWwdNz/uEPAKxeODRcI8ADNX+35mw
 tJEZuAAS0cxLtdiGS29KiRLW+Cw91ANdInely8W8lU4fY0U8jwaynqT+CPAQzcn51zbr
 ++NodNRViAHTMypPFfVDfTGadqChryFS/6wJFv9ThAQjTfc6QpGIqpN1HAq6HXtfjOFV
 QmV9WNVWwHx0TlSEpSHmMIGqMTuLcF+SwMvwhiIL0y/WJOGEVVen6u9z2FUGc9AcMDgQ
 Ba6zxBu5D0xZ0wFohnVXa+IJ8ES2f3+gDhZAzkjESssZnISZutnNffq4BALSFpbwuzwE
 FLww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713718363; x=1714323163;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S5TVtZGaltNicInXlF3zmRiIbJyeBcFpWjIy6Br2PL4=;
 b=JcqYeJ8f2gy+6DZBnWnKR9K4e3R3E5BACaFl3jEpr+iAulQoaTyZ5dVs9E1++pCr2g
 7u6Ghh0pgmpCKGJXSyJ7q0Y0U3m+DPRzruu8U/OIhAf+J9M65dUh5bCCP0+NETai6UJP
 CY9wY3W2o8fL/ibyymYWNoMv3hR9M4JX7rbTWITs+2+0ryVcxHd76HWcKb7iF/qipgC2
 EGsnrtJfFLIx5zv6cRTBgj1pBYmd7cSusG/Ijst5ysoRVEHXkLgWgpFkzLd6e36jvMAq
 o48vqEdpA7UE3vkmuRSqNG0HhpYLfJZ8FZG4OJd6uAvukvexRfNCguR6/k1iu/2538lF
 VwDw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWwH7Y+RqOhDoHUUlQXY4NCC2KFKzfTf3cJC4DEDc4tMTch0iWUOOlx0zMNOsTXm9wQzmIgsW7mPZEv3HRoPM6VbZDlpsw=
X-Gm-Message-State: AOJu0Yyyo54s7ZXD6cWZsC/KfhsmS6igl+dMjwKDHEI8l/Vz6Bct/dxx
 gA7HQa+cQDoPoUjWLyp6AakFJ3m16nGZ7CZ2YRoytDJ+ToWnzrXC3KZiZj90JYU=
X-Google-Smtp-Source: AGHT+IGgeaVwECaFewtI1rsLqV5j/Iz2o7W4fP9LzR76Gt1hdSJdo8Nrs4odSu3pN3cbYKZ1ed0buA==
X-Received: by 2002:a17:902:e887:b0:1e2:9ddc:f72d with SMTP id
 w7-20020a170902e88700b001e29ddcf72dmr10084005plg.26.1713718363485; 
 Sun, 21 Apr 2024 09:52:43 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 y5-20020a17090322c500b001e2461c52c6sm6505421plg.149.2024.04.21.09.52.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Apr 2024 09:52:43 -0700 (PDT)
Message-ID: <5d092e5a-6999-49f5-988b-f54bbc318d80@linaro.org>
Date: Sun, 21 Apr 2024 09:52:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/24] plugins: Un-inline qemu_plugin_disable_mem_helpers()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org,
 qemu-ppc@nongnu.org, qemu-riscv@nongnu.org,
 David Hildenbrand <david@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Anton Johansson <anjo@rev.ng>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour
 <ma.mandourr@gmail.com>, Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20240418192525.97451-1-philmd@linaro.org>
 <20240418192525.97451-22-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240418192525.97451-22-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/18/24 12:25, Philippe Mathieu-Daudé wrote:
> "qemu/plugin.h" only include the huge "hw/core/cpu.h"
> because qemu_plugin_disable_mem_helpers() accesses
> CPUState::plugin_mem_cbs. In order to avoid including
> it, un-inline qemu_plugin_disable_mem_helpers().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/qemu/plugin.h | 6 +-----
>   plugins/core.c        | 5 +++++
>   2 files changed, 6 insertions(+), 5 deletions(-)


I don't see how this helps.
All of the places that use qemu_plugin_disable_mem_helpers also have cpu.h.


r~

