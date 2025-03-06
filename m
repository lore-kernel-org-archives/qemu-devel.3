Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 322C5C282D1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 22:10:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqJPa-0000iP-Qk; Thu, 06 Mar 2025 17:09:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqJPY-0000iH-P3
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 17:09:48 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tqJPX-0005QU-0c
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 17:09:48 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-223cc017ef5so24434325ad.0
 for <qemu-devel@nongnu.org>; Thu, 06 Mar 2025 14:09:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741298985; x=1741903785; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=197N/sLLhaFlD6ueIYkgzFwKq+QiA+TqVrks6EWNrp4=;
 b=lA8KeFTLx4NzXaYd+1Bsh7QsvRSJrsHvHxdruC3R4/IXCZtEFICTK9qp3HBiCiQWFg
 VJkMS5L8jOlqHXZHl8lgvW/SsGm7/83c/zTuT/6lAIZiqY3k5RSmJddL/5jRpaVKwXBS
 7KhN6VbydH0P1P1dJx9norvJjQUMXZajI+GOC2/UGZyHA9zxKGWGNGS7/xAYWpKq2AN/
 Y0Otgzo62pbndrHlCjX10OITKMaDFybjB0uJ3ekVVXyfbCGjgh5XC65C0NLtRpyo/EtG
 FIaK2DajqDehnWaSifMbuVkR2zf6JLHB9DNYtm62AFkXQLAZLnHTVGWoXpaz4hPkYr1p
 DE0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741298985; x=1741903785;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=197N/sLLhaFlD6ueIYkgzFwKq+QiA+TqVrks6EWNrp4=;
 b=pSXVT7NQq2B0OtNT1JNHPtO78/lg9CjXYEI3skCtrSxYpqJe8tzlE+NELPXPNegnj4
 KqO7ELz8zHKGYO5lmmfUhaRybP30ndH9tQNaK5593ClNKpMemY6qmUvtm+6Xf8ohgCO8
 RpBvPCxrXwfr4huwhec8q7sYhCR1K1yy+fW1FxBHPS/D8T9/xxOuG2QyTuIhOdB7E0jR
 E0BIqzMZAdAyWe86QKTjCEDsNFCmhANTkcVmBSB2QtsZRGFyOiuis3wW69AN/DSz9XJE
 d/eRhcOQmGWAZWe/G4nZ6AAW112EfZXDla2VPC0UH78CfwmuL+6dFU+vxnDL71xWyvdD
 V5/Q==
X-Gm-Message-State: AOJu0YygBKzFKUwWIjLG+Le8AwdeymhfeKo6AEOiBUxQWXdHiXt/96ym
 xGvEmhL+BHi2FSCpmcod5dEzxAv2ypON3PsPhmU6eN/38ibU38Y4ubjCrlI4L9LFTyF9J4kRsPI
 m
X-Gm-Gg: ASbGncvBVu7w/ks8uPbom+HzHpHBlBSNiRZ7HQuo0HPWkrtfgMLGR9uuUcAtr4e9oMu
 oe5oQIMdc/Y6dFtllMU+XiOjW7VXRiizn7QNbv5zMwpwTgC/LHRhjE28YwIXfDe2Gfz0FL+/eRF
 jjCLnYLnIAcfTIhtQAOGdT/zk1oivqInRkoTg5x5Qr3tocCoG8vpKqI0XTNOrE38MKQMsPIC5BC
 0GCuUNn4wu3VV8Nmw6IQl63DKSHh3VR9F3KQwNWfmCXPtLQSQhsdcKm9XckuZh6hWcDs7S3HfK+
 EQGLjvDExPWvSi1wU0nC6PYz9C7lnwOMSnZLv4HSkLB3spuWoSF2rqjBaB/kajywka7JE3CiYRu
 4xNr2Yk4k
X-Google-Smtp-Source: AGHT+IF/BU7BZZeJ/aErC83E+VUqPGSKTLVBAxMNa2nju7snGHvoIUI1bTWj+qFaJDO4gDULtLQB+g==
X-Received: by 2002:a17:902:e5d2:b0:223:3b76:4e22 with SMTP id
 d9443c01a7336-22428886738mr13018785ad.6.1741298984914; 
 Thu, 06 Mar 2025 14:09:44 -0800 (PST)
Received: from [192.168.0.4] (174-21-74-48.tukw.qwest.net. [174.21.74.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-224109e974fsm17585855ad.78.2025.03.06.14.09.44
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 06 Mar 2025 14:09:44 -0800 (PST)
Message-ID: <d886ab14-fbd4-4414-8519-fdb1a718c703@linaro.org>
Date: Thu, 6 Mar 2025 14:09:43 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] linux-user/aarch64: Remove unused get/put_user
 macros
To: qemu-devel@nongnu.org
References: <20250306163925.2940297-1-peter.maydell@linaro.org>
 <20250306163925.2940297-4-peter.maydell@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250306163925.2940297-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 3/6/25 08:39, Peter Maydell wrote:
> At the top of linux-user/aarch64/cpu_loop.c we define a set of
> macros for reading and writing data and code words, but we never
> use these macros. Delete them.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
>   linux-user/aarch64/cpu_loop.c | 48 -----------------------------------
>   1 file changed, 48 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

