Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B48C27C4F
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 22:21:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJhCR-0001IX-07; Tue, 18 Jun 2024 18:21:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJhCN-0001IB-I4
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:21:07 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJhCK-0005Kg-6T
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:21:07 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-1f480624d0dso47444925ad.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 15:21:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718749262; x=1719354062; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r5PbntltpwcbC6fxAxMh+L8ky/pzswrk55bWOW9dXjw=;
 b=MpvTRNDl/gd9Gm+eGxvfTcSZJUfOTbG07t01poUckqYo7AS8gnXD1CxxGYyvRdlwBo
 mScTAqltT5opH7sYOwWBfub7Oys2fQFVYb3yw9DBgzs0w3snYIYhdSCt7OjD9/w1O4PF
 NHnNnOcA9gtVP7Sq4gfmsh3iNYSicb4MubWMdycEfwslVY8XrfiMnNpKOKkS5bA5E0kE
 deOHsLMQTvqlmsPTQ6Sg2tQF0jVHiGMKMBRkYrP3iqYtj72HQs+fPZ6PwgSsYsZ1BqnO
 4r7Y/16v0+sN//UvazwoJzKwMwlDA1Xg0eLUwcpPOzLUS2c27kH4k5m0M6jkUsZdBw/1
 VNAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718749262; x=1719354062;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r5PbntltpwcbC6fxAxMh+L8ky/pzswrk55bWOW9dXjw=;
 b=BFFER93LXeTSH+I5mi+MkMNtYIArfyxVbVcgrxqwCptzQJO82fuZ/dwLRJFvMdYmPw
 uGklHnGSX85FAnjsttYK4FUSaD6FGTccQYeP5BRLMhTYRjXzrGieK2J0bcwrOfffqMeN
 Xj9mc6UVQSPry8eBokjrYgVMAp6dCk89I+TaNXDdF3QhH/iAD+GbToWlmxD9jeKnUJnY
 r9yrIVKOOotheta6axTLDRFm3nBvoSEGQDGmh8E0A321DJzoeeTGf/hdA74JgjGKFGDH
 g7bz+npaqkb/pOtoNwvlRxiI7iGaQLuITPvwiq8dfJQmDtDbpnvFm4sTUvxrQYxvtbH1
 pIxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXoomGU5l8Rite9p3vkM+Cy5ZG/UayD5SHnd6T1lzTnwTeHaRaSSh6fpZ/9c05dSXQuhQ+Q2H0E/hKxjLtQArqzreIg5sw=
X-Gm-Message-State: AOJu0Yw6UXHjmiyCXZVKgYMlw6cN/2glyQjEXVQYbKpTXQ5hoRVrH4k1
 /2ek+Tfk28PUrEyxLCufltIWhTqsy1vtUgJMy4XI/01puGPZalWWsT3Mi1XrDjp54qP//OTOvC8
 l
X-Google-Smtp-Source: AGHT+IEBoyXLWHCYqIBCyetSk+Xw8vZtNrpIANIKrw4+ii2omjN7+It00pVuxDALuzyIOVggvBF3Xw==
X-Received: by 2002:a17:902:daca:b0:1f8:67e4:3985 with SMTP id
 d9443c01a7336-1f9aa45eaa7mr12480715ad.49.1718749262152; 
 Tue, 18 Jun 2024 15:21:02 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855e5bca2sm102948935ad.17.2024.06.18.15.21.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 15:21:01 -0700 (PDT)
Message-ID: <786660ab-a74e-4ad9-8347-9bc1733867bd@linaro.org>
Date: Tue, 18 Jun 2024 15:20:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/23] Add ARM AArch64 hardware capability definitions
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
 <20240617185804.25075-15-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240617185804.25075-15-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62d.google.com
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

On 6/17/24 11:57, Ajeet Singh wrote:
> From: Warner Losh<imp@bsdimp.com>
> 
> Defined a huge list of hardware capabilites and added
> macros for retrieving hwcap flags
> 
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> Signed-off-by: Ajeet Singh<itachis@FreeBSD.org>
> ---
>   bsd-user/aarch64/target_arch_elf.h | 61 ++++++++++++++++++++++++++++++
>   1 file changed, 61 insertions(+)

Acked-by: Richard Henderson <richard.henderson@linaro.org>

r~

