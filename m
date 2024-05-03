Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 803BCC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 18:01:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2xCd-0004R8-EG; Fri, 03 May 2024 14:00:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2xCa-0004QJ-Bq
 for qemu-devel@nongnu.org; Fri, 03 May 2024 14:00:08 -0400
Received: from mail-wr1-x42d.google.com ([2a00:1450:4864:20::42d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2xCY-00061t-JS
 for qemu-devel@nongnu.org; Fri, 03 May 2024 14:00:08 -0400
Received: by mail-wr1-x42d.google.com with SMTP id
 ffacd0b85a97d-34e040ed031so1742227f8f.0
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 11:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714759203; x=1715364003; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3H7kiPfh7BCUD9U95zjH7+tQ+21BZ6n9CYOlnBWAFMg=;
 b=NiA3cM019x2PoZgDfMUskMWBQKRDMNW04f5dXmWtSceMKRQ/x5LrirstTcw/ehffI6
 QklCWMKt5c9bAaDfm+OYnUvUIMbF+F/3bo8bcQvlNTIaLhFqowri0IW/f/8MTaEb7que
 aZE/07qRTmJr2QadMq5fHNHW+VMgFDauovMlk0JY2Kdm3gOCmwviKAkueY4O1n8sNLva
 p5VWy+op2WNr5B7Pyqy0kDt3h/p1eqWR4sesEfidFs3ZhfvUq9elPrwP53QBOGIYbDmq
 NxXWw98h9JVrFsrhSJiTB4Bcd2ys5MmkGucdWfLRx6dYBxr5gHLf69r3ELpU0u8fO6+W
 Q9pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714759203; x=1715364003;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3H7kiPfh7BCUD9U95zjH7+tQ+21BZ6n9CYOlnBWAFMg=;
 b=RCqQc5aQ0UCD0nX5FqH8W06hQH4AiqCL5U8aiKIgvFkwQdAmAXGnShtwp42B3hj7Ze
 MhK4SZjcAvx/Cmm1Z/8oEU8HrjXEb3agRHS8gKEcEplrjZXleOKmeW/qFoS9GGWayYu8
 QOXAEtnozQ7cOMVnz514nDiNXKTyRkF8w8RTH40J6nd04mnOC0JdaQS2hXG4+7uwDd5+
 qtOD8lrjahm9o+KkYQYv93jyxTotbScHWwkIsDvPt4y2Rbl3fZKHe6n6f+Sb79xKSJtt
 yPOJt/cH+h26+6hI16h2fqZnob4QPAG9s3JN03tGWbXLqx73p0TDSwIJIe8Eq66GyGqn
 Y2aQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWlEY8o7XWAOrFTeH2K/kqHBSFqpxoY616vWSx4T05NBWuWD8aNRriIaaPoZM0QLtWfoLgYeW+/N0yxWpbh9F9t1vepJwU=
X-Gm-Message-State: AOJu0YwUB2XqnavB73Dl54DRdli7U8kz4TaUd8Vq23Y/ZYyWI9nnRfaR
 xb3HUhOkafcL+QtVSrFuIzZ1jBZsS2dSJnBquEXKrfqEnh7Xh/ZSFig/gJ1GLFM=
X-Google-Smtp-Source: AGHT+IFs7xKRZOAIU8Q4otQC70m1nCj0K1s/egYbpDFcLxPuhOtc+Ht1O90fvXnVl82cwmWnHZcWXw==
X-Received: by 2002:adf:e586:0:b0:34d:2343:b881 with SMTP id
 l6-20020adfe586000000b0034d2343b881mr2834491wrm.43.1714759202616; 
 Fri, 03 May 2024 11:00:02 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 t3-20020a05600001c300b0034df7313bf1sm4374764wrx.0.2024.05.03.11.00.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 11:00:02 -0700 (PDT)
Message-ID: <0d25b3d0-c904-48e2-8d7f-f81638d4abee@linaro.org>
Date: Fri, 3 May 2024 20:00:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] qga/commands-posix: fix typo in
 qmp_guest_set_user_password
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com, kkostiuk@redhat.com
References: <20240503171333.241463-1-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240503171333.241463-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42d;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42d.google.com
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

On 3/5/24 19:13, Paolo Bonzini wrote:
> qga/commands-posix.c does not compile on FreeBSD due to a confusion
> between "chpasswdata" (wrong) and "chpasswddata" (used in the #else
> branch).
> 

Fixes: 0e5b75a390 ("qga/commands-posix: qmp_guest_set_user_password: use 
ga_run_command helper")
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   qga/commands-posix.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)


