Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B56FCC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 13:30:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzGD7-0003wL-3i; Tue, 23 Apr 2024 09:29:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzGD4-0003vb-TT
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:29:22 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rzGD3-0003ux-04
 for qemu-devel@nongnu.org; Tue, 23 Apr 2024 09:29:22 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41adf3580dbso863175e9.0
 for <qemu-devel@nongnu.org>; Tue, 23 Apr 2024 06:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713878959; x=1714483759; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=BUWBtzbcbCSP5D8LbuHFzL/Zcm+wRPLde1EcDYSRM7I=;
 b=dVTlM4bMmA+MtNjLnYVm2qwC4Ed6HL3EWCIOIZ4TjxKq6ILOu5hvf2nYkYbsiO2HsH
 50e2cKOJINKH6ZDbqH3VEBrTj9qnlS4FlHy32rf3cM/lpz68yIori8zGBh/kCrWckygO
 UxZYKlmbWZk8D5RWsLjjqbwBSxqmuESiVrNVj8vPQny5QWYtPgPzNVxmzeso8AG3jRQs
 xyNm2YvyY1EBxlmhDcLn0/BKD2Hrv61Y1ZEDQMZpzWma/1TgcRDS+lNIoHtto0GETM4R
 l8tV1awX9XGuxfufGOv5oKh1UXvmvwHRQ7tjPdIxPjbyq8A38In/P4jVyfVjKx6AH6T+
 B3OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713878959; x=1714483759;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BUWBtzbcbCSP5D8LbuHFzL/Zcm+wRPLde1EcDYSRM7I=;
 b=XvMPxZ2hlEjwSe7FsAPon+4b5QD8FuVQyyTeTOVmSrQRBRP3GkpP6vmcxRls6pCymr
 JMqdvI+i+zMyeTeTua22ywUW24jggdK4G7rVVJhAGMzmqPEid3tER2wIRm3FMzcLLNLt
 +T4TkN5pW/ctSb0QwdhqvpFY5XhrpJ2l0tdPp+20S/fmTKEVEnkrpsuvXzmadWeslHGp
 FrFE0jPRKf1LzfphJsfrxjhcU16RBsbvSA958O8yC2/mCltajNrSE60AUlfRpfW8DxWz
 xtbMHho7ITaxLHW10uVE7/6C/reofkodhA1JwSgaXXXPF/F+aD+CklYwkKX4JL84Snha
 4+XA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWB7Pc9btbeaIao9gLMdHgiV8VwVIODnwfblcpOxSfCQ7S0B2wTuLSaMNcGp2z+R8gEIN8TDDy6u0R6NZ79FIL8CXQKnFY=
X-Gm-Message-State: AOJu0YxfJIi9aN6b9fhEx+ELWZom5xYra/1NY2wOV8ruQChrLl4p/hgn
 dn/1d72/Lolq8WjjIEwF9Qrw9ghiUj2n/O8hMMstvGsHkuPhIcbSadQs9w0C/UU=
X-Google-Smtp-Source: AGHT+IHT2fUAvkuMtUZPKy4RtT/MhgvmafK1DJk9x+zN1aUEXN3UDnCeLUOCi76vX5zztRFQoW3kKA==
X-Received: by 2002:a05:600c:1ca9:b0:418:9d4a:1ba5 with SMTP id
 k41-20020a05600c1ca900b004189d4a1ba5mr1862143wms.6.1713878958831; 
 Tue, 23 Apr 2024 06:29:18 -0700 (PDT)
Received: from [192.168.175.175] ([92.88.171.241])
 by smtp.gmail.com with ESMTPSA id
 t18-20020a05600c199200b00417ee784fcasm20195753wmq.45.2024.04.23.06.29.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Apr 2024 06:29:18 -0700 (PDT)
Message-ID: <0fb3f5f5-4016-440e-b102-88e75ea94d41@linaro.org>
Date: Tue, 23 Apr 2024 15:29:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/22] avr: switch boards to "default y"
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: farosas@suse.de
References: <20240423131612.28362-1-pbonzini@redhat.com>
 <20240423131612.28362-5-pbonzini@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240423131612.28362-5-pbonzini@redhat.com>
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

On 23/4/24 15:15, Paolo Bonzini wrote:
> Some targets use "default y" for boards to filter out those that require
> TCG.  For consistency we are switching all other targets to do the same.
> Continue with AVR.
> 
> No changes to generated config-devices.mak file.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   configs/devices/avr-softmmu/default.mak | 5 ++---
>   hw/avr/Kconfig                          | 3 +++
>   2 files changed, 5 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


