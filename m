Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49DE0CF2576
	for <qemu-devel@archiver.kernel.org>; Sun, 13 Oct 2024 15:52:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t00sf-0001NL-Sa; Sun, 13 Oct 2024 11:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t00sa-0001N0-1n
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 11:51:38 -0400
Received: from mail-pf1-x42a.google.com ([2607:f8b0:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t00sY-0002Wv-HC
 for qemu-devel@nongnu.org; Sun, 13 Oct 2024 11:51:35 -0400
Received: by mail-pf1-x42a.google.com with SMTP id
 d2e1a72fcca58-71e592d7f6eso439006b3a.3
 for <qemu-devel@nongnu.org>; Sun, 13 Oct 2024 08:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1728834693; x=1729439493; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7ChdzlkrVBxoHIK43kAka5ZHC52qiiS8ZumvrEg/p04=;
 b=ChOdx5X06ibZ6jBA3fD1YaD2amf3WQZwxvRXgPB4MDM/akiV5+eBDYObIZLnWieVDT
 wdRfPgyNjMzZJ0dG1+Zijihmmy3iEqBpUwjYwRyJX+2amv0KoutGC5S8GOm3velrTawY
 itr0PCFBbVIutCTQSWZwVbEwMECoFRTZJ4Q3CxiaEyj3Ry5kaZCCH9onYgrIgguIir+A
 ND4SUmYwNyURgULr2cB3fOBoUe/ryjchjsJzVd4Mr67nBPYB2aPfWn/KG1OGzORaM5MF
 MJoK1st+B6wxTNoTEVGWLk9EH1HmphJOV/KXtbssJ4vn8fjbwgMqdu3LkRCEVvde+IOa
 EXHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728834693; x=1729439493;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7ChdzlkrVBxoHIK43kAka5ZHC52qiiS8ZumvrEg/p04=;
 b=pjRay96Q/F8hRwN6tQ9b6HUqySejE6BDwkyH6CjirXfrJt5B9DRniEu6e6ZP+wT3Fo
 QBNH429UpM25dIAcGV0F0tZkaKGCvLmnzvMxNBhza2RHJNC7o2Q6KG2b9m66uOC8eYu9
 BrERuNVtCTJxTR5xJMnFAzkWMfJc9E8wGGQ6PZ1wMWBkdZDUoIL3flbBHU7sPmYBwFLK
 yNSrnkMWaxDuw/V4tVw4mJhDqmbx++ROSrVa4h2tSIT+6mcEBxKtjOL85aFyWStmKTDy
 RBwNDYUJhSdG9NL67staBH+tOXeC7P8snq7UXdDPCS7VsEAAVvVgT8pYb3hsmVKePO0d
 ptgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXvctZCPWr5m5FesDeDcpO5j0MG5GrFSTz7y0Lh5yzxEGYOYJDADjdL+xF3ahubCpAxm/t4W6IwqUmC@nongnu.org
X-Gm-Message-State: AOJu0Yzzkl98pLkxQ6eHRxoSP6w2QLKNWOdHdHDBdErfEVv60jUkXXb6
 7MPo3Q//JGV9qfTs9Ol1yBrRNFEzCB5gyBj2fAcRmhuL6MtUl61KnfzgZzLsi4g=
X-Google-Smtp-Source: AGHT+IH7ccMrH7NX23FGej0Rv7Ey8IFgxtYxj9huzy+umQ6EJj8mvHJ0VVtECIYCKANdiCVwHa+hCw==
X-Received: by 2002:a05:6a00:4b11:b0:710:6e83:cd5e with SMTP id
 d2e1a72fcca58-71e4c030597mr10396572b3a.0.1728834692677; 
 Sun, 13 Oct 2024 08:51:32 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-71e4ad1b97bsm3162832b3a.217.2024.10.13.08.51.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Oct 2024 08:51:31 -0700 (PDT)
Message-ID: <0cc9002f-7bf6-448a-94a8-3bfaceda180f@linaro.org>
Date: Sun, 13 Oct 2024 08:51:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/16] target/mips: Declare mips_env_is_bigendian() in
 'internal.h'
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Huacai Chen <chenhuacai@kernel.org>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, =?UTF-8?Q?Herv=C3=A9_Poussineau?=
 <hpoussin@reactos.org>, Aleksandar Rikalo <arikalo@gmail.com>,
 Aurelien Jarno <aurelien@aurel32.net>
References: <20241010215015.44326-1-philmd@linaro.org>
 <20241010215015.44326-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241010215015.44326-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42a.google.com
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

On 10/10/24 14:49, Philippe Mathieu-Daudé wrote:
> In order to re-use cpu_is_bigendian(), declare it on "internal.h"
> after renaming it as mips_env_is_bigendian().
> 
> Reviewed-by: Jiaxun Yang<jiaxun.yang@flygoat.com>
> Tested-by: Jiaxun Yang<jiaxun.yang@flygoat.com>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Message-Id:<20241004162118.84570-6-philmd@linaro.org>
> ---
>   target/mips/internal.h        |  5 +++++
>   target/mips/tcg/ldst_helper.c | 15 +++++----------
>   2 files changed, 10 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

