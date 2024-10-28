Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8E9BD5B874
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 06:18:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5fS7-0002Ck-GG; Tue, 29 Oct 2024 02:11:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5fRl-0001mO-0G
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:11:21 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1t5fRi-0007Jq-3C
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 02:11:15 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-43158625112so51191595e9.3
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 23:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730182272; x=1730787072; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8qkEf8dK2LoXTwdZkSIL0OsQBUwLoP6bNCbrHzs3LDk=;
 b=erzb08nDLlMD+XpmvJJakf7XwgQeia1Yci56VR6Q6DlBmKqDAknGdjratp9qh1nP+E
 ib9+N22spilZagXXI5BpAezjUsHrq44iCdbuN1U3ftGTMFVnLfTQzDIXT4HWdwJncOzw
 /xmYKeEQ66TMXuFaSookbVkhFT9rBU32t8sjw3GKt4QinL1m3OZTNk2zt6RV5mEmWT2q
 AwkdgPrMx6AOdFtNie+YutWhKLsmaAO6xwb5CN5dhZI+YK/+BgUAcL55ZbAfB46TXlV7
 dakrbhWDKzERmuPKXEjW/zS4Gc1JP2/Qx+toWLfyBkxBV+8ezcBOHM5B8GKARB4Cb8Bo
 L9xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730182272; x=1730787072;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8qkEf8dK2LoXTwdZkSIL0OsQBUwLoP6bNCbrHzs3LDk=;
 b=K7eryp1PTkRFbTdYNRvGSpvZXuClYqERjVDUPYipzGe8uUhwEHOnZBfwp2OtHtPtsn
 o/UeDF7+gUT2YFF4V06gLJL8ZTODDZumyCfpQNVqRm0P9IsKcp5LXCmzUqmC+sY8aj8M
 w3V6X1SPv38JgkWCSjiIR0jUkwr6tULN2zTXps5mUflvPzZ6FVQkcWEs2BmNRjdO5Nsq
 GGeDQMFUTLLxftKMgW4Al4GE7l7hU4ilPJ+TxzIs3PusCLBOHYv4CDmGQuP0ZR65FafK
 Pw2F9Sf31a7fA6D1+ANQplqy05qkCkio/1pYd7kDCYoj0sLGLy3HVNhf5zXu4azPlFx6
 fM3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9Hi4VIJUd8oyxWoYyDK60LQebFcx+I8l4dnyG7sNb8FSqWtptGSRT3CzGbnctk3XZ1JwXSCgL9lQ5@nongnu.org
X-Gm-Message-State: AOJu0Yz7+BY4FzsrjAGisptKWg3TEzYjUgLrhS2ooyiAUxTk+xjzV+iJ
 PPtHMHPKm7ryCAlDlJKS6ir40/uSDnRT1JTJFfXpwTC43/je3JFcu6jU0jwyKLw=
X-Google-Smtp-Source: AGHT+IGvTrYcFzi96p3pvTexxwrCz3hoWtWdtSYsTJ8UmdEEHhKtobLyPS4rZuyJGa+pMaZeFxcfCA==
X-Received: by 2002:a05:600c:1390:b0:431:44fe:fd9f with SMTP id
 5b1f17b1804b1-4319ad000d9mr73554575e9.23.1730182272544; 
 Mon, 28 Oct 2024 23:11:12 -0700 (PDT)
Received: from [192.168.21.227] ([90.197.151.65])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4318b566f11sm161756735e9.20.2024.10.28.23.11.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2024 23:11:12 -0700 (PDT)
Message-ID: <4bf6ee0e-5996-4075-8167-c17d4b285d9d@linaro.org>
Date: Mon, 28 Oct 2024 12:26:04 +0000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 18/21] target/microblaze: Explicitly set 2-NaN propagation
 rule
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
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
 <20241025141254.2141506-19-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20241025141254.2141506-19-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=richard.henderson@linaro.org; helo=mail-wm1-x32a.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_12_24=1.049,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/25/24 15:12, Peter Maydell wrote:
> Set the NaN propagation rule explicitly for the float_status word
> used in the microblaze target.
> 
> This is probably not the architecturally correct behaviour,
> but since this is a no-behaviour-change patch, we leave a
> TODO note to that effect.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   target/microblaze/cpu.c        | 5 +++++
>   fpu/softfloat-specialize.c.inc | 3 ++-
>   2 files changed, 7 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

