Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE79AC3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 07:54:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZn71-0002Ri-Vv; Fri, 02 Aug 2024 03:54:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZn70-0002Q6-RK
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 03:54:06 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZn6z-0000eQ-4E
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 03:54:06 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-7b594936e9bso1768750a12.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 00:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722585243; x=1723190043; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/b611YpZjkMvb0rTCnsyZ4CNe6kQ3vpzKiwOCuM6mqQ=;
 b=MNP1yhTfY3JVu+HfAXedjgejaLy8ciToLuNKfNDoUvZMOkI70L9VFIrDviY7A+FiSy
 Hk7h5svvox7MjwXRPFgJSYZ8mCBKr7neEy7YDjPaV5GLRoXLnr1k0mxJPJ6/MQfAl4t6
 t4P43xC9ZP8IX4Ta2Jz4/zob5eBEyrB+DSAPa2p8Hy0+/kSs+yuqQaRXC6hJRZXwDp6E
 JEzyk66aCA34JR3hL0elXZc+DDaI6KO4p7Tgnz3pSUlxdSQh/NQpOhQoMnwl3CzIiJDk
 ELOWIi9a1ud65aQ7uNY9kjIj59aWnHyWnk4U9qIdjpvBcqldvAkYhCHvem++kCD4+RVr
 FSoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722585243; x=1723190043;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/b611YpZjkMvb0rTCnsyZ4CNe6kQ3vpzKiwOCuM6mqQ=;
 b=DJ8fWh+Q5rvg4wThpUC46TQ8YNm5NfwZNwWL4hvMC6pApKS6l0hI+TyNMBajZhSJMl
 R/qLOYsMEkje65JttrGc9RUBjOuospV7OsmIBO4Vr9ldytk5xdWB2XT6207cg1ONXl7N
 I3zbLUKLuM0UvHEEmT+bdgFhxHAdFDTYY0Nwp/V9rgBv8k3Yddjxctny98iuYix8+gy1
 cAHDWUCQa2ZZm5pr8YzVbjMlaL0ayQ0HaaS+SiFIAQ7AYQAkJ6Nzpvbf3KVjweZNwwIo
 BToCz98BwCJOfWt85akJRpwCAgUkWWrbCfRQHk5CR1Hb643aoZSynf4mQOzfkzY8DgaU
 Gwqw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX1zu0hAI19lGBuT83V+eXw9pwCs4xH4B95NUPleUaACRGo2wRW1Y1RPUMeaEsP5OuPAExGQehWTGoyKAghoLIANi0qqsc=
X-Gm-Message-State: AOJu0YyxMxL4zqHaHCF6JHX/gC8CLYRe4WBscnRACU8HlXwDMIgHn8PK
 XXp9LDbXIXq3YujXQuPRpLiWO+v+j2M9RRGjDIDNfeKmSJWmyT6BwdAXN4MtE7Y=
X-Google-Smtp-Source: AGHT+IF9U17nws+Q50VBO5HUL9JINZ9Lm8/X+jQf3gYwc+RFtZKpbCuEJ3tsHZ2Fn66e1pEuvf6rPA==
X-Received: by 2002:a05:6a21:2d07:b0:1c4:8690:9862 with SMTP id
 adf61e73a8af0-1c69965eb46mr3123824637.43.1722585243242; 
 Fri, 02 Aug 2024 00:54:03 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f18616sm11045845ad.39.2024.08.02.00.53.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 00:54:02 -0700 (PDT)
Message-ID: <30259cf9-d81f-4af9-a297-12af88447f78@linaro.org>
Date: Fri, 2 Aug 2024 17:53:56 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/3] target/riscv: Remove redundant insn length check
 for zama16b
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com
References: <20240802072417.659-1-zhiwei_liu@linux.alibaba.com>
 <20240802072417.659-2-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802072417.659-2-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

On 8/2/24 17:24, LIU Zhiwei wrote:
> Compressed encodings also applies to zama16b.
> https://github.com/riscv/riscv-isa-manual/pull/1557
> 
> Suggested-by: Alistair Francis<alistair.francis@wdc.com>
> Signed-off-by: LIU Zhiwei<zhiwei_liu@linux.alibaba.com>
> ---
>   target/riscv/insn_trans/trans_rvd.c.inc | 4 ++--
>   target/riscv/insn_trans/trans_rvf.c.inc | 4 ++--
>   target/riscv/insn_trans/trans_rvi.c.inc | 4 ++--
>   3 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

