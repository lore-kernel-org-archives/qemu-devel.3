Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F91EC4828D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Feb 2024 22:30:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXTwh-0002zh-Ma; Tue, 06 Feb 2024 17:29:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXTwZ-0002yo-46
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 17:29:32 -0500
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rXTwT-0005vq-Rk
 for qemu-devel@nongnu.org; Tue, 06 Feb 2024 17:29:30 -0500
Received: by mail-pj1-x1034.google.com with SMTP id
 98e67ed59e1d1-296df89efd2so64378a91.0
 for <qemu-devel@nongnu.org>; Tue, 06 Feb 2024 14:29:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707258561; x=1707863361; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=cmORsPVxP0U9mFa5Ukp6VZKkhQe0jbqdwd0vgKw4fVM=;
 b=KcLIC51eWRIOz7ei+MXN8+UUbERW3LbdW4/CiLfx8FxjYiDYzmfJ6DyRY1E1L2esOU
 BSP3IkOhpn9zLQCrygN1n0jCKtdBd2hM9mADrIBq396sFsyDYU7UX+EXwX/eO8mUvf9M
 6NIs6P9QCNEWkzAUxOhDTSKRs4ZHMpDbEfWDtEnR8AF8zMSJEKixSIAcC/lR5yFvaXRQ
 QVcKX2AjWTgNuGpijuJMdqPRxwaCoCkp1q18M05ZoXH079duw8m6p7MWiRrGzxWEqQKw
 QujaIPlSKJRtb1jYPevOWXko9kIQobXbaUh6A4CIKv/DXtQc+eBgL2N9PVu/jibNUrkS
 TAog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707258561; x=1707863361;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=cmORsPVxP0U9mFa5Ukp6VZKkhQe0jbqdwd0vgKw4fVM=;
 b=adxXWVEJO8s/Z+KMpxv1uS19z+sqLqIPRmHOROtGjJ+7mwSo0au/GHWGjAmgHUUi8E
 uevnKRUzo2gFnOCIpVW7XWXJnjJiYTMzss6OxjZIHYzEIXlkXd8FmuCqKTRH7W01H+RJ
 76wACnKiZxJB+lmVpEQKEDMhWpKNzZvLTiZA3NCL7QNqBpkvOiwH7VayboQm3uxPjsdi
 lPpG80iJDX9lJX/PDDyT1ENnSd2msgA+aXu1+UbqrSITmLxiP5bTgU1swrjupu5dafkb
 T/9f1fuP6kbBSu/XH/tkopplvlDyKnECLSLehX9wAVhtFXclTO2BTZNXH0D5a3elVjLm
 AYXA==
X-Gm-Message-State: AOJu0YzlW8N1kFg2gFqrpZ7k9MdLg0bjdMwu5UGpUmLygx0ANPO/jcp+
 ujdusJvvcbqx5z6lO+fWui8sflNTAMf/WknKhFkRt3Y7biUw+uYsptoI+Z5zgaA=
X-Google-Smtp-Source: AGHT+IGiJo4mQye4oUs/uGdx6CBrxjsYbJ1koG/PW36Z2vBVYDMdfhg70XCODvlj1PCxOPkkAQPcRQ==
X-Received: by 2002:a17:90b:238f:b0:293:e300:97ef with SMTP id
 mr15-20020a17090b238f00b00293e30097efmr1002273pjb.16.1707258561303; 
 Tue, 06 Feb 2024 14:29:21 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCWWShz8MKmibxr1Foj1kpdEfZ86/O5j/rc9YZ78X617jK/ihi9w3/4EqYKLwDwvpzxZ5aLE44cME4k7worvsSp7ioRykQXoIrlB1Wzg1ER6cAQ5m1pERV1dcdw=
Received: from [192.168.0.100] ([43.252.112.200])
 by smtp.gmail.com with ESMTPSA id
 sy7-20020a17090b2d0700b00296ca138c96sm31105pjb.26.2024.02.06.14.29.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 06 Feb 2024 14:29:20 -0800 (PST)
Message-ID: <14b49de5-67d7-46f1-9e15-be60fb925dd3@linaro.org>
Date: Wed, 7 Feb 2024 08:29:18 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] util/bufferiszero: remove useless prefetches
Content-Language: en-US
To: Alexander Monakov <amonakov@ispras.ru>, qemu-devel@nongnu.org
Cc: Mikhail Romanov <mmromanov@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240206204809.9859-1-amonakov@ispras.ru>
 <20240206204809.9859-5-amonakov@ispras.ru>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240206204809.9859-5-amonakov@ispras.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
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

On 2/7/24 06:48, Alexander Monakov wrote:
> Use of prefetching in bufferiszero.c is quite questionable:
> 
> - prefetches are issued just a few CPU cycles before the corresponding
>    line would be hit by demand loads;
> 
> - they are done for simple access patterns, i.e. where hardware
>    prefetchers can perform better;
> 
> - they compete for load ports in loops that should be limited by load
>    port throughput rather than ALU throughput.
> 
> Signed-off-by: Alexander Monakov<amonakov@ispras.ru>
> Signed-off-by: Mikhail Romanov<mmromanov@ispras.ru>
> ---
>   util/bufferiszero.c | 3 ---
>   1 file changed, 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

