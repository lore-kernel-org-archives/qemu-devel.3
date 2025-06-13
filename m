Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DBC5DC61DB2
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Jun 2025 10:28:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uQ1dd-0002ZG-EH; Fri, 13 Jun 2025 06:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uQ1dK-0002Ui-2L
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 06:27:38 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uQ1dI-0008SZ-5S
 for qemu-devel@nongnu.org; Fri, 13 Jun 2025 06:27:37 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-710e344bbf9so17251817b3.2
 for <qemu-devel@nongnu.org>; Fri, 13 Jun 2025 03:27:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1749810455; x=1750415255; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JlMs0p6VdV7oxxg2epAT1Bo92I28U+gNdsoTeg5K1Kg=;
 b=ZBqJL+9nBNlgI/rlKBya7f8ZS7N2z1iALIOga1GC5daPJQphfGcys5iIGpXqrkqrXH
 IjtrwAg5Z1PclakWDOoiQRTbJfQbPAq9EwyfDUgFnxJBgSfRhKQWl5Y6rHK31Hq23KDd
 k1yMU6atchsUoLQPSFtn6HkwXmOak1yaz/PfDaMX29H9CB08LpCoupL49sk1rAf+XpvG
 G3gMz4EZKAv/FJ2Fv+poSdCW8KLyXYbDsV3IU0XKqy915jxXQ+tNsqLpI29rYL7ocBsN
 PK8qPsMw4HDgKULxhEDrm761XwIjqaz5VD5M9kHGf4BMOG+Bi4bOHYzZNwgqfOyOU15d
 dgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749810455; x=1750415255;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JlMs0p6VdV7oxxg2epAT1Bo92I28U+gNdsoTeg5K1Kg=;
 b=NCL9tpXNtNwrmsOgTMp18aOdeXPQP1tf0LPzAU1YzLynZdfrFMFx3QR06luAxZw6Rj
 nelhEzuMLvOrmf0R4dXMQieE/TAgIS5UIbVrNbrDLMcJZ5d2G8qHX+6J8Av7evlgi7a5
 Reh1OG2DtOG2hECFz04dHPVIum8rLh7QFA/vVKkicjjGvxEZH17qasxUK/qFjhfbsSJ0
 AgAsxPz7yCnRxfan3ZQPx4ipdllpCMccVZRfvFNZb/q9NIdVtey2VGULQOnmuRjEAMr3
 4pszEDvjvmjqy63Aw9ik82g0ldRScuFVUzlxpJGQGY5JwEjCSvbburFb2C8zBcitEYYC
 2t7A==
X-Gm-Message-State: AOJu0YwTvv+FODjT2jow5B4RskwSYQNXqyIVJJ17+/+PLBZfmrASQWAU
 GhqyvJkynw4Seyzs2cNt4kkNn7j5bowlu0dtsslUmpMN1U/BXVMq3kMWhmR8ZiLxPpiyp5eZMyD
 M7wVpFwUNubxsPYVXI67gCp7q/NbOave0YOZZyrOF+w==
X-Gm-Gg: ASbGnctAocjhqOi95PV8jdnKGoo0FSv61GWVwFfwXBHx1xZbHZXMjk3m4dOqGYkg4Cw
 rPmunV3k4mg69FKGRxELRPYhSkCXAtUcx++CHfHJY2hn00+4UqHR/pUP+aeYrhvyM9v9gc5x7eb
 NmVwp74akT5QYmLpMocsnQSAfHiEGZ7IVwNSp9QNB+Qvw5RHtduQdXsCQ=
X-Google-Smtp-Source: AGHT+IERQXUXqFRJd53kRpxIN/keuu6R3uczYuqHyJ9BN6LqiMx0qa72q8Y7k9xu0+nO97b//YrO6cLKekDqTDUVzDQ=
X-Received: by 2002:a05:690c:4885:b0:709:197d:5d3c with SMTP id
 00721157ae682-71163650082mr41866887b3.11.1749810454848; Fri, 13 Jun 2025
 03:27:34 -0700 (PDT)
MIME-Version: 1.0
References: <20250609135124.45078-1-conte.souleymane@gmail.com>
In-Reply-To: <20250609135124.45078-1-conte.souleymane@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Jun 2025 11:27:22 +0100
X-Gm-Features: AX0GCFsoSXYnOj5hcfyQXlnNaRnAS1PFqwKcUpXPpuXLIQgMdOLs94Tndq82Eto
Message-ID: <CAFEAcA_Z2AgjaeeQ3sGHvUgvcQcDRGz0rwmq6pHJVQcnBGaNHQ@mail.gmail.com>
Subject: Re: [PATCH v2] docs/interop: convert text file to reStructuredText
 format (v2)
To: conte.souleymane@gmail.com
Cc: qemu-devel@nongnu.org, eblake@redhat.com, jsnow@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
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

On Mon, 9 Jun 2025 at 14:52, <conte.souleymane@gmail.com> wrote:
>
> From: Souleymane Conte <conte.souleymane@gmail.com>
>
> buglink: https://gitlab.com/qemu-project/qemu/-/issues/527
> Signed-off-by: Souleymane Conte <conte.souleymane@gmail.com>
> ---
> This is v2 of the patch previously sent here:
> https://lists.nongnu.org/archive/html/qemu-devel/2025-06/msg01318.html

Thanks, this looks good. I've applied it to target-arm.next.

I fixed a few tiny nits on the way:
 * moved the doc down to below qcow2 in the ToC (so it
   doesn't split up the two Parallels related docs)
 * added new file to MAINTAINERS
 * made 'Consistency Checking' a section at the same level
   as 'Header' and 'Tables'

-- PMM

