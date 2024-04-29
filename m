Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9039C19F4F
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 03:27:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1HeT-0002mF-64; Sun, 28 Apr 2024 23:26:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1s1HeP-0002ae-V9; Sun, 28 Apr 2024 23:25:57 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1s1HeO-0004Kw-1A; Sun, 28 Apr 2024 23:25:57 -0400
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-6eff9dc1821so3694928b3a.3; 
 Sun, 28 Apr 2024 20:25:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1714361153; x=1714965953; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=E5DEqy7JSpjY/FY+rrXGljVb60fEF7u+dwD2Q2W9tEY=;
 b=eZ+AzL6QJENVuLMHD50qVyPjBvAUhO/Z8TZZsg7t+xQmO6Ud+eVYyyT8bLyxrfcmzh
 gh1m7M4LRahPsSCW4QVzt13W2grhEUBPMMyAjCHEaeWy7ldqBTtwFay7c1JvtWYY0D/T
 eZwbE3wyqpnIctcwzxfxc2Xi+FE4svl+ct6k5dDXQc5dnerF5YwEB5JcbTGB7sD87v/a
 yPmtIM1hxITsgB0ON5X4HAcfYMb0b9G0kHbghnV8A4aBL6mcmvF9ZE3TbMjyXpHW94IV
 AzlRfN2Us5hQKDvn7XXusiFFc1C8ylSA9KUejOA7LEyDZMq3IjM4GpsIBPjgGDTCimq3
 sB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714361153; x=1714965953;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=E5DEqy7JSpjY/FY+rrXGljVb60fEF7u+dwD2Q2W9tEY=;
 b=V+zYjD3BufP4U/NjLzMkpTGeBYP1xtv38h0v3ntaRRuBtpTuWFl34EyZ6mgkpULNMr
 Rsx9MoP72q5o/ImqKTAACsrQWJBpQNXgonL+Q0FfPsJ/sY3ek03nMLxc3FZxYk3TaEq6
 SIYKfKliq8QF+gPUYqJ9CEt5aGs/gYLNodPdO/OPU775rGXiSVlihU4dAjGCxb88VyUM
 Ea/3Zk8itAlgP1bEV+lt4iWLP8Nv11r+qvsIf3sxhVTGAv+pm49meE3LXpeyAIC0Tnci
 /k2+dIX8iVA+CAe2LvgBjgruABF5MlzLXp11gn9VL2lidOepNBE1nTzpvBwQYRwWVIOg
 s5xA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWdTuUOc+2SbR0b6YEPm+N/uIeo4+zqeQuBI5bgfEaSPEl3800cU1Y8BtI9j+fRercLVwzblgd6NFKxYFpjFBJahpnu4Vg=
X-Gm-Message-State: AOJu0YwwOu+iSRiArbGfk6oQvMYtMKp4MouGm+Wcv8yxMfHB33bAfP6w
 msYjWpLh9AbuCRngMy4Mr94gr20wvIGfNQ9NEcVogZ+QFsPcDVWndgh7Fg==
X-Google-Smtp-Source: AGHT+IFvRK6AGRfpEg5bw2X6iacF1s3DzQ0iWLGKMWW+op7CkL/qjj/gvGOqvgIDRziJkNNjLToVwQ==
X-Received: by 2002:a05:6a00:a11:b0:6eb:3d37:ce7a with SMTP id
 p17-20020a056a000a1100b006eb3d37ce7amr7142716pfh.21.1714361152996; 
 Sun, 28 Apr 2024 20:25:52 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([210.223.46.112])
 by smtp.gmail.com with ESMTPSA id
 j9-20020a056a00130900b006eae2d9298esm18213121pfu.194.2024.04.28.20.25.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 28 Apr 2024 20:25:52 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org,
	stefanha@redhat.com
Cc: fam@euphon.net, pbonzini@redhat.com, qemu-block@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com, zheyuma97@gmail.com
Subject: [PULL 0/1] ufs queue
Date: Mon, 29 Apr 2024 12:25:37 +0900
Message-Id: <cover.1714360640.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pf1-x433.google.com
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

From: Jeuk Kim <jeuk20.kim@samsung.com>

The following changes since commit fd87be1dada5672f877e03c2ca8504458292c479:

  Merge tag 'accel-20240426' of https://github.com/philmd/qemu into staging (2024-04-26 15:28:13 -0700)

are available in the Git repository at:

  https://gitlab.com/jeuk20.kim/qemu.git tags/pull-ufs-20240429

for you to fetch changes up to f2c8aeb1afefcda92054c448b21fc59cdd99db30:

  hw/ufs: Fix buffer overflow bug (2024-04-29 12:13:35 +0900)

----------------------------------------------------------------
ufs queue

- Fix ufs sanitizer vulnerability

----------------------------------------------------------------
Jeuk Kim (1):
      hw/ufs: Fix buffer overflow bug

 hw/ufs/ufs.c | 8 ++++++++
 1 file changed, 8 insertions(+)

