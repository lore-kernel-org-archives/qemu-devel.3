Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CB4C9C02181
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jan 2025 07:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1taUn4-0002Ne-HF; Wed, 22 Jan 2025 02:04:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taUn2-0002MK-Og
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:04:40 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1taUn1-0007Xz-76
 for qemu-devel@nongnu.org; Wed, 22 Jan 2025 02:04:40 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-386329da1d9so3581848f8f.1
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2025 23:04:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737529477; x=1738134277; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=7pj/ihPJuBcNz0/5dD2cGL0y/yLv0+ZqAdXx5Ookdpg=;
 b=ax8+aY5O4Jhh6DTn2o4Vim3o4dteQUw5Dny4qLveVjshxWnsxPAFVGrp67vuWj+SjA
 Or6xoWvGZnCwifdZFwgB97zC5f85SWE3Z3Nq7Sjrc91e1GUyAmDQi7quAWZSW9VUKCTQ
 uss1Yn8jz5uYXtBswAEC5TFg/cZAfi/+gN2Dh6JIpT68k06mTBhpuyuVs61qKjNZSrYj
 jw2yRNvXP0WArVWOm8KHrvNT7I9bhVEXXPpgQ1UQatQcBiM7hZWqdaKn9d6Gybba5Ig9
 4yDnw0HCNqYTqiXIeMTR3z+uPepGhDFxl0mNkXACou4zxM6HiBz5Qd79jRk4+DwPURFl
 m2mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737529477; x=1738134277;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=7pj/ihPJuBcNz0/5dD2cGL0y/yLv0+ZqAdXx5Ookdpg=;
 b=XTTvTR+n0lUThEbKaWcucxWZ8xryc+GOEYItuSKpNGzuQmTViL14uexLdRIykPrC/Q
 ZP5GIQDJm3iFOdOuPFx7hpV3aszvDZbFNdfAIuJutHsOjz9hp6UelLxU7EzVQ6OHgqK2
 DgWBW25b1zskvrhQ3Uh1bA9sCEu8SXRv2ot344Xq7enBvbVb12qxmMYQDNenfca9oPL/
 k3gyaY+Sqi4DFX5APWtyIlLcdYqLmFfcDfPMW+UCQzRyZOfSvADN9wrkWtxtZMdrhxqf
 950x5ZABqw2kUmzLM5LgiW8KvH4K+W5+2ZNAENWsQAaX3nziqrgAPM9LIVceTKJnw+9j
 Pcpg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWuNfVgKidmvoaLf6AA3+12Uk1sd+D6zY8C8D5fhhovtv5hkqzmLyrqZfnh5t1OcJA8fFWN7iKstnGW@nongnu.org
X-Gm-Message-State: AOJu0YzM778/bSU+67xUcvQ90+sK/iX8m1M7VCNah+4UcIsHsbPkyzfO
 Z8HfDqydGQaE07PXEVk9xg2XV/fUN/4qNNeGmCfEbxQ/kLnYo96DzIV3fcVwYgc=
X-Gm-Gg: ASbGncsk6PV2r5ONiBa6EYsP55HM1K5r2+hZ+vDQ1v1XLo9LznZYbAoBdW8iIo9CCvV
 T9jrbVAZDaVN84Zyckz5UP6rpfHGpSfz7dXxmhVCgxWS4tYIrCA9YJ9QSnZzwrFjGR6GzdJYWlw
 3kdrQcP8jHr+NoVB7FUd5OtMT+VEuSTbZzRYQ/K6xixbozJ2YTbxxgjwdEXFYSy99uCOejEimRm
 OGXFFRwhbPaA0n1nDOrekpwINPQEkwSRL5AdE8Sp/IZmtP2NxnARmK+xIlVPqiEpBuHxgbbgTEO
 C48jvLwmiLKubUFTafVeoGnK9xSqG9oiGcNlDQ==
X-Google-Smtp-Source: AGHT+IGKVV2UsBDcnt02eUyI/tAWIADMUfjQHqcXRufNhGJOK6j+O6MGPyMCEFuaxK8CLWhyP6PUXw==
X-Received: by 2002:a5d:6d02:0:b0:38b:ece5:5fe3 with SMTP id
 ffacd0b85a97d-38bf565560amr17011979f8f.1.1737529476547; 
 Tue, 21 Jan 2025 23:04:36 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38bf3221b65sm15733214f8f.33.2025.01.21.23.04.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 21 Jan 2025 23:04:36 -0800 (PST)
Message-ID: <062091f5-627b-4369-a962-2c661f290549@linaro.org>
Date: Wed, 22 Jan 2025 08:04:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] hw/pci/msix: Warn on PBA writes
To: Nicholas Piggin <npiggin@gmail.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
References: <20250117172842.406338-1-npiggin@gmail.com>
 <20250117172842.406338-2-npiggin@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250117172842.406338-2-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 17/1/25 18:28, Nicholas Piggin wrote:
> Of the MSI-X PBA pending bits, the PCI Local Bus Specification says:
> 
>    Software should never write, and should only read
>    Pending Bits. If software writes to Pending Bits, the
>    result is undefined.
> 
> Log a GUEST_ERROR message if the PBA is written to by software.
> 
> Cc: Michael S. Tsirkin <mst@redhat.com>
> Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
> Cc: Dmitry Fleytman <dmitry.fleytman@gmail.com>
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>   hw/pci/msix.c | 9 +++++++++
>   1 file changed, 9 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


