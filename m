Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100E7CD1293
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Aug 2024 08:42:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1skJgG-0004r6-8X; Sat, 31 Aug 2024 04:42:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1skJgE-0004qF-Og
 for qemu-devel@nongnu.org; Sat, 31 Aug 2024 04:41:58 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1skJgC-0001nO-IA
 for qemu-devel@nongnu.org; Sat, 31 Aug 2024 04:41:57 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a86a0b5513aso298877966b.1
 for <qemu-devel@nongnu.org>; Sat, 31 Aug 2024 01:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725093714; x=1725698514; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=EiEgsgYZTZu5gx5GL+RWpkp1uZ4PMa2giuYE0mbq2Uc=;
 b=npTIikIXJjtOHJuF72qCOcDMja0MExsHH5nnEwn8+5tNeJ29b6o/K5itU50wF2efe5
 Oxd1yhPKl++UeJPXGxTT5+iW/jBhKdBWyT8Rxd5LIXaa31z3chP4qpEkFMdR8UPH4pr3
 IVazmKyd4Y0ANaczn6pgh+4LR9sqbn/lzYIxFwiqyqNFV3rOi9TF+Uhnfp/W6xrCuiVk
 AnIuyGAbX2+evLf66+33Kwk+CJAJch/jgk12gGwmwJWRCeMzb1KNFO+bvCQtGVRMMPry
 rBxhhMP0PpX3DfCQZaBGIFPSGsqqFB3xIz9byONoBSzcmicAHOCkWkDUF0+WH+TchMFV
 9RcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725093714; x=1725698514;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EiEgsgYZTZu5gx5GL+RWpkp1uZ4PMa2giuYE0mbq2Uc=;
 b=Zjytk1Z0xyxyImayFkdOf+uYRpAzORGIvYVPyZJAfzUb9UnSajW3EKFdF+ctaWQrxU
 IORse0uBMVUlOK5yjUFtvveW2Bl/O516YrZBqHdd9FRLcQmCcKxSVrXs79Ye1pbDQAor
 /rDE1RYVFy3KQi0nTKJY4nOoZHgF2NxDgatI9DtoY1sSeJvpCgSKVwNKDV2vkCINL5hd
 t4lXos4AQNgHdnmlsjVe+UGbfQVXnZ9D1ely25m3gVyKUJXA4t5SdijZw1iJiQrDP1z8
 AIHv59n5X+EbCaux3UQM3clC7/WJ/oKBTkMzBydsOWzm1KMr19ngpb+1iDsUYBOSB+Qi
 k2vg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV26btiraLPlcZceVugyNAUx3ylNZ0auY2pP42z/fynY0b5Xpv7McTiu60iWhPUXCmwqy2FEWSfY16L@nongnu.org
X-Gm-Message-State: AOJu0YySGJe3sJvYkrWdERufshowaJWzfyur/ljsa+x66clpSLEj4rVX
 HZRrV7k97qYpvtgMPlhsTHwL2l6S0Y9vCfmS2zzaVejQXtTTdpIG37p1poZJxVs=
X-Google-Smtp-Source: AGHT+IFqVm/wneQ+mQ54cpAJo4CajkzUUsip4xTVuWUqjuKQhRbUkgM3wY+32zJKjr+2Q22dA5oTXg==
X-Received: by 2002:a17:907:3f21:b0:a86:a694:aaf7 with SMTP id
 a640c23a62f3a-a897f77ed65mr553871466b.10.1725093713840; 
 Sat, 31 Aug 2024 01:41:53 -0700 (PDT)
Received: from meli-email.org (adsl-122.37.6.3.tellas.gr. [37.6.3.122])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a8989022ac4sm300972966b.59.2024.08.31.01.41.53
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 31 Aug 2024 01:41:53 -0700 (PDT)
Date: Sat, 31 Aug 2024 11:25:34 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: Alex Benn=?UTF-8?B?w6k=?= e <alex.bennee@linaro.org>,
 Junjie Mao <junjie.mao@intel.com>
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 Marc-Andr=?UTF-8?B?w6kg?=Lureau <marcandre.lureau@redhat.com>,
 Daniel P. Berrang=?UTF-8?B?w6kg?=<berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe Mathieu-Daud=?UTF-8?B?w6kg?=<philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>, Zhao Liu <zhao1.liu@intel.com>
Subject: Re: [PATCH RESEND v9 7/9] rust: add crate to expose bindings and
 interfaces
User-Agent: meli 0.8.7
References: <20240828-rust-pl011-v9-0-35579191f17c@linaro.org>
 <20240828-rust-pl011-v9-7-35579191f17c@linaro.org>
 <871q284wxk.fsf@draig.linaro.org>
 <dd2ed180-3624-4981-adb7-c78e699048a7@intel.com>
 <87y14e1de4.fsf@draig.linaro.org>
In-Reply-To: <87y14e1de4.fsf@draig.linaro.org>
Message-ID: <j2qtr.bznhnwg3r4rn@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-ej1-x62c.google.com
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

On Fri, 30 Aug 2024 14:03, Alex Bennée <alex.bennee@linaro.org> wrote:
[.snip.]
>
>It is there:
>
>  /usr/lib/llvm-14/lib/clang/14.0.6/include/stdatomic.h
>
>in the search path:
>
>  clang -E -Wp,-v -
>  clang -cc1 version 14.0.6 based upon LLVM 14.0.6 default target x86_64-pc-linux-gnu
>  ignoring nonexistent directory "/usr/bin/../lib/gcc/x86_64-linux-gnu/12/../../../../x86_64-linux-gnu/include"
>  ignoring nonexistent directory "/include"
>  #include "..." search starts here:
>  #include <...> search starts here:
>   /usr/lib/llvm-14/lib/clang/14.0.6/include
>   /usr/local/include
>   /usr/include/x86_64-linux-gnu
>   /usr/include
>  End of search list.
>
>but not in the list above. Have we told clang not to include system
>search paths in the bindgen invocation?

stdatomic.h was first included in c11, and compilers already shipped the 
header on their own (since they use builtin operations). The compiler 
header paths are considered special system header paths by compilers, 
and what's happening here is a bug in the manual searching logic in 
libclang like explained in the other replies. The bindgen invocation 
looks at system search paths otherwise, or it'd fail to find headers 
used in QEMU.

