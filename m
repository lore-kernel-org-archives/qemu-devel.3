Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609BCC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:41:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzGOF-0005BL-AV; Tue, 23 Apr 2024 09:40:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzGOC-0005A6-66
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:40:52 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzGO8-0006kY-IL
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:40:50 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-34782453ffdso5738259f8f.1
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 06:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713879646; x=1714484446; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=u4htS5t1DYpGtgONQg9GpAx9MW23pjRZm5bcKez8yos=;
 b=j8aqz6cr/gi5FbjIE5ItyiLVFYbGXEi0Ys40cKF/M/J8S1XUVGZCedAgkRUzEV8NwW
 1MkUqyMKIHW/avMJd8OwSjZpBfxqT91WeFRwWUpAEB4yyg3MucK+OEHmqtp34WL2J8RW
 xsJhfict4UjXJaemgC3B0n3XxuqolINxAXi/yQhpGry1IvDFj4I5wZSHasWrkQblRpw5
 BUEEm14NZSoARFrkrOdcMv94u3xz6re9fObkiEj0MV1Kk3PEIbi1GZubIIv1almKTIbm
 XxfPZAxKxZl1/mqGN/27Q35UPildGPNnrdXtQ4OdzlvCW3+O1TXuC0aiR7qNpxusU7B2
 Emwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713879646; x=1714484446;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=u4htS5t1DYpGtgONQg9GpAx9MW23pjRZm5bcKez8yos=;
 b=GTRGLv6B2eJdTFe3nlraRNap5ows6cTqbjxBp5Fe4xDwjVu1LaP9fRVXe6SHDhrWJO
 zt4wBabcMuLkvUUMzHg0eQx5T6LAonpxmulqsKXYZ/A/65kw77f2FRUdgrK8l0QH+6cq
 dPVNHShaP2MpoMeKu1byNc7H4DVdJ7vFxBE2DAvw0+a0nGxsDGEvX762vtEQ0Js5pVBu
 zKYFvDIq5W7z5WJmjThdhubMoMm2r32uVDFz2jaeycG6cQx/tPLEaD6BKfrrltmflC5H
 F63p8WR15IuTFcyuB3q01qho7a1q0YFkAtg2u2Fc2FEKbX4Gcwwy8lqClTNjyl0OmFWP
 SvPQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW10+OqzRP8qOnA41+P4QupMjyWkRG6R0kYTlpKcONrSu2Lp04CMatFP0rjIOyEUwdyciM0yTWxB7dPNgZdNZBQKNIr0vQ=
X-Gm-Message-State: AOJu0YzdaBPNNlsIvUuKjcbLni2UgimKZGkdZn4zOWmKC/jmbJIz2Qnb
 mMDO23m3NOYheFHglIJT0nAiUQhkG2wrLjpZnt77PQIUrNH2UGXxzJHt2RfW7uaIxlao3Y7B1ok
 SJIc=
X-Google-Smtp-Source: AGHT+IFjzc9OlAkOs+jH2ZRJB/tJoGXt2UZ8VkH46OsIZi+tKlF6wa6sbQHYU/kBfFgOPnK9Ohaytg==
X-Received: by 2002:adf:f308:0:b0:343:8551:8d90 with SMTP id
 i8-20020adff308000000b0034385518d90mr11023822wro.34.1713879646608; 
 Tue, 23 Apr 2024 06:40:46 -0700 (PDT)
Received: from [192.168.175.175] ([92.88.171.241])
 by smtp.gmail.com with ESMTPSA id
 cg3-20020a5d5cc3000000b00349bd105089sm14569704wrb.47.2024.04.23.06.40.45
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Apr 2024 06:40:46 -0700 (PDT)
Message-ID: <82ca72e4-ab57-413b-bbbf-59e16274bf7c@linaro.org>
Date: Tue, 23 Apr 2024 15:40:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 13/22] nios2: switch boards to "default y"
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: farosas@suse.de
References: <20240423131612.28362-1-pbonzini@redhat.com>
 <20240423131612.28362-14-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240423131612.28362-14-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
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

On 23/4/24 15:16, Paolo Bonzini wrote:
> Some targets use "default y" for boards to filter out those that require
> TCG.  For consistency we are switching all other targets to do the same.
> Continue with Nios2.
> 
> No changes to generated config-devices.mak file.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   configs/devices/nios2-softmmu/default.mak | 7 +++----
>   hw/nios2/Kconfig                          | 9 ++++-----
>   2 files changed, 7 insertions(+), 9 deletions(-)

Hopefully this gone will be gone before you get a chance
to merge this commit =)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


