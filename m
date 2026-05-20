Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68354CD4F54
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 08:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPbqJ-0003S6-VH; Wed, 20 May 2026 03:59:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wPbqI-0003RO-D4
 for qemu-devel@nongnu.org; Wed, 20 May 2026 03:59:50 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wPbqG-00041P-T6
 for qemu-devel@nongnu.org; Wed, 20 May 2026 03:59:50 -0400
Received: by mail-pl1-x62d.google.com with SMTP id
 d9443c01a7336-2bd2c147abaso26732025ad.3
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 00:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779263987; x=1779868787; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=LH/BXLlF6AH1KnQEODR72O/Iuej85LovWVNKwFOfqbE=;
 b=pEVYa5DLhm4pJPNK5B1NyutJRCsCKepC4F/69l26YxYa8eNL3DVYUU8jUDwKFiJXjX
 PB7YfR4GwgP5BBeAnCHDpHA0FeRNdTSFGe8jgvekwHjL6dp7W7TM1nLSYexASJF7R8Cr
 zR82PIsFGSL3uc8IAxhe8mX7kBpP7dVqlfaE1cAtUL7SDrNDkKIMaMG79D0F4gREgzCP
 yae+6vmhCFkUwhCdBnDTXmFp+H61ILzUtFN5a2BcdR7lfNF9vmYiEsAFkuw6p8tl2aME
 le6WWCfZUiMQJ0TszA96Ermc0ggt8uQ1s3SagLB++HLRJx69Vy64jwcIWVugiUezBqqB
 5x3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779263987; x=1779868787;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LH/BXLlF6AH1KnQEODR72O/Iuej85LovWVNKwFOfqbE=;
 b=flPUCPSDULu7txHHlpNb34KROWqXw4sFYmtZPOX62vomMlf1HxH3IO83qB41yqVo6f
 NrXLJLXRgg4yQp/abqzmqbp3veZwP+uVtMVhfvEqxopzmXA1r+5mfcFuE13OoqRsi3bo
 CxUk/orpCaWQ/BYRHBCTicYCi54iS38RvQAQ8JC01r0RhlcrLv5TFr6GbwgYIhZ6TmSO
 W18E1MHc2sJ6zyrMHOFk9doYduicgBXlpqOd8dlb0JXlRsCKmTQlZVvGVHu0v5S5RDHn
 tvmnJCQIyEQ+gxcXcY+PxYMin1c9kX5dHBr7/icKQQRvDrhMhGYx6h6mQ3zb4Yb8Jzud
 64aw==
X-Gm-Message-State: AOJu0YwDxZbrw8pLhsKTyJDpslBijUzTmgU/KaLDhBivzmsXsxct2Bz/
 1wCxW5MpAtLLxSI6O6stqcB+Utb7PE8REVGxeiJfNG/OGTyrZb8cSU5OmESukQ==
X-Gm-Gg: Acq92OFX+rB7Kr/Y4VZk0bJ0Sm+2nGfBEQQxfRTrAzPufumYwSX11PL41FC7DBiq+/1
 C7DkahMU+8U0zcB/KkgSEvrSmYq0EkfyZRwi2w6OMEuesOgpZHMFrwEHzNDAvZeb1J56WgxUSYH
 PhHi2CCRQkio2yEEb+uwSlw8oEpJl1FzKodUrlLMCBVqSrgun3LtMpuaNiIuqBCXhpgOAPMXyEl
 nqScnmm4+nv+8p19F/312JWmX3NWezy0myxS5SiiajnVTUeOoa1vc5REbNQ5LeiaRpzzKi3Qt6m
 bEIYeBb5+8ei28j/6QovU5Us/8n/abPrKfPwGlcbgHG3zU9OXORjbI1ATONkju9ctBgLOD03/V8
 psBmwgGZE1vL7tmuerE3r/MFNHFDvqZ2bTMPrp8AMA1x3JWRZr4K1QTo6K393DSen/HigGQS9D1
 Rc7zDZ8fV6GZGMfEo5VxBjkNJ/mt/K
X-Received: by 2002:a17:902:a5c9:b0:2b0:7d3d:756a with SMTP id
 d9443c01a7336-2bd7e905aa3mr172634935ad.35.1779263986570; 
 Wed, 20 May 2026 00:59:46 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2bd5c05ffbesm216608435ad.27.2026.05.20.00.59.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 May 2026 00:59:46 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Cc: kwolf@redhat.com, hreitz@redhat.com, farosas@suse.de, lvivier@redhat.com,
 pbonzini@redhat.com, qemu-block@nongnu.org, jeuk20.kim@samsung.com,
 j-young.choi@samsung.com, jaemyung.lee@samsung.com
Subject: [PULL 0/5] ufs queue
Date: Wed, 20 May 2026 16:59:26 +0900
Message-ID: <cover.1779263628.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62d;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x62d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

From: Jeuk Kim <jeuk20.kim@samsung.com>

The following changes since commit e89049b3ba5f1f0468bc0d294173345597514a1b:

  Merge tag 'for-upstream' of https://repo.or.cz/qemu/kevin into staging (2026-05-19 15:23:10 -0400)

are available in the Git repository at:

  https://gitlab.com/jeuk20.kim/qemu.git tags/pull-ufs-20260520

for you to fetch changes up to f50738e34f5bf8d907cfdb8195fedc780341b99a:

  tests/qtest: Add UFS Write Booster QTest (2026-05-20 16:52:22 +0900)

----------------------------------------------------------------
Add write booster support to UFS devices

----------------------------------------------------------------
Jaemyung Lee (5):
      hw/ufs: Apply UFS 4.1 Specification
      hw/ufs: Modify flag handling operation
      hw/ufs: Add idle operation
      hw/ufs: Add UFS Write Booster Support
      tests/qtest: Add UFS Write Booster QTest

 hw/ufs/lu.c            | 102 ++++++-
 hw/ufs/ufs.c           | 711 ++++++++++++++++++++++++++++++++++++++++++++++---
 hw/ufs/ufs.h           |  49 ++++
 include/block/ufs.h    | 114 +++++++-
 tests/qtest/ufs-test.c | 177 ++++++++++++
 5 files changed, 1107 insertions(+), 46 deletions(-)

