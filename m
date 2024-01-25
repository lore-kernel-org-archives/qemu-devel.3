Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15B47C48260
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 15:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT1Oi-0007WQ-Pj; Thu, 25 Jan 2024 10:12:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rT1Og-0007WC-Kw
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 10:12:07 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rT1Od-0003XI-W3
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 10:12:05 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-55cef56c6f9so1120418a12.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 07:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706195523; x=1706800323; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2i80wxe0/0QtBO80+y4+RhgnOoR/kF0A14FE8rom+X4=;
 b=yz+Fc3xo0EO8072CmkMWBjCo0Adxm6h9D+aqc9MEB52i5LDXiOsLGPNeA97gHK3Sfv
 OAdXmyEvyKS9W0tsmh/Gql/q8oU7i89rOpVPAUjAnDSbkP0seXfxXLYfYsa5AaVOAq17
 /S97qKLXgYMyo4L2ZzXLjss3F+y9UYiUIyRJwaoA4t9ETBPDiLyXYKUPCk5DrkS/MxAV
 H5/BqYpABSbf9KYzi2ODThTN7+8uQ4fUwIclV2x2aT5mh8xK7P2A4cAGqsHkCqfE0npE
 1XumyYQkc6RlLQ4fuP8KGLnkpBveLbnT36yNyiZ9x5VCbhMDXXNh6MCztctp3D3FG1tx
 ITjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706195523; x=1706800323;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=2i80wxe0/0QtBO80+y4+RhgnOoR/kF0A14FE8rom+X4=;
 b=MITap/HRsNx41gTner8ChK32MELvEkNWn9FQ2JS3QvFwMTQZIQvwmbbPy2QATFt6Ja
 DEVVnUVhAGJHwu4o9Co9Yq4TjXGjDK+bMOkrUajUVorpVQFcLtROSwJDTLeVrGZ0YhOm
 BXo8wvrKbhCQRZ6ijrwwIpnjcedyAM/M79Zk6kzk+uqZOoGMbrKJHeq5HitS11hTniuv
 HiS47gyVjUrChsAnPPVNnBmS+pNrAlknnTdRcR+MUcAm3FiZYIk/JJYeo1w8O6DDCZMI
 4hU25vnuVlurT+daxqtPLsffCY1KXKk5eYp4kcpRKcHW4rpgT6HFW75M//A+L78xR6mO
 wUeg==
X-Gm-Message-State: AOJu0Ywq0lyNw2r4qYmCFKgN2Os64EGJT5CwOj2Om7Ay/HQbWAeLI9y1
 v5Crg/zLFkJlbbEfbibfKM04DuMaZFrIe2q7xuzKiTNq9i3W+AZ36xHLg+92ns3uRIXdOX6TInt
 Z2rvIELx3EWiehVLdSAXYJX0OiLgzlgEDOx0Msw==
X-Google-Smtp-Source: AGHT+IEaIb8owQVao7zQjpPLzd6gv0uNzMpIaEWQWy4PvJvYxWTBM8f9IhneXkoqvZ19ZjckIoHJ/0SjycjeGCPglSc=
X-Received: by 2002:a05:6402:2554:b0:55d:1504:13c8 with SMTP id
 l20-20020a056402255400b0055d150413c8mr282350edb.48.1706195522803; Thu, 25 Jan
 2024 07:12:02 -0800 (PST)
MIME-Version: 1.0
References: <20240124104231.603418-1-thuth@redhat.com>
In-Reply-To: <20240124104231.603418-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 25 Jan 2024 15:11:51 +0000
Message-ID: <CAFEAcA8pcavVOH6T17Uokps0=nQdCQF4Nujj9Ave-Sek5jpueg@mail.gmail.com>
Subject: Re: [PULL 0/7] Test timeout fixes and URI code clean up
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Wed, 24 Jan 2024 at 10:42, Thomas Huth <thuth@redhat.com> wrote:
>
>  Hi Peter!
>
> The following changes since commit 09be34717190c1620f0c6e5c8765b8da354aeb4b:
>
>   Merge tag 'pull-request-2024-01-19' of https://gitlab.com/thuth/qemu into staging (2024-01-20 17:22:16 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2024-01-24
>
> for you to fetch changes up to e7b991451eecb58af34d6d3d17209e97f5e97f96:
>
>   util/uri: Remove unused macros ISA_RESERVED() and ISA_GEN_DELIM() (2024-01-24 09:54:05 +0100)
>
> ----------------------------------------------------------------
> * Test timeout fixes
> * Clean up URI code
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.0
for any user-visible changes.

-- PMM

