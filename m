Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 661A8E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 18:15:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLREP-0002tE-IU; Wed, 11 Dec 2024 13:14:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLREO-0002si-2o
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 13:14:40 -0500
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tLREM-0006Nz-IX
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 13:14:39 -0500
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e3c8ae3a3b2so1248238276.0
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 10:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733940877; x=1734545677; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LFLxKKSsi/5fWLsw6myNEiO8p/pGOKjx2TTAAphFBoE=;
 b=JZEI5QuLd8IhsD6ZBt5D69oV5nfsUVEPWt8WvTOC0OSFkmJb28y7KjQ+l6o2nXbhOw
 nUHz8wtg734fzIR5uO3Sct0QC3VUpXGbG3Ksags+/p80U3fTd+aL3yGMxJZ9Ao1N0uUf
 GVkxrxzaMRdV0WCgjjNUVY0aFOHI9aHdaXGRE7DQpX4qXpVw3n5A5cHLZ3Sl4UREqNjb
 xQsV7nMXiBB+/sPGEz7+T/WHwN3KltWepD7UX/KPpNVp7KAF/BvXzbi4ysTe/fvFhCGm
 1eECjtvxyzM0rAZW98zewmXqkZ+r2SAiyr3AG6JeAd18VBkJEdf5MIP15rMlKms6QXnT
 3uzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733940877; x=1734545677;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LFLxKKSsi/5fWLsw6myNEiO8p/pGOKjx2TTAAphFBoE=;
 b=SLVqqvGiZ6RIAlA37jTU/ytBiGY8BXLOO7Ugoq6vH5PRYeY+HC+k+pf5uw1FGM6BPP
 S32wY49nf9JQd1RlIYXsZfJ+vGGTQVmFz/ROsXmleBQLFVzKV+8CfDCibk0gsbI9oiZ9
 oZm0lLOHnrLv850QAZWeNcWFsfXiBu6p21lz1UtRZlQ3mC1RG1nPhYrPlGscAfFOnLVm
 RoGj6ntwehRUfKM5sPOO3seRoJjNIsB0vz4fzImJqMXHPjN/U2t2XGDdK3U3oqRJMnrt
 A4WA2e/EWMFXoR7EAnLUzrFk4oayrR93oN3u0Wp2A/K0Pyvh9QA2g5rmoELhCkQt/yZI
 etdA==
X-Gm-Message-State: AOJu0YxZbGtBSuXzdxow3DU4EiHp7MS4OlIInL8gNhqZOKVkqF3dBfnt
 Qa7QRHmlInXj30NVGjC7oVm9hJYRk4P4eSHfuNBiQW6+kiEJmVbGT6LQNI24XJ0X3PuDgegCFKt
 JgYSAB1f2yoJV4f7fGsCTaGW2MshpMoxNt+76Bw==
X-Gm-Gg: ASbGncsCFwUCD8Ad5P4qZDy3lq3zJEyjJFsF44tNw7beqqsMLI0mOhiOLGFTgiilQi3
 Qw7X5pJqFgI66qdh9v4+kZPw+Yeg20P6d9VS4
X-Google-Smtp-Source: AGHT+IGD+jusourcFLrzJqoXt2C27s6UD9272/QXszS/Fa/WEPg2YfxGrAPXvPswHTXcZ0ywpcwBvBEHgeQigxCPR4g=
X-Received: by 2002:a05:6902:2582:b0:e39:7e30:9428 with SMTP id
 3f1490d57ef6-e3da1b08aacmr289082276.34.1733940877204; Wed, 11 Dec 2024
 10:14:37 -0800 (PST)
MIME-Version: 1.0
References: <cover.1733825219.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1733825219.git.qemu_oss@crudebyte.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 11 Dec 2024 18:14:25 +0000
Message-ID: <CAFEAcA9Wv8cPUhb3diMbOMnUEBTMYD9kFDoWFP8rbe_mb1NR2A@mail.gmail.com>
Subject: Re: [PULL for-9.2 0/1] 9p queue 2024-12-10
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, qemu-stable@nongnu.org, Greg Kurz <groug@kaod.org>, 
 Dirk Herrendorfer <d.herrendoerfer@de.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
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

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.0
for any user-visible changes.

-- PMM

