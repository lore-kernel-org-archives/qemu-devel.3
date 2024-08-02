Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F581C52D6D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 13:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZsPV-0004vN-Lk; Fri, 02 Aug 2024 09:33:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZsPS-0004hz-74
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:33:30 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZsPN-0000C9-Ru
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:33:27 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-70eec5f2401so5333293b3a.3
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 06:33:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722605603; x=1723210403; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8GlrSxp9P5B5tfjs9eUfnxeFfMzj9ZjmzQuC1PLy6jw=;
 b=OvxMUuiE/X9ALYJZTVV2EtC1CeVX5Tb+AwZDAh8wkqz4A7BGoUiZuQMROY9XsCUFRU
 YKomx1MCFBcbdvNGQTUTq7zGKRD+JV6+5EncASo+qLbBK32tAjOgN+022sL5Gig949m0
 xIm66MOUUieJIqU/ZaDbQ0ehtfI/7jwZWxZXNGarBD9iestMejJIYFI5maWcNr6Os0ai
 0zU0ixJSNVIDdVgq1z+4ixdRcWzVSxPRyFX2Z8o0LzJB8IzkkG5U+RlyoRn4N4F0KaZn
 YzbskAWCFAjHzKmSML+7+wirCVB3UrbuDWP9g/9Vddsj9jQfhdzR0yRvMb4DPPIdz8NQ
 r7zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722605603; x=1723210403;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8GlrSxp9P5B5tfjs9eUfnxeFfMzj9ZjmzQuC1PLy6jw=;
 b=YIOa7ZAdpbQoOuVncrRjSUbshvx5GXcGb/lUDmgR/FF09J6PG849Sf4DX709Q/7vo+
 Z3+K+cL+GJSEBCYT63pHpN9qkB/rLGJ+ZXQbLhDDtn77GKJ+cXHIv3uhRBNyqP7vPZ7T
 1WsaZiwh4WsjHrAoe+DdivKhJIcVO6RnvnzkIVSLokg5yTqw475oB62jSRNu/4LtnRax
 zMRV0lZ0y35V3q7EDPlWNfKGm45L6dBmPH2EcmVO/l94ly6DCIOhaPKB/gIydPgBpANY
 elheeJs4qJnOnpduAqCKLy7cPjKHX07R75ImbISJict+pKrZCKVdCa2DlgNw/hyrv5wn
 Havw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWqUNMwV0oEVAdrW22UfFSRP5jYMzdlk+pnKDzIAt2QKiSns+KzEcK1NddA6p+lcSfE5w2NwuYVVrluPd4DqGzpyDL0Sdg=
X-Gm-Message-State: AOJu0YyS1sMQLbK5oAPx490dzC6K6ac2iStyhaPdh0ZIh3BGbuBrjGpM
 2Q3//iXpXVEScd7e5jLrkppU6xXNNhNlD3OTFxVb+HCFQxI5dz81bRiG9m7vjBE=
X-Google-Smtp-Source: AGHT+IHgEw2u9hVxKylb+VTAebTDeRzdrGG+HsgLA5g9FvJ09lW4tzje431B3FQUoytnJ2Z/pnlXuA==
X-Received: by 2002:a05:6a20:2444:b0:1c3:a760:9757 with SMTP id
 adf61e73a8af0-1c6996b9b49mr5177633637.49.1722605603313; 
 Fri, 02 Aug 2024 06:33:23 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f57560sm17537695ad.84.2024.08.02.06.33.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 06:33:22 -0700 (PDT)
Message-ID: <8a108f79-4900-4340-b73b-24a79f82d193@linaro.org>
Date: Fri, 2 Aug 2024 23:33:17 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/18] bsd-user: Define RISC-V VM parameters and helper
 functions
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark.corbin@embecsom.com>,
 Ajeet Singh <itachis@FreeBSD.org>
References: <20240802083423.142365-1-itachis@FreeBSD.org>
 <20240802083423.142365-12-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802083423.142365-12-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x430.google.com
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

On 8/2/24 18:34, Ajeet Singh wrote:
> From: Mark Corbin<mark.corbin@embecsom.com>
> 
> Added definitions for RISC-V VM parameters, including maximum and
> default sizes for text, data, and stack, as well as address space
> limits.
> Implemented helper functions for retrieving and setting specific
> values in the CPU state, such as stack pointer and return values.
> 
> Signed-off-by: Mark Corbin<mark.corbin@embecsom.com>
> Signed-off-by: Ajeet Singh<itachis@FreeBSD.org>
> ---
>   bsd-user/riscv/target_arch_vmparam.h | 53 ++++++++++++++++++++++++++++
>   1 file changed, 53 insertions(+)
>   create mode 100644 bsd-user/riscv/target_arch_vmparam.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

