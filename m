Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12A60109B464
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 13:07:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7YoL-0000ts-DT; Tue, 31 Mar 2026 09:07:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7YoJ-0000ql-Fo
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:07:11 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7YoI-0002iH-0h
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 09:07:11 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4887f49ec5aso8315875e9.1
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 06:07:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774962425; x=1775567225; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=tBpUNBe48A2Xbnf6DdqhsHG6MWyMFUhqGDdPEyij4bM=;
 b=S+GkibcnB3854OSr8/evIWO78Krkce784mhzgSJ692HY/gHk0vUpWg+Q3moVG4i6Yn
 Kn7fLxZStFI7DwoHqBuNwwjueeV5UFdU9f/vCFjlOupghDG9xG9cTo9Hq1ngFldzmFkK
 27vQ7qBm/+TRAoRyMZD0t7c8iMvGjFDKxpPO0tZCXhmMCRS4XX6dmocal+F0DUKliERV
 XPrb53fs64vxjP0LfSpgV31OuCgsPU755m1Uiqcc04/pglexsvgRK/9nT8Hzgw92NPT/
 wZom7TAl+6FtROrhXYjzHSQvxyYAa7J/IZQjk7twbMzQC3ZIKP0jcO4FQb9Bmzm6mlen
 Hl6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774962425; x=1775567225;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tBpUNBe48A2Xbnf6DdqhsHG6MWyMFUhqGDdPEyij4bM=;
 b=lzWc6fzUS3FCylKCBGkPoaaFa/McCEGj05Hg8/9wJMoOXUapHyeU0N74wRQfmJA0hR
 NsL/VGl1knfeexjvEGCWDC+bOXyuSnhm7lj1rKkWbpFPD8Ro+BPR2UOV1RH6MOgubySA
 9MBY4SSW3R6GHxPbNFzEuDq2TdOAcqSf/4FiSKdZonNH1qnuay/hMsWsfXfJFKrweHCt
 0NoIdvBtvGtZVb+cQ3+mKPerMSZF+r+R3NMYVVGONT3vp3qeYjMUo+V7X/iXNC0omXRU
 +4ogFExOHPvPI4fMIfT7JHzI2G2+xiNWqos9NnJNgJryZ4AEb+4ZfGsPC11PnRuA4ZAF
 x+cg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVtTIjE8PVqrMQfPH8c832Bl0dPWss7wNndfpBdWXlrfrN0PLlwQt99PlUrDGL68VhzKw2e+xQo0/r9@nongnu.org
X-Gm-Message-State: AOJu0YwsJZX0esdGsRGeye/0ecSKeTfnhbWj+W/5eE69FftVYHZ32Sjl
 7TlIv7pF08Y3rgKGIDWCdYTtxAuMN1Jmb0PItqVTW/s4q/YvNN8KqODBZMBOQfOlNOI=
X-Gm-Gg: ATEYQzxEtUWWSddgRn3IsHsVOgSOu0w8D2tlC2U/4rdXfVdkzsLH0S+WYjFrcEQvFQ3
 oQh+DSmO/gx7I0ckMm34cjnpQk+k0o+vOMyqaw1XYeWKzpEs3YVbE+W6PMegsdlidrP2neyuZKa
 RTSIIQhXltZNTr0g/TTC0vf5Eu14/WqbqRM2GifwzHdEbdcT2mo/RULMIO4TDoEPkOYYMWX3qUi
 Mas/xfmSo+u+zVy9CL1XoSPTvL01CQ8Vvi0Qb3hJIAw7eRd0EiG4bQWkWVGwU9eUjyJSSqMGjlR
 n8UdwgO1S2Lk2pGrBnv0c6pilQ0ixeoF+Y8gOGsaBJhE+ljkxFz5oYtxeRI4PiqJQ7AK0hPDF04
 6VR+1bCFjpJuWsVzAPiMY08448CxI/hh05hYCPb9ILX4sF3ENm/NgPVmjWvllkxSz3pG9zc9QYF
 TSYMR9j4sk0pIf+Bgw/QC0CNtKIvmeV/tPnJRUo1kj8BS8K0jUZOWoxiO5tg==
X-Received: by 2002:a05:600c:1d0e:b0:485:a4de:f4f9 with SMTP id
 5b1f17b1804b1-48727ee54bcmr289551965e9.27.1774962424856; 
 Tue, 31 Mar 2026 06:07:04 -0700 (PDT)
Received: from [10.193.39.66] (43.149.216.82.rev.sfr.net. [82.216.149.43])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887aab1de3sm25647665e9.1.2026.03.31.06.07.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 31 Mar 2026 06:07:04 -0700 (PDT)
Message-ID: <b154a86b-1a62-414f-a784-8964833f7bde@linaro.org>
Date: Tue, 31 Mar 2026 15:07:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386: Treat qtest like TCG for supported-features
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20260330151437.1787008-1-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260330151437.1787008-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 30/3/26 17:14, Peter Maydell wrote:
> In x86_cpu_get_supported_feature_word() we figure out the supported
> features differently for each accelerator. The default case is
> "set all feature bits"; however this triggers a warning because
> it enables two features which conflict with each other:
> 
> $ ./build/x86/qemu-system-x86_64   -cpu max -accel qtest -S
> qemu-system-x86_64: warning: this feature conflicts with APX: CPUID[eax=07h,ecx=00h].EBX.mpx [bit 14]
> qemu-system-x86_64: warning: this feature conflicts with MPX: CPUID[eax=07h,ecx=01h].EDX.apxf [bit 21]
> 
> Treat qtest like TCG here, to avoid the complaint.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> This suggests to me that the default case is not something
> we ever want to be in, and we should instead be exhaustively
> enumerating the accelerators and asserting if we don't know
> how to handle this for the accelerator in use. But there are
> several accelerators that we don't have code for here...
> ---
>   target/i386/cpu.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Queued via hw-misc tree, thanks.

