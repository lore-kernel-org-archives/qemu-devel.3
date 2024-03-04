Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58B3AC5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 10:06:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh5D7-0007RI-D9; Mon, 04 Mar 2024 05:06:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1rh5D5-0007Qn-5y
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 05:06:15 -0500
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1rh5D3-0006GQ-2X
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 05:06:14 -0500
Received: by mail-pl1-x632.google.com with SMTP id
 d9443c01a7336-1dc96f64c10so38575975ad.1
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 02:06:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1709546771; x=1710151571;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YpI7khvGFBzear38hkXuyVFW0aOnBNJWFWhsqobX0vY=;
 b=AGtmw6iHUbAvq4tOCD5sZmK7FSrQV5PO17Q1L5Gjbq7HMh+EBIcJ8lTZzB7hq5AI2X
 2EZMunVDTDxz5VasrG351YxDAZR+Y7LpfQ0NMrFsLDZnCW5OWnStLRTrOdrWqsr9zjsk
 2bpsWyE5gYgoVoe+z9Crm2+KFGvfIsNZTszb53HYLzWm0ytm+K+/5oDekqsFeXcoBhDw
 ErrygaIMDIRHYs5CGe7Yx7EbdhKIYSx1QIyhHXJs0B8heNhEO5ewanhzu2S7pDdkxPyh
 MjESrU+SM/oQj84HVoYpRV+igX2HY3fvtnKh72g01jbKL9Em0fbD/t3BpruWYjOQ8D1F
 Y73Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709546771; x=1710151571;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=YpI7khvGFBzear38hkXuyVFW0aOnBNJWFWhsqobX0vY=;
 b=qG1GwkNY6TzRyAJ6EskYZ3uDXhd/9s+a+1mrkyH5jNR8sZJVKfoEzVpXWNijUQQmvi
 yXFfpjVW9w2JoxZHEyO4zrd3JJ4du7SrO/pUT4fc04vziW7bED2F94wDprssanvYYVRc
 bLf13nVIxXroZEQVVe4wgWzLWEfYTfFb79tAm0aaKU5iHIb5K1HbMMFF56/J66dA28A3
 AnEOcMMohH75ixWOCukA8bU3X1hitpIrV7pNIRQCkq+VSVOyZUM14yGj5hQOVw4Hlxyx
 EcB2aC45vGG1X1p8cWQpaEeyLiaGBRFaSF77o56RqCfOMDCYwOtd3MvuTprkei4GIHru
 BkGw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWy/5WTAjXL6iF6YwjnsS4QALem6nXmMMLKYoEXPpoRjyRJ7x4TAIpPmyERRW0ZEk+amdp/AL407TCB4i4WzbT9tT4pCfM=
X-Gm-Message-State: AOJu0YzF8ovDM6XkIpu0yBgPfQUOQqg7/M8+elaTHoBOJs/IC3r278zR
 TN/FQ+QAeuk4/ATEv/80YdLZglVHKuigjk53wrqxIkSv1n0IqsNBMvqUmVKeqIM=
X-Google-Smtp-Source: AGHT+IGlTS+Djn8LohnKboGKqLpStkvoSfqhXjCdglpEsXN4wNR3z30f2yreLeEDxGVi+hobGaBQig==
X-Received: by 2002:a17:903:2a86:b0:1db:d13d:6bf3 with SMTP id
 lv6-20020a1709032a8600b001dbd13d6bf3mr8982489plb.62.1709546770734; 
 Mon, 04 Mar 2024 02:06:10 -0800 (PST)
Received: from mnissler.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 y18-20020a170902e19200b001dc95e7e191sm8091570pla.298.2024.03.04.02.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 04 Mar 2024 02:06:10 -0800 (PST)
From: Mattias Nissler <mnissler@rivosinc.com>
To: stefanha@redhat.com, jag.raman@oracle.com, peterx@redhat.com,
 qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 john.levon@nutanix.com, David Hildenbrand <david@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v8 0/5] Support message-based DMA in vfio-user server
Date: Mon,  4 Mar 2024 02:05:49 -0800
Message-Id: <20240304100554.1143763-1-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::632;
 envelope-from=mnissler@rivosinc.com; helo=mail-pl1-x632.google.com
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
 system/physmem.c              | 141 ++++++++++++++++++----------------
 10 files changed, 226 insertions(+), 89 deletions(-)

-- 
2.34.1


