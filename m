Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C29CC27C53
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 23:16:25 +0000 (UTC)
Received: from [::1] (helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFd0U-00012Y-Mj; Fri, 07 Jun 2024 13:04:02 -0400
Received: from [2001:470:142:3::10] (helo=eggs.gnu.org)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sFd0R-00012L-F9
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 13:03:59 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sFd0O-0003l6-JO
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 13:03:57 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-702342c60dfso1901824b3a.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2024 10:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717779835; x=1718384635; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=sr7rmdfvi1A83wOOluLJcLofUgrCclBa9lN7lNRXfao=;
 b=lmKZTIF9wGyEpWko+NKRwsGkKUjCxcaIwHHGePAIleQTKJAZSUoznvs4QsbvS8K99v
 B7G937p46vju8d0Rslg8Pqm5lKmjONVbU+fWY9sCTx4OLe15B/T0d6QrP7D5/+pvA61W
 8Pxd0WTis54zw4P8mk+/RxGOnTjaUEmICpQYGdl9OyZUTIFtnC9oLTPnQD8D/Bn/IOsH
 5/NKLTqqlr8kXgxD0/PXHxCg3696AUQ+MZZ0sO/Gf7KtKYEpEYViD9Gff/XiYezNTM63
 4ZX0hjZHMXdjBO8CvklVxBuHloTxsWAx+ChR4vrTekEjJtBsPrhM1ngsZ0npGmzXnqkG
 6GQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717779835; x=1718384635;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=sr7rmdfvi1A83wOOluLJcLofUgrCclBa9lN7lNRXfao=;
 b=EcN5t+8qDpXu1EzHq7aRR4rVQ5k/MhzoxUN/gGvIJPfjkwoTPFZThcP1XUKYbHFAei
 BZfJ5f/uYEEJAqYINXpg9vcZwli+vhyks3zkKet7vHRj1u1TDdFxJobIcaA9JC4XiyBW
 QY/xuEHrxOnLOj4KMQ+2VBCSfUFwB2GRTC5IMn94gRPxtIx1rf4lrmpqRdbUm26tgyE9
 if8r+m7h7zDSoEt+74+ACPKQE4i4n8FaRNoMOa0Ok6/kWsf7+RHd5fjJJ023WqMTmuzX
 UIIr9eNz6PQjN+hTSubddysvR9E/NNakImHg9oIuTOEaOXH816MEiNOVndlDba0X9KyQ
 IPYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuuczxFx86OdOCNvA5IX4QtR+1+MfMm1PcIXfZDqDzJvbsWRdfcuW/vbnSjHLPGArsLmmMcb8n5pSstk9s3qqbTX1wNtw=
X-Gm-Message-State: AOJu0YweW30tbr3MV4kSDXBS/5sibTW8oFoW6cGkfPCDLx/8CTjcH6pB
 d6hr69/ZPX+TcLSnhuh7+0QXCRmysl9vu5q+lpzecs5eyUY9cjrrNJuUYkAoQOU=
X-Google-Smtp-Source: AGHT+IFKEr6hlVXKsfo1I3FVp4msW68GBbFEG8EN3jumaBYjo9e8vTPpjjycRcmAV14N5rdn8xGUMA==
X-Received: by 2002:a05:6a00:1409:b0:702:71e6:2064 with SMTP id
 d2e1a72fcca58-7040c751f6bmr3172008b3a.30.1717779834992; 
 Fri, 07 Jun 2024 10:03:54 -0700 (PDT)
Received: from [192.168.223.227] ([75.147.178.105])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-703fd3b3640sm2873429b3a.95.2024.06.07.10.03.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jun 2024 10:03:54 -0700 (PDT)
Message-ID: <50b39d95-be52-447a-ac57-c1478597a768@linaro.org>
Date: Fri, 7 Jun 2024 10:03:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 5/6] Move tcg implementation of x86
 get_physical_address into common helper code.
To: Don Porter <porter@cs.unc.edu>, qemu-devel@nongnu.org
Cc: dave@treblig.org, peter.maydell@linaro.org, nadav.amit@gmail.com,
 philmd@linaro.org
References: <20240606140253.2277760-1-porter@cs.unc.edu>
 <20240606140253.2277760-6-porter@cs.unc.edu>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240606140253.2277760-6-porter@cs.unc.edu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

On 6/6/24 07:02, Don Porter wrote:
> Signed-off-by: Don Porter <porter@cs.unc.edu>
> ---
>   target/i386/cpu.h                    |  42 ++
>   target/i386/helper.c                 | 515 +++++++++++++++++++++++++
>   target/i386/tcg/sysemu/excp_helper.c | 555 +--------------------------
>   3 files changed, 562 insertions(+), 550 deletions(-)

Why do you want to move this code out of a tcg specific file?
I think this is definitely wrong.


r~

