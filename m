Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DD8DCCA470
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 10:15:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v64ii-0005sT-63; Tue, 07 Oct 2025 06:15:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v64ig-0005rB-5X
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 06:14:58 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v64ib-0005oW-E3
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 06:14:57 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-71d5fb5e34cso82107227b3.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 03:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759832089; x=1760436889; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hCOPQgFfIrKcPiKTSIcm7cg4tw57aIbT+DFvw2tpPeU=;
 b=tXe+Y08Qgq7iOjH6ebyqO9tJuEjxihQckLrifrraQQlzwvGrgTwYETJndupMolXPqj
 W5slKA1R86cKCQZaJScS6jT4L8qRAU/Q9i+OWO5MIj3J/x8YwgKngVzcQTgxGBfVnYpn
 8n8/+xUIIzZzvStQstqd1aQaN5bMxizTvhXBzMD8fvcvCGL+LFI2AighYFLv0fL3blyi
 zty+ILgjvYUi3W6ltpztJ+JxgHfHrSfIz82kom/EuuAkfbWC1O0mjNDSsNnW+KTV85AT
 nhWNxcdpClsL1vAUpMmmgT6YlTqQ0ETBE5R76C/H4EWdFFlcUftAiL8uW4zwKbq3VIpF
 uozQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759832089; x=1760436889;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hCOPQgFfIrKcPiKTSIcm7cg4tw57aIbT+DFvw2tpPeU=;
 b=euY/LNUEDY+ce42ZcKTuLB0HzCu2PiD0OFOFV8AZ5E2IjHuPd65v39lL2Pmm4tUnCu
 gJ2YVNt2aF04EQgOSyH2zhFWpBEKnznLcrCSL6nqmGJ+cyNQieoo9pDPJm0wBUTDemi8
 05wKddawTSiz016BPUCermIJk36AQ9sm42+ULuFOZ0JdAazpr5KlGymBNbrkgRM5WgpU
 C20VBtSYQ2I62U2D3NPln1qGHRWnOaXfRf00c96sErk6AI1Q490eLrB8bLFuTjizJrc3
 41cLSD+GOji1J/e7SqdgtkStOKCLeVxN6p3bhoKsWunDO0uC4vaOsUBlF+3VdZ4KW4gW
 xLTg==
X-Gm-Message-State: AOJu0YxTXF+pDLvhBMhED/QXiPJpK57rlcVh7XjtUKLB0uWeQg4wBYVh
 rjSz7ac0phjUkFoZhVMEkyy4zBB7QgnI3U1oytcc5PRyqEiGpeJnfXfz1u/5gMJIkEA8kFh/UMS
 S7IZRxcAnqp/pif1uJMjN9C5AC1rmDz1jcpCEZcBG7Q==
X-Gm-Gg: ASbGncsxySV8qn84OwzqEFC4U15IgwCQqqPsdkCxxYcunTbooUOX6XDlH0wDo9qm8p7
 dcDcchIB/vD9Cf3vAEoaVrl++zra1UOvBqAtH4nJ/Q1eUp57OEDDSy4oE2F5H1cbDpF/tZoz3Te
 zAmvFQTjrFCwhEVUS58Ggsg5lLhSWJzwcVqqLn3OX/e26wkbsPMltYR/poQCjsOX4OIGrObuyQt
 87oE6zzQdBkTdFqN2dXPn+0sO6ALDMekVRf
X-Google-Smtp-Source: AGHT+IFpfMjKn+8aeWKpoWtTIo5pEWPuzHYO5Vd8OikhHmGrykFhT2iMzrVWHIF29hJxGNcjBbOopE47SK/yDCI+foI=
X-Received: by 2002:a05:690e:2d2:b0:636:cc3:af35 with SMTP id
 956f58d0204a3-63cbe13ede2mr1946421d50.22.1759832089102; Tue, 07 Oct 2025
 03:14:49 -0700 (PDT)
MIME-Version: 1.0
References: <20251003170800.997167-1-richard.henderson@linaro.org>
 <20251003170800.997167-41-richard.henderson@linaro.org>
In-Reply-To: <20251003170800.997167-41-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Oct 2025 11:14:37 +0100
X-Gm-Features: AS18NWAivW2avSMrlThYsZLutULbYT8hshpm8JbPCs7efEIMLxEgKh3OTAdtd7k
Message-ID: <CAFEAcA-XoDckJuJ-6pC3_JrxmS-x7QBBe-Mtnvqm17Xq9oCFXA@mail.gmail.com>
Subject: Re: [PATCH v6 40/73] target/arm: Split out access_nv1_with_nvx
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
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

On Fri, 3 Oct 2025 at 18:22, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/arm/helper.c | 11 ++++++-----
>  1 file changed, 6 insertions(+), 5 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

