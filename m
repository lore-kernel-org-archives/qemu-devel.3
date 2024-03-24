Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0EE4C6FD1F
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Mar 2024 17:22:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roRWi-0006o7-3u; Sun, 24 Mar 2024 13:20:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1roRWe-0006na-KH
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 13:20:52 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1roRWd-0000mY-6k
 for qemu-devel@nongnu.org; Sun, 24 Mar 2024 13:20:52 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1e0025ef1efso20834925ad.1
 for <qemu-devel@nongnu.org>; Sun, 24 Mar 2024 10:20:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711300850; x=1711905650; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IllBLdIzxA15Qa026XG/E2jsLbE3PsU66Vj11aA5tnk=;
 b=zX+75vSr+79LNW8zBs0JUY6Zxn0leCjpXCTrcnKEpd3W9Fmz7HaqGdDdzXMqhFgbLr
 LuRmhQBGipBPnmM3BodwjhoUkpi4tV5PSKT6t3uoZc/DzYMuDDpBQsVRTr+jHlI8B1LQ
 zki8KZiW2kNg4hp66LXBMeTN9J1aengRhn2lWuDOYRpoK9+j8xG9miTkAHaiESrE7Cth
 MJQpfg/8+3cMJxn7z2D79nIb17ivtZywFBpua7bf9Ubzbst/d48q+evo9ZXFvDVndNg8
 v6WWOkmDUyKuzKyZ+4Ab5XFAHU+biegdpUdNPI8eM0kXy9JHyf+QYdi6yYA+YQq+7cy2
 qkkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711300850; x=1711905650;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IllBLdIzxA15Qa026XG/E2jsLbE3PsU66Vj11aA5tnk=;
 b=amo2CmG0CsVsESK6aPRwNO4zMwQWDXeB20x02dzhpAbtgifvSsaLdZmHwu0VnPkG1k
 peGA+E7uFn/CbVtNFFbG45pHzA1nzxjOrewaiEreM1ZH1BzW3dIWxZJMDC/Uj3xjjzOn
 ohQCKUz0r/Dor/2T2jWJ5wOWzgpZmrLA7igZPPbf5MplmoATx7T7TFbnEpN2xUA6q32O
 M2uIafWwo3aBSXsMTM/DnwWjUeELuXrQpvXAHpXAhuvP9lzt0FgnckpH33lt7Eym8HmU
 Qshv3L+7Y5Y6hnCX3hqPOcRHd6XRAMD58nnt5DYFzOa0DIxVJo2sr55to2zihwHrF8s4
 kdwg==
X-Gm-Message-State: AOJu0YwnZ8CTfL/4sO8cjonMhM6E4TXxBWjx/RKbJnKONRlFxENV/PrH
 VrtGsIQ+m1IeMHSyZc01+gcUEvogit/r1NmrT6bKIcFN2SHUfRsXJPEkd6hOtI/o16ZOxu7vHei
 Q
X-Google-Smtp-Source: AGHT+IHNNIB3ZClft8CTVlLrlfptpuNqiF9ou82medmQR+YUWwlX/dMH7Bn6GQ6OOxx7FzduJeO1yA==
X-Received: by 2002:a17:902:e5c2:b0:1e0:282a:2714 with SMTP id
 u2-20020a170902e5c200b001e0282a2714mr5306216plf.23.1711300849908; 
 Sun, 24 Mar 2024 10:20:49 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 y1-20020a17090322c100b001e043df262dsm3275112plg.33.2024.03.24.10.20.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Mar 2024 10:20:49 -0700 (PDT)
Message-ID: <f28ad059-38a4-42e6-a2e6-2a4cd34e2e73@linaro.org>
Date: Sun, 24 Mar 2024 07:20:47 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] target/hppa: use gva_offset_mask() everywhere
Content-Language: en-US
To: Sven Schnelle <svens@stackframe.org>
Cc: qemu-devel@nongnu.org, Helge Deller <deller@gmx.de>
References: <20240324080945.991100-1-svens@stackframe.org>
 <20240324080945.991100-2-svens@stackframe.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240324080945.991100-2-svens@stackframe.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 3/23/24 22:09, Sven Schnelle wrote:
> move it to cpu.h, so it can also be used in hppa_form_gva_psw()
> 
> Signed-off-by: Sven Schnelle<svens@stackframe.org>
> ---
>   target/hppa/cpu.h       | 10 ++++++++--
>   target/hppa/translate.c | 12 +++---------
>   2 files changed, 11 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

