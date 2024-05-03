Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D502FC4345F
	for <qemu-devel@archiver.kernel.org>; Fri,  3 May 2024 08:44:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2oWt-0006UT-Fa; Fri, 03 May 2024 04:44:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2oWi-0006Nj-Eo
 for qemu-devel@nongnu.org; Fri, 03 May 2024 04:44:23 -0400
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s2oWg-0006I8-HY
 for qemu-devel@nongnu.org; Fri, 03 May 2024 04:44:20 -0400
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-34db22374f3so2064495f8f.2
 for <qemu-devel@nongnu.org>; Fri, 03 May 2024 01:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714725857; x=1715330657; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=455sXsiQ9zoRiBAN5ETQ30lT2NzR1fgmV/BBiYpdTRk=;
 b=XKUnNTBxjdXbda5P3yByYzI3AeZ5YL3ny3R5RtiKK/Dfiu1t6kQ6JFeSisXICntjur
 we2TWQHkrPnmVnl+Hd1GQ2jm5sWjSZMdwjDdz2ZoSstc25a+3msuIe9UmQO0Vli0jQZ5
 pMseDeblTibsmQVcGdBedRvKYGmrW47sjdrnT3Enmfp4MncV5P1v9n+8XgIpR5vhi8w8
 b3d2C01J4rIOw7VfP3brov6gyp3U2FeUHzI+zzutJvaqD+ahQifmR2VvffExhOSEnaks
 x99pz98eZj1v2kMaQxF8oqXVw9Mp2gm0KF4fqhSlkfUDhHjZgAeqZK/PSwEXY/cK5lBu
 yTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714725857; x=1715330657;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=455sXsiQ9zoRiBAN5ETQ30lT2NzR1fgmV/BBiYpdTRk=;
 b=fygE4yynVQUbqvkWPGOrtvowSfDqHndSNMhJ7eKW8KjDu6u3hnwxWF0iB0Zq7nz8z1
 QcVDpb9UNGVNW8Du7muKHuFpL2N1PzOLgKpR4W5lQvYKGXfsoQHAIW41yPjDhCdlMWuB
 y8ijQmxbdEafgyl5Alb+Bh9hgI2UnwyFMEfrqLOfhlJmToUYAngd7OL0ErcVEtCrRoB0
 6j4vz4gygY3arekNETFgq/bOBCUxF1vp8/m4QF42/XpKiED+8P7J7LeZ2s7txvbWTfoo
 q4O+WAIaCzOvxDfrdUfcY/GMHvCYs2r+jIkIM35Xrn/SnpIeJLKk8D/bcx4bJGwoHPUA
 QsAw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0Lrid90FIXhJohsPiesSgV8NWQe0jOy0ERZr9xR7Ty2PEyrdmOMc2zzjU7CG/cx+0RZxYRrrpf+5d9j+pp4o8lT0zZfY=
X-Gm-Message-State: AOJu0Yz6msCywDC36JErLKPvGdDnW2Ik2jRiYOAWQEIBZ6tQISbBuc9w
 FzJj9HMuKDPIwok6kEPMENCyyKv1HG7GJz985FZ6xeA0qm+BlmKw+XJ+E3cgl/k=
X-Google-Smtp-Source: AGHT+IEj6GBLWfSQcX9NwG+2HiW0zk7ZDOLTJW7ffhbuIpAHMDYnF8XHaBHYcK/QPr3BfjrFfa2EzA==
X-Received: by 2002:adf:ed48:0:b0:343:a098:f41 with SMTP id
 u8-20020adfed48000000b00343a0980f41mr1393376wro.28.1714725856978; 
 Fri, 03 May 2024 01:44:16 -0700 (PDT)
Received: from [192.168.69.100] ([176.176.179.187])
 by smtp.gmail.com with ESMTPSA id
 d1-20020adfa341000000b0034c124b80f7sm3233883wrb.61.2024.05.03.01.44.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 May 2024 01:44:16 -0700 (PDT)
Message-ID: <d877da0c-d7d0-41dc-95b1-3b0435f14438@linaro.org>
Date: Fri, 3 May 2024 10:44:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/13] net: remove AnnounceTimer from typedefs.h
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20240502155331.109297-1-pbonzini@redhat.com>
 <20240502155331.109297-5-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240502155331.109297-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
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
> Exactly nobody needs it there.  Place the typedef in the header
> that defines the struct.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   include/net/announce.h  | 4 ++--
>   include/qemu/typedefs.h | 1 -
>   2 files changed, 2 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


