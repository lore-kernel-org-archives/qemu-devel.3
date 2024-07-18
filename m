Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B9F0C3DA49
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jul 2024 21:02:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUYFd-0005uf-Va; Thu, 18 Jul 2024 17:01:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUYFZ-0005s0-Vh
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 17:01:17 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sUYFW-0005Re-48
 for qemu-devel@nongnu.org; Thu, 18 Jul 2024 17:01:16 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-70ce3d66a8bso197551b3a.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jul 2024 14:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721336471; x=1721941271; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2sgYWmI3maIsQCVoK33B3b+oddvpKUkwbWnZ9+beUK0=;
 b=mZZXMrb6F2JLMyV/cM1hbzz6iOC8Gf3ZkM3B10OZLJsdKFalKcP/ACPUXMcWnfK8md
 2oOggt1ZA9ybAZ2WYicTAQzZHLTXwV4vefPJ/9yFlSt8/2s7+ntBuf5Q4RQj9P+Tlq+b
 SuU0sAvakF0TdrMZmBdkSZ5qfwUt2ErrCW2S0PbCecN4JJwD17dBcir0H5jjb+tofoPz
 LG943xTPFiNtIiJKZalonaKKg/1tox0Vx6ohOCbQDtTJRnIqLnsattIdbiWHvnGF04Ws
 5r2YaLSKII9N+hXF0MdyoBGFwZh1qljDK/54TrdhtkplNI8uSpMztEL45Gv8bxnMuj3t
 x5iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721336471; x=1721941271;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2sgYWmI3maIsQCVoK33B3b+oddvpKUkwbWnZ9+beUK0=;
 b=msWHONR+t5+hd/m9m9Yswa/E5ksJhPd3bZKMK71keu8F+nvrnZ79IV35acFkmneusp
 Rhs8FNaKegjYmMIzJnUJLGrIccJ3NKrx/8setQmZpxkeN3uVC47BXoluSrE1pa0EDvj7
 xes+AH1o89+bXyI2HLi1UbBGcLs2v3hn0FsmrBWIbKmAHZfBxUm7GIAUIU67+L9h4oBb
 oeeCx1f4WygBfQpWuNCXqwXPuuTFo0yPyy2Pnrvf0EFawTYxZrcaDv8LCXMHw6YKoT/G
 9+rn8K2Z8lN17lmAssRcCNtXx63/V86UVW2gfk5JPdKASXn8xzruYcN8j6thml/p/pfe
 RJAA==
X-Gm-Message-State: AOJu0YwWLpLC3LDnOTTKEnM9t7yDed3Mxn5x0q0NjCpUfGL+2a+Oh+9R
 meLaiUMU400On1lbWIgmWzElLEVn7dKgKEjq+3GbD6WFNZSBncx5skwk3AuQw7VZdj95/D07cvx
 7oBgx4A==
X-Google-Smtp-Source: AGHT+IF1bJncQ9yuRRbI/VHBNx3r+eS85I8eBddYsTb+bTvewi9KELCRgIGGEOj3DxNIHVDQ4WTPIw==
X-Received: by 2002:a05:6a00:218b:b0:706:6bf8:bd7 with SMTP id
 d2e1a72fcca58-70cfc9a87edmr1019017b3a.21.1721336470196; 
 Thu, 18 Jul 2024 14:01:10 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70cfc83e926sm249589b3a.192.2024.07.18.14.01.08
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jul 2024 14:01:09 -0700 (PDT)
Message-ID: <1827c97a-3036-44d7-a192-91bc41a5f56e@linaro.org>
Date: Fri, 19 Jul 2024 07:01:05 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/30] riscv-to-apply queue
To: qemu-devel@nongnu.org
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240718021012.2057986-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 7/18/24 12:09, Alistair Francis wrote:
> The following changes since commit 58ee924b97d1c0898555647a31820c5a20d55a73:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu into staging (2024-07-17 15:40:28 +1000)
> 
> are available in the Git repository at:
> 
>    https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20240718-1
> 
> for you to fetch changes up to daff9f7f7a457f78ce455e6abf19c2a37dfe7630:
> 
>    roms/opensbi: Update to v1.5 (2024-07-18 12:08:45 +1000)
> 
> ----------------------------------------------------------------
> RISC-V PR for 9.1
> 
> * Support the zimop, zcmop, zama16b and zabha extensions
> * Validate the mode when setting vstvec CSR
> * Add decode support for Zawrs extension
> * Update the KVM regs to Linux 6.10-rc5
> * Add smcntrpmf extension support
> * Raise an exception when CSRRS/CSRRC writes a read-only CSR
> * Re-insert and deprecate 'riscv,delegate' in virt machine device tree
> * roms/opensbi: Update to v1.5

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~

