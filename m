Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92908D149E8
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 19:28:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4Pys-0000dU-0R; Fri, 25 Oct 2024 15:28:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4Pyl-0000YN-7Q
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 15:28:12 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t4Pyi-0004h8-In
 for qemu-devel@nongnu.org; Fri, 25 Oct 2024 15:28:10 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-20cb7139d9dso20792815ad.1
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2024 12:28:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729884486; x=1730489286; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=30f+tu42ZCmJzPXPH3/iD203rT2cgzBRHma0eVrvkvM=;
 b=zhWSi0O79d3xWtvdHUb9fD8gXhHxMSgjhkj/Z6UrfmujHzj7wEOvOQP5Zaf6tQZmFE
 0+kQazwm0LAkwwJNA9ElimsADzYNWkYn5DVg200/HJlXNhkwqq6oM9as6ANfmpqkDFZd
 oZcTSzNN/EMfvv8IaHI/iBwkvbpBURXJHPG4HsWy4bmRzrtuupssgJtGADNMA7iKMyrv
 73UZAOrw2f7jvvHg1ErvL2DS8dQH6hyLRhPRlLj1TE7N0WvIygWSeSHdnLXCjJx9lnxf
 AKKckEv2zrg5Ra6R1ZI1j0zyy9xSZHwJCutZffRIV9QmL24NeIWETDyPttOEtyWrppGw
 uxKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729884486; x=1730489286;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=30f+tu42ZCmJzPXPH3/iD203rT2cgzBRHma0eVrvkvM=;
 b=NmOY7tt8pApaVdJd78fathB8yRH/UtAjfLkbp3mk+JHpf0fcl+/Sx1V50Y6PgE4iq7
 iuxiHs25eH+34er4CgJGoFPRewSjRqOsWLEEBBUGHdd/tIYzRUOtEt07xNH/KvnZT0Bl
 ZswdaQqdhe1bRfA/rgTs29jXt4bi3xo/ThtSIUBeZXDH9qSikZ4oNAalbjmKhuuM5C9m
 sAuKHau1juRzoAawr77nVo4ZI1k3PfNBQdTQbqAR2npr9awfBjR7BYnAEyjJ/8jy9UbN
 mptD9hUVioQGz/nqzWVGqjbMILlZLyJTE/7DHcv2CbzgTpUEIThJBmqPnOgpA2wHixRn
 txfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAGFxWroo+JlbknsBI+lofygFRzCJLUcbTktlxjC3Ol317mDkTGbYN8JsYREXRfJU3/CMt6OY1pOvA@nongnu.org
X-Gm-Message-State: AOJu0Yx7PoF8idK2bA6QaKS0LzpRMlMbojpnM6jIco306c8fT+3Idv8Z
 Rhghq1WRdiYIdzgTLmwhOuGc4JUBfwGVKqfbvSd/h95SaTBFWvcKZvHotNXU2Ug=
X-Google-Smtp-Source: AGHT+IEeFiIxKjm1wUuW0S1AwvxqxMbO07oPOVaaEmVqkzmguq9gzyjJRfaQMsBnX6Fk4nHQBt/qGg==
X-Received: by 2002:a17:902:f60c:b0:20c:f648:e3a7 with SMTP id
 d9443c01a7336-210c6c7048cmr2872355ad.50.1729884486478; 
 Fri, 25 Oct 2024 12:28:06 -0700 (PDT)
Received: from [192.168.2.252] ([201.190.186.93])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-210bbf46373sm12828965ad.54.2024.10.25.12.28.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Oct 2024 12:28:05 -0700 (PDT)
Message-ID: <889b9edf-16d5-4372-92fd-43190ada1c6e@linaro.org>
Date: Fri, 25 Oct 2024 16:27:58 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/21] tests/fp: Explicitly set 2-NaN propagation rule
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Song Gao <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aleksandar Rikalo
 <arikalo@gmail.com>, Stafford Horne <shorne@gmail.com>,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Yoshinori Sato <ysato@users.sourceforge.jp>,
 David Hildenbrand <david@redhat.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 Thomas Huth <thuth@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-ppc@nongnu.org, qemu-s390x@nongnu.org
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
 <20241025141254.2141506-3-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241025141254.2141506-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x62c.google.com
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

On 25/10/24 11:12, Peter Maydell wrote:
> Explicitly set a 2-NaN propagation rule in the softfloat tests.  In
> meson.build we put -DTARGET_ARM in fpcflags, and so we should select
> here the Arm propagation rule of float_2nan_prop_s_ab.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/fp/fp-bench.c     | 2 ++
>   tests/fp/fp-test-log2.c | 1 +
>   tests/fp/fp-test.c      | 2 ++
>   3 files changed, 5 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


