Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76B7AC4345F
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Apr 2024 11:36:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rwKcn-0001zV-PB; Mon, 15 Apr 2024 07:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rwKck-0001zB-FQ
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 07:35:46 -0400
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rwKci-0004VB-93
 for qemu-devel@nongnu.org; Mon, 15 Apr 2024 07:35:45 -0400
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-56fffd131a8so872264a12.0
 for <qemu-devel@nongnu.org>; Mon, 15 Apr 2024 04:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1713180942; x=1713785742; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5YtRD/jTzNQldwZhy8fUW7wIvhwf6NiJ8anETY0//QU=;
 b=vffL4vXy41BgjnCst3PJctjcIf2C2BfT5vJ+5r4BAMDn8p2eUydpFKBqo0WssKPz42
 NLmIioZv9Tz37KmAt18uZib2wib2pHgO2LHzRK/Nhdo+Gf74/VDldVokKlXttrY45kbY
 5MnwcybdPvSPs/NhjmXUkjUk3cdJfRTMzWmGB+9/s45oQ1zJH09q7e6Z4VxGlQ2YH0/W
 /2DB00gvOivP4iqV1zgfBtA8f/1j65iP4hj7ARRbFT+FxX/3lkMtdLNk+P4drf58v840
 wv445vUX14emr/sPDgAqQ8/Moen3Pgj0mOYNGruMYRNn6DHYQXlOOS0C9CsJ9etYKYD5
 ttcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1713180942; x=1713785742;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5YtRD/jTzNQldwZhy8fUW7wIvhwf6NiJ8anETY0//QU=;
 b=rSWaEkGFdBrLP8bGm0V/VoWSF7EF5KvC9O9h78vJQfAa5hzexmxd3biDoisX8ock14
 sSEejpjWRbyyWcUmChGeRerjD0SO4g6Be1gGdgSGIRo0G01dlypiJkhhijEzJywz6HIn
 XK0VXrnt/nBHMrMsbcO3+5ZopokuZPJ+hqKQW0f+/R5i/wty/oIvdN0Dx97u+XH3YuQ3
 +h5uV8bd4gY+mDYciwZqVvzhyXlRKwPvWKlXU5QsR2Kst2W1hdJGdp2j+RZKiG5cU/oL
 4U9K3iTlNyrMSQtkqHY02nW0DFAk/gDGFfB7jLJQn8r4XBiSWpJ84PEWf9neFJpuHYdi
 mjlQ==
X-Gm-Message-State: AOJu0Yw6ARnPbP/oE6PPDvzL631HKmGw86yowiv4nroj8J3KzoqqDReO
 H2EnoWmUq4+SbKlbu66O9ZDg7i8/BuRfDY8YyedSyrd6M0QBr6jHyvgz+1i5vHyaliTtvh2pMHv
 Q4ORBrbNjDpdPN2UyXNnmSn+zbAMbL7rcJPxvtA==
X-Google-Smtp-Source: AGHT+IEL48Vfy+W4UH6bMoOdLk+SzA7v/RV7uQmF3020N3+JJPvDEp11q/4wYtwpHjm+Z8WXdwenvHtnAfoAmSBOxeQ=
X-Received: by 2002:a50:aad1:0:b0:56e:22b6:d91f with SMTP id
 r17-20020a50aad1000000b0056e22b6d91fmr7857087edc.5.1713180942185; Mon, 15 Apr
 2024 04:35:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAFfO_h6LZF4T1zfTWh9qhJLcMZWxZ5VAPx-pgO66pXbWiWhNtw@mail.gmail.com>
In-Reply-To: <CAFfO_h6LZF4T1zfTWh9qhJLcMZWxZ5VAPx-pgO66pXbWiWhNtw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Apr 2024 12:35:30 +0100
Message-ID: <CAFEAcA_PTpGqm3Zco3zydpR=tU-MOgAW3ZNExBuUDCk6gcwHTw@mail.gmail.com>
Subject: Re: Questions about "QEMU gives wrong MPIDR value for Arm CPU types
 with MT=1" (gitlab issue #1608)
To: Dorjoy Chowdhury <dorjoychy111@gmail.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Sat, 13 Apr 2024 at 20:59, Dorjoy Chowdhury <dorjoychy111@gmail.com> wrote:
>
> Hi,
> Hope everyone is doing well. I was looking at "Bite Sized" tagged QEMU
> issues in gitlab to see if there is anything that makes sense for me
> as a first time contributor. I see this issue "QEMU gives wrong MPIDR
> value for Arm CPU types with MT=1" (gitlab URL:
> https://gitlab.com/qemu-project/qemu/-/issues/1608 ).
>
> From the bug ticket description, it is very clear that I will need to
> add a bool member variable in the "AarchCPU" struct which is in
> "target/arm/cpu.h" file. I believe the next logical change is to set
> this member variable to "true" in the corresponding arm cpu "initfn"
> functions (a55, a76, noeverse_n1) which are in "target/arm/cpu64.c"
> file. I have a few questions about the following steps as I am looking
> through the code.
>
> 1. I believe I will need to update the "arm_build_mp_affinity"
> function in "target/arm/cpu.c" file to now also take in a bool
> parameter that will indicate if the function should instead put the
> "core index" in the "aff1" bits instead of the existing logic of
> "aff0" bits and the cluster id in the "aff2" bits instead of the
> existing logic of "aff1" bits. But I see this function being invoked
> from 3 other files: "hw/arm/sbsa-ref.c", "hw/arm/virt.c",
> "hw/arm/npcm7xx.c". Should the function calls in these files always
> have that corresponding argument set to "false"?

This bit of the codebase has got a bit more complicated since
I wrote up the bug report. I will look into this and get back
to you, but my suspicion is that these calls must return the
same value that the actual CPU MPIDR affinity values have,
because these values are going to end up in the DTB and ACPI
tables, and the OS will want them to match up with MPIDRs.

> 2. As per the bug ticket description, I will also need to update the
> "mpidr_read_val" function in the "target/arm/helper.c" file to only
> set the MT bit (24th) to 1 if the member variable is true. I think
> there is nothing else to be done in this function apart from checking
> and then setting the MT bit. Is my assumption correct?

Yes, that's right.

> I think doing the above steps should fix the bug and probably we don't
> need anything else. It would be great if someone can help me answer
> the questions or any suggestion would be great if my assumptions are
> wrong. Thanks.

The other thing we need to do is check the TRM (technical reference
manual) for the CPUs that were added since I filed that bug in
April 2023, to see if they need to have the flag set or not. The
ones we need to check are:
 * cortex-a710
 * neoverse-n2
 * neoverse-v1

thanks
-- PMM

