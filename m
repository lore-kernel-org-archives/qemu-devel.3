Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4901FCD4851
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 14:36:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNAh0-0007C4-JC; Wed, 13 May 2026 10:36:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNAgc-00079p-6L
 for qemu-devel@nongnu.org; Wed, 13 May 2026 10:35:49 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wNAgW-0006uq-BB
 for qemu-devel@nongnu.org; Wed, 13 May 2026 10:35:43 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4891b0786beso43819035e9.1
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 07:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1778682935; x=1779287735; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=B0UjjOx1Mt1dCOGRyFA2ff32Jafwzgq9d/fHN/lvVtY=;
 b=sHJOyRHMzg53lksZXoNXS+X/KzeRhpb3wu+n6OEcqn5Ydq1BxWoBqIl7E2whzl7jIP
 DDnuw38F4WIvArcbqi/DLLwtA8JDKWw5Kj6Jn/BpaPh/zqPNG6Ms70zu2WFCmm4igDZu
 3LgdhbsQlikDcSs+c+VJ2GQQp+1hSEnvfmrdTqGTXngbiGBwvzFvrzmTGnsKhsZIg7pv
 bCVl51teIzVAYp04LF0WGxG75iEZJLZ/12mviPhOUtykXEmNTJxNumeiJEIwflFS5wsX
 U6jYektlHLReCiuooR1EX/bsDVjotQJdBRz3YtbldzjJq9MaRsckeZS2H8a7irfixufk
 eWig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778682935; x=1779287735;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=B0UjjOx1Mt1dCOGRyFA2ff32Jafwzgq9d/fHN/lvVtY=;
 b=RBm+TJcZMyuBL8hkai5U0FotUflTSZvpZGxozMomtntC7LzCjSjKg/4bEQV9ui7t8C
 130Bt+PADzyluy/hkbQlsHMMlDZeD2AZemenXBkplVmCG6l6/QQivndZ2Hu1sBTKHtuc
 u36CWAjjSXZbvy7wk+d7JA9vaQLoYTKUpw3l2+E4mFhsjYWVj5c5Tj3OdKgoyXMdZ1rE
 1j+8IuDMRq1q2A+yOOLN1vwNUuBJQ5r49xLWOJ6cvwkIoF5P4OUdmFnV3hJyRbGjlK9u
 7+JIdba5Ls4wzOOPyrN4j1Mp/mJbAk91RiJtClMl+1rNIjMszlF8i0JwpB9hWNXK//TD
 V2tA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/4LyH9oh2N0dZbWwFAwnzI2LDT5xOVraFhXJ/WLeIMDmxGT4lXs3t2YbDVaO+hU5PNy5CZ5hi9rUA7@nongnu.org
X-Gm-Message-State: AOJu0YzluyP7eWtogOq+x1401UJM9lc3LulJi4aOLhSGaqapuLEuFD46
 sFHN3xFxQlDKtVtKS59UWIjaKEw5V8HROliu+kbXky45HHF3/l6HNdor4j1skW1XSEE=
X-Gm-Gg: Acq92OFoHJ0rXqPG261MVaV/MZck4pHaBTewRFP5HBGrTEu6oaqrbjR8OdXHIWESiW4
 2CXqtvBEAJRcS63j024daRQWDgr3AymdljALc53vUVQkOYZxQR9sqA6tJ79Xn+yktrMF1qP+2bI
 PCVEMHhAAjiDr0H5PryI40yE+v018Mw3jFX3mEsxi185lKbQesMLmzXV8XcSdpSOnmC4WzwbCXY
 msTg9j7iqym5KOexxJb5M4ExLiiAljBzr13GVW8hYPYg/mpfxP6Tx6YxSjnaEtbb37lix5O1s5u
 KhSI82WZ36rNLWnywphws7hilLdVI8nrCESZkP7cLnC4xN8BFEe7V0RNw3UT2JbMl6xCDh44EAX
 yw1sS6BtPfskJwuxbOd010QxC3Yd1F7LAkoAS9U/IdoNhi5KAn32s5gBIAf9AeQjRdgLFMSs2no
 4NiFyM+8WrlDMLVU519nCxdk08FENGITX31+ETmGcjYRdXA+dGDXbe+pUFFSmkxyQVgA==
X-Received: by 2002:a05:600c:c171:b0:48e:7f22:d90 with SMTP id
 5b1f17b1804b1-48fce9b30fbmr47840865e9.4.1778682934704; 
 Wed, 13 May 2026 07:35:34 -0700 (PDT)
Received: from [192.168.69.200] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48e8f43c31dsm44377325e9.25.2026.05.13.07.35.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2026 07:35:34 -0700 (PDT)
Message-ID: <0618a887-2727-4a76-a94d-73de52029950@linaro.org>
Date: Wed, 13 May 2026 16:35:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/10] qom: drop user_creatable_add_type method
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
References: <20260512122958.788097-1-berrange@redhat.com>
 <20260512122958.788097-11-berrange@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260512122958.788097-11-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 12/5/26 14:29, Daniel P. Berrangé wrote:
> This can be replaced by object_new_with_props_from_qdict, which does
> functionally the same job, but the caller does not own the returned
> reference, instead the parent object owns it.
> 
> In one case we can use object_new_with_props_from_qdict_owned instead
> since the object is not intended to have any parent.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   authz/listfile.c                |  4 +-
>   include/qom/object_interfaces.h | 18 ---------
>   qom/object_interfaces.c         | 70 ++-------------------------------
>   tests/unit/check-qom-proplist.c |  5 +--
>   4 files changed, 7 insertions(+), 90 deletions(-)

Tested-by: Philippe Mathieu-Daudé <philmd@linaro.org>

