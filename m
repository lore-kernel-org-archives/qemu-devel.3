Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BD38C27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 23:44:31 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFb6f-00019W-C3; Fri, 07 Jun 2024 11:02:17 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sFb6d-00019N-HN
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 11:02:15 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sFb6c-0007w9-1o
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 11:02:15 -0400
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-2c24115469bso2467506a91.0
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2024 08:02:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717772532; x=1718377332; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=e8h3Ob/U2MovjuDuWEQiWuqRZGka2ZSGoWHfBoY/wbQ=;
 b=Q9Yt/F76y5A0X1Q/oZaWeg0SGmvTCNbHewzNHVZB/80AskntdLlFhahaibUCOJL9uT
 +jB1TWyflsqBHLWuGxrlHrl65blQHpthxLKOqXoxFTNGJtZs9Eu2566FgPZXXSzV5yn8
 s7xX/YKNMRp/e25EYGNm1kMO1C+89EePSU7Fsq8JbODhwyp6KHfZUX/1BLFfkMX9q56o
 +FQFSWjEBINTAIspvny++EQWDUYUPWCECxuSZP0UMX5TcNjEkVy5DX4itovDdyOS5I69
 317BsBWblIPmO6H7fuXafw4hU3WFoWHiVOvup+v1lGZNeY+XHL1jENE3BCXfO718wuzw
 leeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717772532; x=1718377332;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=e8h3Ob/U2MovjuDuWEQiWuqRZGka2ZSGoWHfBoY/wbQ=;
 b=ifGj16MKOux90W8r/0eBfEj0+4LDhOjGfHB//pJOYyFxgyyl8bv2nubLkALgVz/fxH
 RB88CBs/3QfIaIImikru4dXZ3hK3QceOL1gyB5o8+T0JWqKt6Nj7yY8N+DNv4IYrKjWG
 8oPA3+g2DHwyA3poih9NctU/wiu5yULKKGWLq1G9HSLB+5By1L0et+qgKStR2YxxOefA
 GdO5VGC67O1QjgZG6JXTE8FMa2llrih3JVlOWc9lpRfOv7WN6EpnM8LhhfYPNwf7nKDY
 Bhf3wvfP1d7JsX9Iw/chJjMdYl+aFuzDhkgbNRxG5VVEqdH+XXy0aW0rMLt21OyacZ4c
 +Dew==
X-Forwarded-Encrypted: i=1;
 AJvYcCWOcAQkOYaLvDkytQfYvxBizHSOgPfOOxQNz2POYZZKVPdHKMvj2BOpwAYDkpPZ3hhVm8W9NZhucHneH3VZysy7KlgXxgQ=
X-Gm-Message-State: AOJu0YyUHpSbC8zTq8FtvbbyALts0fEVvXyfl8dmu/Ihx8DZARJZTLh0
 VLGgV70bzLlXaRvcTAj5JlWKQCyUoDB+z4LE56pqYwDb2PLDsaVXn873am5BXzw=
X-Google-Smtp-Source: AGHT+IFb+omimqyap0eB7Uttxb8BftUOBBerr+x8F3F5aUjI4ebK8CKVosh4A7piDiHaJ8lpLYAENA==
X-Received: by 2002:a17:90a:f982:b0:2b0:e883:270d with SMTP id
 98e67ed59e1d1-2c29996bfd0mr7745701a91.1.1717772531988; 
 Fri, 07 Jun 2024 08:02:11 -0700 (PDT)
Received: from [192.168.223.227] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c2d14fffcesm528227a91.42.2024.06.07.08.02.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jun 2024 08:02:11 -0700 (PDT)
Message-ID: <1b310d07-d59a-4d23-b89c-a46bb0a48a46@linaro.org>
Date: Fri, 7 Jun 2024 08:02:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] bsd-user: Baby Steps towards eliminating
 qemu_host_page_size, et al
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>
References: <20240607042503.25222-1-imp@bsdimp.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240607042503.25222-1-imp@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

On 6/6/24 21:25, Warner Losh wrote:
> Warner Losh (3):
>    linux-user: Adjust comment to reflect the code.
>    bsd-user: port linux-user:ff8a8bbc2ad1 for variable page sizes
>    bsd-user: Catch up to run-time reserved_va math

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

