Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76847C3DA4A
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Aug 2024 14:04:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sg2zO-0003xq-GY; Mon, 19 Aug 2024 10:04:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1sg2zM-0003wt-S8
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 10:04:04 -0400
Received: from mail-pj1-x1036.google.com ([2607:f8b0:4864:20::1036])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1sg2zK-00072f-Ao
 for qemu-devel@nongnu.org; Mon, 19 Aug 2024 10:04:04 -0400
Received: by mail-pj1-x1036.google.com with SMTP id
 98e67ed59e1d1-2d3ec4bacc5so1865776a91.1
 for <qemu-devel@nongnu.org>; Mon, 19 Aug 2024 07:04:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1724076240; x=1724681040;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=5fNvbCwzZDF9oSzpaUCOvQ0VkkWUMlPUIBucQg5dEJA=;
 b=PkbJkgZyB+JGIArVOt0GwmWDe4SWXTEpSYjB5IweeqvWPM70AEt1ytBI9NoEw5wOQi
 tnMspSiP8eRRIdyh1sHlM33mpNi6gSlOZTdbKQiXIe2cCQRwuydXySihOs9VWdNIB/0f
 KSYGJD+6EpVR8jfZeRli8HmlbMlBsfLnvhz+Vz6owC1KF9F0CsJ0z3ZCslqlzlD4vfWm
 mg+AKb1tviJbgbF9ybtE0MaRONFSUSJxuSDqA7Hk3l1re89Jg01/R1gWfgFqBUKjzHDd
 3GMCBjUAl0167DW2GmWY8cpOFvrhcxoM2GT0qDtcSGFvqAYJRTS6rKFzCWE8U5hst4E6
 +yiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1724076240; x=1724681040;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5fNvbCwzZDF9oSzpaUCOvQ0VkkWUMlPUIBucQg5dEJA=;
 b=YbBYvF+qBjZhGPNwlJLFkaxkuUFlv1mxElnuSEyOlrOnmqbGBEyb/qfhw6b4lcbaSl
 W7vWtHE0OmOGlhk0kQ39+W281MsGXQCsoA8OFjwtWBCO4+xcZ/DNDRO0gqA9UDs4Wm1l
 VpPvJXpQVCsCQSj3aAQICnnjvmB7+4J45o47b7KbRiMAIAwY3Nh+Sgxr32dDQm0aE9el
 WZ78q2kPLgTO+22qYfqRUjPRDO+bmiFCM0zwD/nuIvBmHVPFqmKL+ZyuHTllZyzB6oMi
 1x2K9b3P++PwQP1WpMQnobMNUIw3eOjt9pcpoIcdRjojdLoauqmX32V1IGbxAo87K8fU
 dK6Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWokVqHPxx6uSxutXebEE3yigt3L3Qlq4m4et472DRmqqIUd4rg/p/J3AzpBE4XMIPyYw55WbjINtF6Zd6uDV3mvFMGl/o=
X-Gm-Message-State: AOJu0YwVTjMh+tHeELuy1xL+HA4oXBlCv3qsZUoS10Hyrva259calk8h
 USbRNsE381ya/ccEwjyTSrEcychJvMMFugLdl2t1HrhIRkCC1aUFm/bD14Ms1xo=
X-Google-Smtp-Source: AGHT+IHykJUvONMaygJNZHaDCDHqBbNZzjCOUTAvn47CmfPmYPZBKh93eNhpL+y1C1MGdnwmen+ewg==
X-Received: by 2002:a17:90b:2bc6:b0:2d3:ad41:4d7a with SMTP id
 98e67ed59e1d1-2d3e4539f85mr17222534a91.4.1724076239807; 
 Mon, 19 Aug 2024 07:03:59 -0700 (PDT)
Received: from mnissler.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2d3d0b3b6fcsm8341174a91.43.2024.08.19.07.03.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Aug 2024 07:03:59 -0700 (PDT)
From: Mattias Nissler <mnissler@rivosinc.com>
To: jag.raman@oracle.com,
	qemu-devel@nongnu.org
Cc: Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, john.levon@nutanix.com,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v11 0/2] Support message-based DMA in vfio-user server
Date: Mon, 19 Aug 2024 07:03:53 -0700
Message-Id: <20240819140355.2958821-1-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1036;
 envelope-from=mnissler@rivosinc.com; helo=mail-pj1-x1036.google.com
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

Mattias Nissler (2):
  Update subprojects/libvfio-user
  vfio-user: Message-based DMA support

 hw/remote/trace-events        |   2 +
 hw/remote/vfio-user-obj.c     | 100 +++++++++++++++++++++++++++++-----
 subprojects/libvfio-user.wrap |   2 +-
 3 files changed, 88 insertions(+), 16 deletions(-)

-- 
2.34.1


