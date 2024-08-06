Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3670C52D6F
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2024 09:43:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbGiC-0003d2-5M; Tue, 06 Aug 2024 05:42:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbGiA-0003cH-62
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 05:42:34 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sbGi8-0004KG-7R
 for qemu-devel@nongnu.org; Tue, 06 Aug 2024 05:42:33 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-7b396521ff6so238710a12.1
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2024 02:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722937350; x=1723542150; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=IbrkQovGgAXFeLB1uwFl0ohsr3lgSz7WQIWWKDheqV0=;
 b=Fyy+l1x4PcmzukXFETTt89t1aKJcqBrhDOuvMzPJSwW4rgG+BxqzypxzZGHMBdQK4I
 uy4K5U/4rIoGKl7rhLpyx579CPCQO5u9H5B4E7tSjm4gpp5m6T2WZyxcn9qHA9TLLHqA
 FdRFvOaecz40FHUyEC7mpX7VxOsEHynudA1ypNuHFau1U9xiWVmxYCuTGDec+iQxM02D
 yKjsSBfS0bkGLErtS+DqxSpkRzkI9mAEMFXOjbdxIERGqlwQhSBXexOAaYnUQ+Bia7x/
 xC/csSVFcD1dW/Ne9Jl0DS+o51LdnMzprDjwNPHX/wMZHPZ1I0TKY1rJ+n6rNCtYt0g0
 1gWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722937350; x=1723542150;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=IbrkQovGgAXFeLB1uwFl0ohsr3lgSz7WQIWWKDheqV0=;
 b=rwrqnpKpYWA+oHmlshUcACWMTA69S0MMQKK++jlVvlJDdYA1d7aBjWXJb3ZWBN0Pah
 8kCAB0GjwyqJV2IseBbilH8XUwrnFKQZs5NTblAwUA3a+IuP18Y2NzhRp1yuuJvmX0Ff
 dMn1XL0zIHUvw2ea6j0xsFHfaETGT3PfCfnYH/MfWrahRy7WPGSMvUK/BMsMiYvXm8vc
 lV0ibwKH2NsG1cBEVJD/G/n8X+2x05wm84NB59SS2qFJNhX5iyOmpVTI+NjFVK0p51Fk
 6cFzyBrqD5RRcInl9Jc3xTkLx98zpsqLL4r00ygkoGdpIQyd0M2OjwaoQx8doZOjCiSY
 L9KA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUq86yOGzajj8dXN572kJpM8dwQrdNCY6eDvLDXCKlAhRjhe0zFxVej9KK2nt1NJjf/ZS14/RlVlmV0MbThqUn/DM/rA9M=
X-Gm-Message-State: AOJu0Yyrp2VvXRY3Aeqf3hdrnRlciyeciJT3UGt+466Yff33AKzePz2n
 wws5ArkEoofTKNJha99mxlCPRJ1TmSenqGBqhXbFz48vjbk4J2kZPt4ugwhSZW8=
X-Google-Smtp-Source: AGHT+IFqiDhC0x1JexzHqXrb0zltO/PVIQNBbrGdOmvauZ15j1b+F1EoAK3y5aeGWA+qEk4Gohzu+w==
X-Received: by 2002:a17:90b:5207:b0:2c7:aba6:d32f with SMTP id
 98e67ed59e1d1-2cff94487b2mr18024024a91.22.1722937349782; 
 Tue, 06 Aug 2024 02:42:29 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cfdc4064e4sm12287732a91.9.2024.08.06.02.42.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Aug 2024 02:42:29 -0700 (PDT)
Message-ID: <c994e2c7-1f74-48d8-9133-31ed0867d6c0@linaro.org>
Date: Tue, 6 Aug 2024 19:42:22 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/5] riscv-to-apply queue
To: Alistair Francis <alistair23@gmail.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair.francis@wdc.com>
References: <20240806062545.1250910-1-alistair.francis@wdc.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240806062545.1250910-1-alistair.francis@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
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

On 8/6/24 16:25, Alistair Francis wrote:
> The following changes since commit e7207a9971dd41618b407030902b0b2256deb664:
> 
>    Merge tag 'for-upstream' ofhttps://gitlab.com/bonzini/qemu into staging (2024-08-06 08:02:34 +1000)
> 
> are available in the Git repository at:
> 
>    https://github.com/alistair23/qemu.git tags/pull-riscv-to-apply-20240806-2
> 
> for you to fetch changes up to b3a34eb90d8264bd73ccb25295b1a7e271a9029c:
> 
>    roms/opensbi: Update to v1.5.1 (2024-08-06 15:01:01 +1000)
> 
> ----------------------------------------------------------------
> RISC-V PR for 9.1
> 
> * roms/opensbi: update to v1.5.1
> * target/riscv: Add asserts for out-of-bound access
> * Remove redundant insn length check for zama16b

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

