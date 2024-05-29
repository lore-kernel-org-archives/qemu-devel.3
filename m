Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94ACDC25B7C
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 17:40:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCNHs-0003a1-5c; Wed, 29 May 2024 13:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sCNHn-0003WQ-BI
 for qemu-devel@nongnu.org; Wed, 29 May 2024 13:40:28 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sCNHl-00022Y-ME
 for qemu-devel@nongnu.org; Wed, 29 May 2024 13:40:27 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1f4a5344ec7so1758485ad.1
 for <qemu-devel@nongnu.org>; Wed, 29 May 2024 10:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717004424; x=1717609224; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JFwIqar3nWI93niT4cnoh9DpqNPWlPGcBp1lTQDstRk=;
 b=cZ9/QGMCp7CcKlK3l/8szqQJS0AioRnrC/QsGKmgooB15IPby4i7CJGTuQtkajBcb3
 pMSDotqm6+I7gvPfUjz3ZBMnqItbWYvdpiDtzvAXSKWxHT0fLE5djWAJPBoom1v958Ak
 XLS/bq/PjFkdONWYx/N6KV5QytEhHJCNI0aRG8LmpsCXlPAoStmOn/RLIkiA7KgAFwoB
 odsvpfkK5SoftWKUfhxyOL6ANJeywbeMACNH0LlHgv6lpDr+IKeZ7aEkpm6au4eWyZzt
 JkitjJB6TKmTqPf7OqaUFbBi4Z7SmAyfF+K4hRqijM9hqhay4Kyj8PmSM1BCBmTbMnEH
 v+YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717004424; x=1717609224;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JFwIqar3nWI93niT4cnoh9DpqNPWlPGcBp1lTQDstRk=;
 b=P5/O+4TY35nJzlC0nLtEZP+HfAOivvxE2+3gNCpSXf2VWiKfCYsLqSUp+F+QOakJld
 rSrvUkfdhW7QPKciJLtLlSSYpuCPY4b1qhbX9TvBNPK0CRx0tED2n0G9jh+061ZLlj9s
 A/sZAgKWoV6fudmEU3YQaNvdZ+HUrWvZ0Dag/F+SYiXnD2I6iewsLTnBH55J8SSnq6/l
 NmNNANcJGPIjtplAMq6P+vMQP51PkMFjfTrBBaoE7yt+auIyyNZd3XJlYuNJfrRkf3zB
 7YKVnZtMKrdDvbZq0TI0rYhkZGpTk2M6Em9mzHS+o1ZIw5NyyhEFlGJ1tQrPeg4Y44OO
 CGWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBOMNKzkUSbvjoZWrw2jd84Ai/vhfb5oZJ/fb5lewfSZGToleuyVEr/Ik0GoalXiNEpcB5oshIRcx7uKHhRQNG4nob6OA=
X-Gm-Message-State: AOJu0YyM+wxPZt0KK2xS7nQ3S1ehsBCaNqmj59NEXQ5LQihm2CBZcyqC
 xfqJycRfz4gYvygcAmzaHkOqJ2M1uSrDHLth+HZ2AgbiuqgVc+x3cuj6exHvdNaTFgsNCOhgWsN
 C
X-Google-Smtp-Source: AGHT+IFbi5zQKLo8Io8L5MoXaNUlJGK2lGlCciULklUIEcq+quzN9h91lNsO8blq6ewx/KbiP3iUpw==
X-Received: by 2002:a17:902:da81:b0:1f0:8c5e:ffdd with SMTP id
 d9443c01a7336-1f4e9d73e04mr42539615ad.4.1717004424124; 
 Wed, 29 May 2024 10:40:24 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f4ae2cc802sm53854305ad.17.2024.05.29.10.40.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 May 2024 10:40:23 -0700 (PDT)
Message-ID: <e063c590-7e21-4367-adef-315ce0b9d114@linaro.org>
Date: Wed, 29 May 2024 10:40:22 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] semihosting: Restrict to TCG
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>
References: <20240529155548.5878-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240529155548.5878-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 5/29/24 08:55, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (3):
>    target/mips: Restrict semihosting to TCG
>    target/riscv: Restrict semihosting to TCG
>    semihosting: Restrict to TCG

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

