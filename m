Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9ECF4C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 13:20:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZsCf-0007ov-V8; Fri, 02 Aug 2024 09:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZsCe-0007oQ-HH
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:20:16 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sZsCc-0002TJ-VR
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 09:20:16 -0400
Received: by mail-pg1-x530.google.com with SMTP id
 41be03b00d2f7-7b396521ff6so3100530a12.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 06:20:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722604813; x=1723209613; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3fNA8hdVpqFkzAAVruxdEaQCr69Ceo77k/Rmj72x5IQ=;
 b=H8yFoxfdv5T1FQjihoZgiTcbCFcnAGkMsEKUuPp/diBhWIgZvluvCdJA3HUa2ddanD
 PMnK5loMzINxfY2JpA1p6W68G87DqXOhRpRK4I4D8oY5xYVdGJyL5l6Y0fk/PX2o+GDd
 bDCZg8JxuieEiCZdgvi+srvB4bEzl7VcTl3RJ4rKK6F2HeeAk/swEJcMeZ9MR98pfQFX
 4kKSyqHFI73lhsuIHN9K9o0+UVXvNXinFWCUZbfegA6T74AaHeEC66HP+9Runzv2btNJ
 +v/Jg8b2q1Qilu1JjduHQQJ+bAtusysWwCG0NBHKdF4hpcKJZJgVRULB41SuYyFarlx2
 Bu0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722604813; x=1723209613;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3fNA8hdVpqFkzAAVruxdEaQCr69Ceo77k/Rmj72x5IQ=;
 b=wHKqF7ddKD85gRvsSpeKj1njQxwwvf7mxjWGM7bJeUO8FtQ/Nj9/LEebl605zPREi1
 rY5YsmCXCFNw2nC8drS3I8aw3iFCNQn+vyvHJeaoVi5Xa/RhXlu3sCrDg3fudTbU371+
 ++8mSkHsIMF4NBXwswESi4YVVHql0IKnX3iTiu0IfQULkUVd/S6IVfpu3jFo9y/I8T8Q
 txxJ5M8yzwWGf1nlHSxoAjWwdnIJrLh1gpHQRHeFK6SuQa5NLjAnbscJzgqPW9Zv247I
 Yecjr2/TZemSSX8ueyF8OL5T9oBfVviCEh31hGRhNL+ApdW/OYIrWTLnRWJYiywU/Nni
 /wcA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUp2XaAbSsaF6Y1rx+hoPMazLA7DhHcTUZLv8wfhUQvAWZUvt/xPsk1sGT+3jQ5UUIFGIi289yYO8qBtGYSbTfc/8wuj4Y=
X-Gm-Message-State: AOJu0YxCIbOCkp7y84I8du6HT+TGO5+DoD7TTd/6cQJw1QHcMOjteUzK
 MDmdFt9laRF53eZsk2CMaP1tLJVLhuLi0zuZk0q882fXd61yGJ1MUuz4bGmWE8k=
X-Google-Smtp-Source: AGHT+IH12jgMWH7HJFxZEfFkcL4A1pK72aYlUQEH/d28WS5WM5nUHVpG8LRmOEeBMMawClLcRRWyag==
X-Received: by 2002:a17:90b:4c4a:b0:2cf:fcce:5a15 with SMTP id
 98e67ed59e1d1-2cffcce5bcdmr3189198a91.28.1722604813084; 
 Fri, 02 Aug 2024 06:20:13 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cfdc42fa36sm5156616a91.15.2024.08.02.06.20.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 06:20:12 -0700 (PDT)
Message-ID: <fe7e06e9-c10c-406d-b793-248dc80834df@linaro.org>
Date: Fri, 2 Aug 2024 23:20:06 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/18] bsd-user: Define RISC-V register structures and
 register copying
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Mark Corbin <mark.corbin@embecsom.com>,
 Ajeet Singh <itachis@FreeBSD.org>
References: <20240802083423.142365-1-itachis@FreeBSD.org>
 <20240802083423.142365-8-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802083423.142365-8-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::530;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x530.google.com
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

On 8/2/24 18:34, Ajeet Singh wrote:
> From: Mark Corbin<mark.corbin@embecsom.com>
> 
> Added definitions for RISC-V register structures, including
> general-purpose registers and floating-point registers, in
> 'target_arch_reg.h'. Implemented the 'target_copy_regs' function to
> copy register values from the CPU state to the target register
> structure, ensuring proper endianness handling using 'tswapreg'.
> 
> Signed-off-by: Mark Corbin<mark.corbin@embecsom.com>
> Signed-off-by: Ajeet Singh<itachis@FreeBSD.org>
> ---
>   bsd-user/riscv/target_arch_reg.h | 88 ++++++++++++++++++++++++++++++++
>   1 file changed, 88 insertions(+)
>   create mode 100644 bsd-user/riscv/target_arch_reg.h

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

