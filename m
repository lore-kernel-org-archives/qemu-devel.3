Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11391C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 13:27:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZsJU-0004Ja-Q0; Fri, 02 Aug 2024 09:27:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZsJS-0004DM-QK
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:27:18 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZsJQ-0007r0-OG
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:27:18 -0400
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-70d199fb3dfso6858181b3a.3
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 06:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722605235; x=1723210035; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H99bqgf0CxSuHb8b7TGVs7lmWj6sT28gHoNgJP1HL5g=;
 b=g6n+5Ti/DU0RmQc6dWwhtpt4d8io0jzv3geEMkkGLE6B0GaMO0iPif9vGVbUEViAE2
 AY71jkThjD9CP4coA7qcUBwlB3sKcUpYKgynFXuSe6g9AcP9+0VxpKyxCgzxgJYNUhoF
 bixKv6pRvWwvPPERBTRH3bX98eZF0kfGAEcdnYkdPKappgy6xbe7ZXSRR16c2jTbANAD
 5kAqFDYRSDddQETll0Hszcjj9FJTKA6zFPt2NFoC/Uhhaj2QK5PHZ6QZShOm3OCYb84H
 rODnnIujWy+/v/0jngAqRa0btbTYCHRBYLxNlx+qiq04IR9vvtQpUG+J3Eox1elWK4dD
 8O4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722605235; x=1723210035;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H99bqgf0CxSuHb8b7TGVs7lmWj6sT28gHoNgJP1HL5g=;
 b=WMwmzBDk4+HexVFzH+HourVcEJFYuj6PwC19r2jCAVMq5ZHlY1JxBlhkTTzG2GY85x
 ihCbtbrBjCBYrxRhtQaczpDAonazYkFH+6qq0HKJrC49KwD4cK2uOUFGuIiT9fURrhpv
 HXzIEfY3HCxDq3NqY0y3fTwCQka61MabVdCKaSAIAljNG49RaFOUzQLY0kWaYGZpuRoR
 m75wtZtfw4ayYq7MRYH4G0zDawSd532yuQA4IiFveIV0h/jq6aODf+ZzvbTKix1mNtfb
 /qa19tsJlrZXR+rs3ak4nPFZK+auVTF6ny9yfapBtLI9ID1PlXxM8BoSR1RJkyIRvlJ7
 FX6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXCX/SEY/dd/lAk+c/li+w/3xrd5jVoqaTS3T6VY2GGCZRe3z6fFZ59pJ/iOtI31MnNZ6LFnebtpqWmH7X98T09t4Q+Vzw=
X-Gm-Message-State: AOJu0YwTxHM9pwMyofJwQG19xGldYjfGbusLyDQ7mrbZ7x4EhCS2xovt
 ae4gsP7yntIFq81frF/RzYf+SBmU+HT+rhAqiIQ3ySoDpQOYTYPoIlJpqytLITPghAHD1Y4lVBd
 sEILM0Q==
X-Google-Smtp-Source: AGHT+IHqXH2azE4ZvbVJBumBkLX7hmIBA/PvvwhBdsQtdb5DNvEGz7izQH1tQq4fUvBDGMzcwfQ6gw==
X-Received: by 2002:a05:6a21:478b:b0:1c4:9cf9:195b with SMTP id
 adf61e73a8af0-1c69968cc51mr3915618637.48.1722605234799; 
 Fri, 02 Aug 2024 06:27:14 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff590600e4sm16874995ad.144.2024.08.02.06.27.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 06:27:14 -0700 (PDT)
Message-ID: <5a695971-ef34-4595-a247-322149be221c@linaro.org>
Date: Fri, 2 Aug 2024 23:27:09 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/18] bsd-user: Implement RISC-V sysarch system call
 emulation
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark.corbin@embecsom.com>,
 Ajeet Singh <itachis@FreeBSD.org>
References: <20240802083423.142365-1-itachis@FreeBSD.org>
 <20240802083423.142365-10-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802083423.142365-10-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
> From: Mark Corbin <mark.corbin@embecsom.com>
> 
> Added the 'do_freebsd_arch_sysarch' function to emulate the 'sysarch'
> system call for the RISC-V architecture.
> Currently, this function returns '-TARGET_EOPNOTSUPP' to indicate that
> the operation is not supported.
> 
> Signed-off-by: Mark Corbin <mark.corbin@embecsom.com>
> Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
> ---
>   bsd-user/riscv/target_arch_sysarch.h | 41 ++++++++++++++++++++++++++++
>   1 file changed, 41 insertions(+)
>   create mode 100644 bsd-user/riscv/target_arch_sysarch.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

