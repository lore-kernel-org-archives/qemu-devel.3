Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B029C106FD6C
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 03:26:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0tAR-0006PL-0s; Thu, 12 Mar 2026 23:26:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0tAO-0006O3-RF
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 23:26:25 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w0tAN-0004Sd-Bb
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 23:26:24 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-439c4a93841so1212335f8f.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 20:26:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773372381; x=1773977181; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lSUR6sDuLkIyTAHnGUDGlgmGz5Bl2tn13mDpZb//um0=;
 b=BeVL7xo1zZMS2xd6yVSVXiRavuQWarZjFa0+tPU7YuN8FjoD4+IJdDDzDr2go3C8OY
 wBHMs1tIuZgWNjuMFmgvn4l395MV5EF1JABjFRp2aAOdO4QfYaUxDClHKxSUxEosGRiz
 5dGEHeuNK6EJp8loaM41x3DuvY9k+PxAYTYSBidLdRFyN53SMHR5/N15dnCmr/op2fHk
 qHe7O6b77nSRON4UswczPXNjZ/cEAWJU6PxOC0BHCDWUAbpf/bS1pFF+0H436V37UJgP
 2Ad+enIp773nc2Q7WlShMzcktqSn6BlVy0VL6h77ggjpsA/vuvC0nsoPI3B211PUSGS8
 mNiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773372381; x=1773977181;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=lSUR6sDuLkIyTAHnGUDGlgmGz5Bl2tn13mDpZb//um0=;
 b=i4QhV+CASW2hsFvtIwefWXNhc0JJ/S7x6+W2uV+YkmwcSiLA9tEbkF+CEg80q6+HBM
 qNiuI1twZjHKnxxGX5C/ufhdmQQgxajtCXvbTDVoyTS1FJkhz5879D+y2kdG3aMlkFps
 wQLgcB7HHYylee+D/xoKsC8+ZpPsCCYZhJCBLF+EMLIcpuEjNZRqCAwGAO+bSnHL2WZF
 lza2esajs9UL92zgfp+gXd4IKyos2pyoDqeGi/TrCc+eJRyquqWTBTYrnvo/YqLUaDgj
 z07goPr+I/fxhTLwMNyw9B1SnWtcCyncgi1NDMC222mUZvmv6NkDQJFmqIzOGY6/Mdhx
 /6QQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVpZyf06uCrG+lW7hHCxPLVHFjpffuRAyrHOefqQouG3sMwDyCFimV2wneEMOEBoHK5IauO5qEvOvV@nongnu.org
X-Gm-Message-State: AOJu0YxfJXw4/oaE3yqEVkrET6TkEF1BGsun1LjwA5w+VxOve16YDssJ
 5KOOCLX7qn52TIjFlIOXfPxmLEBjP32gUYg260aySLKeU2ppnvdQPn5IFSwjz84QTww=
X-Gm-Gg: ATEYQzw48ZlbkLy6uopfWzKs14jyfzzTVC7I2agBbs4WxyTFcg6KloHorHMHiRfFrp9
 /sOEEzF5S+bsAV8YF29MkVR7z4eCsabD2VJnAZKYJLUIlIyb7ZnPuZpVYqtp7H4nTl/l7fbhphv
 RF5wRZEeYLh0TeEEIwoGibw1U1BM05IpUQmZF1vM7ux4DW1NsIp4f+D+Alal/xFS+eG7+miF9/E
 2fpGJanLXdqmz5mVnInN/g93OSso4neNKmg8cI2DURxcDzN15yTL+J7JCNzpB4XmMeRrAX8w6cD
 Hg2hoJ6yaoyqNKUN2Ia3SM6ruSS+10DcDlgjsDpDMiocre+ltAFn7CDrNsyMb5nwDJYAd1dFUsS
 Tf9Gel/dut7gtztxBvVv+XLNvKcfA0EQYau/iv03CXFAOqAO2mQR5Xn2Yexukx+VNQinIMnBvGY
 uf+sx8gwsWKU6f4awTdjVH/rNw6jNXPZD5EY+VfhOQz3Qfr7Yw5MEVcvqlJ7vOOMeu5w==
X-Received: by 2002:a05:6000:1845:b0:439:b624:5ce6 with SMTP id
 ffacd0b85a97d-43a04d714bcmr3446952f8f.9.1773372381388; 
 Thu, 12 Mar 2026 20:26:21 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe1affe9sm13149484f8f.15.2026.03.12.20.26.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 12 Mar 2026 20:26:20 -0700 (PDT)
Message-ID: <ce1c675e-97a3-456e-8301-ab5b0f087b16@linaro.org>
Date: Fri, 13 Mar 2026 04:26:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] hw/vfio/ap.c: use full path for target specific header
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, eric.auger@redhat.com
References: <20260312224449.1605071-1-pierrick.bouvier@linaro.org>
 <20260312224449.1605071-7-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260312224449.1605071-7-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 12/3/26 23:44, Pierrick Bouvier wrote:
> In addition, we fix target/s390x/kvm/kvm_s390x.h cpu-qom include also.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/s390x/kvm/kvm_s390x.h | 2 +-
>   hw/vfio/ap.c                 | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/s390x/kvm/kvm_s390x.h b/target/s390x/kvm/kvm_s390x.h
> index 649dae5948a..7b1cce3e60d 100644
> --- a/target/s390x/kvm/kvm_s390x.h
> +++ b/target/s390x/kvm/kvm_s390x.h
> @@ -10,7 +10,7 @@
>   #ifndef KVM_S390X_H
>   #define KVM_S390X_H
>   
> -#include "cpu-qom.h"
> +#include "target/s390x/cpu-qom.h"

Yeah, I've been tempted to do that globally with a script, then remove
the various '-Itarget/foo/' from CPPFLAGs, but not a priority.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


