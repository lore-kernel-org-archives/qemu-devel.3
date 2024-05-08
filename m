Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5D41C04FFE
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2024 21:16:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4oeJ-0003sp-Pm; Wed, 08 May 2024 17:16:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4oe9-0003rd-Sf
 for qemu-devel@nongnu.org; Wed, 08 May 2024 17:16:18 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s4odx-0007S5-Va
 for qemu-devel@nongnu.org; Wed, 08 May 2024 17:16:17 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-41b79451145so1817555e9.3
 for <qemu-devel@nongnu.org>; Wed, 08 May 2024 14:16:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1715202963; x=1715807763; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=SqDnnhuaUp0RX1sV9laReXvwXJOJip9csi2moakN+XY=;
 b=DAaUc4IOnINY2M8mMl0xu8j5ly7dKxFREO2uBL0i7M0PPA5a9aJcg6U5bf8bLWbF2E
 qTqUuyCpzKjpyxx9UjuJLgfuQEn4jsIKAAgSOeYbgS9SD2glLudiOPaIGnc50L33Afnb
 s1It/3usCvfU6ZxXY4I1eUJBGxK80a8kwUQBNv+1dzIHCta6Ba6wNd0xUw/s1rgIieCM
 Fwgy177EszRTDIYBF8egvfcRnFqdbv82NyzUb9uUde8GydG4BUizVCJyfVYP2AWMyIhG
 sLDcy+5apETBe26IKiiPh8xf8/D1Ojj6t0D+9NtCP8Vl79MdFNc/cBnzw7OYgJWPswoZ
 J5vA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715202963; x=1715807763;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=SqDnnhuaUp0RX1sV9laReXvwXJOJip9csi2moakN+XY=;
 b=dnr+4dtCWNJFXT5ASZDaYMGppCXAL273/+KjVN0HcoOTTptGsIC6Q1GREHqtqdYuWv
 SZCTi8rPf26RcSHIMYpFTLpGIs8LHhKoPLmH/C1NH1FX8lvHTFXGGCpOszELBkFVIFJg
 JBsWxxktI0qBAjGSd5euNODrIpaxYeCQuLS2xukE0v+a7ckvCvXeJnek6cZyKLhC8EPu
 zX9bOuOGUUxQRA4xUyJbucASYWpZ49HGvyI08srXRC6XFavI56ASc5IPQoy+G+2teUYm
 KH6wO/FmuOvTguZQv/yvRrDTf9Yzgm5P+QZqqcg5lfNas/XUeUTKvagOPuWgcDf4v9sE
 caqg==
X-Gm-Message-State: AOJu0YySGfmuhNmIncbPIT1abLWrJDWAKhPpt0l8GnIVcDl9FLiH9HNU
 PN9Lk01Ug1eFsgIVZh4/1VKR1Zu4rEb9Ygh1KZj/z7TS5UrtYYcCAbZmGSwQmTY+dyGTwzFm+cw
 2
X-Google-Smtp-Source: AGHT+IHSp/WxomxPkLtfEX15ofXycEBoZzzT/p7CXfF6WgkwEMlhL7BW68mPcBeO+6ZeN1L9gzenFw==
X-Received: by 2002:a05:600c:1c01:b0:41b:e84d:67a3 with SMTP id
 5b1f17b1804b1-41f7093c969mr34373265e9.0.1715202963278; 
 Wed, 08 May 2024 14:16:03 -0700 (PDT)
Received: from [192.168.69.100] (sar95-h02-176-184-10-250.dsl.sta.abo.bbox.fr.
 [176.184.10.250]) by smtp.gmail.com with ESMTPSA id
 u17-20020a5d4351000000b0034fda441600sm2582603wrr.39.2024.05.08.14.15.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 08 May 2024 14:16:02 -0700 (PDT)
Message-ID: <c22e999a-6d03-4833-855d-8c2f79257a3a@linaro.org>
Date: Wed, 8 May 2024 23:15:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] misc: Use QEMU header path relative to include/ directory
To: qemu-devel@nongnu.org
Cc: Song Gao <gaosong@loongson.cn>, qemu-block@nongnu.org,
 Keith Busch <kbusch@kernel.org>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Jeuk Kim <jeuk20.kim@samsung.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, "Michael S. Tsirkin" <mst@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240507142737.95735-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240507142737.95735-1-philmd@linaro.org>
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

On 7/5/24 16:27, Philippe Mathieu-Daudé wrote:
> QEMU headers are relative to the include/ directory,
> not to the project root directory. Remove "include/".
> 
> See also:
> https://www.qemu.org/docs/master/devel/style.html#include-directives
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   hw/audio/virtio-snd.c   | 2 +-
>   hw/rtc/ls7a_rtc.c       | 2 +-
>   target/i386/gdbstub.c   | 2 +-
>   tests/qtest/nvme-test.c | 2 +-
>   tests/qtest/ufs-test.c  | 2 +-
>   5 files changed, 5 insertions(+), 5 deletions(-)

Thanks, patch queued to hw-misc tree.

