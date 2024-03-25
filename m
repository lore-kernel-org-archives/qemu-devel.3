Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1A49C54E58
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Mar 2024 09:33:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1roghL-0007eb-9B; Mon, 25 Mar 2024 05:32:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1roghJ-0007eL-RZ
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 05:32:53 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1roghI-0005SM-BB
 for qemu-devel@nongnu.org; Mon, 25 Mar 2024 05:32:53 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-4148a581d3fso2393085e9.3
 for <qemu-devel@nongnu.org>; Mon, 25 Mar 2024 02:32:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1711359170; x=1711963970; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=v79t8Dy6CKUyWsPvkucEnxwlLGs3vBSnXkAdxoXiOsk=;
 b=SyoGg/NsCwW6agyW0efFLHNsSLC6dJKlcXkX0h4WQuCUXGPmG2iLyNB7wAzgHsvFtR
 drB90t15n8UQwZq4EVRDwXYQCwveoT2oxun3CaUXfnMB5x/ymtSWtkHgZ8u1xxMIJSJY
 3AnpY66ohsMSXg7urK09XMYZwz4uUAVNz8jD+7wRgwF+pfdLFjU0Us8GV75iTVz3r1BW
 4rBrrA2UjqQvhK03jEcMVpaVWWZJEAb8ev69B2yXKHAid5rxFkl8DXIzc/+mwQS/uGN6
 mY2bKnGQfdBSseKQCjYINg2a/qWH54S6DHRuVRP6yMh9ZDBkqAC6BWPfrz/RZ2gGd9BA
 w8nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711359170; x=1711963970;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=v79t8Dy6CKUyWsPvkucEnxwlLGs3vBSnXkAdxoXiOsk=;
 b=jKFWC+aQReJIvHh2BEr5BJmm+oGZAiHFZgfCQVkKyLS9Dak955DuyERsckc0LmqBpv
 2e2171qJ3becGBl95IyHyhHsRukKk7avJibbRbWPcGNh/PaHZiqc4yov/21DzsQbs5wO
 zrQ2+UeX/lZS7JasSpuPg0nnUK8sKbQCdkPNp9Hn0B3JUThsXXLqJdkBGNcgPhIoYJHi
 0bdLq/CKZ2iwiNbA/QadVujbW/8rV9sTK+zvFfv0PiMmL/OopooPWQkqCWFFv6eGtB3g
 r91EFHhixzgvzTF6tr280oCHz1joQvL2Lfz2ra3cACMTk9X+s8rFlRRTy23+BlQ4nrYE
 LVjQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX3AoEdXZkfneZrJHkDUOSKAXaQuKayg9VzhKt2e9KWOiA3jtjOjW/651SpDdlOwyuKJMZbc1X/BwbxlNdohmmGuW6ar/w=
X-Gm-Message-State: AOJu0Yzak6dmoJGq879XCMY8w4mvjWT3w+dxkQHx0T9yQn2PLQWe7ukv
 pKPoBR4p4p/BPIZis1lB0t8GSi6cq6A9pV21Mvf7CRjc5ExSgrRH7A86hX1Ranw=
X-Google-Smtp-Source: AGHT+IHNFlZW0AI9Lx3z6i0zk3FnC+cIagQX7AdcUUAcEIjOgdp/kMijy/b14UQCXfAKNbkOIVJ8yQ==
X-Received: by 2002:a05:600c:450c:b0:414:86a2:a43 with SMTP id
 t12-20020a05600c450c00b0041486a20a43mr2149048wmo.40.1711359170626; 
 Mon, 25 Mar 2024 02:32:50 -0700 (PDT)
Received: from [192.168.163.175] (237.red-88-29-182.dynamicip.rima-tde.net.
 [88.29.182.237]) by smtp.gmail.com with ESMTPSA id
 m15-20020a05600c4f4f00b00414037f27a9sm7844004wmq.31.2024.03.25.02.32.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Mar 2024 02:32:50 -0700 (PDT)
Message-ID: <5d5d3415-3ee3-4230-a8c7-5a87fa11fb7e@linaro.org>
Date: Mon, 25 Mar 2024 10:32:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/26] runstate: skip initial CPU reset if reset is not
 actually possible
Content-Language: en-US
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: xiaoyao.li@intel.com, michael.roth@amd.com, david@redhat.com
References: <20240322181116.1228416-1-pbonzini@redhat.com>
 <20240322181116.1228416-12-pbonzini@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240322181116.1228416-12-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
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

On 22/3/24 19:11, Paolo Bonzini wrote:
> Right now, the system reset is concluded by a call to
> cpu_synchronize_all_post_reset() in order to sync any changes
> that the machine reset callback applied to the CPU state.
> 
> However, for VMs with encrypted state such as SEV-ES guests (currently
> the only case of guests with non-resettable CPUs) this cannot be done,
> because guest state has already been finalized by machine-init-done notifiers.
> cpu_synchronize_all_post_reset() does nothing on these guests, and actually
> we would like to make it fail if called once guest has been encrypted.
> So, assume that boards that support non-resettable CPUs do not touch
> CPU state and that all such setup is done before, at the time of
> cpu_synchronize_all_post_init().
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   system/runstate.c | 15 ++++++++++++++-
>   roms/edk2         |  2 +-
Without submodule change:
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   2 files changed, 15 insertions(+), 2 deletions(-)


