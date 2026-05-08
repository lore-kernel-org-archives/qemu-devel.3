Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93238CD3436
	for <qemu-devel@archiver.kernel.org>; Fri,  8 May 2026 08:11:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLGIS-0002Va-KO; Fri, 08 May 2026 04:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLGIQ-0002TV-Tc
 for qemu-devel@nongnu.org; Fri, 08 May 2026 04:10:54 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wLGIJ-0002xa-5n
 for qemu-devel@nongnu.org; Fri, 08 May 2026 04:10:54 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488a9033b2cso16097775e9.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 01:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778227845; x=1778832645; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/XHjoh39IpiuQb/DDadtgvYMDj4z4B69De97mhbmmpk=;
 b=T7ps32B3UK/kpfroYnGPPRXM2ibqBpTGpyjmlqn3T5jbSKCYOUzAlURHihr2epyVdM
 L17riTsG1/uLagksVaCyHz3blPvFS+ll3eogneEgvnSjHFRwyUKSFW89tWFR9b+87XfM
 ql2brzRI/Jpr0Wiurj2E5pSYNgfm9eQFosTCfKeh3CvaVpu+99bRXjOuj2bjaNNEptI0
 Vqe4SOM4np9lgr1sadGRa7cuHzTeJvYOjDPFWLsVuzHaAddO/zevw3KnmauSx1o52mJa
 lh2ZENJEARTPuzkndr6A4/aRDiGTa73NjPP4AMYncWAHw127/SWqmEUniX5QV5CV2dwl
 yHUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778227845; x=1778832645;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/XHjoh39IpiuQb/DDadtgvYMDj4z4B69De97mhbmmpk=;
 b=Dm3U7F0OIIsDV6XCGAgsq5D9AXqqval2SORPMx/LGl3zY0a9bcU0ZncTkUQyCuMMM8
 mqsgVMmC8DVpn0nlUBjjhd4dQyDmCDW/mJn1oxZXPVOETLeFgzuqi7U6+9kqiD7trQQw
 /4AuYq5/+hU68YtOGcqJTB3BYSA8SxkgE/0e1j7WSiSyYg4SmBtL1zXvSOU/AcPMYpox
 LULHalvsfXpL4g6dZL7fhHNcFgdoqHwnmSedKTmbkn4LEncLvmYA0hE/1PO/lZMfF+B4
 Oz+/FnIMqw7ZoOW9+DZEraK6WfRoMVbkQSOYmmsF2k6cLDh2hvI7EghqiR16SdFO+vw4
 3nqA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+85F34OrMA2ZjSQZeDWpk5aLP8LGlC6uzWASR0GtTDhOW5JkUPdixOyqdANz2HmUIkOO2+ecN53ke0@nongnu.org
X-Gm-Message-State: AOJu0YxwLYTOqeC4X60bCKUt7EXzpdsttUiLkfq9EOPxzeGB2VwY32sO
 EfFkb3pN3C2CcNsrzagHitBtVJcaAZAThKBdUkLKykpdozh7LneXvQaoUDij1Iw+x40=
X-Gm-Gg: AeBDievRsW9X+43Ghzryv18ReW+YGM0Mq1G3tiRN9UEA4eD+h7DZFmHQKq6ww9onDLH
 +SC2INbpr9JHF6ZntTcue/Ja0Ls835rSrxs9q+IRY8Zz1LtsP/grgIV7Fw2A9HeDsW+dFoNOPWU
 7UjteXo9PAAf89W0Ccgb2PNL2o84KJg9FEPNLHCAaY/onMI54h9NHDZA0R6Pnt+VViAyKtnqaRE
 V1vCFOASCSqGw19iKOvDXMZXJUekvRyy1AGAnxXufFlqcMdgiIoZSoh7367o2Puiagbnix9c4Xi
 c39hN0Sriy7aAEecvdFrs+fdUB8T8jchZEmLImVz2l8ZMO31QUa7nsSlHmuhs7oPfFgjC3Dw0W7
 G/GZGujWPYTPy90FcLqkohTiXvJ1Xc7jssW+De2sG+YP0BWgo3pQ3RRK+yYLGAkx4uk4ubj6n3o
 qvyfAB0m/X42jeb8mWbCG/gwl+0xHkh8RVz5pd7jrBkO8xcYrgQ2AfRfRKxyMtfYtC
X-Received: by 2002:a05:600c:c107:b0:48e:51f8:eb37 with SMTP id
 5b1f17b1804b1-48e51f8eb65mr140801755e9.25.1778227845527; 
 Fri, 08 May 2026 01:10:45 -0700 (PDT)
Received: from [192.168.0.200] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e65c041b3sm16943825e9.9.2026.05.08.01.10.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 08 May 2026 01:10:45 -0700 (PDT)
Message-ID: <ced7031f-45ea-46da-abcc-09fc4edb4ed7@linaro.org>
Date: Fri, 8 May 2026 10:10:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/6] tests/functional/test_kvm.py: Use -cpu max, not
 cortex-a72
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
References: <20260507194728.2034696-1-peter.maydell@linaro.org>
 <20260507194728.2034696-4-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260507194728.2034696-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 7/5/26 21:47, Peter Maydell wrote:
> The test_kvm test claims to run on any accelerator supporting
> nested virtualization, but it specifies the cortex-a72 CPU.
> This doesn't exist for KVM-only builds. Use max instead.
> 
> This fixes a failure like
>    Output: qemu-system-aarch64: unable to find CPU model 'cortex-a72'
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   tests/functional/aarch64/test_kvm.py | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

