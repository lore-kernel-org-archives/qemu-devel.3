Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0BA1C44521
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:56:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlirH-0003PC-Hf; Mon, 20 Jul 2026 03:56:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wlirB-0003Oj-AR
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 03:56:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wlir7-0006it-Qx
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 03:56:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784534164;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=D6SwdudhFqpaKV0XMGXiUeT/Rco0k1hj7dJhN9XTk30=;
 b=fYUbTLyuNLACEx/R7AvNTrZflM3Yk9FuPI47jwdYlKe66aP1UkC4K72bu+iQzOb3lTduw+
 l65aSwAw3s/BGdO6Hj/acrbgV3YmTjMJN8E4Y1zr19lvU5iaI+p24bSsVagN2ssFL78JwQ
 FarwycVSFuVtejRX2YOG54JRCciICvo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-193-CpgzGo4-MYukQUb9BufLvA-1; Mon,
 20 Jul 2026 03:56:03 -0400
X-MC-Unique: CpgzGo4-MYukQUb9BufLvA-1
X-Mimecast-MFC-AGG-ID: CpgzGo4-MYukQUb9BufLvA_1784534161
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 96D251955F22; Mon, 20 Jul 2026 07:55:59 +0000 (UTC)
Received: from localhost (unknown [10.44.22.17])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 35B0418001E0; Mon, 20 Jul 2026 07:55:56 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 0/8] coroutine: add missing annotations
Date: Mon, 20 Jul 2026 11:55:29 +0400
Message-Id: <20260720-co-v1-0-fabb4db3c204@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcyMD3eR8XTMj0xRLi2TzlGTTVCWgwoKi1LTMCrAh0bEQfnFpUlZqcgl
 Ip1JtLQALZewkZgAAAA==
X-Change-ID: 20260720-co-625d98c7dc5e
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Peter Xu <peterx@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 John Snow <jsnow@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 qemu-block@nongnu.org, Stefan Hajnoczi <stefanha@redhat.com>, 
 Fam Zheng <fam@euphon.net>, "Denis V. Lunev" <den@openvz.org>, 
 Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>, 
 "Michael S. Tsirkin" <mst@redhat.com>, 
 Stefano Stabellini <sstabellini@kernel.org>, 
 Anthony PERARD <anthony@xenproject.org>, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, 
 xen-devel@lists.xenproject.org, Li Zhijian <lizhijian@fujitsu.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1771;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=3p+9mnh7A1Sd9gkpZEuHm2Arv0B2DJblMllOqVWD9JU=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqXdSJGhUyT1s/3ctymKycGnr95OA0QKInBP1Ui
 yXIJzazgUKJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCal3UiQAKCRDa6OEJdZac
 5eMbEACq8EYoKuxQ9/nJnUX4f5S9btARbnstqg+dSMili5YH/rKseLzJI6ASS9TRCiSaLbKxCHr
 J0NH1UiF6C9zFiw2Fcpt7ZQafNIFmEAf8xLYSC0Uuf0RrO97+r+IXptsPvua0gcVAULgRrDkGZh
 aiTm8owI247yvspBOR7nty5r5jfYB6o4znP70TAd2hhGTB5YN43ajTnooWxl1joh+byoU/csVqS
 1g47AbXMZyZLxkpwayh4IcPRZaiEu9XM1JsMHOceeOkvfG68vRzNYwmFNeDyGtJeQCU+e4P3GdO
 JqGc/DDDP5CO2K88SV4AouRI0wP3xzV+IWZFXMqPPURxKomVtZMesnur2fwIZpD2ANvVLkx8IG4
 4Vvt486nrxm6rqGjCG8qqGX8bMUGwN1kwPxwcLKB+T9uUD5dut147306SNOFxE2TTecc49oEFlF
 PiL9bmKXCYgE7082Jyv8XQpnvqDo9Qjt+biA3A3IPdPghJYlFvrCDu0hkY3aqHqmZdnC1WkKFXi
 23+TLZlfkBIOOeqjLQ/er5TRHC4NIB1yTeUqYXTb/vJH2nbbrzJBchS6rmCtAdNJuePl8SIq1az
 Ay2aGD4BDqnMux3yzImPX4z0wGgcu+1/8LfK7yxA5x6n/x887t2hbwyNe/mwkZXHggL6a4TAcWh
 PAxjQOvVtrBQiZg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

Hi

Add missing coroutine_fn, coroutine_mixed_fn annotations and fix
a few related issues across monitor, migration, io, block, and
9pfs subsystems.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
Marc-André Lureau (8):
      monitor: annotate monitor_qmp_dispatcher_pop_any() as coroutine
      migration: fix qemu_get_counted_string annotation
      io: add missing coroutine annotation
      block: add missing coroutine annotation
      qcow2: remove invalid qcow2_check_refcounts calls
      block: add missing coroutine_fn annotations
      hw/9pfs: annotate V9fsTransport callbacks as coroutine_fn
      migration/rdma: annotate and simplify wait_comp_channel()

 hw/9pfs/9p.h                 | 26 +++++++++++++++-----------
 include/block/blockjob_int.h |  2 +-
 include/io/channel.h         |  4 ++--
 block/commit.c               |  5 +++--
 block/crypto.c               | 13 +++++++------
 block/io.c                   |  8 +++++---
 block/parallels.c            |  5 +++--
 block/qcow2-snapshot.c       | 18 ------------------
 block/qcow2.c                | 11 +++++++----
 blockjob.c                   |  3 ++-
 hw/9pfs/9p.c                 | 31 +++++++++++++++++++------------
 hw/9pfs/virtio-9p-device.c   | 24 +++++++++++++-----------
 hw/9pfs/xen-9p-backend.c     | 34 +++++++++++++++++-----------------
 io/channel.c                 |  5 +++--
 migration/qemu-file.c        |  2 +-
 migration/rdma.c             | 12 ++++--------
 monitor/qmp.c                |  3 ++-
 17 files changed, 104 insertions(+), 102 deletions(-)
---
base-commit: 5ef0ecc5942ee07bb581cc96a97bbfc0fdf4005c
change-id: 20260720-co-625d98c7dc5e

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


