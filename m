Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E01DCEB64DE
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 12:23:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snztz-00023A-8r; Tue, 10 Sep 2024 08:23:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1snztw-0001zf-Du
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:23:20 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1snztt-00036x-H9
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 08:23:20 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c3ca32971cso1040686a12.0
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 05:23:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725970995; x=1726575795; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=xIt2jVQ8+nSY6T72AcewDyD/i8OcbuRqdJvmc5AcVvk=;
 b=f79bFm+55K2WIl9dEuLRZ54067DQP9+iL2u2bnLEKsSTst4LpF1xWg+/0awuDr8Yrt
 XCZyGSlaIylqfiXof/AZcJLSbxaNFEehWpkOqqL/W84TgV2FyXKL9PUmtPps1DLCeawi
 n+4cbXRhjaW3+Pmd76Vhi9DN3X8n7cjh0U4MgDZNDN+xvlcBWEKMB77ImMsGbV/I5lyJ
 XiDAxYw97uzEFfF7r7oWE9M9pfd7ZuRmmqesUY1HPh+sdv7sy1Yv/VW95jsoYQRcIkTP
 n8TzmLzgQ2VDlLF5qkohfAmsnUtsoqgvFuGwsXjMkHQr1NDWeJJHme+DJYc2ACgBaYk7
 QZZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725970995; x=1726575795;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=xIt2jVQ8+nSY6T72AcewDyD/i8OcbuRqdJvmc5AcVvk=;
 b=d5pfF8EyzfY7JBzLewkrEAJb8qmyiRNzgKkWOm4h5b62bCjQNzr5CpHQLDC2KdGfvp
 R1LbSI610QSpVGtNm+c+THbeDfiaKZFy3UglYe9G0Osu2aho8ijdKneuoAHyhaz9k+Wx
 fp13EVxuW6uGtmzBIY6rx4Az+CIxLFat9cXnZ8fC0iLgmf0Kijf+BCicC1l0k3XKY0di
 xnIKlk0FIAf4SV+r2JHM4bim0drNlhP4gDXh2/mKxW5XKOq9j+tFGgZUbRXXkJIfkQ21
 CKmdDExBBFoupGuLBkKSHDqGYEiJSbZc1wG9+Z67905sRHEAU/zKxi4d02ZnFoome02i
 zr6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW+NSmij1t/9T/J5+vnxLUKNJTTXNQVNK1rgjeur3CYmNxoA2g3lKIGel0I1JaO0XQsSIZP6YD3pIl+@nongnu.org
X-Gm-Message-State: AOJu0YyvMKpcd4YsBeTHJrrUxYhGmyXX6LGp/MTvaR92Eh90Y8jTq7Qc
 FPHSzwogjpZ8PlExa5Ew/lhIuNT8EFsB/c24Nr3HfQZlepCyg2SBBLx1aqJ4atQaVII6MoVMzgA
 +R6wG0ERsNNUH81qhUz4q2xT1axylnrUdb7errA==
X-Google-Smtp-Source: AGHT+IEIQy/2oLJqkTJNmlede6t2VA5fKPjfuRWYMzmp9bxFaAVi4nS762DPdiLL0mCRvdBo4gxkDKz1jc0oJgoJeoU=
X-Received: by 2002:a05:6402:42cb:b0:5a3:a4d7:caf5 with SMTP id
 4fb4d7f45d1cf-5c3dc7c9cc1mr7526277a12.36.1725970995389; Tue, 10 Sep 2024
 05:23:15 -0700 (PDT)
MIME-Version: 1.0
References: <20240709060448.251881-1-gankulkarni@os.amperecomputing.com>
 <CAFEAcA_7BOXSLXJ=VV0pWDvrN=2dWrM3bRTG+31ivPjeVbWGKQ@mail.gmail.com>
 <0b5764d4-fd63-4779-a22a-8e10ebafbcc7@os.amperecomputing.com>
In-Reply-To: <0b5764d4-fd63-4779-a22a-8e10ebafbcc7@os.amperecomputing.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Sep 2024 13:23:03 +0100
Message-ID: <CAFEAcA9oP5HNYK=HFazBU8M9eaGN8sFhAvLFQvcy36Xf+Tm+7A@mail.gmail.com>
Subject: Re: [PATCH] arm/kvm: add support for MTE
To: Ganapatrao Kulkarni <gankulkarni@os.amperecomputing.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, richard.henderson@linaro.org, 
 darren@os.amperecomputing.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 10 Sept 2024 at 12:57, Ganapatrao Kulkarni
<gankulkarni@os.amperecomputing.com> wrote:
> On 16-07-2024 09:15 pm, Peter Maydell wrote:
> > Since Cornelia first wrote the patch this is based on, we've
> > landed gdbstub support for MTE (so gdb can find out which
> > addresses in the memory map have tags and read and write
> > those tags). So I think the KVM MTE support now also needs to
> > handle that. (See aarch64_cpu_register_gdb_commands() in
> > target/arm/gdbstub64.c.)
>
> I looked at this code and it looks like, complete code is under
> ifdef CONFIG_USER_ONLY and for kvm(target aarch64-softmmu) this is not
> getting enabled. Are you asking to remove these ifdef and make
> mte-gdbstub commands available for the KVM mode as well?

The system mode support for mte gdbstub is just about
to land. The current patchset is this one:
https://patchew.org/QEMU/20240906143316.657436-1-gustavo.romero@linaro.org/

thanks
-- PMM

