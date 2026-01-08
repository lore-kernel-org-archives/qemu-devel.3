Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2344FD1D48A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 21:21:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdxRc-000208-90; Thu, 08 Jan 2026 16:21:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxRa-0001zs-QV
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:21:22 -0500
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdxRZ-0006JH-AS
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 16:21:22 -0500
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2a0bae9aca3so25879595ad.3
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 13:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767907280; x=1768512080; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yF/8qe1ax2t2PVDAt9yS+dIpA3BjKdig7t3Adu/PwTQ=;
 b=mupcQ5ZdU2HPoy9Vrwi+XUyL9Uo8QzKrjnksAEg8sMdOZaQQVb9nwSfKNPDb9AhFlj
 kLx3WxywRy5HFsTpaHrWsjqG376ipktUbh8rLNYfOowPA2XmyEcZyqwEs8ewV7nIpHE+
 /Qf51c8fNam7IskawbgbkCc/yjM7atWr67O4YSXVW45zosQl86YTr8xJecV/QJulm1wN
 JVbtHotBFRevIGUMNLEPbDdVnaPbN/Op8473HoJur3FpJC6UkBmf4iDlkBdpyWROm8ex
 3l8eD/5vlvFrGYH+9cncghOz0iKagD5G8TICR1guwcYCZFn9ppb3gXLIr00mcLg9hf7Z
 xjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767907280; x=1768512080;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=yF/8qe1ax2t2PVDAt9yS+dIpA3BjKdig7t3Adu/PwTQ=;
 b=XKyyl+/pGbtZDfDXjyrMEJqze7eU6o8oKy5CNg6GsViIJ4GfnsRdYrbVReG2hLsVjM
 OX7kx30t1/fV/REuQI2cQb/DWgZQSRXymvrDO0NFeMvvkycQ/bUduGDPZs5G8Jh/cNhF
 W8eXiFzynnbXsxhKXPwdG6UMvv4f/Q2vCfaaosPVG64UGWZn5aBEDiF8Ztc7Y0sXpF3F
 F5H9z22vJRyy61Q6CeZE4ljN3v0OcNkXlrpmG7X3r3cpfYiyeVuI2ktleawB1uU6sXIU
 JQ/pA93Ox4HxDq4c+Eioz5SmeTNnjT1Nq5Ji+lKY5PFLkgqmkFj/CNIKWOGX+Iug1aCl
 y8gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUv3eIZulV2oSsu1Cu4rUdJiJgTg0tSJeF3huPmz3DdqbDpbmZo0M2IXr2FWi6p6jg4xQlBRh6KhMRg@nongnu.org
X-Gm-Message-State: AOJu0YzgejZRT6R6pEBIUVgXN1ztoV3PWGwagU79SIgWy9btDCxMHZPx
 C9z9PMgfHdZVZrtC8MV+JQ6kuVoRDRSShtqscvlls/sZY89SZOYCK5n4bUYBzqBJkuPRLaxfoiN
 uEcko
X-Gm-Gg: AY/fxX7c1wPEe9IB9UYxTJ2p7fLn5UWGcT+lKSlGf615FaGzunlzV5i4yA3XwD3bNtE
 etMxWYkW154zDNZFqRYgd0dU77O3ku3av8Ip0Hbdn3vXfXIBJLLPpWfeTmAUQJ/oG0pFshbGaUB
 WXWMzHOTAiZTS8xeE0h2Iz5e53MNxMjsH49EvZMR48Ysz9ZVNCzXILYA3gYciAIdodRBVggTIDz
 lwimHoi3Qu1YM36IbYsLMQ1E9ln+BcUsEUsMa/AJlwG8KuOpty8SRZj3xSgg9AZApzp7lf0zXvk
 iE8Tfq66Y3apqHMEgjcAMg7KSxWgawWTcFen+VTC4srddwiyWRXBGLsKFMnsbOXW3ktT2t/wNhP
 dLRmFaxFMKFe0tvKkW6IVV+k35+qhlq+EPCUcxON5L/KyNflpXY2Nb4chkc/xeqY/RSbum4gQ87
 D74OmeT0fuVsQVc6ce6DNa/KkhCPjqK1ofnmJg7IJ7q3Es5wO4b3qiGJR7
X-Google-Smtp-Source: AGHT+IF1gg2hl2nlaAGDm62IfSDjkLE71nUWrpMZOOYs+TgLOHvC5+jUyH16dPEIlR7IZZvOdnS8rA==
X-Received: by 2002:a17:902:c945:b0:2a3:6b54:5d42 with SMTP id
 d9443c01a7336-2a3ee5072a4mr77453055ad.59.1767907279722; 
 Thu, 08 Jan 2026 13:21:19 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cb2c0fsm87103555ad.66.2026.01.08.13.21.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 13:21:19 -0800 (PST)
Message-ID: <b9adb8ff-29a1-4575-8efe-076566c23701@linaro.org>
Date: Thu, 8 Jan 2026 13:21:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 45/50] migration: Drop use of Stat64
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-46-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-46-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x631.google.com
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

On 1/7/26 9:30 PM, Richard Henderson wrote:
> The Stat64 structure is an aid for 32-bit hosts, and
> is no longer required.  Use plain 64-bit types.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   migration/migration-stats.h   | 36 ++++++++++++++++-------------------
>   migration/cpu-throttle.c      |  4 ++--
>   migration/migration-stats.c   | 16 ++++++++--------
>   migration/migration.c         | 24 +++++++++++------------
>   migration/multifd-nocomp.c    |  2 +-
>   migration/multifd-zero-page.c |  4 ++--
>   migration/multifd.c           | 12 ++++--------
>   migration/qemu-file.c         |  6 +++---
>   migration/ram.c               | 30 ++++++++++++++---------------
>   migration/rdma.c              |  8 ++++----
>   10 files changed, 67 insertions(+), 75 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

