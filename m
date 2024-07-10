Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50106C3DA42
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 15:58:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRZiP-0003JT-8x; Wed, 10 Jul 2024 11:58:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRZiN-0003E4-P1
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 11:58:43 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRZiL-0006BB-TR
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 11:58:43 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-1fb4a807708so54082385ad.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 08:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720627120; x=1721231920; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NO3DNEzo+C1W0pGnNCFkOXgP2djR4jBCFSiXh+e2TH8=;
 b=iPbRdSRlDfqlCCZVuBthGbYRmJdygDoHm6XYMpZyc6JFdcbuCdmkBCHBze1ebJljBr
 JaYGx/u4CSpLLvZtsyF3+9PP2GHQ7aR378O/EfNCfD4kNBMC9V945+ZSjvfo866ZvdmV
 dyxcosgguPYCX35WZpQpdpFzP7DbEgHrtDWhOmAp+UFvb+3Pv8fz9U6xzLR7O1wDrPWR
 62bjTzX2n7xx8E4pEaiomRTlQVqJOKGAsRcddYw8YV5oo+YBpBmM+POx7Y+BBlhflba6
 4Ej15cGSI9sfGpcONsVc16+RRlJBAS3cpDZbHDMsSePZ9XHFrYhv5gn97P8JkwcXGUT+
 0jtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720627120; x=1721231920;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=NO3DNEzo+C1W0pGnNCFkOXgP2djR4jBCFSiXh+e2TH8=;
 b=qiCHWumJ+bUx027oH5GzZ8ncXnbKcTBB10jLHgR141IQ8yjWpv4l2fjjw+VWNlUlJQ
 d41gZ8VeSUiKDAKNwQaxb/Mi2cwSx3fc8Y03QZQFdYxp8eo9TzBYSJ7SJEc0QZjpLQ/X
 fHlDK65u60+9tezyuZV9rIehbcV55xCGzQ5ME3+m9U75zs920QzzZJy++2NNkOS3PZKj
 z3SpIANO4ps96OFSAu+k8DF518udq3I3cnUHkEB4w7x1fi9Q0QfzoSpBg/yL44TBbpf3
 bDnnwhZazjr3svB93haRMg0CCjYUDrHvFL/y8o7PRICu/TaIlM+VIGRUbPYsDnhP4egy
 hwEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9oyQxtGcLXrjnVU+gdSyjJRdEToT6/Wqzl4eOkN6V5P5Af360js1pR5xMXfdxwz0EQCqdEon3+zly4PW7eyNuESefUrs=
X-Gm-Message-State: AOJu0YzsO9bCzXaDHpFR8UWuwT0KjXvpTlyLRx7aSk5vgO7FHi+Yy6di
 zXVyfMNWFYjZcxNFJitSv9jGjmZaoGx4Q1YoK80lvbxT6R6f9CWfaLFXJufj0mg=
X-Google-Smtp-Source: AGHT+IFdvq4wKGFVVI28YrGNZJmV1+gn9l0KWPwoDrQz+5oZVXbWDiCQulpZdtb1TOW/MkTdci6hvw==
X-Received: by 2002:a17:902:d50e:b0:1fb:38c0:173d with SMTP id
 d9443c01a7336-1fbb6d5aac7mr54086205ad.39.1720627120158; 
 Wed, 10 Jul 2024 08:58:40 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6a12ccfsm35574495ad.47.2024.07.10.08.58.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jul 2024 08:58:39 -0700 (PDT)
Message-ID: <92cc0754-4256-4f8d-aeae-3df7b3cc9c8a@linaro.org>
Date: Wed, 10 Jul 2024 08:58:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] target/i386/tcg: check for correct busy state
 before switching to a new task
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: rrh.henry@gmail.com
References: <20240710062920.73063-1-pbonzini@redhat.com>
 <20240710062920.73063-9-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240710062920.73063-9-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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

On 7/9/24 23:29, Paolo Bonzini wrote:
> This step is listed in the Intel manual: "Checks that the new task is available
> (call, jump, exception, or interrupt) or busy (IRET return)".
> 
> The AMD manual lists the same operation under the "Preventing recursion"
> paragraph of "12.3.4 Nesting Tasks", though it is not clear if the processor
> checks the busy bit in the IRET case.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/seg_helper.c | 5 +++++
>   1 file changed, 5 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r!

