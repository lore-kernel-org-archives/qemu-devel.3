Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DC83EC2BB85
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2024 21:22:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJJnr-0000lx-CF; Mon, 17 Jun 2024 17:22:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJJno-0000lI-Lw
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 17:22:13 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJJnm-0004UQ-Lz
 for qemu-devel@nongnu.org; Mon, 17 Jun 2024 17:22:12 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2c2ecd25e5aso3749298a91.2
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2024 14:22:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718659329; x=1719264129; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=axqYhybjB7slhZtkU6bf3usBou+XlE9yZzb5DRJQwqI=;
 b=kQqOZZErqhsZfpWXu7sWb3nDGEgdVuYdJ9jYKqfSl7wXDku1M3CoAzwl9Jbga1aAN8
 Xnlf/HCO5EoN39CZf3FQ2MhWweGgN3YnUk2dBWLwNrKal/eRwZle6i7cU22ZWrfk8ef7
 H+L3QPyVfyfVlksp1i+IwKAXwj8q4lmh7RlSgR4o2W5hB+TA7rJIpBitLNtWK1AdjH2e
 jpTQSWnWit921WGwuNVIKkb+RjiEXVXuXOpDVsZBK0jduIbKEkTv3vPyTSsdjIhTWinw
 M1BCBU0IbnxRItVjLu3n47yqMu0usOmAZuaiqEO2Y4duyZehZdqJI3x091CTo7zIcjmz
 8k9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718659329; x=1719264129;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=axqYhybjB7slhZtkU6bf3usBou+XlE9yZzb5DRJQwqI=;
 b=c1fMkmyF0NTTRkEQzb7MOR0Y7MyOgYxrW/slMyP1zXaugSljhZAULomMHkJPZBaw0K
 pnvVswZXEOIApiwiPRhk0hFXtjVB7r8GeNYF0dLUknUzp2HTqDk6Q2XFUcUFqw/qdh7D
 8a6/CMYXHLJYUqr/nz2fi/LaZZ83OSgSyujbQXCanzrsMOIx6Y8Pgq0DfpAMswBRVGzk
 +W5ocS851nN4t4MFvHYk4skMkxuetLtAoVtvupwlija956f5STfK4bDe4fthsMPPwgTV
 kP3n6laWCTx566Qs1nhgDLnYJfkNaN3Xy9OBXf8QCIbuqtgf8rKr6t4Z9Z5U0iqfE8ix
 fAYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWnLe0jmEq2iXQMZ1ZCVvAWGvsfpKRnjg+5vNUTCtdUOmcuzW0BH8kcIgEimG5V9yK/DQIW4J/umCLVtqNgz6oWnTyFYwE=
X-Gm-Message-State: AOJu0Yyl4F4YCboe4ADGow5lO40xOXcUjdmgnvLLDa3Y+W+TraPVMQxz
 lFwMGvcqEfgibI2dej0FxHE+84lbg0NMkWfuMkQeTuTWi90m4hOy9IWbAhEt0+M=
X-Google-Smtp-Source: AGHT+IGnlGJbSWsImpGObHB7sx2aQHulcTy7yk8EqGA9Rz2Xnj0rkwBpjbBboxa3iFC0XlBuKoBtzw==
X-Received: by 2002:a17:90a:bd97:b0:2bd:d2f9:c22a with SMTP id
 98e67ed59e1d1-2c4db44b8c5mr9540675a91.29.1718659328955; 
 Mon, 17 Jun 2024 14:22:08 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c4a7603200sm11788674a91.26.2024.06.17.14.22.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Jun 2024 14:22:08 -0700 (PDT)
Message-ID: <f2c4d2be-9fc9-41c9-a47e-4bef99a7b907@linaro.org>
Date: Mon, 17 Jun 2024 14:22:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 00/25] target/i386, SCSI changes for 2024-06-11
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240617081319.88956-1-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240617081319.88956-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
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

On 6/17/24 01:13, Paolo Bonzini wrote:
> The following changes since commit 80e8f0602168f451a93e71cbb1d59e93d745e62e:
> 
>    Merge tag 'bsd-user-misc-2024q2-pull-request' of gitlab.com:bsdimp/qemu into staging (2024-06-09 11:21:55 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/bonzini/qemu.git  tags/for-upstream
> 
> for you to fetch changes up to 109238a8d97cd8e85ca614109724a0b1222b21f5:
> 
>    target/i386: SEV: do not assume machine->cgs is SEV (2024-06-17 09:47:39 +0200)
> 
> ----------------------------------------------------------------
> * i386: fix issue with cache topology passthrough
> * scsi-disk: migrate emulated requests
> * i386/sev: fix Coverity issues
> * i386/tcg: more conversions to new decoder
> 
> ----------------------------------------------------------------
> 
> v1->v2: fixed MOV from/to CR and DR in 64-bit modes (does not need REX.W)

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


