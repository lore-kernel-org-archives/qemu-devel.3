Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B626C282EC
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Mar 2025 15:36:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuCVN-0007eg-8v; Mon, 17 Mar 2025 11:35:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuCUf-0007LV-SG
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 11:35:13 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tuCUb-0005F3-2u
 for qemu-devel@nongnu.org; Mon, 17 Mar 2025 11:35:09 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-38f2f391864so2620369f8f.3
 for <qemu-devel@nongnu.org>; Mon, 17 Mar 2025 08:35:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1742225703; x=1742830503; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=TWuw0WakOcmJIBItiI2Wy4xhbLSSM6RN2OaaQmE5prM=;
 b=h1b3M9z/G6wgoFWSl++KAKZnsBjh5yr18SwasV8N9+28hbwcUAA3FWZ/QXE2R5FEXz
 NM8YKYLGGYMt9W8Rdx6+Y6zdaRITu8RNMqmp04oc5jdLjwOC2rQlX04bzud+Y8joef9l
 +gQRLBP3KPObEgPzXfX6J8/19WZ8ITK+LFZJfRIY3gNhnsyFz3bFRhtBPDuASGhAOgvh
 AzK2ypoH9hHVr4TUH4yyc6vT7q2F995LjVl9/7FSl/VPfLHFq8uxwmvuEzwP/XZGxwoX
 WMHZZxHgOxzOG30N1TkzZYNmPw/skkolk1lmXs+3Feec63BzvLEWki441B7Ci7vGJ2WL
 PC3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742225703; x=1742830503;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TWuw0WakOcmJIBItiI2Wy4xhbLSSM6RN2OaaQmE5prM=;
 b=qUbafuE6+bYfFoz436l3y5ENn901eFZ+c+rM6OTjFORPXKWK2FTmlao3nd/zq3zWNe
 9+l3xeoM3/WFTMSAV9rAXtstCf9Ig6IiSqQ+K0iZbIzgsGgioQJhwua3VF/prjTvEKz/
 5Pra2NO102X3Bo3K9HoAt9Uj2WvUSFF4z/It2smvNbsGqdZfZIjUWhG2CeVB4z7GosWX
 gMJ2e50fyVcYTx0NFESkb9+3FP7WPEywto+iDlaCDcw2tcgsmv+mOMPQ2HS4oAYGu/YT
 CK4oVlEprIjd1BapGvTQdyWW6AtrygpOXkU3okWns66pryx6st40rIEnyhwBpfhdkOzx
 RFTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXr/8xYNLSHK8dv89pAf5t0cU82z4OQWQuyUqwAVJR+2iBLYi/a2nDhy67f8PQkqbmqk+JJeKHI3f79@nongnu.org
X-Gm-Message-State: AOJu0YxLBkD+QHvb4B9GoYWMC+RAGT/Cnn8XyArdimdVsDlXal2gUlL/
 fF9KFQRJ1qPAqPu22Cv1PAeJqvQ/5pOI4tL6gYpD4Z31kZ1fZe/5CjuMftYIU2w=
X-Gm-Gg: ASbGncu+Mwtov4TR0TnXLF5ivWFXKLFQ5YWMsa6UbDZbO9/9zqm67B3oKCPt94xrp4y
 entde5D4/IEMRWoa6yNrUIAUhKLYYlQRQDs31HKUJe+W4AE4CbXWSSqt0en9gN34NaiOyneBMyG
 3ocyIYDiZ/7T562C1iwtQ74aRjhjrua6DMd4eDiMsBkgHSxY0baA9DBbZhMChC7BxBjevpp6u89
 wiqPjYG8h+qXxxyBHYCZ5m2bfwRI7BRyryq7W8/TowCaLZAkdhGRm1Q+omtCYsWam2dG7OpIFHu
 euzNxDbeW6hm6WQik3HBf4g87sWxWBUnP1oIXMUADOobOvCL8xS8GbdcHmtfPsmSVYodR2hgH2N
 rU0qctJ8ULg==
X-Google-Smtp-Source: AGHT+IENMn7guVR4EdogSpj74WA7q6gaaPWgpBC62b0aHwnu/2tWIoYCCaohMPtjMWKqNHuszaB0lA==
X-Received: by 2002:a05:6000:1fa2:b0:38f:483f:8319 with SMTP id
 ffacd0b85a97d-3971fbd4242mr15884201f8f.51.1742225702891; 
 Mon, 17 Mar 2025 08:35:02 -0700 (PDT)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-395c8975b09sm15567309f8f.57.2025.03.17.08.35.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Mar 2025 08:35:02 -0700 (PDT)
Message-ID: <5fba822e-e375-460f-a65e-7358417fed5a@linaro.org>
Date: Mon, 17 Mar 2025 16:35:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0 1/9] core/cpu.h: gdb_arch_name string should not
 be freed
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20250317142819.900029-1-peter.maydell@linaro.org>
 <20250317142819.900029-2-peter.maydell@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250317142819.900029-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 17/3/25 15:28, Peter Maydell wrote:
> The documentation for the CPUClass::gdb_arch_name method claims that
> the returned string should be freed with g_free().  This is not
> correct: in commit a650683871ba728 we changed this method to
> instead return a simple constant string, but forgot to update
> the documentation.
> 
> Make the documentation match the new semantics.
> 
> Fixes: a650683871ba728 ("hw/core/cpu: Return static value with gdb_arch_name()")
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   include/hw/core/cpu.h | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


