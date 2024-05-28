Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A160C25B78
	for <qemu-devel@archiver.kernel.org>; Tue, 28 May 2024 08:40:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBsMM-0002hn-La; Tue, 28 May 2024 04:39:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sBsML-0002hZ-Dr
 for qemu-devel@nongnu.org; Tue, 28 May 2024 04:39:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1sBsMJ-0004oZ-Po
 for qemu-devel@nongnu.org; Tue, 28 May 2024 04:39:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716885542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=A1UrnLyvAfYu3lvm+2EGpMl72XMudIZPVV8xi1QNEX4=;
 b=PTjSn4bOpzKVZdu8ROjzqDFes6RJbQsvu44OXnZhH98CP6wApxtr1taf1Ws5o+LDu6NDZf
 RnaiaY4hl3xjEB0UuvIl9PAfKFs5GAVoIV9xdfVfZ/8nNIvSIPgcU5uJTJh0owwuPpGJNg
 RF+IfJm/caev5L/wmavlGyRrCvL/MWo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-452-_414HVcwP9WwkbDR8fUG8w-1; Tue, 28 May 2024 04:39:00 -0400
X-MC-Unique: _414HVcwP9WwkbDR8fUG8w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BEB42812296
 for <qemu-devel@nongnu.org>; Tue, 28 May 2024 08:38:59 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.39.192.232])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 67AFE40004D;
 Tue, 28 May 2024 08:38:59 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 45DA018009F4; Tue, 28 May 2024 10:38:58 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH v2 0/4] MAINTAINERS: update kraxel's entries.
Date: Tue, 28 May 2024 10:38:52 +0200
Message-ID: <20240528083858.836262-1-kraxel@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

v2 changes:
 - flip entries without maintainer to orphan even if there is
   a reviewer left.
 - add/upgrade volunteers from replies to audio sections.

take care,
  Gerd

Gerd Hoffmann (4):
  MAINTAINERS: drop audio maintainership
  MAINTAINERS: drop usb maintainership
  MAINTAINERS: drop virtio-gpu maintainership
  MAINTAINERS: drop spice+ui maintainership

 MAINTAINERS | 42 +++++++++++++-----------------------------
 1 file changed, 13 insertions(+), 29 deletions(-)

-- 
2.45.1


