Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454EFC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Apr 2024 18:39:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwnhJ-0001EE-GZ; Tue, 16 Apr 2024 14:38:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwnhH-0001Dh-Cq
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 14:38:23 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1rwnhF-0001ZU-OE
 for qemu-devel@nongnu.org; Tue, 16 Apr 2024 14:38:23 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2a502547460so3243610a91.2
 for <qemu-devel@nongnu.org>; Tue, 16 Apr 2024 11:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713292700; x=1713897500; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=g+8L5vRcq2GfZePBd13B3hozGsk2If6c5j0b1z7yzlU=;
 b=hk/5Vvv+sIJQXQ9vKk1+JWhUmfz0F+QK6a7kVtrT6I3Ob/o9jehU4AEyj/GWpv7HOm
 7eMRMC0QOao9Tuh11ahv8iS6gOkq/13mL6rSNinoBrV69FLdXypVMO//C7Dm4GvchrUS
 zDTh5eqNERfM15J4guyRGWP8/VBja2yEUwAh8oUD0b7f29mJME3IUI8kjTzqXSuvynVZ
 jsq11WG6NEtMmJS++KTNxcRo+B/diTsiA60vSL9cmORxnywT3qFDcZ2fpT+lAlUYuRnn
 RyI7POQeJ0lt5JlFgns0xFZ7RMVc6WLmcX1J2LXbvc6ydmrs1dAOGA1tvY1vU+L08QN3
 R+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713292700; x=1713897500;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=g+8L5vRcq2GfZePBd13B3hozGsk2If6c5j0b1z7yzlU=;
 b=taXK1RgeMk2n6bUG+dMCl1uBHExdIPwcN0S7fJoslc7Cc8FfV37qSqCmZRezaw6cCM
 D55QzzYiVN1MVOQzBh8ndN4Ngv01gFj7sAxVo7BPGhnbL9y2GvO9g/O8iu2+tdAwczz8
 QBlHN3kBEHeXqowOg8t/TR8saP9CZBTBgDwc77bGRWWvnaqdY1ZNT4Cv5vsk5PbXKBEz
 1Al9xTZdQkhdHcm4k7F4g7pmvqHxWLTSTlxZR3XkpZshVHjsfqYrS4guPoB6721vmgPM
 qpLqYAMcMFxjoZqZOpDv77ACAGBq5RTWEtrBksRz/2bAzrIwf6ttGE4jG2WcieBQwlRw
 EFqA==
X-Gm-Message-State: AOJu0Yz1oSUF+hPOtLsIKvfcoD+NGXDsGaHjF69r9sFjLJPGaCTDckvx
 /5VTgfLKCQrkn607uW6mE7NbK9dpl7fMVu7RclJiAop2U7jK1dB0ZuSkMHGnQ4w=
X-Google-Smtp-Source: AGHT+IETqUuPRSZ0g5rVdFOxh90qWd0B06MPwIja9L6TXKP0SbIG5MGmZjLMsEx1YivnYDPXntXojw==
X-Received: by 2002:a17:90b:1107:b0:2a5:3310:89d6 with SMTP id
 gi7-20020a17090b110700b002a5331089d6mr12340234pjb.31.1713292700189; 
 Tue, 16 Apr 2024 11:38:20 -0700 (PDT)
Received: from [192.168.0.4] (174-21-72-5.tukw.qwest.net. [174.21.72.5])
 by smtp.gmail.com with ESMTPSA id
 42-20020a17090a09ad00b002a2a3aebb38sm10099692pjo.48.2024.04.16.11.38.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 16 Apr 2024 11:38:18 -0700 (PDT)
Message-ID: <a5ed5846-7a8c-48fb-b84e-2ae285cd1b2c@linaro.org>
Date: Tue, 16 Apr 2024 11:38:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] target/ppc: Move div/mod fixed-point insns (64 bits
 operands) to decodetree.
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, npiggin@gmail.com, danielhb413@gmail.com,
 harshpb@linux.ibm.com
References: <20240416063927.99428-1-rathc@linux.ibm.com>
 <20240416063927.99428-7-rathc@linux.ibm.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20240416063927.99428-7-rathc@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102f.google.com
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

On 4/15/24 23:39, Chinmay Rath wrote:
> Moving the below instructions to decodetree specification :
> 
> 	divd[u, e, eu][o][.]	: XO-form
> 	mod{sd, ud}		: X-form
> 
> With this patch, all the fixed-point arithmetic instructions have been
> moved to decodetree.
> The changes were verified by validating that the tcg ops generated by those
> instructions remain the same, which were captured using the '-d in_asm,op' flag.
> Also, remaned do_divwe method in fixedpoint-impl.c.inc to do_dive because it is
> now used to divide doubleword operands as well, and not just words.
> 
> Signed-off-by: Chinmay Rath<rathc@linux.ibm.com>
> ---
>   target/ppc/helper.h                        |  4 +-
>   target/ppc/insn32.decode                   |  8 +++
>   target/ppc/int_helper.c                    |  4 +-
>   target/ppc/translate.c                     | 65 ++--------------------
>   target/ppc/translate/fixedpoint-impl.c.inc | 29 +++++++++-
>   5 files changed, 42 insertions(+), 68 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

