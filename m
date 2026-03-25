Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8412D109C028
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 15:19:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5Q0X-0007UP-KE; Wed, 25 Mar 2026 11:18:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5Q0U-0007O0-PY
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 11:18:56 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w5Q0Q-0001cs-Mb
 for qemu-devel@nongnu.org; Wed, 25 Mar 2026 11:18:53 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48702d51cd0so53581715e9.2
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 08:18:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774451928; x=1775056728; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5hvrUT+vRgYl+Hq0bVLw3A7u6UZFanM314YqRJb4heI=;
 b=SazD2FqgmlB1go2fqnWxXke7iqAJrsKZJtlE2h54mLB8TK9YJww6/zesxExHWvkhY9
 lpROWQScmDgRqNFeBRotWmu2TNJRB1cVEoMWMtk6G0HF+jRcD+QrmKj4hd0hvguITqkp
 Ya62Qh3WWNyHpOzBv55YsPomjJgHMKdVuhX0pbtW2EPH1G41/jUPH4RbTbIgVNZmBinx
 xyaZd8FzvX76l1drvKedbsKbJ9ujU0xzt2XZ8BEWr2w47RsO8Oq4YEczSv8FZele0a0q
 QQ3Mb9XaJPxXf76QDBXWk/hq9JwOcAFUEvrXuJv40pAQHDYyy7y4EeujEbGvrHNxQXJ5
 6zBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774451928; x=1775056728;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5hvrUT+vRgYl+Hq0bVLw3A7u6UZFanM314YqRJb4heI=;
 b=UZU4TrAIuoW58xQcS5wIspi17Cx1sMYTcym1bNzGJ+37dlbrrJ6M9Pgo9rUGYhENjI
 ExeRX2UO1hY71PCFGeR++eRBKc6YfY9Hmd3J1MNOzvFAT7pJ3l0JO4Z5innp/F5PsojL
 Gm4m5WjuDFx+tBxRlOs4xuTNjSWsRlzc8lq1cSfcuSZJq9gwtm7EKpuaV/wKP5rICmDQ
 tmSCP8VF26OXeYbR2ZVEXv8ol9ZAnop4ySYU8wXVFmjxHbiPYUy7ZUA77b0ZgadAQClV
 vBqHo4Q8cldEJAP9TaUUbf9QNvXORTMCHgdeA+SRUA1YTUHUnCc6+IDebFiIACOJjj58
 +GAA==
X-Forwarded-Encrypted: i=1;
 AJvYcCULWLNM9Je3Mtfq00aZfOnpQsxSQqIP9gGYKEMudT/n3ZELy+5MCcFfcmAt5TNZNpf/yzZjRj772qMP@nongnu.org
X-Gm-Message-State: AOJu0YyQUSS3RZbW+uUPu7Qf6+pr2gnxccjAFGZo4ao4tbz9OppEaaH6
 0/KaS3zTV4KIBsfBYX5j3s4CT0v9pR2xY1EGHbYe1Va9WI+JsQt8IPmtjB8AaRZR130=
X-Gm-Gg: ATEYQzzehQoTGk8ATyXaFvY60eW0RnHmDb8S2gpR/FnDyiaalXF/WTt/Wfzbzn3Vn4P
 V4MzXxELktL5sqn2ARa2dKgweSSTDjrgubsljMlZNeTY96KD59aAbbWXX7v5vDMNY1Sif/4rYKN
 yoelOPjt6nbeGXJ/Vy/En97oSb5z6v0y3xYiX648r1JTYX91TRYzTM5+0T8kPhUBNjamNQbE/mC
 08CwZcgK4EncvpCLSdaXrUi0TVIbnwjCV+pcBRsz9cWERWkCwO3Jnvso9GCdOyiQdq62ZfwHYt+
 Dq/6le8OuL1kmf3do6oZKiYZfEyacq373a4M/476z05XZpfPgdh/4SCa4ntSNbmerbW9rvcTUKn
 Fs8czKvzo8SSjOK54rYYHMEZcIgwVnSpCR+xcS05EuY1HovKxhHXvwmhmWAX8sZ9XVYa5OiYyip
 ZYfZ/Xc5GS0Sfwr+oDGRRT0k7CfPHjeCSnxySZrlk1lusc8hwDBV7x4gNxTyAWxLRiNYQTJEYhR
 69B
X-Received: by 2002:a05:600c:46ce:b0:482:f564:d613 with SMTP id
 5b1f17b1804b1-4871600c29fmr55560215e9.15.1774451928492; 
 Wed, 25 Mar 2026 08:18:48 -0700 (PDT)
Received: from [192.168.69.229] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4871e5ec998sm1825525e9.6.2026.03.25.08.18.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 25 Mar 2026 08:18:46 -0700 (PDT)
Message-ID: <b609440d-d416-4d79-839c-b7ab1369c28b@linaro.org>
Date: Wed, 25 Mar 2026 16:18:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-11.1 0/2] target/i386: Allow 32-bit SMM code to be
 used in the 64-bit binary
Content-Language: en-US
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260325120944.29391-1-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260325120944.29391-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 25/3/26 13:09, Thomas Huth wrote:
> Here are two patches that I just resurrected from an older branch
> on my hard disk. They might come in handy when we finally switch
> to an universal QEMU binary that contains both targets, the x86_64
> and the i386 target at once. In this case we need the SMM code for
> both, 32-bit and 64-bit mode in the binary, and select it during
> runtime.

Thanks!


