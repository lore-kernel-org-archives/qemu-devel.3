Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0182FD172A6
	for <qemu-devel@archiver.kernel.org>; Sun,  1 Feb 2026 23:21:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmgjf-0004uR-H0; Sun, 01 Feb 2026 18:20:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgje-0004uI-PJ
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:20:06 -0500
Received: from mail-wr1-x42a.google.com ([2a00:1450:4864:20::42a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vmgjc-0008Q2-FG
 for qemu-devel@nongnu.org; Sun, 01 Feb 2026 18:20:06 -0500
Received: by mail-wr1-x42a.google.com with SMTP id
 ffacd0b85a97d-4359228b7c6so2648040f8f.2
 for <qemu-devel@nongnu.org>; Sun, 01 Feb 2026 15:20:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1769988002; x=1770592802; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=K4Ir3MRwT1Iy4H7GqGBhdLkfA1iGxDVTiDUbTJ45wgU=;
 b=oRts9CI90AvGA/NdIyspPkuK2JLPLt2ngryk+vjfwNydCb+n65RbWJSoZYuZjKS5hW
 92DqGMDxqirR4Zar5TFtP1KrJZPhMzjOrkBslNw3d9MjuN4lBBdm20ZocG6TUzAcHxHL
 Fb9moJXCjcalSDsLUBseS35FkG6jXTwvPWpMIeS4EDaRgSM8+aXxCoihDMao5GUDOwqn
 8nIDr1IDuiQDkJdE162MNyDn1+ZZfJ+F/gGEXm/b7ANgKBAhpBFv6y/TRLgXKAVr2rKt
 k522/E4sC0BqM4wlJFAcjN4diipLb0iff433sp2TMdTO5Ec2lrobSakhwewaakIc4LDw
 f3gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769988002; x=1770592802;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=K4Ir3MRwT1Iy4H7GqGBhdLkfA1iGxDVTiDUbTJ45wgU=;
 b=nGVb44uCWLhYfpH0neqgI4FIyb4pIu1HenDcSYSSqi17zVY4VJ/D7OPDrtBIOsRbUG
 iRAyykQTIoGH3vvudY1q9UoerjwVbS664NEAIwC1sLfoL0I4p8x46YH0MpRjX7S1GL1O
 yfQPetIPW1mTjLJuUqnCRYJrHLH8PGJJVGOy1WHNzz9sX+AIiw6v4khEO0Kok7IWEElc
 LR5od+kJXNvErNeAcdl3FDbDh19HMKDZr4jIlC1aCkkoZL2WD+alhOEkgLj7v44+IEGU
 ON0Pp/ibFmnIVP6+91x9Er75x2kFNjvqTcNsvutxlwhxu80DIhaYv5a/hNcBBRIFOoOR
 6xiA==
X-Gm-Message-State: AOJu0YzTVd6Yn/1mDMyVFMJiM6RDOxss7+UjHVWYSxgSU4653dnlAjY9
 jnHbGq0L+DLGDRH7WpGW548zYCTDuop5O48Lg/BgC3QxTfDkbkwtsUuuXXUcdtaW266L0GuVfy0
 zMrv7y8s=
X-Gm-Gg: AZuq6aKJVlnrhRQqEq4r1afh3NoFAxptqL5LaNyJrPclPnp+9dV/ZaS6aZ3CI2/l5hh
 zmLK6e/Mc1mqCwcAJFICUyiK9m7qF9tHY4mRpkZXGz6QRmXW60/ArxF+kai4i7KDaoxW/fBV44J
 OTcXrWxnS+Jrjsl1h6ZYThJBVqmj8HUfRCTKAHunnAig9LUBCpwo6SXiPGuXyj+fXQ9MDJIsEs8
 L/V0AYzzmfpy8DFLYMDjw3s60QDCeubaGjxwNT+3R1gHwXsBylv1DKMwoWjcLeaxeRwtWfRpeH7
 24YOUzXTihC34ihdKYhTXZtxAeAz/YUzhSqevVYET94gEfBxk+5vH4UNT0aSsoOoDYxKPth2zmK
 OFmrjHeK8i3cittmfHb+SqY/vbKnm0b0IXOqLj9C3Q2Xc3+8Jz/4Lb0lQWoy1zGR1DGegmKF3va
 0rNg4cyKDeITCc+pgkLUfjNQRy7nBckFGYSB+iP6NCl+80QFE4Rt/gWaDVDZtq
X-Received: by 2002:a5d:5885:0:b0:432:dfa8:e1b6 with SMTP id
 ffacd0b85a97d-435f3aae088mr13849868f8f.39.1769988001862; 
 Sun, 01 Feb 2026 15:20:01 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-435e135422csm41367119f8f.40.2026.02.01.15.20.00
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sun, 01 Feb 2026 15:20:01 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>
Subject: [PATCH v2 00/10] single-binary: hw/virtio
Date: Mon,  2 Feb 2026 00:19:49 +0100
Message-ID: <20260201231959.88559-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42a;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42a.google.com
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

This series eliminates target specifics in hw/virtio and replace them
with runtime functions where needed.

v2:
- Reduce runtime calls for performance
v1:
https://lore.kernel.org/qemu-devel/20260131020100.1115203-1-pierrick.bouvier@linaro.org/

Philippe Mathieu-Daudé (6):
  hw/virtio: Constify virtio_is_big_endian() argument
  hw/virtio: Introduce VirtIODevice::access_is_big_endian boolean field
  hw/virtio: Use VirtIODevice::access_is_big_endian field
  hw/virtio: Reduce virtio_access_is_big_endian() scope
  hw/virtio: Check target supports legacy bi-endianness at runtime
  hw/virtio: Replace TARGET_BIG_ENDIAN -> target_big_endian()

Pierrick Bouvier (4):
  target-info: add target_base_ppc, target_ppc and target_ppc64
  hw/virtio/vhost-user: make compilation unit common
  hw/virtio/virtio-qmp: make compilation unit common
  hw/virtio: make all compilation units common

 include/hw/virtio/virtio-access.h | 46 ++++++--------------
 include/hw/virtio/virtio.h        |  7 +++-
 include/qemu/target-info.h        | 21 ++++++++++
 hw/virtio/vhost-user.c            | 11 ++---
 hw/virtio/virtio-qmp.c            | 70 -------------------------------
 hw/virtio/virtio.c                | 25 ++++++++++-
 target-info.c                     | 21 ++++++++++
 hw/virtio/meson.build             | 17 ++++----
 8 files changed, 95 insertions(+), 123 deletions(-)

-- 
2.52.0


