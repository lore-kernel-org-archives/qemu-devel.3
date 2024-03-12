Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AB42C54E5D
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Mar 2024 21:02:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rk9G4-0001tg-5B; Tue, 12 Mar 2024 17:02:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk9Fv-0001si-Dz
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 17:01:52 -0400
Received: from mail-pl1-x636.google.com ([2607:f8b0:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rk9Ft-0005L0-UF
 for qemu-devel@nongnu.org; Tue, 12 Mar 2024 17:01:51 -0400
Received: by mail-pl1-x636.google.com with SMTP id
 d9443c01a7336-1dd6412da28so2699855ad.3
 for <qemu-devel@nongnu.org>; Tue, 12 Mar 2024 14:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710277308; x=1710882108; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=yhDzCvvu0jNEQ9qcd83suFW2T2FOxYyekKQCzJDQf7g=;
 b=JGR6CumiCQNvrPlbGX+8SkDuRlQy53ge5t4I2IPcw7NqS1cQC+zm1l1sbiInEDL/DW
 F6IXP4MzZ6vq+gJ+qmTQ2mbS974+8pfz7yulzxKWsakC5sT5dAGhWlnl07c0WzcxrIUx
 Uw+ZUrx4qZPNBQn6Um8T5yR/3BWQOm86TdSrWb7guLkNX7iXMptzd0Ct8lv+Cu1RzHCO
 aTOMjx8mV4BeHcQ5jYSVEM4UEW7/ZUdXr7aGh0sgFuKAFMii9A8Vq+zC3IorcJdgPVMV
 gxpVbn8jU0mjkohAjjr9ymUJwlYmnGezAX0Bh4uD18djgws8q+5U0X/AkwaErL8Nht5H
 KZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710277308; x=1710882108;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=yhDzCvvu0jNEQ9qcd83suFW2T2FOxYyekKQCzJDQf7g=;
 b=hZjtrTf9kEkMQpMpqbvYcxNuXeBvS6WtdzQDu48bcqSvwLHGvWutAmuPIm9LT3JzcE
 LMGf/Is0TzsQemBlsfFRbAblkThYtflMZDFIN8dHsafXt12HdCSG10QvvQoBvLPmE3Mr
 4mXMLfJZY+WjkRFG05pu0Hx647Aifk0eqmOMjXwRTdl1fFW4l573PLJT3aT22l+bEPYu
 +FaLeKbtu8p2CTeWMzOdaCg975+aApZ3FZDJN3I29Vg+g8Y9qI7QbAvGwfmsFcJcf30E
 9zcpFAD4qrh+OjDbuVHm+T79w3axAGVEjZh+wYeQCLbU9Lfj/XZ4xKHbQaRlHWZ3AQVD
 2kzQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDsmEQ198RsDnpp7U07ZCWRoC2bU+S4PY0r54pwiu28xD+leMWm7CB3iplWtuWBNStw4fD70jo5rg2ckIu/8q9OYbfRDs=
X-Gm-Message-State: AOJu0Yxd8PGqxUrHyQDon16lFDIvQRwDoZ+EGpniTaVlYy7EHReM5tPA
 kny0seR93Q6Mdm2ygLgRrkH6GzxkCX50k9epWcGaHfocJepjNlitZP4PGytZoNU=
X-Google-Smtp-Source: AGHT+IHJ7TGKjZGHse4FlDsEe6Hi4viwbAH07XDyOn2z6fjIAgtPy28BbGCM2OE7qyjQ5fcwVaapFA==
X-Received: by 2002:a17:903:24e:b0:1dd:8a43:4c33 with SMTP id
 j14-20020a170903024e00b001dd8a434c33mr4580023plh.50.1710277308303; 
 Tue, 12 Mar 2024 14:01:48 -0700 (PDT)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 d15-20020a170902654f00b001dcc0e239fesm7305496pln.232.2024.03.12.14.01.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Mar 2024 14:01:47 -0700 (PDT)
Message-ID: <5da31fc6-f924-41c8-a922-7ae3abd35d4d@linaro.org>
Date: Tue, 12 Mar 2024 11:01:44 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] plugins: prepare introduction of new inline ops
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Paolo Bonzini
 <pbonzini@redhat.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20240312075428.244210-1-pierrick.bouvier@linaro.org>
 <20240312075428.244210-2-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240312075428.244210-2-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::636;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x636.google.com
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

On 3/11/24 21:54, Pierrick Bouvier wrote:
> Until now, only add_u64 was available, and all functions assumed this or
> were named uniquely.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> ---
>   include/qemu/plugin.h  |  2 +-
>   plugins/plugin.h       |  1 +
>   accel/tcg/plugin-gen.c | 77 +++++++++++++++++++++---------------------
>   plugins/api.c          | 23 ++++++++++---
>   plugins/core.c         |  5 +--
>   5 files changed, 61 insertions(+), 47 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

