Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B35D72345
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Jan 2026 08:32:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjCad-0008QX-O2; Fri, 23 Jan 2026 03:32:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vjCaa-0008Pk-E5
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 03:32:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <osteffen@redhat.com>)
 id 1vjCaW-00035r-SW
 for qemu-devel@nongnu.org; Fri, 23 Jan 2026 03:32:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769157133;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=d0xQxbFdKwTyf1KEz9MIN4RWOQVeIgTiFWKG5SwPM8Q=;
 b=hVzoV5XlQkN0oaNxj6Itjuj3BcjSAMliOyQuaYo7IeJ0Tc9yBDkf8rq4LGbbxtpAdN9z5h
 zXHZu02AyJtiGMoExiKGUShF/e0AclVLvLFmk1jZ3HQtCH2g6JGs1s+KfDYlr59zrZzBNk
 a/tHuS2IWcHrOLR9DGNdHkHfiSAwJ1Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-131-Q491ZTkzMCaPEmR_2A1yQQ-1; Fri,
 23 Jan 2026 03:32:10 -0500
X-MC-Unique: Q491ZTkzMCaPEmR_2A1yQQ-1
X-Mimecast-MFC-AGG-ID: Q491ZTkzMCaPEmR_2A1yQQ_1769157129
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 517E61800473; Fri, 23 Jan 2026 08:32:09 +0000 (UTC)
Received: from osteffen-laptop.redhat.com (unknown [10.44.34.167])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 318A91800240; Fri, 23 Jan 2026 08:32:05 +0000 (UTC)
From: Oliver Steffen <osteffen@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Luigi Leonardi <leonardi@redhat.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>, Kashyap Chamarthy <kchamart@redhat.com>,
 Oliver Steffen <osteffen@redhat.com>
Subject: [PATCH 0/3] docs/interop: Extend firmware schema for SVSM
Date: Fri, 23 Jan 2026 09:32:01 +0100
Message-ID: <20260123083204.999920-1-osteffen@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=osteffen@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Extend the firmware metadata JSON schema to support Secure VM Service Module
(SVSM) firmware images. Parts of these changes can be useful for describing
other (confidential) firmware types as well.

This series adds:
- An entry in the FirmwareFeature enum indicating a virtual (emulated) TPM
  devices offered by the firmware (Coconut SVSM provides one)
- An entry in the FirmwareOSInterface enum indicating support of the
  SVSM guest interface
- A new top-level array to store associated digest values
- Add structures to describe AMD SEV-SNP launch digests.

For attesting a confidential virtual machine, the verifier needs to know the
expected launch digest. This new format allows us to add this information to a
metadata file and include it in distribution packages of confidential firmware
images.

Oliver Steffen (3):
  docs/interop: Add vtpm feature firmware.json
  docs/interop: Add AMD SEV-SNP SVSM interface to firmware.json
  docs/interop: Add firmware digests to schema

 docs/interop/firmware.json | 94 ++++++++++++++++++++++++++++++++++++--
 1 file changed, 91 insertions(+), 3 deletions(-)

-- 
2.52.0


