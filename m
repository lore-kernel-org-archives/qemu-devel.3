Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2570CD37AC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 02:53:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMziI-0000o2-KD; Tue, 12 May 2026 22:52:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <emmanuelugwu121@gmail.com>)
 id 1wMziE-0000no-OU
 for qemu-devel@nongnu.org; Tue, 12 May 2026 22:52:42 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <emmanuelugwu121@gmail.com>)
 id 1wMziA-0006W9-32
 for qemu-devel@nongnu.org; Tue, 12 May 2026 22:52:42 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43d7645adbdso3349832f8f.1
 for <qemu-devel@nongnu.org>; Tue, 12 May 2026 19:52:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778640751; x=1779245551; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=PYqqC/oOePA+SO/KeJa+xYia8fjUXGk7OpZD5J3F/cw=;
 b=Lb1daY7q4g194ioTshorOJCTTHJq8RCXzwNFTSaKIuzmFyGNeusUohQparvPalEepk
 1XyG7LIbWBZ8iT2GeLWTmQ0mQwR/J34knWBf6r+6Hnd8YJNewDYwSIlkRmRFaKUFnrt+
 3xtGiYCdqCvi2HLJgyNMZobv10p5ZYh3zXpEzNcwByVQVAmNT641Bu1O1PAxEQC5nySm
 0BGpJkUJeX6mfIeqNUyFS57Zp6wopwWmixT9XXU49nkrRbArQL8R5S19gA8wmXe1Bo82
 wBHAu6/T1oyRoP+YonkuTKgX3SzPZXbpdpnTkhmMcr0eQ+dSMR45Sl8sU01lLjv/LneG
 dAsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778640751; x=1779245551;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PYqqC/oOePA+SO/KeJa+xYia8fjUXGk7OpZD5J3F/cw=;
 b=f61VY33xEgZ8+kSkpvXkpvuw56xLfsPPYHp2VMQtUknsr2M+8YMg6Sr57d7XTjcTq8
 8Ev5SmCs2dzsjOHWpIaL9VoERg1UuyQuftQRdRCgH/zr4iiARI7HEQUz0wwspS1AvpjV
 YzBsF0pOZbSZCnM29tijqoLqM8y9SWda0VsVCgA3pJhB355uBF/Pu3r8ZWYguWGmHoka
 N+qogD2WA2VxYWOBLxtSj224kU5LoCNYWNvWBOKJivIbZImV1BXR5xdT7eO0BGI6oqBX
 AfHZk+nN4YGKcpv//qCb3glqUvo/ZdoJakMn+l1YjUgoKALIzXkziTHlbsIiNwQ1Kcg4
 ODvw==
X-Gm-Message-State: AOJu0YwdjnewiCth6LUIIwAt9nCNbkJ/DSwki0huVAxZHpD67++3LfJa
 0GUH8vsnbs9uuPSPYKc9yjLMIKV26T97HN6qS/L7NBuhKj/9mUvQkpmgrxhB71YqrhNeig==
X-Gm-Gg: Acq92OHQXkM6EbUIKZ7jCZ5H32fAE+wzl0UKUuKWNvDwhanG7DfcoFLVPMaM7NeXhjD
 Vd9blo2gmC4kfvSPUA3p0jmdMuMCAYJ5uotahNM1CDFAZdmH+2perTISaOFBsW2kccfXbnHOqOB
 UtoE5T6GhspvoHDMqqtmPxZGoqsoYanbPQFXs7AmmtbwDQuNMzmty+cYjt/3m1YOMRPeji9fmaB
 OrMEIdquW+OMdzKaW8PuPstKDYB61MAhB2nUphsQQOEMekSypGYoGLoHcHQQAMoFHiZTxmoUOPH
 ytB6izQVqt4I7KyvAZyJiLotolYT69Y5Oet6umNAVwRhGbEbVJ5KqoycWQdtSFGFYm1X35Yibq4
 ShkFoi6gzH/awo0S5UkuUCBg7PldWv6FgFbSSsWbf7au//PZP8QKWWqSplz3ZXNLRfHkZ1Nd6Cv
 QXowfEcvi2LNwOfU5la4R9a/wgw9wADziHJmdGVg==
X-Received: by 2002:a05:6000:1841:b0:451:2157:6291 with SMTP id
 ffacd0b85a97d-45c5ad4b0e5mr1625479f8f.41.1778640750960; 
 Tue, 12 May 2026 19:52:30 -0700 (PDT)
Received: from fedora ([197.211.52.69]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45c7f27762csm1592380f8f.31.2026.05.12.19.52.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 19:52:29 -0700 (PDT)
From: kantnero <emmanuelugwu121@gmail.com>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, fam@euphon.net, deller@gmx.de,
 Emmanuel Ugwu <emmanuelugwu121@gmail.com>
Subject: [PATCH 0/1] hw/scsi: add initial SCSI tape device emulation
Date: Wed, 13 May 2026 03:44:53 +0100
Message-ID: <20260513024454.75840-1-emmanuelugwu121@gmail.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=emmanuelugwu121@gmail.com; helo=mail-wr1-x432.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL=0.141, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Emmanuel Ugwu <emmanuelugwu121@gmail.com>

This RFC adds the foundation for SCSI tape emulation in QEMU. 

This patch implements realize and unrealize only. SCSI command
handling will follow in subsequent patches.

Feedback needed on the overall structure.

Emmanuel Ugwu (1):
  hw/scsi: add initial SCSI tape device emulation

 hw/scsi/meson.build |   1 +
 hw/scsi/scsi-tape.c | 221 ++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 222 insertions(+)
 create mode 100644 hw/scsi/scsi-tape.c

-- 
2.54.0


