Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F2C7CD1292
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Apr 2024 07:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rup9l-0001F5-9h; Thu, 11 Apr 2024 03:47:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rup9j-0001Eg-OR
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 03:47:35 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rup9f-0000kD-UI
 for qemu-devel@nongnu.org; Thu, 11 Apr 2024 03:47:33 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6ed2dc03df6so3587823b3a.1
 for <qemu-devel@nongnu.org>; Thu, 11 Apr 2024 00:47:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712821650; x=1713426450; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gFltme5hyX0EbS1ZiCfjLKVyQMSwe4PRIfBuQHJckjo=;
 b=VoXjWt2hkyYDA7rLFHRYF3beWMqwyqm2lxDQRcfUtUCYaFotMR5PJiSzCKfiCEk0Fy
 7Z6F3q70oW6y2reJsqIPxKfmG9jHdvnH+xPeD3lm/0IwW+vnBR6a3Dn3C605otUOocVb
 m6x/mbz8aUx6I9+68mSbB0+Mot8l9CHmX3P1xfwifr5HB9fg1lRIFVSf8ZVVwKzmH6iV
 nCFVOiNhU+6WtWFXS3K5e9wnn4cST4YjUJVfBpfzm5602ERCTtm/D4cPVEcCkpeva6Ch
 2b4570gI2tlUDyRN9thaH22+yxgIiJ+/WD1iPkjRdJHquISLxRzWFGPzhfCbrxv4rFgw
 O8Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712821650; x=1713426450;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=gFltme5hyX0EbS1ZiCfjLKVyQMSwe4PRIfBuQHJckjo=;
 b=aCc6lU8uiWyTH5O9AGT804/Jxz8MOmqGCtgxV0Hc+jR/vFdhlf9Den8cnqCAdBl5CQ
 YtRtRh1T/wBljfrFaRBdX5+r9ngUjfUOewq6oH0nXXcrn7ItF2NBRZsJmwFvuOGN9pYF
 8F0VuYWRvfsaAb+SZ8GWEvil9YvYMAMVrhKvpOHRz3v/LmcfUJtAF1xRTDt3LhGMEnU3
 YQLmiF+LaIKi1Kfv548TLbWa4aQwSz01jZKEVRpwfnulJJ6uZSBrVnub7tZZekqAFstG
 hYJ9ugMWnpnZtUd/5mBXTsQ9MhkFdNf3lQAqJbSHyNwwUCZ2QhXXws+ScZ87XgkPZpGR
 9dzA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVLGPKNF6gcLwL09l/pF5kasNhma+8AB/sKN/njObLMtObryu6szlucAS/ZvnQ/PT1YAzOT/m0ZYUswCoW8s5R8JOwi6SE=
X-Gm-Message-State: AOJu0YzjrvrRqPPOUtIuza/4fTuwkoPQWeU9l6MZwVdtO9kvkHTTAgvg
 mE8l+18EkYV9Azsqc0VVi0qwzULn2kV6diPW5RE6eFZ1ZNzcsj9UWqZomk33xQQ=
X-Google-Smtp-Source: AGHT+IGJXzLXhATwegBoNJ+nvtysg3e9WYyu/CfiMHWGKO7FD/FYt697trqKmRtqraro7ULaQySRgw==
X-Received: by 2002:a05:6a00:1883:b0:6ea:db09:1a23 with SMTP id
 x3-20020a056a00188300b006eadb091a23mr6713771pfh.10.1712821650364; 
 Thu, 11 Apr 2024 00:47:30 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 q2-20020a656a82000000b005dbd0facb4dsm493803pgu.61.2024.04.11.00.47.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Apr 2024 00:47:29 -0700 (PDT)
Message-ID: <d7e0facd-e9c6-4699-b9e6-d45e0bbf72d0@linaro.org>
Date: Wed, 10 Apr 2024 18:13:24 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.1 10/19] target/i386: generalize gen_movl_seg_T0
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240409164323.776660-1-pbonzini@redhat.com>
 <20240409164323.776660-11-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240409164323.776660-11-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x433.google.com
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
> In the new decoder it is sometimes easier to put the segment
> in T1 instead of T0, usually because another operand was loaded
> by common code in T0.  Genrealize gen_movl_seg_T0 to allow
> using any source.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 16 ++++++++--------
>   1 file changed, 8 insertions(+), 8 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

