Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F2BCC5CFDB
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 23:40:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtw4c-0004R4-IX; Tue, 11 Aug 2026 19:39:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3wLJ7agsKCm8aNZNaThYNgVTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--namangulati.bounces.google.com>)
 id 1wtw4b-0004Qw-Hm
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 19:39:57 -0400
Received: from mail-qv1-xf46.google.com ([2607:f8b0:4864:20::f46])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3wLJ7agsKCm8aNZNaThYNgVTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--namangulati.bounces.google.com>)
 id 1wtw4Z-000899-9p
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 19:39:56 -0400
Received: by mail-qv1-xf46.google.com with SMTP id
 6a1803df08f44-8eeba1d9e47so2593306d6.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 16:39:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=google.com; s=20251104; t=1786491585; x=1787096385; darn=nongnu.org;
 h=content-type:cc:to:from:subject:message-id:mime-version:date:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=rS+O/DdpsqESZeqth+coDUQ3kynDl4zMtrtTzrH+MuM=;
 b=tbDxG3fRv7I0XTK2IiowMZMp7wmK8UvBmLe1+RXin3MOWHFS9gqLGdPBY6jx7RWx+u
 VKzKJFwfrZkp4zV6hYovkpwNWhro2e7nMwqlL49R5Z3Osa3X5vnfU/FxiytDXPDv8Am6
 64IiLZxCLqjmX05Idsi+VXQWY1cnJv3P48YZMmZCCcXbxDr8TtslViQL5MJE81J+WvBS
 YiB9Mm8LErpvQdKhhGVsETpE6zRphyjA2+E/bONoCvexwb+9p0UaUdcAfXB4Omj6fmmF
 q4j29fBD4EoxDKatjjLm3+44oouUfL7CkTBB6NW0h7nlY2Dk45n504kiU+86vItXrX4U
 jXFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786491585; x=1787096385;
 h=content-type:cc:to:from:subject:message-id:mime-version:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=rS+O/DdpsqESZeqth+coDUQ3kynDl4zMtrtTzrH+MuM=;
 b=DRlyLlPnRwUXY1lHrJEGfTGoHyxJ1E2D1Mb4sSaZXigg0JKdURn/HRjPlO7U3GO6i7
 q90Rs8SImwy+g0JEBu1+JwpUuL/YwTuj6uSWPenehQMzr9LU2Wm+FxtBdbBnFOdtEUst
 WEqdJjXqjYxSPn5RFqmDWM0xI+nDDBIe0NM+0VzSIMDoNPIN2dBzcYUmIDlYO+c/yp13
 a8+wsI20Klbn30ZKp2GrI25LYia5mOPsaSa/z2LFlvFp8e1xGPB50k140YGpj3gUrN5E
 qFlen1Mu+DThod/Z6CPXrsAAPW8sdIGE2yBKBe5Wvb035pInZzoNm5FDDfosgs1w/d3f
 fyPA==
X-Gm-Message-State: AOJu0YwT/N8Gq4vZmsVi3QUb02+gYU85++BJxqfsxZLxIHBhZsTV8I0x
 1VGzyDg78rqRfFufAh/TVpD6wpHSzZKL6vosEm3JFRNRNfZWASBUdijw9+iFezfMOCjIGDq2Hnk
 AQ4IeoHNE72wtfUI9kFgo/t0bMikYMX5dfpXQK9pNAEt++rzkqXSBD30qq4BNT/nDPgVLU/HBuy
 shejuVblJzOAz2oeVXSyjqvRAVd9Ur0O6qfqpfptNALN3Dk5MeLv47brqOjoWK7Q==
X-Received: from qvbdd4.prod.google.com ([2002:ad4:5804:0:b0:907:87dd:3b61])
 (user=namangulati job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6214:1316:b0:8ef:b049:7e35 with SMTP id
 6a1803df08f44-90a700cd689mr7384776d6.31.1786491584333; 
 Tue, 11 Aug 2026 16:39:44 -0700 (PDT)
Date: Tue, 11 Aug 2026 23:39:27 +0000
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.679.g6767b8d81c-goog
Message-ID: <20260811233930.401797-1-namangulati@google.com>
Subject: [RFC PATCH 0/3] vfio-user: support multiple FDs backing region mmaps
From: Naman Gulati <namangulati@google.com>
To: qemu-devel@nongnu.org
Cc: John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 "=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=" <clg@redhat.com>,
 Alex Williamson <alex@shazbot.org>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Matt Evans <matt@ozlabs.org>, Naman Gulati <namangulati@google.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::f46;
 envelope-from=3wLJ7agsKCm8aNZNaThYNgVTbbTYR.PbZdRZh-QRiRYabaTah.beT@flex--namangulati.bounces.google.com;
 helo=mail-qv1-xf46.google.com
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

This series extends the vfio-user protocol specification to allow
servers to pass multiple file descriptors for different sparse memory
areas to be mmap'ed within a single device region.

This extension is intended for exposing paravirtualized PCI devices via
a vfio-user server that may have multiple unique sub-regions in a BAR
backed by some mmap'able buffers sourced from distinct file descriptors.

This change introduces a new capability:
  VFIO_REGION_INFO_CAP_SPARSE_MMAP_FDS

Unlike VFIO_REGION_INFO_CAP_SPARSE_MMAP (which maps all sparse areas
from a single open file descriptor), this new capability defines an
array of sparse mmap areas where each area contains an index into the
array of file descriptors.

When all sparse areas share a single file descriptor, servers may
continue to emit VFIO_REGION_INFO_CAP_SPARSE_MMAP and send exactly one
file descriptor in SCM_RIGHTS for backwards compatibility with older
clients.

The extensions in this series also lays the groundwork to make use of
the in-development series [1] extending vfio-pci to return distinct
dmabuf FDs for discrete regions of a device's BAR. A vfio-user server
may choose to return dmabuf FDs for various regions of a device's BAR to
map a vfio passthrough device into the guest, in order to retain control
of the device and be able to revoke mappings passed to the VM.


[1] https://lore.kernel.org/all/20260715174737.15287-1-matt@ozlabs.org

Naman Gulati (3):
  vfio-user: add multi-fd region mmap capability
  vfio: mmap sparse regions backed by multiple FDs
  vfio-user: implement client support for multi-fd region mmap

 docs/interop/vfio-user.rst    | 71 +++++++++++++++++++++++++++++++++--
 hw/vfio-user/device.c         | 63 +++++++++++++++++++++++++++++--
 hw/vfio-user/protocol.h       | 20 ++++++++++
 hw/vfio/device.c              | 50 ++++++++++++------------
 hw/vfio/region.c              | 41 ++++++++++++++++----
 hw/vfio/vfio-region.h         |  8 ++++
 include/hw/vfio/vfio-device.h | 29 ++++++++++++--
 7 files changed, 239 insertions(+), 43 deletions(-)

-- 
2.55.0.679.g6767b8d81c-goog


