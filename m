Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52F0CC49EA1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 02:07:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbW4p-0000xz-2z; Tue, 06 Aug 2024 22:06:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbW4n-0000w3-AX
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 22:06:57 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbW4l-0007yq-IL
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 22:06:57 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1fc66fc35f2so3315925ad.0
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 19:06:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722996414; x=1723601214; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Q6AnjNQhYAgk5t3adXmD53s+4M3IePgjeJO4VTqb//k=;
 b=OaEtcardDk7ffxNZdY6fM48wVwUlnCKPFXzd+A0+V4qB/F8xGvLjAGp0fRuSkrXlo3
 satfJq0FV+rLLhLaHH/Bq5g1WqLoKmMUw8TZc5iCcKrJ4SqzBtIpCBp//VOPUUno/ksB
 n+trubxWe9wUUru/Qro4VYUuwKHmDWDuj1XX/uCiWdUnttx5oylPkc61++JMAs/ZiOwM
 qhKPdYdZIl7QJBNLx8/Vf3GF7wogL3w+wpbtliApDI4HZmnN24sfG0Am0M6e8j1/N9G7
 TZpJNFVrVx0aH54U8GK83+bYZidH4+gsXi0G0ZGkvyxdGh/DKXxgNr/uhGJ1bNsm5A4Q
 6FGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722996414; x=1723601214;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Q6AnjNQhYAgk5t3adXmD53s+4M3IePgjeJO4VTqb//k=;
 b=lF1MlQujQT2FnRNDC6TefJLgGK01Z06A7omcBIMmQb3F6oyBUw9ylWXbl5zVKoYN1c
 xvqsHgGrRZI4+ga40JDB9i3tfUfyJt6YVNqumI1ln5kv7So5Lq/I3sXDaV3/47pdk6Fc
 Au1WSoOdwrCMRBT3YU22P+XRpVvWu7EHwjFd8xh2U5fE2Nf/EbTjMFUSjxYoWGcDaofM
 XhxJmXdLTy3uIla7RoX8I6M90b6Lti3GhwZWLtTVrcxxAhoriqsyGRPJ7iRC/Mefh2D4
 5aeMZa1VEtj0UyMSL9aB7IvdVDxJpyQZcJhgM7EgFPMkxnQ3P5zrSUo4AQ9JHGti+OAn
 MxuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMUesJNnhf9u2qPn//obCh6y9ZVY4/7OKy5OcTi93TcPqzPGqHzMGReaUtrFBy6nDFVDYCGQfxJugSvhxBMLfn1tRE30M=
X-Gm-Message-State: AOJu0YzM+2MBje2ZxKoYrDnV2axZ30CvAEZDkMX9GnQgGPpqzyMqKGpa
 cRcI8/THPNlNlYxETt8Z2mK6chVzkLnR9Fy2zmfk6xDYwr+1lcweYf5wtcQkfpE=
X-Google-Smtp-Source: AGHT+IE5ZZaKXQ4seFG689+d+JYbDijgfS2d4OudBg80MBQTeCip6isu0m3ILzeCdr3Ea0Uc5iV/MQ==
X-Received: by 2002:a17:902:bd03:b0:1ff:4a01:43f7 with SMTP id
 d9443c01a7336-200853eb6e2mr8898875ad.10.1722996413650; 
 Tue, 06 Aug 2024 19:06:53 -0700 (PDT)
Received: from ?IPV6:2403:580a:f89b:0:e01b:92e5:d779:1bc0?
 (2403-580a-f89b-0-e01b-92e5-d779-1bc0.ip6.aussiebb.net.
 [2403:580a:f89b:0:e01b:92e5:d779:1bc0])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff592b89bfsm96049305ad.308.2024.08.06.19.06.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 19:06:53 -0700 (PDT)
Message-ID: <bbe3681c-358e-418c-b172-ec3728ff63a5@linaro.org>
Date: Wed, 7 Aug 2024 12:06:44 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 08/20] disas/riscv: enabled `lpad` disassembly
To: Deepak Gupta <debug@rivosinc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: pbonzini@redhat.com, palmer@dabbelt.com, Alistair.Francis@wdc.com,
 laurent@vivier.eu, bmeng.cn@gmail.com, liwei1518@gmail.com,
 dbarboza@ventanamicro.com, zhiwei_liu@linux.alibaba.com,
 Jim Shu <jim.shu@sifive.com>, Andy Chiu <andy.chiu@sifive.com>
References: <20240807000652.1417776-1-debug@rivosinc.com>
 <20240807000652.1417776-9-debug@rivosinc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240807000652.1417776-9-debug@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 8/7/24 10:06, Deepak Gupta wrote:
> Signed-off-by: Deepak Gupta<debug@rivosinc.com>
> Co-developed-by: Jim Shu<jim.shu@sifive.com>
> Co-developed-by: Andy Chiu<andy.chiu@sifive.com>
> ---
>   disas/riscv.c | 18 +++++++++++++++++-
>   disas/riscv.h |  2 ++
>   2 files changed, 19 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

