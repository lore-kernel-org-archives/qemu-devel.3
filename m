Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B42ECFD8FD6
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Feb 2026 16:44:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vveSm-0003fz-Ic; Thu, 26 Feb 2026 11:43:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vveSk-0003dn-TK
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 11:43:43 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vveSi-0002u8-Ju
 for qemu-devel@nongnu.org; Thu, 26 Feb 2026 11:43:41 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-4836e3288cdso7485125e9.0
 for <qemu-devel@nongnu.org>; Thu, 26 Feb 2026 08:43:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772124218; x=1772729018; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KgKiISxAjVQfycxn5nY2+eocRPiyJzTEpGn5z6nfgXA=;
 b=Hee3NdutzADpfpix6RIhKWYRm2rjeOS0zAX2BJ+D9yq40SS7865nbVcgyUo+nPsIZp
 fPr9T5tSzCaDWq7B1JwO7pialmcBLI2nINR31cVOAcbtVtvb8ty/rwppcWJ2f8wbrNAf
 Cuc6eVdVBfb34zlRXNCxY8JPCcY6KzT/IqhoPJoVv5GHqTfHcMnN/NK2fruKGAkUvVWn
 bMyEs5eEYUzkACytnQs89X8Ly77Rg/U1upPMTBtbsvf2iOjNSwmrW6yCgFYjxf85Y97/
 Nm1ykpEPBqS1PVDTuIyJxPjl7M9oWDXqcRpw0uRWrpWLjmK34D5VlGqaJqAntynDUKwv
 mZdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772124218; x=1772729018;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KgKiISxAjVQfycxn5nY2+eocRPiyJzTEpGn5z6nfgXA=;
 b=Q/2amKsSx7EQesNd8xa/F43YaUAepvs/GPSK7FNrxWsH9Yse40GKiGGtZA6H9dsZ6x
 kfvmRMZhR24ItFQdj8kiwE5svQMH4k6zXX9ZMnAZCCkswixyL5LVmp4/Ti6VjWByETrJ
 llX6cNMbcuIQ8CKIRak0vxHa1+E6KTR2cudV/y45cB9tHDqub7ZpXaW3wZ6BdD+j1L8K
 zXOpkAvkn79HFxcPpc6jYcggvx9n8j0Lyb3KM//PohNwBKznUB8qEpoWAQNZBbjeb9E9
 6gc+hFJaaq8I2y/tfEx/idhqkxTf98OBiuq8bOiq8z37SNlB2nP460XYgXhfU3Un/+bu
 /dCg==
X-Gm-Message-State: AOJu0YztjYlfzG2yfjldIpMCa9Qh10TU+EDGwYyEECbHb2Kh1OpMJLOk
 FJldy0dMxG4D+CDZ7B6I/21nYTGEARVusBUQxLnoQEiUsEpiDKAFKVbJCo8wz6SUHzcQ2TrzLmQ
 ++aDi9Eg=
X-Gm-Gg: ATEYQzx2/N5EVgT3IgZqanceVzEH6AXqJPxU6ftLnRgNO4WyEXweVb4BzI78EhNFfy0
 M6l/YFDw1rwBWAsUMo+BDXsy9dow1eKDPQ6y01G1M+HuGINlnXnyJO0EyL9Nc1dNKwrlaF0ccuB
 ZQ1PzdpjgRxEchsfxm+OzJHy11Sduzjfh5LJgRS0uJR3qbiTc0gLFhjbC/KDhrYmHpbb3Dm8Ef/
 O+0BED3vvWIKSrmlJM7f9MkCQvDMz1DqKc7eZVFQxSMNHt8+8RiQ6jAKNhvNVw7FvAlAkSxqRt+
 6ambL+Af7qn6cAFOBCSQAcxoLGeuiRAWIdifIMw0pUJ28YydWNcLnikLfozEMG0Dy6oL2jPBLu7
 XwmlTJzOe7SNxgJ3vvBIkyrsshaPG/w+i9jcMug4TeEP+zvF0nq/KKq5Psu6an6ChRu1pPevFOJ
 zmxkvgobaX5kT49sUXxSt0Vufb6W1ROKHBpujk27DlCaPwAlgtzZuIAA0gEapprVYXJX9YwndIa
 FfB
X-Received: by 2002:a05:600c:8b71:b0:483:7ea3:3de3 with SMTP id
 5b1f17b1804b1-483c33c3606mr62339715e9.2.1772124217598; 
 Thu, 26 Feb 2026 08:43:37 -0800 (PST)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb776easm40709675e9.6.2026.02.26.08.43.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 26 Feb 2026 08:43:36 -0800 (PST)
Message-ID: <744ecad4-e8db-4eeb-af3a-e8dbb760a314@linaro.org>
Date: Thu, 26 Feb 2026 17:43:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/11] buildsys: Build most stubs once
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <20260225035739.42848-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260225035739.42848-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32f.google.com
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

On 25/2/26 04:57, Philippe Mathieu-Daudé wrote:

> Philippe Mathieu-Daudé (11):
>    meson: Include various directories providing stubs before libqemuutil
>    hw/acpi: Move acpi_send_event() function out of acpi_interface.c
>    hw/acpi: Move qbus_build_aml() function out of acpi_interface.c
>    hw/acpi: Always link QOM interfaces with system binaries
>    hw/nvram: Build fw_cfg-acpi.c once
>    hw/acpi: Build stubs once
>    hw/display: Build stubs once
>    hw/net: Build stubs once
>    hw/*: Build stubs once
>    fsdev: Build stubs once
>    semihosting: Build stubs once

Series queued, thanks.

