Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACA07C25B7A
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 14:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAVgm-00052W-6x; Fri, 24 May 2024 10:14:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAVgk-000522-4G
 for qemu-devel@nongnu.org; Fri, 24 May 2024 10:14:30 -0400
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAVgi-0007wP-It
 for qemu-devel@nongnu.org; Fri, 24 May 2024 10:14:29 -0400
Received: by mail-pl1-x62b.google.com with SMTP id
 d9443c01a7336-1f449f09476so5498945ad.1
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 07:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716560067; x=1717164867; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YmTzSz6mtSeQozrGISHQZ55ntw23k5tLDRtZ+mbvkq0=;
 b=OfW3YqKiKe8ZD42zb+pZ6aDKr78ZKmXhPPS5fHhFf3I2VVj6WLELv5mcs9Z7bSLXvP
 wZJgLyDK2gKariE18g9M+52VccJNNbihHA/ilxugUNlaL4079naj/DeEoL1w841wA6gS
 Fx6zuCMcZDe7+48Sem/muw6TffgIi/ZSWjRSEyMxI4ntMsDnogVe6aiLapxnVe9e/Z+j
 E/TY86wOAFP4irLs/U4g69Lo/C338fh3GMcsV+WtepYWD0uDuGdlcoOxP8D8M3j1hze4
 e0pWea0+V5McUwaHzgTC92ZqMWi3wgA2vAHEHV/i/QxpIAu7rrPXIUjxZnfA5pzqCP1g
 09Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716560067; x=1717164867;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=YmTzSz6mtSeQozrGISHQZ55ntw23k5tLDRtZ+mbvkq0=;
 b=MBm+Ttow7Uw9s9OJ18z4d6k8eA147/6GsC3AyDS8k3NRQooUZpGlHjYI13N2nkmB2a
 73zHLLr2hmhnmPCFz1PTtk7fIdfWSVBAe8/qFpptFy0N7e+ytr+q4m2yN+EbzqB8thqp
 68QGBxcBksRjTIly8t/fRFl7CZNwN4WUBemM+LtKSRW8obmUPjfcrvaDBPZSNQpRee27
 vwAB4Rdf0ZNz+gSt17/U1jKOLoFxlfUP+2u8EdS4Y7ekLKcMM5xE3SrVacwiPWyhDfSh
 15f3sm0NkajoB4ddfzFS/khHFckMyaoVL0U3TavJvTeCAD4znTqCY8D39G4SFFIH+4k1
 LeCg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVDBr7zP8AN37X0OcNSLYGxaSDvKOL4AfS3PpNxdssAzEo3jcHLRQUCx44NU5KH+KlCIG/PwEHgUo3JhS2PEuwPuJkC3Mk=
X-Gm-Message-State: AOJu0YyyYXgTMWQM0kLGtesfrG5byXr8F+xMh8Uu6ZSAikS6C/5Lk6y4
 4rBmLFx4KQ8HjbO7VexK5gIVNW+R/M+RAArMJIsQPqucH62pX9yfaLC9jyOf2Y0=
X-Google-Smtp-Source: AGHT+IHNg6BccghamFNagH2EZAjXJMPbZyEvmZPEKEM82xSUvXelVrZ4WTiVl3y5Ri7jwG9BI5JbQw==
X-Received: by 2002:a17:902:654f:b0:1f4:466f:8c90 with SMTP id
 d9443c01a7336-1f4466f8dddmr28008515ad.8.1716560066819; 
 Fri, 24 May 2024 07:14:26 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c7d2f36sm14326315ad.119.2024.05.24.07.14.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 07:14:26 -0700 (PDT)
Message-ID: <be35cf63-6cdc-4142-a96b-8157a4aca5c1@linaro.org>
Date: Fri, 24 May 2024 07:14:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/16] target/i386: cleanup eob handling of RSM
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240524081019.1141359-1-pbonzini@redhat.com>
 <20240524081019.1141359-3-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240524081019.1141359-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62b.google.com
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
> gen_helper_rsm cannot generate an exception, and reloads the flags.
> So there's no need to spill cc_op and update cpu_eip, but on the
> other hand cc_op must be reset to CC_OP_EFLAGS before returning.
> 
> It all works by chance, because by spilling cc_op before the call
> to the helper, it becomes non-dirty and gen_eob will not overwrite
> the CC_OP_EFLAGS value that is placed there by the helper.  But
> let's clean it up.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

