Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FB69D1D492
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 20:29:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdwdH-0002Vu-1B; Thu, 08 Jan 2026 15:29:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwd5-0002SF-If
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:29:14 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vdwd2-00052h-Mj
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 15:29:09 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-2a1022dda33so23255735ad.2
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 12:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767904145; x=1768508945; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PFJlWPWVnhg6k2f5Sg2NYR2Kwsn0/mdT7xEI6H1jq3o=;
 b=P67p5hZi5T0ufISRv1eKPxY9pnX+C7RVY3FIV+jWU+M8ayHsByh22MZ+tM/bq6uvIf
 Q7tZiB14fPsu/o5r2lw5YfFT4SCqVn+gQAvqPXeZGxNGfptWwSrjEWTJqegwowa2cjXh
 UZ7WJhBxlxjSp5HzM4mTnbfbxVHwlmgkD95Kd5XLkw2cQjadEuKKJWMlFt4Wp1QxxmyD
 akxh6BmRKJEpOoMLSQ6KzG3ZmB8F/aXLgXKxmTd+bGpXOpbMR7QoDywFFI0Ntkk1rwRp
 YMi7+0ruV749agV8x05wOrNR8ovKFd7c4L0aR8J99C69iA/HyWtsiwjCvabeYn0NPGJU
 VIrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767904145; x=1768508945;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PFJlWPWVnhg6k2f5Sg2NYR2Kwsn0/mdT7xEI6H1jq3o=;
 b=lFyGMe3eBkjY/RBUYhQ7+H0ouvYhYKdnu04kNQVEeOi2pQMkNJ7AriEtKNKWKIryzK
 U7kgg5UJBda7CXdV0U7jOo/NqOJNJB9eSyM0z7ZMmbeE8rtqm/3CBXyP5MkblXXyj9XJ
 npG/0kqm6tkfDep8ttvIXKXmiBB5RSYY+aBZKSQMs5T7Rlh1IbDkNywG5E9wRzt47p6Q
 v5C2b9xRAKHSko6tbv7THtG4T5nNOMyA82LB2Z7YFU9b3qdRR9U56VQrIdQ6as+IZJGV
 rKUCZAVlLznls84y/fCQrpfMlGzSLOZMdf1lUCohNjb6FoQyCjiNlf8m7LV2KKFI09Qj
 9vSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrqYqIZ5UhjcrAVVgPAhroVC0ZgyoudHcaNO6B4cde62fLxkxB7mf10oJPdtpt/zygwJg8BSMLIh09@nongnu.org
X-Gm-Message-State: AOJu0YyyapxMiMmnZMDPOHCyCf2uD5vor9e/SqR1yV12LzKGOX2F75CK
 jiDhcoy/k7X3JGWAxMWTFGULtvl/gHpjXGvCXKFpXMD5yX0tXrFQ8Q+INI3niN94vHc=
X-Gm-Gg: AY/fxX62K2kTi93Z71sGKF/uR0dpRxUIQ5JUXMPTGCRCUSmQMfUU6xcJDpCYcukdJ78
 yNumPFkRKc7oVkYF8/Y3uq8Eua8Rg7hXbWHNyizay84n8hN6fJU3qin2d2L3WH0nKEouVQEUrlY
 6rjOwhjF9sgx0BSvt1K7zUtl5+VDa3sqC2yABL9zlM/nlJzPCmBnVFY9zZkzn/Gniakz/ct28JR
 K5daZPXPnj+g1RSiMd1H1hYSv6Vd/US/CRqUOynAOC8dfo7rHI4xId7PS+UsAuX8qJEcxdVactr
 LeZzw5OJo7U6a3hx2jHgTmchi8g3nc2V6vk6wQJOP4ADOIHBW9QBCchD8fGiK41+wjGV9rf+ynt
 E6DHMkTdpIcqG5+DvFjh04leJvApEIdpG6hZjN5xLMeZHD0Wn4078DVAZh9tlt0F0JtZvSvwalO
 DVHf5gt2IuMUk//L1NhWuI6pHXkWtZy8YKyCUkNb8aVbWi2Qw1DJ4bxl7E
X-Google-Smtp-Source: AGHT+IGVUyW64QRTMi2iJhO4PeheB0qCvDfIMv6HBUfLY3J3Ras4/H9xqgpbIpoFCXMmVz/dBW0U4Q==
X-Received: by 2002:a17:903:124d:b0:2a0:be68:9457 with SMTP id
 d9443c01a7336-2a3ee4902d6mr59070495ad.44.1767904145233; 
 Thu, 08 Jan 2026 12:29:05 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cb2d79sm87819105ad.56.2026.01.08.12.29.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 12:29:04 -0800 (PST)
Message-ID: <3e4a34ab-af08-41ee-a91b-db247d78fe59@linaro.org>
Date: Thu, 8 Jan 2026 12:29:04 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/50] tcg: Remove INDEX_op_brcond2_i32
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-20-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20260108053018.626690-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62a.google.com
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

On 1/7/26 9:29 PM, Richard Henderson wrote:
> This opcode was exclusively for 32-bit hosts.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/tcg/tcg-opc.h    |  1 -
>   tcg/optimize.c           | 99 ----------------------------------------
>   tcg/tcg-op.c             | 32 ++-----------
>   tcg/tcg.c                | 34 --------------
>   docs/devel/tcg-ops.rst   |  7 +--
>   tcg/tci/tcg-target.c.inc | 17 -------
>   6 files changed, 4 insertions(+), 186 deletions(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

