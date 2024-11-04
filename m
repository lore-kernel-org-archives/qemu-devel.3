Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 998DED132AF
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Nov 2024 11:21:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t7v8y-00022U-Ay; Mon, 04 Nov 2024 06:21:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t7v8w-00020J-Bz
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 06:21:10 -0500
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t7v8s-00077I-SZ
 for qemu-devel@nongnu.org; Mon, 04 Nov 2024 06:21:09 -0500
Received: by mail-wr1-x435.google.com with SMTP id
 ffacd0b85a97d-3807dd08cfcso3527477f8f.1
 for <qemu-devel@nongnu.org>; Mon, 04 Nov 2024 03:21:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730719264; x=1731324064; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oOhJQNYwL25AxmkLXSYm6FeiriVvaE2KSHEBn0Q9Xvo=;
 b=HR3KmDYo52NnH+BqpUP+5V6qFxOZvWZD0WF4PVw4WViJrGIriVs4DdMTbDheibjkmr
 o9WCUpJhUu4w/++rwvqhLuJ6x5z7uNnTOeOTp/pHiOo7GWDDGCB/6IA4AGTRfeX1k9y3
 3zmOolAfXc/k7gEnoouU+uQbQQV6vXIO5iqs4CIddMXrYEcBDGbOqcDNn7SkdHFwOcDD
 X2IeagfkstDpz27gAZaMIBiW9CO81sv+vuWV213285GesC6CTl40p4J8zfjBE+Iw89ly
 VyDKRDGMW781Qj9PENyEt18+RiAfK1i8gXChx3LHBnEfgEcQygt16pxOwQIwL1pGI53e
 NRtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730719264; x=1731324064;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=oOhJQNYwL25AxmkLXSYm6FeiriVvaE2KSHEBn0Q9Xvo=;
 b=DRoBysX8tqelAVPGEV+UsX79JnZ5hzU24SNcKyODnY01/LBl8c38kVC/Q4P/D4bR40
 8R9iRMXtlAJzphL86CMv2mumRQCpdHKQVpM1jg2zAMkPwjK3XoLM6pCe7WVDgrA7OSPW
 kx+rZ4+qW6rVX7zUVB7W3olICCgvAe7WOv+qXZTW+WC0gbIYxK5jDFF92h0kQLmTSP3p
 p6Mttf974/N3nt4LkI/fheDNOmzyuu/nju5JiIb1Am/akUXdGznyXRSrc3pIgkaMJv2u
 aMUfnSN2fCecBCjQBvpETwM/WBYPVHbQcauRZasxsG3KyVfzAuRi1S1QVuarUv2ko9Xb
 lCEw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWx3hyBNCf0P7JaEXPwATPCBmf1ddBpHmaYgaYppesArjuQEB5CjqvDxSFQOAHpHwBaoRK/yIiH01SF@nongnu.org
X-Gm-Message-State: AOJu0Yza5hAre00Oxo1IMHcdXYwqARHmU9Osm7xvXCn3naGbvm6jxvQX
 nd/bPS1eN1LQ66ojqc48fe6prsa340BvRCY897GS1zd7DnSCTAyaWHe2gR8BNfgjm4HOfHqO71+
 zv3g=
X-Google-Smtp-Source: AGHT+IG6N/gMZ9D1v9lI6SQYymqhE6GFETsev89Q0Kz7WpHYyc2Uzpamr7AdzVoyDF0OjInx2A40jA==
X-Received: by 2002:a05:6000:1848:b0:37d:5359:6753 with SMTP id
 ffacd0b85a97d-381c7a5ccbamr12006208f8f.15.1730719263780; 
 Mon, 04 Nov 2024 03:21:03 -0800 (PST)
Received: from [192.168.69.126] ([176.176.145.27])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-431bd9403bfsm180358545e9.21.2024.11.04.03.21.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 Nov 2024 03:21:03 -0800 (PST)
Message-ID: <b09aad77-0773-4c2c-9c16-02ff658956d4@linaro.org>
Date: Mon, 4 Nov 2024 12:21:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-9.1 v2 0/4] hw/ssi/pnv_spi: Fixes Coverity CID 1558831
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: Glenn Miles <milesg@linux.ibm.com>,
 Caleb Schlossin <calebs@linux.vnet.ibm.com>, qemu-ppc@nongnu.org,
 =?UTF-8?B?RnLDqWTDqXJpYyBCYXJyYXQ=?= <fbarrat@linux.ibm.com>,
 Alistair Francis <alistair@alistair23.me>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@kaod.org>
References: <20240807202804.56038-1-philmd@linaro.org>
 <D5D5RKL2WBOS.2ITT02GVC3S71@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <D5D5RKL2WBOS.2ITT02GVC3S71@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x435.google.com
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

On 4/11/24 02:51, Nicholas Piggin wrote:
> On Thu Aug 8, 2024 at 6:28 AM AEST, Philippe Mathieu-Daudé wrote:
>> v2:
>> - Cover PowerNV SSI in MAINTAINERS
>> - Use GLib API in pnv_spi_xfer_buffer_free()
>> - Simplify returning early
>>
>> Supersedes: <20240806134829.351703-3-chalapathi.v@linux.ibm.com>
>>
>> Chalapathi V (1):
>>    hw/ssi/pnv_spi: Fixes Coverity CID 1558831
>>
>> Philippe Mathieu-Daudé (3):
>>    MAINTAINERS: Cover PowerPC SPI model in PowerNV section
>>    hw/ssi/pnv_spi: Match _xfer_buffer_free() with _xfer_buffer_new()
>>    hw/ssi/pnv_spi: Return early in transfer()
> 
> Note that I included this series in the ppc 9.2 PR, because Chalapathi
> has not found time to finish the better rework. There were a couple
> of comments about style / unnecessary code for these, but that will
> all get replaced by the rework so I prefer to leave unchanged. Thanks
> all for the help with this.

Thanks Nick!


