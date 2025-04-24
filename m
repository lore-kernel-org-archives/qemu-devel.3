Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3070C369AB
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Apr 2025 23:30:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u861E-0004uF-Qv; Thu, 24 Apr 2025 19:30:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u861C-0004pk-H9
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 19:30:10 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u861A-0008PO-OP
 for qemu-devel@nongnu.org; Thu, 24 Apr 2025 19:30:10 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3054ef26da3so1364423a91.3
 for <qemu-devel@nongnu.org>; Thu, 24 Apr 2025 16:30:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745537407; x=1746142207; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gmijQUg6qedi/1PXs9n2C3YLgh0edOYmWSOQO05yNzI=;
 b=HsNywNjTvQg5hDiffu4ulSprIRStRm0a8wxUURXzx7Cmhn/V9Ixm1whoKyTHLIY1+o
 h9xRoh7tWhv8BmB4gBHAnBRPItqKUdvI46FHbMKHCWyV2hZjdT0Z1TOCoa3pOaNzvyok
 38VVEl8G78hj9sHONOBmQWsmnFzWzhBKcKQ5ZLo2z7/itgbj451SxbkMhz/V3ZdHtjQi
 QxNFMHxd5746G5J5oaTRiO4pq1zpVpgqoeif7W6ogmfdg0QKsm9Fy041Qh9NTWc+aHHf
 ynOIWTYohI4C1piep7UZ9TMe+0uSogwW4+skk34ufajFCqHM9x+Up6fmJjO4c03YDId2
 pIYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745537407; x=1746142207;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gmijQUg6qedi/1PXs9n2C3YLgh0edOYmWSOQO05yNzI=;
 b=d4Or790C9temaMWNUqcKnu52c/LI2L0zeXaJFELUpxyCCcjnIKOODfLPLLxRHTgL8O
 qWqW1qnGhr+lxPLNR4hHkIYEQK2jGjx/VCmRZP3k2761FmPd3PTH5tLlF2oYuE67n802
 6QXj2W9iBApgVNM2BY2AQ4GPF0r5jlplmkY+YgRoexfYQsq3hotNmV1eBa2rUAuqRqYd
 IPgtqzjOrF2r9/1UWHKN7N9KFlc8+2Wfn+pETI5SMVjpnUSfBwDW/zMv/qd5wOD2tqFU
 J81l5pZgoeQFCwAm/FlQnGX65aoJWi/Y6nezVpKh22jz/hpMwHk5Nv2955sd/ieblpo+
 1J3w==
X-Gm-Message-State: AOJu0YxBADU+V0w0/n8uS9KnTqVxpDbxGhL1tjTCXNEWf/PKYmG2sazU
 gjQOXOIqOMGPma1KrfvOjtYa7bDxnMX1x70iXH7Y1LNsCCBL1RXOdvgc7TG3gQehEneuiPnqdG4
 23x0=
X-Gm-Gg: ASbGncsQuoEeCSr80NNaI7QsGBs0Kx2a8Il5Lz0Zhwn8I1DpqDR0t3UN9omw2euPMWo
 Qz06D9oRn/UQvnRuOZMePVGj6yRSlbhql8bkJ6IH954DIoqfGpipDYNPaE0r+MH/e5XTN/XEDUr
 i/PLVBpEg4DksYeBx6hlayRhUuE3cMHeQyYzfDoNB/UXLCjl1GwWNO1scKWzGDlObEqfVywjYk1
 JeAnBKIUSXY11hi4m/1boxGqWZVlXjhI5794h/h6U6ZbdmhHmDx0CLTPHQq+PpcrxOLmPGGj6rK
 74BTvQZCqEBn+ANUj4m94dFhL2Q+gE8Ux5kqNQtStVBt2m7gDuii7A==
X-Google-Smtp-Source: AGHT+IHq/z2ESaola/00JY0QWo7+AJCgldmBSHnqFfO23MwHqLzex5qutnKf5V0X9FrPoAWVq1F2oA==
X-Received: by 2002:a17:90b:5408:b0:2fe:68a5:d84b with SMTP id
 98e67ed59e1d1-309f7da5ae5mr472534a91.1.1745537407143; 
 Thu, 24 Apr 2025 16:30:07 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-309ef124ce9sm2028668a91.34.2025.04.24.16.30.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Apr 2025 16:30:06 -0700 (PDT)
Message-ID: <81732388-d0f7-4bdf-ac8a-3537276dc284@linaro.org>
Date: Thu, 24 Apr 2025 16:30:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/8] hw/hyperv: remove duplication compilation units
To: qemu-devel@nongnu.org
Cc: Marcelo Tosatti <mtosatti@redhat.com>, alex.bennee@linaro.org,
 kvm@vger.kernel.org, philmd@linaro.org, manos.pitsidianakis@linaro.org,
 richard.henderson@linaro.org, Paolo Bonzini <pbonzini@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
References: <20250424232829.141163-1-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250424232829.141163-1-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pj1-x1029.google.com
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

On 4/24/25 16:28, Pierrick Bouvier wrote:
> Work towards having a single binary, by removing duplicated object files.
> 
> v2
> - remove osdep from header
> - use hardcoded buffer size for syndbg, assuming page size is always 4Kb.
> 
> v3
> - fix assert for page size.
> 
> v4
> - use KiB unit
> 
> v5
> - rebase on top of system memory common series
> - make hw/hyperv/hyperv common
> 
> v6
> - rebase on top of master (now contains all changes needed for memory access)
> - finish making hw/hyperv/hyperv common (hw/hyperv/hyperv.c)
> 
> Pierrick Bouvier (8):
>    hw/hyperv/hv-balloon-stub: common compilation unit
>    hw/hyperv/hyperv.h: header cleanup
>    hw/hyperv/vmbus: common compilation unit
>    hw/hyperv/syndbg: common compilation unit
>    hw/hyperv/balloon: common balloon compilation units
>    hw/hyperv/hyperv_testdev: common compilation unit
>    include/system: make functions accessible from common code
>    hw/hyperv/hyperv: common compilation unit
> 
>   include/hw/hyperv/hyperv.h |  3 ++-
>   include/system/kvm.h       |  8 ++++----
>   hw/hyperv/hyperv.c         |  3 ++-
>   hw/hyperv/syndbg.c         |  9 ++++++---
>   hw/hyperv/vmbus.c          |  2 +-
>   hw/hyperv/meson.build      | 11 ++++++-----
>   6 files changed, 21 insertions(+), 15 deletions(-)
> 

@Maciej, this is now ready to be tested :)

Regards,
Pierrick

