Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC273C3DA41
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 09:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRpvY-0001vP-OK; Thu, 11 Jul 2024 05:17:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sRpvU-0001kG-Qa
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 05:17:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1sRpvS-00007D-5J
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 05:17:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720689435;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=s2zxRF/aYx1RQXUlNlGXxJcBkRQ9+qJvAytRFpPPHCs=;
 b=OQunymKZeenjGmoNNHb2lWZPpTWktoQqCPZzhCLCT5HLCuQelESqFdria5PgLOZthzOkCX
 nlfeVu1BEZhYREmTNe95ogm9YAaiG0FCF0Pph/3qCR4AB/EbdZs7WYLnV4zTcEpQlfL4+t
 ftmfjFKtsD0w/bnqBlxtLzugaM0ZM1U=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-D5cILuRuNlaksujXzrcLEA-1; Thu,
 11 Jul 2024 05:17:13 -0400
X-MC-Unique: D5cILuRuNlaksujXzrcLEA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D3E511955BCF; Thu, 11 Jul 2024 09:17:11 +0000 (UTC)
Received: from localhost (unknown [10.39.192.113])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id D71CB3000184; Thu, 11 Jul 2024 09:17:10 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Hanna Reitz <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, Fam Zheng <fam@euphon.net>
Subject: [PULL 0/2] Block patches
Date: Thu, 11 Jul 2024 11:17:07 +0200
Message-ID: <20240711091709.584450-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
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

The following changes since commit 59084feb256c617063e0dbe7e64821ae8852d7cf:

  Merge tag 'pull-aspeed-20240709' of https://github.com/legoater/qemu into staging (2024-07-09 07:13:55 -0700)

are available in the Git repository at:

  https://gitlab.com/stefanha/qemu.git tags/block-pull-request

for you to fetch changes up to d05ae948cc887054495977855b0859d0d4ab2613:

  Consider discard option when writing zeros (2024-07-11 11:06:36 +0200)

----------------------------------------------------------------
Pull request

A discard fix from Nir Soffer.

----------------------------------------------------------------

Nir Soffer (2):
  qemu-iotest/245: Add missing discard=unmap
  Consider discard option when writing zeros

 block/io.c                                    |   9 +-
 tests/qemu-iotests/245                        |   2 +-
 tests/qemu-iotests/tests/write-zeroes-unmap   | 127 ++++++++++++++++++
 .../qemu-iotests/tests/write-zeroes-unmap.out |  81 +++++++++++
 4 files changed, 214 insertions(+), 5 deletions(-)
 create mode 100755 tests/qemu-iotests/tests/write-zeroes-unmap
 create mode 100644 tests/qemu-iotests/tests/write-zeroes-unmap.out

-- 
2.45.2


