Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF554C5475B
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Mar 2024 14:17:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rjgRd-0005TN-HB; Mon, 11 Mar 2024 10:16:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjgRc-0005TE-PY
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 10:16:00 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rjgRb-0007Mo-9S
 for qemu-devel@nongnu.org; Mon, 11 Mar 2024 10:16:00 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-4132a5b38fbso4646155e9.0
 for <qemu-devel@nongnu.org>; Mon, 11 Mar 2024 07:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710166558; x=1710771358; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=43jNDHBzdy1gIxQ/6CNhvNbAa8Yb9cT8Zs1tCMJRK0k=;
 b=r4gm+veMe2hYYE/8CPGYsSDJU1uS6Gk4EsttF/RW1SLTgqpP3zoG7FtxBuRSzkYrI9
 W4dsuUUze2CIfNFUvaSDBM8jNLYltt68RNKdBNe5bxok+evs0xXDO4PAKjmMJy3dTkTj
 YiFDQDGa056qJQHloY2qOR5auwZz8OtQRW0j6O5DFwcE3opskMR8rkY2NS00KTknLiec
 rLVST/PKpA6BogwaubU1GP3JlOJga09goZCA2y29FFtOCSIIEh5NVU/7mKDMdxbODEMw
 bD6G2ZwvaMak9fkDJbjXp2GGo8wQATKvKpVuZrJcAHfkdoxxVxairkAFsme2tQEh3QPa
 xnHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710166558; x=1710771358;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=43jNDHBzdy1gIxQ/6CNhvNbAa8Yb9cT8Zs1tCMJRK0k=;
 b=OAaIUO8ZbNO3Q9dUjiJftXuTKtZ99G/hjqk2lBWrS3YGjM5Oe+5ZIF37tzD5u9XBID
 M0kfseQqgsjO5IBk+yR6foTgMuT5MSAYwHvZsds4exWl30Rtn+Y7U1AyLf7i+CHWg1CN
 OepKEeGlHEGBBj03+wirKIIXJ1goWFYsWiy6Mt4DD8oBnPkzXCqyj9hxtNq7Ay+kGz03
 ItF2B3OZGA6v91pHeMxgb5EHPTlS5gB/nd6HGhtAju61h1pfwjM+AWBtHtoUzJGWQpKJ
 3B/ER5pn1+14cSnBcjv4iCBbLu2qFfN8jSfsSxSjFP4WifNK4L15z0VNALDTlJrL6rjz
 6Wdg==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6PzxA8N3pwDmGypLhkVeOevoPEs9riUfGqSmHOLBhvJl7hqF/JK3dus9kvLukD22SrVXJGU1ZoMoVuEPSq69JynM2jMM=
X-Gm-Message-State: AOJu0Yw7J6ET6zhbjqieyMsiG75Fk4v9HH/B08dsyySlaePn8DZLE+GJ
 Uq3ZBt662ACW8XxQ4Ipw25Un0E2S+noLwmhEv9tI6cEk/Svcvk6SWAIf82jHge3XZfOyrkDaSHU
 e
X-Google-Smtp-Source: AGHT+IGwN/d77FeTuHz8IQ4LFm5ExjGtTZ+PVaotTWIYWLspNiItMnQWBFsDTSXa8QhPdJ08BcJcgg==
X-Received: by 2002:a05:600c:45d0:b0:413:2641:c44b with SMTP id
 s16-20020a05600c45d000b004132641c44bmr3046459wmo.28.1710166557769; 
 Mon, 11 Mar 2024 07:15:57 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.167.228])
 by smtp.gmail.com with ESMTPSA id
 u12-20020a5d6acc000000b0033e7a499deasm4334460wrw.109.2024.03.11.07.15.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Mar 2024 07:15:57 -0700 (PDT)
Message-ID: <f74c870a-c2f0-4c30-bb17-cf3d0602b7cb@linaro.org>
Date: Mon, 11 Mar 2024 15:15:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] crypto: handle gcrypt ciphers being disabled
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
References: <20240311121929.212472-1-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240311121929.212472-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x333.google.com
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

On 11/3/24 13:19, Daniel P. Berrangé wrote:
> This fixes testing on RHEL with libgcrypt cipher backends
> 
> Daniel P. Berrangé (4):
>    crypto: factor out conversion of QAPI to gcrypt constants
>    crypto: query gcrypt for cipher availability
>    crypto: use error_abort for unexpected failures
>    crypto: report which ciphers are being skipped during tests

Series:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>



