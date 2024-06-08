Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 89CF6C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 20:14:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sG2RJ-00041U-Sh; Sat, 08 Jun 2024 16:13:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG2RH-000410-Np
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 16:13:23 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG2RG-0005L0-62
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 16:13:23 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1f62fae8c1aso25363945ad.3
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 13:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717877600; x=1718482400; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zbUZ4I/3AC9heKt8nZQrXGzFhc46V2A6hGPpNbkptq8=;
 b=DFNgWaaU4GlfYU35D5i/pp6L4hTskM5pDNXqSUKDSjLfKc54WPkOtJi6cMDacsfwan
 Or0HDu3Bqvi0GfxYkqC6uWvjgiIxdf7Gvo5jxEN5LPT0jGOVDtxLGjgRuRy9U3y2LdZg
 ySeQc3hmBT8vBibU6pWFjh4XqL7ln50kf75oe2YxnpIE4ZB7bktlUyKCf+L20bGNnLsl
 lAdpZqFFxyKyn5f55/chbRmx63EBG/PS4Vqr3Wc1h7HTDfAKlU89j2Z7uci2Q613b7d0
 nQE6xeC7rBMb50UauwBlNPEev+McKHxUyPEaeAtuDIg6WsmAPIiZGlXm+CGSvexqogy8
 TpQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717877600; x=1718482400;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zbUZ4I/3AC9heKt8nZQrXGzFhc46V2A6hGPpNbkptq8=;
 b=II8ihQvsqn7egRQlaLmy53sHZ+9Od9kC7bvmghP2IPTiiZ/cX6XrvceCH0FkuFN5Yr
 E6bMEAIvcQXn2D1jGRdPTXA2MQdGb9xAePSAyRhL5tCgJDdZCzdEFwzijyLDxzH8RBvD
 SsBS6sUlifOqVjD/RNyRi9ZU0PTjc4n1ezpax1IUWiH+xAXamzXRoU/pQjq7PjYW0wQa
 PMNSkYeaWsj7fGeJwLUyRQwuC4qrria9PO/KFNdUJSEY4ZE2cMyg/7dDFyz4cPqzyfbl
 v3VI987ef6mnBftrqSsz4LS46AW7gkviDFdXqomQG+nz0O+X3ays/jEOH3Wl50axtmdQ
 FWfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXBu+CFlpng13FGRr5azOxjWEBeG9XShzPbkeI4jn1tUuD7MOXAmC7/3xp/9iIobUEQ2+MeRL8pwlOjOLwYJokdWhCNDm0=
X-Gm-Message-State: AOJu0YzhN3M5wDYhPq2xFIl9NNeUv06jFTpFTystTw9GnuWuiJUNtVDH
 J+1vs41K9YwkNi+k2IVdUzDJ0Tbj8pOrSmwqrMwasTqe91/ldWH1C72tB3Yw59Y=
X-Google-Smtp-Source: AGHT+IHA4VBXIdAvyTrssDcMuju+Po5WjbX23iQH4Xr/iOZtvNjT25Qk6dT0tJo/wrs5eWAwxjB/yA==
X-Received: by 2002:a17:902:d2c8:b0:1f2:fc8b:ebfe with SMTP id
 d9443c01a7336-1f6d0389353mr65248935ad.48.1717877600154; 
 Sat, 08 Jun 2024 13:13:20 -0700 (PDT)
Received: from [192.168.64.11] ([50.78.183.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6bd7ccf8bsm55507625ad.181.2024.06.08.13.13.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Jun 2024 13:13:19 -0700 (PDT)
Message-ID: <704783f7-0ebb-4555-ad83-fd40b16546de@linaro.org>
Date: Sat, 8 Jun 2024 13:13:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 21/25] target/i386: decode address before going back to
 translate.c
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240608084113.2770363-1-pbonzini@redhat.com>
 <20240608084113.2770363-22-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240608084113.2770363-22-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 6/8/24 01:41, Paolo Bonzini wrote:
> There are now relatively few unconverted opcodes in translate.c (there
> are 13 of them including 8 for x87), and all of them have the same
> format with a mod/rm byte and no immediate.  A good next step is
> to remove the early bail out to disas_insn_x87/disas_insn_old,
> instead giving these legacy translator functions the same prototype
> as the other gen_* functions.
> 
> To do this, the X86DecodeInsn can be passed down to the places that
> used to fetch address bytes from the instruction stream.  To make
> sure that everything is done cleanly, the CPUX86State* argument is
> removed.
> 
> As part of the unification, the gen_lea_modrm() name is now free,
> so rename gen_load_ea() to gen_lea_modrm().  This is as good a name
> and it makes the changes to translate.c easier to review.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.h     |  14 ++-
>   target/i386/tcg/translate.c      | 152 +++++++++++++------------------
>   target/i386/tcg/decode-new.c.inc |  44 ++++-----
>   target/i386/tcg/emit.c.inc       |   2 +-
>   4 files changed, 94 insertions(+), 118 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

