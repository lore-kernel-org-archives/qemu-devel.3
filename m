Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3EA2C87FCB
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 19:08:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhv7U-0000hf-NT; Fri, 01 Aug 2025 15:08:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtaO-0002fP-Qq
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:30:28 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtaN-00047R-3C
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:30:28 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-708d90aa8f9so26357327b3.3
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 10:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754069425; x=1754674225; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=pIow4YDydRLxq3Wrq1Mc3cNruTP2Lke/VJY6KcQl0NE=;
 b=Kqk5kTm0LuWhVHSZSrVB0FgFsosO/jD0RIROo4vH5sNzHLUgUmYzu+Kl3Vbn7LgzBW
 fOJc2PmerYDhh0++5EViLAWgjgq4t1poktwnT+63A7sBcVlUvEjVMDc1aACZXtzeAQBa
 XfCrDtuXc2D1+Bk+s4GnNZkRzVruGe3nn9mzxSYouawcpxjLyeh14fio82qMy5bAiE/r
 uKzIXyRScucAJHCux477ApIMpyAfBDvbCqVEVjlkfHupx5+ju2IdlQlKHOuZL6JDy1Ii
 43q7p3h90m55InqAn92RA++/Od+F+fDj0/PCCO5x0vku6UV+HNXjtF5grFdZiSEmyqyV
 doWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754069425; x=1754674225;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pIow4YDydRLxq3Wrq1Mc3cNruTP2Lke/VJY6KcQl0NE=;
 b=g0kDXmrgHzEeNGGPX6uTre8ImpqGHS9mUVmWSREx6t6pr01zww81u0V5v4RV8TLuhP
 cVmeWiln43VIYXHXnnguNRJvLJoCTmBcogheknoSJK285dgS3Y4onm6V8RVFxU+d4t+c
 1Wmlls5q865iR3mwaStMR8ZfSlf59t0IDXF6mOHaMhzLDSXPsKmnZAo4KeS/ao+JcT5h
 fHRc73Ag3tBpVm7Q777bTGANOkozcbXNUx8qRHfOvsh4y1j6qQXGOtxiYbfq9xq2+4yp
 kPGFzTIk4UJdnvxOUkI4juGc1DrfKjyAu+TZ97lq84S7eSrj5R/FtzcdBZ411YfTbDYs
 O+Aw==
X-Gm-Message-State: AOJu0Yx7E65A6+qE8/9nQv3YJ0nMBYbT5pjzYkq4yPzbTyYTnmS3Ba/M
 ZJG4KVjP3KzMelIonK/JbNRQoHmL+irTVK17mcEZuczyya2Nabvg9MkGm6RSHtbidcKkEVkh6mb
 gpu9RO0v07kwPoCNYhbY1Dq+RU9RFAVgeFMAVjl13WA==
X-Gm-Gg: ASbGncuQAMe8UDa9Q7P+0HOO7lKZcdwNhq3tLjsZaWDevlp6fkDwRnVuEVZZy27WkvU
 r/N04yr8AeGI9wV802ZEEWl5eDK72vSE4CUZ2PoneXfk5OKAzc9FbjZ+MMQYUeENFG9djIyhPLO
 e3pZsWT7DMjQTt1qvE13fw5k0w3yAJchGcwhkkc817txsBKiTELaaeBZQDCogq76NGcsYS5BwA+
 J23yWSn
X-Google-Smtp-Source: AGHT+IHToaKwDjmEgWqvF7qs2EF5n7Tr+Bpv81xvuZ1XaRaTsGXROBUFqXBwwEgpaTKef84kQ8stO7nLZhUGx9L3cFQ=
X-Received: by 2002:a05:690c:660c:b0:710:e81b:f7cf with SMTP id
 00721157ae682-71b7ed716bbmr7817057b3.13.1754069425358; Fri, 01 Aug 2025
 10:30:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-33-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-33-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 18:30:13 +0100
X-Gm-Features: Ac12FXwJZLP_UwkrA4dNq0MiWnN6c9sBmYj1JauDAj4gOSbOtE6TpSSHx2kpxLs
Message-ID: <CAFEAcA95khahVtDUiqK3HH82p6h2axK7pnRznRd_89=BAvH1TQ@mail.gmail.com>
Subject: Re: [PATCH 32/89] linux-user/sh4: Create init_main_thread
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Wed, 30 Jul 2025 at 01:42, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Merge init_thread and target_cpu_copy_regs.
> There's no point going through a target_pt_regs intermediate.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

