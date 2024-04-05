Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E29BC67861
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Apr 2024 22:42:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rssFi-00052w-EK; Fri, 05 Apr 2024 18:41:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rssFg-00052j-UB
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 18:41:40 -0400
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rssFf-0008DN-Ct
 for qemu-devel@nongnu.org; Fri, 05 Apr 2024 18:41:40 -0400
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-2a2601f0562so2058336a91.0
 for <qemu-devel@nongnu.org>; Fri, 05 Apr 2024 15:41:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712356897; x=1712961697; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VEj0+jhOZvM1igH5jzuB/OXE5AyDdVkod07R+YXr5ac=;
 b=h4pmWnPdadeoHlO0a8nDnjTk2tx2qZeBgJJ9Xb/ZsIYNMtBFAl/ArpCgZ/YWbhavRe
 gUR9a++dhNqJ0rUInRggftCfcH0n7I75KbiXX4Kv3gANh9ApHaaHksIFgAba0fWjsb2F
 24ogI5XdP7t7W+lWVNhJmW9at8R3t+TTJ4Bq6KJhOqHFZmkca/4Uz6GKy3i7XF4G8hsW
 GdaQWh6I/wVY5zOSS15VcaVliXWajJaxKaQ1IUiL9num9w/fQhBj1JrJuTCTohoDsoDR
 IDfHyncDuIJHZPzl7WDH1vIxnhSHYsJxokNAOcL+GXmvObkTyqE7sbAaW8ZwIUX3xE2p
 +M+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712356897; x=1712961697;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VEj0+jhOZvM1igH5jzuB/OXE5AyDdVkod07R+YXr5ac=;
 b=EvL/qg4BtS9PpMJu4U65Id59bK2rQ1gK4x5JkzYSykslptnne/S7poBrFoB5Eg3UWu
 Ba/KuANtQEj+2NdujGLOkpR6ho8rKkkzsnO+X3T7XMz2uzR2fwQdZUj7mAut7RK+edDQ
 bWcwOyS/t6oy+jsjQAhXGja8edH4DNDaQpFMBT6t78Tfjfl/Zq57QgMsffhWwZj2A8Fp
 nXj+GFqI6Y2x6YIt7Mc/ZC4qkUvdTjYxh9RsJeGzcxt0FMbFOtrTFoRaauflW2TZUI41
 G4NEBaclq1QIgoJJifXRO6iLrCfvm8hf5/JiQIPTPmjBzA+eRBgjVq/z7hNS6KM/1HTJ
 tHww==
X-Forwarded-Encrypted: i=1;
 AJvYcCWRc8U/7aXJxV6JqEbBm+2Lu7LwMZjIAwIKOKPo44HYJwO4U3EGZiwZN6enfLfG4DUJXyuLnpaNcqJJqilTik+7HOZ0r64=
X-Gm-Message-State: AOJu0YxJEgGyDvcm9rhJL1MqUd1xd70K1gAGkfFN2oFJI2Bwcpry2DsT
 EoIrLR48TKARC86ZyWboC8zr4uX9henrjucynsWhQTrZsFv9F3cYLhWOfk6hXxQ=
X-Google-Smtp-Source: AGHT+IFLjU/G88/3are3x+FX21mgoQ0qZ+R4VDc0tvezQw2MbySOMhcO9z+fiXf1B9riCGmrXQSr8Q==
X-Received: by 2002:a17:90a:cc0a:b0:2a2:ad4a:691a with SMTP id
 b10-20020a17090acc0a00b002a2ad4a691amr2695120pju.22.1712356897481; 
 Fri, 05 Apr 2024 15:41:37 -0700 (PDT)
Received: from [172.20.1.19] (098-147-007-212.res.spectrum.com. [98.147.7.212])
 by smtp.gmail.com with ESMTPSA id
 nh12-20020a17090b364c00b0029c61521eb5sm3882161pjb.43.2024.04.05.15.41.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Apr 2024 15:41:37 -0700 (PDT)
Message-ID: <2208804d-1752-4278-9886-6e1fb0d80808@linaro.org>
Date: Fri, 5 Apr 2024 12:41:33 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] linux-user: Add FITRIM ioctl
To: Michael Vogt <michael.vogt@gmail.com>, qemu-devel@nongnu.org
Cc: Michael Vogt <mvogt@redhat.com>
References: <20240403092048.16023-2-michael.vogt@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240403092048.16023-2-michael.vogt@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1029;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1029.google.com
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

On 4/2/24 23:20, Michael Vogt wrote:
> From: Michael Vogt <mvogt@redhat.com>
> 
> Tiny patch to add the missing FITRIM ioctl.
> 
> Signed-off-by: Michael Vogt <mvogt@redhat.com>
> ---
>   linux-user/ioctls.h        | 3 +++
>   linux-user/syscall_defs.h  | 1 +
>   linux-user/syscall_types.h | 5 +++++
>   3 files changed, 9 insertions(+)

Thanks, queued.


r~

