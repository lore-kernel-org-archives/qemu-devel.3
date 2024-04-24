Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E721BC4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 22:12:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzkqA-0004Na-G3; Wed, 24 Apr 2024 18:11:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzkq7-0004NI-6F
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:11:43 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rzkq5-0000Y7-EW
 for qemu-devel@nongnu.org; Wed, 24 Apr 2024 18:11:42 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1e51398cc4eso3148615ad.2
 for <qemu-devel@nongnu.org>; Wed, 24 Apr 2024 15:11:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713996699; x=1714601499; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=643pKW5znqUgGBxpTv9ovGF7IMPEKkOZq25yYVQyD7k=;
 b=DblKqPV3/mYkHTzf54k/XQmRWeprssye3Ir0QwyOPhY4MdliExRdDdgRa7ihgkblUO
 R+5Upa45PcAXhUSBoqjoDrpfkYx3EohV53OJXNlOkHMO619Tqzw8ixmuLwKifb88V4vc
 dOK2xHFvOb5LRsjY8GmGZWZivU8/ywarNQEl7CZAURBrj8usYVf3Dq1RJH7j9tUXsouQ
 FZ/Fzejd/yvnkIBiEBnjt1NKcfSJg5xQFQE2aVZveORQeJ2s7XXOtUXgffU1Hexy99+B
 WRHn808xNJ8WuNaFsabZAy6lDqklTHqk88EZR2FGYzMPvCF1fyYAMqDDElcpaFwU4hby
 f62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713996699; x=1714601499;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=643pKW5znqUgGBxpTv9ovGF7IMPEKkOZq25yYVQyD7k=;
 b=Ptn7jj1fZjQxX9WYWdzgpy2/kHQlpt/mV7IyGCeXpSOItosFH7m/Y1qFGJ6qVcjJOD
 0qZ2baZdNZH0AD4OQTq+YEjKeZ0VrJ3IIQVc0BD7L5f2cJDnUYCkUg5PpSg0qvpcoB4L
 LxHnUCIodc1b8anOx+1YotUK1KEXx/6ldw05e13qfJqTAprgIMjjrO4jGOYHGOYFc4Pt
 XNghkpKEDzbM8Ubm3jml/LWAwsZ2cq5Vp/npGL4p7/ERbOK4BrEAnEUaSoARPpqRTwFA
 CUigh3WgnUnF6EeLZTM36CkWvV0Rt1D0cdJbQzpwgumeJ7Es8hRovlV8g23ARHtSPqn/
 EG1g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUlSKlMY0ClsTr7+7aGd5IB2N3+55qYMUlEGHY/QkfL8m868BPQaixKf7ZK7Gd3zsyn0huYOLVOlKx2r4q8oHS/Y6eTGj8=
X-Gm-Message-State: AOJu0Yy8beOEs7v0zMKr1f2VXR3DsHrGcLIJKJPF5meTQ1BXHa0nUBct
 /3YrernIqykk5UY006ZRAH6O/agPa7gdqIGl8vdTwaZNYdDTxnhbUhHWhiuxqlo=
X-Google-Smtp-Source: AGHT+IFeRlFHAgQGmaDJa8JFhkVsFif0Db/Rl6sd2m7wMaTKt3QwKBYA4SWFp8SPsRUhKEtnXXVdMw==
X-Received: by 2002:a17:903:11d1:b0:1e2:3cbe:adcc with SMTP id
 q17-20020a17090311d100b001e23cbeadccmr5303650plh.49.1713996699409; 
 Wed, 24 Apr 2024 15:11:39 -0700 (PDT)
Received: from [192.168.91.227] ([156.19.246.23])
 by smtp.gmail.com with ESMTPSA id
 i2-20020a170902c94200b001e27c404922sm12406278pla.130.2024.04.24.15.11.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Apr 2024 15:11:39 -0700 (PDT)
Message-ID: <1f462798-2d10-4590-b2ba-79fc5b737448@linaro.org>
Date: Wed, 24 Apr 2024 15:11:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/3] include: Rename some expanded headers using
 '.h.inc' suffix
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20240424173333.96148-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240424173333.96148-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x635.google.com
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

On 4/24/24 10:33, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (3):
>    hw/elf_ops: Rename elf_ops.h -> elf_ops.h.inc
>    accel/tcg: Rename load-extract/store-insert headers using .h.inc
>      suffix
>    accel/tcg: Rename helper-head.h -> helper-head.h.inc

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

