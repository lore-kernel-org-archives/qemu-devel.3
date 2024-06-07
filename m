Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 921BCC27C5F
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Jun 2024 13:40:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sFZox-00083J-85; Fri, 07 Jun 2024 09:39:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sFZov-00082x-Au
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 09:39:53 -0400
Received: from mail-yw1-x112f.google.com ([2607:f8b0:4864:20::112f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sFZos-0005Sn-1z
 for qemu-devel@nongnu.org; Fri, 07 Jun 2024 09:39:51 -0400
Received: by mail-yw1-x112f.google.com with SMTP id
 00721157ae682-62c8811267dso22496417b3.2
 for <qemu-devel@nongnu.org>; Fri, 07 Jun 2024 06:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717767588; x=1718372388; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jxWporrIUohh1LiPB08FWD5xOdQEpY/r4crr5j/U+OU=;
 b=QX/WPe3CcU3Aw7ZPrgXGIzWBy30AY2uzvf7V10QseYIKXNP89NGEJYJ+UBXofOM3R2
 MLgYqTfMnJU0MOOHYDupPu3e/741ckfTOseKYI/J8/qEq2cL9uqjxQU7ppUGvbeqYlDq
 4u+0uRZXLIW148bp6UwVRL79z1A+tqMG1jx8sRDtAuzB62FTUc7qRfiWmw2B5eg3guNr
 hPocmbvW0aRsfeMPt7FURVCdR5nj5SxNP2B68TQSsAuzg7ghTWBpS48E0a7yCj75Vluq
 m1XCpWdQVsEgrozOEVXqmO0J0Iq3NDvyw4tnxzM8yn705GAgHy74K/vR7K3FVb/MGFXJ
 8YBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717767588; x=1718372388;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jxWporrIUohh1LiPB08FWD5xOdQEpY/r4crr5j/U+OU=;
 b=fntSg36p37hssc5wMd4O446OeuhOAzTncO6kyVNqkjkxIn9f42UQJi557PTr8vBdwM
 UYNRC/Vi6P4UupAjun/JZsqHAho0X5jjRRH8H3z6OW5CyGhlCoKhw6wOpKkUVxvOfa22
 IfivOoEK2aZzoPkFmFcW/+GEFj7NMKR9WhzcN1r0VgaeuG96vlGHIPLKgBnodyfjekCk
 I/SiuIHRbCD0UkX7JbLkpYv1/psF7lh8sgpq98V8l0LgZAm7kRgn+DxD0RGCA00UPA5I
 ONGrhVMG5/SI1otgsgBVJPj5ejyu4d+vu0baIPoDdWT5qrwSg+Rpaw/W4DfmaA+OU7ib
 mwAg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUrh5/ODoyyssDsBOGDZTxkEEX8tUQRfaI8wPi7ZiKgWlIGpqq6dMgitwyFUtLtL2WBprNXr5c9J8tdoYjrfapV9VW1Haw=
X-Gm-Message-State: AOJu0Yw9ug7HxkrvrTo4sXaP1OoCkehabeny9E8zWgOaqeqN0r3PJUia
 Nc50j+objCofPFh+pcppPPqNEhfeM2gETAQWFYv9Qr4+ForjipGD+hubQLu2Lkk=
X-Google-Smtp-Source: AGHT+IG3vVGEknWPqZi6H8uMJT92LgfGrc6P6htAlyA5+E3ygNLpzmIBHZj/h+a/2FR0R0OVkaHqcQ==
X-Received: by 2002:a81:9107:0:b0:61e:a3b:e473 with SMTP id
 00721157ae682-62cd55715d0mr27949667b3.7.1717767588386; 
 Fri, 07 Jun 2024 06:39:48 -0700 (PDT)
Received: from ?IPV6:2607:fb90:2ce2:c16a:7071:cbfe:cb87:bfb5?
 ([2607:fb90:2ce2:c16a:7071:cbfe:cb87:bfb5])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-62ccad1bce4sm6783497b3.71.2024.06.07.06.39.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 07 Jun 2024 06:39:48 -0700 (PDT)
Message-ID: <b4d2ae55-0ab7-478e-9666-a0acc1c0fe2d@linaro.org>
Date: Fri, 7 Jun 2024 06:39:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target/riscv: support atomic instruction fetch (Ziccif)
To: Jim Shu <jim.shu@sifive.com>, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>
References: <20240607101403.1109-1-jim.shu@sifive.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240607101403.1109-1-jim.shu@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::112f;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x112f.google.com
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

On 6/7/24 03:14, Jim Shu wrote:
> Support 4-byte atomic instruction fetch when instruction is natural
> aligned.
> 
> Current implementation is not atomic because it loads instruction twice
> for first and last 2 bytes. We load 4 bytes at once to keep the
> atomicity. This instruction preload method only applys when instruction
> is 4-byte aligned. If instruction is unaligned, it could be across pages
> so that preload will trigger additional page fault.
> 
> We encounter this issue when doing pressure test of enabling & disabling
> Linux kernel ftrace. Ftrace with kernel preemption requires concurrent
> modification and execution of instruction, so non-atomic instruction
> fetch will cause the race condition. We may fetch the wrong instruction
> which is the mixing of 2 instructions.

Hmm.  This is insufficient, as you have no guarantee that translator_ldl itself is atomic. 
  Indeed, it is not: it uses memcpy as the innermost read.

Let me think about this...


r~


