Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2516C52D7F
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Aug 2024 09:18:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seA8W-0005jG-Lx; Wed, 14 Aug 2024 05:17:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seA8Q-0005gD-CE
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 05:17:38 -0400
Received: from mail-oa1-x2c.google.com ([2001:4860:4864:20::2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1seA8N-0002vL-Gu
 for qemu-devel@nongnu.org; Wed, 14 Aug 2024 05:17:38 -0400
Received: by mail-oa1-x2c.google.com with SMTP id
 586e51a60fabf-26ff21d8382so155206fac.1
 for <qemu-devel@nongnu.org>; Wed, 14 Aug 2024 02:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1723627054; x=1724231854; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=r1ECAeNyL49MPbyC00H0OEKjJMNPVMuv2xwiUt6K9jU=;
 b=LfYaia7F5ODawxR/ifakFXqtCFkAXKEKVkQKVFhSqwKXbt5oY3i1uejwOG6S/SxZ6D
 4JYmP9FnETDiLUOkRVsS7xPzyOHGr/4JgWlQbzndx2mGqf0tWgVzLjpTYPRfnNqoNG4c
 KMy7kveYFolUXlOgGV5BZPjGJYIDOaBbWddYAjDc5yAMvSFKC2IHyU7NaZlBd7JuksQ8
 OVwLbKQLq5Xtx/fZ8j3KV9qWpunAxPZdtXQHhUkUVK07O1jQAHHYKVi2Nq6s69dkQxtc
 FcGAUwRa4xAndWec1NXkfCleJCyco+/pBOuiaVpFi0BYxuD0oY3ShCwgkuscb7gRZGeb
 GWkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723627054; x=1724231854;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=r1ECAeNyL49MPbyC00H0OEKjJMNPVMuv2xwiUt6K9jU=;
 b=rbaqlcWr70t+5aCBUA+tfqALHFSqR4Pi3EVjdpSMxnzoglAqiMTpCJ9upRmQyJdT4f
 Lb9HUgPcKyoDZ6mu6/SKirKTFhhItmdoCJqvI4fIWqdRnHNL21ANly5TduVQrHfdkw6Z
 6MOZx4AQQwWZ60T6qRuCky1EeAAwpI9dqIZ5RSiXfzdfY2qj3QmPnrB/i8SQ9euDJNbl
 RyeYgoETC2ZHcGS7C7ztZusWTjFJgrd5LdFUyozt3QZT4pvWkCJsYkjXIIbTA4XeokqI
 XcU67Nmr4H8u+mRH+/AAtMaeXV0oigxghhbISKsBGn6GBmcEQxbHW/6dsCt8cknuOZgK
 /EBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUDa9gSBqaYpzDA4OlFUgsxXM80Whcorah6ogVx0ipUEtu7qyU5887Tm3UJxyEWa7ffWErI6HU1QhwivbYuKhvv9V5F/Gg=
X-Gm-Message-State: AOJu0Yx/95LTurzA5WpGJOrhfgXtNgZlhCPjT7Oc3cHcFejSQh1ssSQn
 hw+8GCgoluMBp2V1hwIznpkW5UpFq2CgVhFe5W1YXPG3GoIHsBop3VCU6b5/9Nw=
X-Google-Smtp-Source: AGHT+IF5/c0FekJFDxnxWNAs1mIkDo5u4K18nALnH0YpmqWXpHulWcqM+z/zT2GOAWyfHHqJhgBtPQ==
X-Received: by 2002:a05:6870:a54c:b0:262:32b0:dede with SMTP id
 586e51a60fabf-26fe59da405mr2670165fac.7.1723627053864; 
 Wed, 14 Aug 2024 02:17:33 -0700 (PDT)
Received: from [192.168.1.113] ([203.30.4.111])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-710e58a0b5dsm6920457b3a.47.2024.08.14.02.17.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 14 Aug 2024 02:17:33 -0700 (PDT)
Message-ID: <b325f636-c337-4fbd-b5da-c08b8978da15@linaro.org>
Date: Wed, 14 Aug 2024 19:17:26 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 08/15] tcg/riscv: Add support for basic vector opcodes
To: LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, palmer@dabbelt.com, alistair.francis@wdc.com,
 dbarboza@ventanamicro.com, liwei1518@gmail.com, bmeng.cn@gmail.com,
 TANG Tiancheng <tangtiancheng.ttc@alibaba-inc.com>
References: <20240813113436.831-1-zhiwei_liu@linux.alibaba.com>
 <20240813113436.831-9-zhiwei_liu@linux.alibaba.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240813113436.831-9-zhiwei_liu@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::2c;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x2c.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 8/13/24 21:34, LIU Zhiwei wrote:
> +    OPC_VADD_VV = 0x57 | V_OPIVV,
> +    OPC_VSUB_VV = 0x8000057 | V_OPIVV,
> +    OPC_VAND_VV = 0x24000057 | V_OPIVV,
> +    OPC_VOR_VV = 0x28000057 | V_OPIVV,
> +    OPC_VXOR_VV = 0x2c000057 | V_OPIVV,

Immediate operand variants to be handled as a follow-up?


r~

