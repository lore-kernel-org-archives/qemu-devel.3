Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90F55C54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 14:00:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhVLA-0007MM-Qj; Tue, 05 Mar 2024 09:00:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVKP-0007Am-5B
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:59:42 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rhVK9-0006yH-RF
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 08:59:19 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-564fc495d83so6952791a12.0
 for <qemu-devel@nongnu.org>; Tue, 05 Mar 2024 05:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709647155; x=1710251955; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Lawp1sjxEsVyZiI+IHrhk2/sI27YCGTO5bv9sr9ZoH0=;
 b=hoj9gIETxPFjgrAWGLeJQ05mOKZOB11/YaabnPqYkmldv4060oOVprAWeTRMYjBzw1
 1rbDoF7vp2cGksVSwU02StJg1/+GSHdGVne+JQucZREnEKUWd21HNvvdp580WqolJYrX
 NaG4ztk04rPRxi/83GPuXwnQYDjTqhJoIChOjjC4WYdfHWKhT+bnptjI7o+ODtFvJMzj
 KF6a543z0MPU+R869xhk8i1q35XzcLR5SK+biJsilhOfKNvsl/yEtpba2cRUqPeY6gBT
 kTKKSX9NjCa7Z8HUn3bihyF26ifhH2Rlcx9G85GyaB6fv1RJlmDRTr5k/8qBP6m1ZSev
 Vdsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709647155; x=1710251955;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Lawp1sjxEsVyZiI+IHrhk2/sI27YCGTO5bv9sr9ZoH0=;
 b=EXaLHmnc8a3rBX/zFT01JHTpztsshU2gWpRHzpMfppiPwimdKw1A8fnhWkRG9tvGyb
 8SEtSq42iBYAgwoV03+BZjly51Z0xmcmJhfPy8gJwuMk3r0tiBjye/LROO0RCCs4bgLs
 PD7YToG7op73M9qDvZ6rVhlmGRS0pYD4niAd9gQzFlNogSiTYEOwlZ77xwoDU1CblsuH
 jClARpfJ1S0rHbmb7bSD15O98K80TP/y+d1p+9nGJ+/2HWO/ljj/6LTxho+z3g8JdyCE
 dds9xNbZK5nHZNmyVEjkY2ZWDKEYRUPwvz1JFeXREJERNdJHpkZ8a/WtyCgZEKpEiAjg
 GjJg==
X-Gm-Message-State: AOJu0Yxmp990AiNqbcciMJYhk4WICwdpEnXEpHZGqUTDobXsxUze8K7Y
 19Bkobzeh7UMkYgjB3vJDF4JyrLLVF7jdRbxhoi3Pyxncv5p50lL/ETcHk2xrry7P8gsNfzkvHf
 pTaeRvj2NsCF7m/jNa78nIyGfp3SgaDTrMvttBggxflwqOecT
X-Google-Smtp-Source: AGHT+IEkVyiUCD2hR3xTa2jUlilUzjISsMfXyD5EOhH7edVtoFOF8ma+HkAJNHG69wQ2tnApwkcWaT0/nCq6GFECv/0=
X-Received: by 2002:a50:85cb:0:b0:566:5cb2:c76c with SMTP id
 q11-20020a5085cb000000b005665cb2c76cmr8881531edh.3.1709647155442; Tue, 05 Mar
 2024 05:59:15 -0800 (PST)
MIME-Version: 1.0
References: <CAK4oD7BPCf5o-OR8WThb3QGJbrJnYpHipjKv-hY9rkWNOSAHjA@mail.gmail.com>
In-Reply-To: <CAK4oD7BPCf5o-OR8WThb3QGJbrJnYpHipjKv-hY9rkWNOSAHjA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Mar 2024 13:59:04 +0000
Message-ID: <CAFEAcA8wQK_jfj+q-70TJ9Mnu+JHan_oNPYTDMMUmsBm7kMcOw@mail.gmail.com>
Subject: Re: ARM hypervisors
To: RR NN <rnn59437@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
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

On Tue, 5 Mar 2024 at 13:40, RR NN <rnn59437@gmail.com> wrote:
>
> Hello
> ARM hypervisors (pKVM, Gunyah) can run x86 OSs?

No. A hypervisor uses the host CPU's virtualization extensions
to allow the guest code to run directly on the host CPU. This
is why they're fast. This also means that they only work when
the guest CPU is the same architecture as the host CPU.
So you can run an x86 OS on an x86 host CPU, or an Arm
OS on an Arm host CPU using a hypervisor, but you can't run
a guest of the "wrong" architecture.

thanks
-- PMM

