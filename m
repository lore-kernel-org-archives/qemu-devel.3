Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECC8FC25B75
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2024 15:28:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFF1V-0006wK-Rw; Thu, 06 Jun 2024 11:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sFF1U-0006vi-0Z
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 11:27:28 -0400
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sFF1Q-0003ZA-M6
 for qemu-devel@nongnu.org; Thu, 06 Jun 2024 11:27:27 -0400
Received: by mail-pl1-x62e.google.com with SMTP id
 d9443c01a7336-1f62217f806so10561215ad.2
 for <qemu-devel@nongnu.org>; Thu, 06 Jun 2024 08:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717687643; x=1718292443; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rcG+GDfI871rFuQQXWeGiLcgcXMAxj0O72vRF9zuv7I=;
 b=yXJyyXuGnAyBMKDVR3OYo/Ab0iAHFtISTVKsDHDKZv1nPL/BDMo4q672vgDpWYktZS
 w5eHNB3jBAhoGI/AEFcmHcBr80ijSpbc0SHHpPGRi3VgMZLwuMlzSxvC7NantAr6xEvL
 2z3KKmsTpYMRDhuvNgl03wUmj/IFR534jx87e1Wwu2KyE42sKaN6wBRdBcAbXuEyuoaV
 89LuWrMd1fqqL+DXt7akXT/2IeQnPmXq0f1TsNH0aQ10afA0+bTx5hx7dRQg8V7D/KTe
 ImyNnzaEZA5YHaBT8IuBobIvhGX9CF9cPtf0e1VrwovcHBv+XoII3Q9cLiHWCD9QSw6N
 auzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717687643; x=1718292443;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rcG+GDfI871rFuQQXWeGiLcgcXMAxj0O72vRF9zuv7I=;
 b=W+ZGN+ryDn4kOjBOjnCAFMZwiBcjqihKBgtzvfFSC2XfK6JqUWe02IoXkvR+o2XGSx
 kSMCn63MbDUdSmhli8xWm7hsdv57ZDWHi8/YoRkrTLJr+uLnxX/LZdqLN2Kvm3q/R2sO
 uQ7X2oa159ppCPO/BsRgB8A+WbI+Ixtu8+qbpMVbchQVqFVFz9DDq8uabLVgIHrCso5G
 /BksAiufb76ng95+0t1TqEhikaODMeUSWACIS0z8socRH2XtA+We8ZPElQZtB9Dt2NaX
 Hzt+vCvBQplJPP3hMRZPVKg8fQMpmqYCzIO/Yfq0Q/UxR3nV6WCyOqz4K8bBMIvxYEVt
 W04Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCV3C3LftNlvIGmkyMKtFqDDv/oTA09R0uClfewKuVU8Vpelx5CxUEzay6KYnpmOlWE0nNxpHQ7y7tgANRsfyAWV8zMx7fM=
X-Gm-Message-State: AOJu0YweZ94pd6Cpguf22PDy8iU7bVpfnJ/GzcbO6r6c3zif0LG7apGm
 i0ijO7QlZheUwgVyiwZ28tIlkpC3f/NgYSTk4YqZ6hyeR3F1cLkBXBsB+N3A8WM=
X-Google-Smtp-Source: AGHT+IFoIsKgNiw3JzRBRUdI2wxsFWoKqlmC4vKMWDRLQtEMjxKNnVO+JuKQo6qzkZa1JVy9aEpkHg==
X-Received: by 2002:a17:903:32cc:b0:1f6:324e:4def with SMTP id
 d9443c01a7336-1f6a5a699e8mr70015655ad.50.1717687642690; 
 Thu, 06 Jun 2024 08:27:22 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6bd761ac8sm16441655ad.54.2024.06.06.08.27.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Jun 2024 08:27:22 -0700 (PDT)
Message-ID: <de594fa3-eed1-4e96-a479-19621b89b392@linaro.org>
Date: Thu, 6 Jun 2024 08:27:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/9] target/i386: Split out gdb-internal.h
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, alex.bennee@linaro.org
References: <20240606032926.83599-1-richard.henderson@linaro.org>
 <20240606032926.83599-6-richard.henderson@linaro.org>
 <11ab799d-2670-4a2c-884e-688589845e83@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <11ab799d-2670-4a2c-884e-688589845e83@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62e.google.com
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

On 6/5/24 23:51, Philippe Mathieu-Daudé wrote:
> Shouldn't we remove the definitions from the source to
> complete the "split"?

Gah, I thought I had done that.


r~

