Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1073C25B4F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 14:37:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4Lu8-0005fk-Mw; Tue, 07 May 2024 10:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s4Lu7-0005bf-9P
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:34:51 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s4Lu4-00020t-RN
 for qemu-devel@nongnu.org; Tue, 07 May 2024 10:34:51 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-2ac9b225a91so2257039a91.2
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 07:34:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715092487; x=1715697287;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=N9lce0NC9HpTSlgl9pTMa/7yKSf1SIgHpsULhFcY2u8=;
 b=SQfcpwue4oCGcuwVKAeV9DHm8DMFprNQtUrdiH+g+Lejxm8DmcmmJXQRT2+ON/l+hj
 E8kn7OenC4NQ5auHXQz6EK0G7sksoq/vjh5mktB/zsc2AH0LDiwH+b64vbZaYtofZ3id
 pShlWF4kpjs7IOSbJujZ9uqKOMigNe14sSllfA5CbL/KJWkINNQlsTy+dAXgB9nRhKzg
 OU3mh23zH7o0alQbi0ZqhRFrok715EJ7G0xl6UI/RF22u8S27c4BiOlan0QzIzd49xTE
 8XpxQDzZiiZKvQyNKLPJz/AqNYcnm7RLKv3DOhmp2cAKY2agQpq54olowbBdOAuPHpVE
 jPfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715092487; x=1715697287;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=N9lce0NC9HpTSlgl9pTMa/7yKSf1SIgHpsULhFcY2u8=;
 b=PDidejiATDmald7yki3PWkIDPbwTF5a5ZoCbuXFSjhDa2UHAuICDh5t2IH6vDg03qY
 Igg6sUfbdb9q3eCagrKhJT2wVY4KMJmq4mScCA0Q00hlz9nD01W4wuSG0OsqOmkXUo3C
 6Dpmahd8n4bQoHZl/PpmSFIiDCl7cniTBwacDMd39zP4x9Te25AD/QSgLD4mQB8cfTXt
 tgZAw2Ai14abY8TxoVXwl9YSXSNj/EPJvrp41axlg1RQ9Gj3SjTuEfWQ9akb+PmVJQPw
 4Lli4vDAETnCH/39YPdjiOHjZFm3d1GbQ6BzoXarCfotCPwrXvrsgDzapkSQIgv1ZYcu
 TMMw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXL+Uy99SA/FJOUeL7LtBHZ8RzIfc3cvYRTYPwg63NdGD52bjblp+AnX9NduHat0QbsYrvJyNCSKiNl3rBDkdlw4X88uEw=
X-Gm-Message-State: AOJu0YwngygmkPCZOY+v4d8D7eax/lyroaQj2Hf08aK/yOEQnSVLacgB
 nlnKcmndw6UiRokxdEKM6zkyM3hFdYa67roVM00OHR4EFdK2GAPy4zePVJJ7oD0=
X-Google-Smtp-Source: AGHT+IHtHPRuYK2Jo+m/XC2W+qpfy7P5/yzMBat3CM2zUzwJ85Rvuwn/8uZsFXxZ2tTx8V2O/cm+Bw==
X-Received: by 2002:a17:90a:b886:b0:2ae:346d:47cc with SMTP id
 o6-20020a17090ab88600b002ae346d47ccmr13138695pjr.38.1715092487024; 
 Tue, 07 May 2024 07:34:47 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 pq10-20020a17090b3d8a00b002af8056917csm11827206pjb.29.2024.05.07.07.34.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 07:34:46 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: jag.raman@oracle.com, peterx@redhat.com, stefanha@redhat.com,
 qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 john.levon@nutanix.com, David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v10 0/7] Support message-based DMA in vfio-user server
Date: Tue,  7 May 2024 07:34:24 -0700
Message-ID: <20240507143431.464382-1-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=mnissler@rivosinc.com; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

Mattias Nissler (6):
  system/physmem: Propagate AddressSpace to MapClient helpers
  system/physmem: Per-AddressSpace bounce buffering
  softmmu: Support concurrent bounce buffers
  Update subprojects/libvfio-user
  vfio-user: Message-based DMA support
  vfio-user: Fix config space access byte order

Philippe Mathieu-Daudé (1):
  system/physmem: Replace qemu_mutex_lock() calls with QEMU_LOCK_GUARD

 hw/pci/pci.c                  |   8 ++
 hw/remote/trace-events        |   2 +
 hw/remote/vfio-user-obj.c     | 104 ++++++++++++++++++++-----
 include/exec/cpu-common.h     |   2 -
 include/exec/memory.h         |  41 +++++++++-
 include/hw/pci/pci_device.h   |   3 +
 subprojects/libvfio-user.wrap |   2 +-
 system/dma-helpers.c          |   4 +-
 system/memory.c               |   8 ++
 system/physmem.c              | 140 ++++++++++++++++++----------------
 10 files changed, 225 insertions(+), 89 deletions(-)

-- 
2.43.2


