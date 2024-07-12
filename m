Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02C71C2BD09
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Jul 2024 22:12:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sSOUD-0007i6-1k; Fri, 12 Jul 2024 18:11:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sSOUB-0007hR-Nu
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 18:11:27 -0400
Received: from mail-pg1-x52a.google.com ([2607:f8b0:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sSOU8-0000nU-Qp
 for qemu-devel@nongnu.org; Fri, 12 Jul 2024 18:11:27 -0400
Received: by mail-pg1-x52a.google.com with SMTP id
 41be03b00d2f7-656d8b346d2so1639912a12.2
 for <qemu-devel@nongnu.org>; Fri, 12 Jul 2024 15:11:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720822283; x=1721427083; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uwz70OfERMB86TaCsI8Lqz7/+ybmADhdvPUXJiuwYMQ=;
 b=uQ1+HNjYlphfleMqFWq66byMuK/EJojZfK3cGjoqXOa3SAt7VUXtSldeCr62dtwFBw
 i/sutDS9kpU+Pb+vTLVNL7FvQTxeU3UE/rn9v5kQ10QiPPdI5BDEdEWvoAhIcA9GzFK7
 9kNMAmEKdWwq2XOppHMKWxOdieN+/1RXftlzwsyHEVOgYZ6iB9/K7c5Ecc+aFWTJpvOs
 JggGOxVmpfU2WrrRBjib2p8IChFVEntkXVuzSSThKBQb8VLLLpZWANDj6k5o7pzDsiFM
 ycrRdrx70aI3e9mAPK3uEFUOXqtQBRXEcrhraN8Jqj9iuo9wMc80UqWRdK2XQQ/C9Lnt
 ICYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720822283; x=1721427083;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=uwz70OfERMB86TaCsI8Lqz7/+ybmADhdvPUXJiuwYMQ=;
 b=qQ2ZlnDJUN5lUTeUrClI44AuO5Bh58UzB6rC2W7XDhNUzLvjjFWat3kc5Od2WjF+Yt
 SCN0vF+I2VaIwy+I0ymUDP99Rji6szz9ju6ldv5Y6clX8p97jzp9lrK3QVvBytwNPrMh
 Vjw0IMq5uhyJOKYGuWBZAfsMgf/1FLJeeGZeigIMEyMrsfUZeXW3bC+p4VqH5jFDJv/h
 aCIr2gk219cmdiB9UvZM6L43CoB/MjljBWlH8keby1HO/nT9w8JpJuezsIraK0y45Dyr
 qWPnpYq2m48ZQkpsANgbaZ5zzLl9xBUGYLSbb70TghD8egrsuNWRaMyv9RMnfC3iC0q2
 kXxw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQM8wSNqeoXlgdMQeF/cemLqZma5Pnf7ZFZ8e/CeuqcbsSKICZ/fpO8XEsCUzgwtbtfTKKWxs0HIWGQQn8BVP6Ow5b3V8=
X-Gm-Message-State: AOJu0YyL7tJa3KdMcgH75+SsCXg76Eveoy1T3ghueydOt8iFt9UulWLX
 b7ElXAUjrX0ypiNE/Kc7A0mGW05gYKf3AiWPg+9etXuvReY+bIQLGgTW520PTcEAtCr8zZcExqF
 8
X-Google-Smtp-Source: AGHT+IEmQiUXXSKC8cdaXQVkqedVtV8FYanAzG5ryBPrv//bMGQKfLuqBe00oOu+WqkyR7DySi3hnw==
X-Received: by 2002:a05:6a20:7487:b0:1c2:8af6:31c2 with SMTP id
 adf61e73a8af0-1c2983ba4f0mr15856758637.44.1720822282540; 
 Fri, 12 Jul 2024 15:11:22 -0700 (PDT)
Received: from ?IPV6:2607:fb90:c960:83bf:3dce:b9f2:e454:16c6?
 ([2607:fb90:c960:83bf:3dce:b9f2:e454:16c6])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70b7eb9c92esm16374b3a.13.2024.07.12.15.11.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Jul 2024 15:11:22 -0700 (PDT)
Message-ID: <a3809a21-4f2f-4a2c-89a7-84d69076e3da@linaro.org>
Date: Fri, 12 Jul 2024 15:11:19 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL v2 0/8] loongarch-to-apply queue
To: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org
References: <20240712013632.3464731-1-gaosong@loongson.cn>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240712013632.3464731-1-gaosong@loongson.cn>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52a.google.com
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

On 7/11/24 18:36, Song Gao wrote:
> The following changes since commit 23901b2b721c0576007ab7580da8aa855d6042a9:
> 
>    Merge tag 'pull-target-arm-20240711' ofhttps://git.linaro.org/people/pmaydell/qemu-arm  into staging (2024-07-11 12:00:00 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/gaosong/qemu.git  tags/pull-loongarch-20240712
> 
> for you to fetch changes up to 3ef4b21a5c767ff0b15047e709762abef490ad07:
> 
>    target/loongarch: Fix cpu_reset set wrong CSR_CRMD (2024-07-12 09:41:18 +0800)
> 
> ----------------------------------------------------------------
> pull-loongarch-20240712
> 
> v2: drop patch 'hw/loongarch: Modify flash block size to 256K'.

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.

r~

