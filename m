Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9EBACD4851
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2026 08:56:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPGFN-0003hW-CO; Tue, 19 May 2026 04:56:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wPGFD-0003g6-3e
 for qemu-devel@nongnu.org; Tue, 19 May 2026 04:56:07 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1wPGFA-0001VO-6v
 for qemu-devel@nongnu.org; Tue, 19 May 2026 04:56:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779180961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=tx8iaJNn6vxL9BRzM+MH3BVCmH9yyRvNjhdKFdYYzUE=;
 b=AjHvJ5Jt2RPNC7GkCzpaRKIsbtW3MQoiR6+jofjKrKu6N6r72BWYzc5hIAqgGucpiXKGlq
 Vf/2ox9lNeypHLoWZSuC2mBCvXB7TujfUa7jOhRLAqc1k25gpEXMKzCXxSlhiK5o7OhazY
 uPp5IZsyPKXcDBgipqERp4glCd9UlIE=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-693-Z1UlTpIJPXSGBjKcU9nn0w-1; Tue,
 19 May 2026 04:55:57 -0400
X-MC-Unique: Z1UlTpIJPXSGBjKcU9nn0w-1
X-Mimecast-MFC-AGG-ID: Z1UlTpIJPXSGBjKcU9nn0w_1779180956
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B42841956059; Tue, 19 May 2026 08:55:56 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.44.48.13])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id CBFD61956053; Tue, 19 May 2026 08:55:55 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id CE4891800795; Tue, 19 May 2026 10:55:54 +0200 (CEST)
From: Gerd Hoffmann <kraxel@redhat.com>
To: qemu-devel@nongnu.org
Cc: Sergio Lopez <slp@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Subject: [PULL 0/2] Firmware 20260519 patches
Date: Tue, 19 May 2026 10:55:52 +0200
Message-ID: <20260519085554.944458-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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

The following changes since commit ac6721b88df944ade0048822b2b74210f543d656:

  Merge tag 'vhost-user-rtc-pr-1' of https://gitlab.com/epilys/qemu into staging (2026-05-16 17:37:33 -0400)

are available in the Git repository at:

  https://gitlab.com/kraxel/qemu.git tags/firmware-20260519-pull-request

for you to fetch changes up to b25c602ec22ca472f98e6154bc60571902011618:

  hw/i386/microvm: Add IGVM support (2026-05-18 14:59:21 +0200)

----------------------------------------------------------------
- one more uefi-vars bugfix
- add igvm support for microvm

----------------------------------------------------------------

Gerd Hoffmann (1):
  hw/uefi: check auth.hdr_length minimum size

Luigi Leonardi (1):
  hw/i386/microvm: Add IGVM support

 hw/i386/microvm.c           | 21 ++++++++++++++++-----
 hw/uefi/var-service-auth.c  |  5 ++++-
 hw/uefi/var-service-pkcs7.c |  4 ++--
 3 files changed, 22 insertions(+), 8 deletions(-)

-- 
2.54.0


