Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9D07E77173
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Dec 2024 10:30:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKb1C-0002eG-3r; Mon, 09 Dec 2024 05:29:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tKb1A-0002df-BX
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 05:29:32 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tKb15-0007vl-B0
 for qemu-devel@nongnu.org; Mon, 09 Dec 2024 05:29:32 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-5d0ac27b412so5240402a12.1
 for <qemu-devel@nongnu.org>; Mon, 09 Dec 2024 02:29:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733740163; x=1734344963; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=8JIB06Is63aqP/v7CjgO+2buwxAwNok2VczuvxBnCYY=;
 b=ZebDAj4vxcrKWZ4/Matp8Zkr/+meO9bBvH56iAculHiyWzj8iXtippiecrB1Jt7Jcq
 22K5irAGXXSpL24NPsDfZtd+cuZtpPehvXZHMPWmfBbBDdJcav20YWceWpcR6yrPukrU
 kKMli4OdOHX9Ek5Bm7ZO4aJc1f/LgRHGjJHk1qQbBLKS7vIobrFrYSVOhTUcLC+aJF0J
 N4YYYYswxV5TWgUdODLfAtZv7mJ30dk+O9/u1O/Do0Q3nQJKxMh4xRC3OC6Xiycg9713
 xm4QiBleleuiJSMmoZDujL9cENX6oloRgEIRzVm9F71oLfBrF6+WozuxBz8YHkSQ3F3N
 fyng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733740163; x=1734344963;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8JIB06Is63aqP/v7CjgO+2buwxAwNok2VczuvxBnCYY=;
 b=vdBwU8ZgH08biQSOjmcJNDCYfoqJm7w8I9EYvMbbINZMziFW/HEtrGi85x3vQXYcNL
 rXTBHRCSk3f3caTI1cIsTFdF/KHzZ75s41DrKR6XZbA547/OHdOY/tudi1xZX6eKQ2EH
 Bu20GV27yiRUSUhqqFwTJ75piqDPkzQWk7xOlMwoJsWa0tZH20HGULPM1RHNaF5ojGbG
 9WOX6M4eJ2qrGQ5mwRf5qJmRQDTBjnoBROsaDr3dJ4cTkX++1UAwybTML4c/55eleSQw
 NbOmeLrePKNB5k0emnLjYvZPSjH1KtxS6+ZJmghIX7FHgGLeR91fiCOHiCrlEjF1O4MK
 Rc3A==
X-Gm-Message-State: AOJu0YyVrcHW+QYTgJGr4Bw0F4U9HV6kK/7VsI3RfCCj/KgfK0a897NU
 64IhcBZEZkexSr1mklOGyheFTF7rO1so2vu4a8jtEgzyg0fu31vH8w7W33rNoBpW6wG9sAnT1Fe
 9Vy+5UiippyVcmhcGIa1Vk6zfWYb/c7tLUiR4FgPh1trMWp/R
X-Gm-Gg: ASbGnctnSDIvBEh2Z6lfmr7ccotAfw+RDKTNQVfjfD/Swpe1Q8g0AxhiaUI7w6WKbQF
 qahLPZmBZ0LVjohBsH98rNWx56QWya9WhkheC
X-Google-Smtp-Source: AGHT+IEfrpiZ0doBay8rbfeNE1OQW+1p13h27mJx6NNU6s4YJ0OPPrgsh4gk3sekRufanJRXcoYPmie2AazZvDg2Lrc=
X-Received: by 2002:a05:6402:274d:b0:5d3:d4cf:fea0 with SMTP id
 4fb4d7f45d1cf-5d418612f4dmr21699a12.21.1733740163476; Mon, 09 Dec 2024
 02:29:23 -0800 (PST)
MIME-Version: 1.0
References: <20241201150607.12812-1-richard.henderson@linaro.org>
In-Reply-To: <20241201150607.12812-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 9 Dec 2024 10:29:12 +0000
Message-ID: <CAFEAcA9_L1Lk=O4-uJ7Qck0RMkUOxySw_LuX087X3TrNqNyoMw@mail.gmail.com>
Subject: Re: [PATCH 00/67] target/arm: AArch64 decodetree conversion,
 final part
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x530.google.com
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

On Sun, 1 Dec 2024 at 15:18, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Finish the conversion of all aarch64 instructions to decodetree.
>

I've reviewed most of this now; I'll review anything I
skipped here in the v2.

thanks
-- PMM

