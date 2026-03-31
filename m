Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 536B2FF60F9
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 09:54:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Vmd-0000Rb-V6; Tue, 31 Mar 2026 05:53:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w7Vmc-0000QI-Vz
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 05:53:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1w7Vmb-00083p-0N
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 05:53:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1774950790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KW1bYZ59OsdLb/9VFy40MTrDbsyladYgM6S2qy/EuRQ=;
 b=bv6xD9S4abWQQzWK2yoRu3Ea6L8KuE/RwG7WqYSyTqcjVxcRDeBISqSJYAmlsWbg4ZCi03
 UqJIf3CGw1tCNIGvt46608NEKgvqtaknbvN4HYSzADO5sTX5Zy6RvgseUql1NH9GUFUPkJ
 sGplL7Z8O108Jo8tOLVDYW5wPXy/CFs=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-445-lAVW7KSuMNyyvtRpYld_SQ-1; Tue,
 31 Mar 2026 05:53:09 -0400
X-MC-Unique: lAVW7KSuMNyyvtRpYld_SQ-1
X-Mimecast-MFC-AGG-ID: lAVW7KSuMNyyvtRpYld_SQ_1774950788
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6818518002CA; Tue, 31 Mar 2026 09:53:08 +0000 (UTC)
Received: from localhost (unknown [10.44.22.22])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 04DFD19560AB; Tue, 31 Mar 2026 09:53:06 +0000 (UTC)
From: marcandre.lureau@redhat.com
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 0/6] For 11.0 rc patches
Date: Tue, 31 Mar 2026 13:52:56 +0400
Message-ID: <20260331095302.644608-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

The following changes since commit 91f6a9cb1b0f11afa74ef7fb20d5579d9dfbe020:

  Merge tag 'qga-pull-2026-03-27' of https://github.com/kostyanf14/qemu into staging (2026-03-27 18:41:05 +0000)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/for-11.0-rc-pull-request

for you to fetch changes up to 425f084fd2dc9838c82eebbfdb88eab5a545ec97:

  tests: don't build audio tests when no audio drivers are enabled (2026-03-31 13:48:42 +0400)

----------------------------------------------------------------
Various UI & audio fixes for 11.0-rc

----------------------------------------------------------------

Anton Kuchin (1):
  tests: don't build audio tests when no audio drivers are enabled

GuoHan Zhao (2):
  ui/dbus: associate add_client completion with its request
  ui/dbus: tear down clipboard callbacks on display finalize

Marc-André Lureau (3):
  audio/mixeng: fix sw/hw mixup in audio_pcm_sw_init_
  ui/vnc-jobs: fix VncRectEntry leak on job cleanup
  ui/vnc-jobs: clear source tag

 audio/audio_template.h     |  6 ++---
 ui/dbus.h                  |  1 +
 tests/audio/modinfo-stub.c |  5 ++++
 ui/dbus-clipboard.c        | 16 +++++++++++++
 ui/dbus.c                  | 47 +++++++++++++++++++++++++++++++++-----
 ui/vnc-jobs.c              | 23 +++++++++++++++----
 ui/vnc.c                   | 31 ++++++-------------------
 tests/audio/meson.build    | 14 +++++++-----
 8 files changed, 99 insertions(+), 44 deletions(-)
 create mode 100644 tests/audio/modinfo-stub.c

-- 
2.53.0


