Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FF77D15DA8
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 14:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2tso-0007wT-Td; Mon, 21 Oct 2024 10:59:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t2tsl-0007vi-4h
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 10:59:43 -0400
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1t2tsj-0002PT-4N
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 10:59:42 -0400
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-20cbca51687so46530155ad.1
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 07:59:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729522779; x=1730127579; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=dFjPAHHDer3SFha5yVymLMykIfDFjcvVqLxABzb0430=;
 b=iLUykHhGAhYxsX6uYDZlZvouchqoCpZRAJ0Z/BM1kRgaoCeJh5iZbKo6C6Yr89oLoN
 VDlyMJbSm10VhMTE6Rp2qYL1cWwl7DXOn1n1AnFEoMun6R3f9Ut4AqHKR9bNp1If7Vey
 ndMncz1VVkj5tIfRLfv5lJrHZIH3w37c3fee56M6jCg08a1wiCH3AD2N2wMifDNZHgFc
 wR0pxMLn9dUJUOSyxxjvK/mBPnL8MOecjE5KEoWdp1r0Ifzc6DscTdeq3Sabwtr+LuPz
 TBqZ95PvQtwATb/NxXqBT+3SGv3iAsN2dK0BZ4WhGf+jFR4eZctZzD+u9TG6dUaQeWst
 jmtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729522779; x=1730127579;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=dFjPAHHDer3SFha5yVymLMykIfDFjcvVqLxABzb0430=;
 b=jfQfrEYMcU22gRC5yHDd0C4hIYLy+XW1Th/Gt6B0mshvI6X0/iIuv/64nut79bF41f
 M3C2WB6j61z1EYlpe+1ynMV12gmFf+KRGniiVuviiT1ROPIa5B6ius1Lsm5XiaO2D8eY
 1M2ngtYFoaS9CLJuYVTKQ4grsBJmd/SWZ7AvmLGVcIrg8+fjjudfAxMfpRzSjvbCuGTp
 4mVq0ciU06cAv/SzRnr+gv4qLzpK8ZbCCFlgDyLPKqMx8uZGQj5UNkf2Qnga4kSvYHzv
 12WEt20nJCFLUOzqCU3VAOJZP0b1TbUrNH+31A2cI1EJcn+iawGqCWeg1T7R0al+hpvB
 Vcfg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVcUQcd0SrcpZV53hauYRiX0ELjlqTCYBjJjL11I/u2AKGP4vLR8MUdGnGBUqAqallTUfNYquOqfq99@nongnu.org
X-Gm-Message-State: AOJu0YyzmSvx4n3fi6p6/yJvHKG8fuH27YcZHSQxhQs3Gy0s0TjAEpBc
 zZ5wPox4YSVnI0OLIQ7EkAXYqLUwd0kXk2q7LXCxaqFUU6WikEQ+930+xmhjPxE=
X-Google-Smtp-Source: AGHT+IHecwHoa0MPUS0HInKRuWBoSXgX0rdlC3t9yo9mJMLrXX4a6R9RNSBue422R2xhG6Di7OFgAg==
X-Received: by 2002:a17:903:244e:b0:20c:9da6:65b0 with SMTP id
 d9443c01a7336-20e5a8d64fdmr159325955ad.35.1729522779444; 
 Mon, 21 Oct 2024 07:59:39 -0700 (PDT)
Received: from [192.168.100.35] ([45.176.88.171])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20e7f0dd499sm26902265ad.223.2024.10.21.07.59.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Oct 2024 07:59:39 -0700 (PDT)
Message-ID: <66e12f91-1c8e-4339-a902-b51552d23bda@linaro.org>
Date: Mon, 21 Oct 2024 11:59:36 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] test: make cached assets for functional tests read-only
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Thomas Huth <thuth@redhat.com>
References: <20241021123633.1391911-1-berrange@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20241021123633.1391911-1-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=philmd@linaro.org; helo=mail-pl1-x632.google.com
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

On 21/10/24 09:36, Daniel P. Berrangé wrote:
> This ensures that if a functional test runs QEMU with a writable
> disk pointing to a cached asset, an error will be reported, rather
> than silently modifying the cache file.
> 
> As an example, tweaking test_sbsaref.py to set snapshot=off,
> results in a clear error:
> 
>    Command: ./build/qemu-system-aarch64 ...snip... -drive file=/var/home/berrange/.cache/qemu/download/44cdbae275ef1bb6dab1d5fbb59473d4f741e1c8ea8a80fd9e906b531d6ad461,format=raw,snapshot=off -cpu max,pauth=off
>    Output: qemu-system-aarch64: Could not open '/var/home/berrange/.cache/qemu/download/44cdbae275ef1bb6dab1d5fbb59473d4f741e1c8ea8a80fd9e906b531d6ad461': Permission denied
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   tests/functional/qemu_test/asset.py | 3 +++
>   1 file changed, 3 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


