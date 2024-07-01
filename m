Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A239C2BD09
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jul 2024 16:06:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sOJX5-0006pG-8f; Mon, 01 Jul 2024 12:05:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOJWq-0006kr-5k
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:05:21 -0400
Received: from mail-pf1-x435.google.com ([2607:f8b0:4864:20::435])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sOJWo-00055x-6x
 for qemu-devel@nongnu.org; Mon, 01 Jul 2024 12:05:19 -0400
Received: by mail-pf1-x435.google.com with SMTP id
 d2e1a72fcca58-706627ff48dso2288489b3a.1
 for <qemu-devel@nongnu.org>; Mon, 01 Jul 2024 09:05:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1719849916; x=1720454716; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ClAS3+/NhIB+hXFwKPrnJoQvW5lme4e/nntm/udmTZ0=;
 b=rMIzA0BPlsoYmqZ7fWxpJvkSBUjc/rY7ZK1iRFVX90Cy+mZ64xGKNbkeaQ8j5Kj13g
 691diRTtDaLaF3/kgVyQL6+35QTzS98pMICm/F6YBlDzVqumvVicAv6/Y+o1S+kNPnHW
 XmrE38wrK0cOBm2gpwCDzn7R/6TdAKCQNukTr2agSD9BSw3NsryDwYb23TbB2q4ICT9h
 R4B1DRNHcEEymime+fQLhfOi6slx3Gz/Amx3chaBgP9ReQi9ESjiSzdXMccvnLZRkUx+
 LXXBjoo2+QeSlfsobqpGGV/agPOMQdT98CLMGuPUguQbWr0E4eJkchqsJf4xs+rEoqis
 yCYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719849916; x=1720454716;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ClAS3+/NhIB+hXFwKPrnJoQvW5lme4e/nntm/udmTZ0=;
 b=c7oOltfVpP5sispKMfjII0FnpYBxZAmd6KV++WbTZUcr+6PQL0j4/qYXNTLV8orVI5
 GtQ2zVG6njL0QnDZlunFUAuCOfjqFI97htkcfimwvZB7JR6MxchsaRg+Wneik1Y7Suy1
 n/7zmNxqLrHW2q5KIRW3enf0clCFbOnVl1gymjfiV4fqHHNOiwgJ3MJIsdZDFOA3TFcZ
 T3+OxG2S8sPmKijAyZdMpRmnpTimlxA2H1rD8dm30HGOXCTS8GLAZcp05ULeJyvw8trF
 1O8qTHB1PBYq+zDbl6OXCOEgmVFPP0YpDVwbAjaXYxsj61Jfx7O1XJP3y6TFynRW4z44
 9yig==
X-Forwarded-Encrypted: i=1;
 AJvYcCU8bd0pzoer5zZRFMQnVC4Yutx8xPb/24ZhAL0Ee2hx6w/z0r7hYa02/ITAg6zUhDorXZQcrXBGb2QZ90GrhWYi3KUVe6w=
X-Gm-Message-State: AOJu0YyAmgBYf9Z5oKtdy5Ze2qSkKzAarFiRr5EIOweIlbdjD1Li6bc4
 VAKXKGBcccBNE/e1YgtInBpN4cj+uE2XMVXjHZIAQtW8Z1nPraK1Q/ByorpRPYs=
X-Google-Smtp-Source: AGHT+IGrbOLMXhFj+GAouzLV1TrsgeJa8fy4UmMpW3I1o4BVtBYuVn70a5HoN4Vo9o2VvIDKI8OWTA==
X-Received: by 2002:a05:6a00:10c7:b0:705:9526:3c0d with SMTP id
 d2e1a72fcca58-70aaad3ab65mr7575704b3a.12.1719849915327; 
 Mon, 01 Jul 2024 09:05:15 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-708044ac1e1sm6701382b3a.163.2024.07.01.09.05.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jul 2024 09:05:14 -0700 (PDT)
Message-ID: <f681575f-1dae-481e-8330-6fe2fc8d0f11@linaro.org>
Date: Mon, 1 Jul 2024 09:05:13 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: linux-user cannot allocate stack memory on riscv64 host due to
 non-zero guest_base
To: Andreas Schwab <schwab@suse.de>, Peter Maydell <peter.maydell@linaro.org>
Cc: Warner Losh <imp@bsdimp.com>, QEMU Developers <qemu-devel@nongnu.org>
References: <mvm8qytp828.fsf@suse.de>
 <9f3cb0e3-c069-497d-81de-234db7bd4d33@linaro.org> <mvm4j9gp0xd.fsf@suse.de>
 <34fed985-6a6a-4458-95f9-aa651744ef1a@linaro.org>
 <CANCZdfq4=s=g8GoeCKY4576xgJs4-X+fXh7m5ZOJ1UeBXwWdCQ@mail.gmail.com>
 <mvmv81un7m9.fsf@suse.de>
 <CANCZdfpW+G54v3oeKZ6QYuovOga93D5hou9Ajeo838Y9bDNsUA@mail.gmail.com>
 <mvmmsn6lawv.fsf@suse.de>
 <CAFEAcA-dbLncCmY8zyZAz8e+AWeoGC437B=nV3wPznER+RmhbA@mail.gmail.com>
 <mvmr0cdjjlh.fsf@suse.de>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <mvmr0cdjjlh.fsf@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::435;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x435.google.com
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

Hi Andreas,

Thanks for the test binary.

Now I need to know about your qemu version and build configuration.

Your test binary still works for me.  My configuration:

Debian GNU/Linux trixie/sid
gcc version 13.2.0 (Debian 13.2.0-25)

commit 60b4f3aff4e39be04f5d73c65a7e8ef838475c9f (HEAD, tag: v9.0.1, origin/stable-9.0)

../src/configure --static --disable-system --disable-tools --disable-docs

qemu-riscv64: ELF 64-bit LSB executable, UCB RISC-V, RVC, double-float ABI, version 1 
(SYSV), statically linked, BuildID[sha1]=86144e2f215344440f3e21b65b2cf2b8cb33c67f, for 
GNU/Linux 4.15.0, with debug_info, not stripped

   LOAD           0x0000000000000000 0x0000000000010000 0x0000000000010000
                  0x000000000035feae 0x000000000035feae  R E    0x1000
   LOAD           0x0000000000360708 0x0000000000370708 0x0000000000370708
                  0x0000000000070ebc 0x00000000000833f0  RW     0x1000

So the end of .bss is at 0x3f3af8.

With -d page, I get

Locating guest address space @ 0x3f4000

which is uncomfortably close to the end of .bss, but seems to work.


r~


