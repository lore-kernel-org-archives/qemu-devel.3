Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D16AFF5137
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Apr 2026 19:38:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wABUi-0006ZM-If; Tue, 07 Apr 2026 14:49:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wABTD-0002eY-NP
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 14:48:18 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wA7Fc-00053K-S1
 for qemu-devel@nongnu.org; Tue, 07 Apr 2026 10:18:00 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-43cfbd17589so4031634f8f.0
 for <qemu-devel@nongnu.org>; Tue, 07 Apr 2026 07:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775571475; x=1776176275; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=geqA3MZMh9qbt+Amv7uressH8UsaaFhMy0S1HJDzOUE=;
 b=o+5cWJtJE9Yvt+iu416e/kkXonKdQAJm+jlxIOkvKMoe9vvk8b7wHCmGLftJEIYA8s
 xhY1TLDWsAIczjZEWot1cW/mBkglJSgLWPFaHqp7m8H/pPS31Q+k6xy+aUQ/aV7fhpmq
 Glf8tZMRKLVqhRAbwGDLm/MCPmIDttQzIb2l02DRegDKnQw3PP2IYqgP3DYuKi/DoSA9
 UDk6FLHKKHAda46CGHw6L++5Tgy2JRFtITxouDyE9Lrq1hc29DzrKQH9g0vlCoUrmwdb
 /ZCqaBhWJ3VK4l9/9f+JKzovsONfB6mt10gikeXTuAoemBWrvmLZCQab44cooJkKNHKj
 KzFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775571475; x=1776176275;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=geqA3MZMh9qbt+Amv7uressH8UsaaFhMy0S1HJDzOUE=;
 b=ix0M2QkbXmy5vAqfSljuTRuj7PVxTMVSm3SqbQ4IBFdarbJRzVgMCeQfU9wI+B4fFd
 l/JwogoduBJrLHOEVH9KIDCqAKYe9z2UaK2zxAmiR+XGmfKqHg2w15bZMIQ/RZIt0Qgg
 uurUVUAgzc44B54zpmDrHd6WaDE/Cya23rsnRY40R9mONcTJxRqTp5DjVU09OMt+QxOX
 P2dTwx0J/3jj1qLmBDjXKCHK/YNSr2Ql746E6k7F9VncuYOiv6xWZRzF97T/Xkav1om6
 jwXE1ejtBklSs71VhgnkRNdNofXWPDFFViGljevIoVUF5kHB0Tx8YnmmbiyTZxK00nXt
 MMSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQoDniVxdVm9l+0D8z57LLevkdwP8Q6GKt7UWoVxkRU0+5wzTcN/jKuWNe6krlMrzmx4FZQ0Mytsz6@nongnu.org
X-Gm-Message-State: AOJu0YwkhxlwgH6CYO3X4KzY5v0tUSpkm5O5Epw968cvNIC0EqsdyMbE
 E84SI/gyftgchwolEnLThOWm05iAPKEEXo/9onjCBVpnTz1fnukE6GliglIy8MKIV5M=
X-Gm-Gg: AeBDiesP+GLcdfpJpTBZE3+eyFGj7/+fu6sGwwNiRa9qF0MQUoLLSct065ZPO0r+AmF
 Yr/GLN09NggNj3NArZ3rbJ01mb4TPBdidlFXXKxrXmVltz6KhpUukUqy73nImTaJa7OZpWp+2Nl
 HOLHWrAT76m6WhoOYA7y16dcQ2zuZ5H8sszfkVkYn8+iPProIWBg4A3Uf8eLDa+2c253gXtWkNW
 bgNmvyUG8b0DERLbmblYOqjxjCNcU9LCF5DNhW5s9RwB63eYJu3bok99e4peqbvHZq3ThFcLaTX
 EJm26QkWirMmoB544h4wCWt+9hP+fVsLmIegzjCccNEl42J8wZy4hkWUXMTZwYpvUwcmewXwLtT
 sGJ1bowo/JGYopykDgShisJ7CSN/hM0qZSV7eQq5WqLEDf/4njqCnbUTTWkEPIfU3CqvgJ7f9ae
 WHEUayGW0SwOPO72P6R5C98sHX3mGl715+uxpVX8jwI9h8TcGKAWMxOSM6pEH/YoM6KA==
X-Received: by 2002:a05:6000:2211:b0:43d:14ae:1340 with SMTP id
 ffacd0b85a97d-43d292e7e5dmr25495821f8f.23.1775571475048; 
 Tue, 07 Apr 2026 07:17:55 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d1e4d2738sm51512450f8f.24.2026.04.07.07.17.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Apr 2026 07:17:54 -0700 (PDT)
Message-ID: <884193da-0078-44f0-804d-e5ccaf5f3398@linaro.org>
Date: Tue, 7 Apr 2026 16:17:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 2/7] target/riscv: Add big-endian CPU property
Content-Language: en-US
To: Djordje Todorovic <Djordje.Todorovic@htecgroup.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "qemu-riscv@nongnu.org" <qemu-riscv@nongnu.org>,
 "cfu@mips.com" <cfu@mips.com>, "mst@redhat.com" <mst@redhat.com>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "dbarboza@ventanamicro.com" <dbarboza@ventanamicro.com>,
 "alistair23@gmail.com" <alistair23@gmail.com>,
 "thuth@redhat.com" <thuth@redhat.com>, Chao Liu <chao.liu.zevorn@gmail.com>
References: <20260406154935.144674-1-djordje.todorovic@htecgroup.com>
 <20260406154935.144674-3-djordje.todorovic@htecgroup.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260406154935.144674-3-djordje.todorovic@htecgroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

On 6/4/26 17:49, Djordje Todorovic wrote:
> Add a "big-endian" boolean property to the RISC-V CPU configuration,
> defaulting to false (little-endian). This property allows machine
> models to configure individual HARTs for big-endian data operation.
> 
> The RISC-V ISA supports big-endian data accesses via the mstatus
> SBE/MBE/UBE bits, while instructions remain always little-endian.
> This property provides the configuration interface; subsequent
> patches will connect it to the CPU state and translation logic.
> 
> Signed-off-by: Djordje Todorovic <djordje.todorovic@htecgroup.com>
> Reviewed-by: Chao Liu <chao.liu.zevorn@gmail.com>
> ---
>   target/riscv/cpu.c                | 1 +
>   target/riscv/cpu_cfg_fields.h.inc | 1 +
>   2 files changed, 2 insertions(+)


> diff --git a/target/riscv/cpu_cfg_fields.h.inc b/target/riscv/cpu_cfg_fields.h.inc
> index 70ec650abf..51436daabf 100644
> --- a/target/riscv/cpu_cfg_fields.h.inc
> +++ b/target/riscv/cpu_cfg_fields.h.inc
> @@ -154,6 +154,7 @@ BOOL_FIELD(ext_xmipscbop)
>   BOOL_FIELD(ext_xmipscmov)
>   BOOL_FIELD(ext_xmipslsp)
>   
> +BOOL_FIELD(big_endian)

Since it is runtime it doesn't belong to RISCVCPUConfig.

