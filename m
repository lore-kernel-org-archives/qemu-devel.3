Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0580DC54F30
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 13:57:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJunq-0001UK-Ou; Tue, 27 May 2025 09:57:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJuni-0001TG-Io
 for qemu-devel@nongnu.org; Tue, 27 May 2025 09:57:06 -0400
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJund-0005V2-Ns
 for qemu-devel@nongnu.org; Tue, 27 May 2025 09:57:06 -0400
Received: by mail-wr1-x436.google.com with SMTP id
 ffacd0b85a97d-3a36e0d22c1so2282932f8f.2
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 06:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748354219; x=1748959019; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RdXZjGyQyGHTnmuMa8B9RY4a5JMFFnrMACzLLOKREOI=;
 b=xybSM1+uixnzdDPuzquxwtP7Hxukm7+m+Xu+qwHpeSJG5xVmuIzKiYZucFMDdppAWB
 /0HJUBXfRu3zTmC71QBO9AGcQC7G4UDLKLaNYudDavs+u6MxRL4k7YdX9966046z7ren
 KXwEMRvuH2+yL8mY9Xx4dOtj3eKLs/obaw8xJLgs7ZfMmaRpDij4geFRjq01mATZfCCz
 Cmp/t+mSrEBC3FJ/a5LjIu9zsBTMaNKu8IH0TBWpSd0rcWjHosLxXddGvExt7T15x5Fr
 lpMPx1TRZfJefdPewx4e4UyylCIfPmW7pN4kTFgeibNJCBK+MkbOrg418vfkFkgUn5yV
 Pk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748354219; x=1748959019;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RdXZjGyQyGHTnmuMa8B9RY4a5JMFFnrMACzLLOKREOI=;
 b=m55a6QzKlBrw8C4F3cv5t2weWOrOszjGDyhdVSLQotsOncW7naEVl7jXMaQ3H25/gF
 8Dcg/zvrjcQMjtSDVbZwnv5APl62NGYlBMwN2PYw9hcFXVO2ac0AdsdCymcJIiMNltWE
 WbRg/G8bO2OsLo/TZKe15rjEsEBMbJ7fTrtxSB4pBAefoF0Dn4fc7ewU9G/P6mYwF/yh
 AFc9cJE6JvHrcBEt+fqTJirnRsBY5MsROA6xwrhHRhZ2tZXsr9xC6nSrGhOivFO06YcL
 AlDAESZaRSpo103qXQYj7wwIjNInhNAqyF5g+GU60f8ftvJxhEHrjT/9OxJtR7ZCHcaK
 FxgA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4JN6xynPVE15ujGe4rSnawP20b8a1DblcHzOCTPqjTO2oqeRglJxQoJYawby1faKHiv+DYQp0P8Yr@nongnu.org
X-Gm-Message-State: AOJu0Yxz5RTLT8PrKaknHmzJdco+d9DdiHm77HA092P7kj6NOdSViwZc
 6q/pjBVObixsyyGzVqpszvo2Z0t0nbIq8xrHYB7g+yu/ILJWRJ228qliVtV8vJUOBT0=
X-Gm-Gg: ASbGncsKmKvD1FpzFpyliHpHfxAf7/6J+KvUv+ARHpzDlgm07fBhhiErDwvfhwM0TQu
 PPn3/aEf5SJYF+h8GlnfQOWIpSCzDVQB7117XO9eu0l1nCMJCigIh8ci67rMDtV4QaBoy7tVwiW
 +usacSNFxns/tPiPx6jmvvSBui/vJRekZX7EemH+AXroyx2JHVZrsqa4edkT6XSCUzaPXgXHES6
 Al3PLTxkF29W8SisrXjPKkq5ZJWXuHvya1iBlJvlranZcqymAeUFa3wyt7gshii3JDuw5VCCk7B
 gRBe755EC/lHQP2ZSESkaEI0ejn2DpOp2iYAXW/sDkbQUBzAHHEtR1Lf6iH2QyoEhx2xTDbT9X9
 aXonH1SQ/9BQJfzgBnIEr0+WC
X-Google-Smtp-Source: AGHT+IEIT2R68u5kDYyMEVLz9eitfQ9nWIacFWei25DVtcVfn0Gr+QOXn+laqIajFLBUvn6BycQZtg==
X-Received: by 2002:a5d:4102:0:b0:3a4:cddc:d3da with SMTP id
 ffacd0b85a97d-3a4cddcd4f1mr8992596f8f.36.1748354219502; 
 Tue, 27 May 2025 06:56:59 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a37fb452e5sm20345153f8f.20.2025.05.27.06.56.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 06:56:59 -0700 (PDT)
Message-ID: <dd7689b5-edfb-4f2b-9aab-ef5f92472040@linaro.org>
Date: Tue, 27 May 2025 15:56:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] hw/microblaze: Add endianness property to the
 petalogix_s3adsp1800 machine
To: Thomas Huth <thuth@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org
Cc: Alistair Francis <alistair@alistair23.me>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250515132019.569365-1-thuth@redhat.com>
 <20250515132019.569365-2-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250515132019.569365-2-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::436;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x436.google.com
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

On 15/5/25 15:20, Thomas Huth wrote:
> From: Thomas Huth <thuth@redhat.com>
> 
> Since the microblaze target can now handle both endianness, big and
> little, we should provide a config knob for the user to select the
> desired endianness.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   hw/microblaze/petalogix_s3adsp1800_mmu.c | 41 +++++++++++++++++++++---
>   1 file changed, 36 insertions(+), 5 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


