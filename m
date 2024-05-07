Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8F2BC10F1A
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2024 09:43:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s4HLF-0004Ii-5f; Tue, 07 May 2024 05:42:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s4HLD-0004I2-9I
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:42:31 -0400
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1s4HL9-0007Pc-Gs
 for qemu-devel@nongnu.org; Tue, 07 May 2024 05:42:31 -0400
Received: by mail-pf1-x434.google.com with SMTP id
 d2e1a72fcca58-6f45020ac2cso2286235b3a.0
 for <qemu-devel@nongnu.org>; Tue, 07 May 2024 02:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1715074946; x=1715679746;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=GunWbuHn3ELCoV+IaCCFT9isaig+7LX+4N5SL4LnV/s=;
 b=fo03d4g96yIYlhv/pHQGXCAPsHTYcy0VAG+16f/GqrOg9lVI8JYYEDrFrUdpG0p7Jn
 de1ECwMC8xXulng+BXmZJdBQxIpJEpQtqnFLZ6UnhQyCzHECvyha2Zfh2m5NOlrMdIZm
 Ir9NRCyxV6MaZ+j3zdr5ENIbqfoR4i+ocCVoQtBfWCOnt/ah/dqPCfG24bgeb+S42m0v
 d5SSIL0CLhy6OUwApimTk4RTr+Oqe1qx6diObw0C9D0zgDmXFyBR37dPxbiBXjqro8Rf
 +UIU7HCmTEGByViLKWDZpH4+++OCv1rycnD/SYhRl5OuAbWTGBadULuVt41tHg38tvpu
 9Ghg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1715074946; x=1715679746;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=GunWbuHn3ELCoV+IaCCFT9isaig+7LX+4N5SL4LnV/s=;
 b=TYGR8PPaaRv15o0SIX/M6kVlxMCvmmwAgEeKqeQicsx8DNtN0Mi5uMpkt2WFYebrLk
 hGRJ20+QW5GAGeNyqIRWJpfPtasDTCCuJRqYqsc0Me73ZP7QZHm4d0DcJDaicdzH8Qu7
 HGN5lWQhLfgwVJuiuciC+lkQTfYMy8SK+pTKV2/IZWnSjrmOHObjZgBWtHVUFVacj6jI
 dzcdLi9NapPInJ++lfrLrOiJApLwKngcv/mTfN78+mvvVrZWSkFQkjOn8JPvHcXxQ2Az
 yBbFPyM1qWBedgjP7u2shklSh19vxeIb7ArOBuzQ/VX/f8CyQIUowdHb0dH+B6mWcBH6
 2zpA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjfMScd+KXT0OsJNwP0z/awdNm+C36wT1PxeNxg/gqKHJ2T7SAz33fqcTtxnnlMv2XEWzc3Cxd++EpNJqsbMtf6tmp/hI=
X-Gm-Message-State: AOJu0Yw7ufyqmbJK0j5Tiqm+09m73kv5MBeFkucvfRBv09iJHX7qwisp
 7cKAUA4mimZzGGrDhtpKoG1hlBXRDUHY7GzlDpDRVf/fN1OEH5Vy/sHzgqynIyM=
X-Google-Smtp-Source: AGHT+IGoq8I45eWv8MPsd3kUQzA7GC11oZyP8NtGfaXTQiLFCcB3K/smai51Cy1UOdcSnaD9Byz0mw==
X-Received: by 2002:a05:6a00:21cc:b0:6f4:74b5:f536 with SMTP id
 t12-20020a056a0021cc00b006f474b5f536mr6792415pfj.34.1715074945750; 
 Tue, 07 May 2024 02:42:25 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 p4-20020a62ab04000000b006f45257d3f7sm6434114pff.45.2024.05.07.02.42.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 May 2024 02:42:25 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: stefanha@redhat.com, qemu-devel@nongnu.org, peterx@redhat.com,
 jag.raman@oracle.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>, john.levon@nutanix.com,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v9 0/5] Support message-based DMA in vfio-user server
Date: Tue,  7 May 2024 02:42:04 -0700
Message-ID: <20240507094210.300566-1-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.43.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::434;
 envelope-from=mnissler@rivosinc.com; helo=mail-pf1-x434.google.com
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

Mattias Nissler (5):
  softmmu: Per-AddressSpace bounce buffering
  softmmu: Support concurrent bounce buffers
  Update subprojects/libvfio-user
  vfio-user: Message-based DMA support
  vfio-user: Fix config space access byte order

 hw/pci/pci.c                  |   8 ++
 hw/remote/trace-events        |   2 +
 hw/remote/vfio-user-obj.c     | 104 +++++++++++++++++++++----
 include/exec/cpu-common.h     |   2 -
 include/exec/memory.h         |  41 +++++++++-
 include/hw/pci/pci_device.h   |   3 +
 subprojects/libvfio-user.wrap |   2 +-
 system/dma-helpers.c          |   4 +-
 system/memory.c               |   8 ++
 system/physmem.c              | 143 ++++++++++++++++++----------------
 10 files changed, 228 insertions(+), 89 deletions(-)

-- 
2.43.2


