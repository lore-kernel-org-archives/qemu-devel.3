Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D94BE77188
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2025 11:39:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tUlRH-0008R9-KQ; Mon, 06 Jan 2025 06:38:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tUlRE-0008QD-Kl
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 06:38:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kkostiuk@redhat.com>)
 id 1tUlRB-0004Ad-Q3
 for qemu-devel@nongnu.org; Mon, 06 Jan 2025 06:38:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736163503;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=d75QfLpy5RclXJv7CW0Tdm4qhYu9hC08DlBnPYd3n6k=;
 b=cCOgwCd9YIlvBTGro7gImD81RPwnfZQTeYIjZAcvZDuh2qXBBRFxzBDfwNeUemmjfz1E3h
 pKO+oFK67zdvJs2pw0Z+HQYRyq0vATIJLZz9We4f2PB6/x2KK2XTfjfmv7GGFFrVbNJQD/
 HQa1GKKzBMqEFeX1Nd/gcAY/pwQqSAw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-137-V2Ut0JsBOcOwt4U-LIVykw-1; Mon,
 06 Jan 2025 06:38:20 -0500
X-MC-Unique: V2Ut0JsBOcOwt4U-LIVykw-1
X-Mimecast-MFC-AGG-ID: V2Ut0JsBOcOwt4U-LIVykw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C5B01955E84; Mon,  6 Jan 2025 11:38:19 +0000 (UTC)
Received: from srv1.redhat.com (unknown [10.45.224.221])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D91803000197; Mon,  6 Jan 2025 11:38:16 +0000 (UTC)
From: Konstantin Kostiuk <kkostiuk@redhat.com>
To: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 0/2] Misc QGA patches for 2025-01-06
Date: Mon,  6 Jan 2025 13:38:12 +0200
Message-ID: <20250106113814.35459-1-kkostiuk@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kkostiuk@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.446,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

The following changes since commit 9ee90cfc25747ab25c7da31a50f167fc5122e20e:

  Merge tag 'qtest-20250102-pull-request' of https://gitlab.com/farosas/qemu into staging (2025-01-03 09:14:11 -0500)

are available in the Git repository at:

  https://github.com/kostyanf14/qemu.git tags/qga-pull-2025-01-06

for you to fetch changes up to 85978dfb6b1c1334ed6aa998ca06c3f45e2127e0:

  qemu-ga: Optimize freeze-hook script logic of logging error (2025-01-06 12:57:13 +0200)

----------------------------------------------------------------
qga-pull-2025-01-06

----------------------------------------------------------------
Daniel P. Berrangé (1):
      qga: implement a 'guest-get-load' command

Dehan Meng (1):
      qemu-ga: Optimize freeze-hook script logic of logging error

 meson.build                            |  1 +
 qga/commands-posix.c                   | 20 ++++++++++++++++++
 qga/qapi-schema.json                   | 37 ++++++++++++++++++++++++++++++++++
 scripts/qemu-guest-agent/fsfreeze-hook | 36 +++++++++++++++++++++++++++++----
 4 files changed, 90 insertions(+), 4 deletions(-)


Daniel P. Berrangé (1):
  qga: implement a 'guest-get-load' command

Dehan Meng (1):
  qemu-ga: Optimize freeze-hook script logic of logging error

 meson.build                            |  1 +
 qga/commands-posix.c                   | 20 ++++++++++++++
 qga/qapi-schema.json                   | 37 ++++++++++++++++++++++++++
 scripts/qemu-guest-agent/fsfreeze-hook | 36 ++++++++++++++++++++++---
 4 files changed, 90 insertions(+), 4 deletions(-)

--
2.47.1


