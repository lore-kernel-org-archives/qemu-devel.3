Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93492D42BB7
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 17:38:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAupg-0003Ll-SI; Tue, 12 Nov 2024 12:37:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rakicaleksandar1999@gmail.com>)
 id 1tAtyK-0000L5-Cp
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 11:42:32 -0500
Received: from mail-ed1-x52b.google.com ([2a00:1450:4864:20::52b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rakicaleksandar1999@gmail.com>)
 id 1tAtyG-0007NB-FR
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 11:42:29 -0500
Received: by mail-ed1-x52b.google.com with SMTP id
 4fb4d7f45d1cf-5cec9ad04aeso170535a12.1
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 08:42:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731429746; x=1732034546; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2gdU9rAVSHK86aRoHi0o9Q7shHMNbo75JTK1QO30yYw=;
 b=ksK66f+pR7D5REXxZc3V9lZUyWMrF0X6C6rZ8lfIQk2eOWtb2q0nQDN6tK+r+qUHUP
 9ZHxlIEpyDjVx9aVDYXXObzMxrbh9LQ+LMfdKngyKXTaf204/ilZ8EzUmQ1UKQBk71rG
 2HRBZnlKJXBDlMuJ2rtIWyImTyY/0Kaax/Xcdy9NPOvH4ZikrAp3NpZMtpx4xZZtowBu
 HNhKTEuJQ/scRx3BU/zDI8hfYklqe1KGALQ8b7x56dVNf96VfNygxObavFqe0aimVVN0
 TYwt7q4koV19zLAqKSysFbFkouUMAlXETSqEYYY+dL0ha2jDdx4XAUIMj7PTGcL+YTPs
 vHIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731429746; x=1732034546;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2gdU9rAVSHK86aRoHi0o9Q7shHMNbo75JTK1QO30yYw=;
 b=jd2iilfXD8RKJ47BDp1e8Qv7jHrwPpMdXtmQpEbXRJsCn2f0l/B5j8Tyc4SL6tNmAF
 6EBd/GR/cRmkBMCpt3DbxrU+OeueAAaP2LwrTIPS102lDLXVd7mcts+MuVHgAHSlyqVy
 oZTXkKoW+D+K9wyBCLhg+6buSIfyUYpuLu+KKMewpbvX8kPVkmu5dUgn+XbuJW9ZBhbP
 8zB9OcRa9KsEwbC4mgmTmrR0FXyOhBbq+yMCSPrp9toS7uS5sHfOfJxrdO+jrfsFDfRX
 Yvd9fG15bvbjQ8w7qrw8CiXvfUgWCXfE/tJkV617tnA/y71RTBqJ1487OyRlWLAbzb2T
 Wv2A==
X-Gm-Message-State: AOJu0Yza8OulJVlvfUtINT9gGxavaZc/bRIdq4zzaEspkQAYsTu2kJuB
 V3DTfQTiY6SIbP/i/v20KK7PV+OYiP2rE2vJuq8infUPK7AmZN9vICkqg9lv
X-Google-Smtp-Source: AGHT+IHXuTVPAxbi2DPE94/PGmK3W/US20bnCpEjwUYqqgMgtkYo8porBtWKG0iWEEIvt0r+rMCzrQ==
X-Received: by 2002:a50:d78e:0:b0:5cf:f82:eb6e with SMTP id
 4fb4d7f45d1cf-5cf0f82ec44mr4357339a12.2.1731429745949; 
 Tue, 12 Nov 2024 08:42:25 -0800 (PST)
Received: from L-H2N0CV05D839062.. ([193.104.68.137])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf03c8130dsm6137004a12.88.2024.11.12.08.42.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 08:42:25 -0800 (PST)
From: Aleksandar Rakic <rakicaleksandar1999@gmail.com>
X-Google-Original-From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: qemu-devel@nongnu.org
Cc: aleksandar.rakic@htecgroup.com, djordje.todorovic@htecgroup.com,
 cfu@mips.com, arikalo@gmail.com, peter.maydell@linaro.org,
 philmd@linaro.org, aurelien@aurel32.net, jiaxun.yang@flygoat.com,
 kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 alex.bennee@linaro.org, pierrick.bouvier@linaro.org, berrange@redhat.com
Subject: [PATCH v3 0/4] Improve Mips target
Date: Tue, 12 Nov 2024 17:41:26 +0100
Message-Id: <20241112164130.2396737-2-aleksandar.rakic@htecgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112164130.2396737-1-aleksandar.rakic@htecgroup.com>
References: <20241112164130.2396737-1-aleksandar.rakic@htecgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52b;
 envelope-from=rakicaleksandar1999@gmail.com; helo=mail-ed1-x52b.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 12 Nov 2024 12:37:36 -0500
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

Aleksandar Rakic (4):
  Add support for emulation of CRC32 instructions
  Skip NaN mode check for soft-float
  target/mips: Enable MSA ASE using a CLI flag
  target/mips: Enable MSA ASE for mips64R2-generic

 linux-user/mips/cpu_loop.c       |  6 ++++--
 target/mips/cpu-defs.c.inc       |  4 +++-
 target/mips/cpu.c                | 16 ++++++++++++++++
 target/mips/cpu.h                |  1 +
 target/mips/helper.h             |  2 ++
 target/mips/internal.h           |  2 +-
 target/mips/meson.build          |  1 +
 target/mips/tcg/op_helper.c      | 26 ++++++++++++++++++++++++++
 target/mips/tcg/rel6.decode      |  5 +++++
 target/mips/tcg/rel6_translate.c | 14 ++++++++++++++
 target/mips/tcg/translate.c      | 25 +++++++++++++++++++++++++
 target/mips/tcg/translate.h      |  3 +++
 12 files changed, 101 insertions(+), 4 deletions(-)

-- 
2.34.1


