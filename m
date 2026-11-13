Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7364606A323
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 14:31:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=efWYOYVY
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRsIS-0007is-W1; Fri, 13 Nov 2026 09:30:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRsIJ-0007hQ-LR
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 09:30:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRsIA-0005tQ-Nt
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 09:30:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794580205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Z9dxiejn+OgNiDIoQhJ9zScPu95DgLRARDhzdj7qT8w=;
 b=efWYOYVY6uL481SscuguJJnD6mueGe0KvFB6oSrW3Eacrc/zL4e22BlyC9Qy34SDheNdSJ
 /calcpsol9+PtXVgizK24XaKQ0UtjRXyzWcV2vib3ygv8EduNgc8fUutdDnXBXR4UvU/nN
 vR3itM3os1P6W+9y1aibMznmkf6BYfw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-674-XmN5iXiQM6-cvdc4J2wGdg-1; Fri,
 13 Nov 2026 09:30:03 -0500
X-MC-Unique: XmN5iXiQM6-cvdc4J2wGdg-1
X-Mimecast-MFC-AGG-ID: XmN5iXiQM6-cvdc4J2wGdg_1794580202
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6D7481800366; Fri, 13 Nov 2026 14:30:02 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 579411956086; Fri, 13 Nov 2026 14:30:00 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 0/8] vhost-user-gpu fixes
Date: Fri, 13 Nov 2026 18:29:52 +0400
Message-Id: <20261113-issue-4848-v3-0-98e4fa3e77eb@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22NywrCMBBFf6VkbaSThFhd+R/iIo+pjWArmTYop
 f9uUjcWXB6459yZEcaAxE7VzCKmQGHoM8hdxVxn+hvy4DMzUQsNAIIHogm5alTDvTp6bX2DB6t
 YFp4R2/BaY5frl2myd3RjKZRFF2gc4nt9S1B2f8MJeM0NWgOuReFqeY7oOzPu3fBgpZzErys3r
 siulqBAaa2sMxt3WZYP8nvKrvMAAAA=
X-Change-ID: 20261112-issue-4848-d49d6bd8e7b4
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry R <rdmitry@taktcycles.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2225;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=lcta1sEiCC3i2eFt8OurRIhjCSUEGFRZm25wY6SBW/g=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq9x7lnY/8FXehQy2Drsek/Zt/ULX3Y+27ZqW+u
 ZNATBJWGVaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCavce5QAKCRDa6OEJdZac
 5RRZEACobfF+UIgzGFNjofAOERlAAQkTngo3YEa2zRFG+lbwqetRjNrcsv29h433jiGUn51f+H2
 rcfqBy/clT8/4U4b8otEyGtW3x6nsad9SHdZR5fs9YnG97VpLAyrzT+bzZeLahHUbu33w9DXbPn
 +FZDxNOgZufoRhd+B/LiUSnSvXaQwBJLKTerz4RPsPCoaUpaoX3JIhKyuR2g1SyrhllVflhuq+B
 qP2C4AvHXOSfNh5Z+Jnlw7oEHkI+hRvQNvulOdQQNUtYEVk+XdXDVkTKdFz6zVhJWOaJd8pJdya
 eRxZn/MtPDk5GlbWrrER1SRU9RSS6s1mm6nQD6JRCyj2m1oiEkX6mtlm8rVyd6wArq9m/8He1/b
 fUx+xFedjflMhslEsroOl+2EpNWYM42pK2MlUTqvzsZ8Wggaj2UZYONAsoTByTDCtiCjBUQn7TW
 tOP8pZjncTEEHlAcWyZAKLMPWjGMdLCBVIZ0e7JIFVnPSaP0UtrV7Kw5LgNR+q7edBAt8nqy8z3
 lscZML0Ok7lUWrw1Umd8pFLvVO2gdDtt/0ZG/G4ihp44pHukL689hb1R2bRs1I84ocKRetxJ5P9
 iLIv5kQPYi9UNPNcXEhUnhw+zTu2jX8Jve263ffaWOVs6Cg+W1j1MNXtJ+pwhWFmyRSudf4036l
 ccwh8xD84taxrJg==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Dmitry reported a handful of vhost-user-gpu issues (#4846-4849): crash
when a command waits for a reply and a fence is signaled (#4848), guest
losing display when the device is restarted (#4849), segfault in
vga_update_display() after a guest device reset (#4846), or main loop
spinning on bad descriptor (#4847). The first patches address those.

The rest are problems found while working through the code: console is
not resized on dmabuf scanout, the 2d scanout path frees a surface it
does not own, and the exported dmabuf is imported with the wrong stride
in some setup.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
Changes in v3:
- fix crash on finalize
- replace Dmitry email address
- Link to v2: https://lore.kernel.org/qemu-devel/20261113-issue-4848-v2-0-631414664bca@redhat.com

Changes in v2:
- add "hw/display/vhost-user-gpu: reset scanouts on the main loop"
  patch, similar to virtio-gpu
- add Tested-by tags
- Link to v1: https://lore.kernel.org/qemu-devel/20261112-issue-4848-v1-0-aeba1cfe2c03@redhat.com

---
Marc-André Lureau (8):
      contrib/vhost-user-gpu: don't fence commands waiting for a reply
      contrib/vhost-user-gpu: reset the frontend socket on stop and start
      hw/display/vhost-user-gpu: reset the console scanout on device reset
      hw/display/vhost-user-gpu: reset scanouts on the main loop
      hw/display/vhost-user-gpu: don't set an fd handler without a socket
      hw/display/vhost-user-gpu: resize the console on dmabuf scanout
      hw/display/vhost-user-gpu: fix scanout bookkeeping on the 2D path
      contrib/vhost-user-gpu: use the stride of the exported dmabuf

 contrib/vhost-user-gpu/vhost-user-gpu.c | 169 ++++++++++++++++++++++++++------
 contrib/vhost-user-gpu/virgl.c          |  70 +++++++++++--
 contrib/vhost-user-gpu/vugpu.h          |   7 +-
 hw/display/vhost-user-gpu.c             | 106 ++++++++++++++++++--
 include/hw/virtio/virtio-gpu.h          |   4 +
 5 files changed, 304 insertions(+), 52 deletions(-)
---
base-commit: 4bcd55a1f4b926ae86872087f7f3bc9f9e1d065e
change-id: 20261112-issue-4848-d49d6bd8e7b4

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


