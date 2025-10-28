Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A605CCCF9E0
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Oct 2025 12:07:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDiTU-0001sK-Dp; Tue, 28 Oct 2025 08:06:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vDiTR-0001s0-E9
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 08:06:49 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vDiTH-0001DP-Jn
 for qemu-devel@nongnu.org; Tue, 28 Oct 2025 08:06:48 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-63c489f1e6cso9382054a12.1
 for <qemu-devel@nongnu.org>; Tue, 28 Oct 2025 05:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761653191; x=1762257991; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=DiblWjC4DiNmcx2LtiI+WmPU3NjmS1h1O2vd3ai/7E8=;
 b=yYg6JLaXmmUmccY2LWZsiMu4d3ZRr907Vw0vX+WMGRqicXh9jpGuJe676IcVyKNQdd
 xlJM84Kgs5C87UYr0t2mR9yFyHqazDCH2vKzThaO+FmLHvI/NQbsSbmY8sUGWOy4Xkzg
 copSN0MG4l+1YP2JdhHXqTjoL4D3wiONfaBA7pTks+fu0Nj4dFQMxRHla7rL7onMLT0w
 46SY9Qx3O+fD5tefdxTcFmrDCuo7TcuMwecx+P1gzDoUYQTndi/GhB+2B4UI8lh+RAn5
 xLaO260Tng4a5gx8sTEUVscrhv1O/YsoLrsr1hkBY8Q8R3cg77BpQgCfsf5ynjXBZahI
 ot9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761653191; x=1762257991;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DiblWjC4DiNmcx2LtiI+WmPU3NjmS1h1O2vd3ai/7E8=;
 b=So4jfRoQdwhP0jjNLSlubm8djyGo5g91xdBF9neKMBzVD01FESle/3jE+mANc+1Uhc
 qRrOHcM2hAQytmJHab+Tfb4PmPSstOkCiF7pyic6tWKffSAF1YgO1M9CQ5RGlO7tQhbA
 cqI3fLSUbR6nUa3pjz07wwsWG6OzOG7qpZV/9XPAo2JMj0tPF93HDGNdS4OA+uKxdmPa
 owoiPSWVvQIMIf0axqGcoeGn+M43sfM4nQ/5yJrnrV7ZV390kfc0a0yFRBoY86x5tXPU
 QiGdZ4qDPyLb6nEzWY9bPXQt4U56rEQ+E8luHnAKwH2pe36pqgaQqMAyrujotzLcNwIv
 PFKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVTfGNK974VdLAwzDvR0b+v4QOXQphFX8XyvpbO/z4oUsUIsShGGtYw+pgoHABHL5LrAR9hJoyp8iBZ@nongnu.org
X-Gm-Message-State: AOJu0YxiBYYlYK0hHfXNEqF4+XDeZ98tijUve1Cp198nsHK4c0c4WuH+
 u9IGj8VPWMae9ML4LDXmtRxttp4AJlsZLPs9AFYMYc0XrC6lj8s0EN9b6Ebj1Gb1KVg=
X-Gm-Gg: ASbGnctGQX2fs9+ZK6F5QRr0DmYrYIAXXmx+GZ+oF1vJWap/tysLOh1kovUQpkPA2qs
 0lpnwWwY/nPwMNbt7OWx6jbMXqIsohmbYMhHmsem9a344OteBbk/Ceoq7mHm1kmFIR3JkySkB1X
 rZy7Wlb0E9XOSqRqQTSvDWiyICHaNATceD+Y144yV9LjfV3Ee3Gwym2AqdjuwiGlePXu97bd7FI
 S693GyzDB4FVT3XU/WJFXCvY9aZEgveYTU47MeloL35anOuk/dyB6o3ejnQ2n+605Shejvt2PqB
 mgkC6g/iy24BLfd2wB5gTqf+uDHJ93C0ztQsxnZxl/r1/LC8OQ1nmfgINaIpP5Iv1NciT3xCTFh
 3DDy7heoMn7vX060It1oB0iv+L46IZb+LaUNnbk0PFowUro0UvwbJL1ECg4hV7ki6WGudhdCxBW
 9xsFjWAyB8tt6/3tpb
X-Google-Smtp-Source: AGHT+IGUHlIIuX9epxS+xGNB53RfyAbX7IlL0JTDzGSP/zqt9Ey4ebZeGdyj/WrrCD4RO1kQBuH45w==
X-Received: by 2002:a05:6402:430e:b0:639:db35:62df with SMTP id
 4fb4d7f45d1cf-63f4bca71b9mr2683223a12.3.1761653191364; 
 Tue, 28 Oct 2025 05:06:31 -0700 (PDT)
Received: from [10.240.88.227] ([212.144.248.67])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-63e7ef829dasm8854771a12.13.2025.10.28.05.06.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 28 Oct 2025 05:06:30 -0700 (PDT)
Message-ID: <f7a2dc18-ecad-4487-9b7d-f85618fc2ba5@linaro.org>
Date: Tue, 28 Oct 2025 13:06:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 50/59] target/arm/hvf: Do not abort in
 hvf_arm_get_*_ipa_bit_size()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Mads Ynddal <mads@ynddal.dk>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Roman Bolshakov <rbolshakov@ddn.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Collingbourne <pcc@google.com>,
 Peter Maydell <peter.maydell@linaro.org>, Alexander Graf <agraf@csgraf.de>
References: <20251028054238.14949-1-philmd@linaro.org>
 <20251028054238.14949-51-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251028054238.14949-51-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=richard.henderson@linaro.org; helo=mail-ed1-x534.google.com
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

On 10/28/25 06:42, Philippe Mathieu-Daudé wrote:
> Do not abort in hvf_arm_get_default_ipa_bit_size()
> and hvf_arm_get_max_ipa_bit_size() when the IPA can
> not be fetched. Return 0 (and document it).
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   target/arm/hvf_arm.h | 11 +++++++++++
>   target/arm/hvf/hvf.c |  8 ++------
>   2 files changed, 13 insertions(+), 6 deletions(-)

Doesn't this just lead to a nonsensical error_report, e.g.

-m and ,maxmem option values require an IPA range (XX bits) larger than the one supported 
by the host (0 bits)

?

Is there a reasonable way to populate an Error return?
I guess this only happens with older versions of Darwin, because surely we can always 
probe the supported IPA size...


r~

