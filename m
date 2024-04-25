Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5347BC4345F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Apr 2024 20:56:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s0697-0006YE-3z; Thu, 25 Apr 2024 16:56:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s0690-0006V3-Sv
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 16:56:38 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s068x-000460-9a
 for qemu-devel@nongnu.org; Thu, 25 Apr 2024 16:56:37 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-a556d22fa93so176754766b.3
 for <qemu-devel@nongnu.org>; Thu, 25 Apr 2024 13:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714078593; x=1714683393; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=VExTLqrYI7SDAYUDE9+LrwByOPLWHQZnJBPadSrBV3E=;
 b=eeNqAO/qAi1fKFCPpUpy09QaeJChiOWlCTa7KzgkxHID20KV+tfCqZJ0DTRW8xLGGU
 BzsTg0lf/3oQz1a8d849lN5IarSsfLINkDVQyhbIML0gWs+ZfbsdOyafsjk+IL1XaVOL
 pHjBp/uBkziiTat4oTSQbVtlOT2hzoHFVzv2mn3UZR99ymPGlNyLavIhuUl38CObm0Jo
 oEzaGWOecMzOGyvifiqzo9ib/j4fshSdzPSvY7h9SbYomqBlfiQbfA8U975SAr7vUUSp
 faByjqMTTJjHn640AUUhThAB6W5J80IIPilIBVcCuH2U7zLgu6C6SGP4Mv+Djx8bj3tF
 3LVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714078593; x=1714683393;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=VExTLqrYI7SDAYUDE9+LrwByOPLWHQZnJBPadSrBV3E=;
 b=XoLvwvmclNaV7CZ/Miv65NPe37jDXN31r7IXMJmRzgoE6YUhVqNJBGZxKWotCX/u60
 BW4SDnMWVLKaCG1Ag6G/nI/HOsvU1A2pRtwmP/kneamFJRgu7rTVzBVJP6HNZ8oJ4w+i
 +8VjsVyXHqKv3rbloygxyQ2rl+Jx0uEwQhWiGEbieQ9bAO2zXMsYLhGVy5S00fIb6cWp
 qEXPYo66sPsftJv9R9UPKcOnPok3xjLdAp0VVQgzjF61AVwcxTd2A1CJRN6n9qG34KXC
 cCTp3tS/CayR4Grsw3Dc0gbtwal+V4Mzr03sHiuUP4h/y8W07UaWmpng03Bu89AuOHCf
 w2cw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUUid2RvNPdWrTqvh1kG0Td2bwdSIWT6gFkQ4GUdbNxuoNUAVkyG51vzzmcXaqW8LTci2R9vwtHB0Cm3BtjcyVxc8gZGWc=
X-Gm-Message-State: AOJu0Ywjph/QwclSQcn80643D6WpFDmeKjv21UuTc4a57I7iuKDMxsZB
 QG21412XU+dERQMMK8ZdH333PwbqHDhWq+xojQWUxhC8WnyWu0/x5zXAAA1Col8=
X-Google-Smtp-Source: AGHT+IG2d0bT2STMiSVPOjDIgeyy8vy8+EYrrK+o2pZWIBXkNhO0mwHN2Yd5Dl1lS2ArQiVnqcg+2w==
X-Received: by 2002:a17:906:f0c4:b0:a52:1432:b790 with SMTP id
 dk4-20020a170906f0c400b00a521432b790mr529313ejb.31.1714078593291; 
 Thu, 25 Apr 2024 13:56:33 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.197.201])
 by smtp.gmail.com with ESMTPSA id
 p11-20020a170906a00b00b00a55892e840bsm8320187ejy.205.2024.04.25.13.56.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Apr 2024 13:56:32 -0700 (PDT)
Message-ID: <49984234-9a41-40aa-b1ea-448b8a02ab0e@linaro.org>
Date: Thu, 25 Apr 2024 22:56:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Make it possible to compile the x86 binaries without
 FDC
To: Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Miroslav Rezanina <mrezanin@redhat.com>, Bernhard Beschow <shentey@gmail.com>
References: <20240425184315.553329-1-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240425184315.553329-1-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
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

Hi Thomas,

On 25/4/24 20:43, Thomas Huth wrote:
> For downstream versions of QEMU, we'd like to be able to compile QEMU
> without the FDC code included (since it's not required for modern VMs
> anymore and the FDC code has rather a bad reputation, see the VENOM CVE).

IIRC you still need to keep the i440fx+piix machine DS due to
migration compatibility, right?

Are you able to migrate a VM booted with FDC to a non-FDC one?

> The q35 machine can already be instantiated without FDC, but for being
> able to link a binary without the FDC code, the Kconfig file needs some
> tweaks and there are two spots in the pc code that directly call functions
> from the FDC code - those need to be disabled via #ifdefs.

Is it useful to you to have q35 without FDC but i440fx+piix with?
Or are you removing it from i440fx+piix due to shared code with q35?

> The third patch changes the i440fx and isapc machine types so that
> they can work without the FDC device, too, in case it has not been
> compiled into the binary. It's marked as RFC since I assume that the
> FDC was originally a fix compononent of these motherboards, so I'm
> unsure whether we should allow the disablement there. OTOH, it seems
> to work fine, and the FDC is only disabled when it is not available
> in the binary, so I hope this patch is fine, too.
> 
> Thomas Huth (3):
>    hw/i386/pc: Allow to compile without CONFIG_FDC_ISA
>    hw/i386/Kconfig: Allow to compile Q35 without FDC_ISA
>    hw/i386: Add the possibility to use i440fx and isapc without FDC
> 
>   hw/i386/pc.c      | 13 +++++++++----
>   hw/i386/pc_piix.c |  6 ++++--
>   hw/i386/Kconfig   |  2 +-
>   3 files changed, 14 insertions(+), 7 deletions(-)
> 


