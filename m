Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FCABE8B362
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 20:57:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnNSB-0006ac-5h; Tue, 03 Feb 2026 15:56:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vnNS9-0006aF-R5
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 15:56:53 -0500
Received: from mail-pl1-x634.google.com ([2607:f8b0:4864:20::634])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1vnNS8-0003TK-3L
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 15:56:53 -0500
Received: by mail-pl1-x634.google.com with SMTP id
 d9443c01a7336-2a12ed4d205so36924725ad.0
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 12:56:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770152210; x=1770757010; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BVknF5a/uqGugksB8n3LY3qgsXh7BR4rbqZuiggqEP4=;
 b=aS+wps6NRhmvnKz9dvcZWCfXEWBJF4B4sDjuv9eUml0x02Scp5/AXyVa17IMDT02iE
 EG+TaEO63dRRkalsvIEiUIqgcj9DMLuG5QgSKRxUPrkTjIdbVSTYX02Eq9CzxYjR4ZY6
 4YM5yFbQhsJ9vBR0Rvf87IKhgClEed4qSx+5E/jxUJJ8Zhe/jc2kYyNTJITq0Y9I+qcv
 WEiXmerroUJYcIBBnMMOnuHs8Z2SfzCVpzRZdSkFqsl/ZcPzXtTmO2d4hz/Fj3LGt+FW
 Htkj9EXqkWHKuNiUGDLVoDU7meepZO+uxbgxOyUQMgznl2cRxDCzeWWS3OKCW6DPBx3G
 y9Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770152210; x=1770757010;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BVknF5a/uqGugksB8n3LY3qgsXh7BR4rbqZuiggqEP4=;
 b=cC5xvrJ1OpaZ7oY++8BEKqsAZ/3Ez/T1CKC3vtsaHQgte1y+2rG8+nceAzYZWPn4Cq
 a/XTonNcgTtd3swOBPV5eCKa8BnN8R3nz9AjgwVOnQd2W4oatTob/OMaXpkYWUr8H/2H
 xPLqrqSrZuZ9aJSjHhIGyqNYLibX3ou5dtCw+NoadYh36hku6J5/NGcB/daZyiv2p0Yw
 8U6T3u1RxOIMBo5S4NqZlRpLF5VkkUz7TRhg316HWv9fIMfrlkV5NmWdCUUHBl1omnO3
 BJD1qu0fYyFDhQuZ1OkpyzYy79vmYoLpFk310ZoAbZhB7D6c8j3U9Y8MXEqAl1FENR2T
 gVTA==
X-Gm-Message-State: AOJu0YyuqC0UcrTC62Ixp0K4t9hkn3Ekf6yUnKpl9P2pczQAFKTAHkhV
 f/qap1P29K/b6RBpq4mbj3JL2FmOXroxOO/k66Y8etga7vfw3YErV4kSTvwImHp/5QBaJ2lgQHe
 8E79Vun4=
X-Gm-Gg: AZuq6aI8z0p7t/A+VrlXdqM4cA6InK7tutRN/8hCuk0HoW2uD122sDtupIKKqb6OdkE
 pgEUYPNlzgZpbi4OqYF6JNaWlLoAVRw8tc4rUSoT4OVxvLDUbREBGTW+Ph6OBK2KZHl01Ri16BI
 CLAGoXIIEG5G9WgV0eV7wz8cUPyw3lmwy7lHpCaw5g4v9hb7E4L6fF5Fi2FaC+1GPXhtLy/BoBs
 4AyMu1hWkpojYDRoWkv5vifRr7wrGR2GvVHhaEF5Za2OLIC6KNS9VVv5g/AlTEngBP+/U2DU7tW
 SnvU2QQHEJoq4YIGlbVdvWsE7eXP8FB3MvKgwJkDU0gOW82jgCqs7U4wvMBDaj+1+ERUGLC7wAt
 xdQ6XCl5drHuRoTY/5//X965U1VZ7wKleUu59IpucEmMBnNfPqsnEC/fFtC/SVzflviDBvGTEeo
 7Ux3rSlqe8my6tvDaDXdYgA6To+3Bbqq55Q0HazdS1Un0h6QI3CdvAE7BsbTAWaNIMl+GMCZPW3
 +c=
X-Received: by 2002:a17:902:f684:b0:2a0:acca:f3f0 with SMTP id
 d9443c01a7336-2a93400c9damr6583905ad.49.1770152210324; 
 Tue, 03 Feb 2026 12:56:50 -0800 (PST)
Received: from pc.taild8403c.ts.net (216-71-219-44.dyn.novuscom.net.
 [216.71.219.44]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a9338512f4sm3612875ad.9.2026.02.03.12.56.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 03 Feb 2026 12:56:49 -0800 (PST)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-ppc@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Subject: [PATCH v4 0/9] single-binary: hw/virtio
Date: Tue,  3 Feb 2026 12:56:28 -0800
Message-ID: <20260203205637.3109749-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::634;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x634.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This series eliminates target specifics in hw/virtio and replace them with
runtime functions where needed.

Performance has been measured with this automated fio benchmark, with
original instructions from Stefan [1].

$ git clone https://github.com/pbo-linaro/qemu-linux-stack -b x86_64_io_benchmark
$ cd qemu-linux-stack
$ ./build.sh
$ ./run.sh /path/to/qemu-system-x86_64

[1] https://lore.kernel.org/qemu-devel/20260202185233.GC405548@fedora/

Results are on 20 runs and expressed in kIOPS:
reference: mean=239.2 std_dev=3.48
with_series: mean=238.5 std_dev=3.46

Performance is on par, and within standard deviation.

v4
--

- Include Philippe patches computing once device endianness to skip runtime
  checks on every access.

Philippe Mathieu-Daudé (3):
  hw/virtio: Constify virtio_is_big_endian() argument
  hw/virtio: Introduce VirtIODevice::access_is_big_endian boolean field
  hw/virtio: Use VirtIODevice::access_is_big_endian field

Pierrick Bouvier (6):
  target-info: add target_base_ppc, target_ppc and target_ppc64
  include/hw/virtio/virtio-access.h: remove target specifics define
  include/hw/ppc/spapr: extract SPAPR_MAX_RAM_SLOTS in a new header
  hw/virtio/vhost-user: make compilation unit common
  hw/virtio/virtio-qmp: make compilation unit common
  hw/virtio/: make all compilation units common

 include/hw/ppc/spapr.h            |  8 +---
 include/hw/ppc/spapr_common.h     | 16 +++++++
 include/hw/virtio/virtio-access.h | 50 +++++++++++-----------
 include/hw/virtio/virtio.h        |  7 +++-
 include/qemu/target-info.h        | 21 ++++++++++
 hw/virtio/vhost-user.c            | 11 ++---
 hw/virtio/virtio-qmp.c            | 70 -------------------------------
 hw/virtio/virtio.c                |  5 ++-
 target-info.c                     | 21 ++++++++++
 hw/virtio/meson.build             | 17 ++++----
 10 files changed, 104 insertions(+), 122 deletions(-)
 create mode 100644 include/hw/ppc/spapr_common.h

-- 
2.47.3


