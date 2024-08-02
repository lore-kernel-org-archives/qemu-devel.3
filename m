Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9AAC52D6D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 13:02:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZrvC-0002p3-Vl; Fri, 02 Aug 2024 09:02:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZrv9-0002nd-QK
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:02:11 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZrv5-00048h-El
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:02:08 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2cb55ff1007so5497753a91.0
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 06:02:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722603726; x=1723208526; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yMkuQ942APWmwsDdHDq6QxNykJv0g24tlTLRG1r5n5A=;
 b=DlwXx+lRLPAgakLS2DWFd7IytRDDwJtLxcM5uPuWMeaHUFonxgZQtO4dHGbyEVSr0A
 mvbc0zzuUhRPXsmrV2Q+CE8mfvTrChiOcULJ2tTcsA/YeC1v1/LvRc5E2GqZYgBNhViN
 iV2CXoZmQ8R3VJIzBet7FWKDH/ahzujuqtSzUDyfvC5Syq60iNdTwJkfpwr3u01a13k9
 pAwV56oY3oil9Ik6uWb18wU/7q66URehbCEpKjzd18ypeytx9mk3WE3ttHqHqquSb1JU
 h2+Qu88RLQcJQIeh3NwrBjbuK4T9NaTJT3yfF3bUyszbed33BTJE0nbzBOsuSVmT/agQ
 ZhdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722603726; x=1723208526;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yMkuQ942APWmwsDdHDq6QxNykJv0g24tlTLRG1r5n5A=;
 b=jVQEpUF4p+l4hzOb8NYvBKiI1UD+xdN1Pez5iHA3BX0wAfYqHJPnMBxPPzzxkwgdez
 ouvDUV9W3N3aN2EleL5cZyrq001PTGyQxqgMVsjB4zqfgMjmWMFj1O58M3KQhwChQTab
 CBzUW5TqOAKohs6pBXQ7SGhyEK6lKGCF+cpSKqcamVwUjMf5nSPCS3M541WVpPXuVZh5
 uoxOGSls/wmqWKrjnmgiui1EEoQxu3zm7UebD40henK7UME5aHw9fpjB8E0dt+ATq/Do
 mIjTLkrHcb7eYCDrWSm2DB+GoTzSFbli2Z0onFW6gSJQgoGhPBkqPEMg/jFoMY9Rojwr
 O3Eg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXI9v6PqD98RDmNekL4nOMzHJnKuq15rXLJsgczByGJ3PpURHXEFwlG1rztAPVeiGWF6mSi2RzyO1/zblm9W2Rwnyn3/qk=
X-Gm-Message-State: AOJu0YwXNGox9lUF6FJGFvMNO0u4kU2KFz9hgRgbBbHKh7FxGwztKMWv
 IiaWCau45jwAGkBd6tXGPAUbtxggimQLDAdRIzuGayPa3/phMm6A9xT+yKxkQ70=
X-Google-Smtp-Source: AGHT+IGSJcHmBI8eV0Kv22K+a4XgofOd9izxm+usFAy2xEj7KA3q/+Cd3/7YoZS/RRXQk8/AQwkEzQ==
X-Received: by 2002:a17:90b:194c:b0:2c9:6f03:6fd6 with SMTP id
 98e67ed59e1d1-2cff941b383mr4181204a91.17.1722603725751; 
 Fri, 02 Aug 2024 06:02:05 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cfdc430fadsm5129161a91.23.2024.08.02.06.02.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 06:02:05 -0700 (PDT)
Message-ID: <26cfe760-eeec-4fc9-bcb4-fa937b507d2a@linaro.org>
Date: Fri, 2 Aug 2024 23:01:58 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/18] bsd-user: Implement RISC-V TLS register setup
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark.corbin@embecsom.com>,
 Ajeet Singh <itachis@FreeBSD.org>
References: <20240802083423.142365-1-itachis@FreeBSD.org>
 <20240802083423.142365-5-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802083423.142365-5-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
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
> From: Mark Corbin<mark.corbin@embecsom.com>
> 
> Added the 'target_cpu_set_tls' function to handle setting the Thread
> Local Storage (TLS) register for the RISC-V architecture.
> 
> Signed-off-by: Mark Corbin<mark.corbin@embecsom.com>
> Signed-off-by: Ajeet Singh<itachis@FreeBSD.org>
> ---
>   bsd-user/riscv/target_arch_cpu.c | 29 +++++++++++++++++++++++++++++
>   1 file changed, 29 insertions(+)
>   create mode 100644 bsd-user/riscv/target_arch_cpu.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

