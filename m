Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A1E0C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 12:55:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOGYD-0006vk-Cc; Mon, 01 Jul 2024 08:54:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOGYB-0006uQ-5S
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 08:54:31 -0400
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOGY9-0004dT-Jd
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 08:54:30 -0400
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-42565670e20so23736815e9.0
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 05:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719838468; x=1720443268; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=kzeyjvgQpG4r7VOdxEXPvtwdkTnrdxZEbwn5+b9xlKI=;
 b=HAdmjd/zertB7E+XdRZtdlBQUBf/BUe9/Jo4AOmpC3TV9Vi/bpm6C0traQHEkLBbtO
 dj/X8w2S7QH2zX5IEI+UYw+MKczaG7q6VLyJ7u9z8pu1fgRP2/Mj9tRjtpfuIqnuIa/S
 NIG4tjUtdizkfRtO4wKghLjKfcfrWQ8BFrvrLjN55Lcum0MK/KukikJDwayCbvcodFOr
 g3ne9HypXoSxbTc9KiXGstwTIoL4j3xKmA+E/ok+imETU3QJyJIDtGaJ/IjoEvl24PdX
 uPzrPvlzG9J5cj7n7Hr+NIKJWoB9NzmGS/TvwBlUMkIAo5PjsBJIOMMHWEwmJHexw4ZT
 EaWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719838468; x=1720443268;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kzeyjvgQpG4r7VOdxEXPvtwdkTnrdxZEbwn5+b9xlKI=;
 b=oh56W5QBmVAHb5INLVJXWmZuJlwClZpK9uu2zCRyaFYNGTXQ1pCmqgg0Xux2R6kt+e
 hYhvi3PioQqWtaTgUuaVSvsFOEWDyPG8tej3NxyeMRfkrY3ny78zciLPBNoMPfUNy6uI
 1ItJPXScctnagCjiFN4m7wCmPn+knCpgBsRG9TONWqXW3BImQs8Bas44o70ShU+ize5O
 4PVI6rJ+ClyfwguOSlMAowyuQ4Sgm1sFAtel1EVVjHHYxyCCvVWT9a1oLJLsCKlGiIPL
 fZQU237VAGvTymrXy77aRfRF9hohj9JqTp9GrNe7BRXXw5TQOU4Xh8dRI1xEe85hB9ab
 x2YA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV9ZomFHcjOYRrHEq1PORL7E7KcQq+iqi7/mdjSsORbmSWhDX5lYSeKxbk/D0PQrtzcBC7f54xJdPcRikTsWwTItqZbneY=
X-Gm-Message-State: AOJu0YxT3mgKZYRP4H7dsmelr7VfODlf00Fh9lSg8b4hiE2D4tz1kWeU
 l+HhDwcY4ukO026wri3GDCGbjSIhTFuD9/Ww2QkMwOATSNvaicKeqmBKnle+AKs=
X-Google-Smtp-Source: AGHT+IGoFNqRjVgdspUfrGpF/fiX/Cra8cOtBtiGRxoCOzMSXQ4ih77Ggh5z8fzXXUFz4KKGgRRVFg==
X-Received: by 2002:a05:6000:2c5:b0:367:3404:1c06 with SMTP id
 ffacd0b85a97d-3677acb5d0amr3192123f8f.20.1719838468088; 
 Mon, 01 Jul 2024 05:54:28 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.159])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a0e1430sm10009025f8f.52.2024.07.01.05.54.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 05:54:27 -0700 (PDT)
Message-ID: <e0691cd4-283e-4a31-a8bb-37615bb139d0@linaro.org>
Date: Mon, 1 Jul 2024 14:54:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 05/14] hw/m68k: convert 'virt' machine definitions to
 use new macros
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Halil Pasic <pasic@linux.ibm.com>, devel@lists.libvirt.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 David Gibson <david@gibson.dropbear.id.au>, qemu-arm@nongnu.org,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clegoate@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Yanan Wang <wangyanan55@huawei.com>, Eduardo Habkost <eduardo@habkost.net>,
 Peter Maydell <peter.maydell@linaro.org>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org
References: <20240620165742.1711389-1-berrange@redhat.com>
 <20240620165742.1711389-6-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240620165742.1711389-6-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

On 20/6/24 18:57, Daniel P. Berrangé wrote:
> This changes the DEFINE_VIRT_MACHINE macro to use the common
> helpers for constructing versioned symbol names and strings,
> bringing greater consistency across targets.
> 
> A DEFINE_VIRT_MACHINE_AS_LATEST helper is added so that it
> is not required to pass 'false' for every single historical
> machine type.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/m68k/virt.c | 51 ++++++++++++++++++++++++++++----------------------
>   1 file changed, 29 insertions(+), 22 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


