Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77DC1606A31C
	for <qemu-devel@archiver.kernel.org>; Sat, 31 Oct 2026 16:41:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=J4Q044OQ
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xNC86-0001v8-LT; Sat, 31 Oct 2026 12:40:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xNC81-0001uJ-2s
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 12:40:25 -0400
Received: from mail-dl1-x1229.google.com ([2607:f8b0:4864:20::1229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <luoyonggang@gmail.com>)
 id 1xNC7z-0007gK-7T
 for qemu-devel@nongnu.org; Sat, 31 Oct 2026 12:40:24 -0400
Received: by mail-dl1-x1229.google.com with SMTP id
 a92af1059eb24-1a8cc11ac42so1456412c88.0
 for <qemu-devel@nongnu.org>; Sat, 31 Oct 2026 09:40:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793464821; x=1794069621; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=3MxWdUF6gAER2KJhpN8hg0/S6P1UR7mrCv6YS1nnebU=;
 b=J4Q044OQoQEb4IwsaBvKSlyx9fSnJzgbleMo3BoVhmEgy5h2lxFx/oXmS2DWBi8bAz
 wf7wZInxn4urMTYe0SDzSEnVoq+wvCYHT02hEYCE77RBOxeofdt/W5SEbmrqunz8qcTc
 6gfTgtiSamhCKmUNmnIGGMEiqtUgVlXZDwqdNTwUYIMF1LOW5Qp+JXvhdnwFFB/dTYFB
 nB2Ded28QVW2mZvIi/4GQnUhZ1fFlcF6hp1y1cGLf8do25RmDDC8q9ox+B6zRDxBnHQ5
 N9Z03JT96/hkgcYysTIUcxgw3wUPJhReg0rMe0uNcooanci5+SoLj8bx6031O+M8s7XJ
 QTCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793464821; x=1794069621;
 h=content-transfer-encoding:mime-version:content-type:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=3MxWdUF6gAER2KJhpN8hg0/S6P1UR7mrCv6YS1nnebU=;
 b=XWIT1xlN8fAZFtrH3H7Wn1HshWSsJv99KL1Ut2d9/uonJ9n6uG9rIlWLU9KdV6cdGT
 xhgb2frC+k8oZjnFq63YEe4OWTk6hk+a/abObniHD1YgIBaRSArUFT8gaoU+dPy9ztJZ
 +MTsY+BgWZFPlUUcOlLgwM3VVRJCTE0CgxP4lhomBElLnOuveIZct1G/36DmqlnXXEyb
 ZbShLYWc0Og7uPoZ6NsMyze4uid7/FXLQePkR3EjQc1uiTdnnIDl8Orp01c6MLMonegG
 57tt/GlOlnC6DjSJ0maH81MCUnNohmqNP5ll1kvRRppi6i1PlM6QMzTuGKFXAXBn9SiN
 69cw==
X-Gm-Message-State: AFq9FYJJIF6sI5aLqd4RWiZtMQ5cdiRcDshjXyzywFZVm/7nHTSzXxDf
 +D7OURt3bmCfCG4Vqf2h8pt5SF9pYc1IZJzCjRQ+MfEVwzBLAAf+c0q14OTY0EBX
X-Gm-Gg: AYBFou2/ZzbAXuRW/7UHsw7oh+CZOEZBhpmh6dpuiWB21A7rPYUfa/HwZT+n2MCRCh0
 29qjwXvR/EHjIuABmeNCES4OHVvcpbiOAAT4atKOAHZ6TQj9hGOfmYTS9R4LBbEAmL7NpfDGanV
 OH5i+2rH+e8IOLoHXccGm549IhPNcb6//URk7p5LB04wPYPmhDWGtRpvzgbP3Yw8QVMPQL4CRaq
 azHUr7KIu4LzntSweBvjQ/6uMghQeX7U0BU5LR4or92r6H3skeh52bSInhZav4rIHfYb/iZvxFK
 VKG6A7sWpeOXp5cT3mvXtGuOvNiFgo2D3fOpsPYYV4Jr6WQGYQRuEYxdVxKKaJhnGPsolPOXBMg
 1XWCVW98MamgFai74Q/BjIwTtVlw0NUOwsrL4zOQXHX7W4w3o7nCNYkUMPXvXQs0Y8egxheBwnl
 +XfEFnWgDyaMXn1mvqlm63DS7A6Anjsp4BESpjXV6mZe6dY3jnkhkIxu/jKASWEB67l/6xca31z
 CSorwro0Pow9NhZMyQm123jWaNFMSVyxjmy8ZJ7PB8oPh/AUKMZ9xSAgiwok7c5X0+x0wD04WZZ
 mTcKM5/nQvxoKevg0Mq1hSsWn7XvXQYlEwLTYn3cq4DtaiYYYyD1E3HgMW5D4cprr0rm6g==
X-Received: by 2002:a05:7022:f507:b0:190:d9bb:281f with SMTP id
 a92af1059eb24-1ac5e3225aamr7486890c88.18.1793464820625; 
 Sat, 31 Oct 2026 09:40:20 -0700 (PDT)
Received: from DESKTOP-Q716RM7 ([103.94.185.75])
 by smtp.googlemail.com with ESMTPSA id
 a92af1059eb24-1ac193b8179sm19574572c88.11.2026.10.31.09.40.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 31 Oct 2026 09:40:19 -0700 (PDT)
From: Yonggang Luo <luoyonggang@gmail.com>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Song Gao <17746591750@163.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Philippe Mathieu-Daude <philmd@mailo.com>,
 David Hildenbrand <david@kernel.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Fam Zheng <fam@euphon.net>, Max Filippov <jcmvbkbc@gmail.com>,
 qemu-s390x@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eric Farman <farman@linux.ibm.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Subject: [PATCH v2 00/12] qom: resolve type name conflicts,
 avoid target_info() in class_init or type_init
Date: Sun,  1 Nov 2026 00:39:55 +0800
Message-ID: <20261031164009.2048-1-luoyonggang@gmail.com>
X-Mailer: git-send-email 2.55.0.windows.3
Content-Type: text/plain; charset="utf-8"
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1229;
 envelope-from=luoyonggang@gmail.com; helo=mail-dl1-x1229.google.com
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

v1: https://lore.kernel.org/qemu-devel/20261028201557.2688-1-luoyonggang@gmail.com/

Changes v1 -> v2:

- Drop target_not_s390x() from target-info. v1 exported it for scsi-disk,
  virtio-blk-pci, and virtio-net-pci. Each file keeps a static copy
- Drop target_not_base_i386() from target-info. Keep target_base_i386(), and a
  static target_not_base_i386() in virtio-mem
- Split hw/xtensa/virt: select virt machine types with is_available out of the
  DEFINE_MACHINE expansion, so later only that small patch needs a revert

Yonggang Luo (12):
  target-info: add target_loongarch()
  hw/loongarch/virt: select virt machine types with is_available
  target-info: add target_xtensa()
  hw/xtensa: expand DEFINE_MACHINE in virt.c
  hw/xtensa/virt: select virt machine types with is_available
  target/arm: register separate max-v8 CPU types for arm and aarch64
  hw/scsi/scsi-disk: register s390x scsi-hd and scsi-cd variants
  hw/virtio/virtio-pci: pass is_available through
    VirtioPCIDeviceTypeInfo
  hw/virtio: register s390x virtio-blk-pci and virtio-net-pci variants
  target-info: add target_base_i386()
  hw/virtio/virtio-mem: register legacy-guest variant with is_available
  hw/microblaze: defer PetaLogix endianness default until init

 hw/loongarch/virt.c                      |  3 ++
 hw/microblaze/petalogix_s3adsp1800_mmu.c | 11 +++--
 hw/pci/pci.c                             | 13 +++---
 hw/scsi/scsi-disk.c                      | 48 +++++++++++++++++-----
 hw/virtio/virtio-blk-pci.c               | 27 +++++++++++-
 hw/virtio/virtio-mem.c                   | 52 +++++++++++++++---------
 hw/virtio/virtio-net-pci.c               | 27 +++++++++++-
 hw/virtio/virtio-pci.c                   |  4 ++
 hw/xtensa/virt.c                         | 20 ++++++++-
 include/hw/virtio/virtio-mem.h           |  2 +
 include/hw/virtio/virtio-pci.h           |  1 +
 include/qemu/target-info.h               | 21 ++++++++++
 target-info.c                            | 27 ++++++++++++
 target/arm/cpu.c                         |  1 +
 target/arm/cpu.h                         |  1 +
 target/arm/tcg/cpu-max-v8.c              | 16 ++++++--
 16 files changed, 225 insertions(+), 49 deletions(-)

-- 
2.55.0.windows.3


