Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B14C25B76
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2024 18:25:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sG0jx-0002V7-G8; Sat, 08 Jun 2024 14:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG0jw-0002Ux-Jx
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 14:24:32 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sG0jv-0004Kf-41
 for qemu-devel@nongnu.org; Sat, 08 Jun 2024 14:24:32 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1f44b594deeso25946065ad.2
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2024 11:24:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717871069; x=1718475869; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Zrlyg3NXecdp+Q2qJwjQpdyZPKt8ZrKqoSB0FVkLojU=;
 b=DOJtizwn1dqb20gQLGYdZMODmq9Wfk8NkV2A1wKoTdAPpzc6TnEN5SnYso+Sbv8j2U
 9YZv7NRpojaPHr6C1bq/+l/dGQIUZ3qON4nWBAqy1OkZN57ieqyuGN/ecK499RlzMM8S
 hsEr7aaoJbFnd5P7lc2pLYgBGiFxdPtPXUWWP4aZBD3h1NtyDEZSkK0xis422owqwU6D
 LqealOx0ADcujU9Z3rJmhg8oax/5v3YPLEd81U0U6+N/S/f57t6/w0G4w1jgk/R1TDl3
 e2AnJProlRiStXVlEvx6Z6H8mQT2+qTqEQB74ewxscZaVLglU1c3X64ja1PtfX6Qu9HH
 O9hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717871069; x=1718475869;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Zrlyg3NXecdp+Q2qJwjQpdyZPKt8ZrKqoSB0FVkLojU=;
 b=j4NEBhmbpIlXBjfmqwj3VCzupVVF2lpruTzZZb9yvw5EQavbeVGHOM7vWcJplYn5OI
 9pMhucg0uYjEy/VjgDxFH0rB4P+CLWJD7w3bSQDPHFIV1AJ83PLaAZIqo3RPNuZ7B2uq
 aRH/NCWKw9ufDa1S8UHYIVATH1ilMKHBxArNT8ljT/gvpO3CxieRP5G6cuno2dkFFSi6
 OP4P0CgConqez5qRU9addxZJW2mh7NaWUTILacn61KJPawXb76zXWCDMVP1xxwJwKvjD
 0fFJnghs8dtxCl/DetSc+zFzrkw+iityk0to733T1wrLZtHncniCiplsxqBusvMMFZcE
 5abg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUudWXVjF7KSceg/FYaYNeGwhnsqOIpes4yOKNfIJP8eab9QpEf/dHBVLkxdCrbI5PhZY5iaojyNSnnpCygnkryg/IJtQ0=
X-Gm-Message-State: AOJu0Yxon46VDxmI0XT59HvRkKwzaIP/obsd02ONv15qd+j9SL7OGWPr
 YorIkfYhMx8z//R8Hxxy3naDBAATdYCJVz/To++ux3odzv71NQjwziVvSlwUL5o=
X-Google-Smtp-Source: AGHT+IETDuD4nqXqa2nEKTAVUjtoH4lIkHxjwTH0+W86tSrDlKcHJ0WNdD146m/VLS6f2utelziUkg==
X-Received: by 2002:a17:902:ec83:b0:1f6:2795:b236 with SMTP id
 d9443c01a7336-1f6d02dd8d6mr67116895ad.24.1717871069089; 
 Sat, 08 Jun 2024 11:24:29 -0700 (PDT)
Received: from [192.168.64.11] ([50.78.183.178])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f6bd7e3e71sm54694555ad.219.2024.06.08.11.24.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Jun 2024 11:24:28 -0700 (PDT)
Message-ID: <0f417e46-d958-4529-8dab-227c8860be2b@linaro.org>
Date: Sat, 8 Jun 2024 11:24:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/25] target/i386: convert MOV from/to CR and DR to new
 decoder
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240608084113.2770363-1-pbonzini@redhat.com>
 <20240608084113.2770363-9-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240608084113.2770363-9-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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
> Complete implementation of C and D operand types, then the operations
> are just MOVs.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c      | 79 --------------------------------
>   target/i386/tcg/decode-new.c.inc | 53 +++++++++++++++++++--
>   target/i386/tcg/emit.c.inc       | 20 +++++++-
>   3 files changed, 68 insertions(+), 84 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

