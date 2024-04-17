Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9735C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Apr 2024 19:18:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rxAnZ-0006AG-EE; Wed, 17 Apr 2024 15:18:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rxAnW-00068S-8N
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 15:18:22 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rxAnU-000507-G2
 for qemu-devel@nongnu.org; Wed, 17 Apr 2024 15:18:21 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1e834159f40so815285ad.2
 for <qemu-devel@nongnu.org>; Wed, 17 Apr 2024 12:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713381499; x=1713986299; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PonsRkuxnlAlm/OvJIsuXhpZ2JhdJmFVpt9gNl1w0GQ=;
 b=OM5VOsKzwh+WyFo2L65qnaus4B5hDXdb1AAmvD3Rlop/CIxmrtM0cSTDVJ7RV2LfBY
 f/GDHkxQs+PY5Lb+qK/YnQIc0YS5/e72lu48KfWIGMhPuAF5RYAaUCcQGk7Zcqfh9lw2
 vzaF56xNhjQ5Fc6QfmJOZn+BWPCngT5uWdnkm8lnz7nIezrjCnFXvSvks7VsLXECGDYR
 /sRGy4kGyrfX8tDfCYE/kwRO6wzX+ZB1wc03fzL5cd/p6q+dQtqLETrD+8DvgLPeNVLp
 t0v54+ToYw+YvF20uUD3i/MHcyExQVlhXw9LLS3TcdCI1aIyUTfRwOutvZ2baymn65zg
 YwqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713381499; x=1713986299;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PonsRkuxnlAlm/OvJIsuXhpZ2JhdJmFVpt9gNl1w0GQ=;
 b=Y1+fuJltc5+8+H1UluWvZnexUGOmFw6C4MmKB59945+WOCMv9w6CIcovdDg9jZE78A
 KvMvMU6Vra3E/Qk4JX4LVKTGrR+c8HXnGF2f1nDv6KULkJ6nEmNdFTsiHWaRUuymN/HS
 qZgpyqGaWvk7TYrBlCbvuKNfKVf/bLBakWSXBNf1HkvLENq4IBH974f/w/etAOtEHdgu
 Z53+bfrS4jfuWVK68DOKOwv2eHhtp4Fwn4sAYNwvAjdNkAwQr0ym5J6nqQVPd6k+2WIe
 oxKBYkZmbqDU/rLEToiQh4T8aJzSERDJXSLNHcu9pQsuNzDJPqWlPIwohfb4CWmVNyar
 iN6g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWl2VzR6ez7J08z04gZbfOtosLGKH4w2a0E0gcYSQtCgxKMv1TI24U3iie0TItIEdlKqrS/QN+DuaACS05Orur4zIWuHi4=
X-Gm-Message-State: AOJu0Yyd/W6ViajrMD5GB7I8I2UbGEbGoO5r8ZGEGq16RdlcdGiINcp0
 hJ4c9/pP/mNb6zNYJP7X1hhumx1l2ybwR4Dk7RoefbGn77S59BerabYEd7m5ZNg=
X-Google-Smtp-Source: AGHT+IE6OgvZe4+QRg4y4g+/VT3yImd715QCTa0e3y5DvQw4Wl1sr3TpckpwWB3vgmQc2ob6ySLmTg==
X-Received: by 2002:a17:903:8c3:b0:1e0:b9d0:f6b with SMTP id
 lk3-20020a17090308c300b001e0b9d00f6bmr540501plb.68.1713381499023; 
 Wed, 17 Apr 2024 12:18:19 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d16-20020a170903231000b001e4881fbec8sm11956811plh.36.2024.04.17.12.18.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Apr 2024 12:18:18 -0700 (PDT)
Message-ID: <cc6159f4-e51b-4ed7-bcf3-9ab179b53565@linaro.org>
Date: Wed, 17 Apr 2024 12:18:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/21] target/ppc/excp_helper: Avoid 'abi_ptr' in system
 emulation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Thomas Huth <thuth@redhat.com>
References: <20240417182806.69446-1-philmd@linaro.org>
 <20240417182806.69446-13-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240417182806.69446-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 4/17/24 11:27, Philippe Mathieu-Daudé wrote:
> 'abi_ptr' is a user specific type. The system emulation
> equivalent is 'target_ulong'. Use it in ppc_ldl_code()
> to emphasis this is not an user emulation function.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> Acked-by: Nicholas Piggin<npiggin@gmail.com>
> Reviewed-by: Thomas Huth<thuth@redhat.com>
> Message-Id:<20231211212003.21686-18-philmd@linaro.org>
> ---
>   target/ppc/excp_helper.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

