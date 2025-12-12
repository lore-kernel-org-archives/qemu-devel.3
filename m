Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59F23D4922D
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Dec 2025 14:38:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vU4H9-0008Kb-Sf; Fri, 12 Dec 2025 09:37:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vU4Gz-0008Iy-Nl
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 09:37:37 -0500
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vU4Gy-00045p-02
 for qemu-devel@nongnu.org; Fri, 12 Dec 2025 09:37:33 -0500
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-65745a436f7so721079eaf.3
 for <qemu-devel@nongnu.org>; Fri, 12 Dec 2025 06:37:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1765550250; x=1766155050; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hY/5/gksFPVCCySIbsBSCMI6I3xJysofC1hC+RDWNDE=;
 b=VATcAluu7AjGraBJqK8gWVRAHLwCNyGlXjXaDgKJenBPJIwk6vnr0rU96Qyzh3Uzaw
 Y93rNInMXwtX7WhXjrCQejly2NzOiIcl5oUX6lZ2yCif6NG8hpyH/wNTkkWnlx4EDARt
 rjsrSC2Qu2OjvGZJizAytsIcUNqOfse0BCyY/TBmghSvOeSWf1scuQSttd7kdHElvpM2
 7S6cLP+IA+qiO7YORSq6Gc1vjE147DvA1X0B3RDy8zuJuzJJdGmhpxxfz/1aMsX7146K
 COQ+meSlRLzlaAjNJpjWDI9+TNehz1R1rMaADLOcPcJDp1d2Z0mLrAX1bWQT800e84rg
 II/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765550250; x=1766155050;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hY/5/gksFPVCCySIbsBSCMI6I3xJysofC1hC+RDWNDE=;
 b=c2KFcrXMN9P1T87konLHOYE/hE5hyyPhfRxG1MDlHD+21nABkeCM96eGpCGRSsRGoN
 o4nkNzsWDDiGl6RPi8S6xgZwv3UOwWDs9yQRdAcjnXd4XxMKtupiPnYS58crjwI9uR3S
 QWDixW1OAuPXBo2qYA+eunavFTwZnLae5ce9JJ4eCKXkb/xKuaGP273oCefXQeFKRV8e
 wumMpWhMCbaWTHZWLC+CD2iDGd8mLwjUkKHk2+mYoyPlTCUNFG0eccNFceijaHMgVidL
 Z+S1ATJfzxk83hUYlaRXWbyQkca+LUqjYeEaHkqnM0H+OvBcueKSX28TDWAGFAMkR001
 OJUA==
X-Gm-Message-State: AOJu0Yz+RtA1y3eqqbh/zFLG/uSdC5LvSTijGhHPVEqZ7o2kd6VxO17K
 7/XvmQ0LG/e9JvGo6V0i2CUIqVWR4yro0U7Rr7sjEjWrwI/8xp1NnkTYEHyytzkeszU=
X-Gm-Gg: AY/fxX5+y7ItgZk6A0PtJAeRHhz8xP+j9WWCPTsxBJA2QhrHzYJDV/EBjUuP1e0Ig7r
 VHJ/9AmtNmtRJvGSOxxWhHFwTi+0JMLg+e2vQxrDX/Nh32LEkOHZdsaTGSZYOTh3GpLMLPWU51M
 WBZeAwLsPWTn7aEDlO1swWHhge4lazVzxrrco80Fw7QLY3DAW/oyMqLWGGjuacTe1lTXNMtZ4c0
 pU74uMlAD7SaiwccJWAH67h1CQ45tQQaYscoVAeQfcsidmJF4ugoHc7B+iV1wH8bimEdGNQwISR
 okWtY1jLxhDeT4prGfWyE250kaC7wPcYew9m1UiuOXFwcE7OnDCKvzGL8T3xteGvJlbJM3BoqT6
 n2rSzxkygNg0FJHPznQX2JaL9EfPNxYgGnnOVADn+3Rnfkglv1+ghFPLUX2HVD9aOiJZ6N0EIso
 Xrc41VJK5taBTyfpDCv0xlw6gUlf3jT8NwNONNy0RrlD1Ekogmvg7RXtDTn33TlZ+y
X-Google-Smtp-Source: AGHT+IEEZfueOcaV8yjb8yLsXVZ3Mr0Rpl4NCHFQOQMMN+sOhtzN35z3YFSFJkNCEt3aOthvGAhHWA==
X-Received: by 2002:a05:6820:308a:b0:65b:3857:b828 with SMTP id
 006d021491bc7-65b45763306mr893598eaf.69.1765550250463; 
 Fri, 12 Dec 2025 06:37:30 -0800 (PST)
Received: from [192.168.4.112] (fixed-187-189-51-143.totalplay.net.
 [187.189.51.143]) by smtp.gmail.com with ESMTPSA id
 006d021491bc7-65b3611c395sm2947160eaf.16.2025.12.12.06.37.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 12 Dec 2025 06:37:30 -0800 (PST)
Message-ID: <0bf7051a-0c72-4fad-97ab-670ac41b2932@linaro.org>
Date: Fri, 12 Dec 2025 08:37:27 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/18] target/i386/tcg: fix check for invalid VSIB
 instruction
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-stable <qemu-stable@nongnu.org>
References: <20251210131653.852163-1-pbonzini@redhat.com>
 <20251210131653.852163-2-pbonzini@redhat.com>
 <bbca9504-2b47-4aa0-8cc0-be17b3db85d0@linaro.org>
 <CABgObfb7xNov4tW1m1Yru+-p55zGW_3jsNXyzL68_NjY0XnMtA@mail.gmail.com>
 <755aed45-4ebf-4828-817a-ebe6106ea2ad@linaro.org>
 <CABgObfbrfSytFOKxAdcgeWPSu9BKsVkLuBSDSVsZLB-=LEBbdQ@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CABgObfbrfSytFOKxAdcgeWPSu9BKsVkLuBSDSVsZLB-=LEBbdQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc30.google.com
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

On 12/11/25 20:06, Paolo Bonzini wrote:
> 
> 
> Il gio 11 dic 2025, 23:22 Richard Henderson <richard.henderson@linaro.org 
> <mailto:richard.henderson@linaro.org>> ha scritto:
> 
>      > Yes, I was confused by the comment and by QEMU's incorrect decoding logic:
>      >
>      >          if (CODE32(s) && !VM86(s)) {
>      >
>      > which should be changed to
>      >
>      >         if (PE(s) && !VM86(s)) {
> 
>     I can't find the language for that.  Can you point me at it?
> 
> 
> It's the exception condition tables. They all mention that you get #UD for the VEX prefix 
> in real or vm86 mode.

Ah right, found it.  Thanks.

> Several BMI instructions also have language like "This instruction is not supported in 
> real mode and virtual-8086 mode".

Amusingly, some of them dropped the "not" in that sentence -- see ADCX.


r~

