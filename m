Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE418C3DA7F
	for <qemu-devel@archiver.kernel.org>; Sun,  4 Aug 2024 21:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1saiph-0006Ic-GG; Sun, 04 Aug 2024 17:32:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saipb-0005uH-Be
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 17:32:01 -0400
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1saipZ-0001ol-Bn
 for qemu-devel@nongnu.org; Sun, 04 Aug 2024 17:31:58 -0400
Received: by mail-pg1-x534.google.com with SMTP id
 41be03b00d2f7-7a1be7b5d70so3633623a12.0
 for <qemu-devel@nongnu.org>; Sun, 04 Aug 2024 14:31:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722807116; x=1723411916; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ZU9VzSI2f7jEOQ8xfL60XLpm6G2xywpUBVql+uACQ9M=;
 b=LZUOLoT1orb+1sL8j4cVuPGugd/J3HYpTqtd1ag8rM97xLFxyhOSSL48592Of+XNnN
 vzQmdqhvUgRnQGAIbajDy+329Wjt2kVwyWK/7Sfo0Mn0oNET3AtemIHAMX2/2yKBkss8
 3uLT0iv/OgZtvTonSZR0jd8Y9qQENewMbPLC7NE6O0o9ovFfBRi2eYpEitJ43Ipm48XN
 aUSsPY6HFlYA2B8VP59rE65gicD4DL8ZXyCRncYwBYMxjF6FLX6cJxncfR9GtMutkxnd
 kiGlmzpI2ObMOoFny052r1Anr3nvTMshzpi2fUhC1Zg0K2/bx5KCPoK5L4zUyFyMh99z
 ojag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722807116; x=1723411916;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZU9VzSI2f7jEOQ8xfL60XLpm6G2xywpUBVql+uACQ9M=;
 b=xKBU72lQB9FBd49gOb5E4Neu+GJ+MK6GokSJp2OikswLHoc1con23elIBHShmU7suE
 Cuw6K7Lq0DpR5lJsjaCXVQI3e46f+0tIn4PZbg5BoOPZs9X3tYgPE7O9JdV14O0hxJkE
 roCMpA1gdgkmEcPM+BLiP21lQO6hHoCdPdDG31pQaeLW3q7wmPkqr2OeevZLEklHnR4z
 O9sqryn8NQF1hkDDaHEPpINm+V9RhZcsgSLSBGVGshl23E7IC+Lr87M0EVekqDTiZZl5
 in/k/d2WoYz0IfNCXJfygPaf9XmcNcV+0DUO3KiELGlYSbFPMlzN9tqoZbT21HEmePBo
 9zfQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVAHwIO4NGKloChXjHMD7uG0OvQHA82ScGDRtTpB0IFVEatq10PvPRl+Aa2SgQ5lc0Xrwk9LaD4AWYkhsvcDlMo5v3giS8=
X-Gm-Message-State: AOJu0YwNIdx5UYscefbWDbr6eEXEyNiFG492EOF2XHZ5UL3IwPy0y/7X
 z0U/CWFooYDNUmrxtHtXJw0MY64PlLaBwbz1NZRuE4XlysTRrs9fqNzCtAX6+bSE96jaK7mL7L3
 +sV3W3Q==
X-Google-Smtp-Source: AGHT+IFz1nTobCi1C6SQhWI3JbfIruLAFr7cdMQS5dLZcRFJZdpUyZ4mmSBYSBhBC/XaMSWDQX99CQ==
X-Received: by 2002:a17:90b:4a8b:b0:2c7:49b4:7e3a with SMTP id
 98e67ed59e1d1-2cff09346a1mr17399198a91.7.1722807115607; 
 Sun, 04 Aug 2024 14:31:55 -0700 (PDT)
Received: from [192.168.1.113] ([203.56.128.103])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2cfdc4cf0f9sm8878283a91.46.2024.08.04.14.31.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 Aug 2024 14:31:55 -0700 (PDT)
Message-ID: <74e6836a-63f0-4f93-bddf-bbe280e45189@linaro.org>
Date: Mon, 5 Aug 2024 07:31:49 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/17] bsd-user: target_mprotect: rename prot to
 target_prot
To: Warner Losh <imp@bsdimp.com>, qemu-devel@nongnu.org
Cc: Kyle Evans <kevans@freebsd.org>, Jessica Clarke <jrtc27@jrtc27.com>
References: <20240802235617.7971-1-imp@bsdimp.com>
 <20240802235617.7971-14-imp@bsdimp.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240802235617.7971-14-imp@bsdimp.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x534.google.com
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

On 8/3/24 09:56, Warner Losh wrote:
> Linux-user's target_mprotect uses this convention, so move to it.
> 
> Signed-off-by: Warner Losh<imp@bsdimp.com>
> ---
>   bsd-user/mmap.c | 18 +++++++++---------
>   1 file changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

