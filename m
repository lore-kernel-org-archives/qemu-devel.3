Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C08A7C282DE
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Mar 2025 09:44:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsf6C-0002RJ-VP; Thu, 13 Mar 2025 05:43:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsf67-0002Ql-4J
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 05:43:27 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tsf64-0005nr-T1
 for qemu-devel@nongnu.org; Thu, 13 Mar 2025 05:43:26 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-43ce71582e9so4247425e9.1
 for <qemu-devel@nongnu.org>; Thu, 13 Mar 2025 02:43:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741859001; x=1742463801; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ajTal2z3WHqsFSlwHTlX+K3XpIiz0pdCYcp16LESb1g=;
 b=dO9gRgk9aoylU8lfYP3rUfJgdLUB2poxB/juX7rzBNYaXKy8w/afr53Cpv9x8YZWdM
 GoM0nhwQ2qsIuUMoPDoKktZDKsU1e5N0oJkQkVa6yz16jBOzG9DVFm8RXyq6+Nh8tQ8S
 jw7mZXHjqSZUWqLjaTXxY1713dTn4Fj1RbRnoG5HSbFti0zH7EzCnR66D7gZsa9HLRnN
 HfKS0F2UzuMGYoZUjWu+s/YYMy6FSJb/IOZVygxfDE19w9/HO+kYv7oE8yJmfimGbFSv
 MxUK7yjPl4o2czM/cx5DsEWnXROo4YNTXDvmCJfd6sc+h9BcS0GY+daNqNP6aGf2zAAW
 ay1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741859001; x=1742463801;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ajTal2z3WHqsFSlwHTlX+K3XpIiz0pdCYcp16LESb1g=;
 b=ZIBYHdkbgArulte7BpQRwVgWLq2lRdEyXR2So0jDoma7CVfbEMH+Z34LXmuamJUCAT
 xKhN5TetzXyYFBoZg3xVlK9STOosD5oFjrRe9UVymm7vjNKYEjeoVZsyIqcWEWwIq3B0
 ZzTmR/952Qsj2fx/xkiH42Einft7Nzwm4Msqkreii6KSyBxptszbGzOGL9T9b2KqJ1+1
 zWus90TUDvsb2ult5+RDY8kco7ZWPbWwEqaV3JYsXmTp1SEGk7dpS6jhLLY/5VKu3cdo
 EEZqcSZTKYmCXaMCg1/Beq2avEfl09BwYAeoSRqYrjy2Embhl+Gf3RPRuO5N0pTcysMu
 f82A==
X-Forwarded-Encrypted: i=1;
 AJvYcCVdQ5MJJNcVGgDvrLXQQZLZ7D/vUMKlmgIQJjSzXBpBI0yhsdspBFfz+roi2NQxjMKLiX0MX9wEFTD6@nongnu.org
X-Gm-Message-State: AOJu0Yz5Lz8ZJOTt0kPpGgXLYJQlOKhu3Cb0LS4+UsyLKSuKZmIP55l5
 E+yRzrRnW2vEosPvMbwhWg3V9lfziePorbplg0U2WXuzvcVy5tItbbarLpMWbIc=
X-Gm-Gg: ASbGnctmCKAKHt0SV7rGc1TaJeuNIfTmevEdWS6w+E+K2hrsJfoCd/kOifLih5Gi1v9
 mR/cA4yC6XBoR3iQrcVFGZ5bub8Tkuo/lmjfvkTZz2g1dYKAZA/3L/tm2GqW1O436Cl1n4581CO
 pSnXb9yfcE0ERG7iXCOw8Y2MXUsVJTA9YuIpRBEhUUMZW4jlINXagnZ4uGP0hsWMSqIYh4frPS9
 sAwYVTWb6GceE9mjwLvIFVeGnkXNU9xfhKiNvuTn/SJQLuE5aFw/jXhPS83RBXWxt6xh1ixHVIb
 FDKjqD6zSMkV/Y8XkPHM+4D3FQh1Q2/2rrSonimAAqg5bD6fhTKb6BiMS2ywbNLPbcj3T8cQ7en
 1R82FsU93sg==
X-Google-Smtp-Source: AGHT+IF2/+gOhJePP3yDnQUXZiIH087GXZ61Viv4RmDrc+hSnqY0TZm4KBGxnUK4eY7XbVAQItsAag==
X-Received: by 2002:a05:600c:4e45:b0:43c:fa3f:8e5d with SMTP id
 5b1f17b1804b1-43cfa3f9022mr127565465e9.2.1741859001480; 
 Thu, 13 Mar 2025 02:43:21 -0700 (PDT)
Received: from [192.168.1.20] (88-178-97-237.subs.proxad.net. [88.178.97.237])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d18a2ae60sm14358295e9.29.2025.03.13.02.43.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Mar 2025 02:43:21 -0700 (PDT)
Message-ID: <82a2bd1f-a150-4a72-a7e6-29b95bbd04f3@linaro.org>
Date: Thu, 13 Mar 2025 10:43:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/37] accel/tcg: Build user-exec-stub.c once
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, pbonzini@redhat.com
References: <20250313034524.3069690-1-richard.henderson@linaro.org>
 <20250313034524.3069690-2-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250313034524.3069690-2-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 13/3/25 04:44, Richard Henderson wrote:
> CONFIG_USER_ONLY == !CONFIG_SYSTEM_ONLY.
> Therefore it's cleaner to just add to user_ss.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   accel/tcg/meson.build | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


