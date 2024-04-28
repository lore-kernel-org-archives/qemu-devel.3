Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31EEFC4345F
	for <qemu-devel@archiver.kernel.org>; Sun, 28 Apr 2024 18:29:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s19HL-0000sM-Rr; Sun, 28 Apr 2024 14:29:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s19HK-0000rv-0g
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 14:29:34 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s19HH-0001bk-L1
 for qemu-devel@nongnu.org; Sun, 28 Apr 2024 14:29:32 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-6f074520c8cso3704613b3a.0
 for <qemu-devel@nongnu.org>; Sun, 28 Apr 2024 11:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714328970; x=1714933770; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D6FNSXjwgeSilkzvfjYcQ77rq8am3hbYDe/BtfdUKaQ=;
 b=GPPQW8dj+OP2PypuTy2cfWs7ApzYLXldT5S4oRayr14fEOItglqxZdTQWHGR2fKwr9
 XBarSbWK/VMF+YD2dP7MDTRZniasXV+NmGSmpNZkvf5tN+4AYou7dg0cpFrztpodhDn4
 bco5f2BwYqTR0izC2RWbs2o8/W3ANoz0GCdEWeLDnxkJHVD7Z8NJ8Tvr6dbjYeqD9oRh
 h42g81cQ7nRUvke0rJ4cRUnCNVKdPiaHFZcLfE8rSTJEFFBkZAUcbg4JArXQtjhoZlQ7
 qvt/j0joW7RPAlIay8/HHpRR7cgG2gVXh238okopiXRrw3EGjNYTqJN2ONMbKT4mQHeR
 +Eig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714328970; x=1714933770;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D6FNSXjwgeSilkzvfjYcQ77rq8am3hbYDe/BtfdUKaQ=;
 b=PvIraXDzllQgj1hrn7h2bOGYSpACLlhauiG528Husprzv1XvrXb3FJzgT8qIlk4fy8
 bZACsAZgp9w0si7rTsgfoXlabehpIstRC2B+J9jVdYagAve/MtwVvMcDtTNeoUPF8Xpz
 sncScHUOqwlZkRbTJ2fpsJa9VVVwbiNH8gM34xmdIbgvAC/WIaJBBHGWoXthSE9Jj1GB
 4o1iPfHq93NOrAMqT2MKDtzco+g/RvjPiwfjhGqLf+C0qeQoWreDJPnA07fOOlw4LPMA
 liLZ4UzNEkt6zoP5XX1C5AQ7pZchA6q5yASjUTPe/97aOi6lhsv//qeOIPKwWFgKVGvR
 ggmA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbInbkxePWGQ4tXR+SKXLTjTWrnwq0vCA3h0doY+hi/e+iWyVhAwCU80QXt9wW5nYRnmIAm4WTqFdq/uAHV6h+YqCY2KU=
X-Gm-Message-State: AOJu0YystQmP+CQlJODCcvgIkPgJHp2qgOc95ej0z3arQiJv3LuWF9wg
 j3fdPSeyLrBKXDZzID62EEpd4WnZvN5bCFSCAbZGhVcFzB9JUfQTZQHYEfy/XU4=
X-Google-Smtp-Source: AGHT+IESyQO9QIJorQToO2n50p9F+Yq/+Nf6DVszwryoyD/7WiwYheyTuZgrewxV6vArFTZUaTgl+A==
X-Received: by 2002:a05:6a00:170a:b0:6ed:d3af:1070 with SMTP id
 h10-20020a056a00170a00b006edd3af1070mr11248674pfc.32.1714328970186; 
 Sun, 28 Apr 2024 11:29:30 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a056a00098c00b006f09d5807ebsm17411528pfg.82.2024.04.28.11.29.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Apr 2024 11:29:29 -0700 (PDT)
Message-ID: <476b5074-8e08-4835-8cdf-6307399a9a24@linaro.org>
Date: Sun, 28 Apr 2024 11:29:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/14] exec/cpu: Extract page-protection definitions to
 page-prot-common.h
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>
References: <20240427155714.53669-1-philmd@linaro.org>
 <20240427155714.53669-9-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240427155714.53669-9-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x436.google.com
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

On 4/27/24 08:57, Philippe Mathieu-Daudé wrote:
> Extract page-protection definitions from "exec/cpu-all.h"
> to "exec/page-prot-common.h".
> 
> The list of files requiring the new header was generated
> using:
> 
> $ git grep -wE \
>    'PAGE_(READ|WRITE|EXEC|BITS|VALID|ANON|RESERVED|TARGET_.|PASSTHROUGH)'
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Acked-by: Nicholas Piggin<npiggin@gmail.com>
> ---

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

