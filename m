Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16171C25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 14:37:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAW2J-0008UC-56; Fri, 24 May 2024 10:36:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAW2G-0008Tj-EX
 for qemu-devel@nongnu.org; Fri, 24 May 2024 10:36:44 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAW2E-0004iJ-UE
 for qemu-devel@nongnu.org; Fri, 24 May 2024 10:36:44 -0400
Received: by mail-pf1-x431.google.com with SMTP id
 d2e1a72fcca58-6f8e9555eabso867120b3a.1
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 07:36:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716561401; x=1717166201; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=powyWBBudBVY056ewWAOQUXFnuqlXpFSVxrNAEkTMoE=;
 b=M/Nzh0tFEPxLdF5NrrJ9AdbwtGlWVSDgM3+2xCd4se6F1EZF4n0/VjurekHqJLQEZu
 s0xP7OtUTsJSvJAeXW5QqtDwdGVhN7ld05mLS85RYJQVAyd7ebd3kwxTuup1fXzTmYmd
 VjPyAnTxAlvvbUz4bXMflbq7lntoE1LinkbL3g9cLmt5e4Kcv2siGQvWnHBWxk2cSOHq
 3BP+a4BR9bDfoj8AxHoHzZfiNIU0HCg1dBhb/ZbxMMBIeZr7N3EEqkOCEnjxHMuZnMmp
 Z0gGUYBHzvjDLHSOTfXWzCGkryMlUxCzNysI9LaliNS16+U7GM3y7wHZSdotL+kS69VA
 qrTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716561401; x=1717166201;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=powyWBBudBVY056ewWAOQUXFnuqlXpFSVxrNAEkTMoE=;
 b=ub4WNRicm05UCU2CwAIBbS/ptKhy00gktyf8TNtn6nR3D+moyAmuR9erWcVS4/kyRs
 Y4fexxWkM3Yd9ovXiZoj6u1BWrfk2t0gTEYvjhqYldY29dasOVRjH8u1oOCyvyKxNhUD
 wQ6yMNREOHspDXIDRCEcW2QF+eXVVlB4mIWVXHGzcXpJD3LsJzKkB7aIHtVThKhiFFII
 iNaXfrHUo6iKJejsbqRhGgvfS0uVU8pZ6A500Y8quunDwDgAquG7l6ZPOoxzYt5u/Vpg
 9ET9hkEgbr6Q49TuJbGX4WTSuRsx+8deWWZhmnMr+GJcOGbuSUAepfQVpBrjqRczpZGl
 sMwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXsSEXrmNLHkjXhQ3DsrsY0S01Of/CLNA5L1mTESmf0KCdPDK4pajoIq5nQcLGNbQ9/GL682a+FEWzGthAmW/AGcGngo0E=
X-Gm-Message-State: AOJu0Yx78lkuFzN5X9kImefLG+yzmIeZHlWrq7nKgE3ElOq6WxyX3SJL
 ym3bVomhJksEQB5rrenX9Y58Xurjdyjzv3NrO+6dO0qc1rgiLD6InC5CMirLd4w=
X-Google-Smtp-Source: AGHT+IG8MRRIIWQjqbxEZs9jmDoNKiik8DCa8rPcEhYHUachc87x63Y4otQ0xkm33LLLy+imN2LlNg==
X-Received: by 2002:a05:6a00:6c87:b0:6f8:bae3:37b4 with SMTP id
 d2e1a72fcca58-6f8f2c7041emr2627742b3a.5.1716561395622; 
 Fri, 24 May 2024 07:36:35 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-682229dc57dsm1062349a12.52.2024.05.24.07.36.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 07:36:35 -0700 (PDT)
Message-ID: <15be1cfc-816c-4df4-81aa-c18171c256d2@linaro.org>
Date: Fri, 24 May 2024 07:36:33 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/16] target/i386: use mo_stacksize more
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240524081019.1141359-1-pbonzini@redhat.com>
 <20240524081019.1141359-12-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240524081019.1141359-12-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 5/24/24 01:10, Paolo Bonzini wrote:
> Use mo_stacksize for all stack accesses, including when
> a 64-bit code segment is impossible and the code is
> therefore checking only for SS32(s).
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

