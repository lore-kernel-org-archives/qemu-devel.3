Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E614BE98DF3
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Feb 2026 07:45:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuQcs-0007eJ-D3; Mon, 23 Feb 2026 02:45:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <6yearold@gmail.com>)
 id 1vuQcq-0007dF-KA
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 02:45:04 -0500
Received: from mail-yw1-f170.google.com ([209.85.128.170])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <6yearold@gmail.com>)
 id 1vuQco-00018e-O7
 for qemu-devel@nongnu.org; Mon, 23 Feb 2026 02:45:04 -0500
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-794fe16d032so32371507b3.3
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 23:45:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771832701; x=1772437501;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=DJ2+OVj1ZawNpTPQ1piAlprYajeEvhlVZNkb5SuvurI=;
 b=M2r7oPHg+C6x2uSoJAwN9fSa8AYKQp9oUNFoZ2Y7TdTO9vw977gAkD1tpz0UOQ8bnW
 3LqrgwaSOy6kBuPzkIvCmjAOxfqVZkGoIZmvPyoRrqhevnQmIRfe0PTIRdbk216gx3oN
 h8R6V2ZSKm9ivh+enF3Ry77GZUJ8C/w2JSUggfCU9/Bm5Uw/TJjOYX7uCOOVUyIJg18s
 D8RwJyH9FVrC9Ja4jMW80dvBhpvDhQSP8EPB3x8cLJH82lJ0rDMuegkAPNfyPJCX5GBr
 spxQ4KilsqGixfJs120qaqiSyED9XzWluzLqk3s9cd6H7sNSy+N2MC4mmR4Xtk/m0sPf
 nygg==
X-Gm-Message-State: AOJu0YwTjXDktF1xqbuZyqqNP5bCMulHcgjOMzQwFb7jSwIFEfHAYGow
 1XZ2l+gW3fdQgzyCaVMdheFYowkOn0XKbzRCb7un6BRQcOdsW/Uom6BvqFJBXjFK
X-Gm-Gg: ATEYQzx3Ojb+9KDhIR+12rU4mB0bLy+TLPn3aQ38QyxeQeBzDNNjYjkTWIJPMz2V0+4
 IK/0PEhBAyk+sA3cs2Y6/OzuN82qn5P1hzJ8l67rSZ4px894h4jb3Qq4C6B/YpHwZCPU0i0wSFO
 XUzIDebsB8ScF5bFhC8cgg8Z3P1rdqUOB0napbbDiXecJckF4rCWoaNZEG+SbB+VYip1wNNl1Fc
 qlsYo8fcBr2j/YKkFa+/qLlYItZtMJqAKo41NM0nr2ZEClKvqGG1mtzOGHRDsqc5cB8EBAFcDAU
 8Ayup4gVHQuWpgGRaQq9sB59XddXW5+sEl9pkIU3aco9Ix0XPiDNTbTQeXt184kPOpvP1ip5840
 l+WRFfFglRFn+8KTTz/veMx6BvlX5eOQ0AklQk8Dy8xCL1BcWwtjBK+ixet6Hgo6vT9Tu70rgal
 tCfVcGM2sn99rpeeI79sibAEWlBGAblob1dLOKxiAIalf4QH1sJC/YsbrCUUSO9pU+nMsmGcnbl
 0wAiKlzXreyMge3S4pTdULPN0j/gWsoOTjJzupvSuGJfsb23ZMPN2a4KI85kfEUjjoKPc0grg6A
 WqzuAss=
X-Received: by 2002:a05:690c:9d:b0:798:25b:3694 with SMTP id
 00721157ae682-79828ef10d7mr63614827b3.1.1771832701107; 
 Sun, 22 Feb 2026 23:45:01 -0800 (PST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com.
 [209.85.128.170]) by smtp.gmail.com with ESMTPSA id
 00721157ae682-7982ddccc24sm29102927b3.40.2026.02.22.23.45.00
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 22 Feb 2026 23:45:00 -0800 (PST)
Received: by mail-yw1-f170.google.com with SMTP id
 00721157ae682-79802e2c989so34031857b3.2
 for <qemu-devel@nongnu.org>; Sun, 22 Feb 2026 23:45:00 -0800 (PST)
X-Received: by 2002:a05:690c:45c9:b0:797:ab23:9c70 with SMTP id
 00721157ae682-79828fe543bmr62822657b3.35.1771832700505; Sun, 22 Feb 2026
 23:45:00 -0800 (PST)
MIME-Version: 1.0
From: Gleb Popov <arrowd@freebsd.org>
Date: Mon, 23 Feb 2026 10:44:34 +0300
X-Gmail-Original-Message-ID: <CALH631=92UznqkD25FszdAAFdm_0GAvpM-m1qYW1yeyQ1Lm6Kg@mail.gmail.com>
X-Gm-Features: AaiRm52izz3XHGFH50GHFzRVnwBAFFvMyb605x4IjVaaeyOgDgXxVVKX9akjE4U
Message-ID: <CALH631=92UznqkD25FszdAAFdm_0GAvpM-m1qYW1yeyQ1Lm6Kg@mail.gmail.com>
Subject: Upstreaming of the Elbrus2000 architecture support
To: qemu-devel@nongnu.org
Cc: qemu@mcst.ru
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=209.85.128.170; envelope-from=6yearold@gmail.com;
 helo=mail-yw1-f170.google.com
X-Spam_score_int: 0
X-Spam_score: -0.1
X-Spam_bar: /
X-Spam_report: (-0.1 / 5.0 requ) BAYES_00=-1.9,
 FREEMAIL_FORGED_FROMDOMAIN=0.001, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=0.249, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.798,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.79, SPF_HELO_NONE=0.001,
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

Hello QEMU devs.

MCST, a company behind the Elbrus2000 (e2k) architecture has
open-sourced their QEMU fork that features e2k support [1]. I
volunteered to help them get their work merged upstream. I realize
that it might take a decent amount of time and labor, but I'm fully
committed to this. On the MCST part they dispatched a developer team
(CCed) to help in reviewing, answer questions and provide future code
maintenance once it gets merged.

So, if the whole idea sounds interesting to the QEMU community, what
would be our first steps?

[1] https://git.openelbrus.ru/mcst/qemu

