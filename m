Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE122CD37BE
	for <qemu-devel@archiver.kernel.org>; Tue, 12 May 2026 04:44:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMext-0006Jj-AP; Tue, 12 May 2026 00:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wMexi-0006GX-Iw
 for qemu-devel@nongnu.org; Tue, 12 May 2026 00:43:20 -0400
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jeuk20.kim@gmail.com>)
 id 1wMexg-00074k-DP
 for qemu-devel@nongnu.org; Tue, 12 May 2026 00:43:17 -0400
Received: by mail-pl1-x629.google.com with SMTP id
 d9443c01a7336-2bcd730e090so11318575ad.2
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 21:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778560993; x=1779165793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=/XoPhzgBMtqRCg+BpClh5roTcSy97cWpZ4Tcnib1sGs=;
 b=feRGXyrJeanOStAfjSr0nVyai0d6VqSjc3XfpzV8xySTj0mpIpF48MYJUiHC6nvXwJ
 C4ci0xmZidbwGyLNcEjUMLCrPnjuvAGINpfmLxYr3w5K2ltbXOoM69sUL2A4SXOrK5Td
 ZikdxBm4/5qZ7P2GczIcPjUEciTmlAEr4Mn9pfOmuFnGVj24lldxrLu+K8pTo0okiw/g
 LxtJm/+U/81+4eSNmX+6zgQfEwWmqLgTLb2ZIi7g+aN6XDUwgjnDwIO4DxVnvwYjVKC7
 3CiPXUVSPhZTlKRvr2zRJbvw1HQ+5bs+8jsFDiSe9pY08QFSJBn6a6MiaDORGUYOMDN9
 u7FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778560993; x=1779165793;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/XoPhzgBMtqRCg+BpClh5roTcSy97cWpZ4Tcnib1sGs=;
 b=GJPzP8h3r3Tr86ANnxm1N14qebRu+18QhopnvK5MO4Zmb6S0WoJvVnkGziwK/6P78r
 wIucLKBcmHCD5V4xzQ7AcI5Q9lzGoSFnZlCXUJwYuTL9jCKgETTFpYr+VsX+97Q/Cb6E
 g8fwn1ytiBnO3F0hkvPMqRgcd2spq7RHuFZ6Wo0RTUIw4MOK1fST3lpDRIhRDO3jxIRt
 DqIgIS31jz1W+nSAUK6NRjMn29KB5buky8pEAALYtA33wY6sEtpEr0UkQFPOHkI+Bn2E
 I1a1UI1gRB6EiXCb5VE0hEyXFKp7K9djVmvQ0yQ+dycoitrfIzgABSY0dgaG2ch8E7D2
 Dzgw==
X-Gm-Message-State: AOJu0YwLuJ5wIXIaQPY51umNCvNhK4By5ZYk+TNacAov7WUlZmX+mkho
 k/OGGavc1HHdDO609mdeKBNDukuLC6tg77cu5av0XNndbXvKny9jo5XHtQDDqQ==
X-Gm-Gg: Acq92OFDlxK7JUNjBqyzkmEYVClR9/+hUrnsnLoBp4/Zv+9LmG0od8Q2ll7ZE3xB+Pj
 7EQQ+Paz4sNZBJcyZefyC46l6XOuJoRaIBrZZLQgzP604QwZgFCPGRLOMbEHcW9aen6fHYnRZfZ
 P0Ull7MTEi5In/wgr2KqZs+yQSiHQvf+6S9hdnC1nvRVNjdYXy+BAKIX9R5V2YyrJy/oz0vLIlm
 FFGDqlPlpyQXrJbMrIdMbtE7yDlxRSdJo4diMh6zPIAw/77ONLWiH+4U2Q7UJAUP8JctY/Wm6SU
 OhlkZPgIMZ+1w8ZcgWU8A1NEuHHxZymiqRgmXZImJZcOOTjGsn3IWtmZwz1ToDtrDzYaE6B44HJ
 WJ6SK6qU4rXxWesMvKO9XY1f8ARH3LcvvkFlI4fZ0LOg9Ga2tGer5YdYGOtwuvgwnNG1LNq92WB
 Fa/Y0luM6zAxliI+jPfLvEGVgYwUDB
X-Received: by 2002:a17:903:2ec7:b0:2bc:9110:8208 with SMTP id
 d9443c01a7336-2bc911088acmr109533495ad.40.1778560993329; 
 Mon, 11 May 2026 21:43:13 -0700 (PDT)
Received: from jeuk-MS-7D42.. ([211.226.54.223])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2baf1ebe7f1sm108938215ad.78.2026.05.11.21.43.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 21:43:12 -0700 (PDT)
From: Jeuk Kim <jeuk20.kim@gmail.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com, qemu-block@nongnu.org, qemu-stable@nongnu.org,
 jeuk20.kim@samsung.com, j-young.choi@samsung.com
Subject: [PULL 0/5] ufs queue
Date: Tue, 12 May 2026 13:42:50 +0900
Message-ID: <cover.1778560533.git.jeuk20.kim@samsung.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::629;
 envelope-from=jeuk20.kim@gmail.com; helo=mail-pl1-x629.google.com
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

The following changes since commit 5e61afe211e82a9af15a8794a0bd29bb574e953b:

  Merge tag 'ui-pull-request' of https://gitlab.com/marcandre.lureau/qemu into staging (2026-05-11 10:49:53 -0400)

are available in the Git repository at:

  https://gitlab.com/jeuk20.kim/qemu.git tags/pull-ufs-20260512-2

for you to fetch changes up to 042dbcff8382393b20b716294a6c4b1a4af6b3f1:

  hw/ufs: Zero reserved bytes in REPORT LUNS response header (2026-05-12 13:24:48 +0900)

----------------------------------------------------------------
ufs mcq bug fix:
- validate MCQ queue references before use
- reject zero-depth MCQ queues
- avoid deleting MCQ SQs while requests are still outstanding
- zero reserved bytes in REPORT LUNS response header

----------------------------------------------------------------
Jeuk Kim (5):
      hw/ufs: Validate MCQ SQ references before use
      hw/ufs: Guard MCQ CQ accesses against missing queues
      hw/ufs: Reject zero-depth MCQ queues
      hw/ufs: Keep MCQ SQs alive while requests are outstanding
      hw/ufs: Zero reserved bytes in REPORT LUNS response header

 hw/ufs/lu.c         |  4 +++
 hw/ufs/trace-events |  3 ++
 hw/ufs/ufs.c        | 92 ++++++++++++++++++++++++++++++++++++++++++++++-------
 hw/ufs/ufs.h        |  9 +++++-
 4 files changed, 96 insertions(+), 12 deletions(-)

