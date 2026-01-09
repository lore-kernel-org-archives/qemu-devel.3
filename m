Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3DE9D232E9
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 07:45:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ve7BS-0002jb-NO; Fri, 09 Jan 2026 02:45:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve7BJ-0002f2-Qc
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 02:45:14 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ve7BI-0001zR-DR
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 02:45:13 -0500
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-4775ae77516so43790845e9.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 23:45:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767944711; x=1768549511; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HthxjT0IS/+mfNmyNSl9TyXl1J84D4NpLHhPVqssp6Y=;
 b=sNKuN8Cl8pGhMRbH+jFntTieVik1/+axA4TmDojOc28SBdnmUsVZQOnP0ZCSwDif39
 aohqPxQs29khjRjCIosg4HRVRMrye+buYoMXGbYoAnmQyVYPBzhpwOFZJBPe6rlGvgLZ
 RXfH/QQV/l7HNos1azP0xtyo5g960EspZkkJvaUzPG6t2+Y3PdkgbRckwYdt5BKL88m5
 Ci97eMipz+RE4zzCRIcAaNV9x9g1QovqlL6hAOAFq0muUcTT3cVVKx0Lu3zJ8BD3j87S
 MzBlRbYbZzJNTfI0rT5YdJ4LO9Ste3tOdara2LH9M/clQsE/kM45/r6YvJnXyxtKqWi4
 4GDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767944711; x=1768549511;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HthxjT0IS/+mfNmyNSl9TyXl1J84D4NpLHhPVqssp6Y=;
 b=tYboSLdnUmIb53bAbP1q/sGDMS9YcauwvReO2nGKqVk+/ZzSDGHp6/DwA8Yd9OCeh/
 HGnNjqI4hdonBclu31s97fGW66fJWnkEdmWMM9hD/Ie7dlKVqjiXi5QGcRSRZL0Ttao9
 9CC2JGeSRKxRsuWkyBVrNCF7I+cfz0LjJ5YcxwOaQ13GhNHlMkiCjU3yzwtHu809mi8W
 f1ZafSI0Pqyj8cemNPNORIqrjNuW2PmwoQhkUsM9sCFzwe9ezs3PRFWEXCs9OCVJikiX
 cscFXRSjLw9Wrvb+ro8p0qz1RUxMLPDYzrEIRXngbRYNXnuTIdkEkUNIvNJotUGjxntt
 fwYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUWOzT7892sywJseRdKn625CQ6Z1FKGksUg4rqGAcc8CZFmQoT1YSLlimG3PhN/ITUZmR9kWJzQ7stk@nongnu.org
X-Gm-Message-State: AOJu0Yy1T1U3wZRe8Q6A7lq4SZ0Esx7AnnKjagkYlOfI+If7W1dqsRCe
 CryjCa1qQ6IyK6JxIGr5JUC0emSJ7XIxFa4DD3Oj+Y6ahuz7nnH6zEwQ1ziAL+7k2Io=
X-Gm-Gg: AY/fxX6G4Ns7UnznH4GdUYzR34LIBkc3P7k13gfecoC/QtKksIVeDqF1Q5UOUXZy5PT
 s/qXX4r8LuZLoI5WKZERq+P4WA65hfEwP4kFvxcKjvVcXYAa7leGYhSbLBLQWoLasUmwChBKWNo
 igFrUFhXAh4RTwDevr1wVavE++bQ5grw/v3ykv4dlRdZliPX5S+ZnncDgy0kBe7Rd4yrB4sN+wP
 Vev/6a7vUUt9IBTC9584Y0Y+3sUMG+VlDXPyTbnalMlv++uuahyJ0xvQ/cx+NUwaiAgQwvymkg0
 kXiQRrXwFphVoQDw0KsGb0KKF5k+bQHLCc1GAWprkGDhrXasdN2AZQb08HkhnpI+MsChExD9MWk
 tGMEjoZDdIQnXavkWQFKKvLZugTc1wI/7VO8z3Tlpi6hjMip269UFKpOgBHTZbo5D9C5xfUGcsq
 o3yQGqlqtMPergSBwvdqX7J3BWaPOipGzsSUmUf7l9PVZoVrKvHW8AEQ==
X-Google-Smtp-Source: AGHT+IHoakssNyPd2T8pGTNk60RAa7lMuKx9Ea83gah1mP3uZFfaXc0hNSKFnlbdQ429bX1BXnbQKg==
X-Received: by 2002:a05:600c:46c4:b0:47d:403e:4eaf with SMTP id
 5b1f17b1804b1-47d84b18ef7mr112850175e9.10.1767944710801; 
 Thu, 08 Jan 2026 23:45:10 -0800 (PST)
Received: from [192.168.69.213] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f668e03sm201512405e9.14.2026.01.08.23.45.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Jan 2026 23:45:10 -0800 (PST)
Message-ID: <eed81c3c-6a19-431f-9dfb-92eaca1b5def@linaro.org>
Date: Fri, 9 Jan 2026 08:45:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/29] target/arm/tcg/cpu-v7m.c: make compilation unit
 common
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Jim MacArthur <jim.macarthur@linaro.org>,
 anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-9-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260109053158.2800705-9-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x334.google.com
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

On 9/1/26 06:31, Pierrick Bouvier wrote:
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/meson.build | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


