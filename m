Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F3FFC47DA9
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jan 2024 07:32:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUial-0001am-9Y; Tue, 30 Jan 2024 02:31:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUiah-0001aK-FN
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 02:31:32 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1rUiad-0001bB-Aa
 for qemu-devel@nongnu.org; Tue, 30 Jan 2024 02:31:30 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-40e7065b7bdso44306275e9.3
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 23:31:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706599885; x=1707204685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=30n6jaEjhAngIBes+KzGiKcIVpmNGpONO4vK0jA59Vk=;
 b=A7cStvu57PKEQMT2H26T7YgQ42ue4M9Isscw6AKK4I+zh/BLo7FPa5mPaEArmsHFwc
 CvW27Puw+aaC6NjgVTK0j9q0cs/U6Ff7LBiWsh+zGgxvLz6XKLSvoBi0gGq7lXnXWtjY
 5IHG2XhUeZU+QpDXXMlLArDSnnlfipTe003glqlxQ70y7sfnQArHMPea+nA5NGtbS92K
 1PG8z+fOISzF7s8jjgshtumfOiGm8CGq2xQ1CWXNtFkoSinz6PXRrZt6ZPpw9vjeED8f
 t8uyKs8u3M1dvUOpTHjN0bK7Tw+2dUBGbQqB3+5t/lbot1c0rwv6U2pd4INNyF6DE1BQ
 cjmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706599885; x=1707204685;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=30n6jaEjhAngIBes+KzGiKcIVpmNGpONO4vK0jA59Vk=;
 b=JXDv3pgimIIdSAYq3kbaxEcwDTOJqI0m9fr0cS0Y09U+mknoSCZcMuQ7kHtuYZIbUj
 FdR1cmNdRLt+HWs9N4NGX8zAbAwj5B4+q7/1KVmLXD6fEVdUyvlLmIM8NNVIoResv49+
 WgwblRUtkMTfRQWTMf7Xhcj+T6UVrtvM+I/yFOmtLuBxKLHGiUKUblIBfgnLlo38/0AS
 QuZPaQJsS4Aetl84oUIQV45NoZdSBOGmtBvbZNjrf38YeVGkcrgn4oyXQUZcvXNsu1lC
 XZVeEHzpLarWCfbABXyieuPdm4yNStnLCqImTYWxYiI9sREFb6cB4930p3v4qU9HaM0b
 7P0g==
X-Gm-Message-State: AOJu0YwUr2HPvhOGS1xJjeG7J4IJ9/r1JFm50YaHyb9R+jF02fp34Yf4
 vVrkh/7eBwt1LAUTAL4e1z6pWVrfLzG2haQV0mWo4bwUcmwj6uLzSrvRUL+V5nubYGZjPx+eevt
 CTrA=
X-Google-Smtp-Source: AGHT+IGaep6vaOZkcWKwaQvSERJYNU8R8vkmp9+GlnE0NaMi8F/t3uVvZEza+3n8HIFAG+/hvxLrpg==
X-Received: by 2002:a05:600c:3595:b0:40e:dbe3:ab8f with SMTP id
 p21-20020a05600c359500b0040edbe3ab8fmr776870wmq.25.1706599885270; 
 Mon, 29 Jan 2024 23:31:25 -0800 (PST)
Received: from localhost.localdomain (adsl-245.37.6.163.tellas.gr.
 [37.6.163.245]) by smtp.gmail.com with ESMTPSA id
 bj26-20020a0560001e1a00b0033ae6530969sm7174070wrb.85.2024.01.29.23.31.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 23:31:24 -0800 (PST)
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org,
	qemu-block@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v3 0/2] hw/block/block.c: improve confusing error
Date: Tue, 30 Jan 2024 09:30:30 +0200
Message-Id: <cover.1706598705.git.manos.pitsidianakis@linaro.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

In cases where a device tries to read more bytes than the block device
contains with the blk_check_size_and_read_all() function, the error is
vague: "device requires X bytes, block backend provides Y bytes".

This patch changes the errors of this function to include the block
backend name, the device id and device type name where appropriate.

Version 3:
- Changed phrasing "%s device with id='%s'" to "%s device '%s'" since
  second parameter might be either device id or device path.
    (thanks Stefan Hajnoczi <stefanha@redhat.com>)

Version 2:
- Assert dev is not NULL on qdev_get_human_name
    (thanks Phil Mathieu-Daudé <philmd@linaro.org>)

Manos Pitsidianakis (2):
  hw/core/qdev.c: add qdev_get_human_name()
  hw/block/block.c: improve confusing blk_check_size_and_read_all()
    error

 include/hw/block/block.h |  4 ++--
 include/hw/qdev-core.h   | 14 ++++++++++++++
 hw/block/block.c         | 25 +++++++++++++++----------
 hw/block/m25p80.c        |  3 ++-
 hw/block/pflash_cfi01.c  |  4 ++--
 hw/block/pflash_cfi02.c  |  2 +-
 hw/core/qdev.c           |  8 ++++++++
 7 files changed, 44 insertions(+), 16 deletions(-)

Range-diff against v2:
1:  5fb5879708 ! 1:  8b566bfced hw/core/qdev.c: add qdev_get_human_name()
    @@ Commit message
         Add a simple method to return some kind of human readable identifier for
         use in error messages.
     
    +    Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
         Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
     
      ## include/hw/qdev-core.h ##
2:  8e7eb17fbd ! 2:  7260eadff2 hw/block/block.c: improve confusing blk_check_size_and_read_all() error
    @@ hw/block/block.c: static int blk_pread_nonzeroes(BlockBackend *blk, hwaddr size,
     -                   "block backend provides %" PRIu64 " bytes",
     -                   size, blk_len);
     +        dev_id = qdev_get_human_name(dev);
    -+        error_setg(errp, "%s device with id='%s' requires %" HWADDR_PRIu
    ++        error_setg(errp, "%s device '%s' requires %" HWADDR_PRIu
     +                   " bytes, %s block backend provides %" PRIu64 " bytes",
     +                   object_get_typename(OBJECT(dev)), dev_id, size,
     +                   blk_name(blk), blk_len);
    @@ hw/block/block.c: bool blk_check_size_and_read_all(BlockBackend *blk, void *buf,
     -        error_setg_errno(errp, -ret, "can't read block backend");
     +        dev_id = qdev_get_human_name(dev);
     +        error_setg_errno(errp, -ret, "can't read %s block backend"
    -+                         "for %s device with id='%s'",
    ++                         " for %s device '%s'",
     +                         blk_name(blk), object_get_typename(OBJECT(dev)),
     +                         dev_id);
              return false;

base-commit: 11be70677c70fdccd452a3233653949b79e97908
-- 
γαῖα πυρί μιχθήτω


