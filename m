Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FEBEC636BF
	for <qemu-devel@archiver.kernel.org>; Sun, 22 Feb 2026 21:58:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuHSN-00026L-6A; Sun, 22 Feb 2026 16:57:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuHSI-00025u-Mp
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 16:57:35 -0500
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vuHSH-0007Nk-7v
 for qemu-devel@nongnu.org; Sun, 22 Feb 2026 16:57:34 -0500
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-65a40f3f048so6947581a12.3
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 13:57:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771797450; x=1772402250; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q+WpuN2NRIDfOO9ElWyz4PqWzyCctMyHXw9xpdiCdL8=;
 b=VsrGWDY6lddWOmrWmhU2tmVXomQ1FGBwTe65yYL5kkND6rx7fbHvrt04Y8+WZdJTwB
 arLwj7sMsv2dsb/EWz4k+dOwSFPZdAO/qGMnJVVIIAzGOBapfOvS/AZ7wShELW4E2D1v
 oJl6Y3dZPs9GFWwB0ABDklCHrbWx8eDccKRSUEXef8cH61CLpiLs9H7dxAo0x+/5Wc7j
 +j38LBQp3fi3NEoKGmiaee/Lq8QcChAjbbOroNjfi8Xtl2GO7nqI23k5WC/dE+cwRygA
 JCWrdKJJGGoJvAEhF+0jxhz4/a5POpMJJXw24dLzM4AD3TT1WVbSeouVYT3V0Wn4/4yB
 UtjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771797450; x=1772402250;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Q+WpuN2NRIDfOO9ElWyz4PqWzyCctMyHXw9xpdiCdL8=;
 b=l9VeE1H36W3BDolnWALp4kVHn0ZJBmQn6xFp7ykYvTpVcVfrTH08zW13VHhS1DtCea
 vdVFPEDzIIlHlOZK7PBSAkTX2OMZmY4zeJ6l/Hs+c5p1DE4YH7Cn2+ZuRHxk8UWk//b0
 Dn+uY8DARMMHtKLSUnGDR0KuouhA6mB8tavPkmhCo9Cd4PvgaijCW8gIPoOgBUvVoQVP
 eGAVaOHHE2Nu5M6ZyJYzgwBm8nGeXL7kQuWdgk5IQeLXfP73Bhgdva8k30Ukhg2lLj5H
 RdK8k3k25Gb/UH22iLNUgwwT+FldutjIgj4naCXkyhgJuvZMuaYgILcpQihVEIX8dOAS
 Mchg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiU36OBW4Q1yTbrVRThyGWb2Nz7L5f3WrZqdHhXUfXnXN7ucBkCN7L4hbVh9jnvyczCW/Aq83gM8/+@nongnu.org
X-Gm-Message-State: AOJu0Yyto+xFZ4pmw5jBM/gNIVLnejy7tt4EZByl8yac2JJftTmYCFlX
 K3+OZtL75np0x7epG5Dl86yRh9qSO/CipJ1bA12KpGnrVt3+y3CAkw9ZsKf05IQ5d5t0kCy8mxQ
 BhF4igoE=
X-Gm-Gg: AZuq6aKsOKe/3lB1u3FQDiFXDyofCKKufzCzXWmAKIb/2P/6mjPOtisK+UJ34wYZ2Zl
 urmyKtAv/V6FKzlMrIdA/WYGjlhGiWKV67AybuIL6FanEtoo69FnhAjbM9TRDYeRAdzpUfP2qoV
 EB9lweWbsEsyc9l1/X4Jp3nBcvN4lqV2gfdCy+JtVFMG4iaIqvq1JjlxnQA9YfCQU3Q/9WOLJ2c
 +4GW39D0T9aNcu4eWFeOqNEMxza++Y1NVup6LOMHeoT1pziGdL73CfqIbf6H3waphPz97wbx13O
 dEDTddhnzQsDpp9lpV5ATQ39+pHypxLgHpY8Lai5WP6cHA7QXS3VKung+35uF/v5d7hmv25LNgg
 eYoH7wy5xixvthpGgUEhsTMtqviBnbmeA7y45eyE+kxcVWiPQdRqgey62RDgi4iSVxOcEAgXENK
 kywqHYGF9XoFmZ6EnK/JgI6pjiTrk5tbr3voTYr1pPoDgpia7Aq7mThfdJQ4v0e+F6/A==
X-Received: by 2002:a5d:6a92:0:b0:439:7e17:c602 with SMTP id
 ffacd0b85a97d-4397e17c699mr16984f8f.3.1771796703812; 
 Sun, 22 Feb 2026 13:45:03 -0800 (PST)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43970d401aasm14170371f8f.23.2026.02.22.13.45.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Feb 2026 13:45:03 -0800 (PST)
Message-ID: <31f46607-9ae5-45bb-8998-c4922fd1a26c@linaro.org>
Date: Sun, 22 Feb 2026 22:45:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/misc/virt_ctrl: Fix incorrect trace event in read
 operation
Content-Language: en-US
To: Kuan-Wei Chiu <visitorckw@gmail.com>, laurent@vivier.eu
Cc: jserv@ccns.ncku.edu.tw, qemu-devel@nongnu.org
References: <20260111184915.1363318-1-visitorckw@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260111184915.1363318-1-visitorckw@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x529.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 11/1/26 19:49, Kuan-Wei Chiu wrote:
> The virt_ctrl_read() function currently invokes trace_virt_ctrl_write()
> instead of trace_virt_ctrl_read(). This results in read operations
> appearing as write operations in the trace output, which is misleading
> during debugging and analysis.
> 
> Replace the incorrect trace call with the proper read-specific trace
> event to accurately reflect the hardware behavior.
> 
> Fixes: 0791bc02b8fb ("m68k: add a system controller")
> Signed-off-by: Kuan-Wei Chiu <visitorckw@gmail.com>
> ---
>   hw/misc/virt_ctrl.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

And queued, thanks!

