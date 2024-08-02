Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF5A5C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 16:36:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZvFk-00033z-Gu; Fri, 02 Aug 2024 12:35:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZvFj-000310-8r
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 12:35:39 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sZvFh-0001G8-BF
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 12:35:38 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2ef2fccca2cso94699981fa.1
 for <qemu-devel@nongnu.org>; Fri, 02 Aug 2024 09:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1722616535; x=1723221335; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Sg/syVbVB0BiclESDrtbqVJ75Ct8dgvei9JvgE2+NAc=;
 b=ciRRuGT2eP6QOqo+rdiZWpxt6LrqdIWzP3cLIv5ebmRAVz3kwG4pSpUgXDlq5ixSvr
 FECbwuIS9uOZd7eEDOEe0cLzZ+20+jLMjOaI8RwhM2pjBkkWiMPCZQIIM5ovTFIdUAHx
 eNBBg8nTGNJ/nauPWAvFSatjrqDj+es7YWHOT9oL0tANn4Uu90YaQZVMmkdQliPP3mjC
 iYGeQJhK4r5n5kl18cA4I7XZfXlKmG9cz28lVTxyAtrML3q1ZyaTxwPcJ7RX+RgHEz49
 iEw7NF7h3HMCQ+jStENX6qcoLa2r+CgxcoNbnkAazmHWT/jN7fflmBiXXKX7Foo79fAG
 F3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722616535; x=1723221335;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Sg/syVbVB0BiclESDrtbqVJ75Ct8dgvei9JvgE2+NAc=;
 b=Z/Yy/7pAWtZR/bynZRXgq5YigEse38gmP0ivsZEfZUb4c/OF+rBMNDJcNp+fn28VW3
 iP7P1/cTNWfXYPKti1tH4KOcFXXzm1wrDM4L3UrnEISsniY2cU170yWHca9QVuDofStL
 F4Fp6daZ57JXO+GWYpD3NKWMYlX7LJifS3fWFZ5X4Hgfn+WNE+j7N57y6anHR0056+/d
 0mk3KzhWxG4Z1ozeFBHpalkzF9XGiOTNr1cZSsq4gVvE4ERUfkqpmIemVsfhxiATQAjT
 7LGRdImGpAZsxEydTxs9wbXpvWFEVOUSbn79GrFtIOj9adcI/TDmm4KG76FcdHU9PPPi
 /nKQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXTyAHTumWlayiYvf/YXsLImcDw0u3ohIKd+nXSXwXeQ9xQbQL0aOAwO2xPmQNr/Urue2k3rLeSDKDqV0sY3JLbMwmMYJE=
X-Gm-Message-State: AOJu0YyaGy1XLyJ0WrBYlMXX0Z4oy5rHUKiYJzXX5I53adNykVgFW4CU
 O27gUGsWuHnSEpeadccqCazlL+5lbGBdXwvBzb7IQkB0O2k3PPBuJ6JFhe82wjk=
X-Google-Smtp-Source: AGHT+IE22hiNPKGuyuopsnWZS0bZRAIM5z/a++AaruH17fL/v8sp+mGxryg3wUOjneHO1LElJfuIPw==
X-Received: by 2002:a2e:99c2:0:b0:2ef:27ab:40e6 with SMTP id
 38308e7fff4ca-2f15ab3d3c0mr26385311fa.49.1722616534532; 
 Fri, 02 Aug 2024 09:35:34 -0700 (PDT)
Received: from [192.168.69.100] (cvl92-h01-176-184-49-210.dsl.sta.abo.bbox.fr.
 [176.184.49.210]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-428e6d6ce6csm39244775e9.8.2024.08.02.09.35.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 02 Aug 2024 09:35:34 -0700 (PDT)
Message-ID: <cfb18fe2-f830-4181-8f60-bb897623e845@linaro.org>
Date: Fri, 2 Aug 2024 18:35:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 17/24] tests/functional: Convert the virtio_gpu avocado
 test into a standalone test
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>, qemu-ppc@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>,
 Ani Sinha <anisinha@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Thomas Huth <thuth@redhat.com>
References: <20240730170347.4103919-1-berrange@redhat.com>
 <20240730170347.4103919-18-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240730170347.4103919-18-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22a.google.com
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

On 30/7/24 19:03, Daniel P. Berrangé wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Nothing thrilling in here, it's just a straight forward conversion.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/functional/meson.build                  |  1 +
>   .../test_virtio_gpu.py}                       | 64 +++++++++----------
>   2 files changed, 30 insertions(+), 35 deletions(-)
>   rename tests/{avocado/virtio-gpu.py => functional/test_virtio_gpu.py} (73%)
>   mode change 100644 => 100755

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


