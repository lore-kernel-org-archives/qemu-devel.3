Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9AE0606A321
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Nov 2026 10:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=IxGHqHGH
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRokI-0002Vw-Ez; Fri, 13 Nov 2026 05:43:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRokG-0002Ve-99
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 05:43:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1xRokE-0000D5-Fz
 for qemu-devel@nongnu.org; Fri, 13 Nov 2026 05:42:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794566576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=sNdZyy+yR4OKOMZlOuruAtoLn2prEk/Y9WMBuBrMeys=;
 b=IxGHqHGHO2GHpF6271BdW3cyWFIzWr6QKVbxFJCKn7XTlv/ujBoHl+tzvSah8lNHagKO3N
 h3pMfDVUIuig4Hoflh0Zs56XZADwv58vo1SKpMk/7qGRt+0s1W9kFVcd+rABSPuWChHE9k
 UPLTGg8kKj978LXtk57xu+UmV1L+928=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-290-k24UcrfvPs6EDsZpjf1buw-1; Fri,
 13 Nov 2026 05:42:53 -0500
X-MC-Unique: k24UcrfvPs6EDsZpjf1buw-1
X-Mimecast-MFC-AGG-ID: k24UcrfvPs6EDsZpjf1buw_1794566572
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 206281800559; Fri, 13 Nov 2026 10:42:52 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D3E3A1955F2D; Fri, 13 Nov 2026 10:42:50 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v2 0/8] vhost-user-gpu fixes
Date: Fri, 13 Nov 2026 14:42:12 +0400
Message-Id: <20261113-issue-4848-v2-0-631414664bca@redhat.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/22Nyw6CMBBFf4XM2pq2Noiu/A/Doo9BxkQgHWg0h
 H+3xa3Lk5x77gqMkZDhWq0QMRHTOGTQhwp8b4cHCgqZQUtdK6W0IOYFhWlMI4K5hNqFBs/OQB5
 METt677F7+2Ne3BP9XArF6InnMX72t6SK9zeclJDCorPKd6i9PN0iht7ORz++oN227QtrPG4Gt
 wAAAA==
X-Change-ID: 20261112-issue-4848-d49d6bd8e7b4
To: qemu-devel@nongnu.org
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, 
 Dmitry R <rdmitry0911@gmail.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=2050;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=6qKW83DUBLvFcB2/n4FpVjFmP8vHPjZ+jD92G+WPUnk=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBq9umnc1bmN5i2puU7di+1mkXNxbetUom+HEds3
 os5rvIlaMaJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCavbppwAKCRDa6OEJdZac
 5eRFD/wJy6nnemAIuPMeBeKItBE+wWIFu9uC/MfMOYMIxGL8F6kz5n7t5fMggVu5Fwy/+Yhkhoa
 FrHVAMdxP3u+vH96Pr/caNchnxCRkud+oMljOGVRvvW0rzHWpF3oR1nbG/7aTncaiXi6GbI8y2D
 fa2/gXb0zOW6XSeqkIaVI4J2CSHPZ1vmMt465x2zDBy9MaoqVKElvRBohIHyxNYCM3Pp0Ht8H6R
 hDvksTJSBWNDuGbAZJ6ik20MRMWrZla1NIgomLOy8DrVwzMv/Un73anijiMoOyi3ujsdrXGhcA1
 W54NWwLyoJkcwqsAkjFP/gATLiS+D4U7NH5rI6ODgo0ILbvDKNNIRAFUapp4CYtE8ocStyPJFG0
 +D0oyLKcXK3J3uBDoK/YFLdjg3WiZFOztoNqI9AYYp2gsYGs+hyxaBFbtaTwkIdZJAXEzlp5eMZ
 TA7TiRzVbq23LPqDWMRXQpW+c1wFpNZN/jfIR3mcqGUsd+/hushBJj4a+dxS0tHAczADi4nL1v7
 A2sVwUXrJwMeLV7D7m7N6y7670gg+F/uIqrkKqPjdOBlRDXkgHlN7dB3/RBmc/XJHRCd3aMZhIx
 cMQIHUQhp1MlDhqrnElCYzSBjMq38Zy2nvFIOmhkKCuh9uZ7iIX/0JYpK7dqD9BvxbUYioawM2n
 4MKt+nuYjM6Se7A==
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
 hw/display/vhost-user-gpu.c             |  97 ++++++++++++++++--
 include/hw/virtio/virtio-gpu.h          |   4 +
 5 files changed, 295 insertions(+), 52 deletions(-)
---
base-commit: 49559567804523cb28cad002aa8e97f444e23ad7
change-id: 20261112-issue-4848-d49d6bd8e7b4

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


