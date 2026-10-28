Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1BF606A31C
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2026 20:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=zIOhhslW
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMA4I-0004vh-GT; Wed, 28 Oct 2026 16:16:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMA4F-0004ut-UB
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:16:16 -0400
Received: from mail-dy1-x1336.google.com ([2607:f8b0:4864:20::1336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xMA4D-0002C3-1s
 for qemu-devel@nongnu.org; Wed, 28 Oct 2026 16:16:15 -0400
Received: by mail-dy1-x1336.google.com with SMTP id
 5a478bee46e88-35cd4e8bdbdso1646990eec.1
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2026 13:16:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793218570; x=1793823370; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=pwlfz+Y06nPj/X9BMLcwEjj0c0qHWsfGuPy/DPtVRRE=;
 b=zIOhhslWLAzPd8FlE1LdgaHO52kREfDMx2LSUGPwNWc25i7f95dZkYXW4FBL/zFGg8
 rgFNPlNniXSovHH1VOEKc8FmeZff6L9OhaRtJEr9MShWzmDe/eFDSgY1l+PjTLUKeZx1
 nrYhXHEB2cvtUYEBOcw5dk3mKwdXG6hGYSIinYaK2Fg3qdQ5bydWOL/u17Aj0itEUAgo
 /V37LhtKDn0lXfFnH6yXS50hKwXYv7/QbzIT4YRBOFML+1inToMuLg+QmBXI0NF12GRL
 KpBJ9bSpy4smxjwrL+uihoq+sGBjkSbUUKCHnLriCeQ7D4FPepsGlCBmfPcYs5RTSkme
 y4lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793218570; x=1793823370;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=pwlfz+Y06nPj/X9BMLcwEjj0c0qHWsfGuPy/DPtVRRE=;
 b=NTOrLEQxKZnjcOk2hmym/XGf06QEYULcGEAKXdKenNITV+aQKA6VMFmHfuVo3bbb8o
 ZaXxhmA03pX2YyuKUv7JwV2F9SKTUwqk1TJ2uE4fCZMs+zUMWAupQCkh/Lo2j3JN+QSK
 7NPZt8k3rlqj1VSzLLlWHNompS8qzx8NVWtKx8QyJFhkwL1zkM3ckjaiASpgpbXn/w3w
 7PU6pb3mpXXHyrA4NjamTAcnRyECwaMHlKOh5nYDcFFB0+zuhSM1rNlcYNDDP/jy5w2m
 dPfzZxX9l1n5/p8LK7NUBcU5XIObUq1pPDdwXGA8gKUZQ3TyLI8OoofaDeTRmJpVT6rw
 wGVA==
X-Gm-Message-State: AFq9FYJbBWxjI8LTTIyI1dvU+xQWf5NnLYXbIsOh/UX6sLBzJrJCjjU0
 2daGoVlptjXSgO3cROQwCNW2icuL7m+24YMVDpH32q7718bb7O/0G74XZbJ3SuWC
X-Gm-Gg: AYBFou18XlMe8IPe6Vpyuw61DavCeU9mOgi8u2lxtfT2lANBddDNV2UK4J+KhExH8O/
 F9NoViXrJCMBlYl0rAxM2iN06FOZs5doMoNJ9vLiKs4kQhV1LPzso0Z1/zTHqnx0FEFWOSZGQmr
 lWlZSLn9STCvqoa91pCJJN2eO6xh2DR7S7korWFRtup9H2FwgT2UxMoU3kcgSkKI+NbETYWFVXk
 w202q6nv9rEUS5C0dVEZqe4wcoMEj+Ndj21abz2CHRpdEbVprRi+I3FdomdCOgn/JUYh9GBek/0
 4YU83NhzUE9Hni+oDCBOds/Pj7iar3mSlO4V4ComG5gSnthmHqO38dgHLqgng1Iuc+eMo7ZUtCA
 wvg5X1Un3bV+wU1MqLxNLz2xQlNdUL5r2DT+yKk39u0FNBekSUDJbWeB36SMYk8+E2lrkkinelr
 2o8DAMbdCw/ElAv8DGbKZka71uOnx3Id9Js9RR5czoD7vXNNqpUTV8fuMc28LXOyyD/W00NqNCw
 iGUhaO8iPEGpwpMzoZlnyUNWOEOf4aLYLjXGEPmKPklq/BnDMD7bannxKWIgmM2sXsG9hbzE4aV
 tNjgoDTK6/YrpMKNaPdcTIEyyMkDP1i+WD9sA/oYLX26WCKI
X-Received: by 2002:a05:693c:88da:10b0:36a:12c4:8bd6 with SMTP id
 5a478bee46e88-36a20108070mr4792753eec.22.1793218569611; 
 Wed, 28 Oct 2026 13:16:09 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 5a478bee46e88-36a23951e00sm12016896eec.20.2026.10.28.13.16.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Oct 2026 13:16:08 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 David Hildenbrand <david@kernel.org>, qemu-s390x@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Eric Farman <farman@linux.ibm.com>, Song Gao <17746591750@163.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Cornelia Huck <cohuck@redhat.com>,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>, qemu-arm@nongnu.org,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH 00/12] qom: resolve type name conflicts,
 avoid target_info() in class_init or type_init
Date: Thu, 29 Oct 2026 04:15:44 +0800
Message-ID: <20261028201557.2688-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1336;
 envelope-from=luoyonggang@gmail.com; helo=mail-dy1-x1336.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The goal is a single binary that links several targets, where every QOM type is
registered once for all of them. Types that share a name go into one bucket per
name, each variant tagged with the targets it serves, and the selected target
picks the variant at lookup time. For that to work, registering a type and
building its class must not depend on which target is selected.

Today some class_init and type_init functions call target_info(), directly or
through helpers such as target_s390x(). The result is fixed for the one target
selected when the class is built, so the other targets never get their own form
of that type.

max-v8 called target_aarch64() from its type_init to pick an instance
initializer. scsi-hd, scsi-cd, virtio-blk-pci, virtio-net-pci and virtio-mem
called target_s390x() or target_arch() from class_init to add properties. The
PetaLogix machine called target_big_endian() from class_init to set the default
endianness.

Instead, each target-specific form becomes its own TypeInfo under the same name.
Its is_available callback says which target it belongs to. Today QOM registers
only the one that matches; a bucket can later keep all of them. LoongArch and
Xtensa virt machines are handled the same way, since both share the virt-machine
name. PetaLogix keeps one type: its endianness default is "unspecified" until
the machine starts. A few target_*() helpers are added for the new callbacks.

Yonggang Luo (12):
  target-info: add target_loongarch()
  hw/loongarch/virt: select virt machine types with is_available
  target-info: add target_xtensa()
  hw/xtensa/virt: select virt machine types with is_available
  target/arm: register separate max-v8 CPU types for arm and aarch64
  target-info: add target_not_s390x()
  hw/scsi/scsi-disk: register s390x scsi-hd and scsi-cd variants
  hw/virtio/virtio-pci: pass is_available through
    VirtioPCIDeviceTypeInfo
  hw/virtio: register s390x virtio-blk-pci and virtio-net-pci variants
  target-info: add target_base_i386() and target_not_base_i386()
  hw/virtio/virtio-mem: register legacy-guest variant with is_available
  hw/microblaze: defer PetaLogix endianness default until init

 hw/loongarch/virt.c                      |  3 ++
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 11 ++++--
 hw/pci/pci.c                             | 13 +++----
 hw/scsi/scsi-disk.c                      | 43 +++++++++++++++++-----
 hw/virtio/virtio-blk-pci.c               | 22 ++++++++++-
 hw/virtio/virtio-mem.c                   | 47 ++++++++++++++----------
 hw/virtio/virtio-net-pci.c               | 22 ++++++++++-
 hw/virtio/virtio-pci.c                   |  4 ++
 hw/xtensa/virt.c                         | 21 ++++++++++-
 include/hw/virtio/virtio-mem.h           |  2 +
 include/hw/virtio/virtio-pci.h           |  1 +
 include/qemu/target-info.h               | 35 ++++++++++++++++++
 target-info.c                            | 37 +++++++++++++++++++
 target/arm/cpu.c                         |  1 +
 target/arm/cpu.h                         |  1 +
 target/arm/tcg/cpu-max-v8.c              | 16 ++++++--
 16 files changed, 231 insertions(+), 48 deletions(-)

-- 
2.55.0.windows.3


