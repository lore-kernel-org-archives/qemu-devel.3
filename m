Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F275C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 11:21:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOF5R-0004KH-0m; Mon, 01 Jul 2024 07:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOF5O-0004Hs-JY
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:20:42 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOF5M-0004eC-GM
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 07:20:42 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-425680b1d3aso19792105e9.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 04:20:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719832839; x=1720437639; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=zOiJPBPWUzVl7WVl54hnbFaILNRK3SzH3sCQhMNGCdw=;
 b=JFMS0r7LYAkDjx9/vAvUnnx7gAWQnSVwLlBLxiTDzlvtmuXWUmK63BkrZqhd6WQkUa
 U+5lvd8CZQ/g+gY3r/zSuehwu3MWK3Q/wKzne87te7QKjxKNRDTPt89dIZ1IULzTar1F
 6h2x6fwg4NTPqUI491KwBl+jh2WiPxnRc2EQr0/66fh/Yu+VzqNue6Z3RrSA6yn8WDjj
 RXlpNcb/fZCyXNaZ7luy4ppKb2OW8AcRXAkHwZNKhV2UuT8AQYx0nDsLnYudeiZKvAHT
 OOga95G8bytHx0gjyxWxpx9NhMD8hX59mtf0NchcrVqmxnOFPPMJz5jaDQo/7DEhtbAW
 gJqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719832839; x=1720437639;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zOiJPBPWUzVl7WVl54hnbFaILNRK3SzH3sCQhMNGCdw=;
 b=A8kUZX9775NoGXkOH3ZJbxttZ1msTAqkiehyEffJHpcu1dUXoZm4Tjy5L8QX8yaJdY
 SZpmQpq8JefeUhGka3pfQDqfHKnp4zyL8uA/iafAhFwzd//J7nHmmJZYFvWhfR0b6fVz
 4Kkhhzy6FzmDnfkkEDIFtI8Wr2+GJe/WN+DHrljiMs6vKcbjzHxT3U3UkAeMog5B40yu
 BbgIThpS+5F5C5ZUm6LdI3rCQeKfF8mKuIh8VfJie++Cq7UzHv66R8YsA9uGpHwanGbV
 G+iZPvfRMZxHlXJ/uhiYB+aAVkiVJR6SqCwzi7bcUztBP2SSNtZS7Rt2tZugQz4wJPCE
 3oqQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWkeOZvxPIjpADjatZfab9WGyYxczeejFZtiK421xx9xlJyL6lBJCV4hA7GZf4Pke61qmPPpTzsmmfxjh+Ooto9TaS2+wU=
X-Gm-Message-State: AOJu0Yzb1t2jIOJwld1QSyhGUIvnob34dvY/16QHltzWGlnapxwcYdlc
 R2WPD1IXnA3cKSdBa98z3ArIDpW2JnXvxaNQQD2bkXJEcKWY3PVbAxm+TGevFv8=
X-Google-Smtp-Source: AGHT+IFJq1PeUB9se9yMEn0vfckw+ozmkKTBC6JVSL3ynCua7CfXMTirwIknZsco+ycQnLVsV8gkQQ==
X-Received: by 2002:a7b:c7d9:0:b0:424:a7f3:1360 with SMTP id
 5b1f17b1804b1-4257a03c07bmr40452915e9.17.1719832838763; 
 Mon, 01 Jul 2024 04:20:38 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.159])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4256af389efsm149589875e9.7.2024.07.01.04.20.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 04:20:38 -0700 (PDT)
Message-ID: <e175720f-6fa3-4c7c-b801-1ade72c1e5e1@linaro.org>
Date: Mon, 1 Jul 2024 13:20:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/14] hw: set deprecation info for all versioned
 machine types
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
 <20240620165742.1711389-11-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240620165742.1711389-11-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 20/6/24 18:57, Daniel P. Berrangé wrote:
> This calls the MACHINE_VER_DEPRECATION() macro in the definition of
> all machine type classes which support versioning. This ensures
> that they will automatically get deprecation info set when they
> reach the appropriate point in their lifecycle.
> 
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/arm/virt.c              | 1 +
>   hw/m68k/virt.c             | 1 +
>   hw/ppc/spapr.c             | 1 +
>   hw/s390x/s390-virtio-ccw.c | 1 +
>   include/hw/i386/pc.h       | 1 +
>   5 files changed, 5 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


