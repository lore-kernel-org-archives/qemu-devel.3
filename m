Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA6CC25B10
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 07:30:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2nNA-0003R7-IE; Fri, 03 May 2024 03:30:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2nN8-0003Qw-9J
 for qemu-devel@nongnu.org; Fri, 03 May 2024 03:30:22 -0400
Received: from mail-lj1-x22d.google.com ([2a00:1450:4864:20::22d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2nN6-0002m6-8i
 for qemu-devel@nongnu.org; Fri, 03 May 2024 03:30:21 -0400
Received: by mail-lj1-x22d.google.com with SMTP id
 38308e7fff4ca-2e0a0cc5e83so59691581fa.1
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 00:30:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714721418; x=1715326218; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lpazXiyo3h3oAkp83Cq3zG2c/WOrKcEcNwJHI+DUkS4=;
 b=z0p3AL91rhbkpEJFkcDJnl6wX57aierXFtG9QgX7xZJ7y+nAuOj+GttknmYz/g10ta
 KN3XAVjZC9M7OSC+vrIZMDktrQKQojPDEANotiq1XVryjpoI4VUUkpa7wmhBa29fHZ3N
 vMU8wT7Dmzfa4/Irkv56OPUy8NqEA6vcj/5sfNtu6veI1ijQWpUVFuJajYdQsEsTEGkB
 kQNF3ImFO5OqKwjoYcPNoaRe328+lw8lr4rKAFK0xFHiRPuC4yc7Vu3mcABsI59v3UkM
 GJbaEuVL8nK7tZAJZ6Pw3YjxOBPm1rtaZ28Km8QZi3soy7xL0V9rgH9MwDCcym71OFYV
 q4EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714721418; x=1715326218;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lpazXiyo3h3oAkp83Cq3zG2c/WOrKcEcNwJHI+DUkS4=;
 b=C7MKBOwspx6zCILhcVE8pRmzT/tq9t9FPDX0KzK122wBcZsX/uj9aHysPQf/9HrNhP
 OlaUpsS2BO+6W7kWf8cTPObjVHK5UjKQZJo31SRAhiB915nRCL704Ui0VAZkaJjsMmpc
 HZ+QiYVMhudLXyGITXCfF5gomTCATjCe8xvL+bmeU9E1clPN5uGdzsx5Pcjv8rAWSVPj
 zxOmI5lA3p0Kl0jDzzs2QUAQ51NdaK69lQUlR9sX680cmrMsJalMqct5mCWR+zDs7NuT
 ATZQfdu1vC3rJjy+ZlvgcHhzNsNVsU9ATaSAa147Wxj8yOVN9hRhm3Yw61Sam3kabXfT
 j0FA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWAVAdtfVcGwy4X+/WBN+VOLZpaz8lI7WsJ2od6C2dTMWdaYABtIWfXzylbJFX7vgfpUXEzVBsk0vE60byN9IPrwEYIw5c=
X-Gm-Message-State: AOJu0YwzxIK+o+Iu3o7ufSf3AjbWBIHKS1Zu7SriviGlFjn5iU6BcPiG
 gwvfEhB+RgoFpEatOkVzigZxT7y+GrZsGozFub9Po59xNoZA5vzN/jwGmzVX72AoMz6fF1ciN4Q
 h
X-Google-Smtp-Source: AGHT+IGTme+xVbuViraMlKaASSodLPYmPBXGhf4WYdjbXcUstnHI7Y+FyeczH7+t8x6bn0LGUSXC0w==
X-Received: by 2002:a2e:9f45:0:b0:2e0:2ef4:a985 with SMTP id
 v5-20020a2e9f45000000b002e02ef4a985mr1216519ljk.35.1714721418505; 
 Fri, 03 May 2024 00:30:18 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 h6-20020a5d5486000000b0034dc4d7cfbfsm3045569wrv.48.2024.05.03.00.30.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 00:30:17 -0700 (PDT)
Message-ID: <c681e2d6-9bfa-4d64-867a-b17d3e50671d@linaro.org>
Date: Fri, 3 May 2024 09:30:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/13] display: remove GraphicHwOps from typedefs.h
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240502155331.109297-1-pbonzini@redhat.com>
 <20240502155331.109297-12-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240502155331.109297-12-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::22d;
 envelope-from=philmd@linaro.org; helo=mail-lj1-x22d.google.com
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

On 2/5/24 17:53, Paolo Bonzini wrote:
> Basically all uses of GraphicHwOps are defining an instance of it, which requires the
> full definition of the struct.  It is pointless to have it in typedefs.h.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   hw/display/vga_int.h    | 1 +
>   include/qemu/typedefs.h | 1 -
>   2 files changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


