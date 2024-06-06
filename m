Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76359C25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 06:56:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sF72d-0000ua-5q; Thu, 06 Jun 2024 02:56:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sF72a-0000tF-Vy
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 02:56:05 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sF72Z-00007m-D1
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 02:56:04 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4214f803606so7008735e9.0
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 23:56:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717656962; x=1718261762; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DhP5cuZ2ssryehuIH5yI1neT4ySJU3ZnR2Wv1dagBx8=;
 b=UCf/KGJjSTTjio20YgOpcA6oPxkuXicogFbRbQtJ81T7UOs7FUJigGSawXhITQc3Hs
 y3rpmkVn9s9pKlTAMVrsi0qQNcf9E+zxCwOXHxE0KizFATiQofsbMcNNIiucAZbDazqd
 RBLZQ0bOWCsYguWDIdOAdj19pDWZVZ3bpOm7EPIBg8t9+UA8pDvVCOmUYEBGn0gGJqIY
 BuZCDX9boeN7hMwbh9ftS/JANMsfCoa9xxwEvAI7j4EeRJNXVpy4+pZ+jUtttqj2pCdb
 F52I0NYzyfWqsEFK/UcU8043AvXAJ8YmsK/WF0bof9EwBGCkW072MI84aeDwUVQOUeJQ
 yL/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717656962; x=1718261762;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DhP5cuZ2ssryehuIH5yI1neT4ySJU3ZnR2Wv1dagBx8=;
 b=e4toqzOT7UFjwzI6ilZ7SKLFRRn9jN2wasMGcqDoJxxFpyU3EgK0xe5KWTOSJUBht0
 3Kh3+gRSFXGWH+W+d+s7RDQprkaLCd2kTcIBytHfurQZeATRAIgAdeARmEEgzHfOaxjw
 Mlv+y1YefmNMzvSys8iKyaNtjiD/uLl13l2ceD1GuURrW0Was1kD0m+tUAkSurpou5+V
 PgsHvRZ44sYyphN/umBmVBnCjwyePOPJnM4PfjJLOUWOAO8Lh/qUAmKVZE/vKYzX5qJ+
 v8sQxIEtsrU/SMCFLBctzMCKFo/Yar+g1xDmrGeFeYY5LRtYiNTM/Ac8k7I5/Hinntz1
 jFOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWGu4HvzQ15ruxv6PQfuuvy5r58YHlXuDq3plpK3uP/TymyKtuvKxYE/GZlFOIlwcQ/g8FvNlggrdGtV/qLy7Z+9yzBDVk=
X-Gm-Message-State: AOJu0YwTATtdz0x1eQu5KMpIcbsMq9OcU/+gLSouZVvJerpUm8E9uECT
 R6oraVRfzG8g12UTejzPkK30/3TGzWGu1cuj3C6NSyi8cRZ5zjS/BFiYntPdPJ6x+LlJC0NzZ+m
 whhI=
X-Google-Smtp-Source: AGHT+IHd2XtRc4upLeugTrnxluoiNKpFxYr8WFDvW07XgsoZkIXA+PEqyyQoCbgWw9jb/3LWKxbI4w==
X-Received: by 2002:a05:600c:3ac4:b0:421:1dde:cb5a with SMTP id
 5b1f17b1804b1-4215634db96mr40440455e9.35.1717656961738; 
 Wed, 05 Jun 2024 23:56:01 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.217.163])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4215c2a59a3sm10876235e9.22.2024.06.05.23.56.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 05 Jun 2024 23:56:01 -0700 (PDT)
Message-ID: <df04f3e0-34b7-4ce4-aed7-69bef43af84b@linaro.org>
Date: Thu, 6 Jun 2024 08:55:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 0/9] plugins: Use unwind info for special gdb registers
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, alex.bennee@linaro.org
References: <20240606032926.83599-1-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240606032926.83599-1-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 6/6/24 05:29, Richard Henderson wrote:
> 
> This is an attempt to fix
> https://gitlab.com/qemu-project/qemu/-/issues/2208
> ("PC is not updated for each instruction in TCG plugins")
> 
> I have only updated target/{i386,arm} so far, but basically all
> targets need updating for the new callbacks.  Extra points to
> anyone who sees how to avoid the extra code duplication.  :-)

Do you mean on ARM, aarch64_tcg_ops i.e.? Because X86 LGTM.


