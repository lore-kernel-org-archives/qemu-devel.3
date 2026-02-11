Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1BBCEB5954
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 10:02:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vq72y-0000dE-Dc; Wed, 11 Feb 2026 05:02:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vq72x-0000d2-Ij
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 05:02:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1vq72v-0002wh-Eu
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 05:02:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770804127;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zYJMcpz1c6Gbv/r6EaoQbjM03IU8Ig4shFnCTtqJuc4=;
 b=iIP6WDkwV9v/pupG2yAFCOnp0hyhEvoJ7SQVArzFa0Zi4j0lfE6/BQh44Z4pb1HBYdduDd
 dCiIa8E8LKw01trmC9JjMxtO9GssxzhJQUI6pvwaPUPgftQxP41iVHlQFLhbmu7ixKIAHg
 M+AkXnOQDqNO2UZLcL7h0JI+x7lIWWE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-449-j2zrQMMtPCylWH2HCm1P9A-1; Wed,
 11 Feb 2026 05:02:04 -0500
X-MC-Unique: j2zrQMMtPCylWH2HCm1P9A-1
X-Mimecast-MFC-AGG-ID: j2zrQMMtPCylWH2HCm1P9A_1770804123
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E03861956094; Wed, 11 Feb 2026 10:02:02 +0000 (UTC)
Received: from localhost (unknown [10.45.242.6])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 5DF0B1956053; Wed, 11 Feb 2026 10:02:00 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 0/7] Some cleanups (mostly ui/audio)
Date: Wed, 11 Feb 2026 14:01:40 +0400
Message-Id: <20260211-cleanups-v1-0-e63c96572389@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDI0ND3eSc1MS80oJi3SRTw5Q0c4Nk4ySjNCWg8oKi1LTMCrBR0bG1tQD
 edeHeWgAAAA==
X-Change-ID: 20260211-cleanups-b51df70c3b2f
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, John Snow <jsnow@redhat.com>, 
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1414;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=6BfGoneTWrAgQkpi3Wg+sNCHnLhwd4FE4YCjT52Vq2w=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBpjFOSEtMuE/HcNaSvgud28RkgTbo4EZsR2EdwO
 GR+RGHlLUyJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCaYxTkgAKCRDa6OEJdZac
 5SuuD/9uM9zzedm6kDJr1u352pPAUoq5G8Wyw22mADEov4g5Qi+sPvC6w1/xyw2KTOc23YGrxWT
 1bUcthBLzNcy3l6Gtkcc+HwCc/0A3qRuxW3fbN1J7KGCZbOXiUn4/CUsLIpCXuFWyGp3lwhhVfU
 FAL0b1Q5MnA/Eh2K+9K4PBsXCTWFgyWl+C/8IFYcL7KtflZ9oNXZeO2EMw4wH7lxBHuqkgiI9y0
 0tV4QkD8unkwhjRLFU4KtcMZG79+vuxnQ2rbrqRyHlreRXYPqQZiXTjOFIK3FEIRCOJ2aVE0Jc8
 ZNB4eMWsiYW9VZVP+beUsT8NSm1pQWjl+lrdl4uFC6KZ0kbxhwMq/VQx95GXY9wDOWAqEh9L4Iz
 ycRP4kdhhW/a1bnNah1QdC+AJSJhZfYhNANp5uHeBKA60XEt2BGSN9oK0uxcxhVC7FWXrAESuYF
 +mNsYjenZfNkFC2wIZ2QCHLdYwcRU2678xam9JibIKaKBLxNw/sYkEZPkUU+uPqP+hZAo/lRbT8
 svH99RBSJYsmQzZt1hbrwtgqR+1CWFuQuUwmzQ9EMMlgCH2SwmtzMf8yAil1G12KLxOs0p3juSU
 5SS7u8pR0eAj/leJny5o47rvUckjF0h6v8/OBM/A8JBPFh4GPkIy0+qBt5l/VdK8QYQlVhyBXWY
 k2k4d7J3aBdtmLQ==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi,

Please review those ui/audio related patches,
thanks

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
Marc-André Lureau (7):
      audio: fix nominal volume channel (cosmetic)
      python/wheel: remove meson-1.9.0
      scripts/vendor.py: add pycotap
      audio: require pulse >= 0.9.13
      audio: require spice >= 0.15
      ui: drop legacy spice < 0.15 support code
      ui: drop spice-protocol < 0.14.3 support

 meson.build                                |   6 +++---
 include/ui/qemu-spice.h                    |   6 ------
 audio/audio.c                              |   2 +-
 audio/paaudio.c                            |  28 ++-------------------------
 audio/spiceaudio.c                         |  30 -----------------------------
 chardev/spice.c                            |   6 ------
 hw/display/qxl.c                           |  23 ++--------------------
 ui/spice-display.c                         |  15 ---------------
 ui/vdagent.c                               |  18 -----------------
 python/scripts/vendor.py                   |   2 ++
 python/wheels/meson-1.9.0-py3-none-any.whl | Bin 1029634 -> 0 bytes
 11 files changed, 10 insertions(+), 126 deletions(-)
---
base-commit: 0b91040d23dc8820724a60c811223b777f3bc6b7
change-id: 20260211-cleanups-b51df70c3b2f

Best regards,
-- 
Marc-André Lureau <marcandre.lureau@redhat.com>


