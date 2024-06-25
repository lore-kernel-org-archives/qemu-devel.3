Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48334C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 17:45:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMA2w-0003Dd-DI; Tue, 25 Jun 2024 13:33:36 -0400
Received: from eggs.gnu.org ([209.51.188.92])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sM9xk-0001c5-3K
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 13:28:23 -0400
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sM9wM-0004uD-3b
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 13:27:45 -0400
Received: by mail-io1-xd31.google.com with SMTP id
 ca18e2360f4ac-7eb7c0f9784so224840639f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2024 10:25:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719336306; x=1719941106; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HDfcigs25phKa5dg9WaS+lhTEE9F5FYPN7xjS1VDmQI=;
 b=dQp5GBX9UWwF+kLXMvj9iSjfnst5kTOO6d1mZikm+IdAoiaiL3PDNOKCeiuWzh9FWK
 hdDpgGbEb/4XRyYwj1G5DdQ7PZ81VJPFQdwvVlAtz5eJsrTiVl/Lnj1KIYQcZlVyYwt7
 t36rRzup2HosyoCO0vYK2hOsH9pfrgD1dIKi3BxfCBk08oPAOvIf6UeNbEzggRKRoqpZ
 xS07D0Q8zkowyx75KrNpncRc8XGPqKO9f5jMXanny5Cnx9Qntyj7L6iEu7Mq5gwLHzo9
 g7rD2bASlNxwpLCBuVJT8S6vY25aOJTvQseCnhwUr/ao9wlYbMH0CzJVJKuGqQGAsfYk
 Fl9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719336306; x=1719941106;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HDfcigs25phKa5dg9WaS+lhTEE9F5FYPN7xjS1VDmQI=;
 b=iREGI/+q7ZJK/A3an181SPfr68rJN2esemWCjo3rCktRlBTBtGRWltu10mkPj5iMOY
 2fG7SOCj3MCqAPzEFl3K/CteWulMtUrHHJFZL/+njH0rxfGPkIo9c0kQX5NJrhzxSShU
 hTe9JsHwIHRAKzurXNvZzbuu12ciTW8SpCY1GMNT5/XpOPmdjV7chbs3zFeY5Iqj5fak
 MFlKYflbP7KcJO7JAfYJ0RleOuB7VVd2CBMjLCof4J9DJX3so8X2q+Ib5Wh3eawt9uBI
 L4yJlRvjz1UjiN+L2KjfDuYfwGdawSNabn/iYlKSk0dlRTUQAmdC6m3tgRegUw1Zxyyh
 MSaQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjg5GTGBYbMuBkNfn8pZQyUjzYoJ9F9NCKYmuqf09oiYmgua/6gEWuuA+IJ4WzmTlWoIa7KMNrHx9kxUWKB0xc/eZS8Rg=
X-Gm-Message-State: AOJu0YyLHv1iTmv7Uf6FGrhILU1dEhLpUTCBv8B1qM6JpPZ5JhG72pZk
 /CH+//hy0J5u6lcouKD7pBDTF7mrO4QhM6Jt0PF7qN0BAE0b/x8y0fMdmaOBUvI=
X-Google-Smtp-Source: AGHT+IHqHWPOURNhkBHYuz9WWSjz58gHg7GxaRvGIAvLkG8j8j51gN7qijAFgu0iDM3TqddjO2S55g==
X-Received: by 2002:a05:6602:158e:b0:7eb:eeba:5e90 with SMTP id
 ca18e2360f4ac-7f3a75e2cc8mr1033913539f.18.1719336305425; 
 Tue, 25 Jun 2024 10:25:05 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-706a2a5146csm530430b3a.218.2024.06.25.10.25.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Jun 2024 10:25:05 -0700 (PDT)
Message-ID: <ece86d08-d75a-4c5e-83cf-957e1b8ca423@linaro.org>
Date: Tue, 25 Jun 2024 10:25:03 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/42] vfio queue
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex.williamson@redhat.com>
References: <20240624212456.350919-1-clg@redhat.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240624212456.350919-1-clg@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::d31;
 envelope-from=richard.henderson@linaro.org; helo=mail-io1-xd31.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 6/24/24 14:24, Cédric Le Goater wrote:
> The following changes since commit d89b64beea65f77c21a553cb54cb97b75c53dc21:
> 
>    Merge tag 'pull-request-2024-06-24' ofhttps://gitlab.com/thuth/qemu  into staging (2024-06-24 11:57:11 -0700)
> 
> are available in the Git repository at:
> 
>    https://github.com/legoater/qemu/  tags/pull-vfio-20240624
> 
> for you to fetch changes up to 96b7af4388b38bc1f66467a9c7c8ee9d3bff500f:
> 
>    vfio/container: Move vfio_container_destroy() to an instance_finalize() handler (2024-06-24 23:15:31 +0200)
> 
> ----------------------------------------------------------------
> vfio queue:
> 
> * Add a host IOMMU device abstraction
> * VIRTIO-IOMMU/VFIO: Fix host iommu geometry handling
> * QOMify VFIOContainer

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/9.1 as appropriate.


r~


