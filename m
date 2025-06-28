Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14789C54ED1
	for <qemu-devel@archiver.kernel.org>; Sat, 28 Jun 2025 10:10:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uVSV7-0005Es-HU; Sat, 28 Jun 2025 06:09:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uVSV0-0005EF-Ic
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 06:09:30 -0400
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uVSUw-000803-Fk
 for qemu-devel@nongnu.org; Sat, 28 Jun 2025 06:09:27 -0400
Received: by mail-ot1-x32f.google.com with SMTP id
 46e09a7af769-72c173211feso240853a34.1
 for <qemu-devel@nongnu.org>; Sat, 28 Jun 2025 03:09:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1751105364; x=1751710164; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ES2fZs3jpJrPDKjM1pdP0S/2RlCzVs5+c8N6vB9RCpA=;
 b=g1qXVGCNy2CEHcU4gJpj75nvFYkt1hjOYoKlrIJ5HyNC95gIFwPtlB7PVSyvSJomS2
 Y/tz/AK9fgdGq1RAlGG4TjfM9AvTYLzKQqX6FvjrLGkdBkPkpiuBUK6BmAUgMpVhmWGV
 vfPIlRN1p6cQX4P5dEDmaHyKEmAq9EnEefKqgES50Yq3wG0HwtL1tPe02tRrf4c2IrXQ
 KI2wQWpbno5xZjB+WxwYfZPzPxpnLr5IQdKGAeZ6Gd/RLkzRgDuJrjoKaMAkgqrkyZSa
 4mykDvqf2lXRHCdQ7me4hpEy4lPqqbBGohOqztzD2IFnWP4e6Sji/BUvsUOpf5yi04+H
 P/Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1751105364; x=1751710164;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ES2fZs3jpJrPDKjM1pdP0S/2RlCzVs5+c8N6vB9RCpA=;
 b=hzrkUlNH29oWZiEFUi7B+Fahe24gA4bXXc97nYtjtQgKMux4Pm+CrqpXRuuQk4i6zr
 BwaDtChreiH64l5dhMDe0M/gsA+QUAiZGzxOfIPusmys1ej66Q5rTt3nPkhLWIL7f7kU
 4ZPFUj/24W0qXW1jTGmddxB4ynvU8j94hrYRrM7TdLjVCE1uSM7TlrcuzwM+hvsIwIcN
 JAd3dqkJGCUEwubRBLn3WsE6j5TH/+FBMuLEj+An/Q5bG58V9tSKKnRESCUttkKPisHh
 uPudlUit9XiDWOzm9yvsvSJfC7IX02I9vnmfCZKbOQrb2Sn+OAytdjHiA5aJRgPBbXjj
 oU/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfiQ/eQj4iFNgtKkL5MxLZrKXI6Zyx7+fNoRnGsZCKOo7TFNeW0zIZkRlz1jm37tkpklCo1jyhBuVK@nongnu.org
X-Gm-Message-State: AOJu0YxK++Hu5mhMXurv4PUnqExt1K7+pxfPi6lqESYKwPZNMVKMHU7G
 i5vlK+yEN/DHDFPS4Fnxy5yOWZK5mz8zL+u5qFOrZKB6hx0o/uGqJqWdnJEx8BVWajM=
X-Gm-Gg: ASbGncvT/r9Mn6NqQ+V/+mLWCEvktfEiKhQ6yRmxZAbsYqxpPAhAhxXGXKpHbti9NX4
 trrqFCR9B/T8rwbuFve5oYkJg5PYDHzTfjj8XUQ83iIuUT44THHyRLE9gxZZecA/usp7qCehtVZ
 9NrYJlylEDgCPcWBHl/3LsgJX8xZ3nl4VDrD0wr8kMjOGySLLIWMOD8MZvNt32oVseG1Uk8mtmt
 DQWHVW96C/tEJmBAo8ghONuBRFGlhbq+PuWcSDVVwHxIwlL/IRdzH0KPttbBOsC/EmEaFt7L4wK
 ydifGzZ/BgNkVRr/i6DnRdJY2d+SDDnZkoxSRc5SY6nnHoYHwy3tRE+KhxFpdVD42xe1yvwynHX
 T
X-Google-Smtp-Source: AGHT+IFZtMMwHzu7mkiApOWXadN4s4RFh2uO+NGn6E0me4MP7Alu0TycQ94m1HOC2NimQEU3iZBfWA==
X-Received: by 2002:a05:6808:152c:b0:407:a47e:6e43 with SMTP id
 5614622812f47-40b33c2a0f6mr4369638b6e.1.1751105364535; 
 Sat, 28 Jun 2025 03:09:24 -0700 (PDT)
Received: from [10.25.7.25] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 5614622812f47-40b32420c83sm769724b6e.36.2025.06.28.03.09.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Jun 2025 03:09:24 -0700 (PDT)
Message-ID: <a0553da3-8bec-4e08-b5d0-9ad32b1853d7@linaro.org>
Date: Sat, 28 Jun 2025 04:09:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] target/alpha: Add GDB XML feature file
To: Yodel Eldar <yodel.eldar@gmail.com>, qemu-devel@nongnu.org
Cc: alex.bennee@linaro.org, laurent@vivier.eu
References: <20250627204817.47595-1-yodel.eldar@gmail.com>
 <20250627204817.47595-3-yodel.eldar@gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250627204817.47595-3-yodel.eldar@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32f;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32f.google.com
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

On 6/27/25 13:47, Yodel Eldar wrote:
> This patch adds the GDB XML feature file that describes Alpha's core
> registers.
> 
> Resolves:https://gitlab.com/qemu-project/qemu/-/issues/2569
> 
> Signed-off-by: Yodel Eldar<yodel.eldar@gmail.com>
> ---
>   configs/targets/alpha-linux-user.mak |   1 +
>   configs/targets/alpha-softmmu.mak    |   1 +
>   gdb-xml/alpha-core.xml               | 136 +++++++++++++++++++++++++++
>   target/alpha/cpu.c                   |   1 +
>   4 files changed, 139 insertions(+)
>   create mode 100644 gdb-xml/alpha-core.xml

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

