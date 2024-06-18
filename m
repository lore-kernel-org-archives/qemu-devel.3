Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3901AC2BA15
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Jun 2024 22:18:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sJh9D-000875-Hz; Tue, 18 Jun 2024 18:17:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJh9A-00086p-CK
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:17:48 -0400
Received: from mail-pg1-x52d.google.com ([2607:f8b0:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sJh98-0004si-SY
 for qemu-devel@nongnu.org; Tue, 18 Jun 2024 18:17:48 -0400
Received: by mail-pg1-x52d.google.com with SMTP id
 41be03b00d2f7-6e7e23b42c3so3867202a12.1
 for <qemu-devel@nongnu.org>; Tue, 18 Jun 2024 15:17:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718749065; x=1719353865; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=D7/Vx/T/CL3qtziBC9pkDn9Sst5tuTypNfJzwdHwadY=;
 b=MZBrbg7dLnCpu7Kaqafr+VJyK98a/jYeNSfFwBYyKc6Ou6GkPTF/CZs/OtFsXJUv9g
 DKKcxryhNssg1iVVA5JIwlZYjgw+iP+i7sdUJxrQR5p6SM4JIf82YeZVnM0vxj3T40+H
 mVt0TDVJkV8cd0G3/1alOTSkMLtJ+SQSNacw2aBL4zhzJlz+lahGYe85FYORv09hIaMk
 KPrJctOMRtO7SR0Cyddv6kIq/bhUM4NS1yz1ijnqE8/rDLJyVYXxUe3E+q/GJaPJQ2fk
 T+AMPHIciyG1vTR9I6w2bquZecFTZn9BPCEgomT6M/UknP+0YVaq1Jzwl1iejM7PunBG
 gDpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718749065; x=1719353865;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=D7/Vx/T/CL3qtziBC9pkDn9Sst5tuTypNfJzwdHwadY=;
 b=s7USnypho8++btnaBLaQTpmVbSXMeNIFVTQMfw6dWrBSIQCsCIFlvyg/l+L53KqizT
 RJUs9m6/6LBrAzRl9KqKOoS7kYaB+/15Xd9JkM1XNKomlEgysHEEBdvis4b0Hbwtiak1
 +/aH3nvi2Qxm62NopZtA4r5/mCTXy47SEceRrEZfEmwVqKHAhaWN+sQPt7Njab3bRnPa
 uNngNDAYRLishSvzuUnHrnYvOK33wx5n9Wff/jNiGlwCUGsEydleAfh3ggMVmLD9kStu
 hg1xR2np1APnV01ylz0/LRatrfK5KMV+f7wKqUEEbcxkdFc8QF1hWqfxZvtR36XGuRSL
 9gLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWtSeFVvst6YRA73ZziNEmuLx++UX+WfSv2BbuiPdqqx3JvYpVHS94ieOWbozfMu2XAJ6l+Ue8X3nX1GaOFJ5otrGYPRF4=
X-Gm-Message-State: AOJu0YwZnnrV+tOL7+IxuxdSckIdJHcwESOerTktQOhQDQBAmiGzFIgZ
 7U7BFfWOY97tT1kIfpIHzUYTGSNQQnHnsdA8cw9NNwYe6168c6wV6K/Vi9J7iTY=
X-Google-Smtp-Source: AGHT+IHddzqdYm3R+hEV3npbQLFZbJ2G0FNWTzR5UUI24vqaXRbEoFV5mGJSmL6FioqLzv7wSP3E9A==
X-Received: by 2002:a17:902:d504:b0:1f8:44f8:a390 with SMTP id
 d9443c01a7336-1f9aa3e2e95mr11573105ad.33.1718749065361; 
 Tue, 18 Jun 2024 15:17:45 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.132.216])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1f855e5b85bsm102660695ad.32.2024.06.18.15.17.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 18 Jun 2024 15:17:44 -0700 (PDT)
Message-ID: <0c5af289-7ff6-4217-8cbf-b9119fe6c587@linaro.org>
Date: Tue, 18 Jun 2024 15:17:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 12/23] Add ability to get rval2
To: Ajeet Singh <itachis6234@gmail.com>, qemu-devel@nongnu.org
Cc: Warner Losh <imp@bsdimp.com>, Ajeet Singh <itachis@freebsd.org>
References: <20240617185804.25075-1-itachis@FreeBSD.org>
 <20240617185804.25075-13-itachis@FreeBSD.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240617185804.25075-13-itachis@FreeBSD.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52d.google.com
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

On 6/17/24 11:57, Ajeet Singh wrote:
> From: Warner Losh <imp@bsdimp.com>
> 
> Function accesses the x1 register which holds the value
> 
> Signed-off-by: Warner Losh <imp@bsdimp.com>
> Signed-off-by: Ajeet Singh <itachis@FreeBSD.org>
> ---
>   bsd-user/aarch64/target_arch_vmparam.h | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/bsd-user/aarch64/target_arch_vmparam.h b/bsd-user/aarch64/target_arch_vmparam.h
> index dc66e1289b..0c35491970 100644
> --- a/bsd-user/aarch64/target_arch_vmparam.h
> +++ b/bsd-user/aarch64/target_arch_vmparam.h
> @@ -65,4 +65,10 @@ static inline void set_second_rval(CPUARMState *state, abi_ulong retval2)
>   {
>       state->xregs[1] = retval2; /* XXX not really used on 64-bit arch */
>   }
> +
> +static inline abi_ulong get_second_rval(CPUARMState *state)
> +{
> +    return state->xregs[1];
> +}

The other two ports only define set_second_rval, and this one only defines get?  This 
doesn't seem right...


r~


