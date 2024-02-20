Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF4DC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 20:07:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcWOW-0004wR-Sc; Tue, 20 Feb 2024 15:07:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcWOV-0004up-QU
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 15:07:11 -0500
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rcWOP-0005b4-3w
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 15:07:11 -0500
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-1dc0d11d1b7so15287795ad.2
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 12:07:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708459623; x=1709064423; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=HLX9bEIAKvN24Z11Kzav6Xy+FarHBV4OURWM6g8sz70=;
 b=m9EK2DdW3R4oZb7OANubEFPAI5fjB+wFetjNITO6YfCf50IrKIKQtih47NrM+VJ1nY
 H7mv2zci18Vjnks2JaQlyibnwIvKq53iqqXJu2sqKVfQaxZqVW0jrUBHqZLw5qhujKPJ
 fA4bVrRfrhBlT1tZ/oLy9yv0N9hddw3Dp5f6tMmECd7YqTFmzb/kUSNtq+tQjE08ae72
 8KUDvDSW9t0CVyaPC/bP6LMD/OxXtambiDlB+vUzUHVN7AdoKBRzGChoe2xIVerOwg4a
 zikkYjngU/oATVeNO8efGUM/N5D7H3Tll7Sou91MAiUKaRxZ9iu6d2+McUBLv6u9dvH/
 2KhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708459623; x=1709064423;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=HLX9bEIAKvN24Z11Kzav6Xy+FarHBV4OURWM6g8sz70=;
 b=TTITw4Y3O67m4bkENMFSqd+G9PSe8mv1BB3RaS0tJaBwiNCkBBw0UXO0yeNnF8ImZ/
 S916he6fPe4iQQBkfbHawNFdckQQcO3yC92mS7+1rBFdUQvoMeT4A04UTD7BSTpMlLxl
 zjYpIHoRvRHDUJRimjZaCXWYhC7F3uqJqxe7AdudN1V3GDxkKZd54XSauRr2gwU2Te2a
 oBUPsu+RaEf15KNhkUKyDxaxj4qttCNFT19/I2CFUHGr9z9rQPh2I/tTMQP9vvxHHvRb
 jxMcGZ2JMmtXLhgrBqI9Ajx1/9qtkCMOyPehPk33NRim2crUE5OHUJTXsXzg7oxCisPv
 2T+Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCX7XskMYMNogbFeMNTblLUOa9X09S8L18ore/HWJvTlvGuP8RcksosDNI6mUlybiWO3xKrQIQaW3htMdOue0nMBHiAaJ5Q=
X-Gm-Message-State: AOJu0Yww2nOnGZK1oRfWFAjdmYpP5l8N4iQDHkGdhNRueSUcy3Gq+HWm
 2M8DuxI8Xfv1m7c8aStJuT5GkPVFb7c6ZHHR5PaE3GyO/60U4AAgyyhLJqvhdKE=
X-Google-Smtp-Source: AGHT+IESHkBCj/Q9VAnyLYw2u54WfwqfnBcJMse6+wX6nCqalg67G5fvimtBW/7xm3AESKhXzHW6sQ==
X-Received: by 2002:a17:902:e886:b0:1dc:fb5:6f36 with SMTP id
 w6-20020a170902e88600b001dc0fb56f36mr4604967plg.32.1708459623509; 
 Tue, 20 Feb 2024 12:07:03 -0800 (PST)
Received: from [172.20.1.19] (173-197-098-125.biz.spectrum.com.
 [173.197.98.125]) by smtp.gmail.com with ESMTPSA id
 li4-20020a170903294400b001db7e3411f7sm6673963plb.134.2024.02.20.12.07.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 Feb 2024 12:07:03 -0800 (PST)
Message-ID: <7efcf8df-8aab-4441-94db-4dbacad21b69@linaro.org>
Date: Tue, 20 Feb 2024 10:06:59 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/10] hw/core/reset: Implement qemu_register_reset via
 qemu_register_resettable
Content-Language: en-US
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 "Gonglei (Arei)" <arei.gonglei@huawei.com>
References: <20240220160622.114437-1-peter.maydell@linaro.org>
 <20240220160622.114437-9-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240220160622.114437-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x633.google.com
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

On 2/20/24 06:06, Peter Maydell wrote:
> Reimplement qemu_register_reset() via qemu_register_resettable().
> 
> We define a new LegacyReset object which implements Resettable and
> defines its reset hold phase method to call a QEMUResetHandler
> function.  When qemu_register_reset() is called, we create a new
> LegacyReset object and add it to the simulation_reset
> ResettableContainer.  When qemu_unregister_reset() is called, we find
> the LegacyReset object in the container and remove it.
> 
> This implementation of qemu_unregister_reset() means we'll end up
> scanning the ResetContainer's list of child objects twice, once
> to find the LegacyReset object, and once in g_ptr_array_remove().
> In theory we could avoid this by having the ResettableContainer
> interface include a resettable_container_remove_with_equal_func()
> that took a callback method so that we could use
> g_ptr_array_find_with_equal_func() and g_ptr_array_remove_index().
> But we don't expect qemu_unregister_reset() to be called frequently
> or in hot paths, and we expect the simulation_reset container to
> usually not have many children.
> 
> Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> ---
> The way that a legacy reset function needs to check the ShutdownCause
> and this doesn't line up with the ResetType is a bit awkward; this
> is an area we should come back and clean up, but I didn't want to
> tackle that in this patchset.
> ---
>   include/sysemu/reset.h |   7 ++-
>   hw/core/reset.c        | 137 +++++++++++++++++++++++++++++++----------
>   2 files changed, 110 insertions(+), 34 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

