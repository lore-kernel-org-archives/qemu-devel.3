Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D727C30653
	for <qemu-devel@archiver.kernel.org>; Thu,  4 Jul 2024 16:31:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sPPML-0000pV-Pr; Thu, 04 Jul 2024 12:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sPPMK-0000pD-0X
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 12:31:00 -0400
Received: from mail-oo1-xc2a.google.com ([2607:f8b0:4864:20::c2a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sPPMI-00047Y-JH
 for qemu-devel@nongnu.org; Thu, 04 Jul 2024 12:30:59 -0400
Received: by mail-oo1-xc2a.google.com with SMTP id
 006d021491bc7-5c46c8ccfa7so408248eaf.1
 for <qemu-devel@nongnu.org>; Thu, 04 Jul 2024 09:30:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720110657; x=1720715457; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=T7MH3jv75EW6R+PEBAni5pRk+IkKfkvy2qoC/ZKedbo=;
 b=e7IRR9cu8hJgyuon6QoyhlLz24C5I+qYfbuSPks25F2HExpm8ZaV356QyclbCsbikZ
 Rx5S++IesMTyYCbcAl+ho8GibWSOzFw9e576PeKRcJnwatUCletFc3seBso2ssDuMLc3
 mJTk4w9I6gY06j3B6vgcQbqyoP6pABj/G45+gfGe/64fgWuJ9MEta1lnVGzxeG61kbaf
 ifv7tzPZcjNPT7zQxQykEQHvo8uQZS5n3x+HAPi65mOGzXJ6/7E8kLStTU8Lzds8UXTY
 NbOuQGz0GedmmgLc7VhU93tJtjDZK6x7duyNtSOphFo9lLgPpV0khgNC9J8dyqCOhrSm
 ky6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720110657; x=1720715457;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=T7MH3jv75EW6R+PEBAni5pRk+IkKfkvy2qoC/ZKedbo=;
 b=LlWCoyfELqK7srvsNIW+tFzqfMFxqHEwEkOUJdFSoKHuRw5EaswlQ6w1tsCU2hygSC
 sh4vJDZUWmAq+jPdCaJH+ZIDkZHhfv0LTge+2QJUSp+Xgy9O9cruHv12k85zRUs9DAkH
 6ijgB0xQx+cuwMmq+cjWut5tjxNDMqYZFX5Hev+LJjGTu/F4maXESlIancS1oLImbYRo
 b4TcauQpZPfFAAgizU8E7hsfrzGK5Eg+8dkjhR4NwSpcudJUFJ4D3h27n6aQVti5zoLy
 Xokb6gJDSIjEKlQC4x0peWkCdNs2/AMoOr93JWovB/Yj5woGkMpzDKZ9Hyo5YI7xJtO7
 sqqA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWcAUE9nyKAAR2DMAW+kzsd/gqINph46l2+pNG9Zw+oYd7U/yadinJKSn1mw5qjQaX586681IoqTE5p+Trstxb5/qi/eeQ=
X-Gm-Message-State: AOJu0YyoGuYSSBP58wqkdcjtpTjs0lHruRHZmdx99DZHRxzdtbuDy7Ro
 DmUT/JVOqNkxpM5T/xtze0M9BIZ16picKyURbIb7AN2xLpGh00Tgri2Q+1QwbtM=
X-Google-Smtp-Source: AGHT+IFIZfNIIoq+0LpQT2SgXN0aVYH91aHNwSiML8kzCkxxTViPEO949nK4SBCIvVLyO2cIVWr4fw==
X-Received: by 2002:a05:6358:7f1e:b0:1a6:72b8:d08f with SMTP id
 e5c5f4694b2df-1aa98ca45abmr195742955d.29.1720110657167; 
 Thu, 04 Jul 2024 09:30:57 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-70803ed469fsm12466176b3a.111.2024.07.04.09.30.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 04 Jul 2024 09:30:56 -0700 (PDT)
Message-ID: <1b23fba0-ab69-444f-8299-9db4f33373a9@linaro.org>
Date: Thu, 4 Jul 2024 09:30:54 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 6/7] tests/plugin/mem: add option to print memory
 accesses
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Alexandre Iooss
 <erdnaxe@crans.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
References: <20240702184448.551705-1-pierrick.bouvier@linaro.org>
 <20240702184448.551705-7-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240702184448.551705-7-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::c2a;
 envelope-from=richard.henderson@linaro.org; helo=mail-oo1-xc2a.google.com
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

On 7/2/24 11:44, Pierrick Bouvier wrote:
> +    case QEMU_PLUGIN_MEM_VALUE_U128:
> +        g_string_append_printf(out, "0x%.0"PRIx64"%"PRIx64,
> +                               value.data.u128.high, value.data.u128.low);

PRIx64 does not pad.
You need %016"PRIx64 for the low value.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

