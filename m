Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0233606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 20:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=HVjREeRl
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJdBv-0005aH-Kg; Wed, 21 Oct 2026 16:45:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xJdBt-0005Zu-Pb
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 16:45:41 -0400
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mattst88@gmail.com>)
 id 1xJdBq-00070v-4t
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 16:45:41 -0400
Received: by mail-lj1-x233.google.com with SMTP id
 38308e7fff4ca-3ab4354db11so8713381fa.1
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 13:45:37 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792615536; cv=none;
 d=google.com; s=arc-20260327;
 b=ZVJkLR2VqG1qUR046arpkzClugHohk0VHEPnHQwwr60gyl5H/HGyxy76Pg91TYFvpb
 yKFn2M6O5Zfk3o9KaVbb2o0rVPPAavG+TewwWnsbGP39P8Kl22rpx9fcIaafYzOCmivl
 6haWFGJUmIytcTY7LmMgvBOf+JpNOxFkzUSw5z3ZBspBzybuIl7o/aIE0k44i8HImIb7
 tyxCR/aIiArWBGzvg6YdGShkjJ7SEFc1jjar5PDf7nUgNVKQdtPdezxsAkPj1CN5iX59
 OxSLbE4eV9SiiEfOWB7NvMVoNh6S1KAbGrhy4HI3sNTX8id2eUdPvzZLBPnQ3Y+6iV+7
 hNyA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=u9aNv+MNV1gWIs6o/Dj9P0dAdWNL06j7VM1JUOj1kOc=;
 fh=fMfr6U9vqZWyCHK3rqr7ZLaoP9Sdvf4Q6WFrB1e877c=;
 b=PsFMrso/AN0WA23UThBEa78ipZzCK4de0oF17WhSkCzt/I+QFOBiZwYxz2k+epPjzC
 ROzffVEtCa4sKQkY/xfRviJVssWXeAtKBXXYSUA5OMpf7T16BLmROtTqsWPhDI618cpY
 H8xfc3ej46LqhuZlJLCi2GvcfsthMVKiGD1igw/fVNuGp2wZdgDXNg23jXbWHVO2dmwX
 mGTeEdUswJQ/4mByMFH03KFm3iznTPQ2s6fIl7OhjEvyLci5lpyk7/zx1COqdrUnXXmk
 iuUfX8WYuzaIAOX4cG5ocYDdx6bmVn+lddsSG1ArQQlRNiv5F8hWGtooLIct9ArrW/ox
 VNog==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792615536; x=1793220336; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=u9aNv+MNV1gWIs6o/Dj9P0dAdWNL06j7VM1JUOj1kOc=;
 b=HVjREeRlFtFOZsUa5+bo4GreTziXQkwAHGcxrNs155VrFLbtPlBC0si8mYFa9R1vOn
 /FLHFjzTA5mE9N/v7ZqjV+sSdFzeqhIWFlwk2wAfWNrHOerd9Kk9c87XPuYszIQnVvpQ
 gmIHO5FqLVrWGJtWxjliekqmkH5Sn5yLJGWi4D1kFqHqkKqfYnySUG2Snyc47k0XcH21
 9S1EQw4Qqq2sNrBGADuwQ2juL/FhDelLlKvJnb/gvnSIxzX3bxvUcJnkDSh4qswxd21r
 tFK1H6Xh9EDzSmKPdrqYkPXCkAgKjcA91r8KU0s2gJ8zbCRb8wVnb/Qpa+207aFocxu8
 owsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792615536; x=1793220336;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=u9aNv+MNV1gWIs6o/Dj9P0dAdWNL06j7VM1JUOj1kOc=;
 b=b7mGuzR+5+80PRbh8hNGKbXvtZCSkYgAxtTOoDkRo/9Ci5fm968VVROyjtqwuLUmRE
 cHr7vuv6+/uwKtftx9gAiVigzmhhLv9ldQ+ptPT8ISmkVpxcC+qO93XVD4jrcOXgZcvz
 MqM+8WsttXCJtGORV/68mtoTSzZF6XCPwMPETrX1QDoBIm6kMFZUEDYi1MVvt3MU0qTv
 EC3h//PrDCNRNNPmQOSbY7oox3YBk8aWhd2bgvhzPqPbAbUkpdRGkg+6o1Q208cLBOhS
 A168D9yPzI5vkZOB2BHoqkgzPULmHwRC3MCZyiH9wY4cAvXJhvPa0kCq23uJ/Nx+P6T6
 agTw==
X-Gm-Message-State: AFq9FYKiS9biCT7P6TPHuodrjwZcbUoBvCRLn8zsbN+7Q5Bn5/q9igoT
 uSUGdsivTlFAb9/8LipJ9V8m1WK8gA4kRofd2NUzvf6g6gHB5Bou3TUu8IVYgEylPi+pPejMwoq
 /6l+dfE5+QRVmIXJWpY+ed3COW941QuQ=
X-Gm-Gg: AYBFou1udrh8Gt25g/Um1ENewzjAx6g9MzqUNprOH9pBaCPr2aSu0A99pECo/vdvxjK
 f46mDYfFoerplVuWJ/X2udTU5rrpatwucLQguG+MRMZ6vuCNuS+yJPgDcJP+7ILygJo7/ULCF16
 QrFzWCUv0wp6S6IvvcXKpt+iIIQfyklE1N3C/GsRKAFVH1xCYp4oEtq6pO0JsljL94nf2+W6ug2
 r/bMWY5Qh9+afHnH9V4+55ILtFxOxwgR8UX6Q61cc1z1/oXDib4SJOI6fNZKCmB8rEkm6THahoc
 oHpCLEOg9cjaOBW3SMRBuTYcQJcoK8l5+KjBWkTOJLtLqaYxwnikcF4ZQN9c8TqLWpPleQZSjGU
 5WdmtQWNqDhWmaj7KXq5rndZRqD+DP7fufcpzMlJdxQL05sgkGqLJjkcbLQVXMoSepCuh42oniK
 4f7mH0wLgLRQbITUkfWhEoF2WM1P3YghoU3QBxpwps796RE9zRRqwX2JMvHRP+W/gmmAKufasYi
 Q==
X-Received: by 2002:a2e:a7cf:0:b0:3a9:d70c:f75e with SMTP id
 38308e7fff4ca-3ac4415825fmr8205211fa.7.1792615536073; Wed, 21 Oct 2026
 13:45:36 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021141652.363109-1-richard.henderson@linaro.org>
 <20261021141652.363109-5-richard.henderson@linaro.org>
In-Reply-To: <20261021141652.363109-5-richard.henderson@linaro.org>
From: Matt Turner <mattst88@gmail.com>
Date: Wed, 21 Oct 2026 16:45:21 -0400
X-Gm-Features: AclHuK94I4tHIHejP0l3bbvLRf-RFMFuj16ItQn8zfK0ZkGUIXkxW0RT_W_du1Q
Message-ID: <CAEdQ38FWXOYZ6Npvam0Bb42=a+r4F8WCQZ32TbgPLM01qZCnVg@mail.gmail.com>
Subject: Re: [PATCH v6 004/100] tcg: Annontate functions in tcg-internal.h
 with QEMU_*_NONNULL
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::233;
 envelope-from=mattst88@gmail.com; helo=mail-lj1-x233.google.com
X-Spam_score_int: -7
X-Spam_score: -0.8
X-Spam_bar: /
X-Spam_report: (-0.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
X-Spam-Status: No, score=-1.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FORGED_GMAIL_RCVD,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

s/Annontate/Annotate/ in the subject.

