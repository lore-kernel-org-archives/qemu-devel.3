Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0598C3DA7F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 07:08:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saVLH-00006g-UQ; Sun, 04 Aug 2024 03:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saVLD-00005P-O3
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 03:07:45 -0400
Received: from mail-oi1-x235.google.com ([2607:f8b0:4864:20::235])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saVLC-0008W5-41
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 03:07:43 -0400
Received: by mail-oi1-x235.google.com with SMTP id
 5614622812f47-3db50abf929so2677331b6e.2
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 00:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722755260; x=1723360060; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=A3lNU17jn/QDRp8Us9zspjpnW7qIJkNwZeWAUd4deWE=;
 b=mhKBEjOquyFdl3lPNDU+H4E3otexuv1jphKTAB+xsJGZ2LIHmawR+y4k1m+/6i+50I
 O7o2/2YP2O+zwbjFcD5Kj13FqqXbPlRVI67ifxQzna9iKBERyul4ohppVc2AEri/Z4os
 xmOFJwYMu4RVPrVpun7jmw6NBRgIOQfhWfomnsKrVLHPiEnliLwkatKL3ntsaglcSlue
 AXAEMNL8x1viA3qzavnvUK7NMi3pAr7Ms2/sxqu1xzJCcyOIsGRHH3/CJonialqjYyvh
 PmQ4+rOvVJRH6v0VTmTJts7O+er5wxJJiiBHZ5toZK2JhHlTYQctaBoy/rb9EvF1LIrm
 dlMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722755260; x=1723360060;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=A3lNU17jn/QDRp8Us9zspjpnW7qIJkNwZeWAUd4deWE=;
 b=TAZ1OmkAvXmqQ/yk1ik7cKRrx9lggPNonxhTn3DC6bb7b07Aj378LEkuk/QmzuvZTm
 7bEkxSueba3lS6f5d3VgKJDloddSm3KBCnB0qrAQhXkbbvusz0da/1DAbgbAYMGXOzMc
 HFsmuRMDWZW8lHDkEQ8iXZ4Sfy/oOPdQXjrNMYsYN9wlG6COIAqlFEXZgBkThvxxTNIU
 5PrftYANCC0Qraw8qV+00oelklCe/af0XSp1VIJJvGaR5d6VoV86TmoC6BuPUZgCdYTn
 ONQ9knkAIG7nwH72eZyQLSwyGIgz19tnHamtoD8FPN0BYXyMZBV8errDq4aLYqRcPx7+
 zUAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUN55K5DIrqJwUOmuJUkB8uOGUkG1pRJhFIV559spxW22K4z5+urrDMFMKY5jIRyh1x5pPgS6zTFInIQjjttFLsJXYjrEc=
X-Gm-Message-State: AOJu0YztXuYh8GpyX3VU7vHHokrSUZmA7st1EM+M3vYkJoAnBSZ4cPpB
 T5RNsQqx7C/g2sgj1QhkFrp7JtydxCs36wDZJXdvMqPtYIlctnd74ORvbITK2lA=
X-Google-Smtp-Source: AGHT+IGEGPp15kRoe/iDjbO4Dom6vUbDuhWi4ubx4YU+uXp8WUQU54s8ozb6hHUh2NAv0JraXruxMQ==
X-Received: by 2002:a05:6830:4981:b0:709:44dc:dde7 with SMTP id
 46e09a7af769-709b32190c7mr13915628a34.9.1722755260078; 
 Sun, 04 Aug 2024 00:07:40 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cfdc406a01sm8100414a91.7.2024.08.04.00.07.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Aug 2024 00:07:39 -0700 (PDT)
Message-ID: <9a9edeac-e2d4-4301-8b4a-c08390518574@linaro.org>
Date: Sun, 4 Aug 2024 17:07:32 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/17] bsd-user: Delete TaskState next member
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Jessica Clarke <jrtc27@jrtc27.com>
References: <20240802235617.7971-1-imp@bsdimp.com>
 <20240802235617.7971-2-imp@bsdimp.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802235617.7971-2-imp@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::235;
 envelope-from=richard.henderson@linaro.org; helo=mail-oi1-x235.google.com
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

On 8/3/24 09:56, Warner Losh wrote:
> The next struct member of TaskState is unused. Remove it.
> 
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/qemu.h | 1 -
>   1 file changed, 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

