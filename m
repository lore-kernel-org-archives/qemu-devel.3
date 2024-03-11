Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 962E2C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 08:27:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjazG-0002FD-WD; Mon, 11 Mar 2024 04:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjazE-0002Em-RB
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 04:26:20 -0400
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjazD-0008Go-Da
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 04:26:20 -0400
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-33e9df3416bso54532f8f.3
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 01:26:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710145577; x=1710750377; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OzFHC9lkYm5S0YhYE2Qm7J8utw6WXcBvO3xMW4Tr9ME=;
 b=aIg3PzpC2mjbQzFNQSLn0EXTEFvq4zRurKDiQbkT3G9yEUTyPNOBFHVM8ySNOEVFDc
 jZ3HtEsGkDA6j9lr+mpwOkGXl23PrGtCsE4cT7fdyoC7Hjnolnqv0EpjlqXzONAntoQE
 0ZDCWzT6Q+VAVYZ9b5MMRNprQo086LpZ6BnBNs5KJrJfUl5c0wEK1Zi0yHRUl8wKjXU2
 j0mPbncJ84Y5FdgIJKoQ56zIozWj0nm5f6H0LbsbVAj5N4U7nryU72asdcApskQFOXas
 lIvt/WmrW4vo9/V1AQD5PfW4vN87+6LGMCsULYaZNY3OFZr9V30Jq2Hlp//W47AxUVQ/
 mZAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710145577; x=1710750377;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=OzFHC9lkYm5S0YhYE2Qm7J8utw6WXcBvO3xMW4Tr9ME=;
 b=f+xfhZUW5KIJiximwLb1TjHfgL1ZiwzovJPYfk1bAWdANvmhXJ09wsLG4FY7JFmfnJ
 nXSRLmnK5Xzu03rXcjUkMYZtuwLYyerPWd8rqSrFpAnLz3nFFzOT+uLJJ/giVIU3XnkN
 496sZa5ThM2KF3mpOe7TvgX4A+LxKEGtcP0tWPN+2jf08FXhwfMpl37hLwglsLQ5cdAq
 EXQVXbl4Qz3ysGoxfaNeFp8et/zcm8y4oPa6nkitRXEQzBwz873v4obOprCCh8AE/cG1
 Bqq+WO1VtMAgNeYPWYiNzozf5wzuZRXRGSE3uVEy04e8Y+Z8+KHMDQ+EkRD+SAASGh30
 1TXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUBgO4UBByXAdIL9+WofJvaoVx4kXbzyqcl0BT+obDN4BPJPgCL3CREE1Ru9jk6AKRU1/A01iBzfdRE6EBVndxPy/VmDXs=
X-Gm-Message-State: AOJu0Yyhsbw5Ak+N6mjr8V2ZXa5DVbrqxDFiEyhAzN/0+7i0UNWJwHis
 YEyLOC7VJWqFVx/E0T6OklnDhna2nKsr9nn75hm/K/7+PcTNu0SnBJNGA/lZz8M=
X-Google-Smtp-Source: AGHT+IHOz8bFXBF2iFanGnXroBf+7W+zBzZ1P5Bh4Ue3PVLk0/jeBf0BETTXt/7voMsw46Qevo95Pg==
X-Received: by 2002:a05:6000:24f:b0:33d:6ef6:8762 with SMTP id
 m15-20020a056000024f00b0033d6ef68762mr4044485wrz.29.1710145577194; 
 Mon, 11 Mar 2024 01:26:17 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.167.228])
 by smtp.gmail.com with ESMTPSA id
 bk5-20020a0560001d8500b0033e699fc6b4sm5828645wrb.69.2024.03.11.01.26.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 01:26:16 -0700 (PDT)
Message-ID: <35c47280-90e0-47e2-b9a3-aff6e15fbeca@linaro.org>
Date: Mon, 11 Mar 2024 09:26:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] tests/plugins: fix use-after-free bug
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20240311081619.669832-1-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240311081619.669832-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 11/3/24 09:16, Paolo Bonzini wrote:
> rec->count.score is inside rec, which is freed before rec->count.score is.
> Reorder the instructions
> 
> Reported by Coverity as CID 1539967.
> 
> Cc: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   contrib/plugins/howvec.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



