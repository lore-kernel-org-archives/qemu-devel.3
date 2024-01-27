Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A29FC46CD2
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jan 2024 04:26:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rTaGL-0001ff-67; Fri, 26 Jan 2024 23:25:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTaGJ-0001fV-91
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:25:47 -0500
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rTaGH-0005f8-Q3
 for qemu-devel@nongnu.org; Fri, 26 Jan 2024 23:25:47 -0500
Received: by mail-qk1-x731.google.com with SMTP id
 af79cd13be357-783d4b3ad96so99683785a.3
 for <qemu-devel@nongnu.org>; Fri, 26 Jan 2024 20:25:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706329544; x=1706934344; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ckUwK3LB8TInseLhTeBP803X96ynCWOe4TMSvQGgZnU=;
 b=exdyf0w45I43kqzbFJRdG7oDgxXjRvP+oUgPsiILCr1iIiAx0bj4yCCAY6P4YXXxMP
 0qgGSviSR+ieGbI0NddEEpPtmF+gyUP/oVbDokhVWTY08OUTFUcTxO1xvodC16/YdF0i
 ARwuWmILUC+JP/0eteWpU/J9c8Y/+vv9iLN6S+tlIjSEZjV+l495Wgy+rM/4+Q1+g6rc
 5w0SMqnfSxpuUYmRobP96C93GrbnvWkLb54GVwH9AE+cgM0juVb1wcGGZlG+G0m8bBUU
 MWblXlxVTtwa/D2hzfZvpAhA9jEUQg2D+Dt+vevmaVyFwEAmiWB8sqoWA6QAA3yhPU2P
 rSbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706329544; x=1706934344;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ckUwK3LB8TInseLhTeBP803X96ynCWOe4TMSvQGgZnU=;
 b=pCf8pE9+DA6Fb1Inz1OWedbBV9995lkXzhrQMyMIjiMZVToZHLh8EC4NUUlGFXDY3D
 3X2TTnEYiKAFU8cAj/1s/SsW6WoBstqH8blYypt06P6ueQSEKBJev3k6moPZb1f5NiGe
 3ReUL6vGm1a4j9xuZlr4z7uKqORzB/xucp6EfTlr6+X6PiIKBPC+kirR6Ok71YvuW21O
 IxttkDSGZm4o5ufGEBJyG4zG5A2pzEeGdnS3Pzofs4e1fUW/4Nb+4UKoBRVZ3gYPgFh5
 vvYpeuOAD3XIkCbsoyF3/DB775oRz/bdjjdeYaaJDTOiiAu4aB9etP/yKrg9ISeW9qxP
 5FTA==
X-Gm-Message-State: AOJu0YxFopEilTO/+WBPP5ODnuyvA819T1FHoVkqAw+WelA9gAl0k8C3
 8VvabFVVWFlwwCG4M7IyL5XaMPuPVxHsqS2qZxYhfGDYZ5Px9HYglEe3Tg+7V8I=
X-Google-Smtp-Source: AGHT+IHAX4tcwC1i1NqfeOvASek/Kd6x4ZP7wjco4K4YFYDhCQWDKjfvArAXNpGU4SimK+6iu/EhxQ==
X-Received: by 2002:ae9:e918:0:b0:783:a929:a3f0 with SMTP id
 x24-20020ae9e918000000b00783a929a3f0mr824651qkf.154.1706329543860; 
 Fri, 26 Jan 2024 20:25:43 -0800 (PST)
Received: from ?IPV6:2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e?
 ([2001:8003:c96c:3c00:b5dc:ba0f:990f:fb9e])
 by smtp.gmail.com with ESMTPSA id
 gd17-20020a17090b0fd100b0028ffc524085sm4001781pjb.56.2024.01.26.20.25.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 26 Jan 2024 20:25:43 -0800 (PST)
Message-ID: <29120da9-7403-4f1b-8dcf-67c9d485c99f@linaro.org>
Date: Sat, 27 Jan 2024 14:25:41 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 06/23] target/avr: Prefer fast cpu_env() over slower
 CPU QOM cast macro
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
References: <20240126220407.95022-1-philmd@linaro.org>
 <20240126220407.95022-7-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240126220407.95022-7-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::731;
 envelope-from=richard.henderson@linaro.org; helo=mail-qk1-x731.google.com
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

On 1/27/24 08:03, Philippe Mathieu-Daudé wrote:
> Mechanical patch produced running the command documented
> in scripts/coccinelle/cpu_env.cocci_template header.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   target/avr/cpu.c     | 27 +++++++--------------------
>   target/avr/gdbstub.c |  6 ++----
>   target/avr/helper.c  | 10 +++-------
>   3 files changed, 12 insertions(+), 31 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

