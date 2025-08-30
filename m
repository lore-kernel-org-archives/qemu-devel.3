Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33C41CA0EFF
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 21:54:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usTVs-0001Dn-7E; Sat, 30 Aug 2025 17:53:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usTVp-0000yK-1V
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 17:53:29 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1usTVn-00079D-6H
 for qemu-devel@nongnu.org; Sat, 30 Aug 2025 17:53:28 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-2487a60d649so37761415ad.2
 for <qemu-devel@nongnu.org>; Sat, 30 Aug 2025 14:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756590805; x=1757195605; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q0CmiC0LwBGPgM8OTkGIpCwQdrlN1liKSx+3ERgIUT4=;
 b=aQBqaTiRkIiqcMnFmFxX8RfzwTk20P82tmOXrrbs/BrSEuA1gJrDxZUZETrVsrAZce
 O952ITPDmnGNhWhY9K3zz97OM3qux5PFU+t+e12bH6LAdhT51eNqc6MY5oUj4KKIu6Kt
 EZsXN4sD3jI12+JKPXWb01ZVOwZe7RtIJwS94OgU/3t59XSSnYV+CwrZrY9y27l1psGd
 3p+ifHR+QHJu2IMtY6VLCbkUjk0jEAlIqgK/N//+ndFT5POoJaFieV3JWvRywtbosRAy
 OgoQrNdaC4lcesg/KZXxe/B7a+GufHR+ZK85+/mePgiwurUu1l9n+VXyPRu3qda47qie
 xLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756590805; x=1757195605;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=q0CmiC0LwBGPgM8OTkGIpCwQdrlN1liKSx+3ERgIUT4=;
 b=gSbE7GIfgMsKw8GH06xptYmkKT4eN+trXzVopmQIP1szHU8vkSjjRvpL1wCQJjjIHS
 PaamIO71ucvLDDMf30TLmgAtstoZ/n2dbqnMUbJvo1NIi8VmlUZs+gBdLLLK+XV1yLR2
 RW3TzR/lifj41Itf8w0zLuu+eEUA43PNqVHvuL52e7gvkIFKGQfEViU8Z6Gk+8eAe9X4
 wS7DzF4yzGEJWPoWq/fjUQfJORWuLwK3MOti6UJNguvwXukvvPx9pdvJOM96ZpZu1QCj
 ZzJk1Z+nqR0I4YGz4YfThYhGDzeFH7VbpF5nEZfVl0OmDfgVCqn2hOUEHgLVT+hJCSTz
 CDTQ==
X-Gm-Message-State: AOJu0YwuFsOdTsjnoWkp1VHmq4S9LqDfcYRMXrLbqynetuIjdv8XrpGF
 x7A6jR1C//kvOGKMa+rhmo1+gU5Twj4lzH6JpFQnus7/C6Xv9kTIeENzXkv/gyQ15LgKApVlRzY
 P4DOfZ/8=
X-Gm-Gg: ASbGncs8ddGoFLBbtUH2IKVNUIl/hTwNHs7JIsoDEuqCmODjG9dmnenQNv88gwQ3rSI
 2SZBaNSfgoTOeFa+dVhplO8EvqTHEV9wOGUUQYkbRzUJXexWu6dBKX8E9qCXk4an/f99inUaqPW
 f3+NF67aw5V+uf1tez6b6Wl/8LAzNNeDd+fGnShubVMYwnzRyCRsgbTgd1PWIwYyH40VTbpqknd
 Os7Y6AuoA0zmbXNslm7gqrWiWlrtCIj9ujr7LPEfGo1C/Xp4Hn0dbAekEyuuCOa9U56wKmlutkA
 0GncCUWh+H7BZQvuxG5ylFbJNsIebPebOL9fOUYAg/9aEERHOeF2GrBBxzLtKlUXwMNwI99nOCm
 ArVxGUKFgnG0muVfnRgWrfgAewnco4r+ivCBiAVBMy3bK19V7wAMj/+K60vQEiMDR/aidiisx
X-Google-Smtp-Source: AGHT+IH6jC8qwXtKUyR8fuYDKDFpQwwnKg5JtgXmjCVsy2l1+/O+slEPGNpUPsV9Ym2nOpSxl4iGKw==
X-Received: by 2002:a17:903:380f:b0:240:a889:554d with SMTP id
 d9443c01a7336-24944ae4ce6mr40054295ad.45.1756590805092; 
 Sat, 30 Aug 2025 14:53:25 -0700 (PDT)
Received: from [10.118.1.198] (122-150-204-179.dyn.ip.vocus.au.
 [122.150.204.179]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-24903724c62sm59976085ad.34.2025.08.30.14.53.23
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 30 Aug 2025 14:53:24 -0700 (PDT)
Message-ID: <76dd4881-73dc-4849-9958-3d4ff73f8a38@linaro.org>
Date: Sun, 31 Aug 2025 07:53:19 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] user-exec: abort if interrupt_request is used
To: qemu-devel@nongnu.org
References: <20250829111110.1490546-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20250829111110.1490546-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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

On 8/29/25 21:11, Paolo Bonzini wrote:
> cpu_interrupt() is only called by a few user-mode emulation targets:
> i386, ppc, sparc, arm.  For all of them it is dead code:
> 
> - i386 uses it for the A20 line
> 
> - ppc uses it in cpu_interrupt_exittb(), whose uses (but not the definition)
>    are guarded by CONFIG_USER_ONLY
> 
> - likewise for sparc's cpu_check_irqs()
> 
> Arm has various uses in arm_cpu_update_v* and omap_wfi_write, but they are
> also dead; disentangling the various cpregs accessors from user-mode
> emulation is a work in progress.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>          A quick and dirty patch that I'd like to place before Igor's
>          https://patchew.org/QEMU/20250814160600.2327672-1-imammedo@redhat.com/,
>          to document that interrupt_request is dead for user-mode emulation.
> 
>          v2 ofhttps://patchew.org/QEMU/20250808185905.62776-1-pbonzini@redhat.com/
>          will also remove callers of cpu_interrupt() treewide.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

