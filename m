Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF050C2D0CD
	for <qemu-devel@archiver.kernel.org>; Mon, 19 May 2025 17:25:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uH4ES-0006UR-D3; Mon, 19 May 2025 13:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uH4EO-0006UC-T3
 for qemu-devel@nongnu.org; Mon, 19 May 2025 13:24:52 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uH4EM-0002jw-RT
 for qemu-devel@nongnu.org; Mon, 19 May 2025 13:24:52 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-702628e34f2so42290297b3.0
 for <qemu-devel@nongnu.org>; Mon, 19 May 2025 10:24:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747675489; x=1748280289; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9uZYBTPFdmX+3Jg5KHox8LcaL34tqmyaROWmmL/1FqM=;
 b=EmbfmGPEbkj/ECpATrHzAUyh9rEmG1/kmwxykD23kuYual81tbFUscvAe10yppYGDM
 9v/rufNQ+rg77vBa1NvR5VL54gSs829ueeK44DjOczoR7o71WBOsiRqpe7r6h4bY0Inv
 BuBE2+JZvyAtPuh5sCq7tTrDHTqlcIgky4j2Oxxe1JV2CNDMyLG0Vh5kNaYqYHXMKutt
 y6tvoM5RoGy5+92V1SwIOD2yBcpPM+Qv+1/scvh92DvNZ+rxuf/TIRBsemzcA+Qv37wS
 v6fk8qM+CBbnOZpDIlX+PVVooJgE9uiMVgPVBLmgfZ/CHfXWzH9BoqJGfwLjx56M6kas
 xJFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747675489; x=1748280289;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9uZYBTPFdmX+3Jg5KHox8LcaL34tqmyaROWmmL/1FqM=;
 b=iRwglypHXctiz5v4U022kPSYHLm3zbsD1VUhonHlhxU+c9bIflpvRIMaSge8iXRtES
 0HfhWfuG96VcCnWtGwBKBMNkOQMhGNSDDdoc9mrOrXb7qKPuJtU+8DT1iGdrOn3MaKHZ
 kZyht0592evhcUgGtlpcxtb/HSx/2QjlremHLtL6S27pIluR7ZTkmTso32uiC7MRINBp
 0o0ISswB9H5UJUUg2+MxBThOk7K20n8w0D1wVEpQPkkSXRkvjbOOQ618biU68s8fuVFQ
 7XwApzQ1mpJRqmS/NVsKJZ1R0Ts2Vm/ySCcO/ma7wSOzsAEiivtAqrWbrEPIYG2wNtje
 KLHQ==
X-Gm-Message-State: AOJu0Ywd4YTW7ehlZ/lBY/Pxy9jenNARGL5ghC2Ca6e+vP63k5PtcCK1
 UhBIgzfCk61D11GopDMDnsTE9bmZcZUefaAWnxZPTqap6D57HdW+UbnuJA7CZSflJWy88YnPzas
 FUC4PNfLjQGyU7K/0oJYaQiImdar/37nXABOF3Zdp5w==
X-Gm-Gg: ASbGncvIH1ssO2dd9kDrrI/bIg8xIxZrsXm1B4iwMZc4NOP2Lz6dKeBAUqo5Fv+PySZ
 4Cwl3Enmvza6MvQ5Rg7QsDk4UwdqpnI/sd8D3QHnyx/IOGoipAwaKLkwxbdosQlIbW5PsW8N5uk
 OgjgQNamF4hdZvq1mmmFb52AUVTD1uq3srtg==
X-Google-Smtp-Source: AGHT+IFMu+rB/Qg8RSPcIRouFO5kHTXP/gDoFOYhJ6WnfkkX2T7CgRX5KTpBGqA4befO841xcyovUZ62871Hhdyx5Pk=
X-Received: by 2002:a81:fe16:0:b0:70c:9a57:699e with SMTP id
 00721157ae682-70c9a576c68mr166029087b3.7.1747675488859; Mon, 19 May 2025
 10:24:48 -0700 (PDT)
MIME-Version: 1.0
References: <20250519171004.352636-1-berrange@redhat.com>
 <20250519171004.352636-10-berrange@redhat.com>
In-Reply-To: <20250519171004.352636-10-berrange@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 May 2025 18:24:37 +0100
X-Gm-Features: AX0GCFsv-eRFVe2afn8CDzMaYyoMeFPX52g1_14godSmmBiVO7TVeHlYdIUua1M
Message-ID: <CAFEAcA8UbDZk-4NXUaCn=rKgkNa9aAuxG5qePtvsUPbnfVS4Gw@mail.gmail.com>
Subject: Re: [PATCH v5 9/9] scripts/checkpatch: reject license boilerplate on
 new files
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Mon, 19 May 2025 at 18:10, Daniel P. Berrang=C3=A9 <berrange@redhat.com>=
 wrote:
>
> The previous commit mandates use of SPDX-License-Identifier on common
> source files, and encourages it on all other files.
>
> Some contributors are none the less still also including the license
> boilerplate text. This is redundant and will potentially cause
> trouble if inconsistent with the SPDX declaration.
>
> Match common boilerplate text blurbs and report them as invalid,
> for newly added files.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

