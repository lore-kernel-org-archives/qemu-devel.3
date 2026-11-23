Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98149606A33D
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 15:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=CCQvdmA1
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVW70-0007kQ-Ba; Mon, 23 Nov 2026 10:37:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVW6x-0007k7-BK
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:37:43 -0500
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVW6v-0000fF-Na
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 10:37:43 -0500
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-67da62357acso4438461d50.0
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 07:37:41 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795448260; cv=none;
 d=google.com; s=arc-20260327;
 b=h1IOFH44VU7c5/zFVP6L3HHevjLJZo1vIuek5Z1TCqa+U5/Cvt8QAE5c1GF/tHxN06
 WTDoSKt5xCeWbYj1jbjKra21y5UrMDArMX1KVjW1cFG5gUUOGsGqqdqYqqaagbGW42zF
 ECe7BxM+Yd0C9QjkIcJ9o+HKdES7g7en5bNHh/zeJO8vEcgQYN2N3oT1szMMcCSpze4h
 XTB+4zhY+TLzqk+sD+1Z+SsHAyG6zJ7mKOwa2iREcFHNQA4iA2RtH2PnBjOIr713yKFq
 ezZ6JXXZAQ/SdmpSQ+pM7A7oeQxzaXsUdKTlQV9Ytpx/hHlkbHVpImBfnyW3U6H4+oWg
 j8pQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4LCaBKHWMB1T+mI4Ctek9gRui8KSkdg9JaTqoRb6N/8=;
 fh=p/w+HpwE/NGb/2RiV20clBwRwriP+2+cZWCF1A9n8Vs=;
 b=e7W0Ybrg667ZlDab1EsaXV2AAXoRB376Sr/42CENGUsnm1CuQ3sC5Jfze1fmCuTonj
 Val7iYOjsAU8hr842d8QThE3YHEVVpWOi/+oXHUTwxBuDr/V/E0RxBFmAgyvjplRSqN+
 PglfsgIqWL2Y9xXzWyLoVmCai5TmnZ8HeXjpFriY640wHs8sUpU3qcBJqqAEbA4Ac3+y
 iG20Br15JtHx8xmU2FlUCSkmgNNKIX+PzqP3jnl0Vi8uu1DO2ZfSK63dza5imQK26Nb7
 rD6+QFDtXcFG9Ofa0M+49MSyy2oipvgp0tNqLa5z07+ZlooZupzmyb4xw01PTK4vgldv
 CxkA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795448260; x=1796053060; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=4LCaBKHWMB1T+mI4Ctek9gRui8KSkdg9JaTqoRb6N/8=;
 b=CCQvdmA1S6wgQ/TuqPvrcRiCulqz/yKN40VA9+Rc3DaE1EDMBsQl3ZpUweociFEgyg
 6xO9qcQ/yICElvJ7Z8pkci/8wGqQDDqcIm5jwSZMtQH7QXDngMDc6oM4UlCpU62bK36I
 eOV9eLb2iQqElBL14SUJVOlY3OYx0jUTyCON1GunyZYItxt50t8P8sCLAt4f2Yw1nr0t
 Rhj4w4Sjme6jCV3n8RHyz0vD/gd5exbW01ftc+TFaYJ0ARsWAqUBl25ArbSe+Ha7Buea
 UHDVsFddnU5JYcOO3TrRfvG3LVNvnpm6cePH6XfSR3z4ZTqv2j4aKCElXXuI65UeeBLE
 feAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795448260; x=1796053060;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=4LCaBKHWMB1T+mI4Ctek9gRui8KSkdg9JaTqoRb6N/8=;
 b=cywZ37eq4osFccb+MhRmwhiQPqDwzdQ//JtTDl/XhTVxw4jmCPL85IE/HVx8WUTMA8
 r5z2v9l2zSPTzyfHlBPEkQ/riy6hJBRJuAKUKsiYJamZ7AS9uehblLW9g5o2ou60MA2m
 36QXElqQGpwqtO/qvdoHSTA45N5g31o4hrzNuTODwjza9VI3AXTuP2yC7P3XFTI6OULu
 NF4M0Ehjt9XDeML5oPConkmz929fKfY/PYyu3PRRF2ymVcsnBQXUMJ3PylEa1SGJRUrk
 VAzQSVlKU7mO04WetodwiL+FzltNAkC6luAq6xfafhcLRALiB1xYLLjV4bdAeb/TgUNt
 Cggg==
X-Gm-Message-State: APuU4Z9Qyc9ZOFf2MnwieImMVwtMA0KOLAj5jQNQmTrx6xgIJ6yzYwCB
 03kdoC7qb7zCpz7Wbz7jkTG4pgzlIply46aMxjwh4mTh51SFpiEnO4LwlKU3pk5erPiqTmJIc1D
 ocd2Uo2/uBb2gGDstt9Bw+MDL2yB7fUeNmZOfH636CQ==
X-Gm-Gg: AZFdTZflev31xdpQW5zYWrmcDT70cIhTHRhnvv1OqcdF5WfYuW6gKaPUkuJh8DF8bBL
 zwV2L46vo6BKEw9lgJ8gy3M7m+e4LaZd7wFpPX7wS1pw8IgasD7rsTIhw1YRuaCpIDkBfifnPR7
 vJwN7fSNj4BBq7IcPLIjvk8FZYgsNEIY+dywR2CV6Xix4KNBWd8be/B4OeIdEvYACFJGX8RNsn4
 G+K7xS+v0DKXNM59xwPqP81DuwGsFwt03pMxS7W1B8Y/WbxpOxDqlVN0et2mnrOSsSu4e6TKVgE
 Y3BCvYeMR0KXnrUFQCUmZhAaMEdpnh+eUuLrEJvLuFjg2joN3kCDbJujbnpaT+TARcACp0sctOE
 qcw6JcV6wIqBaeWLLRZfQukF6f/lTdkn9GO8NdE0D61BIFaVn+k1J54SPhWk3+hvafaa6B1QJ9x
 XHKL8lAV8QMuXHR2X61pPt
X-Received: by 2002:a05:690e:1512:b0:67d:c255:9bf7 with SMTP id
 956f58d0204a3-67df4457baamr4368160d50.50.1795448260106; Mon, 23 Nov 2026
 07:37:40 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261118104150.599535-1-pbonzini@redhat.com>
 <20261118104150.599535-5-pbonzini@redhat.com>
In-Reply-To: <20261118104150.599535-5-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Nov 2026 15:37:28 +0000
X-Gm-Features: Aa3M54pqmGTTPV6mvm5lpxAfLso8vFx5A2UW1qWU1yva5BplGzcf3sEJOrhc8Zo
Message-ID: <CAFEAcA8YKFsvKjtcPq7_gTwA=XKbeSsxmtp9nd6k-VuE6SOA4g@mail.gmail.com>
Subject: Re: [PATCH 4/4] docs/devel: allow larger contributions with
 pre-arrangement
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S . Tsirkin" <mst@redhat.com>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Alistair Francis <alistair.francis@wdc.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Kevin Wolf <kwolf@redhat.com>,
 Warner Losh <imp@bsdimp.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS autolearn=no
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 18 Nov 2026 at 10:42, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The current policy does not include a path to formalize the submission
> of a larger body of AI-assisted work.  In particular, contributors have
> expressed the interest in using LLMs for new accelerators or for the
> userspace side of new hypervisor features; and some past contributions
> suspected to use AI still fall outside what the policy allows.
>
> From the maintainer side, the policy does not handle well the submission
> of multiple small patches; it encourages splitting the work into small
> pieces, which hides the design context and does not allow maintainers
> to delegate infrastructure improvements to contributors that are willing
> (or could be required) to do them.
>
> Constant streams of changes were forbidden in previous drafts, but since
> pre-arrangement of large changes was dropped they were implicitly allowed,
> except possibly when they end up being a code of conduct issue.  Therefore,
> the policy as written risks being unbalanced and shifting the effort
> from developers towards maintainers, which is the opposite of what it
> wanted to achieve.

If we don't want constant streams of small changes, the fix to that
is to say "don't do that", i.e. put some variant of this part:

>  - small LLM-assisted bugfixes (as a rule of thumb, below 10 lines of code)
> -  are allowed with disclosure.
> +  are allowed with disclosure.  Splitting a submission in multiple parts
> +  is **not** a valid way to bypass this rule; repeated, frequent posting
> +  of such fixes must follow the rule for large contributions.

into patch 1, e.g.

"Splitting a submission in multiple parts is **not** a valid way to
bypass this rule. If you have a larger set of changes to make then
you must do them under the rules for larger contributions."

For the rest, I'm not personally in favour (at least at this point
in time), but I can work with it if that's where the community's
consensus ends up landing.

thanks
-- PMM

