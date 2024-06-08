Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 676A7C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 18:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sG0ZU-0006h1-SJ; Sat, 08 Jun 2024 14:13:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG0ZT-0006gg-NV
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 14:13:43 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG0ZS-0002yA-6n
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 14:13:43 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-702555eb23bso2582667b3a.1
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 11:13:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717870421; x=1718475221; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/13LeAeo2QsolB4ha8btlMf8enEspG13rwc1CPOeC0I=;
 b=TICddoHdSFrpov/Nsr33GRXTrgxcnbvmiRlHSaC2sDvOSaFtol38nS/mQISVPuGCR1
 1yYo0pEboFDsW0AOfhzBLAH+vgFmFfxBYwJsdChiu/sB3P9noJxKwlXC3Y/WLS2mv/as
 Qq2vXCe2BVsTrOA9kxu+8jpYFa97B1+nUq5oSwdyzDuukfoi3rOB+3khA/aqbsMqeSxX
 KGxdWH0WIsMxXbkwnKQz6Cyx8COOd014FEJL7b/TwMDl3O2Z4iSRWiCSI2LryVt13lsD
 WuSb3UkWyPDQby2aeeJHOeygW3lwM2fkE3OcQ9s/KUQRb8GwTTuXzI0osAt57LEVgQTG
 Uzgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717870421; x=1718475221;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/13LeAeo2QsolB4ha8btlMf8enEspG13rwc1CPOeC0I=;
 b=UIEgOypqsmd73OHObnhWXYGjgK83ZOxXdcYhZmCPczPLrjDLIh8SNjAl+SqQIv4NK7
 QiSYj/zOWGVQuQaYiMxDtUVSJQv5iAfwM9OcXEqqk1Lb9J+kIA1KRUwV4Bb8clXYExaf
 9sncjhSx9VvaERUFFGHoHXA2j1QhOVmuA8z3/jOPnE/yng9CFZECNT4a0ftWAYiY/yYN
 eSVUjGGRzfjqviJWNlGv/DoZQysLgy8GUXPb+lkHqxJqTE2N3A+Jv0sVr/wJekMy/hvh
 12zggu6i/gChTxHfiSclck42if6ocsoQijWb22gmbRl7Fac0MHjU+IKCVxjkjk2qZgl8
 pMng==
X-Forwarded-Encrypted: i=1;
 AJvYcCWll8aW054CXPUQiz541o0zebxbvyfAb9ODeGKtqHhRik9NBBPdkZ7M8JqkFiZAHHDHjWDiQL94QevxY50/ZXfjHJZb9eU=
X-Gm-Message-State: AOJu0YzheYNjxSF9s7cqJFvnPg5zEg/zmvDuRMKkR49pR92iSG+lENKR
 6P7Yhx6VYBUEm+QKYSCYHOJzRZwQqqzZNHy7yT4MoL33TVMTSZv9CeEj+YSV3INurK2Eql+8G45
 1
X-Google-Smtp-Source: AGHT+IGegNlXO2P09jbXfBd1koWZDdvARspbrVc60rIxJi2PiS5Zp443DDUq73rOIiYSjpH2gyvluQ==
X-Received: by 2002:a05:6a20:2588:b0:1b1:d402:a93d with SMTP id
 adf61e73a8af0-1b2f9a54ba7mr6401803637.19.1717870420694; 
 Sat, 08 Jun 2024 11:13:40 -0700 (PDT)
Received: from [192.168.64.11] ([50.78.183.178])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2c29c21e48bsm5726709a91.19.2024.06.08.11.13.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Jun 2024 11:13:40 -0700 (PDT)
Message-ID: <70716d93-192a-4acf-ada4-9905c2b6e04d@linaro.org>
Date: Sat, 8 Jun 2024 11:13:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/25] target/i386: change X86_ENTRYwr to use T0, use it
 for moves
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240608084113.2770363-1-pbonzini@redhat.com>
 <20240608084113.2770363-6-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240608084113.2770363-6-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 6/8/24 01:40, Paolo Bonzini wrote:
> Just like X86_ENTRYr, X86_ENTRYwr is easily changed to use only T0.
> In this case, the motivation is to use it for the MOV instruction
> family.  The case when you need to preserve the input value is the
> odd one, as it is used basically only for BLS* instructions.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.c.inc | 48 ++++++++++++++++----------------
>   target/i386/tcg/emit.c.inc       |  2 +-
>   2 files changed, 25 insertions(+), 25 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

