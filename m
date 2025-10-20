Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC4CACCD1A2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 23:03:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAytw-00057x-As; Mon, 20 Oct 2025 19:02:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vAytt-00054c-TK
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:02:50 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vAyts-0005sC-9L
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 19:02:49 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-7a1603a098eso3020509b3a.1
 for <qemu-devel@nongnu.org>; Mon, 20 Oct 2025 16:02:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761001366; x=1761606166; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z2um92yXr1aIjgkBdR9GQ5+cVtbbBFhBD83xlz0b/hA=;
 b=znI6V00BI6jYAwVBd8VD3y0NP81q+DxONSn6NmOVp3O8h4G/myqVlF1nkpbANHdzNj
 7zrd8LZX7XEsdy2EDsg6VuJtWjjHC+Q4b6WpWsZLNwkhBqv+hKHJhJPZRh+CivaGMnxp
 mW0RUeKQsMb8xd+Ev3CNwGW8vEhbsJSmZ4koPIvV9IbcqCrux1Vgwi6Ha91K/3N3xCLQ
 LY3jUsvjI5/dElpChClGyqkRNCEqQgk18N03EkZpP70HX2uAll7eyyHZoNG592QEC0hX
 5PrtlFYlOhevrIRHbXiJNrbkrmn0dF0EbIcXRjYJpvQyODX3x3G1i49eKB+Qf/KvbS19
 0xPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761001366; x=1761606166;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=z2um92yXr1aIjgkBdR9GQ5+cVtbbBFhBD83xlz0b/hA=;
 b=BaEK7u7vc/QQNEo4HIJ1y6xgkRGBZJM3JTdFf7G9PupeudK9jEd8l3g0vF1wD1Mf+5
 H+fmqHXu2yrmZeaMNGyqjDAy790gjCow7Z2R5uPWj123qs0wIsw65wBnOGDLxFBPWdKn
 n+COpQQ2q2Qt+LXrnt2N7pdfok1+WQbQjIKeV7OfM8yrC+EbwBfsf5CmhxN4VbfWCNRR
 8Y9fxk/nXxxtVzS9V71gaBdWMUMDZba4uGcjnQ/7dwWQaUBw0PmT4YsJA+1IQvz63854
 zWSwc/P8/ZwhSz/xFn88ME7Id1EpF5nVcyeCLOcGmDfwTKtKmst/SBWlr1SEkkNIYqJ8
 /R+g==
X-Forwarded-Encrypted: i=1;
 AJvYcCVb8BUsqshrHJTiXIVYXogjqppsZ0SvCF1uBjOjyuoi7YSrl4j5JrBoSVd0UoMBTuq5o3v2XFgE035M@nongnu.org
X-Gm-Message-State: AOJu0YyYknYbC+a6ajp3FoWinnoDqRiGIcTVXhWevMz3GluBUYdv2a1Y
 XjQ0d0a5P5c78mVl96x0wv5A44eDkjyG5rilgLCkg7h+NMDR32cN8TXiC3HoioYzQZ4=
X-Gm-Gg: ASbGnctF1GrBZDo5sfuq0476vGwXrPFaK2F5u+OiYQAus8E7OqmVIptKRBfoUICeWZm
 eugI6dFwc2j+21bi9UX/j4OibPVhJANp0qJxh15Epj0VGO3vOKc2+vn63U4byg5ZCYofiZTdtif
 ulNXYhfw9bHzN5uBdHi53S4mRHwyzLxn1UR03102rGlyibGLj0nEsoSw9OnXSRyPBEGSsqmjfR5
 dCCaYoeJ0IuMDOEHp6Auuimw01IAbJDt6tzItGdsvNHMZVlykNoaRIQEFRXyEEwMH6qvPnVJ+e7
 incVfvqkVVl62Y5OnscCW96ABAwNfY4th47jj20nUgRMs+ArRReMp01JCSC51dzuVksegIGTZ8G
 xHraL3P5uLQ6iXCX/nQCVTN25ViSShYict42UHLc6mVl/heF/8lsXpjCuLVHTcAP348BhIqf8a+
 xDp6Pa++QRbS2lLQ==
X-Google-Smtp-Source: AGHT+IEBIyQN4SCFFQ7hdXsAs4JWBKK2NtyulPAwRd8PaO/NuVZIubmQec1t9h9KuJp8t5gwY+wKpw==
X-Received: by 2002:a17:90a:ec8b:b0:32e:a10b:ce48 with SMTP id
 98e67ed59e1d1-33bcf86c996mr21051673a91.12.1761001365852; 
 Mon, 20 Oct 2025 16:02:45 -0700 (PDT)
Received: from [192.168.1.111] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-33d5de14becsm9177503a91.10.2025.10.20.16.02.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Oct 2025 16:02:45 -0700 (PDT)
Message-ID: <f853622f-ac71-4e17-9f64-699e91636da2@linaro.org>
Date: Mon, 20 Oct 2025 16:02:43 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 02/30] hw/boards: Move DEFINE_MACHINE() definition
 closer to its doc string
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Bernhard Beschow <shentey@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>
References: <20251020220941.65269-1-philmd@linaro.org>
 <20251020220941.65269-3-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251020220941.65269-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x434.google.com
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

On 2025-10-20 15:09, Philippe Mathieu-Daudé wrote:
> Code movement to have the DEFINE_MACHINE() definition follow
> its usage documentation comment.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/boards.h | 34 +++++++++++++++++-----------------
>   1 file changed, 17 insertions(+), 17 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


