Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF4C4E7717F
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 10:13:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tKxF7-0007YK-VK; Tue, 10 Dec 2024 05:13:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tKxF4-0007Xn-TB
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 05:13:22 -0500
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tKxF3-00046D-5W
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 05:13:22 -0500
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-5d3f65844deso3297334a12.0
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 02:13:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733825599; x=1734430399; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=DtdQMpYbfJMPo4aM4jPsUX08+Mgu11SebWWT0ntomOA=;
 b=n90vrD7b7SMquTNtZNNyj/mvnyDk8pN2iSj1NtRwWk1pBUBxSyxzOLazvN7BhiJtQn
 GAOUVS54Qa0dRQANk2TqurKe75eIY5sx1UGGQoU2+MJvumN1N8CX+VR5ogoOztlweLq7
 zxShBMedwyjiodREBJmyFskcrGwKJaCFEg7CQiFOb4M5TaVlEjf5qq+C1DFYOO8brMbR
 k2zO7IWyosA/u6Cd45HbVvFIJBUjYspOS0C0FZQwW9qclpcmEOrsmSK9x9g2IfhAs0gS
 SiIz0H0NOykziAOeEf8+XRZh+ARdIVPVVvqC21WHKpwZH5Bh9ZkXL3kUJQ5UisCqwufM
 2lZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733825599; x=1734430399;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=DtdQMpYbfJMPo4aM4jPsUX08+Mgu11SebWWT0ntomOA=;
 b=hFkqk/YFGICu+1pOVZ5aC79VfArAe0xgknCLo1HopYxMi7E7DMz6hebO1szhWrt2c3
 b3FfpdIEuGiOCI3nI/8n9keZzZSPfHaf0BZWEIgPVZ3a9wb7lIgYLLrJTg6P/P8jtoRk
 73uEsWsvLPNMbvuUCI3aJI8Gu8YFIhZSDln13EXIwaUD6Vaz8XVUvkZbjWy3F83UFx3V
 rXqdEB9sBbpQd1sxekPzcCtpv+xnZqU7HMuPnEx/BVaZa/WdX4XSh85RWAtKUpcreLV/
 NU0psC5pSKTGTyQkVhp+/PNHxmMCOjwNwc/b/pqQMMlYMqnW+tgZt9hZ4ricRiXrL6zC
 ysXw==
X-Gm-Message-State: AOJu0YzEtGbvSI7PzI7QpfXF5La41LO121290IfG9Q2GxkfhcLDg5H9t
 k0RB3M/dsbggCc9p3BwQdWdJuDzGll3Di94hg7rvAJPqhCL46AyWQMZj3Doq7+Fsbbw3ha0rijk
 sU0Ot3rU4KFLmateqHIHhcw+ptIoNrZ6nJMTSuw==
X-Gm-Gg: ASbGncs8ht1R8kVADOflvtdFQBd5reH9brF3vyDp99inJLCmpjsUkl3QFCNVy9kYZEG
 BHHxr9yqv0C+3WeKab0b3AXRqNOqAUAI5rtyi
X-Google-Smtp-Source: AGHT+IExlMuC2f7Jx66wRbBX62m6HHyXaHynh4DVbUICjUeb840fJ4FiGxiBhIBO5QYbTK6TvxISpGvC7GqBTbXc/no=
X-Received: by 2002:a05:6402:2115:b0:5d0:8197:7ab3 with SMTP id
 4fb4d7f45d1cf-5d3be6bd82fmr14908205a12.3.1733825599370; Tue, 10 Dec 2024
 02:13:19 -0800 (PST)
MIME-Version: 1.0
References: <cover.1733825219.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1733825219.git.qemu_oss@crudebyte.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Dec 2024 10:13:08 +0000
Message-ID: <CAFEAcA_Mjo=RO==kO+Q9uXf-kD8Y1JAyynu6mOa+pB0WH=e3dg@mail.gmail.com>
Subject: Re: [PULL for-9.2 0/1] 9p queue 2024-12-10
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, 
 Dirk Herrendorfer <d.herrendoerfer@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x531.google.com
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

On Tue, 10 Dec 2024 at 10:11, Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
>
> The following changes since commit 1cf9bc6eba7506ab6d9de635f224259225f63466:
>
>   Update version for v9.2.0-rc3 release (2024-12-03 17:56:12 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/cschoenebeck/qemu.git tags/pull-9p-20241210
>
> for you to fetch changes up to d06a9d843fb65351e0e4dc42ba0c404f01ea92b3:
>
>   9pfs: fix regression regarding CVE-2023-2861 (2024-12-10 10:24:52 +0100)
>
> ----------------------------------------------------------------
> * Fix a regression regarding CVE-2023-2861 with security_model=passthrough
>   which caused certain sockets on guest to fail.
>
> ----------------------------------------------------------------

The commit message says it's a fix for a bug in commit f6b0de53fb,
which was in the 9.1 release. Is this really a regression since 9.1 ?

More generally, if you want to send a change on the day we're
due to make the final release, it needs to come with a clear
justification for why the bug is critical enough to force us
to delay the release by a week.

thanks
-- PMM

