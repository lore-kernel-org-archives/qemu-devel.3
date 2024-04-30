Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 501A5C19F4F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 15:42:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1pcN-0007kq-5B; Tue, 30 Apr 2024 11:42:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1pcL-0007kO-LS
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 11:42:05 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s1pcK-0007KN-4Y
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 11:42:05 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6ecff9df447so5684160b3a.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 08:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714491722; x=1715096522; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HXVUppUJ1XfLFlgtoVwHT8Re+xyd7c0GcwZJAO6EHho=;
 b=tjz4UMF6V2J/SsLwXVfOCadbRG6p3f/DEqRRylYmCZNFd2neEK3WCiFWVhiwROLOm6
 a9YdnxAG8jCnByBc21bXq+OePnTYs+cT2m8S+KMQoFDvNqZKYIQ7n2FDs3Io6dKWl7Sn
 rhN/oI1e4zTqH214c746mbErPf8khnPkO8t2smqjJMeP0ohiObs7ab/4iIIeTcAWxtMS
 nnvKmBmqH2Cr+L72YVkoOpPqhj3s/SGlOU+sI0s1koDRozu2DhAvZUdU4fBT6Yrz6rK3
 v+6+Q9r7LabeKnTGUvBfqT2HeUnCJhhjIm7GQoiXjk54frqRH/dE8I3IN8jqsYjn3kuw
 t4Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714491722; x=1715096522;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HXVUppUJ1XfLFlgtoVwHT8Re+xyd7c0GcwZJAO6EHho=;
 b=QGCWzWfnMbKKvjhuBQyWXkgHO4nhP1ZJGFN2a/GRRoAGs5n1UBD2wZW+gSxlncfqx9
 8IkeEzKmtEElapkpWgwnc0FnbflQSyqerzz6ubpGrdbZIbgUjMit0dvhHKuHBJD+2jGY
 6YLetA/V66ezUiTgM0uET3ViZcpmGJiZQ9URYLQRkruif60udoaUJWFYWjtOTNzGEE3G
 zOTF2A5nRaZ+aU2hbaVoLGkUvLNgEeeNnb1UF9LuA4JV0on9BDL0vGb5gt23tsTO4ht7
 xaQqvTVJolJwdQXSUhsV+1BNc/qfeM1W7Em14xVeFYl7B7uRaDVpY07BAs6X0Ejep8Kl
 Mixg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXyrwk3k+F3FH7+9pOweZIAeCKpA90EE/UJ/R9z9nEsEoxpJ+qDUevjJFXOGPPumpZZHQM/NMgBxwz4w/CHKJBvtJDUyAg=
X-Gm-Message-State: AOJu0Yy2jJy7KVIf9roEJ5ro2uoctaEswmrfeMnMCtG7RQTPSQ6/1JXW
 03Q+ubPiZBulcAL4WwDW/IrOZPHo00tkMOS5VONI0WOGUFznMZ33P7WRRuNH25Sjaz1imppLhm+
 2
X-Google-Smtp-Source: AGHT+IGLtJrGp/EjcivzBUl0cLo9DYp18Qo2YaRfajYriK3sa9s5Z/U6msiZ6dSRJX1Az6LR2bGdjw==
X-Received: by 2002:a05:6a00:1893:b0:6ea:afcb:1b4a with SMTP id
 x19-20020a056a00189300b006eaafcb1b4amr27649pfh.8.1714491722557; 
 Tue, 30 Apr 2024 08:42:02 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 p39-20020a056a000a2700b006f3ea8a57edsm6465612pfh.133.2024.04.30.08.42.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 08:42:02 -0700 (PDT)
Message-ID: <ceefb5e2-1809-44d6-b98f-02ccf6aa45de@linaro.org>
Date: Tue, 30 Apr 2024 08:42:00 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/4] target/sh4: Fix ADDV/SUBV opcodes
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>,
 Paul Cercueil <paul@crapouillou.net>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
References: <20240430145614.76475-1-philmd@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240430145614.76475-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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

On 4/30/24 07:56, Philippe Mathieu-Daudé wrote:
> Philippe Mathieu-Daudé (4):
>    target/sh4: Fix ADDV opcode
>    target/sh4: Fix SUBV opcode
>    target/sh4: Rename TCGv variables as manual for ADDV opcode
>    target/sh4: Rename TCGv variables as manual for SUBV opcode

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

