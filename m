Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1A76C67861
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Apr 2024 19:32:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtBkz-00085d-BP; Sat, 06 Apr 2024 15:31:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtBkx-00085E-RC
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 15:31:15 -0400
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rtBkw-0003w9-55
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 15:31:15 -0400
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-29ddfada0d0so2336135a91.3
 for <qemu-devel@nongnu.org>; Sat, 06 Apr 2024 12:31:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712431872; x=1713036672; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=O25aDOiQ5nxrYfnbZUatCdwGpH0PxjWzG6UWLimr87A=;
 b=PcHIuZ7GMFkQnGjv3/R2XlLHzsoNyaVZVDsZq5TiQEO6azxtPPnzs/iw6K3tF4AFyy
 tSJVbQ8PYWRkAOJ13abQBamSKXldLTX57Cb5xoiqORcPUjMF0+KCG6R9pA+51APwALsl
 0kXTLX/z+mL1DIQzILU9FDfnxvFt+7ItrKO/wph/xS9BMDDCwVeMef8OI80h3LQFaSmR
 l+1lwlv/XUTM6hzuolT4+a0sBrbUSUxy0Go1F1pSXnrx12B2N+tGqkDqlXE8riV1CqOJ
 vHZJfCfDwqOL1FbV3SrFqqhOBxecoeUlo5erJ0yW7NJiDj1jJ8nTogaHXTe0zVaJPOlB
 Ew7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712431872; x=1713036672;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=O25aDOiQ5nxrYfnbZUatCdwGpH0PxjWzG6UWLimr87A=;
 b=ZnSSNB4U8MOLMzAD+W5sMmiXJiZ7CRqr4Fl1WJYxUEmeld78TfkgizskxxHsxu7SHq
 VdIfyzOCMszMg2nEItSIo4P1lZ/v0SXQgc9mecwAYs+Q5l0233iBXH54Ek8s3Kq6eLLq
 KaSCIBWSxlQrh5URJjCQ11yqMRbgBZFNB4f//O8cZNtQ88XfqJ5MUGM63Gw0tlvkl7Z6
 2I+LTjE4owBgET4T48nhzxBdn71wel6UuWDZmfZ5J8KwcrkOThEkT4Mg70hW5qeatjUG
 MncsyT260t3BhhfO8Jvuhj7X3NWKKDe/nsYHLmDZ2F/SV0mobR6T6QZD7HFdhibDhopS
 sbRQ==
X-Gm-Message-State: AOJu0YytnkpuqLdAJR0vEPs1uibN4K6XUDmB5wYqTeTG5XMhPyoffL+m
 q90LEC8r66kkM6ugn4TOMXAidGkpW67muSfdvEHN64KfxJpFIILDT3SU3+Pgln0=
X-Google-Smtp-Source: AGHT+IFAX3hU8Vpqs+6Oh3yAUNNkyv5pM0wXjcqrvCaPYt1tqFl5QlZcQDn+k/bZ+ZxnLD8Z2t9UVQ==
X-Received: by 2002:a17:903:22c1:b0:1e3:e4ff:7054 with SMTP id
 y1-20020a17090322c100b001e3e4ff7054mr1290302plg.38.1712431872090; 
 Sat, 06 Apr 2024 12:31:12 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 y4-20020a170902e18400b001e0287592c4sm3746012pla.267.2024.04.06.12.31.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 06 Apr 2024 12:31:11 -0700 (PDT)
Message-ID: <d7fdb4d2-afab-4379-947c-d8db7c1b2830@linaro.org>
Date: Sat, 6 Apr 2024 09:31:07 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: replace calloc() with g_new0()
To: Nguyen Dinh Phi <phind.uet@gmail.com>, Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org
References: <20240317171747.1642207-1-phind.uet@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240317171747.1642207-1-phind.uet@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 3/17/24 07:17, Nguyen Dinh Phi wrote:
> Use glib allocation as recommended by the coding convention
> 
> Signed-off-by: Nguyen Dinh Phi <phind.uet@gmail.com>
> ---
>   linux-user/main.c | 6 +-----
>   1 file changed, 1 insertion(+), 5 deletions(-)
> 
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 9277df2e9d..149e35432e 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -928,11 +928,7 @@ int main(int argc, char **argv, char **envp)
>        * Prepare copy of argv vector for target.
>        */
>       target_argc = argc - optind;
> -    target_argv = calloc(target_argc + 1, sizeof (char *));
> -    if (target_argv == NULL) {
> -        (void) fprintf(stderr, "Unable to allocate memory for target_argv\n");
> -        exit(EXIT_FAILURE);
> -    }
> +    target_argv = g_new0(char *, target_argc + 1);
>   
>       /*
>        * If argv0 is specified (using '-0' switch) we replace

Queued, thanks.


r~

