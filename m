Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7277C48BEF
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 19:28:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rb3rs-0000EK-QU; Fri, 16 Feb 2024 14:27:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <atp.exp@gmail.com>) id 1rb3rq-0000DX-W8
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 14:27:27 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <atp.exp@gmail.com>) id 1rb3ro-0003WU-BA
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 14:27:26 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-1dba177c596so10166855ad.0
 for <qemu-devel@nongnu.org>; Fri, 16 Feb 2024 11:27:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1708111641; x=1708716441; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bGcLFD79zKisa4D3IYdfxZfTxY3QFRVrmhdPpozYFeQ=;
 b=W5Bw58zvmAvNN0D+iR4/Z2xG5rfCjOdn/SUBBtY0Ni4/Hm1NVLwUBNjSRXVLOH/Knt
 aB0XZ3GgltCSgr6muLZcGdySHlqztZVpBFcd9mWzQ/lfshHCZGUOiPLuDRm0rLyH3BT8
 HjcychXDfq9MM53tv3scYWqaZRpTijHKOf+7THUtzwQRRjPCGgNJtObWC4zYPw4s84o3
 zCbLNVAC5DjTcuUleCA5GEdEGSVJEDVnFWkw29UwpkPOdQdgY5AdWl8FYwoC9mAcAiT6
 58Kfz5TitQ+AvMp5aGozQuxjPJs+eAmveXE0LVYZzjJdFHguFqMRGQKz5QMCIDAlkiJm
 1LOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708111641; x=1708716441;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bGcLFD79zKisa4D3IYdfxZfTxY3QFRVrmhdPpozYFeQ=;
 b=IAxxPM6/soE1Kz6jpmpoi/HdmbiYK9j8R6001BoSzFtCGC088LhYdMA/2tDAthOv/o
 iLVs8/bCcfQGKzlQ7TJVmi+w6YbrVIwoYtsJik7NxdDXJhCh2WJldwSY/NybbsgEuppn
 WR9Tt3ChVCyScFLDgtjuaXFXSlGC4+vDqZDrXCzfmdrKvbztxou0kX1Df4HeFxautmQu
 NokJfIn7BbWdd6TrKKBfn8RtfngvPZTgS6ygq3ZkyyUYC0APl+tPm5+Dp6qp7V+QWyvG
 9KCC69/wtFMOt1jQKr80NgGACg7BU5usASGk/R2yeehrv6QX2mIvKvrAhm5QocIHb9qd
 M/FA==
X-Gm-Message-State: AOJu0YzjGh5yIsgtHVOkeoh4ovUlvGMSLBYTszgAisrXGWgBrnRJcQmQ
 gMpmHCQxcGfCnp3530mH/ERFZKKji5rNkWQSIPxoCivTKfn7/P4m3MaRseEk7Ug=
X-Google-Smtp-Source: AGHT+IGYguLcZ9FJvIb1vnvPcNDS6ofB6I7Z5kYdGcKYk1gefPiLwltE5SEZP5jtNT0ZrSEKQGpCmg==
X-Received: by 2002:a17:902:e84e:b0:1d9:ec0a:52b4 with SMTP id
 t14-20020a170902e84e00b001d9ec0a52b4mr13065621plg.21.1708111641146; 
 Fri, 16 Feb 2024 11:27:21 -0800 (PST)
Received: from iuseotherswifi.notpua
 ([2401:4900:60d1:9963:e637:dcdd:1fbd:732a])
 by smtp.gmail.com with ESMTPSA id
 v9-20020a170902b7c900b001db7709b322sm202579plz.298.2024.02.16.11.27.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Feb 2024 11:27:20 -0800 (PST)
From: Abhiram Tilak <atp.exp@gmail.com>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, clg@kaod.org, david@gibson.dropbear.id.au,
 harshpb@linux.ibm.com, Abhiram Tilak <atp.exp@gmail.com>
Subject: [PATCH v2 0/2] Misc: Make watchdog devices using
 qemu_system_reset_request() use watchdog_perfom_action()
Date: Sat, 17 Feb 2024 00:56:11 +0530
Message-ID: <20240216192612.30838-2-atp.exp@gmail.com>
X-Mailer: git-send-email 2.42.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=atp.exp@gmail.com; helo=mail-pl1-x635.google.com
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

A few watchdog devices use qemu_system_reset_request(). This is not ideal since
behaviour of watchdog-expiry can't be changed by QMP using `watchdog_action`.
As stated in BiteSizedTasks wiki page, instead of using qemu_system_reset_request()
to reset when a watchdog timer expires, let watchdog_perform_action() decide
what to do.

v2:
 - Remove redundant comment in patch1 in m48t59.
 - Exclude patch 3 from patch series due to current call being more preferable.

Abhiram Tilak (2):
  misc: m48t59: replace qemu_system_reset_request() call with
    watchdog_perform_action()
  misc: pxa2xx_timer: replace qemu_system_reset_request() call with
    watchdog_perform_action()

 hw/rtc/m48t59.c         | 4 ++--
 hw/timer/pxa2xx_timer.c | 3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

-- 
2.42.1


