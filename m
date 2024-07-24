Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C1B2C3DA63
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2024 21:31:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWjZI-0006Hc-LN; Wed, 24 Jul 2024 17:30:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWjZE-00060B-IZ
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 17:30:38 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sWjZC-0004Jv-C9
 for qemu-devel@nongnu.org; Wed, 24 Jul 2024 17:30:35 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7515437ff16so194511a12.2
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2024 14:30:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1721856632; x=1722461432; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SJMfIRMTGd52AACNjEtiq5ND9xq+s+LRPLRHrb+eX24=;
 b=ujRREkjLxlcVOWqQt0CuMJOOO0Ji5lCdnDRdaOjtQpdCOyFuGVIHV7c1n6VT/Y1E/w
 zdLFONdsa2PXzotMKBvNSPBDJDpbU2FQpV/qHuLboMXPq5ns0/8u66Dy84laS2H5nYJk
 i2RJXsr3RG3cCAlf+u2a/uB+CvURZhrh0n8vBTxfHS5yBGnxJBYghezT7xlfl4SF55Il
 Wwd6iGeog49I/G4eyJKzbHCclm6p6CnwYmhBTUlTfq5MKGfUOCIOqLKZIfHjdkkBCiGI
 0IX3ed4GwUqpW/9I78gKk+j6ZqKI3oFNRZOJp0bcTrMgdQ1P0uH5EcpItFxoyB3hS7Yp
 fmaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1721856632; x=1722461432;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SJMfIRMTGd52AACNjEtiq5ND9xq+s+LRPLRHrb+eX24=;
 b=Yd2nWei5kt4IgqDbWQboBlBxpWPNn+aGhquDQX+2OSczfX/f4+mnTvbCj/3b8i28VN
 N7O7YeS4d2/2oDMHeB0NRY8MmQSnugp0vhXssBzjmI4Wny2PEzT8X6bcJFnqZ2LlFvxw
 h85ZaNq413tiOy0bc9qyPhph2voGZOYRkC5sk+KvmkWOmc/fREBG32y2IlRIGmSohQ3w
 DSfuk2/25i4ACsZJktBjPBEIdlEKSdfkwZfifh8qSNJEFyCDnHFetWB+99cAT82SOugX
 RfHh2M4KXMjlP2mw7FZk1i/xbgK9sIDt8Wk5oVX7KH22P+y/osgZUpFyBx9W4OluBR90
 XykA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVnNWoFkMaXUI0TmmSLoZF4r2GIuxrHyT7ObML58H7FWLJjzwle0hgk4TX0SdnD3dzjoNAH7ybiNPg+jXMsISb3HsWNfUE=
X-Gm-Message-State: AOJu0YyNL4fvrUkKtYJmDL6bWmCK+uXDegUkRodGtyOaG9FMP3VSsBT/
 dSqYwXzqA971E6CmGuEPD6PpJU7wH4/jkZFuaUUvr3tD1jSJB4K5EMtnRw+kl40=
X-Google-Smtp-Source: AGHT+IEoxglnXzE2DV0XCr30dvQsrOfNud3IJuBVK4P+B27X27h88rRw1gT9jCPuSZVMSzcS/3mMKw==
X-Received: by 2002:a05:6a20:840c:b0:1c0:f2d9:a441 with SMTP id
 adf61e73a8af0-1c4732cf063mr1480132637.39.1721856632352; 
 Wed, 24 Jul 2024 14:30:32 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70ead6e1af8sm23700b3a.24.2024.07.24.14.30.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 24 Jul 2024 14:30:31 -0700 (PDT)
Message-ID: <a3f44122-c3c8-452a-94fd-e02165c00289@linaro.org>
Date: Thu, 25 Jul 2024 07:30:25 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 26/30] target/riscv: Do not setup pmu timer if OF is
 disabled
To: Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Atish Kumar Patra <atishp@rivosinc.com>,
 Peter Maydell <peter.maydell@linaro.org>
Cc: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org,
 Alistair Francis <alistair.francis@wdc.com>
References: <20240718021012.2057986-1-alistair.francis@wdc.com>
 <20240718021012.2057986-27-alistair.francis@wdc.com>
 <CAFEAcA-Lrnt30uvR5k+GVsM-goKuD7ZQzzxOpxocBf3C6BzvMg@mail.gmail.com>
 <CAHBxVyHZ1_zgg-V2aKMcYsZjWHwcfndt-rbTa0h8mp_Ufe7hjw@mail.gmail.com>
 <c6aade3f-4320-4089-9c76-7054f9850274@ventanamicro.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <c6aade3f-4320-4089-9c76-7054f9850274@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 7/25/24 05:00, Daniel Henrique Barboza wrote:
> I'm not sure about which generic functions we're supposed to use in replace of
> get_field/set_field, at least as far as bitops.h goes. extract64/deposit64 has a
> different API (it uses start bit + length, not a mask) and it would require
> a lot of RISC-V code to be adapted to this format.
> 
> Looking a little further I see that registerfields.h has the equivalent of what
> we're using here: FIELD_EX64 / FIELD_SEX64. But these macros seems to be tied with
> the abstractions used in the header, i.e. registers created with REG32/REG64 and
> fields/masks created with the FIELD() macro. The header smmuv3-internal.h makes
> use of them so we could use that as a base.
> 
> Hopefully Peter/Richard can correct me if I'm wrong and point to the right
> direction. Thanks,

Yes, registerfields.h is the proper replacement.


r~

