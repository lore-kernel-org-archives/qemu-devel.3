Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B33C1C2BBCA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2024 06:19:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sLzWk-0003x6-0t; Tue, 25 Jun 2024 02:19:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLzWj-0003wS-0y
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 02:19:37 -0400
Received: from mail-wr1-x42e.google.com ([2a00:1450:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1sLzWh-00071S-CW
 for qemu-devel@nongnu.org; Tue, 25 Jun 2024 02:19:36 -0400
Received: by mail-wr1-x42e.google.com with SMTP id
 ffacd0b85a97d-364a39824baso3744340f8f.1
 for <qemu-devel@nongnu.org>; Mon, 24 Jun 2024 23:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719296370; x=1719901170; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=vsJ1To1Brpg9oc2zSZe28jHu3+iwRhnHBfl18/k1mBc=;
 b=kBEszk7EL0bA3XBUVNsuzXkhItp2r4KulxM3DnmUim5V75S72c6CEJh9I5J621XRdM
 C6Ezh4fgTtM4GoDcZAn4L5vgyIo699/41v/VHVD3M9yRPkwf2AtLbfb8ZwaYuTouxLQU
 E+l2ABENKJa6iVFqrRoGRqrwA54q7O1f6TrcsWGR+h8ztBIkFJw2IfRkQ6xVCn+Wjnvn
 qxmcRKwV5MmD1ZT3JXoM/b0jvxlaiUJff8aOpo95X6uagzEzzyoykRe3oLCU9OkfRtMV
 7hCoIM14mdqRKzyqkM4kb1LvDd9WhyuWgfwWhpAs10t2FaWA4E00BLlVA1VXOZFpVhBH
 esiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719296370; x=1719901170;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=vsJ1To1Brpg9oc2zSZe28jHu3+iwRhnHBfl18/k1mBc=;
 b=D0dbo8lWr6J6nWJ4LM4fqRlcQEJodI4WTA+RH2Y8C57PnQZjDSwGLIKbVc2397nIod
 dbs4L5hmG7eaRSHM5UkE3GpnnbGOgG9IZdqUakQV2hAdZq4rLcS6i1paYo0wJDMGkCqR
 TxXYzMHEBlyqQ2BNBGPeCx5IcZUHIeLLlzu+AFC6VPUmrYqI38uJAZnnEF+i1x1R9pCe
 /xHcHKBcl5+Uf2/iijo97D4+OSkKEgYcpfSnlm0DZuJzuIT7n+POErpKZwJyV+WnN2EF
 DY6hKddPXY9Xv9ASqfw/3Gr2W5cHENcj2R6nwsJtkbA7SBWPMqI3s0TdUlqERZ2ZoJng
 xDNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUHlofhbfjYZ2ZR70I7gZpszRgTO/upImtn5CwaxckJ9FHWAuhhYz8xQ17Enb3TVhFPDJpkhb0jndgdBt5Q0w7TENcetU4=
X-Gm-Message-State: AOJu0YxkgUZf2JA6nrO+UX7IEfbscFyraDDIzhHnyrvUandEIH7q6yQn
 kckeoDEvDQZoiKaCA/ZgwJtgxPbTratqf9F6LsRmNQCHmP554PuWSu4cMDsVkRU=
X-Google-Smtp-Source: AGHT+IFLqY4U7/gARpK+5U1SVg3puEAOZ0pfxm2U//EBxFbokLqclVPTA1NLtHLn/xWtor1LBQW7RQ==
X-Received: by 2002:a5d:4e42:0:b0:364:7de:d70 with SMTP id
 ffacd0b85a97d-366e7a0fc25mr5183503f8f.29.1719296370564; 
 Mon, 24 Jun 2024 23:19:30 -0700 (PDT)
Received: from [192.168.69.100] (bd137-h02-176-184-46-22.dsl.sta.abo.bbox.fr.
 [176.184.46.22]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-36638e90cbesm11957045f8f.58.2024.06.24.23.19.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Jun 2024 23:19:30 -0700 (PDT)
Message-ID: <0b5ff0ab-9b58-4463-8aeb-d464b3b085dd@linaro.org>
Date: Tue, 25 Jun 2024 08:19:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1] include/qemu: Provide a C++ compatible version of
 typeof_strip_qual
To: Paolo Bonzini <pbonzini@redhat.com>, Roman Kiryanov <rkir@google.com>
Cc: Felix Wu <flwu@google.com>, qemu-devel <qemu-devel@nongnu.org>,
 "Maydell, Peter" <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20240624205647.112034-1-flwu@google.com>
 <8e54bd41-9a7e-4b1e-ad99-33de1615374c@linaro.org>
 <CAOGAQeq0b3_g80k5xa-6f+XPkv6C=nfMLkJt=X3-6FD_d3sJUA@mail.gmail.com>
 <CABgObfZ6U0pEcvr-J5H3sYjTU0-kOr4NOLjBRh0Vg-vfutRCqQ@mail.gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <CABgObfZ6U0pEcvr-J5H3sYjTU0-kOr4NOLjBRh0Vg-vfutRCqQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42e;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42e.google.com
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

On 25/6/24 08:05, Paolo Bonzini wrote:
> 
> 
> Il mar 25 giu 2024, 04:32 Roman Kiryanov <rkir@google.com 
> <mailto:rkir@google.com>> ha scritto:
> 
>     Hi Philippe, thank you for looking.
> 
>     On Mon, Jun 24, 2024 at 7:27 PM Philippe Mathieu-Daudé
>     <philmd@linaro.org <mailto:philmd@linaro.org>> wrote:
>      > In particular this patch seems contained well enough
>      > to be carried in forks were C++ _is_ used.
> 
>     Will you agree to take #ifdef __cplusplus  and #error to the QEMU side
>     in atomic.h and
>     we will keep atomic.hpp on our side? The error message looks better
>     when atomic.hpp
>     is somewhere near.
> 
> 
> I think we should also move typeof_strip_qual elsewhere; I will take a 
> look. I think there are a couple headers that already have #ifdef 
> __cplusplus, but I need to check (no source code around right now).

$ git grep -l __cplusplus
ebpf/rss.bpf.skeleton.h
include/hw/xtensa/xtensa-isa.h
include/qemu/compiler.h
include/qemu/osdep.h
include/standard-headers/drm/drm_fourcc.h
include/sysemu/os-posix.h
include/sysemu/os-win32.h
linux-headers/linux/stddef.h
qga/vss-win32/requester.h

> But another good thing to do would be to avoid having atomic.h as a 
> rebuild-the-world header, and any steps towards that would be very welcome.
> 
> Paolo
> 
> 
>     Regards,
>     Roman.
> 


