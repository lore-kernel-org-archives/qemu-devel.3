Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50D7EC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 17:43:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvKvE-0006gR-Ix; Fri, 12 Apr 2024 13:42:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvKvA-0006fo-G5
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 13:42:41 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvKv8-00067H-8h
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 13:42:39 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-346b09d474dso1058503f8f.2
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 10:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712943756; x=1713548556; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bJJiiKhPed/hoGpo5br3OoPXP3cvN9i9h8XAgjbVgPc=;
 b=tlG5zZHnb76VoGHXhGJp8fI9vynLzTq5o6Hh7um8w6LTDk/ots1XmN/u1Vfrap7Y3X
 upse5lW8NKxVMoF5/yxxcw1J5iYF6Z4Ty8WZXO2YlbfQ5EcZTaxddBbLYNjFAgX8RpID
 RqeuXPER52ZvGDGY6rMzfV04Zt0XQxQ7ckhqJgoNed1mAvr24sBiRwgp5q4mUG3XU1MD
 VEAnB62s4BENe0oC7Uo0sxyDLzo5phas8wYO5jYbBeL2Bf13IxnxCNVPkOsHPnahls9L
 kPeKHBbLz1awgVF5Vge9W/6AKOA2zxbiD98FhlvBrhn3nDREGcoswXUnv8XU0+CDJfIg
 HTdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712943756; x=1713548556;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bJJiiKhPed/hoGpo5br3OoPXP3cvN9i9h8XAgjbVgPc=;
 b=STOCSqo5unUb3qRPU793OcYYOaQrZQi7b/wB4xsvKs2pO+4I3AQc5fomwT/5rRNcXP
 OboKgiBpWI/xv610FlmEZD3CTi/j74xzzOdx/sGUAYyLuZ1uEFLVhbLQgEIZU7yE0u0k
 NRzpU6I8iS91HB7zF59HRWq1yiRFIP2Yx3JrH3zFvMcSXAfCcpNcwL7LQ7I9p26Wmy9/
 ugIgTLnDGjeQdeVg//NB6OACyCigYVz2eOIgPo0CY9TyPFxKBxck1rEXiJCF0oq5rXL9
 y9ntqLQDyC/9r1ONabvT6dUM1SueEWhfRQJnPq7U/2uJZnCya8TKo3JUj44zKilFB8K4
 aceA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWVQMZks8WgdMJ93wPTxbJt/7iQQs20n9ivwZKXyweOBK2+msPUGUS8ew656zAo5w4ysRVaJxBbNlfD1q97oo/TJ7xVYbI=
X-Gm-Message-State: AOJu0Yz5vi/jIfvgx4EDmb6W8BNIod1XVMwTZZ2cew+I/b0RizF6fkBh
 vI6kau2lAhpLYPlSA9F6uFqMyhP9gPn0B9aYy/DDx/0Hm2oQ0wuUccENcL67NW2f1DUPxSK0Nok
 L
X-Google-Smtp-Source: AGHT+IF2HXkSCC+wX8QX0T+0V68aTMg8sXn+j6jrhBGYsJydu9fi+6Ujn1zhMeRiOy8ZrJPgOeCSoA==
X-Received: by 2002:a5d:4089:0:b0:347:3d28:c872 with SMTP id
 o9-20020a5d4089000000b003473d28c872mr331694wrp.9.1712943755689; 
 Fri, 12 Apr 2024 10:42:35 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 n12-20020adfe78c000000b00343723c126asm4697949wrm.48.2024.04.12.10.42.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Apr 2024 10:42:35 -0700 (PDT)
Message-ID: <fe559444-634b-4135-9cd6-75add3b9d331@linaro.org>
Date: Fri, 12 Apr 2024 19:42:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 04/27] util/hexdump: Add unit_len and block_len to
 qemu_hexdump_line
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240412073346.458116-1-richard.henderson@linaro.org>
 <20240412073346.458116-5-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240412073346.458116-5-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 12/4/24 09:33, Richard Henderson wrote:
> Generalize the current 1 byte unit and 4 byte blocking
> within the output.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   include/qemu/cutils.h  |  6 +++++-
>   hw/virtio/vhost-vdpa.c |  2 +-
>   util/hexdump.c         | 30 +++++++++++++++++++++---------
>   3 files changed, 27 insertions(+), 11 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


