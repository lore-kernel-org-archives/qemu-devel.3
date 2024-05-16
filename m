Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB3A4C25B7B
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2024 12:04:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s7Zq4-000550-9v; Thu, 16 May 2024 08:04:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1s7Zpv-0004ot-LR
 for qemu-devel@nongnu.org; Thu, 16 May 2024 08:03:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1s7Zpt-0002MN-Nn
 for qemu-devel@nongnu.org; Thu, 16 May 2024 08:03:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715861028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=BXuZW1V0p/+Tl0KKQduReGVFFC8cMf6ZpB2tRr+viGo=;
 b=Ifz8sOSdAScYydP5ruVYzdrRqUshoGLN6ZWncveoM/tBkmDThYhZrOevXi0s2PIPR+Ul2S
 bXwCeJSPhw68pZ+r1ZKWA51AO2lUOVT4q8590v8l19DZnE0oCmU352oftTqfCC1txrJZp5
 K8MCuxhvSjJKqkVjj6Tt1fGuCGQBEK0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-5TrcSQhzOaaXbQeagi-j_Q-1; Thu, 16 May 2024 08:03:46 -0400
X-MC-Unique: 5TrcSQhzOaaXbQeagi-j_Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6353C857A81
 for <qemu-devel@nongnu.org>; Thu, 16 May 2024 12:03:46 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.119])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0943E1C00A8E;
 Thu, 16 May 2024 12:03:45 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id C077C1800DE0; Thu, 16 May 2024 14:03:44 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH 0/4] MAINTAINERS: update kraxel's entries.
Date: Thu, 16 May 2024 14:03:37 +0200
Message-ID: <20240516120344.531521-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.022,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

I have not found much time to work on qemu due to being busy with
firmware (edk2 for the most part).  Time to update the MAINTAINERS
file entries to match reality.

I drop spice, ui, audio and usb due to lack of time.

I drop virtio-gpu, I don't follow recent development (venus etc.)
close enough to be able to actually review the changes.  Looking at
qemu-devel traffic for virtio-gpu it seems to be in good hands with
multiple people working on it, even though this is not reflected in
the MAINTAINERS file.

I keep the firmware bits (edk2, fw_cfg).

I also keep some other pieces which don't see much development
activity such as stdvga and cirrus for now.  I might revisit
this later.

take care,
  Gerd

Gerd Hoffmann (4):
  MAINTAINERS: drop audio maintainership
  MAINTAINERS: drop usb maintainership
  MAINTAINERS: drop virtio-gpu maintainership
  MAINTAINERS: drop spice+ui maintainership

 MAINTAINERS | 31 +++++++------------------------
 1 file changed, 7 insertions(+), 24 deletions(-)

-- 
2.45.0


