Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22263C3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 18:51:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRyt0-0000H3-Gl; Thu, 11 Jul 2024 14:51:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRysy-00009H-HG
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 14:51:20 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRysw-0002lc-Un
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 14:51:20 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2c98b22638bso942857a91.1
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2024 11:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720723877; x=1721328677; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=FhlWYFBafA9Sxh98IG8KoKzrm3Ok7H802948HnRbVTI=;
 b=QK7ILII+5RlzXUaln6hFKOT6xXvUN4yIr4BFVmMQ2mVr2GmJtXV/FGS1Ew1ce4icVP
 NBl5oGG2uEwexDNsS86yT+5qE4KvZq+Kb9D6cUAHWa9p7eLztl8/PnHU6TaPUdCaW8TT
 UM1C/OVYMc+AsOoANnbbA9jM1Hf5YTdec6nZWAGLgOo/gWx5WD5/WrJLd+8YZ66EE/Y+
 N6H9UCN5Nx6U8XN8zvoQwhXmaETkhfzOjjfbQNnOjweTTeCCdCGApe2Z+jmtMEQIcC/Q
 M0yATFSph0J7t54U1U4tn3LAU7hXYxDwPbQfRwNlv93mvlPaD7deTEHZLdLlgAfVgF1d
 0iwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720723877; x=1721328677;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FhlWYFBafA9Sxh98IG8KoKzrm3Ok7H802948HnRbVTI=;
 b=BO02QxzZdNrgzUcCjdSi1MqTHIEooVHDR/7vjwrz5ySkVpTCIQNxJqZsyKhBUqg2Xi
 ut9RQjHEkpUe4FVnmAyMhHmRdjfM7uaJXXd7i/qsZCkUNihbpW7sQA0cVd2GFg4c/h2d
 YCiqJqdoOL5ZC8y40Yam/PjZwp3RA64c/fH0bICJaZZ2OkZwNODH1++vwtPL/EVDghYz
 kOVjraL06Z5C0A8t9Bew8Xb9HHvkxhY5bZNz7JOtpBqXQi4xnhFXAsZXUMquVuRaZ9BX
 ZUeDOY1L9IgApx0nzHbY/OSxjbQrBCy0dnCohhuurI/U0pCijan1udeOVQfyG+iayG5v
 S3DQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXOsxJFW9jtOrmy8Q1OKt5UD7oxiXUHMeRlivYJcqstwoYUstdFikQbaBuHlnHZ9Ry9Aq6Xa/ZNsxxTBC+D8YJ2sRgUmPY=
X-Gm-Message-State: AOJu0Yyvg2GLKESUv4HmEGKklbmvCOYYos+7M97pu4PlQIAV3pUGFPBh
 qc7GZrnKjywaTOqDQS4lzpDVIv/k5Q0UylB5U25Xl26EUL3J6chTtCtAEZNhBFg=
X-Google-Smtp-Source: AGHT+IF/i7gyzgOVE7QSY1EvPvjVkurbzjAFT4KNFpQkd4101GIeWmlaa8NFIJxrvc36MnIO6e3Qyg==
X-Received: by 2002:a17:90a:2dcf:b0:2c8:946b:eea2 with SMTP id
 98e67ed59e1d1-2cac6dfb8dfmr683088a91.7.1720723877272; 
 Thu, 11 Jul 2024 11:51:17 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ca344b936dsm5993968a91.10.2024.07.11.11.51.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jul 2024 11:51:16 -0700 (PDT)
Message-ID: <370d07da-bdf5-4578-9b22-651bed77fcb7@linaro.org>
Date: Thu, 11 Jul 2024 11:51:15 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 0/2] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Hanna Reitz <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>
References: <20240711091709.584450-1-stefanha@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240711091709.584450-1-stefanha@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 7/11/24 02:17, Stefan Hajnoczi wrote:
> The following changes since commit 59084feb256c617063e0dbe7e64821ae8852d7cf:
> 
>    Merge tag 'pull-aspeed-20240709' ofhttps://github.com/legoater/qemu  into staging (2024-07-09 07:13:55 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stefanha/qemu.git  tags/block-pull-request
> 
> for you to fetch changes up to d05ae948cc887054495977855b0859d0d4ab2613:
> 
>    Consider discard option when writing zeros (2024-07-11 11:06:36 +0200)
> 
> ----------------------------------------------------------------
> Pull request
> 
> A discard fix from Nir Soffer.


Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

