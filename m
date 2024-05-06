Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6985CC25B4F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 16:18:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s412u-0006tY-DI; Mon, 06 May 2024 12:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s412s-0006rI-6p
 for qemu-devel@nongnu.org; Mon, 06 May 2024 12:18:30 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1s412q-000339-K3
 for qemu-devel@nongnu.org; Mon, 06 May 2024 12:18:29 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1eca195a7c8so16232645ad.2
 for <qemu-devel@nongnu.org>; Mon, 06 May 2024 09:18:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715012306; x=1715617106; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=H6byCqCmyLuoNDudyQc2MI/gLzNSoPTdi7nrAfpDO2s=;
 b=CYTBbPuCp1zObsm1HZUnqhoWvtHDnj47v13JXXV0YhvPTPvU3c+dX46asqT4EX/2mO
 i/47BvIKjND5HWVnmbbHg8cKZT5HiBWrIypVqo6npvVr/FIHqyKaz5zg+U4pi9BxT6gm
 scxSuHdclJbdtFE/I6cOiIonVjYUC4xxaKK4Sb1Y7jAu1oGIhrvlXQk7M7TsABRUCwtt
 BDPe48hhyh+Gjw1Zu3lzR2C0fL7WQnMPeJuFfp+Vc0c9Dfzy2HW3FHJ2QVvDNfC/5Kj1
 /T/Ixm4pKXTXv8c5sqMIUyfxwahP8pipj98hxZDhd049BNssypXHpGukuvCouiG4FFWq
 FZZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715012306; x=1715617106;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=H6byCqCmyLuoNDudyQc2MI/gLzNSoPTdi7nrAfpDO2s=;
 b=pam4yVv1i/YNE/Nv8hMsPwKV992OrauKigMNO/FfRWWSIk4s7hejVPqRX6Ff9BO350
 kpegMN2zvwBydcMfxFvsP/1gO7mGx1UhrW6R9lF8baKIuuGjgBIvK9Dij8fRmf7pF3D7
 rtwpZRTqaLCCe+LmqoNcTVf4Ef4S23CLGja6b79W4u9hMLTkhQDh3lsoaJNOsBSbTwuI
 cixqqcxRZVUEyg4LUm5cwK/gxkaqHibBxjBzf9JnxecLg1+iJ7KMbgiKVvMLgU247YKT
 9nwck+oKsyElkRpv/ZLBWFKhi9t/RI+PqA4/F3VGbjAKEsr4osxA69MG2A2MRNmUcFnG
 fgRw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUj9+pDhmRHIwPbN9OnIZD5xEQ/S0NSsAQIWkPhLy1dnVsG0TMPfQYig7fZFNDAXejpz1TK42ZVMnLqYayr2znZBwsrSHE=
X-Gm-Message-State: AOJu0Yx3iwOwz5iky4gbPUz2fFBmLktFc22mG0DFXKRKhIDZBLzCtk5J
 wNXK0No7onvEQxhP6p265QgDYxT9bJWEUSZuhEeTXXdlx1UMFrYruoNsOLDxMks=
X-Google-Smtp-Source: AGHT+IELZvHylzX9O7pLnf0+S12vruzpM8znnP4GpBFUMTE0mwgVvnpcFsfRrQXlTUp+gH26ZFVNWQ==
X-Received: by 2002:a17:90b:314:b0:2b2:6339:b1a7 with SMTP id
 ay20-20020a17090b031400b002b26339b1a7mr9385124pjb.11.1715012306091; 
 Mon, 06 May 2024 09:18:26 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 x1-20020a170902ec8100b001eb3d459143sm8462881plg.48.2024.05.06.09.18.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 06 May 2024 09:18:25 -0700 (PDT)
Message-ID: <b74ce8f1-890c-4ef1-848f-8fec2b0e0e38@linaro.org>
Date: Mon, 6 May 2024 09:18:24 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 08/25] target/i386: do not use s->T0 and s->T1 as
 scratch registers for CCPrepare
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: zhao1.liu@intel.com
References: <20240506080957.10005-1-pbonzini@redhat.com>
 <20240506080957.10005-9-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240506080957.10005-9-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x632.google.com
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

On 5/6/24 01:09, Paolo Bonzini wrote:
> Instead of using s->T0 or s->T1, create a scratch register
> when computing the C, NC, L or LE conditions.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 17 ++++++++++-------
>   1 file changed, 10 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

