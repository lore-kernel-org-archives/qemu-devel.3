Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A24CCC25B74
	for <qemu-devel@archiver.kernel.org>; Fri, 24 May 2024 14:36:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sAW1Z-0007m6-EJ; Fri, 24 May 2024 10:36:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAW1W-0007le-G6
 for qemu-devel@nongnu.org; Fri, 24 May 2024 10:35:58 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sAW1T-0004VJ-KC
 for qemu-devel@nongnu.org; Fri, 24 May 2024 10:35:57 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-6f8eba8dcfcso848727b3a.3
 for <qemu-devel@nongnu.org>; Fri, 24 May 2024 07:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716561353; x=1717166153; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=ueHdZjEhC1XNeqgSvK0Y02Gvg5lvHAWFcqoZhxPHDxo=;
 b=vesHpAkh8UW2CETsu68ALF2afQ8KRztLf+WzRC4NHxVQ72FFJRUrevozix1KEKG7G/
 eOo2FAGp8Rn6uw4T77+uzWmoDffQ2Xipmm6rj8/uhMrM5yVeM/KfS1wsIlhdJYiBcn+T
 bYQcJTE6sa0Xu9LWo5Der7XFGTIxCjQq7hT+S1JAZVyfaBQA+lf8nZb6reOFlBYEo8jj
 7OSAVTADSclPydl5mmYFnvY54uZE627PTN+1xvWQOX2v9yoLBJ0StQkCwuhL8Yrj1SWI
 B8kx8uR1IKLVVX28SpVTYe+PIzsil1QON4xABgb3lCmA1nOnA2DF9Sxa4Ot6VRqeXW7x
 1fWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716561353; x=1717166153;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ueHdZjEhC1XNeqgSvK0Y02Gvg5lvHAWFcqoZhxPHDxo=;
 b=DOSSHd5UOtTVHfv+/FOkq0+qEoPvrpYJKOkDdqal0V8wxHPGxDhLIU1TNL7j0YvvqK
 8wvqJMhaR0RRCcVEKM3BIHPWINdqdaPMxAv8SiubT9waMkSZELfbZr/HqXE3nHr6PhqJ
 fbI/im9X9jC9nVS+eGnKS4HZxC+il5/Nhr5xIHidd1saFYDbTdN71IQRzySCWHtcIrhn
 kTl7UcREqwWEZJySAEIsrl5KVLgjSTnz7cYtgUM/xJ4rtWL1iqPujkMzG6P8jIhZc7Im
 KOuA55xVCZwZrA4iWnRDPx24YgvFK8yNG6xl6ZLvZwD0NMdsIc3L3M9QdusiAD6O67w5
 eXJA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVFlbduirDDG2TFJs55A5TmZe9Z+RlrdN9YnLKx+KYn2V7m8Pv+tEiNYSG0mU4MZm9xCxx13he8ptyhsERn3sEwMDOa6Y0=
X-Gm-Message-State: AOJu0Yxr+yiZ4DqSTzE7zE00tOU8BlD9gldbBm65gD3QjjAJX/uoLlEx
 QJ6eIbPp+sIYgBkmynZ+KyaSq4kvDTAOsluNA+9vDq1pXXIy+uHuWJqEdUEcAvS3sbd2G4WGk5f
 T
X-Google-Smtp-Source: AGHT+IG95NF0sTJsNPRjl9hTwXWvjAT35Y2Hr3DjPbCWrJ9wY20BMqWiig+5Pr90jm8jSnI9duysCg==
X-Received: by 2002:a17:902:f706:b0:1f3:2def:1f9f with SMTP id
 d9443c01a7336-1f4487334f9mr28562185ad.35.1716561353550; 
 Fri, 24 May 2024 07:35:53 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f44c9c6fd1sm14941555ad.278.2024.05.24.07.35.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 24 May 2024 07:35:53 -0700 (PDT)
Message-ID: <1beb15e3-1ac5-4966-aed0-9ad90f3746dd@linaro.org>
Date: Fri, 24 May 2024 07:35:51 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/16] target/i386: inline gen_add_A0_ds_seg
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240524081019.1141359-1-pbonzini@redhat.com>
 <20240524081019.1141359-11-pbonzini@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240524081019.1141359-11-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42b.google.com
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
> It is only used in MONITOR, where a direct call of gen_lea_v_seg
> is simpler, and in XLAT.  Inline it in the latter.
> 
> Signed-off-by: Paolo Bonzini<pbonzini@redhat.com>
> ---
>   target/i386/tcg/translate.c | 9 +--------
>   target/i386/tcg/emit.c.inc  | 2 +-
>   2 files changed, 2 insertions(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

