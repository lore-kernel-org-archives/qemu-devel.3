Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5E17C4345F
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Apr 2024 08:46:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvZ1I-0005a6-TL; Sat, 13 Apr 2024 04:45:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rvZ1D-0005YV-Ox
 for qemu-devel@nongnu.org; Sat, 13 Apr 2024 04:45:53 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rvZ19-0007D3-2u
 for qemu-devel@nongnu.org; Sat, 13 Apr 2024 04:45:49 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-56fffb1d14bso2105645a12.1
 for <qemu-devel@nongnu.org>; Sat, 13 Apr 2024 01:45:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1712997945; x=1713602745; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=hHl+uaacNZoO469pzd7El9ANHKIMAnHMvS64gxQXJmg=;
 b=CyV1DhumSzOAtNgeGr0To5h8eZPLOfvJDT8T3QTrc7TfjMcMkHUhXGfXNgdYS0ZDkC
 BX5Qqv+1hrlAZBQ4+0TbyD7d8jWZZBMQBygd5awg7z3fVlAlEuMEFs+1uQfyWK3wNgBh
 Zo1zz+tOwn4HqeRPyA/SZZlqHaQ+XIi4sW4V280LbbeGTmdSkgWZO4J8rSh283k6axB3
 PyEVAK0y0D61HT63+X9GU8JdFwfQKwR5A7We5GCyiaokyIQvT68UR5DfoWQ31Kk8lAb6
 0XlvjmJwmnQSHaXpdga/o4LodBbUrDz7p0BrVEgl7pCk/y75sEBJu4xu2tTGdIWPbm+S
 4FUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712997945; x=1713602745;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=hHl+uaacNZoO469pzd7El9ANHKIMAnHMvS64gxQXJmg=;
 b=rvnNPLuOt0821WPCfoL1/XinZpXJlYr80OW4QJBqZlbW0+FuFMtX0CciP2/Kn434HI
 MWx2OvLYIXxfr/R/J6ol3rQPJ0sL1sQUZJ7KnAEdv8bERi65fAMYrt+PVc49gtHwU8pQ
 vJa1huPvujrIoKu8+KPkxAsWT0RIouvWmFcA1Ixa7EfxQ2VOMThv/L8OaFP2aZQ7zhtW
 8b6RKAbp11929LFOye9AS/mbNnmmYwRFi83hsuDHx26BKkQhEOFTwmLIt85YwiRGhyqF
 xUsNAqB4l66qR9tlxqH4RZ5pQ03/9dMbgZteCrX/pBgc+o9MypWP99rvGgGeFL5P/csZ
 dxDw==
X-Gm-Message-State: AOJu0YzbLX4VK1KIrhNzeK3vxQoTlMQcZCF399ztTyiFRBJYrQD97CwX
 F/HzcfnHYDZlHl8pZYDf/PzB3ol74eS4TTdlE+/jbK9TA+/YdTEF+uhVUQowCRDwZOdHrfQqoSz
 iRCRqghQD40qB4m/OjCtuD91hHDgIkMZF2Hp9FQ==
X-Google-Smtp-Source: AGHT+IE3kdaHBvVwx+GLfnDRVeccpUOyFtqNVD2EFczIQqm4hjNRuiB5IjT4om6W+yLj47TlhXevxicZ9WgrBcoJV5E=
X-Received: by 2002:a05:6402:c4f:b0:56d:fbe4:aeba with SMTP id
 cs15-20020a0564020c4f00b0056dfbe4aebamr7269218edb.21.1712997945346; Sat, 13
 Apr 2024 01:45:45 -0700 (PDT)
MIME-Version: 1.0
References: <20240413052333.688151-1-richard.henderson@linaro.org>
In-Reply-To: <20240413052333.688151-1-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 13 Apr 2024 09:45:33 +0100
Message-ID: <CAFEAcA89WnvcE-0OAun-19vsWLqbSqtx-DMCJ+YaPHKShgzyvg@mail.gmail.com>
Subject: Re: [PATCH 0/6] disas/cris: Use GString instead of sprintf
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, edgar.iglesias@gmail.com, philmd@linaro.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Sat, 13 Apr 2024 at 06:25, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> More sprintf cleanup encouraged by the Apple deprecation.
> Probably there's a more minimal patch.  On the other hand,
> there's certainly a larger cleanup possible.

The CRIS architecture is deprecated, so all this code will
be deleted in 9.2; that seems to me to limit the utility
of doing big cleanups on it.

thanks
-- PMM

