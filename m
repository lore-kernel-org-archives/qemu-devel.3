Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0745C561E6
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 19:26:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wrKmO-00078k-Uc; Tue, 04 Aug 2026 15:26:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wrKmN-00078R-Oi
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 15:26:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wrKmM-00054P-4z
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 15:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785871580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+XiFZpzsJ8MFDBtglKH9yiE/r+6L+4JF7e6g5/Dv+/I=;
 b=YrZ+iDyuDjyg5s3owe8RIbAqaNxI5dvE6/2/EAt2CPrrpdt5b5aWI1EzvW8Z4A6aU9rttZ
 iRee8p1GhBKB1j8b1RZSzQTGfPAdVjksbo+If+YpVyizOvKOCvwIG+/kyldxop+d84nsHe
 CRLzhzfBiVoqBgGxWRr26j+QEyUrrnk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-184-OPckg4BxM3qyYUy7cp8cFA-1; Tue,
 04 Aug 2026 15:26:19 -0400
X-MC-Unique: OPckg4BxM3qyYUy7cp8cFA-1
X-Mimecast-MFC-AGG-ID: OPckg4BxM3qyYUy7cp8cFA_1785871578
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 39AAC180056E
 for <qemu-devel@nongnu.org>; Tue,  4 Aug 2026 19:26:18 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 032D61956087; Tue,  4 Aug 2026 19:26:16 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [GIT PULL v2 0/9] Fixes for 11.1-rc
Message-Id: <20260804-fix-v2-0-70e8fe489c9e@redhat.com>
Date: Tue, 04 Aug 2026 23:21:47 +0400
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
In-Reply-To: <20260804-fix-v1-0-0c2be5390809@redhat.com>
References: <20260804-fix-v1-0-0c2be5390809@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=2085;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=GA7kN85D9i3yCnKE2C28x4nf6CzR9uraZQt7rTUevHc=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcjzTrVXHxL1iZa9qvqdEDrvvIoMHZxHd7rSpn
 4rvdWQDrO+JAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanI80wAKCRDa6OEJdZac
 5eIYD/97nesfVDIFWBJO626sKwpR9wdP7T0SSE8Ov9ELMiE61v6d1o+qZH4hQY2MEYgkbk4ktuK
 DRBKBlwQGwcfD2fTP4dODcE01GYfaXtqS3Kdzi+QRWhW0cPf6fTm11XgZKBVQHJuBs2VR9l2+DF
 Hpi/EFwS5uQFIgcVf++b4Sj5vS+yNMbnm0EhX1PXvDytTJo/Bfx6m3kyCNwROZCe+sTg31oB/dx
 aJxKHyc0gBot7Eb9NS4FYHU/xDXvCAPzUdePc+HOQlfVOCSxm541Sc/tvF/qjcAIbJiET4fNoAM
 nm2ZTadqjXd+FhDzWLF8oH2FL8mON2zhZWscmp0WWB6CC5P1xI+HpfbsAF2rb9c9ud6rvuZArda
 nnGavwdlf2FIsJY335cnlfI9d4iHjhscxNDrKrDhwjxIRL0weyymIE94IKScrH9Wslp8rUVj+jt
 osOw5SEH9lXx73yOYVSHw/1jNc7/z3GCGmBLPMUUnEGalbnTNRveQ4h8ZzyEVtOMo8Z0o2JaCDf
 8PqER9xww5ngVA/LatN85mOJ7qmuVvr+eB7KzyX1JUa3zlteJlDI+zEYbi7FQiMbn+FKeBcWQ3Z
 5/Ik8lO1oNcyOdKMFHrevpz/rT35kAl4LA0EPQurJF6SfDLmjBzI6O1nHEMVyPe1vitvg3ltCGX
 4II+arBmfcVEBwg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.795,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit b428fe036233cbd15d37e3c027ab6ca4d3661a80:

  Merge tag 'pull-target-arm-20260731' of https://gitlab.com/pm215/qemu into staging (2026-07-31 16:19:04 -0400)

are available in the Git repository at:

  https://gitlab.com/marcandre.lureau/qemu.git tags/fix-pr-v2

for you to fetch changes up to dd272c8c87f165d41c945946242c5c8619e7122f:

  qapi/dump: add allowed-by-guest feature to win-dmp (2026-08-04 23:21:40 +0400)

----------------------------------------------------------------
Fixes for 11.1-rc

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

---
v2:
 - fix CVE# in "virtio-gpu: reject requests with short/truncated control
 headers"

----------------------------------------------------------------
Akihiko Odaki (1):
      hw/display/virtio-gpu: Always reject invalid scanout bounds

Ankur Saini (1):
      virtio-gpu: reject requests with short/truncated control headers

Bin Guo (1):
      hw/display/virtio-gpu: Unmap DMA regions on reset

Denis V. Lunev (1):
      qapi/dump: add allowed-by-guest feature to win-dmp

Marc-André Lureau (5):
      hw/display/virtio-gpu: validate blob iov size
      hw/display/vga: fix panning_buf OOB after text/graphics switch
      vhost-user-gpu: fix integer overflow in buffer allocation
      hw/display/virtio-gpu: fix offset wraparound in scanout_blob_to_fb
      hw/display/virtio-gpu: drop redundant node->value NULL checks

 qapi/dump.json                          |  9 +++-
 contrib/vhost-user-gpu/vugpu.h          |  1 +
 include/hw/virtio/virtio-gpu.h          |  8 ++++
 contrib/vhost-user-gpu/vhost-user-gpu.c | 29 +++++++-----
 contrib/vhost-user-gpu/vugbm.c          | 11 ++++-
 hw/display/vga.c                        |  7 +--
 hw/display/virtio-gpu-base.c            |  4 +-
 hw/display/virtio-gpu-rutabaga.c        |  6 +++
 hw/display/virtio-gpu-virgl.c           | 20 ++++-----
 hw/display/virtio-gpu.c                 | 80 ++++++++++++++++++++++++---------
 10 files changed, 126 insertions(+), 49 deletions(-)


