Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6873BC25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 20:05:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sG2J9-0001jl-MB; Sat, 08 Jun 2024 16:05:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG2J6-0001jP-OZ
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 16:04:57 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG2J4-0003HC-8v
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 16:04:55 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2c2c74d9be0so1161275a91.1
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 13:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717877093; x=1718481893; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=7bX91NzUOn/N4kqWFwV6vhuDmim2lwkt+H0RL0Hjd+8=;
 b=BFab4FUNSZ/keFYneVpGCsNI7fA3ZyLOBLo2dQ13PKbhIZ3lsSUvWf3Y5Nffnudhu4
 V0E90gZUKOn06SjunyzKAm4WhjEf+il+pJsm/x8PFFMhslMktjeqvJSf3CsD/Ls4VBGT
 8T3MAcODtABUrj11iIcEX9yDtfsvxofCXYpg4IZXYlGt/NkAP+aMd5hymA5wsn150IdG
 J8L3KsZqpAWREzNegVoQi5rpjk6d+TebEb+s220zMzR5YruscoyS453csGgeJRoQ99A6
 xkRtCpOVoG2U2hQP1pQOVzvMMhZACrODyeWc7HHXD/1fQCPjq2JE5+EQABOMLsoMKI1P
 xqrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717877093; x=1718481893;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7bX91NzUOn/N4kqWFwV6vhuDmim2lwkt+H0RL0Hjd+8=;
 b=GFH4Ty/hNxJz6juvSRqbcELH6avcV9I/npyGoSnAM5KovxAL6gBmFD3s2r6pqvb/89
 ddIghmLTnwfS1U9yJKzlrP4qcnXFYmBnhgucO7CY6gox3VePKoFhRDqG5WUxlLZ/K37m
 RDwakEdb1U12KivyAHROxDxLmmP5ORTzTz4VrDvK/WwSPl11zoXOLYkbo3sRKCl8QbJr
 Iv1HHF4aslskvQETMjAr8wX2zULuevXwKa1Lq9MGkYQA7V9zfHN0tArceZx6XYUq81j0
 nTqCFRAyVidf2WX3ke+13gHfvp3KC7QjFPqFZv3VG0KWcdOlU/olAcWJnbu908xcHRXa
 N01Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXwLZfLGq+RSW3PxbaD8UYba0VvtYM4aAw1jD+4JNkWT0UAOPyN+BJswtR7GHHw5EKPCw8UdjqCBkbhV5yMjZ62O3Stjo=
X-Gm-Message-State: AOJu0Yxt2WSH9esf/WRDvvAG/4+hwXmlLcRFvJ4fU9q/unFMZ04W1ULw
 vfIhEQ//ZXeLJl/algwGF7GUNWRA4PAgaxuq4e55r2bkSsYsnGIwqFHMtFwdi0WkZE8VxzCwwjP
 b
X-Google-Smtp-Source: AGHT+IGqRnRJa9DZ53lmDyDH/PBlYf2gQGBUJgdoAoRfxQKuN5ZX2ZpvXjJk1rLtxF1oEN6vrvMGlg==
X-Received: by 2002:a17:90a:e0f:b0:2c1:5e90:1f8c with SMTP id
 98e67ed59e1d1-2c2bcac2cf3mr5434007a91.1.1717877092664; 
 Sat, 08 Jun 2024 13:04:52 -0700 (PDT)
Received: from [192.168.64.11] ([50.78.183.178])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-6de2008485esm3838869a12.8.2024.06.08.13.04.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Jun 2024 13:04:52 -0700 (PDT)
Message-ID: <bafe5a6b-a0e8-4292-af54-1becc529e858@linaro.org>
Date: Sat, 8 Jun 2024 13:04:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 20/25] target/i386: convert CMPXCHG to new decoder
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240608084113.2770363-1-pbonzini@redhat.com>
 <20240608084113.2770363-21-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240608084113.2770363-21-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1036.google.com
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

On 6/8/24 01:41, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c      | 79 --------------------------------
>   target/i386/tcg/decode-new.c.inc |  3 +-
>   target/i386/tcg/emit.c.inc       | 51 +++++++++++++++++++++
>   3 files changed, 53 insertions(+), 80 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

