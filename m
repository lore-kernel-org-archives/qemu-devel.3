Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77788C3ABCD
	for <qemu-devel@archiver.kernel.org>; Mon, 12 May 2025 12:08:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uERwd-00052S-Pd; Mon, 12 May 2025 08:07:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uERwQ-00051T-Cg
 for qemu-devel@nongnu.org; Mon, 12 May 2025 08:07:33 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uERwN-00012F-U9
 for qemu-devel@nongnu.org; Mon, 12 May 2025 08:07:29 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-7086dcab64bso40146037b3.1
 for <qemu-devel@nongnu.org>; Mon, 12 May 2025 05:07:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1747051645; x=1747656445; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=fqp145TTf6c9TZdU4feno64yxxmj0fOkAJQlbQnv7Ks=;
 b=VE6Yw73xluT0n8JY8nwhJToiS4+UgOoH8n8X1DV6V5WyXTWE3GstN4sxeSalkU8vYE
 acF698gvEZvRbocCdG89QMqCH0lobPhBxl3Sq2nP7SDD63EBml5zyEqcObrq3sfHs268
 vYtCNZCXxs1ii5vTlR31HB600mLrwS9/aM1sp0K0I61FdKgOOtWceDVITQx8Eopcm7KN
 1NhEAyQW0ETHUc7RRHWxcCSdl5ZQEhsrWNXFvEcOkl89lo5DwtWCdOlLqhawb29HV/fE
 +Dj/Pu/1WZQscMhjsm/+VkLOAhGLrcpvODLZgZ2jnHeqVDQ0TsuyBkOj4/06J8WDWsGu
 /bqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747051645; x=1747656445;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fqp145TTf6c9TZdU4feno64yxxmj0fOkAJQlbQnv7Ks=;
 b=SLSEvqHxRqFn2DRtzCbzVPYNP6hIV9yfMrmI7U9NoqihxTdBya/qpNaYQ58Dzugaj6
 o4X20nKr5lQNgv92oyn6cKhd2Ijr3i4gwIXvPYKvtUEAj9fhvFW/R3XIzYtHYPAsh8YH
 B0GfHcwwZlg3nRzMwzQK0QfY1vQeVxtGz1HUbip15tj/J25J2Kg9/MYQ51xyqzN8d1Sa
 hMjCoGNTyrPhjrgso3CZMhwHQ/oIi+xNBgq82RIAVuXKK5pCvPHnottQ/3cElVPrJusg
 ptGiTi3mzgoKBcH0ZLubvwVgVAeF6ELjNJWa/w7y4xlucEsqAYe+5R4t3oAL/HxtDuRi
 z7DQ==
X-Gm-Message-State: AOJu0YyIVzaUcG4s2rP+dhPzucdm8f9hdxMauR9oVI+HnEccAgtqOkfD
 eAnARcB5JSpQTz63pf+DeHjq7CmSfZdvY02heyLtSJf0QzaSMgRJ3I78IHF5PC8drWxqVzGoorM
 T+V0ZlD/pM5rnOU6uBZRlxfNIPNAmA9Zcmj2WBA==
X-Gm-Gg: ASbGncsQlz41S8cExgBUaDwyeqPt/bQydHC8FG7zIREo5kPsZxW+Ddxz66KAT8gkrzd
 BJBiwESuOkjG//lR9rpKTozVgX23sFSaZ3fEcO3xkEaxaC1GSMvoRrj7FdGf01HSVd0BSZJVfFo
 AuqiX8bjS+cwxJHVjx3Ta2UGonNB5La5UOXg==
X-Google-Smtp-Source: AGHT+IGnLn6thlLRWZizXFYbH6qxglVGVckUXnFcSAmzAk21Zga/nGvxh07sGsqYj0gEPIWEvOUye9pubD1pSgvewe0=
X-Received: by 2002:a05:690c:4d46:b0:703:c3ed:1f61 with SMTP id
 00721157ae682-70a3fa4337cmr177144197b3.20.1747051645153; Mon, 12 May 2025
 05:07:25 -0700 (PDT)
MIME-Version: 1.0
References: <20250508082943.446512-1-pbonzini@redhat.com>
 <20250508082943.446512-2-pbonzini@redhat.com>
In-Reply-To: <20250508082943.446512-2-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 12 May 2025 13:07:14 +0100
X-Gm-Features: AX0GCFsUURBzTh1Uds1AdcIFywPA33o5YP_BcBjkBNx113F-Hd-x5y2UtfGdsfk
Message-ID: <CAFEAcA8-A5D-ALLdTuP-urYF4SeVE5MtAYacRmWiMDC7ZshiQw@mail.gmail.com>
Subject: Re: [PATCH 1/2] rust: pl011: Rename RX FIFO methods
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 8 May 2025 at 09:30, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> In preparation of having a TX FIFO, rename the RX FIFO methods.

Is it worth mentioning in the commit messages of these
two patches which the C commit is that they're matching?
For instance this one is 40871ca758cf ("hw/char/pl011:
Rename RX FIFO methods").

> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

