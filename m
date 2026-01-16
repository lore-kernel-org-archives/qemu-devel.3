Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 207BDD4A608
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 07:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vge04-0003Mh-Gh; Fri, 16 Jan 2026 02:12:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vge00-0003Kw-Ti
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 02:12:01 -0500
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vgdzz-00018b-Ci
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 02:12:00 -0500
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-4308d81fdf6so967081f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 23:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768547510; x=1769152310; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=5CAHwUn8YXntEQ8O4POihLaO+M8kM/Rf1a0MQloUD/g=;
 b=d77xYMZOGUjE7VixG5uecoxlQRegFFA8AdXLaCSiNoWjK65KhY5f+5j9+uBYSfrNy6
 UBe0x4lwmZhnI0dKSloeInT3xHD3d+IsIOcjvdflUOUI205PH2bkbD1Z8osiwJYqMUwj
 F6pO4osBtg6fej5plon+aK1/ytG4ZzIEuFV+YmvV8vjesZscxh2gnufW9h8LpeSRG3ki
 9tOHiCWSfKVxQIBEqGoLygikTzsxQUIrDul2xdw2R3ONBKaCYnNNea1KYDUzOFunpYdr
 hnO/hDy/yLMLxGGSMt/taHYej6iB2IwE+yQ2Pwf9lvOzxGqA7eGb26kbV/oUvzEUuSwI
 c6Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768547510; x=1769152310;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5CAHwUn8YXntEQ8O4POihLaO+M8kM/Rf1a0MQloUD/g=;
 b=f64zJ5hDFkVgf2xjrx6+k0PTC8TTUj1HCcsa/XAsj8MT+n5D2iliHLG5N59GBRNnMX
 9VWAijCADhCe1jr2IlI2fUVhmgtR3xd0aqtKfTWxqPhgDQaqJa9vKwC+fWthQjhttwYI
 1N/0P4L3jeLKdGetRvjgiwx0MGzuhLW+uFdf/UECrcN6QvquXyRtsF+lB0WL9DQd/uv9
 pXflARglx6YPtPZkgPKw26+t0VBy0i4i5iyN+f3w24YVLIU76SnBGCUVGeAN/ijr5y92
 y7lsWPefwpS7Xl89NfVcZJ7bIeaAjHHgsSHndG2rxNQwTtjPGHvd2WGKSZQs+GX8A/6M
 iiTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVCfRBAhi3HpTwiCz5+IUZgDCNBFK+jJ4X0n2xqwMo29nfGY2GRHHGqcR9Ul98/DQgSHErzcX/q2eoe@nongnu.org
X-Gm-Message-State: AOJu0YwheFS0Giexca+B/MRZZRz0n4xn25IB/s3U//0NzOyCaDD7DkIQ
 /znzXudJwTJFuRRc2YwB8/8dF4PU7vGI7VlKmDF0w9GOmSzNOLu5gyt4ZhJ8ALCgNfSHyInRGFw
 pOYP6aN8=
X-Gm-Gg: AY/fxX45NAOIGlJTJvUkf2t714we+DUN0Cdp8p4I2E/SJdRZSROIvmX0nZrI2jtBW5i
 ijN8T2E9b55v43LF0QD7/urZaBMaFmF1GQQGzi+k41xvGHazptX9GldKlXx1L2YmMM1toDb+oC9
 wY8gt9mgax5b1kuVs3Y4TCcCPFLHpVUu3LHq3cnVV17RggsxpmgEbNsgQ5REqz/qnw0KFyTMt8s
 wFuMB6XvpkwRF2hw+KYCYEWgZ1yyqmX7gRtYV00+4aQLhI/+4sJtEM/Bx22U5Fdo+343qXHphkT
 88aDFL6R3rMnMe96w8tuuIr4/vW9FRUDgMBh3MVQ2CPcQVkCJ0eXL9LPc3KW461WJjmp9NQB/LM
 oESgv+JxRl1GxzLJzjwGgtC0LDuHLuFP1lEQeX4BAbAh/WhE+9yjVu1D4d2uhy1br2Wgoo2iH5W
 Yc1+1O9cNHVgLWyEmuWpaXYGVht2iHfaeS64eCsC6dmIxCkvjj/md3KOjzbf1A7jNo
X-Received: by 2002:a5d:5d02:0:b0:430:f97a:6f42 with SMTP id
 ffacd0b85a97d-43569bcd728mr2076503f8f.54.1768547510429; 
 Thu, 15 Jan 2026 23:11:50 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43569921dddsm3591061f8f.6.2026.01.15.23.11.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 15 Jan 2026 23:11:49 -0800 (PST)
Message-ID: <7be78f97-18b0-42a1-98ac-084a1a4c005d@linaro.org>
Date: Fri, 16 Jan 2026 08:11:48 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/3] gdbstub: Export host_to_gdb_errno File-I/O helper
 function
Content-Language: en-US
To: Yodel Eldar <yodel.eldar@yodel.dev>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>,
 Richard Henderson <richard.henderson@linaro.org>,
 Dominik Disconnect3d Czarnota <dominik.b.czarnota@gmail.com>
References: <20260116014612.226183-1-yodel.eldar@yodel.dev>
 <20260116014612.226183-3-yodel.eldar@yodel.dev>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260116014612.226183-3-yodel.eldar@yodel.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 16/1/26 02:46, Yodel Eldar wrote:
> Move host_to_gdb_errno from target/m68k/m68k-semi.c to
> gdbstub/syscalls.c. Declare it in include/gdbstub/syscalls.h.
> 
> Add both newly added GDB File-I/O supported errno values, EIO and
> ENOSYS, to the mapping.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Yodel Eldar <yodel.eldar@yodel.dev>
> ---
>   gdbstub/syscalls.c         | 36 ++++++++++++++++++++++++++++++++++++
>   include/gdbstub/syscalls.h |  9 +++++++++
>   target/m68k/m68k-semi.c    | 29 -----------------------------
>   3 files changed, 45 insertions(+), 29 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

