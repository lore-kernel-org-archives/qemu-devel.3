Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FD910A88E0
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 16:46:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5nqN-0008RG-2z; Thu, 26 Mar 2026 12:46:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5nqJ-0008QW-TS
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 12:45:59 -0400
Received: from mail-pf1-x430.google.com ([2607:f8b0:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w5nqC-0006dE-RD
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 12:45:59 -0400
Received: by mail-pf1-x430.google.com with SMTP id
 d2e1a72fcca58-82735a41920so465041b3a.2
 for <qemu-devel@nongnu.org>; Thu, 26 Mar 2026 09:45:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774543551; x=1775148351; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=hxn2iCJLZkigEK0VmVY2vlGaMJrmTxynIrTJmoRBWeU=;
 b=qPZLGSf1DMGSd3G9dRcgiyu3YXRfvzyJz5vumnUI6kMKBU2LN1+cB51QoSugQbem5d
 a1FHDepW4Xn01S55ntMgPoc6nYQEHrMSbcYT8zdSfNBnVNF7tMpdIVsT3lFlbvwn+nKF
 RfbNLvOzn8U7+gMQuJbhaWIltyjnxZJP7Slougc3O13IX1LROe6Bq8hUhpzmZKG3ehwR
 brT0rRitikUN74Ry7M7SA8z7qtxfaZatirAkw2Elm2iMtqeHsf2YrchraK2Z8Tf6uGIn
 PVIuUetaomXfZw7FlPSux5sfgewkILcw1wjhtyTfM8tcnK2lQ3DeDG2YGVc2UIq5QHzk
 T8jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774543551; x=1775148351;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hxn2iCJLZkigEK0VmVY2vlGaMJrmTxynIrTJmoRBWeU=;
 b=RYpIV/9IM4fALPK1CcYf6/EySTNAQriwCQORu3Q44w0ehNGhJ25gmPJpGs2B/WbBEb
 Qh7/NGaBf2TlsESgegf+eRdaqfCNWeO90zUkm7IBKG1LzJT/PhQzX/pqnQ6DUsaIz/Eg
 0WscG7hBcx27RLlTgm/1VzCBZ0WB2aeBDe7M6/3FWvbdXsQ+J5VFBTAeVHbsAv3Kx/r2
 dZomNePxITptfIwiPPdLcpQq6q5GK3+GL0kTIybRghdL2aO2i5f8kr04e68CedunUj7V
 eHqXOlfpznEQV55ffo4W6NsqAq9eps+EpAglFjzKOux8n+OHlhVKbHTXM39/WkkG9tpx
 inpQ==
X-Gm-Message-State: AOJu0YyipPWwitNQrkE4Xwue2a7jSj5xy+OAp0KSyCh+Te9+pkPutxVA
 o43tsSqy5aZocNVFtvHZIEw/Dm8M4mrMH/pXxVQp3JEXp9m/cBAbUXu2tKgNl9MImW4=
X-Gm-Gg: ATEYQzy3tzsHSCc3myy12iayeYHsHIOyZKZtLMtSNnZIlXaIN04OMRRtKvszOdW6u3s
 7g1d/Zvf+14Q/h71se9Zi+f36PL/XJHNJLGArxdiNDIR51wBXtscGPu131XHIiOV5wOW/JsSxZR
 lAlLMb+qeJcnlgnwdI7Pl3g7maPNjiNn3ChLeLwqgC5wx9J2teFj4PjBRHcIV1OXVTKAXm+S1wA
 ePI+YZyHMkXbzZ1z1hxijB69KYFx6J2xk+RRvCNZq3ahMV15GHus7/fEYY2AOW8ReGUKX+mIjFe
 T2Yx86yV+V29Bp8B+rIMUMdi2mhIgeF4IYGpSuU9bum052y7L6Up5i7fUzrj45cCgB4f61NIPgx
 F6co2pESXzyEevne+GCx+jQurHrSTsdITjVLdfYKCU50JBfYJOQys8CvHVBHhOE96+ygitn7H3w
 31lrSQ9DRieTmeg0DaLmaidGI3uKLdLNEzqkwMk1LWK6KeTsVEm3yDQbhacbcvz1anqG4H
X-Received: by 2002:a05:6a00:a21e:b0:829:8990:3f86 with SMTP id
 d2e1a72fcca58-82c6df62cafmr7675469b3a.35.1774543551076; 
 Thu, 26 Mar 2026 09:45:51 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82c7d1e63b6sm3372472b3a.12.2026.03.26.09.45.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Mar 2026 09:45:50 -0700 (PDT)
Message-ID: <2e4b59e6-bcc3-4a54-a71f-a11bbf7fa239@linaro.org>
Date: Thu, 26 Mar 2026 09:45:49 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/7] Misc changes to allow building with Windows Clang
Content-Language: en-US
To: Mohamed Mediouni <mohamed@unpredictable.fr>,
 Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Yan Vugenfirer <yvugenfi@redhat.com>
References: <20260326160033.68318-1-kkostiuk@redhat.com>
 <E4E91C9F-222E-41CA-B51A-928480FDC405@unpredictable.fr>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <E4E91C9F-222E-41CA-B51A-928480FDC405@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::430;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 3/26/26 9:34 AM, Mohamed Mediouni wrote:
> 
>> On 26. Mar 2026, at 17:00, Kostiantyn Kostiuk <kkostiuk@redhat.com> wrote:
>>
>> This is the first set of changes to allow building qemu-ga with Microsoft Windows Clang.
>> It includes some cleanups and fixes that also make the code more portable.
>> The main goal is to be able to build qemu-ga with the MSVC toolchain
>> because MinGW-w64 is not available for ARM64 Windows.
>>
> Hello,
> 
> MinGW-w64 is available for arm64 Windows, although it’s more
> mature with Clang as a compiler instead of of MSVC.
>

As a complement to Mohamed message, this documentation will help you to 
build QEMU on windows platforms (including arm64):
https://www.qemu.org/docs/master/devel/build-environment.html#windows

Just make sure to do this from the console you get with:
c:/msys64/msys2_shell.cmd -defterm -here -no-start -clangarm64

> Is it more of a packaging issue with distributions?
> 
> Thank you,
> -Mohamed
> 
> 


