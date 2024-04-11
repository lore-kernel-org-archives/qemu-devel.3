Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 79CA3CD128A
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 08:01:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rupMN-0000Gi-Bs; Thu, 11 Apr 2024 04:00:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rupM7-0000Dp-By
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 04:00:25 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rupM1-0002hM-8h
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 04:00:19 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1e3f17c64daso32858935ad.3
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 01:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712822415; x=1713427215; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=5JT7sZChA2/x5KcgIxWMLjqTDwnx7TkciMitpCTStl4=;
 b=W/OXaa0fE7/sO1tAKjVDQoLrx6aiZqXLpppVJaCankWA8UCeowQoEuKsO9ZVgvnOwP
 zxCY/UIQ87vZkZjLyVy/V4qaZpATIKuBARDBefgkNkysOnutSLYq7HiYiejLPkspENEn
 Ndlyr4cZQlWOM+TND8a8r0ImXEtNlA/ipCGf9kHTxMO2cB7tQX/IIHS8Y9AxeCxRZwbw
 Qfe82h4RONsbvZSpFSZjGXCfLE5Y5SvSlWPgSAs9SPE54oG0Ww4oJw3vHLKGw6acGRgW
 VEt8SR6PzCapyI3OsmppyREAHceks8LwSlP6fCvtj2ZCBLrt4539QqE8z75cwnr43wLb
 o0DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712822415; x=1713427215;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=5JT7sZChA2/x5KcgIxWMLjqTDwnx7TkciMitpCTStl4=;
 b=MHpkAa+yq/XXZMolqS9GDVUd7E6yWWvGxuOWiDBX8P27B5AmQ1a2k9TRn6MrB8DH5c
 YwmQ/PccrmZXMMo13XTouW9suPduB1LFP24laQEk1BPwzZCFMaTvNpfJMeJ75IJWzGXM
 i7cmgnJ7ElVkg+IQbWoMAphgt1ytK+KCKD4p63coJAsrBNohGfT2DdFusj+v2IQoFLo9
 WZX1pIgucUcWp8FX15qW9ieZrknd4wJQOi4A0fLacq6btpoisNqs/ahiQThepiaIXam5
 XFFE8M4DPz58grz4xr9QNPJjlB6kzGqu1yPcr68sVZEqZHOgRxKqFbZ7PUfyJ3yvAn+L
 9cGA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVrklJbEGP+AxkhxxzuFXg+WI9lWNiCNgUiNC6t7B2VmCLU7gXHw8ZY5V+iT7kh3WQjxz3Rzc5nmgKFhAt4wlBxuNk7nLs=
X-Gm-Message-State: AOJu0YzzjtHUQVHBeel2qT9qzlCvPtjgvMNXeWVsPB5Mbd3qPBY8Dg4X
 fUudqiy0HQKxnpYtzEPnf5Wog/Y6q19AhIIrISpxuB2rEUbFtXgkne8yJxLx9DTrxNmZL0+muQb
 r
X-Google-Smtp-Source: AGHT+IGDKhQ/c9txMbhcQOXf9NDJgjNLXdj1Uj1+cuXpn+I2uQAYa1+gQ6xtcshmmRccejdkNw7YFQ==
X-Received: by 2002:a17:902:a386:b0:1e2:bf98:f1ce with SMTP id
 x6-20020a170902a38600b001e2bf98f1cemr4844721pla.23.1712822415110; 
 Thu, 11 Apr 2024 01:00:15 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 v21-20020a170902f0d500b001e0a28f61d0sm682926pla.70.2024.04.11.01.00.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 01:00:14 -0700 (PDT)
Message-ID: <beebf757-d082-4ca2-88b0-743905f559b3@linaro.org>
Date: Thu, 11 Apr 2024 01:00:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 13/19] target/i386: move remaining conditional
 operations to new decoder
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240409164323.776660-1-pbonzini@redhat.com>
 <20240409164323.776660-14-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240409164323.776660-14-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 4/9/24 09:43, Paolo Bonzini wrote:
> Move long-displacement Jcc, SETcc and CMOVcc to the new decoder.
> While filling in the tables makes the code seem longer, the new
> emitters are all just one line of code.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.h     |  1 +
>   target/i386/tcg/translate.c      |  2 +-
>   target/i386/tcg/decode-new.c.inc | 56 ++++++++++++++++++++++++++++++++
>   target/i386/tcg/emit.c.inc       | 10 ++++++
>   4 files changed, 68 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

