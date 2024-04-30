Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6BDC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 15:31:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1pQL-0001VK-7B; Tue, 30 Apr 2024 11:29:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1pQJ-0001Uz-7y
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 11:29:39 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1s1pQH-0004vC-PH
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 11:29:38 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-41b5e74fa2fso36601765e9.1
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 08:29:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714490976; x=1715095776; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RbLqkgZxG89yShak1b3w96c9QZ8C9P6q/DYUKKV3xUk=;
 b=VPgBG4JlMJGV4VnxXdKE3duwQzw1rrJUEe8kBqLjv3L3g5ThkDmzmYwGYb67LEOvg5
 as5CFluMpchfTpohj8hh7WevG4yBtfGO01jazZRkjEObZX6Auo8YmFS/UjxRdCnBIgMW
 lEntJVW6SFoacJvzyoDCDTMPlULtO4XdB259WT1pnQO9HeroajwYejS1vJLNRV0rq4t8
 vn74Pw9gUu373fKIYSaPSeBQfZb/98mo2tmSKaYEYM1cU/BRMf/6tExI0kgPXFyvDqxb
 Flbhs6r/71KzyLQ/0F3juLthrQfjqDKxBfjBhTj9I++G7JbupG5ACYTwsdwyaExEMR8S
 SXFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714490976; x=1715095776;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RbLqkgZxG89yShak1b3w96c9QZ8C9P6q/DYUKKV3xUk=;
 b=BNaU8L3TUsqqxMdQP9ALAZgY/mMmIdaPWpumkG3nZ0mFeJx8l+m1eG0HDlZWlzZw0N
 zvc5j7CVCU+E9m9B3Z0jBnzZjYgqhywg9uhlMv4NqLOYGj5UwHJ6Y7ETtE+fD8fLSeV3
 D1b/xkSxkWUOvq6olJgOki5RS104PBMy9qxs3RuZToFgEdRboYzXEa0HnnmnSx0dlFIL
 qgV4Ma2b98yfbEmz5ss4l1LEHhbcBxYGmk8XAk+G6Rb1TBwZ9fU8wW6cofXxq52r7cNo
 5y7P++Wpz1Cmj21xJ9zs3IBV9dPhz1wViGBMh50ASd8WNdMarxo1HWm5cOmsomlrWlC0
 voLQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVq/SQuGtEmiJMXnrdzbWveCiXUsTda9Ov1MZDtWIvu38ECJEJnDpfhYM4dlZyeuwjTzVld2tUa4c8mES0vXujgkgb5IPk=
X-Gm-Message-State: AOJu0YwUDEOyHU/uka3RXYHo6Kq/+V1MRxArgMAugjp3Cmhm/oqwarQI
 U6FCjna0zVNRwUBit1Zjp+YKeEuGeeb6KBIsxFQNlwcRtyT9PceOsUw7WElxvwY=
X-Google-Smtp-Source: AGHT+IEFmPLc3bM2kwPdTi2h8Jx+/gU5sSmugzJ82/nreCJrS5Vw/869WkH5TlhnTnkbUhzrS/r9Rw==
X-Received: by 2002:a05:600c:4e54:b0:41b:dabe:8633 with SMTP id
 e20-20020a05600c4e5400b0041bdabe8633mr7691591wmq.21.1714490975736; 
 Tue, 30 Apr 2024 08:29:35 -0700 (PDT)
Received: from [192.168.69.100] (mab78-h01-176-184-55-179.dsl.sta.abo.bbox.fr.
 [176.184.55.179]) by smtp.gmail.com with ESMTPSA id
 n3-20020a05600c4f8300b0041be58cdf83sm12619254wmq.4.2024.04.30.08.29.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 08:29:35 -0700 (PDT)
Message-ID: <0d9ec2ff-ac42-48fa-8cf6-f51ed0766eaa@linaro.org>
Date: Tue, 30 Apr 2024 17:29:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/6] hw/i386/x86: Don't leak "isa-bios" memory regions
To: Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>, Sergio Lopez <slp@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <20240430150643.111976-1-shentey@gmail.com>
 <20240430150643.111976-4-shentey@gmail.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240430150643.111976-4-shentey@gmail.com>
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

On 30/4/24 17:06, Bernhard Beschow wrote:
> Fix the leaking in x86_bios_rom_init() and pc_isa_bios_init() by adding an
> "isa_bios" attribute to X86MachineState.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Bernhard Beschow <shentey@gmail.com>
> ---
>   include/hw/i386/x86.h | 2 ++
>   hw/i386/pc_sysfw.c    | 7 +++----
>   hw/i386/x86.c         | 9 ++++-----
>   3 files changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


