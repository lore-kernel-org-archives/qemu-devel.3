Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6832FC3ABC0
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 07:20:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uCvY9-00020c-Cm; Thu, 08 May 2025 03:20:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCvY4-0001tQ-DM
 for qemu-devel@nongnu.org; Thu, 08 May 2025 03:20:05 -0400
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uCvY2-0007s6-Lh
 for qemu-devel@nongnu.org; Thu, 08 May 2025 03:20:04 -0400
Received: by mail-pf1-x42b.google.com with SMTP id
 d2e1a72fcca58-7398d65476eso619760b3a.1
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 00:20:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746688801; x=1747293601; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6enYSfUE1ozC6qZPYGe5E4fbrcF1HoOPqPeInsz32xs=;
 b=X39b/EWuxNeWo1kROGc2go6lSNRIhf+Vl68RO6WPPeuAar2UMvkEriWmOLYFk9+LTj
 MpzoxtKM8/ySUkF6dTRCXRChyXq7vT3kqcCl+malob/v7R1IpROX85reoSOoJJcu380F
 MjUOFjKBrumjb4PfVjtgJl9rPUqLCLo1up3El1g3irxbdanC7EJjeM6eyW9IGxOTewh9
 uXKmtnZVwDPjzWtVuXxxsBizJWKmu4F4Tn3/X/98XTkJVbsq7TmeCxeovxT/US0dfqC6
 COV1JtKI0FShRpVGRGebwe34ikGFJ+PTEW3IkLWeKityDKEUYC6G7ZTPnRJrM/hdk0Hs
 g2Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746688801; x=1747293601;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6enYSfUE1ozC6qZPYGe5E4fbrcF1HoOPqPeInsz32xs=;
 b=sn/P7kK1hSB4FyV5ffM1aDdx2cJ7xy3ZqkqHnUFxwf8Xg+coDzT9xsSYLKleW/+k7j
 OwckIrD4aBh5EqzTkn0XHEw6OdOWOC3umhWjTel83DYv0eIj1oeCBN72SMXsYR1PG5qz
 U95wuSOvLFfSuAV//u3b6VkhTVTvxgoBFNv+mHrzCr43+Y73OYLKz0t4mCWdzln0bBYN
 yR/sceXblvMkj1ljfjmjbJV0lNgkp7pHXY281KcORK9SqKYYD3D/kNlVQGo6/5yX5V3l
 Or6S77Gil8Sikk2jOiXHMWN7xS+evPRXMZxml84RaEf4LMbaOjARMpAKgw+ONmZcmcfw
 qfSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNN/qFxfmVICuG7e46XtlctbWH2WudDsetpOo9W7X84C6JSc1SiXKWWGbb6Lx79MFEAzFk6Quvb+l7@nongnu.org
X-Gm-Message-State: AOJu0YyN8CjifWa+hY+s77yqomX7TMB9RTOWbZ+586wMFe0Mv4b+o0uz
 pWRfxO52PQ2/GBFhTfZBv+bay0PMRpB+nzZ1gm5g6m7ahXULXPn+eC48qaoAII0=
X-Gm-Gg: ASbGnctmLu25FWGdp5gxtji5omUQG1VHwlfDbVrnQha3i88OVwOBIGFbiQbRtsLC0GU
 ttsVilPxJLJ+OupZKe8bM0P+Qd57gh3WAGQFbPa1iep5SQmaaYYJfi6s+S5bNHTzgbHQOSHUB4N
 0zNhwChkkDz5OV93IFxeEZiCGEPL3K6ZYnwxtHb287o6rw1UpwAauyE8rX598SrlgkRj86wRXUV
 t1UX+4aglnwoEa8RPLHhYGGikEjWou1iEsEzEQG1kHoXJuIqg0t672//LQV6av9tywZEaz/XOgz
 RlJxmGGP34gGbfBIIBaEY3+TFvjiKHqVa7becTJCk5ZeAmfPDA977tUgprCipa1c+rcJk3QNKIS
 pVPQUzPIsei4/yXqK++s=
X-Google-Smtp-Source: AGHT+IGaFxoa8izRZrzEKN34KHYC4N6tHmNsEMUOe0ymEVggfAnKh81+T0BP3pXGLImICTVRmeg+Eg==
X-Received: by 2002:a05:6a00:2703:b0:740:9331:2cd7 with SMTP id
 d2e1a72fcca58-740a94f94f4mr3579947b3a.12.1746688801256; 
 Thu, 08 May 2025 00:20:01 -0700 (PDT)
Received: from [192.168.69.243] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74059021067sm12873703b3a.107.2025.05.08.00.19.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 00:20:00 -0700 (PDT)
Message-ID: <a5893e2f-c340-4d6c-8014-e207de4b3cfb@linaro.org>
Date: Thu, 8 May 2025 09:19:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] ppc/spapr: remove deprecated machine pseries-4.0
To: Harsh Prateek Bora <harshpb@linux.ibm.com>, qemu-ppc@nongnu.org,
 qemu-devel@nongnu.org
Cc: npiggin@gmail.com, danielhb413@gmail.com, clg@kaod.org
References: <20250507052048.90559-1-harshpb@linux.ibm.com>
 <20250507052048.90559-4-harshpb@linux.ibm.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250507052048.90559-4-harshpb@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42b;
 envelope-from=philmd@linaro.org; helo=mail-pf1-x42b.google.com
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

On 7/5/25 07:20, Harsh Prateek Bora wrote:
> pseries-4.0 had been deprecated and due for removal now as per policy.

Please consider splitting, but up to the maintainer.

> Also remove pre-4.1 migration hacks which were introduced for backward
> compatibility.
> 
> Suggested-by: Cédric Le Goater <clg@kaod.org>
> Signed-off-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> ---
>   include/hw/ppc/spapr.h |  1 -
>   hw/ppc/spapr.c         | 27 ---------------------------
>   hw/ppc/spapr_caps.c    | 12 +-----------
>   3 files changed, 1 insertion(+), 39 deletions(-)


