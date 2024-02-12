Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DB7AC4829B
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Feb 2024 08:07:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rZRL1-0000ps-3O; Mon, 12 Feb 2024 03:06:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1rZRL0-0000pT-4L
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 03:06:50 -0500
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <mnissler@rivosinc.com>)
 id 1rZRKw-00080t-UF
 for qemu-devel@nongnu.org; Mon, 12 Feb 2024 03:06:49 -0500
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-5dbd519bde6so2228309a12.1
 for <qemu-devel@nongnu.org>; Mon, 12 Feb 2024 00:06:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=rivosinc-com.20230601.gappssmtp.com; s=20230601; t=1707725204; x=1708330004;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=AsQjm2prj0kXOgrRFlV8izjsBrg7vZkWIgmMOsSE9Uw=;
 b=iVKCOJEAuDOm5jfYG5g1Jp2+ZACsoaSPqN52krfo5tv/ll8BbsBe4uLWzsZipttbKg
 nFGstJkyi9uOqsXWuiyCKC/huDb2yDZhD4on6v2Ug40LYLtm6qr+NzGtLOu13SCqfRBm
 HUTzZUeMlb6fE3ffXixL2jlBNSN5+IQ1ZdnH2Qvi9uFeSXjieU0UWCVXNqCKJ3rpYiHA
 SGAoxj9Ja8pkATzIP8rxQtUfLajjwUre0zbRS9zmJ1DIE3k5DT7mF7Ntmj/bOHKVmuVF
 bZGJxWNsFkcROL/CD4xaPDJgwBS1gBw77tatJJqni3x81b4kKhkaTyAOV+ZZqKw3jJyn
 LgJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1707725204; x=1708330004;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=AsQjm2prj0kXOgrRFlV8izjsBrg7vZkWIgmMOsSE9Uw=;
 b=SYeKrGOKszxFRPkfiC5cNaLLWYwbzEKtHomguR91jU05CZ6Es+L5HU7f9jdQXLoIOa
 Vuok7+53Pgp3io+NOqjwIgCNGBbe4Lrye8LlL0hH/w7nb/BBhvZqEkq33UX5EdJ0vtQP
 qLAdrvx9q2NHtPuniYaLmfMM5hdMeamW8nrmQlco8GBI7DxbytVhYs0VcjlCiukTjeXH
 mVsp3z47DuSRSdF9obTGvKv9R/rfzFCJh7AnElmbC18xx7vB6ySW2YY86KtzaR+F1TWj
 FZBwGb2+5nKckVzigWr47KZm8VgdaL4ZTR+P+1RNXuBtO3CvaVSYm8RWH0Pcitb/dk1f
 t+1g==
X-Gm-Message-State: AOJu0YxXalTPUHOfx7ketc+HTcOlsmfEaOrlSTr8QvVrR4pkpzZ2JJht
 tz+u0OWwppTZ7qAN7ce0cCzNrNdcl27f0ktILQY0GY/Gochwxm8oDYjlFv/kIgysyVIBzRCn8qv
 g
X-Google-Smtp-Source: AGHT+IFTc/jYoezBOGhwY1AfRqfY7Jmws+LJ+7Yt91mNG3YlfC1ClEZzHBdqycixYF25JNaCPd5SJQ==
X-Received: by 2002:a05:6a20:d819:b0:19c:7e49:495a with SMTP id
 iv25-20020a056a20d81900b0019c7e49495amr4602366pzb.57.1707725203775; 
 Mon, 12 Feb 2024 00:06:43 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUwNF8PHo09ydcQd4o3HYjZvu33IckebIPgLFItO9xn3OZPkmBFAcGp7tOEUOUVaLXa284HNuXm+7u3KDw0laxWYYKRCvJFhbiXhQeadK+EETJVXYCCZ5F0EWqp43E2wZ6G5Ox1eWtYX+7thDE+ot/WxVIR8bHQmFEGvCuihAN4ZKVCZvOuoPj+mf1LqiekLrf86q9UdBHNyJ7kLUH2odVJjzXM9lnHl+PX1ytmAtPVksZ4pVhPlDnUCM0FdzjBNQm3K3YtXSTNLHHyRSEI8nXLNHISh3YbQFHQLfBuVSp3uZon9zS/YtsvLgLqKFIxRSvlAx+SrtM8XQivJ9yGibLwbnFZF1yt5SXZGITpc4M3WgXuRw6H/5UfCMCBJmBirg==
Received: from mnissler.ba.rivosinc.com ([64.71.180.162])
 by smtp.gmail.com with ESMTPSA id
 s13-20020a17090330cd00b001d9fc53514esm5404649plc.66.2024.02.12.00.06.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Feb 2024 00:06:43 -0800 (PST)
From: Mattias Nissler <mnissler@rivosinc.com>
To: qemu-devel@nongnu.org, jag.raman@oracle.com, peterx@redhat.com,
 stefanha@redhat.com
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 john.levon@nutanix.com, David Hildenbrand <david@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Mattias Nissler <mnissler@rivosinc.com>
Subject: [PATCH v7 0/5] Support message-based DMA in vfio-user server
Date: Mon, 12 Feb 2024 00:06:12 -0800
Message-Id: <20240212080617.2559498-1-mnissler@rivosinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=mnissler@rivosinc.com; helo=mail-pg1-x535.google.com
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


