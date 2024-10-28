Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BFB6BD339AE
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 18:01:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5U2e-0003OY-IP; Mon, 28 Oct 2024 14:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t5U2c-0003OF-Ah
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 14:00:34 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1t5U2Z-0001Hy-S6
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 14:00:33 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-20c767a9c50so40211275ad.1
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 11:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1730138428; x=1730743228; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=b0rW5l2XZ6Nw2fu/nZcpUdxNW/V8lTRBDsOwCDhO4vM=;
 b=OKZjCbpWKlrMXxNhohWQh8C+nPQcrKLGhu5m5jD5ajbe+aSM1vcyBxtZNik1BBA/e7
 jv5OGr4lCM0usIh2wE1qBzsHA7u9eOCGGh8veP+pCy++44uoYpcr4Czt8Z4DcsG0g/O9
 3ndPxs5Xt0H5CCLRP87d6KOabmUFVgBZjVcf9TlUz/KRD2Xg2K2qR2Zv/t8rcbyUvvmZ
 WpEQebcdniFq8u3BYyvn+7SAe1WXgJ8y5aHqlBI+yMN5HfrlLQWea73tgmhB/6Y3mVwW
 Quwu+KKzo1Hs5m56o5jfkuPQk3lyr2itw8RKQV9h5CSs3rW4OzRtC3EIl/KFpOEUCJTW
 qCUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730138428; x=1730743228;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=b0rW5l2XZ6Nw2fu/nZcpUdxNW/V8lTRBDsOwCDhO4vM=;
 b=LWRIZnfiTReb6uFL8wCiCbaJrSt2SN+pwF67IYYwUhGvk9YHvbiUrcJlHNRf6CnUsq
 Z4o877NVy0pxAiMX3w37B+JTEgEKtpLBpAisIBcnd56snnHLNkEMDk2j7F+ykp6KQA/G
 XOpWIg4+bTLdy1sugMuTwJwK661PhzATyrOV2QzZJRMyVA0Om4uHYJtw9p75m0JwL4/Y
 QlAqfeZ454JfoUmnORg0kga1Dw+dpTyAAx3BvarYOn9+eqguvxMhbawcxr3aZBlQtBlf
 wSrkF7WnjYy0aYTUd9xFdu3mKsjGFNv9so1QDOpHEgwCZ9FTX+fmIBUkGgaWosJsgtFf
 qegw==
X-Gm-Message-State: AOJu0YwGQzVxoBE1kxbyD8xJicXA9CN5r755m3lO8a5ny3jTDgFE1N1L
 aCcqJ1g8yZL8bN/ox5Z4srh4Np2Qu6FrS6O2RS112TZa3XBen0ZnWEubaeT89euluDv0Wliiy5B
 H
X-Google-Smtp-Source: AGHT+IFnATb/+FAwNaLpgWCyPgmeYbk/TYlvB5aqkNF3AVjctXP6rHbInR+JvR4bHPTigH5jRykjnQ==
X-Received: by 2002:a17:902:e842:b0:20b:920e:8fd3 with SMTP id
 d9443c01a7336-210c6c30b32mr128560115ad.35.1730138426895; 
 Mon, 28 Oct 2024 11:00:26 -0700 (PDT)
Received: from [192.168.68.110] ([191.8.109.222])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-210bc02ebcdsm52977805ad.223.2024.10.28.11.00.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Oct 2024 11:00:26 -0700 (PDT)
Message-ID: <f6d26471-9137-498f-b295-2bd6fad7241f@ventanamicro.com>
Date: Mon, 28 Oct 2024 15:00:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] target/riscv/kvm: add riscv-aia bool props
To: qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, alistair.francis@wdc.com, bmeng@tinylab.org,
 liwei1518@gmail.com, zhiwei_liu@linux.alibaba.com, palmer@rivosinc.com,
 ajones@ventanamicro.com
References: <20240924124407.766495-1-dbarboza@ventanamicro.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240924124407.766495-1-dbarboza@ventanamicro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pl1-x629.google.com
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

Hi,

I had a change of heart w.r.t this work. I still believe that the boolean properties
are better to deal with since we don't have to deal with string parsing, and that we
should avoid creating new string props in the future.

But as far as the user API goes it doesn't matter that much. Having to do

-accel kvm,riscv-aia=emul

or

-accel kvm,riscv-aia-emul=on

is basically the same thing. Deprecate properties always creates some form of hassle
for existing scripts and whatnot and we should avoid it.

String properties aren't that great to report to APIs though, so what we can do is to
create internal bools to track the string value and then use it for QMP.


Long story short, I'll re-send this series with only patches 1 and 2. Thanks,


Daniel



On 9/24/24 9:44 AM, Daniel Henrique Barboza wrote:
> Hi,
> 
> Boolean properties are easier to deal with in the protocol side (e.g.
> QMP) since they don't require string parsing. We should always use them
> when applicable.
> 
> This series adds 3 new riscv-aia bool options for the KVM accel driver,
> each one representing the possible values (emul, hwaccel and auto).
> We're also deprecating the existing 'riscv-aia' string option.
> 
> The idea is to use the new properties to enable AIA support in libvirt.
> 
> Patches based on riscv-to-apply.next.
> 
> Daniel Henrique Barboza (4):
>    target/riscv/kvm: set 'aia_mode' to default in error path
>    target/riscv/kvm: clarify how 'riscv-aia' default works
>    target/riscv/kvm: add kvm-aia bools props
>    target/riscv/kvm: deprecate riscv-aia string prop
> 
>   docs/about/deprecated.rst  |   8 +++
>   target/riscv/kvm/kvm-cpu.c | 100 +++++++++++++++++++++++++++++++++----
>   2 files changed, 98 insertions(+), 10 deletions(-)
> 

