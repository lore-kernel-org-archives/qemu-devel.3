Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03E9E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 15:17:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTMxN-00068z-5p; Thu, 02 Jan 2025 10:17:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTMxK-0005vc-Cw
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 10:17:50 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tTMxI-0007YM-OX
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 10:17:50 -0500
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-3862f32a33eso5267180f8f.3
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 07:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1735831066; x=1736435866; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=477N4dgEw1HhSUepYMEeVZmwedjpf81Y6dnHK+akQ8o=;
 b=EwwngJRmVm/FYJeP0klLNrMI6Ct5z8dcDOBcB+O9SYgwSrnpHjWIdEa8kxlmxl03Rn
 4DdAv6+q+e/nb3tpKyZyOiQC6/D1T9Qp9BsJEYukeD/OGmvNmN2/Ror52XBqrbOEoxMZ
 EBuLDm1e0+CrvihSiOjLB3wvx1bY9e/1PzLhbwJHsB0R80Zy14ODe/NrA0Zvjh4RcsvO
 RUWXT+Qxpks5ugoV7rWObAXCmR7IpLevf3F+IKk8T8FvGeu34EkD+Q1OxTnENGbWw6he
 gKpe7rYNwgH3zi3YioOSqLANk8QA1jZn8RlZJ7B1jXix2XOeEAqbbhR8prPl991TwA3D
 lzqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1735831066; x=1736435866;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=477N4dgEw1HhSUepYMEeVZmwedjpf81Y6dnHK+akQ8o=;
 b=DO0b0tdpjFPWySy3Xth8ZURMqEf/0Fbv3TNEGhesP1TQ3dzFNo61OgZ8kZS3ziVu9L
 kLw4vrz5sW/TzO4jKr3Xrjj8MbFvQIdYumSrAxvaChAwIJEpdPr0+SBJYTWiWYwxg9OM
 NNf30g7AKPEAe/iAQha9mVxDJNOxwZ/Da0z5tegpPqso3dd5iD/pxTNpDyzDtFVdEFGx
 C1c5X/0ih5nNNh1aEzQ0q4EUKMWHBd9Hw/Qc+sly1+tkvrJ3f2q3Y2eMcvapYpOr8VWB
 fh5x9yKlQi5wnI+3vR+nguvSprFbU9AbJ9X06XLxZkXs4YVCCs8XdYCMecUXkJ+jcBGI
 m+fw==
X-Gm-Message-State: AOJu0Yx5QLe7grvlwucmYqgE8rVA+xolwAVRQ4jCKMJi9ozJjzJkBCxq
 lRjcLN4wsYr4FzGUEXV+5GGn7MTDN4qq0Ev6DAWWQY/KaXYXqv/QSjnALdfId568TOH6Lf4lpCF
 XWdhFXQ==
X-Gm-Gg: ASbGncuWG6m9XCIEw927wdWbEQuj1ahBEGRuDcPgYciMQWfVtuYWJXqHgir9NThFB3T
 3j5Xp7CBrKhsVln1N4Uoc35vosEsT4nqmvBpt9PozuKHpeBPlZLE8oKaN3ob6nE2XZ4Yln+sqqX
 bOzdEw94OScUMEhllRhNART4XUOzJG06D3BHrrh4Bo+zhlwm/3pge5KBKl5mmLxPiwsx2IdG6K0
 PJ0BB7FqEabsH8RBWGPYSVzOkuQF++aZyJ1yYx271GLSTqLnCapTmG+CaAnlssKksgJIhBb8rHD
 Gw31HVtmvjXUojGc8KDYSXqd
X-Google-Smtp-Source: AGHT+IGjnia3pNPFbMSPDl/uDB0ltLw5GgkeGj6p+yBLHa83KdXheeGOImVTd2dBf49Cb8/+fCwVDQ==
X-Received: by 2002:a05:6000:4a05:b0:386:380d:2cac with SMTP id
 ffacd0b85a97d-38a221f91a1mr41373625f8f.26.1735831066388; 
 Thu, 02 Jan 2025 07:17:46 -0800 (PST)
Received: from [192.168.69.132] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a1c832e8asm37861719f8f.37.2025.01.02.07.17.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Jan 2025 07:17:45 -0800 (PST)
Message-ID: <53d28483-a790-4927-a3a1-386cbeb1745c@linaro.org>
Date: Thu, 2 Jan 2025 16:17:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/10] qdev: Implement qemu_create_machine() for user
 emulation
To: qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-block@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Zhenwei Pi <pizhenwei@bytedance.com>, Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Peter Xu <peterx@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, "Gonglei (Arei)"
 <arei.gonglei@huawei.com>
References: <20250102151244.59357-1-philmd@linaro.org>
 <20250102151244.59357-3-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250102151244.59357-3-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 2/1/25 16:12, Philippe Mathieu-Daudé wrote:
> To satisfy QOM containers design, implement qemu_create_machine()
> for user emulation, creating a 'fake' machine.
> 
> Suggested-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/core/qdev-user-stubs.c | 11 +++++++++++
>   hw/core/meson.build       |  1 +
>   2 files changed, 12 insertions(+)
>   create mode 100644 hw/core/qdev-user-stubs.c
> 
> diff --git a/hw/core/qdev-user-stubs.c b/hw/core/qdev-user-stubs.c
> new file mode 100644
> index 00000000000..9d481a61dbf
> --- /dev/null
> +++ b/hw/core/qdev-user-stubs.c
> @@ -0,0 +1,11 @@

   /* SPDX-License-Identifier: GPL-2.0-or-later */

> +#include "qemu/osdep.h"
> +#include "hw/qdev-core.h"
> +
> +void qemu_create_machine(QDict *qdict)
> +{
> +    Object *fake_machine_obj;
> +
> +    fake_machine_obj = object_property_add_new_container(object_get_root(),
> +                                                         "machine");
> +    object_property_add_new_container(fake_machine_obj, "unattached");
> +}
> diff --git a/hw/core/meson.build b/hw/core/meson.build
> index ce9dfa3f4bf..0f020fed1df 100644
> --- a/hw/core/meson.build
> +++ b/hw/core/meson.build
> @@ -46,3 +46,4 @@ system_ss.add(files(
>     'vm-change-state-handler.c',
>     'clock-vmstate.c',
>   ))
> +user_ss.add(files('qdev-user-stubs.c'))


