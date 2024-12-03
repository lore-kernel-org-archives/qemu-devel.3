Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E765E64AA4
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Dec 2024 13:44:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tITBp-0008D8-Pw; Tue, 03 Dec 2024 08:43:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tITBm-0008Cl-Mi
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 08:43:42 -0500
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tITBk-0002Ep-T3
 for qemu-devel@nongnu.org; Tue, 03 Dec 2024 08:43:42 -0500
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5cecbddb574so6560736a12.1
 for <qemu-devel@nongnu.org>; Tue, 03 Dec 2024 05:43:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733233419; x=1733838219; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=g5WMSQkt52jkcd7ALnyI8L67NEhq/qeoF7cjP8SFnzY=;
 b=xaaUhNdW6/fhPx0O7CG2mJ777bp0T3o09spVUniqtoEe194VB0VvAMUH/8rcHBxcQI
 WjMy6lpwvoFfm4Cc0+cMk1y1z14OaaGkR4QDM/e1+mezfi9N+LlE4IEejdWQ698zS3+X
 9oRDN2efv72wJL2/KQOmv7tuxHX6ZVpNpFV9T4aM/8RtZqr1mHnRVYn+EZKvADEKEkFF
 ovDw+p8Ter5HHoeXL2B0Zr9rCEuwpD4lvrF6cSCrahgdfm5RUI6d1/leurE9uMQY08wO
 mLLBtX1TbihSzjUKCAo+CoYp0OWiDExtRpqeOn7qxwxXiiGzJv2yxlLDXPx5TcgThr5D
 5xxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733233419; x=1733838219;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=g5WMSQkt52jkcd7ALnyI8L67NEhq/qeoF7cjP8SFnzY=;
 b=DH8ODNBqd0V4rDppSG5HtTA7T8hVPtAgU6b9z24Rt++9+36j+TmY2E5HopPcKBdlIJ
 bY87FrVeO6iQ45ArqS+GIy58Wguz/meok+3jABW/WrDSt2C92MkIBgXDKwpAgpa2LKSk
 MzwfyhsmVWP28xAXWuq8wsahuspBaitN767a2Z+UvzrwL4cW0Zfqb+nuaSX8QI+iyvZS
 OSaJwI1y556lFrHbw5S2VFV3Gb4GC3FdHcep4/SXO/OrQS+e1ZkRLSjpUviT5vdnGleY
 B2JgBkjdgGcD85aFy8tde5QPwt9T6xiMZS1mbVs/rkzO90eWxAVAdmtqd3wErSMjmywp
 w93g==
X-Gm-Message-State: AOJu0YwPthI4F5W7nGbH+Yl2XwPFt2Gw8vN5pEhmDlcAxg3x3cSblwrm
 lE+lE4Yw5lSa+69Ahx/YRIGNh5HFwK6u0io29QhehZ1blnZMSxGikvpZC342goDzfeXsp5/zrUc
 ufOlEqAeNhdX+LJ9tD1QkVJsBbALexdhIDUaUPg==
X-Gm-Gg: ASbGnct/S6/Z20JhE2aUhyQX4iV/vNyCoW/lX7WMJTftRwgpRv4apzDuMDZOGp6+KUP
 8iP5N/uWAKlNzp10YTPkrOZAdUtKJ63u8
X-Google-Smtp-Source: AGHT+IEH6+l8SpJB4WKzUVd7CyMPrKf7y0SoB7UfhwXSL3GG6KaXQv8y2ZrkCdgdXAx1xuguwe3cjizuiHeLcr7+iQo=
X-Received: by 2002:a05:6402:42c9:b0:5d0:d30b:d53e with SMTP id
 4fb4d7f45d1cf-5d10cb5d891mr2121837a12.19.1733233419024; Tue, 03 Dec 2024
 05:43:39 -0800 (PST)
MIME-Version: 1.0
References: <20241202212957.570277-1-peterx@redhat.com>
In-Reply-To: <20241202212957.570277-1-peterx@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 3 Dec 2024 13:43:28 +0000
Message-ID: <CAFEAcA8a7D_5fBW0PzpFov2KN6KwvjCWwaqCSsZa4kZBtaYaqw@mail.gmail.com>
Subject: Re: [PULL 0/1] Migration 20241202 patches
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>
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

On Mon, 2 Dec 2024 at 21:30, Peter Xu <peterx@redhat.com> wrote:
>
> The following changes since commit eb22a064455aeebc105cc89bf77f48aa18b52938:
>
>   Merge tag 'pull-request-2024-12-02' of https://gitlab.com/thuth/qemu into staging (2024-12-02 16:16:15 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/peterx/qemu.git tags/migration-20241202-pull-request
>
> for you to fetch changes up to 3b83e663611c628bb04ae84a4f7ee49bdb68138b:
>
>   migration: correct multifd receive thread name (2024-12-02 14:20:44 -0500)
>
> ----------------------------------------------------------------
> Migration pull for 9.2-rc3
>
> - Prasad's one fix on thread name typo
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

