Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC803C25B75
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2024 14:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sA9IO-0000jg-Qu; Thu, 23 May 2024 10:19:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA9I7-0000hX-UN
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:19:36 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sA9I6-0004Zk-DC
 for qemu-devel@nongnu.org; Thu, 23 May 2024 10:19:35 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-574b3d6c0f3so12774643a12.0
 for <qemu-devel@nongnu.org>; Thu, 23 May 2024 07:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1716473972; x=1717078772; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=I2liDebFkFTCFftBWCVhJz27a1IxsiRH1ew8XkLA6gU=;
 b=Ax0ihSkOkMID6dEjhGttv1+DvE6aNKqJNumRaV9WWgGotTWbTo+6geRSwJg62FE6sF
 AO8cLUv0ATt6Ak3kBrHdEoVBkvbZ+pV8qCkn6x50493nFQEbU2zXD2shJpffphVarNSL
 TktFq/yACrVabaVl5yzTqobEnIm3TnRiVXJkwVTGn1Gei3e1LPP5kPE/cl8QbsM/hi5j
 YYkfy69cFWnzGpt2Tub32TQPt2ViWD0YCzVcPFEUyNuMqgwh7I9ykq99UQxLEVvZyxfU
 ILM+QY94mus4iKSJoHlP+2W0j6uYmw0pt/XplQ6G+5bLBPJEOQZsOa0yS16ecvCn1USF
 3dGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1716473972; x=1717078772;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=I2liDebFkFTCFftBWCVhJz27a1IxsiRH1ew8XkLA6gU=;
 b=WYN5VrnRyroqE57COV5kRlZ9CNFVralN2Nilyjj9xzpz8IyuoqRMoGJL2uBtrzhpeG
 tPCfuTcIU9BcngigpKY4XhlNtcn+wQtyG8F4w1Uinm6Pj5j4tdDt2t2H3uZ9Udyp26sJ
 r/z9VQxLQjzkp4jao4YaVgZCQaW9k1iPwCpTpLQuGSwJZGFIOkT16tnz+qhfZY11q8eG
 jPYRYJI9PVojzuSCZHGHu1wbB4oAiBIUq3NKNuUVHWcF5lnn7dpCFEvKWLz6H9TkhvjK
 D53ocuUX+ucyts8B0DCMud1h9h42Q+LGTW4K0YJoVX0gjhpD90yUVq8w9zIn/qwM04/g
 JLxw==
X-Gm-Message-State: AOJu0YzOTlTWi118po7GSj7V8HifIWJ83f2ne7Bg6SjcGJT3uSrINhxA
 UvoStMhDo3aieiu3t2cfXbJ3ZP/ZBT/RddHROIrtItXVJyorVibjwvck5Rw0i68S1+NhqIs6i8G
 EfUA03zf0ROjr+iYmBKI/ssVP9AeEiqYzZ1/GlQ==
X-Google-Smtp-Source: AGHT+IHNhIFedxeOcM0zY01zG47uKK7LZtN2hjjHQ/yXoidv3sarURNWtiW/LSMV1QQwJMH5WHfBhWpmEopreCwNPaY=
X-Received: by 2002:a50:9b11:0:b0:578:4380:3ec8 with SMTP id
 4fb4d7f45d1cf-57843803ef2mr1351380a12.25.1716473971578; Thu, 23 May 2024
 07:19:31 -0700 (PDT)
MIME-Version: 1.0
References: <20240506010403.6204-1-richard.henderson@linaro.org>
In-Reply-To: <20240506010403.6204-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2024 15:19:20 +0100
Message-ID: <CAFEAcA_vcMuJjjOVnsfiD8JAk3KZ+6DG6K6kiRUGqHWXbBjR6Q@mail.gmail.com>
Subject: Re: [PATCH 00/57] target/arm: Convert a64 advsimd to decodetree (part
 1)
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Mon, 6 May 2024 at 02:04, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Based-on: 20240424170908.759043-1-richard.henderson@linaro.org
> ("[PATCH 0/5] tcg: Misc improvements")
>
> In the process, convert more code to gvec as well -- I will need
> the gvec code for implementing SME2.  I guess this is about 1/3
> of the job done, but there's no reason to wait until the patch
> set is completely unwieldy.
>

I've applied patches 1-29 to target-arm.next (with the
FMULX decode line fixed). I plan to continue looking at
the second half of the patchset, but I want to get a
target-arm pullreq out today before the long-long-weekend.

thanks
-- PMM

