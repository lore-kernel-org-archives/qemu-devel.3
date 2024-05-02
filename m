Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50933C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 13:14:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2WFh-0007fb-Sb; Thu, 02 May 2024 09:13:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s2WFg-0007ee-CH
 for qemu-devel@nongnu.org; Thu, 02 May 2024 09:13:32 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1s2WFV-00034n-Qh
 for qemu-devel@nongnu.org; Thu, 02 May 2024 09:13:32 -0400
Received: by mail-ej1-x636.google.com with SMTP id
 a640c23a62f3a-a58ebdd8b64so659138266b.0
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 06:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1714655600; x=1715260400; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=biYJRxw98f02rvGThOtlgZW56Gc/37SIHdCST+2pD8Y=;
 b=lGXhea4UogToRe5iRtQjqhnQqDo8A/xyQX1IPiZImlfOlm/pp5KyhTact4qK+H7rEy
 fb0yhX8HGZXk6HMZHRlfcUOTD0iD4Y9+3BO8NqWLa26fJIHWAgerFF3cT/6pw8yAa5vd
 IHbsXVgmU4JlnKdYQ8TpU538dk8Z70xGWLExBPWmVs87c4MPMfCcErkKjypkx/DSRIiF
 txAJXDuj7Kotkb3RvkWGSlb2IeO258oIBa3AG2DPyeeV6/qMDe+c9wQMQUMiyOc/7o3b
 vwSHKaSj9QZQ33XjWAOLG16WJnaXlKHeeZFa1liVvLmvBhKxzMTTMotKiVCuhioLwMSC
 Tp/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714655600; x=1715260400;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=biYJRxw98f02rvGThOtlgZW56Gc/37SIHdCST+2pD8Y=;
 b=CozhCPkhaKZPX04HtoZpOnAekRUbHNKVQtglXMc6eTehewL5IuBISmURK0tOnSlNdU
 3sIWy4uFRsd+ZL9OkuFNqI+UYOFuicBvU0OWYuqBAOGfNejHfrQ8WBdLz+lycQupDBfq
 q/ZftCNOMFMoF06Lf0OuyyUHVh45j/zMNTcQNVL9t2EzjFn6g1XA2NPYighZX2P+OaHZ
 V68ZEBKNVmuqWsPbeRCG2Q8D1B5VzSn83mJzWJHKFuD/6kyyK5TNv5yjX47hqZEzXZet
 LmfIFWC9f1Akqzs3W56Ql2ehIPjgg2Q94HLHVmSqloKfxw1PKFm57qrmL4S/nC2czmmt
 5K1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCUFXOI/z20l0LbBPbl8WphVsmS285otAoXykYnJ+5vpDsqluc2tzDYNNja4x7rwghTA8xMpHR+q0jdeMf4TDm1ZdvybTZo=
X-Gm-Message-State: AOJu0YyibRmXifzhuprjp0B7CB5bJkWx3bIIpUcN3pqxEnQ5BP4KBMty
 WGHsb/lOEhbXFt3p79sd+Fdh928NW/wGr1GwGzAziPzlRNj1EQz5VVK1iAolM8mFoioqw8gc20i
 V5uv1t1qABa5PcY0a8fZq2bSSbJehb3vm/gWLfw==
X-Google-Smtp-Source: AGHT+IEQncjjT0ZaiK1ki6dalSH5dIMCRcWflCm+/zAlum9yM+i+yxGPMDNZZnpPUfvg5kiXNixdaUnVvOeBDUfM0HE=
X-Received: by 2002:a50:bb41:0:b0:572:719f:b44f with SMTP id
 y59-20020a50bb41000000b00572719fb44fmr3917131ede.9.1714655600208; Thu, 02 May
 2024 06:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <20240419183135.12276-1-dorjoychy111@gmail.com>
 <7c6f66bf-2610-494c-9389-b558a11f8c5f@linaro.org>
 <CAFfO_h6-RXettxqnCYciDrq6ivsTHtM55FcksJSUNnLdbio4mg@mail.gmail.com>
 <c696603d-b8dc-4fed-96f0-da40c6ce8287@linaro.org>
In-Reply-To: <c696603d-b8dc-4fed-96f0-da40c6ce8287@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 2 May 2024 14:13:09 +0100
Message-ID: <CAFEAcA__6PJwdYLTuGbf01YOaV4t67dtRtbAbnP1eL7dd0YH0g@mail.gmail.com>
Subject: Re: [PATCH] target/arm: fix MPIDR value for ARM CPUs with SMT
To: Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Cc: Dorjoy Chowdhury <dorjoychy111@gmail.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Thu, 2 May 2024 at 14:11, Marcin Juszkiewicz
<marcin.juszkiewicz@linaro.org> wrote:
>
> W dniu 2.05.2024 o 15:04, Dorjoy Chowdhury pisze:
> >> Should "return" also have "(1 << 24) |" to have MT=1 set?
> >>
> >> Otherwise MPIDR_EL1 = 0x000100 can mean core0 in cluster1 or core1 in
> >> cluster0.
> >>
> >> Value 0x1000100 shows MT=1 so thread0 in core1 in cluster0.
>
> > I don't know all the details but from what I understand the
> > "arm_build_mp_afiinity" is used to set the "mp_affinity" member
> > variable which I assume is about affinity, not the whole MPIDR
> > register value. That is what I assumed because the Uniprocessor
> > indication bit(30) is being set only in the "mpidr_read_val" function.
> > In the patch, the MT bit is also being set in the "mpidr_read_val"
> > function based on the SMT status (has_smt) of the CPU.
>
> mpidr_read_val() is used only to set VMPIDR and VMPIDR_EL2 registers.
>
> So setting MT bit for MPIDR_EL1 needs to be added somewhere.

The readfn for MPIDR_EL1 is mpidr_read(), which calls
mpidr_read_val().

thanks
-- PMM

