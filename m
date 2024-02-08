Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 819ECC48260
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 20:16:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rYAoZ-0001I5-AJ; Thu, 08 Feb 2024 15:16:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rYAoX-0001Hd-UZ
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 15:16:06 -0500
Received: from mail-pg1-x531.google.com ([2607:f8b0:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rYAoW-0003kh-8F
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 15:16:05 -0500
Received: by mail-pg1-x531.google.com with SMTP id
 41be03b00d2f7-5ca29c131ebso133783a12.0
 for <qemu-devel@nongnu.org>; Thu, 08 Feb 2024 12:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1707423363; x=1708028163; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fCuaNX41IgfJFeRck1YdDAQk3zfjmC/I0Vh6Xpt1AG4=;
 b=Wv+NXj9CCkO/uA2OKc66m5EIs5HhyHuK7dz4MI26LHPx9K+zLsV6vWO2eMoTUhbrxZ
 ExZiVwuiyMVpZBpvxgIjNYvd//RhHvz4TJQMx9W+mUjHL7xTVF8jGNOxEFDiP1QkUTA/
 fFfpdQ6NVZpumwvbZw6RRiEgzp9G186oLvIAmtbvpFvNHW8rJGUfD70srIiSye7O2WMh
 goS2NhZ6JIs6VBkclDq+JvfQcKCsi9aZ73WjI9e8e7/dJ8nObUyizmVax+BFpEwXlH0F
 igFxozgFWdxq75/KFw6FOZdhvqwJygRVDe/msQkxQ4yac4Knu1d+c4usAWxDBtxCkcS3
 V2YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707423363; x=1708028163;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=fCuaNX41IgfJFeRck1YdDAQk3zfjmC/I0Vh6Xpt1AG4=;
 b=CdDByjASqHSC2erqQgF9RJb0VhF5dwqbcLJzQ+/1b/VNQtB0QFAq6VZL5dZElBVc/U
 jwXf728R5lE/LvvrXBqiRPk/Dar8hFkgw1fA0Ixxu5taquQagWm+2NcIMeQtRFIWwiZg
 vigJzoh8b1694DmxmUUUjpngtenvFzeU8QkYOBnuFJqdZA93rlVSxJbJF6WdCpcY9ejP
 U+oxL3J4CQ7mPJ1avtZYSsDYUv3IKO7EFn2uqtHwidkjrbVvWw83eEbCcLIskAvH2tuN
 7z+guo+iAuqYsbwgKxGPfHTlHpHgs0dYCyW1DAcADGvbTB28eKCZhjIJEY1W35JllMFA
 Oj+g==
X-Gm-Message-State: AOJu0Yy/+JsMty91DH+KS5fMSzuNIVTOBv6Ujkw+ERVqCB/lAl3HLjM1
 8ItXXT0cXvoCfjprEDSK6CqHoYIJ7EN/2nww3GGW+hzmtegqoSWxXNKzHyiEpnQ=
X-Google-Smtp-Source: AGHT+IHdBudrn4s0LUr2Glv8lIzZnsm/+ng3Yia67iwpUwahWuNytlTuqP26JTF0ScnUk6lA3uZmPg==
X-Received: by 2002:a05:6a20:2d2c:b0:19e:4793:6263 with SMTP id
 g44-20020a056a202d2c00b0019e47936263mr810269pzl.52.1707423362713; 
 Thu, 08 Feb 2024 12:16:02 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCXYIZy+g2kFEssqXZR/Vlu8rMC3jSdRH3d/PDcFkeuZkF20N+Ay57kNqPAJUdAoG+uEW1JPRzfmieE/rgaVouwvBd/l23s=
Received: from [192.168.4.112] (066-027-223-101.inf.spectrum.com.
 [66.27.223.101]) by smtp.gmail.com with ESMTPSA id
 fe24-20020a056a002f1800b006e08437d2c6sm47171pfb.12.2024.02.08.12.16.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 Feb 2024 12:16:02 -0800 (PST)
Message-ID: <2b639985-8e99-477d-b014-59d9b25ba757@linaro.org>
Date: Thu, 8 Feb 2024 10:15:58 -1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 02/13] target/hppa: Add "diag 0x101" for console output
 support
Content-Language: en-US
To: deller@kernel.org, qemu-devel@nongnu.org
Cc: Helge Deller <deller@gmx.de>
References: <20240207182023.36316-1-deller@kernel.org>
 <20240207182023.36316-3-deller@kernel.org>
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240207182023.36316-3-deller@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::531;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x531.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 2/7/24 08:20, deller@kernel.org wrote:
> @@ -484,3 +486,33 @@ uint64_t HELPER(hshradd)(uint64_t r1, uint64_t r2, uint32_t sh)
>       }
>       return ret;
>   }
> +
> +/*
> + * diag_console_output() is a helper function used during the initial bootup
> + * process of the SeaBIOS-hppa firmware.  During the bootup phase, addresses of
> + * serial ports on e.g. PCI busses are unknown and most other devices haven't
> + * been initialized and configured yet.  With help of a simple "diag" assembler
> + * instruction and an ASCII character code in register %r26 firmware can easily
> + * print debug output without any dependencies to the first serial port and use
> + * that as serial console.
> + */
> +void HELPER(diag_console_output)(CPUHPPAState *env)
> +{
> +    CharBackend *serial_backend;
> +    Chardev *serial_port;
> +    unsigned char c;
> +
> +    /* find first serial port */
> +    serial_port = serial_hd(0);
> +    if (!serial_port)
> +        return;
> +
> +    /* get serial_backend for the serial port */
> +    serial_backend = serial_port->be;
> +    if (!serial_backend ||
> +        !qemu_chr_fe_backend_connected(serial_backend))
> +        return;
> +
> +    c = (unsigned char)env->gr[26];
> +    qemu_chr_fe_write(serial_backend, &c, sizeof(c));
> +}

Looks like this should go in sys_helper.c instead.
Missing ifdefs break hppa-linux-user?

Also, missing braces.


r~

