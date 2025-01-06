Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EC03E77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 18:41:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUs1o-0006UE-Pr; Mon, 06 Jan 2025 13:40:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tUs1m-0006Tj-5b
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 13:40:38 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1tUs1k-0003eP-K5
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 13:40:37 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5d4e2aa7ea9so27771780a12.2
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2025 10:40:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1736188835; x=1736793635; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=EQQWxi5ftjUPeaqlhOgVF6G4ZTzAm0vOzui9bcNGjyw=;
 b=V3412KUC6VYcgTNzPuIGrB6mwKx/v75cbQdTCR29ALAtHQWDx8zCVCJ3wgn+G2EPkK
 S86d8FUWRYr4DK8eRDCTsdw3vVwUjeOwJtWytH3vnJXcmvFFAU3OcaDZTfU0TywvX1pj
 47P3LBDPutJmqz89ml7w9FSmYq8cL43YYC61b3/cNDrn6t0Q5EW2gf32B+12iIQcCR1T
 U/Rrie8DDfaHhT2DpcE2jAn3cZPqOeAHWKbREkoGH89dSoSPl5GNE2uYisuJ2XirySsr
 hRs/iJFFuxdI8MzpBzOnM6jmazkSSMGf3NcNMihLeZgNgoHg5SFLYhiKJSly2MkergRf
 MzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736188835; x=1736793635;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EQQWxi5ftjUPeaqlhOgVF6G4ZTzAm0vOzui9bcNGjyw=;
 b=wfx+hlqizzqvPIfDuJLSNEiv2OClkx5tqxlcOu7csHgiaeGmTY90/+f5dEIyH0mhJP
 Rkg3BAuE2faAAYll8IEp3iSbgRaFv2z416SlxqvftssaAGJ3fkf+UGzQexp79FyKXhrK
 qn/bp+xk2qv/OwT9CokEy85OW4ZIJKbqzidJjO2dp4ny8kB+vd3v3mpdalxoZBCSbpfb
 wE7JQkqbzgcU7BObgxC7+oIzSsyiC+w0cHNsb0EbbjVypZbPh9zaV1IYOw4M4oVIAVNz
 9fPQ03+/zsbCQnj0UNajzt5oLVBOMVEbIuX5UpT0haLle1DefQOkKWuWK6Pss3SbSu+u
 Bx0Q==
X-Gm-Message-State: AOJu0YxzgebkYPekG04Q3YV2AwIy/P6vCtym1MFWbdTT7fSz96aAiuBe
 HbJT+i1TLVSRJjAWHyLPqJsQFaS7NG8s13nEJoLB5jAMdNgFo+QqS12z9ggQd8aMU6nGw+/zLpz
 mxwdYqJ8fFKni3btpG6DwOwPe+hcswo73
X-Gm-Gg: ASbGncv3TSae5uJPPdJzwfNLCCiIKDrwx1gw9mF/CB4sOYYkoD8D7ISlUOtrOpe6gEy
 E3Wyo8B0/+t88S0W+U2IRdpeuLVoUjqNBW+it
X-Google-Smtp-Source: AGHT+IFH5svSjW3JA3wew8HiAosFO4abEqhoNJT+LYVbX/m9UzM0XHJi7f6xwRa/hBxZPJmlFIS1Yru7GrAj648elqg=
X-Received: by 2002:a05:6402:1e90:b0:5d3:e8d1:a46 with SMTP id
 4fb4d7f45d1cf-5d81de38c24mr55338420a12.30.1736188834657; Mon, 06 Jan 2025
 10:40:34 -0800 (PST)
MIME-Version: 1.0
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Mon, 6 Jan 2025 13:40:23 -0500
Message-ID: <CAJSP0QXkas+ejvLrFeoPVOy3QTbGGH+ANO3dE5fNBd6iz3NW3w@mail.gmail.com>
Subject: QEMU 10.0 release schedule
To: qemu-devel <qemu-devel@nongnu.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Michael Roth <michael.roth@amd.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

Dear QEMU community,
Below is a draft release schedule for QEMU 10.0. Please let me know if
you see issues with public holidays or other dates that would prevent
us from rolling this release in mid to late March.

2024-12-11 Beginning of development phase
2025-03-11 Soft feature freeze. Only bug fixes after this point. All
feature changes must be already in a sub maintainer tree and all pull
requests from submaintainers must have been sent to the list by this
date.
2025-03-18 Hard feature freeze. Tag rc0
2025-03-25 Tag rc1
2025-04-01 Tag rc2
2025-04-08 Tag rc3
2025-04-15 Release; or tag rc4 if needed
2025-04-22 Release if we needed an rc4

Thank you,
Stefan

