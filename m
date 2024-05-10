Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D1FC25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2024 09:14:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s5MKQ-0007Ej-1M; Fri, 10 May 2024 05:14:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5MKN-0007DD-Us
 for qemu-devel@nongnu.org; Fri, 10 May 2024 05:14:07 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s5MKM-0008UD-F3
 for qemu-devel@nongnu.org; Fri, 10 May 2024 05:14:07 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a599eedc8eeso461902266b.1
 for <qemu-devel@nongnu.org>; Fri, 10 May 2024 02:14:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715332444; x=1715937244; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=iFdY3M1Za2O2qEH61bAgpoQ5QG/XSkkLmrULTnILsIc=;
 b=YZSKsJg3JQHQ3xNn+lxyB6zdYM0IKz+AlYBi7txVIgovuLttdzovbKNaLzqCm9EAU3
 isbkHlICT/rlqMNU9bVqu/4I8ljUotMPEyF6bnEonlfh03D1mYGEOZbxi7z46x//oyK0
 03DUr3jw1p0RSFQs6dxi33oBMdCP0a6g8v5kgxb4jnQA6Qh/Cme0URPNggtTGM/7S6ga
 pEC7VrrU3wA6l71ssYr3xpAlKXN9QhhDBxmMoPdr2srzHCCuS6Zk7wMmhDg4T3u/58WS
 yq0x/CWieBn/qg4Uex2P+U33ivK1HiJ97C12MBhyL1DLEYK4gE87v/4vrl53RTOU9byM
 moXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715332444; x=1715937244;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=iFdY3M1Za2O2qEH61bAgpoQ5QG/XSkkLmrULTnILsIc=;
 b=gJ1D9Q0SG/uZftySp7iaxTOu9VKvXbGo1LupqV7+FLSS9p0PVu3kfOKbDjy1Mqm2Li
 Cz571etnh+iww70SHMeFOO9GW/53+TY4/NmxOnqgtHTsk/8FUkzPMMEhmurNZygFxw5K
 cuBVCW9RRhchDPVgsrcf2pFDfN1j8q99WxNVFRoNCn5E01gcQUU376lVFoyEeXSUk3ke
 lBdWUruHK1c9FGLgO/pAyu7D0XuXjEdshMVblucTtViu+I9bHenasK8fO69975Y6Rayk
 AChAWTs4w1KzUu602BK99IMrJO+GU7rKjZNuPQ5jsCTyzm0nhcHUBNQN/j32g8Xc9bgD
 W44w==
X-Forwarded-Encrypted: i=1;
 AJvYcCU3UTLqkgOjcdR1+V8Xp4jXJCMSvWcN4Is82eXlzcEITa7sujai0AprM7UhArZFTqNIjwz+VoEnZUB+lmhj1/nw0EZik3I=
X-Gm-Message-State: AOJu0YxrTVX4hG/gYqPGo4fd7b5xsMnlwdTr99pQndRdRiYagtjJ+ju8
 e8PhpKd64CDA0uiR4CaCk+Ds2MLaqSfZq14c4nc5x/T6k+pEKIY/0bPWprZtRIU=
X-Google-Smtp-Source: AGHT+IF+4zbq6azOIkZLrqbZRy0me14Mxl3BVVYmBuP7JqjLf8NQuRlLq0ib+twiDfV4xrx8f2giMA==
X-Received: by 2002:a50:a45b:0:b0:568:32cc:f808 with SMTP id
 4fb4d7f45d1cf-5734d5cf9a5mr1335470a12.15.1715332444409; 
 Fri, 10 May 2024 02:14:04 -0700 (PDT)
Received: from [192.168.69.100] (sev93-h02-176-184-17-152.dsl.sta.abo.bbox.fr.
 [176.184.17.152]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57359e84dc1sm179025a12.23.2024.05.10.02.14.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 May 2024 02:14:03 -0700 (PDT)
Message-ID: <11e3ddeb-cf82-47ed-a02d-29822bb55ae3@linaro.org>
Date: Fri, 10 May 2024 11:14:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/13] tests/qtest: arm: fix operation in a build without
 any boards or devices
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: thuth@redhat.com
References: <20240509170044.190795-1-pbonzini@redhat.com>
 <20240509170044.190795-14-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240509170044.190795-14-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x636.google.com
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

On 9/5/24 19:00, Paolo Bonzini wrote:
> ARM/aarch64 are easy to fix because they already have to pass a machine
> type by hand.  Just guard the tests with a check that the machine actually
> exists.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   tests/qtest/arm-cpu-features.c | 4 ++++
>   tests/qtest/migration-test.c   | 6 ++++++
>   tests/qtest/numa-test.c        | 4 ++++
>   3 files changed, 14 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


