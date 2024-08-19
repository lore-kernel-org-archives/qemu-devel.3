Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D328C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 15:23:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg4D7-00023C-P3; Mon, 19 Aug 2024 11:22:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sg4D6-00022b-BS
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 11:22:20 -0400
Received: from mail-lj1-x232.google.com ([2a00:1450:4864:20::232])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1sg4D4-0000xP-KJ
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 11:22:20 -0400
Received: by mail-lj1-x232.google.com with SMTP id
 38308e7fff4ca-2f1798eaee6so42426811fa.0
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 08:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1724080936; x=1724685736; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fMCGH+ohsB3L9EXWfet7NzpizrZOWcTNR2XO829M2jc=;
 b=JdIHW41QX0BmRiBiEaPwBQmnrkUgLob4vFNum55jj3IoNMo7zv4yLpWAL1pUfEgOjl
 OriQVd/d3xVu1jxbsAZHv/XZHPbtnyDdsY1MX0NNoLelZgG7Z29BfwKOJLkhZNEuhnjH
 oxk4yDWeNdOfUokfgsF47ddbu+IZ7zVilx7L/H5fLsP1nmvI4gWzzBBmiJm6urIYDrtF
 SvnXhvyagAFBi9PNMgsArSymRVz6bRNKtFcHAgZc/Hh87DuPPOn3qDTlS5xTx2BmhuWU
 qR78ddh1w+u0bMufiLXsk8LWHk9BPLE46Y1FzOCJD3wtIizgyNf9s39B0gKjlwa/Wqsl
 wMhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724080936; x=1724685736;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fMCGH+ohsB3L9EXWfet7NzpizrZOWcTNR2XO829M2jc=;
 b=aKxIvbhiDzUWwGGgqRECINUyQr6DmMPoKLAfi9jfL72zKiNKPVxs5UMDS16k8Jk3v3
 4PUc8ad8SmF13Nj9M6VwfSW264+5HZ8W4NYAY1Bcmu9Lohc3wWQwtqi8HC1gsaMX4muR
 CBkQICk1faGzVpJRnIexFZvv0iDuA96R6D2al/olfmtmyFXmUW9ip/atI4iXK4R9uGro
 RU+nNskiSJBHto8Y3fYqEjrvN0wkg0ALFkGP7l5+H0h0l/mxk46QLTpPiGkeolZ4Wycv
 qh0eNUdPT/9Es5xS4BQ64H6SzHGxGG3XtWc0CJRSpAuVW/Hnn/Rve+EJBmV/9xTv0fGC
 nwew==
X-Gm-Message-State: AOJu0Yw1soiL+HAsIjeQ6A5ZXBZ3Bjb3NxrT5M9BEWsFFt940eoS2waS
 7/u7dL2g+gmQMFUEYNN0VxSWR3z38qV1+jULPmLgdHHxbdiTnHAcWZRD3M9xhXJHUqhOrgww15v
 yfr+qd87v+rWQDAoKqd3ecKmLgWzBmesvzouB+VYgpbgHgUWv
X-Google-Smtp-Source: AGHT+IF3tqEz14X2cYBvj3e7k5y3PxbwfiiTsKiKUKT2O/Rr4fPEjbWmX/SUWo/koGICVrits/xYfUbo5vaLpA1zvvA=
X-Received: by 2002:a2e:3017:0:b0:2ef:3093:e2c3 with SMTP id
 38308e7fff4ca-2f3c8f25c07mr52079001fa.31.1724080935503; Mon, 19 Aug 2024
 08:22:15 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1721731723.git.mst@redhat.com>
 <24bec42f3d6eae035d5df48c057157f83b260e17.1721731723.git.mst@redhat.com>
In-Reply-To: <24bec42f3d6eae035d5df48c057157f83b260e17.1721731723.git.mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 19 Aug 2024 16:22:04 +0100
Message-ID: <CAFEAcA8gR4mmyPBxKUzrExobWjQb95ez4j4pb4pvkK5FyVCs4A@mail.gmail.com>
Subject: Re: [PULL v2 42/61] physmem: Add helper function to destroy CPU
 AddressSpace
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Salil Mehta <salil.mehta@huawei.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x232.google.com
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

On Tue, 23 Jul 2024 at 11:59, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> From: Salil Mehta <salil.mehta@huawei.com>
>
> Virtual CPU Hot-unplug leads to unrealization of a CPU object. This also
> involves destruction of the CPU AddressSpace. Add common function to help
> destroy the CPU AddressSpace.

Based on some testing I've been doing that tries to use
(a variation of) this function to do the cleanup of the
CPU address spaces, I think there's a problem with it.
(This doesn't matter for 9.1 because nothing calls this
function as yet.)

> +void cpu_address_space_destroy(CPUState *cpu, int asidx)
> +{
> +    CPUAddressSpace *cpuas;
> +
> +    assert(cpu->cpu_ases);
> +    assert(asidx >= 0 && asidx < cpu->num_ases);
> +    /* KVM cannot currently support multiple address spaces. */
> +    assert(asidx == 0 || !kvm_enabled());
> +
> +    cpuas = &cpu->cpu_ases[asidx];
> +    if (tcg_enabled()) {
> +        memory_listener_unregister(&cpuas->tcg_as_listener);
> +    }
> +
> +    address_space_destroy(cpuas->as);
> +    g_free_rcu(cpuas->as, rcu);

RCU doesn't guarantee the order in which it executes the
rcu reclaim hooks, so we can run the g_free() of cpuas-as
*before* the do_address_space_destroy hook that
address_space_destroy() sets up. This means we free the
RCU node that the latter hook is using, and then
do_address_space_destroy is never called (and I think also
I was seeing the RCU callback thread get stalled entirely,
because the list node it wanted to traverse was garbage.)

However, I don't understand how to fix this -- how is a
caller of address_space_destroy() supposed to know when it
can free the memory containing the AddressSpace ?
Paolo: do you understand how this should work? We seem
to already use address_space_destroy() in various places
usually for an AS that's embedded in a device struct --
how do we ensure that the destroy has finished before we
free the device memory ?

> +
> +    if (asidx == 0) {
> +        /* reset the convenience alias for address space 0 */
> +        cpu->as = NULL;
> +    }
> +
> +    if (--cpu->cpu_ases_count == 0) {
> +        g_free(cpu->cpu_ases);
> +        cpu->cpu_ases = NULL;
> +    }
> +}

thanks
-- PMM

