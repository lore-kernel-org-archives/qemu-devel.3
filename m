Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19815C52D7C
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2024 17:43:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sdZ3M-0002nG-MT; Mon, 12 Aug 2024 13:41:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sdZ3K-0002lE-Ac
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 13:41:54 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <debug@rivosinc.com>)
 id 1sdZ3I-0006Qp-1r
 for qemu-devel@nongnu.org; Mon, 12 Aug 2024 13:41:53 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2cb55ff1007so3306574a91.0
 for <qemu-devel@nongnu.org>; Mon, 12 Aug 2024 10:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1723484510; x=1724089310;
 darn=nongnu.org; 
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=UyfrC6TVBoSvo347EZwXiALcTgGA11Jejacv8YIRml0=;
 b=nlsSJbvXp20l0Oi+wLdTDsPyNrlojdncSYK+0hElnJNHtKfDPV7RiKBPBO5l5GBY+c
 qxeAK7TSpHMQGtUDxxp0eSAQpsYaiVE/RzayY+b6rpOnaNzsZJavB2U9rXfWiIRlcoEO
 VrRnPU6e1I/CHiuKOinKGPkgZJo7hawKeuTV4tjZsSNXhmx7DzlW3biI4WoXVvuFyBCm
 5+3PItkEhpE2YPB59PcE1BREikyhdXxzZTPdmsbTyG7QOrYVgJpWuAUVTmQjHmLE23r0
 CZIiGv0dT7SvXf5KFlvocGUfk0hgrjdpVVgBYcuJbZ2vxlmlmzGmjalDgmc9S4fQvalj
 Krwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723484510; x=1724089310;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UyfrC6TVBoSvo347EZwXiALcTgGA11Jejacv8YIRml0=;
 b=vkz26zbAPSA9H7Yd8traR+VaEWsUsT4i0+SzU5qw+qaa3+sa4lRLROQqtSMqN8cGrX
 N+sVx1rG8KT2O9SkQXbCFj7GYIKTC1bq8u0+IsAF0m5JLDeY9r/nIVWIeohTh0TFJp9m
 rAEPYHmac3A5E5qKDij3E8+/BKVzLt0t2HDcBa6EfEFnKaaMiNOUF7JjRmAr1m2YT0EJ
 c486VuhgEHL4+SZkXdpLkeL5Ms67Kvi2tsoZjAieMQH+hpmhUtHnUWs6+ZYElxEPI+y7
 MJ9nqEQh4dQQ7EXFUwJHjEMgpgiB4XFlXSy25vQ3yDklC1p3dmlSvocqtk/NjUpFf2cN
 lESg==
X-Gm-Message-State: AOJu0YwUxRZrKqQpxODDpl/sEUO8+ZgOeKzpYa1fPdZeiaoHlWWBIYH5
 VyMFyLn0GFzXPQqtyiDnuSi8H+66KtaC6l3cnNMXDnyQwF3JcfjlWQTMFPV/i6s=
X-Google-Smtp-Source: AGHT+IEUUdMWhGsl/q/z/wSZoE9xn+uALzz2OUNVV+zxQmpzdlaMNFeAiGFg5N3/NFY2u0Cq6nVjDg==
X-Received: by 2002:a17:90a:f18d:b0:2cf:cc13:471a with SMTP id
 98e67ed59e1d1-2d3926b8937mr919719a91.43.1723484510003; 
 Mon, 12 Aug 2024 10:41:50 -0700 (PDT)
Received: from debug.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d1fcfe487esm5405683a91.42.2024.08.12.10.41.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Aug 2024 10:41:49 -0700 (PDT)
Date: Mon, 12 Aug 2024 10:41:47 -0700
From: Deepak Gupta <debug@rivosinc.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, pbonzini@redhat.com,
 palmer@dabbelt.com, Alistair.Francis@wdc.com, laurent@vivier.eu,
 bmeng.cn@gmail.com, liwei1518@gmail.com, dbarboza@ventanamicro.com,
 zhiwei_liu@linux.alibaba.com
Subject: Re: [PATCH v3 01/20] accel/tcg: restrict assert on icount_enabled to
 qemu-system
Message-ID: <ZrpJW0ONiAy+lMCV@debug.ba.rivosinc.com>
References: <20240807000652.1417776-1-debug@rivosinc.com>
 <20240807000652.1417776-2-debug@rivosinc.com>
 <9c987cbf-f702-4e1f-88d8-82a149c98007@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <9c987cbf-f702-4e1f-88d8-82a149c98007@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=debug@rivosinc.com; helo=mail-pj1-x1036.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, Aug 07, 2024 at 10:48:56AM +1000, Richard Henderson wrote:
>On 8/7/24 10:06, Deepak Gupta wrote:
>>commit 16ad9788 [1] restricted icount to qemu-system only. Although
>>assert in `cpu_loop_exec_tb` is on `icount_enabled()` which is 0 when
>>its qemu-user and debug build starts asserting.
>>Move assert for qemu-system.
>>
>>[1] - https://lists.gnu.org/archive/html/qemu-riscv/2024-01/msg00608.html
>>
>>Signed-off-by: Deepak Gupta <debug@rivosinc.com>
>>---
>>  accel/tcg/cpu-exec.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>>diff --git a/accel/tcg/cpu-exec.c b/accel/tcg/cpu-exec.c
>>index 245fd6327d..8cc2a6104f 100644
>>--- a/accel/tcg/cpu-exec.c
>>+++ b/accel/tcg/cpu-exec.c
>>@@ -927,9 +927,9 @@ static inline void cpu_loop_exec_tb(CPUState *cpu, TranslationBlock *tb,
>>          return;
>>      }
>>+#ifndef CONFIG_USER_ONLY
>>      /* Instruction counter expired.  */
>>      assert(icount_enabled());
>>-#ifndef CONFIG_USER_ONLY
>>      /* Ensure global icount has gone forward */
>>      icount_update(cpu);
>>      /* Refill decrementer and continue execution.  */
>
>No, this is a real bug.
>
>Just above we handled
>
>  (1) exit for tcg (non-)chaining (!= TB_EXIT_REQUESTED),
>  (2) exit for exception/interrupt (cpu_loop_exit_requested).
>
>The only thing that is left is exit for icount expired.
>And for that we *must* have icount enabled.
>
>How did you encounter this?

I spent last week incorporating your suggestions. And during the flux of it, I started
seeing this issue again. As soon as I switch to branch from where I sent the patches out,
this icount assert issue disappears. So something definitley is triggering the issue.
It happens only when zicfilp and zicfiss are enabled.

I am still trying to root cause and in a fog right now. Although I am not very well versed
with tcg internals. So any pointer here which could help me debug it faster would be well
appreciated. Thanks.


>
>
>r~

