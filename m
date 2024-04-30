Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 612A6C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 09:14:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1jYF-000241-Uu; Tue, 30 Apr 2024 05:13:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1jYD-000237-Ip
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:13:25 -0400
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1jYB-0007lT-Rr
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 05:13:25 -0400
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-a58989cd1f8so695281466b.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 02:13:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714468401; x=1715073201; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=4b7s5t82Qtk2HNVX1E2RkYSvx7ZAGcIt/bW0ToHMJiw=;
 b=ZfOpYOL5ab/+577oTIZ8Rh0enYBkO0xc1uCdSmsy3G4gxopkxoGhfBIF1bnR7kwp3z
 WUptZDSzQORJDW//VwVcXYmh7kSd/AUrdngQOR7t1svj08FEmKyiczxRLC0Gddw9Ivj6
 gMgQkmoNc5XfA1LWo8i9N0QSO2ZpotGWVXP89D0dS5N0RrJlP/SoAaO8yiBdeMen+wZm
 NNkc/RSoZa8UTNckYJFz2w60XwvjfhO7oxGGL/W3oLe24Z9r8o2YC6ceWyKS6sPuqDhQ
 Td3Bnqw1/uuOIzDo7rHL8CSg3OovzRNWT6ORp3onj4sn+W9yZrRLYkWDNl1X4fg1/IZL
 IfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714468401; x=1715073201;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=4b7s5t82Qtk2HNVX1E2RkYSvx7ZAGcIt/bW0ToHMJiw=;
 b=LHQw6D8RHKZsHaW0BcFlm4QGHU8A6FKUy5DDfFshaO6VLneIIo5p+EvjujztzBJNLm
 uBLGnhLJIQvjS6qDBLdhYqgOMVg6dSN6atLXLwBHXZ0Z/edg5RWo4RojhpIKQeAQSMlW
 /A1A9KAXDS5QUR95jd0LPiZAZMZRakmbSyJxDeJTWmTPAMdQ21/I5IDhwpsOwd9KPL71
 yvheKe65ROsIvbrWp71Ml4YdXp/QEXR4197vyFw9gQkfDHcScoCyUAfgDljvzk9AoC1a
 KQWrPgsWwB1kdn3fXbRSxkR5XIElXzxOr1vmnb0jeBpexd3YN8uiBAUKHaCoelu56aag
 dI5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCUsAGfzAmjMU6EBSbU+7GppR94bsDshWkvu4sOz2OQqmdzebhammzAXSpCf6S//C5dLWldBbV8QP2vblrRwyXV5nBQsmU4=
X-Gm-Message-State: AOJu0Yziy2BQrXc5M0QIlSU6UrnOeCH/P1TFY07dvbskdVyYdCImMDGz
 TC+zFWKmIfdv3PFOq29lwTCIGtliHC66rxLBGf00OXDX0bpd+Z3b96UzsMu+G8c=
X-Google-Smtp-Source: AGHT+IHS7aoE0F6fh7sc5GkzKXvZcFQm8yLKouOCvEqctQaFEZNECT1tOpHih/aH1Yai1094DzGY6Q==
X-Received: by 2002:a17:906:d8d4:b0:a58:deb8:8b2b with SMTP id
 re20-20020a170906d8d400b00a58deb88b2bmr6072757ejb.56.1714468401358; 
 Tue, 30 Apr 2024 02:13:21 -0700 (PDT)
Received: from [192.168.69.100] (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 hx11-20020a170906846b00b00a46d2e9fd73sm14918238ejc.222.2024.04.30.02.13.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 02:13:20 -0700 (PDT)
Message-ID: <e7751fd0-2bf5-439a-8c11-83cd660ef670@linaro.org>
Date: Tue, 30 Apr 2024 11:13:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] MAINTAINERS: Update my email address
To: Anthony PERARD <anthony.perard@citrix.com>, qemu-devel@nongnu.org
Cc: Stefano Stabellini <sstabellini@kernel.org>, Paul Durrant <paul@xen.org>, 
 Anthony PERARD <anthony@xenproject.org>
References: <20240429154938.19340-1-anthony.perard@citrix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240429154938.19340-1-anthony.perard@citrix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62a.google.com
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

On 29/4/24 17:49, Anthony PERARD wrote:
> From: Anthony PERARD <anthony.perard@citrix.com>
> 
> Signed-off-by: Anthony PERARD <anthony.perard@citrix.com>
> ---
>   MAINTAINERS | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, patch queued.


