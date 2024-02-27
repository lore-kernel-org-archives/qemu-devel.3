Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 156A7C5478C
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Feb 2024 08:36:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reswN-0002w8-Uf; Tue, 27 Feb 2024 03:35:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reswL-0002uP-O3
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:35:53 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1reswI-0006YA-Lq
 for qemu-devel@nongnu.org; Tue, 27 Feb 2024 03:35:52 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5643eccad0bso6089279a12.1
 for <qemu-devel@nongnu.org>; Tue, 27 Feb 2024 00:35:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709022948; x=1709627748; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VDOx5SO1DOxTpjcvJTrE8g3gdYi/XgVRkYC/Dopt96M=;
 b=gIkMdc/VIZh3+ziCHFiXA1SlJT5HWcCrVmrFknaLJjfAR9xio/dMSlIfmpJxeNLVPX
 u8e50FDHyQ6rSiFhlngiDJhT48X2NKlVsVwr2vFNYhRSNqPLrPxB5tsr3GziF04CZOtv
 1xVjI2uDmNhF1U5LTTHkuSBphzaLhuy6G/uNiDeUiFpGonYpMGBseqm3Pr8Tyi8C8Eih
 BQkNWY6T7BrPom+4uoBgGTU9iiMrlgNQ/rEXZSQX9EIFfAGgkUYAkl0Ry/6u0hdW+Zvo
 mGYzE8+z/8W2EaTzjbKFjkSRYlEg5pwrQgRd/3DLjoeHMkC9WiufMR+Q6GKU+bGOzpLb
 48YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709022948; x=1709627748;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VDOx5SO1DOxTpjcvJTrE8g3gdYi/XgVRkYC/Dopt96M=;
 b=pX9f9BR8j0Jwi/9yGHulvPnL8cwJgNIbPMIzokiqpZxe42BPmDEo0m+W/uNFdBx5Y4
 pMvxXqHtOx7x2EEXEEdy7/hKVAzh4h49O00D1aC8KMZGQh78muJLRQwP4USWXSGUkm8O
 2k41gqa7Nr8BtcOLX6ZvpYAlKAzeMmFh6I6m3SlYEnnXqFFY/0afxcQQWDLE4QcCn8pk
 OIqcaxHz2/e6VCMqJ0fTlO+Bjd4wvjlPG0gEsWYuJZ/plfxc1qfe6wedWN0sNvC5Bk6r
 9eI1AGxWG89tPFNAFFOnkxzAeKSg1NNVacW6/mQ+MirZbH3eHe9ye1Dj3baI+jY8IOGW
 XmMg==
X-Gm-Message-State: AOJu0YwE9Qz0/H0ks+bep/gF9veaEXKqzJo4USQkzG88KyE5gu52A4KI
 QEBYecm7syAVDHwJCH9Akq/wmQ00f0x86iZuTyg//5N+AjCIOaCDCv4nP30Vp1WJSf1tNfwS3eK
 z
X-Google-Smtp-Source: AGHT+IFiVZxsIU1ZfLCeAeAij2m6BxGs0EmYYCS0q0TopsmbYyvl897g2XMzWxl8GjzaSV9FugGrxw==
X-Received: by 2002:a17:906:3c05:b0:a3f:db30:8999 with SMTP id
 h5-20020a1709063c0500b00a3fdb308999mr6938614ejg.4.1709022948541; 
 Tue, 27 Feb 2024 00:35:48 -0800 (PST)
Received: from [192.168.69.100] (mic92-h03-176-184-33-214.dsl.sta.abo.bbox.fr.
 [176.184.33.214]) by smtp.gmail.com with ESMTPSA id
 m16-20020a170906235000b00a3d153fba90sm524141eja.220.2024.02.27.00.35.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Feb 2024 00:35:48 -0800 (PST)
Message-ID: <36af99eb-06db-40ac-b086-36394c2457a1@linaro.org>
Date: Tue, 27 Feb 2024 09:35:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] hw/ide: Make "ide_internal.h" really internal
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>,
 John Snow <jsnow@redhat.com>, Leif Lindholm <quic_llindhol@quicinc.com>,
 qemu-block@nongnu.org, Radoslaw Biernacki <rad@semihalf.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-ppc@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Markus Armbruster <armbru@redhat.com>
References: <20240226080632.9596-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240226080632.9596-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=philmd@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 26/2/24 09:06, Philippe Mathieu-Daudé wrote:
> Missing review: 3

> BALATON Zoltan (1):
>    hw/ide: Remove last two uses of ide/internal.h outside of hw/ide/
> 
> Philippe Mathieu-Daudé (2):
>    hw/arm/sbsa-ref: Do not open-code ahci_ide_create_devs()
>    hw/ide: Include 'ide_internal.h' from current path

Series queued.

