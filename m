Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB29BC3DA61
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 22:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUZgd-0004dX-AT; Thu, 18 Jul 2024 18:33:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUZgc-0004WU-4O
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 18:33:18 -0400
Received: from mail-oo1-xc2b.google.com ([2607:f8b0:4864:20::c2b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUZga-0003Bu-5h
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 18:33:17 -0400
Received: by mail-oo1-xc2b.google.com with SMTP id
 006d021491bc7-5b9794dad09so653761eaf.3
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 15:33:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721341994; x=1721946794; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r5AlK+SbcGri6bbXPkTHnMVFPc8ZScwWoTqkylq+cSo=;
 b=hjovfv3NiZezpiSvG9156E3DFx2yP7vZtZ4ZsjvBOIHh3cbdoW4wWIW8r0Ove4Mv/D
 ZOM5O+2yEqOGTyAStchq1Ap0AJ2wLXhpaFdqaJZYM9nJ1Kyn+1vDxNkLs3YmTf3e4VbQ
 e6F3t4d8NDsldELM7ViKKXNo/vY60bfQvCwRX5rPiWf9IE1oZSaTgLS6XgC5jaIPzQI8
 2xXUptxlj69+/n43WcagQxT3q2txVF8XlYQY5Sm5vwBHKEFkI7JQGQ6RN76Hqp60ftrx
 pd8uO+LNmCu1XSSST/bIULsdDIMFFQPcGhqmD4CpTMFy9LcuNWm0dzNT+BlYyZxV1xGw
 txTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721341994; x=1721946794;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r5AlK+SbcGri6bbXPkTHnMVFPc8ZScwWoTqkylq+cSo=;
 b=K64dwpZJ0LHGcDpAcfNXl7cZJ6KhNwXWlNxr8vlmQ75XCxXYp2vT5FNMk2MP9k65cJ
 k8RbzI80jpjrk8Hobh/LZDSKL7Gj9iVGXEgJQIp/C8qfj2ijOhI//g8Pd9PVqbG9u2zd
 mUnNN82sl6PxngGwpfbU9PfSOZTCnVkjFbZsQQ8+ipuYgXYEA2Gj7NyLibsVR6NqzwB/
 2CCJWheVZtfTHf8r19i/c1Gsr5hCXBO5JOw8wrh7ZL6IhYlA1FbQqU3kMImkIN7G1SFq
 pbZdDPsiu1N4ouPXDfWsmzkOC0gyMIAYPP5ILtAn/C3oSdf8klQbA6RjyhYUtEVB1xaR
 /m6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZzpS8QdoUPeCOdLo9V/L+qlwcNZvY9pfnvWC6rbZKp83XWjuKPuQ41xBzvZ4zW2+ENMkJyPKtEffiEWGzgMgDytaKHV0=
X-Gm-Message-State: AOJu0YwwLtfC1j1ZgU5gMDZTBuww3aSJPwDdh7I+Nyfh4/zhGW9jFQK7
 KOv2iC9bqE9RfOx+TKrGO+1WCTSrUI549dGlyaI2kIvRBEapzrJDuUjtM9EWbww=
X-Google-Smtp-Source: AGHT+IHk2LNm7BrA/lKXddrqmKbLPrPGSvI/L5JuJhVGEUxp1iQTqvEotg3WfNGvVvHXJTYJ6xtGRQ==
X-Received: by 2002:a05:6358:939b:b0:1aa:d3b7:765c with SMTP id
 e5c5f4694b2df-1aca9ec8db0mr380308055d.14.1721341993695; 
 Thu, 18 Jul 2024 15:33:13 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-79db6cba71bsm66892a12.40.2024.07.18.15.33.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jul 2024 15:33:13 -0700 (PDT)
Message-ID: <09c0f51f-c7fa-4d46-be3a-d17ebeec4553@linaro.org>
Date: Fri, 19 Jul 2024 08:33:05 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 01/18] hw/intc/loongson_ipi: Declare QOM types using
 DEFINE_TYPES() macro
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Bibo Mao <maobibo@loongson.cn>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: Song Gao <gaosong@loongson.cn>, Xianglai Li <lixianglai@loongson.cn>,
 Huacai Chen <chenhuacai@kernel.org>, Xiaojuan Yang
 <yangxiaojuan@loongson.cn>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240718083842.81199-1-philmd@linaro.org>
 <20240718083842.81199-2-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240718083842.81199-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2b;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2b.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 7/18/24 18:38, Philippe Mathieu-Daudé wrote:
> When multiple QOM types are registered in the same file,
> it is simpler to use the the DEFINE_TYPES() macro. Replace
> the type_init() / type_register_static() combination.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/intc/loongson_ipi.c | 21 +++++++++------------
>   1 file changed, 9 insertions(+), 12 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

