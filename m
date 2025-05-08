Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0135CC3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 20:56:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uD8HG-0006VM-AG; Thu, 08 May 2025 16:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uD8HC-0006QJ-23
 for qemu-devel@nongnu.org; Thu, 08 May 2025 16:55:30 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uD8HA-0001CX-9y
 for qemu-devel@nongnu.org; Thu, 08 May 2025 16:55:29 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-af52a624283so1401946a12.0
 for <qemu-devel@nongnu.org>; Thu, 08 May 2025 13:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746737727; x=1747342527; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KaLy/9pQK1orApI56HfkpL8gk225GnRZj8BeLUv8SVw=;
 b=tXtqMHYFM00p2HrJKp56BcJWjUZcdZNBxX7Vbzlu9vTq5B7Hxk9IAnSU38Vm51CxMM
 S417FUSVUDqjIXF+lsICdtxxjHJBSePH9R4TaEOejKJLXErK3aCgk9aod79RN8VB2OOC
 0tggo6mPhyq8sqD5qywfQR3lvpFTagOU1JOmBCAtDm3caCO1PP3DPBVtiydZBbnVYSmb
 kiMYlUHov20cXkHWxilSEZJeF2vNyStOZVn7xxF9MvtwjH3O46pmTODBDaiVcqo8wUX/
 0OcCQjMIObGB+Zk5Hdhgs3Pkwm2xW8Kftd2HTdfozKNU1j+eaqeP1En1+46MTeT8VWQD
 l/pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746737727; x=1747342527;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KaLy/9pQK1orApI56HfkpL8gk225GnRZj8BeLUv8SVw=;
 b=uq/ZQDL2VXL7r05H7AuFjJrjaHxsuoPGyz6/Vga71gRxBhf94z3ZUtnZNWPy9hhfEN
 Ge3YsJ5oCnS1e+YgPUsYEOkJGNrtwQgK52DnXeejZ6hMChqd7BvVMDVQY1BNQk35ENpp
 raNzUVdsUQJUFOgmcEzX1DkRMtFUan/G1LUwSVbiQ8PyhyKmrto5DFJkRPdjbb63qYT5
 DUO24ylUW+YmL1Et4BmlvsMzjzp69YRwqWksUhx4cxhNuqfmjjz0hTXD4/TpUUIHCWns
 C+e06NnC/1jhroF0FiWaCpVwTIegLA3y528ZfldNQE33BfNOxo/HHNyuWVGpEdyUDl/X
 G0Sw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXU4yNu/kUkTQpSrLVqLLHNRAjCtb+zH96FwB64wckB5I7SZUIDJe3E5RL+JrkZMBuxT0q7eWS+y2sY@nongnu.org
X-Gm-Message-State: AOJu0YwRmLy/0PkIC1MxKyqwklMKHI9meWlUPP8C6PIpcsAasONXpLfM
 qCgM5+5o0nWNaCT0sZYhq35Ps+yZGTad7wJcjx6vlo1b5Rdfb/BoBt58J+kOHbY=
X-Gm-Gg: ASbGncsJ742f9K424mTuC9StVIkwTKngEbpzhF0F6HC82UzPnw4VVYqzsHCbn+w0qZm
 TqUetkUapRHbiJlGubW+CxP/sSso+3QeG6DnPM5djmN06BT4hw7pblOdsmHGJKsSBZWa8lYHAp2
 GTUKdzxoPkzo7F2TUMnqtIV9nQ57+DpRDHRkyWueD9+pDp/dfOVSUT0VFOBctVkFK9RRhXXwDcn
 QP4ieLlgNk4bGHpkZRUeCJG3MxLN2Qoy6QLk99tw1YGfpdoJCfCte3ZGpb1I6GjpXnH1PgpbHQ0
 7ldom0pBCIFazOckz8H6u2yU8k2My15oaNptEXN+p321E2NXp8Dn/g==
X-Google-Smtp-Source: AGHT+IF9QgbEAsXUVVDvzdkCSI3o6nzBb/Iv9xxIJ2i0U6YeM6LNkLml0axVUQ7KXSKJZBGGuC/A1w==
X-Received: by 2002:a17:902:f607:b0:215:9eac:1857 with SMTP id
 d9443c01a7336-22e846e0394mr72010855ad.5.1746737726728; 
 Thu, 08 May 2025 13:55:26 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22fc7b2a70fsm4109005ad.105.2025.05.08.13.55.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 08 May 2025 13:55:26 -0700 (PDT)
Message-ID: <ad0efe6f-f445-4ba2-8b15-b02667f99ac3@linaro.org>
Date: Thu, 8 May 2025 13:55:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] qapi: make most CPU commands unconditionally
 available
Content-Language: en-US
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20250508135816.673087-1-berrange@redhat.com>
 <20250508135816.673087-10-berrange@redhat.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250508135816.673087-10-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::533;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pg1-x533.google.com
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

On 5/8/25 6:58 AM, Daniel P. Berrangé wrote:
> This removes the TARGET_* conditions from all the CPU commands
> that are conceptually target independent. Top level stubs are
> provided to cope with targets which do not currently implement
> all of the commands.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   qapi/machine-target.json              | 397 --------------------------
>   qapi/machine.json                     | 363 +++++++++++++++++++++++
>   stubs/meson.build                     |   2 +
>   stubs/monitor-cpu-s390x.c             |  23 ++
>   stubs/monitor-cpu.c                   |  21 ++
>   target/arm/arm-qmp-cmds.c             |   2 +-
>   target/i386/cpu-system.c              |   2 +-
>   target/i386/cpu.c                     |   2 +-
>   target/loongarch/loongarch-qmp-cmds.c |   2 +-
>   target/mips/system/mips-qmp-cmds.c    |  12 +-
>   target/ppc/ppc-qmp-cmds.c             |  12 +-
>   target/riscv/riscv-qmp-cmds.c         |   2 +-
>   target/s390x/cpu_models_system.c      |   2 +-
>   13 files changed, 437 insertions(+), 405 deletions(-)
>   create mode 100644 stubs/monitor-cpu-s390x.c
>   create mode 100644 stubs/monitor-cpu.c
>

This sounds good to me, as long we are ok with having commands returning 
a "this command is not supported here" paradigm.
I thought it was the complex case we were trying to deal with, precisely 
because we didn't want to introduce the "command here, but it returns an 
error" shell.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


