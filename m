Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32014C55172
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2026 07:19:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wr9Qm-0000nO-GT; Tue, 04 Aug 2026 03:19:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wr9Qk-0000nF-AE
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 03:19:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wr9Qh-0001Dx-85
 for qemu-devel@nongnu.org; Tue, 04 Aug 2026 03:19:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785827953;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=JEgmvsw4PP9ogy+qSkqv4cF1yXqw+trW3wDXt1uXIr0=;
 b=ShEJ84vP/CqNhOOKHsbuqn4ISYQtQMLLOQ1LoSUMXmm4tqJpagLsmwTwpK/pM4FOzy1xp4
 ldZC1cBUIa4xHpEfnih2cxoKdQ/1osyg2bfdTM5/w/vLp+GiRgzcDFzKbMQVT8jUSdaBPJ
 Kia2PBrlrjPg50Fvagl7JDsI4qU7758=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-63-lOJVYDd3P2yKGF4tv3dpSg-1; Tue,
 04 Aug 2026 03:19:06 -0400
X-MC-Unique: lOJVYDd3P2yKGF4tv3dpSg-1
X-Mimecast-MFC-AGG-ID: lOJVYDd3P2yKGF4tv3dpSg_1785827945
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4138F195609E
 for <qemu-devel@nongnu.org>; Tue,  4 Aug 2026 07:19:05 +0000 (UTC)
Received: from localhost (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B5A1D1800480; Tue,  4 Aug 2026 07:19:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: [GIT PULL 0/9] Fixes for 11.1-rc
Message-Id: <20260804-fix-v1-0-0c2be5390809@redhat.com>
Date: Tue, 04 Aug 2026 11:18:49 +0400
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com
X-Developer-Signature: v=1; a=openpgp-sha256; l=1988;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=sx5HYVJev6pTbLV4henfhvXdEmJ1OT6cK4po/XlKyj8=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqcZJcWzWRKy68LerroPkL+CqSCs/owHXpBAWy6
 800wdLw/gqJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCanGSXAAKCRDa6OEJdZac
 5d80D/sFKUjvX7cPaNx3MZbYvXpoKRlYy8xI5ZvG8pTdDP3PFif70VIWNAIvC+5L18A541EE6ns
 CRvftTiP1RTs2l/MySU3LSVGe3KDUvpAlvviqpRBO/5RI0ROKRFM/Rc/MS2dzHmRWNsI0cGNZAF
 RmlZK7ghE56aqH30QH5eKTaZ+1vcLdOdUyKcNFRoftOS8f6JL5dIPL5m/uv2OIy2i2fjsioZ7E3
 gsBwVy4ir2jrvJDKPxB9b6sfWHvOcy7RAtZsDfX09f3LI7S0K6zCt/znCl+4fNr9TimBM4u64rC
 E3W0GPq+jjmdDNXkjpybUHkwwQnUQcBD8X2cZO9f/KZBBd9qm7IXCwI6nrrgoBVulUom5Rrq7JY
 c3O5S/Ww0kKa7F7fg/1zwa7IdPVhQ4+Da0wviQPKzZGWbAwxasHCKaVkn26aqKZMhh/soPkwOph
 KqcTZ9xKk/hPcYRrsin432wXdtyOJteCE18Rind8IYmAucc+vjIiSZYpOOeaA1HgI3Jgq5RrpSU
 iGywCnraktCDsHEU0Kra1zj5YtXulIBcbsH4gRkZTgnUF0IgTC3wFtNlCwhzYTjGrjgv3czeKFS
 W076GxbvpDNbfEjz8RwDqc85cE9bDRb8cXmKIhO0OceeZVFdA2tqPe015RDcLji+TEePIMsI0Zw
 mOQi8ZQ7PKjmq7w==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 4
X-Spam_score: 0.4
X-Spam_bar: /
X-Spam_report: (0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.811,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

  https://gitlab.com/marcandre.lureau/qemu.git tags/fix-pr-v1

for you to fetch changes up to 8876b366d7cac1f65978b8f8472725b980a1abfb:

  qapi/dump: add allowed-by-guest feature to win-dmp (2026-08-04 11:18:43 +0400)

----------------------------------------------------------------
Fixes for 11.1-rc

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>

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


