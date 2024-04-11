Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59AA2CD1299
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 07:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rup9d-0001Dm-4T; Thu, 11 Apr 2024 03:47:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rup9a-0001D7-MJ
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 03:47:26 -0400
Received: from mail-oa1-x2e.google.com ([2001:4860:4864:20::2e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rup9X-0000jn-0Z
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 03:47:24 -0400
Received: by mail-oa1-x2e.google.com with SMTP id
 586e51a60fabf-22ec61aaf01so2887457fac.2
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 00:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712821641; x=1713426441; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MnbjduhBvFSUVSD9GWa1fp8jbPZOQr5CAaRhyMKrjog=;
 b=kGyUV/nJ4gAd2n2mVhBPUO1OA/q2Zu/anDX4QbYCFOfoxXL9VP8ZUoe8zmJBwN5TxB
 ln/Zg0avQDrbDxwr3kpvIadz4/ut2ETdW1/PPFDb5iB4XNHcYYTNEhQKQWMCtyoxNfyC
 pNwkxkwr4iMpvgsZmw63ZTF8pKoMl6pRsz3CS9p2FeJJdzcOlvPfjx+PlKfzPecwvnhN
 rjC7qRwPja6Yjkh+jOsH/J0ETCe9pSbwpcOELbOkJDIkc2NzZGNIKL29ULk9vWEssiOt
 ibji8S8nN5tJxAIBz8n+jdD6IpdaP6Ma2GsOc9BXe7apI/gqi1lzVFOlFpG30i/ZnItF
 AeEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712821641; x=1713426441;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=MnbjduhBvFSUVSD9GWa1fp8jbPZOQr5CAaRhyMKrjog=;
 b=XxKdtf/J+3BJxVKvs8RI/eNTvrkHJEeYhKGm9ysN3fbZyul708E5v+E3XgwVduvjq2
 qZAusd5FVLy4PS4wnsBDeNl11dEDCo1y84Xv4kLW/qjnayLf6bLJt672ArSV49PE6a6h
 elFw4slA2aZVv4f1ZVjaUZXkGT2uUq1TXCmdKS23qPVuSS0bC7Jz/x3H8TG0zr33/TZQ
 xEEGvQOYblvRimBceTk7Jrluv4/888SxSPxz2u56YgEAaUgVYX0YjCPVRcNDFADJpObF
 QmInwF68kqLQ7kBCwP6mpi4YH6AJFQYLcanOV2SfV+/agfbIMjhfw0JuNJFOKR93DeeR
 R1dg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUIUpqkryBwcY37p7R5i72SQeuYASLdH6cy6zzhJpJ4G0CVuvl8gfpNnV/lx4fwBgaY6I47wlEM5oxiSSvnSXzxO+UYzaA=
X-Gm-Message-State: AOJu0Yxo6OoZE1ayDe/rQmcJaiqU856+NUybxagkj27sYUjdde6//q/b
 sddQdc7ERxS1CXBdY22Ee9dQAmkx9pJUHQCtXBSKDcxOzlsCAzAmiChYUI5RUZI=
X-Google-Smtp-Source: AGHT+IEMPcsokACg1I6nAhy5Icjj5CeYx3ZGhbPnOjtaEHrf3oowb1KUmWNSEqhMI35FqQQIbL1F3Q==
X-Received: by 2002:a05:6870:d148:b0:233:5893:912d with SMTP id
 f8-20020a056870d14800b002335893912dmr1560540oac.44.1712821641120; 
 Thu, 11 Apr 2024 00:47:21 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 q2-20020a656a82000000b005dbd0facb4dsm493803pgu.61.2024.04.11.00.47.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 00:47:20 -0700 (PDT)
Message-ID: <1f244c33-f56d-4c39-8fec-0fe085ba296e@linaro.org>
Date: Wed, 10 Apr 2024 16:55:25 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 07/19] target/i386: extract gen_far_call/jmp,
 reordering temporaries
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240409164323.776660-1-pbonzini@redhat.com>
 <20240409164323.776660-8-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240409164323.776660-8-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2e;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2e.google.com
X-Spam_score_int: -4
X-Spam_score: -0.5
X-Spam_bar: /
X-Spam_report: (-0.5 / 5.0 requ) BAYES_00=-1.9, DATE_IN_PAST_03_06=1.592,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 4/9/24 06:43, Paolo Bonzini wrote:
> Extract the code into new functions, and swap T0/T1 so that T0 corresponds
> to the first immediate in the instruction stream.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 93 +++++++++++++++++++++----------------
>   1 file changed, 53 insertions(+), 40 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

