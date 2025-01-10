Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A540E77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 13:23:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWEu3-0004mv-4R; Fri, 10 Jan 2025 08:18:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWEtx-0004j8-5q
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:18:13 -0500
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tWEtv-0004lJ-AK
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 08:18:12 -0500
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-385e1fcb0e1so1135133f8f.2
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 05:18:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736515087; x=1737119887; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G6m+LB9f0+FAeO/cFtzArunkaJPA+oUICfxUzb3XVSM=;
 b=e3RXPLsZqMNP9QR65uVV3bbGbe6nIBb6PXzylNMZ07zCg6SRswEvDm9bVIVjYN8c5T
 Fe7xgv5Q6D3RzgQRoFT6wXg2CD/7gCJzFxuKPRQ4uUIzsmJT2saThKDn0+s4Dc0ZAi54
 HuMWCHNRbaaerh43tS7Hnz5xnSLyiAmCFMzxP5WZJ2Se4n59CUKxuFQoDKWzdSoLrrjI
 uPMoLg40eP+9NFjae4+DcKdr6KwBqdgJkxZrWpfFfwH0KxkGWGDdlUr08OvnbFA96yK2
 rwGSdgh0gIECaJJXaSePmY5o4Ce0V5fHWQmN8yKJtsqCm7xuOnCsEOxnPRWYQofS+WHZ
 FX+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736515087; x=1737119887;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G6m+LB9f0+FAeO/cFtzArunkaJPA+oUICfxUzb3XVSM=;
 b=HN90hUPP9OHUR98rvI3NsjAyR15SHVBUHVMlEMHjzC3oeb4fBIcAIQQZMfEBv+duN1
 +EkAJW2V+MV+PkrEvylIcvFqTRK+iuSr4bz0g3I+vgzQg8s2YTyJmrufrSVKxQ5JF9z1
 CKBxLO8nFtfe6GwHWZILXbjo7YmotPS4fcviXcZEARwhHw4OvEYd4zhGUnWcG2ydIgfb
 7+qe12oT7lz1d6QXc/EbThkhzJMWf48qgCpaVtfGshZklW2yikTCZsnqkIB2bB66HE/n
 hsW4rih5pI1NWsQwp2kyu6qnlrlkb772QUGFbVFVmqYEGilcEApBIErnowYkCjagml+W
 HyVA==
X-Gm-Message-State: AOJu0Yw2ryNTaTFHnr7kL50gqCbWSe68YLTWzbU1WM680bcrBF8seXhT
 SKRLv1/Y+ZpCzon/ASPJNWnGNU5ouDm8MiHqZGG8E4A5cJZTRF6dvRMpuSySpggezew75nXnC0W
 si5Y=
X-Gm-Gg: ASbGncuEyA9RSvRNTwdO4Ztf9uX1W0DsFXwUpmPIeUX6USRIYGgYnGy7Sf+Uw3gqIoe
 X5EVjtstieWswu6CDNFiTo/Q+Ex02RJp2tBTFkSxcCJup0B8WZbjE14WKejIFoieNwR720aOafs
 STtL5m2/Mqi4iCGWOzwacjFx+srEAh8LwvKCOi7pyjDxBR7A5oPSzh817ioGKmaARv2fThWcVZW
 lXFZZDDw4GCs0E22ocAv+a+dw/fjUireh5wFJgFsuBsponVcjPdz/fjKf0KuhPQf2oUmzNuUlWP
 EPE7YCpWWnHXyznseD3wITciBhY=
X-Google-Smtp-Source: AGHT+IGbVrk9o4b2kM/ohgmhzb0qZTvg9IPgyiDsfNvU7cWENAY+r9LLkbQ0yYNxyDn9evWXKwTaCA==
X-Received: by 2002:a05:6000:1a85:b0:385:e0d6:fb48 with SMTP id
 ffacd0b85a97d-38a872f6f22mr8570700f8f.7.1736515086686; 
 Fri, 10 Jan 2025 05:18:06 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-436dd1682e4sm59714125e9.1.2025.01.10.05.18.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jan 2025 05:18:06 -0800 (PST)
Message-ID: <0882cfb2-367f-4a6e-a1ba-784f2b1714e6@linaro.org>
Date: Fri, 10 Jan 2025 14:18:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 0/6] hw/core: Unify hotplug decision logic
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250110091908.64454-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250110091908.64454-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
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

On 10/1/25 10:19, Philippe Mathieu-Daudé wrote:
> Akihiko's v4 patch was doing too many things at once to
> my taste, so I split it to follow dumbly each steps.
> https://lore.kernel.org/qemu-devel/20250104-bus-v4-1-244cf1c6e2aa@daynix.com/
> 
> Akihiko Odaki (6):
>    hw/qdev: Pass bus argument to qdev_hotplug_allowed()
>    hw/qdev: Factor qdev_hotunplug_allowed() out
>    hw/qdev: Introduce qdev_hotplug_unplug_allowed_common()
>    hw/qdev: Check DevClass::hotpluggable in hotplug_unplug_allowed_common
>    hw/qdev: Check qbus_is_hotpluggable in hotplug_unplug_allowed_common
>    hw/qdev: Check machine_hotplug_handler in
>      hotplug_unplug_allowed_common

Akihiko, are you OK with this split?

