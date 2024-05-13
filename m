Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADD3BC25B10
	for <qemu-devel@archiver.kernel.org>; Mon, 13 May 2024 11:50:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s6UCG-0006Zw-L8; Mon, 13 May 2024 07:50:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6UCD-0006ZR-Do
 for qemu-devel@nongnu.org; Mon, 13 May 2024 07:50:21 -0400
Received: from mail-ej1-x632.google.com ([2a00:1450:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s6UCB-0004uR-Bt
 for qemu-devel@nongnu.org; Mon, 13 May 2024 07:50:20 -0400
Received: by mail-ej1-x632.google.com with SMTP id
 a640c23a62f3a-a59a609dd3fso729122566b.0
 for <qemu-devel@nongnu.org>; Mon, 13 May 2024 04:50:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715601018; x=1716205818; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=6hcvksixmUasNz+CeVA12QiFeszh0CoPYpHWqqrjNrE=;
 b=oabpGawHlbF/IlA6xIic018andxHVQFK2voNM+FGdNAYFT+xtqFMm+I5akT0xaoawq
 l9biQwHvsxfH4z93JwP/tiEyuQ1T2G3ZCKaNXvyLasHrx5r0FWoiETuTaTBfr8V/mD0U
 ihZFgBW1YOJnavfi82YmzsknBPJxFScjBt76C15DtqhMEPnJ0+clhVU/dSi55UH6kNSY
 Acq7psr74Vxfm9lmEV5QuPfB1yr5Utol3+CpSOYS9/b/qJcVKYVVroLEcBvpbBB3ZaAD
 3CJHLDPxJx05Tg8nTc9d3mjDnNFbd6g5UwD44F5uQni4QHBZ9CfQXa3lFqXTlXGMLzNS
 4xxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715601018; x=1716205818;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6hcvksixmUasNz+CeVA12QiFeszh0CoPYpHWqqrjNrE=;
 b=xRrVJ8F2c7IwuVVadYSUJFOCRhbDDR+5r470dImViUCqFI1j1yuDgLI1jdV8LIyN1D
 TK/X4HD5fGZOS1BpPt/rv74bYQE1Z5Srcw5QpeERQrvtgTc4rzEUE4oJUI52caBBxZ+X
 0zpKdb1LEvpX4UrrjvplCbae3Hc5G/CplIXkMAA+iZOv4J6/WY7Gr7YIuAx3Xgsj0h/b
 DTzUw1456fP03KPYbMgZeSWYmcpCJpACFzdFxi8ccND8wx8rTz6LWJoirTTZoCjB7bz5
 rKZy81BGjJ7nyLbBM+ZC8NRgpHYGTp62VlTW9XIYf5YXEX7SQ8zcaeiRKeumqzaOvaPl
 qAew==
X-Forwarded-Encrypted: i=1;
 AJvYcCUeEQltl9eE4D0Wrjf8qe1tr+D9KFb5QPVjldxUbsVF0QD9JvqrQbX225I3/4Efq0wPcWkOxHlogiCf6IjTQVmE0r+ukLk=
X-Gm-Message-State: AOJu0YyVE/dxKduEUDHhI8UhNaKrFwokbhOETU15rEtCujLY6CcSsvMg
 frnffhItE1UdpRdmPN7WuZWjBi7GCXzJVHa4p6qpliseX7ln9YGrQeWMRbvmjyA=
X-Google-Smtp-Source: AGHT+IEr6Ul2azA0WwBiVUb149mpLPmwfP8FHl2LPhaoWe8z0ZTEwrglcDjoe2XcCxoJCmzadz6TrA==
X-Received: by 2002:a17:906:b098:b0:a59:cf0d:d7c8 with SMTP id
 a640c23a62f3a-a5a11601484mr1095578066b.15.1715601017861; 
 Mon, 13 May 2024 04:50:17 -0700 (PDT)
Received: from [10.1.2.72] ([149.14.240.163]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a5a179c7f49sm586242666b.101.2024.05.13.04.50.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 May 2024 04:50:17 -0700 (PDT)
Message-ID: <4b340144-87d3-484b-84e4-cbad0f54ecc9@linaro.org>
Date: Mon, 13 May 2024 13:50:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/3] gitlab: use $MAKE instead of 'make'
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
References: <20240513111551.488088-1-berrange@redhat.com>
 <20240513111551.488088-3-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240513111551.488088-3-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x632.google.com
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

On 13/5/24 13:15, Daniel P. Berrangé wrote:
> The lcitool generated containers have '$MAKE' set to the path
> of the right 'make' binary. Using the env variable makes it
> possible to override the choice per job.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   .gitlab-ci.d/buildtest-template.yml | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


