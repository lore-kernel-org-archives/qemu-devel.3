Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EBB606A330
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 18:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=wE39AdCS
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRvbh-0007hV-7X; Fri, 13 Nov 2026 13:02:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xRvbY-0007VU-Il
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:02:29 -0500
Received: from mail-pj1-x1029.google.com ([2607:f8b0:4864:20::1029])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1xRvbX-0002JZ-1W
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 13:02:28 -0500
Received: by mail-pj1-x1029.google.com with SMTP id
 98e67ed59e1d1-3b15e46698aso1347706a91.3
 for <qemu-devel@nongnu.org>; Fri, 13 Nov 2026 10:02:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1794592945; x=1795197745; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=WWggzH7PK30B/d5ku1xeFRdBslzmwvERgwXtNgYEGlM=;
 b=wE39AdCS4qoYb6EYM47dQbrJxyXwh3roGx/HHBAz34VJ+oTS2LIgtZknfVW13Gtpr2
 tq5E9tk+Ynu9sFcEmVaWEGp4p+Z5b4ouhbFBPAwVibQjDpe8jQe8Dxbz2IsAMOraUfUJ
 NUzVZvuioyMZNLfv6LIpa0zac85HMGj9eXWp9FE8UwO4oL8+YDGcV4bUXg1BlSRYB9+1
 rBnFsv2xsBojMhXAE3iKYli2MiQRq9dYQkq/aXKtGfxTfM2gFzICxzdHZVPTsaT3fdK7
 7kM9iTsgwNMUzS0bn44M39P1/Bt910XfvP+6AEbucbjfBDB9inuKZQAtemZH5lCea+KR
 NEqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794592945; x=1795197745;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=WWggzH7PK30B/d5ku1xeFRdBslzmwvERgwXtNgYEGlM=;
 b=TxbiDLSRJCk2x7j053G4FTth28RFph8t7zjEBlAfvO4rjdaD8sL5Hm4G3WN5tR0jBa
 ZoDzHLNnivGrfmvkqLJmsHlk1U+wG+08c9XzA19CCyLyA7KgMqm3Wchd1cVN8JwgIWvP
 JUSTDkLKECZmcMhDVDMfKI+EbKcp/jdqYN43EV6Nt6SoCTOVso4AvpqnEMxEkOSTjkxq
 BGuhNdsdfrM7B/zicxBGUfYKcypgignv/8qb92kp8HPdlhGfHupTEmdEWjReBXiQHIFg
 MoZLEVOu+Zjhn74MZSfGicJD7C36wolkdScjyONkIjrgTE+TfTZniDSaOhF17C2gRGpS
 camw==
X-Gm-Message-State: APuU4Z/rMqCK792JHU3DNm7C53fnZ0KOF0YrOyQkMUPvpolpZq+g2GdJ
 useXYuardITlCBubNWYOHr1q+AhfWif7cAneRCS8OgZF1Ow10aqkGBG4I6hNwo/0NGdt5uVsKlr
 r41AQ
X-Gm-Gg: AYBFou0LUuFJlvloMW6MPKyCmGyCPJnf61OhSmMkpjcML94dYvCdr9EOBtjx/n+AAUH
 U4Mh3T5HUENsO4kvODscA4mAw3/VzcvH3cOvJg9g4K6ntWEETRfB9srPKth3WTK0DgIPtwkXZtH
 QwdaLP7lfJ8NT9rPg2wszJK0wGf9Vb9jx44Pdow1s9WiUqI7kXapFSQfviAJawBc2s/ujr5iX09
 ZDjR2SEfvr6k3Awsv37/1tUtuJfyZDzyuRFYmydJkEzzqQt30HtZ9O+j7DLRjPn13p8i/+JjE9Z
 DoDMqzkSaDYw1CdJZAf2eJSIGI5X3ByScUPKhOz4xrY0CS7BwhVW6F2U9SRUT1YfDxuY2lugyn5
 /9GtfPDbzcXllAcaaFpQ0Gyr9K0NY6+mKciCtLFN767BaIyEM5em/cUW/IqddsT5YLJFM4p6vju
 BQQA/oyxNVyaJIGBaJLjIC5nvzLFRL0eP4D4Z5yIePkqPaQQyKKe4jqaQcmUwZFTmg9y2SMWv32
 abwofEbtZybokFyLNcp6e0FscL6OiXq5vJroJuA8iJQkSMzt5EymBlWQaId7DFjI70Qd7s/RHIH
 mtEEaP/XDMd6j/N0W4jO89Rvesl0hvnidpRrRi4ng3k=
X-Received: by 2002:a17:90b:264b:b0:3a5:c08:4c41 with SMTP id
 98e67ed59e1d1-3b1b0b6563cmr2689114a91.50.1794592945150; 
 Fri, 13 Nov 2026 10:02:25 -0800 (PST)
Received: from [172.31.6.230] ([69.196.88.181])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3b1ae981c55sm5583615a91.1.2026.11.13.10.02.24
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Nov 2026 10:02:24 -0800 (PST)
Message-ID: <47dcc295-da06-4f35-a97b-19d7870561a7@linaro.org>
Date: Fri, 13 Nov 2026 11:02:22 -0700
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/i386/tcg: remove unused operand sizes
To: qemu-devel@nongnu.org
References: <20261109185702.1068916-1-pbonzini@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20261109185702.1068916-1-pbonzini@redhat.com>
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/9/26 11:57, Paolo Bonzini wrote:
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/decode-new.h     |  4 ----
>   target/i386/tcg/decode-new.c.inc | 10 ++++------
>   2 files changed, 4 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

