Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F44FEE6B66
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 21:46:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voTeK-0005TD-C4; Fri, 06 Feb 2026 16:46:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTdo-0005FV-90
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:45:29 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1voTdl-0002ag-BF
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 16:45:26 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-42fb4eeb482so640839f8f.0
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 13:45:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770414323; x=1771019123; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0aPOqd4Uhs7TsYl8DAC/nxsuVOAQs+b6z/+3jSq4XX8=;
 b=lh+DAOmJ33vM/kVjbMR9ybSs1vgFNedPm2SrXxP9Au4l9HVgvpgAfEwEZk/Q6BuPxY
 15RLhgafnQAzhsoYIbFcLWJi0U5eokwgW25KwN3C1B/OACuVoa4KtMMo/puKimGlBOSf
 NCDBh3ynegdr/hjMzuSf296DIvO+iWihnMQlu2kifbarN2besHES9+gZ84M6yPf18a66
 quBiwTElW94m15cS+PKd7N8AW6bEcvA/m/SrEUDIBCOs8fEOr7vEkKwepVn4QkXZAiRj
 TPnTV6KFkdH808hotsGrU+LfKVlFGvPDoGMqpihudcSnkJnO+RvyyBupv9LFUQMEePCm
 ykqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770414323; x=1771019123;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0aPOqd4Uhs7TsYl8DAC/nxsuVOAQs+b6z/+3jSq4XX8=;
 b=dbZPKCBRidLVinlxRfW+ToJbNq3E5jeCWB6WA4Br39G3D+2OurRahdM0T117f7UeW9
 T+/+V7Cgi+KijJCTxglwURPyYHZsTOTxLuCHGy2GcMBJpX+7f4aKP2rR/b25ib3D5w+H
 uFVABZaEb+taxMQPl4QAef549/3AX/vcUmvEf6a/MM8YDyK7kAYQ96caDT7JxjwDfbg0
 0a1Pe7n3mDjXYdMacZbfFZA113BVKKaO+O/+vA4hDvETwVzkjpYXl1yNXBJQX/j94YMP
 icg7wkU94qCJbc4qAvLVndJ5p/Gb//SGKBpb4bZklis3rGPmnW39r6g+aogmx+jnABhM
 XEcw==
X-Gm-Message-State: AOJu0YyLP2B5QwAlVJ0o3X2avHAj7D26H1G3jN08OLvav6zDVd7cRT4p
 YhlrOgEbx13tbf0JERy+MgXE2LyCjUr/odn6EHgQhtGjz+9IaqCQi1PaB+FS4CVig5FsMLggBt4
 fSvDYkpQ=
X-Gm-Gg: AZuq6aJvKnQamEAK8RH3CLTvHj49CJVRf0NoshAMuYp2fp1Attm4v5BW1xYcF/yAQ2j
 23VjvKY5bXOMo0WJusFB9XWtufwoEQ4kwbubWheDFHVopq00RSI0RXcqz6QqT+ejetRBsy4QSmv
 uae6FivqZ03Epxk9sDJxoYGY/PRb2bvF3R89fiI+0Upeubvxk/jC1Wx55Ob4gE4LMKwJM7FF0GY
 DpGyd5MfwdUiLdVzm8YS1PZlE59C09E6FByu0D/xCkvKWTm/VLKcaWvjndjtPoCsF7EsCAhCoUi
 yDHCgn62Rx6+3m0zNY6VwgB/qosCFVQZabsKjTSnpOqUFX9iDLZx0+Kr8YWW0cXKqn5qJ3h8vxH
 2+hRexvgV93+t98kI0RcxnQ4vgNm4t0d/CoHJ1jStoP/JLXO80po2Jt3bqO5vsM/P+M5tNyVaMv
 bS304oR7NjOK1JDnsfLOCoA+OQEJbIJcWQDO/GCpDyn/LLOH9RIJjmEw==
X-Received: by 2002:a05:6000:25c6:b0:432:8504:a383 with SMTP id
 ffacd0b85a97d-4362938a4bfmr7222102f8f.45.1770414322870; 
 Fri, 06 Feb 2026 13:45:22 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-436309ed238sm2863603f8f.19.2026.02.06.13.45.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Feb 2026 13:45:22 -0800 (PST)
Message-ID: <be309786-98bd-41f5-a187-41af3466d03e@linaro.org>
Date: Fri, 6 Feb 2026 22:45:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 00/10] target/s390x: Prohibit target_ulong and
 TARGET_PAGE_SIZE uses
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Matthew Rosato <mjrosato@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Ilya Leoshkevich <iii@linux.ibm.com>,
 Halil Pasic <pasic@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, David Hildenbrand <david@kernel.org>
References: <20260206181953.18683-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260206181953.18683-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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

On 6/2/26 19:19, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (10):
>    target/s390x: Use address_space_ldl_be() in read_table_entry()
>    target/s390x: Rename get_phys_page_debug() @vaddr argument as @v_addr
>    target/s390x: Replace %target_ulong -> %vaddr where appropriate
>    target/s390x: Replace %target_ulong -> %hwaddr where appropriate
>    target/s390x: Un-inline KVM Protected Virtualization stubs
>    target/s390x: Add more unreachable KVM stubs
>    target/s390x: Build system units in common source set
>    target/s390x: Expand TCGv type as 64-bit target
>    target/s390x: Expand tcg_gen_qemu_ld/st_tl() as 64-bit target
>    target/s390x: Expand tcg_global_mem_new() -> tcg_global_mem_new_i64()

Series queued, thanks.

