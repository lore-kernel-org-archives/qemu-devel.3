Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EE5C5472F
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2024 15:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1siyRl-0003TT-Da; Tue, 27 Aug 2024 11:49:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1siyRi-0003PH-G4
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 11:49:26 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1siyRf-0004mQ-3c
 for qemu-devel@nongnu.org; Tue, 27 Aug 2024 11:49:26 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-201ed196debso50170935ad.1
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2024 08:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724773761; x=1725378561;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=97YCITPaRVBrg+DRbtVmk2fZ82zyT5ON5h5vsaQsquY=;
 b=Md9m3AxOr4PRsrUbTBu8QRxd79hyw6LLyLKknlNZK6gVk5nu1xhEepQVvP7mHhgkyP
 m/rcwsQcKKdNNrU0LVBaLguhUDJQ1PGd9Of6mXAD9bogWWfeSMxKSsPequBdSA00bCan
 4HSNWd2Mfo4pWBpCLfqaCjr23KzghoxAMEC0JWYDc3xGZtXkmNSF36W5llzRLb9+hRc9
 lk85v0kCXZDW2HJciUuLh9p0aGgQM6Ga/JHIMaNU7EluOpwMwTvZhrAfX/MMFgmXgMYN
 UtqEuHlBljJoA9+O6TigxQTTKH2rVrOL1u+mrE3x93fRctDcZaI2tanlJD7yKJ2JKcjD
 z68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724773761; x=1725378561;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=97YCITPaRVBrg+DRbtVmk2fZ82zyT5ON5h5vsaQsquY=;
 b=u+vK1iqF1s+R/d/xAtWKFfSx9iatp7KV6G3IF3M+ovSn+8lsV+Gdz8tIcALRNoJvB+
 lQoqaKgtBBTWk+XZvXlHvIzUEWN7E3gJH5Bxzd0p7KxtCCZG1kfFSHJgAKUuzh7PunxV
 2qltbgTAFDgq7aaFaIiTe8xWyRLIyUMSI3AgKa3YsgtG/IiZ0z5PoPf5ma9ktg67i5mX
 yQT6ItkzQGM/syuVekpiG0eEPQV8WN0DZt933jOHOF8IFZZTpq2VVarRVsmnB1Oco6OZ
 QwvByO8b8rRIP9QBvx/o41njEM86c1lJ4OOkiPhK1JcatGir9Fw1vKgZEjK7ML5SWEbi
 dobA==
X-Gm-Message-State: AOJu0Yx8R5V9hkh7SDHwDo0knnB3cMAblOJ6zjkfWinarosZRr+zUbCr
 ZeCIfeGwaRLLPw91VKTvwP6EKP7e4WaSYmQvNqM4irStqfrHA9D/RBPOdmM8ZMR/Lyl89qF/BQC
 4
X-Google-Smtp-Source: AGHT+IElamTx+ywS3/W7GZI+BuFICBCjDyE3sgyMuh0XUZO3dOr4PjMNQSmAsdWJJbPk8MI2pz70WQ==
X-Received: by 2002:a17:90a:4d83:b0:2c9:5a85:f8dd with SMTP id
 98e67ed59e1d1-2d825809be8mr3599924a91.18.1724773760641; 
 Tue, 27 Aug 2024 08:49:20 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d5eb9037a2sm14624478a91.13.2024.08.27.08.49.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Aug 2024 08:49:20 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: qemu-devel@nongnu.org,
	jag.raman@oracle.com
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>, john.levon@nutanix.com,
 Thanos Makatos <thanos.makatos@nutanix.com>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v12 0/3] Support message-based DMA in vfio-user server
Date: Tue, 27 Aug 2024 08:48:58 -0700
Message-Id: <20240827154902.607926-1-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=mnissler@rivosinc.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This series adds basic support for message-based DMA in qemu's vfio-user
server. This is useful for cases where the client does not provide file
descriptors for accessing system memory via memory mappings. My motivating use
case is to hook up device models as PCIe endpoints to a hardware design. This
works by bridging the PCIe transaction layer to vfio-user, and the endpoint
does not access memory directly, but sends memory requests TLPs to the hardware
design in order to perform DMA.

Note that more work is needed to make message-based DMA work well: qemu
currently breaks down DMA accesses into chunks of size 8 bytes at maximum, each
of which will be handled in a separate vfio-user DMA request message. This is
quite terrible for large DMA accesses, such as when nvme reads and writes
page-sized blocks for example. Thus, I would like to improve qemu to be able to
perform larger accesses, at least for indirect memory regions. I have something
working locally, but since this will likely result in more involved surgery and
discussion, I am leaving this to be addressed in a separate patch.

Changes from v1:

* Address Stefan's review comments. In particular, enforce an allocation limit
  and don't drop the map client callbacks given that map requests can fail when
  hitting size limits.

* libvfio-user version bump now included in the series.

* Tested as well on big-endian s390x. This uncovered another byte order issue
  in vfio-user server code that I've included a fix for.

Changes from v2:

* Add a preparatory patch to make bounce buffering an AddressSpace-specific
  concept.

* The total buffer size limit parameter is now per AdressSpace and can be
  configured for PCIDevice via a property.

* Store a magic value in first bytes of bounce buffer struct as a best effort
  measure to detect invalid pointers in address_space_unmap.

Changes from v3:

* libvfio-user now supports twin-socket mode which uses separate sockets for
  client->server and server->client commands, respectively. This addresses the
  concurrent command bug triggered by server->client DMA access commands. See
  https://github.com/nutanix/libvfio-user/issues/279 for details.

* Add missing teardown code in do_address_space_destroy.

* Fix bounce buffer size bookkeeping race condition.

* Generate unmap notification callbacks unconditionally.

* Some cosmetic fixes.

Changes from v4:

* Fix accidentally dropped memory_region_unref, control flow restored to match
  previous code to simplify review.

* Some cosmetic fixes.

Changes from v5:

* Unregister indirect memory region in libvfio-user dma_unregister callback.

Changes from v6:

* Rebase, resolve straightforward merge conflict in system/dma-helpers.c

Changes from v7:

* Rebase (applied cleanly)

* Restore various Reviewed-by and Tested-by tags that I failed to carry
  forward (I double-checked that the patches haven't changed since the reviewed
  version)

Changes from v8:

* Rebase (clean)

* Change bounce buffer size accounting to use uint32_t so it works also on
  hosts that don't support uint64_t atomics, such as mipsel. As a consequence
  overflows are a real concern now, so switch to a cmpxchg loop for allocating
  bounce buffer space.

Changes from v9:

* Incorporate patch split and QEMU_MUTEX_GUARD change by philmd@linaro.org

* Use size_t instead of uint32_t for bounce buffer size accounting. The qdev
  property remains uint32_t though, so it has a consistent size regardless of
  host.

Changes from v10:

* Update the commit to uprev the libvfio-user subproject to the latest
  libvfio-user revision.

* Break out the "softmmu: Support concurrent bounce buffers" patch so this
  series only touches vfio-user code and can be picked up as is by Jag.

Changes from v11:

* Rebase (clean)

* Add a patch to fix DMA memory region reference leaks, which prevented
  vfio-user-server auto-shutdown from working.

Mattias Nissler (3):
  Update subprojects/libvfio-user
  vfio-user: Message-based DMA support
  vfio-user: Fix memory region reference accounting

 hw/remote/trace-events        |   2 +
 hw/remote/vfio-user-obj.c     | 108 +++++++++++++++++++++++++++++-----
 subprojects/libvfio-user.wrap |   2 +-
 3 files changed, 96 insertions(+), 16 deletions(-)

-- 
2.34.1


