Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1454C52D6D
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 13:38:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZsUE-0000ZU-06; Fri, 02 Aug 2024 09:38:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZsUC-0000TX-Hm
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:38:24 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZsUB-0002xn-0E
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:38:24 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-1fc6ee64512so63341415ad.0
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 06:38:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722605901; x=1723210701; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3xs25e6VMwtHSJtE0JQLlHKetsMpwKiuCbUxa8AO4c0=;
 b=WNP/CIH0IMx0oD7pbJKoaozrF/OJcd6vn3MOOroBWfcO7y9PRJgr6nlkJcEX7M/zBE
 rnS9kr4Dwh6TGxD4/wl24SrXQ7QKqUNxSrbCXOfd0NgMlD2fH0yBOIPcpkp5TgTWUoZh
 sg4uZl8ttBZYjlAIbmcGWOrjKp03jN1rSUCGhmKit9eArC8dz+/34WkBNTWpAP/t/veJ
 KiN+WZcAcaefZWPhR5koFkslSD+bzf2GeCzc67D2Avig4dQFjHRwoLet7JaQGqqWn9yd
 OCA9M4yEANhwDUNBpfGau/EALVy4PVw2M2xtQdoc5cGAyMSFtXfHgyTIPBl7T9RLbMJO
 a6Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722605901; x=1723210701;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3xs25e6VMwtHSJtE0JQLlHKetsMpwKiuCbUxa8AO4c0=;
 b=oMMqUtR5kZU1QinU28TjNyaqt6oCMTxIcDuXojHP66CUANkHmWgGST+jVn407vmgjc
 o6Qm9Hk9ZJ9dKYmTqBpsU5Strs0CXUQlJTDLnxGAHlzzMjv5fG0trtaGmt/UAquk4vN6
 cl5mgBXwYOZuhIMwUzN+49w8WF3rYPUwgRR1z5TlOg2AksZZ5icgpGBGT0C3XVVtupqB
 sn3upKRLkxkbADYu9jMnpih1CGdLKJYvn7BysETVZ6gHcMG0JTcWZuuqKS6MXDiYXi0z
 mo0i54xEZlxVqMSnLh4z5EvbDG2Ood3CZz3cAXUng+ngGnxkBpg8vMHv8CWBSB64Dx7x
 aQag==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9qau1nEXATF7oHV/5t5tUHGp0S9xIZVfk50ZEJAvJgpgXD/Xgp5Qh/dq5JVizTnylYtWgZQDaViyUni6rriT2e0TktbY=
X-Gm-Message-State: AOJu0YzI9zsf4CYJpiguTnPe57SLi7zMGpVk8vmDlbOTOPsrabMKQ1Hn
 +UJ8h6nCtzIlp4eBq0CvMandRXjStH2xt97DE6F4gXzwfyfJgBah4hr+JF12JjU=
X-Google-Smtp-Source: AGHT+IF6UdA5Qri/fV5wy90a6lZW5/peKoB8qPZ7LB8ZoSUaUkP3xss6KtHH9Tt8XEG3NK0Ut24qdg==
X-Received: by 2002:a17:902:ce82:b0:1fd:a942:154d with SMTP id
 d9443c01a7336-1ff572c488dmr37081815ad.22.1722605900804; 
 Fri, 02 Aug 2024 06:38:20 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1ff58f6ad65sm17140425ad.116.2024.08.02.06.38.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 06:38:20 -0700 (PDT)
Message-ID: <ba99cb8e-1244-40a3-9602-4252f576474e@linaro.org>
Date: Fri, 2 Aug 2024 23:38:15 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/18] bsd-user: Define RISC-V signal handling structures
 and constants
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark.corbin@embecsom.com>,
 Ajeet Singh <itachis@FreeBSD.org>
References: <20240802083423.142365-1-itachis@FreeBSD.org>
 <20240802083423.142365-15-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802083423.142365-15-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x629.google.com
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
> Added definitions for RISC-V signal handling, including structures
> and constants for managing signal frames and context
> 
> Signed-off-by: Mark Corbin<mark.corbin@embecsom.com>
> Signed-off-by: Ajeet Singh<itachis@FreeBSD.org>
> Co-authored-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/riscv/target_arch_signal.h | 75 +++++++++++++++++++++++++++++
>   1 file changed, 75 insertions(+)
>   create mode 100644 bsd-user/riscv/target_arch_signal.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

