Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 026F8C54E41
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 22:00:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rej0O-0004oF-LS; Mon, 26 Feb 2024 16:59:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rej0M-0004nW-CH
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 16:59:22 -0500
Received: from mail-wm1-x32f.google.com ([2a00:1450:4864:20::32f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1rej0K-0007gm-69
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 16:59:21 -0500
Received: by mail-wm1-x32f.google.com with SMTP id
 5b1f17b1804b1-412acb93e2aso298625e9.3
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 13:59:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708984757; x=1709589557; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KmnyP4q0jy9nANsN13GP3PZyPgqHfAUAZ17+LFCx0pg=;
 b=Uit+JdFY6eSWtgeQlQMegQXNvjzylvI9vdvYXzwFpEzkji/9aAknlqHIasmnfGHtPf
 qA0DcHaGjb0gGq7+1fGeV3d62eqB0Rv2kfwtUGLTow/eVDbnqw+4XmHKb+HvxzoMnrIn
 gBo5aro8tGQIGPsLiVvy2vNeCwOyNlGhZywTkiMLhJYQXG4RXiSr0pUVNJbEqXNk083i
 91GaxzEGlzDNx1icLjJHHreJ0p49BO48f/RHD0SJEX45TO/63OEKz3X8CLaOWDi3MNOF
 zKwu/kOnQ0ZD3MfQIAsjZ10kiqFg+yWt3e2IZz5lgfjIR0bC1LmBM5IokGL8mWlbCokC
 Mo8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708984757; x=1709589557;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KmnyP4q0jy9nANsN13GP3PZyPgqHfAUAZ17+LFCx0pg=;
 b=C66ahfhSCl+t1TyyFLi5HmNVm0nEAnpApsLbAxfAFN5jDNn42gKqlk+2IyAZXfaXPX
 e0VlahtStflZl/HQBMhp7bkKl3Qp1ZOPccVxZlIyh18f7up9RQR/Hg6xnSDqaktJEGSw
 aj7g/+qOrN7gAME3NHkzgvjNjGRodyIoPfxsNjoHyBKK26ZMfUWtiuG4AobZ8w+UiOdd
 GGMBY6nDv26YFi8qt8xlj7IheqUMpqmsxJyuwJeGkzNZ9gcubUsTepJFubOQ33mTcmhx
 hKkeTRYmsbGLu4Xnu6/CNQgjaiIdAnIx//gHwGbx8fdTIlvPbVHEQQod/kG6oFJbWtSC
 pA1g==
X-Gm-Message-State: AOJu0Ywbb5jgliw4YClwwV6svK4o+iq/4fLJyfftQkO78mng5oaZ+/Px
 wBFJGTfulrOxG1GWgmaSa27delFJ2gn3LjFVoVXyAe4U23BVQy8yjK70NQSI
X-Google-Smtp-Source: AGHT+IH1bjoLVKmNL4UbKqCSKqj5fw5u4sqGY6sISdj9/QFDz3soEWMHkaDZwvqhZ4XhAQNKfTQbcw==
X-Received: by 2002:a5d:50c6:0:b0:33d:6984:3f80 with SMTP id
 f6-20020a5d50c6000000b0033d69843f80mr5305715wrt.67.1708984756711; 
 Mon, 26 Feb 2024 13:59:16 -0800 (PST)
Received: from Provence.localdomain
 (dynamic-077-188-008-186.77.188.pool.telefonica.de. [77.188.8.186])
 by smtp.gmail.com with ESMTPSA id
 h4-20020a05600016c400b0033dda0e82e5sm3985753wrf.32.2024.02.26.13.59.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Feb 2024 13:59:16 -0800 (PST)
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Bernhard Beschow <shentey@gmail.com>
Subject: [PATCH 0/2] Revert "hw/i386/pc: Confine system flash handling to
 pc_sysfw"
Date: Mon, 26 Feb 2024 22:59:07 +0100
Message-ID: <20240226215909.30884-1-shentey@gmail.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32f;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x32f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

As reported by Volker [1], commit 6f6ad2b24582 "hw/i386/pc: Confine system=
=0D
flash handling to pc_sysfw" causes a regression when specifying the propert=
y=0D
`-M pflash0` in the PCI PC machines:=0D
  qemu-system-x86_64: Property 'pc-q35-9.0-machine.pflash0' not found=0D
Revert the commit for now until a solution is found.=0D
=0D
Best regards,=0D
Bernhard=0D
=0D
[1] https://lore.kernel.org/qemu-devel/9e82a04b-f2c1-4e34-b4b6-46a0581b572f=
@t-online.de/=0D
=0D
Bernhard Beschow (2):=0D
  Revert "hw/i386/pc_sysfw: Inline pc_system_flash_create() and remove=0D
    it"=0D
  Revert "hw/i386/pc: Confine system flash handling to pc_sysfw"=0D
=0D
 include/hw/i386/pc.h |  2 ++=0D
 hw/i386/pc.c         |  1 +=0D
 hw/i386/pc_piix.c    |  1 +=0D
 hw/i386/pc_sysfw.c   | 17 +++++++++++++----=0D
 4 files changed, 17 insertions(+), 4 deletions(-)=0D
=0D
-- =0D
2.44.0=0D
=0D

