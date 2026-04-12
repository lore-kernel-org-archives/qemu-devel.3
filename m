Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07838E937F2
	for <qemu-devel@archiver.kernel.org>; Sun, 12 Apr 2026 17:27:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wByaO-0005Xk-GV; Sun, 12 Apr 2026 13:27:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wByaK-0005XJ-Sw
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 13:27:01 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wByaJ-00006O-9j
 for qemu-devel@nongnu.org; Sun, 12 Apr 2026 13:27:00 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-488ba6366a7so45856895e9.0
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 10:26:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776014817; x=1776619617; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=3Rj6KEsSXtoqhhBgycSpSIQxzzQXvWkUvgTIpKYngEs=;
 b=Tzr73V7H5GV4LnwLriGr2Sg40KIdkRumfhp6V5QcfSaw/SFtw2CpTVYvwSYsafvQhg
 rnB92ZqiWQaGeYCQI0xPRSrnau0plnP44GAtjUH0oOUuUfh0+rwpG7GdNOS3yEkMqTFT
 EWfJv9uJds8BToXq7/0WeeX0FkE9fpMXMol9CdT2p8rnIieJxsVatFyPM5ifO24CXeBZ
 qeGG5oufIwqM7gwlIsO+gjCThgV7SgB3MqPFEId7XxBZnwsbKpNqxVfUzHIJZzHYP+pU
 VVNDqN6Joa9X/E38vW4v5YfFkp+NIJHXnbcZYEajRd65kVeeAZtMOGSD0iTElqoWULXS
 /t8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776014817; x=1776619617;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3Rj6KEsSXtoqhhBgycSpSIQxzzQXvWkUvgTIpKYngEs=;
 b=mx5Dfk84vhuPa29cxrJsX9ooHRgX4Hx5bUckyg0RrQJjt8GnBIP42s7BVlrZxQ5JrO
 /UB0UyKOWOeGP7FTUOLWD/8TnlmOJkjz9MIuJmE6HFFJhwDvLjTkAhB3prW3XpsdVut0
 1jC3VwLksF7lcDLe1EaqYA/CJC4UdjMmlxV5rpdfxu3uMQkzgLGqToUViOCnBNOHVE2u
 nBy8PQohibJApY4I1sJ+ma8P5b6dvFUxH9smdaxdo1xWQV8EPBkDg0KMonBrKtalV/KS
 8mR7U9ZzkUViorNxgA3xYX+NiptrhDSu6QP3eGGQ/NIU3cIuMBIWd5quk59ZHiJX+BzP
 oGwA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+nbawW8jFIIbBBocCw+XhrFMHjnzNjsXUGRkUd5JfuI9eTJAxDqXHuM/iWZpp6YGCT8Nd96vsNvDt@nongnu.org
X-Gm-Message-State: AOJu0Yy4Dwc3bjBdau+qfIAdmXS2WX3PTy1JQ7K7UEEDeUotqV3qGot9
 X8Cy+hkOQPsqqbohkArNxDNp/abTFm3sWThYuRSnkSgAXeOwAfaulVEFeQjnDbozAkY=
X-Gm-Gg: AeBDietWFuk4sRnzBFmJk1FNi25H3Kc2ilOYrJDnqr40CQLT+/4+/Lm+5L/hkOBxXLW
 23xezG9JgjEZxOgjvdJX6VPVxfO9fPC/DYska/tZj+TjW3A74t6jXCaojIrS65e3x4eLqodzIii
 JbFn1dPil/lKwsPkXo4nS3cPwjP0HYqJxq4DOce9cXOJcYUWsTNV66GfaZXjpzI10+BYc42h2fv
 kfPMZlGH3o/37qhq4mFE712u7hKqymEs25ldQpavqfq5U2S06uDZ6ECnH7lI/ZgH/bs+tLtZJbm
 78PYWnkN8qkGwz5fK9Y68Uv887n7Oujmj/AWr8P9z3oaRic11N5ajFxIpVWMzZ935wbs2iAz0uw
 yhYeA6dJJS2aFJwkh8yBVwboVmm2FSYjDsIJ6B/MVaOnu5Y0muQWHgWDPM39Skcvd5ETBQY3Uxg
 9dsFXuSp6INK0vkMdYDzkSjLDQOWcBHN+ohX75/LqmiVdAzH3n20YrfIx/mXNzuK9eLw==
X-Received: by 2002:a05:600c:a109:b0:488:b187:3c with SMTP id
 5b1f17b1804b1-488d68431ebmr104073925e9.14.1776014817196; 
 Sun, 12 Apr 2026 10:26:57 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488d5d768afsm111104705e9.2.2026.04.12.10.26.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2026 10:26:56 -0700 (PDT)
Message-ID: <cd86b0bc-976b-40dc-8eb2-4f6547be465d@linaro.org>
Date: Sun, 12 Apr 2026 19:26:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1] hw/char/riscv_htif: Fix format specifier for uint64_t
Content-Language: en-US
To: Chao Liu <chao.liu.zevorn@gmail.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: tangtao1634@phytium.com.cn, qemu-riscv@nongnu.org, qemu-devel@nongnu.org
References: <20260412012323.1807856-1-chao.liu.zevorn@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260412012323.1807856-1-chao.liu.zevorn@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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

On 12/4/26 03:23, Chao Liu wrote:
> Use PRIx64 instead of %llx for uint64_t arguments to avoid
> -Werror=format warnings on platforms where uint64_t is not
> long long.
> 
> This fixes the cross-riscv64-system CI failure:
>    https://gitlab.com/TaoTang/qemu/-/jobs/13878406521

This link might last less than this commit, better to document here:

../hw/char/riscv_htif.c: In function ‘htif_handle_tohost_write’:
../hw/char/riscv_htif.c:175:38: error: format ‘%llx’ expects argument of 
type ‘long long unsigned int’, but argument 2 has type ‘uint64_t’ {aka 
‘long unsigned int’} [-Werror=format=]
   175 |                         error_report("Invalid HTIF signature 
range: begin=0x%llx end=0x%llx",
       | 
^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
   176 |                                     begin_sig_addr, end_sig_addr);
       |                                     ~~~~~~~~~~~~~~
       |                                     |
       |                                     uint64_t {aka long unsigned 
int}

> 
> Fixes: d98f7a541c2c ("riscv_htif: reject invalid signature ranges (end <= begin)")
> Signed-off-by: Chao Liu <chao.liu.zevorn@gmail.com>
> Tested-by: Tao Tang <tangtao1634@phytium.com.cn>
> ---
>   hw/char/riscv_htif.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

