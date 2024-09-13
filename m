Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7D66BFC6181
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Sep 2024 20:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1spDFx-0000d1-To; Fri, 13 Sep 2024 16:51:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1spDFw-0000Z8-So
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 16:51:04 -0400
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1spDFv-0003eh-8A
 for qemu-devel@nongnu.org; Fri, 13 Sep 2024 16:51:04 -0400
Received: by mail-lf1-x134.google.com with SMTP id
 2adb3069b0e04-5367ae52a01so1918479e87.3
 for <qemu-devel@nongnu.org>; Fri, 13 Sep 2024 13:51:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726260661; x=1726865461; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ga8ChKjTc49tZRld8xth2Qy2W/qx0QbnLXgUkw8VrsM=;
 b=T2I3U13pJH6bxD3uOv2xm0f2dx/fUR42Yua3+5spJM9udPYy9oNWJCQSesVKsoaLS2
 uGK00JmXeKdN8PBs5fviXuy1pMWblgSPGqhsNFx4GDE8BGgbQgqUITn+1otoxGieBhid
 Zg2Rf/qMKGRXbWBwgxVozFYpJRa5IYnxuJrDFK7z9sitLUCQyFE2LUZmVpyJMmGjMb0E
 WWl8Dp2lLPLF+YD72lneTm87nqYAz8iYXDS4Xe0NmHDJPy+9nNrgrbGp+VvbfyF+FqXb
 f80OKZof1QhjlkotKwX4TEgH4B1kQNL0uzRdkIRHH31RcnTQqtBNRcAps9MKtPFihLr3
 /duA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726260661; x=1726865461;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ga8ChKjTc49tZRld8xth2Qy2W/qx0QbnLXgUkw8VrsM=;
 b=aDj59mpDfCCLJtFgcuOKz8p1r6CpjKqmWfTdrs7XWMiJLIWyOy+FyaRS+3HU/veUl9
 QjfJkAkKLOdUCU9OAVbrIgeVG2pH6pouUkPpqhyS/BqQ8L+4Emy1qF9KqSmdPXqtF2kz
 fNs9juIhA4eFie9hv0tZWeSltMNJidOKEFXUvwAkTVg3MNXvHm1lg8rApYeOEFvga7rJ
 7iiMhNhtOhC/qIy7UOjSFv2WdAxvZmR0fh+FIMQYv1CtMR0p6WzrVn3zIGyKmxdjh1KK
 NdjZO6Ao6Bc8WH78YBpNBkXyHJubSXWGV4G5SGRg6NqzmU+E/ecmSxdvcH+xgbT/bxGm
 7tYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7qq9vMBsmIgocEdypyXlpPcq/femC15SKfirAi37+kJc346LyjtWkHH0a1Xj0YXTWhZtuOsWtTo3/@nongnu.org
X-Gm-Message-State: AOJu0Yzcm/0Ct2nqlhBJUfBX+FdlIn6FCM9VMZv+lUjKTZ6JsBEg9AvL
 /syS/UxNyO6ce/08QV/2ke4TnpJNTlMRY4r1nS20GVx0GiHSIXtvaUOPPmZvf7mtYHF3GEHEx7l
 3
X-Google-Smtp-Source: AGHT+IGpKDbPKQ1boWHrbCRsB4H7b2nvZO6yjPmDcctYi+c1edXzFi1yxMy8crXPlkZHReAmCR02XQ==
X-Received: by 2002:a05:6512:2391:b0:52e:9382:a36 with SMTP id
 2adb3069b0e04-5367fee6c57mr2991141e87.30.1726260661188; 
 Fri, 13 Sep 2024 13:51:01 -0700 (PDT)
Received: from [192.168.69.100] (uni14-h01-176-184-39-243.dsl.sta.abo.bbox.fr.
 [176.184.39.243]) by smtp.gmail.com with ESMTPSA id
 2adb3069b0e04-536870b8cd6sm21455e87.290.2024.09.13.13.50.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Sep 2024 13:51:00 -0700 (PDT)
Message-ID: <dc9e2f27-8566-4dec-9e6f-d7366f55e1f4@linaro.org>
Date: Fri, 13 Sep 2024 22:50:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] tcg: Return TCGOp from tcg_gen_op[1-6]
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, pierrick.bouvier@linaro.org
References: <20240910212351.977753-1-richard.henderson@linaro.org>
 <20240910212351.977753-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240910212351.977753-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::134;
 envelope-from=philmd@linaro.org; helo=mail-lf1-x134.google.com
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

Maybe a line like "See the justification in the next commit"?

On 10/9/24 23:23, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg-internal.h | 12 ++++++------
>   tcg/tcg-op.c       | 23 +++++++++++++++--------
>   2 files changed, 21 insertions(+), 14 deletions(-)


