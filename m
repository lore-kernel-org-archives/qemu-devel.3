Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE3D8C3DA41
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jul 2024 21:57:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRfJ2-00028B-7M; Wed, 10 Jul 2024 17:56:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRfIw-0001Pf-5I
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 17:56:51 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1sRfIt-0000au-5Q
 for qemu-devel@nongnu.org; Wed, 10 Jul 2024 17:56:49 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-1fb4fa1bb34so1448785ad.0
 for <qemu-devel@nongnu.org>; Wed, 10 Jul 2024 14:56:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720648605; x=1721253405; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BPqlD6k5TG6vIoOYsOyNRYtbQGIi2N3H7eUWD+0CtLE=;
 b=Rkgql8/OHnJlgUqkM1lx+S44ee8F7AwBCczoP3eEyjhBC4AtjF1WwkdYFlSOGBfSR3
 c87Y0RNNYnXRcBrpPeeOAw+I+vJKLeL5hweuQV+zGb9olJaIvdw5SqsnvX3QzI85YR16
 UFjwRrUMW7MOUZ9u8UA9+iNUXf9/M248O4ql9/n/3ocCOIGgVC9BnlkXO4wY7RajYf/b
 xGsdeRMo7GL4l9+PC11ncO65Cj8jm3msoTwJLDj0admkhYfZ4DP3Oo2GwG8bXkck8IYD
 yfQdRSvWEnAEn6266nPOeZbBo9u46g2t4yDr1VUtVGlexiq3eyFrVN0uMVnRiZ7CNnOD
 6/9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720648605; x=1721253405;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=BPqlD6k5TG6vIoOYsOyNRYtbQGIi2N3H7eUWD+0CtLE=;
 b=mI9E//2vuzQi8+vNrUtcGz4i3qKuuwaCxfQIBlLoEAHEStbefIt+lFPnBBBZC5WiIg
 1/f3And4d7dFNC1CjJw56PI33Fag0h2/LYv/9Ouy06BZEEcayDLhB+4E9q+oU4btpiPD
 ct8/Khg/J792tRc5cYV9jl8ZAxzyiiw1WNfQMPQxgeSvkEk3hbWcxWUJfETdjvarU0fa
 Rcsh7p37o0s7Si9LWuvMsHHRCvA39US6j1k3xz37A5+0Le2UMWrqDnqv6T6bwTStPb33
 0uVLRJPugDDkr3QuNVlS9/wJUGDArBN2Vsq6HCOvrPi6yroy/g0WwkLuDx/LKD13817K
 VlEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhifb3VNeKqc25gWTX19sD/LWcOwxbKnwqaV03FLcbOvWIAvwKh2CeCCbCNh22toXW7bH1CfHYWCg5k6cd3LW14O4loAU=
X-Gm-Message-State: AOJu0YzeOdjnO0837fuaow3AfwFlSlcXGVfXYy+t6HqB4SL2ZMb9PQ0t
 xrCNPnIqHAp6HUB45ZrXig2BAO0xgUYDk+kPEX1MsQbJtRtUNohNwNWX+378khK8NRyeLgutqHE
 VGdY=
X-Google-Smtp-Source: AGHT+IGjiEOxL5Onr6iGgV0vf5i/CQ6rmH+TV6C8dXHAzm3DBQ7pSHstzy2nQZclxIJHc4h9FU7PPA==
X-Received: by 2002:a17:902:f54f:b0:1fb:8c35:6021 with SMTP id
 d9443c01a7336-1fbb6cd11c1mr60078765ad.4.1720648605278; 
 Wed, 10 Jul 2024 14:56:45 -0700 (PDT)
Received: from [192.168.0.4] (174-21-76-141.tukw.qwest.net. [174.21.76.141])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-1fbb6a312f9sm38269245ad.111.2024.07.10.14.56.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 10 Jul 2024 14:56:44 -0700 (PDT)
Message-ID: <bb7c5d11-f358-4680-9418-cbb8d596e943@linaro.org>
Date: Wed, 10 Jul 2024 14:56:42 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Disassembler location
To: mrm94040@yahoo.com, qemu-devel@nongnu.org
References: <709543045.677058.1720634520917.ref@mail.yahoo.com>
 <709543045.677058.1720634520917@mail.yahoo.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <709543045.677058.1720634520917@mail.yahoo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 7/10/24 11:02, Michael Morrell wrote:
> I'm working on a port to a new architecture and was noticing a discrepancy in where the disassembler code lives.  There is a file "target/<arch>/disas.c" for 4 architectures (avr, loongarch, openrisc, and rx), but a file "disas/<arch>.c" for 14 architectures (if I counted right).  It seems the 4 architectures using "target/<arch>/disas.c" are more recently added so I was wondering if that is now the preferred location.  I couldn't find information on this, but I wasn't sure where to look.
> 
> Any advice?

The older disas/arch.c files come from binutils, prior to the GPLv3 license change.  These 
are generally very old architectures, or not up to date.

The newer target/arch/disas.c are for architectures for which the translator and the 
disassembler share generated code via decodetree.  If you're implementing a new 
architecture from scratch, this is your best choice.

The "best" supported are those with support in system libcapstone.  :-)


r~

