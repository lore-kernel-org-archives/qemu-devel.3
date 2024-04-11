Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13ABFC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 19:43:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rv0JP-0005nS-Vc; Thu, 11 Apr 2024 15:42:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv0JD-0005fn-Op
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 15:42:09 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rv0JB-0002YN-1B
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 15:42:07 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1e36b7e7dd2so2063095ad.1
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 12:42:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712864523; x=1713469323; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=AWHpk2kciW6Yn6UO7nRjO/nw0NOEfCY/14936J671PE=;
 b=sURWW42R+D7DBheT64ztgrLB2OEo2TejKZeLJT8wkXRi2jdJAnqGwCPT9vTLFh3erN
 b4Rk72KRBSk9mf8kJNJrdjWqxKNiYDZkyNtTwsMeUuPxZ8h9tO1f6sf0uoLZ4N+keddm
 2xCRQSAa6EOZcoKHJI3aQWnkgbJlhspncC/krUjo12f+fHAr73oMkqBXka8irlDEW308
 kn9f1iqHg5Tp/yxZs2AYlE7xLH7AiNJBTJg2bumECftchirDvpwbRsQSZf42e/dP/d1g
 NybOI4ADmOHI80HZbdN0oCuDqz5Dkt94n3+e6RoI0MELXA9LPBLTPHIF4Camgzkjo6rF
 YRsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712864523; x=1713469323;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=AWHpk2kciW6Yn6UO7nRjO/nw0NOEfCY/14936J671PE=;
 b=P5lL9BUo5olvhEckDrod8YSuGLKtYiyEVxWfXblkpa+wfSDb9STQuJujKTP8NyMlyQ
 dLkAB3EhPkL0YTe8t4H9recpoard0gCqAkeTIPl0Orvy6bohw4NiEsZhgS+TUyCOM7e6
 4t8yF9VMvXlmP4kDEzgiREPwJ8qzI9Py1Ce66C3RmigVwTSr6BDA84bf2axDrC9U9iJg
 vMgxRo9A3J0Z0ooOIJ0oAj23PNFBnP3lff4FOAJ0yf8WCIR83oZ4mKBkjhydRH2Oh/vQ
 28zCzpsoYl7MeJvfX2w9rUc1YIJXcEnpAAUTyO6OGBxBkVJY9eSRKERLCg1zshLOEZ2c
 b/jw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXRM2t3eaq1lUwNRzdfuuDN4Q4cdyc0Lr8neyEB3g+ObIGMs2ytPKWHhzbQ4oaTjamK1MGmXZtJc7q9c3NnjsK5M9os3H0=
X-Gm-Message-State: AOJu0Yz13BX1eOlBHYSi4mhxNmwS4d73qX88FEFLvo/o5NYTObmok+AH
 QVq57MDkde/EkuF8nrRTNXP1kiyCrMFVk004Md0yIGqn0W1Iqk6nMHX3nefpJb4=
X-Google-Smtp-Source: AGHT+IEF8CQrczpZN3xrhjZh4Zbqnl8RgAevly4iHJpYvSiIfl+1w03Mu5XkdwB1xyWer8fSA0zEVg==
X-Received: by 2002:a17:902:d492:b0:1e0:f522:2cde with SMTP id
 c18-20020a170902d49200b001e0f5222cdemr525009plg.14.1712864523503; 
 Thu, 11 Apr 2024 12:42:03 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 im23-20020a170902bb1700b001e2936705b4sm1565198plb.243.2024.04.11.12.42.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 12:42:03 -0700 (PDT)
Message-ID: <c56a34d8-49e1-41d4-ab1d-f9b91cb01725@linaro.org>
Date: Thu, 11 Apr 2024 12:42:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 02/13] hw/vfio/pci: Replace sprintf() by snprintf()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <20240411101550.99392-1-philmd@linaro.org>
 <20240411101550.99392-3-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240411101550.99392-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/11/24 03:15, Philippe Mathieu-Daudé wrote:
> sprintf() is deprecated on Darwin since macOS 13.0 / XCode 14.1,
> resulting in painful developper experience. Use snprintf() instead.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/vfio/pci.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

