Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E15DF4BB80
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 19:25:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuy2R-0006vh-75; Tue, 24 Feb 2026 14:25:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vuy27-0006sN-2N
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 14:25:24 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vuy25-0007s9-JZ
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 14:25:22 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-2ad21f437eeso1182485ad.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 11:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771961120; x=1772565920; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iEXfzbx3FmokdwxtqhRrLdj/IPJPoBw7oQ+2gauJ9Nk=;
 b=JhEnfBaD6uLkKkWaWCCFQ06VBnBMb2qmzzjNyODlWUq+Wr3fT/gzqrbQmaZ3BhX9Js
 NQk2mg4cKTrxglaEVB0jsIIj3xlcPXtK3oWKqkfnWINOuX/MVOzAA+LVI4eWEo10eJWX
 C8zl3YNX//9ldiY5MgS+leoz+v8IkMsPwbIqFxbp2GHQt+cwoAkw50CGxbEB0mIh63qm
 ct2/tKCgYEitmKjRqe4U0nn4PwrLVeslcFljDNbZ5y7eovmMUUNhz2sBBNoW7dAgnnPI
 8Np0plJj4ie+xDcQcvCsTYOgPqurJ3O3IgVEUgD5aYTQ2IndBlYyx9nTE+0T32DxyoSB
 GRLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771961120; x=1772565920;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iEXfzbx3FmokdwxtqhRrLdj/IPJPoBw7oQ+2gauJ9Nk=;
 b=PsI9iFGeoMHm2wMgRtS574n16AkqYvKp/rQGVzcQRzf4sPmKWp+R4JDwxYA4GMb+BG
 3MpiCCEtif2XFF6jc+1R56fJZm/BpaN90xjvt4mwGwnYAc1MIdv4tVOAK3F9De9OTs7Z
 Gn8N94ZKv7cYMWdmsbEh5126u75+ir2TPsPd+winGxdHHIWNOqVVJUt3HUFiINSq4wrM
 LLA0FBwSh/0tEgr97wsmjkFFRU89KivCs3V3QlGtNYNT3AbOvdN4v2PpUr9Pt8H2JuIE
 an2AGQGH9vu9Sk4ztFeME0EKh826ywDJzg9xyYnF94kDxbA4aVmnbctP3eWbVt3jzgkq
 z5gw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX/4LEUDfNhYJfLSWfeoLnsH6c7j+WJCdKQAmwGpyP/Y+oTYUNyFi/75AW15yva5xhEOPBoxDt74SXh@nongnu.org
X-Gm-Message-State: AOJu0YxfSr9SImqe0jV+CLfkty4+qn1n17/hjafpepkTTFOfiwOki0p5
 +EYB7cmre6crBcia+31/V5/IqA9aH0xQCSBHg2SwIo3j/RPg7oaKm0NCs5dMb0Or34jg+4raURG
 02lgU
X-Gm-Gg: ATEYQzzufGwkELDzYAqNSJ3KCdxatGaahGmeWJTrKxCD+xWxbMFz3jvjOjHSWzNBeys
 HxWcqKUCSvN9x35XBmMp1wiBc2DZEuAdKHugsswGDUOwuov0eC9S17h66KLdM3xu7cpEqrvwe5O
 qoX7Nssge4lDOy4ErScHgxA2mwrmP+3Ev27WUqv7fY947PSnxiMXxjuh/huXlPXhJan+wdOQVP6
 G0wOGqVArGSCKmWDOUgPoOTbeY2vpFQvxswefvDxySxqrwbgXNvz4Ib8+jNNNXRVsewsDzH3NtP
 UxSw4vzDlSnxkB4gw70O2d0Xgm0mdlme2V/huvU6pRzzrbTTteQtUD2QVJljCpER8IEhtxyke+z
 uga7apbYkfn0fyvH7QQZS1Zi7VG+OLczoygXz35ttXPJYj9fqOdkf66JEDdnRJcAuFe48t4+B1f
 e+T/bndrIykIa3qfV7SoOMaBZaR/xrD0IkVc4N59AsCmHOrJ1yt1ijZsXFuEeqmXwpdWWU
X-Received: by 2002:a17:903:f83:b0:2a9:616c:1716 with SMTP id
 d9443c01a7336-2adbde02f31mr8728745ad.26.1771961119617; 
 Tue, 24 Feb 2026 11:25:19 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2ad74f770b9sm110077285ad.41.2026.02.24.11.25.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 11:25:19 -0800 (PST)
Message-ID: <8f6f6d56-cbc4-4f5c-a7c2-61f2b14389f2@linaro.org>
Date: Tue, 24 Feb 2026 11:25:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] hw/net: Build stubs once
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Jason Wang <jasowang@redhat.com>
References: <20260224182017.99865-1-philmd@linaro.org>
 <20260224182017.99865-8-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260224182017.99865-8-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x632.google.com
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

On 2/24/26 10:20 AM, Philippe Mathieu-Daudé wrote:
> Move stubs to the global stub_ss[] source set. These files
> are now built once for all binaries, instead of one time
> per system binary.
> 
> qmp-norocker.c only contains stubs, rename it accordingly.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/net/rocker/{qmp-norocker.c => rocker-stubs.c} | 0
>   hw/net/meson.build                               | 3 ++-
>   2 files changed, 2 insertions(+), 1 deletion(-)
>   rename hw/net/rocker/{qmp-norocker.c => rocker-stubs.c} (100%)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

