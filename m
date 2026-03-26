Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EB26109E558
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Mar 2026 06:33:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5eHA-0005A0-Ff; Thu, 26 Mar 2026 02:33:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w5eH6-00059S-VQ
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 02:33:02 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>) id 1w5eH4-00033i-12
 for qemu-devel@nongnu.org; Thu, 26 Mar 2026 02:32:59 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-2ad21f437eeso3483075ad.0
 for <qemu-devel@nongnu.org>; Wed, 25 Mar 2026 23:32:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1774506776; x=1775111576; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=JWXnkTNpXkquR0ZaQZYiJ78uaxHdmTz7yT3ivsycKfQ=;
 b=O4I1UjupFxjeDL1s4+QWQos79MKowgneJKmtTSj47RiOXrnGXYT91iAaclaeMQERvd
 ngP4L0PdZlgub+XT5xyPLU+Nu9btjYXEUNgtJs1c029KSB4s4r7Kt2vtyrHJX2EjQIl7
 j0AoWh6xmwwGbZANMLUPfdiTVhkiWOsr0+JuL+VQdU2ZXlVw2CFMvyRAyUuggUX26d3M
 CMsUGuiNk5/89OarN0VwX14sXCUgLZ2dV1GKbJ8ug/9OmLOGhwxOwrR//iLoeymOGtww
 vWDghdrfsqJZ2P77bWNEe0XsNUX8ZY7M4jlgPolPZZhzyLNNwTXV9rV6HJNtmatoGP6F
 GAyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774506776; x=1775111576;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=JWXnkTNpXkquR0ZaQZYiJ78uaxHdmTz7yT3ivsycKfQ=;
 b=qd/0GMCosa2Q05gyZLBC2BhB8gtaM1DT5oqAu9ujWadchre01evs7iNSgew4hrtm8n
 5cTgTr8zNdaqg7/iDoNC7QB4m7SH9VDrGMifuBw2YVwvv6KvhTNXKPEY/4iQQthSlHEi
 rzE9b+IydV0A9U9LI0J4P4pyFEbwJHJi5cBF4rPhGJ/pzAtZuKp9fVMhxh+HakATY4Z6
 O6xyx7JWzumY4cDWCPpYFa10pUPDvEFLVafW8y76jE9h6ULvuujlygBw1Ln17XCrgCFz
 EHtAGSRLBRYrLRlsFkUcELTDt20Dt1PaqwTNoOz5z/FU7qdgczDMX1Dem4zFJHsBGQk0
 YuHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVw2FyEfMysGCId2vJVPLgA1XmWu7O7hZ7wtkpZ/Owxy5EJ21qSDaGf5Hbtw2op7+Rydhl1NCpjTP6d@nongnu.org
X-Gm-Message-State: AOJu0YykHyS4Z+RvXe66/jYN6Sjf46/GUiy5bmchWwxe9oN+L6u8Mcno
 41eHmMT6HklVbREib3WcHIcXs7kFgRQltQC9wCfmsYyKYIFy2HtRy4+i
X-Gm-Gg: ATEYQzylhbnbIB3hV4BU3h0404ArimWxm0lLuMBsSfR7OkzCBfh1zKHz8NxASgc1tYl
 rsQaym8Wqx4JuZx4OhBkh+lbOmQjg/oxOCW4nGh/mtGesxT4ExGrPZwdFEfYmB7ysohGOgO7Qiu
 pWkS85KVMdnCtv0wcm82M/hOZj/G3hAmnoA7HmCdfQe24i9KuMpZKnd0rueK2wJuN5/t8izlL/l
 e2z7UoJpdDy18anBBrHy0dIP67w9+B/J9HXxZO7NcH7Xfr8JMe5xUAaNMGBecfZjWcOcdtRy33M
 xvSFtNniE8XwyrXKPAcu/Izt4m8T7fJed00/0QZ/+kW6+YK+gHnJqp102sDyf5XF3YWXVreyIxl
 HxX45mCMw9zWGuDZCpOV0D/A5hRBuvR0jlFE5czGFFpw7Jh1rDYD2piGqGS4efNe/gxQML2HzPF
 pPuuWCYErKWfqgVdOUWg+4FYRj+aBdTD4yL24jF9ssARNOMFw80qVLBYI7tsL/kTJcJxPYIoePC
 /8=
X-Received: by 2002:a17:902:d4cb:b0:2b0:b7c6:4ae7 with SMTP id
 d9443c01a7336-2b0c4813e4fmr5089965ad.1.1774506776348; 
 Wed, 25 Mar 2026 23:32:56 -0700 (PDT)
Received: from localhost (103.95.112.190.qld.leaptel.network. [103.95.112.190])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b0bc8837e6sm18790825ad.52.2026.03.25.23.32.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Mar 2026 23:32:55 -0700 (PDT)
Date: Thu, 26 Mar 2026 16:32:52 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Chao Liu <chao.liu.zevorn@gmail.com>
Cc: qemu-riscv@nongnu.org, Laurent Vivier <laurent@vivier.eu>, 
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>, 
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-devel@nongnu.org,
 Joel Stanley <joel@jms.id.au>
Subject: Re: [PATCH v3 3/3] tests/tcg: Add riscv test for interrupted vector
 ops
Message-ID: <acTSVA-Ln9wp-2fk@lima-default>
References: <20260321144554.606417-1-npiggin@gmail.com>
 <20260321144554.606417-4-npiggin@gmail.com>
 <acNSjHocMNviKQVZ@ZEVORN-PC.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <acNSjHocMNviKQVZ@ZEVORN-PC.localdomain>
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=npiggin@gmail.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Wed, Mar 25, 2026 at 11:19:26AM +0800, Chao Liu wrote:
> On Sun, Mar 22, 2026 at 12:45:54AM +1000, Nicholas Piggin wrote:
> > riscv vector instructions can be interrupted with a trap, and partial
> > completion is recorded in the vstart register. Some causes are
> > implementation dependent, for example an asynchronous interrupt (which I
> > don't think TCG allows). Others are architectural, typically memory
> > access faults on vector load/store instructions.
> > 
> > Add some TCG tests for interrupting vector load instructions and
> > resuming partially completed ones.
> > 
> > This would have caught a recent (now reverted) regression in vector
> > stride load implementation, commit 28c12c1f2f50d ("Generate strided
> > vector loads/stores with tcg nodes.")
> > 
> > Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> > ---
> >  tests/tcg/riscv64/Makefile.target      |  11 +
> >  tests/tcg/riscv64/test-interrupted-v.c | 329 +++++++++++++++++++++++++
> >  2 files changed, 340 insertions(+)
> >  create mode 100644 tests/tcg/riscv64/test-interrupted-v.c
> > 
> > diff --git a/tests/tcg/riscv64/Makefile.target b/tests/tcg/riscv64/Makefile.target
> > index 19a49b6467..b2b2325843 100644
> > --- a/tests/tcg/riscv64/Makefile.target
> > +++ b/tests/tcg/riscv64/Makefile.target
> > @@ -1,6 +1,10 @@
> >  # -*- Mode: makefile -*-
> >  # RISC-V specific tweaks
> >  
> > +# Not all environments have compilers with vector intrinsics yet.
> > +HAVE_RISCV_VECTOR_INTRINSICS := $(shell echo '#ifndef __riscv_v_intrinsic\n#error\n#endif' |  \
> > +                                  $(CC) -march=rv64gcv -E -x c - >/dev/null 2>&1 && echo y)
> The feature probe relies on echo interpreting '\n'
> as newlines, but this is not portable.
> 
> POSIX leaves echo's handling of backslash sequences
> implementation-defined.
> 
> On bash (the default /bin/sh on many systems including
> Fedora, Arch, and some CI images), echo outputs literal
> '\n', so the preprocessor sees a malformed single-line input
> and always fails. This silently disables test-interrupted-v
> even when the compiler supports vector intrinsics.
> 
> I suggest using printf for portability:
> 
>     HAVE_RISCV_VECTOR_INTRINSICS := $(shell printf \
>         '#ifndef __riscv_v_intrinsic\n#error\n#endif\n' | \
>         $(CC) -march=rv64gcv -E -x c - \
>         >/dev/null 2>&1 && echo y)

Wow nice catch. My shell skills amount to pressing random buttons
until it works, so I appreciate the help :P

[...]

> > +static volatile int nr_segv;
> > +static volatile unsigned long fault_start, fault_end;
> > +static volatile bool fault_write;
> checkpatch errors:
> 
>   ERROR: Use of volatile is usually wrong, please add a comment
>   #84: FILE: tests/tcg/riscv64/test-interrupted-v.c:26:
>   +static volatile int nr_segv;
> 
>   ERROR: Use of volatile is usually wrong, please add a comment
>   #85: FILE: tests/tcg/riscv64/test-interrupted-v.c:27:
>   +static volatile unsigned long fault_start, fault_end;
> 
>   ERROR: Use of volatile is usually wrong, please add a comment
>   #86: FILE: tests/tcg/riscv64/test-interrupted-v.c:28:
>   +static volatile bool fault_write;
> 
> Please fix it.

Yeah I guess they were missed in the rest of the checkpatch
errors, you're right the volatiles should be commented.

Thanks,
Nick

