Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961FAC9830C
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 01:24:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhdzn-0005yY-Rn; Sun, 18 Jan 2026 20:23:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhdzl-0005xY-Qs
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 20:23:53 -0500
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vhdzk-0003yk-Bs
 for qemu-devel@nongnu.org; Sun, 18 Jan 2026 20:23:53 -0500
Received: by mail-pj1-x1041.google.com with SMTP id
 98e67ed59e1d1-34c24f4dfb7so1915706a91.0
 for <qemu-devel@nongnu.org>; Sun, 18 Jan 2026 17:23:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768785831; x=1769390631; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YGbFRQD5bX/ONDxQrenRcDDIoENVan8aqKAztSvypmw=;
 b=uzX5YBMK1r6SP0MDpx8YNP0xNdbhlzthOcSN6VW/7EFzhN4epg2UjMzZyWM0RinOg+
 SvYbyYYQ5KGBv157DgYmaK1JSwGXPWWGwmBEz+3Hy98Urtw5JdN6kkE5QLCTElf/mzan
 tgOZ3ACWjFKi9wgzvP8sWMt0VWq8C8SV9UCKhYRMw6Rmqed5QClOvj1lZGw3FPT8qyIS
 VlwcPODeRzCviLr5SL/veLqt+zSge40SzeWjp2jdsUCxswP1pxrnlXbRps0KFI9Xi1uY
 dGqx99H/tq+FwyVxWH/Tv0sg7CZnBN+7jGjAyFB9VycBuA0hZQwisVtCdi+qlgvlo9Sz
 XzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768785831; x=1769390631;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YGbFRQD5bX/ONDxQrenRcDDIoENVan8aqKAztSvypmw=;
 b=e7ydxBBY/29HA33e8bS+22ebtHf4gJKp11dg9275mMul1NcYeGAHKUytnT+EFMzf0m
 dzEITFKxHSUXBi5rC/1EeVX4KeBrFGQimYLl7AJ6bfH2MkfWxAs+EFCHoBZeQLvUd4wW
 aBcioevV0+BA3hFP4l2X7N2zRzWi0BrD20MSle1F8JbQrRUppwWQODiRBMLcfkXnTUHK
 PhQJMb2dhPcox+zRbb7evyar9Yv/bVL/x0l0MxDCx0wPgPdPhhaKbJneO/YwqKu5AAXk
 a5NK+eAa3WKrzYx8/4jZ0Zpiy3Y98AukHGFMm1i5qnCCwmvdI0/1QuxlX1ZcjQl62TdJ
 wg4Q==
X-Gm-Message-State: AOJu0Yy4FNzAlDR4Dstf/PzoaOEZZ5+FKegwqCR9zSI58MAFaTBpzU3d
 ZCXhqS8FDmqUXizyLD/q/kUf/VAUXnzttxFMvi6f2Fzi5JmJxBvcUZpWXxCtVbTFUgnWo1/nFDT
 dF7bzBBObFA5l
X-Gm-Gg: AY/fxX6WjgtJX8UytJhLLw43iwKXmY16k3barsA6U7Hup8c4QDuCfIZ6KqZPQ7fI8N1
 2iR16IPuOG5gl718aoI/T07vsUWS8yyZktfjDU/osywOtrZT1onpoB6gDTKanVoMp9hlw61hch2
 E8gIOpK9PK4yGdF21jmIl3SJBhdRxA2u0e73qVuaFIPnHAaAOra859LIoDqzjeQD0oSJLvnYdEQ
 Vp+tQqxYvG4f+N19yQOn5nr76iuDR2cfDW8V5McY3gDTLggFdk0XP7W0AMkVgF38BFewb90XXT8
 G9D7nOIJJH7UQ7fgi4uNpYmfK6nBB2XNFpEsyfsPDfvZ1GHOzuvrGl5TMSj674neexr466aAe28
 r361aJy6kETCFu0ViJ3IDmsNLdQ/i+JjgeUn3PEcV+FGBZIj0k5Pz4EwJjZT4cZ5I7CQ2RrFpAh
 CrBHBgP82QBBaqgen6emj2dM3ZWR3ACQ==
X-Received: by 2002:a17:90b:3cc7:b0:340:b572:3b7d with SMTP id
 98e67ed59e1d1-352732559d2mr8031415a91.19.1768785830246; 
 Sun, 18 Jan 2026 17:23:50 -0800 (PST)
Received: from [192.168.10.140] ([180.233.125.201])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-352678af03csm9997067a91.12.2026.01.18.17.23.48
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Jan 2026 17:23:49 -0800 (PST)
Message-ID: <88079392-b423-4ee9-aae9-72cafaaa086c@linaro.org>
Date: Mon, 19 Jan 2026 12:23:45 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH trivial 3/7] linux-user: assume inotify sycalls are always
 present
To: qemu-devel@nongnu.org
References: <20260113130008.910240-1-mjt@tls.msk.ru>
 <20260113130008.910240-6-mjt@tls.msk.ru>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260113130008.910240-6-mjt@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 1/14/26 00:00, Michael Tokarev wrote:
> inotify_init() and other syscalls appeared in linux 2.6.13,
> inotify_init1() - in linux 2.6.27.
> 
> There's no need to check their presence on linux anymore.
> 
> Keep condition on TARGET_NR_inotify_init because modern
> architectures have only more generic inotify_init1().
> 
> Other, not linux-specific, places of the code checks for
> inotify_init1() syscall only.
> 
> Signed-off-by: Michael Tokarev<mjt@tls.msk.ru>
> ---
>   linux-user/fd-trans.c |  5 -----
>   linux-user/fd-trans.h |  4 ----
>   linux-user/syscall.c  | 19 ++-----------------
>   3 files changed, 2 insertions(+), 26 deletions(-)

As Peter mentioned vs patch 1, the relevant version is glibc 2.4.
But again, well within the minimum supported version.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

