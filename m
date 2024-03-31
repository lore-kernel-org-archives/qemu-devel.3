Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED687CD128A
	for <qemu-devel@archiver.kernel.org>; Sun, 31 Mar 2024 19:31:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rr0tF-0000Hm-Hm; Sun, 31 Mar 2024 15:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1rr0tD-0000HD-Cm; Sun, 31 Mar 2024 15:30:47 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <minwoo.im.dev@gmail.com>)
 id 1rr0tB-0001Pm-Uh; Sun, 31 Mar 2024 15:30:47 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-6eaf7c97738so891601b3a.2; 
 Sun, 31 Mar 2024 12:30:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1711913443; x=1712518243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=TQmslNM5GGtrjWB8pIsj9VTguLDdJeZ7U/2WF+E8W10=;
 b=DaTfA8b/O7tAhTIOg07x5p/Y9/LbkCcze1zAbtudzjIUXMS5x/tnAIHUHNRyDH3LsO
 Pf/ici8dIgR9lQHty/Sv6QiktbmOsYOaOiT56vhuwR9Qx76QX60AynFYoXw8ZVhWg0D9
 XWiwcoK13xA+xfF8mbDThawK9kZAEEQWbR9SnTNRLGyXTj4EAkhTWZ0V2hoB1K7UGfiV
 iJWcA8Mg+5gdZazisT2olcUIqnaXPFSRPwvOOsvBmbh0HU2Mh9V5pm0/VdQrVv7NfnT7
 oBwCHtuTHBS7g8WBNEu7WM0gnOA+vB3NEcCA12m4VEvm753OGVuZQmGP5pyzjoRhneOd
 0ORw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711913443; x=1712518243;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TQmslNM5GGtrjWB8pIsj9VTguLDdJeZ7U/2WF+E8W10=;
 b=J34SFVOS9CP39sF4+9NcpnSO8Edc9GCpc8ACIGj0kD3liJ4ughA85Gcq8dRtgzoAh4
 qLjdxhcUYSdC5HtdNyrC3/R9gqGaBdKLSLwxkHKdloT/pYcG7c0HA23xn9ODQO2rVWkr
 Wq6E4jESBlIbRnH78Uo+NOjekoPI7U8wd9OZi8d3Q5WJWUPOOXXfUGzyKlSKqNqHN1tE
 jUV19Xxp+XiGXmy84Oekx3MWrJyEDBJ/uwW3rAHpKpds0ElZSSGDKNUS1nwBBywh0UMS
 VTmgcw2SRCbRlG8D5uXCnBAo5NAcWv0n+DuGFiQNr8vJ6eyZrNn8jnLndXmNYNIEs8FT
 pNpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSeQ5DVy1ojuRiDJYx7cVCwh6OqdSAyd/e9v7H7COoKdF70/dl0F2RVDOTjJe+ob2j+P9/io63jDmp5lo4d1rVFDLmiOU=
X-Gm-Message-State: AOJu0YwsnlnYZrPlJ7tfcQPSVFuAuI8Ff7ppcLbp9fOSLT3erJPd1yUm
 rW6RyCqH8FlBgKXxeXLOPLB0k/HmXnTREvCkCqXrisO/wslTBTYwY1L2Rddio6I=
X-Google-Smtp-Source: AGHT+IGfkDBGEpTUuOx2CaMOKIU/zGLnpycwK9NJHrvDhKMb9fTuFInXIUfZdSd9FE462RvEOQ7C+w==
X-Received: by 2002:a05:6a21:1693:b0:1a3:c3a9:53b7 with SMTP id
 np19-20020a056a21169300b001a3c3a953b7mr6508064pzb.55.1711913443462; 
 Sun, 31 Mar 2024 12:30:43 -0700 (PDT)
Received: from localhost ([116.121.76.56]) by smtp.gmail.com with ESMTPSA id
 j9-20020a170903024900b001e22e8a859asm5245525plh.108.2024.03.31.12.30.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 31 Mar 2024 12:30:43 -0700 (PDT)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: Klaus Jensen <its@irrelevant.dk>,
	Keith Busch <kbusch@kernel.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Minwoo Im <minwoo.im@samsung.com>, Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH v2 0/4] hw/nvme: FDP and SR-IOV enhancements
Date: Mon,  1 Apr 2024 04:30:28 +0900
Message-Id: <20240331193032.5186-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=minwoo.im.dev@gmail.com; helo=mail-pf1-x429.google.com
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

Hello,

This patch set added support for Identify Endurance Group List only just
for 'endgrpid=1' for FDP.  Along with this, the following three patches
are to support more than 127 secondary controllers for SR-IOV with VI/VQ
resources.  [2/4] separated Identify controller data structure for
secondary controller list from the actual secondary controller list
managed by the pf to support proper identify data based on the given
cntlid which is a minimum controller id to retrieve.  [3/4] and [4/4]
are actual patches increasing the number of resources of SR-IOV.

Thanks,

v2:
 - Added [2/4] commit to fix crash due to entry overflow

Minwoo Im (4):
  hw/nvme: add Identify Endurance Group List
  hw/nvme: separate identify data for sec. ctrl list
  hw/nvme: Support SR-IOV VFs more than 127
  hw/nvme: Expand VI/VQ resource to uint32

 hw/nvme/ctrl.c       | 53 +++++++++++++++++++++++++++++++-------------
 hw/nvme/nvme.h       | 20 +++++++++--------
 hw/nvme/subsys.c     |  8 +++----
 include/block/nvme.h |  1 +
 4 files changed, 53 insertions(+), 29 deletions(-)

-- 
2.34.1


