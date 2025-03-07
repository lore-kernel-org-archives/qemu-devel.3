Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C9FCC19F32
	for <qemu-devel@archiver.kernel.org>; Fri,  7 Mar 2025 10:40:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tqV7r-000278-9d; Fri, 07 Mar 2025 05:40:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqV7q-00026W-6S
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 05:40:18 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tqV7o-0006yM-L5
 for qemu-devel@nongnu.org; Fri, 07 Mar 2025 05:40:17 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6fd80f30ba5so12418567b3.3
 for <qemu-devel@nongnu.org>; Fri, 07 Mar 2025 02:40:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741344015; x=1741948815; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5YI/hYqqvKU6tOAc/SFErkl3HO8CSoJdZuzt2pEIiKU=;
 b=S76SQa0i94FcV7yUfE86xBGHNf+njzuMZGrcPhYxA6IbIPjqK6nsfh/8llZRNKGIFc
 uKyjtG/QoDt5CuBpkvZfHMTe0fnrx0r7dU4RGO0ceh480QOkfeD639mJQP5fcr2mzndS
 Uq8HRTT12uX5L/ZyCu6DkrRpqKYxd1zUyFJxvUGEHLM3YrGP4V+rmrAKwB20ddOcJ1XP
 eTFhEctB+mLBW59BgtkgiNpX27QiSxXzurt/v7ePn75SlB13v1ktDnKBWQKYx2GX6XIb
 KX3RKIGBKfVx6/GnLphRMlIEyWp0xNvoH9Jbje84rfFd9IBXwBIaIPaeTfXR/uoAR3fT
 uf6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741344015; x=1741948815;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5YI/hYqqvKU6tOAc/SFErkl3HO8CSoJdZuzt2pEIiKU=;
 b=fiNzSi8UfKx+nu+DV2Sg2NodykIBcGVf5/s7ZyzmAGe9UfFXgFRkMJaaotKX9UuOgU
 IXMFeUlAxuHzLOKdAJt2SS7KPqCPhjAABBP3s+D1i330EZTz03VP6fgeXkiNMXR1u79n
 VpcjQtugaNS/UJAZIM6d69+2206hviGZMW7kkr+8k1j4pCfLJ/QhqcZJi5fPZR0F9CgP
 dEzsVZd8VtssH17PXUSLfLc1K/16OYKHiFnkj+G+tb5VxUPqZbj4pQADScAeUB4zlpap
 tpXIaSNcpyETxoSJbY+eR/tjrzOfF20zefl6eIryMvCP86Y8dBfMZVE40iuwp15/Iy2J
 uZqQ==
X-Gm-Message-State: AOJu0Yxh75Xog/kY8YaaOMaNZF8ZKjlJgjmmnmdfiqqBmYTGiHvw4BfF
 belXQ0LxWXml21hhUOY8GZmLISlOvS0vyH6G2oaisbvMd2L48+QR5QV+enEyZJ12hoxuwuupnCF
 0v+BpqdLQS0R6FodtWy4ldDGojV6bEBCfiVvKAA==
X-Gm-Gg: ASbGncs7t1juB7wUKMAVZISxce4c5+rXVd42SKrFvDNY0Y8J4BzR4Gj5SNj3jvfbBJA
 ntOUfLrr4sDskibeOH+bntStqtPV40kc/No5tsO1mzDGP9k/NDh8B/QMiPGB556qZLtCToZQRC3
 ITF5cVonKj0QKCwGYUPJc1QICzKoM=
X-Google-Smtp-Source: AGHT+IHOEveYhDPrhfuqly+yD0sgXep2zBz4LQ5emtTXZcgp8F4qBzZdgnzpNK0Uv9zqDws1tLSagCJeKq6wW4yDaUs=
X-Received: by 2002:a05:6902:2081:b0:e5a:c837:a8c7 with SMTP id
 3f1490d57ef6-e635c136db5mr3443557276.11.1741344015549; Fri, 07 Mar 2025
 02:40:15 -0800 (PST)
MIME-Version: 1.0
References: <20250228103222.1838913-1-peter.maydell@linaro.org>
 <a95ff4d3-e362-403e-8d0b-63b888e098d2@linaro.org>
In-Reply-To: <a95ff4d3-e362-403e-8d0b-63b888e098d2@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 7 Mar 2025 10:40:04 +0000
X-Gm-Features: AQ5f1JoTTBC9G1kR5NbI1zsyogPpeDAw3LIpBV6_h3IssfJNk-Ywgx10Yzr8D6I
Message-ID: <CAFEAcA9zM6LmRJ8CRhyyr8DVJRR0KUi-H8dbO4_B_BpbK8dN=w@mail.gmail.com>
Subject: Re: [PATCH] include/exec/memop.h: Expand comment for MO_ATOM_SUBALIGN
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Fri, 28 Feb 2025 at 17:32, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 2/28/25 02:32, Peter Maydell wrote:
> > Expand the example in the comment documenting MO_ATOM_SUBALIGN,
> > to be clearer about the atomicity guarantees it represents.
> >
> > Signed-off-by: Peter Maydell<peter.maydell@linaro.org>
> > ---
> >   include/exec/memop.h | 8 ++++++--
> >   1 file changed, 6 insertions(+), 2 deletions(-)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks; I'll put this in target-arm.next since I'm doing a
pullreq before softfreeze, unless you'd rather take it
via your tree.

-- PMM

