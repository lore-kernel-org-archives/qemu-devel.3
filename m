Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A62B5C87FCC
	for <qemu-devel@archiver.kernel.org>; Thu, 31 Jul 2025 20:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhZqV-0004WX-V1; Thu, 31 Jul 2025 16:25:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhYCz-00014P-Sw
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 14:40:54 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uhYCx-0005zS-TX
 for qemu-devel@nongnu.org; Thu, 31 Jul 2025 14:40:53 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-b26f7d2c1f1so844845a12.0
 for <qemu-devel@nongnu.org>; Thu, 31 Jul 2025 11:40:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1753987250; x=1754592050; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TFWkHTdMXqnWoa7O/h3QZSeGc5J50zz6vRjCRmBtHus=;
 b=l92mPCm73gvz9BU6aIR/frdcC7C72NMs7wBNjTSNX//H9MwDJbbvLdOV7RFvgE1UlL
 Ug7RdU6yFqmEHACfSHmxME3YCCjMiWSgX5QBUi+ex1VOhPIGMPJiXa+9BeFtJGrbkZfk
 8I/8rdoa7BVEMpz+oGs7eIml5JeefkniVwP9CXrPE8O9cmswFOmN6jDfZzNph2nFwffh
 x12oQBcTPAmibyI2+qHrfOQsoEb0zuJq0jOHDq0jd2JNh97WsA40ltaQpg269yzj2fL/
 w78QByOALtHLw0heBNs6sKi4DeDdN4+s0pwf5neAFtmeHHxz//bOCbJWZK1rcC3uwVS/
 xdcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753987250; x=1754592050;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TFWkHTdMXqnWoa7O/h3QZSeGc5J50zz6vRjCRmBtHus=;
 b=njUTw+xURgG4x00EKyUJiPf5hInw7BQnNbIYl+L0KJ6AMSbb26pnmzazgodzi1A+We
 xEO7l7j8f4xL8P1pORfo/bW0f4uqghFGZU9RQ4q33zmle11LomamSkqaAHJEIbWCyj5X
 34uPgr6U1+oN0v/UpOFSQBwLQq3b0GbjEDl98jW+6F7L5AvkirdZcWzCa4n7EeiTbVPw
 zNyQCfZczbez0Xe+xn2PyTBQr7b3bLoLvQdHWnmmh4+9CSX+OrPlJ+HChfnwblwZWalo
 Zd5knApznQ7e9t6gNCL6+cIVr/NhbfU44KuYsjkhbJ2Ip1QXU2Lqf7KGjlzXszELZ/s0
 2mhQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6n7q/GBD/nMvj8HpO4ILvyj/IJhf4fEyxci9oIJxSf3i3O71puSQdmtFOACLTHVzGsawpRwVMdwQa@nongnu.org
X-Gm-Message-State: AOJu0YwozxeLmzMH+HL2gG3JMMnIvGTDalyWmkn/cbEbKHB4iYlahsnG
 1TK8yl/RxJ05RwWcLt8ZA0dkdFzOsiCB/mb2YXPiaW1J5eGHUACMQ6TZtIbnw0Z+XmA=
X-Gm-Gg: ASbGncujb6BftFLrVnxniGPAdQ6GITNMf6h7YdNeK091nYY0J0GUoBjodmgbKNZ/mbs
 OthUUzy23hLLN0zmGlpw7GNmdQxpWyj030hxFYGFCnboixcZMPcLDC66APMj06d7El37pRldJp5
 zIZv8VdXb1JQ82XMoOudlxdf/GGU3TD9ReEo7shfYi7aSc9NY7cT6ovxDgXyyCC+MVxusBhrvFk
 rA+k8LDrIF68EHPHLH4g+I+cceiiZlhF2UN1JIjwf2vW2Jg5UZzSWbiNUEyMFV704X4uYSHIJJo
 3Vnl/5du2vTA0Fo8SSnhmLshLn6xMOQ7K0IyzGq1gANlOX4Dtng9FLd1Ecq7RFLHEPzGcOmY3RU
 wfzwaqtdiNRWEN5MFFP3BWE+xUIMkaWlrNyA=
X-Google-Smtp-Source: AGHT+IGkeqGwi/ig9iEm4heRRWKunke/Hr0yv9qoMy2AwtJJKi3RqdBGZUE/b7/B8uxEzEBf4iuvcg==
X-Received: by 2002:a17:90b:2b4c:b0:312:e9d:3ffa with SMTP id
 98e67ed59e1d1-31f5de95105mr11027700a91.31.1753987250033; 
 Thu, 31 Jul 2025 11:40:50 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3207ebc2f3dsm2613558a91.14.2025.07.31.11.40.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Jul 2025 11:40:49 -0700 (PDT)
Message-ID: <1f25d01e-3ced-49f1-9b31-b56ab3301161@linaro.org>
Date: Thu, 31 Jul 2025 11:40:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 42/82] target/arm: Support page protections for GCS mmu
 indexes
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org
References: <20250727080254.83840-1-richard.henderson@linaro.org>
 <20250727080254.83840-43-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250727080254.83840-43-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x52a.google.com
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

On 7/27/25 1:02 AM, Richard Henderson wrote:
> Take read and write from the s1perms.gcs bit computed
> by the Arm pseudocode.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/ptw.c | 17 ++++++++++++++---
>   1 file changed, 14 insertions(+), 3 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


