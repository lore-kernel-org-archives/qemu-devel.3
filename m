Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D977EC4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Apr 2024 16:28:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryDYN-0002Wl-4v; Sat, 20 Apr 2024 12:27:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryDYK-0002VU-Uw
 for qemu-devel@nongnu.org; Sat, 20 Apr 2024 12:27:00 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1ryDYI-0002Xz-Bg
 for qemu-devel@nongnu.org; Sat, 20 Apr 2024 12:27:00 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1e3f17c64daso21593625ad.3
 for <qemu-devel@nongnu.org>; Sat, 20 Apr 2024 09:26:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713630415; x=1714235215; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EVi/ltbTByuAJWQrsYjkR9v6uxtGhW8cPtv5rMnf9/4=;
 b=AzkXf+0/wBewU9ypJtL8fyiz+0sj9xMloWodT75v5bhPTf3zo7YOZUFBel3cBCJ+jp
 uqmzOdfsn0GGSMgXea6SVJ0wTPPaRVGqpMCypDgOaItbCLbeC50WUuhX5386VWjfJdio
 K8T+TR0Aq/Nx5JB/SnmOO3JW54f9l5xhOQT7hUl7l+E9PUBVNH0GG4oHos/yW6N+WdJ/
 pQHr+lm0wDSKWr+UhJBzZFJ16/lNOux25RIVKJrz1hjVYOJOs43lzVl1odGec2w9S/a8
 7fzbwbQ2puj6dLF+dslO4QMzgZQ2g9Q6hg97HDNHZCJq+MXWrWYZY2ddyRf6hQm/SOJi
 mAOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713630415; x=1714235215;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EVi/ltbTByuAJWQrsYjkR9v6uxtGhW8cPtv5rMnf9/4=;
 b=i5tE4dGgIOtXPtGo3b1XJ1YgWKz0+iuV+mQkQ12XOH3MBZ5qWtjv4jQAKwRcnuI+Nc
 qpC+MobWboURClLD7o+q47Awxbup5XjUa2wVCeXzTc9hWmqAzrg5YVaeEj5fVxPqy2sJ
 c6P2IxYgrHh/jH0b58EcKzOST1MLff96Y2l2TZNKP0A2vZT94v2nuPEvLs//Dp7q6cF7
 iUQd020APOVMTkkhyXiIbfetDHJQmpn9/1Og7h9C8HIXQKRlwroDKpRw/ztOh9fLmeyQ
 fOssrB0uP81caa4G9pUlg+fxKs8wolUMS/EPGCfSzuNtU8b5Szo7fYl8SdqPJRQcVXJR
 mSdA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU7qasUiXYgPj8m6aepkUnxLPYZ4KHkjblU6rY1/T+NrORbwY21P3nq0jxXkh20euWuj6eAYxW6jrutcJwiY+tYylLVDaI=
X-Gm-Message-State: AOJu0YzzKWSE1gNTBk0jJwNuf+fwAV5hCHhIffZP9RyguJv/jY9VnTFj
 Er2L1/okhCwu8QtLuD4K0gkyKSyYR0ZMGR0eU0959T93Ivmg74daC4Qr6u5AcWc=
X-Google-Smtp-Source: AGHT+IHW0BqT5Us8+nu0ykOG3l6uhkSYOtoTNjPLWkSFAxzfea/JIYKheJ9Cm5h83zQ7Qy1OZXwO8Q==
X-Received: by 2002:a17:902:8210:b0:1e5:c0ee:a7f5 with SMTP id
 x16-20020a170902821000b001e5c0eea7f5mr5104451pln.24.1713630415398; 
 Sat, 20 Apr 2024 09:26:55 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 j12-20020a170903024c00b001db66f3748fsm5235821plh.182.2024.04.20.09.26.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 20 Apr 2024 09:26:54 -0700 (PDT)
Message-ID: <1b4a11e8-3752-4bfb-b8c2-8c273f13bc6b@linaro.org>
Date: Sat, 20 Apr 2024 09:26:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Remove useless architecture prefix from the CPU list
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-s390x@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Hildenbrand <david@redhat.com>, qemu-trivial@nongnu.org
References: <20240420054606.13353-1-thuth@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240420054606.13353-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 4/19/24 22:46, Thomas Huth wrote:
> Thomas Huth (3):
>    target/i386/cpu: Remove "x86" prefix from the CPU list
>    target/s390x/cpu_models: Rework the output of "-cpu help"
>    target/ppc/cpu_init: Remove "PowerPC" prefix from the CPU list

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

