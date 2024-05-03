Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37C99C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 08:46:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2oYB-0007r7-80; Fri, 03 May 2024 04:45:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2oY8-0007oy-89
 for qemu-devel@nongnu.org; Fri, 03 May 2024 04:45:48 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2oY6-0006g7-O7
 for qemu-devel@nongnu.org; Fri, 03 May 2024 04:45:47 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41c7ac71996so34358315e9.3
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 01:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714725945; x=1715330745; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=x/16csSxfi6fftgPS7aE0JnuIcefXTp0ZVi237gcXZM=;
 b=q1bTN8LWFJ9i5nZlh9yeoDG60SPmDAKylzHQc7YAx39jnOU+BrFpJgoeLrMTMnYRUs
 /dLYorxJ5iqRyBI0qylMGCyiu1qiPIGv9VAlgdbUdFj1GXgudTKSWgqx8oERIgYk9ZAJ
 EQo1o0NHrqOU6nqPFcuMUK68k6ic+cbuNBaIk0Lgay5O3PKCBxBtP6zpweOd1h6yIzjj
 tdINTyehB3xRg49qPGUEag+4uVLhLT45p9l/fGoRvDU79WNj7kgqVp2Ny4MB0crxPaui
 vCAjveQAKZ2l/uU97rquPBbYo9XV1qesnpW+ZaiLIDeHA3TwBDSQen3lQTHn3k8j3Pjq
 vZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714725945; x=1715330745;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=x/16csSxfi6fftgPS7aE0JnuIcefXTp0ZVi237gcXZM=;
 b=ttOxww9CSfc8hScNVWt81jE+vfMVgXVYzHDkYHjKdUGhsJCwEY4zGJq7iL/YKQsJtE
 Vv3yOfKS8AjcoBdQc34aRQfrVs2is0E0EA7R1Z7tHDAO4UDMDC4ANOdSh1qBtpfpjzgB
 v10ho4R4Al9rtX3o2PNCk35DZm93kYpl9CHwaDSfuwU3Y6ufmS5i2lMBGWTbsc++03j3
 8fJc1nAuifXtiqobGk4f1oQANTyU/G6UYFeOWnMHY3bTaSW+/xSb59cyf2YbyYygtZCH
 95rh7ndlahxZuxB/LFlEvSU8v0zFUbIhSlk6It3t9BxxmNr9ZNTTiqn5CXBsYlEisHU4
 KEJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7D5Ve6Y4od8nWImr5bFCLQ/1KYnZVl7NzDlNyhrWASVkdZeUlTf/FtUdL3TvqWF+OUl4JfSj/iFF3YB+TygUBIsF02ok=
X-Gm-Message-State: AOJu0YxbWa+ACT2gBSofLWfIBjVBW4B3B+wdTmH0GSe+A33Q0zGeV77p
 xPscWj8JI9GNxY0X2PgCLj4A6sFopXTZZRyfG04wlCcAvXdzlKL4WhveLoiBxB//xscA8Mgl/Eo
 i
X-Google-Smtp-Source: AGHT+IFAhyxvl/yDo9j4AVkjF7ORxWJplaEh7B8UpAy2836HHUVXI4Fjh6K3PlGQzyb1ft6iGKGDfQ==
X-Received: by 2002:a05:600c:1c8d:b0:419:f27f:6b05 with SMTP id
 k13-20020a05600c1c8d00b00419f27f6b05mr1614684wms.8.1714725944927; 
 Fri, 03 May 2024 01:45:44 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 d18-20020adfef92000000b0034c71090653sm3196103wro.57.2024.05.03.01.45.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 01:45:44 -0700 (PDT)
Message-ID: <03eb433d-c0c7-40a7-8df3-09cdd7896488@linaro.org>
Date: Fri, 3 May 2024 10:45:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/13] migration: remove PostcopyDiscardState from
 typedefs.h
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240502155331.109297-1-pbonzini@redhat.com>
 <20240502155331.109297-9-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240502155331.109297-9-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 2/5/24 17:53, Paolo Bonzini wrote:
> It is defined and referred to exclusively from a .c file.

Ahah what a shame :)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/qemu/typedefs.h  | 1 -
>   migration/postcopy-ram.c | 4 ++--
>   2 files changed, 2 insertions(+), 3 deletions(-)


