Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65831C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 13:36:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAV5g-0007AU-KB; Fri, 24 May 2024 09:36:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAV5e-00079b-5S
 for qemu-devel@nongnu.org; Fri, 24 May 2024 09:36:10 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAV5c-0000ae-Fo
 for qemu-devel@nongnu.org; Fri, 24 May 2024 09:36:09 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-681a48efe77so703388a12.2
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 06:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716557766; x=1717162566; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NKExTAqj07lQDqP0uFgd/kJWbBOJXXVoNJaA3FR8d54=;
 b=TwGi556s27K8wyjpLRc9raeWxcdKNzdXHWvZUaNWC7S2HDIOqh19zt3AIjtp09Lq/G
 YYxLTUj6qR5cIQv0yObnQF6Cbo0r42VSpS390+r8kBEHH7Zm+eEslctfztN/HUCcPG76
 phNSE0kDlevjU/EjEaeRMt0nSIStcYJnAel0ARb+y1JIWzSgj/qkeClCLPs6VfGqh+E5
 vMjdswC7/OCdGqoEMLXT2hrJV5Jr09DTOXSK9Q8BpcS7nMeFZX2N33zJnV0ehiYKUPDl
 xFbenaMV1qc1ppDRMv8fDImozS+skLDcTcVg7VfPlWYACGteVV/BZ7mD/lZ4b0AXccRN
 gY7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716557766; x=1717162566;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NKExTAqj07lQDqP0uFgd/kJWbBOJXXVoNJaA3FR8d54=;
 b=KAlY+9LXo8Isg29O264UBcOjFWgKL+k6ZGIyvRt8ZkYTVr2Mjf63ieHe5WMTEDbMFS
 EWKp0fyonLGS+5vq7KVLO/4+n7b2DLV6llEvrfs/gtdKLjFTOWwICFffSw8g4ZaqcefO
 8K2Z3vOew6ua04iq1jdygQzkUpVX5dOTRmFLD0eDrdy2usCYb0kr7Ho8CHoelCR3s3qJ
 4R469n950SuKDDDqSHVDtdiFPbhvh6UF5dRJv965XGYhaL8wZfZRvqrUTll7EEUFUlyC
 01ZMmcBsjcTjm+B0JyMuf013UkNPHFdwxasaW58X1wNNZM/iTgVxeaLkLX3muLSky+2u
 3pJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUhrJ2oUXFYPO/BoVIzM6Eq27fSo2YiG+iWC7ouy2u7id/wNhNQPFRwwqSRL/sC/2KN7UY0ERf6wVjzKLZT00HlPBTL7VY=
X-Gm-Message-State: AOJu0YzQUI2AbGFe02V2OEB8kOtvTif8bHLMej/Jh3oIGhgS04I9mL4M
 SsfXt3aIalvQsBFtfrJSXwZlpRYz84DLTu1kWHp3nT+OTYJztnSyU5O/EhliWY8=
X-Google-Smtp-Source: AGHT+IGVsYsGLC6hJEd3BCCFbuq3MO5ehSJn33yJAvgWmbcy2LoeLvlMozkgel6M+JHddH4lB+443w==
X-Received: by 2002:a17:90a:e007:b0:2bd:e8d3:8808 with SMTP id
 98e67ed59e1d1-2bf5f10aa16mr2012924a91.49.1716557765921; 
 Fri, 24 May 2024 06:36:05 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2bf5f989871sm1353558a91.40.2024.05.24.06.36.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 06:36:05 -0700 (PDT)
Message-ID: <747545de-de3d-4f55-aee8-a8dc7b2c970a@linaro.org>
Date: Fri, 24 May 2024 06:36:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/72] ppc-for-9.1-1 queue
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org
References: <20240523235319.56568-1-npiggin@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240523235319.56568-1-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

On 5/23/24 16:53, Nicholas Piggin wrote:
> This replaces the previous PR for tags/pull-ppc-for-9.1-1-20240524 note
> this tag is tags/pull-ppc-for-9.1-1-20240524-1 (added -1 suffix). The
> changelog and code are unchanged. Subject for BHRB patches are fixed
> and trimmed for some MMU cleanup patches. So I won't re-send individual
> patches to lists.
> 
> Thanks,
> Nick
> 
> The following changes since commit 70581940cabcc51b329652becddfbc6a261b1b83:
> 
>    Merge tag 'pull-tcg-20240523' ofhttps://gitlab.com/rth7680/qemu  into staging (2024-05-23 09:47:40 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/npiggin/qemu.git  tags/pull-ppc-for-9.1-1-20240524-1
> 
> for you to fetch changes up to e48fb4c590a23d81ee1d2f09ee9bcf5dd5f98e43:
> 
>    target/ppc: Remove pp_check() and reuse ppc_hash32_pp_prot() (2024-05-24 09:43:14 +1000)
> 
> ----------------------------------------------------------------
> 
> * Fix an interesting TLB invalidate race
> * Implement more instructions with decodetree
> * Add the POWER8/9/10 BHRB facility
> * Add missing instructions, registers, SMT support
> * First round of a big MMU xlate cleanup

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


