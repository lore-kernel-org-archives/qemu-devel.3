Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9824C48BC4
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 12:31:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcPHP-0007rz-Jx; Tue, 20 Feb 2024 07:31:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcPHM-0007rA-Of
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:31:20 -0500
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rcPHL-000763-38
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 07:31:20 -0500
Received: by mail-ed1-x534.google.com with SMTP id
 4fb4d7f45d1cf-5645960cd56so3174164a12.1
 for <qemu-devel@nongnu.org>; Tue, 20 Feb 2024 04:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708432277; x=1709037077; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=HIStiYXkXTcOJyvv/atc2ADxmhvcM7xyvK8iIss2cic=;
 b=XMEUh4AUf8d9slXLuN1GiM2OtN8RBWKi4PN1Vkc9HCXI9WK/flyWdU9fQxCCfytvOz
 V06rWlGVD/TriEMtrUJPrW+urH3TCq2LC7rzHeTVzFGI9sHTQImVoCeJ+mmXHMPzeelr
 i5kIqzNf3x6K/vMHYrzm7u2jfyYgFe0MZAA5kDP+HJneb98rR9CaSft8AnwrUkIrU/gy
 UwPqmrg+un9+925kF1oD6Y9EMh722S+cZ9U2hEve4yVbTj3/a/LMXCbr1imzzvp2bbnI
 OTYBZu8+ACUSjsf0hvKHBaylRnE6esaNUrreCQaxYwuE1ke1uoJo9/4vKqbr12kJka4J
 R4nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708432277; x=1709037077;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=HIStiYXkXTcOJyvv/atc2ADxmhvcM7xyvK8iIss2cic=;
 b=VMtNqHs9iaem5KhkcCjoA+YB3VyfztuQOhtE/F9zMy5crLZv9Wikbg0+PSDLiUw1Nh
 nj7cHXt/u1//NUb/u/oEWfTAqF369inZFhNWglpFcRjdFuaRv8xrZJ/FE2Ah/6xpz7z1
 TF8gsYo0hT1IBfHSindeciCy3OeUd0bkKwjmLbePzZDLpMwhnoZxas2egRVpyGbKTtSB
 E6GTQQ7oCjgpsniincUhtPnJSG5RLxJu4gn0MFXigLaSzcLCXNypN6HSpRqGGQmas635
 RkXF8N2G+sBy/UlWeihnvFEBSXF1q2A6/PrbFFgFUpbVI+Vx1OwdOJna9c7njwpJBNp5
 34HQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUG+tVNKGx297C11xnuVMYKHa1UbSnfDqnjlwAJOhEUbZbvEjSRWFIbyPOnKKRlhoQer1OfxJgGHHkgQEqFRZUTw4x5BKY=
X-Gm-Message-State: AOJu0YxeKiO53ZfUya6v3G7nMsfdb/a/cM+nAqd2TmW5z14Od9INt/m0
 GGDU+WefEeOnNdV7uK8jhGchlTc55wAMvZBk81mmjQsMg2Jll8E3UNRbwQe4jPIxir+WAky+bVN
 Jq6uzZndooT8Uyv6FXA8OThR8eL1KNPLsm4K0/Q==
X-Google-Smtp-Source: AGHT+IFD3yG4a7UJ5e3h0jULdB0+RL/ZCaJMR8YzJdmaC5YvP3u3+j41sZuIFH7Sna6qqQAaT02to41u9vMLlEBt+7E=
X-Received: by 2002:a50:ed03:0:b0:564:7350:cac8 with SMTP id
 j3-20020a50ed03000000b005647350cac8mr3664227eds.15.1708432276797; Tue, 20 Feb
 2024 04:31:16 -0800 (PST)
MIME-Version: 1.0
References: <20240220121752.490665-1-ruanjinjie@huawei.com>
 <20240220121752.490665-2-ruanjinjie@huawei.com>
In-Reply-To: <20240220121752.490665-2-ruanjinjie@huawei.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 20 Feb 2024 12:31:05 +0000
Message-ID: <CAFEAcA8jef+ZqSaj7MOwkneuj5aLayA6MZA=-LH+VvcDuFCtZA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/3] target/arm: Implement FEAT_NMI to support
 Non-maskable Interrupt
To: Jinjie Ruan <ruanjinjie@huawei.com>
Cc: eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org, 
 wangyanan55@huawei.com, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::534;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x534.google.com
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

On Tue, 20 Feb 2024 at 12:19, Jinjie Ruan <ruanjinjie@huawei.com> wrote:
>
> Enable Non-maskable Interrupt feature.
>
> Enable HCRX register feature to support TALLINT read/write.
>
> Add support for enable/disable NMI at qemu startup as below:
>
>         qemu-system-aarch64 -cpu cortex-a53/a57/a72/a76,nmi=[on/off]
>
> Add support for allint read/write as follow:
>
>         mrs <xt>, ALLINT        // read allint
>         msr ALLINT, <xt>        // write allint with imm
>         msr ALLINT, #<imm>      // write allint with 1 or 0

Can I ask you to break this patchset down into smaller
coherent pieces, please? When you write a commit message
that has this sort of "list of four different things the
patch does" structure, that's a sign that really it ought to
be multiple different patches that do one thing each.

Do we really need the command line option? Mostly we
don't add that for new CPU features, unless there's a
strong reason why users might need to turn it off: instead
we just implement it if the CPU type and/or the board has
the feature.

thanks
-- PMM

