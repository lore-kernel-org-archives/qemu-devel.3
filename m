Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5AA3BC2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 12:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOGd7-0002dp-VR; Mon, 01 Jul 2024 08:59:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOGd5-0002VV-SO
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 08:59:35 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sOGd4-0008Sn-7k
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 08:59:35 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4256788e13bso22165335e9.2
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 05:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719838770; x=1720443570; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nltnGyhaxdfz0PKIWdNG9LcTwf3w7YSnFF4WD9SZe2Y=;
 b=vxg2rsIezUdknmRwM/PtDbPS/korzSUV2bz1rNTMjtC5XLnJYjEQUwcHfnYtE/inLj
 wEG8GmQpYS1sVsLFYIwuvRAlUfjCepP+iitg2wRtgdn68d+kAZSGV6LWke9aaIUNoNhI
 ofiWrOQYSRGVqdn3THISOSMz8fHUZrqo7+PxQFnYN2K/lVMvoPlCxlDmtaPkiGBtm+ir
 8bHV5xKMfu9+JtQ6ACuwH4B225WXiPzxKseMdBoT03fJ242IpvqQnr6max5rwnawS1pz
 4UdSSTd4anhlJ8g9iqFiY8pcQ/RtVsB+cxHw0Y5B+JPqVyswQXUAXpmtW4+72ukg0ZWq
 kZhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719838771; x=1720443571;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nltnGyhaxdfz0PKIWdNG9LcTwf3w7YSnFF4WD9SZe2Y=;
 b=pdd87e97NYO4i4Rdjgog02cdP9tA5J2YCsuxW9SPkwiuOUWK+Vjv978ttjayxTEKYQ
 LoO7DmiythmSdRydT1hS0Co36Ga+72fQky3xndY+PPt0I1KADisJ/axDVfwl4TUBtXf/
 ynj0XX7CyqPayqzb+ZvmT4RdjP6MlT/V8/6RwVM//Aaj7h2Ws6VcV/fpTShpKk1gqpz+
 ihNrV/yzs0tSPoqAxeTHzCmxLME8ylKTNLk7WCiJjk4eAWBuC5fkTR+3Z9GEfadIBKJs
 SGtfG/zj+SD2q11s7d7GeVarQtkcmZXkCMku6Mtazjn/K//sA6cV3e2Q48QMH49xQbvq
 HD4g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUJcaq9x9UWr9Beguxi1M17j0Z5MWT0clyz/YzBEwYFdneJU86W7Lj9X4saOwu+rHp+HeBAKWglPvChDjCwWoEqTaOuF/I=
X-Gm-Message-State: AOJu0Yyp39Ar4dUw/ALfWwW3Kywch2SZmm/ucHsaFmNBqKiMjaG10D9I
 f80ghwF+OVRIBjA7mEa39PqJwUiijyD3zRsCIIEX/TgeliuXWCkRxpC/E3zzPXY=
X-Google-Smtp-Source: AGHT+IEmOWN9ybWeaKUC0Invbcc9P0Jzlg8uSdHp7b4kZiPC6yVfLWp1GawUA9wcpNSljldY/ufXew==
X-Received: by 2002:adf:ea87:0:b0:35f:f1d:f4e9 with SMTP id
 ffacd0b85a97d-367756bb7fbmr3247672f8f.28.1719838770624; 
 Mon, 01 Jul 2024 05:59:30 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.177.159])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3675a1069cfsm9900804f8f.91.2024.07.01.05.59.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 05:59:30 -0700 (PDT)
Message-ID: <e3ac884a-fe6d-4cac-a00f-aa3e884d6dad@linaro.org>
Date: Mon, 1 Jul 2024 14:59:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 07/14] hw/i386: convert 'q35' machine definitions to
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
 <20240620165742.1711389-8-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240620165742.1711389-8-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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
> This changes the DEFINE_Q35_MACHINE macro to use the common
> helpers for constructing versioned symbol names and strings,
> bringing greater consistency across targets.
> 
> The added benefit is that it avoids the need to repeat the
> version number thrice in three different formats in the calls
> to DEFINE_Q35_MACHINE.
> 
> Due to the odd-ball '4.0.1' machine type version, this
> commit introduces a DEFINE_Q35_BUGFIX helper, to allow
> defining of "bugfix" machine types which have a three
> digit version.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   hw/i386/pc_q35.c | 215 ++++++++++++++++++++---------------------------
>   1 file changed, 90 insertions(+), 125 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


