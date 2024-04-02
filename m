Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 071FCC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Apr 2024 11:01:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rrbrq-0002W7-M3; Tue, 02 Apr 2024 06:59:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrbrO-0002Kz-I1
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 06:59:30 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1rrbrD-0001No-KO
 for qemu-devel@nongnu.org; Tue, 02 Apr 2024 06:59:19 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-415523d9824so31605225e9.3
 for <qemu-devel@nongnu.org>; Tue, 02 Apr 2024 03:59:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712055550; x=1712660350; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bg2C6HUNavPzHDH2TiN+WuMdpPwhnQUMcYlg7KGYexc=;
 b=ooYwAU62Y6z1y1DWuRVRdyCE9GFphtTkpI8Xx0O//6j5fYtnOUhaBO7y4hUFjlXCjB
 zWjnV8Xdpx9zMV27LoUrzK1hi/gcp9bC3W5phaxFFi9uxa4DH53/T0NSRXKynEWi5Y/p
 YOD/RJmxNw6DWRaPc6RkXGsRC7FJa0QRU79iG3+j3HIZJTmz3E0itm/4YF1Lb0w7heGM
 aVTS4AMRX/vR7SebWbyCFdzrdGk/eRKCmJJt0g+ajPsJBKmi+yOGPqc+3CFQl3kCL7A4
 ANXfdRgLVuXPKrp/dktaSBBLlWOiMIrNOJdl2T+zh23rUk/Cw/Y9j/u2CCd9R5Jr6q7t
 mmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712055550; x=1712660350;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bg2C6HUNavPzHDH2TiN+WuMdpPwhnQUMcYlg7KGYexc=;
 b=lOtLqpAHTARl+p6aeqqMVDjgMOkQayKt4bLTZtr7eXx9y7AGcsLF07aZ+REDt2pJhh
 q3LW96oYZt1egOBLFJYwoq8HAUJCi+Ims7+ZoHE/y1HarguwT1FDdgFbJ/nhaVM2y1kr
 8XBZcRGSJtt9gU4j5j5vG+ogFY3bDQrbkeBJB44PVWINhJjDs1NzlxjSSEhYEt2rYR6J
 I+f8Z6joncTlJnbYccw3cQWeJPtavyS6rCGbygeuaGXLE0wzmu4kUBP+t+67QLAxZthG
 sqi5/ANRi6A9WKCMGsRB4woGal+LPmCmd/UZfgPQxRVFbdOlOPMJBRK1ti46OFyfTGpc
 PZJg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW7/y+no0wGhgkGDbB4WhOpogLYdeX1T1UKXv6DsKGi0b1n5sZPIhnrLbJJHrCt5DfgkvrxfECRVQ2Hun2bCp+qrIROHSI=
X-Gm-Message-State: AOJu0Yy+cR4xN3yY1YPmD9cpEMja9JEppz7T3q0zkIZ60a7yeoYJw4Y+
 CVgXEpEJKehrn0UdNkxL3fgtZUXSSYeS5tgNvZBvFf0vBgI2fK2RzDzyrmSY1VzRqgvOqCfnrRe
 Lcoc=
X-Google-Smtp-Source: AGHT+IEA9Fh+uSGq72ZiUZKC0XFJJKx1tqxc1ZDzX01ZEk4sdL0wUy10yFWH7DlSKM81Lu3qlUj+yw==
X-Received: by 2002:a05:600c:3505:b0:413:ee55:8bba with SMTP id
 h5-20020a05600c350500b00413ee558bbamr1253687wmq.4.1712055549747; 
 Tue, 02 Apr 2024 03:59:09 -0700 (PDT)
Received: from [192.168.69.100] ([176.187.202.91])
 by smtp.gmail.com with ESMTPSA id
 u22-20020a05600c139600b004148d7b889asm20743743wmf.8.2024.04.02.03.59.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Apr 2024 03:59:09 -0700 (PDT)
Message-ID: <b69e43ca-6f0f-4b2c-a555-a697a377bfd7@linaro.org>
Date: Tue, 2 Apr 2024 12:59:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] linux-user/syscall: xtensa: fix ipc_perm conversion
To: Max Filippov <jcmvbkbc@gmail.com>, qemu-devel@nongnu.org
Cc: Laurent Vivier <laurent@vivier.eu>, qemu-stable@nongnu.org
References: <20240329223318.155572-1-jcmvbkbc@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240329223318.155572-1-jcmvbkbc@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 29/3/24 23:33, Max Filippov wrote:
> target_ipc_perm::mode and target_ipc_perm::__seq fields are 32-bit wide
> on xtensa and thus need to use tswap32.
> The issue is spotted by the libc-test http://nsz.repo.hu/git/?p=libc-test
> on big-endian xtensa core.
> 
> Cc: qemu-stable@nongnu.org
> Fixes: a3da8be5126b ("target/xtensa: linux-user: fix sysv IPC structures")
> Signed-off-by: Max Filippov <jcmvbkbc@gmail.com>
> ---
> Changes v1->v2:
> - split into a separate patch
> 
>   linux-user/syscall.c | 10 ++++++----
>   1 file changed, 6 insertions(+), 4 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


