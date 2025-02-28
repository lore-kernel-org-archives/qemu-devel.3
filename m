Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 735B8C282C6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Feb 2025 16:54:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1to3cw-0004WH-Nn; Fri, 28 Feb 2025 11:54:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1to3cv-0004NO-9V
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 11:54:17 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1to3ct-0006cS-Of
 for qemu-devel@nongnu.org; Fri, 28 Feb 2025 11:54:17 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2feaca4e99cso3145119a91.0
 for <qemu-devel@nongnu.org>; Fri, 28 Feb 2025 08:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740761654; x=1741366454; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=C65t9vtYeGdV8K2Iy4HPZIkGcZTVDZzapYJ2xi/9egc=;
 b=EhN/nLo9lZ8rFgcu7bpRJ74O+wC8c3QB6/EED5I4Evf9K5ukjwcrisNOk7zrGPencQ
 XbXnj7f96arn68Uqe6vFxxfGN4EqQmCiZ6TJ/u9vd5zIN5KxgJoE8oyI5nhqsTzKJ+OD
 n6jGPSBhCpi74XQ+UXjfGy1S6oN3rbX1VH6LyhdGIKRg1CrEEE1rjDze1v8byJ+Npj5I
 8DjeqgaKZgF7iLj/RRG8JLusVVvTd09FlO3AdeLOMP+6ZbrQ1V304wpdWEIzzVCtVTQr
 v0B1++zMXfhJLLNSsuoxrds3v93j1050QvaXp7BL+bnIszP6xeQT0ji6HfxgvNHMMUL/
 OdXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740761654; x=1741366454;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=C65t9vtYeGdV8K2Iy4HPZIkGcZTVDZzapYJ2xi/9egc=;
 b=aPVxPkEfgyisKZZx/9/FA7S5+7qGwiCRUEv4sPvwb5uZH4hcKBzRe9nOuU0UVn94+O
 ajRpwYAETYIUQbk+YSOoFpzBciUf4cInvVrv5nyz6srXNS40wOr9m2xLjwZNvJlYes0B
 EzZfK5HyXq9z8wN1EnojvSf8evay8XUK/Fm90MrgTw50Xa0/gJvYkZ3kiW7e0uLOKJFc
 t4LhUINiKe6Gu8v73ZUM/GgkP6LuGtwm00RVAbkhDz3KMDJnLGOIHUOvqRqXuSoBdEw6
 T9djVaZyLBgvEHkJ0fLJs8Z3sRTcLtkP9Cqm6VAhbVySCMzAvpDlcUwJpqzMe7DnApxZ
 0lSw==
X-Gm-Message-State: AOJu0Yzh598wiVzl8MrYrsHxmHpfzeYbHK7YvZ6PiNOd8G0RmqTHmVjz
 JCMBE2D1hOFQqnIbbXGw1Tkm7DNNxH8lxeEucuW+4CgyThSUe5ILmWGz1bKByzqJYZ6RyrHcijH
 L
X-Gm-Gg: ASbGncsmwJ907/xIsbBwKRzH+lxMdhtmnLITHUpLbxbV9bBLC8CCfytmETONZtWhZBL
 FieDoxhO9qDDY68suerwgVyfg+U2vkgY97xkJaQ/vaLYRHzT9nURxtc97gt3CI8mPghN/mZY91W
 BBhfCZOeUdbhF9i+t5rs5dZHNPvFSNIZUcXB7PEs4ZtuZWm5XC4KwNWfzQr4AfNrJX589014C9Q
 JyuUmgQ5X3fw39kqFWvqtHbgz/W/TtszBLGKkBEfEeqPF/PyTBYY/ELpGRzocilEGYXa3QP+c05
 ew6UWKoaMSwoJtVsBXTb5oORR2Nh6woV+I95Y1mNXRkIUHmlnClh3p24ufaCJdcuZA9G6DIHr9J
 ixbteIcc=
X-Google-Smtp-Source: AGHT+IGy+AhlceUNcO94boOgVjw4Y2XnrJ0CWfDG2JMWjzlaDuEeMZc42chK5B9ZqiRh6RFOVygY4w==
X-Received: by 2002:a17:90b:3c02:b0:2fe:b8ba:62e1 with SMTP id
 98e67ed59e1d1-2febabf41afmr6179047a91.28.1740761654197; 
 Fri, 28 Feb 2025 08:54:14 -0800 (PST)
Received: from [10.254.143.227] (syn-156-019-246-023.biz.spectrum.com.
 [156.19.246.23]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2fea696e50csm3999202a91.31.2025.02.28.08.54.13
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Feb 2025 08:54:13 -0800 (PST)
Message-ID: <12a158a4-fc88-489b-b184-a8a78fbdde78@linaro.org>
Date: Fri, 28 Feb 2025 08:54:11 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/7] tests/functional: reduce tuxrun maxmem to work on
 32-bit hosts
To: qemu-devel@nongnu.org
References: <20250228102738.3064045-1-berrange@redhat.com>
 <20250228102738.3064045-5-berrange@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250228102738.3064045-5-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
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

On 2/28/25 02:27, Daniel P. Berrangé wrote:
> maxmem=4G is too large to address on 32-bit hosts, so reduce it
> to 2G since the tuxrun tests don't actually need such an elevated
> memory limit.
> 
> Signed-off-by: Daniel P. Berrangé<berrange@redhat.com>
> ---
>   tests/functional/test_ppc64_tuxrun.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

