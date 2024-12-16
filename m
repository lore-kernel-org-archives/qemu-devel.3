Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5222FE77183
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 14:02:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNBfO-0004zp-3s; Mon, 16 Dec 2024 09:01:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNBfJ-0004ys-8n
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:01:41 -0500
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tNBfF-0006Mi-UE
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 09:01:39 -0500
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-6ef7f8d4f30so34357397b3.1
 for <qemu-devel@nongnu.org>; Mon, 16 Dec 2024 06:01:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1734357696; x=1734962496; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=utJvzy3zZQcbbkMPAN++kwF5ocQoRVsyPTFt71LWUTw=;
 b=rWojyGXtDcAhKFOcdtsYWx0ctdJ2sVDSSj39awzeY91RhQgkjyjyC8ZEUfgEWwmTCJ
 Dtn9ZIne/Q+dehwlhaCbw+BJSwAExq0VCD+0xF7oe2PzHcV+PuEbjx/qO/yByZY0ldiR
 PYTKrAf+Y3V/6Q3Z59w6qCEmeQvvq+DqKcH89JoQDiXjbQhvUmpTfmhw570pK8UguLmT
 EZmpcnwOoVobExwwKSMbCKqq2fLwIgQhU3nl2eXAo+HjUeE87XgoauFEoNWTkR/skUPT
 xtvenI677gY+yF4BNEAJYPv2g+H96r4g+tMTI4joLZgpcbeJzAajU2hM4VxOs9g4lrtk
 qNlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734357696; x=1734962496;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=utJvzy3zZQcbbkMPAN++kwF5ocQoRVsyPTFt71LWUTw=;
 b=d+uFNdgvgyRvRw4odJFyTu5fYbyY7D412cldVa8Upfzbuq/fehDn7T3BzL9V85319H
 Zz9DVmyfl+akLjDwlsifkjhp/D+6eZs2Dzwdx92ooXLifkHABm6nZED4O8QmAdSGqx+/
 P2VkiZcW9VV0YUa/DI9MvhCFU3nJiJvaXrx5YClPkcInLAw2IQ1xvRP2cWhWTM3YBvTJ
 6A+JloKLs/vrILPT6Mr2UDX5me3gUOLXd1hTUCjZUWZOuNuvYc5aFC7DR08eMtweOqxT
 /W83eYLe8wGUkm2zix9zAyqcCF7Z+oUWHXaNgew1GkZQr3aRoVP3VOxRhtHRPbvl/OrV
 rIYA==
X-Gm-Message-State: AOJu0YyyupCfvHRN0UQYHDg6kx6S9xuebww729K7tsim1UgPzvrQgdyY
 a29GGoJUSsR3uHBlVJLTu6AVrByCqaqINh2cY6DCcq31S3toW5HEzKJ0Cr/Q/ijkmEURJN82bqH
 JgCJJzSfJmwon+N+ZYk7hHng9botPeGId2HOt2Q==
X-Gm-Gg: ASbGnctf6xGHxjm5s/HGHu5PyIeyse8Y4R6h+q3v8ha/Dcihwu6R+NYqFgFIlneGwb0
 pqXzUcY4F4d2hK2s5zv0QfBhfsbSVGG2/k4b7I/M=
X-Google-Smtp-Source: AGHT+IGCs3bvRitEhRguZ0PqbDWmhAx7Hf1i287a/j/ctBlEk+9Lx8QB/prZBd57Ga8179YovdFePfDh3ebuDAbhZ7M=
X-Received: by 2002:a05:690c:6c07:b0:6ef:6a91:4971 with SMTP id
 00721157ae682-6f279ba6c8cmr108983837b3.36.1734357696075; Mon, 16 Dec 2024
 06:01:36 -0800 (PST)
MIME-Version: 1.0
References: <20241206031224.78525-1-richard.henderson@linaro.org>
In-Reply-To: <20241206031224.78525-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 16 Dec 2024 14:01:23 +0000
Message-ID: <CAFEAcA8-P=cmov6FNP1uhD3YRpZk8BB0tdrS_yx-5L18SX5y4g@mail.gmail.com>
Subject: Re: [PATCH 0/9] target/arm: Helper type cleanups
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Fri, 6 Dec 2024 at 03:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Add macros such that "fpst" can be used with DEF_HELPER to
> indicate float_status* instead of "ptr" for void*.
> In addition, fix a few uses of "ptr" that should be "env".
>
> r~
>
> Richard Henderson (9):
>   target/arm: Introduce fpst alias for helper.h
>   target/arm: Convert vfp_helper.c to fpst alias
>   target/arm: Convert helper-a64.c to fpst alias
>   target/arm: Convert vec_helper.c to fpst alias
>   target/arm: Convert neon_helper.c to fpst alias
>   target/arm: Convert sve_helper.c to fpst alias
>   target/arm: Convert sme_helper.c to fpst alias
>   target/arm: Convert vec_helper.c to use env alias
>   target/arm: Convert neon_helper.c to use env alias

I see that commit a9af119f3d to put the fpst alias into
helper-head.h.inc is already upstream, superseding patch
1 from this series, so I've queued the remaining patches
2..9 to target-arm.next.

thanks
-- PMM

