Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8BE23D185D5
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 11:15:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdnye-0007XL-32; Thu, 08 Jan 2026 06:14:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdnyR-0006yY-LU
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 06:14:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vdnyP-0002t0-Bf
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 06:14:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767870876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Ogn19CRzCbidLuAARjfEZkTrf9EyGp3ZBIEvMQRnf70=;
 b=Rsha3F38fCEyJw1EKJwnEPSV8FoFHNOPFuQsMhsSZDOoCxQAQhoR/Ww6PKDOqK/+XtOrpj
 7AHQxKxE1pqWZxTbdu0nMFwc9GZS+N+pCpkyTP/6uLoOPMBKX0UFlE0RUz3twsOR+5f99J
 NpN7mRWOjY0x3Lbj3PzrapPkvvrXylc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-qkFf0q60Ozy-vuPbNcEcsg-1; Thu, 08 Jan 2026 06:14:34 -0500
X-MC-Unique: qkFf0q60Ozy-vuPbNcEcsg-1
X-Mimecast-MFC-AGG-ID: qkFf0q60Ozy-vuPbNcEcsg_1767870873
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4792bd2c290so32336915e9.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 03:14:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767870873; x=1768475673; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ogn19CRzCbidLuAARjfEZkTrf9EyGp3ZBIEvMQRnf70=;
 b=FNGXlp982UP50FeZrRd4rxlWvKpQhUTxmJHC2bzYA4Mj6pHvn5TynR8wY7aFqItWs/
 7QH8UJvwQERGUou5hzttGSuzkYUm8Zl+vUQeovD/j5r3CoxzlZaDGJw9tuUJ2P9Bl8UJ
 9921tM/IlFPaqNTWqM8kffKcryHW61XSAy2UImDmmE2HSGPG74iyodbDkRftF1fwC9Ez
 MELXZH9y/wfk4SG8C+4cIvzKpwuRdLrW8RYEBz2q0p+JagOazW7SRrItSoSJ1Se4h6Cu
 o6bmhfuKwDt4E9ZnjjXg56wc0nspRcBhI/u5fbvV+cv3h1n7/7vXU4YyKMsT2YxzZQsK
 Wrlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767870873; x=1768475673;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Ogn19CRzCbidLuAARjfEZkTrf9EyGp3ZBIEvMQRnf70=;
 b=vQNTgYOf1Rj0DU24hQBjDJMhg17mqUvJ6gkTpz3s8+c1FD8sT4MX/JjiynSN08TESP
 EmQlWNcOy8V7TsDK7lPcQgObzQgfAppP0JxWLxqePmuMU+hm8fi2obPdikZtE9XT546n
 kqkAz4n+NOpLQXYG3IocO3oztNUfk5xWp8cua/Kd0Y+WyRMFMOp9hwmTj5uaX2BQx3iF
 OjII7S61FOH/wJrHtj9q6poKHjf3OTeuZj0Q2QXSXCISMJa2JuuYI6wdsVNOKzNrwuWv
 s0oIbMoSOWlKNZFP2+DNkeER4zdM16EcioyOsGGBZvfG0B3QPwLIYO3SrWAUc+CrEOWb
 WclA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVky0J/BDEpFHPVQuV/HtNwD+9XGDhE54eOIJKIA/ZH3Bhaa6qxtP8Rz2Kr7j8j35Re4YNU13iaUSZc@nongnu.org
X-Gm-Message-State: AOJu0YyLZiAGzWH8Io52UfHM1PKSwgQqcQvxrwfr+wvGCp2Wj2Z/PQ9H
 zC/suvt9HVUyMVz7ocZCRK0ya1dRYswnHYc0dFTqQ/Gd0AYygrGMHqAelo2FXEq0T8R/AaHffXJ
 8pGD179CcNEGwZ+yXxA5F7Jeco84Rq1tDW9YneSIqDnnBWAw6TIqIRuZcrpPXO2y8
X-Gm-Gg: AY/fxX41VFUcbW50h7S5ZmsHqawOYrzfDyUCJw/+gpj5NnVUAqVfoiyZUtPNLIC9k8N
 BCP5s4Iuh2YktNNKIZC0xMstjsfaVUL+wwCz/pMktjIe3iIzVU8NksluToWkZjpgK4UC29Fq6CZ
 k5+SI5ypZGtZmpu7CStM0MBdhQjpbzaHBw8uX1PjvSgMZTw+QYvdeM1JlynqCUYy+n6SdIpX0S6
 b8WX0x0W5z9uhTjXRweJoMLZKoz2K0BbspOCoOtmLBOjO3SNKlygFT8Vj3uey1MT9m7B0l4Mki5
 7mmW3Nf64MNRR34KYjynY80u806vRlY4eNskd8SABrTuFnUNBClV586d9qoViYPtTKb02eMFZxo
 5syqB9OQ=
X-Received: by 2002:a05:600c:3114:b0:47d:403e:90c9 with SMTP id
 5b1f17b1804b1-47d84b18663mr68656255e9.11.1767870873407; 
 Thu, 08 Jan 2026 03:14:33 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHfIQDfCyV0xpVrFLKut83Fo2hkjcUHPuNyKSpXPuoiF6Sjrs3Lt+t2B3/it48OahGr/DQSZg==
X-Received: by 2002:a05:600c:3114:b0:47d:403e:90c9 with SMTP id
 5b1f17b1804b1-47d84b18663mr68656075e9.11.1767870873027; 
 Thu, 08 Jan 2026 03:14:33 -0800 (PST)
Received: from [192.168.0.9] ([47.64.114.194])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d8718c610sm34518065e9.15.2026.01.08.03.14.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 03:14:32 -0800 (PST)
Message-ID: <07cf5928-1db2-48e6-8872-64950e5b81e6@redhat.com>
Date: Thu, 8 Jan 2026 12:14:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/50] tcg/i386: Remove TCG_TARGET_REG_BITS tests
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20260108053018.626690-1-richard.henderson@linaro.org>
 <20260108053018.626690-11-richard.henderson@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260108053018.626690-11-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 08/01/2026 06.29, Richard Henderson wrote:
> We now only support 64-bit code generation.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/i386/tcg-target-has.h      |   8 +-
>   tcg/i386/tcg-target-reg-bits.h |   2 +-
>   tcg/i386/tcg-target.h          |  13 +-
>   tcg/i386/tcg-target.c.inc      | 552 ++++++---------------------------
>   4 files changed, 97 insertions(+), 478 deletions(-)
....
> @@ -152,26 +127,13 @@ static TCGReg tcg_target_call_oarg_reg(TCGCallReturnKind kind, int slot)
>   #define TCG_CT_CONST_TST 0x1000
>   #define TCG_CT_CONST_ZERO 0x2000
>   
> -/* Registers used with L constraint, which are the first argument
> -   registers on x86_64, and two random call clobbered registers on
> -   i386. */
> -#if TCG_TARGET_REG_BITS == 64
> -# define TCG_REG_L0 tcg_target_call_iarg_regs[0]
> -# define TCG_REG_L1 tcg_target_call_iarg_regs[1]
> -#else
> -# define TCG_REG_L0 TCG_REG_EAX
> -# define TCG_REG_L1 TCG_REG_EDX
> -#endif
> +/* Registers used with L constraint. */
> +#define TCG_REG_L0 TCG_REG_EAX
> +#define TCG_REG_L1 TCG_REG_EDX

I just want to double-check: This change looks confusing, since you kept the 
"else" part ... but the (removed) comment indicated that this was the 
original intention? So this is also bug fix?

  Thomas



