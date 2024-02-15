Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FD22C4829E
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Feb 2024 17:50:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rafsZ-0003oV-AL; Thu, 15 Feb 2024 12:50:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafsX-0003nc-L7
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:50:33 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rafsW-00088V-5t
 for qemu-devel@nongnu.org; Thu, 15 Feb 2024 12:50:33 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-55f279dca99so1986341a12.3
 for <qemu-devel@nongnu.org>; Thu, 15 Feb 2024 09:50:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708019430; x=1708624230; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=CB9rng1yqc5qKLqPGbyUPs6HKuEouCWc3AXnz3VU8HU=;
 b=dtpQq/XPCX8oA1EJ0jyZ9DYxt+w0umdmgFkfj3WBrJtWR9KrBeX2sNNcIk+E9sQKMb
 Opx5d/BN6wTruWpnomD1DLMyMl0/AyyTDa7MHvVwNfOU/HhZ7v+t94reknBiiL3nRHB+
 mshjRueYBqs0Maw9T20HdUB4zOmmnJxaySkWe0uYRakrW08aAcnUR0dzz/uvq+zx2CkA
 xzAO/6zdQzjADuNnUHEH844meNZNbXq0BB99lM1idvrFwVK+SWUorf9JPej1MGncNItv
 fhIa8Fei83QHjuaiDd+AxUvJuJgZnKR+3YBsy3TAhQ787kniIjk1z+52yCUmAWR344dT
 Absg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708019430; x=1708624230;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=CB9rng1yqc5qKLqPGbyUPs6HKuEouCWc3AXnz3VU8HU=;
 b=ZKrfiz1Fx3kGCYR1+msV7mi1miPdb11CJ2TLcC/CzD4/31SIwg3j8zj22tGQz9ewiR
 hJezJr64F/W+CagcH/1/8acJcuFMVvdQd2qpGE1UvwjaNufKRu39pwALv4ySTzQ6fSI1
 7y5KpchKroo+2DubfVg6exSLF1SShlwk3J+mB5UjKT0II1eyXY5VuKdeWigcfGgyweB/
 u3cBPkoB+9ur4ICpk6ps4z7yCwaiyNQf2aYPyztx3b6+Mges5Uz04fPjmkxi8v+i4n4u
 Cz1khqVqkhwQl7RfHtfR3cm7m1l+6Y6Kqz7xeQi5Nb4eloN87fen7VgzPqanvgO8fyYd
 3kgg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKof2vf1h+NC8kvdkbEuqcy4Dk+WY8z1EF+q1ZUf4SJaOiwwljPhrdXrY46XXY0a9iBtMBhLGAtha/JAFCo8qf1r0wXDA=
X-Gm-Message-State: AOJu0YwE5UhJW0vnEb/tPHcbjDdok6TOgEoC7jIjycmJL6yD46xEozzK
 hMbb0/lq3f0aFy+RJIIM6duBCAvaC9ZWbgFej8f17pzRyKKe4bGv1lsLJt176mpq/MzdfYwI+3e
 UGDRDDsfPn2GmjyRVUyyu9lVNrTqT2jNJR29djQ==
X-Google-Smtp-Source: AGHT+IEA7RxiA5XaVgzwAXHqZ8KwEnUcfoU/2Wtulf6Nnr+HeFp19NtVBIoUoPvq+gQWOJBHzQQ/PRsVhH+iekyV6Is=
X-Received: by 2002:a05:6402:1b1a:b0:55f:f94d:cf76 with SMTP id
 by26-20020a0564021b1a00b0055ff94dcf76mr1897552edb.27.1708019430462; Thu, 15
 Feb 2024 09:50:30 -0800 (PST)
MIME-Version: 1.0
References: <20240215171512.800892-1-npiggin@gmail.com>
In-Reply-To: <20240215171512.800892-1-npiggin@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 15 Feb 2024 17:50:19 +0000
Message-ID: <CAFEAcA_m=xZEh0gS8ttfPiuRGWJrow7A303GiLG44W4LQZ10xw@mail.gmail.com>
Subject: Re: [PATCH] target/ppc: BHRB avoid using host pointer in translated
 code
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, 
 Glenn Miles <milesg@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On Thu, 15 Feb 2024 at 17:16, Nicholas Piggin <npiggin@gmail.com> wrote:
>
> Calculate the BHRB base from arithmetic on the tcg_env target ptr.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
> Hi Glenn,
>
> I think I have to squash this into the BHRB series. 32-bit host
> compile shows up a size mismatch warning... I think it's not quite
> right to be using host pointer directly in target code. The change
> of offset and mask to 32-bit is needed due to to seemingly missing
> tl->ptr conversion helpers, but 32-bit is okay for those anyway.

There's nothing inherently wrong with it (depending on what the
pointer is pointing to!), but you need to use the right type.
target_ulong and the _tl suffix are for the type which
depends on the size of the target's 'long'. The TCG type which is
"size of a host pointer" is TCG_TYPE_PTR, and you want the _ptr
suffix functions and to pass it around with TCGv_ptr.

thanks
-- PMM

