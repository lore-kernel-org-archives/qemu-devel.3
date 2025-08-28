Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B484CA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:28:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgFl-0002Lh-02; Thu, 28 Aug 2025 13:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdhX-0006rY-HY
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:34:09 -0400
Received: from mail-yb1-xb34.google.com ([2607:f8b0:4864:20::b34])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdhU-0008A9-AV
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:34:06 -0400
Received: by mail-yb1-xb34.google.com with SMTP id
 3f1490d57ef6-e94d678e116so868956276.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:34:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756391641; x=1756996441; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=JdW0FAikDnlYvC1ZJ5NjdjCS7rBoSnw11YgFEcbLqJ4=;
 b=kgtErnY3Gjh5DIOvm/o9/fDtRy6OpnAPso9iNspsNbwFH46OR/5xWtl6sZOTUqJukn
 l0gn8SSYeGy+LrpGniVWIHTdpti7nralkuZoTSCzxYGGWk1cf5LiWRw6ATra7Ihot6pE
 RDyiUICOtF3rn8m+cvk1+R/9v/8NHIM2J0qsv0cYKrRc+Zcs+t8mTnTfCqJelATNti5N
 4qFKhfSVoxomfYZFhYFZmrDqIRIen1IxJ4+JfXs8+EyqMnGdnOC6RL2+IMA1KABhTA7C
 JDyr2boPi084iORj2A07lFvcNPgZ18wmdJ3uMXjQllXwcWh++ThGXBEt2ZPGGN80Bn9Q
 hdOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756391641; x=1756996441;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JdW0FAikDnlYvC1ZJ5NjdjCS7rBoSnw11YgFEcbLqJ4=;
 b=TahQvzN/ELSA3QScNfmdCJr6I774s37JvE4gJlnt6RtbQhGj9/c41iRiZP9Om8YxLW
 +vET4W6F7foSgHURWdv3U3xgnIq/l9GH94lyGOOTYuqF9A5aoCL8yZFrNKBjiWC3ADiV
 s/RER22Absj0UsSzFzr9BZguSxakI/GEba9bOZtqmHav5/8XF720M/UMuOtx0LvPE1T4
 a4a+fDhU5l1t68UkxvjSdoHOiXQBRKMsyfhZUEyC9+BQIjXzEJY9zZTSHurBQcV7E2HC
 FrhM1K9TKplHryIh/0BRj+lWP2px450ZgD+IUvacvjy7FPYxaCGj1sMRjjuJYB+D4fbJ
 h+cw==
X-Gm-Message-State: AOJu0Ywh65bHrxBUJomyvfls97fXBIVEmpG0MaAaGZ5erdbgSZFH5R9+
 v1rKC5PfW2/EHQ7oAEy4UuMsexbpzA5jO71+LZfL4dco/U+ZKdXSI8unQrl0QMGqQgzszSKzg+F
 Xg5noYh1hU/cK/w4lxqijTe10/YxltVlRvhrT119dFTPpIH1D5+8J
X-Gm-Gg: ASbGncthxTAx3wveqOdgKtnT9bQMzmDD3pVbRb6I5+O9URJmX/vFojQBGpAUB1k2pPi
 YtEaXrD2t9IQJnZxyBpXapsHABSrh9c7uuSJ+ytP7MIDANGbUghh4qww7GOevCKcJCk8IGwamPg
 335onyfqYuOkdg/931dGk8l8FdHCV3J0BzIH9B0zL5LXLnE2D7VLNDrzC7YopPTYIaTd+oI6E7N
 0PcZfWFVHu2mjgzXdo=
X-Google-Smtp-Source: AGHT+IGyQikb/HfBAOrb6D4Iyc9MeaTTolDnPyDVRpSdDSnGhWK1m0UcfhIcX6TGlhM4+2XmPW5V53ON5bgNHA4qOoQ=
X-Received: by 2002:a05:690c:4a01:b0:71f:f359:6c9d with SMTP id
 00721157ae682-71ff3597064mr240129067b3.11.1756391641172; Thu, 28 Aug 2025
 07:34:01 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-30-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-30-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:33:49 +0100
X-Gm-Features: Ac12FXxQT-zLnanGaQaAne4tuZczNe4uuAWLyOcNgc6YXxOMguw363-_P4HNnvg
Message-ID: <CAFEAcA-DSpLNLN8WdFfN0L4huf-HT6UqEY2uyzJ7PqBHvngcrA@mail.gmail.com>
Subject: Re: [PATCH v3 29/87] linux-user: Remove target_elf_greg_t, tswapreg
 from elfload.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b34;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb34.google.com
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

On Thu, 28 Aug 2025 at 13:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> These are no longer used within the generic file.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 8 --------
>  1 file changed, 8 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

