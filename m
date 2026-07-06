Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B5EC43602
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 12:54:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgiq9-0005t2-3r; Mon, 06 Jul 2026 08:54:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wgipx-0005qf-PH
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 08:54:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@redhat.com>)
 id 1wgipu-0007yv-57
 for qemu-devel@nongnu.org; Mon, 06 Jul 2026 08:54:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783342448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Q23b86ptzOLnqqhghvGfMuQR4jZfV1R+cfGj5j1FRlk=;
 b=IFctb0Q11/Ex9iX3Yci+3RchJAzntTu0lobDwR3jyAVjAkLk0NrmOVS3J4VlIzJCd0OGRd
 D5HcZFxiHZrMa/+2vC+Cr9W2xQJE9mVybIne6xPefGtIAns6z8ooAXDHy5RciCUdhXrNLY
 kKigyvPhqwylpCKWqrTY0/WGvStpEWM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-529-6tFSBzOdMyCzMG-UtvgE9A-1; Mon,
 06 Jul 2026 08:54:07 -0400
X-MC-Unique: 6tFSBzOdMyCzMG-UtvgE9A-1
X-Mimecast-MFC-AGG-ID: 6tFSBzOdMyCzMG-UtvgE9A_1783342446
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D07251955F20; Mon,  6 Jul 2026 12:54:05 +0000 (UTC)
Received: from localhost (unknown [10.44.22.3])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id BDDCD1956088; Mon,  6 Jul 2026 12:54:04 +0000 (UTC)
From: =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH 0/5] Various UI/security-related fixes
Date: Mon, 06 Jul 2026 16:53:47 +0400
Message-Id: <20260706-fix-v1-0-4b83a70e9f3b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDcwMz3bTMCt3k5EQTM6NUY1OLZEsloMqColSgMNiU6FgIv7g0KSs1uQS
 kVam2FgC3rv+uZwAAAA==
X-Change-ID: 20260706-fix-cca462e358c9
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, 
 Marcelo Tosatti <mtosatti@redhat.com>, kvm@vger.kernel.org, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 =?utf-8?q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>
X-Developer-Signature: v=1; a=openpgp-sha256; l=776;
 i=marcandre.lureau@redhat.com; h=from:subject:message-id;
 bh=1bgyDeU7x52yJFu8RjfDCvFh8ya6pUiQ0StZ7Qnbh2w=;
 b=owEBbQKS/ZANAwAKAdro4Ql1lpzlAcsmYgBqS6VnI+R793oxQmkqEv3AAWJL7oo78LTjmeXjQ
 wDnZS+5uCeJAjMEAAEKAB0WIQSHqb2TP4fGBtJ29i3a6OEJdZac5QUCakulZwAKCRDa6OEJdZac
 5adoD/oDyi1zAfh2tz2BcCCAMbxmpq8JUvEH7VHBKp1tTUmuO3v4j3Ty+65m76DWtpBjuoYl6ZN
 MalT3PdP8UpXnQT5regjZByap+dqKMzBVltP54jKRs+/wX+bFVSa0KX6151NoNnbSOlp9b40YI5
 wv5Kql8ZTfdGNNkWEpLYVMWelGE3eW2/Q3V4RjIQATMghAyxA2lbgpEFMuG5lPeVIduK5bUmGN/
 FlJ39CVF8fvJhhANWO9CzUlKFeccfQTxrdxJ+2+h9XJeR9NvOcKW6RoWXDa3JN6c2jE4Fyw7LbZ
 CDqgBp8i071QgnfcOBL7IjChUW+yDlPziN0EjkXNWldLtl9MWPYyZYY5nIzWZ9/TceNk4nLthBA
 8FGGxZ5rLlXBBrYqe1aMAqwvQD+NuKPf+8b31FqDm0S56WVE05765OhWx6sbztCarRF0QcHcwlR
 nj5u0wIfsBJJq1LMjcq5Ql+xhgCtcaEQAq+ptPKsIk+ZwglBGdVd6lImhJLjSRkx8lh2vH/12Vj
 jt1SifEWIbS6G0OP4Yey+ax041F4bq9sZDOb9tIIxdG75spzADaIKPONpddhS3pwkYvG0wZXZ8f
 dy2/b7xmeCN5HbjX5dSrwJFHK+imCtr1cy+bmXzvP5av4yLQIdORjRFr0pUHZDlYLFHMwn+5pEe
 P/9sywkkMAotT7A==
X-Developer-Key: i=marcandre.lureau@redhat.com; a=openpgp;
 fpr=87A9BD933F87C606D276F62DDAE8E10975969CE5
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124;
 envelope-from=marcandre.lureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
Marc-André Lureau (5):
      i386/tdx: fix uninitialized variable warning in tdx_check_features
      ui/vnc: fix OOB write in vnc_refresh_lossy_rect
      ui/vnc: validate color shifts in SetPixelFormat
      ui/vnc: use RFB wire types for client message handlers
      ui/input-barrier: fix off-by-one in keycode bounds check

 target/i386/kvm/tdx.c |  2 +-
 ui/input-barrier.c    |  2 +-
 ui/vnc.c              | 56 ++++++++++++++++++++++++++++++---------------------
 3 files changed, 35 insertions(+), 25 deletions(-)
---
base-commit: 4ee536fac748b70e6f3d8568ddd20cfbaa9cf7bf
change-id: 20260706-fix-cca462e358c9

Best regards,
--  
Marc-André Lureau <marcandre.lureau@redhat.com>


