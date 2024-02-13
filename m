Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A90C8C4829A
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Feb 2024 18:34:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZxbP-0003WQ-9c; Tue, 13 Feb 2024 13:33:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZxbN-0003W3-NP
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 13:33:53 -0500
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rZxbM-0002xl-4U
 for qemu-devel@nongnu.org; Tue, 13 Feb 2024 13:33:53 -0500
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-1d71cb97937so44737915ad.3
 for <qemu-devel@nongnu.org>; Tue, 13 Feb 2024 10:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707849230; x=1708454030; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=WrL3VQadMSDjEv9wzfhB+FnKnd/32KzdGRkWhAuZbwg=;
 b=dZbd9lH4LgtG3gltyJMmXW16r70IRKexHTSiXRwPlQDRiNhsjY0YlJtejyoMH1Hx7y
 aZLpXJ+idDbuVTyTRUkq79l3+XD7uLEbJpwcFVAOPQiF7tswIfAe+gYVIjHQgKUsMKZM
 MSSijOUAYvL+45GVc/r9Gcll89didDwJ7taIRbh8uCdNLPcW43J4uHiIAOGFZ4Ie3WHC
 OuQFH46aAj16/GiZlEj7UdVwLm4IJ29s+RxbzidQfGg3bJzBrU14YrvtsQr4iJ7dzpCX
 ssQWfylON6bi66M9LvcF0AmJa4ps3BmGpu1rIhSQY+1PXP4mSoQQ9ysF2NBfuMEtF5Mn
 xcqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707849230; x=1708454030;
 h=content-transfer-encoding:in-reply-to:from:references:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=WrL3VQadMSDjEv9wzfhB+FnKnd/32KzdGRkWhAuZbwg=;
 b=ZQxR38mgTZTPp498kR9KKAEcpHfj71voFXaa43zB0TDU3kgMGLRLVtBsuG0hLrK+Vd
 89o2aBeyeXMsW4cudqfW5rZ9Sd/1b7gCL9BIodvqHP5CaZo/us2/SlSQ26H5Ri+Fn3nk
 UN22N2kRRciom4e6FJ/xmQIxZip1oPZD2//bbRTMhtRs+sPH+YQ5PAdm2qY4d88UL1Jl
 dMQvkpfPKmk1l3dhGqI8IlnHAD/oV9Vr01uSzBL5Al2jWZQpVy25cGxq9yDtFsnkxCQB
 bhdydphwtq7EGcrn6IXin14Bsbqb6pu6fRSYywDiCLqTMadxcr/4OC4GZZ0cfDArjAFP
 vWmg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUZfzrHdVTALpPgqCscIqUFyYZv5YEy5tk1ouzZmE+Jj/TIwm/PQWJ6MdvalBrTgFJQmy+5fhN7pjRBCmtGo7QYTSSoViI=
X-Gm-Message-State: AOJu0YxJEiREbteMy3K4B4ts1QN9S0WlzWq6+s92SZI5ak+0eU3awHi5
 mnk9zwhYBVjD5YlVb+ybg989KuaC2PspXNPMq6eRmtLhgUHQf8EIhDiXhrnKEC0=
X-Google-Smtp-Source: AGHT+IFlzgCPn502ZZ7afbGsAPHG40fy+y/02Vr+Wadq+YHOs183v8H+e3DCvTWyiem/xcKFZP9G1A==
X-Received: by 2002:a17:902:aa90:b0:1db:45ac:e55c with SMTP id
 d16-20020a170902aa9000b001db45ace55cmr333925plr.18.1707849230568; 
 Tue, 13 Feb 2024 10:33:50 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUXA5A4dqyWV91Afyi+H0nTcaOcFXWtqwy1dvPRGDy6LF5OmGlj6daSl5x0SdAmiYZRtwzKbc+aFHAqGlkQcjZqoARHfvI=
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 jw8-20020a170903278800b001da2f9d04b0sm2409062plb.15.2024.02.13.10.33.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Feb 2024 10:33:50 -0800 (PST)
Message-ID: <1a60dda0-3a09-41b0-950f-9463d47662a4@linaro.org>
Date: Tue, 13 Feb 2024 08:33:47 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/18] docs/devel: plugins can trigger a tb flush
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20240213094009.150349-1-pierrick.bouvier@linaro.org>
 <20240213094009.150349-8-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240213094009.150349-8-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
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

On 2/12/24 23:39, Pierrick Bouvier wrote:
> When scoreboards need to be reallocated.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   docs/devel/multi-thread-tcg.rst | 1 +
>   1 file changed, 1 insertion(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

