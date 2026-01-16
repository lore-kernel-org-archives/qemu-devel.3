Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1325D4A607
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 07:45:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgeVH-0002OC-7E; Fri, 16 Jan 2026 02:44:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vgeVF-0002MW-Qv
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 02:44:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1vgeVE-0000Im-GF
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 02:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768549455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=YLZoprLd9Vkw98A4Oh/ld4cM7pQkpd3mlIWf7jY5eIk=;
 b=cR7HTarqXDZRFWkBvTrBFjAjpYFIVQ1i0veVvDgMXLWpcZ3ecnm+6yrgi5/SePbhlU0uUX
 BcO70YIsbaTT0CL7eWZsn6flxvcbl6rJhwJIegvXp0k6Bu0R1qPlaQNB1YoDbspnfxJf/W
 i+5mhZ/4MVB+hQt97X4Q9fTgBCcSpEo=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-puLflReQNcO2fYqZidq-BA-1; Fri, 16 Jan 2026 02:44:13 -0500
X-MC-Unique: puLflReQNcO2fYqZidq-BA-1
X-Mimecast-MFC-AGG-ID: puLflReQNcO2fYqZidq-BA_1768549452
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-b870870f1aeso401042266b.0
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 23:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768549452; x=1769154252; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=YLZoprLd9Vkw98A4Oh/ld4cM7pQkpd3mlIWf7jY5eIk=;
 b=k9/MGji+O7zlgJvCqFGr4AQX4oj9FbFJTkmESK/CkbORckVoqjDJsAJZpAb3MZeytI
 dQ+mPHwS1yuJy9B58CXgJiCAywEtAkJte2OihCL4k0h80cQQNRPwPh5ZP69Hp5VFLfys
 6RDaKUySn62lla8vqZ+hEtiBoCAPC5GpsYaKj0o24YJqXRp9NjYNZu0xjearrZpo3k9G
 pY0eIgBosvHXR5wbWHGFEQ5CVYzmnQsqTQ7zH2wjhCEykgR7Eo0JrJTy9nt0OGCW4qr/
 wDd/czoeDo303lSuW57tAJaxNtlTz31vFP/XdJMxN4cX1DepGdskSPI7HSWsLbR49Te9
 6lqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768549452; x=1769154252;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YLZoprLd9Vkw98A4Oh/ld4cM7pQkpd3mlIWf7jY5eIk=;
 b=oyPq0am3SvyFORQAEGDvPg8FjS3ZiaVtL6nUmUD7Kno/RPAtSgxtE9HoGgB3ubne92
 QEMDUzYaXuddJtGMD2vD+LGGeo93X1ZLO01G/cMI3OrjYu/CbJZ3VFB+3GGgGSoPJbHD
 SoZdAHoygj1k4jNeNUDLWgdOYILNRJTqRHnIM7DNJFXFdJ8xJk01wn2p62enpjF+qBdC
 omjyMnIYdhVoxMQgL1Fg/uFc6vXMIHd6WIhyBAxJtbK7scqUilFokvwdbyv/x36P0162
 POUjuIhXWZ2qmtY989Eu0qRsHVO+DkYwvxX13mGCJsWvDqhLFq0kSyBVYWKkoPuEuyR4
 ufSQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVwc1f4GSg4lEpqZfxM+CI89UB+pYaYefRdJhX9A7J3wQQDtccUg3Zv4wJ/+uBnsSzb+BPsz+p3nvsk@nongnu.org
X-Gm-Message-State: AOJu0YygW6OZEaQw8YhBvqAAPrPkcD/2AApPOtrsxUEAKAh2FAzGAivV
 OkleOARsBdoLo5bu8b9uJ5U3V/515eXQqCkxbFVm1/5/z5Dg9alnNOhKOaYcfDOyfFpCD08es2P
 QVfGlXsGRFeNKhBZXTSdD1Ec1GtSs6M1haLKdY2IR+cUolssDc1N+kFXs
X-Gm-Gg: AY/fxX7JdLe601wwTsZ3NdcqBXzumaW3ghO5oVlBFowV2n83KyEdjjQVUEPr2HFyM0Z
 BjSA+7HjS81BcQxXZzE9mPyyEl6x6Ggs3kcW55b7uVbu1+3Ng3K93q9mhTfCPyl8tBMEcDaJYbe
 4uNo48xHmT660CptVUGyHLJsGwLKKbZ80jOb6AXR2zisNQdwD6akimyUxjfQgWIFsWvN3ijpsjX
 Y02+SGE172iSp0cGrO53FmOtKw1CWUAs0fZZKNz1nXUBMQ01uIvYoUWpg4X9mjZrMRY5gXS2wRt
 jvbANLUIS1XrFDJAmULE7VEtktqDx5veJdpok39pTC8dEzFM0J8L+NWrLp3z04mImqg2mfNxX72
 Do/9UWFs=
X-Received: by 2002:a17:906:9897:b0:b86:eeab:510d with SMTP id
 a640c23a62f3a-b8777bc5e2amr397568066b.15.1768549452283; 
 Thu, 15 Jan 2026 23:44:12 -0800 (PST)
X-Received: by 2002:a17:906:9897:b0:b86:eeab:510d with SMTP id
 a640c23a62f3a-b8777bc5e2amr397565966b.15.1768549451889; 
 Thu, 15 Jan 2026 23:44:11 -0800 (PST)
Received: from [192.168.0.9] ([47.64.113.220])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-654533cc45asm1708863a12.21.2026.01.15.23.44.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 23:44:11 -0800 (PST)
Message-ID: <e461d2db-c09c-4bf9-ba23-b67878a9cf35@redhat.com>
Date: Fri, 16 Jan 2026 08:44:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 10/14] tests: use 'driver' as collective term for
 either format or protocol
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: John Snow <jsnow@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Kevin Wolf <kwolf@redhat.com>
References: <20260115164756.799402-1-berrange@redhat.com>
 <20260115164756.799402-11-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260115164756.799402-11-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 15/01/2026 17.47, Daniel P. Berrangé wrote:
> The I/O tests integration previously exclusively tested block formats
> and now also covers the NBD protocol. Replace references to 'format'
> with 'driver', as a generic term to collectively apply to either a
> format or protocol.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   docs/devel/testing/main.rst    | 13 +++++++------
>   tests/Makefile.include         |  4 ++--
>   tests/qemu-iotests/meson.build |  6 +++---
>   3 files changed, 12 insertions(+), 11 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


