Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6CC71C4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2024 10:03:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvaD9-0006sD-GV; Sat, 13 Apr 2024 06:02:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvaD7-0006rn-EJ
 for qemu-devel@nongnu.org; Sat, 13 Apr 2024 06:02:13 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rvaD5-0006CS-N8
 for qemu-devel@nongnu.org; Sat, 13 Apr 2024 06:02:13 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-41550858cabso11509345e9.2
 for <qemu-devel@nongnu.org>; Sat, 13 Apr 2024 03:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713002530; x=1713607330; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=E/8TOcv4r/ctWTXXe8ps1n6oddvUwI/skAQUtcBK0Ys=;
 b=mnhenB6+qTCpTAfuSWYyTXFPOKtMfimP732wvvlNDeJulwnj5vKKe/b/qVUPKEgVmi
 vOnTPIKlWVlRVQUA/yhinkgDcP5az3UsLpHNheBzDSUNPYH/SlyEw1fa1CCl7VzjqosJ
 5y5zN6ysGrha5ZIEP2JDz8gp0Eba+iJGgSCIyKaMraE6nFA/Q2EYjIb4SuDFtZxuwpnb
 Kq+4jS4VS8X50fvPRgfMOUHxQIvMehqcMGPglJXg5WFfohgVdpqL2uSKqR2cQOs38GhU
 xskHw8D961m9k4iomTwAFFkvG66tKKwmAvOMyWsk0UWHAHJ7n2dV82Flm23nKolLSTB3
 EwKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713002530; x=1713607330;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=E/8TOcv4r/ctWTXXe8ps1n6oddvUwI/skAQUtcBK0Ys=;
 b=ARY1qlRphP8RMP5cJhyL2rmYH4s61T78WD9m+3/avjbC7JGW+QM0hNZvsv/hs80taB
 Ca4T+zlABuBti97FqQP+s+1DQ/Nckr0qytSTLz/QMynzYvVFMa7AnMttyNE2on/QWfZJ
 nKEfuxZAcqe/ZcOLY5r0L3lh/m29Ccv2gK8UpNk7cR1PB3A+18b0y9QM4bv5NN+EJaEs
 gepnmBVsSB3KwtRi5KV6v6ALAKSw46sJGUR+QqYrqRSUqg2ik3M1pQZYl4nVJzOqjijy
 MQyfU9dTv2Nvi5M822AicHn8dugJdpxqU6XgIasFC3c5f2xAupQTjj74/iiyh73E42oQ
 IbuQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmp2p4K253DHDQ1YWNXgq5utCeX4547jbqs5QL9VE3yad2VDGLAUcwMcvEmPY2oh9PbjVgzfeBkKQueSNBSQyYZS23ZNk=
X-Gm-Message-State: AOJu0YwKSceFgK+Rp4l086ZsAXlVnVqOm6Y7dk5GJsSTGwsvA3uJFuLa
 6+Vq36gtSyhC7+6Q7VaK2UQH2vquf0auAGppfSLj0FPG1+QehZ/FNCsGp02Jg1A=
X-Google-Smtp-Source: AGHT+IFlnhDdxcxEWn7x2e0JnrB1Kz51mMrwz+Nk2itORHWUX0pWPoo0OKBG0vnQR0tQdMeYUZZNfg==
X-Received: by 2002:a05:600c:4510:b0:418:ef3:6cfb with SMTP id
 t16-20020a05600c451000b004180ef36cfbmr2019166wmo.26.1713002529850; 
 Sat, 13 Apr 2024 03:02:09 -0700 (PDT)
Received: from [192.168.1.28] (lfbn-bay-1-170-196.w83-193.abo.wanadoo.fr.
 [83.193.250.196]) by smtp.gmail.com with ESMTPSA id
 iv18-20020a05600c549200b004174ff337f4sm8445890wmb.7.2024.04.13.03.02.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 13 Apr 2024 03:02:09 -0700 (PDT)
Message-ID: <eecb616c-ad00-42da-ac49-1ebe51d0a1ec@linaro.org>
Date: Sat, 13 Apr 2024 12:02:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] ppc440_pcix: Do not expose a bridge device on PCI bus
To: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20240411192443.B4D644E6026@zero.eik.bme.hu>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240411192443.B4D644E6026@zero.eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 11/4/24 21:24, BALATON Zoltan wrote:
> Real 460EX SoC apparently does not expose a bridge device and having
> it appear on PCI bus confuses an AmigaOS file system driver that uses
> this to detect which machine it is running on.
> 
> Signed-off-by: BALATON Zoltan <balaton@eik.bme.hu>
> ---
> Here's another version that keeps the values and only drops the device
> so it's even less likely it could break anything, in case this can be
> accepted for 9.0.
> 
>   hw/pci-host/ppc440_pcix.c | 11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


