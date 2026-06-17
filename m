Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B4DACD98E2
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZrXV-0007xU-R4; Wed, 17 Jun 2026 10:46:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZrXL-0007uj-MA
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:46:40 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wZrXG-0005yz-JV
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:46:38 -0400
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-36d5b11201aso4031306a91.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 07:46:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1781707592; x=1782312392; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=s2xPCCVxQlLpectea6P3aODk94xrC0wK+E+4zwUjVvs=;
 b=sPVixIs0xUH3C/wy62u9xCJMIVy0zWJMuCo+PEXdDcCclWP0m90WUdWV3IluzjsUc8
 PckebEDE9KPMVXOxWHv/8yMlV0Fy7W/zDrAkL0FZgE1cqoyXWvLmX36zCO6v+88jnsOS
 KwgloLvVr4+1AzwVakv+wpV9edwICfZrTYMFbgCOgHk8VykyKXz3cjKehiDAurtUOUXv
 r/Ngz8oG8waRS3xqz7DijQzbG9KcjGvM6JkiWJNuCO56B0+V7MeTJ/KW8KRinzRG/8Jl
 yD1VT4PP847lO0fVfhseFZttQxqIx2m45Ory+fMZy+lXLpscYwQ6GzJDhy6bBZw+K98D
 L6LA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781707592; x=1782312392;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=s2xPCCVxQlLpectea6P3aODk94xrC0wK+E+4zwUjVvs=;
 b=ewCnl/k4Jixye0IP9IpEFbW6yXyH09K5difTMO81zgbYj8TaSB15pzNfGzkHbASZrX
 iEKM4pGGqEUZDgiFXAWYFGBunhjTmQoxEUr89nDXAntcN4NJATzR6FZkqzuCMKeGR98Y
 vFrxNBr5l0oUe3RlEf2pFnRLIzZ/W6xJZoBWpfGYOBkkfAEwUTOQLGc7ar5EteRPAv+N
 UyxDmsd1O2MMVTar0i28ZVRif4GzV2x60qNibRdZb3eUfXethCQO+OJdo7JunUEFOfM1
 6IB4soVZMvwQqaZPv4JJBskBlWKMDqqFIfxfFM6d21Ss0FP36u7kD8aYj0AMG1Cnr5QE
 SkYQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9QWHE9xWXtsIAH9nj4W8+oA0aZXKo9npBmqrBLay9QsxOk9pyNolt5BQPeyyQbcTXXV+wTg35biBgd@nongnu.org
X-Gm-Message-State: AOJu0Yzg8vfvGscNpgC97Zvi4nwfaz7lojVVaEq6cII5Z+gqhD7zhB8E
 BFhAzPtcvIjOJ+Ldi8sSvnvebcuCNc4yPZvDYTyMbUbZM0yG6s/nLG4EGWFcUAhaEyZ1QnQMny0
 2NglV
X-Gm-Gg: AfdE7clEF3TULVIaN+tcuqbphq2bAiV6ogO5dG2luJUh/8LmW7yKWE8/iUMd5Wy779L
 55Arji22JtCmBR5KxWRt5JkYt9zK/ZGyxsTpkwPgud64UJndTNARvhuAe9eVKmxmfMw9Xla7kxk
 vttS+5WSIqdEUmdfvg+Ojl3OonefvsebSWrsWz+IU/nmBPS2y3vK0k6tyIP6uQEmuB9weHTgncC
 2sOob9QM/Qt6K5GsdKCA0UkIujmNx3W2fC/VeX3jrR5jT3wPBMTQDp4LmELCl6QOeQ9mZc1eSI6
 yv7IG04Y9rPMwI7xAwO0hzRqBBQZ7mFtXJQ3ylIQgatP5VBcC6sx1F7zU4JIA/BpAClTc/B5yZo
 Nf5TdsrrnJVCGqMiTGzhpyrxj78FhiztLa832EaoNochu3wEaUg/gLPyx2rV+vlvriGXAGCSxA5
 DnAaUGmnMwD7V6TOdcOMkGYMPg5BCkq2boKnYHEyEPPM6uYTeKo0mbyHshvA==
X-Received: by 2002:a17:90b:1ccf:b0:368:341a:a925 with SMTP id
 98e67ed59e1d1-37c93d53bdfmr3835351a91.23.1781707591924; 
 Wed, 17 Jun 2026 07:46:31 -0700 (PDT)
Received: from [192.168.0.4] (174-21-129-215.tukw.qwest.net. [174.21.129.215])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-37c521ae78csm6300167a91.4.2026.06.17.07.46.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 17 Jun 2026 07:46:31 -0700 (PDT)
Message-ID: <d66a13f5-99a9-476e-ad67-86dcc909622f@linaro.org>
Date: Wed, 17 Jun 2026 07:46:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] target/arm: Restrict TCG specific headers
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>
References: <20260616191716.12932-1-philmd@oss.qualcomm.com>
 <20260616191716.12932-2-philmd@oss.qualcomm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260616191716.12932-2-philmd@oss.qualcomm.com>
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

On 6/16/26 12:17, Philippe Mathieu-Daudé wrote:
> Avoid including TCG-specific headers in non-TCG builds.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>   target/arm/internals.h | 4 +++-
>   target/arm/cpu-irq.c   | 3 ++-
>   2 files changed, 5 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

