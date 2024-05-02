Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FC23C4345F
	for <qemu-devel@archiver.kernel.org>; Thu,  2 May 2024 15:53:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s2Ykg-0000l8-6I; Thu, 02 May 2024 11:53:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2Ykd-0000kw-2T
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:53:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1s2Ykb-0002Jy-Ga
 for qemu-devel@nongnu.org; Thu, 02 May 2024 11:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714665216;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=n/L7WZ5CHIKopU4zqOsTMz8o56zSGHiLVboWpUfN+mg=;
 b=ShyUE1QgL44jUQYjNEVHs7sS1HFazpYshUYJ7K5lgPWQHqBbIKgjXQu15/OvBuppWsCEaS
 wE6CDjC865a86PY/UJekm6fKWEIZiXgA8oPyFxmwoejIlYZ+VoscVuM/UDtdKYRMhSYhsX
 gLLzohA6g1iQuKuoxmn+E5rgUl/20is=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-316-_dQFMQ00M16D7AeBHJ85qg-1; Thu, 02 May 2024 11:53:35 -0400
X-MC-Unique: _dQFMQ00M16D7AeBHJ85qg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a55a8c841e8so427508666b.2
 for <qemu-devel@nongnu.org>; Thu, 02 May 2024 08:53:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714665214; x=1715270014;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=n/L7WZ5CHIKopU4zqOsTMz8o56zSGHiLVboWpUfN+mg=;
 b=e+if/OcgklIJQ+FqbTbH9bZvmnYn4VIdtcyHxdDYZr87AdZIvUqTn/BTBWe/9if03J
 V3HZDBH6f0JWnUCsLS6lHpu3O/QlaA6LTgyeJN7lReMkDI1xVe41lF6FzFHOLsi7H/rW
 XtZRCVKgAx6PdgH+fTqujq6uaWBRbA7acoqaK8di0iRd7VROdz9ioHUuTkt3jV51Npjc
 kNEsoJG7bVJW/b1SMD6PzvUtqAeKHK7bs2enA47U+NfWaMaZ+t1rO40hN+n8oliVshf4
 rViAGfkStzA/gZwqNtHzvyKLRByB9oe1Oc4/Rqyyp3913ZGwMdAKFRepldoDI4AL3w30
 vO7Q==
X-Gm-Message-State: AOJu0Yy8MahbvtTQDJsreFGe63XNluftYZu76YpRwG5g9PbXNhCU2//i
 1EDAgP4GJlxeP6k9aMJhVnzH1N9tZrclI8oVLQ/binauT8qxQ62zLlR1g5VSkfw2mKNThqV7rRW
 yLQi4yYbKgGmAp5gl2m2S306QPCwkOvGD/hYgJd/EAm0+KnhOglOZliLVt5lLrP1z3sTRvv7JJv
 CqoSDl9z33z1QucqanBq1UiLBSsvw6STgRm0qO
X-Received: by 2002:a17:906:c789:b0:a58:f143:b4af with SMTP id
 cw9-20020a170906c78900b00a58f143b4afmr2206556ejb.60.1714665213921; 
 Thu, 02 May 2024 08:53:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFS4Hk0QuPT9BuJDzqTSU6It43xFTUjNytPhRxh1nPHdjlwf5gkHDOHGXU8GuIq0wAxifbSjw==
X-Received: by 2002:a17:906:c789:b0:a58:f143:b4af with SMTP id
 cw9-20020a170906c78900b00a58f143b4afmr2206537ejb.60.1714665213468; 
 Thu, 02 May 2024 08:53:33 -0700 (PDT)
Received: from avogadro.local ([151.95.155.52])
 by smtp.gmail.com with ESMTPSA id
 z3-20020a170906270300b00a55bb18e3d7sm684102ejc.168.2024.05.02.08.53.32
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 May 2024 08:53:33 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/13] remove some types from typedefs.h
Date: Thu,  2 May 2024 17:53:18 +0200
Message-ID: <20240502155331.109297-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.44.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.476,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The main reason for typedefs.h to exist is to avoid the need for
"struct Foo;" forward declarations of types that are needed in function
prototypes.  It avoids the infamous "struct declared inside parameter list
will not be visible outside of this definition or declaration" warning.
Another less common use is when the struct is used as a pointer in
another struct (when the struct is embedded by value, the typedef is
obviously not enough).

This series is a first pass removing unnecessary typedefs.  In most
cases, the users are actually already including it.  In a few patches
towards the end, new includes are introduced but not in files that
already "rebuild the world" when changed.

Personally, I think that in many cases the uses are so limited
(often they only appear only in the few non-qdev boards that are
left) that they could use forward declarations of structs.  I did
that for patch 12 (tcg) because there are already a couple of
forward declataions in include/hw/core/cpu.h, but that's more as
food for thought than anything else.

Paolo

Paolo Bonzini (13):
  fw_cfg: remove useless declarations from typedefs.h
  qdev-core: remove DeviceListener from typedefs.h
  numa: remove types from typedefs.h
  net: remove AnnounceTimer from typedefs.h
  qemu-option: remove QemuOpt from typedefs.h
  intc: remove PICCommonState from typedefs.h
  lockable: remove QemuLockable from typedefs.h
  migration: remove PostcopyDiscardState from typedefs.h
  monitor: remove MonitorDef from typedefs.h
  qapi/machine: remove types from typedefs.h
  display: remove GraphicHwOps from typedefs.h
  tcg: remove CPU* types from typedefs.h
  pci: remove some types from typedefs.h

 accel/tcg/tb-jmp-cache.h     |  4 ++--
 hw/display/vga_int.h         |  1 +
 include/hw/core/cpu.h        | 11 +++++++++--
 include/hw/intc/i8259.h      |  2 ++
 include/hw/nvram/fw_cfg.h    |  2 ++
 include/hw/pci/pcie.h        |  3 +++
 include/hw/pci/pcie_aer.h    | 38 ++++++++++++++++++------------------
 include/hw/pci/pcie_sriov.h  |  8 ++++----
 include/hw/qdev-core.h       |  1 +
 include/monitor/hmp-target.h | 11 +++++++----
 include/net/announce.h       |  4 ++--
 include/qemu/coroutine.h     |  4 ++--
 include/qemu/lockable.h      |  4 ++--
 include/qemu/option.h        |  2 ++
 include/qemu/typedefs.h      | 23 ----------------------
 include/sysemu/numa.h        |  8 ++++----
 migration/postcopy-ram.c     |  4 ++--
 stubs/target-monitor-defs.c  |  3 +--
 system/physmem.c             |  4 ++--
 19 files changed, 67 insertions(+), 70 deletions(-)

-- 
2.44.0


