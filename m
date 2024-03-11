Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B2FC5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 12:03:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjeNN-0004gr-Rr; Mon, 11 Mar 2024 08:03:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjeNJ-0004f1-9u
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 08:03:26 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjeNH-0005Ec-Hz
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 08:03:25 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-33e92b3b5c9so1277029f8f.2
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 05:03:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710158602; x=1710763402; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dV5UyBtfTTwJ57CNR7ZwV91eZXWHKrV3a0l3VoK3FYI=;
 b=OZLavTV/xMOfKwQe5IbNpWB7jXKFT79MHbHeZIn68XnpUlKWDJJzijr3TKJnH4aH55
 AtXnXKUe92YABWKzKMqIyHKwzHIB6IL4aL0CLe4xC8C2y+UCmm3dtst/TJA4EsTquPj0
 Ot6yUdXsyt/w2JKM3qYKboyJ3QclwuirP+KNIBqJnv452koTF0BYHGYwkuv5Jt68DwuP
 zG0fsqSE8S5r/H5SlAsoy+7ELSgGs9qK9YkbRhsGGmFJHSNHbGaXaeDh2LRrUM3ZhMP4
 idfm/YR81Dg0JqCl6plxQPS1P36nXH2aGijd3Z4Q16HUvzu75Xijmf1hc4f9Hh0zh2aN
 ppcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710158602; x=1710763402;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dV5UyBtfTTwJ57CNR7ZwV91eZXWHKrV3a0l3VoK3FYI=;
 b=UphLY+2+JaMmorzeRjRtfB/8iBucIpxuervLH6yty5IxxBiyv7BGPcTdJx1aF87vmj
 cI067JDMSSwWPH4rUPmVfsvIsBGzhYWJtCYt+K3i9MGPL9YIvMy71p6iomOC4KELUdCz
 oqd0mcTX03F3q1cvCSm6i850KDWvplAERIKqXpmf2uck4TuRv4u/YeSigt1dHtDreRUL
 vsNH9UVCPe9TjJ3PK/81N1U4UGzrMURY/xaBRxWSexGkQrXMYkkSAKv0Epa5c+KjnzCx
 CD+hn1WtpS3jeCTETvATc+D1KDJn5Yx/uRJtdcdQlJ6E/YR25DqT/p5DlYl3UJA4lerq
 Iq0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG4BwFxL05/w2wMgmvs7Pu30Sy2J5c2CS6pTRJuGrx1liGgZq1OWdnUf7HTkA/zJ61WwmNTe9PhlbxU6kZQqWqr/J0FeQ=
X-Gm-Message-State: AOJu0Yzw1CvvhfOTli1fME8YCp3cD1QhjgR+mrncQM9/UTxT6ppuZ/FK
 P/gGa4/5ubkQAdTAjrQb5+oAkBInHfnUnesbwvRYTEyV6ZLeXLKtmA7TFb4z8wx0bbGFzsOB0be
 z
X-Google-Smtp-Source: AGHT+IHGRgPxaNb2OXRXi66p2l7v68iVE6maUO0oPpI1Si0YI0QNQuKxLXEldTpkKoKIkfAelhRUVQ==
X-Received: by 2002:a05:6000:cc:b0:33d:226e:3769 with SMTP id
 q12-20020a05600000cc00b0033d226e3769mr4174610wrx.55.1710158601759; 
 Mon, 11 Mar 2024 05:03:21 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.167.228])
 by smtp.gmail.com with ESMTPSA id
 bj28-20020a0560001e1c00b0033e7de97214sm6355145wrb.40.2024.03.11.05.03.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 05:03:21 -0700 (PDT)
Message-ID: <e7dc81df-1a51-4e0d-b865-5741803fb8cf@linaro.org>
Date: Mon, 11 Mar 2024 13:03:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] hw: gpio: introduce pcf8574 driver
Content-Language: en-US
To: Dmitriy Sharikhin <d.sharikhin@yadro.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: Igor Kononenko <i.kononenko@yadro.com>,
 "Alexander A. Filippov" <a.filippov@yadro.com>,
 Alexander Amelkin <a.amelkin@yadro.com>
References: <f1552d822276e878d84c01eba2cf2c7c9ebdde00.camel@yadro.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f1552d822276e878d84c01eba2cf2c7c9ebdde00.camel@yadro.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 11/3/24 10:58, Dmitriy Sharikhin wrote:
> NXP PCF8574 and compatible ICs are simple I2C GPIO expanders.
> PCF8574 incorporates quasi-bidirectional IO, and simple
> communication protocol, when IO read is I2C byte read, and
> IO write is I2C byte write. User can think of it as
> open-drain port, when line high state is input and line low
> state is output.
> 
> Signed-off-by: Dmitrii Sharikhin <d.sharikhin@yadro.com>

If a patch is reviewed, please carry reviewers' tag:
https://www.qemu.org/docs/master/devel/submitting-a-patch.html#proper-use-of-reviewed-by-tags-can-aid-review

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

> ---
>   MAINTAINERS               |   6 ++
>   hw/gpio/Kconfig           |   4 +
>   hw/gpio/meson.build       |   1 +
>   hw/gpio/pcf8574.c         | 162 ++++++++++++++++++++++++++++++++++++++
>   include/hw/gpio/pcf8574.h |  15 ++++
>   5 files changed, 188 insertions(+)
>   create mode 100644 hw/gpio/pcf8574.c
>   create mode 100644 include/hw/gpio/pcf8574.h


