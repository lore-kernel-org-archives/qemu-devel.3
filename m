Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B0DAD42BB5
	for <qemu-devel@archiver.kernel.org>; Tue, 12 Nov 2024 17:38:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAupf-0003Kl-Lw; Tue, 12 Nov 2024 12:37:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rakicaleksandar1999@gmail.com>)
 id 1tAtyK-0000L4-Cl
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 11:42:32 -0500
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <rakicaleksandar1999@gmail.com>)
 id 1tAtyG-0007Mz-Dt
 for qemu-devel@nongnu.org; Tue, 12 Nov 2024 11:42:29 -0500
Received: by mail-ed1-x52f.google.com with SMTP id
 4fb4d7f45d1cf-5c942ef8d83so461994a12.0
 for <qemu-devel@nongnu.org>; Tue, 12 Nov 2024 08:42:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1731429745; x=1732034545; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=JXB2/poZUeRzcA7p/fWaPJMSrgjm81eiPi6dt0s/bBo=;
 b=Cn2x/eRUUl8cKOB0KE4tc3yVNtRg6K11nHjQLLZUzrBiIGe4JIb84bhq/yC3UUGAgo
 KtAr8Y69Bn2ssaAWOlKTixWYqZvO8EhZcTTixsy/aJCPC/IqyMiM+TS3J0gJjUdwIely
 mJj6ZitYoUDXNPGLgVEt1Zmq1zQ5v4Dzk67qpxVqkecGXQyAwcCR91vbYOdP24ARdguA
 k6iSsTniiCYLVDQF1MEgQnaEyZo3EdXr/GtRaBQAooQY4V+MySf7m70/2gtKZcwIsUln
 8vvDDF+MW2RodlXZHyvfBqM0rtACKt1RE5xVfK643E/IWTB7NbuCMFCNMkjglNH71XjA
 GKcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731429745; x=1732034545;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=JXB2/poZUeRzcA7p/fWaPJMSrgjm81eiPi6dt0s/bBo=;
 b=lJdok0tszEBva9I7xzpMSmfd8sOGP3fcgmj0BBvtDXFTH23lGHA6hLtKdmTxCTMDIP
 W/0DUvYCYw0JYajchSpvaVL0b3ktv2hzFS9hSvSP6kTXwvieA/rb8uS56cG/91jPUTX3
 /go2YhtVEr2J8DeqM9SZyTSYaMm/Rq0ArmnSIBvPbslaNAPneX4dKlA9mVEVvJXuSPNp
 RCrJSA5rju+fH9RPYrWsxhYA4eOQW8SHhe8L7DHNY2OpQCjG3AIR4G1l6dtIor8DBszZ
 Z1g7UbxevVqZt0H6R6wBWO62NDid0bo6GmSNC/RoMFWZN32MflAYluRHzs4ODkTq2SUW
 ihow==
X-Gm-Message-State: AOJu0YzYT4UmIknpt4/Hz29FsfytKVOGK6usSH/CzeXlNIvPJqAnjJmY
 gG+6YayTF/od98dkPuTdBLhTpJjFvauzGcXKnKrnFoTxbdV/vNp+I1H2uZqe
X-Google-Smtp-Source: AGHT+IF6jFBnszqYBHBIk8ttZ71mJl/sRyn6yN4dU2HEB3eAH7TqXFzPcjKxyd2JmHv2XaeOynwMMQ==
X-Received: by 2002:a05:6402:3595:b0:5cf:3d18:7b92 with SMTP id
 4fb4d7f45d1cf-5cf3d187bb4mr2401771a12.0.1731429744279; 
 Tue, 12 Nov 2024 08:42:24 -0800 (PST)
Received: from L-H2N0CV05D839062.. ([193.104.68.137])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-5cf03c8130dsm6137004a12.88.2024.11.12.08.42.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 Nov 2024 08:42:23 -0800 (PST)
From: Aleksandar Rakic <rakicaleksandar1999@gmail.com>
X-Google-Original-From: Aleksandar Rakic <aleksandar.rakic@htecgroup.com>
To: qemu-devel@nongnu.org
Cc: aleksandar.rakic@htecgroup.com, djordje.todorovic@htecgroup.com,
 cfu@mips.com, arikalo@gmail.com, peter.maydell@linaro.org,
 philmd@linaro.org, aurelien@aurel32.net, jiaxun.yang@flygoat.com,
 kwolf@redhat.com, hreitz@redhat.com, pbonzini@redhat.com,
 alex.bennee@linaro.org, pierrick.bouvier@linaro.org, berrange@redhat.com
Subject: [PATCH v3 0/4] Improve Mips target
Date: Tue, 12 Nov 2024 17:41:25 +0100
Message-Id: <20241112164130.2396737-1-aleksandar.rakic@htecgroup.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::52f;
 envelope-from=rakicaleksandar1999@gmail.com; helo=mail-ed1-x52f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Tue, 12 Nov 2024 12:37:37 -0500
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

This patch series adds support for emulation of CRC32 instructions for
the Mips target in QEMU, skips NaN mode check for soft-float, adds a CLI
flag for enabling an MSA feature, and enables the MSA for
MIPS64R2-generic.

There aren't tests for these improvements.

The patch 1/8 "Add CP0 MemoryMapID register implementation" from v2 has
been dropped from v3 since it has been accepted and integrated into the
master branch.

The patch 3/8 "GTM19-448: Fix script to work without realpath" from v2
will be sent separately as it is a fix to a general bug and is intended
for other maintainers.

The patch 5/8 "Add micromips to P5600" from v2 has been dropped from v3
since the latest document for P5600 with eventually updated field
CP0_Config3_ISA that would support microMIPS hasn't been found.

The patch 6/8 "Revert use of clock_gettime for benchmarking" from v2 has
been dropped from v3 because it seems that clock_gettime and
CLOCK_MONOTONIC exist in MinGW headers and that QEMU builds with MinGW.

The patch 7/8 "target/mips: Enable MSA ASE for mips32r6-generic" from v2
has been dropped from v3 since it has been accepted and integrated into
the master branch.

When it comes to the patch 8/8 "target/mips: Enable MSA ASE for
mips64R2-generic" from v2, the cpu Loongson-3A4000 supports both
mips64r2 and the MSA, so I'm not sure whether to drop this patch.

Regarding the DSPRAM for I6500, I heard that the IP for the DSPRAM for
mips64r6 hasn't been published, but in the document "MIPS64® I6500
Multiprocessing System Programmer’s Guide" the DSPRAM is elaborated, so
I don't know whether to add support for the DSPRAM.

Most of the following patches are cherry-picked from the branch
mips_rel/4_1_0/master on the MIPS' repository:
https://github.com/MIPS/gnutools-qemu/
Further details on individual changes are included in the respective
patches. An instance of a pipeline of QEMU CI jobs run with input
variable QEMU_CI=1 for this patch series is available here:
https://gitlab.com/rakicaleksandar1999/qemu/-/pipelines/1533819034
and for the master branch is available here:
https://gitlab.com/rakicaleksandar1999/qemu/-/pipelines/1533465414

We are open for a discussion.

