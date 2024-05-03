Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3277C4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 12:55:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2sR3-0002qb-DZ; Fri, 03 May 2024 08:54:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2sR1-0002of-MF
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:54:44 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2sQo-0006Ra-H8
 for qemu-devel@nongnu.org; Fri, 03 May 2024 08:54:42 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41ba1ba5592so50204045e9.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 05:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714740865; x=1715345665; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=qTrGKWfHdwUoDIhLTj4+dEcr+/0OGfFnRrF8zcB+0vQ=;
 b=JQ3XWPNMxL44DuLO+TBEY7n4oxBCMQh0qCcCMX5xLUn8ZC836ub/FTltk2gcVsbRB1
 7Ni4Cy/xUTq2MrkeUl6OKFKGPhcBytZuNAENa2v14ojyWMkMZWw0sqDodOM7K8Sa+SH7
 fGT/ES7k5ydrNiNKh5MuAtCnsMa+5qVrTrDubkhyYqp4bJ/dY00Ej+3lqTU/J9PQMBkQ
 jT/Ou+AIJQpwzmS5OBf3v5rAKeFjaaZwUM5RgR1FVR1/gLbxilqgDPgIPsZfUvh3F+IY
 RpgFuBwSAN6RtH5jZ/YNh4fWVPmTgtpFR7SEV5qNtdcUG6KISHFuAweCwfPhbet5Z54z
 KhcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714740865; x=1715345665;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qTrGKWfHdwUoDIhLTj4+dEcr+/0OGfFnRrF8zcB+0vQ=;
 b=B8F30F5w5SdBSDKQfW7DHcONIO4Inqh/+Becf2M3mGXUCkUwjy9zA21+VIwFqdAT6s
 C+PjfUeyh29Uh6QB2NIJ9rj1lc3jRaTZIBJGRHYOzIUQHN5rKeuCsLew5UoPMORYlv6T
 Vv8LC8ueyorucD5Cpbo3DxVHaZs/r/fXMVOALhxlv6kYkgZ0cVcnddp6+15cJMiZxy6D
 m8u5snK91wcPfnj4joLg8jPXhQt5FZyflzt48HvyXBZzNVbl3L5IKYDhWKx9wsVjZYe2
 g2O3ed3gdoMVMRqbL++q+9sE06MsdBkajyxtvqmyB09U9Aa36PxHLtKGzNYJpXZI1kim
 tERg==
X-Gm-Message-State: AOJu0YxGCxb8wfvK9Xtn8Dh3CitrWy3OaoRnnpO+icLd+MgxWAcwhBn5
 r++yGncmVK6Wxg/D84pxzA8HuNdeAqYm7Q19MSRqGvmZoTShaRDOeSZA7+u1E2tof/7pzC6TDeU
 n
X-Google-Smtp-Source: AGHT+IGQLYWrGbyPpnbyTZdhgPkr2DrRwDG71DJ2r6Ua+xmEHUHM6PQZiRpsmk1Ujc3kYffVNrw+Vg==
X-Received: by 2002:a05:600c:a01:b0:417:caa8:c3f4 with SMTP id
 z1-20020a05600c0a0100b00417caa8c3f4mr2544098wmp.34.1714740865531; 
 Fri, 03 May 2024 05:54:25 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 n20-20020a05600c501400b0041aa79f27a0sm5553086wmr.38.2024.05.03.05.54.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 05:54:25 -0700 (PDT)
Message-ID: <f26bb21c-77e7-4366-ae34-062283478a63@linaro.org>
Date: Fri, 3 May 2024 14:54:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/4] target/sh4: Fix ADDV/SUBV opcodes
To: qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Paul Cercueil <paul@crapouillou.net>
References: <20240430163125.77430-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240430163125.77430-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 30/4/24 18:31, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (4):
>    target/sh4: Fix ADDV opcode
>    target/sh4: Fix SUBV opcode
>    target/sh4: Rename TCGv variables as manual for ADDV opcode
>    target/sh4: Rename TCGv variables as manual for SUBV opcode

Series queued, thanks.


